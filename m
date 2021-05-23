Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC58438DD07
	for <lists+linux-wireless@lfdr.de>; Sun, 23 May 2021 23:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhEWVFB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 May 2021 17:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231956AbhEWVFA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 May 2021 17:05:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C791561076;
        Sun, 23 May 2021 21:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621803813;
        bh=9OaH11tQg0xRuiXdRvodUzQnC1B67LWxuWCmd4w4ed8=;
        h=From:To:Cc:Subject:Date:From;
        b=otvlvja7QeqtQeFc9rRmJHt09/KH/CkRP0mFRbsaqRT9Karf/5nglTBOANFR4qGsS
         HvaFIeopo+95reFv6RsEUJh0b2+PiKMyrmykIV/xBX4YxdL1ZZTNmu5plx6p1kYKPj
         ou9ReEf+XkLvOfNhvtG2gtc7R1Mw0ned9jWb+rYwqy06vCxQPk01yDVjCs7HqqpjQm
         So+dRYhH4zBRsrnQL9DH+lzEwSC19wOwBYtMgDzArr9HBJzaqsHW9HasXl02K9BaH6
         Wj0DK9kUtaKJUI7MoFPME0KKXSQ6KG5YguRH86P7L0l123f5s7rRVXyWYLpaY3zQVD
         0wrZUSOvDtjvg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: return proper error value in mt7921_mac_init
Date:   Sun, 23 May 2021 23:03:26 +0200
Message-Id: <c4ba4ec6cdb906982bb878732dfd32850f80960f.1621803709.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Return possible error values in mt7921_mac_init routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   | 8 +++-----
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    | 5 ++++-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index f4bf8360615f..2369b5ff81e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -109,7 +109,7 @@ mt7921_mac_init_band(struct mt7921_dev *dev, u8 band)
 	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
 }
 
-void mt7921_mac_init(struct mt7921_dev *dev)
+int mt7921_mac_init(struct mt7921_dev *dev)
 {
 	int i;
 
@@ -125,7 +125,7 @@ void mt7921_mac_init(struct mt7921_dev *dev)
 	for (i = 0; i < 2; i++)
 		mt7921_mac_init_band(dev, i);
 
-	mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b, 0);
+	return mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b, 0);
 }
 
 static int mt7921_init_hardware(struct mt7921_dev *dev)
@@ -165,9 +165,7 @@ static int mt7921_init_hardware(struct mt7921_dev *dev)
 	dev->mt76.global_wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	rcu_assign_pointer(dev->mt76.wcid[idx], &dev->mt76.global_wcid);
 
-	mt7921_mac_init(dev);
-
-	return 0;
+	return mt7921_mac_init(dev);
 }
 
 int mt7921_register_device(struct mt7921_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index e29d4fdab572..90a94974a28c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1297,7 +1297,10 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 	if (err)
 		return err;
 
-	mt7921_mac_init(dev);
+	err = mt7921_mac_init(dev);
+	if (err)
+		return err;
+
 	return __mt7921_start(&dev->phy);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 59862ea4951c..f3e0d0fa010e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -318,7 +318,7 @@ static inline bool mt7921_dma_need_reinit(struct mt7921_dev *dev)
 	return !mt76_get_field(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
 }
 
-void mt7921_mac_init(struct mt7921_dev *dev);
+int mt7921_mac_init(struct mt7921_dev *dev);
 bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask);
 void mt7921_mac_reset_counters(struct mt7921_phy *phy);
 void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
-- 
2.31.1

