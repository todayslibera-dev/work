const fetch = require('node-fetch');

exports.handler = async (event, context) => {
  // Only allow POST requests for gRPC-Web
  if (event.httpMethod !== 'POST') {
    return {
      statusCode: 405,
      body: 'Method Not Allowed',
    };
  }

  const clovaApiUrl = 'https://clovaspeech-gw.ncloud.com:50051';
  const targetPath = event.path.replace('/.netlify/functions/proxy', ''); // Remove the function path

  try {
    const headers = {
      ...event.headers,
      // Remove host header as it will be set by node-fetch
      host: undefined,
      // Ensure content-type is set for gRPC-Web
      'content-type': event.headers['content-type'] || 'application/grpc-web+proto',
    };

    // Forward the request to Clova API
    const response = await fetch(`${clovaApiUrl}${targetPath}`, {
      method: 'POST',
      headers: headers,
      body: event.body, // event.body is base64 encoded for binary data
      // Netlify functions automatically decode base64 for event.body if it's binary
    });

    // Stream the response back
    const responseHeaders = {};
    response.headers.forEach((value, name) => {
      responseHeaders[name] = value;
    });

    return {
      statusCode: response.status,
      headers: responseHeaders,
      body: await response.buffer().then(buf => buf.toString('base64')),
      isBase64Encoded: true,
    };
  } catch (error) {
    console.error('Proxy error:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'Proxy failed', details: error.message }),
    };
  }
};
