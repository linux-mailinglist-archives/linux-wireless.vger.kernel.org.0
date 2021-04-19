Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83C73645E6
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 16:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbhDSOVl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Apr 2021 10:21:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49028 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238604AbhDSOVh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Apr 2021 10:21:37 -0400
X-UUID: 3970f636acf443b3867fcd2d47c393e6-20210419
X-UUID: 3970f636acf443b3867fcd2d47c393e6-20210419
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 894135357; Mon, 19 Apr 2021 22:21:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Apr 2021 22:21:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Apr 2021 22:21:00 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Leon Yen <leon.yen@mediatek.com>
Subject: [PATCH v2 4/6] mt76: mt7921: introduce mt7921_wpdma_reinit_cond utility routine
Date:   Mon, 19 Apr 2021 22:20:57 +0800
Message-ID: <1618842059-8192-5-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1618842059-8192-1-git-send-email-sean.wang@mediatek.com>
References: <1618842059-8192-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FAD8A403A11F7897794284DAA6677DC5ECB4C422DCC3A0B248AEECEBD0CF588A2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Add mt7921_wpdma_reinit_cond to check dummy reg if driver needs to
reinitialized WPDMA after driver_own operation

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  2 ++
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  3 +++
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 25 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  6 +++++
 4 files changed, 36 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 9e61c107c640..6c889b90fd12 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -64,11 +64,13 @@ struct mt76_connac_pm {
 	struct delayed_work ps_work;
 	unsigned long last_activity;
 	unsigned long idle_timeout;
+
 	struct {
 		unsigned long last_wake_event;
 		unsigned long awake_time;
 		unsigned long last_doze_event;
 		unsigned long doze_time;
+		unsigned int lp_wake;
 	} stats;
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index f3982578cc56..6ee423dd4027 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -269,6 +269,7 @@ mt7921_pm_stats(struct seq_file *s, void *data)
 {
 	struct mt7921_dev *dev = dev_get_drvdata(s->private);
 	struct mt76_connac_pm *pm = &dev->pm;
+
 	unsigned long awake_time = pm->stats.awake_time;
 	unsigned long doze_time = pm->stats.doze_time;
 
@@ -281,6 +282,8 @@ mt7921_pm_stats(struct seq_file *s, void *data)
 		   jiffies_to_msecs(awake_time),
 		   jiffies_to_msecs(doze_time));
 
+	seq_printf(s, "low power wakes: %9d\n", pm->stats.lp_wake);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index fb7f98d92377..71e664ee7652 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -353,6 +353,31 @@ int mt7921_wpdma_reset(struct mt7921_dev *dev, bool force)
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
index 67cb0a647066..efc3ba791342 100644
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

