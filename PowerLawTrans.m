img = im2double(imread("C:\Users\Titi\Desktop\img proj\New images\Margan.png"));
linear_img = zeros(size(img));
he_img = zeros(size(img));
clahe_img = zeros(size(img));

for c = 1:3
    % Channel extraction
    ch = img(:,:,c);

    % --- Linear Stretching using 2nd–98th percentiles
    min_val = prctile(ch(:), 2);
    max_val = prctile(ch(:), 98);
    stretched = (ch - min_val) / (max_val - min_val);
    linear_img(:,:,c) = max(min(stretched, 1), 0);

    % --- Histogram Equalization
    he = histeq(ch);  % Apply global HE
    he_img(:,:,c) = he;

    % --- CLAHE (Contrast Limited Adaptive HE)
    clahe = adapthisteq(ch, 'ClipLimit', 0.01, 'NumTiles', [8 8]);
    clahe_img(:,:,c) = clahe;
end

% Display comparison
figure;
subplot(2,2,1); imshow(img); title("Original");
subplot(2,2,2); imshow(linear_img); title("Linear Stretching");
subplot(2,2,3); imshow(he_img); title("Histogram Equalization");
subplot(2,2,4); imshow(clahe_img); title("CLAHE");
