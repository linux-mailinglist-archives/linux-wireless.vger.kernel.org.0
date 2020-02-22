Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD2E168F1A
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2020 14:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgBVN1d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Feb 2020 08:27:33 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:36803 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727115AbgBVN1d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Feb 2020 08:27:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582378052; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=rFbaqFqXgjEfkRN06hF6RG/GVZYvW2ceLxQsVqfewpA=; b=PHtucN2xs//HLeSMa6KbJnswOPQ5xyNUHcheW+CLWtUrk0k+ldYZsMCzw3F5YkNnvQRnMUUs
 1MKTXgeFmKYqzDLijhuO23s7v4Owi400Ov7EXyWwRDrJJsvL6pdA6K2Cc0EZoagyGTq/bs6M
 Ds/5oQ2N3lAah3YQxAiJTKpydPQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e512c39.7fee97fb0810-smtp-out-n01;
 Sat, 22 Feb 2020 13:27:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 991E4C433A2; Sat, 22 Feb 2020 13:27:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (176-93-35-56.bb.dnainternet.fi [176.93.35.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F233C43383;
        Sat, 22 Feb 2020 13:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F233C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 6/7] mac80211: Beacon protection using the new BIGTK (STA)
Date:   Sat, 22 Feb 2020 15:25:47 +0200
Message-Id: <20200222132548.20835-6-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200222132548.20835-1-jouni@codeaurora.org>
References: <20200222132548.20835-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This adds support for mac80211 to verify that received Beacon frames
have a valid MME in station mode when a BIGTK is configured.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 net/mac80211/rx.c | 79 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index ec3a04a1db20..6bd24123456d 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -983,7 +983,8 @@ static int ieee80211_get_mmie_keyidx(struct sk_buff *skb)
 	if (skb->len < 24 + sizeof(*mmie) || !is_multicast_ether_addr(hdr->da))
 		return -1;
 
-	if (!ieee80211_is_robust_mgmt_frame(skb))
+	if (!ieee80211_is_robust_mgmt_frame(skb) &&
+	    !ieee80211_is_beacon(hdr->frame_control))
 		return -1; /* not a robust management frame */
 
 	mmie = (struct ieee80211_mmie *)
@@ -1868,6 +1869,41 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 	return RX_CONTINUE;
 } /* ieee80211_rx_h_sta_process */
 
+static struct ieee80211_key *
+ieee80211_rx_get_bigtk(struct ieee80211_rx_data *rx, int idx)
+{
+	struct ieee80211_key *key = NULL;
+	struct ieee80211_sub_if_data *sdata = rx->sdata;
+	int idx2;
+
+	/* Make sure key gets set if either BIGTK key index is set so that
+	 * ieee80211_drop_unencrypted_mgmt() can properly drop both unprotected
+	 * Beacon frames and Beacon frames that claim to use another BIGTK key
+	 * index (i.e., a key that we do not have).
+	 */
+
+	if (idx < 0) {
+		idx = NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS;
+		idx2 = idx + 1;
+	} else {
+		if (idx == NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS)
+			idx2 = idx + 1;
+		else
+			idx2 = idx - 1;
+	}
+
+	if (rx->sta)
+		key = rcu_dereference(rx->sta->gtk[idx]);
+	if (!key)
+		key = rcu_dereference(sdata->keys[idx]);
+	if (!key && rx->sta)
+		key = rcu_dereference(rx->sta->gtk[idx2]);
+	if (!key)
+		key = rcu_dereference(sdata->keys[idx2]);
+
+	return key;
+}
+
 static ieee80211_rx_result debug_noinline
 ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 {
@@ -1885,17 +1921,18 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 	/*
 	 * Key selection 101
 	 *
-	 * There are four types of keys:
+	 * There are five types of keys:
 	 *  - GTK (group keys)
 	 *  - IGTK (group keys for management frames)
+	 *  - BIGTK (group keys for Beacon frames)
 	 *  - PTK (pairwise keys)
 	 *  - STK (station-to-station pairwise keys)
 	 *
 	 * When selecting a key, we have to distinguish between multicast
 	 * (including broadcast) and unicast frames, the latter can only
-	 * use PTKs and STKs while the former always use GTKs and IGTKs.
-	 * Unless, of course, actual WEP keys ("pre-RSNA") are used, then
-	 * unicast frames can also use key indices like GTKs. Hence, if we
+	 * use PTKs and STKs while the former always use GTKs, IGTKs, and
+	 * BIGTKs. Unless, of course, actual WEP keys ("pre-RSNA") are used,
+	 * then unicast frames can also use key indices like GTKs. Hence, if we
 	 * don't have a PTK/STK we check the key index for a WEP key.
 	 *
 	 * Note that in a regular BSS, multicast frames are sent by the
@@ -1939,6 +1976,20 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 		/* Skip decryption if the frame is not protected. */
 		if (!ieee80211_has_protected(fc))
 			return RX_CONTINUE;
+	} else if (mmie_keyidx >= 0 && ieee80211_is_beacon(fc)) {
+		/* Broadcast/multicast robust management frame / BIP */
+		if ((status->flag & RX_FLAG_DECRYPTED) &&
+		    (status->flag & RX_FLAG_IV_STRIPPED))
+			return RX_CONTINUE;
+
+		if (mmie_keyidx < NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS ||
+		    mmie_keyidx >= NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS +
+		    NUM_DEFAULT_BEACON_KEYS)
+			return RX_DROP_MONITOR; /* unexpected BIP keyidx */
+
+		rx->key = ieee80211_rx_get_bigtk(rx, mmie_keyidx);
+		if (!rx->key)
+			return RX_CONTINUE; /* Beacon protection not in use */
 	} else if (mmie_keyidx >= 0) {
 		/* Broadcast/multicast robust management frame / BIP */
 		if ((status->flag & RX_FLAG_DECRYPTED) &&
@@ -1968,11 +2019,12 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 		struct ieee80211_sub_if_data *sdata = rx->sdata;
 		int i;
 
-		if (ieee80211_is_mgmt(fc) &&
-		    is_multicast_ether_addr(hdr->addr1) &&
-		    (key = rcu_dereference(rx->sdata->default_mgmt_key)))
-			rx->key = key;
-		else {
+		if (ieee80211_is_beacon(fc)) {
+			key = ieee80211_rx_get_bigtk(rx, -1);
+		} else if (ieee80211_is_mgmt(fc) &&
+			   is_multicast_ether_addr(hdr->addr1)) {
+			key = rcu_dereference(rx->sdata->default_mgmt_key);
+		} else {
 			if (rx->sta) {
 				for (i = 0; i < NUM_DEFAULT_KEYS; i++) {
 					key = rcu_dereference(rx->sta->gtk[i]);
@@ -1987,9 +2039,9 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 						break;
 				}
 			}
-			if (key)
-				rx->key = key;
 		}
+		if (key)
+			rx->key = key;
 		return RX_CONTINUE;
 	} else {
 		/*
@@ -2358,6 +2410,9 @@ static int ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 							     rx->skb->len);
 			return -EACCES;
 		}
+		if (unlikely(ieee80211_is_beacon(fc) && rx->key &&
+			     ieee80211_get_mmie_keyidx(rx->skb) < 0))
+			return -EACCES;
 		/*
 		 * When using MFP, Action frames are not allowed prior to
 		 * having configured keys.
-- 
2.20.1
