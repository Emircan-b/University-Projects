import React, {Component} from "react";
import CategoryComponent from "./categoryComponent";

class HomePageComponent extends Component{

    state = {
        activeCategory: 1
    }

    setCategory = (activeCategory) => {
        this.setState({
            activeCategory: activeCategory
        })
    }

    renderCategory = () => {
        switch(this.state.activeCategory){
            case 1:
                return <CategoryComponent
                    category_name={"kategori-1"}
                    tab_name_1={"kategori-1 alt-kategori-1"}
                    tab_name_2={"kategori-1 alt-kategori-2"}
                    tab_name_3={"kategori-1 alt-kategori-3"}
                />
                break;
            case 2:
                return <CategoryComponent
                    category_name={"kategori-2"}
                    tab_name_1={"kategori-2 alt-kategori-1"}
                    tab_name_2={"kategori-2 alt-kategori-2"}
                    tab_name_3={"kategori-2 alt-kategori-3"}
                />
                break;
            case 3:
                return <CategoryComponent
                    category_name={"kategori-3"}
                    tab_name_1={"kategori-3 alt-kategori-1"}
                    tab_name_2={"kategori-3 alt-kategori-2"}
                    tab_name_3={"kategori-3 alt-kategori-3"}
                />
                break;
            case 4:
                return <CategoryComponent
                    category_name={"kategori-4"}
                    tab_name_1={"kategori-4 alt-kategori-1"}
                    tab_name_2={"kategori-4 alt-kategori-2"}
                    tab_name_3={"kategori-4 alt-kategori-3"}
                />
                break;
            case 5:
                return <CategoryComponent
                    category_name={"kategori-5"}
                    tab_name_1={"kategori-5 alt-kategori-1"}
                    tab_name_2={"kategori-5 alt-kategori-2"}
                    tab_name_3={"kategori-5 alt-kategori-3"}
                />
                break;
            case 6:
                return <CategoryComponent
                    category_name={"kategori-6"}
                    tab_name_1={"kategori-6 alt-kategori-1"}
                    tab_name_2={"kategori-6 alt-kategori-2"}
                    tab_name_3={"kategori-6 alt-kategori-3"}
                />
                break;
        }
    }

    render() {
        return (
            <div>
                <div className="header-root">
                    <div className="header-wrapper">
                        <div className="header-container">
                            <div className="nav-block left">
                                <div className="nav-item">
                                    <span>Nav-1</span>
                                </div>
                                <div className="nav-item">
                                    <span>Nav-2</span>
                                </div>
                            </div>
                            <div className="logo-item">
                                LOGO
                            </div>
                            <div className="nav-block right">
                                <div className="nav-item">
                                    <span>Nav-3</span>
                                </div>
                                <div className="nav-item">
                                    <span>Nav-4</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <main className="main-root">
                    <div className="main-wrapper">
                        <div className="main-container">
                            <div className="menu-container">
                                <div className="menu-block">
                                    <div className={`menu-item ${this.state.activeCategory===1?"active":""}`} onClick={()=>{this.setCategory(1)}}>
                                        <span>kategori-1</span>
                                    </div>
                                    <div className={`menu-item ${this.state.activeCategory===2?"active":""}`} onClick={()=>{this.setCategory(2)}}>
                                        <span>kategori-2</span>
                                    </div>
                                    <div className={`menu-item ${this.state.activeCategory===3?"active":""}`} onClick={()=>{this.setCategory(3)}}>
                                        <span>kategori-3</span>
                                    </div>
                                    <div className={`menu-item ${this.state.activeCategory===4?"active":""}`} onClick={()=>{this.setCategory(4)}}>
                                        <span>kategori-4</span>
                                    </div>
                                    <div className={`menu-item ${this.state.activeCategory===5?"active":""}`} onClick={()=>{this.setCategory(5)}}>
                                        <span>kategori-5</span>
                                    </div>
                                    <div className={`menu-item ${this.state.activeCategory===6?"active":""}`} onClick={()=>{this.setCategory(6)}}>
                                        <span>kategori-6</span>
                                    </div>
                                </div>
                            </div>
                            {this.renderCategory()}
                        </div>
                    </div>
                </main>
                <div className="footer-root">

                </div>
            </div>
        );
    }
}


export default HomePageComponent;
