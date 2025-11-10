Return-Path: <linux-wireless+bounces-28746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A0BC45FAE
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493783AEBE2
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 10:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BC1309DCB;
	Mon, 10 Nov 2025 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NoDii6nB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84483307486
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771054; cv=none; b=RSnjQZouaZqV+7FXfdpS4EcmtaIy6KFijWyPWpFwBe6Av+lwJIXw+GPlb7CSj+69zpZFx6nAGl+cJpEUrISPCQ0DoVk37wtyq4b7qi9p2670r8uCnbket1jBwQ/q9TKASq2r+I90rfdU+zsNKY//Eqn/6UBZ/HFgTg7Tjv5uuFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771054; c=relaxed/simple;
	bh=HNejfEfkHScmbw/v2r7fyFdE1bCNBd/3AKJ8Tym2sXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XC1gWblBBVSse1WkctnPP0Sq7xtDAaLf5DSLr/TP5TJ+77oQRCEbBG/HF3109vYOE7Rmj8FR4G1VbBeXszS155TPvbtcaxRBrezbvlRru2cimtUxLCvUT83m120qFrBB7bHpARTxmmM2B1ZQkFduH2TpWCXsnHtu2f6YMA7GE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NoDii6nB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA7voEi1558322;
	Mon, 10 Nov 2025 10:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=s/Mn3IWbptM
	DXpOffCmqSfR44YVLa/BRYbA1IBEeYQw=; b=NoDii6nBDGcqBWgi92EnbxIjfgT
	b41T/twXJXyXOSIuLlCgmN8/5TkGw6DCYRXtt/PAC3cyue4ShKJ86v4HhHdA5yiq
	ak66HVw9Pks/GhmaKsk/sThXy6dodlCxD4DBcK86Zbeif0TrVEQ7Tb9Znz5Fr2yv
	gBGYXdn30/SkF1PiJxQZx7lnyQNBV5FUjYOxYjnNRnwqCv6V2pGSASY6ARg0Ud0u
	J4+sxUglfrXFTu8q9xORowzdRqxOc3HfVbBHJl03XCWyNbrzAG5Rl4Kuer4Dy7aC
	qRqcJtGh2GSOC/+JQ1Voe6Oq74wxt4J7aLubeRBl6FoOTTKu6VepfdQA5tA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xuemc21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:20 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAAbHV2008071;
	Mon, 10 Nov 2025 10:37:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a9xxkq1fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:17 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AAAbH2J008046;
	Mon, 10 Nov 2025 10:37:17 GMT
Received: from hu-devc-blr-u22-c.qualcomm.com (hu-aloksing-blr.qualcomm.com [10.190.111.138])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5AAAbHWN008037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:17 +0000
Received: by hu-devc-blr-u22-c.qualcomm.com (Postfix, from userid 2272527)
	id 7ECD25D3; Mon, 10 Nov 2025 16:07:16 +0530 (+0530)
From: Alok Singh <quic_aloksing@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Alok Singh <quic_aloksing@quicinc.com>
Subject: [PATCH ath12k-ng 02/12] wifi: ath12k: Move monitor status processing to Wi-Fi 7 module
Date: Mon, 10 Nov 2025 16:07:03 +0530
Message-Id: <20251110103713.3484779-3-quic_aloksing@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
References: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MiBTYWx0ZWRfX+L18l2JlQPto
 5irrumQLxeZKNAbGu5hy3MT+SKK6dNhu/h+1cw/NHPTqcioH5pMWpCLYxNBbFN/13S29Tywj7sS
 zN4hd909q5mJaJRfD/LYwantvBT3x8pDOdfnbDjOGKX6RXq9nVwb0lqPKDR0ZK6JwQPuVqmKVkt
 zmmHzq+ybgC2pMYJqfSXMIc1YM0sR4Bs17oaEHnN0V9sbIdSTBaRtpa7np0YdgBhWHtTmwNCFM4
 wZmkdZ1y+7osS27vyPKfDjQuVoSn+6s9BdTJD69MQy2f91Zhh/dG+8Qstc/cAprrdPOL2g+S4v4
 7fTGnJeHK9chiJXrujz0/fH0hppB3/xyUW+asyutGhNqxjLmOUAu1siO0MnESEwJZW0KILr1bUZ
 +p1vHLaYzpCa6iKWvtGv+ZpTUZODUQ==
X-Proofpoint-GUID: QCTYdZ2Si98oMXKauVu1bTxu1j2_5FyW
X-Proofpoint-ORIG-GUID: QCTYdZ2Si98oMXKauVu1bTxu1j2_5FyW
X-Authority-Analysis: v=2.4 cv=BOK+bVQG c=1 sm=1 tr=0 ts=6911c061 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=Q7q9U-sb7cuU7tlj3XcA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100092

Split Wi-Fi 7-specific monitor status processing out of ath12k common
code and into the Wi-Fi 7 module to improve modularity.

Move the following functions to wifi7/dp_mon.c and rename them with the
ath12k_wifi7_ prefix:
- ath12k_dp_mon_rx_parse_mon_status()
- ath12k_dp_rx_reap_mon_status_ring()
- ath12k_dp_mon_parse_rx_dest()
- ath12k_dp_rx_mon_buf_done()
- ath12k_dp_rx_mon_dest_process()
- ath12k_dp_mon_rx_memset_ppdu_info()

Export helper functions required by the Wi-Fi 7 monitor path.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Alok Singh <quic_aloksing@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 409 +-----------------
 drivers/net/wireless/ath/ath12k/dp_mon.h      |  38 +-
 drivers/net/wireless/ath/ath12k/hal.c         |   2 +
 .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 399 ++++++++++++++++-
 4 files changed, 433 insertions(+), 415 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 5e2bf24d6b7e..37a5d46b1ca4 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1461,7 +1461,7 @@ ath12k_dp_mon_parse_status_msdu_end(struct ath12k_mon_data *pmon,
 					   RX_MSDU_END_INFO11_DECAP_FORMAT);
 }
 
-static enum hal_rx_mon_status
+enum hal_rx_mon_status
 ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
 				  struct ath12k_mon_data *pmon,
 				  const struct hal_tlv_64_hdr *tlv)
@@ -1733,6 +1733,7 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
 
 	return HAL_RX_MON_STATUS_PPDU_NOT_DONE;
 }
+EXPORT_SYMBOL(ath12k_dp_mon_rx_parse_status_tlv);
 
 static void
 ath12k_dp_mon_fill_rx_stats_info(struct hal_rx_mon_ppdu_info *ppdu_info,
@@ -1761,7 +1762,7 @@ ath12k_dp_mon_fill_rx_stats_info(struct hal_rx_mon_ppdu_info *ppdu_info,
 	}
 }
 
-static struct sk_buff
+struct sk_buff
 *ath12k_dp_rx_alloc_mon_status_buf(struct ath12k_base *ab,
 				   struct dp_rxdma_mon_ring *rx_ring,
 				   int *buf_id)
@@ -1804,46 +1805,7 @@ static struct sk_buff
 fail_alloc_skb:
 	return NULL;
 }
-
-static enum dp_mon_status_buf_state
-ath12k_dp_rx_mon_buf_done(struct ath12k_base *ab, struct hal_srng *srng,
-			  struct dp_rxdma_mon_ring *rx_ring)
-{
-	struct ath12k_skb_rxcb *rxcb;
-	struct hal_tlv_64_hdr *tlv;
-	struct sk_buff *skb;
-	void *status_desc;
-	dma_addr_t paddr;
-	u32 cookie;
-	int buf_id;
-	u8 rbm;
-
-	status_desc = ath12k_hal_srng_src_next_peek(ab, srng);
-	if (!status_desc)
-		return DP_MON_STATUS_NO_DMA;
-
-	ath12k_hal_rx_buf_addr_info_get(&ab->hal, status_desc, &paddr, &cookie, &rbm);
-
-	buf_id = u32_get_bits(cookie, DP_RXDMA_BUF_COOKIE_BUF_ID);
-
-	spin_lock_bh(&rx_ring->idr_lock);
-	skb = idr_find(&rx_ring->bufs_idr, buf_id);
-	spin_unlock_bh(&rx_ring->idr_lock);
-
-	if (!skb)
-		return DP_MON_STATUS_NO_DMA;
-
-	rxcb = ATH12K_SKB_RXCB(skb);
-	dma_sync_single_for_cpu(ab->dev, rxcb->paddr,
-				skb->len + skb_tailroom(skb),
-				DMA_FROM_DEVICE);
-
-	tlv = (struct hal_tlv_64_hdr *)skb->data;
-	if (le64_get_bits(tlv->tl, HAL_TLV_HDR_TAG) != HAL_RX_STATUS_BUFFER_DONE)
-		return DP_MON_STATUS_NO_DMA;
-
-	return DP_MON_STATUS_REPLINISH;
-}
+EXPORT_SYMBOL(ath12k_dp_rx_alloc_mon_status_buf);
 
 static u32 ath12k_dp_mon_comp_ppduid(u32 msdu_ppdu_id, u32 *ppdu_id)
 {
@@ -2358,10 +2320,10 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
 	ieee80211_rx_napi(ath12k_pdev_dp_to_hw(dp_pdev), pubsta, msdu, napi);
 }
 
-static int ath12k_dp_mon_rx_deliver(struct ath12k_pdev_dp *dp_pdev,
-				    struct dp_mon_mpdu *mon_mpdu,
-				    struct hal_rx_mon_ppdu_info *ppduinfo,
-				    struct napi_struct *napi)
+int ath12k_dp_mon_rx_deliver(struct ath12k_pdev_dp *dp_pdev,
+			     struct dp_mon_mpdu *mon_mpdu,
+			     struct hal_rx_mon_ppdu_info *ppduinfo,
+			     struct napi_struct *napi)
 {
 	struct sk_buff *mon_skb, *skb_next, *header;
 	struct ieee80211_rx_status *rxs = &dp_pdev->rx_status;
@@ -2412,8 +2374,9 @@ static int ath12k_dp_mon_rx_deliver(struct ath12k_pdev_dp *dp_pdev,
 	}
 	return -EINVAL;
 }
+EXPORT_SYMBOL(ath12k_dp_mon_rx_deliver);
 
-static int ath12k_dp_pkt_set_pktlen(struct sk_buff *skb, u32 len)
+int ath12k_dp_pkt_set_pktlen(struct sk_buff *skb, u32 len)
 {
 	if (skb->len > len) {
 		skb_trim(skb, len);
@@ -2430,6 +2393,7 @@ static int ath12k_dp_pkt_set_pktlen(struct sk_buff *skb, u32 len)
 
 	return 0;
 }
+EXPORT_SYMBOL(ath12k_dp_pkt_set_pktlen);
 
 /* Hardware fill buffer with 128 bytes aligned. So need to reap it
  * with 128 bytes aligned.
@@ -2503,7 +2467,7 @@ ath12k_dp_mon_parse_status_buf(struct ath12k_pdev_dp *dp_pdev,
 	return 0;
 }
 
-static int
+int
 ath12k_dp_mon_parse_rx_dest_tlv(struct ath12k_pdev_dp *dp_pdev,
 				struct ath12k_mon_data *pmon,
 				enum hal_rx_mon_status hal_status,
@@ -2540,87 +2504,7 @@ ath12k_dp_mon_parse_rx_dest_tlv(struct ath12k_pdev_dp *dp_pdev,
 
 	return 0;
 }
-
-enum hal_rx_mon_status
-ath12k_dp_mon_parse_rx_dest(struct ath12k_pdev_dp *dp_pdev, struct ath12k_mon_data *pmon,
-			    struct sk_buff *skb)
-{
-	struct ath12k *ar = ath12k_pdev_dp_to_ar(dp_pdev);
-	struct hal_tlv_64_hdr *tlv;
-	struct ath12k_skb_rxcb *rxcb;
-	enum hal_rx_mon_status hal_status;
-	u16 tlv_tag, tlv_len;
-	u8 *ptr = skb->data;
-
-	do {
-		tlv = (struct hal_tlv_64_hdr *)ptr;
-		tlv_tag = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_TAG);
-
-		/* The actual length of PPDU_END is the combined length of many PHY
-		 * TLVs that follow. Skip the TLV header and
-		 * rx_rxpcu_classification_overview that follows the header to get to
-		 * next TLV.
-		 */
-
-		if (tlv_tag == HAL_RX_PPDU_END)
-			tlv_len = sizeof(struct hal_rx_rxpcu_classification_overview);
-		else
-			tlv_len = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_LEN);
-
-		hal_status = ath12k_dp_mon_rx_parse_status_tlv(dp_pdev, pmon, tlv);
-
-		if (ar->monitor_started && ar->ab->hw_params->rxdma1_enable &&
-		    ath12k_dp_mon_parse_rx_dest_tlv(dp_pdev, pmon, hal_status,
-						    tlv->value))
-			return HAL_RX_MON_STATUS_PPDU_DONE;
-
-		ptr += sizeof(*tlv) + tlv_len;
-		ptr = PTR_ALIGN(ptr, HAL_TLV_64_ALIGN);
-
-		if ((ptr - skb->data) > skb->len)
-			break;
-
-	} while ((hal_status == HAL_RX_MON_STATUS_PPDU_NOT_DONE) ||
-		 (hal_status == HAL_RX_MON_STATUS_BUF_ADDR) ||
-		 (hal_status == HAL_RX_MON_STATUS_MPDU_START) ||
-		 (hal_status == HAL_RX_MON_STATUS_MPDU_END) ||
-		 (hal_status == HAL_RX_MON_STATUS_MSDU_END));
-
-	rxcb = ATH12K_SKB_RXCB(skb);
-	if (rxcb->is_end_of_ppdu)
-		hal_status = HAL_RX_MON_STATUS_PPDU_DONE;
-
-	return hal_status;
-}
-EXPORT_SYMBOL(ath12k_dp_mon_parse_rx_dest);
-
-enum hal_rx_mon_status
-ath12k_dp_mon_rx_parse_mon_status(struct ath12k_pdev_dp *dp_pdev,
-				  struct ath12k_mon_data *pmon,
-				  struct sk_buff *skb,
-				  struct napi_struct *napi)
-{
-	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
-	struct dp_mon_mpdu *tmp;
-	struct dp_mon_mpdu *mon_mpdu = pmon->mon_mpdu;
-	enum hal_rx_mon_status hal_status;
-
-	hal_status = ath12k_dp_mon_parse_rx_dest(dp_pdev, pmon, skb);
-	if (hal_status != HAL_RX_MON_STATUS_PPDU_DONE)
-		return hal_status;
-
-	list_for_each_entry_safe(mon_mpdu, tmp, &pmon->dp_rx_mon_mpdu_list, list) {
-		list_del(&mon_mpdu->list);
-
-		if (mon_mpdu->head && mon_mpdu->tail)
-			ath12k_dp_mon_rx_deliver(dp_pdev, mon_mpdu, ppdu_info, napi);
-
-		kfree(mon_mpdu);
-	}
-
-	return hal_status;
-}
-EXPORT_SYMBOL(ath12k_dp_mon_rx_parse_mon_status);
+EXPORT_SYMBOL(ath12k_dp_mon_parse_rx_dest_tlv);
 
 int ath12k_dp_mon_buf_replenish(struct ath12k_base *ab,
 				struct dp_rxdma_mon_ring *buf_ring,
@@ -3766,161 +3650,7 @@ ath12k_dp_mon_rx_update_peer_mu_stats(struct ath12k_base *ab,
 }
 EXPORT_SYMBOL(ath12k_dp_mon_rx_update_peer_mu_stats);
 
-void
-ath12k_dp_mon_rx_memset_ppdu_info(struct hal_rx_mon_ppdu_info *ppdu_info)
-{
-	memset(ppdu_info, 0, sizeof(*ppdu_info));
-	ppdu_info->peer_id = HAL_INVALID_PEERID;
-}
-EXPORT_SYMBOL(ath12k_dp_mon_rx_memset_ppdu_info);
-
-int ath12k_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
-				      int *budget, struct sk_buff_head *skb_list)
-{
-	const struct ath12k_hw_hal_params *hal_params;
-	int buf_id, srng_id, num_buffs_reaped = 0;
-	enum dp_mon_status_buf_state reap_status;
-	struct dp_rxdma_mon_ring *rx_ring;
-	struct ath12k_mon_data *pmon;
-	struct ath12k_skb_rxcb *rxcb;
-	struct hal_tlv_64_hdr *tlv;
-	void *rx_mon_status_desc;
-	struct hal_srng *srng;
-	struct ath12k_dp *dp;
-	struct sk_buff *skb;
-	struct ath12k *ar;
-	dma_addr_t paddr;
-	u32 cookie;
-	u8 rbm;
-
-	ar = ab->pdevs[ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id)].ar;
-	dp = ath12k_ab_to_dp(ab);
-	pmon = &ar->dp.mon_data;
-	srng_id = ath12k_hw_mac_id_to_srng_id(ab->hw_params, mac_id);
-	rx_ring = &dp->rx_mon_status_refill_ring[srng_id];
-
-	srng = &ab->hal.srng_list[rx_ring->refill_buf_ring.ring_id];
-
-	spin_lock_bh(&srng->lock);
-
-	ath12k_hal_srng_access_begin(ab, srng);
-
-	while (*budget) {
-		*budget -= 1;
-		rx_mon_status_desc = ath12k_hal_srng_src_peek(ab, srng);
-		if (!rx_mon_status_desc) {
-			pmon->buf_state = DP_MON_STATUS_REPLINISH;
-			break;
-		}
-		ath12k_hal_rx_buf_addr_info_get(&ab->hal, rx_mon_status_desc, &paddr,
-						&cookie, &rbm);
-		if (paddr) {
-			buf_id = u32_get_bits(cookie, DP_RXDMA_BUF_COOKIE_BUF_ID);
-
-			spin_lock_bh(&rx_ring->idr_lock);
-			skb = idr_find(&rx_ring->bufs_idr, buf_id);
-			spin_unlock_bh(&rx_ring->idr_lock);
-
-			if (!skb) {
-				ath12k_warn(ab, "rx monitor status with invalid buf_id %d\n",
-					    buf_id);
-				pmon->buf_state = DP_MON_STATUS_REPLINISH;
-				goto move_next;
-			}
-
-			rxcb = ATH12K_SKB_RXCB(skb);
-
-			dma_sync_single_for_cpu(ab->dev, rxcb->paddr,
-						skb->len + skb_tailroom(skb),
-						DMA_FROM_DEVICE);
-
-			tlv = (struct hal_tlv_64_hdr *)skb->data;
-			if (le64_get_bits(tlv->tl, HAL_TLV_HDR_TAG) !=
-					HAL_RX_STATUS_BUFFER_DONE) {
-				pmon->buf_state = DP_MON_STATUS_NO_DMA;
-				ath12k_warn(ab,
-					    "mon status DONE not set %llx, buf_id %d\n",
-					    le64_get_bits(tlv->tl, HAL_TLV_HDR_TAG),
-					    buf_id);
-				/* RxDMA status done bit might not be set even
-				 * though tp is moved by HW.
-				 */
-
-				/* If done status is missing:
-				 * 1. As per MAC team's suggestion,
-				 *    when HP + 1 entry is peeked and if DMA
-				 *    is not done and if HP + 2 entry's DMA done
-				 *    is set. skip HP + 1 entry and
-				 *    start processing in next interrupt.
-				 * 2. If HP + 2 entry's DMA done is not set,
-				 *    poll onto HP + 1 entry DMA done to be set.
-				 *    Check status for same buffer for next time
-				 *    dp_rx_mon_status_srng_process
-				 */
-				reap_status = ath12k_dp_rx_mon_buf_done(ab, srng,
-									rx_ring);
-				if (reap_status == DP_MON_STATUS_NO_DMA)
-					continue;
-
-				spin_lock_bh(&rx_ring->idr_lock);
-				idr_remove(&rx_ring->bufs_idr, buf_id);
-				spin_unlock_bh(&rx_ring->idr_lock);
-
-				dma_unmap_single(ab->dev, rxcb->paddr,
-						 skb->len + skb_tailroom(skb),
-						 DMA_FROM_DEVICE);
-
-				dev_kfree_skb_any(skb);
-				pmon->buf_state = DP_MON_STATUS_REPLINISH;
-				goto move_next;
-			}
-
-			spin_lock_bh(&rx_ring->idr_lock);
-			idr_remove(&rx_ring->bufs_idr, buf_id);
-			spin_unlock_bh(&rx_ring->idr_lock);
-
-			dma_unmap_single(ab->dev, rxcb->paddr,
-					 skb->len + skb_tailroom(skb),
-					 DMA_FROM_DEVICE);
-
-			if (ath12k_dp_pkt_set_pktlen(skb, RX_MON_STATUS_BUF_SIZE)) {
-				dev_kfree_skb_any(skb);
-				goto move_next;
-			}
-			__skb_queue_tail(skb_list, skb);
-		} else {
-			pmon->buf_state = DP_MON_STATUS_REPLINISH;
-		}
-move_next:
-		skb = ath12k_dp_rx_alloc_mon_status_buf(ab, rx_ring,
-							&buf_id);
-		hal_params = ab->hal.hal_params;
-
-		if (!skb) {
-			ath12k_warn(ab, "failed to alloc buffer for status ring\n");
-			ath12k_hal_rx_buf_addr_info_set(&ab->hal, rx_mon_status_desc,
-							0, 0, hal_params->rx_buf_rbm);
-			num_buffs_reaped++;
-			break;
-		}
-		rxcb = ATH12K_SKB_RXCB(skb);
-
-		cookie = u32_encode_bits(mac_id, DP_RXDMA_BUF_COOKIE_PDEV_ID) |
-			 u32_encode_bits(buf_id, DP_RXDMA_BUF_COOKIE_BUF_ID);
-
-		ath12k_hal_rx_buf_addr_info_set(&ab->hal, rx_mon_status_desc, rxcb->paddr,
-						cookie, hal_params->rx_buf_rbm);
-		ath12k_hal_srng_src_get_next_entry(ab, srng);
-		num_buffs_reaped++;
-	}
-	ath12k_hal_srng_access_end(ab, srng);
-	spin_unlock_bh(&srng->lock);
-
-	return num_buffs_reaped;
-}
-EXPORT_SYMBOL(ath12k_dp_rx_reap_mon_status_ring);
-
-static u32
+u32
 ath12k_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
 			  void *ring_entry, struct sk_buff **head_msdu,
 			  struct sk_buff **tail_msdu,
@@ -4107,113 +3837,4 @@ ath12k_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
 
 	return rx_bufs_used;
 }
-
-/* The destination ring processing is stuck if the destination is not
- * moving while status ring moves 16 PPDU. The destination ring processing
- * skips this destination ring PPDU as a workaround.
- */
-#define MON_DEST_RING_STUCK_MAX_CNT 16
-
-void ath12k_dp_rx_mon_dest_process(struct ath12k *ar, int mac_id,
-				   u32 quota, struct napi_struct *napi)
-{
-	struct ath12k_mon_data *pmon = (struct ath12k_mon_data *)&ar->dp.mon_data;
-	struct ath12k_pdev_mon_stats *rx_mon_stats;
-	u32 ppdu_id, rx_bufs_used = 0, ring_id;
-	u32 mpdu_rx_bufs_used, npackets = 0;
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
-	void *ring_entry, *mon_dst_srng;
-	struct dp_mon_mpdu *tmp_mpdu;
-	LIST_HEAD(rx_desc_used_list);
-	struct hal_srng *srng;
-
-	ring_id = dp->rxdma_err_dst_ring[mac_id].ring_id;
-	srng = &ab->hal.srng_list[ring_id];
-
-	mon_dst_srng = &ab->hal.srng_list[ring_id];
-
-	spin_lock_bh(&srng->lock);
-
-	ath12k_hal_srng_access_begin(ab, mon_dst_srng);
-
-	ppdu_id = pmon->mon_ppdu_info.ppdu_id;
-	rx_mon_stats = &pmon->rx_mon_stats;
-
-	while ((ring_entry = ath12k_hal_srng_dst_peek(ar->ab, mon_dst_srng))) {
-		struct sk_buff *head_msdu, *tail_msdu;
-
-		head_msdu = NULL;
-		tail_msdu = NULL;
-
-		mpdu_rx_bufs_used = ath12k_dp_rx_mon_mpdu_pop(ar, mac_id, ring_entry,
-							      &head_msdu, &tail_msdu,
-							      &rx_desc_used_list,
-							      &npackets, &ppdu_id);
-
-		rx_bufs_used += mpdu_rx_bufs_used;
-
-		if (mpdu_rx_bufs_used) {
-			dp->mon_dest_ring_stuck_cnt = 0;
-		} else {
-			dp->mon_dest_ring_stuck_cnt++;
-			rx_mon_stats->dest_mon_not_reaped++;
-		}
-
-		if (dp->mon_dest_ring_stuck_cnt > MON_DEST_RING_STUCK_MAX_CNT) {
-			rx_mon_stats->dest_mon_stuck++;
-			ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
-				   "status ring ppdu_id=%d dest ring ppdu_id=%d mon_dest_ring_stuck_cnt=%d dest_mon_not_reaped=%u dest_mon_stuck=%u\n",
-				   pmon->mon_ppdu_info.ppdu_id, ppdu_id,
-				   dp->mon_dest_ring_stuck_cnt,
-				   rx_mon_stats->dest_mon_not_reaped,
-				   rx_mon_stats->dest_mon_stuck);
-			spin_lock_bh(&pmon->mon_lock);
-			pmon->mon_ppdu_info.ppdu_id = ppdu_id;
-			spin_unlock_bh(&pmon->mon_lock);
-			continue;
-		}
-
-		if (ppdu_id != pmon->mon_ppdu_info.ppdu_id) {
-			spin_lock_bh(&pmon->mon_lock);
-			pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
-			spin_unlock_bh(&pmon->mon_lock);
-			ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
-				   "dest_rx: new ppdu_id %x != status ppdu_id %x dest_mon_not_reaped = %u dest_mon_stuck = %u\n",
-				   ppdu_id, pmon->mon_ppdu_info.ppdu_id,
-				   rx_mon_stats->dest_mon_not_reaped,
-				   rx_mon_stats->dest_mon_stuck);
-			break;
-		}
-
-		if (head_msdu && tail_msdu) {
-			tmp_mpdu = kzalloc(sizeof(*tmp_mpdu), GFP_ATOMIC);
-			if (!tmp_mpdu)
-				break;
-
-			tmp_mpdu->head = head_msdu;
-			tmp_mpdu->tail = tail_msdu;
-			tmp_mpdu->err_bitmap = pmon->err_bitmap;
-			tmp_mpdu->decap_format = pmon->decap_format;
-			ath12k_dp_mon_rx_deliver(&ar->dp, tmp_mpdu,
-						 &pmon->mon_ppdu_info, napi);
-			rx_mon_stats->dest_mpdu_done++;
-			kfree(tmp_mpdu);
-		}
-
-		ring_entry = ath12k_hal_srng_dst_get_next_entry(ar->ab,
-								mon_dst_srng);
-	}
-	ath12k_hal_srng_access_end(ar->ab, mon_dst_srng);
-
-	spin_unlock_bh(&srng->lock);
-
-	if (rx_bufs_used) {
-		rx_mon_stats->dest_ppdu_done++;
-		ath12k_dp_rx_bufs_replenish(ar->ab->dp,
-					    &dp->rx_refill_buf_ring,
-					    &rx_desc_used_list,
-					    rx_bufs_used);
-	}
-}
-EXPORT_SYMBOL(ath12k_dp_rx_mon_dest_process);
+EXPORT_SYMBOL(ath12k_dp_rx_mon_mpdu_pop);
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index 689d7a0fff5c..726434ab74ac 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -78,11 +78,6 @@ struct dp_mon_tx_ppdu_info {
 	struct dp_mon_mpdu *tx_mon_mpdu;
 };
 
-enum hal_rx_mon_status
-ath12k_dp_mon_rx_parse_mon_status(struct ath12k_pdev_dp *dp_pdev,
-				  struct ath12k_mon_data *pmon,
-				  struct sk_buff *skb,
-				  struct napi_struct *napi);
 int ath12k_dp_mon_buf_replenish(struct ath12k_base *ab,
 				struct dp_rxdma_mon_ring *buf_ring,
 				int req_entries);
@@ -101,18 +96,33 @@ ath12k_dp_mon_tx_parse_mon_status(struct ath12k_pdev_dp *dp_pdev,
 				  struct napi_struct *napi,
 				  u32 ppdu_id);
 void ath12k_dp_mon_rx_process_ulofdma(struct hal_rx_mon_ppdu_info *ppdu_info);
-enum hal_rx_mon_status
-ath12k_dp_mon_parse_rx_dest(struct ath12k_pdev_dp *dp_pdev, struct ath12k_mon_data *pmon,
-			    struct sk_buff *skb);
-int ath12k_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
-				      int *budget, struct sk_buff_head *skb_list);
-void ath12k_dp_rx_mon_dest_process(struct ath12k *ar, int mac_id,
-				   u32 quota, struct napi_struct *napi);
 void
 ath12k_dp_mon_rx_update_peer_mu_stats(struct ath12k_base *ab,
 				      struct hal_rx_mon_ppdu_info *ppdu_info);
 void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k_dp_link_peer *peer,
 					   struct hal_rx_mon_ppdu_info *ppdu_info);
-void
-ath12k_dp_mon_rx_memset_ppdu_info(struct hal_rx_mon_ppdu_info *ppdu_info);
+u32
+ath12k_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
+			  void *ring_entry, struct sk_buff **head_msdu,
+			  struct sk_buff **tail_msdu,
+			  struct list_head *used_list,
+			  u32 *npackets, u32 *ppdu_id);
+int ath12k_dp_pkt_set_pktlen(struct sk_buff *skb, u32 len);
+int ath12k_dp_mon_rx_deliver(struct ath12k_pdev_dp *dp_pdev,
+			     struct dp_mon_mpdu *mon_mpdu,
+			     struct hal_rx_mon_ppdu_info *ppduinfo,
+			     struct napi_struct *napi);
+int
+ath12k_dp_mon_parse_rx_dest_tlv(struct ath12k_pdev_dp *dp_pdev,
+				struct ath12k_mon_data *pmon,
+				enum hal_rx_mon_status hal_status,
+				const void *tlv_data);
+enum hal_rx_mon_status
+ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
+				  struct ath12k_mon_data *pmon,
+				  const struct hal_tlv_64_hdr *tlv);
+struct sk_buff
+*ath12k_dp_rx_alloc_mon_status_buf(struct ath12k_base *ab,
+				   struct dp_rxdma_mon_ring *rx_ring,
+				   int *buf_id);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index efa039f6df92..91d697ad1799 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -402,6 +402,7 @@ void *ath12k_hal_srng_src_next_peek(struct ath12k_base *ab,
 
 	return desc;
 }
+EXPORT_SYMBOL(ath12k_hal_srng_src_next_peek);
 
 void *ath12k_hal_srng_src_get_next_entry(struct ath12k_base *ab,
 					 struct hal_srng *srng)
@@ -447,6 +448,7 @@ void *ath12k_hal_srng_src_peek(struct ath12k_base *ab, struct hal_srng *srng)
 
 	return srng->ring_base_vaddr + srng->u.src_ring.hp;
 }
+EXPORT_SYMBOL(ath12k_hal_srng_src_peek);
 
 void *ath12k_hal_srng_src_reap_next(struct ath12k_base *ab,
 				    struct hal_srng *srng)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
index 4135ff5e8759..ffebeb1652e7 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
@@ -12,6 +12,390 @@
 #include "dp_rx.h"
 #include "../peer.h"
 
+static void
+ath12k_wifi7_dp_mon_rx_memset_ppdu_info(struct hal_rx_mon_ppdu_info *ppdu_info)
+{
+	memset(ppdu_info, 0, sizeof(*ppdu_info));
+	ppdu_info->peer_id = HAL_INVALID_PEERID;
+}
+
+/* The destination ring processing is stuck if the destination is not
+ * moving while status ring moves 16 PPDU. The destination ring processing
+ * skips this destination ring PPDU as a workaround.
+ */
+#define MON_DEST_RING_STUCK_MAX_CNT 16
+
+static void
+ath12k_wifi7_dp_rx_mon_dest_process(struct ath12k *ar, int mac_id,
+				    u32 quota, struct napi_struct *napi)
+{
+	struct ath12k_mon_data *pmon = (struct ath12k_mon_data *)&ar->dp.mon_data;
+	struct ath12k_pdev_mon_stats *rx_mon_stats;
+	u32 ppdu_id, rx_bufs_used = 0, ring_id;
+	u32 mpdu_rx_bufs_used, npackets = 0;
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	void *ring_entry, *mon_dst_srng;
+	struct dp_mon_mpdu *tmp_mpdu;
+	LIST_HEAD(rx_desc_used_list);
+	struct hal_srng *srng;
+
+	ring_id = dp->rxdma_err_dst_ring[mac_id].ring_id;
+	srng = &ab->hal.srng_list[ring_id];
+
+	mon_dst_srng = &ab->hal.srng_list[ring_id];
+
+	spin_lock_bh(&srng->lock);
+
+	ath12k_hal_srng_access_begin(ab, mon_dst_srng);
+
+	ppdu_id = pmon->mon_ppdu_info.ppdu_id;
+	rx_mon_stats = &pmon->rx_mon_stats;
+
+	while ((ring_entry = ath12k_hal_srng_dst_peek(ar->ab, mon_dst_srng))) {
+		struct sk_buff *head_msdu, *tail_msdu;
+
+		head_msdu = NULL;
+		tail_msdu = NULL;
+
+		mpdu_rx_bufs_used = ath12k_dp_rx_mon_mpdu_pop(ar, mac_id, ring_entry,
+							      &head_msdu, &tail_msdu,
+							      &rx_desc_used_list,
+							      &npackets, &ppdu_id);
+
+		rx_bufs_used += mpdu_rx_bufs_used;
+
+		if (mpdu_rx_bufs_used) {
+			dp->mon_dest_ring_stuck_cnt = 0;
+		} else {
+			dp->mon_dest_ring_stuck_cnt++;
+			rx_mon_stats->dest_mon_not_reaped++;
+		}
+
+		if (dp->mon_dest_ring_stuck_cnt > MON_DEST_RING_STUCK_MAX_CNT) {
+			rx_mon_stats->dest_mon_stuck++;
+			ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+				   "status ring ppdu_id=%d dest ring ppdu_id=%d mon_dest_ring_stuck_cnt=%d dest_mon_not_reaped=%u dest_mon_stuck=%u\n",
+				   pmon->mon_ppdu_info.ppdu_id, ppdu_id,
+				   dp->mon_dest_ring_stuck_cnt,
+				   rx_mon_stats->dest_mon_not_reaped,
+				   rx_mon_stats->dest_mon_stuck);
+			spin_lock_bh(&pmon->mon_lock);
+			pmon->mon_ppdu_info.ppdu_id = ppdu_id;
+			spin_unlock_bh(&pmon->mon_lock);
+			continue;
+		}
+
+		if (ppdu_id != pmon->mon_ppdu_info.ppdu_id) {
+			spin_lock_bh(&pmon->mon_lock);
+			pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
+			spin_unlock_bh(&pmon->mon_lock);
+			ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+				   "dest_rx: new ppdu_id %x != status ppdu_id %x dest_mon_not_reaped = %u dest_mon_stuck = %u\n",
+				   ppdu_id, pmon->mon_ppdu_info.ppdu_id,
+				   rx_mon_stats->dest_mon_not_reaped,
+				   rx_mon_stats->dest_mon_stuck);
+			break;
+		}
+
+		if (head_msdu && tail_msdu) {
+			tmp_mpdu = kzalloc(sizeof(*tmp_mpdu), GFP_ATOMIC);
+			if (!tmp_mpdu)
+				break;
+
+			tmp_mpdu->head = head_msdu;
+			tmp_mpdu->tail = tail_msdu;
+			tmp_mpdu->err_bitmap = pmon->err_bitmap;
+			tmp_mpdu->decap_format = pmon->decap_format;
+			ath12k_dp_mon_rx_deliver(&ar->dp, tmp_mpdu,
+						 &pmon->mon_ppdu_info, napi);
+			rx_mon_stats->dest_mpdu_done++;
+			kfree(tmp_mpdu);
+		}
+
+		ring_entry = ath12k_hal_srng_dst_get_next_entry(ar->ab,
+								mon_dst_srng);
+	}
+	ath12k_hal_srng_access_end(ar->ab, mon_dst_srng);
+
+	spin_unlock_bh(&srng->lock);
+
+	if (rx_bufs_used) {
+		rx_mon_stats->dest_ppdu_done++;
+		ath12k_dp_rx_bufs_replenish(ar->ab->dp,
+					    &dp->rx_refill_buf_ring,
+					    &rx_desc_used_list,
+					    rx_bufs_used);
+	}
+}
+
+static enum dp_mon_status_buf_state
+ath12k_wifi7_dp_rx_mon_buf_done(struct ath12k_base *ab, struct hal_srng *srng,
+				struct dp_rxdma_mon_ring *rx_ring)
+{
+	struct ath12k_skb_rxcb *rxcb;
+	struct hal_tlv_64_hdr *tlv;
+	struct sk_buff *skb;
+	void *status_desc;
+	dma_addr_t paddr;
+	u32 cookie;
+	int buf_id;
+	u8 rbm;
+
+	status_desc = ath12k_hal_srng_src_next_peek(ab, srng);
+	if (!status_desc)
+		return DP_MON_STATUS_NO_DMA;
+
+	ath12k_wifi7_hal_rx_buf_addr_info_get(status_desc, &paddr, &cookie, &rbm);
+
+	buf_id = u32_get_bits(cookie, DP_RXDMA_BUF_COOKIE_BUF_ID);
+
+	spin_lock_bh(&rx_ring->idr_lock);
+	skb = idr_find(&rx_ring->bufs_idr, buf_id);
+	spin_unlock_bh(&rx_ring->idr_lock);
+
+	if (!skb)
+		return DP_MON_STATUS_NO_DMA;
+
+	rxcb = ATH12K_SKB_RXCB(skb);
+	dma_sync_single_for_cpu(ab->dev, rxcb->paddr,
+				skb->len + skb_tailroom(skb),
+				DMA_FROM_DEVICE);
+
+	tlv = (struct hal_tlv_64_hdr *)skb->data;
+	if (le64_get_bits(tlv->tl, HAL_TLV_HDR_TAG) != HAL_RX_STATUS_BUFFER_DONE)
+		return DP_MON_STATUS_NO_DMA;
+
+	return DP_MON_STATUS_REPLINISH;
+}
+
+static enum hal_rx_mon_status
+ath12k_wifi7_dp_mon_parse_rx_dest(struct ath12k_pdev_dp *dp_pdev,
+				  struct ath12k_mon_data *pmon,
+				  struct sk_buff *skb)
+{
+	struct ath12k *ar = ath12k_pdev_dp_to_ar(dp_pdev);
+	struct hal_tlv_64_hdr *tlv;
+	struct ath12k_skb_rxcb *rxcb;
+	enum hal_rx_mon_status hal_status;
+	u16 tlv_tag, tlv_len;
+	u8 *ptr = skb->data;
+
+	do {
+		tlv = (struct hal_tlv_64_hdr *)ptr;
+		tlv_tag = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_TAG);
+
+		/* The actual length of PPDU_END is the combined length of many PHY
+		 * TLVs that follow. Skip the TLV header and
+		 * rx_rxpcu_classification_overview that follows the header to get to
+		 * next TLV.
+		 */
+
+		if (tlv_tag == HAL_RX_PPDU_END)
+			tlv_len = sizeof(struct hal_rx_rxpcu_classification_overview);
+		else
+			tlv_len = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_LEN);
+
+		hal_status = ath12k_dp_mon_rx_parse_status_tlv(dp_pdev, pmon, tlv);
+
+		if (ar->monitor_started && ar->ab->hw_params->rxdma1_enable &&
+		    ath12k_dp_mon_parse_rx_dest_tlv(dp_pdev, pmon, hal_status,
+						    tlv->value))
+			return HAL_RX_MON_STATUS_PPDU_DONE;
+
+		ptr += sizeof(*tlv) + tlv_len;
+		ptr = PTR_ALIGN(ptr, HAL_TLV_64_ALIGN);
+
+		if ((ptr - skb->data) > skb->len)
+			break;
+
+	} while ((hal_status == HAL_RX_MON_STATUS_PPDU_NOT_DONE) ||
+		 (hal_status == HAL_RX_MON_STATUS_BUF_ADDR) ||
+		 (hal_status == HAL_RX_MON_STATUS_MPDU_START) ||
+		 (hal_status == HAL_RX_MON_STATUS_MPDU_END) ||
+		 (hal_status == HAL_RX_MON_STATUS_MSDU_END));
+
+	rxcb = ATH12K_SKB_RXCB(skb);
+	if (rxcb->is_end_of_ppdu)
+		hal_status = HAL_RX_MON_STATUS_PPDU_DONE;
+
+	return hal_status;
+}
+
+static enum hal_rx_mon_status
+ath12k_wifi7_dp_mon_rx_parse_mon_status(struct ath12k_pdev_dp *dp_pdev,
+					struct ath12k_mon_data *pmon,
+					struct sk_buff *skb,
+					struct napi_struct *napi)
+{
+	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
+	struct dp_mon_mpdu *tmp;
+	struct dp_mon_mpdu *mon_mpdu = pmon->mon_mpdu;
+	enum hal_rx_mon_status hal_status;
+
+	hal_status = ath12k_wifi7_dp_mon_parse_rx_dest(dp_pdev, pmon, skb);
+	if (hal_status != HAL_RX_MON_STATUS_PPDU_DONE)
+		return hal_status;
+
+	list_for_each_entry_safe(mon_mpdu, tmp, &pmon->dp_rx_mon_mpdu_list, list) {
+		list_del(&mon_mpdu->list);
+
+		if (mon_mpdu->head && mon_mpdu->tail)
+			ath12k_dp_mon_rx_deliver(dp_pdev, mon_mpdu, ppdu_info, napi);
+
+		kfree(mon_mpdu);
+	}
+
+	return hal_status;
+}
+
+static int
+ath12k_wifi7_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
+					int *budget, struct sk_buff_head *skb_list)
+{
+	const struct ath12k_hw_hal_params *hal_params;
+	int buf_id, srng_id, num_buffs_reaped = 0;
+	enum dp_mon_status_buf_state reap_status;
+	struct dp_rxdma_mon_ring *rx_ring;
+	struct ath12k_mon_data *pmon;
+	struct ath12k_skb_rxcb *rxcb;
+	struct hal_tlv_64_hdr *tlv;
+	void *rx_mon_status_desc;
+	struct hal_srng *srng;
+	struct ath12k_dp *dp;
+	struct sk_buff *skb;
+	struct ath12k *ar;
+	dma_addr_t paddr;
+	u32 cookie;
+	u8 rbm;
+
+	ar = ab->pdevs[ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id)].ar;
+	dp = ath12k_ab_to_dp(ab);
+	pmon = &ar->dp.mon_data;
+	srng_id = ath12k_hw_mac_id_to_srng_id(ab->hw_params, mac_id);
+	rx_ring = &dp->rx_mon_status_refill_ring[srng_id];
+
+	srng = &ab->hal.srng_list[rx_ring->refill_buf_ring.ring_id];
+
+	spin_lock_bh(&srng->lock);
+
+	ath12k_hal_srng_access_begin(ab, srng);
+
+	while (*budget) {
+		*budget -= 1;
+		rx_mon_status_desc = ath12k_hal_srng_src_peek(ab, srng);
+		if (!rx_mon_status_desc) {
+			pmon->buf_state = DP_MON_STATUS_REPLINISH;
+			break;
+		}
+		ath12k_wifi7_hal_rx_buf_addr_info_get(rx_mon_status_desc, &paddr,
+						      &cookie, &rbm);
+		if (paddr) {
+			buf_id = u32_get_bits(cookie, DP_RXDMA_BUF_COOKIE_BUF_ID);
+
+			spin_lock_bh(&rx_ring->idr_lock);
+			skb = idr_find(&rx_ring->bufs_idr, buf_id);
+			spin_unlock_bh(&rx_ring->idr_lock);
+
+			if (!skb) {
+				ath12k_warn(ab, "rx monitor status with invalid buf_id %d\n",
+					    buf_id);
+				pmon->buf_state = DP_MON_STATUS_REPLINISH;
+				goto move_next;
+			}
+
+			rxcb = ATH12K_SKB_RXCB(skb);
+
+			dma_sync_single_for_cpu(ab->dev, rxcb->paddr,
+						skb->len + skb_tailroom(skb),
+						DMA_FROM_DEVICE);
+
+			tlv = (struct hal_tlv_64_hdr *)skb->data;
+			if (le64_get_bits(tlv->tl, HAL_TLV_HDR_TAG) !=
+					HAL_RX_STATUS_BUFFER_DONE) {
+				pmon->buf_state = DP_MON_STATUS_NO_DMA;
+				ath12k_warn(ab,
+					    "mon status DONE not set %llx, buf_id %d\n",
+					    le64_get_bits(tlv->tl, HAL_TLV_HDR_TAG),
+					    buf_id);
+				/* RxDMA status done bit might not be set even
+				 * though tp is moved by HW.
+				 */
+
+				/* If done status is missing:
+				 * 1. As per MAC team's suggestion,
+				 *    when HP + 1 entry is peeked and if DMA
+				 *    is not done and if HP + 2 entry's DMA done
+				 *    is set. skip HP + 1 entry and
+				 *    start processing in next interrupt.
+				 * 2. If HP + 2 entry's DMA done is not set,
+				 *    poll onto HP + 1 entry DMA done to be set.
+				 *    Check status for same buffer for next time
+				 *    dp_rx_mon_status_srng_process
+				 */
+				reap_status = ath12k_wifi7_dp_rx_mon_buf_done(ab, srng,
+									      rx_ring);
+				if (reap_status == DP_MON_STATUS_NO_DMA)
+					continue;
+
+				spin_lock_bh(&rx_ring->idr_lock);
+				idr_remove(&rx_ring->bufs_idr, buf_id);
+				spin_unlock_bh(&rx_ring->idr_lock);
+
+				dma_unmap_single(ab->dev, rxcb->paddr,
+						 skb->len + skb_tailroom(skb),
+						 DMA_FROM_DEVICE);
+
+				dev_kfree_skb_any(skb);
+				pmon->buf_state = DP_MON_STATUS_REPLINISH;
+				goto move_next;
+			}
+
+			spin_lock_bh(&rx_ring->idr_lock);
+			idr_remove(&rx_ring->bufs_idr, buf_id);
+			spin_unlock_bh(&rx_ring->idr_lock);
+
+			dma_unmap_single(ab->dev, rxcb->paddr,
+					 skb->len + skb_tailroom(skb),
+					 DMA_FROM_DEVICE);
+
+			if (ath12k_dp_pkt_set_pktlen(skb, RX_MON_STATUS_BUF_SIZE)) {
+				dev_kfree_skb_any(skb);
+				goto move_next;
+			}
+			__skb_queue_tail(skb_list, skb);
+		} else {
+			pmon->buf_state = DP_MON_STATUS_REPLINISH;
+		}
+move_next:
+		skb = ath12k_dp_rx_alloc_mon_status_buf(ab, rx_ring,
+							&buf_id);
+		hal_params = ab->hal.hal_params;
+
+		if (!skb) {
+			ath12k_warn(ab, "failed to alloc buffer for status ring\n");
+			ath12k_wifi7_hal_rx_buf_addr_info_set(rx_mon_status_desc,
+							      0, 0,
+							      hal_params->rx_buf_rbm);
+			num_buffs_reaped++;
+			break;
+		}
+		rxcb = ATH12K_SKB_RXCB(skb);
+
+		cookie = u32_encode_bits(mac_id, DP_RXDMA_BUF_COOKIE_PDEV_ID) |
+			 u32_encode_bits(buf_id, DP_RXDMA_BUF_COOKIE_BUF_ID);
+
+		ath12k_wifi7_hal_rx_buf_addr_info_set(rx_mon_status_desc, rxcb->paddr,
+						      cookie, hal_params->rx_buf_rbm);
+		ath12k_hal_srng_src_get_next_entry(ab, srng);
+		num_buffs_reaped++;
+	}
+	ath12k_hal_srng_access_end(ab, srng);
+	spin_unlock_bh(&srng->lock);
+
+	return num_buffs_reaped;
+}
+
 static int
 __ath12k_wifi7_dp_mon_process_ring(struct ath12k *ar, int mac_id,
 				   struct napi_struct *napi, int *budget)
@@ -26,8 +410,8 @@ __ath12k_wifi7_dp_mon_process_ring(struct ath12k *ar, int mac_id,
 
 	__skb_queue_head_init(&skb_list);
 
-	num_buffs_reaped = ath12k_dp_rx_reap_mon_status_ring(ar->ab, mac_id,
-							     budget, &skb_list);
+	num_buffs_reaped = ath12k_wifi7_dp_rx_reap_mon_status_ring(ar->ab, mac_id,
+								   budget, &skb_list);
 	if (!num_buffs_reaped)
 		goto exit;
 
@@ -35,14 +419,14 @@ __ath12k_wifi7_dp_mon_process_ring(struct ath12k *ar, int mac_id,
 		memset(ppdu_info, 0, sizeof(*ppdu_info));
 		ppdu_info->peer_id = HAL_INVALID_PEERID;
 
-		hal_status = ath12k_dp_mon_parse_rx_dest(&ar->dp, pmon, skb);
+		hal_status = ath12k_wifi7_dp_mon_parse_rx_dest(&ar->dp, pmon, skb);
 
 		if (ar->monitor_started &&
 		    pmon->mon_ppdu_status == DP_PPDU_STATUS_START &&
 		    hal_status == HAL_TLV_STATUS_PPDU_DONE) {
 			rx_mon_stats->status_ppdu_done++;
 			pmon->mon_ppdu_status = DP_PPDU_STATUS_DONE;
-			ath12k_dp_rx_mon_dest_process(ar, mac_id, *budget, napi);
+			ath12k_wifi7_dp_rx_mon_dest_process(ar, mac_id, *budget, napi);
 			pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
 		}
 
@@ -167,10 +551,11 @@ ath12k_wifi7_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
 	 * the memset of the ppdu_info structure and continue processing it.
 	 */
 	if (!ppdu_info->ppdu_continuation)
-		ath12k_dp_mon_rx_memset_ppdu_info(ppdu_info);
+		ath12k_wifi7_dp_mon_rx_memset_ppdu_info(ppdu_info);
 
 	while ((skb = __skb_dequeue(&skb_list))) {
-		hal_status = ath12k_dp_mon_rx_parse_mon_status(pdev_dp, pmon, skb, napi);
+		hal_status = ath12k_wifi7_dp_mon_rx_parse_mon_status(pdev_dp, pmon,
+								     skb, napi);
 		if (hal_status != HAL_RX_MON_STATUS_PPDU_DONE) {
 			ppdu_info->ppdu_continuation = true;
 			dev_kfree_skb_any(skb);
@@ -201,7 +586,7 @@ ath12k_wifi7_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
 		rcu_read_unlock();
 free_skb:
 		dev_kfree_skb_any(skb);
-		ath12k_dp_mon_rx_memset_ppdu_info(ppdu_info);
+		ath12k_wifi7_dp_mon_rx_memset_ppdu_info(ppdu_info);
 	}
 
 	return num_buffs_reaped;
-- 
2.34.1


