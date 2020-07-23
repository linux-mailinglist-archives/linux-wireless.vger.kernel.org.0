Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F3622AC12
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 12:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgGWKDT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 06:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgGWKDS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 06:03:18 -0400
Received: from rhcavuit04.kulnet.kuleuven.be (rhcavuit04.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA90C0619DC
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 03:03:18 -0700 (PDT)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (not cached, score=-50.999, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00,
        URIBL_BLOCKED 0.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 743B212033A.A0D8C
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-2.cc.kuleuven.be (icts-p-smtps-2e.kulnet.kuleuven.be [134.58.240.34])
        by rhcavuit04.kulnet.kuleuven.be (Postfix) with ESMTP id 743B212033A
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 12:03:16 +0200 (CEST)
Received: from mathy-work.localhost (unknown [176.205.50.14])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts-p-smtps-2.cc.kuleuven.be (Postfix) with ESMTPSA id 5C495200A1;
        Thu, 23 Jul 2020 12:03:15 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 4/6] mac80211: use same flag everywhere to avoid sequence number overwrite
Date:   Thu, 23 Jul 2020 14:01:51 +0400
Message-Id: <20200723100153.31631-4-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723100153.31631-1-Mathy.Vanhoef@kuleuven.be>
References: <20200723085126.29127-1-Mathy.Vanhoef@kuleuven.be>
 <20200723100153.31631-1-Mathy.Vanhoef@kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use the IEEE80211_TX_CTRL_NO_SEQNO flag in ieee80211_tx_info to mark
probe requests whose sequence number must not be overwritten. This
provides consistency with the radiotap flag that can be set to indicate
that the sequence number of an injected frame should not be overwritten.

Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
---
 net/mac80211/ieee80211_i.h | 1 -
 net/mac80211/scan.c        | 7 +++----
 net/mac80211/tx.c          | 2 --
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index ec1a71ac6..8f1a325e0 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -164,7 +164,6 @@ typedef unsigned __bitwise ieee80211_tx_result;
 #define TX_DROP		((__force ieee80211_tx_result) 1u)
 #define TX_QUEUED	((__force ieee80211_tx_result) 2u)
 
-#define IEEE80211_TX_NO_SEQNO		BIT(0)
 #define IEEE80211_TX_UNICAST		BIT(1)
 #define IEEE80211_TX_PS_BUFFERED	BIT(2)
 
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index ad90bbe57..8ccdafa62 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -591,7 +591,6 @@ static void ieee80211_send_scan_probe_req(struct ieee80211_sub_if_data *sdata,
 					  struct ieee80211_channel *channel)
 {
 	struct sk_buff *skb;
-	u32 txdata_flags = 0;
 
 	skb = ieee80211_build_probe_req(sdata, src, dst, ratemask, channel,
 					ssid, ssid_len,
@@ -600,15 +599,15 @@ static void ieee80211_send_scan_probe_req(struct ieee80211_sub_if_data *sdata,
 	if (skb) {
 		if (flags & IEEE80211_PROBE_FLAG_RANDOM_SN) {
 			struct ieee80211_hdr *hdr = (void *)skb->data;
+			struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 			u16 sn = get_random_u32();
 
-			txdata_flags |= IEEE80211_TX_NO_SEQNO;
+			info->control.flags |= IEEE80211_TX_CTRL_NO_SEQNO;
 			hdr->seq_ctrl =
 				cpu_to_le16(IEEE80211_SN_TO_SEQ(sn));
 		}
 		IEEE80211_SKB_CB(skb)->flags |= tx_flags;
-		ieee80211_tx_skb_tid_band(sdata, skb, 7, channel->band,
-					  txdata_flags);
+		ieee80211_tx_skb_tid_band(sdata, skb, 7, channel->band, 0);
 	}
 }
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index cc5068999..279d1edbb 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -835,8 +835,6 @@ ieee80211_tx_h_sequence(struct ieee80211_tx_data *tx)
 	 */
 	if (!ieee80211_is_data_qos(hdr->frame_control) ||
 	    is_multicast_ether_addr(hdr->addr1)) {
-		if (tx->flags & IEEE80211_TX_NO_SEQNO)
-			return TX_CONTINUE;
 		/* driver should assign sequence number */
 		info->flags |= IEEE80211_TX_CTL_ASSIGN_SEQ;
 		/* for pure STA mode without beacons, we can do it */
-- 
2.27.0

