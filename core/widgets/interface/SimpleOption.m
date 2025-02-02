classdef SimpleOption < ThresholdingOption
    
    methods ( Access = public )
        
        function obj = SimpleOption( ...
                button_group_handle, ...
                id, ...
                value_picker_fn, ...
                x_padding, ...
                y_pos, ...
                font_size, ...
                label ...
                )
            
            obj = obj@ThresholdingOption( ...
                button_group_handle, ...
                id, ...
                value_picker_fn, ...
                x_padding, ...
                y_pos, ...
                font_size, ...
                label ...
                );
            
        end
        
    end
    
    
    methods ( Access = public, Static )
        
        function type = get_type()
            
            type = 'simple';
            
        end
        
    end
    
end

