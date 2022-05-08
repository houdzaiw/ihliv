class HttpApis {
  static String getAppStrategy = '/config/getStrategy'; // 获取app策略
  static String getAppConfig = "/config/getAppConfig"; // 获取app配置

  static String oauth = "/security/oauth"; // 登录注册
  static String getRCToken = "/user/rongcloud/token"; // 获取融云Token
  static String getUserInfo = "/user/getUserInfo"; // 获取用户信息
  static String getUserExt =  "/user/getBroadcasterExtraInfo";  // 获取主播额外信息
  static String getUserStatus =  "/user/getUserOnlineStatus";  // 获取主播状态
  static String getUserCoins = "/user/getUserCoins";  // 获取用户金币
  static String updateUserMedia = "/user/updateMedia";  // 更新用户媒体资源
  static String updateUserAvatar = "/user/updateAvatar";  //更新用户头像
  static String updateUserInfo = "/user/saveUserInfo";  // 更新用户信息
  static String updateUserBaseInfo = "/user/saveBasicInfo"; // 更新用户基本信息
  static String getPresentedCoins = "/coin/presented/get";  // 获取新用户金币奖励

  static String wallList = "/broadcaster/wall/search"; // 获取主播列表
  static String wallAvatarList = "/user/avatar/search"; // 获取主播头像
  static String flowList = "/broadcaster/videoStream/search"; // 视频流列表

  static String getProducts = "/coin/goods/search"; // 获取商品列表
  static String getPromotionProducts = "/coin/goods/getPromotion"; // 获取促销商品
  static String getSpecialProduct = "/coin/goods/getLastSpecialOffer"; // 获取活动商品

  static String createOrder = "/coin/recharge/create";  // 创建订单
  static String verifyOrder = "/coin/recharge/payment/ipa"; // 验证订单

  static String follow = "/user/addFriend"; // 加关注
  static String unfollow = "/user/unfriend";  // 取消关注
  static String followList = "/user/getFriendsList";  // 关注列表

  static String block =  "/report/complain/insertRecord"; // 举报、拉黑
  static String blockList = "/report/complain/blockList"; // 用户屏蔽列表
  static String removeBlock = "/report/complain/removeBlock"; // 用户取消屏蔽

  static String getOssPolicy = "/user/oss/policy";  // 获取文件上传参数

  static String callCreateChannel = "/video-call/channel/create"; // 创建频道
  static String callPickup = "/video-call/pickUp";  // 接听
  static String callHangup = "/video-call/hangUp";  // 挂断
  static String callDuration = "/video-call/duration";  // 通话时长获取
  static String callRecordWarn = "/video-call/record/warn"; // 通话录屏警告上报
  static String callResult = "/video-call/user/callResult"; // 获取通话结果
  static String hostEvaluate = "/broadcaster/evaluate/submit"; // 主播评价


  static String getHostRank = "/broadcaster/rank/search"; // 主播排行榜
  static String getUserRank = "/user/rank/search"; // 用户排行榜

  static String getGiftList = "/gift/list"; // 获取礼物列表
  static String sendGift = "/user/giveUserGifts"; // 发送礼物

  static String storyList = "/info-flow/list";  // 信息流列表
  static String storyLike = "/info-flow/like/updateStatus"; // 信息流点赞
  static String storySendGift = "/info-flow/Gifts/giveUser";  // 信息流送礼
  static String storyPublishLimit = "/info-flow/user/residueTimes"; // 信息流发布次数查询
  static String userStoryList = "/info-flow/user/list"; // 用户信息流列表
  static String storyPublish = "/info-flow/publish";  // 发布信息流
  static String storyDelete = "/info-flow/delete";  // 发布信息流

  // gogogogogo
  static String appInfo = "/live/app/info"; //获取app配置
}