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
ax1 = nexttile(t);
imagesc(ax1, gr)
c = colorbar(ax1);
ylabel(c, "intensity")
colormap(ax1, "bone")
title(ax1, "original image:")
ylabel(ax1, "y")
xlabel(ax1, "x")

% image region averages
ax2 = nexttile(t);
imagesc(ax2, I)
c = colorbar(ax2);
colormap(ax2, "bone")
ylabel(c, "average intensity")
ylabel(ax2, "y-region")
xlabel(ax2, "x-region")
title(ax2, "average region intensity")

% collapsed intensity (average over columns and rows respectively)
Iy = sum(gr, 2) / width;
Ix = sum(gr, 1) / height;

ax3 = nexttile(t);
plot(ax3, Iy, 1:height, Color="red")
set(ax3, YDir="reverse", ylim=[1, height])
ylabel(ax3, "y")
xlabel(ax3, "row intensity average")
title(ax3, "average row intensity")

ax4 = nexttile(t);
plot(ax4, 1:width, Ix, Color="blue")
set(ax4, XLim=[1, width])
xlabel(ax4, "x")
ylabel(ax4, "column intensity average")
title(ax4, "average column intensity")