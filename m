Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F7351BE47
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 13:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358195AbiEELlx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 07:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350382AbiEELlv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 07:41:51 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361A249922
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 04:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2QatfP3eiw2VHAziiwH2RFO5u0QCAIGlUJFocOR7D68=; b=LH/OzA7gGaDTdSGSM+wNu0C71W
        d6gJ/Z0MRMvJC1qJ0nUW5DpX1VmnBMvT7vwQh6rClx/75JUx7qzKlQJCU7I2362U46zrjkv3rYQ5W
        /L9EXoobNERJSJu8WfsBTgMSrM9OhvtJFDkY2vQi+hhvgD/MMrp97CIphz/zpcwVa/Lk=;
Received: from p200300daa70ef200412f484bca3869cd.dip0.t-ipconnect.de ([2003:da:a70e:f200:412f:484b:ca38:69cd] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nmZo9-0007Ts-Io
        for linux-wireless@vger.kernel.org; Thu, 05 May 2022 13:38:09 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/4] mt76: make number of tokens configurable dynamically
Date:   Thu,  5 May 2022 13:37:28 +0200
Message-Id: <20220505113729.50380-3-nbd@nbd.name>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505113729.50380-1-nbd@nbd.name>
References: <20220505113729.50380-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Preparation for adding Wireless Ethernet Dispatch support

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt76.h     | 6 +++---
 drivers/net/wireless/mediatek/mt76/tx.c       | 7 +++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 41e59f34f02a..9056d09d6c33 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -580,6 +580,7 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	INIT_LIST_HEAD(&dev->wcid_list);
 
 	INIT_LIST_HEAD(&dev->txwi_cache);
+	dev->token_size = dev->drv->token_size;
 
 	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++)
 		skb_queue_head_init(&dev->rx_skb[i]);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 9a2fc77243bf..dce86846e648 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -719,7 +719,8 @@ struct mt76_dev {
 
 	spinlock_t token_lock;
 	struct idr token;
-	int token_count;
+	u16 token_count;
+	u16 token_size;
 
 	wait_queue_head_t tx_wait;
 	/* spinclock used to protect wcid pktid linked list */
@@ -1381,8 +1382,7 @@ mt76_token_get(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi)
 	int token;
 
 	spin_lock_bh(&dev->token_lock);
-	token = idr_alloc(&dev->token, *ptxwi, 0, dev->drv->token_size,
-			  GFP_ATOMIC);
+	token = idr_alloc(&dev->token, *ptxwi, 0, dev->token_size, GFP_ATOMIC);
 	spin_unlock_bh(&dev->token_lock);
 
 	return token;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index d5a8456c108b..84fa922c977a 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -722,12 +722,11 @@ int mt76_token_consume(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi)
 
 	spin_lock_bh(&dev->token_lock);
 
-	token = idr_alloc(&dev->token, *ptxwi, 0, dev->drv->token_size,
-			  GFP_ATOMIC);
+	token = idr_alloc(&dev->token, *ptxwi, 0, dev->token_size, GFP_ATOMIC);
 	if (token >= 0)
 		dev->token_count++;
 
-	if (dev->token_count >= dev->drv->token_size - MT76_TOKEN_FREE_THR)
+	if (dev->token_count >= dev->token_size - MT76_TOKEN_FREE_THR)
 		__mt76_set_tx_blocked(dev, true);
 
 	spin_unlock_bh(&dev->token_lock);
@@ -747,7 +746,7 @@ mt76_token_release(struct mt76_dev *dev, int token, bool *wake)
 	if (txwi)
 		dev->token_count--;
 
-	if (dev->token_count < dev->drv->token_size - MT76_TOKEN_FREE_THR &&
+	if (dev->token_count < dev->token_size - MT76_TOKEN_FREE_THR &&
 	    dev->phy.q_tx[0]->blocked)
 		*wake = true;
 
-- 
2.35.1

