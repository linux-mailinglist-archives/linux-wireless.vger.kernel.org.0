Return-Path: <linux-wireless+bounces-26823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87292B3A847
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 19:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C917B3999
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D7133CE87;
	Thu, 28 Aug 2025 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tdrcj8XP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA88340DA2
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402593; cv=none; b=qfHI1WHakc1ioRfi6ye6k/jEJacyx7OQcoX2CFctdTAHYeFjHFG/1QtV6P9+Vt0kQ+Spa4h804psBj1DesydlftqzngsC6LjWP8Ahf98H/m3JR55QsOT1u2bqIAKFoGDykc1H3dje//qXmXfOBBnJLt7bM8NwVN6jIFxqeXI2yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402593; c=relaxed/simple;
	bh=gudv0FYj63w4HihNChJmcYw7tARwVWOkbgEqc0JYPDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlqIMZUWO7J6Lc72f+1PD2B28PPM0qrr2yP18FpkihseGXCtSbIsEt9tdrGH8P7GXct4nnSpobx7Q62oCO2bsRErDQ0XYcqkg7kDkhNsGZDtp9ZoOLqkC41ooD/Nqa9J8E6JCFkUTJeKaztBbIf7MxADC+5Y6YLXb9QRHRENIZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tdrcj8XP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SEOjxU030104;
	Thu, 28 Aug 2025 17:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UZQiFfzJTj+9Ns43mAmqM10/yOwsXrOusxkjt7y3KsU=; b=Tdrcj8XPaMlgJhp1
	zs91DPrqyMW4OpKl4r3HP7MAu2ZPEaHKYUbGIMJqmiJUyU9Iw59sQvChmabOBVC1
	o+hxsCBDE6pN/4bx2Yup9dFSqqvUZi8ILW8+XckrXra9vvP3pnIlT30RvinuqLRt
	jXINxjbz7GHNz9HklnHXo9eGwoEDLfuwzPwxQe/FO3fvEb3Hdbc/rF2mF2wWBsW/
	TGhOdkEK4KaMvZ6w44fxKW6gt2Nyx6YfVdhBMtZDE5we16D6pmUeuqmU9Jt57P+R
	HXIjX/mvp2b3emsjOrExpc+cKV5IWlwknxtxee54QRrwikVEFNc9H/0wQVEj/lBz
	qh9wDg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5up102u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SHaPVl019697
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:25 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 10:36:24 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 10/20] wifi: ath12k: Move regular msdu processing functions to wifi7 directory
Date: Thu, 28 Aug 2025 23:05:43 +0530
Message-ID: <20250828173553.3341351-11-quic_rdeuri@quicinc.com>
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
X-Proofpoint-GUID: _Is-EM4gBLANib2J7D6dq6cJwf3-f-ze
X-Proofpoint-ORIG-GUID: _Is-EM4gBLANib2J7D6dq6cJwf3-f-ze
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68b0939a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=IdimTUKBqCxWY8uyIzIA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX3v7xSlZ3KVSd
 /A6eHoea1OXckZ9JzXz2VExQhKIPq2yAMkBv0U2vnFOtJsbKU6VtuxdzyI0p5j+9yjk+vanQO5U
 ksDZwC2V9dV+pfKu4uFn7WXC8gmVzBHa6fWAgvImVl+h7kW9/YbOowA3U6rhpsLWe4nQtQvbbFT
 mkgVKgltOj8pHL2qm8fDZoNRhE4Fl5p+KarxwIShMsAdcKiLoAFSn4tKORR5CkFgoP/v/EF2oy4
 vIXwiW+9qVa9Ruaw45V8QalYg/lpoNR57sr9GDJYFTMBd26aCrsZSjYUdaP46TYzpUjcqhQzxSJ
 ZM5AMWR4eWYop5ghZws1C//jMIkAdOkTondeQko43vAXLFZbuVtqz/bxh2Qlfs8lWxO7mA6T1d6
 qii8zuoZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move arch specific RX MSDU processing related functions to wifi7 directory.

The moved APIs will be a part of dp_rx.c file inside wifi7 directory.
wifi7/dp_rx.c file will continue to be part of ath12k.ko temporarily
until the corresponding infra for movement to ath12k_wifi7.ko arrives
in upcoming patches.

Architecture specific APIs:
ath12k_dp_rx_msdu_coalesce
ath12k_dp_rx_h_csum_offload
ath12k_dp_rx_h_mpdu
ath12k_dp_rx_process
ath12k_dp_rx_process_received_packets
ath12k_dp_rx_h_verify_tkip_mic
ath12k_dp_rx_process_msdu

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c       | 543 +-----------------
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  18 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 527 +++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   3 +
 4 files changed, 547 insertions(+), 544 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index d52fec62eed7..6809c50ee871 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1664,95 +1664,8 @@ void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
 }
 EXPORT_SYMBOL(ath12k_dp_htt_htc_t2h_msg_handler);
 
-static int ath12k_dp_rx_msdu_coalesce(struct ath12k *ar,
-				      struct sk_buff_head *msdu_list,
-				      struct sk_buff *first, struct sk_buff *last,
-				      u8 l3pad_bytes, int msdu_len)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct sk_buff *skb;
-	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(first);
-	int buf_first_hdr_len, buf_first_len;
-	struct hal_rx_desc *ldesc;
-	int space_extra, rem_len, buf_len;
-	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
-	bool is_continuation;
-
-	/* As the msdu is spread across multiple rx buffers,
-	 * find the offset to the start of msdu for computing
-	 * the length of the msdu in the first buffer.
-	 */
-	buf_first_hdr_len = hal_rx_desc_sz + l3pad_bytes;
-	buf_first_len = DP_RX_BUFFER_SIZE - buf_first_hdr_len;
-
-	if (WARN_ON_ONCE(msdu_len <= buf_first_len)) {
-		skb_put(first, buf_first_hdr_len + msdu_len);
-		skb_pull(first, buf_first_hdr_len);
-		return 0;
-	}
-
-	ldesc = (struct hal_rx_desc *)last->data;
-	rxcb->is_first_msdu = ath12k_dp_rx_h_first_msdu(ab, ldesc);
-	rxcb->is_last_msdu = ath12k_dp_rx_h_last_msdu(ab, ldesc);
-
-	/* MSDU spans over multiple buffers because the length of the MSDU
-	 * exceeds DP_RX_BUFFER_SIZE - HAL_RX_DESC_SIZE. So assume the data
-	 * in the first buf is of length DP_RX_BUFFER_SIZE - HAL_RX_DESC_SIZE.
-	 */
-	skb_put(first, DP_RX_BUFFER_SIZE);
-	skb_pull(first, buf_first_hdr_len);
-
-	/* When an MSDU spread over multiple buffers MSDU_END
-	 * tlvs are valid only in the last buffer. Copy those tlvs.
-	 */
-	ath12k_dp_rx_desc_end_tlv_copy(ab, rxcb->rx_desc, ldesc);
-
-	space_extra = msdu_len - (buf_first_len + skb_tailroom(first));
-	if (space_extra > 0 &&
-	    (pskb_expand_head(first, 0, space_extra, GFP_ATOMIC) < 0)) {
-		/* Free up all buffers of the MSDU */
-		while ((skb = __skb_dequeue(msdu_list)) != NULL) {
-			rxcb = ATH12K_SKB_RXCB(skb);
-			if (!rxcb->is_continuation) {
-				dev_kfree_skb_any(skb);
-				break;
-			}
-			dev_kfree_skb_any(skb);
-		}
-		return -ENOMEM;
-	}
-
-	rem_len = msdu_len - buf_first_len;
-	while ((skb = __skb_dequeue(msdu_list)) != NULL && rem_len > 0) {
-		rxcb = ATH12K_SKB_RXCB(skb);
-		is_continuation = rxcb->is_continuation;
-		if (is_continuation)
-			buf_len = DP_RX_BUFFER_SIZE - hal_rx_desc_sz;
-		else
-			buf_len = rem_len;
-
-		if (buf_len > (DP_RX_BUFFER_SIZE - hal_rx_desc_sz)) {
-			WARN_ON_ONCE(1);
-			dev_kfree_skb_any(skb);
-			return -EINVAL;
-		}
-
-		skb_put(skb, buf_len + hal_rx_desc_sz);
-		skb_pull(skb, hal_rx_desc_sz);
-		skb_copy_from_linear_data(skb, skb_put(first, buf_len),
-					  buf_len);
-		dev_kfree_skb_any(skb);
-
-		rem_len -= buf_len;
-		if (!is_continuation)
-			break;
-	}
-
-	return 0;
-}
-
-static struct sk_buff *ath12k_dp_rx_get_msdu_last_buf(struct sk_buff_head *msdu_list,
-						      struct sk_buff *first)
+struct sk_buff *ath12k_dp_rx_get_msdu_last_buf(struct sk_buff_head *msdu_list,
+					       struct sk_buff *first)
 {
 	struct sk_buff *skb;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(first);
@@ -1769,13 +1682,6 @@ static struct sk_buff *ath12k_dp_rx_get_msdu_last_buf(struct sk_buff_head *msdu_
 	return NULL;
 }
 
-static void ath12k_dp_rx_h_csum_offload(struct sk_buff *msdu,
-					struct ath12k_dp_rx_info *rx_info)
-{
-	msdu->ip_summed = (rx_info->ip_csum_fail || rx_info->l4_csum_fail) ?
-			   CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
-}
-
 int ath12k_dp_rx_crypto_mic_len(struct ath12k *ar, enum hal_encrypt_type enctype)
 {
 	switch (enctype) {
@@ -2094,84 +2000,6 @@ ath12k_dp_rx_h_find_peer(struct ath12k_base *ab, struct sk_buff *msdu,
 	return peer;
 }
 
-void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
-			 struct sk_buff *msdu,
-			 struct hal_rx_desc *rx_desc,
-			 struct ath12k_dp_rx_info *rx_info)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_skb_rxcb *rxcb;
-	enum hal_encrypt_type enctype;
-	bool is_decrypted = false;
-	struct ieee80211_hdr *hdr;
-	struct ath12k_peer *peer;
-	struct ieee80211_rx_status *rx_status = rx_info->rx_status;
-	u32 err_bitmap;
-
-	/* PN for multicast packets will be checked in mac80211 */
-	rxcb = ATH12K_SKB_RXCB(msdu);
-	rxcb->is_mcbc = rx_info->is_mcbc;
-
-	if (rxcb->is_mcbc)
-		rxcb->peer_id = rx_info->peer_id;
-
-	spin_lock_bh(&ar->ab->base_lock);
-	peer = ath12k_dp_rx_h_find_peer(ar->ab, msdu, rx_info);
-	if (peer) {
-		/* resetting mcbc bit because mcbc packets are unicast
-		 * packets only for AP as STA sends unicast packets.
-		 */
-		rxcb->is_mcbc = rxcb->is_mcbc && !peer->ucast_ra_only;
-
-		if (rxcb->is_mcbc)
-			enctype = peer->sec_type_grp;
-		else
-			enctype = peer->sec_type;
-	} else {
-		enctype = HAL_ENCRYPT_TYPE_OPEN;
-	}
-	spin_unlock_bh(&ar->ab->base_lock);
-
-	err_bitmap = ath12k_dp_rx_h_mpdu_err(ab, rx_desc);
-	if (enctype != HAL_ENCRYPT_TYPE_OPEN && !err_bitmap)
-		is_decrypted = ath12k_dp_rx_h_is_decrypted(ab, rx_desc);
-
-	/* Clear per-MPDU flags while leaving per-PPDU flags intact */
-	rx_status->flag &= ~(RX_FLAG_FAILED_FCS_CRC |
-			     RX_FLAG_MMIC_ERROR |
-			     RX_FLAG_DECRYPTED |
-			     RX_FLAG_IV_STRIPPED |
-			     RX_FLAG_MMIC_STRIPPED);
-
-	if (err_bitmap & HAL_RX_MPDU_ERR_FCS)
-		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
-	if (err_bitmap & HAL_RX_MPDU_ERR_TKIP_MIC)
-		rx_status->flag |= RX_FLAG_MMIC_ERROR;
-
-	if (is_decrypted) {
-		rx_status->flag |= RX_FLAG_DECRYPTED | RX_FLAG_MMIC_STRIPPED;
-
-		if (rx_info->is_mcbc)
-			rx_status->flag |= RX_FLAG_MIC_STRIPPED |
-					RX_FLAG_ICV_STRIPPED;
-		else
-			rx_status->flag |= RX_FLAG_IV_STRIPPED |
-					   RX_FLAG_PN_VALIDATED;
-	}
-
-	ath12k_dp_rx_h_csum_offload(msdu, rx_info);
-	ath12k_dp_rx_h_undecap(ar, msdu, rx_desc,
-			       enctype, rx_status, is_decrypted);
-
-	if (!is_decrypted || rx_info->is_mcbc)
-		return;
-
-	if (rx_info->decap_type != DP_RX_DECAP_TYPE_ETHERNET2_DIX) {
-		hdr = (void *)msdu->data;
-		hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_PROTECTED);
-	}
-}
-
 static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct ath12k_dp_rx_info *rx_info)
 {
 	struct ieee80211_supported_band *sband;
@@ -2416,140 +2244,9 @@ bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
 	return false;
 }
 
-static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
-				     struct sk_buff *msdu,
-				     struct sk_buff_head *msdu_list,
-				     struct ath12k_dp_rx_info *rx_info)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct hal_rx_desc *rx_desc, *lrx_desc;
-	struct ath12k_skb_rxcb *rxcb;
-	struct sk_buff *last_buf;
-	u8 l3_pad_bytes;
-	u16 msdu_len;
-	int ret;
-	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
-
-	last_buf = ath12k_dp_rx_get_msdu_last_buf(msdu_list, msdu);
-	if (!last_buf) {
-		ath12k_warn(ab,
-			    "No valid Rx buffer to access MSDU_END tlv\n");
-		ret = -EIO;
-		goto free_out;
-	}
-
-	rx_desc = (struct hal_rx_desc *)msdu->data;
-	lrx_desc = (struct hal_rx_desc *)last_buf->data;
-	if (!ath12k_dp_rx_h_msdu_done(ab, lrx_desc)) {
-		ath12k_warn(ab, "msdu_done bit in msdu_end is not set\n");
-		ret = -EIO;
-		goto free_out;
-	}
-
-	rxcb = ATH12K_SKB_RXCB(msdu);
-	rxcb->rx_desc = rx_desc;
-	msdu_len = ath12k_dp_rx_h_msdu_len(ab, lrx_desc);
-	l3_pad_bytes = ath12k_dp_rx_h_l3pad(ab, lrx_desc);
-
-	if (rxcb->is_frag) {
-		skb_pull(msdu, hal_rx_desc_sz);
-	} else if (!rxcb->is_continuation) {
-		if ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE) {
-			ret = -EINVAL;
-			ath12k_warn(ab, "invalid msdu len %u\n", msdu_len);
-			ath12k_dbg_dump(ab, ATH12K_DBG_DATA, NULL, "", rx_desc,
-					sizeof(*rx_desc));
-			goto free_out;
-		}
-		skb_put(msdu, hal_rx_desc_sz + l3_pad_bytes + msdu_len);
-		skb_pull(msdu, hal_rx_desc_sz + l3_pad_bytes);
-	} else {
-		ret = ath12k_dp_rx_msdu_coalesce(ar, msdu_list,
-						 msdu, last_buf,
-						 l3_pad_bytes, msdu_len);
-		if (ret) {
-			ath12k_warn(ab,
-				    "failed to coalesce msdu rx buffer%d\n", ret);
-			goto free_out;
-		}
-	}
-
-	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu))) {
-		ret = -EINVAL;
-		goto free_out;
-	}
-
-	ath12k_dp_rx_h_fetch_info(ab, rx_desc, rx_info);
-	ath12k_dp_rx_h_ppdu(ar, rx_info);
-	ath12k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_info);
-
-	rx_info->rx_status->flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
-
-	return 0;
-
-free_out:
-	return ret;
-}
-
-static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
-						  struct napi_struct *napi,
-						  struct sk_buff_head *msdu_list,
-						  int ring_id)
-{
-	struct ath12k_hw_group *ag = ab->ag;
-	struct ieee80211_rx_status rx_status = {};
-	struct ath12k_skb_rxcb *rxcb;
-	struct sk_buff *msdu;
-	struct ath12k *ar;
-	struct ath12k_hw_link *hw_links = ag->hw_links;
-	struct ath12k_base *partner_ab;
-	struct ath12k_dp_rx_info rx_info;
-	u8 hw_link_id, pdev_id;
-	int ret;
-
-	if (skb_queue_empty(msdu_list))
-		return;
-
-	rx_info.addr2_present = false;
-	rx_info.rx_status = &rx_status;
-
-	rcu_read_lock();
-
-	while ((msdu = __skb_dequeue(msdu_list))) {
-		rxcb = ATH12K_SKB_RXCB(msdu);
-		hw_link_id = rxcb->hw_link_id;
-		partner_ab = ath12k_ag_to_ab(ag,
-					     hw_links[hw_link_id].device_id);
-		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
-						      hw_links[hw_link_id].pdev_idx);
-		ar = partner_ab->pdevs[pdev_id].ar;
-		if (!rcu_dereference(partner_ab->pdevs_active[pdev_id])) {
-			dev_kfree_skb_any(msdu);
-			continue;
-		}
-
-		if (test_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags)) {
-			dev_kfree_skb_any(msdu);
-			continue;
-		}
-
-		ret = ath12k_dp_rx_process_msdu(ar, msdu, msdu_list, &rx_info);
-		if (ret) {
-			ath12k_dbg(ab, ATH12K_DBG_DATA,
-				   "Unable to process msdu %d", ret);
-			dev_kfree_skb_any(msdu);
-			continue;
-		}
-
-		ath12k_dp_rx_deliver_msdu(ar, napi, msdu, &rx_info);
-	}
-
-	rcu_read_unlock();
-}
-
-static u16 ath12k_dp_rx_get_peer_id(struct ath12k_base *ab,
-				    enum ath12k_peer_metadata_version ver,
-				    __le32 peer_metadata)
+u16 ath12k_dp_rx_get_peer_id(struct ath12k_base *ab,
+			     enum ath12k_peer_metadata_version ver,
+			     __le32 peer_metadata)
 {
 	switch (ver) {
 	default:
@@ -2570,166 +2267,6 @@ static u16 ath12k_dp_rx_get_peer_id(struct ath12k_base *ab,
 	}
 }
 
-int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
-			 struct napi_struct *napi, int budget)
-{
-	struct ath12k_hw_group *ag = ab->ag;
-	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
-	struct ath12k_hw_link *hw_links = ag->hw_links;
-	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
-	struct ath12k_rx_desc_info *desc_info;
-	struct ath12k_dp *dp = &ab->dp;
-	struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
-	struct hal_reo_dest_ring *desc;
-	struct ath12k_base *partner_ab;
-	struct sk_buff_head msdu_list;
-	struct ath12k_skb_rxcb *rxcb;
-	int total_msdu_reaped = 0;
-	u8 hw_link_id, device_id;
-	struct hal_srng *srng;
-	struct sk_buff *msdu;
-	bool done = false;
-	u64 desc_va;
-
-	__skb_queue_head_init(&msdu_list);
-
-	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++)
-		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
-
-	srng = &ab->hal.srng_list[dp->reo_dst_ring[ring_id].ring_id];
-
-	spin_lock_bh(&srng->lock);
-
-try_again:
-	ath12k_hal_srng_access_begin(ab, srng);
-
-	while ((desc = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
-		struct rx_mpdu_desc *mpdu_info;
-		struct rx_msdu_desc *msdu_info;
-		enum hal_reo_dest_ring_push_reason push_reason;
-		u32 cookie;
-
-		cookie = le32_get_bits(desc->buf_addr_info.info1,
-				       BUFFER_ADDR_INFO1_SW_COOKIE);
-
-		hw_link_id = le32_get_bits(desc->info0,
-					   HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
-
-		desc_va = ((u64)le32_to_cpu(desc->buf_va_hi) << 32 |
-			   le32_to_cpu(desc->buf_va_lo));
-		desc_info = (struct ath12k_rx_desc_info *)((unsigned long)desc_va);
-
-		device_id = hw_links[hw_link_id].device_id;
-		partner_ab = ath12k_ag_to_ab(ag, device_id);
-		if (unlikely(!partner_ab)) {
-			if (desc_info->skb) {
-				dev_kfree_skb_any(desc_info->skb);
-				desc_info->skb = NULL;
-			}
-
-			continue;
-		}
-
-		/* retry manual desc retrieval */
-		if (!desc_info) {
-			desc_info = ath12k_dp_get_rx_desc(partner_ab, cookie);
-			if (!desc_info) {
-				ath12k_warn(partner_ab, "Invalid cookie in manual descriptor retrieval: 0x%x\n",
-					    cookie);
-				continue;
-			}
-		}
-
-		if (desc_info->magic != ATH12K_DP_RX_DESC_MAGIC)
-			ath12k_warn(ab, "Check HW CC implementation");
-
-		msdu = desc_info->skb;
-		desc_info->skb = NULL;
-
-		list_add_tail(&desc_info->list, &rx_desc_used_list[device_id]);
-
-		rxcb = ATH12K_SKB_RXCB(msdu);
-		dma_unmap_single(partner_ab->dev, rxcb->paddr,
-				 msdu->len + skb_tailroom(msdu),
-				 DMA_FROM_DEVICE);
-
-		num_buffs_reaped[device_id]++;
-		ab->device_stats.reo_rx[ring_id][ab->device_id]++;
-
-		push_reason = le32_get_bits(desc->info0,
-					    HAL_REO_DEST_RING_INFO0_PUSH_REASON);
-		if (push_reason !=
-		    HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
-			dev_kfree_skb_any(msdu);
-			ab->device_stats.hal_reo_error[ring_id]++;
-			continue;
-		}
-
-		msdu_info = &desc->rx_msdu_info;
-		mpdu_info = &desc->rx_mpdu_info;
-
-		rxcb->is_first_msdu = !!(le32_to_cpu(msdu_info->info0) &
-					 RX_MSDU_DESC_INFO0_FIRST_MSDU_IN_MPDU);
-		rxcb->is_last_msdu = !!(le32_to_cpu(msdu_info->info0) &
-					RX_MSDU_DESC_INFO0_LAST_MSDU_IN_MPDU);
-		rxcb->is_continuation = !!(le32_to_cpu(msdu_info->info0) &
-					   RX_MSDU_DESC_INFO0_MSDU_CONTINUATION);
-		rxcb->hw_link_id = hw_link_id;
-		rxcb->peer_id = ath12k_dp_rx_get_peer_id(ab, dp->peer_metadata_ver,
-							 mpdu_info->peer_meta_data);
-		rxcb->tid = le32_get_bits(mpdu_info->info0,
-					  RX_MPDU_DESC_INFO0_TID);
-
-		__skb_queue_tail(&msdu_list, msdu);
-
-		if (!rxcb->is_continuation) {
-			total_msdu_reaped++;
-			done = true;
-		} else {
-			done = false;
-		}
-
-		if (total_msdu_reaped >= budget)
-			break;
-	}
-
-	/* Hw might have updated the head pointer after we cached it.
-	 * In this case, even though there are entries in the ring we'll
-	 * get rx_desc NULL. Give the read another try with updated cached
-	 * head pointer so that we can reap complete MPDU in the current
-	 * rx processing.
-	 */
-	if (!done && ath12k_hal_srng_dst_num_free(ab, srng, true)) {
-		ath12k_hal_srng_access_end(ab, srng);
-		goto try_again;
-	}
-
-	ath12k_hal_srng_access_end(ab, srng);
-
-	spin_unlock_bh(&srng->lock);
-
-	if (!total_msdu_reaped)
-		goto exit;
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
-	ath12k_dp_rx_process_received_packets(ab, napi, &msdu_list,
-					      ring_id);
-
-exit:
-	return total_msdu_reaped;
-}
-
 static void ath12k_dp_rx_frag_timer(struct timer_list *timer)
 {
 	struct ath12k_dp_rx_tid *rx_tid = timer_container_of(rx_tid, timer,
@@ -2787,9 +2324,9 @@ int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev
 	return 0;
 }
 
-static int ath12k_dp_rx_h_michael_mic(struct crypto_shash *tfm, u8 *key,
-				      struct ieee80211_hdr *hdr, u8 *data,
-				      size_t data_len, u8 *mic)
+int ath12k_dp_rx_h_michael_mic(struct crypto_shash *tfm, u8 *key,
+			       struct ieee80211_hdr *hdr, u8 *data,
+			       size_t data_len, u8 *mic)
 {
 	SHASH_DESC_ON_STACK(desc, tfm);
 	u8 mic_hdr[16] = {};
@@ -2828,70 +2365,6 @@ static int ath12k_dp_rx_h_michael_mic(struct crypto_shash *tfm, u8 *key,
 	return ret;
 }
 
-int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer *peer,
-				   struct sk_buff *msdu)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
-	struct ieee80211_rx_status *rxs = IEEE80211_SKB_RXCB(msdu);
-	struct ieee80211_key_conf *key_conf;
-	struct ieee80211_hdr *hdr;
-	struct ath12k_dp_rx_info rx_info;
-	u8 mic[IEEE80211_CCMP_MIC_LEN];
-	int head_len, tail_len, ret;
-	size_t data_len;
-	u32 hdr_len, hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
-	u8 *key, *data;
-	u8 key_idx;
-
-	if (ath12k_dp_rx_h_enctype(ab, rx_desc) != HAL_ENCRYPT_TYPE_TKIP_MIC)
-		return 0;
-
-	rx_info.addr2_present = false;
-	rx_info.rx_status = rxs;
-
-	hdr = (struct ieee80211_hdr *)(msdu->data + hal_rx_desc_sz);
-	hdr_len = ieee80211_hdrlen(hdr->frame_control);
-	head_len = hdr_len + hal_rx_desc_sz + IEEE80211_TKIP_IV_LEN;
-	tail_len = IEEE80211_CCMP_MIC_LEN + IEEE80211_TKIP_ICV_LEN + FCS_LEN;
-
-	if (!is_multicast_ether_addr(hdr->addr1))
-		key_idx = peer->ucast_keyidx;
-	else
-		key_idx = peer->mcast_keyidx;
-
-	key_conf = peer->keys[key_idx];
-
-	data = msdu->data + head_len;
-	data_len = msdu->len - head_len - tail_len;
-	key = &key_conf->key[NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY];
-
-	ret = ath12k_dp_rx_h_michael_mic(peer->tfm_mmic, key, hdr, data, data_len, mic);
-	if (ret || memcmp(mic, data + data_len, IEEE80211_CCMP_MIC_LEN))
-		goto mic_fail;
-
-	return 0;
-
-mic_fail:
-	(ATH12K_SKB_RXCB(msdu))->is_first_msdu = true;
-	(ATH12K_SKB_RXCB(msdu))->is_last_msdu = true;
-
-	ath12k_dp_rx_h_fetch_info(ab, rx_desc, &rx_info);
-
-	rxs->flag |= RX_FLAG_MMIC_ERROR | RX_FLAG_MMIC_STRIPPED |
-		    RX_FLAG_IV_STRIPPED | RX_FLAG_DECRYPTED;
-	skb_pull(msdu, hal_rx_desc_sz);
-
-	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu)))
-		return -EINVAL;
-
-	ath12k_dp_rx_h_ppdu(ar, &rx_info);
-	ath12k_dp_rx_h_undecap(ar, msdu, rx_desc,
-			       HAL_ENCRYPT_TYPE_TKIP_MIC, rxs, true);
-	ieee80211_rx(ath12k_ar_to_hw(ar), msdu);
-	return -EINVAL;
-}
-
 void ath12k_dp_rx_h_undecap_frag(struct ath12k *ar, struct sk_buff *msdu,
 				 enum hal_encrypt_type enctype, u32 flags)
 {
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index dc0b1078213c..5fc9adeb49bd 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -6,6 +6,7 @@
 #ifndef ATH12K_DP_RX_H
 #define ATH12K_DP_RX_H
 
+#include <crypto/hash.h>
 #include "core.h"
 #include "wifi7/hal_rx_desc.h"
 #include "debug.h"
@@ -353,20 +354,20 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
 bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
 					    struct hal_rx_desc *rx_desc,
 					    struct sk_buff *msdu);
-void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
-			 struct sk_buff *msdu,
-			 struct hal_rx_desc *rx_desc,
-			 struct ath12k_dp_rx_info *rx_info);
 u64 ath12k_dp_rx_h_get_pn(struct ath12k *ar, struct sk_buff *skb);
 void ath12k_dp_rx_h_sort_frags(struct ath12k_base *ab,
 			       struct sk_buff_head *frag_list,
 			       struct sk_buff *cur_frag);
 void ath12k_dp_rx_h_undecap_frag(struct ath12k *ar, struct sk_buff *msdu,
 				 enum hal_encrypt_type enctype, u32 flags);
-int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer *peer,
-				   struct sk_buff *msdu);
 void ath12k_dp_rx_frags_cleanup(struct ath12k_dp_rx_tid *rx_tid,
 				bool rel_link_desc);
+int ath12k_dp_rx_h_michael_mic(struct crypto_shash *tfm, u8 *key,
+			       struct ieee80211_hdr *hdr, u8 *data,
+			       size_t data_len, u8 *mic);
+u16 ath12k_dp_rx_get_peer_id(struct ath12k_base *ab,
+			     enum ath12k_peer_metadata_version ver,
+			     __le32 peer_metadata);
 int ath12k_dp_rx_ampdu_start(struct ath12k *ar,
 			     struct ieee80211_ampdu_params *params,
 			     u8 link_id);
@@ -394,9 +395,6 @@ int ath12k_dp_rx_pdev_alloc(struct ath12k_base *ab, int pdev_idx);
 void ath12k_dp_rx_pdev_free(struct ath12k_base *ab, int pdev_idx);
 void ath12k_dp_rx_reo_cmd_list_cleanup(struct ath12k_base *ab);
 void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab);
-int ath12k_dp_rx_process(struct ath12k_base *ab, int mac_id,
-			 struct napi_struct *napi,
-			 int budget);
 int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 				struct dp_rxdma_ring *rx_ring,
 				struct list_head *used_list,
@@ -431,4 +429,6 @@ int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
 bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
 				 struct hal_rx_desc *rx_desc);
 void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct ath12k_dp_rx_info *rx_info);
+struct sk_buff *ath12k_dp_rx_get_msdu_last_buf(struct sk_buff_head *msdu_list,
+					       struct sk_buff *first);
 #endif /* ATH12K_DP_RX_H */
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index c2b108a1005b..b55cfb926571 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -8,6 +8,469 @@
 #include "../dp_tx.h"
 #include "../peer.h"
 
+static void ath12k_dp_rx_h_csum_offload(struct sk_buff *msdu,
+					struct ath12k_dp_rx_info *rx_info)
+{
+	msdu->ip_summed = (rx_info->ip_csum_fail || rx_info->l4_csum_fail) ?
+			   CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
+}
+
+static void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
+				struct sk_buff *msdu,
+				struct hal_rx_desc *rx_desc,
+				struct ath12k_dp_rx_info *rx_info)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_skb_rxcb *rxcb;
+	enum hal_encrypt_type enctype;
+	bool is_decrypted = false;
+	struct ieee80211_hdr *hdr;
+	struct ath12k_peer *peer;
+	struct ieee80211_rx_status *rx_status = rx_info->rx_status;
+	u32 err_bitmap;
+
+	/* PN for multicast packets will be checked in mac80211 */
+	rxcb = ATH12K_SKB_RXCB(msdu);
+	rxcb->is_mcbc = rx_info->is_mcbc;
+
+	if (rxcb->is_mcbc)
+		rxcb->peer_id = rx_info->peer_id;
+
+	spin_lock_bh(&ar->ab->base_lock);
+	peer = ath12k_dp_rx_h_find_peer(ar->ab, msdu, rx_info);
+	if (peer) {
+		/* resetting mcbc bit because mcbc packets are unicast
+		 * packets only for AP as STA sends unicast packets.
+		 */
+		rxcb->is_mcbc = rxcb->is_mcbc && !peer->ucast_ra_only;
+
+		if (rxcb->is_mcbc)
+			enctype = peer->sec_type_grp;
+		else
+			enctype = peer->sec_type;
+	} else {
+		enctype = HAL_ENCRYPT_TYPE_OPEN;
+	}
+	spin_unlock_bh(&ar->ab->base_lock);
+
+	err_bitmap = ath12k_dp_rx_h_mpdu_err(ab, rx_desc);
+	if (enctype != HAL_ENCRYPT_TYPE_OPEN && !err_bitmap)
+		is_decrypted = ath12k_dp_rx_h_is_decrypted(ab, rx_desc);
+
+	/* Clear per-MPDU flags while leaving per-PPDU flags intact */
+	rx_status->flag &= ~(RX_FLAG_FAILED_FCS_CRC |
+			     RX_FLAG_MMIC_ERROR |
+			     RX_FLAG_DECRYPTED |
+			     RX_FLAG_IV_STRIPPED |
+			     RX_FLAG_MMIC_STRIPPED);
+
+	if (err_bitmap & HAL_RX_MPDU_ERR_FCS)
+		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
+	if (err_bitmap & HAL_RX_MPDU_ERR_TKIP_MIC)
+		rx_status->flag |= RX_FLAG_MMIC_ERROR;
+
+	if (is_decrypted) {
+		rx_status->flag |= RX_FLAG_DECRYPTED | RX_FLAG_MMIC_STRIPPED;
+
+		if (rx_info->is_mcbc)
+			rx_status->flag |= RX_FLAG_MIC_STRIPPED |
+					RX_FLAG_ICV_STRIPPED;
+		else
+			rx_status->flag |= RX_FLAG_IV_STRIPPED |
+					   RX_FLAG_PN_VALIDATED;
+	}
+
+	ath12k_dp_rx_h_csum_offload(msdu, rx_info);
+	ath12k_dp_rx_h_undecap(ar, msdu, rx_desc,
+			       enctype, rx_status, is_decrypted);
+
+	if (!is_decrypted || rx_info->is_mcbc)
+		return;
+
+	if (rx_info->decap_type != DP_RX_DECAP_TYPE_ETHERNET2_DIX) {
+		hdr = (void *)msdu->data;
+		hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_PROTECTED);
+	}
+}
+
+static int ath12k_dp_rx_msdu_coalesce(struct ath12k *ar,
+				      struct sk_buff_head *msdu_list,
+				      struct sk_buff *first, struct sk_buff *last,
+				      u8 l3pad_bytes, int msdu_len)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct sk_buff *skb;
+	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(first);
+	int buf_first_hdr_len, buf_first_len;
+	struct hal_rx_desc *ldesc;
+	int space_extra, rem_len, buf_len;
+	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
+	bool is_continuation;
+
+	/* As the msdu is spread across multiple rx buffers,
+	 * find the offset to the start of msdu for computing
+	 * the length of the msdu in the first buffer.
+	 */
+	buf_first_hdr_len = hal_rx_desc_sz + l3pad_bytes;
+	buf_first_len = DP_RX_BUFFER_SIZE - buf_first_hdr_len;
+
+	if (WARN_ON_ONCE(msdu_len <= buf_first_len)) {
+		skb_put(first, buf_first_hdr_len + msdu_len);
+		skb_pull(first, buf_first_hdr_len);
+		return 0;
+	}
+
+	ldesc = (struct hal_rx_desc *)last->data;
+	rxcb->is_first_msdu = ath12k_dp_rx_h_first_msdu(ab, ldesc);
+	rxcb->is_last_msdu = ath12k_dp_rx_h_last_msdu(ab, ldesc);
+
+	/* MSDU spans over multiple buffers because the length of the MSDU
+	 * exceeds DP_RX_BUFFER_SIZE - HAL_RX_DESC_SIZE. So assume the data
+	 * in the first buf is of length DP_RX_BUFFER_SIZE - HAL_RX_DESC_SIZE.
+	 */
+	skb_put(first, DP_RX_BUFFER_SIZE);
+	skb_pull(first, buf_first_hdr_len);
+
+	/* When an MSDU spread over multiple buffers MSDU_END
+	 * tlvs are valid only in the last buffer. Copy those tlvs.
+	 */
+	ath12k_dp_rx_desc_end_tlv_copy(ab, rxcb->rx_desc, ldesc);
+
+	space_extra = msdu_len - (buf_first_len + skb_tailroom(first));
+	if (space_extra > 0 &&
+	    (pskb_expand_head(first, 0, space_extra, GFP_ATOMIC) < 0)) {
+		/* Free up all buffers of the MSDU */
+		while ((skb = __skb_dequeue(msdu_list)) != NULL) {
+			rxcb = ATH12K_SKB_RXCB(skb);
+			if (!rxcb->is_continuation) {
+				dev_kfree_skb_any(skb);
+				break;
+			}
+			dev_kfree_skb_any(skb);
+		}
+		return -ENOMEM;
+	}
+
+	rem_len = msdu_len - buf_first_len;
+	while ((skb = __skb_dequeue(msdu_list)) != NULL && rem_len > 0) {
+		rxcb = ATH12K_SKB_RXCB(skb);
+		is_continuation = rxcb->is_continuation;
+		if (is_continuation)
+			buf_len = DP_RX_BUFFER_SIZE - hal_rx_desc_sz;
+		else
+			buf_len = rem_len;
+
+		if (buf_len > (DP_RX_BUFFER_SIZE - hal_rx_desc_sz)) {
+			WARN_ON_ONCE(1);
+			dev_kfree_skb_any(skb);
+			return -EINVAL;
+		}
+
+		skb_put(skb, buf_len + hal_rx_desc_sz);
+		skb_pull(skb, hal_rx_desc_sz);
+		skb_copy_from_linear_data(skb, skb_put(first, buf_len),
+					  buf_len);
+		dev_kfree_skb_any(skb);
+
+		rem_len -= buf_len;
+		if (!is_continuation)
+			break;
+	}
+
+	return 0;
+}
+
+static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
+				     struct sk_buff *msdu,
+				     struct sk_buff_head *msdu_list,
+				     struct ath12k_dp_rx_info *rx_info)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct hal_rx_desc *rx_desc, *lrx_desc;
+	struct ath12k_skb_rxcb *rxcb;
+	struct sk_buff *last_buf;
+	u8 l3_pad_bytes;
+	u16 msdu_len;
+	int ret;
+	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
+
+	last_buf = ath12k_dp_rx_get_msdu_last_buf(msdu_list, msdu);
+	if (!last_buf) {
+		ath12k_warn(ab,
+			    "No valid Rx buffer to access MSDU_END tlv\n");
+		ret = -EIO;
+		goto free_out;
+	}
+
+	rx_desc = (struct hal_rx_desc *)msdu->data;
+	lrx_desc = (struct hal_rx_desc *)last_buf->data;
+	if (!ath12k_dp_rx_h_msdu_done(ab, lrx_desc)) {
+		ath12k_warn(ab, "msdu_done bit in msdu_end is not set\n");
+		ret = -EIO;
+		goto free_out;
+	}
+
+	rxcb = ATH12K_SKB_RXCB(msdu);
+	rxcb->rx_desc = rx_desc;
+	msdu_len = ath12k_dp_rx_h_msdu_len(ab, lrx_desc);
+	l3_pad_bytes = ath12k_dp_rx_h_l3pad(ab, lrx_desc);
+
+	if (rxcb->is_frag) {
+		skb_pull(msdu, hal_rx_desc_sz);
+	} else if (!rxcb->is_continuation) {
+		if ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE) {
+			ret = -EINVAL;
+			ath12k_warn(ab, "invalid msdu len %u\n", msdu_len);
+			ath12k_dbg_dump(ab, ATH12K_DBG_DATA, NULL, "", rx_desc,
+					sizeof(*rx_desc));
+			goto free_out;
+		}
+		skb_put(msdu, hal_rx_desc_sz + l3_pad_bytes + msdu_len);
+		skb_pull(msdu, hal_rx_desc_sz + l3_pad_bytes);
+	} else {
+		ret = ath12k_dp_rx_msdu_coalesce(ar, msdu_list,
+						 msdu, last_buf,
+						 l3_pad_bytes, msdu_len);
+		if (ret) {
+			ath12k_warn(ab,
+				    "failed to coalesce msdu rx buffer%d\n", ret);
+			goto free_out;
+		}
+	}
+
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu))) {
+		ret = -EINVAL;
+		goto free_out;
+	}
+
+	ath12k_dp_rx_h_fetch_info(ab, rx_desc, rx_info);
+	ath12k_dp_rx_h_ppdu(ar, rx_info);
+	ath12k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_info);
+
+	rx_info->rx_status->flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
+
+	return 0;
+
+free_out:
+	return ret;
+}
+
+static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
+						  struct napi_struct *napi,
+						  struct sk_buff_head *msdu_list,
+						  int ring_id)
+{
+	struct ath12k_hw_group *ag = ab->ag;
+	struct ieee80211_rx_status rx_status = {};
+	struct ath12k_skb_rxcb *rxcb;
+	struct sk_buff *msdu;
+	struct ath12k *ar;
+	struct ath12k_hw_link *hw_links = ag->hw_links;
+	struct ath12k_base *partner_ab;
+	struct ath12k_dp_rx_info rx_info;
+	u8 hw_link_id, pdev_id;
+	int ret;
+
+	if (skb_queue_empty(msdu_list))
+		return;
+
+	rx_info.addr2_present = false;
+	rx_info.rx_status = &rx_status;
+
+	rcu_read_lock();
+
+	while ((msdu = __skb_dequeue(msdu_list))) {
+		rxcb = ATH12K_SKB_RXCB(msdu);
+		hw_link_id = rxcb->hw_link_id;
+		partner_ab = ath12k_ag_to_ab(ag,
+					     hw_links[hw_link_id].device_id);
+		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
+						      hw_links[hw_link_id].pdev_idx);
+		ar = partner_ab->pdevs[pdev_id].ar;
+		if (!rcu_dereference(partner_ab->pdevs_active[pdev_id])) {
+			dev_kfree_skb_any(msdu);
+			continue;
+		}
+
+		if (test_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags)) {
+			dev_kfree_skb_any(msdu);
+			continue;
+		}
+
+		ret = ath12k_dp_rx_process_msdu(ar, msdu, msdu_list, &rx_info);
+		if (ret) {
+			ath12k_dbg(ab, ATH12K_DBG_DATA,
+				   "Unable to process msdu %d", ret);
+			dev_kfree_skb_any(msdu);
+			continue;
+		}
+
+		ath12k_dp_rx_deliver_msdu(ar, napi, msdu, &rx_info);
+	}
+
+	rcu_read_unlock();
+}
+
+int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
+			 struct napi_struct *napi, int budget)
+{
+	struct ath12k_hw_group *ag = ab->ag;
+	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
+	struct ath12k_hw_link *hw_links = ag->hw_links;
+	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
+	struct ath12k_rx_desc_info *desc_info;
+	struct ath12k_dp *dp = &ab->dp;
+	struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
+	struct hal_reo_dest_ring *desc;
+	struct ath12k_base *partner_ab;
+	struct sk_buff_head msdu_list;
+	struct ath12k_skb_rxcb *rxcb;
+	int total_msdu_reaped = 0;
+	u8 hw_link_id, device_id;
+	struct hal_srng *srng;
+	struct sk_buff *msdu;
+	bool done = false;
+	u64 desc_va;
+
+	__skb_queue_head_init(&msdu_list);
+
+	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++)
+		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
+
+	srng = &ab->hal.srng_list[dp->reo_dst_ring[ring_id].ring_id];
+
+	spin_lock_bh(&srng->lock);
+
+try_again:
+	ath12k_hal_srng_access_begin(ab, srng);
+
+	while ((desc = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
+		struct rx_mpdu_desc *mpdu_info;
+		struct rx_msdu_desc *msdu_info;
+		enum hal_reo_dest_ring_push_reason push_reason;
+		u32 cookie;
+
+		cookie = le32_get_bits(desc->buf_addr_info.info1,
+				       BUFFER_ADDR_INFO1_SW_COOKIE);
+
+		hw_link_id = le32_get_bits(desc->info0,
+					   HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
+
+		desc_va = ((u64)le32_to_cpu(desc->buf_va_hi) << 32 |
+			   le32_to_cpu(desc->buf_va_lo));
+		desc_info = (struct ath12k_rx_desc_info *)((unsigned long)desc_va);
+
+		device_id = hw_links[hw_link_id].device_id;
+		partner_ab = ath12k_ag_to_ab(ag, device_id);
+		if (unlikely(!partner_ab)) {
+			if (desc_info->skb) {
+				dev_kfree_skb_any(desc_info->skb);
+				desc_info->skb = NULL;
+			}
+
+			continue;
+		}
+
+		/* retry manual desc retrieval */
+		if (!desc_info) {
+			desc_info = ath12k_dp_get_rx_desc(partner_ab, cookie);
+			if (!desc_info) {
+				ath12k_warn(partner_ab, "Invalid cookie in manual descriptor retrieval: 0x%x\n",
+					    cookie);
+				continue;
+			}
+		}
+
+		if (desc_info->magic != ATH12K_DP_RX_DESC_MAGIC)
+			ath12k_warn(ab, "Check HW CC implementation");
+
+		msdu = desc_info->skb;
+		desc_info->skb = NULL;
+
+		list_add_tail(&desc_info->list, &rx_desc_used_list[device_id]);
+
+		rxcb = ATH12K_SKB_RXCB(msdu);
+		dma_unmap_single(partner_ab->dev, rxcb->paddr,
+				 msdu->len + skb_tailroom(msdu),
+				 DMA_FROM_DEVICE);
+
+		num_buffs_reaped[device_id]++;
+		ab->device_stats.reo_rx[ring_id][ab->device_id]++;
+
+		push_reason = le32_get_bits(desc->info0,
+					    HAL_REO_DEST_RING_INFO0_PUSH_REASON);
+		if (push_reason !=
+		    HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
+			dev_kfree_skb_any(msdu);
+			ab->device_stats.hal_reo_error[ring_id]++;
+			continue;
+		}
+
+		msdu_info = &desc->rx_msdu_info;
+		mpdu_info = &desc->rx_mpdu_info;
+
+		rxcb->is_first_msdu = !!(le32_to_cpu(msdu_info->info0) &
+					 RX_MSDU_DESC_INFO0_FIRST_MSDU_IN_MPDU);
+		rxcb->is_last_msdu = !!(le32_to_cpu(msdu_info->info0) &
+					RX_MSDU_DESC_INFO0_LAST_MSDU_IN_MPDU);
+		rxcb->is_continuation = !!(le32_to_cpu(msdu_info->info0) &
+					   RX_MSDU_DESC_INFO0_MSDU_CONTINUATION);
+		rxcb->hw_link_id = hw_link_id;
+		rxcb->peer_id = ath12k_dp_rx_get_peer_id(ab, dp->peer_metadata_ver,
+							 mpdu_info->peer_meta_data);
+		rxcb->tid = le32_get_bits(mpdu_info->info0,
+					  RX_MPDU_DESC_INFO0_TID);
+
+		__skb_queue_tail(&msdu_list, msdu);
+
+		if (!rxcb->is_continuation) {
+			total_msdu_reaped++;
+			done = true;
+		} else {
+			done = false;
+		}
+
+		if (total_msdu_reaped >= budget)
+			break;
+	}
+
+	/* Hw might have updated the head pointer after we cached it.
+	 * In this case, even though there are entries in the ring we'll
+	 * get rx_desc NULL. Give the read another try with updated cached
+	 * head pointer so that we can reap complete MPDU in the current
+	 * rx processing.
+	 */
+	if (!done && ath12k_hal_srng_dst_num_free(ab, srng, true)) {
+		ath12k_hal_srng_access_end(ab, srng);
+		goto try_again;
+	}
+
+	ath12k_hal_srng_access_end(ab, srng);
+
+	spin_unlock_bh(&srng->lock);
+
+	if (!total_msdu_reaped)
+		goto exit;
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
+	ath12k_dp_rx_process_received_packets(ab, napi, &msdu_list,
+					      ring_id);
+
+exit:
+	return total_msdu_reaped;
+}
+
 static bool
 ath12k_dp_rx_h_defrag_validate_incr_pn(struct ath12k *ar, struct ath12k_dp_rx_tid *rx_tid)
 {
@@ -188,6 +651,70 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 	return ret;
 }
 
+static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer *peer,
+					  struct sk_buff *msdu)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
+	struct ieee80211_rx_status *rxs = IEEE80211_SKB_RXCB(msdu);
+	struct ieee80211_key_conf *key_conf;
+	struct ieee80211_hdr *hdr;
+	struct ath12k_dp_rx_info rx_info;
+	u8 mic[IEEE80211_CCMP_MIC_LEN];
+	int head_len, tail_len, ret;
+	size_t data_len;
+	u32 hdr_len, hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
+	u8 *key, *data;
+	u8 key_idx;
+
+	if (ath12k_dp_rx_h_enctype(ab, rx_desc) != HAL_ENCRYPT_TYPE_TKIP_MIC)
+		return 0;
+
+	rx_info.addr2_present = false;
+	rx_info.rx_status = rxs;
+
+	hdr = (struct ieee80211_hdr *)(msdu->data + hal_rx_desc_sz);
+	hdr_len = ieee80211_hdrlen(hdr->frame_control);
+	head_len = hdr_len + hal_rx_desc_sz + IEEE80211_TKIP_IV_LEN;
+	tail_len = IEEE80211_CCMP_MIC_LEN + IEEE80211_TKIP_ICV_LEN + FCS_LEN;
+
+	if (!is_multicast_ether_addr(hdr->addr1))
+		key_idx = peer->ucast_keyidx;
+	else
+		key_idx = peer->mcast_keyidx;
+
+	key_conf = peer->keys[key_idx];
+
+	data = msdu->data + head_len;
+	data_len = msdu->len - head_len - tail_len;
+	key = &key_conf->key[NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY];
+
+	ret = ath12k_dp_rx_h_michael_mic(peer->tfm_mmic, key, hdr, data, data_len, mic);
+	if (ret || memcmp(mic, data + data_len, IEEE80211_CCMP_MIC_LEN))
+		goto mic_fail;
+
+	return 0;
+
+mic_fail:
+	(ATH12K_SKB_RXCB(msdu))->is_first_msdu = true;
+	(ATH12K_SKB_RXCB(msdu))->is_last_msdu = true;
+
+	ath12k_dp_rx_h_fetch_info(ab, rx_desc, &rx_info);
+
+	rxs->flag |= RX_FLAG_MMIC_ERROR | RX_FLAG_MMIC_STRIPPED |
+		    RX_FLAG_IV_STRIPPED | RX_FLAG_DECRYPTED;
+	skb_pull(msdu, hal_rx_desc_sz);
+
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu)))
+		return -EINVAL;
+
+	ath12k_dp_rx_h_ppdu(ar, &rx_info);
+	ath12k_dp_rx_h_undecap(ar, msdu, rx_desc,
+			       HAL_ENCRYPT_TYPE_TKIP_MIC, rxs, true);
+	ieee80211_rx(ath12k_ar_to_hw(ar), msdu);
+	return -EINVAL;
+}
+
 static int ath12k_dp_rx_h_defrag(struct ath12k *ar,
 				 struct ath12k_peer *peer,
 				 struct ath12k_dp_rx_tid *rx_tid,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
index 9c2114c62ba2..fa44e454cee6 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -13,6 +13,9 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 				 struct napi_struct *napi, int budget);
 int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 			     int budget);
+int ath12k_dp_rx_process(struct ath12k_base *ab, int mac_id,
+			 struct napi_struct *napi,
+			 int budget);
 int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab);
 int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab);
 #endif
-- 
2.34.1


