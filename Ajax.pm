package Catalyst::Plugin::Ajax;

use strict;

our $VERSION = '0.01';
our $http    = do { local $/; <DATA> };

=head1 NAME

Catalyst::Plugin::Ajax - Plugin for Ajax

=head1 SYNOPSIS

    # use it
    use Catalyst qw/Ajax/;

    # ...add this to your tt2 template...
    [% c.include_ajax %]

    # ...and get a ready to use ajax object named http.
    <script type="text/javascript"><!--
    function doEdit() {
        http.post(
            '[% base %]edit/[% page.title %]',
            'body=' + document.edit.body.value,
            function () {
                var res = http.response();
                if ( res && res.status == 200 )
                    document.getElementById('view').innerHTML = res.text;
            }
        );
    }
    //--></script>

    <div id="view"></div>
    <form name="edit">
        <textarea name="body" cols="80" rows="24"
            onKeyup="doEdit()">[% page.body %]</textarea>
    </form>

=head1 DESCRIPTION

Some stuff to make Ajax fun.

This plugin replaces L<Catalyst::Helper::Ajax>.

=head2 METHODS

=head3 include_ajax

=cut

sub include_ajax {
    my $c = shift;
    return $http;
}

=head1 SEE ALSO

L<Catalyst::Manual>, L<Catalyst::Test>, L<Catalyst::Request>,
L<Catalyst::Response>, L<Catalyst::Helper>

=head1 AUTHOR

Sebastian Riedel, C<sri@oook.de>,
Sascha Kiefer, C<esskar@cpan.org>

=head1 LICENSE

This library is free software . You can redistribute it and/or modify it under
the same terms as perl itself.

=cut

1;
__DATA__
<script type="text/javascript"><!--
var HTTP_SUCCESS         = 0;
var HTTP_INVALIDOBJECT   = 1;
var HTTP_INVALIDCALLBACK = 2;
var HTTP_FAILEDOPEN      = 3;

function Http () {
    this.version       = '0.6';
    this.isAsync       = false;
    this.agent         = null;
    this.lastException = '';

    if( typeof XMLHttpRequest != 'undefined' )
        this.agent = new XMLHttpRequest();

    if( this.agent == null ) {

        var axos = new Array(
            'MSXML2.XMLHTTP.4.0',
            'MSXML2.XMLHTTP.3.0',
            'MSXML2.XMLHTTP',
            'Microsoft.XMLHTTP'
        );

        for( var i = 0; this.agent == null && i < axos.length; i++ ) {
            try {
                this.agent = new ActiveXObject(axos[i]);
            } catch(e) {
                this.lastException = e;
                this.agent         = null;
            }
        }
    }

   this.isValid  = callHttpIsValid;
   this.get      = callHttpGet;
   this.post     = callHttpPost;
   this.open     = callHttpOpen;
   this.request  = callHttpRequest;
   this.response = callHttpResponse;
}

function HttpResponse() {
    this.status     = 0;
    this.statusText = '';
    this.headers    = new Array();
    this.body       = '';
    this.text       = '';
    this.xml        = '';
}

function HttpRequest() {
    this.method   = 'GET';
    this.url      = '';
    this.headers  = new Array();
    this.body     = null;
    this.callback = null;
}

function callHttpGet( url, callback, headers ) {
    return this.open( 'GET', url, null, callback, headers );
}

function callHttpIsValid() {
    return this.agent != null;
}

function callHttpOpen( method, url, data, callback, headers ) {
    if (this.isValid()) {
        if (!method)  method       = 'GET';
        if (!data)    data         = null;
        if (callback) this.isAsync = true;

        if (this.isAsync) {
            if ( typeof callback != 'function' )
                return HTTP_INVALIDCALLBACK;
            this.agent.onreadystatechange = callback;
        }

        try {
            this.agent.open( method, url, this.isAsync );
        } catch(e) {
            this.lastException = e;
            return HTTP_FAILEDOPEN;
        }

        if ( headers != null ) {
            for ( var header in headers ) {
                this.agent.setRequestHeader( header, headers[header] );
            }
        }

        this.agent.send(data);
        return HTTP_SUCCESS;
    }
    return HTTP_INVALIDOBJECT;
}

function callHttpPost( url, data, callback, headers ) {
    return this.open( 'POST', url, data, callback, headers );
}

function callHttpResponse() {
    if ( this.agent.readyState != 4 )
        return null;

    var res = new HttpResponse();

    res.status      = this.agent.status;
    res.statusText  = typeof this.agent.statusText == 'undefined'
        ? ''
        : this.agent.statusText;
    res.body        = typeof this.agent.responseBody == 'undefined'
        ? ''
        : this.agent.responseBody;
    res.text        = typeof this.agent.responseText == 'undefined'
        ? ''
        : this.agent.responseText;
    res.xml          = this.agent.responseXML == null
        ? ''
        : this.agent.responseXML.xml;

    var string = this.agent.getAllResponseHeaders();
    if (!string) string = '';

    var lines = string.split("\\n");
    for ( var i = 0; i < lines.length; i++ ) {
        var header = lines[i].split(": ");
        if(header.length >= 2) {
            var headername  = header.shift();
            var headervalue = header.join(": ");

            res.headers[headername] = headervalue;
        }
    }

    return res;
}

function callHttpRequest(req) {
   return this.Open(
       req.method,
       req.url,
       req.body,
       req.callback,
       req.headers
   );
}

var http = new Http();
//--></script>
