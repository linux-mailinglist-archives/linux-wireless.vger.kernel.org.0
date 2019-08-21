Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B65497237
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 08:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfHUGXj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 02:23:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41140 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfHUGXi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 02:23:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C38D16086B; Wed, 21 Aug 2019 06:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566368617;
        bh=rzjKhbTyblZNDpsKh1zHIuWUaxGg9PD2Pu58sAWO9Pc=;
        h=From:To:Cc:Subject:Date:From;
        b=VdP461x5meXuVekGwYJmnKwybncVMXLqb1hEyd1fIUPGOsQrD5JFE8MRDayMC48gM
         76auXd0GLJkP2aJvwVIYEeCsAXOPhRUvmaC2qJgZw7+LpmIDgLk1/iV1mgG9ArM9Yc
         +PIDzMrUn2fljdHw+1mupI4QZNsXntCTHJHOVOzA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B0F8608FF;
        Wed, 21 Aug 2019 06:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566368617;
        bh=rzjKhbTyblZNDpsKh1zHIuWUaxGg9PD2Pu58sAWO9Pc=;
        h=From:To:Cc:Subject:Date:From;
        b=VdP461x5meXuVekGwYJmnKwybncVMXLqb1hEyd1fIUPGOsQrD5JFE8MRDayMC48gM
         76auXd0GLJkP2aJvwVIYEeCsAXOPhRUvmaC2qJgZw7+LpmIDgLk1/iV1mgG9ArM9Yc
         +PIDzMrUn2fljdHw+1mupI4QZNsXntCTHJHOVOzA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B0F8608FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: add reorder and change PN check logic for mac80211
Date:   Wed, 21 Aug 2019 14:23:25 +0800
Message-Id: <1566368605-20109-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For sdio chip, if the rssi is not good, then it have some retry,
firmware will indicate the msdu list of a ppdu with a hole, it
means it lost the hole msdu, after the msdu retry from AP, the
hole msdu will indicate from firmware later. The hole msdu's PN
check will fail and the hole msdu will be dropped.

PN check fail example:
Sequence number PN number  PN check status
     3814         6101         success
     3815         6102         success
     3816         6103         success
     3818         6105         success
     3819         6106         success
     3820         6107         success
     3817         6104         fail

The correct logic is reorder the msdu list and then do PN check.
ieee80211_rx_reorder_ampdu of mac80211 will do the reorer logic
and then do PN check in ieee80211_rx_h_decrypt of mac80211.

example after reorder:
Sequence number PN number  PN check status
     3814         6101         success
     3815         6102         success
     3816         6103         success
     3817         6104         success
     3818         6105         success
     3819         6106         success
     3820         6107         success

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00017-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 91 +++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 83a7fb6..53f1095 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -2151,6 +2151,10 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 	struct ath10k_peer *peer;
 	struct htt_rx_indication_mpdu_range *mpdu_ranges;
 	struct fw_rx_desc_hl *fw_desc;
+	enum htt_txrx_sec_cast_type sec_index;
+	enum htt_security_types sec_type;
+	union htt_rx_pn_t new_pn = {0};
+	struct htt_hl_rx_desc *rx_desc;
 	struct ieee80211_hdr *hdr;
 	struct ieee80211_rx_status *rx_status;
 	u16 peer_id;
@@ -2158,9 +2162,11 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 	int num_mpdu_ranges;
 	size_t tot_hdr_len;
 	struct ieee80211_channel *ch;
-	bool pn_invalid;
+	bool pn_invalid, qos, first_msdu;
+	u32 tid, rx_desc_info;
 
 	peer_id = __le16_to_cpu(rx->hdr.peer_id);
+	tid = MS(rx->hdr.info0, HTT_RX_INDICATION_INFO0_EXT_TID);
 
 	spin_lock_bh(&ar->data_lock);
 	peer = ath10k_peer_find_by_id(ar, peer_id);
@@ -2168,6 +2174,9 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 	if (!peer && peer_id != HTT_INVALID_PEERID)
 		ath10k_warn(ar, "Got RX ind from invalid peer: %u\n", peer_id);
 
+	if (!peer)
+		return true;
+
 	num_mpdu_ranges = MS(__le32_to_cpu(rx->hdr.info1),
 			     HTT_RX_INDICATION_INFO1_NUM_MPDU_RANGES);
 	mpdu_ranges = htt_rx_ind_get_mpdu_ranges_hl(rx);
@@ -2192,10 +2201,24 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 		goto err;
 	}
 
-	if (check_pn_type == HTT_RX_PN_CHECK) {
+	rx_desc = (struct htt_hl_rx_desc *)&rx->mpdu_ranges[num_mpdu_ranges];
+	rx_desc_info = __le32_to_cpu(rx_desc->info);
+
+	if (MS(rx_desc_info, HTT_RX_DESC_HL_INFO_MCAST_BCAST))
+		sec_index = HTT_TXRX_SEC_MCAST;
+	else
+		sec_index = HTT_TXRX_SEC_UCAST;
+
+	sec_type = peer->rx_pn[sec_index].sec_type;
+	first_msdu = rx->fw_desc.flags & FW_RX_DESC_FLAGS_FIRST_MSDU;
+
+	ath10k_htt_rx_mpdu_desc_pn_hl(rx_desc, &new_pn, peer->rx_pn[sec_index].pn_len);
+
+	if (check_pn_type == HTT_RX_PN_CHECK && tid >= IEEE80211_NUM_TIDS) {
 		spin_lock_bh(&ar->data_lock);
 		pn_invalid = ath10k_htt_rx_pn_check_replay_hl(ar, peer, rx);
 		spin_unlock_bh(&ar->data_lock);
+
 		if (pn_invalid)
 			goto err;
 	}
@@ -2211,6 +2234,7 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 	skb_pull(skb, tot_hdr_len);
 
 	hdr = (struct ieee80211_hdr *)skb->data;
+	qos = ieee80211_is_data_qos(hdr->frame_control);
 	rx_status = IEEE80211_SKB_RXCB(skb);
 	rx_status->chains |= BIT(0);
 	if (rx->ppdu.combined_rssi == 0) {
@@ -2254,6 +2278,55 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 		rx_status->flag |= RX_FLAG_DECRYPTED |
 				   RX_FLAG_IV_STRIPPED |
 				   RX_FLAG_MMIC_STRIPPED;
+
+		if (tid < IEEE80211_NUM_TIDS &&
+		    first_msdu &&
+		    check_pn_type == HTT_RX_PN_CHECK &&
+		   (sec_type == HTT_SECURITY_AES_CCMP ||
+		    sec_type == HTT_SECURITY_TKIP ||
+		    sec_type == HTT_SECURITY_TKIP_NOMIC)) {
+			u8 offset, *ivp, i;
+			s8 keyidx = 0;
+			__le64 pn48 = cpu_to_le64(new_pn.pn48);
+
+			hdr = (struct ieee80211_hdr *)skb->data;
+			offset = ieee80211_hdrlen(hdr->frame_control);
+			hdr->frame_control |= __cpu_to_le16(IEEE80211_FCTL_PROTECTED);
+			rx_status->flag &= ~RX_FLAG_IV_STRIPPED;
+
+			memmove(skb->data - IEEE80211_CCMP_HDR_LEN,
+				skb->data, offset);
+			skb_push(skb, IEEE80211_CCMP_HDR_LEN);
+			ivp = skb->data + offset;
+			memset(skb->data + offset, 0, IEEE80211_CCMP_HDR_LEN);
+			/* Ext IV */
+			ivp[IEEE80211_WEP_IV_LEN - 1] |= ATH10K_IEEE80211_EXTIV;
+
+			for (i = 0; i < ARRAY_SIZE(peer->keys); i++) {
+				if (peer->keys[i] &&
+				    peer->keys[i]->flags & IEEE80211_KEY_FLAG_PAIRWISE)
+					keyidx = peer->keys[i]->keyidx;
+			}
+
+			/* Key ID */
+			ivp[IEEE80211_WEP_IV_LEN - 1] |= keyidx << 6;
+
+			if (sec_type == HTT_SECURITY_AES_CCMP) {
+				rx_status->flag |= RX_FLAG_MIC_STRIPPED;
+				/* pn 0, pn 1 */
+				memcpy(skb->data + offset, &pn48, 2);
+				/* pn 1, pn 3 , pn 34 , pn 5 */
+				memcpy(skb->data + offset + 4, ((u8 *)&pn48) + 2, 4);
+			} else {
+				rx_status->flag |= RX_FLAG_ICV_STRIPPED;
+				/* TSC 0 */
+				memcpy(skb->data + offset + 2, &pn48, 1);
+				/* TSC 1 */
+				memcpy(skb->data + offset, ((u8 *)&pn48) + 1, 1);
+				/* TSC 2 , TSC 3 , TSC 4 , TSC 5*/
+				memcpy(skb->data + offset + 4, ((u8 *)&pn48) + 2, 4);
+			}
+		}
 	}
 
 	if (tkip_mic_type == HTT_RX_TKIP_MIC)
@@ -2263,6 +2336,20 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 	if (mpdu_ranges->mpdu_range_status == HTT_RX_IND_MPDU_STATUS_TKIP_MIC_ERR)
 		rx_status->flag |= RX_FLAG_MMIC_ERROR;
 
+	if (!qos && tid < IEEE80211_NUM_TIDS) {
+		u8 offset;
+		__le16 qos_ctrl = 0;
+
+		hdr = (struct ieee80211_hdr *)skb->data;
+		offset = ieee80211_hdrlen(hdr->frame_control);
+
+		hdr->frame_control |= cpu_to_le16(IEEE80211_STYPE_QOS_DATA);
+		memmove(skb->data - IEEE80211_QOS_CTL_LEN, skb->data, offset);
+		skb_push(skb, IEEE80211_QOS_CTL_LEN);
+		qos_ctrl = cpu_to_le16(tid);
+		memcpy(skb->data + offset, &qos_ctrl, IEEE80211_QOS_CTL_LEN);
+	}
+
 	ieee80211_rx_ni(ar->hw, skb);
 
 	/* We have delivered the skb to the upper layers (mac80211) so we
-- 
1.9.1

