Return-Path: <linux-wireless+bounces-18560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23490A29E78
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 02:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B237A3ED0
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 01:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6251D33CFC;
	Thu,  6 Feb 2025 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="niG5KPqX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02643AA4
	for <linux-wireless@vger.kernel.org>; Thu,  6 Feb 2025 01:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805990; cv=none; b=cHWYWGVJsj00qGKd7ORd7Mbd9/ecUwEBz+5UA3OYfRmWyUvCQkRbHYBH5tT36ru8chV+Ksg61rZoM0Xm7CuL2e7TcUoVFGwKp1lf2r3uMrrC19PrPASMc94ymv/jWgS2azvWTC0g5yI0X9kHwmkMLsBGHgNBsJkeCPaltiOOr7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805990; c=relaxed/simple;
	bh=8Ixc0bNqp2r6aieRasCeKQD2Q51odRDQeRGs3FeE3U4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRUWDSw/11fStwP6QEIGCndMcquz0l96CCi1vuTnY7YauZmB/Cj31CwiR0+JvUClbv8HBQmGy/dCFTEQH1bIghqqvqMjcYDGFvjmnCQJY+NfAyQWi59ouHOT0AhRxWICJOhEy2+dt+S/hdV0npzYFiINoEdkcl/GjXy2jhPBv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=niG5KPqX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GqvxW030065;
	Thu, 6 Feb 2025 01:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vWNeNJexyTz7rwQQX0hZUlwLt9ar1dL8+11/hGCxfvs=; b=niG5KPqX0lUgi68o
	tn3E+v/IzL18JemQn/gGu6lTzTH+u8vf+6DNwSsmUjFPLQE0MUryUvc3DqpT3mba
	0dge6lih+nJubzdOWRZdogTpgQocGtqGDC0O8uosqPYKdT67HJ5bl23h5S3iFt68
	ZEqr+ChxZHeQEqjcRfTKstgX6EUj8SybLwkoo5mFOaF/TbAy7yPCV0JrVT5iGun+
	oY60NifKhLqdzc+kH/3gjYlsd5nkYdOTCT7cLjzpzpkrEGmTh9/kSPmIz/1cozOT
	2jSYx5n7laQRTVy+WyYlr6LHd8TxMoVQj2ngVQPLoIjQ384YY4Hy1E5OqYumWubd
	T+lHrQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44mbw491au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 01:39:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5161di17012426
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Feb 2025 01:39:44 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Feb 2025 17:39:42 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Balamurugan Mahalingam
	<quic_bmahalin@quicinc.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v9 7/9] wifi: ath12k: Add EHT MCS support in Extended Rx statistics
Date: Thu, 6 Feb 2025 07:08:52 +0530
Message-ID: <20250206013854.174765-8-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206013854.174765-1-quic_periyasa@quicinc.com>
References: <20250206013854.174765-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: FW-bUk_hU4V2nMXKEr11aMrGAbVJSID-
X-Proofpoint-ORIG-GUID: FW-bUk_hU4V2nMXKEr11aMrGAbVJSID-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_01,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=831 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502060010

From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>

Currently, EHT MCS information is not populated. Therefore, add the EHT
MCS counter array to the peer rate statistics and update the EHT MCS
statistics from the status TLV data in the monitor Rx path. In the future,
this information will be used in the peer extended Rx statistics dump.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h   | 2 ++
 drivers/net/wireless/ath/ath12k/dp_mon.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 57e71ccbbb67..45bb243f2258 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -360,6 +360,7 @@ struct ath12k_vif_iter {
 #define HAL_RX_MAX_MCS_HT	31
 #define HAL_RX_MAX_MCS_VHT	9
 #define HAL_RX_MAX_MCS_HE	11
+#define HAL_RX_MAX_MCS_BE	15
 #define HAL_RX_MAX_NSS		8
 #define HAL_RX_MAX_NUM_LEGACY_RATES 12
 #define ATH12K_RX_RATE_TABLE_11AX_NUM	576
@@ -369,6 +370,7 @@ struct ath12k_rx_peer_rate_stats {
 	u64 ht_mcs_count[HAL_RX_MAX_MCS_HT + 1];
 	u64 vht_mcs_count[HAL_RX_MAX_MCS_VHT + 1];
 	u64 he_mcs_count[HAL_RX_MAX_MCS_HE + 1];
+	u64 be_mcs_count[HAL_RX_MAX_MCS_BE + 1];
 	u64 nss_count[HAL_RX_MAX_NSS];
 	u64 bw_count[HAL_RX_BW_MAX];
 	u64 gi_count[HAL_RX_GI_MAX];
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index a9a012b81bfc..cdc5e2c19f39 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -3028,6 +3028,12 @@ static void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k *ar,
 		rx_stats->byte_stats.he_mcs_count[ppdu_info->mcs] += ppdu_info->mpdu_len;
 	}
 
+	if (ppdu_info->preamble_type == HAL_RX_PREAMBLE_11BE &&
+	    ppdu_info->mcs <= HAL_RX_MAX_MCS_BE) {
+		rx_stats->pkt_stats.be_mcs_count[ppdu_info->mcs] += num_msdu;
+		rx_stats->byte_stats.be_mcs_count[ppdu_info->mcs] += ppdu_info->mpdu_len;
+	}
+
 	if ((ppdu_info->preamble_type == HAL_RX_PREAMBLE_11A ||
 	     ppdu_info->preamble_type == HAL_RX_PREAMBLE_11B) &&
 	     ppdu_info->rate < HAL_RX_LEGACY_RATE_INVALID) {
-- 
2.34.1


