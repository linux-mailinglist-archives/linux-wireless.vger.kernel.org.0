Return-Path: <linux-wireless+bounces-24627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 037C9AEBDF3
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 18:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734E06A1445
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6962EA730;
	Fri, 27 Jun 2025 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jEzjmNxt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760462E9ED4
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043564; cv=none; b=C16skP+dLk8rpZefVS/JlY/M2HZZxYXrLUbU7ziTjUd3VlENIHzt7tvq7KAXLEaSy0VKK3nP48fcrISAKaCnRvAxosj5Nm4neQWRTM3JkXmpzPC3EtH1PoBmKXt2dWH2p94YQjHrpCNeLYZ5J/8DmmnJyluvQjn6I3sn8D8gREI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043564; c=relaxed/simple;
	bh=um5YWMAuY642rXADGQHR2c+NNk3bWctgf1qysus3w8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfAEgKGoCE2aBQvlGrn1RQP44EwTgbt/9R8RcRJ1+oChFKcaanpazs0tfZRoTCo8r9S9vuBq91n4KS+3OsjQ4YRWrGqKppAbW0ifnGJACq6lAhej8RgYKvrQqA2fKS2k9fAY9qp/FMsISJ6vZbavjT2NM0yy0HaPQnwlFhmK1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jEzjmNxt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RCHhDW007786;
	Fri, 27 Jun 2025 16:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WE8pr/fU5WTXe63tbRjSwg8Tv9UVkm0A7QGWGuk/7EQ=; b=jEzjmNxtzyf1laCk
	x1nj8NCRRyxsY2Zx25jHBpeveERHaw1ndojqyb/FzcaaDkP3lh5ZAUnCnc+06jX1
	Tq3n4SfXt08FongDqse+OJ0RhOuvYsM0dvZWjPra5W24YpHEVaeMwfAysjdl0GE5
	TszAqq8IK6q2TL4HDf8I+naV30vEUEBbfBASvnatFnYbMGNOXjfayTRPXSfY0FDn
	qYRPhJ/H5t3ri8Nv6MKt4h4/7lCo0kpX21b60AF7Wv3lQNp3ORnLTqNk3oncOZjd
	Mg8W1ID5Wgi1gFP+IQilo79Zy/2oaOcVu1gFan8HnSUx/Wkhb0KkukLyfLBG1gMF
	PjqgLA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbhqwvuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 16:59:18 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55RGxHSg012828
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 16:59:17 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 27 Jun 2025 09:59:13 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next v6 5/5] wifi: ath12k: fetch tx_retry and tx_failed from htt_ppdu_stats_user_cmpltn_common_tlv
Date: Fri, 27 Jun 2025 22:28:48 +0530
Message-ID: <20250627165848.3178339-6-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627165848.3178339-1-quic_sarishar@quicinc.com>
References: <20250627165848.3178339-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SBxyN8sBAlstGvVQrfBrcDhZfMsyIz0O
X-Authority-Analysis: v=2.4 cv=Id+HWXqa c=1 sm=1 tr=0 ts=685ecde6 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=oAq0YBx28stV0eL2X4IA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: SBxyN8sBAlstGvVQrfBrcDhZfMsyIz0O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEzNyBTYWx0ZWRfX032I2tOaDDr8
 zZTQXFFnTV79t2QhW8V6QPM3TZ9LyaZLiBRV/LQBwSP4yZWmIbi1/LQHeTgUrIKLi+r/6uM1F8M
 CWKNEXl4MSkEjPddfOO4iqlSAtgs6e+LdLlHinu2ZYTvQW9oNPLkGsAZDscBchRE4bfO5S/dImi
 ozHlQzN+2GzV/uBrZuJQoQAJM7U0sA3txxB3dPbwAs2+aDn2r9zCakG2h+Zpp0XL+MC/UdYBao4
 4XSBGPdHkJ4xGxdLcAz7RYhDIJYoHzHk+xeXfle8YWAnZTMpjDVTS1SGlT07KL20+9y4bTENjb0
 iaKkTyMMl57Y26/5owV9TEqaAnaQQ4o9ty43wu9/gHGG860jZHELSzYfectvsPxavbzlqK2GaFG
 XbHazshI9yC3ubVgGyX5W0ogSb0ZpYkK+vdxX5jYyDGAcwDn8/ug4X7rG0pqnI05eziNmNEb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270137

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
index 0c1a6df7a02e..053280589596 100644
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
index ff92ec764ae5..3c6407156b24 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1429,13 +1429,21 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 	u32 tx_duration = 0;
 	u8 tid = HTT_PPDU_STATS_NON_QOS_TID;
 	bool is_ampdu = false, is_ofdma = false;
+	u16 tx_retry_failed = 0, tx_retry_count = 0;
 
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
index ec03d4470085..9c6c0aa28ffa 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11650,6 +11650,11 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->signal_avg += ATH12K_DEFAULT_NOISE_FLOOR;
 
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+
+	sinfo->tx_retries = arsta->tx_retry_count;
+	sinfo->tx_failed = arsta->tx_retry_failed;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 }
 
 static void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
@@ -11727,6 +11732,11 @@ static void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
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


