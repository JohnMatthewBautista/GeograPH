extends Node

var regions : Array[Region] = [
	Region.new("Ilocos Region", "Luzon", "San Fernando, La Union", 0, ["Ilocos Norte", "Ilocos Sur", "La Union", "Pangasinan"]),
	Region.new("Cagayan Valley", "Luzon", "Tuguegarao", 1, ["Batanes", "Cagayan", "Isabela", "Nueva Vizcaya", "Quirino"]),
	Region.new("Central Luzon", "Luzon", "San Fernando, Pampanga", 2, ["Aurora", "Bataan", "Bulacan", "Nueva Ecija", "Pampanga", "Tarlac", "Zambales"]),
	Region.new("Calabarzon", "Luzon", "Calamba", 3, ["Batangas", "Cavite", "Laguna", "Quezon", "Rizal"]),
	Region.new("Mimaropa", "Luzon", "Calapan", 4, ["Marinduque", "Occidental Mindoro", "Oriental Mindoro", "Palawan", "Romblon"]),
	Region.new("Bicol Region", "Luzon", "Legazpi", 5, ["Albay", "Camarines Norte", "Camarines Sur", "Catanduanes", "Masbate", "Sorsogon"]),
	Region.new("Western Visayas", "Visayas", "Iloilo City", 6, ["Aklan", "Antique", "Capiz", "Guimaras", "Iloilo"]),
	Region.new("Negros Island Region (NIR)", "Visayas", "Bacolod and Dumaguete", 7, ["Negros Occidental", "Negros Oriental", "Siquijor"]),
	Region.new("Central Visayas", "Visayas", "Cebu City", 8, ["Bohol", "Cebu"]),
	Region.new("Eastern Visayas", "Visayas", "Tacloban", 9, ["Biliran", "Eastern Samar", "Leyte", "Northern Samar", "Samar", "Southern Leyte"]),
	Region.new("Zamboanga Peninsula", "Mindanao", "Pagadian", 10, ["Zamboanga del Norte", "Zamboanga del Sur", "Zamboanga Sibugay"]),
	Region.new("Northern Mindanao", "Mindanao", "Cagayan de Oro", 11, ["Bukidnon", "Camiguin", "Lanao del Norte", "Misamis Occidental", "Misamis Oriental"]),
	Region.new("Davao Region", "Mindanao", "Davao City", 12, ["Davao de Oro", "Davao del Norte", "Davao del Sur", "Davao Occidental", "Davao Oriental"]),
	Region.new("Soccsksargen", "Mindanao", "Koronadal", 13, ["Sarangani", "South Cotabato", "Sultan Kudarat"]),
	Region.new("Caraga", "Mindanao", "Butuan", 14, ["Agusan del Norte", "Agusan del Sur", "Dinagat Islands", "Surigao del Norte", "Surigao del Sur"]),
	Region.new("NCR", "Luzon", "Manila", 15, ["Caloocan", "Las Piñas", "Makati", "Malabon", "Mandaluyong", "Marikina", "Muntinlupa", "Navotas", "Parañaque", "Pasay", "Pasig", "Pateros", "Quezon City", "San Juan", "Taguig", "Valenzuela"]),
	Region.new("CAR", "Luzon", "Baguio", 16, ["Abra", "Apayao", "Benguet", "Ifugao", "Kalinga", "Mountain Province"]),
	Region.new("BARMM", "Mindanao", "Cotabato City", 17, ["Basilan", "Lanao del Sur", "Maguindanao", "Sulu", "Tawi-Tawi"])
]

func _ready():
	pass
