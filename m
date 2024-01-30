Return-Path: <linux-wireless+bounces-2768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F44841B01
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 05:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6424A1C24488
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 04:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5328E381AF;
	Tue, 30 Jan 2024 04:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tefvlebk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3A237716
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 04:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706589180; cv=none; b=e+JRuKAIAZWfknnrYITwSxDtmxu6AGP6DXCS3ejck99l8yQyD1CbXs5qo0TpgNNze/Lluotyhf/Dw8qs2MAbnNCMKvr3Jdpt+u8z45f6+e6NFJ2nN8HmGj+SS3C1MYYzVjTpmz23RRRyj8MuHB8CPE4mFKEOm27VLUvJG2j8fYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706589180; c=relaxed/simple;
	bh=51ivPvwfa5C2OnCX83VOkhhKKv3LemxuVdhkzftYfIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WL20de4bGQA6xLV2XJPuIfLm28SBscoIiwHo6pFcYvS8PMvf8mtLTadAkMoK8vX3ZwOQe2VJZu/hMpBT5qZAwZnyat04f47az+9Jt02hYdVIqMR9OS4DIoBCdPd4jOWqYfTPpOJR79XyhxRQ7Kw5nGjIOP2M3fC4ldBGEa3a9No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tefvlebk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U1Vr8W021812;
	Tue, 30 Jan 2024 04:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=q0fDwV1bCDcLyrnVAKtlbEjbiiyfaQQvFP3jUNS8HGQ=; b=Te
	fvlebkV+Cf3s4L9PX9dJ7OnAPAu/8XYsywvIth9J6rr1Zldg8pyxecAqisz1Ezhn
	0E9tj5l4cSAkXFkqvvRFbPDReaJPO37rLA5UOaYMo6OFR31dvljxeqZBfXBgNd7q
	PbLEBQ3ufOv8V7WFkYXBbqH/WRDzXlx9C8q0HlRb3K6aH0ZxEJFPjJwVEtHEWxQM
	BJHhbDDgJFvPxoMNjUqd359+au4Gxd6hn9Akt+WQTCBsJmbJHmUvAnxwPJFPhdKq
	Uc6dVTqMcxQn0vrTklQ08bXjCJ6jv7xEsN0nAIBKwNU4ElyijN1gIJ/cWRCzNjUK
	LY60YYsj1xjUibX4IVpA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx86htmqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:32:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U4WrVV008814
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:32:53 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 20:32:51 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v7 1/5] wifi: cfg80211: send link id in channel_switch ops
Date: Tue, 30 Jan 2024 10:02:21 +0530
Message-ID: <20240130043225.942202-2-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130043225.942202-1-quic_adisi@quicinc.com>
References: <20240130043225.942202-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: EBtfvO8Gt6cLx9sysXwvSH9IyzZMApLE
X-Proofpoint-GUID: EBtfvO8Gt6cLx9sysXwvSH9IyzZMApLE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_01,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 clxscore=1015 mlxlogscore=938
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300029

Currently, during channel switch, no link id information is passed down.
In order to support channel switch during Multi Link Operation, it is
required to pass link id as well.

Add changes to pass link id in the channel_switch cfg80211_ops.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/net/cfg80211.h | 3 +++
 net/wireless/nl80211.c | 1 +
 net/wireless/trace.h   | 7 +++++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 51b9e6fa12f8..2d6ff5ba5c03 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1531,6 +1531,8 @@ struct cfg80211_ap_update {
  * @punct_bitmap: Preamble puncturing bitmap. Each bit represents
  *	a 20 MHz channel, lowest bit corresponding to the lowest channel.
  *	Bit set to 1 indicates that the channel is punctured.
+ * @link_id: defines the link on which channel switch is expected during
+ *	     MLO. 0 in case of non-MLO.
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
index e4f41f86e295..7f58e11eba58 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10232,6 +10232,7 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 			goto free;
 	}
 
+	params.link_id = link_id;
 	err = rdev_channel_switch(rdev, dev, &params);
 
 free:
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 1f374c8a17a5..77972f7b774f 100644
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
+		  ", block_tx: %d, count: %u, radar_required: %d, link_id: %d",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, CHAN_DEF_PR_ARG,
-		  __entry->block_tx, __entry->count, __entry->radar_required)
+		  __entry->block_tx, __entry->count, __entry->radar_required,
+		  __entry->link_id)
 );
 
 TRACE_EVENT(rdev_set_qos_map,
-- 
2.25.1


