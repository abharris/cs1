<%@page language="java" %>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="com.mysql.jdbc.*" %>

<%

// select user_name is null -- error

      try {

         java.sql.Connection con = null;
         String url = "";

	 String key = (String)session.getAttribute("key");

	 String tweetsQuery = "select count(*) from tweet_t where user_id=" + "'" +key+ "'";
	 //how many followers they have
	 String followersQuery = "select count(*) from users_t a, follow_rel b where b.followee=" + "'" +key+ "'" + "and a.user_id = b.follower";
	 //how many they are following
	 String followeeQuery = "select count(*) from users_t a, follow_rel b where b.follower=" + "'" +key+ "'" + "and a.user_id=b.followee";
	 //add to see own tweets
	 String tweetQuery = "select b.tweet, b.timeStamp, b.user_id from follow_rel a, tweet_t b where a.follower=" + "'" +key+ "'" +"and a.followee=b.user_id order by timeStamp desc";
	 String first_nameQuery = "select first_name from users_t where user_id=" + "'" + key + "'";
	 	// out.println(query);
	 String user_nameQuery = "select user_name from users_t where user_id=" + "'" + key + "'";

	 //open sql:
         Class.forName("com.mysql.jdbc.Driver").newInstance();
         url = "jdbc:mysql://localhost:3306/aharris";
         con = DriverManager.getConnection(url, "aharris", "dalton123");

         java.sql.Statement stmt1 = con.createStatement();
       	 java.sql.Statement stmt2 = con.createStatement();
         java.sql.Statement stmt3 = con.createStatement();
         java.sql.Statement stmt4 = con.createStatement();
         java.sql.Statement stmt5 = con.createStatement();
         java.sql.Statement stmt6 = con.createStatement();


	 //executes the query:
	 java.sql.ResultSet rs1 = stmt1.executeQuery(tweetsQuery);
	 java.sql.ResultSet rs2 = stmt2.executeQuery(followersQuery);
	 java.sql.ResultSet rs3 = stmt3.executeQuery(followeeQuery);
	 java.sql.ResultSet rs4 = stmt4.executeQuery(tweetQuery);
	 java.sql.ResultSet rs5 = stmt5.executeQuery(first_nameQuery);
	 java.sql.ResultSet rs6 = stmt6.executeQuery(user_nameQuery);

String tweetnum = "";
 boolean exists1 = false;
    	while(rs1.next())
	  {
		tweetnum = rs1.getString("count(*)");
		exists1 = true;
	  } //end while

	String followernum = "";
	int nfollower = 0;
	 boolean exists2 = false;
   	while(rs2.next())
	  {
		followernum = rs2.getString("count(*)");
		nfollower = Integer.parseInt(followernum);
		exists2 = true;
		} //end while

	nfollower--;

	String followeenum = "";
	int nfollowee = 0;
	 boolean exists3 = false;
    	while(rs3.next())
	  {
		followeenum = rs3.getString("count(*)");
		nfollowee = Integer.parseInt(followeenum);
		exists3 = true;
	  } //end while

	  nfollowee--;

	  String first_name = "";
    	while(rs5.next())
	  {
		first_name = rs5.getString("first_name");
	  } //end while

	  String user_name = "";
    	while(rs6.next())
	  {
		user_name = rs6.getString("user_name");
	  } //end while

//send to a twiter page
%>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <meta name="description" content="">
    <meta name="author" content="">
    <style type="text/css">
    	body {
    		padding-top: 60px;
    		padding-bottom: 40px;
    	}
    	.sidebar-nav {
    		padding: 9px 0;
    	}
    </style>
    <link rel="stylesheet" href="css/gordy_bootstrap.min.css">
</head>
<body class="user-style-theme1">
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
                <i class="nav-home"></i> <a href="#" class="brand">!Twitter</a>
				<div class="nav-collapse collapse">
					<p class="navbar-text pull-right">Logged in as <a href="#" class="navbar-link"><%=first_name%></a>
					</p>
					<ul class="nav">
						<li class="active"><a href="index.html">Home</a></li>
						<li><a href="queries.html">Test Queries</a></li>
						<li><a href="twitter-signin.html">Main sign-in</a></li>
					</ul>
				</div><!--/ .nav-collapse -->
			</div>
		</div>
	</div>

    <div class="container wrap">
        <div class="row">

            <!-- left column -->
            <div class="span4" id="secondary">
                <div class="module mini-profile">
                    <div class="content">
                        <div class="account-group">
                            <a href="#">
                                <img class="avatar size32" src="images/pirate_normal.jpg" alt="Gordy">
                                <b class="fullname"><%=first_name%></b>
                                <small class="metadata">View my profile page</small>
                            </a>
                        </div>
                    </div>
                    <div class="js-mini-profile-stats-container">
                        <ul class="stats">
                            <li><a href="#"><strong><%=tweetnum%></strong>Tweets</a></li>
                            <li><a href="twitter-following.html"><strong><%=nfollowee%></strong>Following</a></li>
                            <li><a href="#"><strong><%=nfollower%></strong>Followers</a></li>
                        </ul>
                    </div>
                    <form action="insertTweet.jsp">
                    <input type="hidden" name="key" value="<%=key%>" >

                    <div class="tweet">
                   		<input type="text" id="composeTweet" autocomplete="off" name="tweet" placeholder="Compose a New Tweet..."> </input>
                    </div>
                    	<button type="submit" class="insertTweet.jsp">
						Tweet!
					</button>
                    </form>
                </div>
                <div class="module other-side-content">
                    <div class="content"
                        <p>Some other content here</p>
                    </div>
                </div>
            </div>

            <!-- right column -->
            <div class="span8 content-main">
                <div class="module">
                    <div class="content-header">
                        <div class="header-inner">
                            <h2 class="js-timeline-title">Tweets</h2>
                        </div>
                    </div>

                    <!-- new tweets alert -->
                    <div class="stream-item hidden">
                        <div class="new-tweets-bar js-new-tweets-bar well">
                            2 new Tweets
                        </div>
                    </div>

                    <!-- all tweets -->
                    <div class="stream home-stream">
			<%

    			while(rs4.next())
    			{

	  				String tweet = "";
	  				String output = "";

	  				String hash_id = "";
					int hashid = 0;

					tweet = rs4.getString("b.tweet");
					String timeTweeted = rs4.getString("b.timeStamp");
					String tweetedUserID = rs4.getString("b.user_id");

					String tweetUQ = "select user_name, first_name from users_t where user_id=" + "'" + tweetedUserID + "'";

					java.sql.Statement stmt8 = con.createStatement();
					java.sql.ResultSet rs8 = stmt8.executeQuery(tweetUQ);

					String tweetedUser = "";
					String tweetedName = "";
					while(rs8.next())
	  				{
						tweetedUser = rs8.getString("user_name");
						tweetedName = rs8.getString("first_name");
					} //end while


					String[] splitTweet = tweet.split(" ");

					for(int i = 0; i < splitTweet.length; i++)
					{
	  					if(splitTweet[i].charAt(0) == '#')
	  						{
	  						String trimmedHash = "";
	  						trimmedHash = splitTweet[i].replace('#', ' ');
	  						trimmedHash = trimmedHash.trim();

	  						String hashQuery = "select idhashtag from hashtags where UPPER(hashtag) =" + "'" + trimmedHash + "'";

         					java.sql.Statement stmtHash = con.createStatement();

	 					//executes the query:
	 						java.sql.ResultSet rsHash = stmtHash.executeQuery(hashQuery);

	 					//loop through result set until there is no more data
         					while(rsHash.next())
	  						{
								hash_id = rsHash.getString("idhashtag");
								hashid = Integer.parseInt(hash_id);
	  						} //end while

							String anchor = "<a href='hashPage.jsp?&hashid=" + hashid + "'> #" + trimmedHash + "</a>";

	  					//hyperlink w/ anchor tag


	  					output = output + " " + anchor + " ";



	  					}
	  					else
	  					{
	  						output = output + " " + splitTweet[i] + " ";
	  					}
					}
					//split here, do same checks
					//anchor w/ hyperlinked to hashtag's page
					//make a hashtag page
					//output = anchor + hash_id

			%>
                        <!-- start tweet -->
                        <div class="js-stream-item stream-item expanding-string-item">
                            <div class="tweet original-tweet">
                                <div class="content">
                                    <div class="stream-item-header">
                                        <small class="time">
                                            <a href="#" class="tweet-timestamp" title="10:15am - 16 Nov 12">
                                                <span class="_timestamp"><%=timeTweeted%></span>
                                            </a>
                                        </small>
                                        <a class="account-group">
                                            <img class="avatar" src="images/obama.png" alt="Barak Obama">
                                            <strong class="fullname"><%=tweetedName%></strong> <!--add name later-->
                                            <span>&rlm;</span>
                                            <span class="username">
                                                <b>@<%=tweetedUser%></b>
                                            </span>
                                        </a>
                                    </div>
                                    <p class="js-tweet-text">
                                       <%=output%>
                                            <span class="invisible">http://</span>
                                            <span class="invisible"></span>
                                            <span class="tco-ellipsis">
                                                <span class="invisible">&nbsp;</span>
                                            </span>
                                    </p>
                                </div>
                            </a>
                                <div class="expanded-content js-tweet-details-dropdown"></div>
                            </div>
                        </div><!-- end tweet -->

        		<%
        			}
        		%>

                    </div>
                    <div class="stream-footer"></div>
                    <div class="hidden-replies-container"></div>
                    <div class="stream-autoplay-marker"></div>
                </div>
                </div>

            </div>
        </div>
    </div>
     <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <script type="text/javascript" src="js/main-ck.js"></script>
  </body>
</html>

<%

      } catch (Exception e) {
         out.println(e);
      }
%>
