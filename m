Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B1719C1B0
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 15:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbgDBNID (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 09:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388322AbgDBNIC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 09:08:02 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B556920678;
        Thu,  2 Apr 2020 13:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585832882;
        bh=Uh6JOT0aZYC6AsgluYPttqMIAwnEgeKrzLqMAFlWKfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3t10QyxT/pnC38gVB678cXXPrH/BITM1aibUHjCMGhAI4Abd4clpGUZe1FgpFmLW
         FD63+Fe/LnO2BAXpeYu+F24TgLhtfVdp44AXAMDZoWjLp3ZJUDAdq45Yxo+LHH7BU2
         fyvgOVSQ3OZK7F9qwiJWZBIPyacy4Le8bW5dn38o=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 07/12] mt76: mt7663: keep Rx filters as the default
Date:   Thu,  2 Apr 2020 15:06:37 +0200
Message-Id: <52286a3c4f11f494d12575dc12feeb7aeea25118.1585832458.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585832458.git.lorenzo@kernel.org>
References: <cover.1585832458.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Keep Rx filters default value if the firmware supports offload and
low power features.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 24 +++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 8b7d8118d9ab..96b37f6ebf1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -22,7 +22,7 @@ static void mt7615_phy_init(struct mt7615_dev *dev)
 static void
 mt7615_init_mac_chain(struct mt7615_dev *dev, int chain)
 {
-	u32 val, mask, set;
+	u32 val;
 
 	if (!chain)
 		val = MT_CFG_CCR_MAC_D0_1X_GC_EN | MT_CFG_CCR_MAC_D0_2X_GC_EN;
@@ -62,15 +62,19 @@ mt7615_init_mac_chain(struct mt7615_dev *dev, int chain)
 		FIELD_PREP(MT_AGG_ARxCR_LIMIT(6), MT7615_RATE_RETRY - 1) |
 		FIELD_PREP(MT_AGG_ARxCR_LIMIT(7), MT7615_RATE_RETRY - 1));
 
-	mask = MT_DMA_RCFR0_MCU_RX_MGMT |
-	       MT_DMA_RCFR0_MCU_RX_CTL_NON_BAR |
-	       MT_DMA_RCFR0_MCU_RX_CTL_BAR |
-	       MT_DMA_RCFR0_MCU_RX_BYPASS |
-	       MT_DMA_RCFR0_RX_DROPPED_UCAST |
-	       MT_DMA_RCFR0_RX_DROPPED_MCAST;
-	set = FIELD_PREP(MT_DMA_RCFR0_RX_DROPPED_UCAST, 2) |
-	      FIELD_PREP(MT_DMA_RCFR0_RX_DROPPED_MCAST, 2);
-	mt76_rmw(dev, MT_DMA_RCFR0(chain), mask, set);
+	if (!mt7615_firmware_offload(dev)) {
+		u32 mask, set;
+
+		mask = MT_DMA_RCFR0_MCU_RX_MGMT |
+		       MT_DMA_RCFR0_MCU_RX_CTL_NON_BAR |
+		       MT_DMA_RCFR0_MCU_RX_CTL_BAR |
+		       MT_DMA_RCFR0_MCU_RX_BYPASS |
+		       MT_DMA_RCFR0_RX_DROPPED_UCAST |
+		       MT_DMA_RCFR0_RX_DROPPED_MCAST;
+		set = FIELD_PREP(MT_DMA_RCFR0_RX_DROPPED_UCAST, 2) |
+		      FIELD_PREP(MT_DMA_RCFR0_RX_DROPPED_MCAST, 2);
+		mt76_rmw(dev, MT_DMA_RCFR0(chain), mask, set);
+	}
 }
 
 static void mt7615_mac_init(struct mt7615_dev *dev)
-- 
2.25.1

