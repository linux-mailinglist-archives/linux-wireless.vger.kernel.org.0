Return-Path: <linux-wireless+bounces-15676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C539D7B0B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 06:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF26162BF0
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 05:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4BA4D9FB;
	Mon, 25 Nov 2024 05:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hltvri7m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7052500DE
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 05:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732511811; cv=none; b=YyHVjdww2xQOLwp73hHS1eS/gYmA3yqBudkM7oWtJzsyCViRtJEsy1K5VbhMfpIx5La0wZDN3bhriZyM0NC86kU2deY/zyntJprY/w1IH5PAJ9CvgelVZ93jekG+Bm7jGO95YytTah0PlCmNTGaExvvn8Encv/tIdjUfI53FrzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732511811; c=relaxed/simple;
	bh=uOKX7UWJcn35FWgI4AUth1VRaM7Dl2QuB5Rl0G+TLJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AOBdsmWDBOjs6smDpbDzTC9GgXkGuQrMonf5mWdUQymbJkAcu6eLkOa2KZjNHYZA8NOiMn1UL5QTfvlo2X+D7Du0RhdHwMnKsCgCYShp/mX7u5of54hnob46yYkhT99egyDKHHBlbvBFe61GZhVVTSYtV6sx+vwYEQnouFvcqjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hltvri7m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AOLueW0032678;
	Mon, 25 Nov 2024 05:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=9If6+kzg1vCmRoO+rz7U2XMuioGJhDVNYjJogD6nLqk=; b=Hl
	tvri7mCd8o/flZVLvdtpLUH623Bjia+l+GizoFMkPJ/PbGsjGsFeKu/74bJzMkbO
	OvLfxlZkTugZ5DYUzd1YadLYGdJGG/+PtUOic3wGfOORmc7/aRgwG9gDbptRTflh
	GAXWSzRv/xL2IiDn8YDeKj8wmzsq5J9TYJ2tpqcZXWkOf4vmdYGcXZm0dVTRvpFG
	5/V46rJOpbdgDE5z6GuWw2zX0fFqG0+P4do4QwlJ5vl7JRwt7rDchfecaFI8fo1A
	SaVHV0/wNXbFMQeDY3eHOz6mMWiWujYImfUsG7533YvrVFwZlW2VaXjzQyIBNAMj
	HnFejIxYykZpiduiLAVQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 433626bgt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 05:16:44 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AP5Ghoq021961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 05:16:43 GMT
Received: from hu-kkavita-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 24 Nov 2024 21:16:40 -0800
From: Kavita Kavita <quic_kkavita@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_kkavita@quicinc.com>,
        <quic_mpaluri@quicinc.com>
Subject: [PATCH v2] wifi: cfg80211: skip regulatory checks when the channel is punctured
Date: Mon, 25 Nov 2024 10:46:24 +0530
Message-ID: <20241125051624.29085-1-quic_kkavita@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KTzXrwotMs3kgC5rwjE6vw7JdPnrlOnf
X-Proofpoint-ORIG-GUID: KTzXrwotMs3kgC5rwjE6vw7JdPnrlOnf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 spamscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250043

The kernel performs several regulatory checks for AP mode in
nl80211/cfg80211. These checks include radar detection,
verification of whether the sub-channel is disabled, and
an examination to determine if the channel is a DFS channel
(both DFS usable and DFS available). These checks are
performed across a frequency range, examining each sub-channel.

However, these checks are also performed on frequencies that
have been punctured, which should not be examined as they are
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
Changes in v2:
- Added macro "for_each_subchan" for traversing non punctured channels.
- Skip setting dfs state for punctured channels.
- for center_freq2, pass 0 as punctured bitmap.
---
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 40b6375a5de4..bd6b0056ce42 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -583,15 +583,20 @@ cfg80211_chandef_compatible(const struct cfg80211_chan_def *c1,
 EXPORT_SYMBOL(cfg80211_chandef_compatible);
 
 static void cfg80211_set_chans_dfs_state(struct wiphy *wiphy, u32 center_freq,
-					 u32 bandwidth,
+					 u32 bandwidth, u16 punctured,
 					 enum nl80211_dfs_state dfs_state)
 {
 	struct ieee80211_channel *c;
 	u32 freq;
+	int subchan = 0;
 
 	for (freq = center_freq - bandwidth/2 + 10;
 	     freq <= center_freq + bandwidth/2 - 10;
 	     freq += 20) {
+		if (punctured & BIT(subchan))
+			continue;
+		subchan++;
+
 		c = ieee80211_get_channel(wiphy, freq);
 		if (!c || !(c->flags & IEEE80211_CHAN_RADAR))
 			continue;
@@ -615,40 +620,12 @@ void cfg80211_set_dfs_state(struct wiphy *wiphy,
 		return;
 
 	cfg80211_set_chans_dfs_state(wiphy, chandef->center_freq1,
-				     width, dfs_state);
+				     width, chandef->punctured, dfs_state);
 
 	if (!chandef->center_freq2)
 		return;
 	cfg80211_set_chans_dfs_state(wiphy, chandef->center_freq2,
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
-
-	return end_freq;
+				     width, 0, dfs_state);
 }
 
 static bool
@@ -727,24 +704,20 @@ static bool cfg80211_dfs_permissive_chan(struct wiphy *wiphy,
 static int cfg80211_get_chans_dfs_required(struct wiphy *wiphy,
 					    u32 center_freq,
 					    u32 bandwidth,
+					    u16 punctured,
 					    enum nl80211_iftype iftype)
 {
-	struct ieee80211_channel *c;
-	u32 freq, start_freq, end_freq;
-
-	start_freq = cfg80211_get_start_freq(center_freq, bandwidth);
-	end_freq = cfg80211_get_end_freq(center_freq, bandwidth);
+	struct ieee80211_channel *subchan;
 
-	for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
-		c = ieee80211_get_channel_khz(wiphy, freq);
-		if (!c)
-			return -EINVAL;
-
-		if (c->flags & IEEE80211_CHAN_RADAR &&
-		    !cfg80211_dfs_permissive_chan(wiphy, iftype, c))
+	for_each_subchan(wiphy, center_freq, bandwidth, punctured, subchan) {
+		if ((subchan->flags & IEEE80211_CHAN_RADAR) &&
+		    !cfg80211_dfs_permissive_chan(wiphy, iftype, subchan))
 			return 1;
 	}
 
+	if (subchan && IS_ERR(subchan))
+		return PTR_ERR(subchan);
+
 	return 0;
 }
 
@@ -770,7 +743,8 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 
 		ret = cfg80211_get_chans_dfs_required(wiphy,
 					ieee80211_chandef_to_khz(chandef),
-					width, iftype);
+					width, chandef->punctured, iftype);
+
 		if (ret < 0)
 			return ret;
 		else if (ret > 0)
@@ -781,7 +755,8 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 
 		ret = cfg80211_get_chans_dfs_required(wiphy,
 					MHZ_TO_KHZ(chandef->center_freq2),
-					width, iftype);
+					width, 0, iftype);
+
 		if (ret < 0)
 			return ret;
 		else if (ret > 0)
@@ -808,38 +783,33 @@ EXPORT_SYMBOL(cfg80211_chandef_dfs_required);
 
 static int cfg80211_get_chans_dfs_usable(struct wiphy *wiphy,
 					 u32 center_freq,
-					 u32 bandwidth)
+					 u32 bandwidth, u16 punctured)
 {
-	struct ieee80211_channel *c;
-	u32 freq, start_freq, end_freq;
+	struct ieee80211_channel *subchan;
 	int count = 0;
 
-	start_freq = cfg80211_get_start_freq(center_freq, bandwidth);
-	end_freq = cfg80211_get_end_freq(center_freq, bandwidth);
-
 	/*
 	 * Check entire range of channels for the bandwidth.
 	 * Check all channels are DFS channels (DFS_USABLE or
 	 * DFS_AVAILABLE). Return number of usable channels
 	 * (require CAC). Allow DFS and non-DFS channel mix.
 	 */
-	for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
-		c = ieee80211_get_channel_khz(wiphy, freq);
-		if (!c)
-			return -EINVAL;
-
-		if (c->flags & IEEE80211_CHAN_DISABLED)
+	for_each_subchan(wiphy, center_freq, bandwidth, punctured, subchan) {
+		if (subchan->flags & IEEE80211_CHAN_DISABLED)
 			return -EINVAL;
 
-		if (c->flags & IEEE80211_CHAN_RADAR) {
-			if (c->dfs_state == NL80211_DFS_UNAVAILABLE)
+		if (subchan->flags & IEEE80211_CHAN_RADAR) {
+			if (subchan->dfs_state == NL80211_DFS_UNAVAILABLE)
 				return -EINVAL;
 
-			if (c->dfs_state == NL80211_DFS_USABLE)
+			if (subchan->dfs_state == NL80211_DFS_USABLE)
 				count++;
 		}
 	}
 
+	if (subchan && IS_ERR(subchan))
+		return PTR_ERR(subchan);
+
 	return count;
 }
 
@@ -858,7 +828,7 @@ bool cfg80211_chandef_dfs_usable(struct wiphy *wiphy,
 
 	r1 = cfg80211_get_chans_dfs_usable(wiphy,
 					   MHZ_TO_KHZ(chandef->center_freq1),
-					   width);
+					   width, chandef->punctured);
 
 	if (r1 < 0)
 		return false;
@@ -868,7 +838,7 @@ bool cfg80211_chandef_dfs_usable(struct wiphy *wiphy,
 		WARN_ON(!chandef->center_freq2);
 		r2 = cfg80211_get_chans_dfs_usable(wiphy,
 					MHZ_TO_KHZ(chandef->center_freq2),
-					width);
+					width, 0);
 		if (r2 < 0)
 			return false;
 		break;
@@ -1053,37 +1023,32 @@ bool cfg80211_any_wiphy_oper_chan(struct wiphy *wiphy,
 
 static bool cfg80211_get_chans_dfs_available(struct wiphy *wiphy,
 					     u32 center_freq,
-					     u32 bandwidth)
+					     u32 bandwidth, u16 punctured)
 {
-	struct ieee80211_channel *c;
-	u32 freq, start_freq, end_freq;
+	struct ieee80211_channel *subchan;
 	bool dfs_offload;
 
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
-		c = ieee80211_get_channel_khz(wiphy, freq);
-		if (!c)
+	for_each_subchan(wiphy, center_freq, bandwidth, punctured, subchan) {
+		if (subchan->flags & IEEE80211_CHAN_DISABLED)
 			return false;
 
-		if (c->flags & IEEE80211_CHAN_DISABLED)
-			return false;
-
-		if ((c->flags & IEEE80211_CHAN_RADAR) &&
-		    (c->dfs_state != NL80211_DFS_AVAILABLE) &&
-		    !(c->dfs_state == NL80211_DFS_USABLE && dfs_offload))
+		if ((subchan->flags & IEEE80211_CHAN_RADAR) &&
+		    subchan->dfs_state != NL80211_DFS_AVAILABLE &&
+		    !(subchan->dfs_state == NL80211_DFS_USABLE && dfs_offload))
 			return false;
 	}
 
+	if (subchan && IS_ERR(subchan))
+		return false;
+
 	return true;
 }
 
@@ -1102,7 +1067,7 @@ static bool cfg80211_chandef_dfs_available(struct wiphy *wiphy,
 
 	r = cfg80211_get_chans_dfs_available(wiphy,
 					     MHZ_TO_KHZ(chandef->center_freq1),
-					     width);
+					     width, chandef->punctured);
 
 	/* If any of channels unavailable for cf1 just return */
 	if (!r)
@@ -1113,7 +1078,7 @@ static bool cfg80211_chandef_dfs_available(struct wiphy *wiphy,
 		WARN_ON(!chandef->center_freq2);
 		r = cfg80211_get_chans_dfs_available(wiphy,
 					MHZ_TO_KHZ(chandef->center_freq2),
-					width);
+					width, 0);
 		break;
 	default:
 		WARN_ON(chandef->center_freq2);
@@ -1125,30 +1090,25 @@ static bool cfg80211_chandef_dfs_available(struct wiphy *wiphy,
 
 static unsigned int cfg80211_get_chans_dfs_cac_time(struct wiphy *wiphy,
 						    u32 center_freq,
-						    u32 bandwidth)
+						    u32 bandwidth, u16 punctured)
 {
-	struct ieee80211_channel *c;
-	u32 start_freq, end_freq, freq;
+	struct ieee80211_channel *subchan;
 	unsigned int dfs_cac_ms = 0;
 
-	start_freq = cfg80211_get_start_freq(center_freq, bandwidth);
-	end_freq = cfg80211_get_end_freq(center_freq, bandwidth);
-
-	for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
-		c = ieee80211_get_channel_khz(wiphy, freq);
-		if (!c)
-			return 0;
-
-		if (c->flags & IEEE80211_CHAN_DISABLED)
+	for_each_subchan(wiphy, center_freq, bandwidth, punctured, subchan) {
+		if (subchan->flags & IEEE80211_CHAN_DISABLED)
 			return 0;
 
-		if (!(c->flags & IEEE80211_CHAN_RADAR))
+		if (!(subchan->flags & IEEE80211_CHAN_RADAR))
 			continue;
 
-		if (c->dfs_cac_ms > dfs_cac_ms)
-			dfs_cac_ms = c->dfs_cac_ms;
+		if (subchan->dfs_cac_ms > dfs_cac_ms)
+			dfs_cac_ms = subchan->dfs_cac_ms;
 	}
 
+	if (subchan && IS_ERR(subchan))
+		return 0;
+
 	return dfs_cac_ms;
 }
 
@@ -1168,14 +1128,14 @@ cfg80211_chandef_dfs_cac_time(struct wiphy *wiphy,
 
 	t1 = cfg80211_get_chans_dfs_cac_time(wiphy,
 					     MHZ_TO_KHZ(chandef->center_freq1),
-					     width);
+					     width, chandef->punctured);
 
 	if (!chandef->center_freq2)
 		return t1;
 
 	t2 = cfg80211_get_chans_dfs_cac_time(wiphy,
 					     MHZ_TO_KHZ(chandef->center_freq2),
-					     width);
+					     width, 0);
 
 	return max(t1, t2);
 }
@@ -1183,25 +1143,21 @@ EXPORT_SYMBOL(cfg80211_chandef_dfs_cac_time);
 
 static bool cfg80211_secondary_chans_ok(struct wiphy *wiphy,
 					u32 center_freq, u32 bandwidth,
-					u32 prohibited_flags,
+					u16 punctured, u32 prohibited_flags,
 					u32 permitting_flags)
 {
-	struct ieee80211_channel *c;
-	u32 freq, start_freq, end_freq;
-
-	start_freq = cfg80211_get_start_freq(center_freq, bandwidth);
-	end_freq = cfg80211_get_end_freq(center_freq, bandwidth);
+	struct ieee80211_channel *subchan;
 
-	for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
-		c = ieee80211_get_channel_khz(wiphy, freq);
-		if (!c)
-			return false;
-		if (c->flags & permitting_flags)
+	for_each_subchan(wiphy, center_freq, bandwidth, punctured, subchan) {
+		if (subchan->flags & permitting_flags)
 			continue;
-		if (c->flags & prohibited_flags)
+		if (subchan->flags & prohibited_flags)
 			return false;
 	}
 
+	if (subchan && IS_ERR(subchan))
+		return false;
+
 	return true;
 }
 
@@ -1423,7 +1379,8 @@ bool _cfg80211_chandef_usable(struct wiphy *wiphy,
 
 	if (!cfg80211_secondary_chans_ok(wiphy,
 					 ieee80211_chandef_to_khz(chandef),
-					 width, prohibited_flags,
+					 width, chandef->punctured,
+					 prohibited_flags,
 					 permitting_flags))
 		return false;
 
@@ -1431,7 +1388,7 @@ bool _cfg80211_chandef_usable(struct wiphy *wiphy,
 		return true;
 	return cfg80211_secondary_chans_ok(wiphy,
 					   MHZ_TO_KHZ(chandef->center_freq2),
-					   width, prohibited_flags,
+					   width, 0, prohibited_flags,
 					   permitting_flags);
 }
 
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 4c45f994a8c0..f4583e0494d7 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -505,6 +505,18 @@ bool _cfg80211_chandef_usable(struct wiphy *wiphy,
 			      u32 prohibited_flags,
 			      u32 permitting_flags);
 
+#define for_each_subchan(wiphy, center_freq, bandwidth, punctured,	\
+			       subchan)						\
+	for (subchan = ieee80211_next_subchan(wiphy, center_freq, bandwidth,	\
+					      punctured, NULL);			\
+	     subchan && !IS_ERR(subchan);					\
+	     subchan = ieee80211_next_subchan(wiphy, center_freq, bandwidth,	\
+					      punctured, subchan))
+
+struct ieee80211_channel *
+ieee80211_next_subchan(struct wiphy *wiphy, u32 center_freq, u32 bandwidth,
+		       u16 punctured, struct ieee80211_channel *subchan);
+
 static inline unsigned int elapsed_jiffies_msecs(unsigned long start)
 {
 	unsigned long end = jiffies;
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 040d62051eb9..2e2f362b7548 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -184,6 +184,70 @@ struct ieee80211_channel *ieee80211_get_channel_khz(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(ieee80211_get_channel_khz);
 
+static u32 cfg80211_get_start_freq(u32 center_freq,
+				   u32 bandwidth)
+{
+	u32 start_freq;
+
+	bandwidth = MHZ_TO_KHZ(bandwidth);
+	if (bandwidth <= MHZ_TO_KHZ(20))
+		start_freq = center_freq;
+	else
+		start_freq = center_freq - bandwidth / 2 + MHZ_TO_KHZ(10);
+
+	return start_freq;
+}
+
+static u32 cfg80211_get_end_freq(u32 center_freq,
+				 u32 bandwidth)
+{
+	u32 end_freq;
+
+	bandwidth = MHZ_TO_KHZ(bandwidth);
+	if (bandwidth <= MHZ_TO_KHZ(20))
+		end_freq = center_freq;
+	else
+		end_freq = center_freq + bandwidth / 2 - MHZ_TO_KHZ(10);
+
+	return end_freq;
+}
+
+struct ieee80211_channel *ieee80211_next_subchan(struct wiphy *wiphy,
+						 u32 center_freq, u32 bandwidth,
+						 u16 punctured,
+						 struct ieee80211_channel *subchan)
+{
+	struct ieee80211_channel *next_subchan;
+	u32 freq, start_freq, end_freq;
+	int pos;
+
+	start_freq = cfg80211_get_start_freq(center_freq, bandwidth);
+	end_freq = cfg80211_get_end_freq(center_freq, bandwidth);
+
+	if (!subchan) {
+		freq = start_freq;
+	} else {
+		freq = ieee80211_channel_to_khz(subchan);
+		freq += MHZ_TO_KHZ(20);
+	}
+
+	while (freq <= end_freq) {
+		next_subchan = ieee80211_get_channel_khz(wiphy, freq);
+
+		if (!next_subchan)
+			return ERR_PTR(-EINVAL);
+
+		pos = (freq - start_freq) / MHZ_TO_KHZ(20);
+
+		if (!(punctured & BIT(pos)))
+			return next_subchan;
+
+		freq += MHZ_TO_KHZ(20);
+	}
+
+	return NULL;
+}
+
 static void set_mandatory_flags_band(struct ieee80211_supported_band *sband)
 {
 	int i, want;
-- 
2.17.1


