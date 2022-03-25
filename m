Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59004E7BC4
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Mar 2022 01:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiCYVMV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 17:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiCYVMR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 17:12:17 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7CF1FE54C
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/WtNl/o5Pmcjf/ZiCwFNzmbnFHHYcHXG9vVzdZA7COQ=; b=bNgPiYZZgOCGTr5wRh7JAwpsnw
        vOCmNufBjt4N4fuYVPRSDXIhjRDvmm9jI/IT5d6V7Ef/zvY+wqa4WKtAxVug9EkEItbaY9RO3gFmE
        nsBP6Sfl8U5l+O0djbhd2Vd2fDMDaIvhaGifg1WYrBLqn9l/+ulIm7aqu6GN8qr1LWCQ=;
Received: from p200300daa70ef200dc11dea3d730df97.dip0.t-ipconnect.de ([2003:da:a70e:f200:dc11:dea3:d730:df97] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nXrCh-0001fW-ST
        for linux-wireless@vger.kernel.org; Fri, 25 Mar 2022 22:10:39 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/8] mt76: dma: use kzalloc instead of devm_kzalloc for txwi
Date:   Fri, 25 Mar 2022 22:10:27 +0100
Message-Id: <20220325211031.24171-4-nbd@nbd.name>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325211031.24171-1-nbd@nbd.name>
References: <20220325211031.24171-1-nbd@nbd.name>
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

dma unmap is already needed for cleanup anyway, so we don't need the extra
tracking and can save a bit of memory here

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 02daeefb0761..09dc37bbf112 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -16,7 +16,7 @@ mt76_alloc_txwi(struct mt76_dev *dev)
 	int size;
 
 	size = L1_CACHE_ALIGN(dev->drv->txwi_size + sizeof(*t));
-	txwi = devm_kzalloc(dev->dev, size, GFP_ATOMIC);
+	txwi = kzalloc(size, GFP_ATOMIC);
 	if (!txwi)
 		return NULL;
 
@@ -73,9 +73,11 @@ mt76_free_pending_txwi(struct mt76_dev *dev)
 	struct mt76_txwi_cache *t;
 
 	local_bh_disable();
-	while ((t = __mt76_get_txwi(dev)) != NULL)
+	while ((t = __mt76_get_txwi(dev)) != NULL) {
 		dma_unmap_single(dev->dev, t->dma_addr, dev->drv->txwi_size,
 				 DMA_TO_DEVICE);
+		kfree(mt76_get_txwi_ptr(dev, t));
+	}
 	local_bh_enable();
 }
 
-- 
2.35.1

