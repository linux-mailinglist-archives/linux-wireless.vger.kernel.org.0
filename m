Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42665379A17
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 00:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhEJWaw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 18:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231193AbhEJWav (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 18:30:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CE2B615FF;
        Mon, 10 May 2021 22:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620685786;
        bh=l59rbff3HU5lg49fk40Vg6jVpFZOnN6XZwXaWnhQqvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NywHb5LPpDbaTBiYZaukFZM9dhb7ZCXVL0jrQ/6Qmg0m2jjBIKw8EuYtKacXwZ2Bm
         Bv1ybG8Nn3XkHrmHyqOVpKZ2TBWDlO2hG/nfLOXy3EkwqPFS5mU6dKtgbbVEY+I0us
         7DftUz6GycoAEw+UbZe6kJ27iaT1T9CsMoRRYh6nwFgn4zpPUlyostRaQesJGgQflq
         PseTdXHotpk6nfhwnYdhsv3KbOXzvO+7rTrHFMXdO9TJpQYY40pbSygREGosXjO9QV
         h2oCYWD/l0ew2utZyQZkCyG/+FkIkjfA6w/nYUa9Y9ZA7DlXEUK9W/F4RN7ru3pENV
         5ONbHZk2zRNJQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 4/5] mt76: mt7663s: enable runtime-pm
Date:   Tue, 11 May 2021 00:29:23 +0200
Message-Id: <953f164989390c11a541b46b454765f6dc52c26c.1620685619.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620685619.git.lorenzo@kernel.org>
References: <cover.1620685619.git.lorenzo@kernel.org>
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
index 676bb22726d6..eb33d2baee06 100644
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
index 6f180c92d413..7880b41b16d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -10,7 +10,7 @@ int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm)
 	if (!pm->enable)
 		return 0;
 
-	if (!mt76_is_mmio(dev))
+	if (mt76_is_usb(dev))
 		return 0;
 
 	cancel_delayed_work_sync(&pm->ps_work);
@@ -34,7 +34,7 @@ void mt76_connac_power_save_sched(struct mt76_phy *phy,
 {
 	struct mt76_dev *dev = phy->dev;
 
-	if (!mt76_is_mmio(dev))
+	if (mt76_is_usb(dev))
 		return;
 
 	if (!pm->enable)
-- 
2.31.1

