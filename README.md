# swift-CustomPicker
 封装好了一级，二级，三级选择器，只需要注意传进数据的模型和对应的type(枚举)即可



![image](https://github.com/ZeroOneMore/swift-CustomPicker/blob/master/Resource/picker.gif)

    struct RegionsModel{
        var id: String
        var name: String
        var num: String
        var parentId: String
        var level: String
    
        init(dict: [String: Any]) {
            id = dict["id"] as! String
            name = dict["name"] as! String
            num = dict["num"] as! String
            parentId = dict["parentId"] as! String
            level = dict["level"] as! String
        }
    }

    var arrays = [["id":"0001","name":"北京市","num":"0001","parentId":"0","level":"1"],
    ["id":"00010001","name":"朝阳区","num":"0001","parentId":"0001","level":"2"],
    ["id":"00010001","name":"南磨房地区","num":"0001","parentId":"00010001","level":"3"]]
   

|RegionsModel   | 是否必填 |       |
| ------------- |:-------:| -----:|
| id            | 是      |      每个模型的id |
| name          | 是      |    每个模型的描述 |
| parentId      | 是      |    每个模型的父id |
| level         | 是      |    每个模型的等级 |
| num           | 否      |    项目中用到而已 |
      
    
