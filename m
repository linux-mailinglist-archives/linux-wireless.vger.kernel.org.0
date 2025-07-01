Return-Path: <linux-wireless+bounces-24724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E9DAEF5F5
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 13:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF381C01808
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E11272E53;
	Tue,  1 Jul 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kjpv+G6W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0CA271A6A
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367597; cv=none; b=ovAMmy2LfLMdsQ1Jp7YjQ/drV6mmxj+rDjuP/xL3ccBSWf2rkKNd03+KXT7NnGEjDWrpGPQ8z5MbeUOgV2nawK2oJ53R/ggpzN1L6Xjb6R9XRQrENVgco7bbX5WvzVCXUOQtAvg7Zqg1nFxhBWVQbdyL4ddnOJdrR9JNl4s26tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367597; c=relaxed/simple;
	bh=Y3EyDojK+fagtI7fowjM0VXRD3JPFLpDhRKELIHpZTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfWofY9e8/YkiYN8kV32e3XXIyM/Dpxif08iTGI4lFtFNeXLB5cnTCVm1g4D22etgv8DHTg7n71qAxJfpbMEKNqlx27ym/unTgCCc/jNWY2mQ9L+GMT3ns0+93Sb+FU4qf4sP+93JqrOL0989I5iPcDuM8zJESTQ6JPXN1Sj0N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kjpv+G6W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5619tMvJ029344;
	Tue, 1 Jul 2025 10:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4bCPk6nI8sSurd5oKtH4fP2vBFBMabZennQXng5THoo=; b=kjpv+G6WTNgju/QR
	yLv87S8x8MalVNLogMMDX4eec+NLusrG3KGsxUBWFF+N7CPHtBKCt/BK1O+OzFys
	Z+JGd4D3Mrh9ncqGBoG/zylurdSpNSNBVKIKrhjSHsr8incO0GLHCCNVX1Y7s4JC
	uYKGFs+9xTXj3iymVd1+9EZrQuiQbAamtOUbKhmK0mCAH4oU5Jh0y2gfP6FQyYtO
	bBq2I+E5HmPoM+wIzVwd21aQkatN5whlCBmZ9JmAkGamYws9qbobWlIvZXPZzmc1
	XOb2c9f/LIkNeDFBvqXHcOFerrEdI1rh2MEuYVN2ncq/DIvxoNeadnZlvunYEL3Q
	1PFflw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j95j0d0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 10:59:54 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 561Axr40002592
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 10:59:53 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 1 Jul 2025 03:59:52 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next v8 5/5] wifi: ath12k: fetch tx_retry and tx_failed from htt_ppdu_stats_user_cmpltn_common_tlv
Date: Tue, 1 Jul 2025 16:29:27 +0530
Message-ID: <20250701105927.803342-6-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701105927.803342-1-quic_sarishar@quicinc.com>
References: <20250701105927.803342-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2NiBTYWx0ZWRfX+3gW9Okwwyjo
 EN/gA2vqtAF+/PBiYtbWbdgx8ngxpPBIeCVp4abU4w5mdmFFhW0uGIQ2hONI7KEScM445eZNgfB
 h2h4xJX00Cro4v+4096vp6LerU4irdppR3K80uL9a2mtsybqnExHQlDR3/vRhIg7/CU6+CQB/gj
 /zGak5ExTCHprvCJyxESyNXwnyye760f0RjsYL6EiMPYJf9X/t6UJ1TwH522mk8Vwi7bdWUMbTs
 Hfizyjq3NANl2r//cquzkNvCz/0gLFzR+fMv9Q/1yJ75KJriioqnKFjaCju33D/Phwejq00AN/O
 krgK4nfmxKaNdfnLlykyMZK2SR/e22Eylci/ngRo1rWqy205lyhi/uJvvpJIiH1f7/O8tG5OUaR
 mEaP5MA/RsABJtDoZ02IGLk7jyXxDTmAPDHfBfmP5tLYQywBr8whYJaKeCZiuHxatAWCzCIf
X-Proofpoint-ORIG-GUID: QJtrA9Qpa0MgaqIg5IMrCyFMds0TE8r1
X-Authority-Analysis: v=2.4 cv=EuHSrTcA c=1 sm=1 tr=0 ts=6863bfaa cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=oAq0YBx28stV0eL2X4IA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: QJtrA9Qpa0MgaqIg5IMrCyFMds0TE8r1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010066

Currently, tx_retries and tx_failed are updated only in mac80211 during
tx_completion path for sta->deflink. This works fine for non-ML
station but for multi-link (ML) station, these values should be updated
for sta->link[link_id] as per tx link_id. However, in tx_completion path
there is no way to determine the link_id for which packet is retried or
failed.

Therefore, update the tx_retries and tx_failed in arsta structure from
htt_ppdu_stats_user_cmpltn_common_tlv during
ath12k_update_per_peer_tx_stats() call to utilize the values from arsta.
Also, during 'iw dev xxxx station dump' populate the tx_retries and
tx_failed in station_info structure to ensure values are correctly
reflected.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h  |  2 ++
 drivers/net/wireless/ath/ath12k/dp_rx.c | 12 +++++++++++-
 drivers/net/wireless/ath/ath12k/mac.c   | 10 ++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3c10d7eb9669..c57e3313065e 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -563,6 +563,8 @@ struct ath12k_link_sta {
 
 	 /* for firmware use only */
 	u8 link_idx;
+	u32 tx_retry_failed;
+	u32 tx_retry_count;
 };
 
 struct ath12k_reoq_buf {
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 7be9f8c02c67..ed325aa6322d 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1428,14 +1428,22 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 	u16 tones, rate = 0, succ_pkts = 0;
 	u32 tx_duration = 0;
 	u8 tid = HTT_PPDU_STATS_NON_QOS_TID;
+	u16 tx_retry_failed = 0, tx_retry_count = 0;
 	bool is_ampdu = false, is_ofdma;
 
 	if (!(usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_RATE)))
 		return;
 
-	if (usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON))
+	if (usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON)) {
 		is_ampdu =
 			HTT_USR_CMPLTN_IS_AMPDU(usr_stats->cmpltn_cmn.flags);
+		tx_retry_failed =
+			__le16_to_cpu(usr_stats->cmpltn_cmn.mpdu_tried) -
+			__le16_to_cpu(usr_stats->cmpltn_cmn.mpdu_success);
+		tx_retry_count =
+			HTT_USR_CMPLTN_LONG_RETRY(usr_stats->cmpltn_cmn.flags) +
+			HTT_USR_CMPLTN_SHORT_RETRY(usr_stats->cmpltn_cmn.flags);
+	}
 
 	if (usr_stats->tlv_flags &
 	    BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS)) {
@@ -1557,6 +1565,8 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 		break;
 	}
 
+	arsta->tx_retry_failed += tx_retry_failed;
+	arsta->tx_retry_count += tx_retry_count;
 	arsta->txrate.nss = nss;
 	arsta->tx_duration += tx_duration;
 	memcpy(&arsta->last_txrate, &arsta->txrate, sizeof(struct rate_info));
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8aa74c9171f8..5a1726a145f5 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11684,6 +11684,11 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->signal_avg += noise_floor;
 
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+
+	sinfo->tx_retries = arsta->tx_retry_count;
+	sinfo->tx_failed = arsta->tx_retry_failed;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 }
 
 static void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
@@ -11761,6 +11766,11 @@ static void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
 		link_sinfo->signal_avg += ATH12K_DEFAULT_NOISE_FLOOR;
 
 	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+
+	link_sinfo->tx_retries = arsta->tx_retry_count;
+	link_sinfo->tx_failed = arsta->tx_retry_failed;
+	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 }
 
 static int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
-- 
2.34.1


