Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87D93636AD
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhDRQgv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:36:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37120 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232095AbhDRQgv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:36:51 -0400
X-UUID: b915b1992cde4183b3e1503af19fd0c4-20210419
X-UUID: b915b1992cde4183b3e1503af19fd0c4-20210419
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 784178280; Mon, 19 Apr 2021 00:36:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Apr 2021 00:36:09 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Apr 2021 00:36:09 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Leon Yen <leon.yen@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH 4/6] mt76: mt7921: introduce mt7921_wpdma_reinit_cond utility routine
Date:   Mon, 19 Apr 2021 00:36:05 +0800
Message-ID: <1618763767-1292-5-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1618763767-1292-1-git-send-email-sean.wang@mediatek.com>
References: <1618763767-1292-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 01C456E25688B0D85D405DE075C71174F0D2B1E6ACDEB96D220DE24DE2B40C082000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add mt7921_wpdma_reinit_cond to check dummy reg if driver needs to
reinitialized WPDMA after driver_own operation

Co-developed-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  4 +++
 .../wireless/mediatek/mt76/mt7921/debugfs.c   | 13 ++++++++++
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 25 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  6 +++++
 4 files changed, 48 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index b811f3c410a1..3b5bff80a462 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -58,6 +58,10 @@ struct mt76_connac_pm {
 	struct delayed_work ps_work;
 	unsigned long last_activity;
 	unsigned long idle_timeout;
+
+	struct {
+		unsigned int lp_wake;
+	} stats;
 };
 
 struct mt76_connac_coredump {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 5a54cd8d2ce4..bd2aca654767 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -256,6 +256,17 @@ mt7921_pm_get(void *data, u64 *val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_pm, mt7921_pm_get, mt7921_pm_set, "%lld\n");
 
+static int
+mt7921_pm_stats(struct seq_file *s, void *data)
+{
+	struct mt7921_dev *dev = dev_get_drvdata(s->private);
+	struct mt76_connac_pm *pm = &dev->pm;
+
+	seq_printf(s, "low power wakes: %9d\n", pm->stats.lp_wake);
+
+	return 0;
+}
+
 static int
 mt7921_pm_idle_timeout_set(void *data, u64 val)
 {
@@ -322,6 +333,8 @@ int mt7921_init_debugfs(struct mt7921_dev *dev)
 	debugfs_create_file("idle-timeout", 0600, dir, dev,
 			    &fops_pm_idle_timeout);
 	debugfs_create_file("chip_reset", 0600, dir, dev, &fops_reset);
+	debugfs_create_devm_seqfile(dev->mt76.dev, "runtime_pm_stats", dir,
+				    mt7921_pm_stats);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 8c556ff3ae93..72f5704f8f11 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -329,6 +329,31 @@ int mt7921_wpdma_reset(struct mt7921_dev *dev, bool force)
 	return 0;
 }
 
+int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev)
+{
+	struct mt76_connac_pm *pm = &dev->pm;
+	int err;
+
+	/* check if the wpdma must be reinitialized */
+	if (mt7921_dma_need_reinit(dev)) {
+		/* disable interrutpts */
+		mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
+
+		err = mt7921_wpdma_reset(dev, false);
+		if (err) {
+			dev_err(dev->mt76.dev, "wpdma reset failed\n");
+			return err;
+		}
+
+		/* enable interrutpts */
+		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+		pm->stats.lp_wake++;
+	}
+
+	return 0;
+}
+
 int mt7921_dma_init(struct mt7921_dev *dev)
 {
 	/* Increase buffer size to receive large VHT/HE MPDUs */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 06a85d2d1c6f..bb4961d3969a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -254,6 +254,7 @@ int mt7921_eeprom_get_target_power(struct mt7921_dev *dev,
 void mt7921_eeprom_init_sku(struct mt7921_dev *dev);
 int mt7921_dma_init(struct mt7921_dev *dev);
 int mt7921_wpdma_reset(struct mt7921_dev *dev, bool force);
+int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev);
 void mt7921_dma_cleanup(struct mt7921_dev *dev);
 int mt7921_run_firmware(struct mt7921_dev *dev);
 int mt7921_mcu_init(struct mt7921_dev *dev);
@@ -317,6 +318,11 @@ mt7921_l1_rmw(struct mt7921_dev *dev, u32 addr, u32 mask, u32 val)
 #define mt7921_l1_set(dev, addr, val)	mt7921_l1_rmw(dev, addr, 0, val)
 #define mt7921_l1_clear(dev, addr, val)	mt7921_l1_rmw(dev, addr, val, 0)
 
+static inline bool mt7921_dma_need_reinit(struct mt7921_dev *dev)
+{
+	return !mt76_get_field(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
+}
+
 void mt7921_mac_init(struct mt7921_dev *dev);
 bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask);
 void mt7921_mac_reset_counters(struct mt7921_phy *phy);
-- 
2.25.1

