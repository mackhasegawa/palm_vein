
file_name = uigetfile('*');
IMG = imread(file_name);

ORG0 = IMG(:,1:256,:);
ORG = IMG(:,257:512,:);

for i=1:9
    deg = rand*60-30; % -30“x‚©‚ç30“x‚Ü‚Å‰ñ“]s
    IMG0 = imrotate(ORG0,deg);
    IMG = imrotate(ORG,deg);

    imagesc(IMG); colorbar; axis image;
    [x,y] = getpts;
    P = [x y];
    
    len = min(P(2,1)-P(1,1),P(2,2)-P(1,2));
    IMG = imcrop(IMG, [P(1,1) P(1,2) len len]);
    IMG = imresize(IMG,[256 256]);
    IMG0 = imcrop(IMG0, [P(1,1) P(1,2) len len]);
    IMG0 = imresize(IMG0,[256 256]);

    IMG = [IMG0 IMG];

    imwrite(IMG,strcat('dataset/',file_name(1:7),num2str(i),'.jpg'));
end
