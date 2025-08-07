function SBC = stocasticBoundaryCondition(SBCtype, temp, iters, dt)
    if SBCtype == "Gaussian"
        std = temp * 0.25; % standard deviation
        for i = 1:iters
            SBC = std .* randn(iters, 1) + temp; % random value drawn from Gaussian distribution
        end
    elseif SBCtype == "Bimodal"
        BC = zeros(iters, 1);
        for i = 1:iters
            if rem(i, 2) == 0
                std1 = temp * 0.25;
                BC(i) = std1 .* randn(1) + temp; % random value drawn from Gaussian distribution
            else
                std2 = temp * 0.5;
                BC(i) = std2 .* randn(1) + (temp*2); % random value drawn from Gaussian distribution
            end
        end
        SBC = BC;
    elseif SBCtype == "Brownian"
        BC = zeros(iters, 1);
        BC(1) = temp;
        std = temp * 0.25;
        for i = 2:iters
            BC(i) = (std * sqrt(dt)) .* randn(1) + BC(i - 1);
        end
        SBC = BC;
    else
        error("Invalid SBCtype");
    end
end
