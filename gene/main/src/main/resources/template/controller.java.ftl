package ${package.Controller};


import org.springframework.web.bind.annotation.RequestMapping;

<#if restControllerStyle>
import org.springframework.web.bind.annotation.RestController;
<#else>
import org.springframework.stereotype.Controller;
</#if>
<#if superControllerClassPackage??>
import ${superControllerClassPackage};
</#if>
import java.util.List;
import java.util.Map;

/**
 * <p>
 * ${table.comment!} 前端控制器
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
<#if restControllerStyle>
@RestController
<#else>
@Controller
</#if>
@RequestMapping("<#if package.ModuleName??>/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>")
<#if kotlin>
class ${table.controllerName}<#if superControllerClass??> : ${superControllerClass}()</#if>
<#else>
<#if superControllerClass??>
public class ${table.controllerName} extends ${superControllerClass} {
<#else>
public class ${table.controllerName} {
</#if>

    @Autowired
    private ${table.serviceName} service;

    /**
     * 查询分页数据
     */
    @ResponseBody
    @ApiOperation(value = "查询分页数据")
    @RequestMapping(value = "/page.do")
    public ResultPagerVo findListByPage(@RequestBody Map<String, Object> map) {
        int pageNumber = Integer.parseInt((String) map.get("pageNo"));
        int pageSize = Integer.parseInt((String) map.get("pageSize"));
        YxBill billParam = JSON.parseObject(JSON.toJSONString(map.get("bill")), YxBill.class);
        Page page = PageHelper.startPage(pageNumber, pageSize, true);
        List pageList = service.queryPage(map);
        return ResultUtils.pagerSuccess(pageList, DistConst.SELECT_SUCCUESS, page);
    }

    /**
     * 根据id查询
     */
    @ResponseBody
    @ApiOperation(value = "根据id查询数据")
    @RequestMapping(value = "/getById.do")
    public ResultVo getById(@RequestParam("id") String id) {
        return null;
    }

    /**
     * 新增
     */
    @ResponseBody
    @ApiOperation(value = "新增数据")
    @RequestMapping(value = "/add.do", method = RequestMethod.POST)
    public ResultVo add(@RequestBody Map<String, Object> map) {
        return null;
    }

    /**
     * 删除
     */
    @ResponseBody
    @ApiOperation(value = "删除数据")
    @RequestMapping(value = "/del.do")
    public ResultVo delete(@RequestParam("id") String id) {
        service.deleteById(id);
        return ResultUtils.success();
    }

    /**
     * 修改
     */
    @ResponseBody
    @ApiOperation(value = "更新数据")
    @RequestMapping(value = "/update.do", method = RequestMethod.POST)
    public ResultVo update(@RequestBody Map<String, Object> map) {
        return return null;
    }

}
</#if>
