# Codeigniter Survey

Create and manage surveys created with Codeigniter. 

## Installation
Require the package using composer.
```bash
composer require dompdf/dompdf
```

Add this to your Routes
```
$routes->cli("/surveys", "Surveys::setup");
```

Run this bash command to create all the required tables.
```bash
php index.php surveys setup
```
Enjoy using the application