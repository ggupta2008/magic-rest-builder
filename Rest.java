/**
 *
 */
package com.verizon.iot.thingspace.{Service}service;

import java.lang.annotation.Target;

import javax.ejb.Stateless;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;

/**
 * @author guptga1
 *
 */
@Stateless
@Path("/v1")
@Api(value = "{Service} Endpoint")
    public class {Service}Rest{
	private static final Logger log = LoggerFactory.getLogger({Service}Rest.class);

	/*
	 * isHealthy()
	 */
	@GET
	@ApiOperation(value = "get status",notes = "this is to prove that service is healthy and running!")
    	@ApiResponses(value = {@ApiResponse(code = 500, message = "Error handling request."),@ApiResponse(code = 400, message = "Invalid values specified.")})
	@Produces(MediaType.APPLICATION_JSON)
    	@Path("/status")
	public Response isHealthy() {
		// TODO Auto-generated method stub
		return Response.status(200).entity("status=up! It's healthy").build(); 
	}
	
}
