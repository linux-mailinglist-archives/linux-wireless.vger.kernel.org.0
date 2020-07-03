Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A0A213627
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGCIQ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:16:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbgGCIQ5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:57 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 647AC206A1;
        Fri,  3 Jul 2020 08:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764216;
        bh=pL/RJwV34kLhA82mkIjmWG0XdyPXBhhdwvUgPc2fKPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lrm0ZRNBNJPwkB83puOQx04Z+ftbN6fXmO5/smLBvTXkbr/gWPbmL56oaFwCeRVBL
         g6h9o+4ZymMT2Y2KlnSuNpHdVYnpTbiUh7urW8rKrDH/C9v32p7kaZsX+G4A3vebtJ
         IBaEwcmNicWzSQEEZkGHL3gSaYvH4p5YsylOKFtM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 20/22] mt76: mt7615: enable beacon hw filter for runtime-pm
Date:   Fri,  3 Jul 2020 10:15:59 +0200
Message-Id: <69f1c9c97890f3cd8cbd21e5df1a79df1ab8ba07.1593763584.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593763584.git.lorenzo@kernel.org>
References: <cover.1593763584.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to reduce number of received interrupts and power consumption,
enable hw beacon filter if runtime-pm is enabled

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 26 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 19 ++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  5 ++--
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 ++
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index d7c2c08da3c7..bdd9b66ca47d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1929,8 +1929,31 @@ void mt7615_pm_power_save_work(struct work_struct *work)
 				   MT7615_PM_TIMEOUT);
 }
 
+static void
+mt7615_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt7615_phy *phy = priv;
+	struct mt7615_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+
+	if (mt7615_mcu_set_bss_pm(dev, vif, dev->pm.enable))
+		return;
+
+	if (dev->pm.enable) {
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+		mt76_set(dev, MT_WF_RFCR(ext_phy),
+			 MT_WF_RFCR_DROP_OTHER_BEACON);
+	} else {
+		vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
+		mt76_clear(dev, MT_WF_RFCR(ext_phy),
+			   MT_WF_RFCR_DROP_OTHER_BEACON);
+	}
+}
+
 int mt7615_pm_set_enable(struct mt7615_dev *dev, bool enable)
 {
+	struct mt76_phy *mphy = dev->phy.mt76;
+
 	if (!mt7615_firmware_offload(dev) || !mt76_is_mmio(&dev->mt76))
 		return -EOPNOTSUPP;
 
@@ -1940,6 +1963,9 @@ int mt7615_pm_set_enable(struct mt7615_dev *dev, bool enable)
 		goto out;
 
 	dev->pm.enable = enable;
+	ieee80211_iterate_active_interfaces(mphy->hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7615_pm_interface_iter, mphy->priv);
 out:
 	mt7615_mutex_release(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 0ce76472df2c..b1cfae7c4b55 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -209,6 +209,18 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	}
 
 	ret = mt7615_mcu_add_dev_info(dev, vif, true);
+	if (ret)
+		goto out;
+
+	if (dev->pm.enable) {
+		ret = mt7615_mcu_set_bss_pm(dev, vif, true);
+		if (ret)
+			goto out;
+
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+		mt76_set(dev, MT_WF_RFCR(ext_phy),
+			 MT_WF_RFCR_DROP_OTHER_BEACON);
+	}
 out:
 	mt7615_mutex_release(dev);
 
@@ -234,6 +246,13 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 
 	mt7615_free_pending_tx_skbs(dev, msta);
 
+	if (dev->pm.enable) {
+		bool ext_phy = phy != &dev->phy;
+
+		mt7615_mcu_set_bss_pm(dev, vif, false);
+		mt76_clear(dev, MT_WF_RFCR(ext_phy),
+			   MT_WF_RFCR_DROP_OTHER_BEACON);
+	}
 	mt7615_mcu_add_dev_info(dev, vif, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 195710a5da2a..4b576cc3c5c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -3581,9 +3581,8 @@ int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend)
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_set_hif_suspend);
 
-static int
-mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-		      bool enable)
+int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+			  bool enable)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index b80bf79e4849..46a2a38d0b1f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -640,6 +640,8 @@ int mt7615_driver_own(struct mt7615_dev *dev);
 int mt7615_init_debugfs(struct mt7615_dev *dev);
 int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
 
+int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+			  bool enable);
 int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend);
 void mt7615_mcu_set_suspend_iter(void *priv, u8 *mac,
 				 struct ieee80211_vif *vif);
-- 
2.26.2

