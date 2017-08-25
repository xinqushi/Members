package mapper;


import entity.Province;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * .
 */
public interface ProvinceMapper {
    List<Province> getProvinceAll();

    Province getProvinceName(Integer id);
}
