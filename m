Return-Path: <linux-wireless+bounces-33964-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKVdDeoRxWkI6AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33964-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 12:00:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D508333EB4
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 12:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20B823093ABD
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E4E3C0634;
	Thu, 26 Mar 2026 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gfZq6mi1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3373394495;
	Thu, 26 Mar 2026 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774522473; cv=none; b=R5loCz+BxGFXhvKev32gTfIV4b63NSCBzp4kt69aHHvYvk3VYYDRPY6UsgDcKqSnGx0k3E2u42JbCyw18hV4SwS0vBLStSIdMr9QDRWIxcUfZqRqKqKsTnuAPJqju7f9IjhApE7ZT/I3eLPID8VLqOJnYa7him3W14HA9Embv/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774522473; c=relaxed/simple;
	bh=fLJwhXQ4n2ELjvZwMiP5eXAMaIvZKA1TP7R61zrhVN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SmkZ7sf5W/TzQxO3x5Q/4v/KdnxG7y8OfgI4dX52ImPVf/i0IuQyCtWH7JGjg2D0L6528qqKJJ1cQOEIEMoEppVUWWm2f8aY6ACITWsfLqub9qbtArP09gzkwHXKCkb7DOqMW7VgHYBOFXhzhhL8ep0EKQb+BE6ujmBNBgsuEus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gfZq6mi1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1774522470;
	bh=fLJwhXQ4n2ELjvZwMiP5eXAMaIvZKA1TP7R61zrhVN0=;
	h=From:Date:Subject:To:Cc:From;
	b=gfZq6mi11LaqBCAlw5/fsZzAqvtEiowHR6u4pTuSLvPeTOecKJyDYZzrSGjkLPNWE
	 tl2RskwHt7b+OS86LW8Lz/12QU9cAOS67mr50gK8r067N3ieitNOnO1KcqbXyj3bmo
	 NjedqKleSjgpYftCGN+yMHiMtXoq9WgGsHspffUBslyVlN/SHWnxwl08XOtqsgNTUd
	 3SUGaGhq9AIRlvlYZvoMuwWQT2BM9vvR4C/KIPjyqsOeGoUMk9IvLuhcsM6tg7l+iz
	 gET67Y2tVc0dCpoY3jtVCFZ7uOhnBW7hW95sB5NH2FFPKFRfc7GsDmNzuC5tdS6XlP
	 Vp7q3QVggEBDA==
Received: from goku6.local (ncb.1e0.uk [5.83.15.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mattl)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E0C8817E460B;
	Thu, 26 Mar 2026 11:54:29 +0100 (CET)
From: Matthew Leach <matthew.leach@collabora.com>
Date: Thu, 26 Mar 2026 10:53:53 +0000
Subject: [PATCH] ath11k: workaround firmware bug where peer_id=0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-ath11k-null-peerid-workaround-v1-1-0c2fd53202f8@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBBA4auQWTsJM4b6cxXDotBRKqQlU6omh
 LtTdfkt3lshiXpJcK1WUHn55GMooEMF/WDDQ9C7YuCaTX1kg3YZiEYMeZpwlhI7fEcdrcYcHBp
 uLPHldKaOoDxmlbv//P639u+Uu6f0y3cK27YDIDyLk4EAAAA=
X-Change-ID: 20260326-ath11k-null-peerid-workaround-625a129781b1
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Matthew Leach <matthew.leach@collabora.com>
X-Mailer: b4 0.15.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33964-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.leach@collabora.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,collabora.com:email,collabora.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D508333EB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It has been observed that under certain conditions the ath11k firmware
sets the peer_id=0 for RX'd frames. For standard MPDUs this is fine as
ath11k_dp_rx_h_find_peer() has a fallback case where it locates the peer
based upon the source mac address.

However, on an aggregated link, reception of an A-MSDU results in the
peer not being resolved for the second (any any subsequent) sub-MSDUs.
This causes the encryption type of the frame to be set to an incorrect
value, resulting in the sub-MSDUs being dropped by ieee80211. Notice how
the flags differ in:

ath11k_pci 0000:03:00.0: data rx skb 000000002f4b704d len 1534 peer xx:xx:xx:xx:xx:xx 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d1a fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 1 last_msdu 0
ath11k_pci 0000:03:00.0: data rx skb 0000000038acd580 len 1534 peer (null) 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d00 fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 0 last_msdu 1

This patch caches the peer enctype during the MSDU processing loop,
caching it on the first AMSDU sub-frame (is_first_msdu=1 is_last_msdu=0)
and setting the correct enctype for any subsequent sub-MSDUs.

Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 35 ++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 49d959b2e148..f5c2a8085a1b 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -21,6 +21,12 @@
 
 #define ATH11K_DP_RX_FRAGMENT_TIMEOUT_MS (2 * HZ)
 
+struct cached_peer_info {
+	enum hal_encrypt_type enctype;
+	u16 seq_no;
+	bool valid;
+};
+
 static inline
 u8 *ath11k_dp_rx_h_80211_hdr(struct ath11k_base *ab, struct hal_rx_desc *desc)
 {
@@ -2232,7 +2238,8 @@ ath11k_dp_rx_h_find_peer(struct ath11k_base *ab, struct sk_buff *msdu)
 static void ath11k_dp_rx_h_mpdu(struct ath11k *ar,
 				struct sk_buff *msdu,
 				struct hal_rx_desc *rx_desc,
-				struct ieee80211_rx_status *rx_status)
+				struct ieee80211_rx_status *rx_status,
+				struct cached_peer_info *peer_cache)
 {
 	bool  fill_crypto_hdr;
 	enum hal_encrypt_type enctype;
@@ -2265,6 +2272,21 @@ static void ath11k_dp_rx_h_mpdu(struct ath11k *ar,
 	}
 	spin_unlock_bh(&ar->ab->base_lock);
 
+	if (!rxcb->peer_id && rxcb->is_first_msdu && !rxcb->is_last_msdu) {
+		peer_cache->enctype = enctype;
+		peer_cache->seq_no = rxcb->seq_no;
+		peer_cache->valid = true;
+	}
+
+	if (!rxcb->peer_id && !rxcb->is_first_msdu && peer_cache->valid) {
+		if (rxcb->seq_no == peer_cache->seq_no)
+			enctype = peer_cache->enctype;
+		else
+			ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
+				   "null peer_id workaround failed. cached seq_no=%d, msdu seq_no=%d",
+				   peer_cache->seq_no, rxcb->seq_no);
+	}
+
 	rx_attention = ath11k_dp_rx_get_attention(ar->ab, rx_desc);
 	err_bitmap = ath11k_dp_rx_h_attn_mpdu_err(rx_attention);
 	if (enctype != HAL_ENCRYPT_TYPE_OPEN && !err_bitmap)
@@ -2506,7 +2528,8 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
 static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 				     struct sk_buff *msdu,
 				     struct sk_buff_head *msdu_list,
-				     struct ieee80211_rx_status *rx_status)
+				     struct ieee80211_rx_status *rx_status,
+				     struct cached_peer_info *peer_cache)
 {
 	struct ath11k_base *ab = ar->ab;
 	struct hal_rx_desc *rx_desc, *lrx_desc;
@@ -2574,7 +2597,7 @@ static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 	}
 
 	ath11k_dp_rx_h_ppdu(ar, rx_desc, rx_status);
-	ath11k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_status);
+	ath11k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_status, peer_cache);
 
 	rx_status->flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
 
@@ -2592,6 +2615,7 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 	struct sk_buff *msdu;
 	struct ath11k *ar;
 	struct ieee80211_rx_status rx_status = {};
+	struct cached_peer_info peer_cache = {};
 	int ret;
 
 	if (skb_queue_empty(msdu_list))
@@ -2609,7 +2633,7 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 	}
 
 	while ((msdu = __skb_dequeue(msdu_list))) {
-		ret = ath11k_dp_rx_process_msdu(ar, msdu, msdu_list, &rx_status);
+		ret = ath11k_dp_rx_process_msdu(ar, msdu, msdu_list, &rx_status, &peer_cache);
 		if (unlikely(ret)) {
 			ath11k_dbg(ab, ATH11K_DBG_DATA,
 				   "Unable to process msdu %d", ret);
@@ -3959,6 +3983,7 @@ static int ath11k_dp_rx_h_null_q_desc(struct ath11k *ar, struct sk_buff *msdu,
 	u8 l3pad_bytes;
 	struct ath11k_skb_rxcb *rxcb = ATH11K_SKB_RXCB(msdu);
 	u32 hal_rx_desc_sz = ar->ab->hw_params.hal_desc_sz;
+	struct cached_peer_info peer_cache = {};
 
 	msdu_len = ath11k_dp_rx_h_msdu_start_msdu_len(ar->ab, desc);
 
@@ -4002,7 +4027,7 @@ static int ath11k_dp_rx_h_null_q_desc(struct ath11k *ar, struct sk_buff *msdu,
 	}
 	ath11k_dp_rx_h_ppdu(ar, desc, status);
 
-	ath11k_dp_rx_h_mpdu(ar, msdu, desc, status);
+	ath11k_dp_rx_h_mpdu(ar, msdu, desc, status, &peer_cache);
 
 	rxcb->tid = ath11k_dp_rx_h_mpdu_start_tid(ar->ab, desc);
 

---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260326-ath11k-null-peerid-workaround-625a129781b1

Best regards,
--  
Matt


