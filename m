Return-Path: <linux-wireless+bounces-26822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 637D0B3A845
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 19:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2305189AD77
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF2A340DB6;
	Thu, 28 Aug 2025 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CiSjnUE+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8C2338F38
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402592; cv=none; b=hXGOb4BaNJgIZef73UNH17mE/GWH8BK847gXvNF1wuRG9/prZahDcxZkEuIRxB1kx3Gv96I9fCf4ww4SqDIBxUg+l4r71eXdiUIBC4DlG/M+tqztDDN/3bf6eyYSGztzD0Lc7xM5svuftYf71bPSu3SzE7BHzrsZ5hazgNDDvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402592; c=relaxed/simple;
	bh=ywJUXELtlunfJjta5eGwbru44GRuXyhmWdqGVTyi1Fo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRvTjTDpF+3w5pU7xLrSWIC7IepQrcUn5CeDu71Ow2XxNXpVF4/ZY4ZK2sz0sXMOfncj8l7KChpRkWZKY+rE8lxdE+ZdN8fQ47edJ3dndTycIBxFUpjGudQgqejcL62zdyZxyHEn/BpiYeIWhLusAAznx5fZz2Nc4Uy6iwGxUKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CiSjnUE+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SDmRNk031557;
	Thu, 28 Aug 2025 17:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m0tJPKGb/wBfS9OzaUDIflv0v/0Rs/5Ck5PxQztIrIE=; b=CiSjnUE+pXZsrLv9
	swomtQwPkd/IZHD4BA4xoV6VI97AAlDJ//1jYvEtBKL0XSKSDcVZW9IcV6cLmRdt
	mjFcfiZdTc0/hh1npOSsysuyD75Mgb2KziFnlG6CdgSKRPlyaB4Hc9X1D2DBFvLH
	5IYh3duYQhRe1OAk/bjVFpMRKQ8Fw4vMwwC7Mq32OUMs2AsvwlXlJ2jAxCoE3RI0
	CitX51gEUGtLhDW2CA4ydgTRdmG8KXES8dUCeycLj6stlG6/VI15KDvCjvv/A8pF
	gmxVHayENa11KSB3tIePkysYAgjSX4nzxDtSMYZ15FVxf8TfR3H4tj4G9YKpclvb
	jAitIQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615s2ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SHaOn8019692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:24 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 10:36:22 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 09/20] wifi: ath12k: Move rx error and defrag functions to wifi7 directory
Date: Thu, 28 Aug 2025 23:05:42 +0530
Message-ID: <20250828173553.3341351-10-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
References: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX8u16jd2iVBr9
 FolqO8NuXK/MeAc4CldV78Pl5a7QeOtHwi6O4SFN+ELwTFTYqYYp0XA8RHePEfi6D4pzZwxJ/LZ
 VeppUibPlxspFeJwmhaayNWqFxp6lMTGdtUviO/DRKXfsiY63WuKnnZqyeGvbH7nEj87GHyX/k6
 8ytIM/XNamLR9AneAfnYyykrUWehLYKMKRXvxFv5G+1z/VigY7BJUptu/uez2VwbNdYU2J24xLM
 UqPdpcLNFr4AtJCEO/8Wvli/kAwEpgW9KFZ1PyPhOhaWw6Da+JqshLf8TPpAXOhqIqgE+Os3bVH
 02us1m4r6CE6N+8LvlPfVL6Tt13r08do1AwtN+MsYptPM5FADN0GIcX8wt6rMN488dsBHhVK38G
 RKS/sT7R
X-Proofpoint-GUID: A65SUktaB5LtXGs8Zenu8j-yIO-VlC9c
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68b09399 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=TRiuUH53HfhBKZY0EgAA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: A65SUktaB5LtXGs8Zenu8j-yIO-VlC9c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move arch specific RX error and defrag functions to wifi7 directory.

The moved APIs will be a part of dp_rx.c file inside wifi7 directory.
wifi7/dp_rx.c file will continue to be part of ath12k.ko
temporarily until the corresponding infra for movement
to ath12k_wifi7.ko arrives in upcoming patches.

Architecture specific APIs:
ath12k_dp_rx_h_defrag_validate_incr_pn
ath12k_dp_rx_h_defrag_reo_reinject
ath12k_dp_rx_h_defrag
ath12k_dp_rx_frag_h_mpdu
ath12k_dp_process_rx_err_buf
ath12k_dp_rx_process_err
ath12k_dp_rx_null_q_desc_sg_drop
ath12k_dp_rx_h_null_q_desc

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c       | 711 +-----------------
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  21 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 682 +++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   2 +
 4 files changed, 714 insertions(+), 702 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 4f666fd077fc..d52fec62eed7 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -19,8 +19,6 @@
 #include "dp_mon.h"
 #include "debugfs_htt_stats.h"
 
-#define ATH12K_DP_RX_FRAGMENT_TIMEOUT_MS (2 * HZ)
-
 static size_t ath12k_dp_list_cut_nodes(struct list_head *list,
 				       struct list_head *head,
 				       size_t count)
@@ -653,8 +651,8 @@ int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
 	return ret;
 }
 
-static void ath12k_dp_rx_frags_cleanup(struct ath12k_dp_rx_tid *rx_tid,
-				       bool rel_link_desc)
+void ath12k_dp_rx_frags_cleanup(struct ath12k_dp_rx_tid *rx_tid,
+				bool rel_link_desc)
 {
 	struct ath12k_buffer_addr *buf_addr_info;
 	struct ath12k_base *ab = rx_tid->ab;
@@ -2096,10 +2094,10 @@ ath12k_dp_rx_h_find_peer(struct ath12k_base *ab, struct sk_buff *msdu,
 	return peer;
 }
 
-static void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
-				struct sk_buff *msdu,
-				struct hal_rx_desc *rx_desc,
-				struct ath12k_dp_rx_info *rx_info)
+void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
+			 struct sk_buff *msdu,
+			 struct hal_rx_desc *rx_desc,
+			 struct ath12k_dp_rx_info *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_skb_rxcb *rxcb;
@@ -2830,8 +2828,8 @@ static int ath12k_dp_rx_h_michael_mic(struct crypto_shash *tfm, u8 *key,
 	return ret;
 }
 
-static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer *peer,
-					  struct sk_buff *msdu)
+int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer *peer,
+				   struct sk_buff *msdu)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
@@ -2894,8 +2892,8 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer
 	return -EINVAL;
 }
 
-static void ath12k_dp_rx_h_undecap_frag(struct ath12k *ar, struct sk_buff *msdu,
-					enum hal_encrypt_type enctype, u32 flags)
+void ath12k_dp_rx_h_undecap_frag(struct ath12k *ar, struct sk_buff *msdu,
+				 enum hal_encrypt_type enctype, u32 flags)
 {
 	struct ieee80211_hdr *hdr;
 	size_t hdr_len;
@@ -2925,222 +2923,6 @@ static void ath12k_dp_rx_h_undecap_frag(struct ath12k *ar, struct sk_buff *msdu,
 	}
 }
 
-static int ath12k_dp_rx_h_defrag(struct ath12k *ar,
-				 struct ath12k_peer *peer,
-				 struct ath12k_dp_rx_tid *rx_tid,
-				 struct sk_buff **defrag_skb)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct hal_rx_desc *rx_desc;
-	struct sk_buff *skb, *first_frag, *last_frag;
-	struct ieee80211_hdr *hdr;
-	enum hal_encrypt_type enctype;
-	bool is_decrypted = false;
-	int msdu_len = 0;
-	int extra_space;
-	u32 flags, hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
-
-	first_frag = skb_peek(&rx_tid->rx_frags);
-	last_frag = skb_peek_tail(&rx_tid->rx_frags);
-
-	skb_queue_walk(&rx_tid->rx_frags, skb) {
-		flags = 0;
-		rx_desc = (struct hal_rx_desc *)skb->data;
-		hdr = (struct ieee80211_hdr *)(skb->data + hal_rx_desc_sz);
-
-		enctype = ath12k_dp_rx_h_enctype(ab, rx_desc);
-		if (enctype != HAL_ENCRYPT_TYPE_OPEN)
-			is_decrypted = ath12k_dp_rx_h_is_decrypted(ab,
-								   rx_desc);
-
-		if (is_decrypted) {
-			if (skb != first_frag)
-				flags |= RX_FLAG_IV_STRIPPED;
-			if (skb != last_frag)
-				flags |= RX_FLAG_ICV_STRIPPED |
-					 RX_FLAG_MIC_STRIPPED;
-		}
-
-		/* RX fragments are always raw packets */
-		if (skb != last_frag)
-			skb_trim(skb, skb->len - FCS_LEN);
-		ath12k_dp_rx_h_undecap_frag(ar, skb, enctype, flags);
-
-		if (skb != first_frag)
-			skb_pull(skb, hal_rx_desc_sz +
-				      ieee80211_hdrlen(hdr->frame_control));
-		msdu_len += skb->len;
-	}
-
-	extra_space = msdu_len - (DP_RX_BUFFER_SIZE + skb_tailroom(first_frag));
-	if (extra_space > 0 &&
-	    (pskb_expand_head(first_frag, 0, extra_space, GFP_ATOMIC) < 0))
-		return -ENOMEM;
-
-	__skb_unlink(first_frag, &rx_tid->rx_frags);
-	while ((skb = __skb_dequeue(&rx_tid->rx_frags))) {
-		skb_put_data(first_frag, skb->data, skb->len);
-		dev_kfree_skb_any(skb);
-	}
-
-	hdr = (struct ieee80211_hdr *)(first_frag->data + hal_rx_desc_sz);
-	hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_MOREFRAGS);
-	ATH12K_SKB_RXCB(first_frag)->is_frag = 1;
-
-	if (ath12k_dp_rx_h_verify_tkip_mic(ar, peer, first_frag))
-		first_frag = NULL;
-
-	*defrag_skb = first_frag;
-	return 0;
-}
-
-static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
-					      struct ath12k_dp_rx_tid *rx_tid,
-					      struct sk_buff *defrag_skb)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_dp *dp = &ab->dp;
-	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)defrag_skb->data;
-	struct hal_reo_entrance_ring *reo_ent_ring;
-	struct hal_reo_dest_ring *reo_dest_ring;
-	struct dp_link_desc_bank *link_desc_banks;
-	struct hal_rx_msdu_link *msdu_link;
-	struct hal_rx_msdu_details *msdu0;
-	struct hal_srng *srng;
-	dma_addr_t link_paddr, buf_paddr;
-	u32 desc_bank, msdu_info, msdu_ext_info, mpdu_info;
-	u32 cookie, hal_rx_desc_sz, dest_ring_info0, queue_addr_hi;
-	int ret;
-	struct ath12k_rx_desc_info *desc_info;
-	enum hal_rx_buf_return_buf_manager idle_link_rbm = dp->idle_link_rbm;
-	u8 dst_ind;
-
-	hal_rx_desc_sz = ab->hal.hal_desc_sz;
-	link_desc_banks = dp->link_desc_banks;
-	reo_dest_ring = rx_tid->dst_ring_desc;
-
-	ath12k_hal_rx_reo_ent_paddr_get(ab, &reo_dest_ring->buf_addr_info,
-					&link_paddr, &cookie);
-	desc_bank = u32_get_bits(cookie, DP_LINK_DESC_BANK_MASK);
-
-	msdu_link = (struct hal_rx_msdu_link *)(link_desc_banks[desc_bank].vaddr +
-			(link_paddr - link_desc_banks[desc_bank].paddr));
-	msdu0 = &msdu_link->msdu_link[0];
-	msdu_ext_info = le32_to_cpu(msdu0->rx_msdu_ext_info.info0);
-	dst_ind = u32_get_bits(msdu_ext_info, RX_MSDU_EXT_DESC_INFO0_REO_DEST_IND);
-
-	memset(msdu0, 0, sizeof(*msdu0));
-
-	msdu_info = u32_encode_bits(1, RX_MSDU_DESC_INFO0_FIRST_MSDU_IN_MPDU) |
-		    u32_encode_bits(1, RX_MSDU_DESC_INFO0_LAST_MSDU_IN_MPDU) |
-		    u32_encode_bits(0, RX_MSDU_DESC_INFO0_MSDU_CONTINUATION) |
-		    u32_encode_bits(defrag_skb->len - hal_rx_desc_sz,
-				    RX_MSDU_DESC_INFO0_MSDU_LENGTH) |
-		    u32_encode_bits(1, RX_MSDU_DESC_INFO0_VALID_SA) |
-		    u32_encode_bits(1, RX_MSDU_DESC_INFO0_VALID_DA);
-	msdu0->rx_msdu_info.info0 = cpu_to_le32(msdu_info);
-	msdu0->rx_msdu_ext_info.info0 = cpu_to_le32(msdu_ext_info);
-
-	/* change msdu len in hal rx desc */
-	ath12k_dp_rxdesc_set_msdu_len(ab, rx_desc, defrag_skb->len - hal_rx_desc_sz);
-
-	buf_paddr = dma_map_single(ab->dev, defrag_skb->data,
-				   defrag_skb->len + skb_tailroom(defrag_skb),
-				   DMA_TO_DEVICE);
-	if (dma_mapping_error(ab->dev, buf_paddr))
-		return -ENOMEM;
-
-	spin_lock_bh(&dp->rx_desc_lock);
-	desc_info = list_first_entry_or_null(&dp->rx_desc_free_list,
-					     struct ath12k_rx_desc_info,
-					     list);
-	if (!desc_info) {
-		spin_unlock_bh(&dp->rx_desc_lock);
-		ath12k_warn(ab, "failed to find rx desc for reinject\n");
-		ret = -ENOMEM;
-		goto err_unmap_dma;
-	}
-
-	desc_info->skb = defrag_skb;
-	desc_info->in_use = true;
-
-	list_del(&desc_info->list);
-	spin_unlock_bh(&dp->rx_desc_lock);
-
-	ATH12K_SKB_RXCB(defrag_skb)->paddr = buf_paddr;
-
-	ath12k_hal_rx_buf_addr_info_set(&msdu0->buf_addr_info, buf_paddr,
-					desc_info->cookie,
-					HAL_RX_BUF_RBM_SW3_BM);
-
-	/* Fill mpdu details into reo entrance ring */
-	srng = &ab->hal.srng_list[dp->reo_reinject_ring.ring_id];
-
-	spin_lock_bh(&srng->lock);
-	ath12k_hal_srng_access_begin(ab, srng);
-
-	reo_ent_ring = ath12k_hal_srng_src_get_next_entry(ab, srng);
-	if (!reo_ent_ring) {
-		ath12k_hal_srng_access_end(ab, srng);
-		spin_unlock_bh(&srng->lock);
-		ret = -ENOSPC;
-		goto err_free_desc;
-	}
-	memset(reo_ent_ring, 0, sizeof(*reo_ent_ring));
-
-	ath12k_hal_rx_buf_addr_info_set(&reo_ent_ring->buf_addr_info, link_paddr,
-					cookie,
-					idle_link_rbm);
-
-	mpdu_info = u32_encode_bits(1, RX_MPDU_DESC_INFO0_MSDU_COUNT) |
-		    u32_encode_bits(0, RX_MPDU_DESC_INFO0_FRAG_FLAG) |
-		    u32_encode_bits(1, RX_MPDU_DESC_INFO0_RAW_MPDU) |
-		    u32_encode_bits(1, RX_MPDU_DESC_INFO0_VALID_PN) |
-		    u32_encode_bits(rx_tid->tid, RX_MPDU_DESC_INFO0_TID);
-
-	reo_ent_ring->rx_mpdu_info.info0 = cpu_to_le32(mpdu_info);
-	reo_ent_ring->rx_mpdu_info.peer_meta_data =
-		reo_dest_ring->rx_mpdu_info.peer_meta_data;
-
-	if (ab->hw_params->reoq_lut_support) {
-		reo_ent_ring->queue_addr_lo = reo_dest_ring->rx_mpdu_info.peer_meta_data;
-		queue_addr_hi = 0;
-	} else {
-		reo_ent_ring->queue_addr_lo =
-				cpu_to_le32(lower_32_bits(rx_tid->qbuf.paddr_aligned));
-		queue_addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
-	}
-
-	reo_ent_ring->info0 = le32_encode_bits(queue_addr_hi,
-					       HAL_REO_ENTR_RING_INFO0_QUEUE_ADDR_HI) |
-			      le32_encode_bits(dst_ind,
-					       HAL_REO_ENTR_RING_INFO0_DEST_IND);
-
-	reo_ent_ring->info1 = le32_encode_bits(rx_tid->cur_sn,
-					       HAL_REO_ENTR_RING_INFO1_MPDU_SEQ_NUM);
-	dest_ring_info0 = le32_get_bits(reo_dest_ring->info0,
-					HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
-	reo_ent_ring->info2 =
-		cpu_to_le32(u32_get_bits(dest_ring_info0,
-					 HAL_REO_ENTR_RING_INFO2_SRC_LINK_ID));
-
-	ath12k_hal_srng_access_end(ab, srng);
-	spin_unlock_bh(&srng->lock);
-
-	return 0;
-
-err_free_desc:
-	spin_lock_bh(&dp->rx_desc_lock);
-	desc_info->in_use = false;
-	desc_info->skb = NULL;
-	list_add_tail(&desc_info->list, &dp->rx_desc_free_list);
-	spin_unlock_bh(&dp->rx_desc_lock);
-err_unmap_dma:
-	dma_unmap_single(ab->dev, buf_paddr, defrag_skb->len + skb_tailroom(defrag_skb),
-			 DMA_TO_DEVICE);
-	return ret;
-}
-
 static int ath12k_dp_rx_h_cmp_frags(struct ath12k_base *ab,
 				    struct sk_buff *a, struct sk_buff *b)
 {
@@ -3152,9 +2934,9 @@ static int ath12k_dp_rx_h_cmp_frags(struct ath12k_base *ab,
 	return frag1 - frag2;
 }
 
-static void ath12k_dp_rx_h_sort_frags(struct ath12k_base *ab,
-				      struct sk_buff_head *frag_list,
-				      struct sk_buff *cur_frag)
+void ath12k_dp_rx_h_sort_frags(struct ath12k_base *ab,
+			       struct sk_buff_head *frag_list,
+			       struct sk_buff *cur_frag)
 {
 	struct sk_buff *skb;
 	int cmp;
@@ -3169,7 +2951,7 @@ static void ath12k_dp_rx_h_sort_frags(struct ath12k_base *ab,
 	__skb_queue_tail(frag_list, cur_frag);
 }
 
-static u64 ath12k_dp_rx_h_get_pn(struct ath12k *ar, struct sk_buff *skb)
+u64 ath12k_dp_rx_h_get_pn(struct ath12k *ar, struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr;
 	u64 pn = 0;
@@ -3189,471 +2971,6 @@ static u64 ath12k_dp_rx_h_get_pn(struct ath12k *ar, struct sk_buff *skb)
 	return pn;
 }
 
-static bool
-ath12k_dp_rx_h_defrag_validate_incr_pn(struct ath12k *ar, struct ath12k_dp_rx_tid *rx_tid)
-{
-	struct ath12k_base *ab = ar->ab;
-	enum hal_encrypt_type encrypt_type;
-	struct sk_buff *first_frag, *skb;
-	struct hal_rx_desc *desc;
-	u64 last_pn;
-	u64 cur_pn;
-
-	first_frag = skb_peek(&rx_tid->rx_frags);
-	desc = (struct hal_rx_desc *)first_frag->data;
-
-	encrypt_type = ath12k_dp_rx_h_enctype(ab, desc);
-	if (encrypt_type != HAL_ENCRYPT_TYPE_CCMP_128 &&
-	    encrypt_type != HAL_ENCRYPT_TYPE_CCMP_256 &&
-	    encrypt_type != HAL_ENCRYPT_TYPE_GCMP_128 &&
-	    encrypt_type != HAL_ENCRYPT_TYPE_AES_GCMP_256)
-		return true;
-
-	last_pn = ath12k_dp_rx_h_get_pn(ar, first_frag);
-	skb_queue_walk(&rx_tid->rx_frags, skb) {
-		if (skb == first_frag)
-			continue;
-
-		cur_pn = ath12k_dp_rx_h_get_pn(ar, skb);
-		if (cur_pn != last_pn + 1)
-			return false;
-		last_pn = cur_pn;
-	}
-	return true;
-}
-
-static int ath12k_dp_rx_frag_h_mpdu(struct ath12k *ar,
-				    struct sk_buff *msdu,
-				    struct hal_reo_dest_ring *ring_desc)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct hal_rx_desc *rx_desc;
-	struct ath12k_peer *peer;
-	struct ath12k_dp_rx_tid *rx_tid;
-	struct sk_buff *defrag_skb = NULL;
-	u32 peer_id;
-	u16 seqno, frag_no;
-	u8 tid;
-	int ret = 0;
-	bool more_frags;
-
-	rx_desc = (struct hal_rx_desc *)msdu->data;
-	peer_id = ath12k_dp_rx_h_peer_id(ab, rx_desc);
-	tid = ath12k_dp_rx_h_tid(ab, rx_desc);
-	seqno = ath12k_dp_rx_h_seq_no(ab, rx_desc);
-	frag_no = ath12k_dp_rx_h_frag_no(ab, msdu);
-	more_frags = ath12k_dp_rx_h_more_frags(ab, msdu);
-
-	if (!ath12k_dp_rx_h_seq_ctrl_valid(ab, rx_desc) ||
-	    !ath12k_dp_rx_h_fc_valid(ab, rx_desc) ||
-	    tid > IEEE80211_NUM_TIDS)
-		return -EINVAL;
-
-	/* received unfragmented packet in reo
-	 * exception ring, this shouldn't happen
-	 * as these packets typically come from
-	 * reo2sw srngs.
-	 */
-	if (WARN_ON_ONCE(!frag_no && !more_frags))
-		return -EINVAL;
-
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_peer_find_by_id(ab, peer_id);
-	if (!peer) {
-		ath12k_warn(ab, "failed to find the peer to de-fragment received fragment peer_id %d\n",
-			    peer_id);
-		ret = -ENOENT;
-		goto out_unlock;
-	}
-
-	if (!peer->dp_setup_done) {
-		ath12k_warn(ab, "The peer %pM [%d] has uninitialized datapath\n",
-			    peer->addr, peer_id);
-		ret = -ENOENT;
-		goto out_unlock;
-	}
-
-	rx_tid = &peer->rx_tid[tid];
-
-	if ((!skb_queue_empty(&rx_tid->rx_frags) && seqno != rx_tid->cur_sn) ||
-	    skb_queue_empty(&rx_tid->rx_frags)) {
-		/* Flush stored fragments and start a new sequence */
-		ath12k_dp_rx_frags_cleanup(rx_tid, true);
-		rx_tid->cur_sn = seqno;
-	}
-
-	if (rx_tid->rx_frag_bitmap & BIT(frag_no)) {
-		/* Fragment already present */
-		ret = -EINVAL;
-		goto out_unlock;
-	}
-
-	if ((!rx_tid->rx_frag_bitmap || frag_no > __fls(rx_tid->rx_frag_bitmap)))
-		__skb_queue_tail(&rx_tid->rx_frags, msdu);
-	else
-		ath12k_dp_rx_h_sort_frags(ab, &rx_tid->rx_frags, msdu);
-
-	rx_tid->rx_frag_bitmap |= BIT(frag_no);
-	if (!more_frags)
-		rx_tid->last_frag_no = frag_no;
-
-	if (frag_no == 0) {
-		rx_tid->dst_ring_desc = kmemdup(ring_desc,
-						sizeof(*rx_tid->dst_ring_desc),
-						GFP_ATOMIC);
-		if (!rx_tid->dst_ring_desc) {
-			ret = -ENOMEM;
-			goto out_unlock;
-		}
-	} else {
-		ath12k_dp_rx_link_desc_return(ab, &ring_desc->buf_addr_info,
-					      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
-	}
-
-	if (!rx_tid->last_frag_no ||
-	    rx_tid->rx_frag_bitmap != GENMASK(rx_tid->last_frag_no, 0)) {
-		mod_timer(&rx_tid->frag_timer, jiffies +
-					       ATH12K_DP_RX_FRAGMENT_TIMEOUT_MS);
-		goto out_unlock;
-	}
-
-	spin_unlock_bh(&ab->base_lock);
-	timer_delete_sync(&rx_tid->frag_timer);
-	spin_lock_bh(&ab->base_lock);
-
-	peer = ath12k_peer_find_by_id(ab, peer_id);
-	if (!peer)
-		goto err_frags_cleanup;
-
-	if (!ath12k_dp_rx_h_defrag_validate_incr_pn(ar, rx_tid))
-		goto err_frags_cleanup;
-
-	if (ath12k_dp_rx_h_defrag(ar, peer, rx_tid, &defrag_skb))
-		goto err_frags_cleanup;
-
-	if (!defrag_skb)
-		goto err_frags_cleanup;
-
-	if (ath12k_dp_rx_h_defrag_reo_reinject(ar, rx_tid, defrag_skb))
-		goto err_frags_cleanup;
-
-	ath12k_dp_rx_frags_cleanup(rx_tid, false);
-	goto out_unlock;
-
-err_frags_cleanup:
-	dev_kfree_skb_any(defrag_skb);
-	ath12k_dp_rx_frags_cleanup(rx_tid, true);
-out_unlock:
-	spin_unlock_bh(&ab->base_lock);
-	return ret;
-}
-
-static int
-ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
-			     struct list_head *used_list,
-			     bool drop, u32 cookie)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct sk_buff *msdu;
-	struct ath12k_skb_rxcb *rxcb;
-	struct hal_rx_desc *rx_desc;
-	u16 msdu_len;
-	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
-	struct ath12k_rx_desc_info *desc_info;
-	u64 desc_va;
-
-	desc_va = ((u64)le32_to_cpu(desc->buf_va_hi) << 32 |
-		   le32_to_cpu(desc->buf_va_lo));
-	desc_info = (struct ath12k_rx_desc_info *)((unsigned long)desc_va);
-
-	/* retry manual desc retrieval */
-	if (!desc_info) {
-		desc_info = ath12k_dp_get_rx_desc(ab, cookie);
-		if (!desc_info) {
-			ath12k_warn(ab, "Invalid cookie in DP rx error descriptor retrieval: 0x%x\n",
-				    cookie);
-			return -EINVAL;
-		}
-	}
-
-	if (desc_info->magic != ATH12K_DP_RX_DESC_MAGIC)
-		ath12k_warn(ab, " RX Exception, Check HW CC implementation");
-
-	msdu = desc_info->skb;
-	desc_info->skb = NULL;
-
-	list_add_tail(&desc_info->list, used_list);
-
-	rxcb = ATH12K_SKB_RXCB(msdu);
-	dma_unmap_single(ar->ab->dev, rxcb->paddr,
-			 msdu->len + skb_tailroom(msdu),
-			 DMA_FROM_DEVICE);
-
-	if (drop) {
-		dev_kfree_skb_any(msdu);
-		return 0;
-	}
-
-	rcu_read_lock();
-	if (!rcu_dereference(ar->ab->pdevs_active[ar->pdev_idx])) {
-		dev_kfree_skb_any(msdu);
-		goto exit;
-	}
-
-	if (test_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags)) {
-		dev_kfree_skb_any(msdu);
-		goto exit;
-	}
-
-	rx_desc = (struct hal_rx_desc *)msdu->data;
-	msdu_len = ath12k_dp_rx_h_msdu_len(ar->ab, rx_desc);
-	if ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE) {
-		ath12k_warn(ar->ab, "invalid msdu leng %u", msdu_len);
-		ath12k_dbg_dump(ar->ab, ATH12K_DBG_DATA, NULL, "", rx_desc,
-				sizeof(*rx_desc));
-		dev_kfree_skb_any(msdu);
-		goto exit;
-	}
-
-	skb_put(msdu, hal_rx_desc_sz + msdu_len);
-
-	if (ath12k_dp_rx_frag_h_mpdu(ar, msdu, desc)) {
-		dev_kfree_skb_any(msdu);
-		ath12k_dp_rx_link_desc_return(ar->ab, &desc->buf_addr_info,
-					      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
-	}
-exit:
-	rcu_read_unlock();
-	return 0;
-}
-
-int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
-			     int budget)
-{
-	struct ath12k_hw_group *ag = ab->ag;
-	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
-	u32 msdu_cookies[HAL_NUM_RX_MSDUS_PER_LINK_DESC];
-	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
-	struct dp_link_desc_bank *link_desc_banks;
-	enum hal_rx_buf_return_buf_manager rbm;
-	struct hal_rx_msdu_link *link_desc_va;
-	int tot_n_bufs_reaped, quota, ret, i;
-	struct hal_reo_dest_ring *reo_desc;
-	struct dp_rxdma_ring *rx_ring;
-	struct dp_srng *reo_except;
-	struct ath12k_hw_link *hw_links = ag->hw_links;
-	struct ath12k_base *partner_ab;
-	u8 hw_link_id, device_id;
-	u32 desc_bank, num_msdus;
-	struct hal_srng *srng;
-	struct ath12k *ar;
-	dma_addr_t paddr;
-	bool is_frag;
-	bool drop;
-	int pdev_id;
-
-	tot_n_bufs_reaped = 0;
-	quota = budget;
-
-	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++)
-		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
-
-	reo_except = &ab->dp.reo_except_ring;
-
-	srng = &ab->hal.srng_list[reo_except->ring_id];
-
-	spin_lock_bh(&srng->lock);
-
-	ath12k_hal_srng_access_begin(ab, srng);
-
-	while (budget &&
-	       (reo_desc = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
-		drop = false;
-		ab->device_stats.err_ring_pkts++;
-
-		ret = ath12k_hal_desc_reo_parse_err(ab, reo_desc, &paddr,
-						    &desc_bank);
-		if (ret) {
-			ath12k_warn(ab, "failed to parse error reo desc %d\n",
-				    ret);
-			continue;
-		}
-
-		hw_link_id = le32_get_bits(reo_desc->info0,
-					   HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
-		device_id = hw_links[hw_link_id].device_id;
-		partner_ab = ath12k_ag_to_ab(ag, device_id);
-
-		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
-						      hw_links[hw_link_id].pdev_idx);
-		ar = partner_ab->pdevs[pdev_id].ar;
-
-		link_desc_banks = partner_ab->dp.link_desc_banks;
-		link_desc_va = link_desc_banks[desc_bank].vaddr +
-			       (paddr - link_desc_banks[desc_bank].paddr);
-		ath12k_hal_rx_msdu_link_info_get(link_desc_va, &num_msdus, msdu_cookies,
-						 &rbm);
-		if (rbm != partner_ab->dp.idle_link_rbm &&
-		    rbm != HAL_RX_BUF_RBM_SW3_BM &&
-		    rbm != partner_ab->hw_params->hal_params->rx_buf_rbm) {
-			ab->device_stats.invalid_rbm++;
-			ath12k_warn(ab, "invalid return buffer manager %d\n", rbm);
-			ath12k_dp_rx_link_desc_return(partner_ab,
-						      &reo_desc->buf_addr_info,
-						      HAL_WBM_REL_BM_ACT_REL_MSDU);
-			continue;
-		}
-
-		is_frag = !!(le32_to_cpu(reo_desc->rx_mpdu_info.info0) &
-			     RX_MPDU_DESC_INFO0_FRAG_FLAG);
-
-		/* Process only rx fragments with one msdu per link desc below, and drop
-		 * msdu's indicated due to error reasons.
-		 * Dynamic fragmentation not supported in Multi-link client, so drop the
-		 * partner device buffers.
-		 */
-		if (!is_frag || num_msdus > 1 ||
-		    partner_ab->device_id != ab->device_id) {
-			drop = true;
-
-			/* Return the link desc back to wbm idle list */
-			ath12k_dp_rx_link_desc_return(partner_ab,
-						      &reo_desc->buf_addr_info,
-						      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
-		}
-
-		for (i = 0; i < num_msdus; i++) {
-			if (!ath12k_dp_process_rx_err_buf(ar, reo_desc,
-							  &rx_desc_used_list[device_id],
-							  drop,
-							  msdu_cookies[i])) {
-				num_buffs_reaped[device_id]++;
-				tot_n_bufs_reaped++;
-			}
-		}
-
-		if (tot_n_bufs_reaped >= quota) {
-			tot_n_bufs_reaped = quota;
-			goto exit;
-		}
-
-		budget = quota - tot_n_bufs_reaped;
-	}
-
-exit:
-	ath12k_hal_srng_access_end(ab, srng);
-
-	spin_unlock_bh(&srng->lock);
-
-	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++) {
-		if (!num_buffs_reaped[device_id])
-			continue;
-
-		partner_ab = ath12k_ag_to_ab(ag, device_id);
-		rx_ring = &partner_ab->dp.rx_refill_buf_ring;
-
-		ath12k_dp_rx_bufs_replenish(partner_ab, rx_ring,
-					    &rx_desc_used_list[device_id],
-					    num_buffs_reaped[device_id]);
-	}
-
-	return tot_n_bufs_reaped;
-}
-
-static void ath12k_dp_rx_null_q_desc_sg_drop(struct ath12k *ar,
-					     int msdu_len,
-					     struct sk_buff_head *msdu_list)
-{
-	struct sk_buff *skb, *tmp;
-	struct ath12k_skb_rxcb *rxcb;
-	int n_buffs;
-
-	n_buffs = DIV_ROUND_UP(msdu_len,
-			       (DP_RX_BUFFER_SIZE - ar->ab->hal.hal_desc_sz));
-
-	skb_queue_walk_safe(msdu_list, skb, tmp) {
-		rxcb = ATH12K_SKB_RXCB(skb);
-		if (rxcb->err_rel_src == HAL_WBM_REL_SRC_MODULE_REO &&
-		    rxcb->err_code == HAL_REO_DEST_RING_ERROR_CODE_DESC_ADDR_ZERO) {
-			if (!n_buffs)
-				break;
-			__skb_unlink(skb, msdu_list);
-			dev_kfree_skb_any(skb);
-			n_buffs--;
-		}
-	}
-}
-
-int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
-			       struct ath12k_dp_rx_info *rx_info,
-			       struct sk_buff_head *msdu_list)
-{
-	struct ath12k_base *ab = ar->ab;
-	u16 msdu_len;
-	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
-	u8 l3pad_bytes;
-	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
-
-	msdu_len = ath12k_dp_rx_h_msdu_len(ab, desc);
-
-	if (!rxcb->is_frag && ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE)) {
-		/* First buffer will be freed by the caller, so deduct it's length */
-		msdu_len = msdu_len - (DP_RX_BUFFER_SIZE - hal_rx_desc_sz);
-		ath12k_dp_rx_null_q_desc_sg_drop(ar, msdu_len, msdu_list);
-		return -EINVAL;
-	}
-
-	/* Even after cleaning up the sg buffers in the msdu list with above check
-	 * any msdu received with continuation flag needs to be dropped as invalid.
-	 * This protects against some random err frame with continuation flag.
-	 */
-	if (rxcb->is_continuation)
-		return -EINVAL;
-
-	if (!ath12k_dp_rx_h_msdu_done(ab, desc)) {
-		ath12k_warn(ar->ab,
-			    "msdu_done bit not set in null_q_des processing\n");
-		__skb_queue_purge(msdu_list);
-		return -EIO;
-	}
-
-	/* Handle NULL queue descriptor violations arising out a missing
-	 * REO queue for a given peer or a given TID. This typically
-	 * may happen if a packet is received on a QOS enabled TID before the
-	 * ADDBA negotiation for that TID, when the TID queue is setup. Or
-	 * it may also happen for MC/BC frames if they are not routed to the
-	 * non-QOS TID queue, in the absence of any other default TID queue.
-	 * This error can show up both in a REO destination or WBM release ring.
-	 */
-
-	if (rxcb->is_frag) {
-		skb_pull(msdu, hal_rx_desc_sz);
-	} else {
-		l3pad_bytes = ath12k_dp_rx_h_l3pad(ab, desc);
-
-		if ((hal_rx_desc_sz + l3pad_bytes + msdu_len) > DP_RX_BUFFER_SIZE)
-			return -EINVAL;
-
-		skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
-		skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
-	}
-	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
-		return -EINVAL;
-
-	ath12k_dp_rx_h_fetch_info(ab, desc, rx_info);
-	ath12k_dp_rx_h_ppdu(ar, rx_info);
-	ath12k_dp_rx_h_mpdu(ar, msdu, desc, rx_info);
-
-	rxcb->tid = rx_info->tid;
-
-	/* Please note that caller will having the access to msdu and completing
-	 * rx with mac80211. Need not worry about cleaning up amsdu_list.
-	 */
-
-	return 0;
-}
-
 void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 542f08efe0cd..dc0b1078213c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -45,6 +45,8 @@ struct ath12k_dp_rx_reo_cmd {
 			enum hal_reo_cmd_status status);
 };
 
+#define ATH12K_DP_RX_FRAGMENT_TIMEOUT_MS (2 * HZ)
+
 #define ATH12K_DP_RX_REO_DESC_FREE_THRES  64
 #define ATH12K_DP_RX_REO_DESC_FREE_TIMEOUT_MS 1000
 
@@ -351,9 +353,20 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
 bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
 					    struct hal_rx_desc *rx_desc,
 					    struct sk_buff *msdu);
-int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
-			       struct ath12k_dp_rx_info *rx_info,
-			       struct sk_buff_head *msdu_list);
+void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
+			 struct sk_buff *msdu,
+			 struct hal_rx_desc *rx_desc,
+			 struct ath12k_dp_rx_info *rx_info);
+u64 ath12k_dp_rx_h_get_pn(struct ath12k *ar, struct sk_buff *skb);
+void ath12k_dp_rx_h_sort_frags(struct ath12k_base *ab,
+			       struct sk_buff_head *frag_list,
+			       struct sk_buff *cur_frag);
+void ath12k_dp_rx_h_undecap_frag(struct ath12k *ar, struct sk_buff *msdu,
+				 enum hal_encrypt_type enctype, u32 flags);
+int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer *peer,
+				   struct sk_buff *msdu);
+void ath12k_dp_rx_frags_cleanup(struct ath12k_dp_rx_tid *rx_tid,
+				bool rel_link_desc);
 int ath12k_dp_rx_ampdu_start(struct ath12k *ar,
 			     struct ieee80211_ampdu_params *params,
 			     u8 link_id);
@@ -381,8 +394,6 @@ int ath12k_dp_rx_pdev_alloc(struct ath12k_base *ab, int pdev_idx);
 void ath12k_dp_rx_pdev_free(struct ath12k_base *ab, int pdev_idx);
 void ath12k_dp_rx_reo_cmd_list_cleanup(struct ath12k_base *ab);
 void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab);
-int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
-			     int budget);
 int ath12k_dp_rx_process(struct ath12k_base *ab, int mac_id,
 			 struct napi_struct *napi,
 			 int budget);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index a002e3839fff..c2b108a1005b 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -6,6 +6,688 @@
 
 #include "dp_rx.h"
 #include "../dp_tx.h"
+#include "../peer.h"
+
+static bool
+ath12k_dp_rx_h_defrag_validate_incr_pn(struct ath12k *ar, struct ath12k_dp_rx_tid *rx_tid)
+{
+	struct ath12k_base *ab = ar->ab;
+	enum hal_encrypt_type encrypt_type;
+	struct sk_buff *first_frag, *skb;
+	struct hal_rx_desc *desc;
+	u64 last_pn;
+	u64 cur_pn;
+
+	first_frag = skb_peek(&rx_tid->rx_frags);
+	desc = (struct hal_rx_desc *)first_frag->data;
+
+	encrypt_type = ath12k_dp_rx_h_enctype(ab, desc);
+	if (encrypt_type != HAL_ENCRYPT_TYPE_CCMP_128 &&
+	    encrypt_type != HAL_ENCRYPT_TYPE_CCMP_256 &&
+	    encrypt_type != HAL_ENCRYPT_TYPE_GCMP_128 &&
+	    encrypt_type != HAL_ENCRYPT_TYPE_AES_GCMP_256)
+		return true;
+
+	last_pn = ath12k_dp_rx_h_get_pn(ar, first_frag);
+	skb_queue_walk(&rx_tid->rx_frags, skb) {
+		if (skb == first_frag)
+			continue;
+
+		cur_pn = ath12k_dp_rx_h_get_pn(ar, skb);
+		if (cur_pn != last_pn + 1)
+			return false;
+		last_pn = cur_pn;
+	}
+	return true;
+}
+
+static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
+					      struct ath12k_dp_rx_tid *rx_tid,
+					      struct sk_buff *defrag_skb)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = &ab->dp;
+	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)defrag_skb->data;
+	struct hal_reo_entrance_ring *reo_ent_ring;
+	struct hal_reo_dest_ring *reo_dest_ring;
+	struct dp_link_desc_bank *link_desc_banks;
+	struct hal_rx_msdu_link *msdu_link;
+	struct hal_rx_msdu_details *msdu0;
+	struct hal_srng *srng;
+	dma_addr_t link_paddr, buf_paddr;
+	u32 desc_bank, msdu_info, msdu_ext_info, mpdu_info;
+	u32 cookie, hal_rx_desc_sz, dest_ring_info0, queue_addr_hi;
+	int ret;
+	struct ath12k_rx_desc_info *desc_info;
+	enum hal_rx_buf_return_buf_manager idle_link_rbm = dp->idle_link_rbm;
+	u8 dst_ind;
+
+	hal_rx_desc_sz = ab->hal.hal_desc_sz;
+	link_desc_banks = dp->link_desc_banks;
+	reo_dest_ring = rx_tid->dst_ring_desc;
+
+	ath12k_hal_rx_reo_ent_paddr_get(ab, &reo_dest_ring->buf_addr_info,
+					&link_paddr, &cookie);
+	desc_bank = u32_get_bits(cookie, DP_LINK_DESC_BANK_MASK);
+
+	msdu_link = (struct hal_rx_msdu_link *)(link_desc_banks[desc_bank].vaddr +
+			(link_paddr - link_desc_banks[desc_bank].paddr));
+	msdu0 = &msdu_link->msdu_link[0];
+	msdu_ext_info = le32_to_cpu(msdu0->rx_msdu_ext_info.info0);
+	dst_ind = u32_get_bits(msdu_ext_info, RX_MSDU_EXT_DESC_INFO0_REO_DEST_IND);
+
+	memset(msdu0, 0, sizeof(*msdu0));
+
+	msdu_info = u32_encode_bits(1, RX_MSDU_DESC_INFO0_FIRST_MSDU_IN_MPDU) |
+		    u32_encode_bits(1, RX_MSDU_DESC_INFO0_LAST_MSDU_IN_MPDU) |
+		    u32_encode_bits(0, RX_MSDU_DESC_INFO0_MSDU_CONTINUATION) |
+		    u32_encode_bits(defrag_skb->len - hal_rx_desc_sz,
+				    RX_MSDU_DESC_INFO0_MSDU_LENGTH) |
+		    u32_encode_bits(1, RX_MSDU_DESC_INFO0_VALID_SA) |
+		    u32_encode_bits(1, RX_MSDU_DESC_INFO0_VALID_DA);
+	msdu0->rx_msdu_info.info0 = cpu_to_le32(msdu_info);
+	msdu0->rx_msdu_ext_info.info0 = cpu_to_le32(msdu_ext_info);
+
+	/* change msdu len in hal rx desc */
+	ath12k_dp_rxdesc_set_msdu_len(ab, rx_desc, defrag_skb->len - hal_rx_desc_sz);
+
+	buf_paddr = dma_map_single(ab->dev, defrag_skb->data,
+				   defrag_skb->len + skb_tailroom(defrag_skb),
+				   DMA_TO_DEVICE);
+	if (dma_mapping_error(ab->dev, buf_paddr))
+		return -ENOMEM;
+
+	spin_lock_bh(&dp->rx_desc_lock);
+	desc_info = list_first_entry_or_null(&dp->rx_desc_free_list,
+					     struct ath12k_rx_desc_info,
+					     list);
+	if (!desc_info) {
+		spin_unlock_bh(&dp->rx_desc_lock);
+		ath12k_warn(ab, "failed to find rx desc for reinject\n");
+		ret = -ENOMEM;
+		goto err_unmap_dma;
+	}
+
+	desc_info->skb = defrag_skb;
+	desc_info->in_use = true;
+
+	list_del(&desc_info->list);
+	spin_unlock_bh(&dp->rx_desc_lock);
+
+	ATH12K_SKB_RXCB(defrag_skb)->paddr = buf_paddr;
+
+	ath12k_hal_rx_buf_addr_info_set(&msdu0->buf_addr_info, buf_paddr,
+					desc_info->cookie,
+					HAL_RX_BUF_RBM_SW3_BM);
+
+	/* Fill mpdu details into reo entrance ring */
+	srng = &ab->hal.srng_list[dp->reo_reinject_ring.ring_id];
+
+	spin_lock_bh(&srng->lock);
+	ath12k_hal_srng_access_begin(ab, srng);
+
+	reo_ent_ring = ath12k_hal_srng_src_get_next_entry(ab, srng);
+	if (!reo_ent_ring) {
+		ath12k_hal_srng_access_end(ab, srng);
+		spin_unlock_bh(&srng->lock);
+		ret = -ENOSPC;
+		goto err_free_desc;
+	}
+	memset(reo_ent_ring, 0, sizeof(*reo_ent_ring));
+
+	ath12k_hal_rx_buf_addr_info_set(&reo_ent_ring->buf_addr_info, link_paddr,
+					cookie,
+					idle_link_rbm);
+
+	mpdu_info = u32_encode_bits(1, RX_MPDU_DESC_INFO0_MSDU_COUNT) |
+		    u32_encode_bits(0, RX_MPDU_DESC_INFO0_FRAG_FLAG) |
+		    u32_encode_bits(1, RX_MPDU_DESC_INFO0_RAW_MPDU) |
+		    u32_encode_bits(1, RX_MPDU_DESC_INFO0_VALID_PN) |
+		    u32_encode_bits(rx_tid->tid, RX_MPDU_DESC_INFO0_TID);
+
+	reo_ent_ring->rx_mpdu_info.info0 = cpu_to_le32(mpdu_info);
+	reo_ent_ring->rx_mpdu_info.peer_meta_data =
+		reo_dest_ring->rx_mpdu_info.peer_meta_data;
+
+	if (ab->hw_params->reoq_lut_support) {
+		reo_ent_ring->queue_addr_lo = reo_dest_ring->rx_mpdu_info.peer_meta_data;
+		queue_addr_hi = 0;
+	} else {
+		reo_ent_ring->queue_addr_lo =
+				cpu_to_le32(lower_32_bits(rx_tid->qbuf.paddr_aligned));
+		queue_addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
+	}
+
+	reo_ent_ring->info0 = le32_encode_bits(queue_addr_hi,
+					       HAL_REO_ENTR_RING_INFO0_QUEUE_ADDR_HI) |
+			      le32_encode_bits(dst_ind,
+					       HAL_REO_ENTR_RING_INFO0_DEST_IND);
+
+	reo_ent_ring->info1 = le32_encode_bits(rx_tid->cur_sn,
+					       HAL_REO_ENTR_RING_INFO1_MPDU_SEQ_NUM);
+	dest_ring_info0 = le32_get_bits(reo_dest_ring->info0,
+					HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
+	reo_ent_ring->info2 =
+		cpu_to_le32(u32_get_bits(dest_ring_info0,
+					 HAL_REO_ENTR_RING_INFO2_SRC_LINK_ID));
+
+	ath12k_hal_srng_access_end(ab, srng);
+	spin_unlock_bh(&srng->lock);
+
+	return 0;
+
+err_free_desc:
+	spin_lock_bh(&dp->rx_desc_lock);
+	desc_info->in_use = false;
+	desc_info->skb = NULL;
+	list_add_tail(&desc_info->list, &dp->rx_desc_free_list);
+	spin_unlock_bh(&dp->rx_desc_lock);
+err_unmap_dma:
+	dma_unmap_single(ab->dev, buf_paddr, defrag_skb->len + skb_tailroom(defrag_skb),
+			 DMA_TO_DEVICE);
+	return ret;
+}
+
+static int ath12k_dp_rx_h_defrag(struct ath12k *ar,
+				 struct ath12k_peer *peer,
+				 struct ath12k_dp_rx_tid *rx_tid,
+				 struct sk_buff **defrag_skb)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct hal_rx_desc *rx_desc;
+	struct sk_buff *skb, *first_frag, *last_frag;
+	struct ieee80211_hdr *hdr;
+	enum hal_encrypt_type enctype;
+	bool is_decrypted = false;
+	int msdu_len = 0;
+	int extra_space;
+	u32 flags, hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
+
+	first_frag = skb_peek(&rx_tid->rx_frags);
+	last_frag = skb_peek_tail(&rx_tid->rx_frags);
+
+	skb_queue_walk(&rx_tid->rx_frags, skb) {
+		flags = 0;
+		rx_desc = (struct hal_rx_desc *)skb->data;
+		hdr = (struct ieee80211_hdr *)(skb->data + hal_rx_desc_sz);
+
+		enctype = ath12k_dp_rx_h_enctype(ab, rx_desc);
+		if (enctype != HAL_ENCRYPT_TYPE_OPEN)
+			is_decrypted = ath12k_dp_rx_h_is_decrypted(ab,
+								   rx_desc);
+
+		if (is_decrypted) {
+			if (skb != first_frag)
+				flags |= RX_FLAG_IV_STRIPPED;
+			if (skb != last_frag)
+				flags |= RX_FLAG_ICV_STRIPPED |
+					 RX_FLAG_MIC_STRIPPED;
+		}
+
+		/* RX fragments are always raw packets */
+		if (skb != last_frag)
+			skb_trim(skb, skb->len - FCS_LEN);
+		ath12k_dp_rx_h_undecap_frag(ar, skb, enctype, flags);
+
+		if (skb != first_frag)
+			skb_pull(skb, hal_rx_desc_sz +
+				      ieee80211_hdrlen(hdr->frame_control));
+		msdu_len += skb->len;
+	}
+
+	extra_space = msdu_len - (DP_RX_BUFFER_SIZE + skb_tailroom(first_frag));
+	if (extra_space > 0 &&
+	    (pskb_expand_head(first_frag, 0, extra_space, GFP_ATOMIC) < 0))
+		return -ENOMEM;
+
+	__skb_unlink(first_frag, &rx_tid->rx_frags);
+	while ((skb = __skb_dequeue(&rx_tid->rx_frags))) {
+		skb_put_data(first_frag, skb->data, skb->len);
+		dev_kfree_skb_any(skb);
+	}
+
+	hdr = (struct ieee80211_hdr *)(first_frag->data + hal_rx_desc_sz);
+	hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_MOREFRAGS);
+	ATH12K_SKB_RXCB(first_frag)->is_frag = 1;
+
+	if (ath12k_dp_rx_h_verify_tkip_mic(ar, peer, first_frag))
+		first_frag = NULL;
+
+	*defrag_skb = first_frag;
+	return 0;
+}
+
+static int ath12k_dp_rx_frag_h_mpdu(struct ath12k *ar,
+				    struct sk_buff *msdu,
+				    struct hal_reo_dest_ring *ring_desc)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct hal_rx_desc *rx_desc;
+	struct ath12k_peer *peer;
+	struct ath12k_dp_rx_tid *rx_tid;
+	struct sk_buff *defrag_skb = NULL;
+	u32 peer_id;
+	u16 seqno, frag_no;
+	u8 tid;
+	int ret = 0;
+	bool more_frags;
+
+	rx_desc = (struct hal_rx_desc *)msdu->data;
+	peer_id = ath12k_dp_rx_h_peer_id(ab, rx_desc);
+	tid = ath12k_dp_rx_h_tid(ab, rx_desc);
+	seqno = ath12k_dp_rx_h_seq_no(ab, rx_desc);
+	frag_no = ath12k_dp_rx_h_frag_no(ab, msdu);
+	more_frags = ath12k_dp_rx_h_more_frags(ab, msdu);
+
+	if (!ath12k_dp_rx_h_seq_ctrl_valid(ab, rx_desc) ||
+	    !ath12k_dp_rx_h_fc_valid(ab, rx_desc) ||
+	    tid > IEEE80211_NUM_TIDS)
+		return -EINVAL;
+
+	/* received unfragmented packet in reo
+	 * exception ring, this shouldn't happen
+	 * as these packets typically come from
+	 * reo2sw srngs.
+	 */
+	if (WARN_ON_ONCE(!frag_no && !more_frags))
+		return -EINVAL;
+
+	spin_lock_bh(&ab->base_lock);
+	peer = ath12k_peer_find_by_id(ab, peer_id);
+	if (!peer) {
+		ath12k_warn(ab, "failed to find the peer to de-fragment received fragment peer_id %d\n",
+			    peer_id);
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	if (!peer->dp_setup_done) {
+		ath12k_warn(ab, "The peer %pM [%d] has uninitialized datapath\n",
+			    peer->addr, peer_id);
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	rx_tid = &peer->rx_tid[tid];
+
+	if ((!skb_queue_empty(&rx_tid->rx_frags) && seqno != rx_tid->cur_sn) ||
+	    skb_queue_empty(&rx_tid->rx_frags)) {
+		/* Flush stored fragments and start a new sequence */
+		ath12k_dp_rx_frags_cleanup(rx_tid, true);
+		rx_tid->cur_sn = seqno;
+	}
+
+	if (rx_tid->rx_frag_bitmap & BIT(frag_no)) {
+		/* Fragment already present */
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if ((!rx_tid->rx_frag_bitmap || frag_no > __fls(rx_tid->rx_frag_bitmap)))
+		__skb_queue_tail(&rx_tid->rx_frags, msdu);
+	else
+		ath12k_dp_rx_h_sort_frags(ab, &rx_tid->rx_frags, msdu);
+
+	rx_tid->rx_frag_bitmap |= BIT(frag_no);
+	if (!more_frags)
+		rx_tid->last_frag_no = frag_no;
+
+	if (frag_no == 0) {
+		rx_tid->dst_ring_desc = kmemdup(ring_desc,
+						sizeof(*rx_tid->dst_ring_desc),
+						GFP_ATOMIC);
+		if (!rx_tid->dst_ring_desc) {
+			ret = -ENOMEM;
+			goto out_unlock;
+		}
+	} else {
+		ath12k_dp_rx_link_desc_return(ab, &ring_desc->buf_addr_info,
+					      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+	}
+
+	if (!rx_tid->last_frag_no ||
+	    rx_tid->rx_frag_bitmap != GENMASK(rx_tid->last_frag_no, 0)) {
+		mod_timer(&rx_tid->frag_timer, jiffies +
+					       ATH12K_DP_RX_FRAGMENT_TIMEOUT_MS);
+		goto out_unlock;
+	}
+
+	spin_unlock_bh(&ab->base_lock);
+	timer_delete_sync(&rx_tid->frag_timer);
+	spin_lock_bh(&ab->base_lock);
+
+	peer = ath12k_peer_find_by_id(ab, peer_id);
+	if (!peer)
+		goto err_frags_cleanup;
+
+	if (!ath12k_dp_rx_h_defrag_validate_incr_pn(ar, rx_tid))
+		goto err_frags_cleanup;
+
+	if (ath12k_dp_rx_h_defrag(ar, peer, rx_tid, &defrag_skb))
+		goto err_frags_cleanup;
+
+	if (!defrag_skb)
+		goto err_frags_cleanup;
+
+	if (ath12k_dp_rx_h_defrag_reo_reinject(ar, rx_tid, defrag_skb))
+		goto err_frags_cleanup;
+
+	ath12k_dp_rx_frags_cleanup(rx_tid, false);
+	goto out_unlock;
+
+err_frags_cleanup:
+	dev_kfree_skb_any(defrag_skb);
+	ath12k_dp_rx_frags_cleanup(rx_tid, true);
+out_unlock:
+	spin_unlock_bh(&ab->base_lock);
+	return ret;
+}
+
+static int
+ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
+			     struct list_head *used_list,
+			     bool drop, u32 cookie)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct sk_buff *msdu;
+	struct ath12k_skb_rxcb *rxcb;
+	struct hal_rx_desc *rx_desc;
+	u16 msdu_len;
+	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
+	struct ath12k_rx_desc_info *desc_info;
+	u64 desc_va;
+
+	desc_va = ((u64)le32_to_cpu(desc->buf_va_hi) << 32 |
+		   le32_to_cpu(desc->buf_va_lo));
+	desc_info = (struct ath12k_rx_desc_info *)((unsigned long)desc_va);
+
+	/* retry manual desc retrieval */
+	if (!desc_info) {
+		desc_info = ath12k_dp_get_rx_desc(ab, cookie);
+		if (!desc_info) {
+			ath12k_warn(ab, "Invalid cookie in DP rx error descriptor retrieval: 0x%x\n",
+				    cookie);
+			return -EINVAL;
+		}
+	}
+
+	if (desc_info->magic != ATH12K_DP_RX_DESC_MAGIC)
+		ath12k_warn(ab, " RX Exception, Check HW CC implementation");
+
+	msdu = desc_info->skb;
+	desc_info->skb = NULL;
+
+	list_add_tail(&desc_info->list, used_list);
+
+	rxcb = ATH12K_SKB_RXCB(msdu);
+	dma_unmap_single(ar->ab->dev, rxcb->paddr,
+			 msdu->len + skb_tailroom(msdu),
+			 DMA_FROM_DEVICE);
+
+	if (drop) {
+		dev_kfree_skb_any(msdu);
+		return 0;
+	}
+
+	rcu_read_lock();
+	if (!rcu_dereference(ar->ab->pdevs_active[ar->pdev_idx])) {
+		dev_kfree_skb_any(msdu);
+		goto exit;
+	}
+
+	if (test_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags)) {
+		dev_kfree_skb_any(msdu);
+		goto exit;
+	}
+
+	rx_desc = (struct hal_rx_desc *)msdu->data;
+	msdu_len = ath12k_dp_rx_h_msdu_len(ar->ab, rx_desc);
+	if ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE) {
+		ath12k_warn(ar->ab, "invalid msdu leng %u", msdu_len);
+		ath12k_dbg_dump(ar->ab, ATH12K_DBG_DATA, NULL, "", rx_desc,
+				sizeof(*rx_desc));
+		dev_kfree_skb_any(msdu);
+		goto exit;
+	}
+
+	skb_put(msdu, hal_rx_desc_sz + msdu_len);
+
+	if (ath12k_dp_rx_frag_h_mpdu(ar, msdu, desc)) {
+		dev_kfree_skb_any(msdu);
+		ath12k_dp_rx_link_desc_return(ar->ab, &desc->buf_addr_info,
+					      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+	}
+exit:
+	rcu_read_unlock();
+	return 0;
+}
+
+int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
+			     int budget)
+{
+	struct ath12k_hw_group *ag = ab->ag;
+	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
+	u32 msdu_cookies[HAL_NUM_RX_MSDUS_PER_LINK_DESC];
+	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
+	struct dp_link_desc_bank *link_desc_banks;
+	enum hal_rx_buf_return_buf_manager rbm;
+	struct hal_rx_msdu_link *link_desc_va;
+	int tot_n_bufs_reaped, quota, ret, i;
+	struct hal_reo_dest_ring *reo_desc;
+	struct dp_rxdma_ring *rx_ring;
+	struct dp_srng *reo_except;
+	struct ath12k_hw_link *hw_links = ag->hw_links;
+	struct ath12k_base *partner_ab;
+	u8 hw_link_id, device_id;
+	u32 desc_bank, num_msdus;
+	struct hal_srng *srng;
+	struct ath12k *ar;
+	dma_addr_t paddr;
+	bool is_frag;
+	bool drop;
+	int pdev_id;
+
+	tot_n_bufs_reaped = 0;
+	quota = budget;
+
+	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++)
+		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
+
+	reo_except = &ab->dp.reo_except_ring;
+
+	srng = &ab->hal.srng_list[reo_except->ring_id];
+
+	spin_lock_bh(&srng->lock);
+
+	ath12k_hal_srng_access_begin(ab, srng);
+
+	while (budget &&
+	       (reo_desc = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
+		drop = false;
+		ab->device_stats.err_ring_pkts++;
+
+		ret = ath12k_hal_desc_reo_parse_err(ab, reo_desc, &paddr,
+						    &desc_bank);
+		if (ret) {
+			ath12k_warn(ab, "failed to parse error reo desc %d\n",
+				    ret);
+			continue;
+		}
+
+		hw_link_id = le32_get_bits(reo_desc->info0,
+					   HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
+		device_id = hw_links[hw_link_id].device_id;
+		partner_ab = ath12k_ag_to_ab(ag, device_id);
+
+		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
+						      hw_links[hw_link_id].pdev_idx);
+		ar = partner_ab->pdevs[pdev_id].ar;
+
+		link_desc_banks = partner_ab->dp.link_desc_banks;
+		link_desc_va = link_desc_banks[desc_bank].vaddr +
+			       (paddr - link_desc_banks[desc_bank].paddr);
+		ath12k_hal_rx_msdu_link_info_get(link_desc_va, &num_msdus, msdu_cookies,
+						 &rbm);
+		if (rbm != partner_ab->dp.idle_link_rbm &&
+		    rbm != HAL_RX_BUF_RBM_SW3_BM &&
+		    rbm != partner_ab->hw_params->hal_params->rx_buf_rbm) {
+			ab->device_stats.invalid_rbm++;
+			ath12k_warn(ab, "invalid return buffer manager %d\n", rbm);
+			ath12k_dp_rx_link_desc_return(partner_ab,
+						      &reo_desc->buf_addr_info,
+						      HAL_WBM_REL_BM_ACT_REL_MSDU);
+			continue;
+		}
+
+		is_frag = !!(le32_to_cpu(reo_desc->rx_mpdu_info.info0) &
+			     RX_MPDU_DESC_INFO0_FRAG_FLAG);
+
+		/* Process only rx fragments with one msdu per link desc below, and drop
+		 * msdu's indicated due to error reasons.
+		 * Dynamic fragmentation not supported in Multi-link client, so drop the
+		 * partner device buffers.
+		 */
+		if (!is_frag || num_msdus > 1 ||
+		    partner_ab->device_id != ab->device_id) {
+			drop = true;
+
+			/* Return the link desc back to wbm idle list */
+			ath12k_dp_rx_link_desc_return(partner_ab,
+						      &reo_desc->buf_addr_info,
+						      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+		}
+
+		for (i = 0; i < num_msdus; i++) {
+			if (!ath12k_dp_process_rx_err_buf(ar, reo_desc,
+							  &rx_desc_used_list[device_id],
+							  drop,
+							  msdu_cookies[i])) {
+				num_buffs_reaped[device_id]++;
+				tot_n_bufs_reaped++;
+			}
+		}
+
+		if (tot_n_bufs_reaped >= quota) {
+			tot_n_bufs_reaped = quota;
+			goto exit;
+		}
+
+		budget = quota - tot_n_bufs_reaped;
+	}
+
+exit:
+	ath12k_hal_srng_access_end(ab, srng);
+
+	spin_unlock_bh(&srng->lock);
+
+	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++) {
+		if (!num_buffs_reaped[device_id])
+			continue;
+
+		partner_ab = ath12k_ag_to_ab(ag, device_id);
+		rx_ring = &partner_ab->dp.rx_refill_buf_ring;
+
+		ath12k_dp_rx_bufs_replenish(partner_ab, rx_ring,
+					    &rx_desc_used_list[device_id],
+					    num_buffs_reaped[device_id]);
+	}
+
+	return tot_n_bufs_reaped;
+}
+
+static void ath12k_dp_rx_null_q_desc_sg_drop(struct ath12k *ar,
+					     int msdu_len,
+					     struct sk_buff_head *msdu_list)
+{
+	struct sk_buff *skb, *tmp;
+	struct ath12k_skb_rxcb *rxcb;
+	int n_buffs;
+
+	n_buffs = DIV_ROUND_UP(msdu_len,
+			       (DP_RX_BUFFER_SIZE - ar->ab->hal.hal_desc_sz));
+
+	skb_queue_walk_safe(msdu_list, skb, tmp) {
+		rxcb = ATH12K_SKB_RXCB(skb);
+		if (rxcb->err_rel_src == HAL_WBM_REL_SRC_MODULE_REO &&
+		    rxcb->err_code == HAL_REO_DEST_RING_ERROR_CODE_DESC_ADDR_ZERO) {
+			if (!n_buffs)
+				break;
+			__skb_unlink(skb, msdu_list);
+			dev_kfree_skb_any(skb);
+			n_buffs--;
+		}
+	}
+}
+
+static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
+				      struct ath12k_dp_rx_info *rx_info,
+				      struct sk_buff_head *msdu_list)
+{
+	struct ath12k_base *ab = ar->ab;
+	u16 msdu_len;
+	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
+	u8 l3pad_bytes;
+	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
+	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
+
+	msdu_len = ath12k_dp_rx_h_msdu_len(ab, desc);
+
+	if (!rxcb->is_frag && ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE)) {
+		/* First buffer will be freed by the caller, so deduct it's length */
+		msdu_len = msdu_len - (DP_RX_BUFFER_SIZE - hal_rx_desc_sz);
+		ath12k_dp_rx_null_q_desc_sg_drop(ar, msdu_len, msdu_list);
+		return -EINVAL;
+	}
+
+	/* Even after cleaning up the sg buffers in the msdu list with above check
+	 * any msdu received with continuation flag needs to be dropped as invalid.
+	 * This protects against some random err frame with continuation flag.
+	 */
+	if (rxcb->is_continuation)
+		return -EINVAL;
+
+	if (!ath12k_dp_rx_h_msdu_done(ab, desc)) {
+		ath12k_warn(ar->ab,
+			    "msdu_done bit not set in null_q_des processing\n");
+		__skb_queue_purge(msdu_list);
+		return -EIO;
+	}
+
+	/* Handle NULL queue descriptor violations arising out a missing
+	 * REO queue for a given peer or a given TID. This typically
+	 * may happen if a packet is received on a QOS enabled TID before the
+	 * ADDBA negotiation for that TID, when the TID queue is setup. Or
+	 * it may also happen for MC/BC frames if they are not routed to the
+	 * non-QOS TID queue, in the absence of any other default TID queue.
+	 * This error can show up both in a REO destination or WBM release ring.
+	 */
+
+	if (rxcb->is_frag) {
+		skb_pull(msdu, hal_rx_desc_sz);
+	} else {
+		l3pad_bytes = ath12k_dp_rx_h_l3pad(ab, desc);
+
+		if ((hal_rx_desc_sz + l3pad_bytes + msdu_len) > DP_RX_BUFFER_SIZE)
+			return -EINVAL;
+
+		skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
+		skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
+	}
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
+		return -EINVAL;
+
+	ath12k_dp_rx_h_fetch_info(ab, desc, rx_info);
+	ath12k_dp_rx_h_ppdu(ar, rx_info);
+	ath12k_dp_rx_h_mpdu(ar, msdu, desc, rx_info);
+
+	rxcb->tid = rx_info->tid;
+
+	/* Please note that caller will having the access to msdu and completing
+	 * rx with mac80211. Need not worry about cleaning up amsdu_list.
+	 */
+
+	return 0;
+}
 
 static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 					struct ath12k_dp_rx_info *rx_info)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
index 154018c221da..9c2114c62ba2 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -11,6 +11,8 @@
 
 int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 				 struct napi_struct *napi, int budget);
+int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
+			     int budget);
 int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab);
 int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab);
 #endif
-- 
2.34.1


