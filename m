Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DA855A35D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jun 2022 23:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiFXVOr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jun 2022 17:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiFXVOq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jun 2022 17:14:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202BD86ACE
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jun 2022 14:14:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A285662385
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jun 2022 21:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC51EC34114;
        Fri, 24 Jun 2022 21:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656105283;
        bh=Gm00kx8p+J+sZTwTzKi798YTrkYU2cqHXMEcw2ps4Co=;
        h=From:To:Cc:Subject:Date:From;
        b=f4a/SfuaeO4ND+NEFpOp5q8dfMqRLUyj9Untfq9sjtN58YoDO/cPRI+r/T6uOsh8c
         okGl8W8nVYBuEt0ypd/muWZTCvp1PNycFA2bkuHXf3/p6VvAHn8MJK2raPk/ukmQRt
         Hodi+D7eIaODezbcF5x4tEeb6U4l0ar4gDMoMepCf5lsrP6Ex+0soAvd0E3ae2OILi
         a5nrHQL0ASVJCkr/v4rh/3REM69HxA2eVYUuLpwWMds9CHJtX6aenWAp8aJH73gABQ
         qaFqFljEKMQZ21zvNjx5BBfvxvP0fSCnnhphhzKtqS9X3Ih7q/G8yB2RCwXAutL1h0
         SeC8Eaf+yd1Cg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: connac: introduce mt76_connac_reg_map structure
Date:   Fri, 24 Jun 2022 23:14:33 +0200
Message-Id: <cf01928c24dfdd94af4e86e8f6855fb7283f358a.1656105220.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76_connac_reg_map structure in mt76-connac module since it
is used by all connac2 chipset. Align structure definitions.
This is a preliminary patch to add mt7990 chipset support.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   6 +
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 254 +++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |   8 +-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  76 +++---
 4 files changed, 170 insertions(+), 174 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 386d5572681d..a46379bdd74b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -63,6 +63,12 @@ enum {
 	REPEATER_BSSID_MAX = 0x3f,
 };
 
+struct mt76_connac_reg_map {
+	u32 phys;
+	u32 maps;
+	u32 size;
+};
+
 struct mt76_connac_pm {
 	bool enable:1;
 	bool enable_user:1;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 930fae7a0bd5..baed4696e829 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -204,147 +204,147 @@ static const u32 mt7916_offs[] = {
 	[ETBF_PAR_RPT0]		= 0x100,
 };
 
-static const struct __map mt7915_reg_map[] = {
+static const struct mt76_connac_reg_map mt7915_reg_map[] = {
 	{ 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
 	{ 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (configure regs) */
 	{ 0x40000000, 0x70000, 0x10000 }, /* WF_UMAC_SYSRAM */
-	{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA PCIE0 MCU DMA0 */
-	{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA PCIE0 MCU DMA1 */
-	{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
-	{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA PCIE1 MCU DMA1 */
+	{ 0x54000000, 0x02000, 0x01000 }, /* WFDMA PCIE0 MCU DMA0 */
+	{ 0x55000000, 0x03000, 0x01000 }, /* WFDMA PCIE0 MCU DMA1 */
+	{ 0x58000000, 0x06000, 0x01000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
+	{ 0x59000000, 0x07000, 0x01000 }, /* WFDMA PCIE1 MCU DMA1 */
 	{ 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
 	{ 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, WFDMA */
 	{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
 	{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
-	{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
-	{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
-	{ 0x820cc000, 0x0e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
-	{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
-	{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
+	{ 0x820c0000, 0x08000, 0x04000 }, /* WF_UMAC_TOP (PLE) */
+	{ 0x820c8000, 0x0c000, 0x02000 }, /* WF_UMAC_TOP (PSE) */
+	{ 0x820cc000, 0x0e000, 0x02000 }, /* WF_UMAC_TOP (PP) */
+	{ 0x820ce000, 0x21c00, 0x00200 }, /* WF_LMAC_TOP (WF_SEC) */
+	{ 0x820cf000, 0x22000, 0x01000 }, /* WF_LMAC_TOP (WF_PF) */
 	{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
-	{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
-	{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
-	{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
-	{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
-	{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
-	{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
-	{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
-	{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
-	{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
-	{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
-	{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
-	{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
-	{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
-	{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
-	{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
-	{ 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
-	{ 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
-	{ 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
-	{ 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
-	{ 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
-	{ 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
-	{ 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
-	{ 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
-	{ 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
+	{ 0x820e0000, 0x20000, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
+	{ 0x820e1000, 0x20400, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
+	{ 0x820e2000, 0x20800, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
+	{ 0x820e3000, 0x20c00, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
+	{ 0x820e4000, 0x21000, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
+	{ 0x820e5000, 0x21400, 0x00800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
+	{ 0x820e7000, 0x21e00, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
+	{ 0x820e9000, 0x23400, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
+	{ 0x820ea000, 0x24000, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
+	{ 0x820eb000, 0x24200, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
+	{ 0x820ec000, 0x24600, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
+	{ 0x820ed000, 0x24800, 0x00800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
+	{ 0x820f0000, 0xa0000, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
+	{ 0x820f1000, 0xa0600, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
+	{ 0x820f2000, 0xa0800, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
+	{ 0x820f3000, 0xa0c00, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
+	{ 0x820f4000, 0xa1000, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
+	{ 0x820f5000, 0xa1400, 0x00800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
+	{ 0x820f7000, 0xa1e00, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
+	{ 0x820f9000, 0xa3400, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
+	{ 0x820fa000, 0xa4000, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
+	{ 0x820fb000, 0xa4200, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
+	{ 0x820fc000, 0xa4600, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
+	{ 0x820fd000, 0xa4800, 0x00800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
 	{ 0x0, 0x0, 0x0 }, /* imply end of search */
 };
 
-static const struct __map mt7916_reg_map[] = {
-	{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA_0 (PCIE0 MCU DMA0) */
-	{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA_1 (PCIE0 MCU DMA1) */
-	{ 0x56000000, 0x04000, 0x1000 }, /* WFDMA_2 (Reserved) */
-	{ 0x57000000, 0x05000, 0x1000 }, /* WFDMA_3 (MCU wrap CR) */
-	{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA_4 (PCIE1 MCU DMA0) */
-	{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA_5 (PCIE1 MCU DMA1) */
-	{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
-	{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
-	{ 0x820cc000, 0x0e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
-	{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
-	{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
-	{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
-	{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
-	{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
-	{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
-	{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
-	{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
-	{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
-	{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
-	{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
-	{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
-	{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
-	{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
-	{ 0x820ca000, 0x26000, 0x2000 }, /* WF_LMAC_TOP BN0 (WF_MUCOP) */
-	{ 0x820d0000, 0x30000, 0x10000}, /* WF_LMAC_TOP (WF_WTBLON) */
-	{ 0x00400000, 0x80000, 0x10000}, /* WF_MCU_SYSRAM */
-	{ 0x00410000, 0x90000, 0x10000}, /* WF_MCU_SYSRAM (configure cr) */
-	{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
-	{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
-	{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
-	{ 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
-	{ 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
-	{ 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
-	{ 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
-	{ 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
-	{ 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
-	{ 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
-	{ 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
-	{ 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
-	{ 0x820c4000, 0xa8000, 0x1000 }, /* WF_LMAC_TOP (WF_UWTBL ) */
-	{ 0x820b0000, 0xae000, 0x1000 }, /* [APB2] WFSYS_ON */
-	{ 0x80020000, 0xb0000, 0x10000}, /* WF_TOP_MISC_OFF */
-	{ 0x81020000, 0xc0000, 0x10000}, /* WF_TOP_MISC_ON */
+static const struct mt76_connac_reg_map mt7916_reg_map[] = {
+	{ 0x54000000, 0x02000, 0x01000 }, /* WFDMA_0 (PCIE0 MCU DMA0) */
+	{ 0x55000000, 0x03000, 0x01000 }, /* WFDMA_1 (PCIE0 MCU DMA1) */
+	{ 0x56000000, 0x04000, 0x01000 }, /* WFDMA_2 (Reserved) */
+	{ 0x57000000, 0x05000, 0x01000 }, /* WFDMA_3 (MCU wrap CR) */
+	{ 0x58000000, 0x06000, 0x01000 }, /* WFDMA_4 (PCIE1 MCU DMA0) */
+	{ 0x59000000, 0x07000, 0x01000 }, /* WFDMA_5 (PCIE1 MCU DMA1) */
+	{ 0x820c0000, 0x08000, 0x04000 }, /* WF_UMAC_TOP (PLE) */
+	{ 0x820c8000, 0x0c000, 0x02000 }, /* WF_UMAC_TOP (PSE) */
+	{ 0x820cc000, 0x0e000, 0x02000 }, /* WF_UMAC_TOP (PP) */
+	{ 0x820e0000, 0x20000, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
+	{ 0x820e1000, 0x20400, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
+	{ 0x820e2000, 0x20800, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
+	{ 0x820e3000, 0x20c00, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
+	{ 0x820e4000, 0x21000, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
+	{ 0x820e5000, 0x21400, 0x00800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
+	{ 0x820ce000, 0x21c00, 0x00200 }, /* WF_LMAC_TOP (WF_SEC) */
+	{ 0x820e7000, 0x21e00, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
+	{ 0x820cf000, 0x22000, 0x01000 }, /* WF_LMAC_TOP (WF_PF) */
+	{ 0x820e9000, 0x23400, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
+	{ 0x820ea000, 0x24000, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
+	{ 0x820eb000, 0x24200, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
+	{ 0x820ec000, 0x24600, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
+	{ 0x820ed000, 0x24800, 0x00800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
+	{ 0x820ca000, 0x26000, 0x02000 }, /* WF_LMAC_TOP BN0 (WF_MUCOP) */
+	{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
+	{ 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
+	{ 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (configure cr) */
+	{ 0x820f0000, 0xa0000, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
+	{ 0x820f1000, 0xa0600, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
+	{ 0x820f2000, 0xa0800, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
+	{ 0x820f3000, 0xa0c00, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
+	{ 0x820f4000, 0xa1000, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
+	{ 0x820f5000, 0xa1400, 0x00800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
+	{ 0x820f7000, 0xa1e00, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
+	{ 0x820f9000, 0xa3400, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
+	{ 0x820fa000, 0xa4000, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
+	{ 0x820fb000, 0xa4200, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
+	{ 0x820fc000, 0xa4600, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
+	{ 0x820fd000, 0xa4800, 0x00800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
+	{ 0x820c4000, 0xa8000, 0x01000 }, /* WF_LMAC_TOP (WF_UWTBL ) */
+	{ 0x820b0000, 0xae000, 0x01000 }, /* [APB2] WFSYS_ON */
+	{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
+	{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
 	{ 0x0, 0x0, 0x0 }, /* imply end of search */
 };
 
-static const struct __map mt7986_reg_map[] = {
-	{ 0x54000000, 0x402000, 0x1000 }, /* WFDMA_0 (PCIE0 MCU DMA0) */
-	{ 0x55000000, 0x403000, 0x1000 }, /* WFDMA_1 (PCIE0 MCU DMA1) */
-	{ 0x56000000, 0x404000, 0x1000 }, /* WFDMA_2 (Reserved) */
-	{ 0x57000000, 0x405000, 0x1000 }, /* WFDMA_3 (MCU wrap CR) */
-	{ 0x58000000, 0x406000, 0x1000 }, /* WFDMA_4 (PCIE1 MCU DMA0) */
-	{ 0x59000000, 0x407000, 0x1000 }, /* WFDMA_5 (PCIE1 MCU DMA1) */
-	{ 0x820c0000, 0x408000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
-	{ 0x820c8000, 0x40c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
-	{ 0x820cc000, 0x40e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
-	{ 0x820e0000, 0x420000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
-	{ 0x820e1000, 0x420400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
-	{ 0x820e2000, 0x420800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
-	{ 0x820e3000, 0x420c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
-	{ 0x820e4000, 0x421000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
-	{ 0x820e5000, 0x421400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
-	{ 0x820ce000, 0x421c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
-	{ 0x820e7000, 0x421e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
-	{ 0x820cf000, 0x422000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
-	{ 0x820e9000, 0x423400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
-	{ 0x820ea000, 0x424000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
-	{ 0x820eb000, 0x424200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
-	{ 0x820ec000, 0x424600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
-	{ 0x820ed000, 0x424800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
-	{ 0x820ca000, 0x426000, 0x2000 }, /* WF_LMAC_TOP BN0 (WF_MUCOP) */
-	{ 0x820d0000, 0x430000, 0x10000}, /* WF_LMAC_TOP (WF_WTBLON) */
-	{ 0x00400000, 0x480000, 0x10000}, /* WF_MCU_SYSRAM */
-	{ 0x00410000, 0x490000, 0x10000}, /* WF_MCU_SYSRAM */
-	{ 0x820f0000, 0x4a0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
-	{ 0x820f1000, 0x4a0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
-	{ 0x820f2000, 0x4a0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
-	{ 0x820f3000, 0x4a0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
-	{ 0x820f4000, 0x4a1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
-	{ 0x820f5000, 0x4a1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
-	{ 0x820f7000, 0x4a1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
-	{ 0x820f9000, 0x4a3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
-	{ 0x820fa000, 0x4a4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
-	{ 0x820fb000, 0x4a4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
-	{ 0x820fc000, 0x4a4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
-	{ 0x820fd000, 0x4a4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
-	{ 0x820c4000, 0x4a8000, 0x1000 }, /* WF_LMAC_TOP (WF_UWTBL ) */
-	{ 0x820b0000, 0x4ae000, 0x1000 }, /* [APB2] WFSYS_ON */
-	{ 0x80020000, 0x4b0000, 0x10000}, /* WF_TOP_MISC_OFF */
-	{ 0x81020000, 0x4c0000, 0x10000}, /* WF_TOP_MISC_ON */
-	{ 0x89000000, 0x4d0000, 0x1000 }, /* WF_MCU_CFG_ON */
-	{ 0x89010000, 0x4d1000, 0x1000 }, /* WF_MCU_CIRQ */
-	{ 0x89020000, 0x4d2000, 0x1000 }, /* WF_MCU_GPT */
-	{ 0x89030000, 0x4d3000, 0x1000 }, /* WF_MCU_WDT */
-	{ 0x80010000, 0x4d4000, 0x1000 }, /* WF_AXIDMA */
+static const struct mt76_connac_reg_map mt7986_reg_map[] = {
+	{ 0x54000000, 0x402000, 0x01000 }, /* WFDMA_0 (PCIE0 MCU DMA0) */
+	{ 0x55000000, 0x403000, 0x01000 }, /* WFDMA_1 (PCIE0 MCU DMA1) */
+	{ 0x56000000, 0x404000, 0x01000 }, /* WFDMA_2 (Reserved) */
+	{ 0x57000000, 0x405000, 0x01000 }, /* WFDMA_3 (MCU wrap CR) */
+	{ 0x58000000, 0x406000, 0x01000 }, /* WFDMA_4 (PCIE1 MCU DMA0) */
+	{ 0x59000000, 0x407000, 0x01000 }, /* WFDMA_5 (PCIE1 MCU DMA1) */
+	{ 0x820c0000, 0x408000, 0x04000 }, /* WF_UMAC_TOP (PLE) */
+	{ 0x820c8000, 0x40c000, 0x02000 }, /* WF_UMAC_TOP (PSE) */
+	{ 0x820cc000, 0x40e000, 0x02000 }, /* WF_UMAC_TOP (PP) */
+	{ 0x820e0000, 0x420000, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
+	{ 0x820e1000, 0x420400, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
+	{ 0x820e2000, 0x420800, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
+	{ 0x820e3000, 0x420c00, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
+	{ 0x820e4000, 0x421000, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
+	{ 0x820e5000, 0x421400, 0x00800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
+	{ 0x820ce000, 0x421c00, 0x00200 }, /* WF_LMAC_TOP (WF_SEC) */
+	{ 0x820e7000, 0x421e00, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
+	{ 0x820cf000, 0x422000, 0x01000 }, /* WF_LMAC_TOP (WF_PF) */
+	{ 0x820e9000, 0x423400, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
+	{ 0x820ea000, 0x424000, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
+	{ 0x820eb000, 0x424200, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
+	{ 0x820ec000, 0x424600, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
+	{ 0x820ed000, 0x424800, 0x00800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
+	{ 0x820ca000, 0x426000, 0x02000 }, /* WF_LMAC_TOP BN0 (WF_MUCOP) */
+	{ 0x820d0000, 0x430000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
+	{ 0x00400000, 0x480000, 0x10000 }, /* WF_MCU_SYSRAM */
+	{ 0x00410000, 0x490000, 0x10000 }, /* WF_MCU_SYSRAM */
+	{ 0x820f0000, 0x4a0000, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
+	{ 0x820f1000, 0x4a0600, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
+	{ 0x820f2000, 0x4a0800, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
+	{ 0x820f3000, 0x4a0c00, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
+	{ 0x820f4000, 0x4a1000, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
+	{ 0x820f5000, 0x4a1400, 0x00800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
+	{ 0x820f7000, 0x4a1e00, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
+	{ 0x820f9000, 0x4a3400, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
+	{ 0x820fa000, 0x4a4000, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
+	{ 0x820fb000, 0x4a4200, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
+	{ 0x820fc000, 0x4a4600, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
+	{ 0x820fd000, 0x4a4800, 0x00800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
+	{ 0x820c4000, 0x4a8000, 0x01000 }, /* WF_LMAC_TOP (WF_UWTBL ) */
+	{ 0x820b0000, 0x4ae000, 0x01000 }, /* [APB2] WFSYS_ON */
+	{ 0x80020000, 0x4b0000, 0x10000 }, /* WF_TOP_MISC_OFF */
+	{ 0x81020000, 0x4c0000, 0x10000 }, /* WF_TOP_MISC_ON */
+	{ 0x89000000, 0x4d0000, 0x01000 }, /* WF_MCU_CFG_ON */
+	{ 0x89010000, 0x4d1000, 0x01000 }, /* WF_MCU_CIRQ */
+	{ 0x89020000, 0x4d2000, 0x01000 }, /* WF_MCU_GPT */
+	{ 0x89030000, 0x4d3000, 0x01000 }, /* WF_MCU_WDT */
+	{ 0x80010000, 0x4d4000, 0x01000 }, /* WF_AXIDMA */
 	{ 0x0, 0x0, 0x0 }, /* imply end of search */
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 77fd448beed7..51f3d8af4d4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -4,17 +4,11 @@
 #ifndef __MT7915_REGS_H
 #define __MT7915_REGS_H
 
-struct __map {
-	u32 phys;
-	u32 maps;
-	u32 size;
-};
-
 /* used to differentiate between generations */
 struct mt7915_reg_desc {
 	const u32 *reg_rev;
 	const u32 *offs_rev;
-	const struct __map *map;
+	const struct mt76_connac_reg_map *map;
 	u32 map_size;
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 06af35250b3b..4b32c4cc2e5a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -123,54 +123,50 @@ static void mt7921e_unregister_device(struct mt7921_dev *dev)
 
 static u32 __mt7921_reg_addr(struct mt7921_dev *dev, u32 addr)
 {
-	static const struct {
-		u32 phys;
-		u32 mapped;
-		u32 size;
-	} fixed_map[] = {
+	static const struct mt76_connac_reg_map fixed_map[] = {
 		{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
-		{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
-		{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
-		{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
-		{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
-		{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
-		{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
-		{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
+		{ 0x820ed000, 0x24800, 0x00800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
+		{ 0x820e4000, 0x21000, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
+		{ 0x820e7000, 0x21e00, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
+		{ 0x820eb000, 0x24200, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
+		{ 0x820e2000, 0x20800, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
+		{ 0x820e3000, 0x20c00, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
+		{ 0x820e5000, 0x21400, 0x00800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
 		{ 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
 		{ 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (configure register) */
 		{ 0x40000000, 0x70000, 0x10000 }, /* WF_UMAC_SYSRAM */
-		{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA PCIE0 MCU DMA0 */
-		{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA PCIE0 MCU DMA1 */
-		{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
-		{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA PCIE1 MCU DMA1 */
+		{ 0x54000000, 0x02000, 0x01000 }, /* WFDMA PCIE0 MCU DMA0 */
+		{ 0x55000000, 0x03000, 0x01000 }, /* WFDMA PCIE0 MCU DMA1 */
+		{ 0x58000000, 0x06000, 0x01000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
+		{ 0x59000000, 0x07000, 0x01000 }, /* WFDMA PCIE1 MCU DMA1 */
 		{ 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
 		{ 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, WFDMA */
 		{ 0x7c060000, 0xe0000, 0x10000 }, /* CONN_INFRA, conn_host_csr_top */
 		{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
 		{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
-		{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
-		{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
-		{ 0x820cc000, 0x0e000, 0x1000 }, /* WF_UMAC_TOP (PP) */
-		{ 0x820cd000, 0x0f000, 0x1000 }, /* WF_MDP_TOP */
-		{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
-		{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
-		{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
-		{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
-		{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
-		{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
-		{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
-		{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
-		{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
-		{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
-		{ 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
-		{ 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
-		{ 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
-		{ 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
-		{ 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
-		{ 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
-		{ 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
-		{ 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
-		{ 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
+		{ 0x820c0000, 0x08000, 0x04000 }, /* WF_UMAC_TOP (PLE) */
+		{ 0x820c8000, 0x0c000, 0x02000 }, /* WF_UMAC_TOP (PSE) */
+		{ 0x820cc000, 0x0e000, 0x01000 }, /* WF_UMAC_TOP (PP) */
+		{ 0x820cd000, 0x0f000, 0x01000 }, /* WF_MDP_TOP */
+		{ 0x820ce000, 0x21c00, 0x00200 }, /* WF_LMAC_TOP (WF_SEC) */
+		{ 0x820cf000, 0x22000, 0x01000 }, /* WF_LMAC_TOP (WF_PF) */
+		{ 0x820e0000, 0x20000, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
+		{ 0x820e1000, 0x20400, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
+		{ 0x820e9000, 0x23400, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
+		{ 0x820ea000, 0x24000, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
+		{ 0x820ec000, 0x24600, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
+		{ 0x820f0000, 0xa0000, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
+		{ 0x820f1000, 0xa0600, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
+		{ 0x820f2000, 0xa0800, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
+		{ 0x820f3000, 0xa0c00, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
+		{ 0x820f4000, 0xa1000, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
+		{ 0x820f5000, 0xa1400, 0x00800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
+		{ 0x820f7000, 0xa1e00, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
+		{ 0x820f9000, 0xa3400, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
+		{ 0x820fa000, 0xa4000, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
+		{ 0x820fb000, 0xa4200, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
+		{ 0x820fc000, 0xa4600, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
+		{ 0x820fd000, 0xa4800, 0x00800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
 	};
 	int i;
 
@@ -187,7 +183,7 @@ static u32 __mt7921_reg_addr(struct mt7921_dev *dev, u32 addr)
 		if (ofs > fixed_map[i].size)
 			continue;
 
-		return fixed_map[i].mapped + ofs;
+		return fixed_map[i].maps + ofs;
 	}
 
 	if ((addr >= 0x18000000 && addr < 0x18c00000) ||
-- 
2.36.1

