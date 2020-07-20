Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818C4226400
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jul 2020 17:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgGTPl3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jul 2020 11:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729861AbgGTPl2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jul 2020 11:41:28 -0400
Received: from lore-desk.redhat.com (unknown [151.48.143.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2189D22D08;
        Mon, 20 Jul 2020 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259688;
        bh=MNkicltIGSl5rlafMUXueFNJK3EWuou1mxMXHJz3GOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfcWiJh4v8WTWXu12M97saqhznV5Hf26/hzb96Vslz7OY6VctzR32GMpt78utd7Mh
         sYmu9+x/NuS2xeinAIK8qj3by8j4P1fg3EJE+XABir+YLGDOHCmFPNjDGbEl8ypo7E
         UISMSmnIIGy79Fi8cFDLZ3aW472IySMLlhI4dq6Q=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: mt7615: move drv_own/fw_own in mt7615_mcu_ops
Date:   Mon, 20 Jul 2020 17:41:19 +0200
Message-Id: <85e6edc12cd2acea970f6000b2845e2c0d0b291e.1595259089.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1595259089.git.lorenzo@kernel.org>
References: <cover.1595259089.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce set_drv_ctrl and set_fw_ctrl function pointers in
mt7615_mcu_ops data structure. This is a preliminary patch to enable
runtime-pm for non-pci chipsets

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |   4 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 158 +++++++++---------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   6 +-
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |   4 +-
 4 files changed, 89 insertions(+), 83 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 3dd8dd28690e..5d2261d2e79e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1845,7 +1845,7 @@ void mt7615_pm_wake_work(struct work_struct *work)
 						pm.wake_work);
 	mphy = dev->phy.mt76;
 
-	if (mt7615_driver_own(dev)) {
+	if (mt7615_mcu_set_drv_ctrl(dev)) {
 		dev_err(mphy->dev->dev, "failed to wake device\n");
 		goto out;
 	}
@@ -1943,7 +1943,7 @@ void mt7615_pm_power_save_work(struct work_struct *work)
 		goto out;
 	}
 
-	if (!mt7615_firmware_own(dev))
+	if (!mt7615_mcu_set_fw_ctrl(dev))
 		return;
 out:
 	queue_delayed_work(dev->mt76.wq, &dev->pm.ps_work, delta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 554f8fa4f0b7..179412355ae5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -324,6 +324,79 @@ int mt7615_rf_wr(struct mt7615_dev *dev, u32 wf, u32 reg, u32 val)
 				   sizeof(req), false);
 }
 
+static void mt7622_trigger_hif_int(struct mt7615_dev *dev, bool en)
+{
+	if (!is_mt7622(&dev->mt76))
+		return;
+
+	regmap_update_bits(dev->infracfg, MT_INFRACFG_MISC,
+			   MT_INFRACFG_MISC_AP2CONN_WAKE,
+			   !en * MT_INFRACFG_MISC_AP2CONN_WAKE);
+}
+
+static int mt7615_mcu_drv_pmctrl(struct mt7615_dev *dev)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_dev *mdev = &dev->mt76;
+	int i;
+
+	if (!test_and_clear_bit(MT76_STATE_PM, &mphy->state))
+		goto out;
+
+	mt7622_trigger_hif_int(dev, true);
+
+	for (i = 0; i < MT7615_DRV_OWN_RETRY_COUNT; i++) {
+		u32 addr;
+
+		addr = is_mt7663(mdev) ? MT_PCIE_DOORBELL_PUSH : MT_CFG_LPCR_HOST;
+		mt76_wr(dev, addr, MT_CFG_LPCR_HOST_DRV_OWN);
+
+		addr = is_mt7663(mdev) ? MT_CONN_HIF_ON_LPCTL : MT_CFG_LPCR_HOST;
+		if (mt76_poll_msec(dev, addr, MT_CFG_LPCR_HOST_FW_OWN, 0, 50))
+			break;
+	}
+
+	mt7622_trigger_hif_int(dev, false);
+
+	if (i == MT7615_DRV_OWN_RETRY_COUNT) {
+		dev_err(mdev->dev, "driver own failed\n");
+		set_bit(MT76_STATE_PM, &mphy->state);
+		return -EIO;
+	}
+
+out:
+	dev->pm.last_activity = jiffies;
+
+	return 0;
+}
+
+static int mt7615_mcu_fw_pmctrl(struct mt7615_dev *dev)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	int err = 0;
+	u32 addr;
+
+	if (test_and_set_bit(MT76_STATE_PM, &mphy->state))
+		return 0;
+
+	mt7622_trigger_hif_int(dev, true);
+
+	addr = is_mt7663(&dev->mt76) ? MT_CONN_HIF_ON_LPCTL : MT_CFG_LPCR_HOST;
+	mt76_wr(dev, addr, MT_CFG_LPCR_HOST_FW_OWN);
+
+	if (is_mt7622(&dev->mt76) &&
+	    !mt76_poll_msec(dev, addr, MT_CFG_LPCR_HOST_FW_OWN,
+			    MT_CFG_LPCR_HOST_FW_OWN, 300)) {
+		dev_err(dev->mt76.dev, "Timeout for firmware own\n");
+		clear_bit(MT76_STATE_PM, &mphy->state);
+		err = -EIO;
+	}
+
+	mt7622_trigger_hif_int(dev, false);
+
+	return err;
+}
+
 static void
 mt7615_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
@@ -1310,6 +1383,8 @@ static const struct mt7615_mcu_ops wtbl_update_ops = {
 	.add_tx_ba = mt7615_mcu_wtbl_tx_ba,
 	.add_rx_ba = mt7615_mcu_wtbl_rx_ba,
 	.sta_add = mt7615_mcu_wtbl_sta_add,
+	.set_drv_ctrl = mt7615_mcu_drv_pmctrl,
+	.set_fw_ctrl = mt7615_mcu_fw_pmctrl,
 };
 
 static int
@@ -1406,6 +1481,8 @@ static const struct mt7615_mcu_ops sta_update_ops = {
 	.add_tx_ba = mt7615_mcu_sta_tx_ba,
 	.add_rx_ba = mt7615_mcu_sta_rx_ba,
 	.sta_add = mt7615_mcu_add_sta,
+	.set_drv_ctrl = mt7615_mcu_drv_pmctrl,
+	.set_fw_ctrl = mt7615_mcu_fw_pmctrl,
 };
 
 static int
@@ -1819,6 +1896,8 @@ static const struct mt7615_mcu_ops uni_update_ops = {
 	.add_tx_ba = mt7615_mcu_uni_tx_ba,
 	.add_rx_ba = mt7615_mcu_uni_rx_ba,
 	.sta_add = mt7615_mcu_uni_add_sta,
+	.set_drv_ctrl = mt7615_mcu_drv_pmctrl,
+	.set_fw_ctrl = mt7615_mcu_fw_pmctrl,
 };
 
 static int mt7615_mcu_send_firmware(struct mt7615_dev *dev, const void *data,
@@ -1891,81 +1970,6 @@ static int mt7615_mcu_start_patch(struct mt7615_dev *dev)
 				   &req, sizeof(req), true);
 }
 
-static void mt7622_trigger_hif_int(struct mt7615_dev *dev, bool en)
-{
-	if (!is_mt7622(&dev->mt76))
-		return;
-
-	regmap_update_bits(dev->infracfg, MT_INFRACFG_MISC,
-			   MT_INFRACFG_MISC_AP2CONN_WAKE,
-			   !en * MT_INFRACFG_MISC_AP2CONN_WAKE);
-}
-
-int mt7615_driver_own(struct mt7615_dev *dev)
-{
-	struct mt76_phy *mphy = &dev->mt76.phy;
-	struct mt76_dev *mdev = &dev->mt76;
-	int i;
-
-	if (!test_and_clear_bit(MT76_STATE_PM, &mphy->state))
-		goto out;
-
-	mt7622_trigger_hif_int(dev, true);
-
-	for (i = 0; i < MT7615_DRV_OWN_RETRY_COUNT; i++) {
-		u32 addr;
-
-		addr = is_mt7663(mdev) ? MT_PCIE_DOORBELL_PUSH : MT_CFG_LPCR_HOST;
-		mt76_wr(dev, addr, MT_CFG_LPCR_HOST_DRV_OWN);
-
-		addr = is_mt7663(mdev) ? MT_CONN_HIF_ON_LPCTL : MT_CFG_LPCR_HOST;
-		if (mt76_poll_msec(dev, addr, MT_CFG_LPCR_HOST_FW_OWN, 0, 50))
-			break;
-	}
-
-	mt7622_trigger_hif_int(dev, false);
-
-	if (i == MT7615_DRV_OWN_RETRY_COUNT) {
-		dev_err(mdev->dev, "driver own failed\n");
-		set_bit(MT76_STATE_PM, &mphy->state);
-		return -EIO;
-	}
-
-out:
-	dev->pm.last_activity = jiffies;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mt7615_driver_own);
-
-int mt7615_firmware_own(struct mt7615_dev *dev)
-{
-	struct mt76_phy *mphy = &dev->mt76.phy;
-	int err = 0;
-	u32 addr;
-
-	if (test_and_set_bit(MT76_STATE_PM, &mphy->state))
-		return 0;
-
-	mt7622_trigger_hif_int(dev, true);
-
-	addr = is_mt7663(&dev->mt76) ? MT_CONN_HIF_ON_LPCTL : MT_CFG_LPCR_HOST;
-	mt76_wr(dev, addr, MT_CFG_LPCR_HOST_FW_OWN);
-
-	if (is_mt7622(&dev->mt76) &&
-	    !mt76_poll_msec(dev, addr, MT_CFG_LPCR_HOST_FW_OWN,
-			    MT_CFG_LPCR_HOST_FW_OWN, 300)) {
-		dev_err(dev->mt76.dev, "Timeout for firmware own\n");
-		clear_bit(MT76_STATE_PM, &mphy->state);
-		err = -EIO;
-	}
-
-	mt7622_trigger_hif_int(dev, false);
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(mt7615_firmware_own);
-
 static int mt7615_load_patch(struct mt7615_dev *dev, u32 addr, const char *name)
 {
 	const struct mt7615_patch_hdr *hdr;
@@ -2447,7 +2451,7 @@ int mt7615_mcu_init(struct mt7615_dev *dev)
 
 	dev->mt76.mcu_ops = &mt7615_mcu_ops,
 
-	ret = mt7615_driver_own(dev);
+	ret = mt7615_mcu_drv_pmctrl(dev);
 	if (ret)
 		return ret;
 
@@ -2477,7 +2481,7 @@ EXPORT_SYMBOL_GPL(mt7615_mcu_init);
 void mt7615_mcu_exit(struct mt7615_dev *dev)
 {
 	__mt76_mcu_restart(&dev->mt76);
-	mt7615_firmware_own(dev);
+	mt7615_mcu_set_fw_ctrl(dev);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_exit);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 2964d0dc9736..8f008e056e39 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -220,6 +220,8 @@ struct mt7615_phy {
 #define mt7615_mcu_add_bss_info(phy, ...) (phy->dev)->mcu_ops->add_bss_info((phy),  __VA_ARGS__)
 #define mt7615_mcu_add_beacon(dev, ...)	(dev)->mcu_ops->add_beacon_offload((dev),  __VA_ARGS__)
 #define mt7615_mcu_set_pm(dev, ...)	(dev)->mcu_ops->set_pm_state((dev),  __VA_ARGS__)
+#define mt7615_mcu_set_drv_ctrl(dev)	(dev)->mcu_ops->set_drv_ctrl((dev))
+#define mt7615_mcu_set_fw_ctrl(dev)	(dev)->mcu_ops->set_fw_ctrl((dev))
 struct mt7615_mcu_ops {
 	int (*add_tx_ba)(struct mt7615_dev *dev,
 			 struct ieee80211_ampdu_params *params,
@@ -238,6 +240,8 @@ struct mt7615_mcu_ops {
 				  struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif, bool enable);
 	int (*set_pm_state)(struct mt7615_dev *dev, int band, int state);
+	int (*set_drv_ctrl)(struct mt7615_dev *dev);
+	int (*set_fw_ctrl)(struct mt7615_dev *dev);
 };
 
 struct mt7615_dev {
@@ -638,8 +642,6 @@ int mt7615_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif);
 int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_channel *chan, int duration);
-int mt7615_firmware_own(struct mt7615_dev *dev);
-int mt7615_driver_own(struct mt7615_dev *dev);
 
 int mt7615_init_debugfs(struct mt7615_dev *dev);
 int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 2328d78e06a1..b9794f8a8df4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -118,7 +118,7 @@ static int mt7615_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	if (err)
 		goto restore;
 
-	err = mt7615_firmware_own(dev);
+	err = mt7615_mcu_set_fw_ctrl(dev);
 	if (err)
 		goto restore;
 
@@ -142,7 +142,7 @@ static int mt7615_pci_resume(struct pci_dev *pdev)
 	bool pdma_reset;
 	int i, err;
 
-	err = mt7615_driver_own(dev);
+	err = mt7615_mcu_set_drv_ctrl(dev);
 	if (err < 0)
 		return err;
 
-- 
2.26.2

