Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36E73968D1
	for <lists+linux-wireless@lfdr.de>; Mon, 31 May 2021 22:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhEaUao (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 16:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhEaUaY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 16:30:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1785EC06138B;
        Mon, 31 May 2021 13:28:43 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lnoWf-000F0y-5U; Mon, 31 May 2021 22:28:41 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     stable@vger.kernel.org, Wen Gong <wgong@codeaurora.org>
Subject: [PATCH v4.4 10/10] mac80211: extend protection against mixed key and fragment cache attacks
Date:   Mon, 31 May 2021 22:28:34 +0200
Message-Id: <20210531202834.179810-11-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531202834.179810-1-johannes@sipsolutions.net>
References: <20210531202834.179810-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>

commit 3edc6b0d6c061a70d8ca3c3c72eb1f58ce29bfb1 upstream.

For some chips/drivers, e.g., QCA6174 with ath10k, the decryption is
done by the hardware, and the Protected bit in the Frame Control field
is cleared in the lower level driver before the frame is passed to
mac80211. In such cases, the condition for ieee80211_has_protected() is
not met in ieee80211_rx_h_defragment() of mac80211 and the new security
validation steps are not executed.

Extend mac80211 to cover the case where the Protected bit has been
cleared, but the frame is indicated as having been decrypted by the
hardware. This extends protection against mixed key and fragment cache
attack for additional drivers/chips. This fixes CVE-2020-24586 and
CVE-2020-24587 for such cases.

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1

Cc: stable@vger.kernel.org
Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Link: https://lore.kernel.org/r/20210511200110.037aa5ca0390.I7bb888e2965a0db02a67075fcb5deb50eb7408aa@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/rx.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 1a7267448dc8..ae0fba044cd0 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1842,7 +1842,7 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 	unsigned int frag, seq;
 	struct ieee80211_fragment_entry *entry;
 	struct sk_buff *skb;
-	struct ieee80211_rx_status *status;
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
 
 	hdr = (struct ieee80211_hdr *)rx->skb->data;
 	fc = hdr->frame_control;
@@ -1901,7 +1901,9 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 				     sizeof(rx->key->u.gcmp.rx_pn[queue]));
 			BUILD_BUG_ON(IEEE80211_CCMP_PN_LEN !=
 				     IEEE80211_GCMP_PN_LEN);
-		} else if (rx->key && ieee80211_has_protected(fc)) {
+		} else if (rx->key &&
+			   (ieee80211_has_protected(fc) ||
+			    (status->flag & RX_FLAG_DECRYPTED))) {
 			entry->is_protected = true;
 			entry->key_color = rx->key->color;
 		}
@@ -1946,13 +1948,19 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 			return RX_DROP_UNUSABLE;
 		memcpy(entry->last_pn, pn, IEEE80211_CCMP_PN_LEN);
 	} else if (entry->is_protected &&
-		   (!rx->key || !ieee80211_has_protected(fc) ||
+		   (!rx->key ||
+		    (!ieee80211_has_protected(fc) &&
+		     !(status->flag & RX_FLAG_DECRYPTED)) ||
 		    rx->key->color != entry->key_color)) {
 		/* Drop this as a mixed key or fragment cache attack, even
 		 * if for TKIP Michael MIC should protect us, and WEP is a
 		 * lost cause anyway.
 		 */
 		return RX_DROP_UNUSABLE;
+	} else if (entry->is_protected && rx->key &&
+		   entry->key_color != rx->key->color &&
+		   (status->flag & RX_FLAG_DECRYPTED)) {
+		return RX_DROP_UNUSABLE;
 	}
 
 	skb_pull(rx->skb, ieee80211_hdrlen(fc));
-- 
2.31.1

