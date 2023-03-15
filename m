Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016066BB49F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 14:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjCON3p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 09:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjCON3j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 09:29:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE3188ECB
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 06:29:36 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FALwjS010975;
        Wed, 15 Mar 2023 13:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=pqAWvxlqR0vpcGaNhENl63U35Eyf/xUYOLVNkQ6ttkU=;
 b=aQWPWa5FXDwscjZyNvEf/pbY70XEGxNpqvIbmkni0WmQvq0WlEVqwiYX11jIlORKb54B
 CyujWVnaZJI418rD9wrx20x/mQM4dN1JA6nTX61coa6MYXlLw33iDAjMVO+3G34q7n7B
 rW7ccoBPj8KM8BZ8kGZDUwmD5zFZOSGwunW8kBl5SdtuiaEG/ujdKUz6Z4LLVVwQstxJ
 b94/WbuLbbPQlCCMAw+l99Diphys/jGhWZITPn7dIzwrdMtrlmBTkGYzoJxbBL2IKPly
 gZOHnxUaonTOFk544AQr94MVV9xWj7WgLbO3gB3zxM2y4KsVnzmp75HGxQKyrl6rXBGK VQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2c2sm0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FDTWXr023757
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:32 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 15 Mar 2023 06:29:30 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v3 6/9] wifi: cfg80211: rework nl80211_parse_chandef for 6 GHz
Date:   Wed, 15 Mar 2023 18:59:01 +0530
Message-ID: <20230315132904.31779-7-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230315132904.31779-1-quic_adisi@quicinc.com>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QaAj9NncjBFNCh9YIRqBy4_1R7XQESB1
X-Proofpoint-ORIG-GUID: QaAj9NncjBFNCh9YIRqBy4_1R7XQESB1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_06,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150114
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, nl80211_parse_chandef function just selects a
channel based on the control frequency provided. However,
for 6 GHz, power mode also needs to be considered since
6 GHz has got multiple channel pools based on the power
mode.

Modify logic to consider power mode as well for 6 GHz
interface and accordingly select the channel for the
given control frequency.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/net/cfg80211.h     |  9 ++++++
 net/mac80211/cfg.c         | 41 +++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  3 ++
 net/wireless/nl80211.c     | 57 ++++++++++++++++++++++++++------------
 net/wireless/nl80211.h     |  3 +-
 net/wireless/pmsr.c        |  8 ++++--
 net/wireless/rdev-ops.h    | 21 ++++++++++++++
 net/wireless/trace.h       | 34 +++++++++++++++++++++++
 8 files changed, 155 insertions(+), 21 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fa2c0551e3da..0120a520c58e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -512,6 +512,10 @@ struct ieee80211_sta_s1g_cap {
 	u8 nss_mcs[5];
 };
 
+#define is_6ghz_freq_khz(freq) \
+			(freq >= MHZ_TO_KHZ(5945) && freq <= MHZ_TO_KHZ(7125))
+#define is_6ghz_freq(freq)     is_6ghz_freq_khz(MHZ_TO_KHZ(freq))
+
 /**
  * struct ieee80211_channel_6ghz - 6 GHz channel definitions
  *
@@ -4367,6 +4371,8 @@ struct mgmt_frame_regs {
  * @del_link_station: Remove a link of a station.
  *
  * @set_hw_timestamp: Enable/disable HW timestamping of TM/FTM frames.
+ *
+ * @get_6ghz_power_mode: Get the 6 GHz power mode for the given interface.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4722,6 +4728,9 @@ struct cfg80211_ops {
 				    struct link_station_del_parameters *params);
 	int	(*set_hw_timestamp)(struct wiphy *wiphy, struct net_device *dev,
 				    struct cfg80211_set_hw_timestamp *hwts);
+	int     (*get_6ghz_power_mode)(struct wireless_dev *wdev,
+				       unsigned int link_id,
+				       enum nl80211_regulatory_power_modes *power_mode);
 };
 
 /*
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 760ad934f9e1..9af1e31bdc91 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4947,6 +4947,46 @@ static int ieee80211_set_hw_timestamp(struct wiphy *wiphy,
 	return local->ops->set_hw_timestamp(&local->hw, &sdata->vif, hwts);
 }
 
+int
+ieee80211_get_6ghz_power_mode(struct wireless_dev *wdev,
+			      unsigned int link_id,
+			      enum nl80211_regulatory_power_modes *power_mode_6ghz)
+{
+	enum nl80211_iftype iftype;
+	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_vif vif;
+	enum ieee80211_ap_reg_power power_mode_6ghz_ap;
+	enum ieee80211_client_reg_power power_mode_6ghz_client;
+
+	if (!wdev)
+		return -EINVAL;
+
+	iftype = wdev->iftype;
+
+	/* For APs, 6 GHz power mode is taken from the user configured
+	 * value. However, for clients, power mode is also dependent
+	 * upon the APs power mode to which this client has associated.
+	 * Hence for client, need to take power mode of associated AP,
+	 * which is present in beacon data.
+	 */
+	if (iftype == NL80211_IFTYPE_AP) {
+		power_mode_6ghz_ap = wdev->links[link_id].ap.power_mode_6ghz;
+		*power_mode_6ghz =
+			ieee80211_ap_reg_power_to_reg_power_mode(power_mode_6ghz_ap);
+	} else if (iftype == NL80211_IFTYPE_STATION) {
+		sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+		vif = sdata->vif;
+		power_mode_6ghz_client = wdev->links[link_id].client.power_mode_6ghz;
+		*power_mode_6ghz =
+		  ieee80211_client_reg_power_to_reg_power_mode(power_mode_6ghz_client,
+							       vif.bss_conf.power_type);
+	} else {
+		*power_mode_6ghz = NL80211_REG_PWR_MODE_AP_LPI;
+	}
+
+	return 0;
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -5058,4 +5098,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.mod_link_station = ieee80211_mod_link_station,
 	.del_link_station = ieee80211_del_link_station,
 	.set_hw_timestamp = ieee80211_set_hw_timestamp,
+	.get_6ghz_power_mode = ieee80211_get_6ghz_power_mode,
 };
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3d4edc25a69e..1a82fc9c0f1f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2572,4 +2572,7 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
 				    u8 eht_cap_len,
 				    struct link_sta_info *link_sta);
+int ieee80211_get_6ghz_power_mode(struct wireless_dev *wdev,
+				  unsigned int link_id,
+				  enum nl80211_regulatory_power_modes *power_mode_6ghz);
 #endif /* IEEE80211_I_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 36cb4574145c..042035f26e9f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3208,10 +3208,13 @@ static int nl80211_parse_punct_bitmap(struct cfg80211_registered_device *rdev,
 
 int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 			  struct genl_info *info,
-			  struct cfg80211_chan_def *chandef)
+			  struct cfg80211_chan_def *chandef,
+			  struct wireless_dev *wdev)
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct nlattr **attrs = info->attrs;
+	enum nl80211_regulatory_power_modes power_mode_6ghz;
+	unsigned int link_id = nl80211_link_id(info->attrs);
 	u32 control_freq;
 
 	if (!attrs[NL80211_ATTR_WIPHY_FREQ]) {
@@ -3227,7 +3230,23 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 		    nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET]);
 
 	memset(chandef, 0, sizeof(*chandef));
-	chandef->chan = ieee80211_get_channel_khz(&rdev->wiphy, control_freq);
+
+	if (is_6ghz_freq_khz(control_freq)) {
+		if (!wdev)
+			return -EINVAL;
+
+		power_mode_6ghz = rdev_get_6ghz_power_mode(rdev, wdev, link_id);
+
+		if (power_mode_6ghz >= NL80211_REG_PWR_MODE_MAX)
+			return -EINVAL;
+
+		chandef->chan = ieee80211_get_6ghz_channel_khz(&rdev->wiphy,
+							       control_freq,
+							       power_mode_6ghz);
+	} else {
+		chandef->chan = ieee80211_get_channel_khz(&rdev->wiphy, control_freq);
+	}
+
 	chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
 	chandef->center_freq1 = KHZ_TO_MHZ(control_freq);
 	chandef->freq1_offset = control_freq % 1000;
@@ -3358,7 +3377,7 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 		link_id = 0;
 	}
 
-	result = nl80211_parse_chandef(rdev, info, &chandef);
+	result = nl80211_parse_chandef(rdev, info, &chandef, wdev);
 	if (result)
 		return result;
 
@@ -5976,7 +5995,8 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
-		err = nl80211_parse_chandef(rdev, info, &params->chandef);
+		err = nl80211_parse_chandef(rdev, info, &params->chandef,
+					    wdev);
 		if (err)
 			goto out;
 	} else if (wdev->valid_links) {
@@ -9865,7 +9885,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	if (dfs_region == NL80211_DFS_UNSET)
 		goto unlock;
 
-	err = nl80211_parse_chandef(rdev, info, &chandef);
+	err = nl80211_parse_chandef(rdev, info, &chandef, wdev);
 	if (err)
 		goto unlock;
 
@@ -9945,7 +9965,7 @@ static int nl80211_notify_radar_detection(struct sk_buff *skb,
 		return -EINVAL;
 	}
 
-	err = nl80211_parse_chandef(rdev, info, &chandef);
+	err = nl80211_parse_chandef(rdev, info, &chandef, wdev);
 	if (err) {
 		GENL_SET_ERR_MSG(info, "Unable to extract chandef info");
 		return err;
@@ -10143,7 +10163,7 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	}
 
 skip_beacons:
-	err = nl80211_parse_chandef(rdev, info, &params.chandef);
+	err = nl80211_parse_chandef(rdev, info, &params.chandef, wdev);
 	if (err)
 		goto free;
 
@@ -11236,6 +11256,7 @@ static int nl80211_join_ibss(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_ibss_params ibss;
 	struct wiphy *wiphy;
 	struct cfg80211_cached_keys *connkeys = NULL;
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err;
 
 	memset(&ibss, 0, sizeof(ibss));
@@ -11258,7 +11279,7 @@ static int nl80211_join_ibss(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->join_ibss)
 		return -EOPNOTSUPP;
 
-	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_ADHOC)
+	if (wdev->iftype != NL80211_IFTYPE_ADHOC)
 		return -EOPNOTSUPP;
 
 	wiphy = &rdev->wiphy;
@@ -11277,7 +11298,7 @@ static int nl80211_join_ibss(struct sk_buff *skb, struct genl_info *info)
 		ibss.ie_len = nla_len(info->attrs[NL80211_ATTR_IE]);
 	}
 
-	err = nl80211_parse_chandef(rdev, info, &ibss.chandef);
+	err = nl80211_parse_chandef(rdev, info, &ibss.chandef, wdev);
 	if (err)
 		return err;
 
@@ -11376,13 +11397,13 @@ static int nl80211_join_ibss(struct sk_buff *skb, struct genl_info *info)
 	ibss.userspace_handles_dfs =
 		nla_get_flag(info->attrs[NL80211_ATTR_HANDLE_DFS]);
 
-	wdev_lock(dev->ieee80211_ptr);
+	wdev_lock(wdev);
 	err = __cfg80211_join_ibss(rdev, dev, &ibss, connkeys);
 	if (err)
 		kfree_sensitive(connkeys);
 	else if (info->attrs[NL80211_ATTR_SOCKET_OWNER])
-		dev->ieee80211_ptr->conn_owner_nlportid = info->snd_portid;
-	wdev_unlock(dev->ieee80211_ptr);
+		wdev->conn_owner_nlportid = info->snd_portid;
+	wdev_unlock(wdev);
 
 	return err;
 }
@@ -12248,7 +12269,7 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 	    duration > rdev->wiphy.max_remain_on_channel_duration)
 		return -EINVAL;
 
-	err = nl80211_parse_chandef(rdev, info, &chandef);
+	err = nl80211_parse_chandef(rdev, info, &chandef, wdev);
 	if (err)
 		return err;
 
@@ -12470,7 +12491,7 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	 */
 	chandef.chan = NULL;
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
-		err = nl80211_parse_chandef(rdev, info, &chandef);
+		err = nl80211_parse_chandef(rdev, info, &chandef, wdev);
 		if (err)
 			return err;
 	}
@@ -12879,7 +12900,8 @@ static int nl80211_join_ocb(struct sk_buff *skb, struct genl_info *info)
 	struct ocb_setup setup = {};
 	int err;
 
-	err = nl80211_parse_chandef(rdev, info, &setup.chandef);
+	err = nl80211_parse_chandef(rdev, info, &setup.chandef,
+				    dev->ieee80211_ptr);
 	if (err)
 		return err;
 
@@ -12954,7 +12976,8 @@ static int nl80211_join_mesh(struct sk_buff *skb, struct genl_info *info)
 		cfg.auto_open_plinks = false;
 
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
-		err = nl80211_parse_chandef(rdev, info, &setup.chandef);
+		err = nl80211_parse_chandef(rdev, info, &setup.chandef,
+					    dev->ieee80211_ptr);
 		if (err)
 			return err;
 	} else {
@@ -15291,7 +15314,7 @@ static int nl80211_tdls_channel_switch(struct sk_buff *skb,
 	    !info->attrs[NL80211_ATTR_OPER_CLASS])
 		return -EINVAL;
 
-	err = nl80211_parse_chandef(rdev, info, &chandef);
+	err = nl80211_parse_chandef(rdev, info, &chandef, wdev);
 	if (err)
 		return err;
 
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index 0278d817bb02..24966630ba27 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -24,7 +24,8 @@ static inline u64 wdev_id(struct wireless_dev *wdev)
 
 int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 			  struct genl_info *info,
-			  struct cfg80211_chan_def *chandef);
+			  struct cfg80211_chan_def *chandef,
+			  struct wireless_dev *wdev);
 int nl80211_parse_random_mac(struct nlattr **attrs,
 			     u8 *mac_addr, u8 *mac_addr_mask);
 
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 2bc647720cda..501b8af547e1 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -184,7 +184,8 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 			   struct nlattr *peer,
 			   struct cfg80211_pmsr_request_peer *out,
-			   struct genl_info *info)
+			   struct genl_info *info,
+			   struct wireless_dev *wdev)
 {
 	struct nlattr *tb[NL80211_PMSR_PEER_ATTR_MAX + 1];
 	struct nlattr *req[NL80211_PMSR_REQ_ATTR_MAX + 1];
@@ -213,7 +214,7 @@ static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 	if (err)
 		return err;
 
-	err = nl80211_parse_chandef(rdev, info, &out->chandef);
+	err = nl80211_parse_chandef(rdev, info, &out->chandef, wdev);
 	if (err)
 		return err;
 
@@ -316,7 +317,8 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 	idx = 0;
 	nla_for_each_nested(peer, peers, rem) {
 		/* NB: this reuses info->attrs, but we no longer need it */
-		err = pmsr_parse_peer(rdev, peer, &req->peers[idx], info);
+		err = pmsr_parse_peer(rdev, peer, &req->peers[idx], info,
+				      wdev);
 		if (err)
 			goto out_err;
 		idx++;
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 2e497cf26ef2..b2c8b92789cd 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1511,4 +1511,25 @@ rdev_set_hw_timestamp(struct cfg80211_registered_device *rdev,
 
 	return ret;
 }
+
+static inline enum nl80211_regulatory_power_modes
+rdev_get_6ghz_power_mode(struct cfg80211_registered_device *rdev,
+			 struct wireless_dev *wdev,
+			 unsigned int link_id)
+{
+	enum nl80211_regulatory_power_modes power_mode_6ghz;
+	int ret;
+
+	if (!rdev->ops->get_6ghz_power_mode)
+		return NL80211_REG_PWR_MODE_MAX;
+
+	trace_rdev_get_6ghz_power_mode(&rdev->wiphy, wdev, link_id);
+	ret = rdev->ops->get_6ghz_power_mode(wdev, link_id, &power_mode_6ghz);
+	trace_rdev_return_6ghz_power_mode(wdev, ret, power_mode_6ghz);
+
+	if (ret)
+		return NL80211_REG_PWR_MODE_MAX;
+
+	return power_mode_6ghz;
+}
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 716a1fa70069..f9595f86fc08 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3946,6 +3946,40 @@ TRACE_EVENT(rdev_set_hw_timestamp,
 		  __entry->enable)
 );
 
+TRACE_EVENT(rdev_get_6ghz_power_mode,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
+		 unsigned int link_id),
+	TP_ARGS(wiphy, wdev, link_id),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		WDEV_ENTRY
+		__field(u32, link_id)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		WDEV_ASSIGN;
+		__entry->link_id = params->link_id;
+	),
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", link_id: %u",
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->link_id)
+);
+
+TRACE_EVENT(rdev_return_6ghz_power_mode,
+	TP_PROTO(struct wireless_dev *wdev, int ret, u8 power_mode),
+	TP_ARGS(wdev, ret, power_mode),
+	TP_STRUCT__entry(
+		WDEV_ENTRY
+		__field(u8, ret)
+		__field(u8, power_mode)
+	),
+	TP_fast_assign(
+		WDEV_ASSIGN;
+		__entry->ret = ret;
+		__entry->power_mode = power_mode;
+	),
+	TP_printk(WDEV_PR_FMT ", ret: %d, power_mode: %d",
+		  WDEV_PR_ARG, __entry->ret, __entry->power_mode)
+);
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.17.1

