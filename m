Return-Path: <linux-wireless+bounces-2817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8788426A8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 15:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5459E1F250F1
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 14:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606296DCF9;
	Tue, 30 Jan 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="biOndTOc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E756D1B1
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623789; cv=none; b=Ivc8SalYtvp9TzwrIthtE72bjuKyF7wIea9daVapmIWEUcAOYIx4NLjA2Bmm8fzv7Q2S51LxmnGfxt9xrBMfybOQhAqkteJZxik9vr0vxvfHEwNZVjqi/qzYKysd+70TBvkgTn3scqr+2zn5sb7HiVmlByw4NzvGEVAlriA1mVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623789; c=relaxed/simple;
	bh=up7FsmrCLODI6L1lLeihnBKJchTXkz74Y+9lseeYDM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nUYpLZLu/QOzeok9jqb0Ok2CQDr7Ery5ptEG40tX7bfWC+d0U2QGurLCAwuAvzUVNknMtlAFj5xvty7tDJs67bbFSzdR9WodTmZwSfS13vGV7xYbwc68lQzbs98AkJP0NX6p0xt9vG5ibJrP9XDu1Yb3NbaPNWuaB5Y0CgDFcs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=biOndTOc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UCmW8m016128;
	Tue, 30 Jan 2024 14:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=hFlf893pYwkyyWup8OtaeJ9zdq6/jk6Z0yNUu4q4XO8=; b=bi
	OndTOcvR9N/dxkOGJIA0l5kEcN3KrFpXhGgjYL0Ed9d8y1ybdIOPYnLEf1CwvQF8
	xVa0GFtYY6wvoAUBuKItjAAJLSjPfQXSDX93Yq+vRq/u9zyMe+tPR6wOt46pTZCd
	yEOVIQS8mf240yy4047aPq6M/pUa7wxbDKIDptlxdx8w1dCj7CjGtB3sYRMVfkxg
	KhCKQ87+6+qwqCPe/1itYThfdvDthX4hUkhU5qgf0KOvk69g+G7iVE2EAgaWAU99
	mOZpTTqOU9SaV/b+3e00j81iiNHUxo7pm2U/jdO/xgfvuYjn+nyN5P3QbVnsGHpG
	lk+gxWKu+d8Mv/LsYSFQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxr2v1ax2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 14:09:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UE9hE0026986
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 14:09:43 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 06:09:41 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v8 1/5] wifi: cfg80211: send link id in channel_switch ops
Date: Tue, 30 Jan 2024 19:39:14 +0530
Message-ID: <20240130140918.1172387-2-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130140918.1172387-1-quic_adisi@quicinc.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: 7EHiI2ZDsCsC2xMS21crkB2WpUwFULDh
X-Proofpoint-ORIG-GUID: 7EHiI2ZDsCsC2xMS21crkB2WpUwFULDh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=938
 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300104

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
index 51b9e6fa12f8..60d99336751a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1531,6 +1531,8 @@ struct cfg80211_ap_update {
  * @punct_bitmap: Preamble puncturing bitmap. Each bit represents
  *	a 20 MHz channel, lowest bit corresponding to the lowest channel.
  *	Bit set to 1 indicates that the channel is punctured.
+ * @link_id: defines the link on which channel switch is expected during
+ *	MLO. 0 in case of non-MLO.
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


