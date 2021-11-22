Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01910459637
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 21:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhKVUqj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 15:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhKVUqi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 15:46:38 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3062C061574
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 12:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZPobdfeCHed4yL+o8jD2OjfdxyRj0UuvmmwBV3kgprg=; b=orFXnQvRMLlBu48TefJwVeedYw
        v3M156oJcusktCDPRb4oEFBei1VKg2gZrZ3WegmSsTlozMolGReR2EoTbENyi5ZFza0/wMqRAmj0K
        pT6F8QG/yj94W/poP1QV9iA01CsigezUxZd57mtSonvQIkh5UapmbfiHEC8hM5gBwp+g=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mpG9t-0002M3-Hm; Mon, 22 Nov 2021 21:43:25 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, aaro.koskinen@iki.fi,
        rwbugreport@lost-in-the-void.net, ryder.lee@mediatek.com
Subject: [PATCH 5.16] mac80211: fix rate control for retransmitted frames
Date:   Mon, 22 Nov 2021 21:43:23 +0100
Message-Id: <20211122204323.9787-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since retransmission clears info->control, rate control needs to be called
again, otherwise the driver might crash due to invalid rates.

Cc: stable@vger.kernel.org # 5.14+
Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Reported-by: Robert W <rwbugreport@lost-in-the-void.net>
Fixes: 03c3911d2d67 ("mac80211: call ieee80211_tx_h_rate_ctrl() when dequeue")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 278945e3e08a..e19f6e246642 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1822,15 +1822,15 @@ static int invoke_tx_handlers_late(struct ieee80211_tx_data *tx)
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx->skb);
 	ieee80211_tx_result res = TX_CONTINUE;
 
+	if (!ieee80211_hw_check(&tx->local->hw, HAS_RATE_CONTROL))
+		CALL_TXH(ieee80211_tx_h_rate_ctrl);
+
 	if (unlikely(info->flags & IEEE80211_TX_INTFL_RETRANSMISSION)) {
 		__skb_queue_tail(&tx->skbs, tx->skb);
 		tx->skb = NULL;
 		goto txh_done;
 	}
 
-	if (!ieee80211_hw_check(&tx->local->hw, HAS_RATE_CONTROL))
-		CALL_TXH(ieee80211_tx_h_rate_ctrl);
-
 	CALL_TXH(ieee80211_tx_h_michael_mic_add);
 	CALL_TXH(ieee80211_tx_h_sequence);
 	CALL_TXH(ieee80211_tx_h_fragment);
-- 
2.30.1

