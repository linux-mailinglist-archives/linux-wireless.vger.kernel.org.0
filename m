Return-Path: <linux-wireless+bounces-18136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07344A21B7B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 11:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090641881725
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5569B1AE01B;
	Wed, 29 Jan 2025 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FCPtRd01"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33E1D5CC6
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738148329; cv=none; b=TLy2+y59MhVQ0omQuJ/4StzNQXaqNtV78X2dHHErckQXnbncEHEje5FaJqp7aXygR4N8JE1dGW+ZALlVWU++dIX8ZYqbglfNhLfZvNNY5/8Jh9V8ABn+vkwXrFx/4ttwW3ruslBiF67Qm5+iqheOhzCa8qA7a/sNznxnZTySTac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738148329; c=relaxed/simple;
	bh=m+fqlIEOw31tLFLoSLB9uDMxkA8o0JAm98UUzPPYLNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmYoL6AF/qySdGl3j1+nrQ5GeE+ryF6KZq/xmnJmelK7S3/hJHFzg63g1rfbltFnG/q+KHdk7f1Wnho+lXd/aO5Fkyk3UBInadku0IWPnpbKD7g+c+Xv6s11s80kokk/1lvDWSS5JhUDrJ3Tm5gFBNWF3XXwkRGB78RSCN2zP+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FCPtRd01; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T8SxfJ027090;
	Wed, 29 Jan 2025 10:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q/IxGIN7uXCgXXZTmibHtibwwy3ztPzIzzej/6p1++4=; b=FCPtRd01oLN8XqT5
	/YKjiwBZ8lhfFP4bI+x6KUXBskeExPp1Q38wFnmZGUPgtuxNSazW0csy6E8BxsOw
	nP24VF6DZ1z1OgnbLnymD0jBWMxBqRl8edkeOjLPMPOHqo8M9KIbKJqLHwTxFIJX
	8RsjKG3w76AvHt7rfcSty7fewr4+3+qbqRgW4ujzdjCLAvnODSnUK/8xzuTIUb+4
	AAkOYBHA9Rgo9/iUC9owerdJLh45vUyyQslZO50pUAsQMhZ5A0pQ92Qkw13SnJq8
	T2BWu9PHZocxqM+aDYmkDe0hAw4qzfjApsJ9WEA/tBpWM6voLJbGiXgPKHSY07jN
	owEZSg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fguxg8cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 10:58:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50TAwhhm008096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 10:58:43 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 29 Jan 2025 02:58:41 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Balamurugan Mahalingam
	<quic_bmahalin@quicinc.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH v6 7/9] wifi: ath12k: Add EHT MCS support in Extended Rx statistics
Date: Wed, 29 Jan 2025 16:28:08 +0530
Message-ID: <20250129105810.1094359-8-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250129105810.1094359-1-quic_periyasa@quicinc.com>
References: <20250129105810.1094359-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 2ykQQ4iaULsMiCohqnzU5qjqSU25eRuh
X-Proofpoint-GUID: 2ykQQ4iaULsMiCohqnzU5qjqSU25eRuh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=838 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290089

From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>

Currently, EHT MCS information is not populated. Therefore, add the EHT
MCS counter array to the peer rate statistics and update the EHT MCS
statistics from the status TLV data in the monitor Rx path. In the future,
this information will be used in the peer extended Rx statistics dump.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h   | 2 ++
 drivers/net/wireless/ath/ath12k/dp_mon.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 28db100cfac0..2c9c62cb1af5 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -357,6 +357,7 @@ struct ath12k_vif_iter {
 #define HAL_RX_MAX_MCS_HT	31
 #define HAL_RX_MAX_MCS_VHT	9
 #define HAL_RX_MAX_MCS_HE	11
+#define HAL_RX_MAX_MCS_BE	15
 #define HAL_RX_MAX_NSS		8
 #define HAL_RX_MAX_NUM_LEGACY_RATES 12
 #define ATH12K_RX_RATE_TABLE_11AX_NUM	576
@@ -366,6 +367,7 @@ struct ath12k_rx_peer_rate_stats {
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


