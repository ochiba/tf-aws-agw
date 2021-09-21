openapi: "3.0.1"
info:
  title: "${name}"
  version: "2020-09-09T06:11:13Z"
paths:
  /:
    get:
      responses:
        200:
          description: "200 response"
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/Empty"
      x-amazon-apigateway-integration:
        uri: "${nlb_uri}"
        responses:
          default:
            statusCode: "200"
        passthroughBehavior: "when_no_match"
        connectionType: "VPC_LINK"
        connectionId: "${vpc_link_id}"
        httpMethod: "GET"
        type: "http_proxy"