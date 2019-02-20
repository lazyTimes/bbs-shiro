package com.zxd.forrun.pojo.vo;

import java.util.List;

/**
 * 分页信息
 */
public class PageInfo<T> {
    private int pageNow;			//当前页
    private int pageSize;		//每一页显示多少条记录
    private int pageCount;		//分页总数
    private int rowCount; 		//总的记录数	数据库查询
    private int beginPage; 		//开始页数
    private int endPage; 		//结束页数
    private List<T> pageList; 	//分页数据（集合）


    public PageInfo() {

    }

    /**
     * 建立分页对象的必要条件
     * @param pageNow 当前页
     * @param pageSize 每页记录
     * @param rowCount 分页总记录
     * @param pageList 分页数据
     */
    public PageInfo(int pageNow, int pageSize, int rowCount, List<T> pageList) {
        this.pageNow = pageNow;
        this.pageSize = pageSize;
        this.rowCount = rowCount;
        this.pageList = pageList;

        // 计算分页数
        this.pageCount = (rowCount-1) / pageSize + 1;


//		如果pageCount <= 10
        if(pageCount <= 10){
//			直接显示当前附近的10个页码(前4个 + 后5个)
            beginPage = 1;
            endPage = pageCount;
        }else{
//			如果pageCount > 10
            beginPage = pageNow - 4;
            endPage = pageNow + 5;
            if (beginPage < 1) {
//				如果不足 4 个页码
//				显示前10个页码
                beginPage = 1;
                endPage = 10;
            }else if(endPage > pageCount){
//				如果不足 5 个页码
//					显示后10个页码
                beginPage = pageCount - 9;
                endPage = pageCount;
            }
        }
    }

    public int getPageNow() {
        return pageNow;
    }

    public void setPageNow(int pageNow) {
        this.pageNow = pageNow;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getPageCount() {
        return pageCount;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public int getRowCount() {
        return rowCount;
    }

    public void setRowCount(int rowCount) {
        this.rowCount = rowCount;
    }

    public int getBeginPage() {
        return beginPage;
    }

    public void setBeginPage(int beginPage) {
        this.beginPage = beginPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public List<T> getPageList() {
        return pageList;
    }

    public void setPageList(List<T> pageList) {
        this.pageList = pageList;
    }

    @Override
    public String toString() {
        return "PageInfo{" +
                "pageNow=" + pageNow +
                ", pageSize=" + pageSize +
                ", pageCount=" + pageCount +
                ", rowCount=" + rowCount +
                ", beginPage=" + beginPage +
                ", endPage=" + endPage +
                ", pageList=" + pageList +
                '}';
    }
}
