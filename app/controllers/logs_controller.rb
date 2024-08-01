class LogsController < ApplicationController
    before_action :authorized_client, only: [:generate_client_operations_report]
    before_action :authorized_admin, only: [:generate_brand_operations, :generate_client_operations]

    def generate_client_operations_report
        @all_logs_for_client = Log.where(client_id: get_current_user_id)

        Log.create({
            log_id: SecureRandom.uuid,
            user_id: get_current_user_id,
            action: "Client operations report generated",
            client_id: get_current_user_id
        })

        render json: {
            client_operations_log: @all_logs_for_client.map{ |entry| format_log_entry(entry) }
        }, status: 200
    end

    def generate_brand_operations
        @brand_logs = Log.where(brand_id: log_params[:brand_id])

        Log.create({
            log_id: SecureRandom.uuid,
            user_id: get_current_user_id,
            action: "Brand operations report generated"
        })

        render json: {
            brand_operations_log: @brand_logs.map{ |entry| format_log_entry(entry) }
        }, status: 200
    end

    def generate_client_operations
        @client_logs = Log.where(client_id: log_params[:client_id])

        Log.create({
            log_id: SecureRandom.uuid,
            user_id: get_current_user_id,
            action: "Brand operations report generated",
            client_id: log_params[:client_id]
        })

        render json: {
            client_operations_log: @client_logs.map{ |entry| format_log_entry(entry) }
        }, status: 200
    end

    private

    def log_params
        params.permit(:client_id, :brand_id)
    end

    def format_name(id, type)
        if !id || id.length == 0
            return ""
        else
            object = nil
            case type
                when "user"
                    object = Auth.find_by(userid: id)
                when "brand"
                    object = Brand.find_by(brand_id: id)
                when "product"
                    object = Product.find_by(product_id: id)
            end

            if !object
                return id
            else
                return object[:name]
            end
        end
    end

    def format_log_entry(entry)
        return {
            user_name: format_name(entry[:user_id], "user"),
            action: entry[:action],
            client_affected: format_name(entry[:client_id], "user"),
            brand_name: format_name(entry[:brand_id], "brand"),
            product_name: format_name(entry[:product_id], "product"),
            card_id: entry[:card_id],
            timestamp: entry[:created_at]
        }
    end
end
