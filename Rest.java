/**
 *
 */
package com.verizon.iot.thingspace.{Service}service;

import javax.ejb.Stateless;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import io.swagger.annotations.Api;

/**
 * @author guptga1
 *
 */
@Stateless
@Path("/v1")
@Api(value = "/v1", description = "{Service} Service")
public class {Service}Rest{
	private static final Logger log = LoggerFactory.getLogger({Service}Rest.class);

	/*
	 * isHealthy()
	 */
	@GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/status")
	public String isHealthy() {
		// TODO Auto-generated method stub
		return "status=up! It's healthy";
	}
}
