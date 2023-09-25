Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3797ADB5A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 17:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjIYPZ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 11:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjIYPZX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 11:25:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED24C10A
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=zv8PqxgQstARFqaOcV85dK7SSjxzWus4TSIVHqVDmoE=; t=1695655516; x=1696865116; 
        b=ZP5riABKAXMAwHq9JSDEGdi8urYiNB3Z9lQaVJeB4WjTSqY40aiXyHs/uUKdo7D7d44T4uEwXx2
        qecXZCuwShAxEPdes0aOy5iFddpu4mL08WaZAFds995Wcd+uUI/tBk6ytMUBz7fcFTW3BlpZZ0wCz
        9X7crfwb1Mw8BgevkmVnJ7sqnBHa/Rp/aenJgElrvXPqZ9JKbeXtxJV6cn26ISQDHmUMlj33bVU5B
        Uwm1pfWQYR212Rlij8/0TFIsVxmqKzBRiV2o29/s3h/aZIPZWOfsl0Jcr1y2S1QzGZkMwL+YQ07jp
        Py+UWIXRnBOZAkGX8gell9Fp3iUKTWVJyIgA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qknST-003kq9-0X;
        Mon, 25 Sep 2023 17:25:13 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/3] wifi: mac80211: remove RX_DROP_UNUSABLE
Date:   Mon, 25 Sep 2023 17:25:09 +0200
Message-ID: <20230925172508.bc62dfb8a129.I9d64271b6d375aa87c8cac82145823374800b246@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Convert all instances of RX_DROP_UNUSABLE to indicate a
better reason, and then remove RX_DROP_UNUSABLE.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/drop.h | 33 +++++++++++++++++++++++++++-
 net/mac80211/rx.c   | 52 ++++++++++++++++++++++-----------------------
 net/mac80211/wep.c  |  9 ++++----
 net/mac80211/wpa.c  | 42 ++++++++++++++++++------------------
 4 files changed, 84 insertions(+), 52 deletions(-)

diff --git a/net/mac80211/drop.h b/net/mac80211/drop.h
index 1570fac8411f..725a07a5b614 100644
--- a/net/mac80211/drop.h
+++ b/net/mac80211/drop.h
@@ -21,6 +21,38 @@ typedef unsigned int __bitwise ieee80211_rx_result;
 	R(RX_DROP_U_MIC_FAIL)			\
 	R(RX_DROP_U_REPLAY)			\
 	R(RX_DROP_U_BAD_MMIE)			\
+	R(RX_DROP_U_DUP)			\
+	R(RX_DROP_U_SPURIOUS)			\
+	R(RX_DROP_U_DECRYPT_FAIL)		\
+	R(RX_DROP_U_NO_KEY_ID)			\
+	R(RX_DROP_U_BAD_CIPHER)			\
+	R(RX_DROP_U_OOM)			\
+	R(RX_DROP_U_NONSEQ_PN)			\
+	R(RX_DROP_U_BAD_KEY_COLOR)		\
+	R(RX_DROP_U_BAD_4ADDR)			\
+	R(RX_DROP_U_BAD_AMSDU)			\
+	R(RX_DROP_U_BAD_AMSDU_CIPHER)		\
+	R(RX_DROP_U_INVALID_8023)		\
+	R(RX_DROP_U_RUNT_ACTION)		\
+	R(RX_DROP_U_UNPROT_ACTION)		\
+	R(RX_DROP_U_ACTION_UNKNOWN_SRC)		\
+	R(RX_DROP_U_REJECTED_ACTION_RESPONSE)	\
+	R(RX_DROP_U_EXPECT_DEFRAG_PROT)		\
+	R(RX_DROP_U_WEP_DEC_FAIL)		\
+	R(RX_DROP_U_NO_IV)			\
+	R(RX_DROP_U_NO_ICV)			\
+	R(RX_DROP_U_AP_RX_GROUPCAST)		\
+	R(RX_DROP_U_SHORT_MMIC)			\
+	R(RX_DROP_U_MMIC_FAIL)			\
+	R(RX_DROP_U_SHORT_TKIP)			\
+	R(RX_DROP_U_TKIP_FAIL)			\
+	R(RX_DROP_U_SHORT_CCMP)			\
+	R(RX_DROP_U_SHORT_CCMP_MIC)		\
+	R(RX_DROP_U_SHORT_GCMP)			\
+	R(RX_DROP_U_SHORT_GCMP_MIC)		\
+	R(RX_DROP_U_SHORT_CMAC)			\
+	R(RX_DROP_U_SHORT_CMAC256)		\
+	R(RX_DROP_U_SHORT_GMAC)			\
 /* this line for the trailing \ - add before this */
 
 /* having two enums allows for checking ieee80211_rx_result use with sparse */
@@ -46,7 +78,6 @@ enum mac80211_drop_reason {
 	RX_CONTINUE	 = (__force ieee80211_rx_result)___RX_CONTINUE,
 	RX_QUEUED	 = (__force ieee80211_rx_result)___RX_QUEUED,
 	RX_DROP_MONITOR	 = (__force ieee80211_rx_result)___RX_DROP_MONITOR,
-	RX_DROP_UNUSABLE = (__force ieee80211_rx_result)___RX_DROP_UNUSABLE,
 #define DEF(x) x = (__force ieee80211_rx_result)___ ## x,
 	MAC80211_DROP_REASONS_MONITOR(DEF)
 	MAC80211_DROP_REASONS_UNUSABLE(DEF)
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 944adc9a51f1..1851b86fc5fd 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1436,7 +1436,7 @@ ieee80211_rx_h_check_dup(struct ieee80211_rx_data *rx)
 		     rx->sta->last_seq_ctrl[rx->seqno_idx] == hdr->seq_ctrl)) {
 		I802_DEBUG_INC(rx->local->dot11FrameDuplicateCount);
 		rx->link_sta->rx_stats.num_duplicates++;
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_DUP;
 	} else if (!(status->flag & RX_FLAG_AMSDU_MORE)) {
 		rx->sta->last_seq_ctrl[rx->seqno_idx] = hdr->seq_ctrl;
 	}
@@ -1490,7 +1490,7 @@ ieee80211_rx_h_check(struct ieee80211_rx_data *rx)
 		    cfg80211_rx_spurious_frame(rx->sdata->dev,
 					       hdr->addr2,
 					       GFP_ATOMIC))
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_SPURIOUS;
 
 		return RX_DROP_MONITOR;
 	}
@@ -1883,7 +1883,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	int keyidx;
-	ieee80211_rx_result result = RX_DROP_UNUSABLE;
+	ieee80211_rx_result result = RX_DROP_U_DECRYPT_FAIL;
 	struct ieee80211_key *sta_ptk = NULL;
 	struct ieee80211_key *ptk_idx = NULL;
 	int mmie_keyidx = -1;
@@ -1933,7 +1933,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 			keyid = ieee80211_get_keyid(rx->skb);
 
 			if (unlikely(keyid < 0))
-				return RX_DROP_UNUSABLE;
+				return RX_DROP_U_NO_KEY_ID;
 
 			ptk_idx = rcu_dereference(rx->sta->ptk[keyid]);
 		}
@@ -2038,7 +2038,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 		keyidx = ieee80211_get_keyid(rx->skb);
 
 		if (unlikely(keyidx < 0))
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_NO_KEY_ID;
 
 		/* check per-station GTK first, if multicast packet */
 		if (is_multicast_ether_addr(hdr->addr1) && rx->link_sta)
@@ -2104,7 +2104,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 		result = ieee80211_crypto_gcmp_decrypt(rx);
 		break;
 	default:
-		result = RX_DROP_UNUSABLE;
+		result = RX_DROP_U_BAD_CIPHER;
 	}
 
 	/* the hdr variable is invalid after the decrypt handlers */
@@ -2249,7 +2249,7 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 	I802_DEBUG_INC(rx->local->rx_handlers_fragments);
 
 	if (skb_linearize(rx->skb))
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_OOM;
 
 	/*
 	 *  skb_linearize() might change the skb->data and
@@ -2312,11 +2312,11 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 		u8 pn[IEEE80211_CCMP_PN_LEN], *rpn;
 
 		if (!requires_sequential_pn(rx, fc))
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_NONSEQ_PN;
 
 		/* Prevent mixed key and fragment cache attacks */
 		if (entry->key_color != rx->key->color)
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_BAD_KEY_COLOR;
 
 		memcpy(pn, entry->last_pn, IEEE80211_CCMP_PN_LEN);
 		for (i = IEEE80211_CCMP_PN_LEN - 1; i >= 0; i--) {
@@ -2327,7 +2327,7 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 
 		rpn = rx->ccm_gcm.pn;
 		if (memcmp(pn, rpn, IEEE80211_CCMP_PN_LEN))
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_REPLAY;
 		memcpy(entry->last_pn, pn, IEEE80211_CCMP_PN_LEN);
 	} else if (entry->is_protected &&
 		   (!rx->key ||
@@ -2338,11 +2338,11 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 		 * if for TKIP Michael MIC should protect us, and WEP is a
 		 * lost cause anyway.
 		 */
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_EXPECT_DEFRAG_PROT;
 	} else if (entry->is_protected && rx->key &&
 		   entry->key_color != rx->key->color &&
 		   (status->flag & RX_FLAG_DECRYPTED)) {
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_BAD_KEY_COLOR;
 	}
 
 	skb_pull(rx->skb, ieee80211_hdrlen(fc));
@@ -2361,7 +2361,7 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 					      GFP_ATOMIC))) {
 			I802_DEBUG_INC(rx->local->rx_handlers_drop_defrag);
 			__skb_queue_purge(&entry->skb_list);
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_OOM;
 		}
 	}
 	while ((skb = __skb_dequeue(&entry->skb_list))) {
@@ -2904,10 +2904,10 @@ ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta
 		skb = NULL;
 
 		if (skb_cow_head(fwd_skb, hdrlen - sizeof(struct ethhdr)))
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_OOM;
 
 		if (skb_linearize(fwd_skb))
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_OOM;
 	}
 
 	fwd_hdr = skb_push(fwd_skb, hdrlen - sizeof(struct ethhdr));
@@ -3003,7 +3003,7 @@ __ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx, u8 data_offset)
 					  rx->sdata->vif.addr,
 					  rx->sdata->vif.type,
 					  data_offset, true))
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_BAD_AMSDU;
 
 	if (rx->sta->amsdu_mesh_control < 0) {
 		s8 valid = -1;
@@ -3078,21 +3078,21 @@ ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx)
 		switch (rx->sdata->vif.type) {
 		case NL80211_IFTYPE_AP_VLAN:
 			if (!rx->sdata->u.vlan.sta)
-				return RX_DROP_UNUSABLE;
+				return RX_DROP_U_BAD_4ADDR;
 			break;
 		case NL80211_IFTYPE_STATION:
 			if (!rx->sdata->u.mgd.use_4addr)
-				return RX_DROP_UNUSABLE;
+				return RX_DROP_U_BAD_4ADDR;
 			break;
 		case NL80211_IFTYPE_MESH_POINT:
 			break;
 		default:
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_BAD_4ADDR;
 		}
 	}
 
 	if (is_multicast_ether_addr(hdr->addr1) || !rx->sta)
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_BAD_AMSDU;
 
 	if (rx->key) {
 		/*
@@ -3105,7 +3105,7 @@ ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx)
 		case WLAN_CIPHER_SUITE_WEP40:
 		case WLAN_CIPHER_SUITE_WEP104:
 		case WLAN_CIPHER_SUITE_TKIP:
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_BAD_AMSDU_CIPHER;
 		default:
 			break;
 		}
@@ -3147,7 +3147,7 @@ ieee80211_rx_h_data(struct ieee80211_rx_data *rx)
 
 	err = __ieee80211_data_to_8023(rx, &port_control);
 	if (unlikely(err))
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_INVALID_8023;
 
 	res = ieee80211_rx_mesh_data(rx->sdata, rx->sta, rx->skb);
 	if (res != RX_CONTINUE)
@@ -3379,7 +3379,7 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 	/* drop too small action frames */
 	if (ieee80211_is_action(mgmt->frame_control) &&
 	    rx->skb->len < IEEE80211_MIN_ACTION_SIZE)
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_RUNT_ACTION;
 
 	if (rx->sdata->vif.type == NL80211_IFTYPE_AP &&
 	    ieee80211_is_beacon(mgmt->frame_control) &&
@@ -3401,7 +3401,7 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 	}
 
 	if (ieee80211_drop_unencrypted_mgmt(rx))
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_UNPROT_ACTION;
 
 	return RX_CONTINUE;
 }
@@ -3473,7 +3473,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 	if (!rx->sta && mgmt->u.action.category != WLAN_CATEGORY_PUBLIC &&
 	    mgmt->u.action.category != WLAN_CATEGORY_SELF_PROTECTED &&
 	    mgmt->u.action.category != WLAN_CATEGORY_SPECTRUM_MGMT)
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_ACTION_UNKNOWN_SRC;
 
 	switch (mgmt->u.action.category) {
 	case WLAN_CATEGORY_HT:
@@ -3878,7 +3878,7 @@ ieee80211_rx_h_action_return(struct ieee80211_rx_data *rx)
 
 	/* do not return rejected action frames */
 	if (mgmt->u.action.category & 0x80)
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_REJECTED_ACTION_RESPONSE;
 
 	nskb = skb_copy_expand(rx->skb, local->hw.extra_tx_headroom, 0,
 			       GFP_ATOMIC);
diff --git a/net/mac80211/wep.c b/net/mac80211/wep.c
index 9a6e11d7b4db..5c01e121481a 100644
--- a/net/mac80211/wep.c
+++ b/net/mac80211/wep.c
@@ -3,6 +3,7 @@
  * Software WEP encryption implementation
  * Copyright 2002, Jouni Malinen <jkmaline@cc.hut.fi>
  * Copyright 2003, Instant802 Networks, Inc.
+ * Copyright (C) 2023 Intel Corporation
  */
 
 #include <linux/netdevice.h>
@@ -250,18 +251,18 @@ ieee80211_crypto_wep_decrypt(struct ieee80211_rx_data *rx)
 
 	if (!(status->flag & RX_FLAG_DECRYPTED)) {
 		if (skb_linearize(rx->skb))
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_OOM;
 		if (ieee80211_wep_decrypt(rx->local, rx->skb, rx->key))
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_WEP_DEC_FAIL;
 	} else if (!(status->flag & RX_FLAG_IV_STRIPPED)) {
 		if (!pskb_may_pull(rx->skb, ieee80211_hdrlen(fc) +
 					    IEEE80211_WEP_IV_LEN))
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_NO_IV;
 		ieee80211_wep_remove_iv(rx->local, rx->skb, rx->key);
 		/* remove ICV */
 		if (!(status->flag & RX_FLAG_ICV_STRIPPED) &&
 		    pskb_trim(rx->skb, rx->skb->len - IEEE80211_WEP_ICV_LEN))
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_NO_ICV;
 	}
 
 	return RX_CONTINUE;
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 2d8e38b3bcb5..94dae7cb6dbd 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -3,7 +3,7 @@
  * Copyright 2002-2004, Instant802 Networks, Inc.
  * Copyright 2008, Jouni Malinen <j@w1.fi>
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2020-2022 Intel Corporation
+ * Copyright (C) 2020-2023 Intel Corporation
  */
 
 #include <linux/netdevice.h>
@@ -142,7 +142,7 @@ ieee80211_rx_h_michael_mic_verify(struct ieee80211_rx_data *rx)
 		 * group keys and only the AP is sending real multicast
 		 * frames in the BSS.
 		 */
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_AP_RX_GROUPCAST;
 	}
 
 	if (status->flag & RX_FLAG_MMIC_ERROR)
@@ -150,10 +150,10 @@ ieee80211_rx_h_michael_mic_verify(struct ieee80211_rx_data *rx)
 
 	hdrlen = ieee80211_hdrlen(hdr->frame_control);
 	if (skb->len < hdrlen + MICHAEL_MIC_LEN)
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_SHORT_MMIC;
 
 	if (skb_linearize(rx->skb))
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_OOM;
 	hdr = (void *)skb->data;
 
 	data = skb->data + hdrlen;
@@ -188,7 +188,7 @@ ieee80211_rx_h_michael_mic_verify(struct ieee80211_rx_data *rx)
 				     NL80211_KEYTYPE_PAIRWISE,
 				     rx->key ? rx->key->conf.keyidx : -1,
 				     NULL, GFP_ATOMIC);
-	return RX_DROP_UNUSABLE;
+	return RX_DROP_U_MMIC_FAIL;
 }
 
 static int tkip_encrypt_skb(struct ieee80211_tx_data *tx, struct sk_buff *skb)
@@ -276,11 +276,11 @@ ieee80211_crypto_tkip_decrypt(struct ieee80211_rx_data *rx)
 		return RX_CONTINUE;
 
 	if (!rx->sta || skb->len - hdrlen < 12)
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_SHORT_TKIP;
 
 	/* it may be possible to optimize this a bit more */
 	if (skb_linearize(rx->skb))
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_OOM;
 	hdr = (void *)skb->data;
 
 	/*
@@ -298,7 +298,7 @@ ieee80211_crypto_tkip_decrypt(struct ieee80211_rx_data *rx)
 					  &rx->tkip.iv32,
 					  &rx->tkip.iv16);
 	if (res != TKIP_DECRYPT_OK)
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_TKIP_FAIL;
 
 	/* Trim ICV */
 	if (!(status->flag & RX_FLAG_ICV_STRIPPED))
@@ -523,12 +523,12 @@ ieee80211_crypto_ccmp_decrypt(struct ieee80211_rx_data *rx,
 
 	if (status->flag & RX_FLAG_DECRYPTED) {
 		if (!pskb_may_pull(rx->skb, hdrlen + IEEE80211_CCMP_HDR_LEN))
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_SHORT_CCMP;
 		if (status->flag & RX_FLAG_MIC_STRIPPED)
 			mic_len = 0;
 	} else {
 		if (skb_linearize(rx->skb))
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_OOM;
 	}
 
 	/* reload hdr - skb might have been reallocated */
@@ -536,7 +536,7 @@ ieee80211_crypto_ccmp_decrypt(struct ieee80211_rx_data *rx,
 
 	data_len = skb->len - hdrlen - IEEE80211_CCMP_HDR_LEN - mic_len;
 	if (!rx->sta || data_len < 0)
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_SHORT_CCMP;
 
 	if (!(status->flag & RX_FLAG_PN_VALIDATED)) {
 		int res;
@@ -574,7 +574,7 @@ ieee80211_crypto_ccmp_decrypt(struct ieee80211_rx_data *rx,
 
 	/* Remove CCMP header and MIC */
 	if (pskb_trim(skb, skb->len - mic_len))
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_SHORT_CCMP_MIC;
 	memmove(skb->data + IEEE80211_CCMP_HDR_LEN, skb->data, hdrlen);
 	skb_pull(skb, IEEE80211_CCMP_HDR_LEN);
 
@@ -719,12 +719,12 @@ ieee80211_crypto_gcmp_decrypt(struct ieee80211_rx_data *rx)
 
 	if (status->flag & RX_FLAG_DECRYPTED) {
 		if (!pskb_may_pull(rx->skb, hdrlen + IEEE80211_GCMP_HDR_LEN))
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_SHORT_GCMP;
 		if (status->flag & RX_FLAG_MIC_STRIPPED)
 			mic_len = 0;
 	} else {
 		if (skb_linearize(rx->skb))
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_OOM;
 	}
 
 	/* reload hdr - skb might have been reallocated */
@@ -732,7 +732,7 @@ ieee80211_crypto_gcmp_decrypt(struct ieee80211_rx_data *rx)
 
 	data_len = skb->len - hdrlen - IEEE80211_GCMP_HDR_LEN - mic_len;
 	if (!rx->sta || data_len < 0)
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_SHORT_GCMP;
 
 	if (!(status->flag & RX_FLAG_PN_VALIDATED)) {
 		int res;
@@ -771,7 +771,7 @@ ieee80211_crypto_gcmp_decrypt(struct ieee80211_rx_data *rx)
 
 	/* Remove GCMP header and MIC */
 	if (pskb_trim(skb, skb->len - mic_len))
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_SHORT_GCMP_MIC;
 	memmove(skb->data + IEEE80211_GCMP_HDR_LEN, skb->data, hdrlen);
 	skb_pull(skb, IEEE80211_GCMP_HDR_LEN);
 
@@ -924,7 +924,7 @@ ieee80211_crypto_aes_cmac_decrypt(struct ieee80211_rx_data *rx)
 	/* management frames are already linear */
 
 	if (skb->len < 24 + sizeof(*mmie))
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_SHORT_CMAC;
 
 	mmie = (struct ieee80211_mmie *)
 		(skb->data + skb->len - sizeof(*mmie));
@@ -974,13 +974,13 @@ ieee80211_crypto_aes_cmac_256_decrypt(struct ieee80211_rx_data *rx)
 	/* management frames are already linear */
 
 	if (skb->len < 24 + sizeof(*mmie))
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_SHORT_CMAC256;
 
 	mmie = (struct ieee80211_mmie_16 *)
 		(skb->data + skb->len - sizeof(*mmie));
 	if (mmie->element_id != WLAN_EID_MMIE ||
 	    mmie->length != sizeof(*mmie) - 2)
-		return RX_DROP_UNUSABLE; /* Invalid MMIE */
+		return RX_DROP_U_BAD_MMIE; /* Invalid MMIE */
 
 	bip_ipn_swap(ipn, mmie->sequence_number);
 
@@ -1073,7 +1073,7 @@ ieee80211_crypto_aes_gmac_decrypt(struct ieee80211_rx_data *rx)
 	/* management frames are already linear */
 
 	if (skb->len < 24 + sizeof(*mmie))
-		return RX_DROP_UNUSABLE;
+		return RX_DROP_U_SHORT_GMAC;
 
 	mmie = (struct ieee80211_mmie_16 *)
 		(skb->data + skb->len - sizeof(*mmie));
@@ -1097,7 +1097,7 @@ ieee80211_crypto_aes_gmac_decrypt(struct ieee80211_rx_data *rx)
 
 		mic = kmalloc(GMAC_MIC_LEN, GFP_ATOMIC);
 		if (!mic)
-			return RX_DROP_UNUSABLE;
+			return RX_DROP_U_OOM;
 		if (ieee80211_aes_gmac(key->u.aes_gmac.tfm, aad, nonce,
 				       skb->data + 24, skb->len - 24,
 				       mic) < 0 ||
-- 
2.41.0

