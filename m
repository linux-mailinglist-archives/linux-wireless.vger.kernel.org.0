Return-Path: <linux-wireless+bounces-23461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E33F1AC6162
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 07:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C6E1BC2A1A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 05:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A18520C00C;
	Wed, 28 May 2025 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W+k1h7pR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3D7207DFE
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 05:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748411102; cv=none; b=LOY32x9bsGSdW13Wh74a4sOZuSc+iYlbSoePO7bAjCQ/ldcd8RsmDrXthl74opTiT/cb9IXHlNdR4pTU5joehlSQN/SSRLuP3O7HS0TAI7X9vfn00hp7S3ovghpaq5TH6ZbGCEOidJVlIqM9cT3VK61aci+0DeaIK28qc55qkWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748411102; c=relaxed/simple;
	bh=g7w+pqROPuMNmYuwcvP5lcOHtHX6LpOHgj6XH1FK3co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIlt5t2oD04hFeY3BSkKzveCcACy3/v0cRF1WajsKbENJf21ws617iODr6TahkImyOLlRgA+CwSbbtC9kBkIjQGWwuSVuLRo7SD9zdRZpJs2oiSTAggziUE9AIatxe+fiMzckSWLJ0yxbFYGA6eGLC/EzfT5Y939mueHlJMZzEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W+k1h7pR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S0w8Nk019819;
	Wed, 28 May 2025 05:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9NT3N8CDRFMmqjV5qdcn3wWt4iMElb6vL6dHTJxidP0=; b=W+k1h7pRrsWCpX6H
	hppi2h04yfbbk/PT24B+5sI4jziSO3B2DBiAT1T6Hki1kulPfoaLix/m6Roo6HGO
	Pxg1k0vITppxQWX+3w/BhtrHeB3+jKGWnASsCLcUTn4x0ZD+M0Kv/wPKAFwGcRzc
	ZAqC/3gW4iSam2+FXJBi58789xQ7qWdmgYsnskR/j5Pe/CUnG3VG07orlxZOvP2y
	kO3LInwMNRWJ1SG0c9gJRCmVsfTxiCFSR7/8VL6KZzt8z9ZNHq5FGM+ZQ602oyl3
	mA1sPTv63OZlxNNTWEDyzAM/eIyGldZmoPs0yS76dv2JNa4bnVHyRVylXDJeK4+j
	DWDPcA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u5ek13sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 05:44:54 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54S5irWI010326
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 05:44:53 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 27 May 2025 22:44:52 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v10 09/10] wifi: mac80211: correct RX stats packet increment for multi-link
Date: Wed, 28 May 2025 11:14:19 +0530
Message-ID: <20250528054420.3050133-10-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528054420.3050133-1-quic_sarishar@quicinc.com>
References: <20250528054420.3050133-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=GIgIEvNK c=1 sm=1 tr=0 ts=6836a2d6 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=DHE891H7Gske2VlohvUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: fcH4Aifsn8K__NAt9rw4IFrDm1S_jiG2
X-Proofpoint-GUID: fcH4Aifsn8K__NAt9rw4IFrDm1S_jiG2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA0OSBTYWx0ZWRfXx1mhM9LZjC7v
 vEgXTLqwN4uydIjPF1vr95wG1iz3pmuVRFP+s3Ic2Kvk2OHCqilF7ioNfR57NAA3xuAdKsOLUye
 FWhLEoHh4OnhG1PgUYceKLTV6HUa6X4JlhG6ISRD4l6MLWekaGISBBbrnHomau4s/hW+hFwA9B4
 2ETIT45sIkoiMG5Q3BHjz58TtikjQPTPZ6vK2o1RHhk/CeAMRC/KyCXiAVBuXF5qsICLOMheCFu
 SBUX0QGYm+6NNt98L7JbrDh/qkW0BztdctyUMPXvneza1Lumuw+U1PSDsrt7OvkTSgXqtXryv0s
 C160QLdIA0+wNU8dYXJ4GhTAW0YLTGFJozSLmq8/ywQiFLDLnwIqRSm0oMqeVLgnOjp44zF7DYe
 mHxkqWtnQqpdUrgLUdpdg3XQccsbTPv/hJgEpWZIKxEdIbWcsxwJMZLM0xYCxNpPnssACkVb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_03,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=967 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280049

Currently, RX stats packets are incremented for deflink member for
non-ML and multi-link(ML) station case. However, for ML station,
packets should be incremented based on the specific link.

Therefore, if a valid link_id is present, fetch the corresponding
link station information and increment the RX packets for that link.
For non-MLO stations, the deflink will still be used.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/mac80211/rx.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 09beb65d6108..a3222c0e86ac 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -231,8 +231,19 @@ static void __ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
 
 	skb_queue_tail(&sdata->skb_queue, skb);
 	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
-	if (sta)
-		sta->deflink.rx_stats.packets++;
+	if (sta) {
+		struct link_sta_info *link_sta_info;
+
+		if (link_id >= 0) {
+			link_sta_info = rcu_dereference(sta->link[link_id]);
+			if (!link_sta_info)
+				return;
+		} else {
+			link_sta_info = &sta->deflink;
+		}
+
+		link_sta_info->rx_stats.packets++;
+	}
 }
 
 static void ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
-- 
2.34.1


