Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827E851E5A0
	for <lists+linux-wireless@lfdr.de>; Sat,  7 May 2022 10:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379079AbiEGIli (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 May 2022 04:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346493AbiEGIlh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 May 2022 04:41:37 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 043A8396B6
        for <linux-wireless@vger.kernel.org>; Sat,  7 May 2022 01:37:50 -0700 (PDT)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1651912666;
        bh=dT+iblPp+xRuQZDcFiqTIbaNZ+jQOJ9N38bC6ynCXR8=;
        h=From:To:Cc:Subject:Date;
        b=BjNZk896zgap26LajhsrIyV3tQE09flenRDK9JAjd9O/Q2fSSvchhllTWsjquXPe6
         Lfbm0i//g4Ro5QcUuqU5Y4tItEdX1SNpQxtQsM0v4KntFpL5lPEmN0qAYwh8nV93l8
         5pMotN1iPDUiLuYBG8ZEW1JbygWbTNbgUMbnnPaE=
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Alexander Wetzel <alexander@wetzel-home.de>,
        Pierre Asselin <pa@panix.com>
Subject: [PATCH] mac80211: Use full queue selection code for control port tx
Date:   Sat,  7 May 2022 10:37:06 +0200
Message-Id: <20220507083706.384513-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Calling only __ieee80211_select_queue() for control port TX exposes
drivers which do not support QoS to non-zero values in
skb->queue_mapping and even can assign not available queues to
info->hw_queue.
This can cause issues for drivers like we did e.g. see in
'746285cf81dc ("rtl818x: Prevent using not initialized queues")'.

This also prevents a redundant call to __ieee80211_select_queue() when
using control port TX with iTXQ (pull path).
And it starts to prioritize 802.11 preauthentication frames
(ETH_P_PREAUTH) on all TX paths.

Pierre Asselin confirmed that this patch indeed prevents crashing his
system without '746285cf81dc ("rtl818x: Prevent using not initialized
queues")'.

Tested-by: Pierre Asselin <pa@panix.com>
Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---

Starting to prioritize ETH_P_PREAUTH was just added since I noticed that
contradictory to at least my expectations control port does accept
ETH_P_PREAUTH but handles these like a normal frame for the priority.
That can be broken out or even drop, when needed.

While looking at the code I also tripped over multiple other questions
and I'll probably propose a much more invasive change how to handle
the queue assignment. (End2end we seem to do some quite stupid things.)

Additionally I really don't get why we call skb_get_hash() on queue
assignment:
I found the commit '180ac48ee62f ("mac80211: calculate skb hash early
when using itxq")' but don't see why calculating the hash early is
useful. Any hints here are appreciated. fq_flow_idx() seems to do that
when needed and I can't find any other usage of the hash...

 net/mac80211/tx.c  | 18 +++---------------
 net/mac80211/wme.c |  3 ++-
 2 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0e4efc08c762..2fabf6c4547c 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5727,7 +5727,6 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
-	struct sta_info *sta;
 	struct sk_buff *skb;
 	struct ethhdr *ehdr;
 	u32 ctrl_flags = 0;
@@ -5771,20 +5770,9 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	skb_reset_network_header(skb);
 	skb_reset_mac_header(skb);
 
-	/* update QoS header to prioritize control port frames if possible,
-	 * priorization also happens for control port frames send over
-	 * AF_PACKET
-	 */
-	rcu_read_lock();
-
-	if (ieee80211_lookup_ra_sta(sdata, skb, &sta) == 0 && !IS_ERR(sta)) {
-		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
-
-		skb_set_queue_mapping(skb, queue);
-		skb_get_hash(skb);
-	}
-
-	rcu_read_unlock();
+	/* skb bypassed queue selection in net/core/dev.c, do it now */
+	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, skb));
+	skb_get_hash(skb);
 
 	/* mutex lock is only needed for incrementing the cookie counter */
 	mutex_lock(&local->mtx);
diff --git a/net/mac80211/wme.c b/net/mac80211/wme.c
index 62c6733e0792..774afefbe0b0 100644
--- a/net/mac80211/wme.c
+++ b/net/mac80211/wme.c
@@ -160,7 +160,8 @@ u16 __ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
 		return IEEE80211_AC_BE;
 	}
 
-	if (skb->protocol == sdata->control_port_protocol) {
+	if (skb->protocol == sdata->control_port_protocol ||
+	    skb->protocol == cpu_to_be16(ETH_P_PREAUTH)) {
 		skb->priority = 7;
 		goto downgrade;
 	}
-- 
2.35.1

