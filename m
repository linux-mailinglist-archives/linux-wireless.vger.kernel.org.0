Return-Path: <linux-wireless+bounces-5441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ECE88F8BF
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 08:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45A61C29787
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 07:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5579853E1F;
	Thu, 28 Mar 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lDJoto8E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E4452F96
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611021; cv=none; b=ePBKAnKIpZeqsSSEVrfZ1YSmK+tckQSgPO5f6x65coVXg45lousY4/fh75pXe+oaSxCxStp5sRqHD/BTyo5OkVtkiJy6Xlht4KxhmAlo33kEC9pB6nqzMgfBZl3a78Rd1V9pt8Ezy4jUIjtGIMOLfBRs9UOCpWuukDLmGzNRrIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611021; c=relaxed/simple;
	bh=qdM8CKRYFSCyshP+cMf59eT93klHlq7hXGwWaAUtRoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaUQ3jWYjysLsLZfQ+RIqNV6pHfqFituZ9VlPtgcvoza7OzO0JDd3nrixxvZYlcbjHLY6qfSK19QhJxyn72iXwzHJzWeI5QazMBD5zpGdowkFgVA+9Ed6ANrxp92FwTyRZbeFA1mfk54iZ6nP/49DnE4NaQCSwiaJhqGlxzJ32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lDJoto8E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S4fvOO028796;
	Thu, 28 Mar 2024 07:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mY1WVvWUa3DboJH7ADBJXhfPU1+y1DUVM8FJmgvcp5c=; b=lD
	Joto8EKp/iWLahwxY9QwfJo8AM0RDDdnABZm59tpMh2wQ88Vjjuj48iGyxvMcmwL
	P0Ps0QpbKcrZ8RIP8i7E+eOwNokDZtzOuOnZpFqYvbJg9RINAizRk2CVqOHPlUcu
	LvahHjGN/yuoano/iFitIhWhwQjCpidRyPq1AffOsS6stjRcyhIbBjk9wleAR/ON
	NR2YogFt/oM7wjBztupakgz3Y2OAOrvTgdhmTbrioM63qtYFtmAQlUvlHyqCw3Wl
	t0njH5hobSUQTKR9zwIt4lXnd/SYJo8RLzdDEhtBVRwpiaMzs2t0kzOBZt2AbF2I
	T4sbqbfZUurgkAjHFhTQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1wjb37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:30:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S7Tq5C003687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:29:52 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 00:29:50 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 04/13] wifi: cfg80211/mac80211: extend iface comb advertisement for multi-hardware dev
Date: Thu, 28 Mar 2024 12:59:07 +0530
Message-ID: <20240328072916.1164195-5-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0fbya7M05UqIpQYjoHfhDZLh47dPUnuS
X-Proofpoint-ORIG-GUID: 0fbya7M05UqIpQYjoHfhDZLh47dPUnuS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_06,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280048

From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>

As originally discussed in the RFC [1], when a driver combines multiple
discrete hardware under one wiphy, it is required for the driver to be
able to advertise iface combination capabilities per underlying physical
hardware. Each underlying hardware's iface combination is described with
an identifier, which corresponds to the same index used in
wiphy->hw_chans[] to learn the channel capabilities of the respective
hardware. It’s important to note that supporting drivers also signal the
iface combination capabilities that are common for all the hardware
through the existing interface, maintaining backward compatibility with
user space. This commit implements provisions to advertise per-physical
hardware specific iface combination capabilities and includes sanity
checks on the advertised capabilities. The sanity check includes channel
validation against the entire range of DFS frequencies, irrespective of
regulatory configurations.

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

[1]: https://lore.kernel.org/linux-wireless/20220920100518.19705-4-quic_vthiagar@quicinc.com/

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Co-developed-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 include/net/cfg80211.h | 96 ++++++++++++++++++++++++++++++++++++++++++
 net/mac80211/main.c    | 46 ++++++++++++++++++++
 net/wireless/core.c    | 92 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index dde129e61b60..491d074fe430 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5030,6 +5030,32 @@ struct ieee80211_iface_limit {
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
+ * @limits: limits for the given interface type
+ * @num_different_channels: number of different channels which can be active
+ *	concurrently in this hardware
+ * @max_interfaces: maximum number of total interfaces allowed in this group
+ * @n_limits: number of limitations
+ * @hw_chans_idx: index of hardware specific channel list as per wiphy @hw_chans
+ */
+struct ieee80211_iface_per_hw {
+	const struct ieee80211_iface_limit *limits;
+	u32 num_different_channels;
+	u16 max_interfaces;
+	u8 n_limits;
+	u8 hw_chans_idx;
+};
+
 /**
  * struct ieee80211_iface_combination - possible interface combination
  *
@@ -5088,6 +5114,62 @@ struct ieee80211_iface_limit {
  *		.num_different_channels = 2,
  *	};
  *
+ *
+ * 4. Hardware specific interface combination with driver supporting two
+ *    physical HW, first underlying HW supporting 2 GHz band and the other
+ *    supporting 5 GHz band.
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
+ *	struct ieee80211_iface_limit limits_overall[] = {
+ *		{ .max = 1, .types = BIT(NL80211_IFTYPE_STATION), },
+ *		{ .max = 1, .types = BIT(NL80211_IFTYPE_AP), },
+ *	};
+ *	struct ieee80211_iface_limit limits_2ghz[] = {
+ *		{ .max = 1, .types = BIT(NL80211_IFTYPE_STATION), },
+ *		{ .max = 1, .types = BIT(NL80211_IFTYPE_AP), },
+ *	};
+ *	struct ieee80211_iface_limit limits_5ghz[] = {
+ *		{ .max = 1, .types = BIT(NL80211_IFTYPE_STATION), },
+ *		{ .max = 2, .types = BIT(NL80211_IFTYPE_AP), },
+ *	};
+ *	struct ieee80211_iface_per_hw hw_combinations[] = {
+ *		{
+ *			.hw_chans_idx = 0,
+ *			.limits = limits_2ghz,
+ *			.num_different_channels = 1,
+ *			.max_interfaces = 2,
+ *			.n_limits = ARRAY_SIZE(limits_2ghz),
+ *		 },
+ *		{
+ *			.hw_chans_idx = 1,
+ *			.limits = limits_5ghz,
+ *			.num_different_channels = 1,
+ *			.max_interfaces = 3,
+ *			.n_limits = ARRAY_SIZE(limits_5ghz),
+ *		 },
+ *	};
+ *	struct ieee80211_iface_combination combination4 = {
+ *		.limits = limits_overall,
+ *		.n_limits = ARRAY_SIZE(limits_overall),
+ *		.max_interfaces = 2,
+ *		.num_different_channels = 1,
+ *		.iface_hw_list = hw_combinations,
+ *		.n_hw_list = ARRAY_SIZE(hw_combinations),
+ *	};
+ *
  */
 struct ieee80211_iface_combination {
 	/**
@@ -5145,6 +5227,20 @@ struct ieee80211_iface_combination {
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
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 4eaea0a9975b..24765ab5121b 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1083,6 +1083,46 @@ static int ieee80211_init_cipher_suites(struct ieee80211_local *local)
 	return 0;
 }
 
+static int
+ieee80211_check_per_hw_iface_comb(struct ieee80211_local *local,
+				  const struct ieee80211_iface_combination *c)
+{
+	int hw_idx, lmt_idx;
+	u32 hw_idx_bm = 0;
+
+	if (!local->hw.wiphy->num_hw)
+		return -EINVAL;
+
+	if (local->emulate_chanctx)
+		return -EINVAL;
+
+	for (hw_idx = 0; hw_idx < c->n_hw_list; hw_idx++) {
+		const struct ieee80211_iface_per_hw *hl;
+
+		hl = &c->iface_hw_list[hw_idx];
+
+		if (hl->hw_chans_idx >= local->hw.wiphy->num_hw)
+			return -EINVAL;
+
+		/* mac80211 doesn't support more than one IBSS interface right now */
+		for (lmt_idx = 0; lmt_idx < hl->n_limits; lmt_idx++) {
+			const struct ieee80211_iface_limit *limits;
+
+			limits = &hl->limits[lmt_idx];
+			if ((limits->types & BIT(NL80211_IFTYPE_ADHOC)) &&
+			    limits->max > 1)
+				return -EINVAL;
+		}
+
+		if (hw_idx_bm & BIT(hw_idx))
+			return -EINVAL;
+
+		hw_idx_bm |= BIT(hw_idx);
+	}
+
+	return 0;
+}
+
 int ieee80211_register_hw(struct ieee80211_hw *hw)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
@@ -1323,6 +1363,12 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			if ((c->limits[j].types & BIT(NL80211_IFTYPE_ADHOC)) &&
 			    c->limits[j].max > 1)
 				return -EINVAL;
+
+		if (!c->n_hw_list)
+			continue;
+
+		if (ieee80211_check_per_hw_iface_comb(local, c))
+			return -EINVAL;
 	}
 
 	local->int_scan_req = kzalloc(sizeof(*local->int_scan_req) +
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 2b810855a805..88de2839ed6b 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -600,6 +600,34 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 }
 EXPORT_SYMBOL(wiphy_new_nm);
 
+/**
+ * cfg80211_hw_chans_includes_dfs - check if per-hardware channel includes DFS
+ * @chans: hardware channel list
+ *
+ * Check if the given per-hardware list include channels in DFS range.
+ * Please note the channel is checked against the entire range of DFS
+ * freq in 5 GHz irrespective of regulatory configurations.
+ *
+ * This helper helps for the sanity checks on the channel advertisement from
+ * driver during the hw registration.
+ */
+static bool
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
+
 static int
 wiphy_verify_comb_limit(struct wiphy *wiphy,
 			const struct ieee80211_iface_limit *limits,
@@ -659,6 +687,63 @@ wiphy_verify_comb_limit(struct wiphy *wiphy,
 	return 0;
 }
 
+static int
+wiphy_verify_comb_per_hw(struct wiphy *wiphy,
+			 const struct ieee80211_iface_combination *comb)
+{
+	int i;
+	u32 hw_idx_bitmap = 0;
+	int ret;
+
+	for (i = 0; i < comb->n_hw_list; i++) {
+		const struct ieee80211_iface_per_hw *hl;
+		const struct ieee80211_chans_per_hw *chans;
+		u32 iface_cnt = 0;
+		u16 all_iftypes = 0;
+
+		hl = &comb->iface_hw_list[i];
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
@@ -701,6 +786,13 @@ static int wiphy_verify_combinations(struct wiphy *wiphy)
 		/* You can't even choose that many! */
 		if (WARN_ON(cnt < c->max_interfaces))
 			return -EINVAL;
+
+		/* Do similar validations on the freq range specific interface
+		 * combinations when advertised.
+		 */
+		if (WARN_ON(c->n_hw_list &&
+			    wiphy_verify_comb_per_hw(wiphy, c)))
+			return -EINVAL;
 	}
 
 	return 0;
-- 
2.34.1


