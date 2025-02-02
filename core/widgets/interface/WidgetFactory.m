classdef (Sealed) WidgetFactory < handle
    
    methods ( Access = public )
        %% CONSTRUCTOR
        function obj = WidgetFactory( resolution_px )
            
            obj.previous_y_top = obj.Y_TOP;
            obj.previous_y_left = obj.Y_LEFT;
            obj.previous_y_right = obj.Y_RIGHT;
            
        end
        
        
        %% WINDOW
        function h = create_figure( obj, name )
            
            h = figure();
            h.Name = sprintf( 'Orientation Data for %s', name );
            h.NumberTitle = 'off';
            h.Position = obj.get_figure_position();
            h.MenuBar = 'none';
            h.ToolBar = 'none';
            h.DockControls = 'off';
            h.Resize = 'off';
            movegui( h, 'center' );
            
            obj.figure_handle = h;
            
        end
        
        
        %% TOP PANE
        function h = add_point_reporter_widget( obj )
            
            x = obj.center( PointReporterWidget.get_width() );
            y = obj.previous_y_top - ...
                PointReporterWidget.get_height( obj.FONT_SIZE ) - ...
                obj.Y_PAD;
            h = PointReporterWidget( ...
                obj.figure_handle, ...
                [ x y ], ...
                obj.FONT_SIZE ...
                );
            obj.previous_y_top = y;
            
        end
        
        
        function h = add_objective_picker_widget( ...
                obj, ...
                titles, ...
                initial_index, ...
                list_box_callback ...
                )
            
            x = obj.center( ObjectivePickerWidget.get_width() );
            y = obj.previous_y_top - ...
                ObjectivePickerWidget.get_height( obj.FONT_SIZE ) - ...
                obj.Y_PAD;
            h = ObjectivePickerWidget( ...
                obj.figure_handle, ...
                [ x y ], ...
                obj.FONT_SIZE, ...
                titles, ...
                initial_index, ...
                list_box_callback ...
                );
            
        end
        
        
        %% LEFT PANE
        function h = add_point_plot_widgets( obj, check_box_callback )
            
            x = obj.X_LEFT + obj.X_PAD;
            h = PointPlotWidgets( ...
                obj.figure_handle, ...
                [ x 0 ], ...
                obj.X_PAD, ...
                obj.Y_PAD, ...
                obj.FONT_SIZE, ...
                check_box_callback ...
                );
            y = obj.previous_y_left - ...
                obj.Y_PAD - ...
                h.get_height();
            pos = h.get_position();
            pos( 2 ) = y;
            pos( 3 ) = obj.WIDTH_LEFT;
            h.set_position( pos );
            obj.previous_y_left = y;
            
        end
        
        
        function h = add_thresholding_widget( ...
                obj, ...
                default_id, ...
                value_picker_fns, ...
                labels, ...
                selection_changed_function ...
                )
            
            x = obj.X_LEFT + obj.X_PAD;
            h = ThresholdingWidgets( ...
                obj.figure_handle, ...
                [ x 0 ], ...
                obj.X_PAD, ...
                obj.Y_PAD, ...
                obj.FONT_SIZE, ...
                default_id, ...
                value_picker_fns, ...
                labels, ...
                selection_changed_function ...
                );
            y = obj.previous_y_left - ...
                obj.Y_PAD - ...
                h.get_height();
            pos = h.get_position();
            pos( 2 ) = y;
            pos( 3 ) = obj.WIDTH_LEFT;
            h.set_position( pos );
            obj.previous_y_left = y;
            
        end
        
        
        function h = add_mode_selector_widget( ...
                obj, ...
                mode_changed_callback ...
                )
            
            x = obj.X_LEFT + obj.X_PAD;
            h = ModeSelectorWidget( ...
                obj.figure_handle, ...
                [ x 0 ], ...
                obj.X_PAD, ...
                obj.Y_PAD, ...
                obj.FONT_SIZE, ...
                DataFilter.VALUE_MODE, ...
                mode_changed_callback ...
                );
            y = obj.previous_y_left - ...
                obj.Y_PAD - ...
                h.get_height();
            pos = h.get_position();
            pos( 2 ) = y;
            pos( 3 ) = obj.WIDTH_LEFT;
            h.set_position( pos );
            obj.previous_y_left = y;
            
        end
        
        
        function h = add_visualization_widget( ....
                obj, ...
                visualization_generator, ...
                button_callback ...
                )
            
            x = obj.X_LEFT + obj.X_PAD;
            h = VisualizationWidget( ...
                obj.figure_handle, ...
                [ x 0 ], ...
                obj.FONT_SIZE, ...
                visualization_generator, ...
                button_callback ...
                );
            y = obj.previous_y_left - ...
                obj.Y_PAD - ...
                h.get_height();
            pos = h.get_position();
            pos( 2 ) = y;
            pos( 3 ) = obj.WIDTH_LEFT;
            h.set_position( pos );
            obj.previous_y_left = y;
            
        end
        
        
        function h = add_threshold_value_selector_widget( ...
                obj, ...
                data_filter, ...
                value_update_callback, ...
                check_box_callback ...
                )
            
            x = obj.X_LEFT + obj.X_PAD;
            h = ThresholdValueSelectorWidget( ...
                obj.figure_handle, ...
                [ x 0 ], ...
                obj.X_PAD, ...
                obj.Y_PAD, ...
                obj.FONT_SIZE, ...
                data_filter, ...
                value_update_callback, ...
                check_box_callback ...
                );
            y = obj.previous_y_left - ...
                obj.Y_PAD - ...
                h.get_height();
            pos = h.get_position();
            pos( 2 ) = y;
            pos( 3 ) = obj.WIDTH_LEFT;
            h.set_position( pos );
            obj.previous_y_left = y;
            
        end
        
        
        %% RIGHT PANE
        function h = add_axes_widget( ...
                obj, ...
                button_down_callback ...
                )
            
            desired_width = obj.WIDTH_RIGHT;
            desired_height = obj.HEIGHT_RIGHT * 0.5;
            
            x = obj.X_RIGHT + obj.X_PAD;
            y = obj.previous_y_right;
            h = AxesWidget( ...
                obj.figure_handle, ...
                [ x y ], ...
                [ desired_width desired_height ], ...
                obj.FONT_SIZE, ...
                button_down_callback ...
                );
            pos = h.get_position();
            obj.previous_y_right = pos( 3 ) - pos( 4 );
            
        end
        
        
        function surface_plotter = add_surface_plotter_widget( ...
                ~, ...
                phi_grid, ...
                theta_grid ...
                )
            
            surface_plotter = SurfacePlotter( ...
                phi_grid, ...
                theta_grid ...
                );
            
        end
        
        
        function h = add_parallel_plotter_widget( ...
                obj, ...
                data_filter ...
                )
            
            desired_width = obj.WIDTH_RIGHT;
            desired_height = obj.HEIGHT_RIGHT * 0.5;
            x = obj.X_RIGHT + obj.X_PAD;
            y = obj.previous_y_right;
            h = ParallelPlotWidget( ...
                obj.figure_handle, ...
                [ x y ], ...
                [ desired_width desired_height ], ...
                obj.FONT_SIZE, ...
                data_filter ...
                );
            pos = h.get_position();
            obj.previous_y_right = pos( 3 ) - pos( 4 );
            
            
        end
        
    end
    
    
    methods ( Access = public, Static )
        
    end
    
    
    properties ( Access = private )
        
        figure_handle
        
        previous_y_top
        previous_y_left
        previous_y_right
        
    end
    
    
    properties ( Access = private, Constant )
        
        % WINDOW PARAMETERS
        X_WIN = 0;
        Y_WIN = 0;
        WIDTH_WIN = 1440;
        HEIGHT_WIN = 960;
        
        % TOP PANE
        X_TOP = 0;
        Y_TOP = WidgetFactory.HEIGHT_WIN;
        RATIO_TOP = 1 / 15;
        HEIGHT_TOP = WidgetFactory.RATIO_TOP * WidgetFactory.HEIGHT_WIN;
        WIDTH_TOP = WidgetFactory.WIDTH_WIN;
        
        % LEFT PANE
        X_LEFT = 0;
        Y_LEFT = WidgetFactory.HEIGHT_WIN - WidgetFactory.HEIGHT_TOP;
        RATIO_LEFT = 0.35;
        HEIGHT_LEFT = WidgetFactory.HEIGHT_WIN - WidgetFactory.HEIGHT_TOP;
        WIDTH_LEFT = WidgetFactory.RATIO_LEFT * WidgetFactory.WIDTH_WIN;
        
        % RIGHT PANE
        X_RIGHT = WidgetFactory.WIDTH_LEFT;
        Y_RIGHT = WidgetFactory.HEIGHT_WIN - WidgetFactory.HEIGHT_TOP;
        HEIGHT_RIGHT = WidgetFactory.HEIGHT_WIN - WidgetFactory.HEIGHT_TOP;
        WIDTH_RIGHT = WidgetFactory.WIDTH_WIN - WidgetFactory.WIDTH_LEFT
        
        % OTHER PARAMETERS
        X_PAD = 6;
        Y_PAD = 6;
        FONT_SIZE = 10;
        
    end
    
    
    methods ( Access = private )
        
        function x_pos = center( obj, widget_width )
            
            x_pos = round( obj.figure_handle.Position( 3 ) / 2 ) ...
                - round( widget_width / 2 ) ...
                + 1;
            
        end
        
    end
    
    
    methods ( Access = private, Static )
        
        function pos = compute_figure_position( resolution_px )
            
            assert( resolution_px >= WidgetFactory.MIN_RESOLUTION );
            pos = [ ...
                0, ...
                0, ...
                1.8 * resolution_px + 1, ...
                1.2 * make_odd( resolution_px ) ...
                ];
            
        end
        
        
        function pos = get_figure_position()
            
            pos = [ ...
                WidgetFactory.X_WIN ...
                WidgetFactory.Y_WIN ...
                WidgetFactory.WIDTH_WIN ...
                WidgetFactory.HEIGHT_WIN ...
                ];
            
        end
        
    end
    
end

