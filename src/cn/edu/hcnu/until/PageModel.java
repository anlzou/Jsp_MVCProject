package cn.edu.hcnu.until;

import java.util.List;

public class PageModel {
    private List list;
    private int currentPage;
    private int totalPage;

        return list;
    public void setList(List list) {
        this.list = list;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    @Override
    public String toString() {
        return "PageModel{" +
                "list=" + list +
                ", currentPage=" + currentPage +
                ", totalPage=" + totalPage +
                '}';
    }
}
