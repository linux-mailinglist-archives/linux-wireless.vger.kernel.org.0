Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74494CA915
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Mar 2022 16:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243475AbiCBPdx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Mar 2022 10:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbiCBPdw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Mar 2022 10:33:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEDC4474E
        for <linux-wireless@vger.kernel.org>; Wed,  2 Mar 2022 07:33:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DDCA7CE21CF
        for <linux-wireless@vger.kernel.org>; Wed,  2 Mar 2022 15:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29498C004E1;
        Wed,  2 Mar 2022 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646235186;
        bh=2cPmJGuxoQl4H7Fdwt0eESoC2C+3ZK2DPyn7Dju87uM=;
        h=From:To:Cc:Subject:Date:From;
        b=ktd03imZPjWHj5aYOaQGpEhxacQPuzPejMsbH4aT5StnQRdliS6C1/3J9rlUW/0i0
         V0PouHDq7YC5w5ruvYQVSPzwzZ33bFwFIei+4bdo2nus05CW2XdKHZf8BBUX7ubo5i
         K2u9frlBmneNkHWKF4unrjANs+g2CsXNcpWmIemuhQB8zCXiC8kyZ9eBhQSrqLvfxd
         XK08g8Zn+xPBdDDsQW6EcRkEhC9rDXx+d7IMDJWx2nOk88ka6t2hWMd3oIlDkTOD1u
         ZZ+tIfiUW54BgqFSPkDm6f1wR5U5IYe9tFNKnetXOevPqAG/qwjxYkT2HXlGtMhQPU
         HxzCLOfiq+elA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7921: make mt7921_init_tx_queues static
Date:   Wed,  2 Mar 2022 16:32:57 +0100
Message-Id: <0048d29450b30adccbd7ea8e9e959ead87f0a5df.1646235119.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7921 is only used in mt7921_dma_init routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 39d6ce4ecddd..ca7e20fb5fc0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -5,7 +5,7 @@
 #include "../dma.h"
 #include "mac.h"
 
-int mt7921_init_tx_queues(struct mt7921_phy *phy, int idx, int n_desc)
+static int mt7921_init_tx_queues(struct mt7921_phy *phy, int idx, int n_desc)
 {
 	int i, err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 9edc83f06139..f8bfd987fbc9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -384,7 +384,6 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 void mt7921_tx_worker(struct mt76_worker *w);
 void mt7921e_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
-int mt7921_init_tx_queues(struct mt7921_phy *phy, int idx, int n_desc);
 void mt7921_tx_token_put(struct mt7921_dev *dev);
 void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
-- 
2.35.1

