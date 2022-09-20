Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808CB5BE2BA
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 12:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiITKLG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 06:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiITKKx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 06:10:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F8D5F7F9
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:10:50 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K7xg6X011091;
        Tue, 20 Sep 2022 10:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=9K+EwUuXa0toeSRdMguuObo92UDwfBJhDLFubGNUME0=;
 b=LbHGY9AHG4YO2UgIw0UChPFlszeUNRHB/aLCQV1aCc/ZVSAQaeHLECFyy0Ex4mUbc20j
 cAPqk+Rnnp2DXeX1zunIm/Jwz/U2TxyfSTaijkTcGoGuqgA+6m8yqZ/QJ1hwHpbITaX3
 uhHVg6+lD6t6AETJZ+hmJ5lMhqiZT3tBlTmJfmiWFsVoAmTECXW+XaGNxJhMCwJJed97
 Mhxjgnx/E30Fmxqr28YFGu/Cbc25GDAkVzHWdVGd4BiPON+18t/0jWSF4ZOP1d+slbny
 Ksr68yhQYBiYmJczx3TjDwboJDzj2KuBDF4m/RM2nCezKEXYI4UFI1iW2m/TF2RcUWZT Fg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jq04y247n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:10:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28KA5jIO022243
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:05:45 GMT
Received: from CDCCSTEX0180100-LIN.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 20 Sep 2022 03:05:44 -0700
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [RFC 3/4] wifi: cfg80211/mac80211: extend iface comb advertisement for multi-hardware dev
Date:   Tue, 20 Sep 2022 15:35:17 +0530
Message-ID: <20220920100518.19705-4-quic_vthiagar@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
References: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EE4GJFrP2H5G2SWidTXkcxK5MKQKm_9p
X-Proofpoint-GUID: EE4GJFrP2H5G2SWidTXkcxK5MKQKm_9p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 bulkscore=0 phishscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When driver combines multiple discrete hardware under one wiphy, it is
required for the driver to be able to advertise iface combination
capabilities per underlying physical hardware. Iface combination for each
underlying hardware is described with an identifier, the same index which
is used in wiphy->hw_chans[] to learn the channel capabilities of the
respective hardware. It should be noted that the supporting drivers also
need to signal the iface comb capabilities that are common for all the
hardware through the existing interface to maintain the backward
compatibility with the user space. Provision to advertise per physical
hardware specific iface comb capabilities and the sanity checks on the
advertised capabilities are implemented in this commit.

Example:

Say driver abstracts two discrete hardware under one wiphy,
wiphy->hw_chans[0] supporting 2 GHz and wiphy->hw_chans[1] supporting
5 GHz. Each hardware can operate on only one channel at any given time
but under the wiphy there can be concurrent interfaces on both the radios.
2 GHz hardware supports #STA <= 1, #AP <= 3 total 4 and 5 GHz hardware
supports #STA <= 1, #AP <= 4 total 5

struct ieee80211_iface_limit limits_common[] = {
	{ .max = 1, .types = BIT(NL80211_IFTYPE_STATION), },
	{ .max = 3, .types = BIT(NL80211_IFTYPE_AP), },
};

limits_common[] defines the minimum (common) capability out of all the
underlying hardware specific capabilities. This is reported in the existing
advertisement mechanism. Common max_interfaces across 2 GHz and 5 GHz is 4,
common num_different_channels is 1.

struct ieee80211_iface_limit limits_2ghz[] = {
	{ .max = 1, .types = BIT(NL80211_IFTYPE_STATION), },
	{ .max = 3, .types = BIT(NL80211_IFTYPE_AP), },
};

struct ieee80211_iface_limit limits_5ghz[] = {
	{ .max = 1, .types = BIT(NL80211_IFTYPE_STATION), },
	{ .max = 4, .types = BIT(NL80211_IFTYPE_AP), },
};

struct ieee80211_iface_combination combination = {
	.limits = limits_common,
	.max_interfaces = 4,
	.num_different_channels = 1,
	...
	.freq_range = {
			{
				.hw_chan_idx = 0,
				.limits = limits_2ghz,
				.max_interfaces = 4,
				.num_different_channels = 1,
				.n_limits = ARRAY_SIZE(limits_2ghz),
			},
			{
				.hw_chan_idx = 1,
				.limits = limits_5ghz,
				.max_interfaces = 5,
				.num_different_channels = 1,
				.n_limits = ARRAY_SIZE(limits_5ghz),
			},
		      },
};

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
---
 include/net/cfg80211.h | 106 ++++++++++++++++++++++++
 net/mac80211/main.c    |  54 +++++++++++++
 net/wireless/core.c    | 178 +++++++++++++++++++++++++++++------------
 net/wireless/util.c    |  18 +++++
 4 files changed, 307 insertions(+), 49 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4662231ad068..175c2ad4a3e8 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4726,6 +4726,32 @@ struct ieee80211_iface_limit {
 	u16 types;
 };
 
+/**
+ * struct ieee80211_iface_per_hw - hardware specific interface combination
+ *
+ * Drivers registering multiple radios under a single wiphy can advertise
+ * radio specific interface combinations through this structure. Please note
+ * that to maintain the compatibility with the user space which is not aware
+ * of this extension of per-hardware interface combination signaling,
+ * the driver should still advertise it's interface combination (mostly
+ * common minimum capability) using the existing interface combination signaling
+ * method.
+ *
+ * @hw_chans_idx: index of hardware specific channel list as per wiphy @hw_chans
+ * @limits: limits for the given interface type
+ * @num_different_channels: number of different channels which can be active
+ *	concurrently in this hardware
+ * @max_interfaces: maximum number of total interfaces allowed in this group
+ * @n_limits: number of limitations
+ */
+struct ieee80211_iface_per_hw {
+	u8 hw_chans_idx;
+	const struct ieee80211_iface_limit *limits;
+	u32 num_different_channels;
+	u16 max_interfaces;
+	u8 n_limits;
+};
+
 /**
  * struct ieee80211_iface_combination - possible interface combination
  *
@@ -4784,6 +4810,62 @@ struct ieee80211_iface_limit {
  *		.num_different_channels = 2,
  *	};
  *
+ *
+ * 4. Hardware specific interface combination with driver supporting two hw
+ *    (MAC), one underlying MAC supporting 2 GHz band and the other supporting
+ *    5 GHz band.
+ *
+ *    Allow #STA <= 1, #AP <= 1, channels = 1, total 2 in 2 GHz radio and
+ *
+ *    Allow #STA <= 1, #AP <= 2, channels = 1, total 3 in 5 GHz radio
+ *
+ *    Drivers advertising per-hardware interface combination should also
+ *    advertise a sub-set of capabilities using existing interface mainly for
+ *    maintaining compatibility with the user space which is not aware of the
+ *    new per-hardware advertisement.
+ *
+ *    Sub-set interface combination advertised in the existing infrastructure:
+ *    Allow #STA <= 1, #AP <= 1, channels = 1, total 2
+ *
+ *    .. code-block:: c
+ *
+ *	struct ieee80211_iface_limit limits4[] = {
+ *		{ .max = 1, .types = BIT(NL80211_IFTYPE_STATION), },
+ *		{ .max = 1, .types = BIT(NL80211_IFTYPE_AP), },
+ *	};
+ *	struct ieee80211_iface_limit limits5_2ghz[] = {
+ *		{ .max = 1, .types = BIT(NL80211_IFTYPE_STATION), },
+ *		{ .max = 1, .types = BIT(NL80211_IFTYPE_AP), },
+ *	};
+ *	struct ieee80211_iface_limit limits5_5ghz[] = {
+ *		{ .max = 1, .types = BIT(NL80211_IFTYPE_STATION), },
+ *		{ .max = 2, .types = BIT(NL80211_IFTYPE_AP), },
+ *	};
+ *	struct ieee80211_iface_per_hw hw_combinations[] = {
+ *		{
+ *			.hw_chans_idx = 0,
+ *			.limits = limits5_2ghz,
+ *			.num_different_channels = 1,
+ *			.max_interfaces = 2,
+ *			.n_limits = ARRAY_SIZE(limits5_2ghz),
+ *		 },
+ *		{
+ *			.hw_chans_idx = 1,
+ *			.limits = limits5_5ghz,
+ *			.num_different_channels = 1,
+ *			.max_interfaces = 3,
+ *			.n_limits = ARRAY_SIZE(limits5_5ghz),
+ *		 },
+ *	};
+ *	struct ieee80211_iface_combination combination4 = {
+ *		.limits = limits4,
+ *		.n_limits = ARRAY_SIZE(limits4),
+ *		.max_interfaces = 2,
+ *		.num_different_channels = 1,
+ *		.iface_hw_list = hw_combinations,
+ *		.n_hw_list = ARRAY_SIZE(hw_combinations),
+ *	};
+ *
  */
 struct ieee80211_iface_combination {
 	/**
@@ -4841,6 +4923,20 @@ struct ieee80211_iface_combination {
 	 *   combination must be greater or equal to this value.
 	 */
 	u32 beacon_int_min_gcd;
+
+	/**
+	 * @iface_hw_list:
+	 * This wiphy has multiple underlying radios, describe interface
+	 * combination for each of them, valid only when the driver advertises
+	 * multi-radio presence in wiphy @hw_chans.
+	 */
+	const struct ieee80211_iface_per_hw *iface_hw_list;
+
+	/**
+	 * @n_hw_list:
+	 * number of hardware in @iface_hw_List
+	 */
+	u32 n_hw_list;
 };
 
 struct ieee80211_txrx_stypes {
@@ -8791,6 +8887,16 @@ bool cfg80211_iftype_allowed(struct wiphy *wiphy, enum nl80211_iftype iftype,
 void cfg80211_assoc_comeback(struct net_device *netdev,
 			     const u8 *ap_addr, u32 timeout);
 
+/**
+ * cfg80211_hw_chans_includes_dfs - check if per-hardware channel includes DFS
+ *	@chans: hardware channel list
+ *
+ * Check if the given per-hardware list includes channels in DFS range.
+ * Please note the channel is checked against the entire range of DFS
+ * freq in 5 GHz irrespective of regulatory configurations.
+ */
+bool cfg80211_hw_chans_includes_dfs(const struct ieee80211_chans_per_hw *chans);
+
 /* Logging, debugging and troubleshooting/diagnostic helpers. */
 
 /* wiphy_printk helpers, similar to dev_printk */
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 46f3eddc2388..2e008fa976e9 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -933,6 +933,45 @@ static int ieee80211_init_cipher_suites(struct ieee80211_local *local)
 	return 0;
 }
 
+static int
+ieee80211_check_per_hw_iface_comb(struct ieee80211_local *local,
+				  const struct ieee80211_iface_combination *c)
+{
+	int h, l;
+	u32 hw_idx_bm = 0;
+
+	if (!local->use_chanctx)
+		return -EINVAL;
+
+	for (h = 0; h < c->n_hw_list; h++) {
+		const struct ieee80211_iface_per_hw *hl;
+		const struct ieee80211_chans_per_hw *chans;
+
+		hl = &c->iface_hw_list[h];
+
+		if (hl->hw_chans_idx >= local->hw.wiphy->num_hw)
+			return -EINVAL;
+
+		chans = local->hw.wiphy->hw_chans[hl->hw_chans_idx];
+		if (c->radar_detect_widths &&
+		    cfg80211_hw_chans_includes_dfs(chans) &&
+		    hl->num_different_channels > 1)
+			return -EINVAL;
+
+		for (l = 0; l < hl->n_limits; l++)
+			if ((hl->limits[l].types & BIT(NL80211_IFTYPE_ADHOC)) &&
+			    hl->limits[l].max > 1)
+				return -EINVAL;
+
+		if (hw_idx_bm & BIT(h))
+			return -EINVAL;
+
+		hw_idx_bm |= BIT(h);
+	}
+
+	return 0;
+}
+
 int ieee80211_register_hw(struct ieee80211_hw *hw)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
@@ -1035,6 +1074,21 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		}
 	}
 
+	for (i = 0; i < local->hw.wiphy->n_iface_combinations; i++) {
+		const struct ieee80211_iface_combination *comb;
+
+		comb = &local->hw.wiphy->iface_combinations[i];
+
+		if (comb->n_hw_list && !local->hw.wiphy->num_hw)
+			return -EINVAL;
+
+		if (!comb->n_hw_list)
+			continue;
+
+		if (ieee80211_check_per_hw_iface_comb(local, comb))
+			return -EINVAL;
+	}
+
 	/* Only HW csum features are currently compatible with mac80211 */
 	if (WARN_ON(hw->netdev_features & ~MAC80211_SUPPORTED_FEATURES))
 		return -EINVAL;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 4163602a1b9a..50fd7f131736 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -563,10 +563,126 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 }
 EXPORT_SYMBOL(wiphy_new_nm);
 
+static int
+wiphy_verify_comb_limit(struct wiphy *wiphy,
+			const struct ieee80211_iface_limit *limits,
+			u8 n_limits, u32 bcn_int_min_gcd, u32 *iface_cnt,
+			u16 *all_iftypes)
+{
+	int l;
+
+	for (l = 0; l < n_limits; l++) {
+		u16 types = limits[l].types;
+
+		/*
+		 * Don't advertise an unsupported type
+		 * in a combination.
+		 */
+		if (WARN_ON((wiphy->interface_modes & types) != types))
+			return -EINVAL;
+
+		/* interface types shouldn't overlap */
+		if (WARN_ON(types & *all_iftypes))
+			return -EINVAL;
+
+		*all_iftypes |= types;
+
+		/* Shouldn't list software iftypes in combinations! */
+		if (WARN_ON(wiphy->software_iftypes & types))
+			return -EINVAL;
+
+		/* Only a single P2P_DEVICE can be allowed */
+		if (WARN_ON(types & BIT(NL80211_IFTYPE_P2P_DEVICE) &&
+			    limits[l].max > 1))
+			return -EINVAL;
+
+		/* Only a single NAN can be allowed */
+		if (WARN_ON(types & BIT(NL80211_IFTYPE_NAN) &&
+			    limits[l].max > 1))
+			return -EINVAL;
+
+		/*
+		 * This isn't well-defined right now. If you have an
+		 * IBSS interface, then its beacon interval may change
+		 * by joining other networks, and nothing prevents it
+		 * from doing that.
+		 * So technically we probably shouldn't even allow AP
+		 * and IBSS in the same interface, but it seems that
+		 * some drivers support that, possibly only with fixed
+		 * beacon intervals for IBSS.
+		 */
+		if (WARN_ON(types & BIT(NL80211_IFTYPE_ADHOC) &&
+			    bcn_int_min_gcd))
+			return -EINVAL;
+
+		*iface_cnt += limits[l].max;
+	}
+
+	return 0;
+}
+
+static int
+wiphy_verify_comb_per_hw(struct wiphy *wiphy,
+			 const struct ieee80211_iface_combination *comb)
+{
+	int h;
+	u32 hw_idx_bitmap = 0;
+	int ret;
+
+	for (h = 0; h < comb->n_hw_list; h++) {
+		const struct ieee80211_iface_per_hw *hl;
+		const struct ieee80211_chans_per_hw *chans;
+		u32 iface_cnt = 0;
+		u16 all_iftypes = 0;
+
+		hl = &comb->iface_hw_list[h];
+
+		if (hl->hw_chans_idx >= wiphy->num_hw)
+			return -EINVAL;
+
+		if (hw_idx_bitmap & BIT(hl->hw_chans_idx))
+			return -EINVAL;
+
+		hw_idx_bitmap |= BIT(hl->hw_chans_idx);
+		chans = wiphy->hw_chans[hl->hw_chans_idx];
+
+		if (WARN_ON(hl->max_interfaces < 2 &&
+			    (!comb->radar_detect_widths ||
+			     !(cfg80211_hw_chans_includes_dfs(chans)))))
+			return -EINVAL;
+
+		if (WARN_ON(!hl->num_different_channels))
+			return -EINVAL;
+
+		if (WARN_ON(comb->radar_detect_widths &&
+			    cfg80211_hw_chans_includes_dfs(chans) &&
+			    hl->num_different_channels > 1))
+			return -EINVAL;
+
+		if (WARN_ON(!hl->n_limits))
+			return -EINVAL;
+
+		ret = wiphy_verify_comb_limit(wiphy, hl->limits, hl->n_limits,
+					      comb->beacon_int_min_gcd,
+					      &iface_cnt, &all_iftypes);
+		if (ret)
+			return ret;
+
+		if (WARN_ON(all_iftypes & BIT(NL80211_IFTYPE_WDS)))
+			return -EINVAL;
+
+		if (WARN_ON(iface_cnt < comb->max_interfaces))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int wiphy_verify_combinations(struct wiphy *wiphy)
 {
 	const struct ieee80211_iface_combination *c;
-	int i, j;
+	int i;
+	int ret;
 
 	for (i = 0; i < wiphy->n_iface_combinations; i++) {
 		u32 cnt = 0;
@@ -593,54 +709,11 @@ static int wiphy_verify_combinations(struct wiphy *wiphy)
 		if (WARN_ON(!c->n_limits))
 			return -EINVAL;
 
-		for (j = 0; j < c->n_limits; j++) {
-			u16 types = c->limits[j].types;
-
-			/* interface types shouldn't overlap */
-			if (WARN_ON(types & all_iftypes))
-				return -EINVAL;
-			all_iftypes |= types;
-
-			if (WARN_ON(!c->limits[j].max))
-				return -EINVAL;
-
-			/* Shouldn't list software iftypes in combinations! */
-			if (WARN_ON(wiphy->software_iftypes & types))
-				return -EINVAL;
-
-			/* Only a single P2P_DEVICE can be allowed */
-			if (WARN_ON(types & BIT(NL80211_IFTYPE_P2P_DEVICE) &&
-				    c->limits[j].max > 1))
-				return -EINVAL;
-
-			/* Only a single NAN can be allowed */
-			if (WARN_ON(types & BIT(NL80211_IFTYPE_NAN) &&
-				    c->limits[j].max > 1))
-				return -EINVAL;
-
-			/*
-			 * This isn't well-defined right now. If you have an
-			 * IBSS interface, then its beacon interval may change
-			 * by joining other networks, and nothing prevents it
-			 * from doing that.
-			 * So technically we probably shouldn't even allow AP
-			 * and IBSS in the same interface, but it seems that
-			 * some drivers support that, possibly only with fixed
-			 * beacon intervals for IBSS.
-			 */
-			if (WARN_ON(types & BIT(NL80211_IFTYPE_ADHOC) &&
-				    c->beacon_int_min_gcd)) {
-				return -EINVAL;
-			}
-
-			cnt += c->limits[j].max;
-			/*
-			 * Don't advertise an unsupported type
-			 * in a combination.
-			 */
-			if (WARN_ON((wiphy->interface_modes & types) != types))
-				return -EINVAL;
-		}
+		ret = wiphy_verify_comb_limit(wiphy, c->limits, c->n_limits,
+					      c->beacon_int_min_gcd,
+					      &cnt, &all_iftypes);
+		if (ret)
+			return ret;
 
 		if (WARN_ON(all_iftypes & BIT(NL80211_IFTYPE_WDS)))
 			return -EINVAL;
@@ -648,6 +721,13 @@ static int wiphy_verify_combinations(struct wiphy *wiphy)
 		/* You can't even choose that many! */
 		if (WARN_ON(cnt < c->max_interfaces))
 			return -EINVAL;
+		/*
+		 * Do similar validations on the freq range specific interface
+		 * combinations when advertised.
+		 */
+		if (WARN_ON(c->n_hw_list &&
+			    wiphy_verify_comb_per_hw(wiphy, c)))
+			return -EINVAL;
 	}
 
 	return 0;
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 0b28d00ba8f5..dee9bf309345 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2504,3 +2504,21 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type)
 	return NULL;
 }
 EXPORT_SYMBOL(cfg80211_get_iftype_ext_capa);
+
+bool
+cfg80211_hw_chans_includes_dfs(const struct ieee80211_chans_per_hw *chans)
+{
+	int i;
+
+	for (i = 0; i < chans->n_chans; i++) {
+		if (chans->chans[i].band == NL80211_BAND_5GHZ &&
+		    ((chans->chans[i].center_freq >= 5250 &&
+		     chans->chans[i].center_freq <= 5340) ||
+		    (chans->chans[i].center_freq >= 5480 &&
+		     chans->chans[i].center_freq <= 5720)))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(cfg80211_hw_chans_includes_dfs);
-- 
2.17.1

