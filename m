Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 308BCB0AEE
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 11:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbfILJGy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 05:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730575AbfILJGy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 05:06:54 -0400
Received: from localhost.localdomain (unknown [151.66.2.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58EB0208C2;
        Thu, 12 Sep 2019 09:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568279213;
        bh=Dja8yLq5tMSuiuzLWxFLnoQvTDSQ3VnPwLNHRIwcg7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pU8wFlslWc2m4tlpem73M9iuHLY7RMZCRTXYZBAKunbRGBMonvFwOHE2Y41LmogXa
         7rRJvWHFfkxV57X39vUjl0uDFUdeT1hlm5VZqrL2Dt5S0ykFHaDsIwFe64f5A4QKn7
         1Rnpj/2spctbwNdgiMrHHjcxaYAerqGwnOp6o0ic=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH 2/4] mt76: mt76x2: move mt76x02_mac_reset_counters in mt76x02_mac_start
Date:   Thu, 12 Sep 2019 11:06:36 +0200
Message-Id: <a891a308f4919dab3f13d7b4c8adc768dc9a5327.1568278771.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568278771.git.lorenzo@kernel.org>
References: <cover.1568278771.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76x02_mac_reset_counters in mt76x02_mac_start and get rid of
mt76x2_mac_start since it is just a wrapper for mt76x02_mac_start

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c   |  1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/mac.h     |  1 -
 .../net/wireless/mediatek/mt76/mt76x2/pci_init.c    | 13 ++-----------
 .../net/wireless/mediatek/mt76/mt76x2/pci_main.c    |  6 ++----
 4 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index dc773070481d..4e2371c926d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -343,6 +343,7 @@ EXPORT_SYMBOL_GPL(mt76x02_dma_disable);
 
 void mt76x02_mac_start(struct mt76x02_dev *dev)
 {
+	mt76x02_mac_reset_counters(dev);
 	mt76x02_dma_enable(dev);
 	mt76_wr(dev, MT_RX_FILTR_CFG, dev->mt76.rxfilter);
 	mt76_wr(dev, MT_MAC_SYS_CTRL,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/mac.h b/drivers/net/wireless/mediatek/mt76/mt76x2/mac.h
index a1583021e1e9..d5c3d26b94c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/mac.h
@@ -12,7 +12,6 @@ struct mt76x02_dev;
 struct mt76x2_sta;
 struct mt76x02_vif;
 
-int mt76x2_mac_start(struct mt76x02_dev *dev);
 void mt76x2_mac_stop(struct mt76x02_dev *dev, bool force);
 
 static inline void mt76x2_mac_resume(struct mt76x02_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
index 114e4fa4f4f6..3cf54963854a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
@@ -7,6 +7,7 @@
 #include "mt76x2.h"
 #include "eeprom.h"
 #include "mcu.h"
+#include "../mt76x02_mac.h"
 
 static void
 mt76x2_mac_pbf_init(struct mt76x02_dev *dev)
@@ -146,14 +147,6 @@ int mt76x2_mac_reset(struct mt76x02_dev *dev, bool hard)
 	return 0;
 }
 
-int mt76x2_mac_start(struct mt76x02_dev *dev)
-{
-	mt76x02_mac_reset_counters(dev);
-	mt76x02_mac_start(dev);
-
-	return 0;
-}
-
 static void
 mt76x2_power_on_rf_patch(struct mt76x02_dev *dev)
 {
@@ -256,9 +249,7 @@ static int mt76x2_init_hardware(struct mt76x02_dev *dev)
 		return ret;
 
 	set_bit(MT76_STATE_INITIALIZED, &dev->mt76.state);
-	ret = mt76x2_mac_start(dev);
-	if (ret)
-		return ret;
+	mt76x02_mac_start(dev);
 
 	ret = mt76x2_mcu_init(dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index 4971685aafe8..385960dca906 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -4,6 +4,7 @@
  */
 
 #include "mt76x2.h"
+#include "../mt76x02_mac.h"
 
 static int
 mt76x2_start(struct ieee80211_hw *hw)
@@ -11,10 +12,7 @@ mt76x2_start(struct ieee80211_hw *hw)
 	struct mt76x02_dev *dev = hw->priv;
 	int ret;
 
-	ret = mt76x2_mac_start(dev);
-	if (ret)
-		return ret;
-
+	mt76x02_mac_start(dev);
 	ret = mt76x2_phy_start(dev);
 	if (ret)
 		return ret;
-- 
2.21.0

