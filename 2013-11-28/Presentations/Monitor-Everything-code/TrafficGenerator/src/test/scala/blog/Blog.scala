package blog
import io.gatling.core.Predef._
import io.gatling.core.session.Expression
import io.gatling.http.Predef._
import io.gatling.jdbc.Predef._
import io.gatling.http.Headers.Names._
import io.gatling.http.Headers.Values._
import scala.concurrent.duration._
import bootstrap._
import assertions._

class Blog extends Simulation {

	val httpProtocol = http
		.baseURL("http://localhost:8098/article/4")
		.acceptHeader("image/png,image/*;q=0.8,*/*;q=0.5")
		.acceptEncodingHeader("gzip, deflate")
		.acceptLanguageHeader("de,en-us;q=0.7,en;q=0.3")
		.authorizationHeader("Basic ZGF0YS1yb29tOlRuK3d2VD9o")
		.connection("keep-alive")
		.userAgentHeader("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0")

	val headers_1 = Map("""Accept""" -> """text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8""")

	val chain_0 = exec(
			http("request_1")
			.get("""/""")
			.headers(headers_1)
			.check(status.is(200)))
					
	val scn = scenario("Scenario Name").exec(chain_0).pause(0, 100).exec(chain_0).pause(0, 100).exec(chain_0)

	setUp(scn.inject(ramp(2000 users) over(300 seconds))).protocols(httpProtocol)
}
