Return-Path: <linux-wireless+bounces-16689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A1B9F9E7F
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 06:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8A416B959
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 05:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9421E3DF7;
	Sat, 21 Dec 2024 05:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P4TvYPbq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8EA1EC4C4
	for <linux-wireless@vger.kernel.org>; Sat, 21 Dec 2024 05:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734758593; cv=none; b=NAMaqUMeoBlkRSTZkigbPM9JtTrFCMMxMOIhbaGfiPvZoNwJ8ArNVF+1npwAS6+6/sDR94tFiHo/RJZxr1OIzUTAQ+yshxDTvKpQPMizku/3b7oAtrSlqiWORTCAuiT/yjUT/5m7JZ5QxmQ0JPPU28QuUc9NLgOUXAwe7ZvgorY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734758593; c=relaxed/simple;
	bh=5er73hKMkHngHfysSgjgfrcpJ3pkQizibuSxOzDIHUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJH9V4gTa418osNEJjSXAiGlhn2xRhTh+XQDWm2pioTnxe3hRwuKHmYHedh+SicrnqxG2rqhNG4eCi6z/rSIbbPTY64ryxUWA8SzWZwATwPmVzoByesPLNjDWf8Dn8kzlmaDaP7NGUK0VMAgUOJS138J0XK2RcUpVejoifw8XGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P4TvYPbq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BL4C1CZ009238;
	Sat, 21 Dec 2024 05:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HLxw5NUKgrUwMyATGWq9eRmSypDOX64X3/jnl9bdIE8=; b=P4TvYPbqMCEtXhHs
	vdGb8sVLi7mdor2Y63eg5OxLgoqbRstBsdaGsxbWj/jmDrNpaqoVGW/mEHp+BY8s
	vNfp2dSXuTs3dpWVecprcgCjShRApnKS87Wo+M96qyRjwmJs3W+ORQZ0n/+bU4Xe
	A74cz4opDiR2UD7LEwVkDophW9wfvIBFdqjoXyg8SUgt5v5xChtoFX3KYHZTuDue
	iXHC9IYILtn30QEOQhQfq5e2sHfrU3Pa+dqhINdZ/QBZrSMzQpvVgyCiHkwOf0wT
	EpuRXmWNCTc/YL735pL68BZR7dwRArooq+//RDDYGFx4d6RCOY5Kp0l7LxZ6BGWQ
	HXUt4w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43npeh86ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 05:23:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BL5NAwH012742
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 05:23:10 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 20 Dec 2024 21:23:07 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Balamurugan Mahalingam
	<quic_bmahalin@quicinc.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 07/10] wifi: ath12k: Add EHT MCS support in Extended Rx statistics
Date: Sat, 21 Dec 2024 10:49:16 +0530
Message-ID: <20241221051919.686500-8-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241221051919.686500-1-quic_periyasa@quicinc.com>
References: <20241221051919.686500-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: jXOjZPPBDxkiwVZaJyZ1Xeqpd0BrvdiJ
X-Proofpoint-ORIG-GUID: jXOjZPPBDxkiwVZaJyZ1Xeqpd0BrvdiJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 priorityscore=1501 mlxlogscore=880 mlxscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412210043

From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>

Currently, EHT MCS information is not populated. Therefore, add the EHT
MCS counter array to the peer rate statistics and update the EHT MCS
statistics from the status TLV data in the monitor Rx path. In the future,
this information will be used in the peer extended Rx statistics dump.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h   | 2 ++
 drivers/net/wireless/ath/ath12k/dp_mon.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ad69d8544357..f934faad51bc 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -355,6 +355,7 @@ struct ath12k_vif_iter {
 #define HAL_RX_MAX_MCS_HT	31
 #define HAL_RX_MAX_MCS_VHT	9
 #define HAL_RX_MAX_MCS_HE	11
+#define HAL_RX_MAX_MCS_BE	15
 #define HAL_RX_MAX_NSS		8
 #define HAL_RX_MAX_NUM_LEGACY_RATES 12
 #define ATH12K_RX_RATE_TABLE_11AX_NUM	576
@@ -364,6 +365,7 @@ struct ath12k_rx_peer_rate_stats {
 	u64 ht_mcs_count[HAL_RX_MAX_MCS_HT + 1];
 	u64 vht_mcs_count[HAL_RX_MAX_MCS_VHT + 1];
 	u64 he_mcs_count[HAL_RX_MAX_MCS_HE + 1];
+	u64 be_mcs_count[HAL_RX_MAX_MCS_BE + 1];
 	u64 nss_count[HAL_RX_MAX_NSS];
 	u64 bw_count[HAL_RX_BW_MAX];
 	u64 gi_count[HAL_RX_GI_MAX];
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 68dda1b58cb7..7e5c1ac6d0cd 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -3051,6 +3051,12 @@ static void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k *ar,
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


