Return-Path: <linux-wireless+bounces-11984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B80195F159
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 14:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528EEB20C66
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 12:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E77213DDD9;
	Mon, 26 Aug 2024 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cLtOzDTz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437CE22071
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675647; cv=none; b=b9qcZKlejLHHD1aXpp/fAi3SstikH7ynHd8kDVx3WjwkOYIWBspse7igMYf7gtiCF9HYoFZravNg803OiHsHH+v7DQFV17EDXTpWrn6qIOj5dn6MTSPX7HCKrZ4nN6NboNRZ8f4ULjSuA9XijMhHAQMI/Q/kVwVem4I52xDhal0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675647; c=relaxed/simple;
	bh=4Lwc3lG+X4xvl3cTfXa+oMpvcTq4pXdbwSsfQ3wP4M4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=floBmvjBjG2OiqJOAVRBjD98VHijCa5S9iBlGIE5YUFZRuh+o3ZJpG9Sl6JY5RoQQeCauBu5cfX45oQ3dR0R7YLvMNCwG3QK4fLTDVhC9EEkrEPR5tpeQCJw2K200u+LAvLlAMPO+B72KO+wWq7mqgmG33TBi9Qc4LfAuplDujA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cLtOzDTz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q8MQr9017727;
	Mon, 26 Aug 2024 12:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=19MWozbl5vOTznMmoRDQi1C3MVR/hSeoN+H8LoEYGDE=; b=cL
	tOzDTzkywCt+ECl1hZxa+fqXTkKjhdfFssMX4f5OZ/A5U5fc7gwuMlLCJE6ZMmSR
	kKlgnIRdsErCPOFVd5dUHMAhdDFp3/Bi+D3k46ZxcveyvN07JhOzKU7x2HnZnk4q
	S3VIL0zi9p6hwhFyNAkHp7zgfYtSBvJ1otXmWArbHiJQUTnAWM+6oATP638O+jlG
	TjBOyB3SKJ9K01sT4euM5HuXD3cbKuCFVbsqVDN0zmyThtw7IO3riinJxN6kGWA5
	F8+wa7NumQWE6zYs9+zXsv8UHuRnsna6JBhQJVMZMkwbr44AYmKo3VwAIs4p4KGK
	GLJYYf+ua7rkWnH3+NMQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4179a1uk10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 12:34:00 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47QCXxuS030504
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 12:33:59 GMT
Received: from hu-kkavita-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 26 Aug 2024 05:33:57 -0700
From: Kavita Kavita <quic_kkavita@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_kkavita@quicinc.com>,
        <quic_mpaluri@quicinc.com>
Subject: [PATCH] wifi: cfg80211: skip regulatory checks when the channel is punctured
Date: Mon, 26 Aug 2024 18:03:41 +0530
Message-ID: <20240826123341.5405-1-quic_kkavita@quicinc.com>
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
X-Proofpoint-GUID: hDdXMq_4decykHPSxFPO5NLbvcdUOi3m
X-Proofpoint-ORIG-GUID: hDdXMq_4decykHPSxFPO5NLbvcdUOi3m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_08,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=963
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408260098

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
 net/wireless/chan.c | 59 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index e579d7e1425f..b363649acd03 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -727,6 +727,7 @@ static bool cfg80211_dfs_permissive_chan(struct wiphy *wiphy,
 static int cfg80211_get_chans_dfs_required(struct wiphy *wiphy,
 					    u32 center_freq,
 					    u32 bandwidth,
+					    u16 punctured,
 					    enum nl80211_iftype iftype)
 {
 	struct ieee80211_channel *c;
@@ -740,9 +741,11 @@ static int cfg80211_get_chans_dfs_required(struct wiphy *wiphy,
 		if (!c)
 			return -EINVAL;
 
-		if (c->flags & IEEE80211_CHAN_RADAR &&
+		if (!(punctured & 1) && (c->flags & IEEE80211_CHAN_RADAR) &&
 		    !cfg80211_dfs_permissive_chan(wiphy, iftype, c))
 			return 1;
+
+		punctured >>= 1;
 	}
 
 	return 0;
@@ -770,7 +773,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 
 		ret = cfg80211_get_chans_dfs_required(wiphy,
 					ieee80211_chandef_to_khz(chandef),
-					width, iftype);
+					width, chandef->punctured, iftype);
 		if (ret < 0)
 			return ret;
 		else if (ret > 0)
@@ -781,7 +784,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 
 		ret = cfg80211_get_chans_dfs_required(wiphy,
 					MHZ_TO_KHZ(chandef->center_freq2),
-					width, iftype);
+					width, chandef->punctured, iftype);
 		if (ret < 0)
 			return ret;
 		else if (ret > 0)
@@ -808,7 +811,7 @@ EXPORT_SYMBOL(cfg80211_chandef_dfs_required);
 
 static int cfg80211_get_chans_dfs_usable(struct wiphy *wiphy,
 					 u32 center_freq,
-					 u32 bandwidth)
+					 u32 bandwidth, u16 punctured)
 {
 	struct ieee80211_channel *c;
 	u32 freq, start_freq, end_freq;
@@ -828,6 +831,12 @@ static int cfg80211_get_chans_dfs_usable(struct wiphy *wiphy,
 		if (!c)
 			return -EINVAL;
 
+		if (punctured & 1) {
+			punctured >>= 1;
+			continue;
+		}
+		punctured >>= 1;
+
 		if (c->flags & IEEE80211_CHAN_DISABLED)
 			return -EINVAL;
 
@@ -858,7 +867,7 @@ bool cfg80211_chandef_dfs_usable(struct wiphy *wiphy,
 
 	r1 = cfg80211_get_chans_dfs_usable(wiphy,
 					   MHZ_TO_KHZ(chandef->center_freq1),
-					   width);
+					   width, chandef->punctured);
 
 	if (r1 < 0)
 		return false;
@@ -868,7 +877,7 @@ bool cfg80211_chandef_dfs_usable(struct wiphy *wiphy,
 		WARN_ON(!chandef->center_freq2);
 		r2 = cfg80211_get_chans_dfs_usable(wiphy,
 					MHZ_TO_KHZ(chandef->center_freq2),
-					width);
+					width, chandef->punctured);
 		if (r2 < 0)
 			return false;
 		break;
@@ -1053,7 +1062,7 @@ bool cfg80211_any_wiphy_oper_chan(struct wiphy *wiphy,
 
 static bool cfg80211_get_chans_dfs_available(struct wiphy *wiphy,
 					     u32 center_freq,
-					     u32 bandwidth)
+					     u32 bandwidth, u16 punctured)
 {
 	struct ieee80211_channel *c;
 	u32 freq, start_freq, end_freq;
@@ -1075,6 +1084,12 @@ static bool cfg80211_get_chans_dfs_available(struct wiphy *wiphy,
 		if (!c)
 			return false;
 
+		if (punctured & 1) {
+			punctured >>= 1;
+			continue;
+		}
+		punctured >>= 1;
+
 		if (c->flags & IEEE80211_CHAN_DISABLED)
 			return false;
 
@@ -1102,7 +1117,7 @@ static bool cfg80211_chandef_dfs_available(struct wiphy *wiphy,
 
 	r = cfg80211_get_chans_dfs_available(wiphy,
 					     MHZ_TO_KHZ(chandef->center_freq1),
-					     width);
+					     width, chandef->punctured);
 
 	/* If any of channels unavailable for cf1 just return */
 	if (!r)
@@ -1113,7 +1128,7 @@ static bool cfg80211_chandef_dfs_available(struct wiphy *wiphy,
 		WARN_ON(!chandef->center_freq2);
 		r = cfg80211_get_chans_dfs_available(wiphy,
 					MHZ_TO_KHZ(chandef->center_freq2),
-					width);
+					width, chandef->punctured);
 		break;
 	default:
 		WARN_ON(chandef->center_freq2);
@@ -1125,7 +1140,8 @@ static bool cfg80211_chandef_dfs_available(struct wiphy *wiphy,
 
 static unsigned int cfg80211_get_chans_dfs_cac_time(struct wiphy *wiphy,
 						    u32 center_freq,
-						    u32 bandwidth)
+						    u32 bandwidth,
+						    u16 punctured)
 {
 	struct ieee80211_channel *c;
 	u32 start_freq, end_freq, freq;
@@ -1139,6 +1155,12 @@ static unsigned int cfg80211_get_chans_dfs_cac_time(struct wiphy *wiphy,
 		if (!c)
 			return 0;
 
+		if (punctured & 1) {
+			punctured >>= 1;
+			continue;
+		}
+		punctured >>= 1;
+
 		if (c->flags & IEEE80211_CHAN_DISABLED)
 			return 0;
 
@@ -1168,14 +1190,14 @@ cfg80211_chandef_dfs_cac_time(struct wiphy *wiphy,
 
 	t1 = cfg80211_get_chans_dfs_cac_time(wiphy,
 					     MHZ_TO_KHZ(chandef->center_freq1),
-					     width);
+					     width, chandef->punctured);
 
 	if (!chandef->center_freq2)
 		return t1;
 
 	t2 = cfg80211_get_chans_dfs_cac_time(wiphy,
 					     MHZ_TO_KHZ(chandef->center_freq2),
-					     width);
+					     width, chandef->punctured);
 
 	return max(t1, t2);
 }
@@ -1183,6 +1205,7 @@ EXPORT_SYMBOL(cfg80211_chandef_dfs_cac_time);
 
 static bool cfg80211_secondary_chans_ok(struct wiphy *wiphy,
 					u32 center_freq, u32 bandwidth,
+					u16 punctured,
 					u32 prohibited_flags,
 					u32 permitting_flags)
 {
@@ -1198,8 +1221,10 @@ static bool cfg80211_secondary_chans_ok(struct wiphy *wiphy,
 			return false;
 		if (c->flags & permitting_flags)
 			continue;
-		if (c->flags & prohibited_flags)
+		if ((c->flags & prohibited_flags) && !(punctured & 1))
 			return false;
+
+		punctured >>= 1;
 	}
 
 	return true;
@@ -1423,16 +1448,16 @@ bool _cfg80211_chandef_usable(struct wiphy *wiphy,
 
 	if (!cfg80211_secondary_chans_ok(wiphy,
 					 ieee80211_chandef_to_khz(chandef),
-					 width, prohibited_flags,
-					 permitting_flags))
+					 width, chandef->punctured,
+					 prohibited_flags, permitting_flags))
 		return false;
 
 	if (!chandef->center_freq2)
 		return true;
 	return cfg80211_secondary_chans_ok(wiphy,
 					   MHZ_TO_KHZ(chandef->center_freq2),
-					   width, prohibited_flags,
-					   permitting_flags);
+					   width, chandef->punctured,
+					   prohibited_flags, permitting_flags);
 }
 
 bool cfg80211_chandef_usable(struct wiphy *wiphy,
-- 
2.17.1


