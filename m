Return-Path: <linux-wireless+bounces-14314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB72E9AA0D9
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 13:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930F7283B36
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 11:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE56E19C553;
	Tue, 22 Oct 2024 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VJIbaXDo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA619B3EE
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595343; cv=none; b=lmxoJrDPhQekDZXtq7Yz1UNMxZt5HDxiQdqa8mmc6quIJbwhgg6cxN109SXnioIL05231plBDEkJCGHlf2oz+3GA9xKnB3kGiJTYFbfYQiAkFkI0eVMLYhzWSCnxbEIsFkXkfhYLjgVOY0evpiu0gXF7iHnKMO3hZgff7MOI6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595343; c=relaxed/simple;
	bh=+UQPiloKVozmdJl/W2GzaKkZY+T3E2p0goOkOxX28Yk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svtwUwGFITzsbZW0LBQFVv5xrxUkeAiylgL38XOWlvkCnMYeZaizgW8N6ftEDxsqLdw86L7fNmNj1nsEC7jAPvkESJ+Ss2P49FyEklFFGjJxpbrJjs8n4eaD91eOyNLzlrKASo8UmLtrNUljsbe6rTNG5DYCyR6UiubuX6GcdLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VJIbaXDo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M9GJ6a025215;
	Tue, 22 Oct 2024 11:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H38dzgDSZgSnfkd3e06eOOEPVpc3k12OTEdbr/QWo7o=; b=VJIbaXDonbY6YXeF
	ZtOdggmrsh6uv0B+YgsX5n51y7rKFudUUrf37YUMXDaaZkl/3U9DoccZciBewHHU
	DYO0VL9UkvKP6Byoqtj4S1sNjgoPVVjrdDR/wJvvjuKvVPhq3MUcJBCEM7XyJEhq
	SZJ+Q8BgRO1FfGilSRoJtyE0CZpUSINkyeaUtaavqgavz5tVI0XMT7YqE+0GYgVO
	q31f/1s9OLpQlJYjKprUVelMvpeAv2GzowNYbrLs1iW+cWlvobgKcujPwu75P95n
	JFkv0k9RHw2BieEc2FDEECiDmz1/ntcj4j757+rISl91cteRuRI/azFHGriF+G4h
	BWPiWw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6vv0194-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 11:08:58 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49MB8vKW007596
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 11:08:57 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 04:08:55 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v6 3/8] wifi: ath12k: fix struct hal_rx_ppdu_start
Date: Tue, 22 Oct 2024 19:08:26 +0800
Message-ID: <20241022110831.974-4-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241022110831.974-1-quic_kangyang@quicinc.com>
References: <20241022110831.974-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mp8UQoxa--C-3J7yUaM0JvteGk2RX74e
X-Proofpoint-GUID: mp8UQoxa--C-3J7yUaM0JvteGk2RX74e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=825 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220071

Current struct hal_rx_ppdu_start in hal_rx.h is not matched with
hardware descriptor definition. This hardware descriptor definition
is determined by hardware. Host shall follow it.

So update struct hal_rx_ppdu_start and related code.

Both QCN9274 and WCN7850 need this modification.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h           |  8 ++++++++
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c  |  8 --------
 drivers/net/wireless/ath/ath12k/dp_mon.c         | 16 ++++++++++++----
 drivers/net/wireless/ath/ath12k/hal_rx.h         | 11 ++++++++---
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3410fcaac128..3fff6e1d7e21 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -102,6 +102,14 @@ static inline enum wme_ac ath12k_tid_to_ac(u32 tid)
 		WME_AC_VO);
 }
 
+static inline u64 ath12k_le32hilo_to_u64(__le32 hi, __le32 lo)
+{
+	u64 hi64 = le32_to_cpu(hi);
+	u64 lo64 = le32_to_cpu(lo);
+
+	return (hi64 << 32) | lo64;
+}
+
 enum ath12k_skb_flags {
 	ATH12K_SKB_HW_80211_ENCAP = BIT(0),
 	ATH12K_SKB_CIPHER_SET = BIT(1),
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 799b865b89e5..c9980c0193d1 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2542,14 +2542,6 @@ ath12k_htt_print_pdev_obss_pd_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
-static u64 ath12k_le32hilo_to_u64(__le32 hi, __le32 lo)
-{
-	u64 hi64 = le32_to_cpu(hi);
-	u64 lo64 = le32_to_cpu(lo);
-
-	return (hi64 << 32) | lo64;
-}
-
 static void
 ath12k_htt_print_dmac_reset_stats_tlv(const void *tag_buf, u16 tag_len,
 				      struct debug_htt_stats_req *stats_req)
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 6454ceba142a..f3df6365a27e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -590,12 +590,20 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 		struct hal_rx_ppdu_start *ppdu_start =
 			(struct hal_rx_ppdu_start *)tlv_data;
 
+		u64 ppdu_ts = ath12k_le32hilo_to_u64(ppdu_start->ppdu_start_ts_63_32,
+						     ppdu_start->ppdu_start_ts_31_0);
+
 		info[0] = __le32_to_cpu(ppdu_start->info0);
 
-		ppdu_info->ppdu_id =
-			u32_get_bits(info[0], HAL_RX_PPDU_START_INFO0_PPDU_ID);
-		ppdu_info->chan_num = __le32_to_cpu(ppdu_start->chan_num);
-		ppdu_info->ppdu_ts = __le32_to_cpu(ppdu_start->ppdu_start_ts);
+		ppdu_info->ppdu_id = u32_get_bits(info[0],
+						  HAL_RX_PPDU_START_INFO0_PPDU_ID);
+
+		info[1] = __le32_to_cpu(ppdu_start->info1);
+		ppdu_info->chan_num = u32_get_bits(info[1],
+						   HAL_RX_PPDU_START_INFO1_CHAN_NUM);
+		ppdu_info->freq = u32_get_bits(info[1],
+					       HAL_RX_PPDU_START_INFO1_CHAN_FREQ);
+		ppdu_info->ppdu_ts = ppdu_ts;
 
 		if (ppdu_info->ppdu_id != ppdu_info->last_ppdu_id) {
 			ppdu_info->last_ppdu_id = ppdu_info->ppdu_id;
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 837ba4adba88..6ab33d5f1b2a 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -156,6 +156,7 @@ struct hal_rx_mon_ppdu_info {
 	u32 preamble_type;
 	u32 mpdu_len;
 	u16 chan_num;
+	u16 freq;
 	u16 tcp_msdu_count;
 	u16 tcp_ack_msdu_count;
 	u16 udp_msdu_count;
@@ -232,12 +233,16 @@ struct hal_rx_mon_ppdu_info {
 	u8 medium_prot_type;
 };
 
-#define HAL_RX_PPDU_START_INFO0_PPDU_ID		GENMASK(15, 0)
+#define HAL_RX_PPDU_START_INFO0_PPDU_ID			GENMASK(15, 0)
+#define HAL_RX_PPDU_START_INFO1_CHAN_NUM		GENMASK(15, 0)
+#define HAL_RX_PPDU_START_INFO1_CHAN_FREQ		GENMASK(31, 16)
 
 struct hal_rx_ppdu_start {
 	__le32 info0;
-	__le32 chan_num;
-	__le32 ppdu_start_ts;
+	__le32 info1;
+	__le32 ppdu_start_ts_31_0;
+	__le32 ppdu_start_ts_63_32;
+	__le32 rsvd[2];
 } __packed;
 
 #define HAL_RX_PPDU_END_USER_STATS_INFO0_MPDU_CNT_FCS_ERR	GENMASK(26, 16)
-- 
2.34.1


