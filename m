Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE44722AC0B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 12:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGWKCU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 06:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgGWKCU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 06:02:20 -0400
Received: from rhcavuit01.kulnet.kuleuven.be (rhcavuit01.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE468C0619DC
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 03:02:19 -0700 (PDT)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (cached, score=-50.999, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00,
        URIBL_BLOCKED 0.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 06FC9120341.A2E61
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-2.cc.kuleuven.be (icts-p-smtps-2e.kulnet.kuleuven.be [134.58.240.34])
        by rhcavuit01.kulnet.kuleuven.be (Postfix) with ESMTP id 06FC9120341
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 12:02:16 +0200 (CEST)
Received: from mathy-work.localhost (unknown [176.205.50.14])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts-p-smtps-2.cc.kuleuven.be (Postfix) with ESMTPSA id 0F1C8200A1;
        Thu, 23 Jul 2020 12:02:14 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 1/6] mac80211: never drop injected frames even if normally not allowed
Date:   Thu, 23 Jul 2020 14:01:48 +0400
Message-Id: <20200723100153.31631-1-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723085126.29127-1-Mathy.Vanhoef@kuleuven.be>
References: <20200723085126.29127-1-Mathy.Vanhoef@kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In ieee80211_tx_dequeue there is a check to see if the dequeued frame
is allowed in the current state. Injected frames that are normally
not allowed are being be dropped here. Fix this by checking if a
frame was injected and if so always allowing it.

Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
---
 net/mac80211/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 1a2941e52..62d01ab26 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3618,7 +3618,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	tx.skb = skb;
 	tx.sdata = vif_to_sdata(info->control.vif);
 
-	if (txq->sta) {
+	if (txq->sta && !(info->flags & IEEE80211_TX_CTL_INJECTED)) {
 		tx.sta = container_of(txq->sta, struct sta_info, sta);
 		/*
 		 * Drop unicast frames to unauthorised stations unless they are
-- 
2.27.0

