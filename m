Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D087E37ADAB
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 20:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhEKSEi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 14:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhEKSEX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 14:04:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B253C06138F;
        Tue, 11 May 2021 11:03:13 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lgWit-007aAS-RH; Tue, 11 May 2021 20:03:11 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Wen Gong <wgong@codeaurora.org>, stable@vger.kernel.org
Subject: [PATCH 12/18] ath10k: drop fragments with multicast DA for PCIe
Date:   Tue, 11 May 2021 20:02:53 +0200
Message-Id: <20210511200110.5a0bd289bda8.Idd6ebea20038fb1cfee6de924aa595e5647c9eae@changeid>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511180259.159598-1-johannes@sipsolutions.net>
References: <20210511180259.159598-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>

Fragmentation is not used with multicast frames. Discard unexpected
fragments with multicast DA. This fixes CVE-2020-26145.

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1

Cc: stable@vger.kernel.org
Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index f1e5bce8b14f..cb04848ed5cb 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1768,6 +1768,16 @@ static u64 ath10k_htt_rx_h_get_pn(struct ath10k *ar, struct sk_buff *skb,
 	return pn;
 }
 
+static bool ath10k_htt_rx_h_frag_multicast_check(struct ath10k *ar,
+						 struct sk_buff *skb,
+						 u16 offset)
+{
+	struct ieee80211_hdr *hdr;
+
+	hdr = (struct ieee80211_hdr *)(skb->data + offset);
+	return !is_multicast_ether_addr(hdr->addr1);
+}
+
 static bool ath10k_htt_rx_h_frag_pn_check(struct ath10k *ar,
 					  struct sk_buff *skb,
 					  u16 peer_id,
@@ -1839,7 +1849,7 @@ static void ath10k_htt_rx_h_mpdu(struct ath10k *ar,
 	bool is_decrypted;
 	bool is_mgmt;
 	u32 attention;
-	bool frag_pn_check = true;
+	bool frag_pn_check = true, multicast_check = true;
 
 	if (skb_queue_empty(amsdu))
 		return;
@@ -1946,13 +1956,20 @@ static void ath10k_htt_rx_h_mpdu(struct ath10k *ar,
 								      0,
 								      enctype);
 
-		if (!frag_pn_check) {
-			/* Discard the fragment with invalid PN */
+		if (frag)
+			multicast_check = ath10k_htt_rx_h_frag_multicast_check(ar,
+									       msdu,
+									       0);
+
+		if (!frag_pn_check || !multicast_check) {
+			/* Discard the fragment with invalid PN or multicast DA
+			 */
 			temp = msdu->prev;
 			__skb_unlink(msdu, amsdu);
 			dev_kfree_skb_any(msdu);
 			msdu = temp;
 			frag_pn_check = true;
+			multicast_check = true;
 			continue;
 		}
 
-- 
2.30.2

