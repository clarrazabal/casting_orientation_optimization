classdef ThresholdValueWidget < handle
    
    methods ( Access = public )
        
        function obj = ThresholdValueWidget( ...
                parent_handle, ...
                x_padding, ...
                y_pos, ...
                font_size, ...
                tag, ...
                label, ...
                initial_value, ...
                initial_check_box_state, ...
                value_update_callback, ...
                check_box_update_callback ...
                )
            
            corner_pos = [ x_padding y_pos ];
            
            obj.tag = tag;
            obj.value = initial_value;
            
            check_box_update_cb = @(h,e)check_box_update_callback(h,e,obj);
            check_box_position = [ ...
                corner_pos ...
                obj.CHECK_BOX_WIDTH + x_padding ...
                obj.get_height( font_size ) ...
                ];
            obj.check_box_handle = obj.create_check_box( ...
                parent_handle, ...
                label, ...
                font_size, ...
                check_box_position, ...
                initial_check_box_state, ...
                check_box_update_cb ...
                );
            
            value_update_cb = @(h,e)value_update_callback(h,e,obj);
            value_editor_position = [ ...
                check_box_position( 1 ) + check_box_position( 3 ) ...
                corner_pos( 2 ) ...
                obj.VALUE_EDITOR_WIDTH ...
                obj.get_height( font_size ) ...
                ];
            obj.edit_text_handle = obj.create_value_editor( ...
                parent_handle, ...
                value_editor_position, ...
                font_size, ...
                initial_value.get_value(), ...
                value_update_cb ...
                );
            
            slider_position = [ ...
                value_editor_position( 1 ) + value_editor_position( 3 ) ...
                corner_pos( 2 ) ...
                obj.SLIDER_WIDTH ...
                obj.get_height( font_size ) ...
                ];
            obj.slider_handle = obj.create_slider( ...
                parent_handle, ...
                slider_position, ...
                initial_value.get_value(), ...
                initial_value.get_range(), ...
                value_update_cb ...
                );
            
        end
        
        
        function changed = update_value( obj, style )
            
            new_value = obj.get_new_value( style );
            changed = obj.update_internal_value( new_value );
            obj.update_handle_values();
            
        end
        
        
        function change_constrained_value( obj, new_value )
            
            obj.value = new_value;
            obj.update_handle_values();
            obj.update_handle_ranges();
            
        end
        
        
        function value = get_value( obj )
            
            value = obj.value.get_value();
            
        end
        
        
        function state = get_usage_state( obj )
            
            state = obj.check_box_handle.Value;
            
        end
        
        
        function tag = get_tag( obj )
            
            tag = obj.tag;
            
        end
        
        
        function set_background_color( obj, color )
            
            obj.check_box_handle.BackgroundColor = color;
            obj.static_text_handle.BackgroundColor = color;
            
        end
        
    end
    
    
    methods ( Access = public, Static )
        
        function width = get_width()
            
            width = ThresholdSelectorWidget.CHECK_BOX_WIDTH + ...
                2 * ThresholdSelectorWidget.HORIZONTAL_PAD + ...
                ThresholdSelectorWidget.TITLE_WIDTH + ...
                ThresholdSelectorWidget.VALUE_EDITOR_WIDTH + ...
                ThresholdSelectorWidget.SLIDER_WIDTH;
            
        end
        
        
        function height = get_height( font_size )
            
            height = get_height( font_size );
            
        end
        
    end
    
    
    properties ( Access = private )
        
        check_box_handle
        static_text_handle
        edit_text_handle
        slider_handle
        
        tag
        value
        
    end
    
    
    properties ( Access = private, Constant )
        
        CHECK_BOX_WIDTH = 250;
        VALUE_EDITOR_WIDTH = 80;
        SLIDER_WIDTH = 150; % TODO CHANGE THIS IF NEED VERT SCROLLBAR
        
        PRECISION = 4;
        
    end
    
    
    methods ( Access = private )
        
        function value = get_new_value( obj, style )
            
            if strcmpi( style, 'edit' )
                value = str2double( obj.edit_text_handle.String );
            elseif strcmpi( style, 'slider' )
                value = obj.slider_handle.Value;
            else
                assert( false )
            end
            
        end
        
        
        function changed = update_internal_value( obj, new_value )
            
            changed = obj.value.update( new_value );
            
        end
        
        
        function update_handle_values( obj )
            
            obj.slider_handle.Value = obj.value.get_value();
            obj.edit_text_handle.String = num2str( obj.value.get_value(), obj.PRECISION );
            
        end
        
        
        function update_handle_ranges( obj )
            
            obj.slider_handle.Min = obj.value.get_min();
            obj.slider_handle.Max = obj.value.get_max();
            
        end
        
    end
    
    
    methods ( Access = private, Static )
        
        function h = create_check_box( ...
                parent, ...
                label, ...
                font_size, ...
                position, ...
                state, ...
                callback ...
                )
            
            h = uicontrol();
            h.Style = 'checkbox';
            h.String = label;
            h.FontSize = font_size;
            h.Value = state;
            h.Position = position;
            h.Callback = callback;
            h.Parent = parent;
            
        end
        
        
        function h = create_value_editor( ...
                parent, ...
                position, ...
                font_size, ...
                value, ...
                callback ...
                )
            
            h = uicontrol();
            h.Style = 'edit';
            h.String = num2str( value, ThresholdValueWidget.PRECISION );
            h.FontSize = font_size;
            h.Position = position;
            h.Callback = callback;
            h.Parent = parent;
            
        end
        
        
        function h = create_slider( ...
                parent, ...
                position, ...
                value, ...
                value_range, ...
                callback ...
                )
            
            h = uicontrol();
            h.Style = 'slider';
            h.Min = value_range.min;
            h.Max = value_range.max;
            h.Value = value;
            h.Position = position;
            h.Callback = callback;
            h.Parent = parent;
            
        end
        
    end
    
    
end

