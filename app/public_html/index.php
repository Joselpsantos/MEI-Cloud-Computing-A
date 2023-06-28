<?php include '_dotenv.php'; ?>

<!DOCTYPE html>
<html>
<head>
    <title>CNV - Project A</title>
    <!-- Load Bootstrap 5.2.3 CSS from a local copy -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/site.css">
</head>
<body class="d-flex flex-column">
<?php include 'partials/navbar.php'; ?>

<!-- Begin page content -->
<main class="flex-shrink-0">
  <div class="container">
        <h1 class="mt-5">Hello, World!</h1>
        <?php
            $hostname = gethostname();
        ?>
        <p class="lead">Welcome to my app, hosted on the <span class="badge bg-<?php echo $badge; ?>"><?php echo "$hostname";?></span> node. Deployed with shell scripts on <span id="deployed_on"></span>.

        <?php
            echo '<div class="alert alert-info" role="alert">This is a PHP snippet! Is it working?</div>';
        ?>

        <div class="row">
            <div class="col">
                <div class="image-container">
                	<img src="https://cataas.com/cat" alt="Random Cat Image" class="img-fluid">
                </div>
</div>
        </div>
    </div>
</main>
<?php include 'partials/footer.php'; ?>

    <!-- Load Bootstrap 5.2.3 JS from a local copy -->
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/moment.min.js"></script>
    <script type="text/javascript">
    	moment.relativeTimeThreshold('ss', 0);
    	
    	function updateDeploymentTime() {
	        //var deployed_on = "{{ now() }}";
            var deployed_on = "<?php echo $deploy_date;?>";
	        // Format and display the date in the <p> element with id "deployed_on"
	        document.getElementById("deployed_on").textContent = moment(deployed_on).format('MMMM Do YYYY, h:mm:ss a') + " (that was " +  moment(deployed_on).fromNow() + ")";
    	}


        // Call the updateDeploymentTime function immediately
        updateDeploymentTime();

        // Refresh the time value every second using setInterval
        setInterval(updateDeploymentTime, 1000);
    </script>
</body>
</html>
