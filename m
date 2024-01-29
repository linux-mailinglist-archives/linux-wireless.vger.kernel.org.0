Return-Path: <linux-wireless+bounces-2628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 272FD83FDBB
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 06:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858B0283B46
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 05:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C48645958;
	Mon, 29 Jan 2024 05:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W7agq9ky"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63234446CA
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 05:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706506138; cv=none; b=PSL5yyUX1rraHEz0spO3AbYzqH41mof8QAm7i8jL6JcrZerMmHds0txW4zJYFN6iY1vFN6P1iHAVHeNK2f9NKP3doitovB6cFj7eyJext9MPHG+sPZPOr9TjWJT7CeC5G83z1a01zLAWkUcO2PPYTzIRGSRFglxVEKL1NIZ8O2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706506138; c=relaxed/simple;
	bh=MnIUlr7CZV9NlThbtwN9gbxS4gMSBb1CSwiMWyuCScc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzFXSmzNsHDCUX0GsZyFdsEjVGyub9zt7XXSNA6gDKv0W4NLZOF+9CGFX7uSBoYDAURa3Hrp2dhoRGk3alLe2W3qWkXY1IHaH8duXak5umBzRL31oWxEB1isgJkr/F0AutVacf1IjaKjSOd+ril77ObSvnTPJyrL5ALZfI331Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W7agq9ky; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T4jw4S006174;
	Mon, 29 Jan 2024 05:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=FeTIgqoD2Whj1jGX3dIBR/SxQijY1xMPeVCIBiH7Be0=; b=W7
	agq9kyF392Tl7yROh+KuHKS4ohIM7w3CWEtu6yAFF/TIRQbkRTNpZ+lfo699G92v
	z9Jq3rFav7je9r1aT8EVmzFqlSG2HHSqwvD5cSqN1mBOJnj0CAB3WQ/H2FMrz8qr
	K2AZ7/sztQprJN4OLLUKLIV2tori00i9gwc0QHQ3vyRgluWxSXUX4QU2JGFoyjr0
	z7cWYVKXi2c85SvGkk/OmwXioK0JGhWBhtQ28TduUMnxOdOxjGJ8qOG5Eiktl5zS
	2o9zE9j0xzj56DNJpBp1CO6rwKkyovnQiJatInj29ufcSbgRFV+jmz2hc5e7dUpl
	fCq4icriv21pW/B77s+w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx3rqg6n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 05:28:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T5SotN031596
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 05:28:50 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 21:28:49 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v6 1/5] wifi: cfg80211: send link id in channel_switch ops
Date: Mon, 29 Jan 2024 10:58:28 +0530
Message-ID: <20240129052832.905113-2-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240129052832.905113-1-quic_adisi@quicinc.com>
References: <20240129052832.905113-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: 7LK14akwI4UldQsxM4utjj6oWaV0ijRy
X-Proofpoint-ORIG-GUID: 7LK14akwI4UldQsxM4utjj6oWaV0ijRy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_02,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxlogscore=938 spamscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401290037

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


