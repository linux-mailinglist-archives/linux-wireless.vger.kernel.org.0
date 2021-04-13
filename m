Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DD735D9D0
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 10:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242384AbhDMIQA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 04:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242343AbhDMIQA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 04:16:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8BC161242;
        Tue, 13 Apr 2021 08:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618301740;
        bh=1mUv6lZM1xtTJps70EWh15Uh+FrMPrQ/hEi5bv2n2nQ=;
        h=From:To:Cc:Subject:Date:From;
        b=WB0WiFWtpomUSCVBb+doxavLISyvdCgLdA0txve85xqOEV1uwR0WCUWNVpPlW+jVH
         Ie5DYfM23OwUVU016E7AYCpGxcPG1ppkZQyeRs3h6Wxsiv9JUcIppUd1hc9Tu7hxLT
         ORz60JHJ6n52HX2yi7UDBFwPAMMgNk+YeNopr95cw3QipLrlZBCcQ0eOBfcPAY6xeH
         Kw61QBxZ8VmFZJxCOtLNZKd8I7YnuGjYxw8ZwOerLYxpPltayh8jEgwLrlrAxrbBJa
         m2mlrJ7CJVzXy6kK+K0Fjy9Zs1aRUPVJks18FzedOrWVDh9ONV9h8nP3v1kWKMkfn/
         IEyTBplTLJ3kQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: get rid of mt7921_dma_cleanup
Date:   Tue, 13 Apr 2021 10:15:35 +0200
Message-Id: <a685211cdac6d961744cbbc6c9af54c177023e95.1618301684.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove mt7921_dma_cleanup routine since it is no longer used

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 23 -------------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 -
 2 files changed, 24 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 992faf82ad09..14e694563a89 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -331,26 +331,3 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 
 	return 0;
 }
-
-void mt7921_dma_cleanup(struct mt7921_dev *dev)
-{
-	/* disable */
-	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
-		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-		   MT_WFDMA0_GLO_CFG_RX_DMA_EN |
-		   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
-		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
-		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
-
-	/* reset */
-	mt76_clear(dev, MT_WFDMA0_RST,
-		   MT_WFDMA0_RST_DMASHDL_ALL_RST |
-		   MT_WFDMA0_RST_LOGIC_RST);
-
-	mt76_set(dev, MT_WFDMA0_RST,
-		 MT_WFDMA0_RST_DMASHDL_ALL_RST |
-		 MT_WFDMA0_RST_LOGIC_RST);
-
-	mt76_dma_cleanup(&dev->mt76);
-}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index e3d83d3d954c..1e70c749bbf3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -225,7 +225,6 @@ int mt7921_eeprom_get_target_power(struct mt7921_dev *dev,
 void mt7921_eeprom_init_sku(struct mt7921_dev *dev);
 int mt7921_dma_init(struct mt7921_dev *dev);
 void mt7921_dma_prefetch(struct mt7921_dev *dev);
-void mt7921_dma_cleanup(struct mt7921_dev *dev);
 int mt7921_run_firmware(struct mt7921_dev *dev);
 int mt7921_mcu_init(struct mt7921_dev *dev);
 int mt7921_mcu_add_bss_info(struct mt7921_phy *phy,
-- 
2.30.2

