Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B6C35662C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 10:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244678AbhDGINV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 04:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbhDGINV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 04:13:21 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBBCC06174A
        for <linux-wireless@vger.kernel.org>; Wed,  7 Apr 2021 01:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bV6kxVVTqjRAhD5Hf0TFvesDFNLy5ggRKT+CWxVJ1rU=; b=felGIiJUJ8JElkgpGpxxAYmykK
        9IjoEqXIr6e/qnIdCmQMG60+thLkFDugQi2VuXLhDHvfS/WDdvufMogso+YWDqmxRc4/ejfxgOnDE
        6KQvLp3Q+DxJu8QiZmG29I+jpAuiw5sjPPx6lp3dAWE74vQc+hZ7PlQSdO6ESzyyGmVs=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lU3JG-0002NN-3G
        for linux-wireless@vger.kernel.org; Wed, 07 Apr 2021 10:13:10 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH v2] mt76: fix rx amsdu subframe processing
Date:   Wed,  7 Apr 2021 10:13:03 +0200
Message-Id: <20210407081303.59647-1-nbd@nbd.name>
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
Rework the code to make it easier to read and less convoluted, and release the
newly created head if status->last_amsdu is set.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 47 ++++++++-----------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 7684a8cf00fb..ef31026ac9d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -508,44 +508,37 @@ void mt76_free_device(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76_free_device);
 
+static void mt76_rx_release_amsdu(struct mt76_phy *phy, enum mt76_rxq_id q)
+{
+	struct sk_buff *skb = phy->rx_amsdu[q].head;
+	struct mt76_dev *dev = phy->dev;
+
+	phy->rx_amsdu[q].head = NULL;
+	phy->rx_amsdu[q].tail = NULL;
+	__skb_queue_tail(&dev->rx_skb[q], skb);
+}
+
 static void mt76_rx_release_burst(struct mt76_phy *phy, enum mt76_rxq_id q,
 				  struct sk_buff *skb)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
-	struct sk_buff *nskb = phy->rx_amsdu[q].head;
-	struct mt76_dev *dev = phy->dev;
 
-	/* first amsdu subframe */
-	if (status->amsdu && !phy->rx_amsdu[q].head) {
+	if (phy->rx_amsdu[q].head &&
+	    (!status->amsdu || status->first_amsdu ||
+	     status->seqno != phy->rx_amsdu[q].seqno))
+		mt76_rx_release_amsdu(phy, q);
+
+	if (!phy->rx_amsdu[q].head) {
 		phy->rx_amsdu[q].tail = &skb_shinfo(skb)->frag_list;
 		phy->rx_amsdu[q].seqno = status->seqno;
 		phy->rx_amsdu[q].head = skb;
-		goto enqueue;
-	}
-
-	/* ampdu or out-of-order amsdu subframes */
-	if (!status->amsdu || status->seqno != phy->rx_amsdu[q].seqno) {
-		/* release pending frames */
-		if (phy->rx_amsdu[q].head)
-			__skb_queue_tail(&dev->rx_skb[q],
-					 phy->rx_amsdu[q].head);
-		nskb = skb;
-		goto reset_burst;
-	}
-
-	/* trailing amsdu subframes */
-	*phy->rx_amsdu[q].tail = skb;
-	if (!status->last_amsdu) {
+	} else {
+		*phy->rx_amsdu[q].tail = skb;
 		phy->rx_amsdu[q].tail = &skb->next;
-		return;
 	}
 
-reset_burst:
-	phy->rx_amsdu[q].head = NULL;
-	phy->rx_amsdu[q].tail = NULL;
-enqueue:
-	if (nskb)
-		__skb_queue_tail(&dev->rx_skb[q], nskb);
+	if (!status->amsdu || status->last_amsdu)
+		mt76_rx_release_amsdu(phy, q);
 }
 
 void mt76_rx(struct mt76_dev *dev, enum mt76_rxq_id q, struct sk_buff *skb)
-- 
2.30.1

