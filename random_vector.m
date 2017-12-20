function result = random_vector(length, rho)
	result = zeros(length,1);
	for i=1:length
		if rand()<rho
			result(i) = randn();
		else
			result(i) = 0;
		end
	end
end
