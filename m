Return-Path: <linux-wireless+bounces-5437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5E088F8B9
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 08:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806681C29749
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 07:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5546535DE;
	Thu, 28 Mar 2024 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CiKosPce"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2844E1D1
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611015; cv=none; b=YqhHlgqtJC713EGKCc5paGLg/Xkd58sYoT5f36atgvTilabaGkq1e3Y1FWIQTd3bxw0m6Kv07kWVWSZEJgwEGvYANqy91Sw25A/dseij1GFpM/nj/sy1gNI38VegpcPUJ3iw5BlyHobdlOMuQiFJlGgvNg26V4JKhTe9vKbe/9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611015; c=relaxed/simple;
	bh=igWnA3U2uZ8Ccum/OpTiN2mscy1MhlLRZaC2kesF4E4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQtBTz7JVx0jJHu81fUl8qlcLjnqEEmutcQg0Z2pcc+oMM26h4EjLP4LCDeu7LO0d5MtXGCSam+KL/IYQ2y3KylTEMN6N1FmnMqtVp3/wk/aulLgBa2etSmoVfxjQfzZH4jjq3vAI5ju0VvhHWSkkqDbmB92l3CibxS8mNMWQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CiKosPce; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S4LGv4014521;
	Thu, 28 Mar 2024 07:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=D2SDNHlklnUQzCd4heMupV2hHWsQZ7S0hZa9dPOh1Co=; b=Ci
	KosPcehrwPb65eOOYWAtbWKW+fD2wBsEbsA37SKX+EZoMq+aBfzNBsi7Vn7Cfuyj
	KBlDh78GmyEz2y4vF56lHLsiMR3JfOR096IuTDQV20Y3h5aMVzC/sub4eKax1tB2
	ge/0gm50KdmvzEiBmcn9B3tHxWxAIKvDtpukGDVvgRB0SiIv2BOazG9bKFrxgI3t
	5x6wIVWCiEIFzKNoJFr0Lks8Lb1D6Z/MKCyCNRL2GFGK7CR/bNmYg+Mg1+LWQ7p1
	oQ0FKRo+zMmIeIY4V5P6XtQFPhIDaP2Cni713elSFEyjvSC35HYni8b/D1sAHVV5
	VadTPQccUWwo5we52Cow==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u20aayf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:30:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S7U4Eo000436
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:30:04 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 00:30:02 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 09/13] wifi: cfg80211: Add multi-hardware iface combination support
Date: Thu, 28 Mar 2024 12:59:12 +0530
Message-ID: <20240328072916.1164195-10-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 22xMlyFJMf5OSTxMtDzwxi1DgiQJW-ud
X-Proofpoint-GUID: 22xMlyFJMf5OSTxMtDzwxi1DgiQJW-ud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_06,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280048

From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>

Currently, the interface combination parameter supports a single physical
hardware configuration. To support multiple physical hardware interface
combination, add per hardware configuration parameters
(like num_different_channels, iftype_num[NUM_NL80211_IFTYPES]) and channel
definition for which the interface combination will be checked. Modify the
iface combination iterate helper function to retrieve the per hardware
parameters and validate the iface combination limits. For the per hardware
parameters, retrieve the respective hardware index from the channel
definition and pass them to the iterator callback.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Co-developed-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 include/net/cfg80211.h |  53 +++++++++++
 net/wireless/util.c    | 196 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 241 insertions(+), 8 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 246a8c07becf..8668b877fc3a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1585,6 +1585,23 @@ struct cfg80211_color_change_settings {
 	u8 color;
 };
 
+/**
+ * struct iface_comb_per_hw_params - HW specific interface combinations input
+ *
+ * Used to pass per-hw interface combination parameters
+ *
+ * @num_different_channels: the number of different channels we want to use
+ *	with in the per-hw supported channels.
+ * @iftype_num: array with the number of interfaces of each interface
+ *	type. The index is the interface type as specified in &enum
+ *	nl80211_iftype.
+ */
+
+struct iface_comb_per_hw_params {
+	int num_different_channels;
+	int iftype_num[NUM_NL80211_IFTYPES];
+};
+
 /**
  * struct iface_combination_params - input parameters for interface combinations
  *
@@ -1601,12 +1618,27 @@ struct cfg80211_color_change_settings {
  * @new_beacon_int: set this to the beacon interval of a new interface
  *	that's not operating yet, if such is to be checked as part of
  *	the verification
+ * @chandef: Channel definition for which the interface combination is to be
+ *	checked, when checking during interface preparation on a new channel,
+ *	for example. This will be used when the driver advertises underlying
+ *	hw specific interface combination in a multi physical hardware device.
+ *	This will be NULL when the interface combination check is not due to
+ *	channel or the interface combination does not include per-hw
+ *	advertisement.
+ * @n_per_hw: number of Per-HW interface combinations.
+ * @per_hw: @n_per_hw of hw specific interface combinations. Per-hw channel
+ *	list index as advertised in wiphy @hw_chans is used as index
+ *	in @per_hw to maintain the interface combination of the corresponding
+ *	hw.
  */
 struct iface_combination_params {
 	int num_different_channels;
 	u8 radar_detect;
 	int iftype_num[NUM_NL80211_IFTYPES];
 	u32 new_beacon_int;
+	const struct cfg80211_chan_def *chandef;
+	u8 n_per_hw;
+	const struct iface_comb_per_hw_params *per_hw;
 };
 
 /**
@@ -9236,6 +9268,27 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 					    int hw_chan_idx, void *data),
 			       void *data);
 
+/**
+ * cfg80211_per_hw_iface_comb_advertised - if per-hw iface combination supported
+ *
+ * @wiphy: the wiphy
+ *
+ * This function is used to check underlying per-hw interface combination is
+ * advertised by the driver.
+ */
+bool cfg80211_per_hw_iface_comb_advertised(struct wiphy *wiphy);
+
+/**
+ * cfg80211_get_hw_idx_by_chan - get the hw index by the channel
+ *
+ * @wiphy: the wiphy
+ * @chan: channel for which the supported hw index is required
+ *
+ * returns -1 in case the channel is not supported by any of the constituent hw
+ */
+int cfg80211_get_hw_idx_by_chan(struct wiphy *wiphy,
+				const struct ieee80211_channel *chan);
+
 /*
  * cfg80211_stop_iface - trigger interface disconnection
  *
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 39358b69dd36..635fd2637b73 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2390,6 +2390,78 @@ cfg80211_validate_iface_limits(struct wiphy *wiphy,
 	return 0;
 }
 
+static const struct ieee80211_iface_per_hw *
+cfg80211_get_hw_iface_comb_by_idx(struct wiphy *wiphy,
+				  const struct ieee80211_iface_combination *c,
+				  int idx)
+{
+	int i;
+
+	for (i = 0; i < c->n_hw_list; i++)
+		if (c->iface_hw_list[i].hw_chans_idx == idx)
+			break;
+
+	if (i == c->n_hw_list)
+		return NULL;
+
+	return &c->iface_hw_list[i];
+}
+
+static int
+cfg80211_validate_iface_comb_per_hw_limits(struct wiphy *wiphy,
+					   struct iface_combination_params *params,
+					   const struct ieee80211_iface_combination *c,
+					   u16 *num_ifaces, u32 *all_iftypes)
+{
+	struct ieee80211_iface_limit *limits;
+	const struct iface_comb_per_hw_params *per_hw;
+	const struct ieee80211_iface_per_hw *per_hw_comb;
+	int i, ret = 0;
+
+	for (i = 0; i < params->n_per_hw; i++) {
+		per_hw = &params->per_hw[i];
+
+		per_hw_comb = cfg80211_get_hw_iface_comb_by_idx(wiphy, c, i);
+		if (!per_hw_comb) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (num_ifaces[i] > per_hw_comb->max_interfaces) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (per_hw->num_different_channels >
+		    per_hw_comb->num_different_channels) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		limits = kmemdup(per_hw_comb->limits,
+				 sizeof(limits[0]) * per_hw_comb->n_limits,
+				 GFP_KERNEL);
+		if (!limits) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ret = cfg80211_validate_iface_limits(wiphy,
+						     per_hw->iftype_num,
+						     limits,
+						     per_hw_comb->n_limits,
+						     all_iftypes);
+
+		kfree(limits);
+
+		if (ret)
+			goto out;
+	}
+
+out:
+	return ret;
+}
+
 static int
 cfg80211_validate_iface_comb_limits(struct wiphy *wiphy,
 				    struct iface_combination_params *params,
@@ -2421,6 +2493,23 @@ cfg80211_validate_iface_comb_limits(struct wiphy *wiphy,
 	return ret;
 }
 
+bool cfg80211_per_hw_iface_comb_advertised(struct wiphy *wiphy)
+{
+	int i;
+
+	for (i = 0; i < wiphy->n_iface_combinations; i++)
+		if (wiphy->iface_combinations[i].n_hw_list)
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL(cfg80211_per_hw_iface_comb_advertised);
+
+static void cfg80211_put_iface_comb_iftypes(u16 *num_ifaces)
+{
+	kfree(num_ifaces);
+}
+
 static u16 cfg80211_get_iftype_info(struct wiphy *wiphy,
 				    const int iftype_num[NUM_NL80211_IFTYPES],
 				    u32 *used_iftypes)
@@ -2438,6 +2527,69 @@ static u16 cfg80211_get_iftype_info(struct wiphy *wiphy,
 	return num_interfaces;
 }
 
+static u16*
+cfg80211_get_iface_comb_iftypes(struct wiphy *wiphy,
+				struct iface_combination_params *params,
+				u32 *used_iftypes)
+{
+	const struct iface_comb_per_hw_params *per_hw;
+	u16 *num_ifaces;
+	int i;
+	u8 num_hw;
+
+	num_hw = params->n_per_hw ? params->n_per_hw : 1;
+
+	num_ifaces = kcalloc(num_hw, sizeof(*num_ifaces), GFP_KERNEL);
+	if (!num_ifaces)
+		return NULL;
+
+	if (!params->n_per_hw) {
+		num_ifaces[0] = cfg80211_get_iftype_info(wiphy,
+							 params->iftype_num,
+							 used_iftypes);
+	} else {
+		/* account per_hw interfaces, if advertised */
+		for (i = 0; i < params->n_per_hw; i++) {
+			per_hw = &params->per_hw[i];
+			num_ifaces[i] = cfg80211_get_iftype_info(wiphy,
+								 per_hw->iftype_num,
+								 used_iftypes);
+		}
+	}
+
+	return num_ifaces;
+}
+
+static bool
+cfg80211_chan_supported_by_sub_hw(const struct ieee80211_chans_per_hw *hw_chans,
+				  const struct ieee80211_channel *chan)
+{
+	int i;
+
+	for (i = 0; i < hw_chans->n_chans; i++)
+		if (chan->center_freq == hw_chans->chans[i].center_freq)
+			return true;
+
+	return false;
+}
+
+int
+cfg80211_get_hw_idx_by_chan(struct wiphy *wiphy,
+			    const struct ieee80211_channel *chan)
+{
+	int i;
+
+	if (!chan)
+		return -1;
+
+	for (i = 0; i < wiphy->num_hw; i++)
+		if (cfg80211_chan_supported_by_sub_hw(wiphy->hw_chans[i], chan))
+			return i;
+
+	return -1;
+}
+EXPORT_SYMBOL(cfg80211_get_hw_idx_by_chan);
+
 int cfg80211_iter_combinations(struct wiphy *wiphy,
 			       struct iface_combination_params *params,
 			       void (*iter)(const struct ieee80211_iface_combination *c,
@@ -2450,8 +2602,8 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 	int hw_chan_idx = -1;
 	u32 used_iftypes = 0;
 	u32 beacon_int_gcd;
-	u16 num_interfaces = 0;
-	bool beacon_int_different;
+	u16 *num_ifaces = NULL;
+	bool beacon_int_different, is_per_hw;
 	int ret = 0;
 
 	/*
@@ -2475,9 +2627,26 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 		rcu_read_unlock();
 	}
 
-	num_interfaces = cfg80211_get_iftype_info(wiphy,
-						  params->iftype_num,
-						  &used_iftypes);
+	is_per_hw = cfg80211_per_hw_iface_comb_advertised(wiphy);
+	/* check per HW validation */
+	if (params->n_per_hw) {
+		if (!is_per_hw)
+			return -EINVAL;
+
+		if (params->n_per_hw > wiphy->num_hw)
+			return -EINVAL;
+	}
+
+	if (is_per_hw && params->chandef &&
+	    cfg80211_chandef_valid(params->chandef))
+		hw_chan_idx = cfg80211_get_hw_idx_by_chan(wiphy,
+							  params->chandef->chan);
+
+	num_ifaces = cfg80211_get_iface_comb_iftypes(wiphy,
+						     params,
+						     &used_iftypes);
+	if (!num_ifaces)
+		return -ENOMEM;
 
 	for (i = 0; i < wiphy->n_iface_combinations; i++) {
 		const struct ieee80211_iface_combination *c;
@@ -2485,9 +2654,18 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 
 		c = &wiphy->iface_combinations[i];
 
-		ret = cfg80211_validate_iface_comb_limits(wiphy, params,
-							  c, num_interfaces,
-							  &all_iftypes);
+		if (params->n_per_hw)
+			ret = cfg80211_validate_iface_comb_per_hw_limits(wiphy,
+									 params,
+									 c,
+									 num_ifaces,
+									 &all_iftypes);
+		else
+			ret = cfg80211_validate_iface_comb_limits(wiphy,
+								  params,
+								  c,
+								  num_ifaces[0],
+								  &all_iftypes);
 		if (ret == -ENOMEM) {
 			break;
 		} else if (ret) {
@@ -2526,6 +2704,8 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 		(*iter)(c, hw_chan_idx, data);
 	}
 
+	cfg80211_put_iface_comb_iftypes(num_ifaces);
+
 	return ret;
 }
 EXPORT_SYMBOL(cfg80211_iter_combinations);
-- 
2.34.1


