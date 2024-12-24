Return-Path: <linux-wireless+bounces-16766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0BD9FBF1E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 15:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD871884D30
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 14:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91EF1C5F25;
	Tue, 24 Dec 2024 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bWlZ5qRM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD714689
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735050002; cv=none; b=c8vx9VpUAU898kERdNjYyp1RZI5+Kyh7Al96kIEbUmxVmWTfN7iURgLP5xXbOoupOF6UpYW578yrWzpy8tGOhmShzYRc7tYCNDdWMcmwIoZE9Dr6YnPDy+yMbWa4zFGrbPZABuV99IW6FyKLIvCP3bpFJOY9YWPlnMFXOdVCDxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735050002; c=relaxed/simple;
	bh=zJ7dr2M9k6QgXrMFChmP6igcg7ClnSrvJAHD9cqKG70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wkf2VpApyT00ZvMBUvb2t2YmhB9hx2NlF0VhdXmodtOEhw4m8kujr7U5Thh/dVHmy0VFE4Wk1TuxSSVQEFSHRbLGDHQ0dWxMRM2bmGnZK81zlYneq32MoLDxN2rIoL6OZDy2Fo5UOgG6BteA9MNTGCP/c3Gxav+sRftmwyRNSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bWlZ5qRM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOD3hGL021102;
	Tue, 24 Dec 2024 14:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3kv77XmD56FGU7G/OfWMLcgx4uBOoNZT0/YHSyvX78A=; b=bWlZ5qRMuLXhWpUD
	mqjIcLFuymmGCtWBOo+4AMIy71Yl44NcSLBMISGxmudwZPwJo1Er/19nysGiJCll
	6H3ukAQZf3h2NcKgxJMxCGj+KESd5hAAciX7v0yLwf67JaTuB0UMmv4QirDARmil
	fa67Bsc2cxdDX6bcnpM86VwgwpQk7iDPxcl7765rdozCic2WHW6tvbiUjLp34yXg
	cUebBoQ+ZYUbDsmBBenIwO/g1JX8zihBT3VNuBcz+U4pxKaWRaIudqTs29cWIdwd
	hhaDb7D8Xkf2o0i/LdomPkPaql1JbGxktkQEkr8VBgaLhn/aw9PymGMSYa3jl0qu
	KBvFSg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qwgt8cav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 14:19:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BOEJsnX007267
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 14:19:54 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Dec 2024 06:19:52 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v2 1/3] wifi: ath12k: Refactor the monitor Rx parser handler argument
Date: Tue, 24 Dec 2024 19:49:18 +0530
Message-ID: <20241224141920.129339-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224141920.129339-1-quic_periyasa@quicinc.com>
References: <20241224141920.129339-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: _CtjeCYP3xQYIQS9lLgHLzF-8jzHCItC
X-Proofpoint-ORIG-GUID: _CtjeCYP3xQYIQS9lLgHLzF-8jzHCItC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412240124

Currently, the monitor Rx parser handlers
ath12k_dp_mon_rx_parse_status_tlv() and ath12k_dp_mon_parse_rx_dest()
take the device handle from the caller. However, these handlers
functionality is technically pdev specific. Additionally, the device handle
can be retrieved from the pdev handle. Therefore, for better code
understanding, change the monitor Rx parser handlers argument from the
device handle to the pdev handle.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Acked-by: Kalle Valo <kvalo@kernel.org>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 5a21961cfd46..85ff89b91624 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -563,11 +563,12 @@ static void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *
 }
 
 static enum hal_rx_mon_status
-ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
+ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 				  struct ath12k_mon_data *pmon,
 				  u32 tlv_tag, const void *tlv_data,
 				  u32 userid)
 {
+	struct ath12k_base *ab = ar->ab;
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
 	u32 info[7];
 
@@ -1180,7 +1181,7 @@ static int ath12k_dp_mon_rx_deliver(struct ath12k *ar, u32 mac_id,
 }
 
 static enum hal_rx_mon_status
-ath12k_dp_mon_parse_rx_dest(struct ath12k_base *ab, struct ath12k_mon_data *pmon,
+ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
 			    struct sk_buff *skb)
 {
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
@@ -1208,7 +1209,7 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k_base *ab, struct ath12k_mon_data *pmon
 		if (tlv_tag == HAL_RX_PPDU_END)
 			tlv_len = sizeof(struct hal_rx_rxpcu_classification_overview);
 
-		hal_status = ath12k_dp_mon_rx_parse_status_tlv(ab, pmon,
+		hal_status = ath12k_dp_mon_rx_parse_status_tlv(ar, pmon,
 							       tlv_tag, ptr, tlv_userid);
 		ptr += tlv_len;
 		ptr = PTR_ALIGN(ptr, HAL_TLV_64_ALIGN);
@@ -1228,14 +1229,13 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 				  struct sk_buff *skb,
 				  struct napi_struct *napi)
 {
-	struct ath12k_base *ab = ar->ab;
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
 	struct dp_mon_mpdu *tmp;
 	struct dp_mon_mpdu *mon_mpdu = pmon->mon_mpdu;
 	struct sk_buff *head_msdu, *tail_msdu;
 	enum hal_rx_mon_status hal_status = HAL_RX_MON_STATUS_BUF_DONE;
 
-	ath12k_dp_mon_parse_rx_dest(ab, pmon, skb);
+	ath12k_dp_mon_parse_rx_dest(ar, pmon, skb);
 
 	list_for_each_entry_safe(mon_mpdu, tmp, &pmon->dp_rx_mon_mpdu_list, list) {
 		list_del(&mon_mpdu->list);
@@ -2477,7 +2477,7 @@ int ath12k_dp_mon_rx_process_stats(struct ath12k *ar, int mac_id,
 
 		for (i = 0; i < dest_idx; i++) {
 			skb = pmon->dest_skb_q[i];
-			hal_status = ath12k_dp_mon_parse_rx_dest(ab, pmon, skb);
+			hal_status = ath12k_dp_mon_parse_rx_dest(ar, pmon, skb);
 
 			if (ppdu_info->peer_id == HAL_INVALID_PEERID ||
 			    hal_status != HAL_RX_MON_STATUS_PPDU_DONE) {
-- 
2.34.1


