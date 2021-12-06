Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038824690CD
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Dec 2021 08:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhLFHaB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Dec 2021 02:30:01 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:30205 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229652AbhLFHaB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Dec 2021 02:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638775593; x=1670311593;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=AD3Drb+quM5fVNUsmyjEaRQRg9rWkbeRL4L/d/3OO4o=;
  b=JPVdCnVwfekYU8aIj4wgDmw0Iuusb1gzFzXyXug1kv/4NkP8fjBjCobl
   daZf6pjVto+SZEyPJu3dhS6+gQcLy6cSSxD4KMqgpGkdeITyc2qPdIBGG
   jRI9Idf6OH5Yg6mkpgxP7sG0TscCdpz7ikncCZzwIt4r0F/EbOA9AsnY+
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Dec 2021 23:26:32 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 23:26:32 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 5 Dec 2021 23:26:31 -0800
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 5 Dec 2021 23:26:29 -0800
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [RFC] mac80211: add support for 6 GHz channels and regulatory
Date:   Mon, 6 Dec 2021 12:56:11 +0530
Message-ID: <1638775571-24366-1-git-send-email-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

6 GHz introduces various power modes of operation. Currently,
based on the power mode, channel's psd value as well as
channel disabled flag can change. For single interface, current
implementaion works just fine. But for multi-interfaces, for
example AP-STA concurrency, two different channel needs to be
maintained. This is because, STA power mode also depends on the
AP's power mode it is going to associate with. Hence, psd value
and channel disabled flag might vary. In this case, same channel
can not be used for both AP and STA.

Therefore, to support multiple channels for each power mode, the
6 GHz channels needs a separate storage space in struct
ieee80211_supported_band. Because of this, the existing
APIs to get the channel/freq from freq/channel will not
work for 6 GHz band.

Hence, this patch adds support to store all possible 6 GHz
channels according to power mode as well as add API
support for getting chan/freq info from the new struct
ieee80211_6ghz_channel.

The new NL80211_ATTR_6G_REG_POWER_MODE NL attribute
can be used in subsequent patch to get the power mode
from user space.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/linux/ieee80211.h    |  1 +
 include/net/cfg80211.h       | 31 +++++++++++++++++++++++++++++++
 include/net/regulatory.h     |  1 +
 include/uapi/linux/nl80211.h | 16 ++++++++++++++++
 net/mac80211/util.c          | 25 ++++++++++++++++++++++++-
 net/wireless/nl80211.c       | 15 ++++++++++++++-
 net/wireless/reg.c           | 31 ++++++++++++++++++++++++-------
 net/wireless/util.c          | 24 ++++++++++++++++++++++++
 8 files changed, 135 insertions(+), 9 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 11d7af2..d54e69b 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2371,6 +2371,7 @@ struct ieee80211_he_6ghz_oper {
 #define		IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ	3
 #define IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON	0x4
 #define IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO	0x38
+#define IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO_LSB 3
 	u8 control;
 	u8 ccfs0;
 	u8 ccfs1;
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 362da9f..2793ccf 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -456,6 +456,21 @@ struct ieee80211_sta_s1g_cap {
 };
 
 /**
+ * struct ieee80211_6ghz_channel - 6G channel definitions
+ *
+ * This structure defines all the channels supported by the
+ * 6 GHz band
+ *
+ * @channels: Array of channels the hardware can operate with
+ *      in 6G band.
+ * @n_channels: Number of channels in @channels
+ */
+struct ieee80211_6ghz_channel {
+	struct ieee80211_channel *channels;
+	int n_channels;
+};
+
+/**
  * struct ieee80211_supported_band - frequency band definition
  *
  * This structure describes a frequency band a wiphy
@@ -463,6 +478,7 @@ struct ieee80211_sta_s1g_cap {
  *
  * @channels: Array of channels the hardware can operate with
  *	in this band.
+ * @chan_6g: Array of 6G channels the hardware can operate with
  * @band: the band this structure represents
  * @n_channels: Number of channels in @channels
  * @bitrates: Array of bitrates the hardware can operate with
@@ -482,6 +498,7 @@ struct ieee80211_sta_s1g_cap {
  */
 struct ieee80211_supported_band {
 	struct ieee80211_channel *channels;
+	struct ieee80211_6ghz_channel *chan_6g[NL80211_REG_NUM_POWER_MODES];
 	struct ieee80211_rate *bitrates;
 	enum nl80211_band band;
 	int n_channels;
@@ -5565,6 +5582,7 @@ struct wireless_dev {
 	struct work_struct pmsr_free_wk;
 
 	unsigned long unprot_beacon_reported;
+	u8 reg_6g_power_mode;
 };
 
 static inline const u8 *wdev_address(struct wireless_dev *wdev)
@@ -5697,6 +5715,19 @@ ieee80211_get_channel(struct wiphy *wiphy, int freq)
 }
 
 /**
+ * ieee80211_get_6g_channel_khz - get channel struct from wiphy for specified
+ *                                frequency in 6G band
+ *
+ * @wiphy: the struct wiphy to get the channel for
+ * @freq: the center frequency (in KHz) of the channel
+ * @mode: the poer mode in which freq is to be operated
+ * Return: The channel struct from @wiphy at @freq.
+ */
+struct ieee80211_channel *
+ieee80211_get_6g_channel_khz(struct wiphy *wiphy, u32 freq,
+			     enum nl80211_regulatory_power_modes mode);
+
+/**
  * cfg80211_channel_is_psc - Check if the channel is a 6 GHz PSC
  * @chan: control channel to check
  *
diff --git a/include/net/regulatory.h b/include/net/regulatory.h
index 47f06f6..1695153 100644
--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -218,6 +218,7 @@ struct ieee80211_reg_rule {
 	struct ieee80211_freq_range freq_range;
 	struct ieee80211_power_rule power_rule;
 	struct ieee80211_wmm_rule wmm_rule;
+	enum nl80211_regulatory_power_modes mode;
 	u32 flags;
 	u32 dfs_cac_ms;
 	bool has_wmm;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 3e73482..d0a2dd6 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3154,6 +3154,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_RADAR_OFFCHAN,
 
+	NL80211_ATTR_6G_REG_POWER_MODE,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3821,6 +3823,20 @@ enum nl80211_band_attr {
 
 #define NL80211_BAND_ATTR_HT_CAPA NL80211_BAND_ATTR_HT_CAPA
 
+enum nl80211_regulatory_power_modes {
+	NL80211_REG_AP_LPI,
+	NL80211_REG_AP_SP,
+	NL80211_REG_AP_VLP,
+	NL80211_REG_REGULAR_CLIENT_LPI,
+	NL80211_REG_REGULAR_CLIENT_SP,
+	NL80211_REG_REGULAR_CLIENT_VLP,
+	NL80211_REG_SUBORDINATE_CLIENT_LPI,
+	NL80211_REG_SUBORDINATE_CLIENT_SP,
+	NL80211_REG_SUBORDINATE_CLIENT_VLP,
+
+	NL80211_REG_NUM_POWER_MODES,
+};
+
 /**
  * enum nl80211_wmm_rule - regulatory wmm rule
  *
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 39fa2a5..c2312ba 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3385,10 +3385,13 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 	const struct ieee80211_sta_he_cap *he_cap;
 	struct cfg80211_chan_def he_chandef = *chandef;
 	const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
+	enum nl80211_regulatory_power_modes mode;
 	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
 	bool support_80_80, support_160;
 	u8 he_phy_cap;
 	u32 freq;
+	u8 reg_info;
+	u8 reg_6g_power_mode;
 
 	if (chandef->chan->band != NL80211_BAND_6GHZ)
 		return true;
@@ -3425,9 +3428,29 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 		return false;
 	}
 
+	/* 6G Power mode present in the beacon */
+	reg_info = (he_6ghz_oper->control & IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO) >>
+		   IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO_LSB;
+
+	/* 6G Power mode configured by the user */
+	reg_6g_power_mode = sdata->wdev.reg_6g_power_mode;
+
+	/**
+	 * For AP/AP_VLAN/MESH_POINT interfaces, the 6G power mode depends on the
+	 * mode configured by user (LPI/SP/VLP). For other interfaces (for ex STA)
+	 * mode depends on the power mode present in beacon as well as power mode
+	 * configured by the user for that interface
+	 */
+	if (iftype == NL80211_IFTYPE_AP || iftype == NL80211_IFTYPE_AP_VLAN ||
+	    iftype == NL80211_IFTYPE_MESH_POINT)
+		mode = reg_6g_power_mode;
+	else
+		mode = 3 * (1 + reg_6g_power_mode) + reg_info;
+
 	freq = ieee80211_channel_to_frequency(he_6ghz_oper->primary,
 					      NL80211_BAND_6GHZ);
-	he_chandef.chan = ieee80211_get_channel(sdata->local->hw.wiphy, freq);
+	he_chandef.chan = ieee80211_get_6g_channel_khz(sdata->local->hw.wiphy,
+						       MHZ_TO_KHZ(freq), mode);
 
 	switch (u8_get_bits(he_6ghz_oper->control,
 			    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 25ee165..c010f72 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -777,6 +777,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 			NLA_POLICY_NESTED(nl80211_mbssid_config_policy),
 	[NL80211_ATTR_MBSSID_ELEMS] = { .type = NLA_NESTED },
 	[NL80211_ATTR_RADAR_OFFCHAN] = { .type = NLA_FLAG },
+	[NL80211_ATTR_6G_REG_POWER_MODE] = NLA_POLICY_RANGE(NLA_U8, 0, 2),
 };
 
 /* policy for the key attributes */
@@ -3059,6 +3060,7 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct nlattr **attrs = info->attrs;
+	enum nl80211_regulatory_power_modes mode = NL80211_REG_AP_LPI;
 	u32 control_freq;
 
 	if (!attrs[NL80211_ATTR_WIPHY_FREQ])
@@ -3070,8 +3072,19 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 		control_freq +=
 		    nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET]);
 
+	if (info->attrs[NL80211_ATTR_6G_REG_POWER_MODE])
+		mode = nla_get_u8(info->attrs[NL80211_ATTR_6G_REG_POWER_MODE]);
+
 	memset(chandef, 0, sizeof(*chandef));
-	chandef->chan = ieee80211_get_channel_khz(&rdev->wiphy, control_freq);
+
+	if (control_freq >= MHZ_TO_KHZ(5945) && control_freq <= MHZ_TO_KHZ(7125))
+		chandef->chan = ieee80211_get_6g_channel_khz(&rdev->wiphy,
+							     control_freq,
+							     mode);
+	else
+		chandef->chan = ieee80211_get_channel_khz(&rdev->wiphy,
+							  control_freq);
+
 	chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
 	chandef->center_freq1 = KHZ_TO_MHZ(control_freq);
 	chandef->freq1_offset = control_freq % 1000;
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index df87c7f..957c246 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1595,7 +1595,8 @@ static u32 map_regdom_flags(u32 rd_flags)
 
 static const struct ieee80211_reg_rule *
 freq_reg_info_regd(u32 center_freq,
-		   const struct ieee80211_regdomain *regd, u32 bw)
+		   const struct ieee80211_regdomain *regd, u32 bw,
+		   enum nl80211_regulatory_power_modes mode)
 {
 	int i;
 	bool band_rule_found = false;
@@ -1609,7 +1610,12 @@ freq_reg_info_regd(u32 center_freq,
 		const struct ieee80211_freq_range *fr = NULL;
 
 		rr = &regd->reg_rules[i];
-		fr = &rr->freq_range;
+
+		if (rr->mode == mode)
+			fr = &rr->freq_range;
+
+		if (!fr)
+			continue;
 
 		/*
 		 * We only need to know if one frequency rule was
@@ -1641,7 +1647,7 @@ __freq_reg_info(struct wiphy *wiphy, u32 center_freq, u32 min_bw)
 	u32 bw;
 
 	for (bw = MHZ_TO_KHZ(bws[i]); bw >= min_bw; bw = MHZ_TO_KHZ(bws[i--])) {
-		reg_rule = freq_reg_info_regd(center_freq, regd, bw);
+		reg_rule = freq_reg_info_regd(center_freq, regd, bw, 0);
 		if (!IS_ERR(reg_rule))
 			return reg_rule;
 	}
@@ -2279,7 +2285,7 @@ static void reg_process_ht_flags_channel(struct wiphy *wiphy,
 	if (regd) {
 		const struct ieee80211_reg_rule *reg_rule =
 			freq_reg_info_regd(MHZ_TO_KHZ(channel->center_freq),
-					   regd, MHZ_TO_KHZ(20));
+					   regd, MHZ_TO_KHZ(20), 0);
 
 		if (!IS_ERR(reg_rule))
 			flags = reg_rule->flags;
@@ -2489,7 +2495,8 @@ static void update_all_wiphy_regulatory(enum nl80211_reg_initiator initiator)
 static void handle_channel_custom(struct wiphy *wiphy,
 				  struct ieee80211_channel *chan,
 				  const struct ieee80211_regdomain *regd,
-				  u32 min_bw)
+				  u32 min_bw,
+				  enum nl80211_regulatory_power_modes mode)
 {
 	u32 bw_flags = 0;
 	const struct ieee80211_reg_rule *reg_rule = NULL;
@@ -2498,7 +2505,7 @@ static void handle_channel_custom(struct wiphy *wiphy,
 
 	center_freq_khz = ieee80211_channel_to_khz(chan);
 	for (bw = MHZ_TO_KHZ(20); bw >= min_bw; bw = bw / 2) {
-		reg_rule = freq_reg_info_regd(center_freq_khz, regd, bw);
+		reg_rule = freq_reg_info_regd(center_freq_khz, regd, bw, mode);
 		if (!IS_ERR(reg_rule))
 			break;
 	}
@@ -2548,10 +2555,20 @@ static void handle_band_custom(struct wiphy *wiphy,
 			       const struct ieee80211_regdomain *regd)
 {
 	unsigned int i;
+	unsigned int j;
 
 	if (!sband)
 		return;
 
+	if (sband->band == NL80211_BAND_6GHZ) {
+		for (i = 0; i < NL80211_REG_NUM_POWER_MODES; i++)
+			for (j = 0; j < sband->chan_6g[i]->n_channels; j++)
+				handle_channel_custom(wiphy,
+						      &sband->chan_6g[i]->channels[j],
+						      regd, MHZ_TO_KHZ(20), i);
+		return;
+	}
+
 	/*
 	 * We currently assume that you always want at least 20 MHz,
 	 * otherwise channel 12 might get enabled if this rule is
@@ -2559,7 +2576,7 @@ static void handle_band_custom(struct wiphy *wiphy,
 	 */
 	for (i = 0; i < sband->n_channels; i++)
 		handle_channel_custom(wiphy, &sband->channels[i], regd,
-				      MHZ_TO_KHZ(20));
+				      MHZ_TO_KHZ(20), 0);
 }
 
 /* Used by drivers prior to wiphy registration */
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 5ff1f872..8e7f8c2 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -165,6 +165,30 @@ int ieee80211_freq_khz_to_channel(u32 freq)
 }
 EXPORT_SYMBOL(ieee80211_freq_khz_to_channel);
 
+struct ieee80211_channel
+*ieee80211_get_6g_channel_khz(struct wiphy *wiphy, u32 freq,
+			      enum nl80211_regulatory_power_modes mode)
+{
+	struct ieee80211_supported_band *sband;
+	int i;
+
+	sband = wiphy->bands[NL80211_BAND_6GHZ];
+
+	if (!sband || mode >= NL80211_REG_NUM_POWER_MODES)
+		return NULL;
+
+	for (i = 0; i < sband->chan_6g[mode]->n_channels; i++) {
+		struct ieee80211_channel *chan =
+				&sband->chan_6g[mode]->channels[i];
+
+		if (ieee80211_channel_to_khz(chan) == freq)
+			return chan;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(ieee80211_get_6g_channel_khz);
+
 struct ieee80211_channel *ieee80211_get_channel_khz(struct wiphy *wiphy,
 						    u32 freq)
 {
-- 
2.7.4

