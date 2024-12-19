Return-Path: <linux-wireless+bounces-16562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0C29F713E
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 01:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE4E16A7B3
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 00:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11992566;
	Thu, 19 Dec 2024 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XTg0+ZUn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA961853
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734567034; cv=none; b=ViESVXTh+lpXLJnheFlYEaZmZ8/Qu/qLPIsyGx4AqnA9y5LD2dW/xNfb+HPaQ2TLlTDKeCPrkqKLChw+GFZk50FTxhln1XMm0SI1sEmux+EK4P5uVWTqsnTmASpxDrCUMFuZGp129FBBGhgO1orPFXiz2CrTXItHkeaS7spmSxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734567034; c=relaxed/simple;
	bh=qtnhbo6UTw5aNQGrvw+qRmpZObWiRRiBt4E24dvQZe0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQAswcoWGf6phELtE6fJSJw/S0z5+sj9MHp+sOBzPzkbMO2DI/001JDKwjxyquG9JD1EKtB86pm+g01+vo0CyL6GqidGvdJb9YsOdTDgLNz90QH3gD0NTWiAMXGO0CmUeMnZ4nNDzPtAGQiVwDDpehd5ux4WHo4Le29qeQbYJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XTg0+ZUn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIKLRgr025944;
	Thu, 19 Dec 2024 00:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DEa6X46sw2Iaw/rJUVd5Wx6DGhhFfif3MtZI8CRDWlw=; b=XTg0+ZUn+R4W/zHA
	53VkbHtUzUDCH5DXClgU9YDTTaffc6zsdTswMiGyX/ihzCqtboGNXAy1c/a1nYZG
	yYZs/0Uy0hdcOtuqaxXbtou7ZoQVmxo8YqtyBNTffQuC9hMpkEvMYYcet3GJe4l8
	y19bR8XqxK1nJzfrE0LYrH2kPV39kWI6TPztcsIPtQ4r+5XDukz8XbrxFy1G8Gbq
	UOaSD0TopXdqx3XtGAX7oVcDMTUO93jICIL1kpZ4Eu++iEV+sBM7kH7i0OwjTKFF
	nApEAlZCske1sYI5RLJ6LoEXyplmZv8e24AgVquYb9mkgYnz6wrQh4rKrsESfN1H
	C5Sscg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43m5bnrcu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 00:10:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BJ0ASH1010505
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 00:10:28 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 18 Dec 2024 16:10:27 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 1/3] wifi: ath12k: Refactor the monitor Rx parser handler argument
Date: Thu, 19 Dec 2024 05:40:04 +0530
Message-ID: <20241219001006.1036495-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219001006.1036495-1-quic_periyasa@quicinc.com>
References: <20241219001006.1036495-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: YBCDMuHlp_1osyXzf8YWvFft_TfMYA2j
X-Proofpoint-ORIG-GUID: YBCDMuHlp_1osyXzf8YWvFft_TfMYA2j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180188

Currently, the monitor Rx parser handlers
ath12k_dp_mon_rx_parse_status_tlv() and ath12k_dp_mon_parse_rx_dest()
take the device handle from the caller. However, these handlers
functionality is technically pdev specific. Additionally, the device handle
can be retrieved from the pdev handle. Therefore, for better code
understanding, change the monitor Rx parser handlers argument from the
device handle to the pdev handle.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

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


