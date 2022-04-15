import React, {Component} from "react";

class TabComponent extends Component{

    state = {
        activeTab: 0
    }

    setTab = (activeTab) => {
        this.setState({
            activeTab: activeTab
        })
    }

    render() {
        let {tab1, tab2, tab3} = this.props;
        return (
            <div className="tab-select-root">
                <div className="tab-select-block">
                    <div className={`tab-item ${this.state.activeTab===0?"active":""}`} onClick={()=>{this.setTab(0)}}>
                        <span>{tab1}</span>
                    </div>
                    <div className={`tab-item ${this.state.activeTab===1?"active":""}`} onClick={()=>{this.setTab(1)}}>
                        <span>{tab2}</span>
                    </div>
                    <div className={`tab-item ${this.state.activeTab===2?"active":""}`} onClick={()=>{this.setTab(2)}}>
                        <span>{tab3}</span>
                    </div>
                </div>
            </div>
        );
    }
}


export default TabComponent;
