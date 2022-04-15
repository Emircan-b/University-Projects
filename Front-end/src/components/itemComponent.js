import React, {Component} from "react";

class ItemComponent extends Component{

    render() {
        let {name, img} = this.props;
        return (
            <div className="content-block">
                <div className="img-item">
                    {img}
                </div>
                <div className="text-item">
                    <p>{name}</p>
                </div>
            </div>
        );
    }
}


export default ItemComponent;
