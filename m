Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA0E3AC5C3
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 10:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhFRIKz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 04:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232671AbhFRIKw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 04:10:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 989F26128C;
        Fri, 18 Jun 2021 08:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624003721;
        bh=G4rN1UkIqSWKx3WVJNhpoCePTaju9czyLNMc01eK5XE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPQfUuvie8S7aKQzS/8p1bgvVtDPpyhQ4u4xq7wOjfHMbUMMKliZUDoSgadOEpa/y
         9xUFsD6d+Dvi81NT7zIsKk66TgFhOH68AtHEVgS5bu8ImpA4LctjKNb4WKYOsLZdAL
         jZhWuq5AhaDSz49idvNA8tW0JOJzroDvqbD1f3FIwWyBAMiOEZJvK3Xl8J0E0AQ0BL
         lXkzsL5WWLWJqPd9C0dxBUjO/azj1zVW8ZiBdaXLgtRm9xXGvVNaERp3BM6KVxgugF
         KGP8+MKyIo23q5WpWJNacVrgVlUTC+9/XfbQBWv1oJSvJfEoEnGxTF6lsFkDUoFxAb
         FlGdztW67TOAw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH v2 4/5] mt76: mt7663s: enable runtime-pm
Date:   Fri, 18 Jun 2021 10:08:23 +0200
Message-Id: <784173403172cdf5d4cc1d1f33f98fbd5fe3c0a4.1624003282.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624003282.git.lorenzo@kernel.org>
References: <cover.1624003282.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allow the user to enable runtime-pm for mt7663s driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio_mcu.c    | 13 ++++++++++---
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c    |  4 ++--
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 8cb4426e757c..cb4659771fd9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -75,7 +75,7 @@ mt7615_pm_set(void *data, u64 val)
 	if (!mt7615_wait_for_mcu_init(dev))
 		return 0;
 
-	if (!mt7615_firmware_offload(dev) || !mt76_is_mmio(&dev->mt76))
+	if (!mt7615_firmware_offload(dev) || mt76_is_usb(&dev->mt76))
 		return -EOPNOTSUPP;
 
 	if (val == pm->enable)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index 6c23c6dbf1c6..45c1cd3b9f49 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -65,13 +65,16 @@ static int __mt7663s_mcu_drv_pmctrl(struct mt7615_dev *dev)
 
 	ret = readx_poll_timeout(mt7663s_read_pcr, dev, status,
 				 status & WHLPCR_IS_DRIVER_OWN, 2000, 1000000);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(dev->mt76.dev, "Cannot get ownership from device");
-	else
+	} else {
 		clear_bit(MT76_STATE_PM, &mphy->state);
 
+		pm->stats.last_wake_event = jiffies;
+		pm->stats.doze_time += pm->stats.last_wake_event -
+				       pm->stats.last_doze_event;
+	}
 	sdio_release_host(func);
-	pm->last_activity = jiffies;
 
 	return ret;
 }
@@ -113,6 +116,10 @@ static int mt7663s_mcu_fw_pmctrl(struct mt7615_dev *dev)
 	if (ret < 0) {
 		dev_err(dev->mt76.dev, "Cannot set ownership to device");
 		clear_bit(MT76_STATE_PM, &mphy->state);
+	} else {
+		pm->stats.last_doze_event = jiffies;
+		pm->stats.awake_time += pm->stats.last_doze_event -
+					pm->stats.last_wake_event;
 	}
 
 	sdio_release_host(func);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 5f2705fbd680..af43bcb54578 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -10,7 +10,7 @@ int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm)
 	if (!pm->enable)
 		return 0;
 
-	if (!mt76_is_mmio(dev))
+	if (mt76_is_usb(dev))
 		return 0;
 
 	cancel_delayed_work_sync(&pm->ps_work);
@@ -37,7 +37,7 @@ void mt76_connac_power_save_sched(struct mt76_phy *phy,
 {
 	struct mt76_dev *dev = phy->dev;
 
-	if (!mt76_is_mmio(dev))
+	if (mt76_is_usb(dev))
 		return;
 
 	if (!pm->enable)
-- 
2.31.1

