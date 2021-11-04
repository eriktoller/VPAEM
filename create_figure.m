function [] = create_figure(x_dim, y_dim)
%CREATE_FIGURE Creates a figure with given properties for publications.
%   VARIBALES
%   x_dim - Resultion in the x-direction
%   y_dim - Resultion in the y-direction
switch nargin
    case 2 % if both x and y-dimensions are given
        figure('Position', [100 100 x_dim y_dim])
        axes('Units', 'normalized', 'Position', [0 0 1 1]);
        axis equal
        axis off
        hold on
        set(gcf,'color','w');
    case 1 % if only one dimension is given
        figure('Position', [100 100 x_dim x_dim])
        axes('Units', 'normalized', 'Position', [0 0 1 1]);
        axis equal
        axis off
        hold on
        set(gcf,'color','w');
    otherwise % if no dimensions are given
        figure('Position', [100 100 600 600])
        axes('Units', 'normalized', 'Position', [0 0 1 1]);
        axis equal
        axis off
        hold on
        set(gcf,'color','w');
end

end

