Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082BE5BEA9A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 17:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiITP4K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 11:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiITP4I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 11:56:08 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0CA36BCC0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 08:56:05 -0700 (PDT)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1663689362;
        bh=Arz06mzgnmfqzaWy5jmbXz3GvPJY8+rQZORoX2NT0BU=;
        h=From:To:Cc:Subject:Date;
        b=K0g8uohYA3v3iQPaXG+8bPeKhi+PcEDxCiTOfBXntRsWSKOwjxSMISTZEmSYNygNs
         M9TnBRbIFd87MRWyuYbgsnLxdsaWrVF2qP31hgW5FrsVbQs+yMMBbhPiWE+GDBIczX
         RUmyWEUUmHerWJCtRLtwn2+izJgWONRCxj0j1Sos=
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH] wifi: mac80211: netdev compatible TX stop for iTXQ drivers
Date:   Tue, 20 Sep 2022 17:55:41 +0200
Message-Id: <20220920155541.2942-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Properly handle TX stop for internal queues (iTXQs) within mac80211.

mac80211 must not stop netdev queues when using mac80211 iTXQs.
For these drivers the netdev interface is created with IFF_NO_QUEUE.

While netdev still drops frames for IFF_NO_QUEUE interfaces when we stop
the netdev queues, it also prints a warning when this happens:
Assuming the mac80211 interface is called wlan0 we would get
"Virtual device wlan0 asks to queue packet!" when netdev has to drop a
frame.

This patch is keeping the harmless netdev queue starts for iTXQ drivers.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---

This is another issue I tripped over while working on the patch to move all
drivers to iTXQ. Didn't want to hide that in the "switch all to iTXQ"
patch. (Which will simply remove all netdev queue starts and stops.)

When running the hwsim tests from hostapd with my WIP patches, I always
got a few "Virtual device XXXX asks to queue packet!" warnings from
netdev. (The offending packets were all from an ipv6 tasklet and looked
like some kind of race for me: While I always would get the message I
did not find a test to do it reproducible.)
---
 net/mac80211/iface.c |  6 +++---
 net/mac80211/tx.c    | 10 ++++++----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 572254366a0f..5d7f25ed7a0e 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -461,7 +461,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	/*
 	 * Stop TX on this interface first.
 	 */
-	if (sdata->dev)
+	if (!local->ops->wake_tx_queue && sdata->dev)
 		netif_tx_stop_all_queues(sdata->dev);
 
 	ieee80211_roc_purge(local, sdata);
@@ -1412,8 +1412,6 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			sdata->vif.type != NL80211_IFTYPE_STATION);
 	}
 
-	set_bit(SDATA_STATE_RUNNING, &sdata->state);
-
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_P2P_DEVICE:
 		rcu_assign_pointer(local->p2p_sdata, sdata);
@@ -1472,6 +1470,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
 	}
 
+	set_bit(SDATA_STATE_RUNNING, &sdata->state);
+
 	return 0;
  err_del_interface:
 	drv_remove_interface(local, sdata);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 24c0a1706b92..48deda3570a7 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2319,6 +2319,10 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 	u16 len_rthdr;
 	int hdrlen;
 
+	sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	if (unlikely(!ieee80211_sdata_running(sdata)))
+		goto fail;
+
 	memset(info, 0, sizeof(*info));
 	info->flags = IEEE80211_TX_CTL_REQ_TX_STATUS |
 		      IEEE80211_TX_CTL_INJECTED;
@@ -2378,8 +2382,6 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 	 * This is necessary, for example, for old hostapd versions that
 	 * don't use nl80211-based management TX/RX.
 	 */
-	sdata = IEEE80211_DEV_TO_SUB_IF(dev);
-
 	list_for_each_entry_rcu(tmp_sdata, &local->interfaces, list) {
 		if (!ieee80211_sdata_running(tmp_sdata))
 			continue;
@@ -4169,7 +4171,7 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 	struct sk_buff *next;
 	int len = skb->len;
 
-	if (unlikely(skb->len < ETH_HLEN)) {
+	if (unlikely(!ieee80211_sdata_running(sdata) || skb->len < ETH_HLEN)) {
 		kfree_skb(skb);
 		return;
 	}
@@ -4566,7 +4568,7 @@ netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 	struct ieee80211_key *key;
 	struct sta_info *sta;
 
-	if (unlikely(skb->len < ETH_HLEN)) {
+	if (unlikely(!ieee80211_sdata_running(sdata) || skb->len < ETH_HLEN)) {
 		kfree_skb(skb);
 		return NETDEV_TX_OK;
 	}
-- 
2.37.3

