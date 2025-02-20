% Solve the differential equation using Laplace transforms. Assume the system starts unde-
% flected at rest: ...
% θ (t) + 40 ̈θ(t) + 20  ̇θ(t) + 2θ(t) = 4
% You’ll have to find a way to determine the roots of the denominator of the Laplace transforms
% output function. You therefore may use numerical approximations of the pole locations. In
% all the assignment is: find and plot θ(t), where you do the Laplace transform by hand.

poles = roots([1 40 20 2]);
disp('Poles of the system:');
disp(poles);

% Perform partial fraction expansion in Matlab on the following transfer function.
% H(s) = (s3 + 2s2 + 3s + 4) / (s3 + 6s2 + 11s + 6)
% Is this system stable? Check your results for the p.f.e.!

num = [1 2 3 4]; %numerator
den = [1, 6, 11, 6]; % denom

[r, p, k] = residue(num, den);
disp('Residues (A_j):');
disp(r);
disp('Poles (p_j):');
disp(p);
disp('Direct term (k):');
disp(k);
disp('System is stable if all poles have negative real parts.');
stable = all(real(p) < 0); 
if stable
    disp('The system is STABLE.');
else
    disp('The system is UNSTABLE!');
end

% With help of Matlab perform partial fraction expansion on the transfer functions of the
% following continuous-time systems (sometimes you have to find the transfer function first).
% Determine whether these systems are stable and find the impulse response and step response
% function. Plot the impulse response and step response function of each system in a single plot
% and try to determine the relationship between them. The definition of the step and impulse
% functions in the Laplace transform tables might proof useful here. Also cherish the Matlab
% roots, poly, residue, pole, zero, impulse and step functions. If you need the practice,
% you can also do this by hand and use Matlab for verification. (Perhaps you can let Matlab
% help you to find the poles, certainly for the 3rd one)

% 1) H(s) = (s + 2)(s + 10) / (s − 3)(s + 5)s

num = [1, 12, 20]; %numerator
den = [1, 2, -15]; % denom

[r,p,k] = residue(num, den);
disp('Residues (A_j):');
disp(r);
disp('Poles (p_j):');
disp(p);
disp('Direct term (k):');
disp(k);

% 2) H(s) = (s3 − 6s2 + 5s + 12) / (s5 + 20s4 + 156s3 + 590s2 + 1075s + 750)
num = [1,6,5,12];
den = [1,20,156, 590, 1075, 750];

[r,p,k] = residue(num, den);
disp('Residues (A_j):');
disp(r);
disp('Poles (p_j):');
disp(p);
disp('Direct term (k):');
disp(k);

% Use the residue function to determine the partial fraction expansion of the discrete-time
% transfer functions:
% H(z) = (z^2 +1/3z - 1/12) / (z^3-4/3z^2+5/6z-1/6)
num = [1,1/3,1/12];
den = [1,4/3,5/6, 1/6];

[r,p,k] = residue(num, den);
disp('Residues (A_j):');
disp(r);
disp('Poles (p_j):');
disp(p);
disp('Direct term (k):');
disp(k);