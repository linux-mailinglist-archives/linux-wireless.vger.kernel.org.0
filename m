Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E1E50C787
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Apr 2022 07:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiDWFTx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 01:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiDWFTw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 01:19:52 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691678D6B1
        for <linux-wireless@vger.kernel.org>; Fri, 22 Apr 2022 22:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WcYERNmbGHz6qnpdXVE+fTJevHMz5wvD2HERDxIzTKA=; b=LGu8eDCxK/Wujg2lPwoMOlRFrX
        mKnECNI9203Jz5H0bmnDAopmr68RMqIlupO2qtGHG5Dhk2c/heKpkSlOIo9UaaCVYGVn11vwfqdsI
        2iUE6s6mfiWiP0Ko7+q7xgDPbmO9WH/WaEqBV7sjjVQqgrhtr2euxL+xpKcE/3Uz0bPY=;
Received: from [217.114.218.20] (helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ni88b-0002gY-2W; Sat, 23 Apr 2022 07:16:53 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mt76: fix tx status related use-after-free race on station removal
Date:   Sat, 23 Apr 2022 07:16:48 +0200
Message-Id: <20220423051648.17362-1-nbd@nbd.name>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is a small race window where ongoing tx activity can lead to a skb
getting added to the status tracking idr after that idr has already been
cleaned up, which will keep the wcid linked in the status poll list.
Fix this by only adding status skbs if the wcid pointer is still assigned
in dev->wcid, which gets cleared early by mt76_sta_pre_rcu_remove

Fixes: bd1e3e7b693c ("mt76: introduce packet_id idr")
Tested-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 2 ++
 drivers/net/wireless/mediatek/mt76/tx.c       | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 2dd3ebd1863f..8a2fedbb1451 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1381,7 +1381,9 @@ void mt76_sta_pre_rcu_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
 
 	mutex_lock(&dev->mutex);
+	spin_lock_bh(&dev->status_lock);
 	rcu_assign_pointer(dev->wcid[wcid->idx], NULL);
+	spin_unlock_bh(&dev->status_lock);
 	mutex_unlock(&dev->mutex);
 }
 EXPORT_SYMBOL_GPL(mt76_sta_pre_rcu_remove);
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index c3be62f58b62..d5a8456c108b 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -120,7 +120,7 @@ mt76_tx_status_skb_add(struct mt76_dev *dev, struct mt76_wcid *wcid,
 
 	memset(cb, 0, sizeof(*cb));
 
-	if (!wcid)
+	if (!wcid || !rcu_access_pointer(dev->wcid[wcid->idx]))
 		return MT_PACKET_ID_NO_ACK;
 
 	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
-- 
2.35.1

