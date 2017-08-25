package dao;

import entity.Province;
import mapper.ProvinceMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * .
 */
@Repository
public class ProvinceDAO {

    @Autowired
    ProvinceMapper provinceMapper;

    /**
     * 得到所有地区
     * @return
     */
    public List<Province> getProvinceAll () {
        return provinceMapper.getProvinceAll();
    }
//
    /**
     * 根据id查询地区
     * @param id
     * @return
     */
    public Province getProvinceName (Integer id) {
        return provinceMapper.getProvinceName(id);
    }
}