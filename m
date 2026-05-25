Return-Path: <linux-wireless+bounces-36879-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOLHNZwuFGqUKgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36879-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 13:12:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5F85C9BF8
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 13:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF4F6301082D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 11:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E655D37E2EB;
	Mon, 25 May 2026 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j1z79bNt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77237DEA0
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707419; cv=none; b=rSQUoaOu53aPw98qHUz2z9pwR+nCoanGa5TjegIZWjBKu0pUl+q+lYDD+OYEIEH156uSCB5YN6Xxn/bODa4h+Hj+nSzbA2SYvKt56xJ55N3b9pEWz2BR/R5F6+6i7n3qyTi7rR5gWNziqpwEoUKCEOeOrJUa0iXbpEFWuK8rz6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707419; c=relaxed/simple;
	bh=Yd1srzeGadOEVooPEMTTF/JLgfUV9mlLl6PAl46iU+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C0jq5g0ToP+XhpZ/wLbOCqMm6sgizb5fS5s1jr+IgjEWfDthMaogXZIpMY0r0DzqEYytuVPTUh/jRUsxQqTE78ni16CmjwIYMyF4wkED9Ov2upXSIPD4M+jH7A2mpOcvCkRAM5M10ywBfOKX0a1ip8jRm9YqGqQx2coF2XkCG18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j1z79bNt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PApm2S3282561;
	Mon, 25 May 2026 11:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=A8L+ECEoayO
	YjnBH4SBislCWz8r+NUnITLEnjWvY7ts=; b=j1z79bNthtCceKOBqF9uLj8Lnno
	lKPymyj9G5691T8AAPP6OgK3j7+ylCt4X5EmsGztaljWYyvnmHmYt+F0RK+6HQQ5
	uZoWvSR6aaH2CXxlB93c8/toe2WZFT2INE40dFnQpCmtUS5WjOd330HX2lrZ1YN6
	lVgkdBIaP4BFy1dgvSZut7Je+kIsGex63xBxOOrp601TOa0Kij/VrxqL0dKrH8tj
	IKElievUUjWhlvCoHY4G+I61O3AoGOk/Iz09Lr1wNjBIAyDzAVOROxQt+KmEaetA
	oBWRtIOEfdxmw6YxRHCiyMDmntXjps8R/2fRFsQJWl+p5dN0KhrL2GZQRcQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4f3eb7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:10:15 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64PB9vCP025757;
	Mon, 25 May 2026 11:10:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4eb5ajfc4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:10:12 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64PBACtu026854;
	Mon, 25 May 2026 11:10:12 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 64PBAC8g026852
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:10:12 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id 9CE0A4195D; Mon, 25 May 2026 16:40:11 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Subject: [PATCH ath-next 6/6] wifi: ath12k: Handle 4-address EAPOL frames from WBM error path
Date: Mon, 25 May 2026 16:39:42 +0530
Message-Id: <20260525110942.2890212-7-tamizh.raja@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525110942.2890212-1-tamizh.raja@oss.qualcomm.com>
References: <20260525110942.2890212-1-tamizh.raja@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: rbHYWjY3z0sWOTSyNsVicfn-X-PI61V6
X-Authority-Analysis: v=2.4 cv=WvYb99fv c=1 sm=1 tr=0 ts=6a142e18 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=CHvhhog7QKGsEOd0EDMA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDExNCBTYWx0ZWRfX+WXqhXMUfDTh
 gcipkkOULhxym4SsIqACVyDkVfQ1UoIoaNQXS48r8yzz5/YhZ65zfJIe/Xm2IeXsvWsCppys1qy
 pGHvzTZT9Uu0fRM4vFo3OifA9xWNbNLOJsvozzvujbzswDBb4lo2+1mhFGS2ChGTEJnlBLdEKmI
 98InnjqjrtJmF2TYFs2kW9KP5zrKSokeyORJx84R/j+jRxs+u/2ysA/ifai5H3hHNQ5OfQLnOmG
 JX0Pq9mWoQm332oWGCPYwaaDt1cXRInK7/01xYyw7F34LMNCEJMgfuzlp2QsZp21SN/g5ZOJzIW
 nFiG3FygrTPOJ/oHPd5fW+WqGIDfEHHkXba4QlEeuiBnDnc4RKKAOtAj9jnVHXlDF4H11J8rnNR
 w2U/RGClGXLZqUV1FZNwlvfoJrevvBUTpklLC1TsZtZQaIlL1tEC3MvJPfzeotUhv7Jei1RrLeu
 oWUjkGgiCoVbYfTfmAQ==
X-Proofpoint-GUID: rbHYWjY3z0sWOTSyNsVicfn-X-PI61V6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250114
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36879-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:mid,quicinc.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: EF5F85C9BF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Whenever hardware receives 4-address EAPOL frames from an unauthorized
station it is routed through WBM/RXDMA error path with the
HAL_REO_ENTR_RING_RXDMA_ECODE_UNAUTH_WDS_ERR error code. But, the
current driver does not handle the 4-address EAPOL frames
in the WBM error path. As a result, these frames are dropped,
causing authentication failures and connectivity issues for 4-address
stations.

Add support to correctly process these frames and forward them to mac80211
for proper handling. This prevents the loss of 4-address EAPOL frames and
ensures reliable connectivity for WDS/4-address clients.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Co-developed-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index 43bb8631827f..d1d63c49d014 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -1702,6 +1702,56 @@ static bool ath12k_wifi7_dp_rx_h_tkip_mic_err(struct ath12k_pdev_dp *dp_pdev,
 	return false;
 }
 
+static bool ath12k_wifi7_dp_rx_h_unauth_wds_err(struct ath12k_pdev_dp *dp_pdev,
+						struct sk_buff *msdu,
+						struct hal_rx_desc_data *rx_info)
+{
+	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
+	struct ath12k_dp *dp = dp_pdev->dp;
+	u32 hdr_len, hal_rx_desc_sz = dp->ab->hal.hal_desc_sz;
+	u8 l3pad_bytes = rx_info->l3_pad_bytes;
+	struct ath12k_dp_rx_rfc1042_hdr *llc;
+	u16 msdu_len = rx_info->msdu_len;
+	struct ath12k_dp_peer *peer;
+	struct ieee80211_hdr *hdr;
+	int ret;
+
+	guard(rcu)();
+	peer = ath12k_dp_peer_find_by_peerid(dp_pdev, rxcb->peer_id);
+	if (!peer) {
+		ath12k_dbg(dp->ab, ATH12K_DBG_DATA,
+			   "failed to find the peer to process unauth wds err handling peer_id %d\n",
+			   rxcb->peer_id);
+		return true;
+	}
+
+	if ((hal_rx_desc_sz + l3pad_bytes + msdu_len) > DP_RX_BUFFER_SIZE)
+		return true;
+
+	skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
+	skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
+
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, msdu,
+							     rx_info)))
+		return true;
+
+	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
+
+	ret = ath12k_wifi7_dp_rx_h_mpdu(dp_pdev, msdu, rx_info);
+	if (ret)
+		return true;
+
+	rxcb->tid = rx_info->tid;
+
+	hdr = (struct ieee80211_hdr *)msdu->data;
+	hdr_len = ieee80211_hdrlen(hdr->frame_control);
+	llc = (struct ath12k_dp_rx_rfc1042_hdr *)(msdu->data + hdr_len);
+	if (llc->snap_type != cpu_to_be16(ETH_P_PAE))
+		return true;
+
+	return false;
+}
+
 static bool ath12k_wifi7_dp_rx_h_rxdma_err(struct ath12k_pdev_dp *dp_pdev,
 					   struct sk_buff *msdu,
 					   struct hal_rx_desc_data *rx_info)
@@ -1713,6 +1763,9 @@ static bool ath12k_wifi7_dp_rx_h_rxdma_err(struct ath12k_pdev_dp *dp_pdev,
 	dp->device_stats.rxdma_error[rxcb->err_code]++;
 
 	switch (rxcb->err_code) {
+	case HAL_REO_ENTR_RING_RXDMA_ECODE_UNAUTH_WDS_ERR:
+		drop = ath12k_wifi7_dp_rx_h_unauth_wds_err(dp_pdev, msdu, rx_info);
+		break;
 	case HAL_REO_ENTR_RING_RXDMA_ECODE_DECRYPT_ERR:
 	case HAL_REO_ENTR_RING_RXDMA_ECODE_TKIP_MIC_ERR:
 		if (rx_info->err_bitmap & HAL_RX_MPDU_ERR_TKIP_MIC) {
-- 
2.34.1


