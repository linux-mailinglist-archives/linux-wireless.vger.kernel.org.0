Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E15856523E
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 12:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiGDKZ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 06:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiGDKZf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 06:25:35 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AD51115C
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 03:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656930253; x=1688466253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=1rcXM5diwjF9xWa5nm07uvLm6hFCJu0vRsRlo5z046w=;
  b=QOHUNZZ7Ggc9M6rhKwrlAlzZkDrY6HRj3pK0aZ4fV2Bo2kcEv4i6WTG4
   GTeI0Fz8Y5Tv9IBYtrzNFBReAAbxU9eqqiXzr/BysFuvBpIZxA7ffKu4q
   2YqAN9tp8BsXWm4kFI3MulkFrjChaK3gYRIJuY+PcKsgQKo/fkZZJezLo
   0=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 04 Jul 2022 03:24:13 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 03:24:13 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 03:24:12 -0700
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 03:24:11 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH 5/7] mac80211: add support for 6 GHz channels and regulatory
Date:   Mon, 4 Jul 2022 15:53:39 +0530
Message-ID: <20220704102341.5692-6-quic_adisi@quicinc.com>
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

6 GHz introduces various power modes of operation. Currently, based
on the power mode, channel's Power Spectral Density (PSD)  value as
well as channel disabled flag can change. For single interface,
current implementation works just fine. But for multi-interfaces, for
example AP-STA concurrency, two different channel context needs to be
maintained. This is because, STA power mode also depends on the AP's
power mode it is going to associate with. Hence, PSD value and channel
disabled flag might vary. In this case, same channel context cannot be
used for both AP and STA.

Therefore, to support multiple channel space for each power mode, the
6 GHz channels needs a separate storage space in struct
ieee80211_supported_band. Because of this, the existing APIs to get the
channel/freq from freq/channel will not work for 6 GHz band.

Add support to store all possible 6 GHz channel pools according to the
power mode as well as add API support for getting chan/freq info from
the new struct ieee80211_channel_6ghz.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/net/cfg80211.h   | 31 ++++++++++++++++++++++++++++
 include/net/regulatory.h |  1 +
 net/mac80211/util.c      | 40 +++++++++++++++++++++++++++++++++++-
 net/wireless/reg.c       | 44 +++++++++++++++++++++++++++++++++-------
 net/wireless/util.c      | 27 ++++++++++++++++++++++++
 5 files changed, 135 insertions(+), 8 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1e8852c6149f..21c058bec5fe 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -512,6 +512,21 @@ struct ieee80211_sta_s1g_cap {
 	u8 nss_mcs[5];
 };
 
+/**
+ * struct ieee80211_channel_6ghz - 6 GHz channel definitions
+ *
+ * This structure defines all the channels supported by the
+ * 6 GHz band.
+ *
+ * @channels: Array of channels the hardware can operate with
+ *      in 6 GHz band.
+ * @n_channels: Number of channels in @channels
+ */
+struct ieee80211_channel_6ghz {
+	struct ieee80211_channel *channels;
+	int n_channels;
+};
+
 /**
  * struct ieee80211_supported_band - frequency band definition
  *
@@ -520,6 +535,7 @@ struct ieee80211_sta_s1g_cap {
  *
  * @channels: Array of channels the hardware can operate with
  *	in this band.
+ * @channels_6ghz: Array of 6 GHz channels the hardware can operate with
  * @band: the band this structure represents
  * @n_channels: Number of channels in @channels
  * @bitrates: Array of bitrates the hardware can operate with
@@ -539,6 +555,8 @@ struct ieee80211_sta_s1g_cap {
  */
 struct ieee80211_supported_band {
 	struct ieee80211_channel *channels;
+	struct ieee80211_channel_6ghz
+			    *channels_6ghz[NL80211_REG_MAX_POWER_MODES + 1];
 	struct ieee80211_rate *bitrates;
 	enum nl80211_band band;
 	int n_channels;
@@ -5943,6 +5961,19 @@ ieee80211_get_channel(struct wiphy *wiphy, int freq)
 	return ieee80211_get_channel_khz(wiphy, MHZ_TO_KHZ(freq));
 }
 
+/**
+ * ieee80211_get_6ghz_channel_khz - get channel struct from wiphy for specified
+ *                                  frequency in 6 GHz band
+ *
+ * @wiphy: the struct wiphy to get the channel for
+ * @freq: the center frequency (in KHz) of the channel
+ * @power_mode: the power mode in which freq is to be operated
+ * Return: The channel struct from @wiphy at @freq.
+ */
+struct ieee80211_channel *
+ieee80211_get_6ghz_channel_khz(struct wiphy *wiphy, u32 freq,
+			       enum nl80211_regulatory_power_modes power_mode);
+
 /**
  * cfg80211_channel_is_psc - Check if the channel is a 6 GHz PSC
  * @chan: control channel to check
diff --git a/include/net/regulatory.h b/include/net/regulatory.h
index ed20004fb6a9..5589c3eb8316 100644
--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -218,6 +218,7 @@ struct ieee80211_reg_rule {
 	struct ieee80211_freq_range freq_range;
 	struct ieee80211_power_rule power_rule;
 	struct ieee80211_wmm_rule wmm_rule;
+	enum nl80211_regulatory_power_modes power_mode;
 	u32 flags;
 	u32 dfs_cac_ms;
 	bool has_wmm;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index efdea5c2f2db..6a955ef5712c 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3464,6 +3464,9 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 	bool support_80_80, support_160, support_320;
 	u8 he_phy_cap, eht_phy_cap;
 	u32 freq;
+	enum ieee80211_ap_reg_power reg_6ghz_power_beacon, reg_6ghz_ap_power;
+	enum ieee80211_client_reg_power reg_6ghz_client_power;
+	enum nl80211_regulatory_power_modes reg_6ghz_power_final;
 
 	if (chandef->chan->band != NL80211_BAND_6GHZ)
 		return true;
@@ -3506,6 +3509,39 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 		return false;
 	}
 
+	/* 6 GHz Power mode present in the beacon */
+	reg_6ghz_power_beacon = u8_get_bits(he_6ghz_oper->control,
+					    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO);
+	switch (reg_6ghz_power_beacon) {
+	case IEEE80211_REG_LPI_AP:
+	case IEEE80211_REG_SP_AP:
+	case IEEE80211_REG_VLP_AP:
+		break;
+	default:
+		sdata_info(sdata,
+			   "Invalid Regulatory Info subfield in HE 6 GHz operation, expect issues\n");
+		return false;
+	}
+
+	/* For AP/AP_VLAN/MESH_POINT interfaces, the 6 GHz power mode depends on the
+	 * mode configured by user (LPI/SP/VLP). For other interfaces (for ex STA)
+	 * mode depends on the power mode present in beacon as well as power mode
+	 * configured by the user for that interface
+	 */
+	if (iftype == NL80211_IFTYPE_AP || iftype == NL80211_IFTYPE_AP_VLAN ||
+	    iftype == NL80211_IFTYPE_MESH_POINT) {
+		/* 6 GHz Power mode configured by the user in the config */
+		reg_6ghz_ap_power = sdata->wdev.ap_6ghz_power;
+		reg_6ghz_power_final =
+			ieee80211_ap_reg_power_to_reg_power_mode(reg_6ghz_ap_power);
+	} else {
+		/* 6 GHz Power mode configured by the user in the config */
+		reg_6ghz_client_power = sdata->wdev.client_6ghz_power;
+		reg_6ghz_power_final =
+		     ieee80211_client_reg_power_to_reg_power_mode(reg_6ghz_client_power,
+								  reg_6ghz_power_beacon);
+	}
+
 	/*
 	 * The EHT operation IE does not contain the primary channel so the
 	 * primary channel frequency should be taken from the 6 GHz operation
@@ -3513,7 +3549,9 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 	 */
 	freq = ieee80211_channel_to_frequency(he_6ghz_oper->primary,
 					      NL80211_BAND_6GHZ);
-	he_chandef.chan = ieee80211_get_channel(sdata->local->hw.wiphy, freq);
+	he_chandef.chan = ieee80211_get_6ghz_channel_khz(sdata->local->hw.wiphy,
+							 MHZ_TO_KHZ(freq),
+							 reg_6ghz_power_final);
 
 	switch (u8_get_bits(he_6ghz_oper->control,
 			    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 9a06aadba0d7..fae360afbd65 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1626,7 +1626,8 @@ static u32 map_regdom_flags(u32 rd_flags)
 
 static const struct ieee80211_reg_rule *
 freq_reg_info_regd(u32 center_freq,
-		   const struct ieee80211_regdomain *regd, u32 bw)
+		   const struct ieee80211_regdomain *regd, u32 bw,
+		   enum nl80211_regulatory_power_modes power_mode)
 {
 	int i;
 	bool band_rule_found = false;
@@ -1640,7 +1641,12 @@ freq_reg_info_regd(u32 center_freq,
 		const struct ieee80211_freq_range *fr = NULL;
 
 		rr = &regd->reg_rules[i];
-		fr = &rr->freq_range;
+
+		if (rr->power_mode == power_mode)
+			fr = &rr->freq_range;
+
+		if (!fr)
+			continue;
 
 		/*
 		 * We only need to know if one frequency rule was
@@ -1672,7 +1678,8 @@ __freq_reg_info(struct wiphy *wiphy, u32 center_freq, u32 min_bw)
 	u32 bw;
 
 	for (bw = MHZ_TO_KHZ(bws[i]); bw >= min_bw; bw = MHZ_TO_KHZ(bws[i--])) {
-		reg_rule = freq_reg_info_regd(center_freq, regd, bw);
+		reg_rule = freq_reg_info_regd(center_freq, regd, bw,
+					      NL80211_REG_AP_LPI);
 		if (!IS_ERR(reg_rule))
 			return reg_rule;
 	}
@@ -2324,7 +2331,8 @@ static void reg_process_ht_flags_channel(struct wiphy *wiphy,
 	if (regd) {
 		const struct ieee80211_reg_rule *reg_rule =
 			freq_reg_info_regd(MHZ_TO_KHZ(channel->center_freq),
-					   regd, MHZ_TO_KHZ(20));
+					   regd, MHZ_TO_KHZ(20),
+					   NL80211_REG_AP_LPI);
 
 		if (!IS_ERR(reg_rule))
 			flags = reg_rule->flags;
@@ -2563,7 +2571,8 @@ static void update_all_wiphy_regulatory(enum nl80211_reg_initiator initiator)
 static void handle_channel_custom(struct wiphy *wiphy,
 				  struct ieee80211_channel *chan,
 				  const struct ieee80211_regdomain *regd,
-				  u32 min_bw)
+				  u32 min_bw,
+				  enum nl80211_regulatory_power_modes power_mode)
 {
 	u32 bw_flags = 0;
 	const struct ieee80211_reg_rule *reg_rule = NULL;
@@ -2572,7 +2581,7 @@ static void handle_channel_custom(struct wiphy *wiphy,
 
 	center_freq_khz = ieee80211_channel_to_khz(chan);
 	for (bw = MHZ_TO_KHZ(20); bw >= min_bw; bw = bw / 2) {
-		reg_rule = freq_reg_info_regd(center_freq_khz, regd, bw);
+		reg_rule = freq_reg_info_regd(center_freq_khz, regd, bw, power_mode);
 		if (!IS_ERR(reg_rule))
 			break;
 	}
@@ -2625,10 +2634,30 @@ static void handle_band_custom(struct wiphy *wiphy,
 			       const struct ieee80211_regdomain *regd)
 {
 	unsigned int i;
+	unsigned int j;
+	bool _6ghz_new_support = false;
 
 	if (!sband)
 		return;
 
+	if (sband->band == NL80211_BAND_6GHZ) {
+		for (i = 0; i < NL80211_REG_MAX_POWER_MODES + 1; i++) {
+			if (!sband->channels_6ghz[i])
+				continue;
+
+			if (!_6ghz_new_support)
+				_6ghz_new_support = true;
+
+			for (j = 0; j < sband->channels_6ghz[i]->n_channels; j++)
+				handle_channel_custom(wiphy,
+						      &sband->channels_6ghz[i]->channels[j],
+						      regd, MHZ_TO_KHZ(20), i);
+		}
+
+		if (_6ghz_new_support)
+			return;
+	}
+
 	/*
 	 * We currently assume that you always want at least 20 MHz,
 	 * otherwise channel 12 might get enabled if this rule is
@@ -2636,7 +2665,8 @@ static void handle_band_custom(struct wiphy *wiphy,
 	 */
 	for (i = 0; i < sband->n_channels; i++)
 		handle_channel_custom(wiphy, &sband->channels[i], regd,
-				      MHZ_TO_KHZ(20));
+				      MHZ_TO_KHZ(20),
+				      NL80211_REG_AP_LPI);
 }
 
 /* Used by drivers prior to wiphy registration */
diff --git a/net/wireless/util.c b/net/wireless/util.c
index cca0ee321a03..38e807e30874 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -165,6 +165,33 @@ int ieee80211_freq_khz_to_channel(u32 freq)
 }
 EXPORT_SYMBOL(ieee80211_freq_khz_to_channel);
 
+struct ieee80211_channel
+*ieee80211_get_6ghz_channel_khz(struct wiphy *wiphy, u32 freq,
+				enum nl80211_regulatory_power_modes power_mode)
+{
+	struct ieee80211_supported_band *sband;
+	int i;
+	struct ieee80211_channel *chan;
+
+	sband = wiphy->bands[NL80211_BAND_6GHZ];
+
+	if (!sband || power_mode >= NL80211_REG_MAX_POWER_MODES + 1)
+		return NULL;
+
+	if (!sband->channels_6ghz[power_mode])
+		return ieee80211_get_channel_khz(wiphy, freq);
+
+	for (i = 0; i < sband->channels_6ghz[power_mode]->n_channels; i++) {
+		chan = &sband->channels_6ghz[power_mode]->channels[i];
+
+		if (ieee80211_channel_to_khz(chan) == freq)
+			return chan;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(ieee80211_get_6ghz_channel_khz);
+
 struct ieee80211_channel *ieee80211_get_channel_khz(struct wiphy *wiphy,
 						    u32 freq)
 {
-- 
2.17.1

