Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E896A7C3F
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Mar 2023 09:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCBIG5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Mar 2023 03:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCBIGs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Mar 2023 03:06:48 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E1335260
        for <linux-wireless@vger.kernel.org>; Thu,  2 Mar 2023 00:06:44 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3227wIHa029316;
        Thu, 2 Mar 2023 08:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=uVkwwFQG6mu5QRFEUDbr4LhKm8tFhaORdOj4T1x+sHU=;
 b=ha9d3o0SPzO1S21IywGnSEZyxbtBLwrdUq9VtuF7u2sfkyZ+oHkppVOG4Qh5H+KlV007
 zxqvzCR2Zozaibdkq0Q4fQ+wXYz3W+dxIN2eZSBWw9u5Qc+XoJIxzQK0msv8672+2ntG
 PIYYwg2w3gThshk+8Br1I9B/mFz87rpbPNyLmoh4dzREkZpigNF4YYSYdvdbE5tcaaVR
 METqt2nJaJJjm2ZN6gmoxY08YcEx/VfG8k65ANWuipR0JFPCuKdKS1738B4EizyZdSKw
 mrTJDvI/3/Rujb1I4YrWRWldxxbZ4YsuXw6z7+lCUqPl2Hkvye+je71km3HQbmZYvaFd 5A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p25jwjtf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 08:06:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 322862R9016238
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 08:06:02 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 2 Mar 2023 00:06:00 -0800
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v2 5/7] wifi: mac80211: add support for 6 GHz channels and regulatory
Date:   Thu, 2 Mar 2023 13:35:32 +0530
Message-ID: <20230302080534.22821-6-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230302080534.22821-1-quic_adisi@quicinc.com>
References: <20230302080534.22821-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q9aY1-nbxKW5DVAVocsOq9t1EJcAcT5T
X-Proofpoint-ORIG-GUID: q9aY1-nbxKW5DVAVocsOq9t1EJcAcT5T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_03,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303020069
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 net/wireless/reg.c       | 44 ++++++++++++++++++++++++++++++++--------
 net/wireless/util.c      | 27 ++++++++++++++++++++++++
 5 files changed, 134 insertions(+), 9 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a823b34120aa..4675a6feb09b 100644
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
+			    *channels_6ghz[NL80211_REG_PWR_MODE_MAX];
 	struct ieee80211_rate *bitrates;
 	enum nl80211_band band;
 	int n_channels;
@@ -6074,6 +6092,19 @@ ieee80211_get_channel(struct wiphy *wiphy, int freq)
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
index c2bf0b39fd1e..93402ccf366c 100644
--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -221,6 +221,7 @@ struct ieee80211_reg_rule {
 	struct ieee80211_freq_range freq_range;
 	struct ieee80211_power_rule power_rule;
 	struct ieee80211_wmm_rule wmm_rule;
+	enum nl80211_regulatory_power_modes power_mode;
 	u32 flags;
 	u32 dfs_cac_ms;
 	bool has_wmm;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 1a28fe5cb614..9ddbc02571c1 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3676,6 +3676,9 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 	bool support_80_80, support_160, support_320;
 	u8 he_phy_cap, eht_phy_cap;
 	u32 freq;
+	enum ieee80211_ap_reg_power reg_6ghz_power_beacon, reg_6ghz_ap_power;
+	enum ieee80211_client_reg_power reg_6ghz_client_power;
+	enum nl80211_regulatory_power_modes reg_6ghz_power_final;
 
 	if (chandef->chan->band != NL80211_BAND_6GHZ)
 		return true;
@@ -3718,6 +3721,39 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
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
+		reg_6ghz_ap_power =
+			sdata->wdev.links[bss_conf->link_id].ap.power_mode_6ghz;
+		reg_6ghz_power_final =
+			ieee80211_ap_reg_power_to_reg_power_mode(reg_6ghz_ap_power);
+	} else {
+		reg_6ghz_client_power =
+			sdata->wdev.links[bss_conf->link_id].client.power_mode_6ghz;
+		reg_6ghz_power_final =
+		     ieee80211_client_reg_power_to_reg_power_mode(reg_6ghz_client_power,
+								  reg_6ghz_power_beacon);
+	}
+
 	/*
 	 * The EHT operation IE does not contain the primary channel so the
 	 * primary channel frequency should be taken from the 6 GHz operation
@@ -3725,7 +3761,9 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
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
index 452e0085ed2c..c5bf3c9abdb1 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1594,7 +1594,8 @@ static u32 map_regdom_flags(u32 rd_flags)
 
 static const struct ieee80211_reg_rule *
 freq_reg_info_regd(u32 center_freq,
-		   const struct ieee80211_regdomain *regd, u32 bw)
+		   const struct ieee80211_regdomain *regd, u32 bw,
+		   enum nl80211_regulatory_power_modes power_mode)
 {
 	int i;
 	bool band_rule_found = false;
@@ -1608,7 +1609,12 @@ freq_reg_info_regd(u32 center_freq,
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
@@ -1640,7 +1646,8 @@ __freq_reg_info(struct wiphy *wiphy, u32 center_freq, u32 min_bw)
 	u32 bw;
 
 	for (bw = MHZ_TO_KHZ(bws[i]); bw >= min_bw; bw = MHZ_TO_KHZ(bws[i--])) {
-		reg_rule = freq_reg_info_regd(center_freq, regd, bw);
+		reg_rule = freq_reg_info_regd(center_freq, regd, bw,
+					      NL80211_REG_PWR_MODE_AP_LPI);
 		if (!IS_ERR(reg_rule))
 			return reg_rule;
 	}
@@ -2292,7 +2299,8 @@ static void reg_process_ht_flags_channel(struct wiphy *wiphy,
 	if (regd) {
 		const struct ieee80211_reg_rule *reg_rule =
 			freq_reg_info_regd(MHZ_TO_KHZ(channel->center_freq),
-					   regd, MHZ_TO_KHZ(20));
+					   regd, MHZ_TO_KHZ(20),
+					   NL80211_REG_PWR_MODE_AP_LPI);
 
 		if (!IS_ERR(reg_rule))
 			flags = reg_rule->flags;
@@ -2535,7 +2543,8 @@ static void update_all_wiphy_regulatory(enum nl80211_reg_initiator initiator)
 static void handle_channel_custom(struct wiphy *wiphy,
 				  struct ieee80211_channel *chan,
 				  const struct ieee80211_regdomain *regd,
-				  u32 min_bw)
+				  u32 min_bw,
+				  enum nl80211_regulatory_power_modes power_mode)
 {
 	u32 bw_flags = 0;
 	const struct ieee80211_reg_rule *reg_rule = NULL;
@@ -2544,7 +2553,7 @@ static void handle_channel_custom(struct wiphy *wiphy,
 
 	center_freq_khz = ieee80211_channel_to_khz(chan);
 	for (bw = MHZ_TO_KHZ(20); bw >= min_bw; bw = bw / 2) {
-		reg_rule = freq_reg_info_regd(center_freq_khz, regd, bw);
+		reg_rule = freq_reg_info_regd(center_freq_khz, regd, bw, power_mode);
 		if (!IS_ERR(reg_rule))
 			break;
 	}
@@ -2596,11 +2605,29 @@ static void handle_band_custom(struct wiphy *wiphy,
 			       struct ieee80211_supported_band *sband,
 			       const struct ieee80211_regdomain *regd)
 {
-	unsigned int i;
+	unsigned int i, j;
+	bool channels_6ghz_present = false;
 
 	if (!sband)
 		return;
 
+	if (sband->band == NL80211_BAND_6GHZ) {
+		for (i = 0; i < NL80211_REG_PWR_MODE_MAX; i++) {
+			if (!sband->channels_6ghz[i])
+				continue;
+
+			channels_6ghz_present = true;
+
+			for (j = 0; j < sband->channels_6ghz[i]->n_channels; j++)
+				handle_channel_custom(wiphy,
+						      &sband->channels_6ghz[i]->channels[j],
+						      regd, MHZ_TO_KHZ(20), i);
+		}
+
+		if (channels_6ghz_present)
+			return;
+	}
+
 	/*
 	 * We currently assume that you always want at least 20 MHz,
 	 * otherwise channel 12 might get enabled if this rule is
@@ -2608,7 +2635,8 @@ static void handle_band_custom(struct wiphy *wiphy,
 	 */
 	for (i = 0; i < sband->n_channels; i++)
 		handle_channel_custom(wiphy, &sband->channels[i], regd,
-				      MHZ_TO_KHZ(20));
+				      MHZ_TO_KHZ(20),
+				      NL80211_REG_PWR_MODE_AP_LPI);
 }
 
 /* Used by drivers prior to wiphy registration */
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 56a23e5797f4..266ce51b2f7b 100644
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
+	if (!sband || power_mode >= NL80211_REG_PWR_MODE_MAX)
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

