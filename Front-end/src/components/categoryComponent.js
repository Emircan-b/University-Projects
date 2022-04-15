import React, {Component} from "react";
import TabComponent from "./tabComponent";
import ItemComponent from "./itemComponent";

class CategoryComponent extends Component{

    render() {
        let {category_name, tab_name_1, tab_name_2, tab_name_3} = this.props;
        return (
            <div className="main-block">
                <TabComponent
                    tab1={tab_name_1}
                    tab2={tab_name_2}
                    tab3={tab_name_3}
                />
                <div className="content-root">
                    <div className="content-container">
                        <ItemComponent
                            name={`${category_name} item-1`}
                            img={"img-1"}
                        />
                        <ItemComponent
                            name={`${category_name} item-2`}
                            img={"img-1"}
                        />
                        <ItemComponent
                            name={`${category_name} item-3`}
                            img={"img-1"}
                        />
                        <ItemComponent
                            name={`${category_name} item-4`}
                            img={"img-1"}
                        />
                        <ItemComponent
                            name={`${category_name} item-5`}
                            img={"img-1"}
                        />
                        <ItemComponent
                            name={`${category_name} item-6`}
                            img={"img-1"}
                        />
                        <ItemComponent
                            name={`${category_name} item-7`}
                            img={"img-1"}
                        />
                        <ItemComponent
                            name={`${category_name} item-8`}
                            img={"img-1"}
                        />
                        <ItemComponent
                            name={`${category_name} item-9`}
                            img={"img-1"}
                        />
                        <ItemComponent
                            name={`${category_name} item-10`}
                            img={"img-1"}
                        />
                        <ItemComponent
                            name={`${category_name} item-11`}
                            img={"img-1"}
                        />
                        <ItemComponent
                            name={`${category_name} item-12`}
                            img={"img-1"}
                        />
                        <ItemComponent
                            name={`${category_name} item-13`}
                            img={"img-1"}
                        />
                        <ItemComponent
                            name={`${category_name} item-14`}
                            img={"img-1"}
                        />
                        <ItemComponent
                            name={`${category_name} item-15`}
                            img={"img-1"}
                        />
                        <ItemComponent
                            name={`${category_name} item-16`}
                            img={"img-1"}
                        />
                        <ItemComponent
                            name={`${category_name} item-17`}
                            img={"img-1"}
                        />
                    </div>
                </div>
            </div>
        );
    }
}


export default CategoryComponent;
