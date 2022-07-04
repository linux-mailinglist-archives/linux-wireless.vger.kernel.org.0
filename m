Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D9456522E
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 12:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbiGDK0B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 06:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiGDKZk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 06:25:40 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9644711173
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 03:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656930256; x=1688466256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=iXM8+wzxpHBX7tWTfApBS8Lo/t8rOP/V6VAcMB5qOQo=;
  b=S+Vmb98zFu9z2d3NJ+r6MFfcN3pu75Jpm6CR3OtdI8v584mg0HJSGTtB
   qNw1mVh7r8K3jsmReGMO8yx2ZyafpCdf+18ZlOkEyJzGDRvzG+akuIAw9
   CVCJVLcWCps8b0agWDvLLi8Pm1YEKpylOa2OpQt1VPlz8N8/p9gZOW1nC
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Jul 2022 03:24:15 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 03:24:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 03:24:15 -0700
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 03:24:13 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH 6/7] cfg80211: rework nl80211_parse_chandef for 6 GHz
Date:   Mon, 4 Jul 2022 15:53:40 +0530
Message-ID: <20220704102341.5692-7-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704102341.5692-1-quic_adisi@quicinc.com>
References: <20220704102341.5692-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 include/net/cfg80211.h  |  4 +++
 net/mac80211/cfg.c      | 35 ++++++++++++++++++++++++
 net/wireless/nl80211.c  | 59 +++++++++++++++++++++++++++++------------
 net/wireless/nl80211.h  |  3 ++-
 net/wireless/pmsr.c     |  8 +++---
 net/wireless/rdev-ops.h | 19 +++++++++++++
 net/wireless/trace.h    | 21 +++++++++++++++
 7 files changed, 128 insertions(+), 21 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 21c058bec5fe..df493feb6d89 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4238,6 +4238,8 @@ struct mgmt_frame_regs {
  *	radar channel.
  *	The caller is expected to set chandef pointer to NULL in order to
  *	disable background CAC/radar detection.
+ *
+ * @get_6ghz_power_mode: Get the 6 GHz power mode for the given interface.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4583,6 +4585,8 @@ struct cfg80211_ops {
 				struct cfg80211_fils_aad *fils_aad);
 	int	(*set_radar_background)(struct wiphy *wiphy,
 					struct cfg80211_chan_def *chandef);
+	int     (*get_6ghz_power_mode)(struct wireless_dev *wdev,
+				       enum nl80211_regulatory_power_modes *power_mode_6ghz);
 };
 
 /*
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index fd6c4291c971..4962f9b5917f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4549,6 +4549,40 @@ static void ieee80211_del_intf_link(struct wiphy *wiphy,
 	ieee80211_vif_set_links(sdata, wdev->valid_links);
 }
 
+static int
+ieee80211_get_6ghz_power_mode(struct wireless_dev *wdev,
+			      enum nl80211_regulatory_power_modes *power_mode_6ghz)
+{
+	enum nl80211_iftype iftype;
+	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_vif vif;
+
+	if (!wdev)
+		return 1;
+
+	iftype = wdev->iftype;
+
+	/* For APs, 6 GHz power mode is taken from the user configured
+	 * value. However, for clients, power mode is also dependent
+	 * upon the APs power mode to which this client has associated.
+	 * Hence for client, need to take power mode of asscoiated AP,
+	 * which is present in beacon data.
+	 */
+	if (iftype == NL80211_IFTYPE_AP) {
+		*power_mode_6ghz =
+			ieee80211_ap_reg_power_to_reg_power_mode(wdev->ap_6ghz_power);
+	} else if (iftype == NL80211_IFTYPE_STATION) {
+		sdata = container_of(wdev, struct ieee80211_sub_if_data, wdev);
+		vif = sdata->vif;
+
+		*power_mode_6ghz =
+		  ieee80211_client_reg_power_to_reg_power_mode(wdev->client_6ghz_power,
+							       vif.bss_conf.power_type);
+	}
+
+	return 0;
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -4656,4 +4690,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.set_radar_background = ieee80211_set_radar_background,
 	.add_intf_link = ieee80211_add_intf_link,
 	.del_intf_link = ieee80211_del_intf_link,
+	.get_6ghz_power_mode = ieee80211_get_6ghz_power_mode,
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4d5c45f303ec..915516bd4d93 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3163,10 +3163,12 @@ static bool nl80211_can_set_dev_channel(struct wireless_dev *wdev)
 
 int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 			  struct genl_info *info,
-			  struct cfg80211_chan_def *chandef)
+			  struct cfg80211_chan_def *chandef,
+			  struct wireless_dev *wdev)
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct nlattr **attrs = info->attrs;
+	enum nl80211_regulatory_power_modes power_mode_6ghz = NL80211_REG_AP_LPI;
 	u32 control_freq;
 
 	if (!attrs[NL80211_ATTR_WIPHY_FREQ])
@@ -3179,7 +3181,26 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 		    nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET]);
 
 	memset(chandef, 0, sizeof(*chandef));
-	chandef->chan = ieee80211_get_channel_khz(&rdev->wiphy, control_freq);
+
+	if (control_freq >= MHZ_TO_KHZ(5945) && control_freq <= MHZ_TO_KHZ(7125)) {
+		if (!wdev)
+			return -EINVAL;
+
+		if (!rdev->ops->get_6ghz_power_mode)
+			return -EINVAL;
+
+		power_mode_6ghz = rdev_get_6ghz_power_mode(rdev, wdev);
+
+		if (power_mode_6ghz >= NL80211_REG_MAX_POWER_MODES + 1)
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
@@ -3310,7 +3331,7 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 		link_id = 0;
 	}
 
-	result = nl80211_parse_chandef(rdev, info, &chandef);
+	result = nl80211_parse_chandef(rdev, info, &chandef, wdev);
 	if (result)
 		return result;
 
@@ -5786,7 +5807,8 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
-		err = nl80211_parse_chandef(rdev, info, &params->chandef);
+		err = nl80211_parse_chandef(rdev, info, &params->chandef,
+					    wdev);
 		if (err)
 			goto out;
 	} else if (wdev->valid_links) {
@@ -9580,7 +9602,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	if (dfs_region == NL80211_DFS_UNSET)
 		goto unlock;
 
-	err = nl80211_parse_chandef(rdev, info, &chandef);
+	err = nl80211_parse_chandef(rdev, info, &chandef, wdev);
 	if (err)
 		goto unlock;
 
@@ -9660,7 +9682,7 @@ static int nl80211_notify_radar_detection(struct sk_buff *skb,
 		return -EINVAL;
 	}
 
-	err = nl80211_parse_chandef(rdev, info, &chandef);
+	err = nl80211_parse_chandef(rdev, info, &chandef, wdev);
 	if (err) {
 		GENL_SET_ERR_MSG(info, "Unable to extract chandef info");
 		return err;
@@ -9858,7 +9880,7 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	}
 
 skip_beacons:
-	err = nl80211_parse_chandef(rdev, info, &params.chandef);
+	err = nl80211_parse_chandef(rdev, info, &params.chandef, wdev);
 	if (err)
 		goto free;
 
@@ -10903,6 +10925,7 @@ static int nl80211_join_ibss(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_ibss_params ibss;
 	struct wiphy *wiphy;
 	struct cfg80211_cached_keys *connkeys = NULL;
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err;
 
 	memset(&ibss, 0, sizeof(ibss));
@@ -10925,7 +10948,7 @@ static int nl80211_join_ibss(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->join_ibss)
 		return -EOPNOTSUPP;
 
-	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_ADHOC)
+	if (wdev->iftype != NL80211_IFTYPE_ADHOC)
 		return -EOPNOTSUPP;
 
 	wiphy = &rdev->wiphy;
@@ -10944,7 +10967,7 @@ static int nl80211_join_ibss(struct sk_buff *skb, struct genl_info *info)
 		ibss.ie_len = nla_len(info->attrs[NL80211_ATTR_IE]);
 	}
 
-	err = nl80211_parse_chandef(rdev, info, &ibss.chandef);
+	err = nl80211_parse_chandef(rdev, info, &ibss.chandef, wdev);
 	if (err)
 		return err;
 
@@ -11043,13 +11066,13 @@ static int nl80211_join_ibss(struct sk_buff *skb, struct genl_info *info)
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
+		 wdev->conn_owner_nlportid = info->snd_portid;
+	wdev_unlock(wdev);
 
 	return err;
 }
@@ -11918,7 +11941,7 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 	    duration > rdev->wiphy.max_remain_on_channel_duration)
 		return -EINVAL;
 
-	err = nl80211_parse_chandef(rdev, info, &chandef);
+	err = nl80211_parse_chandef(rdev, info, &chandef, wdev);
 	if (err)
 		return err;
 
@@ -12132,7 +12155,7 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	 */
 	chandef.chan = NULL;
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
-		err = nl80211_parse_chandef(rdev, info, &chandef);
+		err = nl80211_parse_chandef(rdev, info, &chandef, wdev);
 		if (err)
 			return err;
 	}
@@ -12525,7 +12548,8 @@ static int nl80211_join_ocb(struct sk_buff *skb, struct genl_info *info)
 	struct ocb_setup setup = {};
 	int err;
 
-	err = nl80211_parse_chandef(rdev, info, &setup.chandef);
+	err = nl80211_parse_chandef(rdev, info, &setup.chandef,
+				    dev->ieee80211_ptr);
 	if (err)
 		return err;
 
@@ -12600,7 +12624,8 @@ static int nl80211_join_mesh(struct sk_buff *skb, struct genl_info *info)
 		cfg.auto_open_plinks = false;
 
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
-		err = nl80211_parse_chandef(rdev, info, &setup.chandef);
+		err = nl80211_parse_chandef(rdev, info, &setup.chandef,
+					    dev->ieee80211_ptr);
 		if (err)
 			return err;
 	} else {
@@ -14933,7 +14958,7 @@ static int nl80211_tdls_channel_switch(struct sk_buff *skb,
 	    !info->attrs[NL80211_ATTR_OPER_CLASS])
 		return -EINVAL;
 
-	err = nl80211_parse_chandef(rdev, info, &chandef);
+	err = nl80211_parse_chandef(rdev, info, &chandef, wdev);
 	if (err)
 		return err;
 
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index d642e3be4ee7..76e95e6b4c11 100644
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
index a329ba036989..4dac065c55ed 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1448,4 +1448,23 @@ rdev_del_intf_link(struct cfg80211_registered_device *rdev,
 	trace_rdev_return_void(&rdev->wiphy);
 }
 
+static inline enum nl80211_regulatory_power_modes
+rdev_get_6ghz_power_mode(struct cfg80211_registered_device *rdev,
+			 struct wireless_dev *wdev)
+{
+	enum nl80211_regulatory_power_modes power_mode_6ghz = NL80211_REG_AP_LPI;
+	int ret;
+
+	if (!rdev->ops->get_6ghz_power_mode)
+		return NL80211_REG_MAX_POWER_MODES + 1;
+
+	trace_rdev_get_6ghz_power_mode(&rdev->wiphy, wdev);
+	ret = rdev->ops->get_6ghz_power_mode(wdev, &power_mode_6ghz);
+	trace_rdev_return_6ghz_power_mode(wdev, ret, power_mode_6ghz);
+
+	if (ret)
+		return NL80211_REG_MAX_POWER_MODES + 1;
+
+	return power_mode_6ghz;
+}
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 65f8b814ecd0..9308efde3cb2 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3775,6 +3775,27 @@ TRACE_EVENT(cfg80211_assoc_comeback,
 		  WDEV_PR_ARG, MAC_PR_ARG(bssid), __entry->timeout)
 );
 
+DEFINE_EVENT(wiphy_wdev_evt, rdev_get_6ghz_power_mode,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev),
+	TP_ARGS(wiphy, wdev)
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
+	TP_printk(WDEV_PR_FMT ", function returns: %d, function filled: %d",
+		  WDEV_PR_ARG, __entry->ret, __entry->power_mode)
+);
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.17.1

