%% Boxcar-like low-pass filtering
% emphasis on speed vs. accuracy
fn = '~/Downloads/dsc3440_1.png';

im = imread(fn);
% grayscale intensity
gr = rgb2gray(im);

%% regions
[height, width] = size(gr);
Nw = 16;
Nh = 12;

fw = floor(width / Nw);
fh = floor(height / Nh);

I = zeros(Nh, Nw);

for iw = 1:Nw
  for ih = 1:Nh
    % disp([(ih-1)*fh+1, ih*fh, (iw-1)*fw+1, iw*fw])
    I(ih, iw) = sum(gr((ih-1)*fh+1:ih*fh, (iw-1)*fw+1:iw*fw), "all") / (fw*fh);
  end
end

f1 = figure(1);
clf(f1)
t = tiledlayout(2, 2, parent=f1);
title(t, fn, interpreter="none")

% original image
ax1 = nexttile(t, [2, 1]);
imagesc(ax1, gr)
c = colorbar(ax1);
ylabel(c, "intensity")
colormap(ax1, "bone")
title(ax1, "original image:")
ylabel(ax1, "y")
xlabel(ax1, "x")

% collapsed intensity (average over columns and rows respectively)
Iy = sum(gr, 2) / width;
Ix = sum(gr, 1) / height;

ax2 = nexttile(t);
plot(ax2, Iy, 1:height, Color="red")
set(ax2, YDir="reverse", ylim=[1, height])
ylabel(ax2, "y")
xlabel(ax2, "row intensity average")
title(ax2, "average row intensity")

ax3 = nexttile(t);
plot(ax3, 1:width, Ix, Color="blue")
set(ax3, XLim=[1, width])
xlabel(ax3, "x")
ylabel(ax3, "column intensity average")
title(ax3, "average column intensity")

% region plots
f2 = figure(2);
clf(f2)

t = tiledlayout(2, 1);
title(t, fn, interpreter="none")

% image region averages
ax1 = nexttile(t);
imagesc(ax1, I)
c = colorbar(ax1);
colormap(ax1, "bone")
ylabel(c, "average intensity")
ylabel(ax1, "y-region")
xlabel(ax1, "x-region")
title(ax1, "average region intensity")

% histogram of regions
ax2 = nexttile(t);
histogram(ax2, I)
ylabel(ax2, "Number of regions")
xlabel(ax2, "Intensity bin")
title(ax2, "region histogram")