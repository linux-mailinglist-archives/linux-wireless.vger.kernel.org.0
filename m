Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D6D2887C8
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Oct 2020 13:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388064AbgJILZ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 07:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732637AbgJILZ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 07:25:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A680C0613D2
        for <linux-wireless@vger.kernel.org>; Fri,  9 Oct 2020 04:25:58 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQqX2-002EKa-6U; Fri, 09 Oct 2020 13:25:52 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+32fd1a1bfe355e93f1e2@syzkaller.appspotmail.com
Subject: [PATCH] mac80211: fix use of skb payload instead of header
Date:   Fri,  9 Oct 2020 13:25:41 +0200
Message-Id: <20201009132538.e1fd7f802947.I799b288466ea2815f9d4c84349fae697dca2f189@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When ieee80211_skb_resize() is called from ieee80211_build_hdr()
the skb has no 802.11 header yet, in fact it consist only of the
payload as the ethernet frame is removed. As such, we're using
the payload data for ieee80211_is_mgmt(), which is of course
completely wrong. This didn't really hurt us because these are
always data frames, so we could only have added more tailroom
than we needed if we determined it was a management frame and
sdata->crypto_tx_tailroom_needed_cnt was false.

However, syzbot found that of course there need not be any payload,
so we're using at best uninitialized memory for the check.

Fix this to pass explicitly the kind of frame that we have instead
of checking there, by replacing the "bool may_encrypt" argument
with an argument that can carry the three possible states - it's
not going to be encrypted, it's a management frame, or it's a data
frame (and then we check sdata->crypto_tx_tailroom_needed_cnt).

Reported-by: syzbot+32fd1a1bfe355e93f1e2@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
#syz test: https://github.com/google/kmsan.git master
---
 net/mac80211/tx.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index dca01d7e6e3e..af9c4a416039 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1938,19 +1938,24 @@ static bool ieee80211_tx(struct ieee80211_sub_if_data *sdata,
 
 /* device xmit handlers */
 
+enum ieee80211_encrypt {
+	ENCRYPT_NO,
+	ENCRYPT_MGMT,
+	ENCRYPT_DATA,
+};
+
 static int ieee80211_skb_resize(struct ieee80211_sub_if_data *sdata,
 				struct sk_buff *skb,
-				int head_need, bool may_encrypt)
+				int head_need,
+				enum ieee80211_encrypt encrypt)
 {
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_hdr *hdr;
 	bool enc_tailroom;
 	int tail_need = 0;
 
-	hdr = (struct ieee80211_hdr *) skb->data;
-	enc_tailroom = may_encrypt &&
-		       (sdata->crypto_tx_tailroom_needed_cnt ||
-			ieee80211_is_mgmt(hdr->frame_control));
+	enc_tailroom = encrypt == ENCRYPT_MGMT ||
+		       (encrypt == ENCRYPT_DATA &&
+			sdata->crypto_tx_tailroom_needed_cnt);
 
 	if (enc_tailroom) {
 		tail_need = IEEE80211_ENCRYPT_TAILROOM;
@@ -1981,23 +1986,29 @@ void ieee80211_xmit(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_hdr *hdr;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 	int headroom;
-	bool may_encrypt;
+	enum ieee80211_encrypt encrypt;
 
-	may_encrypt = !(info->flags & IEEE80211_TX_INTFL_DONT_ENCRYPT);
+	if (info->flags & IEEE80211_TX_INTFL_DONT_ENCRYPT)
+		encrypt = ENCRYPT_NO;
+	else if (ieee80211_is_mgmt(hdr->frame_control))
+		encrypt = ENCRYPT_MGMT;
+	else
+		encrypt = ENCRYPT_DATA;
 
 	headroom = local->tx_headroom;
-	if (may_encrypt)
+	if (encrypt != ENCRYPT_NO)
 		headroom += sdata->encrypt_headroom;
 	headroom -= skb_headroom(skb);
 	headroom = max_t(int, 0, headroom);
 
-	if (ieee80211_skb_resize(sdata, skb, headroom, may_encrypt)) {
+	if (ieee80211_skb_resize(sdata, skb, headroom, encrypt)) {
 		ieee80211_free_txskb(&local->hw, skb);
 		return;
 	}
 
+	/* reload after potential resize */
 	hdr = (struct ieee80211_hdr *) skb->data;
 	info->control.vif = &sdata->vif;
 
@@ -2822,7 +2833,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 		head_need += sdata->encrypt_headroom;
 		head_need += local->tx_headroom;
 		head_need = max_t(int, 0, head_need);
-		if (ieee80211_skb_resize(sdata, skb, head_need, true)) {
+		if (ieee80211_skb_resize(sdata, skb, head_need, ENCRYPT_DATA)) {
 			ieee80211_free_txskb(&local->hw, skb);
 			skb = NULL;
 			return ERR_PTR(-ENOMEM);
@@ -3496,7 +3507,7 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	if (unlikely(ieee80211_skb_resize(sdata, skb,
 					  max_t(int, extra_head + hw_headroom -
 						     skb_headroom(skb), 0),
-					  false))) {
+					  ENCRYPT_NO))) {
 		kfree_skb(skb);
 		return true;
 	}
-- 
2.26.2

