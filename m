Return-Path: <linux-wireless+bounces-17225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D73A06D61
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 06:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA41F18885DF
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 05:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4D5210F6B;
	Thu,  9 Jan 2025 05:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fypZISgk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A449C13A26D
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 05:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736399081; cv=none; b=jSjE1k5ih014AfqYNbBj2gEdtLNvrmKu3NSjnGd8UNi/817EQzEPJcBlUsYi67VAbsfxOKO+279VxR9JVMRMhtEEqCeDXPAFay3l64Y0HqeYnTuQ6JFpjzFDKUyTXJJ13PXXF87as5TsW7GdViRKktkCd6pE+SU3Azrqdc8JWzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736399081; c=relaxed/simple;
	bh=vHTaLwEnkL1EJajq/EyWpm1IXyrgO5O7YYA3MzHPk+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CkqKoNv31CtqC5UTnxeBQZIgIgq71NR/myQjwERQG/RqZNmEA8rUrMNvkZwI9K0a+ZFJCmD5yCENdbEBZJrj+7GmwlaUoih+aavmApU2oK7mXsneOi6OszL4S5phZPJ0UkqPLKXaTQ19K2/SJ7U+LksEolx/uRCO+p9egbrjMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fypZISgk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5094i8JL020566;
	Thu, 9 Jan 2025 05:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=U4ErO6gNzzN++4oKhxdTc3bVj2qZXjo00uK3j5SjV1g=; b=fy
	pZISgkRTjS0oUB4LK+72t8o2Za33QXyLchEp1Fk6MmvHfgIm9CDOpOEUeHfSNxe+
	OnScIGqJZXcDL2TcyipFTvw/lJmy4Oq6t6RFdx4aMhASl/Ai+I6A7l3BBEvQJhey
	dJwXSnMbz9GahFnMmikB3VotWLqtl4udBugysPbUHophIXwQiUgcdNE1AEA0SzU0
	qnmqQBUHz5filADvoywxBMvh4WUIygBKk5BbqNBx/2eHD+QByU/gMdKhpM22Hi69
	hmnASYKJIpKHh1vRNcjJ5g9gxFStnpAbDDsCLBErY2CYOCJ3lvcBidkuo3e4976f
	JZ96+JjyI9o/bGLUNTfA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4427nwr171-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 05:04:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50954Wur008792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 05:04:32 GMT
Received: from hu-kkavita-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 Jan 2025 21:04:30 -0800
From: Kavita Kavita <quic_kkavita@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_kkavita@quicinc.com>,
        <quic_mpaluri@quicinc.com>
Subject: [PATCH v3] wifi: cfg80211: skip regulatory for punctured subchannels
Date: Thu, 9 Jan 2025 10:34:09 +0530
Message-ID: <20250109050409.25351-1-quic_kkavita@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: APvAn9hohrQaEGbqsLNYR1qG2Vg6eyt1
X-Proofpoint-GUID: APvAn9hohrQaEGbqsLNYR1qG2Vg6eyt1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090039

The kernel performs several regulatory checks for AP mode in
nl80211/cfg80211. These checks include radar detection,
verification of whether the sub-channel is disabled, and
an examination to determine if the channel is a DFS channel
(both DFS usable and DFS available). These checks are
performed across a frequency range, examining each sub-channel.

However, these checks are also performed on subchannels that
have been punctured which should not be examined as they are
not in use.

This leads to the issue where the AP stops because one of
the 20 MHz sub-channels is disabled or radar detected on
the channel, even when the sub-channel is punctured.

To address this issue, add a condition check wherever
regulatory checks exist for AP mode in nl80211/cfg80211.
This check identifies punctured channels and, upon finding
them, skips the regulatory checks for those channels.

Co-developed-by: Manaswini Paluri <quic_mpaluri@quicinc.com>
Signed-off-by: Manaswini Paluri <quic_mpaluri@quicinc.com>
Signed-off-by: Kavita Kavita <quic_kkavita@quicinc.com>
---
Changes in v3:
- Modified macro "for_each_subchan" for traversing non punctured channels.
- Skip setting dfs state for punctured channels.
- Handled both cf1 and cf2 cases together
Changes in v2:
- Added macro "for_each_subchan" for traversing non punctured channels.
- Skip setting dfs state for punctured channels.
- for center_freq2, pass 0 as punctured bitmap.
---

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 833ea73053a4..9f918b77b40e 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -55,6 +55,56 @@ void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
 }
 EXPORT_SYMBOL(cfg80211_chandef_create);
 
+static int cfg80211_chandef_get_width(const struct cfg80211_chan_def *c)
+{
+	return nl80211_chan_width_to_mhz(c->width);
+}
+
+static u32 cfg80211_get_start_freq(const struct cfg80211_chan_def *chandef,
+				   u32 cf)
+{
+	u32 start_freq, center_freq, bandwidth;
+
+	center_freq = MHZ_TO_KHZ((cf == 1) ?
+			chandef->center_freq1 : chandef->center_freq2);
+	bandwidth = MHZ_TO_KHZ(cfg80211_chandef_get_width(chandef));
+
+	if (bandwidth <= MHZ_TO_KHZ(20))
+		start_freq = center_freq;
+	else
+		start_freq = center_freq - bandwidth / 2 + MHZ_TO_KHZ(10);
+
+	return start_freq;
+}
+
+static u32 cfg80211_get_end_freq(const struct cfg80211_chan_def *chandef,
+				 u32 cf)
+{
+	u32 end_freq, center_freq, bandwidth;
+
+	center_freq = MHZ_TO_KHZ((cf == 1) ?
+			chandef->center_freq1 : chandef->center_freq2);
+	bandwidth = MHZ_TO_KHZ(cfg80211_chandef_get_width(chandef));
+
+	if (bandwidth <= MHZ_TO_KHZ(20))
+		end_freq = center_freq;
+	else
+		end_freq = center_freq + bandwidth / 2 - MHZ_TO_KHZ(10);
+
+	return end_freq;
+}
+
+#define for_each_subchan(chandef, freq, cf)				\
+	for (u32 punctured = chandef->punctured,			\
+	     cf = 1, freq = cfg80211_get_start_freq(chandef, cf);	\
+	     freq <= cfg80211_get_end_freq(chandef, cf);		\
+	     freq += MHZ_TO_KHZ(20),					\
+	     ((cf == 1 && chandef->center_freq2 != 0 &&			\
+	       freq > cfg80211_get_end_freq(chandef, cf)) ?		\
+	      (cf++, freq = cfg80211_get_start_freq(chandef, cf),	\
+	       punctured = 0) : (punctured >>= 1)))			\
+		if (!(punctured & 1))
+
 struct cfg80211_per_bw_puncturing_values {
 	u8 len;
 	const u16 *valid_values;
@@ -258,11 +308,6 @@ int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
 }
 EXPORT_SYMBOL(nl80211_chan_width_to_mhz);
 
-static int cfg80211_chandef_get_width(const struct cfg80211_chan_def *c)
-{
-	return nl80211_chan_width_to_mhz(c->width);
-}
-
 static bool cfg80211_valid_center_freq(u32 center,
 				       enum nl80211_chan_width width)
 {
@@ -582,29 +627,11 @@ cfg80211_chandef_compatible(const struct cfg80211_chan_def *c1,
 }
 EXPORT_SYMBOL(cfg80211_chandef_compatible);
 
-static void cfg80211_set_chans_dfs_state(struct wiphy *wiphy, u32 center_freq,
-					 u32 bandwidth,
-					 enum nl80211_dfs_state dfs_state)
-{
-	struct ieee80211_channel *c;
-	u32 freq;
-
-	for (freq = center_freq - bandwidth/2 + 10;
-	     freq <= center_freq + bandwidth/2 - 10;
-	     freq += 20) {
-		c = ieee80211_get_channel(wiphy, freq);
-		if (!c || !(c->flags & IEEE80211_CHAN_RADAR))
-			continue;
-
-		c->dfs_state = dfs_state;
-		c->dfs_state_entered = jiffies;
-	}
-}
-
 void cfg80211_set_dfs_state(struct wiphy *wiphy,
 			    const struct cfg80211_chan_def *chandef,
 			    enum nl80211_dfs_state dfs_state)
 {
+	struct ieee80211_channel *c;
 	int width;
 
 	if (WARN_ON(!cfg80211_chandef_valid(chandef)))
@@ -614,41 +641,14 @@ void cfg80211_set_dfs_state(struct wiphy *wiphy,
 	if (width < 0)
 		return;
 
-	cfg80211_set_chans_dfs_state(wiphy, chandef->center_freq1,
-				     width, dfs_state);
-
-	if (!chandef->center_freq2)
-		return;
-	cfg80211_set_chans_dfs_state(wiphy, chandef->center_freq2,
-				     width, dfs_state);
-}
-
-static u32 cfg80211_get_start_freq(u32 center_freq,
-				   u32 bandwidth)
-{
-	u32 start_freq;
-
-	bandwidth = MHZ_TO_KHZ(bandwidth);
-	if (bandwidth <= MHZ_TO_KHZ(20))
-		start_freq = center_freq;
-	else
-		start_freq = center_freq - bandwidth / 2 + MHZ_TO_KHZ(10);
-
-	return start_freq;
-}
-
-static u32 cfg80211_get_end_freq(u32 center_freq,
-				 u32 bandwidth)
-{
-	u32 end_freq;
-
-	bandwidth = MHZ_TO_KHZ(bandwidth);
-	if (bandwidth <= MHZ_TO_KHZ(20))
-		end_freq = center_freq;
-	else
-		end_freq = center_freq + bandwidth / 2 - MHZ_TO_KHZ(10);
+	for_each_subchan(chandef, freq, cf) {
+		c = ieee80211_get_channel_khz(wiphy, freq);
+		if (!c || !(c->flags & IEEE80211_CHAN_RADAR))
+			continue;
 
-	return end_freq;
+		c->dfs_state = dfs_state;
+		c->dfs_state_entered = jiffies;
+	}
 }
 
 static bool
@@ -725,17 +725,12 @@ static bool cfg80211_dfs_permissive_chan(struct wiphy *wiphy,
 }
 
 static int cfg80211_get_chans_dfs_required(struct wiphy *wiphy,
-					    u32 center_freq,
-					    u32 bandwidth,
-					    enum nl80211_iftype iftype)
+					   const struct cfg80211_chan_def *chandef,
+					   enum nl80211_iftype iftype)
 {
 	struct ieee80211_channel *c;
-	u32 freq, start_freq, end_freq;
-
-	start_freq = cfg80211_get_start_freq(center_freq, bandwidth);
-	end_freq = cfg80211_get_end_freq(center_freq, bandwidth);
 
-	for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
+	for_each_subchan(chandef, freq, cf) {
 		c = ieee80211_get_channel_khz(wiphy, freq);
 		if (!c)
 			return -EINVAL;
@@ -768,25 +763,9 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 		if (width < 0)
 			return -EINVAL;
 
-		ret = cfg80211_get_chans_dfs_required(wiphy,
-					ieee80211_chandef_to_khz(chandef),
-					width, iftype);
-		if (ret < 0)
-			return ret;
-		else if (ret > 0)
-			return BIT(chandef->width);
-
-		if (!chandef->center_freq2)
-			return 0;
-
-		ret = cfg80211_get_chans_dfs_required(wiphy,
-					MHZ_TO_KHZ(chandef->center_freq2),
-					width, iftype);
-		if (ret < 0)
-			return ret;
-		else if (ret > 0)
-			return BIT(chandef->width);
+		ret = cfg80211_get_chans_dfs_required(wiphy, chandef, iftype);
 
+		return (ret > 0) ? BIT(chandef->width) : ret;
 		break;
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_OCB:
@@ -806,16 +785,18 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(cfg80211_chandef_dfs_required);
 
-static int cfg80211_get_chans_dfs_usable(struct wiphy *wiphy,
-					 u32 center_freq,
-					 u32 bandwidth)
+bool cfg80211_chandef_dfs_usable(struct wiphy *wiphy,
+				 const struct cfg80211_chan_def *chandef)
 {
 	struct ieee80211_channel *c;
-	u32 freq, start_freq, end_freq;
-	int count = 0;
+	int width, count = 0;
 
-	start_freq = cfg80211_get_start_freq(center_freq, bandwidth);
-	end_freq = cfg80211_get_end_freq(center_freq, bandwidth);
+	if (WARN_ON(!cfg80211_chandef_valid(chandef)))
+		return false;
+
+	width = cfg80211_chandef_get_width(chandef);
+	if (width < 0)
+		return false;
 
 	/*
 	 * Check entire range of channels for the bandwidth.
@@ -823,61 +804,24 @@ static int cfg80211_get_chans_dfs_usable(struct wiphy *wiphy,
 	 * DFS_AVAILABLE). Return number of usable channels
 	 * (require CAC). Allow DFS and non-DFS channel mix.
 	 */
-	for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
+	for_each_subchan(chandef, freq, cf) {
 		c = ieee80211_get_channel_khz(wiphy, freq);
 		if (!c)
-			return -EINVAL;
+			return false;
 
 		if (c->flags & IEEE80211_CHAN_DISABLED)
-			return -EINVAL;
+			return false;
 
 		if (c->flags & IEEE80211_CHAN_RADAR) {
 			if (c->dfs_state == NL80211_DFS_UNAVAILABLE)
-				return -EINVAL;
+				return false;
 
 			if (c->dfs_state == NL80211_DFS_USABLE)
 				count++;
 		}
 	}
 
-	return count;
-}
-
-bool cfg80211_chandef_dfs_usable(struct wiphy *wiphy,
-				 const struct cfg80211_chan_def *chandef)
-{
-	int width;
-	int r1, r2 = 0;
-
-	if (WARN_ON(!cfg80211_chandef_valid(chandef)))
-		return false;
-
-	width = cfg80211_chandef_get_width(chandef);
-	if (width < 0)
-		return false;
-
-	r1 = cfg80211_get_chans_dfs_usable(wiphy,
-					   MHZ_TO_KHZ(chandef->center_freq1),
-					   width);
-
-	if (r1 < 0)
-		return false;
-
-	switch (chandef->width) {
-	case NL80211_CHAN_WIDTH_80P80:
-		WARN_ON(!chandef->center_freq2);
-		r2 = cfg80211_get_chans_dfs_usable(wiphy,
-					MHZ_TO_KHZ(chandef->center_freq2),
-					width);
-		if (r2 < 0)
-			return false;
-		break;
-	default:
-		WARN_ON(chandef->center_freq2);
-		break;
-	}
-
-	return (r1 + r2 > 0);
+	return count > 0;
 }
 EXPORT_SYMBOL(cfg80211_chandef_dfs_usable);
 
@@ -1051,26 +995,29 @@ bool cfg80211_any_wiphy_oper_chan(struct wiphy *wiphy,
 	return false;
 }
 
-static bool cfg80211_get_chans_dfs_available(struct wiphy *wiphy,
-					     u32 center_freq,
-					     u32 bandwidth)
+static bool cfg80211_chandef_dfs_available(struct wiphy *wiphy,
+				const struct cfg80211_chan_def *chandef)
 {
 	struct ieee80211_channel *c;
-	u32 freq, start_freq, end_freq;
+	int width;
 	bool dfs_offload;
 
+	if (WARN_ON(!cfg80211_chandef_valid(chandef)))
+		return false;
+
+	width = cfg80211_chandef_get_width(chandef);
+	if (width < 0)
+		return false;
+
 	dfs_offload = wiphy_ext_feature_isset(wiphy,
 					      NL80211_EXT_FEATURE_DFS_OFFLOAD);
 
-	start_freq = cfg80211_get_start_freq(center_freq, bandwidth);
-	end_freq = cfg80211_get_end_freq(center_freq, bandwidth);
-
 	/*
 	 * Check entire range of channels for the bandwidth.
 	 * If any channel in between is disabled or has not
 	 * had gone through CAC return false
 	 */
-	for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
+	for_each_subchan(chandef, freq, cf) {
 		c = ieee80211_get_channel_khz(wiphy, freq);
 		if (!c)
 			return false;
@@ -1087,124 +1034,54 @@ static bool cfg80211_get_chans_dfs_available(struct wiphy *wiphy,
 	return true;
 }
 
-static bool cfg80211_chandef_dfs_available(struct wiphy *wiphy,
-				const struct cfg80211_chan_def *chandef)
+unsigned int
+cfg80211_chandef_dfs_cac_time(struct wiphy *wiphy,
+			      const struct cfg80211_chan_def *chandef)
 {
+	struct ieee80211_channel *c;
 	int width;
-	int r;
+	unsigned int t1 = 0, t2 = 0;
 
 	if (WARN_ON(!cfg80211_chandef_valid(chandef)))
-		return false;
+		return 0;
 
 	width = cfg80211_chandef_get_width(chandef);
 	if (width < 0)
-		return false;
-
-	r = cfg80211_get_chans_dfs_available(wiphy,
-					     MHZ_TO_KHZ(chandef->center_freq1),
-					     width);
-
-	/* If any of channels unavailable for cf1 just return */
-	if (!r)
-		return r;
-
-	switch (chandef->width) {
-	case NL80211_CHAN_WIDTH_80P80:
-		WARN_ON(!chandef->center_freq2);
-		r = cfg80211_get_chans_dfs_available(wiphy,
-					MHZ_TO_KHZ(chandef->center_freq2),
-					width);
-		break;
-	default:
-		WARN_ON(chandef->center_freq2);
-		break;
-	}
-
-	return r;
-}
-
-static unsigned int cfg80211_get_chans_dfs_cac_time(struct wiphy *wiphy,
-						    u32 center_freq,
-						    u32 bandwidth)
-{
-	struct ieee80211_channel *c;
-	u32 start_freq, end_freq, freq;
-	unsigned int dfs_cac_ms = 0;
-
-	start_freq = cfg80211_get_start_freq(center_freq, bandwidth);
-	end_freq = cfg80211_get_end_freq(center_freq, bandwidth);
+		return 0;
 
-	for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
+	for_each_subchan(chandef, freq, cf) {
 		c = ieee80211_get_channel_khz(wiphy, freq);
-		if (!c)
-			return 0;
-
-		if (c->flags & IEEE80211_CHAN_DISABLED)
-			return 0;
+		if (!c || (c->flags & IEEE80211_CHAN_DISABLED)) {
+			if (cf == 1)
+				t1 = INT_MAX;
+			else
+				t2 = INT_MAX;
+			continue;
+		}
 
 		if (!(c->flags & IEEE80211_CHAN_RADAR))
 			continue;
 
-		if (c->dfs_cac_ms > dfs_cac_ms)
-			dfs_cac_ms = c->dfs_cac_ms;
-	}
-
-	return dfs_cac_ms;
-}
-
-unsigned int
-cfg80211_chandef_dfs_cac_time(struct wiphy *wiphy,
-			      const struct cfg80211_chan_def *chandef)
-{
-	int width;
-	unsigned int t1 = 0, t2 = 0;
+		if (cf == 1 && c->dfs_cac_ms > t1)
+			t1 = c->dfs_cac_ms;
 
-	if (WARN_ON(!cfg80211_chandef_valid(chandef)))
-		return 0;
+		if (cf == 2 && c->dfs_cac_ms > t2)
+			t2 = c->dfs_cac_ms;
+	}
 
-	width = cfg80211_chandef_get_width(chandef);
-	if (width < 0)
+	if (t1 == INT_MAX && t2 == INT_MAX)
 		return 0;
 
-	t1 = cfg80211_get_chans_dfs_cac_time(wiphy,
-					     MHZ_TO_KHZ(chandef->center_freq1),
-					     width);
+	if (t1 == INT_MAX)
+		return t2;
 
-	if (!chandef->center_freq2)
+	if (t2 == INT_MAX)
 		return t1;
 
-	t2 = cfg80211_get_chans_dfs_cac_time(wiphy,
-					     MHZ_TO_KHZ(chandef->center_freq2),
-					     width);
-
 	return max(t1, t2);
 }
 EXPORT_SYMBOL(cfg80211_chandef_dfs_cac_time);
 
-static bool cfg80211_secondary_chans_ok(struct wiphy *wiphy,
-					u32 center_freq, u32 bandwidth,
-					u32 prohibited_flags,
-					u32 permitting_flags)
-{
-	struct ieee80211_channel *c;
-	u32 freq, start_freq, end_freq;
-
-	start_freq = cfg80211_get_start_freq(center_freq, bandwidth);
-	end_freq = cfg80211_get_end_freq(center_freq, bandwidth);
-
-	for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
-		c = ieee80211_get_channel_khz(wiphy, freq);
-		if (!c)
-			return false;
-		if (c->flags & permitting_flags)
-			continue;
-		if (c->flags & prohibited_flags)
-			return false;
-	}
-
-	return true;
-}
-
 /* check if the operating channels are valid and supported */
 static bool cfg80211_edmg_usable(struct wiphy *wiphy, u8 edmg_channels,
 				 enum ieee80211_edmg_bw_config edmg_bw_config,
@@ -1270,6 +1147,7 @@ bool _cfg80211_chandef_usable(struct wiphy *wiphy,
 	bool ext_nss_cap, support_80_80 = false, support_320 = false;
 	const struct ieee80211_sband_iftype_data *iftd;
 	struct ieee80211_supported_band *sband;
+	struct ieee80211_channel *c;
 	int i;
 
 	if (WARN_ON(!cfg80211_chandef_valid(chandef)))
@@ -1420,19 +1298,17 @@ bool _cfg80211_chandef_usable(struct wiphy *wiphy,
 	if (width < 20)
 		prohibited_flags |= IEEE80211_CHAN_NO_OFDM;
 
+	for_each_subchan(chandef, freq, cf) {
+		c = ieee80211_get_channel_khz(wiphy, freq);
+		if (!c)
+			return false;
+		if (c->flags & permitting_flags)
+			continue;
+		if (c->flags & prohibited_flags)
+			return false;
+	}
 
-	if (!cfg80211_secondary_chans_ok(wiphy,
-					 ieee80211_chandef_to_khz(chandef),
-					 width, prohibited_flags,
-					 permitting_flags))
-		return false;
-
-	if (!chandef->center_freq2)
-		return true;
-	return cfg80211_secondary_chans_ok(wiphy,
-					   MHZ_TO_KHZ(chandef->center_freq2),
-					   width, prohibited_flags,
-					   permitting_flags);
+	return true;
 }
 
 bool cfg80211_chandef_usable(struct wiphy *wiphy,
-- 
2.34.1


