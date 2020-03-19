Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5EF18ACFA
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2020 07:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCSGrm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Mar 2020 02:47:42 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:43479 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726063AbgCSGrm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Mar 2020 02:47:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584600460; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=k20keGS4OE7/fkS70LpCTB4cdhFiTQikaOibcU0kzq4=;
 b=UKSMIkKX7JO84enFo5t7stK5sv2rWcbCYfWsr2eZ6wa7Wg96/o/BERv2NeXFp7URnYsgf/BW
 w+jw1CZozYvh6yen491onosLLoXj1Url3UCEu1BxQSLuaXdr100sQIxJOCPEo7PgaD06qdQu
 u3ZBMS2n/O3f6QEsH5aygtucOTc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e73158b.7f27cc1e9490-smtp-out-n05;
 Thu, 19 Mar 2020 06:47:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7EEC0C432C2; Thu, 19 Mar 2020 06:47:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A61E6C433D2;
        Thu, 19 Mar 2020 06:47:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 19 Mar 2020 12:17:36 +0530
From:   tamizhr@codeaurora.org
To:     Janusz Dziedzic <janusz.dziedzic@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCHv4 1/2] cfg80211: Add support to configure station specific
 RSSI threshold for AP mode
In-Reply-To: <CAFED-jkNGd2qcqwGMS-+BbvvV-RDb9RNWENjub3cEiZjNSQceA@mail.gmail.com>
References: <1555492880-26457-1-git-send-email-tamizhr@codeaurora.org>
 <1555492880-26457-2-git-send-email-tamizhr@codeaurora.org>
 <CAFED-jkNGd2qcqwGMS-+BbvvV-RDb9RNWENjub3cEiZjNSQceA@mail.gmail.com>
Message-ID: <addf46fd5038dc508c882796d3d8b97a@codeaurora.org>
X-Sender: tamizhr@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-03-19 01:04, Janusz Dziedzic wrote:
> śr., 17 kwi 2019 o 11:24 Tamizh chelvam <tamizhr@codeaurora.org> 
> napisał(a):
>> 
>> Add infrastructure to configure station specific RSSI threshold
>> configuration to monitor station's signal strength variation.
>> This configuration will be useful for the application like
>> steering which requires change in the station's current signal
>> strength.
>> 
>> New NL80211_CMD_STA_MON introduced to configure the RSSI threshold
>> using NL80211_ATTR_CQM nested attributes. The MAC address of
>> a station is passed in NL80211_ATTR_MAC. And 
>> NL80211_ATTR_STA_MON_FIXED_THOLD
>> introduced to have this RSSI threshold as a fixed(not modifying the
>> low and high threshold upon crossing the threshold) or 
>> moving(modifying
>> low and high threshold upon crossing the threshold) thresholds.
>> Depends on the application's use case user can have either fixed or
>> moving RSSI range thresholds.
>> 
>> cfg80211_sta_mon_rssi_notify introduced to notify change in the
>> station's signal stregnth cross event using 
>> NL80211_CMD_NOTIFY_STA_MON.
>> Driver supporting this feature should advertise
>> NL80211_EXT_FEATURE_STA_MON_RSSI_CONFIG feature flag.
>> 
>> Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
>> ---
>>  include/net/cfg80211.h       |   39 +++++++++
>>  include/uapi/linux/nl80211.h |   21 +++++
>>  net/wireless/nl80211.c       |  179 
>> ++++++++++++++++++++++++++++++++++++------
>>  net/wireless/rdev-ops.h      |   13 +++
>>  net/wireless/trace.h         |   21 +++++
>>  5 files changed, 247 insertions(+), 26 deletions(-)
>> 
>> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
>> index 2ea04e9..cb8ba5a 100644
>> --- a/include/net/cfg80211.h
>> +++ b/include/net/cfg80211.h
>> @@ -3161,6 +3161,20 @@ struct cfg80211_update_owe_info {
>>  };
>> 
>>  /**
>> + * struct cfg80211_sta_mon - Configure station monitor parameters
>> + * @rssi_tholds - array of RSSI thresholds for the station
>> + * @rssi_hyst - RSSI hysterisis
>> + * @n_tholds - Number of configuration thresholds
>> + * @fixed_thold - Fixed thresholds limit used for the station
>> + */
>> +struct cfg80211_sta_mon {
>> +       s32 *rssi_tholds;
>> +       u32 rssi_hyst;
>> +       int n_tholds;
>> +       u8 fixed_thold;
>> +};
>> +
>> +/**
>>   * struct cfg80211_ops - backend description for wireless 
>> configuration
>>   *
>>   * This struct is registered by fullmac card drivers and/or wireless 
>> stacks
>> @@ -3501,6 +3515,12 @@ struct cfg80211_update_owe_info {
>>   * @update_owe_info: Provide updated OWE info to driver. Driver 
>> implementing SME
>>   *     but offloading OWE processing to the user space will get the 
>> updated
>>   *     DH IE through this interface.
>> + *
>> + * @set_sta_mon_rssi_config: Configure  RSSI threshold for a station.
>> + *     After configuration, the driver should (soon) send an event 
>> indicating
>> + *     the current level of a station is above/below the configured 
>> threshold;
>> + *     this may need some care when the configuration is changed
>> + *     (without first being disabled.)
>>   */
>>  struct cfg80211_ops {
>>         int     (*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan 
>> *wow);
>> @@ -3817,6 +3837,9 @@ struct cfg80211_ops {
>>                               struct cfg80211_pmsr_request *request);
>>         int     (*update_owe_info)(struct wiphy *wiphy, struct 
>> net_device *dev,
>>                                    struct cfg80211_update_owe_info 
>> *owe_info);
>> +       int     (*set_sta_mon_rssi_config)(struct wiphy *wiphy,
>> +                               struct net_device *dev, const u8 
>> *addr,
>> +                               const struct cfg80211_sta_mon 
>> *sta_mon_cfg);
>>  };
>> 
>>  /*
>> @@ -6620,6 +6643,22 @@ bool cfg80211_rx_control_port(struct net_device 
>> *dev,
>>                               struct sk_buff *skb, bool unencrypted);
>> 
>>  /**
>> + * cfg80211_sta_mon_rssi_notify - Station's rssi out of range event
>> + * @dev: network device
>> + * @peer: Station's mac address
>> + * @rssi_event: the triggered RSSI event
>> + * @rssi_level: new RSSI level value or 0 if not available
>> + * @gfp: context flags
>> + *
>> + * This function is called when a configured rssi threshold reached 
>> event
>> + * occurs for a station.
>> + */
>> +void
>> +cfg80211_sta_mon_rssi_notify(struct net_device *dev, const u8 *peer,
>> +                            enum nl80211_cqm_rssi_threshold_event 
>> rssi_event,
>> +                            s32 rssi_level, gfp_t gfp);
>> +
>> +/**
>>   * cfg80211_cqm_rssi_notify - connection quality monitoring rssi 
>> event
>>   * @dev: network device
>>   * @rssi_event: the triggered RSSI event
>> diff --git a/include/uapi/linux/nl80211.h 
>> b/include/uapi/linux/nl80211.h
>> index 25f70dd..cbe5866 100644
>> --- a/include/uapi/linux/nl80211.h
>> +++ b/include/uapi/linux/nl80211.h
>> @@ -1070,6 +1070,12 @@
>>   *     OWE AKM by the host drivers that implement SME but rely
>>   *     on the user space for the cryptographic/DH IE processing in AP 
>> mode.
>>   *
>> + * @NL80211_CMD_SET_STA_MON: This command is used to configure 
>> station's
>> + *     connection monitoring notification trigger levels. This uses 
>> nested
>> + *     attribute %NL80211_ATTR_CQM with %NL80211_ATTR_CQM_* 
>> sub-attributes.
>> + * @NL80211_CMD_NOTIFY_STA_MON: This is used as an event to notify
>> + *     the user space that a trigger level was reached for a station.
>> + *
>>   * @NL80211_CMD_MAX: highest used command number
>>   * @__NL80211_CMD_AFTER_LAST: internal use
>>   */
>> @@ -1292,6 +1298,9 @@ enum nl80211_commands {
>> 
>>         NL80211_CMD_UPDATE_OWE_INFO,
>> 
>> +       NL80211_CMD_SET_STA_MON,
>> +       NL80211_CMD_NOTIFY_STA_MON,
>> +
>>         /* add new commands above here */
>> 
>>         /* used to define NL80211_CMD_MAX below */
>> @@ -2324,6 +2333,12 @@ enum nl80211_commands {
>>   *     should be picking up the lowest tx power, either tx power 
>> per-interface
>>   *     or per-station.
>>   *
>> + * @NL80211_ATTR_STA_MON_FIXED_THOLD: This u8 attribute is used with
>> + *     %NL80211_CMD_SET_STA_MON to indicate driver that the 
>> monitoring
>> + *     threshold is fixed(not modifying the low and high threshold 
>> upon
>> + *     crossing the threshold) or moving(modifying low and high 
>> threshold
>> + *     upon crossing the threshold) thresholds.
>> + *
>>   * @NUM_NL80211_ATTR: total number of nl80211_attrs available
>>   * @NL80211_ATTR_MAX: highest attribute number currently defined
>>   * @__NL80211_ATTR_AFTER_LAST: internal use
>> @@ -2777,6 +2792,8 @@ enum nl80211_attrs {
>>         NL80211_ATTR_STA_TX_POWER_SETTING,
>>         NL80211_ATTR_STA_TX_POWER,
>> 
>> +       NL80211_ATTR_STA_MON_FIXED_THOLD,
>> +
>>         /* add attributes here, update the policy in nl80211.c */
>> 
>>         __NL80211_ATTR_AFTER_LAST,
>> @@ -5405,6 +5422,9 @@ enum nl80211_feature_flags {
>>   * @NL80211_EXT_FEATURE_STA_TX_PWR: This driver supports controlling 
>> tx power
>>   *     to a station.
>>   *
>> + * @NL80211_EXT_FEATURE_STA_MON_RSSI_CONFIG: Driver supports 
>> monitoring
>> + *     station's RSSI threshold value should adveritise this flag.
>> + *
>>   * @NUM_NL80211_EXT_FEATURES: number of extended features.
>>   * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
>>   */
>> @@ -5449,6 +5469,7 @@ enum nl80211_ext_feature_index {
>>         NL80211_EXT_FEATURE_SCHED_SCAN_BAND_SPECIFIC_RSSI_THOLD,
>>         NL80211_EXT_FEATURE_EXT_KEY_ID,
>>         NL80211_EXT_FEATURE_STA_TX_PWR,
>> +       NL80211_EXT_FEATURE_STA_MON_RSSI_CONFIG,
>> 
>>         /* add new features before the definition below */
>>         NUM_NL80211_EXT_FEATURES,
>> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
>> index 846d25d..78657c0 100644
>> --- a/net/wireless/nl80211.c
>> +++ b/net/wireless/nl80211.c
>> @@ -280,6 +280,17 @@ static int validate_ie_attr(const struct nlattr 
>> *attr,
>>                 
>> NLA_POLICY_NESTED_ARRAY(nl80211_psmr_peer_attr_policy),
>>  };
>> 
>> +static const struct nla_policy
>> +nl80211_attr_cqm_policy[NL80211_ATTR_CQM_MAX + 1] = {
>> +       [NL80211_ATTR_CQM_RSSI_THOLD] = { .type = NLA_BINARY },
>> +       [NL80211_ATTR_CQM_RSSI_HYST] = { .type = NLA_U32 },
>> +       [NL80211_ATTR_CQM_RSSI_THRESHOLD_EVENT] = { .type = NLA_U32 },
>> +       [NL80211_ATTR_CQM_TXE_RATE] = { .type = NLA_U32 },
>> +       [NL80211_ATTR_CQM_TXE_PKTS] = { .type = NLA_U32 },
>> +       [NL80211_ATTR_CQM_TXE_INTVL] = { .type = NLA_U32 },
>> +       [NL80211_ATTR_CQM_RSSI_LEVEL] = { .type = NLA_S32 },
>> +};
>> +
>>  const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
>>         [NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
>>         [NL80211_ATTR_WIPHY_NAME] = { .type = NLA_NUL_STRING,
>> @@ -395,7 +406,8 @@ static int validate_ie_attr(const struct nlattr 
>> *attr,
>>         [NL80211_ATTR_PS_STATE] = NLA_POLICY_RANGE(NLA_U32,
>>                                                    
>> NL80211_PS_DISABLED,
>>                                                    
>> NL80211_PS_ENABLED),
>> -       [NL80211_ATTR_CQM] = { .type = NLA_NESTED, },
>> +       [NL80211_ATTR_CQM] =
>> +               NLA_POLICY_NESTED(nl80211_attr_cqm_policy),
>>         [NL80211_ATTR_LOCAL_STATE_CHANGE] = { .type = NLA_FLAG },
>>         [NL80211_ATTR_AP_ISOLATE] = { .type = NLA_U8 },
>>         [NL80211_ATTR_WIPHY_TX_POWER_SETTING] = { .type = NLA_U32 },
>> @@ -546,6 +558,7 @@ static int validate_ie_attr(const struct nlattr 
>> *attr,
>>         [NL80211_ATTR_PEER_MEASUREMENTS] =
>>                 NLA_POLICY_NESTED(nl80211_pmsr_attr_policy),
>>         [NL80211_ATTR_AIRTIME_WEIGHT] = NLA_POLICY_MIN(NLA_U16, 1),
>> +       [NL80211_ATTR_STA_MON_FIXED_THOLD] = { .type = NLA_FLAG },
>>  };
>> 
>>  /* policy for the key attributes */
>> @@ -10498,17 +10511,6 @@ static int nl80211_get_power_save(struct 
>> sk_buff *skb, struct genl_info *info)
>>         return err;
>>  }
>> 
>> -static const struct nla_policy
>> -nl80211_attr_cqm_policy[NL80211_ATTR_CQM_MAX + 1] = {
>> -       [NL80211_ATTR_CQM_RSSI_THOLD] = { .type = NLA_BINARY },
>> -       [NL80211_ATTR_CQM_RSSI_HYST] = { .type = NLA_U32 },
>> -       [NL80211_ATTR_CQM_RSSI_THRESHOLD_EVENT] = { .type = NLA_U32 },
>> -       [NL80211_ATTR_CQM_TXE_RATE] = { .type = NLA_U32 },
>> -       [NL80211_ATTR_CQM_TXE_PKTS] = { .type = NLA_U32 },
>> -       [NL80211_ATTR_CQM_TXE_INTVL] = { .type = NLA_U32 },
>> -       [NL80211_ATTR_CQM_RSSI_LEVEL] = { .type = NLA_S32 },
>> -};
>> -
>>  static int nl80211_set_cqm_txe(struct genl_info *info,
>>                                u32 rate, u32 pkts, u32 intvl)
>>  {
>> @@ -10589,14 +10591,9 @@ static int cfg80211_cqm_rssi_update(struct 
>> cfg80211_registered_device *rdev,
>>         return rdev_set_cqm_rssi_range_config(rdev, dev, low, high);
>>  }
>> 
>> -static int nl80211_set_cqm_rssi(struct genl_info *info,
>> -                               const s32 *thresholds, int 
>> n_thresholds,
>> -                               u32 hysteresis)
>> +static int nl80211_validate_rssi_tholds(const s32 *thresholds, int 
>> n_thresholds)
>>  {
>> -       struct cfg80211_registered_device *rdev = info->user_ptr[0];
>> -       struct net_device *dev = info->user_ptr[1];
>> -       struct wireless_dev *wdev = dev->ieee80211_ptr;
>> -       int i, err;
>> +       int i;
>>         s32 prev = S32_MIN;
>> 
>>         /* Check all values negative and sorted */
>> @@ -10606,6 +10603,21 @@ static int nl80211_set_cqm_rssi(struct 
>> genl_info *info,
>> 
>>                 prev = thresholds[i];
>>         }
>> +       return 0;
>> +}
>> +
>> +static int nl80211_set_cqm_rssi(struct genl_info *info,
>> +                               const s32 *thresholds, int 
>> n_thresholds,
>> +                               u32 hysteresis)
>> +{
>> +       struct cfg80211_registered_device *rdev = info->user_ptr[0];
>> +       struct net_device *dev = info->user_ptr[1];
>> +       struct wireless_dev *wdev = dev->ieee80211_ptr;
>> +       int err;
>> +
>> +       err = nl80211_validate_rssi_tholds(thresholds, n_thresholds);
>> +       if (err)
>> +               return err;
>> 
>>         if (wdev->iftype != NL80211_IFTYPE_STATION &&
>>             wdev->iftype != NL80211_IFTYPE_P2P_CLIENT)
>> @@ -10668,7 +10680,7 @@ static int nl80211_set_cqm(struct sk_buff 
>> *skb, struct genl_info *info)
>>                 return -EINVAL;
>> 
>>         err = nla_parse_nested(attrs, NL80211_ATTR_CQM_MAX, cqm,
>> -                              nl80211_attr_cqm_policy, info->extack);
>> +                              NULL, NULL);
>>         if (err)
>>                 return err;
>> 
>> @@ -13405,6 +13417,78 @@ static int nl80211_update_owe_info(struct 
>> sk_buff *skb, struct genl_info *info)
>>         return rdev_update_owe_info(rdev, dev, &owe_info);
>>  }
>> 
>> +static int nl80211_set_sta_mon(struct sk_buff *skb, struct genl_info 
>> *info)
>> +{
>> +       struct cfg80211_registered_device *rdev = info->user_ptr[0];
>> +       struct net_device *dev = info->user_ptr[1];
>> +       struct wireless_dev *wdev = dev->ieee80211_ptr;
>> +       struct nlattr *attrs[NL80211_ATTR_CQM_MAX + 1];
>> +       struct cfg80211_sta_mon sta_mon_config = {};
>> +       struct nlattr *sta_mon;
>> +       u8 *addr = NULL;
>> +       int err;
>> +
>> +       if (wdev->iftype != NL80211_IFTYPE_AP &&
>> +           wdev->iftype != NL80211_IFTYPE_P2P_GO)
>> +               return -ENOTSUPP;
>> +
>> +       wdev_lock(wdev);
>> +       sta_mon = info->attrs[NL80211_ATTR_CQM];
>> +       if (!sta_mon || !info->attrs[NL80211_ATTR_MAC]) {
>> +               err = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       err = nla_parse_nested(attrs, NL80211_ATTR_CQM_MAX, sta_mon,
>> +                              NULL, NULL);
>> +       if (err) {
>> +               err = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
>> +       sta_mon_config.fixed_thold =
>> +               
>> nla_get_flag(info->attrs[NL80211_ATTR_STA_MON_FIXED_THOLD]);
>> +
>> +       if (attrs[NL80211_ATTR_CQM_RSSI_THOLD] &&
>> +           attrs[NL80211_ATTR_CQM_RSSI_HYST]) {
>> +               int len = nla_len(attrs[NL80211_ATTR_CQM_RSSI_THOLD]);
>> +
>> +               sta_mon_config.rssi_tholds =
>> +                       nla_data(attrs[NL80211_ATTR_CQM_RSSI_THOLD]);
>> +               sta_mon_config.rssi_hyst =
>> +                       
>> nla_get_u32(attrs[NL80211_ATTR_CQM_RSSI_HYST]);
>> +
>> +               if (!rdev->ops->set_sta_mon_rssi_config ||
>> +                   !wiphy_ext_feature_isset(&rdev->wiphy,
>> +                                    
>> NL80211_EXT_FEATURE_STA_MON_RSSI_CONFIG)) {
>> +                       err = -EOPNOTSUPP;
>> +                       goto out;
>> +               }
>> +
>> +               if (len % 4) {
>> +                       err = -EINVAL;
>> +                       goto out;
>> +               }
>> +
>> +               sta_mon_config.n_tholds = len / 4;
>> +               err = 
>> nl80211_validate_rssi_tholds(sta_mon_config.rssi_tholds,
>> +                                                  
>> sta_mon_config.n_tholds);
>> +               if (err) {
>> +                       err = -EINVAL;
>> +                       goto out;
>> +               }
>> +
>> +               err = rdev_set_sta_mon_rssi_config(rdev, dev, addr,
>> +                                                  &sta_mon_config);
>> +               goto out;
>> +       }
>> +
>> +out:
>> +       wdev_unlock(wdev);
>> +       return err;
>> +}
>> +
>>  #define NL80211_FLAG_NEED_WIPHY                0x01
>>  #define NL80211_FLAG_NEED_NETDEV       0x02
>>  #define NL80211_FLAG_NEED_RTNL         0x04
>> @@ -14242,6 +14326,13 @@ static void nl80211_post_doit(const struct 
>> genl_ops *ops, struct sk_buff *skb,
>>                 .internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
>>                                   NL80211_FLAG_NEED_RTNL,
>>         },
>> +       {
>> +               .cmd = NL80211_CMD_SET_STA_MON,
>> +               .doit = nl80211_set_sta_mon,
>> +               .flags = GENL_UNS_ADMIN_PERM,
>> +               .internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
>> +                                 NL80211_FLAG_NEED_RTNL,
>> +       },
>>  };
>> 
>>  static struct genl_family nl80211_fam __ro_after_init = {
>> @@ -15443,7 +15534,8 @@ bool cfg80211_rx_control_port(struct 
>> net_device *dev,
>>  EXPORT_SYMBOL(cfg80211_rx_control_port);
>> 
>>  static struct sk_buff *cfg80211_prepare_cqm(struct net_device *dev,
>> -                                           const char *mac, gfp_t 
>> gfp)
>> +                                           const char *mac, gfp_t 
>> gfp,
>> +                                           enum nl80211_commands cmd)
>>  {
>>         struct wireless_dev *wdev = dev->ieee80211_ptr;
>>         struct cfg80211_registered_device *rdev = 
>> wiphy_to_rdev(wdev->wiphy);
>> @@ -15455,7 +15547,7 @@ static struct sk_buff 
>> *cfg80211_prepare_cqm(struct net_device *dev,
>> 
>>         cb = (void **)msg->cb;
>> 
>> -       cb[0] = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_NOTIFY_CQM);
>> +       cb[0] = nl80211hdr_put(msg, 0, 0, 0, cmd);
>>         if (!cb[0]) {
>>                 nlmsg_free(msg);
>>                 return NULL;
>> @@ -15517,7 +15609,7 @@ void cfg80211_cqm_rssi_notify(struct 
>> net_device *dev,
>>                         rssi_level = 
>> wdev->cqm_config->last_rssi_event_value;
>>         }
>> 
>> -       msg = cfg80211_prepare_cqm(dev, NULL, gfp);
>> +       msg = cfg80211_prepare_cqm(dev, NULL, gfp, 
>> NL80211_CMD_NOTIFY_CQM);
>>         if (!msg)
>>                 return;
>> 
>> @@ -15538,13 +15630,48 @@ void cfg80211_cqm_rssi_notify(struct 
>> net_device *dev,
>>  }
>>  EXPORT_SYMBOL(cfg80211_cqm_rssi_notify);
>> 
>> +void
>> +cfg80211_sta_mon_rssi_notify(struct net_device *dev, const u8 *peer,
>> +                            enum nl80211_cqm_rssi_threshold_event 
>> rssi_event,
>> +                            s32 rssi_level, gfp_t gfp)
>> +{
>> +       struct sk_buff *msg;
>> +
>> +       trace_cfg80211_sta_mon_rssi_notify(dev, peer, rssi_event, 
>> rssi_level);
>> +       if (WARN_ON(!peer))
>> +               return;
>> +
>> +       if (WARN_ON(rssi_event != NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW 
>> &&
>> +                   rssi_event != 
>> NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH))
>> +               return;
>> +
>> +       msg = cfg80211_prepare_cqm(dev, peer, gfp, 
>> NL80211_CMD_NOTIFY_STA_MON);
>> +       if (!msg)
>> +               return;
>> +
>> +       if (nla_put_u32(msg, NL80211_ATTR_CQM_RSSI_THRESHOLD_EVENT,
>> +                       rssi_event))
>> +               goto nla_put_failure;
>> +
>> +       if (rssi_level && nla_put_s32(msg, 
>> NL80211_ATTR_CQM_RSSI_LEVEL,
>> +                                     rssi_level))
>> +               goto nla_put_failure;
>> +
>> +       cfg80211_send_cqm(msg, gfp);
>> +       return;
>> +
>> + nla_put_failure:
>> +       nlmsg_free(msg);
>> +}
>> +EXPORT_SYMBOL(cfg80211_sta_mon_rssi_notify);
>> +
>>  void cfg80211_cqm_txe_notify(struct net_device *dev,
>>                              const u8 *peer, u32 num_packets,
>>                              u32 rate, u32 intvl, gfp_t gfp)
>>  {
>>         struct sk_buff *msg;
>> 
>> -       msg = cfg80211_prepare_cqm(dev, peer, gfp);
>> +       msg = cfg80211_prepare_cqm(dev, peer, gfp, 
>> NL80211_CMD_NOTIFY_CQM);
>>         if (!msg)
>>                 return;
>> 
>> @@ -15572,7 +15699,7 @@ void cfg80211_cqm_pktloss_notify(struct 
>> net_device *dev,
>> 
>>         trace_cfg80211_cqm_pktloss_notify(dev, peer, num_packets);
>> 
>> -       msg = cfg80211_prepare_cqm(dev, peer, gfp);
>> +       msg = cfg80211_prepare_cqm(dev, peer, gfp, 
>> NL80211_CMD_NOTIFY_CQM);
>>         if (!msg)
>>                 return;
>> 
>> @@ -15591,7 +15718,7 @@ void cfg80211_cqm_beacon_loss_notify(struct 
>> net_device *dev, gfp_t gfp)
>>  {
>>         struct sk_buff *msg;
>> 
>> -       msg = cfg80211_prepare_cqm(dev, NULL, gfp);
>> +       msg = cfg80211_prepare_cqm(dev, NULL, gfp, 
>> NL80211_CMD_NOTIFY_CQM);
>>         if (!msg)
>>                 return;
>> 
>> diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
>> index 18437a9..8d36745 100644
>> --- a/net/wireless/rdev-ops.h
>> +++ b/net/wireless/rdev-ops.h
>> @@ -1286,4 +1286,17 @@ static inline int rdev_update_owe_info(struct 
>> cfg80211_registered_device *rdev,
>>         return ret;
>>  }
>> 
>> +static inline int
>> +rdev_set_sta_mon_rssi_config(struct cfg80211_registered_device *rdev,
>> +                            struct net_device *dev, const u8 *addr,
>> +                            const struct cfg80211_sta_mon 
>> *sta_mon_config)
>> +{
>> +       int ret = -EOPNOTSUPP;
>> +
>> +       ret = rdev->ops->set_sta_mon_rssi_config(&rdev->wiphy, dev,
>> +                                                addr, 
>> sta_mon_config);
>> +       trace_rdev_return_int(&rdev->wiphy, ret);
>> +       return ret;
>> +}
>> +
>>  #endif /* __CFG80211_RDEV_OPS */
>> diff --git a/net/wireless/trace.h b/net/wireless/trace.h
>> index 488ef2ce..113cd45 100644
>> --- a/net/wireless/trace.h
>> +++ b/net/wireless/trace.h
>> @@ -3421,6 +3421,27 @@
>>                       WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer))
>>  );
>> 
>> +TRACE_EVENT(cfg80211_sta_mon_rssi_notify,
>> +       TP_PROTO(struct net_device *netdev, const u8 *addr,
>> +                enum nl80211_cqm_rssi_threshold_event rssi_event,
>> +                s32 rssi_level),
>> +       TP_ARGS(netdev, addr, rssi_event, rssi_level),
>> +       TP_STRUCT__entry(
>> +               NETDEV_ENTRY
>> +               MAC_ENTRY(addr)
>> +               __field(enum nl80211_cqm_rssi_threshold_event, 
>> rssi_event)
>> +               __field(s32, rssi_level)
>> +       ),
>> +       TP_fast_assign(
>> +               NETDEV_ASSIGN;
>> +               MAC_ASSIGN(addr, addr);
>> +               __entry->rssi_event = rssi_event;
>> +               __entry->rssi_level = rssi_level;
>> +       ),
>> +       TP_printk(NETDEV_PR_FMT ", station mac: " MAC_PR_FMT
>> +                 ", rssi event: %d, level: %d", NETDEV_PR_ARG,
>> +                 MAC_PR_ARG(addr), __entry->rssi_event, 
>> __entry->rssi_level)
>> +);
>>  #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
>> 
>>  #undef TRACE_INCLUDE_PATH
>> --
>> 1.7.9.5
>> 
> 
> Will you continue with that?
> 
Currently not working on this patchset.

> Maybe simple use:
>  - NL80211_CMD_SET_CQM - switch base on info->attrs[NL80211_ATTR_MAC],
> if set assume this is for IFTYPE_AP in other case for IFTYPE_STA
>  - use n_thresolds - and only that on begining
>  - use/extend  - rdev_set_cqm_rssi_range_config (... const u8 *addr ..)
>  - this is what we need rssi_low, rssi_high for AP and sta
> 

It was my first design using NL80211_CMD_SET_CQM and that was not 
accepted by the community.
And I have moved to this design then got the suggestion to go with bpf 
approach.

> Unfortunately for IFTYPE_STATION we are using:  wdev->cqm_config (not
> sure this is really required). Still even that required - can split to
> sta/ap functions ...
> 
> This could be really useful for me. Don't know yet if will handle that
> directly in hostapd or simple will forward this as an event to
> hostapd_cli listeners.
> 

Thanks,
Tamizh.
