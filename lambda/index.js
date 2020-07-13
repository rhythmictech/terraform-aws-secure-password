const AWS = require('aws-sdk')
const password = require('secure-random-password')

const secretsmanager = new AWS.SecretsManager()

const generateChar = (include, min, charset) => {
  const result = []

  if (!include) {
    return result
  }

  for (let i = 0; i < min; i++) {
    result.push(charset)
  }
  return result
}

const transformParams = params => ({
  length: params.length,
  characters: [
    ...generateChar(params.lower, params.min_lower, password.lower),
    ...generateChar(params.upper, params.min_upper, password.upper),
    ...generateChar(params.numbers, params.min_numeric, password.digits),
    ...generateChar(params.special, params.min_special, params.override_special)
  ]
})

const putValueParams = event => ({
  SecretId: event.secret_name,
  SecretString: password.randomString(transformParams(event))
})

exports.handler = async (event, context) => {
  try {
    await secretsmanager.putSecretValue(putValueParams(event)).promise()
  } catch (error) {
    console.error(error)
    throw (error)
  }
}
