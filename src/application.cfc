
component {

    this.name = "myBlogApp";
    this.sessionManagement = true;
    this.datasource = "cfBlogspot";
    this.sessionTimeout = createTimespan(0,0,30,0);
        
    function onSessionStart() {
        session.user = '';
        
    }
}