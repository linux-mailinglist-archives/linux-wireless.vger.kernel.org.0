Return-Path: <linux-wireless+bounces-20390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09504A6141B
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 15:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A9B1B600CB
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 14:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CE52010E1;
	Fri, 14 Mar 2025 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZyHWzcfL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A201F4716
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963875; cv=none; b=uMxU6DQRDMwnY5piAHIy88PiPCxfjaK2ltjmH9/tNYYEemXFDVksIX7PoPSTKegKSsTH+75rs91/s0fW5mn0aw3CDdcWkWQqT/RQg079PLlJ+yHd2A76gYVCZe7Fn/TYI5WztoZLFMH+LSLSDx046dMvgnen4CD1CgCD5Tu2WUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963875; c=relaxed/simple;
	bh=Xbheni6okr46RMOqB1ZesJF789vArthr7Ey3FjeEKVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxCTu9NqN46zcjuZXfAWw/mo93SoZgb1l7iexiJylGm76Ww6nxHhKrdtI54zjdSDqtANATHKfpuZIrC6XZIvRyjzd7smCIS5w5utkTP3TZRRU/tAcjkTLAYuceFSEBdk8xEPp4hHIB8Iso7QdBYZa8FP2mRqM495wNrjO726hz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZyHWzcfL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EBZv7g031553;
	Fri, 14 Mar 2025 14:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/AldWJuOXO1vxe7s2bwXtK9MxP2/C7az8rnmxONo6CE=; b=ZyHWzcfLMOvZ4HQu
	hsxSN+/MFpd1PfWXHNq+SgCAYMWXw31Szp8LOU+MKQ13S2WIL9Y3CUxu5fulN8F2
	Jw5dLg3ZzV8A6YtiWGgewBEwANHQ9i1mMbTPHj/AW2ZsGllZbFHoDGcTrt+6uyAh
	Sf+u3DKRsNuyzu/SmMOB15QxCmOpu+phrXJ4uw7Rb07imWM+Bs8kz1FtkuvRLcjs
	i44KVXpC2rYI041AE7M1dub17M/1Ev+ifsNJg/sttMD6F7su/uYEezMsf2SPQKyu
	k2JtwfSl/6T0YwoKoNFG3aUBzmorJJkHqSCcmYs1EPdAdcXtifLpWx1GZ/Oq8NMq
	SUkpFw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bx1jm0h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 14:51:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52EEpAVL021687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 14:51:10 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 14 Mar 2025 07:51:07 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Nicolas Escande <nico.escande@gmail.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v10 6/9] wifi: ath12k: Avoid packet offset and FCS length from Rx TLV
Date: Fri, 14 Mar 2025 20:20:34 +0530
Message-ID: <20250314145037.3678649-7-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314145037.3678649-1-quic_periyasa@quicinc.com>
References: <20250314145037.3678649-1-quic_periyasa@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=CNQqXQrD c=1 sm=1 tr=0 ts=67d4425e cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=gsXNxhYJDCAcXyPnMeUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: LXempaRD7OloZN-pZWckLZb0asZj7Gbl
X-Proofpoint-GUID: LXempaRD7OloZN-pZWckLZb0asZj7Gbl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_05,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=669 impostorscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140117

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
Tested-by: Nicolas Escande <nico.escande@gmail.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 23 +++++------------------
 drivers/net/wireless/ath/ath12k/dp_mon.h |  1 +
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index bb227c7e2748..6df04920a0c6 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1688,18 +1688,6 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
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
@@ -1815,7 +1803,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 {
 	struct ath12k_base *ab = ar->ab;
 	struct sk_buff *msdu, *mpdu_buf, *prev_buf, *head_frag_list;
-	struct sk_buff *head_msdu, *tail_msdu;
+	struct sk_buff *head_msdu;
 	struct hal_rx_desc *rx_desc;
 	u8 *hdr_desc, *dest, decap_format = mon_mpdu->decap_format;
 	struct ieee80211_hdr_3addr *wh;
@@ -1825,7 +1813,6 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 
 	mpdu_buf = NULL;
 	head_msdu = mon_mpdu->head;
-	tail_msdu = mon_mpdu->tail;
 
 	if (!head_msdu)
 		goto err_merge_fail;
@@ -1855,14 +1842,14 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
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
@@ -1874,7 +1861,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 
 		prev_buf->next = NULL;
 
-		skb_trim(prev_buf, prev_buf->len - HAL_RX_FCS_LEN);
+		skb_trim(prev_buf, prev_buf->len);
 		if (head_frag_list) {
 			skb_shinfo(head_msdu)->frag_list = head_frag_list;
 			head_msdu->data_len = frag_list_sum_len;
@@ -1897,7 +1884,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
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


