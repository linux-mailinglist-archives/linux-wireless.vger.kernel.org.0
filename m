Return-Path: <linux-wireless+bounces-21623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39A3A91270
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 06:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F2C3A92C9
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 04:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BAA1DE3BA;
	Thu, 17 Apr 2025 04:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UipzyUwh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7251DE3AC
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744865865; cv=none; b=uKASyLD1yhKbvKlFoxn7fek96MHphUvoyq+5+a5a3xHBE/qnNZLbgIVNk6Nwzif/duk5PXXF9Bco2QddPRCiRw37ggb0+zhyHzuYF3Uz4TAncwQt5XmsNHVA3EvKy7+mv4pvy32c5iM0tEDkzUzVPD1zkJCzNUOsCSH8zgEfFgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744865865; c=relaxed/simple;
	bh=AQ1dpMfnGnCzsmBiUlovwaxVr2tGoAQSgOMZcBudmjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czXyLg5Bckb7I/6EQ/bVzaxOIRVz3ZUagNV71yKEom8ovxx7YMr5xsiUngvb7Z1g8X4k5bbdXYqUvPrpSRFTk8vIn8mWLKplbZVSBDwKNCAoqAOR4OEWt3cF1y12JfIW1jw/Hw2mXLAQXfvJOh/dmeSOOSFmbohPTdI34JrMCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UipzyUwh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GLk6oB020618;
	Thu, 17 Apr 2025 04:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ddIoHvGwW+P3+MqNz7iPBEdrKb7ho3kLANsAYyfViNM=; b=UipzyUwhITUXvaVr
	mRdM/pRisv0og96Om14rrLM6t4+6I14/FrGelquVpfoy0mXHvuwLNFbvQ9GkwyhD
	0Fy3T0XdTDjYQjpZZOfv/H6HszS8m8OkP9dwnuO+3gFZZ/YARzHpPNkUWmxDH58X
	bvYs4qJMfJBcCHtriE/kfyIQNNDkb+6eKkWRtwGcJjY/WOi/S7CLf4TtRGtwbPvM
	ag3EoGEt5j2z4zIt5fmBdpdKNoRjNPw719/xzOupsb4y+O++6wJYJ11WedAMK0FO
	BmsQ6nz6WxOiSeGn46VFk9+fXSaZfsE+FfWOK/dL4LfzDS6HrfhHwHymq9UPOc+/
	A0T1gg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8wnpqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 04:57:40 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53H4vddt008965
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 04:57:39 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 16 Apr 2025 21:57:38 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next v5 6/6] wifi: ath12k: fetch tx_retry and tx_failed from htt_ppdu_stats_user_cmpltn_common_tlv
Date: Thu, 17 Apr 2025 10:27:09 +0530
Message-ID: <20250417045709.770219-7-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417045709.770219-1-quic_sarishar@quicinc.com>
References: <20250417045709.770219-1-quic_sarishar@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=68008a44 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=0ySGWpZ9h4q4K3gXlG0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: E5KkOHI3jBnSzWvWQ4Ok3JMwnB1aYw6F
X-Proofpoint-GUID: E5KkOHI3jBnSzWvWQ4Ok3JMwnB1aYw6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170036

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
 drivers/net/wireless/ath/ath12k/mac.c   |  5 +++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 44e02ebb1071..092ee17ee07c 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -530,6 +530,8 @@ struct ath12k_link_sta {
 
 	 /* for firmware use only */
 	u8 link_idx;
+	u32 tx_retry_failed;
+	u32 tx_retry_count;
 };
 
 struct ath12k_sta {
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 54057113b2a3..d4b29248423b 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1368,13 +1368,21 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
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
@@ -1496,6 +1504,8 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 		break;
 	}
 
+	arsta->tx_retry_failed += tx_retry_failed;
+	arsta->tx_retry_count += tx_retry_count;
 	arsta->txrate.nss = nss;
 	arsta->tx_duration += tx_duration;
 	memcpy(&arsta->last_txrate, &arsta->txrate, sizeof(struct rate_info));
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 30643f8db487..ede4b75440a2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10571,6 +10571,11 @@ static void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->signal_avg += ATH12K_DEFAULT_NOISE_FLOOR;
 
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+
+	sinfo->tx_retries = arsta->tx_retry_count;
+	sinfo->tx_failed = arsta->tx_retry_failed;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 }
 
 static int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
-- 
2.34.1


