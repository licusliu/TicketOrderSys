package com.ticket.service.impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ticket.dao.BaseDAO;
import com.ticket.entity.Flight;
import com.ticket.entity.PageBean;
import com.ticket.service.FlightService;
import com.ticket.util.DateUtil;
import com.ticket.util.StringUtil;

/**
 * 航班Service实现类
 * @author Administrator
 *
 */
@Service("flightService")
public class FlightServiceImpl implements FlightService{

	@Resource
	private BaseDAO<Flight> baseDAO;
	
	public List<Flight> findFlightList(Flight s_flight,PageBean pageBean){
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from Flight");
		if(s_flight!=null){
			if(StringUtil.isNotEmpty(s_flight.getName())){
				hql.append(" and name like '%"+s_flight.getName()+"%'");
			}
			if(StringUtil.isNotEmpty(s_flight.getFlightType())){
				hql.append(" and flightType='"+s_flight.getFlightType()+"'");
			}
			if(StringUtil.isNotEmpty(s_flight.getFromCity())){
				hql.append(" and fromCity='"+s_flight.getFromCity()+"'");
			}
			if(StringUtil.isNotEmpty(s_flight.getToCity())){
				hql.append(" and toCity='"+s_flight.getToCity()+"'");
			}
			if(s_flight.getFromTime()!=null){
				try
				{
					hql.append("  and date( fromTime)= date('"+new java.sql.Date(s_flight.getFromTime().getTime())+"')");
				} catch (Exception e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		hql.append(" order by fromTime desc");
		if(pageBean!=null){
			return baseDAO.find(hql.toString().replaceFirst("and", "where"), param, pageBean);
		}else{
			return baseDAO.find(hql.toString().replaceFirst("and", "where"), param);
		}
	}

	public Long getFlightCount(Flight s_flight) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("select count(*) from Flight");
		if(s_flight!=null){
			if(StringUtil.isNotEmpty(s_flight.getName())){
				hql.append(" and name like '%"+s_flight.getName()+"%'");
			}
			if(StringUtil.isNotEmpty(s_flight.getFlightType())){
				hql.append(" and flightType='"+s_flight.getFlightType()+"'");
			}
			if(StringUtil.isNotEmpty(s_flight.getFromCity())){
				hql.append(" and fromCity='"+s_flight.getFromCity()+"'");
			}
			if(StringUtil.isNotEmpty(s_flight.getToCity())){
				hql.append(" and toCity='"+s_flight.getToCity()+"'");
			}
			if(s_flight.getFromTime()!=null){
				try
				{
					System.out.println(new java.sql.Date(s_flight.getFromTime().getTime()));
					hql.append("  and date( fromTime)= date('"+new java.sql.Date(s_flight.getFromTime().getTime())+"')");
				} catch (Exception e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return baseDAO.count(hql.toString().replaceFirst("and", "where"), param);
	}

	public Flight getFlightById(int id) {
		return baseDAO.get(Flight.class, id);
	}

	public void saveFlight(Flight flight) {
		baseDAO.merge(flight);
	}

	public void delete(Flight flight) {
		baseDAO.delete(flight);
	}
}
