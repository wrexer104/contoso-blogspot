
component {

    this.name = "myBlogApp";
    this.sessionManagement = true;
    this.datasource = "cfBlogspot";
    
    function onSessionStart() {
        session.user = '';
        
    }
}