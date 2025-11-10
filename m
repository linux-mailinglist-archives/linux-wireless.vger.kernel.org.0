Return-Path: <linux-wireless+bounces-28734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A87C45F88
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1586A1890AE2
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 10:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C3D3054C4;
	Mon, 10 Nov 2025 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SqQF2e6C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684223002D8
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771048; cv=none; b=ckLC8VwN5DzCf5yz+H7yA1KAsACPopZtTr+ZmtUcB1zI7tXJ+BFHK8+A8rGaB6olACj9YV+Os04HnkT5RpAKnjHhGGaV5j+R1aBn1sgDo2gTEHw9qbfHeip0rYqcbaVYB/lvTiJOXkGmrQSo1azgIW3+0LxVXlljCTy4bJD8lUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771048; c=relaxed/simple;
	bh=vUxzl5zQYpb6FzjFeW/EB54rEfcmb+6VA5/uzaYo5lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N6uXKRsta4W4ZY8lO/WB+zv9EM057KOHfdfBSPX2U+AFa4ig8K2nbE+AJkeBd6yUcIft8IPM3nUgHLpC8JG/gH80klaVG0KLJu154bFSnVGTJbjJE3kLBearkvKYdzBO16rViYBh9+laqY9MxyjHS4vbn/LjPxisJNy/9zIoHcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SqQF2e6C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8UKcZ1809202;
	Mon, 10 Nov 2025 10:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pg42q6NB3tt
	BE4SVf/xl6j4GMDSB/LOGWlbFvli8rAU=; b=SqQF2e6CoiL11gDWzt0J/0tbn97
	4bTKIRGnAUlDeNWL7IosbprLAEX2ghFQYU1pyDTcXydevBaV+OMB7APITeRH87/M
	7YCONs66LRQmj9tq58VrG4xjQIdUf/c8V3+hGlE/ac5KNbDeadkWsqOK5vGzxDyd
	WIzzucD78aPdFW0IQ2CSG67K7CaAm90S95iokvMuS2ByRHndbZVfxF8fYpoBv9+f
	hBh/k64UpvunSMbJX1kmW2bS0My5ztDZfsm1oG63MoZd3Cx+x46ANB8SuF905B5w
	cogevwxvl3qTLmMTuj5OKkgnLdyVuioAgMGXpJyCxOa5H5Dk9xK6NsYbn2Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab5m1hhb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:20 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAAbHRe008070;
	Mon, 10 Nov 2025 10:37:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a9xxkq1fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:17 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AAAbHOV008044;
	Mon, 10 Nov 2025 10:37:17 GMT
Received: from hu-devc-blr-u22-c.qualcomm.com (hu-aloksing-blr.qualcomm.com [10.190.111.138])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5AAAbHuq008038
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:17 +0000
Received: by hu-devc-blr-u22-c.qualcomm.com (Postfix, from userid 2272527)
	id 82DC75E3; Mon, 10 Nov 2025 16:07:16 +0530 (+0530)
From: Alok Singh <quic_aloksing@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Alok Singh <quic_aloksing@quicinc.com>
Subject: [PATCH ath12k-ng 03/12] wifi: ath12k: Move MPDU pop functionality to Wi-Fi 7 module
Date: Mon, 10 Nov 2025 16:07:04 +0530
Message-Id: <20251110103713.3484779-4-quic_aloksing@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MiBTYWx0ZWRfX0XbgjN/pKCf/
 oxshD0RnA25yurGuzY70Gzat78X9pVznIW2H0aJ5pwryxLKacmV2EHP3vw+fn6zj2E1EpHSxdsg
 G796bUTc9DT71L5W0OvRWmGchoy4vyGO8iHqyLNvHy9rlTUMz82Iml5NmVVV/CeYOYXQD3VFsHG
 XMZpOOGqVj8PnzUyI12ljkCwpzUBto6OnGIdnRvJs5PXIxbOWGbJXLcRRO9JJc0LHhqCSAXZ4rh
 9epPBd/Uws+UcdpqTdbxFB5TroUNjKYQ26h4Jxr65AVA3jX0KPgQPhyip/hOVRUPrvHQ6pYbQ18
 deJXBSY3pYiLfcVoPF+l0+B+n0cmeI/98ZIeY9VpdzFcT07U12NAqaFCCCJ4+ju5SS8cvq4ZElf
 ZR80gM8b2Ybvva72OY2mRcaFKJa36A==
X-Authority-Analysis: v=2.4 cv=TsXrRTXh c=1 sm=1 tr=0 ts=6911c061 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=9-3pT3-K_x4IDlJ1OH4A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ORAB1RQEKseFRK34_mV1nPooKh7UeLTy
X-Proofpoint-GUID: ORAB1RQEKseFRK34_mV1nPooKh7UeLTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100092

Separate Wi-Fi 7-specific monitor code from ath12k common
code to improve modularity.

Move the following monitor MPDU pop function to the new
file wifi7/dp_mon.c and rename them with the ath12k_wifi7_ prefix:
- ath12k_dp_rx_mon_mpdu_pop()

Export helper functions required by the ath12k_wifi7 module.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Alok Singh <quic_aloksing@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 207 +-----------------
 drivers/net/wireless/ath/ath12k/dp_mon.h      |  15 +-
 drivers/net/wireless/ath/ath12k/hal.h         |   5 +
 .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 201 ++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  11 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   3 +
 .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |   5 -
 7 files changed, 230 insertions(+), 217 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 37a5d46b1ca4..16361dd77a6a 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -17,16 +17,6 @@
 #define ATH12K_LE64_DEC_ENC(value, dec_bits, enc_bits) \
 		u32_encode_bits(le64_get_bits(value, dec_bits), enc_bits)
 
-static bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
-					struct hal_rx_desc *rx_desc)
-{
-	u32 tlv_tag;
-
-	tlv_tag = ab->hal.ops->rx_desc_get_mpdu_start_tag(rx_desc);
-
-	return tlv_tag == HAL_RX_MPDU_START;
-}
-
 static void
 ath12k_dp_mon_rx_handle_ofdma_info(const struct hal_rx_ppdu_end_user_stats *ppdu_end_user,
 				   struct hal_rx_user_status *rx_user_status)
@@ -1807,7 +1797,7 @@ struct sk_buff
 }
 EXPORT_SYMBOL(ath12k_dp_rx_alloc_mon_status_buf);
 
-static u32 ath12k_dp_mon_comp_ppduid(u32 msdu_ppdu_id, u32 *ppdu_id)
+u32 ath12k_dp_mon_comp_ppduid(u32 msdu_ppdu_id, u32 *ppdu_id)
 {
 	u32 ret = 0;
 
@@ -1826,8 +1816,8 @@ static u32 ath12k_dp_mon_comp_ppduid(u32 msdu_ppdu_id, u32 *ppdu_id)
 	}
 	return ret;
 }
+EXPORT_SYMBOL(ath12k_dp_mon_comp_ppduid);
 
-static
 void ath12k_dp_mon_next_link_desc_get(struct ath12k_base *ab,
 				      struct hal_rx_msdu_link *msdu_link,
 				      dma_addr_t *paddr, u32 *sw_cookie, u8 *rbm,
@@ -1841,6 +1831,7 @@ void ath12k_dp_mon_next_link_desc_get(struct ath12k_base *ab,
 
 	*pp_buf_addr_info = buf_addr_info;
 }
+EXPORT_SYMBOL(ath12k_dp_mon_next_link_desc_get);
 
 static void
 ath12k_dp_mon_fill_rx_rate(struct ath12k_pdev_dp *dp_pdev,
@@ -2400,7 +2391,7 @@ EXPORT_SYMBOL(ath12k_dp_pkt_set_pktlen);
  */
 #define RXDMA_DATA_DMA_BLOCK_SIZE 128
 
-static void
+void
 ath12k_dp_mon_get_buf_len(struct hal_rx_msdu_desc_info *info,
 			  bool *is_frag, u32 *total_len,
 			  u32 *frag_len, u32 *msdu_cnt)
@@ -2420,6 +2411,7 @@ ath12k_dp_mon_get_buf_len(struct hal_rx_msdu_desc_info *info,
 		*msdu_cnt -= 1;
 	}
 }
+EXPORT_SYMBOL(ath12k_dp_mon_get_buf_len);
 
 static int
 ath12k_dp_mon_parse_status_buf(struct ath12k_pdev_dp *dp_pdev,
@@ -3649,192 +3641,3 @@ ath12k_dp_mon_rx_update_peer_mu_stats(struct ath12k_base *ab,
 		ath12k_dp_mon_rx_update_user_stats(ab, ppdu_info, i);
 }
 EXPORT_SYMBOL(ath12k_dp_mon_rx_update_peer_mu_stats);
-
-u32
-ath12k_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
-			  void *ring_entry, struct sk_buff **head_msdu,
-			  struct sk_buff **tail_msdu,
-			  struct list_head *used_list,
-			  u32 *npackets, u32 *ppdu_id)
-{
-	struct ath12k_mon_data *pmon = (struct ath12k_mon_data *)&ar->dp.mon_data;
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
-	struct ath12k_buffer_addr *p_buf_addr_info, *p_last_buf_addr_info;
-	u32 msdu_ppdu_id = 0, msdu_cnt = 0, total_len = 0, frag_len = 0;
-	u32 rx_buf_size, rx_pkt_offset, sw_cookie;
-	bool is_frag, is_first_msdu, drop_mpdu = false;
-	struct hal_reo_entrance_ring *ent_desc =
-		(struct hal_reo_entrance_ring *)ring_entry;
-	u32 rx_bufs_used = 0, i = 0, desc_bank = 0;
-	struct hal_rx_desc *rx_desc, *tail_rx_desc;
-	struct hal_rx_msdu_link *msdu_link_desc;
-	struct sk_buff *msdu = NULL, *last = NULL;
-	struct ath12k_rx_desc_info *desc_info;
-	struct ath12k_buffer_addr buf_info;
-	struct hal_rx_msdu_list msdu_list;
-	struct ath12k_skb_rxcb *rxcb;
-	u16 num_msdus = 0;
-	dma_addr_t paddr;
-	u8 rbm;
-
-	ath12k_hal_rx_reo_ent_buf_paddr_get(&ab->hal, ring_entry, &paddr,
-					    &sw_cookie,
-					    &p_last_buf_addr_info, &rbm,
-					    &msdu_cnt);
-
-	spin_lock_bh(&pmon->mon_lock);
-
-	if (le32_get_bits(ent_desc->info1,
-			  HAL_REO_ENTR_RING_INFO1_RXDMA_PUSH_REASON) ==
-			  HAL_REO_DEST_RING_PUSH_REASON_ERR_DETECTED) {
-		u8 rxdma_err = le32_get_bits(ent_desc->info1,
-					     HAL_REO_ENTR_RING_INFO1_RXDMA_ERROR_CODE);
-		if (rxdma_err == HAL_REO_ENTR_RING_RXDMA_ECODE_FLUSH_REQUEST_ERR ||
-		    rxdma_err == HAL_REO_ENTR_RING_RXDMA_ECODE_MPDU_LEN_ERR ||
-		    rxdma_err == HAL_REO_ENTR_RING_RXDMA_ECODE_OVERFLOW_ERR) {
-			drop_mpdu = true;
-			pmon->rx_mon_stats.dest_mpdu_drop++;
-		}
-	}
-
-	is_frag = false;
-	is_first_msdu = true;
-	rx_pkt_offset = sizeof(struct hal_rx_desc);
-
-	do {
-		if (pmon->mon_last_linkdesc_paddr == paddr) {
-			pmon->rx_mon_stats.dup_mon_linkdesc_cnt++;
-			spin_unlock_bh(&pmon->mon_lock);
-			return rx_bufs_used;
-		}
-
-		desc_bank = u32_get_bits(sw_cookie, DP_LINK_DESC_BANK_MASK);
-		msdu_link_desc =
-			dp->link_desc_banks[desc_bank].vaddr +
-			(paddr - dp->link_desc_banks[desc_bank].paddr);
-
-		ath12k_hal_rx_msdu_list_get(&ar->ab->hal, ar, msdu_link_desc, &msdu_list,
-					    &num_msdus);
-		desc_info = ath12k_dp_get_rx_desc(ar->ab->dp,
-						  msdu_list.sw_cookie[num_msdus - 1]);
-		tail_rx_desc = (struct hal_rx_desc *)(desc_info->skb)->data;
-
-		for (i = 0; i < num_msdus; i++) {
-			u32 l2_hdr_offset;
-
-			if (pmon->mon_last_buf_cookie == msdu_list.sw_cookie[i]) {
-				ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
-					   "i %d last_cookie %d is same\n",
-					   i, pmon->mon_last_buf_cookie);
-				drop_mpdu = true;
-				pmon->rx_mon_stats.dup_mon_buf_cnt++;
-				continue;
-			}
-
-			desc_info =
-				ath12k_dp_get_rx_desc(ar->ab->dp, msdu_list.sw_cookie[i]);
-			msdu = desc_info->skb;
-
-			if (!msdu) {
-				ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
-					   "msdu_pop: invalid msdu (%d/%d)\n",
-					   i + 1, num_msdus);
-				goto next_msdu;
-			}
-			rxcb = ATH12K_SKB_RXCB(msdu);
-			if (rxcb->paddr != msdu_list.paddr[i]) {
-				ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
-					   "i %d paddr %lx != %lx\n",
-					   i, (unsigned long)rxcb->paddr,
-					   (unsigned long)msdu_list.paddr[i]);
-				drop_mpdu = true;
-				continue;
-			}
-			if (!rxcb->unmapped) {
-				dma_unmap_single(ar->ab->dev, rxcb->paddr,
-						 msdu->len +
-						 skb_tailroom(msdu),
-						 DMA_FROM_DEVICE);
-				rxcb->unmapped = 1;
-			}
-			if (drop_mpdu) {
-				ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
-					   "i %d drop msdu %p *ppdu_id %x\n",
-					   i, msdu, *ppdu_id);
-				dev_kfree_skb_any(msdu);
-				msdu = NULL;
-				goto next_msdu;
-			}
-
-			rx_desc = (struct hal_rx_desc *)msdu->data;
-			l2_hdr_offset = ath12k_dp_rx_h_l3pad(ar->ab, tail_rx_desc);
-			if (is_first_msdu) {
-				if (!ath12k_dp_rxdesc_mpdu_valid(ar->ab, rx_desc)) {
-					drop_mpdu = true;
-					dev_kfree_skb_any(msdu);
-					msdu = NULL;
-					pmon->mon_last_linkdesc_paddr = paddr;
-					goto next_msdu;
-				}
-				msdu_ppdu_id =
-					ath12k_dp_rxdesc_get_ppduid(ar->ab, rx_desc);
-
-				if (ath12k_dp_mon_comp_ppduid(msdu_ppdu_id,
-							      ppdu_id)) {
-					spin_unlock_bh(&pmon->mon_lock);
-					return rx_bufs_used;
-				}
-				pmon->mon_last_linkdesc_paddr = paddr;
-				is_first_msdu = false;
-			}
-			ath12k_dp_mon_get_buf_len(&msdu_list.msdu_info[i],
-						  &is_frag, &total_len,
-						  &frag_len, &msdu_cnt);
-			rx_buf_size = rx_pkt_offset + l2_hdr_offset + frag_len;
-
-			if (ath12k_dp_pkt_set_pktlen(msdu, rx_buf_size)) {
-				dev_kfree_skb_any(msdu);
-				goto next_msdu;
-			}
-
-			if (!(*head_msdu))
-				*head_msdu = msdu;
-			else if (last)
-				last->next = msdu;
-
-			last = msdu;
-next_msdu:
-			pmon->mon_last_buf_cookie = msdu_list.sw_cookie[i];
-			rx_bufs_used++;
-			desc_info->skb = NULL;
-			list_add_tail(&desc_info->list, used_list);
-		}
-
-		ath12k_hal_rx_buf_addr_info_set(&ab->hal, &buf_info, paddr,
-						sw_cookie, rbm);
-
-		ath12k_dp_mon_next_link_desc_get(ab, msdu_link_desc, &paddr,
-						 &sw_cookie, &rbm,
-						 &p_buf_addr_info);
-
-		ath12k_dp_arch_rx_link_desc_return(ar->ab->dp, &buf_info,
-						   HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
-
-		p_last_buf_addr_info = p_buf_addr_info;
-
-	} while (paddr && msdu_cnt);
-
-	spin_unlock_bh(&pmon->mon_lock);
-
-	if (last)
-		last->next = NULL;
-
-	*tail_msdu = msdu;
-
-	if (msdu_cnt == 0)
-		*npackets = 1;
-
-	return rx_bufs_used;
-}
-EXPORT_SYMBOL(ath12k_dp_rx_mon_mpdu_pop);
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index 726434ab74ac..425bec6f0f3c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -101,12 +101,6 @@ ath12k_dp_mon_rx_update_peer_mu_stats(struct ath12k_base *ab,
 				      struct hal_rx_mon_ppdu_info *ppdu_info);
 void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k_dp_link_peer *peer,
 					   struct hal_rx_mon_ppdu_info *ppdu_info);
-u32
-ath12k_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
-			  void *ring_entry, struct sk_buff **head_msdu,
-			  struct sk_buff **tail_msdu,
-			  struct list_head *used_list,
-			  u32 *npackets, u32 *ppdu_id);
 int ath12k_dp_pkt_set_pktlen(struct sk_buff *skb, u32 len);
 int ath12k_dp_mon_rx_deliver(struct ath12k_pdev_dp *dp_pdev,
 			     struct dp_mon_mpdu *mon_mpdu,
@@ -125,4 +119,13 @@ struct sk_buff
 *ath12k_dp_rx_alloc_mon_status_buf(struct ath12k_base *ab,
 				   struct dp_rxdma_mon_ring *rx_ring,
 				   int *buf_id);
+void
+ath12k_dp_mon_get_buf_len(struct hal_rx_msdu_desc_info *info,
+			  bool *is_frag, u32 *total_len,
+			  u32 *frag_len, u32 *msdu_cnt);
+void ath12k_dp_mon_next_link_desc_get(struct ath12k_base *ab,
+				      struct hal_rx_msdu_link *msdu_link,
+				      dma_addr_t *paddr, u32 *sw_cookie, u8 *rbm,
+				      struct ath12k_buffer_addr **pp_buf_addr_info);
+u32 ath12k_dp_mon_comp_ppduid(u32 msdu_ppdu_id, u32 *ppdu_id);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 071f4897e4cd..1d22173975f0 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -592,6 +592,11 @@ struct hal_rx_eht_info {
 	u32 user_info[EHT_MAX_USER_INFO];
 };
 
+struct hal_rx_msdu_desc_info {
+	u32 msdu_flags;
+	u16 msdu_len; /* 14 bits for length */
+};
+
 struct hal_rx_mon_ppdu_info {
 	u32 ppdu_id;
 	u32 last_ppdu_id;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
index ffebeb1652e7..dae3f262cc50 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
@@ -19,6 +19,196 @@ ath12k_wifi7_dp_mon_rx_memset_ppdu_info(struct hal_rx_mon_ppdu_info *ppdu_info)
 	ppdu_info->peer_id = HAL_INVALID_PEERID;
 }
 
+static u32
+ath12k_wifi7_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
+				void *ring_entry, struct sk_buff **head_msdu,
+				struct sk_buff **tail_msdu,
+				struct list_head *used_list,
+				u32 *npackets, u32 *ppdu_id)
+{
+	struct ath12k_mon_data *pmon = (struct ath12k_mon_data *)&ar->dp.mon_data;
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_buffer_addr *p_buf_addr_info, *p_last_buf_addr_info;
+	u32 msdu_ppdu_id = 0, msdu_cnt = 0, total_len = 0, frag_len = 0;
+	u32 rx_buf_size, rx_pkt_offset, sw_cookie;
+	bool is_frag, is_first_msdu, drop_mpdu = false;
+	struct hal_reo_entrance_ring *ent_desc =
+		(struct hal_reo_entrance_ring *)ring_entry;
+	u32 rx_bufs_used = 0, i = 0, desc_bank = 0;
+	struct hal_rx_desc *rx_desc, *tail_rx_desc;
+	struct hal_rx_msdu_link *msdu_link_desc;
+	struct sk_buff *msdu = NULL, *last = NULL;
+	struct ath12k_rx_desc_info *desc_info;
+	struct ath12k_buffer_addr buf_info;
+	struct hal_rx_msdu_list msdu_list;
+	struct ath12k_skb_rxcb *rxcb;
+	u16 num_msdus = 0;
+	dma_addr_t paddr;
+	u8 rbm;
+
+	ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get(ring_entry, &paddr,
+						  &sw_cookie,
+						  &p_last_buf_addr_info,
+						  &rbm,
+						  &msdu_cnt);
+
+	spin_lock_bh(&pmon->mon_lock);
+
+	if (le32_get_bits(ent_desc->info1,
+			  HAL_REO_ENTR_RING_INFO1_RXDMA_PUSH_REASON) ==
+			  HAL_REO_DEST_RING_PUSH_REASON_ERR_DETECTED) {
+		u8 rxdma_err = le32_get_bits(ent_desc->info1,
+					     HAL_REO_ENTR_RING_INFO1_RXDMA_ERROR_CODE);
+		if (rxdma_err == HAL_REO_ENTR_RING_RXDMA_ECODE_FLUSH_REQUEST_ERR ||
+		    rxdma_err == HAL_REO_ENTR_RING_RXDMA_ECODE_MPDU_LEN_ERR ||
+		    rxdma_err == HAL_REO_ENTR_RING_RXDMA_ECODE_OVERFLOW_ERR) {
+			drop_mpdu = true;
+			pmon->rx_mon_stats.dest_mpdu_drop++;
+		}
+	}
+
+	is_frag = false;
+	is_first_msdu = true;
+	rx_pkt_offset = sizeof(struct hal_rx_desc);
+
+	do {
+		if (pmon->mon_last_linkdesc_paddr == paddr) {
+			pmon->rx_mon_stats.dup_mon_linkdesc_cnt++;
+			spin_unlock_bh(&pmon->mon_lock);
+			return rx_bufs_used;
+		}
+
+		desc_bank = u32_get_bits(sw_cookie, DP_LINK_DESC_BANK_MASK);
+		msdu_link_desc =
+			dp->link_desc_banks[desc_bank].vaddr +
+			(paddr - dp->link_desc_banks[desc_bank].paddr);
+
+		ath12k_wifi7_hal_rx_msdu_list_get(ar, msdu_link_desc, &msdu_list,
+						  &num_msdus);
+		desc_info = ath12k_dp_get_rx_desc(ar->ab->dp,
+						  msdu_list.sw_cookie[num_msdus - 1]);
+		tail_rx_desc = (struct hal_rx_desc *)(desc_info->skb)->data;
+
+		for (i = 0; i < num_msdus; i++) {
+			u32 l2_hdr_offset;
+
+			if (pmon->mon_last_buf_cookie == msdu_list.sw_cookie[i]) {
+				ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+					   "i %d last_cookie %d is same\n",
+					   i, pmon->mon_last_buf_cookie);
+				drop_mpdu = true;
+				pmon->rx_mon_stats.dup_mon_buf_cnt++;
+				continue;
+			}
+
+			desc_info =
+				ath12k_dp_get_rx_desc(ar->ab->dp, msdu_list.sw_cookie[i]);
+			msdu = desc_info->skb;
+
+			if (!msdu) {
+				ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+					   "msdu_pop: invalid msdu (%d/%d)\n",
+					   i + 1, num_msdus);
+				goto next_msdu;
+			}
+			rxcb = ATH12K_SKB_RXCB(msdu);
+			if (rxcb->paddr != msdu_list.paddr[i]) {
+				ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+					   "i %d paddr %lx != %lx\n",
+					   i, (unsigned long)rxcb->paddr,
+					   (unsigned long)msdu_list.paddr[i]);
+				drop_mpdu = true;
+				continue;
+			}
+			if (!rxcb->unmapped) {
+				dma_unmap_single(ar->ab->dev, rxcb->paddr,
+						 msdu->len +
+						 skb_tailroom(msdu),
+						 DMA_FROM_DEVICE);
+				rxcb->unmapped = 1;
+			}
+			if (drop_mpdu) {
+				ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+					   "i %d drop msdu %p *ppdu_id %x\n",
+					   i, msdu, *ppdu_id);
+				dev_kfree_skb_any(msdu);
+				msdu = NULL;
+				goto next_msdu;
+			}
+
+			rx_desc = (struct hal_rx_desc *)msdu->data;
+			l2_hdr_offset = ath12k_dp_rx_h_l3pad(ar->ab, tail_rx_desc);
+			if (is_first_msdu) {
+				if (!ath12k_wifi7_dp_rxdesc_mpdu_valid(ar->ab,
+								       rx_desc)) {
+					drop_mpdu = true;
+					dev_kfree_skb_any(msdu);
+					msdu = NULL;
+					pmon->mon_last_linkdesc_paddr = paddr;
+					goto next_msdu;
+				}
+				msdu_ppdu_id =
+					ath12k_dp_rxdesc_get_ppduid(ar->ab, rx_desc);
+
+				if (ath12k_dp_mon_comp_ppduid(msdu_ppdu_id,
+							      ppdu_id)) {
+					spin_unlock_bh(&pmon->mon_lock);
+					return rx_bufs_used;
+				}
+				pmon->mon_last_linkdesc_paddr = paddr;
+				is_first_msdu = false;
+			}
+			ath12k_dp_mon_get_buf_len(&msdu_list.msdu_info[i],
+						  &is_frag, &total_len,
+						  &frag_len, &msdu_cnt);
+			rx_buf_size = rx_pkt_offset + l2_hdr_offset + frag_len;
+
+			if (ath12k_dp_pkt_set_pktlen(msdu, rx_buf_size)) {
+				dev_kfree_skb_any(msdu);
+				goto next_msdu;
+			}
+
+			if (!(*head_msdu))
+				*head_msdu = msdu;
+			else if (last)
+				last->next = msdu;
+
+			last = msdu;
+next_msdu:
+			pmon->mon_last_buf_cookie = msdu_list.sw_cookie[i];
+			rx_bufs_used++;
+			desc_info->skb = NULL;
+			list_add_tail(&desc_info->list, used_list);
+		}
+
+		ath12k_wifi7_hal_rx_buf_addr_info_set(&buf_info, paddr,
+						      sw_cookie, rbm);
+
+		ath12k_dp_mon_next_link_desc_get(ab, msdu_link_desc, &paddr,
+						 &sw_cookie, &rbm,
+						 &p_buf_addr_info);
+
+		ath12k_dp_arch_rx_link_desc_return(ar->ab->dp, &buf_info,
+						   HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+
+		p_last_buf_addr_info = p_buf_addr_info;
+
+	} while (paddr && msdu_cnt);
+
+	spin_unlock_bh(&pmon->mon_lock);
+
+	if (last)
+		last->next = NULL;
+
+	*tail_msdu = msdu;
+
+	if (msdu_cnt == 0)
+		*npackets = 1;
+
+	return rx_bufs_used;
+}
+
 /* The destination ring processing is stuck if the destination is not
  * moving while status ring moves 16 PPDU. The destination ring processing
  * skips this destination ring PPDU as a workaround.
@@ -58,10 +248,13 @@ ath12k_wifi7_dp_rx_mon_dest_process(struct ath12k *ar, int mac_id,
 		head_msdu = NULL;
 		tail_msdu = NULL;
 
-		mpdu_rx_bufs_used = ath12k_dp_rx_mon_mpdu_pop(ar, mac_id, ring_entry,
-							      &head_msdu, &tail_msdu,
-							      &rx_desc_used_list,
-							      &npackets, &ppdu_id);
+		mpdu_rx_bufs_used = ath12k_wifi7_dp_rx_mon_mpdu_pop(ar, mac_id,
+								    ring_entry,
+								    &head_msdu,
+								    &tail_msdu,
+								    &rx_desc_used_list,
+								    &npackets,
+								    &ppdu_id);
 
 		rx_bufs_used += mpdu_rx_bufs_used;
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index 2138b20a04d5..08dcf170b801 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -2141,3 +2141,14 @@ void ath12k_wifi7_dp_rx_process_reo_status(struct ath12k_dp *dp)
 
 	spin_unlock_bh(&srng->lock);
 }
+
+bool
+ath12k_wifi7_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
+				  struct hal_rx_desc *rx_desc)
+{
+	u32 tlv_tag;
+
+	tlv_tag = ab->hal.ops->rx_desc_get_mpdu_start_tag(rx_desc);
+
+	return tlv_tag == HAL_RX_MPDU_START;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
index b92f9cf173dc..2d3eb2313b2f 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -49,6 +49,9 @@ int ath12k_wifi7_peer_rx_tid_reo_update(struct ath12k_dp *dp,
 					struct ath12k_dp_rx_tid *rx_tid,
 					u32 ba_win_sz, u16 ssn,
 					bool update_ssn);
+bool
+ath12k_wifi7_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
+				  struct hal_rx_desc *rx_desc);
 static inline
 void ath12k_wifi7_dp_extract_rx_desc_data(struct ath12k_hal *hal,
 					  struct hal_rx_desc_data *rx_info,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
index 2715b7d52cfc..c5a2125a04af 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
@@ -313,11 +313,6 @@ struct hal_rx_rxpcu_classification_overview {
 	u32 rsvd0;
 } __packed;
 
-struct hal_rx_msdu_desc_info {
-	u32 msdu_flags;
-	u16 msdu_len; /* 14 bits for length */
-};
-
 #define HAL_RX_NUM_MSDU_DESC 6
 struct hal_rx_msdu_list {
 	struct hal_rx_msdu_desc_info msdu_info[HAL_RX_NUM_MSDU_DESC];
-- 
2.34.1


