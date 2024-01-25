Return-Path: <linux-wireless+bounces-2479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B03AC83C2F0
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 13:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E751C21A70
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 12:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576F24F21D;
	Thu, 25 Jan 2024 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PvZR118r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CEE4EB24
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187567; cv=none; b=Dee3I40oeUZUwQ+rs7KGvstQSwrst19c9TQ71yHw3eIXKtDMZZCJaeVaC0DdBvU+oFitv6mWmZj6EeN8Lue/VU5uqLVdsGUUHbYNprmylD2SJyNvRbLnuQ9G3TzTDH+sBpXhp9uAdXjJCUcjseJRk0NbhAh6TpLDCaP6A4l9W2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187567; c=relaxed/simple;
	bh=xg2DUYuZTOjoHGVl7aUrFKcfsdKHg5/NBf4yajGuGjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1k4DMna6WaDsYuapqlYsrtqkVDXMERVT1jiUqVpTwqfm1RHqm/UuixjsS7S9T1SpzqOxwdmEghUJkQBCmp15K1YT21O3nZlorGTX6OgvkixwE5QtqR4/S+c5E6gyKVSDmLfP3E+aLf6YtS6N409hBH8Sa0I/e70pUU58DBI7Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PvZR118r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PBu7cC028048;
	Thu, 25 Jan 2024 12:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=7QUoY9xhpgIrwvQuU/IEDAk9OYK2v7qDauAg/zyDrZA=; b=Pv
	ZR118rfymK8plhZA52SJaqygOqVWahVX0rqGOmbJl7leVQfZ1LGqCAokmJkDeaub
	xz7Yz33J872o9Hhe/HTowk2N+BAjgn0bDUP983l1oVMNTKoP5hh4IM4u3UgeJYXV
	CV/14xzVMZYLZ2xUhsbgj26U5Zjxo7bhVks+1Dm25jakNo8VqFrGGNolQmvcBE6u
	U9JAcf/ruyul/KUqC8ptxtyJp+xAXdDqj8wT61BYYOESE7flSwdcaiNfkndwuNqF
	HWFOanf6sezPvp8GXTiX0O5PSxIS69MONHBpjxX9wV2P9T9F8Qs2EX9ha5/RQaQr
	dptQwzGhWaU6fIVvZsoA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vumyngm77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 12:59:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PCxL8E009131
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 12:59:21 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jan 2024 04:59:19 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v5 1/3] wifi: cfg80211: send link id in channel_switch ops
Date: Thu, 25 Jan 2024 18:28:53 +0530
Message-ID: <20240125125855.827619-6-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125125855.827619-1-quic_adisi@quicinc.com>
References: <20240125125855.827619-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: ooBVRjOwzRsz7CllKthW39bvVKeO1ybj
X-Proofpoint-ORIG-GUID: ooBVRjOwzRsz7CllKthW39bvVKeO1ybj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_08,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=885 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250090

Currently, during channel switch, no link id information is passed
due to which channel switch is carried on deflink always. In order
to support channel switch during Multi Link Operation, it is
required to pass link id as well.

Add changes to pass link id in the channel_switch cfg80211_ops.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/net/cfg80211.h | 3 +++
 net/wireless/nl80211.c | 1 +
 net/wireless/trace.h   | 7 +++++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index cf79656ce09c..098a4f10fdfd 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1531,6 +1531,8 @@ struct cfg80211_ap_update {
  * @punct_bitmap: Preamble puncturing bitmap. Each bit represents
  *	a 20 MHz channel, lowest bit corresponding to the lowest channel.
  *	Bit set to 1 indicates that the channel is punctured.
+ * @link_id: defines the link on which channel switch is expected during
+ *	     MLO. 0 is case of non-MLO.
  */
 struct cfg80211_csa_settings {
 	struct cfg80211_chan_def chandef;
@@ -1544,6 +1546,7 @@ struct cfg80211_csa_settings {
 	bool block_tx;
 	u8 count;
 	u16 punct_bitmap;
+	u8 link_id;
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 60877b532993..7022e34d0a93 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10277,6 +10277,7 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 			goto free;
 	}
 
+	params.link_id = link_id;
 	err = rdev_channel_switch(rdev, dev, &params);
 
 free:
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 1f374c8a17a5..2af58f5fbf51 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2324,6 +2324,7 @@ TRACE_EVENT(rdev_channel_switch,
 		__field(u8, count)
 		__dynamic_array(u16, bcn_ofs, params->n_counter_offsets_beacon)
 		__dynamic_array(u16, pres_ofs, params->n_counter_offsets_presp)
+		__field(u8, link_id)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
@@ -2341,11 +2342,13 @@ TRACE_EVENT(rdev_channel_switch,
 			memcpy(__get_dynamic_array(pres_ofs),
 			       params->counter_offsets_presp,
 			       params->n_counter_offsets_presp * sizeof(u16));
+		__entry->link_id = params->link_id;
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT
-		  ", block_tx: %d, count: %u, radar_required: %d",
+		  ", block_tx: %d, count: %u, radar_required: %d link_id: %d",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, CHAN_DEF_PR_ARG,
-		  __entry->block_tx, __entry->count, __entry->radar_required)
+		  __entry->block_tx, __entry->count, __entry->radar_required,
+		  __entry->link_id)
 );
 
 TRACE_EVENT(rdev_set_qos_map,
-- 
2.25.1


