
component {

    this.name = "myBlogApp";
    this.sessionManagement = true;
    this.datasource = "cfBlogspot";
    this.applicationTimeout = createTimespan(0,0,15,0);
    this.sessionTimeout = createTimespan(0,0,15,0);
        
    function onSessionStart() {
        session.user = '';
    }
}