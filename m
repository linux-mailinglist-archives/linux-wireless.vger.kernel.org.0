Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9301818CA1B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2020 10:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgCTJUj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Mar 2020 05:20:39 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42224 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCTJUj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Mar 2020 05:20:39 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jFDpT-00APNL-Cp; Fri, 20 Mar 2020 10:20:35 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: don't leave skb->next/prev pointing to stack
Date:   Fri, 20 Mar 2020 10:20:23 +0100
Message-Id: <20200320102021.1be7823fc05e.Ia89fb79a0469d32137c9a04315a1d2dfc7b7d6f5@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In beacon protection, don't leave skb->next/prev pointing to the
on-stack list, even if that's actually harmless since we don't use
them again afterwards.

While at it, check that the SKB on the list is still the same, as
that's required here. If not, the encryption (protection) code is
buggy.

Fixes: 0a3a84360b37 ("mac80211: Beacon protection using the new BIGTK (AP)")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 83147385c200..49d35936cc9d 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4670,6 +4670,7 @@ static int ieee80211_beacon_protect(struct sk_buff *skb,
 {
 	ieee80211_tx_result res;
 	struct ieee80211_tx_data tx;
+	struct sk_buff *check_skb;
 
 	memset(&tx, 0, sizeof(tx));
 	tx.key = rcu_dereference(sdata->default_beacon_key);
@@ -4680,8 +4681,11 @@ static int ieee80211_beacon_protect(struct sk_buff *skb,
 	__skb_queue_head_init(&tx.skbs);
 	__skb_queue_tail(&tx.skbs, skb);
 	res = ieee80211_tx_h_encrypt(&tx);
+	check_skb = __skb_dequeue(&tx.skbs);
+	/* we may crash after this, but it'd be a bug in crypto */
+	WARN_ON(check_skb != skb);
 	if (WARN_ON_ONCE(res != TX_CONTINUE))
-		return -1;
+		return -EINVAL;
 
 	return 0;
 }
-- 
2.25.1

