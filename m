Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B083F381914
	for <lists+linux-wireless@lfdr.de>; Sat, 15 May 2021 15:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhEON1i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 May 2021 09:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhEON1h (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 May 2021 09:27:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EBB9613C1;
        Sat, 15 May 2021 13:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621085184;
        bh=dI6waNOadGf/d6YLh2UWTDNiypfhv0PQEkvJqsQwvWU=;
        h=From:To:Cc:Subject:Date:From;
        b=NVs9gBB9w2DJxqAWyJvEearNwikn+pdhaTFQdF/RcbPtsqnQeqA32aWbyVDfiE8EM
         DwK7mJq6uJeQrGTr6kOJmfU+qV7fAsFae8eYWyO0sPnTUafFrSGFr4+0s/xi/LJni/
         QHQNQ8HUFUzFc3qkW0V2ZfBNUz25kqx/nw3KhndxBcfVuBpneKhY3tNIOMovRSBg6k
         tNA3Yj2RLu2grTiDUrY4alMhpodbBmlNUAn0/j0Fk07/d8xwt3xRZuTtdVFEBIOSjP
         MmMWtd7gjffyRUY9Z/IMvJMeIdGMWDXvciwyc1faSL+NRZzOXC2cvZqPR/fbYXCyAl
         8LhiXzTM8dSfA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
Subject: [PATCH v2 5.13] mt76: mt7615: do not set MT76_STATE_PM at bootstrap
Date:   Sat, 15 May 2021 15:26:12 +0200
Message-Id: <e5a2618574007113d844874420f7855891abf167.1621085028.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove MT76_STATE_PM in mt7615_init_device() and introduce
__mt7663s_mcu_drv_pmctrl for fw loading in mt7663s.
This patch fixes a crash at bootstrap for device (e.g. mt7622) that do
not support runtime-pm

Fixes: 7f2bc8ba11a0 ("mt76: connac: introduce wake counter for fw_pmctrl synchronization")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- use proper Fixes commit hash
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  1 -
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  | 19 ++++++++++++-------
 .../wireless/mediatek/mt76/mt7615/usb_mcu.c   |  3 ---
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 86341d1f82f3..d20f05a7717d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -510,7 +510,6 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	mutex_init(&dev->pm.mutex);
 	init_waitqueue_head(&dev->pm.wait);
 	spin_lock_init(&dev->pm.txq_lock);
-	set_bit(MT76_STATE_PM, &dev->mphy.state);
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7615_mac_work);
 	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7615_scan_work);
 	INIT_DELAYED_WORK(&dev->coredump.work, mt7615_coredump_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index 17fe4187d1de..d1be78b0711c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -51,16 +51,13 @@ mt7663s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	return ret;
 }
 
-static int mt7663s_mcu_drv_pmctrl(struct mt7615_dev *dev)
+static int __mt7663s_mcu_drv_pmctrl(struct mt7615_dev *dev)
 {
 	struct sdio_func *func = dev->mt76.sdio.func;
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	u32 status;
 	int ret;
 
-	if (!test_and_clear_bit(MT76_STATE_PM, &mphy->state))
-		goto out;
-
 	sdio_claim_host(func);
 
 	sdio_writel(func, WHLPCR_FW_OWN_REQ_CLR, MCR_WHLPCR, NULL);
@@ -76,13 +73,21 @@ static int mt7663s_mcu_drv_pmctrl(struct mt7615_dev *dev)
 	}
 
 	sdio_release_host(func);
-
-out:
 	dev->pm.last_activity = jiffies;
 
 	return 0;
 }
 
+static int mt7663s_mcu_drv_pmctrl(struct mt7615_dev *dev)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+
+	if (test_and_clear_bit(MT76_STATE_PM, &mphy->state))
+		return __mt7663s_mcu_drv_pmctrl(dev);
+
+	return 0;
+}
+
 static int mt7663s_mcu_fw_pmctrl(struct mt7615_dev *dev)
 {
 	struct sdio_func *func = dev->mt76.sdio.func;
@@ -123,7 +128,7 @@ int mt7663s_mcu_init(struct mt7615_dev *dev)
 	struct mt7615_mcu_ops *mcu_ops;
 	int ret;
 
-	ret = mt7663s_mcu_drv_pmctrl(dev);
+	ret = __mt7663s_mcu_drv_pmctrl(dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
index c55698f9c49a..028ff432d811 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
@@ -55,10 +55,7 @@ int mt7663u_mcu_init(struct mt7615_dev *dev)
 
 	dev->mt76.mcu_ops = &mt7663u_mcu_ops,
 
-	/* usb does not support runtime-pm */
-	clear_bit(MT76_STATE_PM, &dev->mphy.state);
 	mt76_set(dev, MT_UDMA_TX_QSEL, MT_FW_DL_EN);
-
 	if (test_and_clear_bit(MT76_STATE_POWER_OFF, &dev->mphy.state)) {
 		mt7615_mcu_restart(&dev->mt76);
 		if (!mt76_poll_msec(dev, MT_CONN_ON_MISC,
-- 
2.31.1

