Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616A13636C3
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhDRQqg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232095AbhDRQqg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDD0C6135D;
        Sun, 18 Apr 2021 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764367;
        bh=LCzANB/MXiKU/3fnjO0RYiby0QCBO5lTsoUBIJoPlTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lPgGC+e2GuqFaGjdmMWQeroo/Oq5zK/nGw/eeKUsfV8/9MmY4yfjE9Al3vBXCXj39
         ri2Fpi1QqIz9Y/dvlbuXGGaFbQ1Nu8Oz58Pz4lkd97Uo9x6mPmlx7KoVzqh84zZFAm
         FIaOA+CRLwxcAVvS47vS+2QKGIN2mpwxLGlSUzGLsnodxRa8+smyoqgsRXCqHwNmgC
         1chZ8sa+BMiDiDmkekxXt0xsMGbSqA6qxXbvWi9e1gopqGGASDztEZ4W1rYCbskN45
         kKZOEBSkITMQKiy9jUrFpfJWB1uBMtbbJ+buq5TGTQBEOxELP5YpR9+DbhLVZ03y5d
         TtfkDxngyueNg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 09/19] mt76: connac: unschedule ps_work in mt76_connac_pm_wake
Date:   Sun, 18 Apr 2021 18:45:35 +0200
Message-Id: <da190226104f56203436a3d4c4a021505cfddef1.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to avoid synchronization issues between wake and ps works,
cancel ps_work in mt76_connac_pm_wake routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      | 1 -
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 7081bb4a28bd..5890fee98d97 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -345,7 +345,6 @@ static int mt7615_mcu_lp_drv_pmctrl(struct mt7615_dev *dev)
 	clear_bit(MT76_STATE_PM, &mphy->state);
 
 out:
-	dev->pm.last_activity = jiffies;
 	mutex_unlock(&dev->pm.mutex);
 
 	return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index c5f5037f5757..32d664ac1e35 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -13,6 +13,7 @@ int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm)
 	if (!mt76_is_mmio(dev))
 		return 0;
 
+	cancel_delayed_work_sync(&pm->ps_work);
 	if (!test_bit(MT76_STATE_PM, &phy->state))
 		return 0;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index ea00f6b6af56..44f02cbf9cc7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1289,7 +1289,6 @@ int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
 	clear_bit(MT76_STATE_PM, &mphy->state);
 
 out:
-	dev->pm.last_activity = jiffies;
 	mutex_unlock(&dev->pm.mutex);
 
 	if (err)
-- 
2.30.2

