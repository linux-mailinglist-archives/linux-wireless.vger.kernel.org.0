Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B431B4E6DF9
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354865AbiCYGBs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbiCYGBr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:01:47 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3295DC681C
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648188013; x=1679724013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jxW0AKNyMc0aaceNpt/Bp4wX4PU42zG88qxxLK0hLxY=;
  b=lfQfTdALOV3qEZ6w7ardhx57fblS+/8juQ1G9rEfyuL04taCpnEYb05F
   OTVvCzVPjTy82UKWYwMB9Dqo8bCNTvzT5D+xXMP2TRFX6mv8X3vNkFBEN
   UTDfQNiZaK7murjooTBqVod5iGlhgmAIdUPQFiIgJeu+kIuD0C6wdBACH
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Mar 2022 23:00:13 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 23:00:13 -0700
Received: from che-siroccolnx03.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 23:00:11 -0700
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
To:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Subject: [PATCH v6 1/3] nl80211: Add support for beacon tx mode
Date:   Fri, 25 Mar 2022 11:29:47 +0530
Message-ID: <20220325055949.3035053-2-quic_mkenna@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325055949.3035053-1-quic_mkenna@quicinc.com>
References: <20220325055949.3035053-1-quic_mkenna@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

User can configure the below beacon tx mode
1. Staggered mode and 2. Burst mode while bring-up the AP
or MESH.

Beacons can be sent out in burst(continuously in a single shot
one after another) or staggered (equally spread out over beacon
interval) mode.

Set the beacon_tx_mode as 1 for Staggered mode and 2 for
burst mode.

Hence, added the support in the nl80211/cfg80211
layer to honour the beacon tx mode configuration and pass
this value to the driver.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00630-QCAHKSWPL_SILICONZ-2

Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
---
V6: Addressed Jeff's comment on v5 patch.

V5: Addressed Johannes's & Felix's comments on v4 patch.

V4: Rebases on latest ath.git TOT.

V3: Addressed Johnson's comment on v2 patch.

V2: Addressed Johannes's comment on v1 patch.

 include/net/cfg80211.h       |  4 ++++
 include/uapi/linux/nl80211.h | 21 +++++++++++++++++++++
 net/wireless/nl80211.c       | 11 +++++++++++
 3 files changed, 36 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 68713388b617..4f4839ebcce6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1297,6 +1297,7 @@ struct cfg80211_unsol_bcast_probe_resp {
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  * @mbssid_config: AP settings for multiple bssid
+ * @beacon_tx_mode: Beacon Tx Mode setting
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1330,6 +1331,7 @@ struct cfg80211_ap_settings {
 	struct cfg80211_fils_discovery fils_discovery;
 	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 	struct cfg80211_mbssid_config mbssid_config;
+	enum nl80211_beacon_tx_mode beacon_tx_mode;
 };
 
 /**
@@ -2211,6 +2213,7 @@ struct mesh_config {
  *	to operate on DFS channels.
  * @control_port_over_nl80211: TRUE if userspace expects to exchange control
  *	port frames over NL80211 instead of the network interface.
+ * @beacon_tx_mode: Beacon Tx Mode setting.
  *
  * These parameters are fixed when the mesh is created.
  */
@@ -2234,6 +2237,7 @@ struct mesh_setup {
 	struct cfg80211_bitrate_mask beacon_rate;
 	bool userspace_handles_dfs;
 	bool control_port_over_nl80211;
+	enum nl80211_beacon_tx_mode beacon_tx_mode;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0568a79097b8..42712ffc6d16 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2663,6 +2663,13 @@ enum nl80211_commands {
  *	association request when used with NL80211_CMD_NEW_STATION). Can be set
  *	only if %NL80211_STA_FLAG_WME is set.
  *
+ * @NL80211_ATTR_BEACON_TX_MODE: used to configure the beacon tx mode (u32),
+ *	as specified in the &enum nl80211_beacon_tx_mode. The user-space
+ *	can use this attribute to configure the tx mode of beacons.
+ *	Beacons can be sent out in burst(continuously in a single shot
+ *	one after another) or staggered (equally spread out over beacon
+ *	interval) mode.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3175,6 +3182,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_EHT_CAPABILITY,
 
+	NL80211_ATTR_BEACON_TX_MODE,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7600,4 +7609,16 @@ enum nl80211_ap_settings_flags {
 	NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT	= 1 << 1,
 };
 
+/**
+ * enum nl80211_beacon_tx_mode - Beacon Tx Mode enum.
+ * @NL80211_BEACON_STAGGERED_MODE: Used to configure beacon tx mode as
+ *	staggered mode. This is the default beacon tx mode.
+ * @NL80211_BEACON_BURST_MODE: Used to configure beacon tx mode as burst mode.
+ */
+enum nl80211_beacon_tx_mode {
+	NL80211_BEACON_DEFAULT_MODE = 0,
+	NL80211_BEACON_STAGGERED_MODE = 1,
+	NL80211_BEACON_BURST_MODE = 2,
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ee1c2b6b6971..ccb4b486da1e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -790,6 +790,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_RANGE(NLA_BINARY,
 				 NL80211_EHT_MIN_CAPABILITY_LEN,
 				 NL80211_EHT_MAX_CAPABILITY_LEN),
+	[NL80211_ATTR_BEACON_TX_MODE] =
+		NLA_POLICY_RANGE(NLA_U32, NL80211_BEACON_STAGGERED_MODE,
+				 NL80211_BEACON_BURST_MODE),
 };
 
 /* policy for the key attributes */
@@ -5555,6 +5558,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	params->dtim_period =
 		nla_get_u32(info->attrs[NL80211_ATTR_DTIM_PERIOD]);
 
+	if (info->attrs[NL80211_ATTR_BEACON_TX_MODE])
+		params->beacon_tx_mode =
+			nla_get_u32(info->attrs[NL80211_ATTR_BEACON_TX_MODE]);
+
 	err = cfg80211_validate_beacon_int(rdev, dev->ieee80211_ptr->iftype,
 					   params->beacon_interval);
 	if (err)
@@ -12235,6 +12242,10 @@ static int nl80211_join_mesh(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 	}
 
+	if (info->attrs[NL80211_ATTR_BEACON_TX_MODE])
+		setup.beacon_tx_mode =
+			nla_get_u32(info->attrs[NL80211_ATTR_BEACON_TX_MODE]);
+
 	if (info->attrs[NL80211_ATTR_MESH_SETUP]) {
 		/* parse additional setup parameters if given */
 		err = nl80211_parse_mesh_setup(info, &setup);
-- 
2.25.1

