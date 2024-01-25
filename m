Return-Path: <linux-wireless+bounces-2460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36C883B92D
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 06:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6572F287B10
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 05:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898BF107B6;
	Thu, 25 Jan 2024 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iXYaAzS5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D5107B4
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706161873; cv=none; b=ZyolLHdd2hPCDVa9fsug+8G7zjeYru7JBHmAF5ugQuBevSUSKkIRGMQP0b/okA16Fh9NwAxEFAYdKIFrKI394W/9P0XWRW+KpDDfzxs6iq9opaAOGUN8Ikj4SBmdPXOw1PpaOZeC2KByk8MbHwyWwol4JC9AFhXRizlj9Vsydyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706161873; c=relaxed/simple;
	bh=xg2DUYuZTOjoHGVl7aUrFKcfsdKHg5/NBf4yajGuGjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unQr+eDKDqu7M564/KfBIrbvC1Ptn7NBCM6FEedrqo7oRaYG5ktEHfB5axHU2b7GUre5dqttm2LEIeiMcUl7bHW/apx5fkPOrBsItKvL9R78auLuXnujOymEt5TcCv0A+NhCr+KGy6/uiYH6tImK5hKtkr8HVTKplgbvUysY7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iXYaAzS5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P5kPDq021244;
	Thu, 25 Jan 2024 05:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=7QUoY9xhpgIrwvQuU/IEDAk9OYK2v7qDauAg/zyDrZA=; b=iX
	YaAzS56pTqJYBu9/IPEpOL32duTE3FYPg2ywLpFFuUnCFRRLpbs9pfotxAcFyVsB
	+Tyh2pnH6+8HIuB+wIiTMpo/KhTAHk30MT8V/sfEIxsGcHQR5U/OMdQ8mGfqP41l
	OiU6t76cw3nG3UGvSXlWPj0mrGQTFkJf4gz0DsBQRYM+ExuSJpb8b05Nul6s2NOU
	jJ6AE7O0ci4C3xK41fMVUy5Nf7QqvX3M8//TVtMquz3OF5qOEYcTktb69VlHdfSw
	AVOzOqZWxDW9CrO7Nq8pPcqX0uZCvYIX2FJ1FGoaC/Nm0nLFOgfdWbAIEFjngpa9
	8U8dOhq4/OnDL8W3Zcqw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vu1ccj8fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 05:51:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40P5p4Ha004320
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 05:51:04 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Jan 2024 21:51:02 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v4 1/3] wifi: cfg80211: send link id in channel_switch ops
Date: Thu, 25 Jan 2024 11:20:37 +0530
Message-ID: <20240125055039.826200-2-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125055039.826200-1-quic_adisi@quicinc.com>
References: <20240125055039.826200-1-quic_adisi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PBuXhs-QFEDI8To10OfI_C_UQbXMwA2O
X-Proofpoint-GUID: PBuXhs-QFEDI8To10OfI_C_UQbXMwA2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_02,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=885
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250037

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


