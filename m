Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E6265A9D0
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jan 2023 12:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjAALqI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Jan 2023 06:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjAALqH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Jan 2023 06:46:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B673BB
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 03:46:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90EE0B8090B
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 11:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB736C433D2;
        Sun,  1 Jan 2023 11:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672573561;
        bh=pOqEo970+Hpcx5K/JvSUDCduSwws39YY7NGpWSzQ7tY=;
        h=From:To:Cc:Subject:Date:From;
        b=MyKqT63YfUGQRm2o+qCQUMiHE0n8gFmdR+r+0wARDhK1J+oWkS1loQ4u4M28dwgdg
         9U3JNu9e9bg6YtVNO5obAGjKYpUxcpEquh0g+IPSPY/0HvSi1BdIjziLIQc2V8q8w2
         izw7pzg4lsxtbnq529saSSC29arP+83j+bMIo9iKG6G9NqHt/TYsZcMylDPwXBWj1e
         FJZrkthF275sWUIaSLKMqA+3shTiuo6j93MXzaFwN7OMmKNaXYinZcttvj+olM8B/Y
         +1MoY0TsnxR6Ia+fPw0DEwilePC45jgXVCGdxP0ur9r0k4ySAMTOTYPe281acSxDT4
         j9Ptwzy87uV8w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: introduce mt76_queue_is_wed_rx utility routine
Date:   Sun,  1 Jan 2023 12:35:49 +0100
Message-Id: <73955f97c18eabc82f43c8dcca1240ae09ccc8cd.1672572805.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch does not change any logic, just improve code readability.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c        | 6 ++----
 drivers/net/wireless/mediatek/mt76/mt76.h       | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 3 +--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 93a2e8ab64ed..f1368a6aed15 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -218,8 +218,7 @@ mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
 
 	ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
 
-	if ((q->flags & MT_QFLAG_WED) &&
-	    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX) {
+	if (mt76_queue_is_wed_rx(q)) {
 		txwi = mt76_get_rxwi(dev);
 		if (!txwi)
 			return -ENOMEM;
@@ -399,8 +398,7 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 	if (info)
 		*info = le32_to_cpu(desc->info);
 
-	if ((q->flags & MT_QFLAG_WED) &&
-	    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX) {
+	if (mt76_queue_is_wed_rx(q)) {
 		u32 token = FIELD_GET(MT_DMA_CTL_TOKEN,
 				      le32_to_cpu(desc->buf1));
 		struct mt76_txwi_cache *t = mt76_rx_token_release(dev, token);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 1037d23bc4d0..f351a37c47f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1409,6 +1409,12 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 			      struct mt76_power_limits *dest,
 			      s8 target_power);
 
+static inline bool mt76_queue_is_wed_rx(struct mt76_queue *q)
+{
+	return (q->flags & MT_QFLAG_WED) &&
+	       FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX;
+}
+
 struct mt76_txwi_cache *
 mt76_token_release(struct mt76_dev *dev, int token, bool *wake);
 int mt76_token_consume(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index f0d5a3603902..65727ce6c29e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -256,8 +256,7 @@ mt7915_wed_check_ppe(struct mt7915_dev *dev, struct mt76_queue *q,
 	if (!msta || !msta->vif)
 		return;
 
-	if (!(q->flags & MT_QFLAG_WED) ||
-	    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) != MT76_WED_Q_RX)
+	if (!mt76_queue_is_wed_rx(q))
 		return;
 
 	if (!(info & MT_DMA_INFO_PPE_VLD))
-- 
2.38.1

