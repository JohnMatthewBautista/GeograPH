extends Node

var regions = {
	"region1" : Region.new("Ilocos Region", "Luzon", "San Fernando, La Union", 1, ["Ilocos Norte", "Ilocos Sur", "La Union", "Pangasinan"]),
	"region2" : Region.new("Cagayan Valley", "Luzon", "Tuguegarao", 2, ["Batanes", "Cagayan", "Isabela", "Nueva Vizcaya", "Quirino"]),
	"region3" : Region.new("Central Luzon", "Luzon", "San Fernando, Pampanga", 3, ["Aurora", "Bataan", "Bulacan", "Nueva Ecija", "Pampanga", "Tarlac", "Zambales"]),
	"region4a" : Region.new("Calabarzon", "Luzon", "Calamba", 0, ["Batangas", "Cavite", "Laguna", "Quezon", "Rizal"]),
	"region4b" : Region.new("Mimaropa", "Luzon", "Calapan", 0, ["Marinduque", "Occidental Mindoro", "Oriental Mindoro", "Palawan", "Romblon"]),
	"region5" : Region.new("Bicol Region", "Luzon", "Legazpi", 5, ["Albay", "Camarines Norte", "Camarines Sur", "Catanduanes", "Masbate", "Sorsogon"]),
	"region6" : Region.new("Western Visayas", "Visayas", "Iloilo City", 6, ["Aklan", "Antique", "Capiz", "Guimaras", "Iloilo"]),
	"nir" : Region.new("Negros Island Region (NIR)", "Visayas", "Bacolod and Dumaguete", 0, ["Negros Occidental", "Negros Oriental", "Siquijor"]),
	"region7" : Region.new("Central Visayas", "Visayas", "Cebu City", 7, ["Bohol", "Cebu"]),
	"region8" : Region.new("Eastern Visayas", "Visayas", "Tacloban", 8, ["Biliran", "Eastern Samar", "Leyte", "Northern Samar", "Samar", "Southern Leyte"]),
	"region9" : Region.new("Zamboanga Peninsula", "Mindanao", "Pagadian", 9, ["Zamboanga del Norte", "Zamboanga del Sur", "Zamboanga Sibugay"]),
	"region10" : Region.new("Northern Mindanao", "Mindanao", "Cagayan de Oro", 10, ["Bukidnon", "Camiguin", "Lanao del Norte", "Misamis Occidental", "Misamis Oriental"]),
	"region11" : Region.new("Davao Region", "Mindanao", "Davao City", 11, ["Davao de Oro", "Davao del Norte", "Davao del Sur", "Davao Occidental", "Davao Oriental"]),
	"region12" : Region.new("Soccsksargen", "Mindanao", "Koronadal", 12, ["Sarangani", "South Cotabato", "Sultan Kudarat"]),
	"region13" : Region.new("Caraga", "Mindanao", "Butuan", 13, ["Agusan del Norte", "Agusan del Sur", "Dinagat Islands", "Surigao del Norte", "Surigao del Sur"]),
	"ncr" : Region.new("NCR", "Luzon", "Manila", 0, ["Caloocan", "Las Piñas", "Makati", "Malabon", "Mandaluyong", "Marikina", "Muntinlupa", "Navotas", "Parañaque", "Pasay", "Pasig", "Pateros", "Quezon City", "San Juan", "Taguig", "Valenzuela"]),
	"car" : Region.new("CAR", "Luzon", "Baguio", 0, ["Abra", "Apayao", "Benguet", "Ifugao", "Kalinga", "Mountain Province"]),
	"barmm" : Region.new("BARMM", "Mindanao", "Cotabato City", 0, ["Basilan", "Lanao del Sur", "Maguindanao", "Sulu", "Tawi-Tawi"])
}
