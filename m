Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E3D564EEA
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 09:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiGDHnm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 03:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiGDHnl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 03:43:41 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E4DB65
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 00:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1nO5qKptci1Np7C30tHRT1wHMrUdntkCINJ5zocxRG8=; b=hy1MNH7JZKaIjmr4bUP74VHEkr
        FfGUjWGUby8G/yD4nuRNNiZvNLKoGRpYPgr7q2En5HmtLMhCuwGHug9va5o/NUXC/M/GTFtjwQxOk
        xLYXr3KpTAQcNYjQK0TR1aV5vbxOOa8/i21b6qiVgzV0mD/rJKPw50W4nEtxpDJu9MIY=;
Received: from p200300daa726cc0049e0488d38233d42.dip0.t-ipconnect.de ([2003:da:a726:cc00:49e0:488d:3823:3d42] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o8Gk6-00049K-GL
        for linux-wireless@vger.kernel.org; Mon, 04 Jul 2022 09:43:38 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: remove q->qid
Date:   Mon,  4 Jul 2022 09:43:36 +0200
Message-Id: <20220704074336.28043-1-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
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

It is no longer used

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 3 ---
 drivers/net/wireless/mediatek/mt76/sdio.c | 2 --
 drivers/net/wireless/mediatek/mt76/usb.c  | 1 -
 3 files changed, 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index cb712c0438c2..f25f2dad43d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -185,7 +185,6 @@ struct mt76_queue {
 
 	u8 buf_offset;
 	u8 hw_idx;
-	u8 qid;
 	u8 flags;
 
 	u32 wed_regs;
@@ -977,7 +976,6 @@ static inline int mt76_init_tx_queue(struct mt76_phy *phy, int qid, int idx,
 	if (IS_ERR(q))
 		return PTR_ERR(q);
 
-	q->qid = qid;
 	phy->q_tx[qid] = q;
 
 	return 0;
@@ -992,7 +990,6 @@ static inline int mt76_init_mcu_queue(struct mt76_dev *dev, int qid, int idx,
 	if (IS_ERR(q))
 		return PTR_ERR(q);
 
-	q->qid = __MT_TXQ_MAX + qid;
 	dev->q_mcu[qid] = q;
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 974fdbf0ffab..aba2a9865821 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -350,7 +350,6 @@ int mt76s_alloc_tx(struct mt76_dev *dev)
 		if (IS_ERR(q))
 			return PTR_ERR(q);
 
-		q->qid = i;
 		dev->phy.q_tx[i] = q;
 	}
 
@@ -358,7 +357,6 @@ int mt76s_alloc_tx(struct mt76_dev *dev)
 	if (IS_ERR(q))
 		return PTR_ERR(q);
 
-	q->qid = MT_MCUQ_WM;
 	dev->q_mcu[MT_MCUQ_WM] = q;
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index b030b567989b..6b8964c19f50 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -937,7 +937,6 @@ static int mt76u_alloc_tx(struct mt76_dev *dev)
 
 		spin_lock_init(&q->lock);
 		q->hw_idx = mt76u_ac_to_hwq(dev, i);
-		q->qid = i;
 
 		dev->phy.q_tx[i] = q;
 
-- 
2.36.1

