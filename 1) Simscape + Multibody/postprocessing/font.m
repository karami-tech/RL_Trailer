function s=font(size,name)
% FONT.M     Changes the size and the type of the font in the graphs. And the 
%            marker size is automatically adjusted to the font size.
%
%            FONT without inputs displays the current font name and size
%            FONT(size) changes the default font size and the font type to
%                       New Century Schoolbook (default)
%            FONT(size,name) changes to other font names according to:
%                       name = 1: New Century Schoolbook
%                              2: Times
%                              3: Helvetica
%                              4: Courier
%                              5: Symbol
%            size=FONT returns the current size of the font
%    
% Author     ir. Peter W.A. Zegelaar
%            Delft University of Technology
%            Vehicle Research Laboratory
%            Mekelweg 2, 2628 CD DELFT, The Netherlands
%            Phone: +31-15-2786637,   Telefax: +31-15-2781397
%
% Last update: 17-01-95                                            (c) PWAZ '95

% ------- The name of the font ------------------------------------------------

if nargin==2,
  if name==1,    fontname = 'NewCenturySchlbk';
  elseif name==2,fontname = 'Times';           
  elseif name==3,fontname = 'Helvetica';       
  elseif name==4,fontname = 'Courier';         
  elseif name==5,fontname = 'Symbol';          
  else,          error('Error in FONT.M, wrong type of font number');end
else
  fontname = 'NewCenturySchlbk';
end

% ------- Printing the current name and size ----------------------------------

if nargin==0,
  size   = get(0,'DefaultAxesFontSize');
  name   = get(0,'DefaultTextFontName');
  marker = get(0,'DefaultLineMarkerSize');
  if nargout==0,
    fprintf('Default Font Size:   %2.1i pt.\n',size);
    fprintf('Default Marker Size: %2.1i pt.\n',marker);
    fprintf('Default Font Name:   %s\n',name);
  end
% ------- Changing the size and font type -------------------------------------

else,
  set(0,'DefaultLineLineWidth',size/60);        % Width of the lines
  set(0,'DefaultAxesLineWidth',size/60);        % Width of the axes border
  set(0,'DefaultTextFontSize',size);            % Font size of figure text
  set(0,'DefaultAxesFontSize',size);            % Font size of axes text
  set(0,'DefaultTextFontName',fontname);        % Font mame of figure text
  set(0,'DefaultAxesFontName',fontname);        % Font name of axes text
  set(0,'DefaultLineMarkerSize',round(size/3)); % Marker size
  set(0,'DefaultAxesTickLength',[0.01 0.01]*size/10);
%  set(0,'DefaultAxesTickLength',[1 1]*size/700);
end

if nargout==1,
  s = size;
end

% ------- End of program ------------------------------------------------------

