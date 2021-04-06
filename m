Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF31D355B3A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Apr 2021 20:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbhDFSWu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Apr 2021 14:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbhDFSWt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Apr 2021 14:22:49 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8437CC06174A
        for <linux-wireless@vger.kernel.org>; Tue,  6 Apr 2021 11:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OWqQFrPlWSOoTfV2qTbhbwEDNJ7XXI9Atjex8euzvzo=; b=taV7E67pqfwtvRLka8aKK36D+Y
        zLeASR9UqKW2NlLbNTROz7czwSkxE9B8CprDnti+LpMGJOsUXKsESIwgMtfO7hyBSfCSFfA85xtOt
        sU3n/naqwM5Jn+fKl85WqHlk9W4ERBGwjobS/BjvqvM9Sog4dINUUrScJmVtLmLU3FY8=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lTqLW-00075B-R9
        for linux-wireless@vger.kernel.org; Tue, 06 Apr 2021 20:22:38 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: fix rx amsdu subframe processing
Date:   Tue,  6 Apr 2021 20:22:35 +0200
Message-Id: <20210406182235.14377-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When receiving an A-MSDU containing only a single subframe, status->last_amsdu
is set, but no previous head is present in the rx A-MSDU queue.
In this case, the A-MSDU subframe will be held until the next one is received,
potentially causing significant extra latency.
Fix this by releasing the frame instead of creating a new queue head if
last_amsdu is set.

Fixes: c7fd4a5d3f75 ("mt76: mt7915: enable hw rx-amsdu de-aggregation")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 7684a8cf00fb..0d92b658b6a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -517,10 +517,14 @@ static void mt76_rx_release_burst(struct mt76_phy *phy, enum mt76_rxq_id q,
 
 	/* first amsdu subframe */
 	if (status->amsdu && !phy->rx_amsdu[q].head) {
+		if (status->last_amsdu) {
+			nskb = skb;
+			goto reset_burst;
+		}
 		phy->rx_amsdu[q].tail = &skb_shinfo(skb)->frag_list;
 		phy->rx_amsdu[q].seqno = status->seqno;
 		phy->rx_amsdu[q].head = skb;
-		goto enqueue;
+		return;
 	}
 
 	/* ampdu or out-of-order amsdu subframes */
@@ -543,7 +547,6 @@ static void mt76_rx_release_burst(struct mt76_phy *phy, enum mt76_rxq_id q,
 reset_burst:
 	phy->rx_amsdu[q].head = NULL;
 	phy->rx_amsdu[q].tail = NULL;
-enqueue:
 	if (nskb)
 		__skb_queue_tail(&dev->rx_skb[q], nskb);
 }
-- 
2.30.1

