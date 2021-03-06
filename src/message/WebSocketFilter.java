package message;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

@WebFilter("/websocket/chat")
public class WebSocketFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        final Map<String, String[]> props = new HashMap<>();
        // Add properties of interest from session; session ID
        // is just for example
        props.put("sessionId", new String[] { (String) httpRequest.getSession().getAttribute("room_id"),  (String) httpRequest.getSession().getAttribute("sessionId")});
        HttpServletRequestWrapper wrappedRequest = new HttpServletRequestWrapper(httpRequest) {
            @Override
            public Map<String, String[]> getParameterMap() {
                return props;
            }
        };
        chain.doFilter(wrappedRequest, response);
    }

    @Override
    public void destroy() {
    }

    @Override
    public void init(FilterConfig arg0) throws ServletException {
    }
}