Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50702BC42
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 00:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfE0W4L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 May 2019 18:56:11 -0400
Received: from mail.w1.fi ([212.71.239.96]:43242 "EHLO
        li674-96.members.linode.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726931AbfE0W4L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 May 2019 18:56:11 -0400
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 May 2019 18:56:11 EDT
Received: from localhost (localhost [127.0.0.1])
        by li674-96.members.linode.com (Postfix) with ESMTP id 2E28E1220A;
        Mon, 27 May 2019 22:46:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from li674-96.members.linode.com ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QYXDCQAvehPZ; Mon, 27 May 2019 22:46:54 +0000 (UTC)
From:   Jouni Malinen <j@w1.fi>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Jouni Malinen <j@w1.fi>
Subject: [PATCH] mac80211: Do not use stack memory with scatterlist for GMAC
Date:   Tue, 28 May 2019 01:46:43 +0300
Message-Id: <20190527224643.26084-1-j@w1.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ieee80211_aes_gmac() uses the mic argument directly in sg_set_buf() and
that does not allow use of stack memory (e.g., BUG_ON() is hit in
sg_set_buf() with CONFIG_DEBUG_SG). BIP GMAC TX side is fine for this
since it can use the skb data buffer, but the RX side was using a stack
variable for deriving the local MIC value to compare against the
received one.

Fix this by allocating heap memory for the mic buffer.

This was found with hwsim test case ap_cipher_bip_gmac_128 hitting that
BUG_ON() and kernel panic.

Signed-off-by: Jouni Malinen <j@w1.fi>
---
 net/mac80211/wpa.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 58d0b258b684..5dd48f0a4b1b 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -1175,7 +1175,7 @@ ieee80211_crypto_aes_gmac_decrypt(struct ieee80211_rx_data *rx)
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_key *key = rx->key;
 	struct ieee80211_mmie_16 *mmie;
-	u8 aad[GMAC_AAD_LEN], mic[GMAC_MIC_LEN], ipn[6], nonce[GMAC_NONCE_LEN];
+	u8 aad[GMAC_AAD_LEN], *mic, ipn[6], nonce[GMAC_NONCE_LEN];
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 
 	if (!ieee80211_is_mgmt(hdr->frame_control))
@@ -1206,13 +1206,18 @@ ieee80211_crypto_aes_gmac_decrypt(struct ieee80211_rx_data *rx)
 		memcpy(nonce, hdr->addr2, ETH_ALEN);
 		memcpy(nonce + ETH_ALEN, ipn, 6);
 
+		mic = kmalloc(GMAC_MIC_LEN, GFP_ATOMIC);
+		if (!mic)
+			return RX_DROP_UNUSABLE;
 		if (ieee80211_aes_gmac(key->u.aes_gmac.tfm, aad, nonce,
 				       skb->data + 24, skb->len - 24,
 				       mic) < 0 ||
 		    crypto_memneq(mic, mmie->mic, sizeof(mmie->mic))) {
 			key->u.aes_gmac.icverrors++;
+			kfree(mic);
 			return RX_DROP_UNUSABLE;
 		}
+		kfree(mic);
 	}
 
 	memcpy(key->u.aes_gmac.rx_pn, ipn, 6);
-- 
2.20.1

