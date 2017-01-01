db=linspace(-20,60);

lin=db2lin(db);

figure(1);clf
subplot(1,2,1)
plot(lin,db)
ylabel('Value in decible')
xlabel('Absolute value')
title('The decible scale')
grid


subplot(1,2,2)
semilogx(lin,db)
ylabel('Value in decible')
xlabel('Absolute value')
title('The decible scale')
grid

% figure(2);clf
% plotyy(db,lin,db,lin,@semilogy,@plot)