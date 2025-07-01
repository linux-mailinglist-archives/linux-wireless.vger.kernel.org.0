Return-Path: <linux-wireless+bounces-24722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA1DAEF5F0
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 13:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF296189B23A
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 11:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47907271A9A;
	Tue,  1 Jul 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I3z/lZhY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A145B270EB9
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367596; cv=none; b=K0TjTL0laqwrK4C5cpj/K0C/E8Gy1VfICtG0Tk6gnSFsKT9f8hcUFCAW1TpL2ld4+rlig4pigfN+G7+9lzyhRvUY2eHOvkgdwBxlzj2EzICq5t0KeelYC90SgwCboHkHhkb2I2Pa5K9HOduuudBjrmO+fStzRKIlapeEmVivPzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367596; c=relaxed/simple;
	bh=hD6hhDKGGfXfrGNvGBF9dRefPRPHDxTDsccsAunhlng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0MJyRytU37h9Vege9oIHblazWdKRHJegl+cLGQiE00dp9WQP3f/0z5obc1547+MD3olMV7ynA0FFE55og/8lpcTUScIK1XblUmkdTFDf9MgvNa0A7nsjidfkMtvmbHokSdoXqkblFHdTf0/JYFw1iZP4qWUNHs3DdjWw2zkcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I3z/lZhY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5616rGll031491;
	Tue, 1 Jul 2025 10:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qj9c3sg8yS+3a9NdblKZGcm8lagf0rI+WPx03c6kphg=; b=I3z/lZhY+7rkBoZZ
	6BtYjU3L2Twa6xPSWkvXlkA3pPNuqz6CQOXAjWl6a56j/fojvWagXYzBt7pqSf95
	CZIUCbYq6QHQSW2C8zsXJbK27ttjrAW4Lg3DRZZzhPfbRfifmQYeF4cfVWf3sx/E
	Ws2SX0c2MAOplvLUcfQtx15ZXf/ljT9SHIPfuX4ZjU0+tdKmH77sUvsV8C+XNFsA
	CuGeU7+/K4G6aVSBYXEgxsitScObVqgBCTUb2MIr+XrqhLsdx9CVLo11zLYCsnP+
	DjLU6PAx7Wk54DvmC5ISz0FflHt55x+tmIFG1xJM3Gi9ngIzMtJomhkt5RvIH1U1
	VgnyZQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47m02v2mgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 10:59:52 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 561Axpsm022310
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 10:59:51 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 1 Jul 2025 03:59:50 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next v8 4/5] wifi: ath12k: correctly update bw for ofdma packets
Date: Tue, 1 Jul 2025 16:29:26 +0530
Message-ID: <20250701105927.803342-5-quic_sarishar@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2NiBTYWx0ZWRfXwcJocGNlaB8n
 vcJiVVgeszgEwN6WWtS70cNWZywaw4UnsKwEjeXJRTHgMo0KYsdpPxnQ7lSN+MfqriLncjfSfGo
 i7BvA+x73cGqVHpOQYZI4dToTmG2AuvFMhNciopJSYW/fpdih1mhvgYk5foCm6kyDi8hKCPnUg5
 Y6rsPNX51EeKgsSx7bT7cAfhjrb7L9dpz+Yk8waPkh9oCGQ2HFTsQbTPCNtzOwfAMDtDc1JqXqS
 1pHrknSGDZrlCInggchn+Q00jUp4dL+ZvEbQsmNjb6SgZy1wJNkhRjkiPUXOxyffmsCA1mmpKpl
 4QZ/vNM83Q8JM/V85PWHpVBDF9iXTkqQSbT0jqXlKevdQPKRV4yVqiQMAW87q7dNZfEGRfNq5Pr
 kVKGcOhXz0cwsfxOyLXdXEozdCd9LGcZF2c2FGlC4OnG6ERlj/cvCaGHZ3HbAhV4Ng0s9LkH
X-Authority-Analysis: v=2.4 cv=Y8L4sgeN c=1 sm=1 tr=0 ts=6863bfa8 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=WP206t09-qgxmGJDAAsA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: kPi1dtRILY-r0rF3lM_3JbOL58GfRntu
X-Proofpoint-ORIG-GUID: kPi1dtRILY-r0rF3lM_3JbOL58GfRntu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507010066

Currently, arsta->txrate.bw is filled from ath12k_mac_bw_to_mac80211_bw(bw)
during ath12k_update_per_peer_tx_stats(). But in tx_completion path bw
is filled differently if ppdu_type is ofdma for HE/EHT rates.

Hence, update arsta->txrate.bw correctly if packet is ofdma for HE
and EHT rate.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.h    |  2 ++
 drivers/net/wireless/ath/ath12k/dp_rx.c | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index a353333f83b6..0c1fece27264 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -1559,6 +1559,8 @@ enum HTT_PPDU_STATS_PPDU_TYPE {
 #define HTT_PPDU_STATS_USER_RATE_FLAGS_DCM_M		BIT(28)
 #define HTT_PPDU_STATS_USER_RATE_FLAGS_LDPC_M		BIT(29)
 
+#define HTT_USR_RATE_PPDU_TYPE(_val) \
+		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_INFO1_PPDU_TYPE_M)
 #define HTT_USR_RATE_PREAMBLE(_val) \
 		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_PREAMBLE_M)
 #define HTT_USR_RATE_BW(_val) \
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 0f5edc81fc5d..7be9f8c02c67 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1423,12 +1423,12 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 	struct htt_ppdu_user_stats *usr_stats = &ppdu_stats->user_stats[user];
 	struct htt_ppdu_stats_common *common = &ppdu_stats->common;
 	int ret;
-	u8 flags, mcs, nss, bw, sgi, dcm, rate_idx = 0;
+	u8 flags, mcs, nss, bw, sgi, dcm, ppdu_type, rate_idx = 0;
 	u32 v, succ_bytes = 0;
 	u16 tones, rate = 0, succ_pkts = 0;
 	u32 tx_duration = 0;
 	u8 tid = HTT_PPDU_STATS_NON_QOS_TID;
-	bool is_ampdu = false;
+	bool is_ampdu = false, is_ofdma;
 
 	if (!(usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_RATE)))
 		return;
@@ -1457,6 +1457,10 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 	sgi = HTT_USR_RATE_GI(user_rate->rate_flags);
 	dcm = HTT_USR_RATE_DCM(user_rate->rate_flags);
 
+	ppdu_type = HTT_USR_RATE_PPDU_TYPE(user_rate->info1);
+	is_ofdma = (ppdu_type == HTT_PPDU_STATS_PPDU_TYPE_MU_OFDMA) ||
+		   (ppdu_type == HTT_PPDU_STATS_PPDU_TYPE_MU_MIMO_OFDMA);
+
 	/* Note: If host configured fixed rates and in some other special
 	 * cases, the broadcast/management frames are sent in different rates.
 	 * Firmware rate's control to be skipped for this?
@@ -1506,6 +1510,8 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 
 	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
 
+	arsta->txrate.bw = ath12k_mac_bw_to_mac80211_bw(bw);
+
 	switch (flags) {
 	case WMI_RATE_PREAMBLE_OFDM:
 		arsta->txrate.legacy = rate;
@@ -1534,6 +1540,8 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 			le16_to_cpu(user_rate->ru_start) + 1;
 		v = ath12k_he_ru_tones_to_nl80211_he_ru_alloc(tones);
 		arsta->txrate.he_ru_alloc = v;
+		if (is_ofdma)
+			arsta->txrate.bw = RATE_INFO_BW_HE_RU;
 		break;
 	case WMI_RATE_PREAMBLE_EHT:
 		arsta->txrate.mcs = mcs;
@@ -1544,11 +1552,12 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 			le16_to_cpu(user_rate->ru_start) + 1;
 		v = ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(tones);
 		arsta->txrate.eht_ru_alloc = v;
+		if (is_ofdma)
+			arsta->txrate.bw = RATE_INFO_BW_EHT_RU;
 		break;
 	}
 
 	arsta->txrate.nss = nss;
-	arsta->txrate.bw = ath12k_mac_bw_to_mac80211_bw(bw);
 	arsta->tx_duration += tx_duration;
 	memcpy(&arsta->last_txrate, &arsta->txrate, sizeof(struct rate_info));
 
-- 
2.34.1


