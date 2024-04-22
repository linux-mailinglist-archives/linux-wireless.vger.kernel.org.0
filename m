Return-Path: <linux-wireless+bounces-6634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9065B8AC3C1
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 07:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7701C21B65
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 05:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5A3182BB;
	Mon, 22 Apr 2024 05:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LA9m50pM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985A718042
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764100; cv=none; b=BZQAvmOfmoRLxkH4DVX4JFL+/j7oDBnahpDDBMKvXoAA3k3p7t83vy4jRm3uDWy4235uWJEA7nVrnj3/SWQh3iNK+FETWce82rReA5XurfANoqcGRmD+AZhT3BFaiiDcVbNCRhV9dF4r3EhhJkOukP4BOPkPSA5/U8JJDts71IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764100; c=relaxed/simple;
	bh=AhehsCmF0fnnbkYtbB239Hrp6/dxGUb72u1nY62AbWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G080UEB9YCbYJcctkrWCQ2m/CjgHgxwrtJi7HCjd1QtrUxL9S1PUg7UFvrve/zfiZ2fAsgvmzAL6yAgLFoC7GMUCHP3X1RE33ubpy+KZqVXx09JYQGBpTjY4sZ7vnPnF6Ipt9oxWz6c40t3+wgAeiOoXcnXcI2Ai2ocLzhU4190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LA9m50pM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M41V4x006917;
	Mon, 22 Apr 2024 05:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=xDR7YWI/gKFCWpPgy/NFx7VQh1i7yQJL2tyYqUCO/8k=; b=LA
	9m50pMfnIQ6YYnu53OpI9RzOe84be6OF/sbOaOVjMr64I1NsGSJXwtcjCI8Rer4K
	JG1muI04qtTtn523TXFIF/6d4PZsXETgJfQmpxu6DIhh/vd5hnKMBjiLKdaZYXhM
	P54NG9Ft1NrkgMiO9BqRa5pvL5/JTeKyjwi53ug7xm59NcnnK7XdPmakxpbtRoY9
	El9qtkTlUFB33WmhqZ6b6EatiyBL+EmXdUny8cSq2HfP/Zvu9/r4F3UiKOsgeGYr
	gLyX5tox687B2YjcHIAF38h+Deg7FBFUl6rVW9ich8SEVWCweM5pWcVDl3WbysBM
	lIjvb/mFLMivufC3TOXQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm6vrb5b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 05:34:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M5YXLB029172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 05:34:33 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 21 Apr 2024 22:34:31 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 1/7] wifi: cfg80211: send link id in color_change ops
Date: Mon, 22 Apr 2024 11:04:06 +0530
Message-ID: <20240422053412.2024075-2-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422053412.2024075-1-quic_adisi@quicinc.com>
References: <20240422053412.2024075-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: fBl_nVcL_Wuc_YDAniT74lI9odNttJ91
X-Proofpoint-ORIG-GUID: fBl_nVcL_Wuc_YDAniT74lI9odNttJ91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_02,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220025

Currently, during color change, no link id information is passed down.
In order to support color change during Multi Link Operation, it is
required to pass link id as well.

Add changes to pass link id in the color_change cfg80211_ops.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/net/cfg80211.h | 3 +++
 net/wireless/nl80211.c | 4 +++-
 net/wireless/trace.h   | 6 ++++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0112d645a2b4..9716a8090f47 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1577,6 +1577,8 @@ struct cfg80211_csa_settings {
  * @beacon_next: beacon data to be used after the color change
  * @count: number of beacons until the color change
  * @color: the color used after the change
+ * @link_id: defines the link on which color change is expected during MLO.
+ *	0 in case of non-MLO.
  */
 struct cfg80211_color_change_settings {
 	struct cfg80211_beacon_data beacon_color_change;
@@ -1585,6 +1587,7 @@ struct cfg80211_color_change_settings {
 	struct cfg80211_beacon_data beacon_next;
 	u8 count;
 	u8 color;
+	u8 link_id;
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e5d8ea4211ea..995904f71be3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16030,6 +16030,7 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 		params.counter_offset_presp = offset;
 	}
 
+	params.link_id = nl80211_link_id(info->attrs);
 	err = rdev_color_change(rdev, dev, &params);
 
 out:
@@ -17432,7 +17433,8 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_color_change,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
 	{
 		.cmd = NL80211_CMD_SET_FILS_AAD,
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index cbbf347c6b2e..db4d9f567ad0 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2842,6 +2842,7 @@ TRACE_EVENT(rdev_color_change,
 		__field(u8, count)
 		__field(u16, bcn_ofs)
 		__field(u16, pres_ofs)
+		__field(u8, link_id)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
@@ -2849,11 +2850,12 @@ TRACE_EVENT(rdev_color_change,
 		__entry->count = params->count;
 		__entry->bcn_ofs = params->counter_offset_beacon;
 		__entry->pres_ofs = params->counter_offset_presp;
+		__entry->link_id = params->link_id;
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT
-		  ", count: %u",
+		  ", count: %u, link_id: %d",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG,
-		  __entry->count)
+		  __entry->count, __entry->link_id)
 );
 
 TRACE_EVENT(rdev_set_radar_background,
-- 
2.34.1


