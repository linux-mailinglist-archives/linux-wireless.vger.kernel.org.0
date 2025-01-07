Return-Path: <linux-wireless+bounces-17124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7788A034F1
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 03:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6CD1642DF
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 02:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDAE155C87;
	Tue,  7 Jan 2025 02:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FTnpWH3O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10283143736
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736215852; cv=none; b=YtduRaremFypoyUFAjcFvVfvHBAOBKNDEwUDYoM3I6vmXGqgWtw+ysC2ZRgoa/7eKFtsZcLsE11ps3YJgiEs3lrX9Z3v0WVrhJtKFjHbuZYs0a1wSZok7jasQMPBbcSBfNJjYYzGlcQom1sRKGMfIYJ2veyXVoG4o5Rb9PVSBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736215852; c=relaxed/simple;
	bh=Kp8SyYzc+OIua1nTujby9cDJ89fUBBnT3DLP3fPGh8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cixh4uohGfRMRvZpENmBsOYerPLOYKTNhNLmuA95Numt4GwfIb/uGbhdYsljYnYzgpiZi+xyotKKWdFCHnyKD+j/+iG5V3mKrwd9XXpmqySN9lzRFedc/6AyGd82wsKFOHrPBDpEzt2qrCe/ZhTPh5ETUVwo1SfI8QHBMO+QGQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FTnpWH3O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506GLCQa027187;
	Tue, 7 Jan 2025 02:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YPTBz/nCUbzKbalH1Hi4cAnU9L/eKASphCH1Ej+Dd4Q=; b=FTnpWH3OQEopxpPC
	njPpaLwU1sop9VfuKkPYlfFQLcaBPkpBKvleQXqgB6n5HcY9DLFwV49fjv09MLjs
	ogFe47BszxKhRSgkeUe8WPbElNm/ymKXKK7eN9oQ3SxlMcexmfsZIz+nLHZKe6Xw
	cSafg1hLIhshgeZ6Dq3KiNZMJTCT1vMiW5aWX5T0axNe/3ertmkF9+HeAATB47A+
	QrMsCRhZEC9qVMib/8DcREseCGT0BXFlcNxvZ4OF4o9or8cgWJrCQsXqhlaSuUmC
	m2MqKfGdFxnWCGFD3g4q7CbeuV6ywJ90fGjrpU2+20KrP5yD6B5ROo4+FfvkywZH
	UF6UCQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440jm213n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 02:10:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5072Ak11010421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 02:10:46 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 6 Jan 2025 18:10:44 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH 6/7] wifi: ath12k: Avoid packet offset and FCS length from Rx TLV
Date: Tue, 7 Jan 2025 07:40:16 +0530
Message-ID: <20250107021017.3857555-7-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107021017.3857555-1-quic_periyasa@quicinc.com>
References: <20250107021017.3857555-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: -ksVX22-5FANXqksUO2yfWXPITEGytIr
X-Proofpoint-ORIG-GUID: -ksVX22-5FANXqksUO2yfWXPITEGytIr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=748 impostorscore=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070015

From: P Praneesh <quic_ppranees@quicinc.com>

Currently, the packet offset and FCS length are fetched from the MSDU Rx
TLV data, a logic inherited from ath11k. However, for ath12k 802.11be
hardware, the Rx TLV will not be present in the MSDU data. Instead, this
information is constant. Therefore, remove the existing FCS trim and the
packet offset fetch code. Handle the packet offset with the constant in
the merge MSDU procedure.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 23 +++++------------------
 drivers/net/wireless/ath/ath12k/dp_mon.h |  1 +
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 00e0c5df3e32..bce7e9ce6b1f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1717,18 +1717,6 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 	return HAL_RX_MON_STATUS_PPDU_NOT_DONE;
 }
 
-static void ath12k_dp_mon_rx_msdus_set_payload(struct ath12k *ar,
-					       struct sk_buff *head_msdu,
-					       struct sk_buff *tail_msdu)
-{
-	u32 rx_pkt_offset, l2_hdr_offset;
-
-	rx_pkt_offset = ar->ab->hal.hal_desc_sz;
-	l2_hdr_offset =
-		ath12k_dp_rx_h_l3pad(ar->ab, (struct hal_rx_desc *)tail_msdu->data);
-	skb_pull(head_msdu, rx_pkt_offset + l2_hdr_offset);
-}
-
 static void
 ath12k_dp_mon_fill_rx_stats_info(struct ath12k *ar,
 				 struct hal_rx_mon_ppdu_info *ppdu_info,
@@ -1844,7 +1832,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 {
 	struct ath12k_base *ab = ar->ab;
 	struct sk_buff *msdu, *mpdu_buf, *prev_buf, *head_frag_list;
-	struct sk_buff *head_msdu, *tail_msdu;
+	struct sk_buff *head_msdu;
 	struct hal_rx_desc *rx_desc;
 	u8 *hdr_desc, *dest, decap_format = mon_mpdu->decap_format;
 	struct ieee80211_hdr_3addr *wh;
@@ -1854,7 +1842,6 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 
 	mpdu_buf = NULL;
 	head_msdu = mon_mpdu->head;
-	tail_msdu = mon_mpdu->tail;
 
 	if (!head_msdu)
 		goto err_merge_fail;
@@ -1884,14 +1871,14 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 	ath12k_dp_mon_fill_rx_rate(ar, ppdu_info, rxs);
 
 	if (decap_format == DP_RX_DECAP_TYPE_RAW) {
-		ath12k_dp_mon_rx_msdus_set_payload(ar, head_msdu, tail_msdu);
+		skb_pull(head_msdu, ATH12K_MON_RX_PKT_OFFSET);
 
 		prev_buf = head_msdu;
 		msdu = head_msdu->next;
 		head_frag_list = NULL;
 
 		while (msdu) {
-			ath12k_dp_mon_rx_msdus_set_payload(ar, msdu, tail_msdu);
+			skb_pull(msdu, ATH12K_MON_RX_PKT_OFFSET);
 
 			if (!head_frag_list)
 				head_frag_list = msdu;
@@ -1903,7 +1890,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 
 		prev_buf->next = NULL;
 
-		skb_trim(prev_buf, prev_buf->len - HAL_RX_FCS_LEN);
+		skb_trim(prev_buf, prev_buf->len);
 		if (head_frag_list) {
 			skb_shinfo(head_msdu)->frag_list = head_frag_list;
 			head_msdu->data_len = frag_list_sum_len;
@@ -1926,7 +1913,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 		msdu = head_msdu;
 
 		while (msdu) {
-			ath12k_dp_mon_rx_msdus_set_payload(ar, msdu, tail_msdu);
+			skb_pull(msdu, ATH12K_MON_RX_PKT_OFFSET);
 			if (qos_pkt) {
 				dest = skb_push(msdu, sizeof(__le16));
 				if (!dest)
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index b039f6b9277c..9f3adee51cb2 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -10,6 +10,7 @@
 #include "core.h"
 
 #define ATH12K_MON_RX_DOT11_OFFSET	5
+#define ATH12K_MON_RX_PKT_OFFSET	8
 
 enum dp_monitor_mode {
 	ATH12K_DP_TX_MONITOR_MODE,
-- 
2.34.1


