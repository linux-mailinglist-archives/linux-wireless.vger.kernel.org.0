Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A9E37ADAA
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 20:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhEKSEh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 14:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKSEX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 14:04:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B9EC06138E;
        Tue, 11 May 2021 11:03:13 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lgWit-007aAS-Ha; Tue, 11 May 2021 20:03:11 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Wen Gong <wgong@codeaurora.org>, stable@vger.kernel.org
Subject: [PATCH 11/18] ath10k: add CCMP PN replay protection for fragmented frames for PCIe
Date:   Tue, 11 May 2021 20:02:52 +0200
Message-Id: <20210511200110.9ba2664866a4.I756e47b67e210dba69966d989c4711ffc02dc6bc@changeid>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511180259.159598-1-johannes@sipsolutions.net>
References: <20210511180259.159598-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>

PN replay check for not fragmented frames is finished in the firmware,
but this was not done for fragmented frames when ath10k is used with
QCA6174/QCA6377 PCIe. mac80211 has the function
ieee80211_rx_h_defragment() for PN replay check for fragmented frames,
but this does not get checked with QCA6174 due to the
ieee80211_has_protected() condition not matching the cleared Protected
bit case.

Validate the PN of received fragmented frames within ath10k when CCMP is
used and drop the fragment if the PN is not correct (incremented by
exactly one from the previous fragment). This applies only for
QCA6174/QCA6377 PCIe.

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1

Cc: stable@vger.kernel.org
Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath10k/htt.h    |  1 +
 drivers/net/wireless/ath/ath10k/htt_rx.c | 99 +++++++++++++++++++++++-
 2 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
index 956157946106..dbc8aef82a65 100644
--- a/drivers/net/wireless/ath/ath10k/htt.h
+++ b/drivers/net/wireless/ath/ath10k/htt.h
@@ -845,6 +845,7 @@ enum htt_security_types {
 
 #define ATH10K_HTT_TXRX_PEER_SECURITY_MAX 2
 #define ATH10K_TXRX_NUM_EXT_TIDS 19
+#define ATH10K_TXRX_NON_QOS_TID 16
 
 enum htt_security_flags {
 #define HTT_SECURITY_TYPE_MASK 0x7F
diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 1a08156d5011..f1e5bce8b14f 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1746,16 +1746,87 @@ static void ath10k_htt_rx_h_csum_offload(struct sk_buff *msdu)
 	msdu->ip_summed = ath10k_htt_rx_get_csum_state(msdu);
 }
 
+static u64 ath10k_htt_rx_h_get_pn(struct ath10k *ar, struct sk_buff *skb,
+				  u16 offset,
+				  enum htt_rx_mpdu_encrypt_type enctype)
+{
+	struct ieee80211_hdr *hdr;
+	u64 pn = 0;
+	u8 *ehdr;
+
+	hdr = (struct ieee80211_hdr *)(skb->data + offset);
+	ehdr = skb->data + offset + ieee80211_hdrlen(hdr->frame_control);
+
+	if (enctype == HTT_RX_MPDU_ENCRYPT_AES_CCM_WPA2) {
+		pn = ehdr[0];
+		pn |= (u64)ehdr[1] << 8;
+		pn |= (u64)ehdr[4] << 16;
+		pn |= (u64)ehdr[5] << 24;
+		pn |= (u64)ehdr[6] << 32;
+		pn |= (u64)ehdr[7] << 40;
+	}
+	return pn;
+}
+
+static bool ath10k_htt_rx_h_frag_pn_check(struct ath10k *ar,
+					  struct sk_buff *skb,
+					  u16 peer_id,
+					  u16 offset,
+					  enum htt_rx_mpdu_encrypt_type enctype)
+{
+	struct ath10k_peer *peer;
+	union htt_rx_pn_t *last_pn, new_pn = {0};
+	struct ieee80211_hdr *hdr;
+	bool more_frags;
+	u8 tid, frag_number;
+	u32 seq;
+
+	peer = ath10k_peer_find_by_id(ar, peer_id);
+	if (!peer) {
+		ath10k_dbg(ar, ATH10K_DBG_HTT, "invalid peer for frag pn check\n");
+		return false;
+	}
+
+	hdr = (struct ieee80211_hdr *)(skb->data + offset);
+	if (ieee80211_is_data_qos(hdr->frame_control))
+		tid = ieee80211_get_tid(hdr);
+	else
+		tid = ATH10K_TXRX_NON_QOS_TID;
+
+	last_pn = &peer->frag_tids_last_pn[tid];
+	new_pn.pn48 = ath10k_htt_rx_h_get_pn(ar, skb, offset, enctype);
+	more_frags = ieee80211_has_morefrags(hdr->frame_control);
+	frag_number = le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_FRAG;
+	seq = (__le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_SEQ) >> 4;
+
+	if (frag_number == 0) {
+		last_pn->pn48 = new_pn.pn48;
+		peer->frag_tids_seq[tid] = seq;
+	} else {
+		if (seq != peer->frag_tids_seq[tid])
+			return false;
+
+		if (new_pn.pn48 != last_pn->pn48 + 1)
+			return false;
+
+		last_pn->pn48 = new_pn.pn48;
+	}
+
+	return true;
+}
+
 static void ath10k_htt_rx_h_mpdu(struct ath10k *ar,
 				 struct sk_buff_head *amsdu,
 				 struct ieee80211_rx_status *status,
 				 bool fill_crypt_header,
 				 u8 *rx_hdr,
-				 enum ath10k_pkt_rx_err *err)
+				 enum ath10k_pkt_rx_err *err,
+				 u16 peer_id,
+				 bool frag)
 {
 	struct sk_buff *first;
 	struct sk_buff *last;
-	struct sk_buff *msdu;
+	struct sk_buff *msdu, *temp;
 	struct htt_rx_desc *rxd;
 	struct ieee80211_hdr *hdr;
 	enum htt_rx_mpdu_encrypt_type enctype;
@@ -1768,6 +1839,7 @@ static void ath10k_htt_rx_h_mpdu(struct ath10k *ar,
 	bool is_decrypted;
 	bool is_mgmt;
 	u32 attention;
+	bool frag_pn_check = true;
 
 	if (skb_queue_empty(amsdu))
 		return;
@@ -1866,6 +1938,24 @@ static void ath10k_htt_rx_h_mpdu(struct ath10k *ar,
 	}
 
 	skb_queue_walk(amsdu, msdu) {
+		if (frag && !fill_crypt_header && is_decrypted &&
+		    enctype == HTT_RX_MPDU_ENCRYPT_AES_CCM_WPA2)
+			frag_pn_check = ath10k_htt_rx_h_frag_pn_check(ar,
+								      msdu,
+								      peer_id,
+								      0,
+								      enctype);
+
+		if (!frag_pn_check) {
+			/* Discard the fragment with invalid PN */
+			temp = msdu->prev;
+			__skb_unlink(msdu, amsdu);
+			dev_kfree_skb_any(msdu);
+			msdu = temp;
+			frag_pn_check = true;
+			continue;
+		}
+
 		ath10k_htt_rx_h_csum_offload(msdu);
 		ath10k_htt_rx_h_undecap(ar, msdu, status, first_hdr, enctype,
 					is_decrypted);
@@ -2071,7 +2161,8 @@ static int ath10k_htt_rx_handle_amsdu(struct ath10k_htt *htt)
 		ath10k_htt_rx_h_unchain(ar, &amsdu, &drop_cnt, &unchain_cnt);
 
 	ath10k_htt_rx_h_filter(ar, &amsdu, rx_status, &drop_cnt_filter);
-	ath10k_htt_rx_h_mpdu(ar, &amsdu, rx_status, true, first_hdr, &err);
+	ath10k_htt_rx_h_mpdu(ar, &amsdu, rx_status, true, first_hdr, &err, 0,
+			     false);
 	msdus_to_queue = skb_queue_len(&amsdu);
 	ath10k_htt_rx_h_enqueue(ar, &amsdu, rx_status);
 
@@ -3027,7 +3118,7 @@ static int ath10k_htt_rx_in_ord_ind(struct ath10k *ar, struct sk_buff *skb)
 			ath10k_htt_rx_h_ppdu(ar, &amsdu, status, vdev_id);
 			ath10k_htt_rx_h_filter(ar, &amsdu, status, NULL);
 			ath10k_htt_rx_h_mpdu(ar, &amsdu, status, false, NULL,
-					     NULL);
+					     NULL, peer_id, frag);
 			ath10k_htt_rx_h_enqueue(ar, &amsdu, status);
 			break;
 		case -EAGAIN:
-- 
2.30.2

