<?php include '_dotenv.php'; ?>

<!DOCTYPE html>
<html>

<head>
  <title>CNV - Project A</title>
  <!-- Load Bootstrap 5.2.3 CSS from a local copy -->
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/site.css">
</head>

<body class="d-flex flex-column h-100">
  <?php include 'partials/navbar.php'; ?>

  <!-- Begin page content -->
  <main class="flex-shrink-0">
    <div class="container">
      <h1 class="mt-5">Image Upload</h1>

      <?php
      // Handle file upload
      if (isset($_POST['submit'])) {
        $uploadDir = 'gallery/';

        // Check if the upload directory exists, otherwise create it
        if (!is_dir($uploadDir)) {
          mkdir($uploadDir);
        }

        $fileName = basename($_FILES['image']['name']);
        $targetPath = $uploadDir . $fileName;
        $fileType = pathinfo($targetPath, PATHINFO_EXTENSION);

        // Check if the uploaded file is a JPG image
        if ($fileType === 'jpg' || $fileType === 'jpeg') {
          if (move_uploaded_file($_FILES['image']['tmp_name'], $targetPath)) {
            // Store image file in the database
            $dbh = new PDO("pgsql:host=$db_host;port=$db_port;dbname=$db_name", $db_user, $db_pass);
            $q = $dbh->prepare("INSERT INTO image (filename) VALUES (?)");
            $q->bindParam(1, $fileName);
            $q->execute();

            echo '<div class="alert alert-success">Image uploaded successfully!</div>';
          } else {
            echo '<div class="alert alert-danger">Sorry, there was an error uploading your file.</div>';
          }
        } else {
          echo '<div class="alert alert-danger">Please upload a JPG image.</div>';
        }
      }

      // Handle clear gallery button click
      if (isset($_POST['clear'])) {
        // Delete images from the database
        $dbh = new PDO("pgsql:host=$db_host;port=$db_port;dbname=$db_name", $db_user, $db_pass);
        $q = $dbh->prepare("DELETE FROM image");
        $q->execute();

        // Delete images from the server
        $imageDir = 'gallery/';
        $images = glob($imageDir . '*.jpg');

        foreach ($images as $image) {
          unlink($image); // Delete each image file
        }

        echo '<div class="alert alert-success">Gallery cleared successfully!</div>';
      }
      ?>

      <div class="row">
        <div class="col-md-6">
          <!-- Display file upload form -->
          <form method="POST" enctype="multipart/form-data">
            <div class="form-group">
              <label for="image">Select an image:</label>
              <input type="file" class="form-control-file" id="image" name="image" accept=".jpg, .jpeg">
            </div>
            <button type="submit" class="btn btn-primary" name="submit">Upload</button>
          </form>
        </div>
        <div class="col-md-6">
          <!-- Display clear gallery button -->
          <form method="POST">
            <div class="form-group mt-md-4">
              <button type="submit" class="btn">
            </div>
          </form>
        </div>
        <div class="col-md-6">
        <!-- Display clear gallery button -->
        <form method="POST">
          <div class="form-group mt-md-4">
            <button type="submit" class="btn btn-danger" name="clear">Clear Gallery</button>
          </div>
        </form>
      </div>
      </div>
      <div class="row">
        <?php
        $dbh = new PDO("pgsql:host=$db_host;port=$db_port;dbname=$db_name", $db_user, $db_pass);
        $q = $dbh->prepare("SELECT filename FROM image");
        $q->execute();
        $images = $q->fetchAll(PDO::FETCH_COLUMN);

        foreach ($images as $image) {
          echo '<div class="col-md-4 mb-3">';
          echo '<img src="gallery/' . $image . '" class="img-fluid">';
          echo '</div>';
        }
        ?>
      </div>