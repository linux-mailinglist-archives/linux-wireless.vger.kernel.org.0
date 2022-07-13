Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB7457332A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiGMJpS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbiGMJpL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3F3ED167
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=V+8oV33ekGwZYMeIwC2pwfq4cMK8Qs3T3k9zkojDWdQ=;
        t=1657705508; x=1658915108; b=yNqAsIsmiL8N77WI8xtMiDdE7oEshKImeA5ApuieENiQLjB
        k7Bz/3ZV/uPp2xT9QGAQL5flDN9JgG9igy56K7fkncPQlzKaaSIIIimjjtdgcL85QJ1kIqUaW+Zgl
        GyrrpEbWGKiPUFdNNtpLCN6kOtw+y11gC6Hac6yv9m50d3UxZzUFPAL/ioNnVqA5UBvy+yjeuWpe2
        WGRbseQD9lRFXkabyEOr/XQAjTjNNFYQmAcQ2k8csFi+jvVx+oAzFc8+txTXvBf072vCF6CBBs08V
        sQaibovM3V4CzBWUWiAR0Ktn5nFSLAMdPUi7H6aY7PKMDx+DWKivejNct2c+6RnA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYva-00EgvB-Pc;
        Wed, 13 Jul 2022 11:45:06 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 08/76] wifi: cfg80211: add API to add/modify/remove a link station
Date:   Wed, 13 Jul 2022 11:43:54 +0200
Message-Id: <20220713114425.d11127e6a9ea.I96baaf4c4c2964ca753271f26e02d05ab0e5e98c@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

Add an API for adding/modifying/removing a link of a station.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       |  64 +++++++++++++
 include/uapi/linux/nl80211.h |   8 ++
 net/wireless/nl80211.c       | 168 +++++++++++++++++++++++++++++++++--
 net/wireless/rdev-ops.h      |  48 ++++++++++
 net/wireless/trace.h         |  97 ++++++++++++++++++++
 5 files changed, 377 insertions(+), 8 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 140354f5f15b..a26d738a2f52 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1456,6 +1456,61 @@ struct sta_txpwr {
 	enum nl80211_tx_power_setting type;
 };
 
+/**
+ * struct link_station_parameters - link station parameters
+ *
+ * Used to change and create a new link station.
+ *
+ * @mld_mac: MAC address of the station
+ * @link_id: the link id (-1 for non-MLD station)
+ * @link_mac: MAC address of the link
+ * @supported_rates: supported rates in IEEE 802.11 format
+ *	(or NULL for no change)
+ * @supported_rates_len: number of supported rates
+ * @ht_capa: HT capabilities of station
+ * @vht_capa: VHT capabilities of station
+ * @opmode_notif: operating mode field from Operating Mode Notification
+ * @opmode_notif_used: information if operating mode field is used
+ * @he_capa: HE capabilities of station
+ * @he_capa_len: the length of the HE capabilities
+ * @txpwr: transmit power for an associated station
+ * @txpwr_set: txpwr field is set
+ * @he_6ghz_capa: HE 6 GHz Band capabilities of station
+ * @eht_capa: EHT capabilities of station
+ * @eht_capa_len: the length of the EHT capabilities
+ */
+struct link_station_parameters {
+	const u8 *mld_mac;
+	int link_id;
+	const u8 *link_mac;
+	const u8 *supported_rates;
+	u8 supported_rates_len;
+	const struct ieee80211_ht_cap *ht_capa;
+	const struct ieee80211_vht_cap *vht_capa;
+	u8 opmode_notif;
+	bool opmode_notif_used;
+	const struct ieee80211_he_cap_elem *he_capa;
+	u8 he_capa_len;
+	struct sta_txpwr txpwr;
+	bool txpwr_set;
+	const struct ieee80211_he_6ghz_capa *he_6ghz_capa;
+	const struct ieee80211_eht_cap_elem *eht_capa;
+	u8 eht_capa_len;
+};
+
+/**
+ * struct link_station_del_parameters - link station deletion parameters
+ *
+ * Used to delete a link station entry (or all stations).
+ *
+ * @mld_mac: MAC address of the station
+ * @link_id: the link id
+ */
+struct link_station_del_parameters {
+	const u8 *mld_mac;
+	u32 link_id;
+};
+
 /**
  * struct station_parameters - station parameters
  *
@@ -4215,6 +4270,9 @@ struct mgmt_frame_regs {
  *	radar channel.
  *	The caller is expected to set chandef pointer to NULL in order to
  *	disable background CAC/radar detection.
+ * @add_link_station: Add a link to a station.
+ * @mod_link_station: Modify a link of a station.
+ * @del_link_station: Remove a link of a station.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4560,6 +4618,12 @@ struct cfg80211_ops {
 				struct cfg80211_fils_aad *fils_aad);
 	int	(*set_radar_background)(struct wiphy *wiphy,
 					struct cfg80211_chan_def *chandef);
+	int	(*add_link_station)(struct wiphy *wiphy, struct net_device *dev,
+				    struct link_station_parameters *params);
+	int	(*mod_link_station)(struct wiphy *wiphy, struct net_device *dev,
+				    struct link_station_parameters *params);
+	int	(*del_link_station)(struct wiphy *wiphy, struct net_device *dev,
+				    struct link_station_del_parameters *params);
 };
 
 /*
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 7bb1ae59f3a5..37bfc934325a 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1254,6 +1254,10 @@
  *	without %NL80211_ATTR_MLO_LINK_ID as an easy way to remove all links
  *	in preparation for e.g. roaming to a regular (non-MLO) AP.
  *
+ * @NL80211_CMD_ADD_LINK_STA: Add a link to an MLD station
+ * @NL80211_CMD_MODIFY_LINK_STA: Modify a link of an MLD station
+ * @NL80211_CMD_REMOVE_LINK_STA: Remove a link of an MLD station
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1501,6 +1505,10 @@ enum nl80211_commands {
 	NL80211_CMD_ADD_LINK,
 	NL80211_CMD_REMOVE_LINK,
 
+	NL80211_CMD_ADD_LINK_STA,
+	NL80211_CMD_MODIFY_LINK_STA,
+	NL80211_CMD_REMOVE_LINK_STA,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 22c4cf6fbb57..3cf8e01e3f7e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6801,7 +6801,8 @@ static int nl80211_set_station_tdls(struct genl_info *info,
 }
 
 static int nl80211_parse_sta_txpower_setting(struct genl_info *info,
-					     struct station_parameters *params)
+					     struct sta_txpwr *txpwr,
+					     bool *txpwr_set)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	int idx;
@@ -6813,18 +6814,20 @@ static int nl80211_parse_sta_txpower_setting(struct genl_info *info,
 			return -EOPNOTSUPP;
 
 		idx = NL80211_ATTR_STA_TX_POWER_SETTING;
-		params->txpwr.type = nla_get_u8(info->attrs[idx]);
+		txpwr->type = nla_get_u8(info->attrs[idx]);
 
-		if (params->txpwr.type == NL80211_TX_POWER_LIMITED) {
+		if (txpwr->type == NL80211_TX_POWER_LIMITED) {
 			idx = NL80211_ATTR_STA_TX_POWER;
 
 			if (info->attrs[idx])
-				params->txpwr.power =
-					nla_get_s16(info->attrs[idx]);
+				txpwr->power = nla_get_s16(info->attrs[idx]);
 			else
 				return -EINVAL;
 		}
-		params->sta_modify_mask |= STATION_PARAM_APPLY_STA_TXPOWER;
+
+		*txpwr_set = true;
+	} else {
+		*txpwr_set = false;
 	}
 
 	return 0;
@@ -6837,6 +6840,7 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 	struct station_parameters params;
 	u8 *mac_addr;
 	int err;
+	bool txpwr_set;
 
 	memset(&params, 0, sizeof(params));
 
@@ -6930,9 +6934,11 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 				     NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
 		return -EOPNOTSUPP;
 
-	err = nl80211_parse_sta_txpower_setting(info, &params);
+	err = nl80211_parse_sta_txpower_setting(info, &params.txpwr, &txpwr_set);
 	if (err)
 		return err;
+	if (txpwr_set)
+		params.sta_modify_mask |= STATION_PARAM_APPLY_STA_TXPOWER;
 
 	/* Include parameters for TDLS peer (will check later) */
 	err = nl80211_set_station_tdls(info, &params);
@@ -6975,6 +6981,7 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	u8 *mac_addr = NULL;
 	u32 auth_assoc = BIT(NL80211_STA_FLAG_AUTHENTICATED) |
 			 BIT(NL80211_STA_FLAG_ASSOCIATED);
+	bool txpwr_set;
 
 	memset(&params, 0, sizeof(params));
 
@@ -7085,9 +7092,11 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 				     NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
 		return -EOPNOTSUPP;
 
-	err = nl80211_parse_sta_txpower_setting(info, &params);
+	err = nl80211_parse_sta_txpower_setting(info, &params.txpwr, &txpwr_set);
 	if (err)
 		return err;
+	if (txpwr_set)
+		params.sta_modify_mask |= STATION_PARAM_APPLY_STA_TXPOWER;
 
 	err = nl80211_parse_sta_channel_info(info, &params);
 	if (err)
@@ -15682,6 +15691,128 @@ static int nl80211_remove_link(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+static int
+nl80211_add_mod_link_station(struct sk_buff *skb, struct genl_info *info,
+			     bool add)
+{
+	struct link_station_parameters params = {};
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	int err;
+
+	if ((add && !rdev->ops->add_link_station) ||
+	    (!add && !rdev->ops->mod_link_station))
+		return -EOPNOTSUPP;
+
+	if (add && !info->attrs[NL80211_ATTR_MAC])
+		return -EINVAL;
+
+	if (add && !info->attrs[NL80211_ATTR_MLD_ADDR])
+		return -EINVAL;
+
+	if (add && !info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES])
+		return -EINVAL;
+
+	if (info->attrs[NL80211_ATTR_MLD_ADDR])
+		params.mld_mac = nla_data(info->attrs[NL80211_ATTR_MLD_ADDR]);
+
+	if (info->attrs[NL80211_ATTR_MAC]) {
+		params.link_mac = nla_data(info->attrs[NL80211_ATTR_MAC]);
+		if (!is_valid_ether_addr(params.link_mac))
+			return -EINVAL;
+	}
+
+	if (!info->attrs[NL80211_ATTR_MLO_LINK_ID])
+		return -EINVAL;
+
+	params.link_id = nla_get_u8(info->attrs[NL80211_ATTR_MLO_LINK_ID]);
+
+	if (info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES]) {
+		params.supported_rates =
+			nla_data(info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES]);
+		params.supported_rates_len =
+			nla_len(info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES]);
+	}
+
+	if (info->attrs[NL80211_ATTR_HT_CAPABILITY])
+		params.ht_capa =
+			nla_data(info->attrs[NL80211_ATTR_HT_CAPABILITY]);
+
+	if (info->attrs[NL80211_ATTR_VHT_CAPABILITY])
+		params.vht_capa =
+			nla_data(info->attrs[NL80211_ATTR_VHT_CAPABILITY]);
+
+	if (info->attrs[NL80211_ATTR_HE_CAPABILITY]) {
+		params.he_capa =
+			nla_data(info->attrs[NL80211_ATTR_HE_CAPABILITY]);
+		params.he_capa_len =
+			nla_len(info->attrs[NL80211_ATTR_HE_CAPABILITY]);
+
+		if (info->attrs[NL80211_ATTR_EHT_CAPABILITY]) {
+			params.eht_capa =
+				nla_data(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
+			params.eht_capa_len =
+				nla_len(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
+
+			if (!ieee80211_eht_capa_size_ok((const u8 *)params.he_capa,
+							(const u8 *)params.eht_capa,
+							params.eht_capa_len))
+				return -EINVAL;
+		}
+	}
+
+	if (info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY])
+		params.he_6ghz_capa =
+			nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
+
+	if (info->attrs[NL80211_ATTR_OPMODE_NOTIF]) {
+		params.opmode_notif_used = true;
+		params.opmode_notif =
+			nla_get_u8(info->attrs[NL80211_ATTR_OPMODE_NOTIF]);
+	}
+
+	err = nl80211_parse_sta_txpower_setting(info, &params.txpwr,
+						&params.txpwr_set);
+	if (err)
+		return err;
+
+	if (add)
+		return rdev_add_link_station(rdev, dev, &params);
+	return rdev_mod_link_station(rdev, dev, &params);
+}
+
+static int
+nl80211_add_link_station(struct sk_buff *skb, struct genl_info *info)
+{
+	return nl80211_add_mod_link_station(skb, info, true);
+}
+
+static int
+nl80211_modify_link_station(struct sk_buff *skb, struct genl_info *info)
+{
+	return nl80211_add_mod_link_station(skb, info, false);
+}
+
+static int
+nl80211_remove_link_station(struct sk_buff *skb, struct genl_info *info)
+{
+	struct link_station_del_parameters params = {};
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+
+	if (!rdev->ops->del_link_station)
+		return -EOPNOTSUPP;
+
+	if (!info->attrs[NL80211_ATTR_MLD_ADDR] ||
+	    !info->attrs[NL80211_ATTR_MLO_LINK_ID])
+		return -EINVAL;
+
+	params.mld_mac = nla_data(info->attrs[NL80211_ATTR_MLD_ADDR]);
+	params.link_id = nla_get_u8(info->attrs[NL80211_ATTR_MLO_LINK_ID]);
+
+	return rdev_del_link_station(rdev, dev, &params);
+}
+
 #define NL80211_FLAG_NEED_WIPHY		0x01
 #define NL80211_FLAG_NEED_NETDEV	0x02
 #define NL80211_FLAG_NEED_RTNL		0x04
@@ -16832,6 +16963,27 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
 					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
+	{
+		.cmd = NL80211_CMD_ADD_LINK_STA,
+		.doit = nl80211_add_link_station,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
+	},
+	{
+		.cmd = NL80211_CMD_MODIFY_LINK_STA,
+		.doit = nl80211_modify_link_station,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
+	},
+	{
+		.cmd = NL80211_CMD_REMOVE_LINK_STA,
+		.doit = nl80211_remove_link_station,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index a329ba036989..6221a996c19f 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1448,4 +1448,52 @@ rdev_del_intf_link(struct cfg80211_registered_device *rdev,
 	trace_rdev_return_void(&rdev->wiphy);
 }
 
+static inline int
+rdev_add_link_station(struct cfg80211_registered_device *rdev,
+		      struct net_device *dev,
+		      struct link_station_parameters *params)
+{
+	int ret;
+
+	if (!rdev->ops->add_link_station)
+		return -EOPNOTSUPP;
+
+	trace_rdev_add_link_station(&rdev->wiphy, dev, params);
+	ret = rdev->ops->add_link_station(&rdev->wiphy, dev, params);
+	trace_rdev_return_int(&rdev->wiphy, ret);
+	return ret;
+}
+
+static inline int
+rdev_mod_link_station(struct cfg80211_registered_device *rdev,
+		      struct net_device *dev,
+		      struct link_station_parameters *params)
+{
+	int ret;
+
+	if (!rdev->ops->mod_link_station)
+		return -EOPNOTSUPP;
+
+	trace_rdev_mod_link_station(&rdev->wiphy, dev, params);
+	ret = rdev->ops->mod_link_station(&rdev->wiphy, dev, params);
+	trace_rdev_return_int(&rdev->wiphy, ret);
+	return ret;
+}
+
+static inline int
+rdev_del_link_station(struct cfg80211_registered_device *rdev,
+		      struct net_device *dev,
+		      struct link_station_del_parameters *params)
+{
+	int ret;
+
+	if (!rdev->ops->del_link_station)
+		return -EOPNOTSUPP;
+
+	trace_rdev_del_link_station(&rdev->wiphy, dev, params);
+	ret = rdev->ops->del_link_station(&rdev->wiphy, dev, params);
+	trace_rdev_return_int(&rdev->wiphy, ret);
+	return ret;
+}
+
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 65f8b814ecd0..16d0fe53fcf2 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3775,6 +3775,103 @@ TRACE_EVENT(cfg80211_assoc_comeback,
 		  WDEV_PR_ARG, MAC_PR_ARG(bssid), __entry->timeout)
 );
 
+DECLARE_EVENT_CLASS(link_station_add_mod,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 struct link_station_parameters *params),
+	TP_ARGS(wiphy, netdev, params),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		__array(u8, mld_mac, 6)
+		__array(u8, link_mac, 6)
+		__field(u32, link_id)
+		__dynamic_array(u8, supported_rates,
+				params->supported_rates_len)
+		__array(u8, ht_capa, (int)sizeof(struct ieee80211_ht_cap))
+		__array(u8, vht_capa, (int)sizeof(struct ieee80211_vht_cap))
+		__field(u8, opmode_notif)
+		__field(bool, opmode_notif_used)
+		__dynamic_array(u8, he_capa, params->he_capa_len)
+		__array(u8, he_6ghz_capa, (int)sizeof(struct ieee80211_he_6ghz_capa))
+		__dynamic_array(u8, eht_capa, params->eht_capa_len)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		memset(__entry->mld_mac, 0, 6);
+		memset(__entry->link_mac, 0, 6);
+		if (params->mld_mac)
+			memcpy(__entry->mld_mac, params->mld_mac, 6);
+		if (params->link_mac)
+			memcpy(__entry->link_mac, params->link_mac, 6);
+		__entry->link_id = params->link_id;
+		if (params->supported_rates && params->supported_rates_len)
+			memcpy(__get_dynamic_array(supported_rates),
+			       params->supported_rates,
+			       params->supported_rates_len);
+		memset(__entry->ht_capa, 0, sizeof(struct ieee80211_ht_cap));
+		if (params->ht_capa)
+			memcpy(__entry->ht_capa, params->ht_capa,
+			       sizeof(struct ieee80211_ht_cap));
+		memset(__entry->vht_capa, 0, sizeof(struct ieee80211_vht_cap));
+		if (params->vht_capa)
+			memcpy(__entry->vht_capa, params->vht_capa,
+			       sizeof(struct ieee80211_vht_cap));
+		__entry->opmode_notif = params->opmode_notif;
+		__entry->opmode_notif_used = params->opmode_notif_used;
+		if (params->he_capa && params->he_capa_len)
+			memcpy(__get_dynamic_array(he_capa), params->he_capa,
+			       params->he_capa_len);
+		memset(__entry->he_6ghz_capa, 0, sizeof(struct ieee80211_he_6ghz_capa));
+		if (params->he_6ghz_capa)
+			memcpy(__entry->he_6ghz_capa, params->he_6ghz_capa,
+			       sizeof(struct ieee80211_he_6ghz_capa));
+		if (params->eht_capa && params->eht_capa_len)
+			memcpy(__get_dynamic_array(eht_capa), params->eht_capa,
+			       params->eht_capa_len);
+	),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: " MAC_PR_FMT
+		  ", link mac: " MAC_PR_FMT ", link id: %u",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(mld_mac),
+		  MAC_PR_ARG(link_mac), __entry->link_id)
+);
+
+DEFINE_EVENT(link_station_add_mod, rdev_add_link_station,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 struct link_station_parameters *params),
+	TP_ARGS(wiphy, netdev, params)
+);
+
+DEFINE_EVENT(link_station_add_mod, rdev_mod_link_station,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 struct link_station_parameters *params),
+	TP_ARGS(wiphy, netdev, params)
+);
+
+TRACE_EVENT(rdev_del_link_station,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 struct link_station_del_parameters *params),
+	TP_ARGS(wiphy, netdev, params),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		__array(u8, mld_mac, 6)
+		__field(u32, link_id)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		memset(__entry->mld_mac, 0, 6);
+		if (params->mld_mac)
+			memcpy(__entry->mld_mac, params->mld_mac, 6);
+		__entry->link_id = params->link_id;
+	),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: " MAC_PR_FMT
+		  ", link id: %u",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(mld_mac),
+		  __entry->link_id)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.36.1

