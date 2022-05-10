Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FE45220AB
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 18:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347035AbiEJQJI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 12:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348520AbiEJQIb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 12:08:31 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4C89994F2
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 09:01:13 -0700 (PDT)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1652198471;
        bh=tU+uluQy49GeL81uGtA5QW7ihpkSGYyV23jNGflsYpw=;
        h=From:To:Cc:Subject:Date;
        b=uJANyqF7Z6rlj7lJe01zopLjwzKbZEr1XadLaZ4sUO53+gj6o6p4E13BXAEL5yGd5
         EpIlL54A0WFFkSGIRH2J2oWNSeQcilN6EhKh1vK/iv2T90peOa7TURrr8cNzzV3Ntn
         mxjYGV4etgyIueralAxXnCzHQoAyN1Uhs4SV1BcU=
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH] mac80211: Simplify queue selection
Date:   Tue, 10 May 2022 17:58:28 +0200
Message-Id: <20220510155828.9406-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Let iTXQ drivers also register four queues in netdev and move queue
assignment to ndo_select_queue(), like it's done for other drivers.

This gets rid of a special case in mac80211 and also increases the
chance that when we call skb_get_hash() the skb is still hot in the CPU
buffers.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---
This patch is currently mostly an attempt to review our queueing
procedure. It's also assuming the patch offered in
https://lore.kernel.org/linux-wireless/20220507083706.384513-1-alexander@wetzel-home.de/
has been merged. Without that there will be one merge conflict in
ieee80211_tx_control_port(). But it only drops skb_get_hash() there,
which is also in the function without the patch.

I've only a basic understanding about QoS and qdisc and I may miss
some obvious reason why we can't use ndo_select_queue() with iTXQ
drivers. Looking at the code I just started wondering why we have
all the special handling when there seems to be no pressing need.
Now the additional sta lookup may make it a bit slower. But on the other
side we move skb_get_hash() up in the call chain, increasing the change
the skb is still in the CPU buffers. (Which according to our discussion
in https://lore.kernel.org/linux-wireless/875ymf263a.fsf@toke.dk/ seems
to be the only reason for the call.)

'1974da8b31e6 ("mac80211: when using iTXQ, select the queue in
ieee80211_subif_start_xmit")' from Felix claims "mac80211 is using its
internal queues anyway". But following that logic we can always bypass
ndo_select_queue(). Or even stop registering the handler at all.
(Which is something I also consider.)

I still don't understand why we don't want to use qdisc with the iTXQ
drivers. I now just made sure we don't start using qdiscs with this
patch to start with the least invasive approach. Anyone able to shed some
light on that?

I've also test this patch with an iwlmvm card and it looks like it's just
doing what I expect:
netdev is indeed accepting IEEE80211_AC_BE (2) as queue number and the
warning from netdev_cap_txqueue() is not triggered.

The card also looks unchanged when I check it with "tc qdisc show":
	qdisc noqueue 0: dev wlp0s12f0 root refcnt 2

Alexander

 net/mac80211/iface.c | 10 +++++-----
 net/mac80211/tx.c    | 13 -------------
 net/mac80211/wme.c   |  5 ++---
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 41531478437c..98b499197c41 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -2009,13 +2009,13 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 			txq_size += sizeof(struct txq_info) +
 				    local->hw.txq_data_size;
 
-		if (local->ops->wake_tx_queue) {
+		if (local->ops->wake_tx_queue)
 			if_setup = ieee80211_if_setup_no_queue;
-		} else {
+		else
 			if_setup = ieee80211_if_setup;
-			if (local->hw.queues >= IEEE80211_NUM_ACS)
-				txqs = IEEE80211_NUM_ACS;
-		}
+
+		if (local->hw.queues >= IEEE80211_NUM_ACS)
+			txqs = IEEE80211_NUM_ACS;
 
 		ndev = alloc_netdev_mqs(size + txq_size,
 					name, name_assign_type,
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 2fabf6c4547c..2298e2e1a4ce 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4181,12 +4181,6 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 	if (IS_ERR(sta))
 		sta = NULL;
 
-	if (local->ops->wake_tx_queue) {
-		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
-		skb_set_queue_mapping(skb, queue);
-		skb_get_hash(skb);
-	}
-
 	ieee80211_aggr_check(sdata, sta, skb);
 
 	sk_pacing_shift_update(skb->sk, sdata->local->hw.tx_sk_pacing_shift);
@@ -4442,12 +4436,6 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	struct tid_ampdu_tx *tid_tx;
 	u8 tid;
 
-	if (local->ops->wake_tx_queue) {
-		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
-		skb_set_queue_mapping(skb, queue);
-		skb_get_hash(skb);
-	}
-
 	if (unlikely(test_bit(SCAN_SW_SCANNING, &local->scanning)) &&
 	    test_bit(SDATA_STATE_OFFCHANNEL, &sdata->state))
 		goto out_free;
@@ -5772,7 +5760,6 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 
 	/* skb bypassed queue selection in net/core/dev.c, do it now */
 	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, skb));
-	skb_get_hash(skb);
 
 	/* mutex lock is only needed for incrementing the cookie counter */
 	mutex_lock(&local->mtx);
diff --git a/net/mac80211/wme.c b/net/mac80211/wme.c
index 774afefbe0b0..5047faee6974 100644
--- a/net/mac80211/wme.c
+++ b/net/mac80211/wme.c
@@ -186,9 +186,8 @@ u16 ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
 	const u8 *ra = NULL;
 	u16 ret;
 
-	/* when using iTXQ, we can do this later */
-	if (local->ops->wake_tx_queue)
-		return 0;
+	/* Calculate hash early, hopefully it's still in the CPU buffer */
+	skb_get_hash(skb);
 
 	if (local->hw.queues < IEEE80211_NUM_ACS || skb->len < 6) {
 		skb->priority = 0; /* required for correct WPA/11i MIC */
-- 
2.35.1

