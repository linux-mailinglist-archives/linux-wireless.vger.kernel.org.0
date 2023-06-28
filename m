Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DC17409D7
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjF1Hwa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:52:30 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:38834 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230121AbjF1Hw0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:26 -0400
X-UUID: 693a5070158211ee9cb5633481061a41-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ABuHCxsICVcwv14Sm24hYvi2X5JaVph65dNzimN890E=;
        b=OSYj8m2TSiLX0yui/P6nDJnuvD4oluQXtmNzOSrtM5TDBJ5F5q6Zq0ydmZ6gzRsTZh3iOD75Ru60W/ZsmrIaDWxIk38xLbjV5DLARkDjBou/7j4x99jFLuIIhgzEZa69z9rNY2x0psl9xD2J+e9WrVipqc9tpQPNSm8CvfcCX5c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:c6d3f4f3-bdaf-4a4b-bef4-2a3d66ca450f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.27,REQID:c6d3f4f3-bdaf-4a4b-bef4-2a3d66ca450f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:01c9525,CLOUDID:4cd05eda-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:230628150716R3EPWWF3,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:1
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 2,OSH
X-CID-BAS: 2,OSH,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: 693a5070158211ee9cb5633481061a41-20230628
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1981287689; Wed, 28 Jun 2023 15:07:15 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:07:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:07:14 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 06/16] wifi: mt76: mt7921: rename mt7921_dev in mt792x_dev
Date:   Wed, 28 Jun 2023 15:05:52 +0800
Message-ID: <95a27f1b833d2cc132511a29ceab7ab4af6eb0f3.1687919628.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687919628.git.deren.wu@mediatek.com>
References: <cover.1687919628.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

This is a preliminary patch to introduce WiFi7 chipset support

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/acpi_sar.c  |  12 +-
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  38 ++---
 .../net/wireless/mediatek/mt76/mt7921/dma.c   |  26 ++--
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  20 +--
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  58 ++++----
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  88 ++++++------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  74 +++++-----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 132 +++++++++---------
 .../mediatek/mt76/mt7921/mt7921_trace.h       |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  26 ++--
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |   4 +-
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c   |  12 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  14 +-
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c  |   6 +-
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  |  12 +-
 .../wireless/mediatek/mt76/mt7921/testmode.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  20 +--
 .../wireless/mediatek/mt76/mt7921/usb_mac.c   |  16 +--
 18 files changed, 282 insertions(+), 282 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c b/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
index 06f2acdbfe1c..057767ab45ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
@@ -5,7 +5,7 @@
 #include "mt7921.h"
 
 static int
-mt7921_acpi_read(struct mt7921_dev *dev, u8 *method, u8 **tbl, u32 *len)
+mt7921_acpi_read(struct mt792x_dev *dev, u8 *method, u8 **tbl, u32 *len)
 {
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *sar_root, *sar_unit;
@@ -65,7 +65,7 @@ mt7921_acpi_read(struct mt7921_dev *dev, u8 *method, u8 **tbl, u32 *len)
 
 /* MTCL : Country List Table for 6G band */
 static int
-mt7921_asar_acpi_read_mtcl(struct mt7921_dev *dev, u8 **table, u8 *version)
+mt7921_asar_acpi_read_mtcl(struct mt792x_dev *dev, u8 **table, u8 *version)
 {
 	*version = (mt7921_acpi_read(dev, MT7921_ACPI_MTCL, table, NULL) < 0)
 		   ? 1 : 2;
@@ -74,7 +74,7 @@ mt7921_asar_acpi_read_mtcl(struct mt7921_dev *dev, u8 **table, u8 *version)
 
 /* MTDS : Dynamic SAR Power Table */
 static int
-mt7921_asar_acpi_read_mtds(struct mt7921_dev *dev, u8 **table, u8 version)
+mt7921_asar_acpi_read_mtds(struct mt792x_dev *dev, u8 **table, u8 version)
 {
 	int len, ret, sarlen, prelen, tblcnt;
 	bool enable;
@@ -109,7 +109,7 @@ mt7921_asar_acpi_read_mtds(struct mt7921_dev *dev, u8 **table, u8 version)
 
 /* MTGS : Geo SAR Power Table */
 static int
-mt7921_asar_acpi_read_mtgs(struct mt7921_dev *dev, u8 **table, u8 version)
+mt7921_asar_acpi_read_mtgs(struct mt792x_dev *dev, u8 **table, u8 version)
 {
 	int len, ret = 0, sarlen, prelen, tblcnt;
 
@@ -140,7 +140,7 @@ mt7921_asar_acpi_read_mtgs(struct mt7921_dev *dev, u8 **table, u8 version)
 
 /* MTFG : Flag Table */
 static int
-mt7921_asar_acpi_read_mtfg(struct mt7921_dev *dev, u8 **table)
+mt7921_asar_acpi_read_mtfg(struct mt792x_dev *dev, u8 **table)
 {
 	int len, ret;
 
@@ -154,7 +154,7 @@ mt7921_asar_acpi_read_mtfg(struct mt7921_dev *dev, u8 **table)
 	return ret;
 }
 
-int mt7921_init_acpi_sar(struct mt7921_dev *dev)
+int mt7921_init_acpi_sar(struct mt792x_dev *dev)
 {
 	struct mt7921_acpi_sar *asar;
 	int ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index baa640e8a982..6137a10c022a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -6,7 +6,7 @@
 static int
 mt7921_reg_set(void *data, u64 val)
 {
-	struct mt7921_dev *dev = data;
+	struct mt792x_dev *dev = data;
 
 	mt7921_mutex_acquire(dev);
 	mt76_wr(dev, dev->mt76.debugfs_reg, val);
@@ -18,7 +18,7 @@ mt7921_reg_set(void *data, u64 val)
 static int
 mt7921_reg_get(void *data, u64 *val)
 {
-	struct mt7921_dev *dev = data;
+	struct mt792x_dev *dev = data;
 
 	mt7921_mutex_acquire(dev);
 	*val = mt76_rr(dev, dev->mt76.debugfs_reg);
@@ -32,7 +32,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_regval, mt7921_reg_get, mt7921_reg_set,
 static int
 mt7921_fw_debug_set(void *data, u64 val)
 {
-	struct mt7921_dev *dev = data;
+	struct mt792x_dev *dev = data;
 
 	mt7921_mutex_acquire(dev);
 
@@ -47,7 +47,7 @@ mt7921_fw_debug_set(void *data, u64 val)
 static int
 mt7921_fw_debug_get(void *data, u64 *val)
 {
-	struct mt7921_dev *dev = data;
+	struct mt792x_dev *dev = data;
 
 	*val = dev->fw_debug;
 
@@ -61,7 +61,7 @@ static void
 mt7921_ampdu_stat_read_phy(struct mt792x_phy *phy,
 			   struct seq_file *file)
 {
-	struct mt7921_dev *dev = file->private;
+	struct mt792x_dev *dev = file->private;
 	int bound[15], range[4], i;
 
 	if (!phy)
@@ -93,7 +93,7 @@ mt7921_ampdu_stat_read_phy(struct mt792x_phy *phy,
 static int
 mt7921_tx_stats_show(struct seq_file *file, void *data)
 {
-	struct mt7921_dev *dev = file->private;
+	struct mt792x_dev *dev = file->private;
 	struct mt792x_phy *phy = &dev->phy;
 	struct mt76_mib_stats *mib = &phy->mib;
 	int i;
@@ -123,7 +123,7 @@ DEFINE_SHOW_ATTRIBUTE(mt7921_tx_stats);
 static int
 mt7921_queues_acq(struct seq_file *s, void *data)
 {
-	struct mt7921_dev *dev = dev_get_drvdata(s->private);
+	struct mt792x_dev *dev = dev_get_drvdata(s->private);
 	int i;
 
 	mt7921_mutex_acquire(dev);
@@ -154,7 +154,7 @@ mt7921_queues_acq(struct seq_file *s, void *data)
 static int
 mt7921_queues_read(struct seq_file *s, void *data)
 {
-	struct mt7921_dev *dev = dev_get_drvdata(s->private);
+	struct mt792x_dev *dev = dev_get_drvdata(s->private);
 	struct {
 		struct mt76_queue *q;
 		char *queue;
@@ -211,7 +211,7 @@ mt7921_seq_puts_array(struct seq_file *file, const char *str,
 static int
 mt7921_txpwr(struct seq_file *s, void *data)
 {
-	struct mt7921_dev *dev = dev_get_drvdata(s->private);
+	struct mt792x_dev *dev = dev_get_drvdata(s->private);
 	struct mt7921_txpwr txpwr;
 	int ret;
 
@@ -263,7 +263,7 @@ mt7921_txpwr(struct seq_file *s, void *data)
 static int
 mt7921_pm_set(void *data, u64 val)
 {
-	struct mt7921_dev *dev = data;
+	struct mt792x_dev *dev = data;
 	struct mt76_connac_pm *pm = &dev->pm;
 
 	if (mt76_is_usb(&dev->mt76))
@@ -296,7 +296,7 @@ mt7921_pm_set(void *data, u64 val)
 static int
 mt7921_pm_get(void *data, u64 *val)
 {
-	struct mt7921_dev *dev = data;
+	struct mt792x_dev *dev = data;
 
 	*val = dev->pm.enable_user;
 
@@ -308,7 +308,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_pm, mt7921_pm_get, mt7921_pm_set, "%lld\n");
 static int
 mt7921_deep_sleep_set(void *data, u64 val)
 {
-	struct mt7921_dev *dev = data;
+	struct mt792x_dev *dev = data;
 	struct mt76_connac_pm *pm = &dev->pm;
 	bool monitor = !!(dev->mphy.hw->conf.flags & IEEE80211_CONF_MONITOR);
 	bool enable = !!val;
@@ -332,7 +332,7 @@ mt7921_deep_sleep_set(void *data, u64 val)
 static int
 mt7921_deep_sleep_get(void *data, u64 *val)
 {
-	struct mt7921_dev *dev = data;
+	struct mt792x_dev *dev = data;
 
 	*val = dev->pm.ds_enable_user;
 
@@ -345,7 +345,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ds, mt7921_deep_sleep_get,
 static int
 mt7921_pm_stats(struct seq_file *s, void *data)
 {
-	struct mt7921_dev *dev = dev_get_drvdata(s->private);
+	struct mt792x_dev *dev = dev_get_drvdata(s->private);
 	struct mt76_connac_pm *pm = &dev->pm;
 
 	unsigned long awake_time = pm->stats.awake_time;
@@ -368,7 +368,7 @@ mt7921_pm_stats(struct seq_file *s, void *data)
 static int
 mt7921_pm_idle_timeout_set(void *data, u64 val)
 {
-	struct mt7921_dev *dev = data;
+	struct mt792x_dev *dev = data;
 
 	dev->pm.idle_timeout = msecs_to_jiffies(val);
 
@@ -378,7 +378,7 @@ mt7921_pm_idle_timeout_set(void *data, u64 val)
 static int
 mt7921_pm_idle_timeout_get(void *data, u64 *val)
 {
-	struct mt7921_dev *dev = data;
+	struct mt792x_dev *dev = data;
 
 	*val = jiffies_to_msecs(dev->pm.idle_timeout);
 
@@ -390,7 +390,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_pm_idle_timeout, mt7921_pm_idle_timeout_get,
 
 static int mt7921_chip_reset(void *data, u64 val)
 {
-	struct mt7921_dev *dev = data;
+	struct mt792x_dev *dev = data;
 	int ret = 0;
 
 	switch (val) {
@@ -414,7 +414,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_reset, NULL, mt7921_chip_reset, "%lld\n");
 static int
 mt7921s_sched_quota_read(struct seq_file *s, void *data)
 {
-	struct mt7921_dev *dev = dev_get_drvdata(s->private);
+	struct mt792x_dev *dev = dev_get_drvdata(s->private);
 	struct mt76_sdio *sdio = &dev->mt76.sdio;
 
 	seq_printf(s, "pse_data_quota\t%d\n", sdio->sched.pse_data_quota);
@@ -425,7 +425,7 @@ mt7921s_sched_quota_read(struct seq_file *s, void *data)
 	return 0;
 }
 
-int mt7921_init_debugfs(struct mt7921_dev *dev)
+int mt7921_init_debugfs(struct mt792x_dev *dev)
 {
 	struct dentry *dir;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 4153cd6c2a01..3c628962641b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -7,9 +7,9 @@
 
 static int mt7921_poll_tx(struct napi_struct *napi, int budget)
 {
-	struct mt7921_dev *dev;
+	struct mt792x_dev *dev;
 
-	dev = container_of(napi, struct mt7921_dev, mt76.tx_napi);
+	dev = container_of(napi, struct mt792x_dev, mt76.tx_napi);
 
 	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
 		napi_complete(napi);
@@ -27,10 +27,10 @@ static int mt7921_poll_tx(struct napi_struct *napi, int budget)
 
 static int mt7921_poll_rx(struct napi_struct *napi, int budget)
 {
-	struct mt7921_dev *dev;
+	struct mt792x_dev *dev;
 	int done;
 
-	dev = container_of(napi->dev, struct mt7921_dev, mt76.napi_dev);
+	dev = container_of(napi->dev, struct mt792x_dev, mt76.napi_dev);
 
 	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
 		napi_complete(napi);
@@ -43,7 +43,7 @@ static int mt7921_poll_rx(struct napi_struct *napi, int budget)
 	return done;
 }
 
-static void mt7921_dma_prefetch(struct mt7921_dev *dev)
+static void mt7921_dma_prefetch(struct mt792x_dev *dev)
 {
 #define PREFETCH(base, depth)	((base) << 16 | (depth))
 
@@ -64,7 +64,7 @@ static void mt7921_dma_prefetch(struct mt7921_dev *dev)
 	mt76_wr(dev, MT_WFDMA0_TX_RING17_EXT_CTRL, PREFETCH(0x380, 0x4));
 }
 
-static int mt7921_dma_disable(struct mt7921_dev *dev, bool force)
+static int mt7921_dma_disable(struct mt792x_dev *dev, bool force)
 {
 	/* disable WFDMA0 */
 	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
@@ -98,7 +98,7 @@ static int mt7921_dma_disable(struct mt7921_dev *dev, bool force)
 	return 0;
 }
 
-static int mt7921_dma_enable(struct mt7921_dev *dev)
+static int mt7921_dma_enable(struct mt792x_dev *dev)
 {
 	/* configure perfetch settings */
 	mt7921_dma_prefetch(dev);
@@ -131,7 +131,7 @@ static int mt7921_dma_enable(struct mt7921_dev *dev)
 	return 0;
 }
 
-static int mt7921_dma_reset(struct mt7921_dev *dev, bool force)
+static int mt7921_dma_reset(struct mt792x_dev *dev, bool force)
 {
 	int i, err;
 
@@ -154,7 +154,7 @@ static int mt7921_dma_reset(struct mt7921_dev *dev, bool force)
 	return mt7921_dma_enable(dev);
 }
 
-int mt7921_wfsys_reset(struct mt7921_dev *dev)
+int mt7921_wfsys_reset(struct mt792x_dev *dev)
 {
 	mt76_clear(dev, MT_WFSYS_SW_RST_B, WFSYS_SW_RST_B);
 	msleep(50);
@@ -167,7 +167,7 @@ int mt7921_wfsys_reset(struct mt7921_dev *dev)
 	return 0;
 }
 
-int mt7921_wpdma_reset(struct mt7921_dev *dev, bool force)
+int mt7921_wpdma_reset(struct mt792x_dev *dev, bool force)
 {
 	int i, err;
 
@@ -196,7 +196,7 @@ int mt7921_wpdma_reset(struct mt7921_dev *dev, bool force)
 	return 0;
 }
 
-int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev)
+int mt7921_wpdma_reinit_cond(struct mt792x_dev *dev)
 {
 	struct mt76_connac_pm *pm = &dev->pm;
 	int err;
@@ -221,7 +221,7 @@ int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev)
 	return 0;
 }
 
-int mt7921_dma_init(struct mt7921_dev *dev)
+int mt7921_dma_init(struct mt792x_dev *dev)
 {
 	int ret;
 
@@ -286,7 +286,7 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 	return mt7921_dma_enable(dev);
 }
 
-void mt7921_dma_cleanup(struct mt7921_dev *dev)
+void mt7921_dma_cleanup(struct mt792x_dev *dev)
 {
 	/* disable */
 	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index d383586eb429..bace86813b76 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -61,7 +61,7 @@ static ssize_t mt7921_thermal_temp_show(struct device *dev,
 	switch (to_sensor_dev_attr(attr)->index) {
 	case 0: {
 		struct mt792x_phy *phy = dev_get_drvdata(dev);
-		struct mt7921_dev *mdev = phy->dev;
+		struct mt792x_dev *mdev = phy->dev;
 		int temperature;
 
 		mt7921_mutex_acquire(mdev);
@@ -110,7 +110,7 @@ mt7921_regd_notifier(struct wiphy *wiphy,
 		     struct regulatory_request *request)
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
 	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
 	dev->mt76.region = request->dfs_region;
@@ -127,7 +127,7 @@ static int
 mt7921_init_wiphy(struct ieee80211_hw *hw)
 {
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
-	struct mt7921_dev *dev = phy->dev;
+	struct mt792x_dev *dev = phy->dev;
 	struct wiphy *wiphy = hw->wiphy;
 
 	hw->queues = 4;
@@ -200,7 +200,7 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 }
 
 static void
-mt7921_mac_init_band(struct mt7921_dev *dev, u8 band)
+mt7921_mac_init_band(struct mt792x_dev *dev, u8 band)
 {
 	u32 mask, set;
 
@@ -309,7 +309,7 @@ mt7921_get_mac80211_ops(struct device *dev, void *drv_data, u8 *fw_features)
 }
 EXPORT_SYMBOL_GPL(mt7921_get_mac80211_ops);
 
-int mt7921_mac_init(struct mt7921_dev *dev)
+int mt7921_mac_init(struct mt792x_dev *dev)
 {
 	int i;
 
@@ -329,7 +329,7 @@ int mt7921_mac_init(struct mt7921_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt7921_mac_init);
 
-static int __mt7921_init_hardware(struct mt7921_dev *dev)
+static int __mt7921_init_hardware(struct mt792x_dev *dev)
 {
 	int ret;
 
@@ -352,7 +352,7 @@ static int __mt7921_init_hardware(struct mt7921_dev *dev)
 	return ret;
 }
 
-static int mt7921_init_hardware(struct mt7921_dev *dev)
+static int mt7921_init_hardware(struct mt792x_dev *dev)
 {
 	int ret, i;
 
@@ -374,7 +374,7 @@ static int mt7921_init_hardware(struct mt7921_dev *dev)
 	return 0;
 }
 
-static int mt7921_init_wcid(struct mt7921_dev *dev)
+static int mt7921_init_wcid(struct mt792x_dev *dev)
 {
 	int idx;
 
@@ -393,7 +393,7 @@ static int mt7921_init_wcid(struct mt7921_dev *dev)
 
 static void mt7921_init_work(struct work_struct *work)
 {
-	struct mt7921_dev *dev = container_of(work, struct mt7921_dev,
+	struct mt792x_dev *dev = container_of(work, struct mt792x_dev,
 					      init_work);
 	int ret;
 
@@ -429,7 +429,7 @@ static void mt7921_init_work(struct work_struct *work)
 	mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
 }
 
-int mt7921_register_device(struct mt7921_dev *dev)
+int mt7921_register_device(struct mt792x_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	int ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 15c0e8be8f34..a17d70aa90da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -20,7 +20,7 @@ static u32 mt7921_mac_wtbl_lmac_addr(int idx, u8 offset)
 	return MT_WTBL_LMAC_OFFS(idx, 0) + offset * 4;
 }
 
-static struct mt76_wcid *mt7921_rx_get_wcid(struct mt7921_dev *dev,
+static struct mt76_wcid *mt7921_rx_get_wcid(struct mt792x_dev *dev,
 					    u16 idx, bool unicast)
 {
 	struct mt792x_sta *sta;
@@ -43,7 +43,7 @@ static struct mt76_wcid *mt7921_rx_get_wcid(struct mt7921_dev *dev,
 	return &sta->vif->sta.wcid;
 }
 
-bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask)
+bool mt7921_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask)
 {
 	mt76_rmw(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
 		 FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, idx) | mask);
@@ -52,7 +52,7 @@ bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask)
 			 0, 5000);
 }
 
-static void mt7921_mac_sta_poll(struct mt7921_dev *dev)
+static void mt7921_mac_sta_poll(struct mt792x_dev *dev)
 {
 	static const u8 ac_to_tid[] = {
 		[IEEE80211_AC_BE] = 0,
@@ -185,7 +185,7 @@ static void mt7921_mac_sta_poll(struct mt7921_dev *dev)
 }
 
 static void
-mt7921_get_status_freq_info(struct mt7921_dev *dev, struct mt76_phy *mphy,
+mt7921_get_status_freq_info(struct mt792x_dev *dev, struct mt76_phy *mphy,
 			    struct mt76_rx_status *status, u8 chfreq)
 {
 	if (chfreq > 180) {
@@ -217,7 +217,7 @@ mt7921_mac_rssi_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 }
 
 static void
-mt7921_mac_assoc_rssi(struct mt7921_dev *dev, struct sk_buff *skb)
+mt7921_mac_assoc_rssi(struct mt792x_dev *dev, struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
 
@@ -231,7 +231,7 @@ mt7921_mac_assoc_rssi(struct mt7921_dev *dev, struct sk_buff *skb)
 }
 
 static int
-mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
+mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 {
 	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
@@ -511,7 +511,7 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	return 0;
 }
 
-void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
+void mt7921_mac_add_txs(struct mt792x_dev *dev, void *data)
 {
 	struct mt792x_sta *msta = NULL;
 	struct mt76_wcid *wcid;
@@ -552,7 +552,7 @@ void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
 	rcu_read_unlock();
 }
 
-static void mt7921_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
+static void mt7921_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 {
 	struct mt76_connac_tx_free *free = data;
 	__le32 *tx_info = (__le32 *)(data + sizeof(*free));
@@ -634,7 +634,7 @@ static void mt7921_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
 
 bool mt7921_rx_check(struct mt76_dev *mdev, void *data, int len)
 {
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	__le32 *rxd = (__le32 *)data;
 	__le32 *end = (__le32 *)&rxd[len / 4];
 	enum rx_pkt_type type;
@@ -659,7 +659,7 @@ EXPORT_SYMBOL_GPL(mt7921_rx_check);
 void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb, u32 *info)
 {
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	__le32 *rxd = (__le32 *)skb->data;
 	__le32 *end = (__le32 *)&skb->data[skb->len];
 	enum rx_pkt_type type;
@@ -701,7 +701,7 @@ EXPORT_SYMBOL_GPL(mt7921_queue_rx_skb);
 
 void mt7921_mac_reset_counters(struct mt792x_phy *phy)
 {
-	struct mt7921_dev *dev = phy->dev;
+	struct mt792x_dev *dev = phy->dev;
 	int i;
 
 	for (i = 0; i < 4; i++) {
@@ -724,7 +724,7 @@ void mt7921_mac_reset_counters(struct mt792x_phy *phy)
 void mt7921_mac_set_timing(struct mt792x_phy *phy)
 {
 	s16 coverage_class = phy->coverage_class;
-	struct mt7921_dev *dev = phy->dev;
+	struct mt792x_dev *dev = phy->dev;
 	u32 val, reg_offset;
 	u32 cck = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 231) |
 		  FIELD_PREP(MT_TIMEOUT_VAL_CCA, 48);
@@ -771,7 +771,7 @@ mt7921_phy_get_nf(struct mt792x_phy *phy, int idx)
 static void
 mt7921_phy_update_channel(struct mt76_phy *mphy, int idx)
 {
-	struct mt7921_dev *dev = container_of(mphy->dev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mphy->dev, struct mt792x_dev, mt76);
 	struct mt792x_phy *phy = (struct mt792x_phy *)mphy->priv;
 	struct mt76_channel_state *state;
 	u64 busy_time, tx_time, rx_time, obss_time;
@@ -802,7 +802,7 @@ mt7921_phy_update_channel(struct mt76_phy *mphy, int idx)
 
 void mt7921_update_channel(struct mt76_phy *mphy)
 {
-	struct mt7921_dev *dev = container_of(mphy->dev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mphy->dev, struct mt792x_dev, mt76);
 
 	if (mt76_connac_pm_wake(mphy, &dev->pm))
 		return;
@@ -820,7 +820,7 @@ mt7921_vif_connect_iter(void *priv, u8 *mac,
 			struct ieee80211_vif *vif)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt7921_dev *dev = mvif->phy->dev;
+	struct mt792x_dev *dev = mvif->phy->dev;
 	struct ieee80211_hw *hw = mt76_hw(dev);
 
 	if (vif->type == NL80211_IFTYPE_STATION)
@@ -841,7 +841,7 @@ mt7921_vif_connect_iter(void *priv, u8 *mac,
 /* system error recovery */
 void mt7921_mac_reset_work(struct work_struct *work)
 {
-	struct mt7921_dev *dev = container_of(work, struct mt7921_dev,
+	struct mt792x_dev *dev = container_of(work, struct mt792x_dev,
 					      reset_work);
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct mt76_connac_pm *pm = &dev->pm;
@@ -886,7 +886,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
 
 void mt7921_reset(struct mt76_dev *mdev)
 {
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt76_connac_pm *pm = &dev->pm;
 
 	if (!dev->hw_init_done)
@@ -905,7 +905,7 @@ EXPORT_SYMBOL_GPL(mt7921_reset);
 void mt7921_mac_update_mib_stats(struct mt792x_phy *phy)
 {
 	struct mt76_mib_stats *mib = &phy->mib;
-	struct mt7921_dev *dev = phy->dev;
+	struct mt792x_dev *dev = phy->dev;
 	int i, aggr0 = 0, aggr1;
 	u32 val;
 
@@ -989,10 +989,10 @@ void mt7921_mac_work(struct work_struct *work)
 
 void mt7921_pm_wake_work(struct work_struct *work)
 {
-	struct mt7921_dev *dev;
+	struct mt792x_dev *dev;
 	struct mt76_phy *mphy;
 
-	dev = (struct mt7921_dev *)container_of(work, struct mt7921_dev,
+	dev = (struct mt792x_dev *)container_of(work, struct mt792x_dev,
 						pm.wake_work);
 	mphy = dev->phy.mt76;
 
@@ -1022,11 +1022,11 @@ void mt7921_pm_wake_work(struct work_struct *work)
 
 void mt7921_pm_power_save_work(struct work_struct *work)
 {
-	struct mt7921_dev *dev;
+	struct mt792x_dev *dev;
 	unsigned long delta;
 	struct mt76_phy *mphy;
 
-	dev = (struct mt7921_dev *)container_of(work, struct mt7921_dev,
+	dev = (struct mt792x_dev *)container_of(work, struct mt792x_dev,
 						pm.ps_work.work);
 	mphy = dev->phy.mt76;
 
@@ -1059,10 +1059,10 @@ void mt7921_pm_power_save_work(struct work_struct *work)
 
 void mt7921_coredump_work(struct work_struct *work)
 {
-	struct mt7921_dev *dev;
+	struct mt792x_dev *dev;
 	char *dump, *data;
 
-	dev = (struct mt7921_dev *)container_of(work, struct mt7921_dev,
+	dev = (struct mt792x_dev *)container_of(work, struct mt792x_dev,
 						coredump.work.work);
 
 	if (time_is_after_jiffies(dev->coredump.last_activity +
@@ -1106,7 +1106,7 @@ void mt7921_coredump_work(struct work_struct *work)
 
 /* usb_sdio */
 static void
-mt7921_usb_sdio_write_txwi(struct mt7921_dev *dev, struct mt76_wcid *wcid,
+mt7921_usb_sdio_write_txwi(struct mt792x_dev *dev, struct mt76_wcid *wcid,
 			   enum mt76_txq_id qid, struct ieee80211_sta *sta,
 			   struct ieee80211_key_conf *key, int pid,
 			   struct sk_buff *skb)
@@ -1123,7 +1123,7 @@ int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 				   struct ieee80211_sta *sta,
 				   struct mt76_tx_info *tx_info)
 {
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
 	struct ieee80211_key_conf *key = info->control.hw_key;
 	struct sk_buff *skb = tx_info->skb;
@@ -1189,7 +1189,7 @@ EXPORT_SYMBOL_GPL(mt7921_usb_sdio_tx_complete_skb);
 
 bool mt7921_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update)
 {
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 
 	mt7921_mutex_acquire(dev);
 	mt7921_mac_sta_poll(dev);
@@ -1202,8 +1202,8 @@ EXPORT_SYMBOL_GPL(mt7921_usb_sdio_tx_status_data);
 #if IS_ENABLED(CONFIG_IPV6)
 void mt7921_set_ipv6_ns_work(struct work_struct *work)
 {
-	struct mt7921_dev *dev = container_of(work, struct mt7921_dev,
-						ipv6_ns_work);
+	struct mt792x_dev *dev = container_of(work, struct mt792x_dev,
+					      ipv6_ns_work);
 	struct sk_buff *skb;
 	int ret = 0;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index fc9a306344cd..2f597fb3ae5c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -264,7 +264,7 @@ static int mt7921_start(struct ieee80211_hw *hw)
 
 void mt7921_stop(struct ieee80211_hw *hw)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
@@ -285,7 +285,7 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	struct mt76_txq *mtxq;
 	int idx, ret = 0;
@@ -343,7 +343,7 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_sta *msta = &mvif->sta;
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	int idx = msta->wcid.idx;
 
@@ -472,7 +472,7 @@ static int mt7921_cancel_remain_on_channel(struct ieee80211_hw *hw,
 
 static int mt7921_set_channel(struct mt792x_phy *phy)
 {
-	struct mt7921_dev *dev = phy->dev;
+	struct mt792x_dev *dev = phy->dev;
 	int ret;
 
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
@@ -506,7 +506,7 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 			  struct ieee80211_key_conf *key)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_sta *msta = sta ? (struct mt792x_sta *)sta->drv_priv :
 				  &mvif->sta;
@@ -578,7 +578,7 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 static void
 mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	struct mt7921_dev *dev = priv;
+	struct mt792x_dev *dev = priv;
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	bool pm_enable = dev->pm.enable;
 	int err;
@@ -599,7 +599,7 @@ mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 static void
 mt7921_sniffer_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	struct mt7921_dev *dev = priv;
+	struct mt792x_dev *dev = priv;
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct mt76_connac_pm *pm = &dev->pm;
 	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
@@ -614,7 +614,7 @@ mt7921_sniffer_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 		mt7921_mcu_set_beacon_filter(dev, vif, false);
 }
 
-void mt7921_set_runtime_pm(struct mt7921_dev *dev)
+void mt7921_set_runtime_pm(struct mt792x_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct mt76_connac_pm *pm = &dev->pm;
@@ -630,7 +630,7 @@ void mt7921_set_runtime_pm(struct mt7921_dev *dev)
 
 static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	int ret = 0;
 
@@ -686,7 +686,7 @@ static void mt7921_configure_filter(struct ieee80211_hw *hw,
 #define MT7921_FILTER_OTHER_BSS  BIT(6)
 #define MT7921_FILTER_ENABLE     BIT(31)
 
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	u32 flags = MT7921_FILTER_ENABLE;
 
 #define MT7921_FILTER(_fif, _type) do {			\
@@ -711,7 +711,7 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 				    u64 changed)
 {
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
 	mt7921_mutex_acquire(dev);
 
@@ -755,7 +755,7 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta)
 {
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	int ret, idx;
@@ -796,7 +796,7 @@ EXPORT_SYMBOL_GPL(mt7921_mac_sta_add);
 void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			  struct ieee80211_sta *sta)
 {
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
@@ -821,7 +821,7 @@ EXPORT_SYMBOL_GPL(mt7921_mac_sta_assoc);
 void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta)
 {
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
@@ -853,7 +853,7 @@ EXPORT_SYMBOL_GPL(mt7921_mac_sta_remove);
 
 void mt7921_tx_worker(struct mt76_worker *w)
 {
-	struct mt7921_dev *dev = container_of(w, struct mt7921_dev,
+	struct mt792x_dev *dev = container_of(w, struct mt792x_dev,
 					      mt76.tx_worker);
 
 	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
@@ -869,7 +869,7 @@ static void mt7921_tx(struct ieee80211_hw *hw,
 		      struct ieee80211_tx_control *control,
 		      struct sk_buff *skb)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
@@ -907,7 +907,7 @@ static void mt7921_tx(struct ieee80211_hw *hw,
 
 static int mt7921_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
 	mt7921_mutex_acquire(dev);
 	mt76_connac_mcu_set_rts_thresh(&dev->mt76, val, 0);
@@ -921,7 +921,7 @@ mt7921_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		    struct ieee80211_ampdu_params *params)
 {
 	enum ieee80211_ampdu_mlme_action action = params->action;
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	struct ieee80211_sta *sta = params->sta;
 	struct ieee80211_txq *txq = sta->txq[params->tid];
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
@@ -979,7 +979,7 @@ static int mt7921_sta_state(struct ieee80211_hw *hw,
 			    enum ieee80211_sta_state old_state,
 			    enum ieee80211_sta_state new_state)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
 	if (dev->pm.ds_enable) {
 		mt7921_mutex_acquire(dev);
@@ -1087,7 +1087,7 @@ static void
 mt7921_get_et_strings(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		      u32 sset, u8 *data)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
 	if (sset != ETH_SS_STATS)
 		return;
@@ -1105,7 +1105,7 @@ static int
 mt7921_get_et_sset_count(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			 int sset)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
 	if (sset != ETH_SS_STATS)
 		return 0;
@@ -1136,7 +1136,7 @@ void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	int stats_size = ARRAY_SIZE(mt7921_gstrings_stats);
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
-	struct mt7921_dev *dev = phy->dev;
+	struct mt792x_dev *dev = phy->dev;
 	struct mt76_mib_stats *mib = &phy->mib;
 	struct mt76_ethtool_worker_info wi = {
 		.data = data,
@@ -1204,7 +1204,7 @@ static u64
 mt7921_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	u8 omac_idx = mvif->mt76.omac_idx;
 	union {
 		u64 t64;
@@ -1230,7 +1230,7 @@ mt7921_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       u64 timestamp)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	u8 omac_idx = mvif->mt76.omac_idx;
 	union {
 		u64 t64;
@@ -1253,7 +1253,7 @@ static void
 mt7921_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 {
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
-	struct mt7921_dev *dev = phy->dev;
+	struct mt792x_dev *dev = phy->dev;
 
 	mt7921_mutex_acquire(dev);
 	phy->coverage_class = max_t(s16, coverage_class, 0);
@@ -1298,7 +1298,7 @@ static int
 mt7921_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       struct ieee80211_scan_request *req)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
 	int err;
 
@@ -1312,7 +1312,7 @@ mt7921_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 static void
 mt7921_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
 
 	mt7921_mutex_acquire(dev);
@@ -1325,7 +1325,7 @@ mt7921_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			struct cfg80211_sched_scan_request *req,
 			struct ieee80211_scan_ies *ies)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
 	int err;
 
@@ -1345,7 +1345,7 @@ mt7921_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 static int
 mt7921_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
 	int err;
 
@@ -1359,7 +1359,7 @@ mt7921_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 static int
 mt7921_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	int max_nss = hweight8(hw->wiphy->available_antennas_tx);
 
@@ -1423,7 +1423,7 @@ static void mt7921_sta_statistics(struct ieee80211_hw *hw,
 static int mt7921_suspend(struct ieee80211_hw *hw,
 			  struct cfg80211_wowlan *wowlan)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 
 	cancel_delayed_work_sync(&phy->scan_work);
@@ -1447,7 +1447,7 @@ static int mt7921_suspend(struct ieee80211_hw *hw,
 
 static int mt7921_resume(struct ieee80211_hw *hw)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 
 	mt7921_mutex_acquire(dev);
@@ -1468,7 +1468,7 @@ static int mt7921_resume(struct ieee80211_hw *hw)
 
 static void mt7921_set_wakeup(struct ieee80211_hw *hw, bool enabled)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	struct mt76_dev *mdev = &dev->mt76;
 
 	device_set_wakeup_enable(mdev->dev, enabled);
@@ -1478,7 +1478,7 @@ static void mt7921_set_rekey_data(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct cfg80211_gtk_rekey_data *data)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
 	mt7921_mutex_acquire(dev);
 	mt76_connac_mcu_update_gtk_rekey(hw, vif, data);
@@ -1489,7 +1489,7 @@ static void mt7921_set_rekey_data(struct ieee80211_hw *hw,
 static void mt7921_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			 u32 queues, bool drop)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
 	wait_event_timeout(dev->mt76.tx_wait, !mt76_has_tx_pending(&dev->mphy),
 			   HZ / 2);
@@ -1501,7 +1501,7 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 					 bool enabled)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
 	mt7921_mutex_acquire(dev);
 
@@ -1522,7 +1522,7 @@ static void mt7921_ipv6_addr_change(struct ieee80211_hw *hw,
 				    struct inet6_dev *idev)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt7921_dev *dev = mvif->phy->dev;
+	struct mt792x_dev *dev = mvif->phy->dev;
 	struct inet6_ifaddr *ifa;
 	struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
 	struct sk_buff *skb;
@@ -1598,7 +1598,7 @@ int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
 static int mt7921_set_sar_specs(struct ieee80211_hw *hw,
 				const struct cfg80211_sar_specs *sar)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	int err;
 
 	mt7921_mutex_acquire(dev);
@@ -1619,7 +1619,7 @@ mt7921_channel_switch_beacon(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
 			     struct cfg80211_chan_def *chandef)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
 	mt7921_mutex_acquire(dev);
 	mt7921_mcu_uni_add_beacon_offload(dev, hw, vif, true);
@@ -1632,7 +1632,7 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	int err;
 
 	mt7921_mutex_acquire(dev);
@@ -1660,7 +1660,7 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	int err;
 
 	mt7921_mutex_acquire(dev);
@@ -1725,7 +1725,7 @@ mt7921_assign_vif_chanctx(struct ieee80211_hw *hw,
 			  struct ieee80211_chanctx_conf *ctx)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
 	mvif->ctx = ctx;
@@ -1741,7 +1741,7 @@ mt7921_unassign_vif_chanctx(struct ieee80211_hw *hw,
 			    struct ieee80211_chanctx_conf *ctx)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
 	mvif->ctx = NULL;
@@ -1753,7 +1753,7 @@ static void mt7921_mgd_prepare_tx(struct ieee80211_hw *hw,
 				  struct ieee80211_prep_tx_info *info)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	u16 duration = info->duration ? info->duration :
 		       jiffies_to_msecs(HZ);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 06fecc9dc220..db3394ba4e45 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -69,7 +69,7 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 }
 EXPORT_SYMBOL_GPL(mt7921_mcu_parse_response);
 
-static int mt7921_mcu_read_eeprom(struct mt7921_dev *dev, u32 offset, u8 *val)
+static int mt7921_mcu_read_eeprom(struct mt792x_dev *dev, u32 offset, u8 *val)
 {
 	struct mt7921_mcu_eeprom_info *res, req = {
 		.addr = cpu_to_le32(round_down(offset,
@@ -134,7 +134,7 @@ void mt7921_mcu_set_suspend_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 #endif /* CONFIG_PM */
 
 static void
-mt7921_mcu_uni_roc_event(struct mt7921_dev *dev, struct sk_buff *skb)
+mt7921_mcu_uni_roc_event(struct mt792x_dev *dev, struct sk_buff *skb)
 {
 	struct mt7921_roc_grant_tlv *grant;
 	struct mt76_connac2_mcu_rxd *rxd;
@@ -157,7 +157,7 @@ mt7921_mcu_uni_roc_event(struct mt7921_dev *dev, struct sk_buff *skb)
 }
 
 static void
-mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
+mt7921_mcu_scan_event(struct mt792x_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt792x_phy *phy = (struct mt792x_phy *)mphy->priv;
@@ -188,7 +188,7 @@ mt7921_mcu_connection_loss_iter(void *priv, u8 *mac,
 }
 
 static void
-mt7921_mcu_connection_loss_event(struct mt7921_dev *dev, struct sk_buff *skb)
+mt7921_mcu_connection_loss_event(struct mt792x_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_connac_beacon_loss_event *event;
 	struct mt76_phy *mphy = &dev->mt76.phy;
@@ -202,7 +202,7 @@ mt7921_mcu_connection_loss_event(struct mt7921_dev *dev, struct sk_buff *skb)
 }
 
 static void
-mt7921_mcu_debug_msg_event(struct mt7921_dev *dev, struct sk_buff *skb)
+mt7921_mcu_debug_msg_event(struct mt792x_dev *dev, struct sk_buff *skb)
 {
 	struct mt7921_debug_msg {
 		__le16 id;
@@ -229,7 +229,7 @@ mt7921_mcu_debug_msg_event(struct mt7921_dev *dev, struct sk_buff *skb)
 }
 
 static void
-mt7921_mcu_low_power_event(struct mt7921_dev *dev, struct sk_buff *skb)
+mt7921_mcu_low_power_event(struct mt792x_dev *dev, struct sk_buff *skb)
 {
 	struct mt7921_mcu_lp_event {
 		u8 state;
@@ -243,7 +243,7 @@ mt7921_mcu_low_power_event(struct mt7921_dev *dev, struct sk_buff *skb)
 }
 
 static void
-mt7921_mcu_tx_done_event(struct mt7921_dev *dev, struct sk_buff *skb)
+mt7921_mcu_tx_done_event(struct mt792x_dev *dev, struct sk_buff *skb)
 {
 	struct mt7921_mcu_tx_done_event *event;
 
@@ -254,7 +254,7 @@ mt7921_mcu_tx_done_event(struct mt7921_dev *dev, struct sk_buff *skb)
 }
 
 static void
-mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
+mt7921_mcu_rx_unsolicited_event(struct mt792x_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_connac2_mcu_rxd *rxd;
 
@@ -288,7 +288,7 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
 }
 
 static void
-mt7921_mcu_uni_rx_unsolicited_event(struct mt7921_dev *dev,
+mt7921_mcu_uni_rx_unsolicited_event(struct mt792x_dev *dev,
 				    struct sk_buff *skb)
 {
 	struct mt76_connac2_mcu_rxd *rxd;
@@ -305,7 +305,7 @@ mt7921_mcu_uni_rx_unsolicited_event(struct mt7921_dev *dev,
 	dev_kfree_skb(skb);
 }
 
-void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
+void mt7921_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_connac2_mcu_rxd *rxd;
 
@@ -339,7 +339,7 @@ void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
 }
 
 /** starec & wtbl **/
-int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
+int mt7921_mcu_uni_tx_ba(struct mt792x_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable)
 {
@@ -353,7 +353,7 @@ int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
 				      enable, true);
 }
 
-int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
+int mt7921_mcu_uni_rx_ba(struct mt792x_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable)
 {
@@ -364,7 +364,7 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
 				      enable, false);
 }
 
-static char *mt7921_patch_name(struct mt7921_dev *dev)
+static char *mt7921_patch_name(struct mt792x_dev *dev)
 {
 	char *ret;
 
@@ -376,7 +376,7 @@ static char *mt7921_patch_name(struct mt7921_dev *dev)
 	return ret;
 }
 
-static char *mt7921_ram_name(struct mt7921_dev *dev)
+static char *mt7921_ram_name(struct mt792x_dev *dev)
 {
 	char *ret;
 
@@ -388,7 +388,7 @@ static char *mt7921_ram_name(struct mt7921_dev *dev)
 	return ret;
 }
 
-static int mt7921_load_clc(struct mt7921_dev *dev, const char *fw_name)
+static int mt7921_load_clc(struct mt792x_dev *dev, const char *fw_name)
 {
 	const struct mt76_connac2_fw_trailer *hdr;
 	const struct mt76_connac2_fw_region *region;
@@ -472,7 +472,7 @@ static int mt7921_load_clc(struct mt7921_dev *dev, const char *fw_name)
 	return ret;
 }
 
-static int mt7921_load_firmware(struct mt7921_dev *dev)
+static int mt7921_load_firmware(struct mt792x_dev *dev)
 {
 	int ret;
 
@@ -507,7 +507,7 @@ static int mt7921_load_firmware(struct mt7921_dev *dev)
 	return 0;
 }
 
-int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl)
+int mt7921_mcu_fw_log_2_host(struct mt792x_dev *dev, u8 ctrl)
 {
 	struct {
 		u8 ctrl_val;
@@ -520,7 +520,7 @@ int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl)
 				 &data, sizeof(data), false);
 }
 
-int mt7921_run_firmware(struct mt7921_dev *dev)
+int mt7921_run_firmware(struct mt792x_dev *dev)
 {
 	int err;
 
@@ -541,7 +541,7 @@ int mt7921_run_firmware(struct mt7921_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt7921_run_firmware);
 
-int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
+int mt7921_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct edca {
@@ -640,7 +640,7 @@ int mt7921_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 		       enum mt7921_roc_req type, u8 token_id)
 {
 	int center_ch = ieee80211_frequency_to_channel(chan->center_freq);
-	struct mt7921_dev *dev = phy->dev;
+	struct mt792x_dev *dev = phy->dev;
 	struct {
 		struct {
 			u8 rsv[4];
@@ -705,7 +705,7 @@ int mt7921_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 int mt7921_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 			 u8 token_id)
 {
-	struct mt7921_dev *dev = phy->dev;
+	struct mt792x_dev *dev = phy->dev;
 	struct {
 		struct {
 			u8 rsv[4];
@@ -734,7 +734,7 @@ int mt7921_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 
 int mt7921_mcu_set_chan_info(struct mt792x_phy *phy, int cmd)
 {
-	struct mt7921_dev *dev = phy->dev;
+	struct mt792x_dev *dev = phy->dev;
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	int freq1 = chandef->center_freq1;
 	struct {
@@ -791,7 +791,7 @@ int mt7921_mcu_set_chan_info(struct mt792x_phy *phy, int cmd)
 	return mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
 }
 
-int mt7921_mcu_set_eeprom(struct mt7921_dev *dev)
+int mt7921_mcu_set_eeprom(struct mt792x_dev *dev)
 {
 	struct req_hdr {
 		u8 buffer_mode;
@@ -807,7 +807,7 @@ int mt7921_mcu_set_eeprom(struct mt7921_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt7921_mcu_set_eeprom);
 
-int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif)
+int mt7921_mcu_uni_bss_ps(struct mt792x_dev *dev, struct ieee80211_vif *vif)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct {
@@ -845,7 +845,7 @@ int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 }
 
 static int
-mt7921_mcu_uni_bss_bcnft(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+mt7921_mcu_uni_bss_bcnft(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			 bool enable)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
@@ -881,7 +881,7 @@ mt7921_mcu_uni_bss_bcnft(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 }
 
 int
-mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+mt7921_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		      bool enable)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
@@ -918,7 +918,7 @@ mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 				 &req, sizeof(req), false);
 }
 
-int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
+int mt7921_mcu_sta_update(struct mt792x_dev *dev, struct ieee80211_sta *sta,
 			  struct ieee80211_vif *vif, bool enable,
 			  enum mt76_sta_info_state state)
 {
@@ -942,7 +942,7 @@ int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
 	return mt76_connac_mcu_sta_cmd(&dev->mphy, &info);
 }
 
-int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
+int mt7921_mcu_drv_pmctrl(struct mt792x_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt76_connac_pm *pm = &dev->pm;
@@ -964,7 +964,7 @@ int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt7921_mcu_drv_pmctrl);
 
-int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev)
+int mt7921_mcu_fw_pmctrl(struct mt792x_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt76_connac_pm *pm = &dev->pm;
@@ -986,7 +986,7 @@ int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt7921_mcu_fw_pmctrl);
 
-int mt7921_mcu_set_beacon_filter(struct mt7921_dev *dev,
+int mt7921_mcu_set_beacon_filter(struct mt792x_dev *dev,
 				 struct ieee80211_vif *vif,
 				 bool enable)
 {
@@ -1021,7 +1021,7 @@ int mt7921_mcu_set_beacon_filter(struct mt7921_dev *dev,
 	return 0;
 }
 
-int mt7921_get_txpwr_info(struct mt7921_dev *dev, struct mt7921_txpwr *txpwr)
+int mt7921_get_txpwr_info(struct mt792x_dev *dev, struct mt7921_txpwr *txpwr)
 {
 	struct mt7921_txpwr_event *event;
 	struct mt7921_txpwr_req req = {
@@ -1044,7 +1044,7 @@ int mt7921_get_txpwr_info(struct mt7921_dev *dev, struct mt7921_txpwr *txpwr)
 	return 0;
 }
 
-int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+int mt7921_mcu_set_sniffer(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			   bool enable)
 {
 	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
@@ -1143,7 +1143,7 @@ int mt7921_mcu_config_sniffer(struct mt792x_vif *vif,
 }
 
 int
-mt7921_mcu_uni_add_beacon_offload(struct mt7921_dev *dev,
+mt7921_mcu_uni_add_beacon_offload(struct mt792x_dev *dev,
 				  struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  bool enable)
@@ -1221,7 +1221,7 @@ mt7921_mcu_uni_add_beacon_offload(struct mt7921_dev *dev,
 }
 
 static
-int __mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
+int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 			 enum environment_cap env_cap,
 			 struct mt7921_clc *clc,
 			 u8 idx)
@@ -1283,7 +1283,7 @@ int __mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
 	return 0;
 }
 
-int mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
+int mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		       enum environment_cap env_cap)
 {
 	struct mt792x_phy *phy = (struct mt792x_phy *)&dev->phy;
@@ -1307,7 +1307,7 @@ int mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
 
 int mt7921_mcu_get_temperature(struct mt792x_phy *phy)
 {
-	struct mt7921_dev *dev = phy->dev;
+	struct mt792x_dev *dev = phy->dev;
 	struct {
 		u8 ctrl_id;
 		u8 action;
@@ -1322,7 +1322,7 @@ int mt7921_mcu_get_temperature(struct mt792x_phy *phy)
 				 sizeof(req), true);
 }
 
-int mt7921_mcu_set_rxfilter(struct mt7921_dev *dev, u32 fif,
+int mt7921_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
 			    u8 bit_op, u32 bit_map)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index d9550b0aba61..617aecd42544 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -201,7 +201,7 @@ struct mt7921_clc {
 
 struct mt792x_phy {
 	struct mt76_phy *mt76;
-	struct mt7921_dev *dev;
+	struct mt792x_dev *dev;
 
 	struct ieee80211_sband_iftype_data iftype[NUM_NL80211_BANDS][NUM_NL80211_IFTYPES];
 
@@ -250,14 +250,14 @@ enum mt7921_eeprom_field {
 #define __mt7921_mcu_drv_pmctrl(dev)	((dev)->hif_ops->drv_own(dev))
 #define	__mt7921_mcu_fw_pmctrl(dev)	((dev)->hif_ops->fw_own(dev))
 struct mt7921_hif_ops {
-	int (*init_reset)(struct mt7921_dev *dev);
-	int (*reset)(struct mt7921_dev *dev);
-	int (*mcu_init)(struct mt7921_dev *dev);
-	int (*drv_own)(struct mt7921_dev *dev);
-	int (*fw_own)(struct mt7921_dev *dev);
+	int (*init_reset)(struct mt792x_dev *dev);
+	int (*reset)(struct mt792x_dev *dev);
+	int (*mcu_init)(struct mt792x_dev *dev);
+	int (*drv_own)(struct mt792x_dev *dev);
+	int (*fw_own)(struct mt792x_dev *dev);
 };
 
-struct mt7921_dev {
+struct mt792x_dev {
 	union { /* must be first */
 		struct mt76_dev mt76;
 		struct mt76_phy mphy;
@@ -325,12 +325,12 @@ mt7921_hw_phy(struct ieee80211_hw *hw)
 	return phy->priv;
 }
 
-static inline struct mt7921_dev *
+static inline struct mt792x_dev *
 mt7921_hw_dev(struct ieee80211_hw *hw)
 {
 	struct mt76_phy *phy = hw->priv;
 
-	return container_of(phy->dev, struct mt7921_dev, mt76);
+	return container_of(phy->dev, struct mt792x_dev, mt76);
 }
 
 #define mt7921_mutex_acquire(dev)	\
@@ -340,33 +340,33 @@ mt7921_hw_dev(struct ieee80211_hw *hw)
 
 extern const struct ieee80211_ops mt7921_ops;
 
-u32 mt7921_reg_map(struct mt7921_dev *dev, u32 addr);
+u32 mt7921_reg_map(struct mt792x_dev *dev, u32 addr);
 
 int __mt7921_start(struct mt792x_phy *phy);
-int mt7921_register_device(struct mt7921_dev *dev);
-void mt7921_unregister_device(struct mt7921_dev *dev);
-int mt7921_dma_init(struct mt7921_dev *dev);
-int mt7921_wpdma_reset(struct mt7921_dev *dev, bool force);
-int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev);
-void mt7921_dma_cleanup(struct mt7921_dev *dev);
-int mt7921_run_firmware(struct mt7921_dev *dev);
-int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+int mt7921_register_device(struct mt792x_dev *dev);
+void mt7921_unregister_device(struct mt792x_dev *dev);
+int mt7921_dma_init(struct mt792x_dev *dev);
+int mt7921_wpdma_reset(struct mt792x_dev *dev, bool force);
+int mt7921_wpdma_reinit_cond(struct mt792x_dev *dev);
+void mt7921_dma_cleanup(struct mt792x_dev *dev);
+int mt7921_run_firmware(struct mt792x_dev *dev);
+int mt7921_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			  bool enable);
-int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
+int mt7921_mcu_sta_update(struct mt792x_dev *dev, struct ieee80211_sta *sta,
 			  struct ieee80211_vif *vif, bool enable,
 			  enum mt76_sta_info_state state);
 int mt7921_mcu_set_chan_info(struct mt792x_phy *phy, int cmd);
-int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif);
-int mt7921_mcu_set_eeprom(struct mt7921_dev *dev);
+int mt7921_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif);
+int mt7921_mcu_set_eeprom(struct mt792x_dev *dev);
 int mt7921_mcu_get_rx_rate(struct mt792x_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate);
-int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl);
-void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb);
-int mt7921_mcu_set_rxfilter(struct mt7921_dev *dev, u32 fif,
+int mt7921_mcu_fw_log_2_host(struct mt792x_dev *dev, u8 ctrl);
+void mt7921_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb);
+int mt7921_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
 			    u8 bit_op, u32 bit_map);
 
 static inline u32
-mt7921_reg_map_l1(struct mt7921_dev *dev, u32 addr)
+mt7921_reg_map_l1(struct mt792x_dev *dev, u32 addr)
 {
 	u32 offset = FIELD_GET(MT_HIF_REMAP_L1_OFFSET, addr);
 	u32 base = FIELD_GET(MT_HIF_REMAP_L1_BASE, addr);
@@ -379,19 +379,19 @@ mt7921_reg_map_l1(struct mt7921_dev *dev, u32 addr)
 }
 
 static inline u32
-mt7921_l1_rr(struct mt7921_dev *dev, u32 addr)
+mt7921_l1_rr(struct mt792x_dev *dev, u32 addr)
 {
 	return mt76_rr(dev, mt7921_reg_map_l1(dev, addr));
 }
 
 static inline void
-mt7921_l1_wr(struct mt7921_dev *dev, u32 addr, u32 val)
+mt7921_l1_wr(struct mt792x_dev *dev, u32 addr, u32 val)
 {
 	mt76_wr(dev, mt7921_reg_map_l1(dev, addr), val);
 }
 
 static inline u32
-mt7921_l1_rmw(struct mt7921_dev *dev, u32 addr, u32 mask, u32 val)
+mt7921_l1_rmw(struct mt792x_dev *dev, u32 addr, u32 mask, u32 val)
 {
 	val |= mt7921_l1_rr(dev, addr) & ~mask;
 	mt7921_l1_wr(dev, addr, val);
@@ -402,13 +402,13 @@ mt7921_l1_rmw(struct mt7921_dev *dev, u32 addr, u32 mask, u32 val)
 #define mt7921_l1_set(dev, addr, val)	mt7921_l1_rmw(dev, addr, 0, val)
 #define mt7921_l1_clear(dev, addr, val)	mt7921_l1_rmw(dev, addr, val, 0)
 
-static inline bool mt7921_dma_need_reinit(struct mt7921_dev *dev)
+static inline bool mt7921_dma_need_reinit(struct mt792x_dev *dev)
 {
 	return !mt76_get_field(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
 }
 
 static inline void
-mt7921_skb_add_usb_sdio_hdr(struct mt7921_dev *dev, struct sk_buff *skb,
+mt7921_skb_add_usb_sdio_hdr(struct mt792x_dev *dev, struct sk_buff *skb,
 			    int type)
 {
 	u32 hdr, len;
@@ -421,8 +421,8 @@ mt7921_skb_add_usb_sdio_hdr(struct mt7921_dev *dev, struct sk_buff *skb,
 }
 
 void mt7921_stop(struct ieee80211_hw *hw);
-int mt7921_mac_init(struct mt7921_dev *dev);
-bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask);
+int mt7921_mac_init(struct mt792x_dev *dev);
+bool mt7921_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask);
 void mt7921_mac_reset_counters(struct mt792x_phy *phy);
 void mt7921_mac_set_timing(struct mt792x_phy *phy);
 int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
@@ -447,28 +447,28 @@ void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 void mt7921_stats_work(struct work_struct *work);
 void mt7921_set_stream_he_caps(struct mt792x_phy *phy);
 void mt7921_update_channel(struct mt76_phy *mphy);
-int mt7921_init_debugfs(struct mt7921_dev *dev);
+int mt7921_init_debugfs(struct mt792x_dev *dev);
 
-int mt7921_mcu_set_beacon_filter(struct mt7921_dev *dev,
+int mt7921_mcu_set_beacon_filter(struct mt792x_dev *dev,
 				 struct ieee80211_vif *vif,
 				 bool enable);
-int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
+int mt7921_mcu_uni_tx_ba(struct mt792x_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
-int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
+int mt7921_mcu_uni_rx_ba(struct mt792x_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
 void mt7921_scan_work(struct work_struct *work);
 void mt7921_roc_work(struct work_struct *work);
 void mt7921_roc_timer(struct timer_list *timer);
-int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif);
-int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
-int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev);
+int mt7921_mcu_uni_bss_ps(struct mt792x_dev *dev, struct ieee80211_vif *vif);
+int mt7921_mcu_drv_pmctrl(struct mt792x_dev *dev);
+int mt7921_mcu_fw_pmctrl(struct mt792x_dev *dev);
 void mt7921_pm_wake_work(struct work_struct *work);
 void mt7921_pm_power_save_work(struct work_struct *work);
 void mt7921_coredump_work(struct work_struct *work);
-int mt7921_wfsys_reset(struct mt7921_dev *dev);
-int mt7921_get_txpwr_info(struct mt7921_dev *dev, struct mt7921_txpwr *txpwr);
+int mt7921_wfsys_reset(struct mt792x_dev *dev);
+int mt7921_get_txpwr_info(struct mt792x_dev *dev, struct mt7921_txpwr *txpwr);
 int mt7921_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			void *data, int len);
 int mt7921_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
@@ -476,26 +476,26 @@ int mt7921_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
 int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq);
 
-int mt7921e_driver_own(struct mt7921_dev *dev);
-int mt7921e_mac_reset(struct mt7921_dev *dev);
-int mt7921e_mcu_init(struct mt7921_dev *dev);
-int mt7921s_wfsys_reset(struct mt7921_dev *dev);
-int mt7921s_mac_reset(struct mt7921_dev *dev);
-int mt7921s_init_reset(struct mt7921_dev *dev);
-int __mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
-int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
-int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev);
-
-int mt7921s_mcu_init(struct mt7921_dev *dev);
-int mt7921s_mcu_drv_pmctrl(struct mt7921_dev *dev);
-int mt7921s_mcu_fw_pmctrl(struct mt7921_dev *dev);
-void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data);
-void mt7921_set_runtime_pm(struct mt7921_dev *dev);
+int mt7921e_driver_own(struct mt792x_dev *dev);
+int mt7921e_mac_reset(struct mt792x_dev *dev);
+int mt7921e_mcu_init(struct mt792x_dev *dev);
+int mt7921s_wfsys_reset(struct mt792x_dev *dev);
+int mt7921s_mac_reset(struct mt792x_dev *dev);
+int mt7921s_init_reset(struct mt792x_dev *dev);
+int __mt7921e_mcu_drv_pmctrl(struct mt792x_dev *dev);
+int mt7921e_mcu_drv_pmctrl(struct mt792x_dev *dev);
+int mt7921e_mcu_fw_pmctrl(struct mt792x_dev *dev);
+
+int mt7921s_mcu_init(struct mt792x_dev *dev);
+int mt7921s_mcu_drv_pmctrl(struct mt792x_dev *dev);
+int mt7921s_mcu_fw_pmctrl(struct mt792x_dev *dev);
+void mt7921_mac_add_txs(struct mt792x_dev *dev, void *data);
+void mt7921_set_runtime_pm(struct mt792x_dev *dev);
 void mt7921_mcu_set_suspend_iter(void *priv, u8 *mac,
 				 struct ieee80211_vif *vif);
 void mt7921_set_ipv6_ns_work(struct work_struct *work);
 
-int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+int mt7921_mcu_set_sniffer(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			   bool enable);
 int mt7921_mcu_config_sniffer(struct mt792x_vif *vif,
 			      struct ieee80211_chanctx_conf *ctx);
@@ -513,22 +513,22 @@ bool mt7921_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update);
 #define MT_USB_TYPE_VENDOR	(USB_TYPE_VENDOR | 0x1f)
 #define MT_USB_TYPE_UHW_VENDOR	(USB_TYPE_VENDOR | 0x1e)
 
-int mt7921u_mcu_power_on(struct mt7921_dev *dev);
-int mt7921u_wfsys_reset(struct mt7921_dev *dev);
-int mt7921u_dma_init(struct mt7921_dev *dev, bool resume);
-int mt7921u_init_reset(struct mt7921_dev *dev);
-int mt7921u_mac_reset(struct mt7921_dev *dev);
-int mt7921_mcu_uni_add_beacon_offload(struct mt7921_dev *dev,
+int mt7921u_mcu_power_on(struct mt792x_dev *dev);
+int mt7921u_wfsys_reset(struct mt792x_dev *dev);
+int mt7921u_dma_init(struct mt792x_dev *dev, bool resume);
+int mt7921u_init_reset(struct mt792x_dev *dev);
+int mt7921u_mac_reset(struct mt792x_dev *dev);
+int mt7921_mcu_uni_add_beacon_offload(struct mt792x_dev *dev,
 				      struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
 				      bool enable);
 #ifdef CONFIG_ACPI
-int mt7921_init_acpi_sar(struct mt7921_dev *dev);
+int mt7921_init_acpi_sar(struct mt792x_dev *dev);
 int mt7921_init_acpi_sar_power(struct mt792x_phy *phy, bool set_default);
 u8 mt7921_acpi_get_flags(struct mt792x_phy *phy);
 #else
 static inline int
-mt7921_init_acpi_sar(struct mt7921_dev *dev)
+mt7921_init_acpi_sar(struct mt792x_dev *dev)
 {
 	return 0;
 }
@@ -548,7 +548,7 @@ mt7921_acpi_get_flags(struct mt792x_phy *phy)
 int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
 			  const struct cfg80211_sar_specs *sar);
 
-int mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
+int mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		       enum environment_cap env_cap);
 int mt7921_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 		       struct ieee80211_channel *chan, int duration,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h
index 9bc4db67f352..9426fda69c30 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h
@@ -21,7 +21,7 @@
 #define LP_STATE_PR_ARG	__entry->lp_state ? "lp ready" : "lp not ready"
 
 TRACE_EVENT(lp_event,
-	TP_PROTO(struct mt7921_dev *dev, u8 lp_state),
+	TP_PROTO(struct mt792x_dev *dev, u8 lp_state),
 
 	TP_ARGS(dev, lp_state),
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 1b7f19939a69..517e4d541bdc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -41,7 +41,7 @@ mt7921_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
 
 static irqreturn_t mt7921_irq_handler(int irq, void *dev_instance)
 {
-	struct mt7921_dev *dev = dev_instance;
+	struct mt792x_dev *dev = dev_instance;
 
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
 
@@ -55,7 +55,7 @@ static irqreturn_t mt7921_irq_handler(int irq, void *dev_instance)
 
 static void mt7921_irq_tasklet(unsigned long data)
 {
-	struct mt7921_dev *dev = (struct mt7921_dev *)data;
+	struct mt792x_dev *dev = (struct mt792x_dev *)data;
 	u32 intr, mask = 0;
 
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
@@ -97,12 +97,12 @@ static void mt7921_irq_tasklet(unsigned long data)
 		napi_schedule(&dev->mt76.napi[MT_RXQ_MAIN]);
 }
 
-static int mt7921e_init_reset(struct mt7921_dev *dev)
+static int mt7921e_init_reset(struct mt792x_dev *dev)
 {
 	return mt7921_wpdma_reset(dev, true);
 }
 
-static void mt7921e_unregister_device(struct mt7921_dev *dev)
+static void mt7921e_unregister_device(struct mt792x_dev *dev)
 {
 	int i;
 	struct mt76_connac_pm *pm = &dev->pm;
@@ -124,7 +124,7 @@ static void mt7921e_unregister_device(struct mt7921_dev *dev)
 	tasklet_disable(&dev->mt76.irq_tasklet);
 }
 
-static u32 __mt7921_reg_addr(struct mt7921_dev *dev, u32 addr)
+static u32 __mt7921_reg_addr(struct mt792x_dev *dev, u32 addr)
 {
 	static const struct mt76_connac_reg_map fixed_map[] = {
 		{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
@@ -203,7 +203,7 @@ static u32 __mt7921_reg_addr(struct mt7921_dev *dev, u32 addr)
 
 static u32 mt7921_rr(struct mt76_dev *mdev, u32 offset)
 {
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	u32 addr = __mt7921_reg_addr(dev, offset);
 
 	return dev->bus_ops->rr(mdev, addr);
@@ -211,7 +211,7 @@ static u32 mt7921_rr(struct mt76_dev *mdev, u32 offset)
 
 static void mt7921_wr(struct mt76_dev *mdev, u32 offset, u32 val)
 {
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	u32 addr = __mt7921_reg_addr(dev, offset);
 
 	dev->bus_ops->wr(mdev, addr, val);
@@ -219,7 +219,7 @@ static void mt7921_wr(struct mt76_dev *mdev, u32 offset, u32 val)
 
 static u32 mt7921_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
 {
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	u32 addr = __mt7921_reg_addr(dev, offset);
 
 	return dev->bus_ops->rmw(mdev, addr, mask, val);
@@ -256,7 +256,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	};
 	struct ieee80211_ops *ops;
 	struct mt76_bus_ops *bus_ops;
-	struct mt7921_dev *dev;
+	struct mt792x_dev *dev;
 	struct mt76_dev *mdev;
 	u8 features;
 	int ret;
@@ -303,7 +303,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, mdev);
 
-	dev = container_of(mdev, struct mt7921_dev, mt76);
+	dev = container_of(mdev, struct mt792x_dev, mt76);
 	dev->fw_features = features;
 	dev->hif_ops = &mt7921_pcie_ops;
 	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
@@ -373,7 +373,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 static void mt7921_pci_remove(struct pci_dev *pdev)
 {
 	struct mt76_dev *mdev = pci_get_drvdata(pdev);
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 
 	mt7921e_unregister_device(dev);
 	devm_free_irq(&pdev->dev, pdev->irq, dev);
@@ -385,7 +385,7 @@ static int mt7921_pci_suspend(struct device *device)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct mt76_dev *mdev = pci_get_drvdata(pdev);
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt76_connac_pm *pm = &dev->pm;
 	int i, err;
 
@@ -459,7 +459,7 @@ static int mt7921_pci_resume(struct device *device)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct mt76_dev *mdev = pci_get_drvdata(pdev);
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt76_connac_pm *pm = &dev->pm;
 	int i, err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 32bba86727a5..7323388327f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -10,7 +10,7 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			   struct ieee80211_sta *sta,
 			   struct mt76_tx_info *tx_info)
 {
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
 	struct ieee80211_key_conf *key = info->control.hw_key;
 	struct mt76_connac_hw_txp *txp;
@@ -53,7 +53,7 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	return 0;
 }
 
-int mt7921e_mac_reset(struct mt7921_dev *dev)
+int mt7921e_mac_reset(struct mt792x_dev *dev)
 {
 	int i, err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
index 1aefbb6cf0ab..5a30cd0b9382 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
@@ -4,7 +4,7 @@
 #include "mt7921.h"
 #include "mcu.h"
 
-int mt7921e_driver_own(struct mt7921_dev *dev)
+int mt7921e_driver_own(struct mt792x_dev *dev)
 {
 	u32 reg = mt7921_reg_map_l1(dev, MT_TOP_LPCR_HOST_BAND0);
 
@@ -22,7 +22,7 @@ static int
 mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			int cmd, int *seq)
 {
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	enum mt76_mcuq_id txq = MT_MCUQ_WM;
 	int ret;
 
@@ -38,7 +38,7 @@ mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[txq], skb, 0);
 }
 
-int mt7921e_mcu_init(struct mt7921_dev *dev)
+int mt7921e_mcu_init(struct mt792x_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7921_mcu_ops = {
 		.headroom = sizeof(struct mt76_connac2_mcu_txd),
@@ -62,7 +62,7 @@ int mt7921e_mcu_init(struct mt7921_dev *dev)
 	return err;
 }
 
-int __mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
+int __mt7921e_mcu_drv_pmctrl(struct mt792x_dev *dev)
 {
 	int i, err = 0;
 
@@ -81,7 +81,7 @@ int __mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
 	return err;
 }
 
-int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
+int mt7921e_mcu_drv_pmctrl(struct mt792x_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt76_connac_pm *pm = &dev->pm;
@@ -101,7 +101,7 @@ int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
 	return err;
 }
 
-int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev)
+int mt7921e_mcu_fw_pmctrl(struct mt792x_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt76_connac_pm *pm = &dev->pm;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index a77a309c0d60..86da0cbbdf3b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -27,7 +27,7 @@ static void mt7921s_txrx_worker(struct mt76_worker *w)
 	struct mt76_sdio *sdio = container_of(w, struct mt76_sdio,
 					      txrx_worker);
 	struct mt76_dev *mdev = container_of(sdio, struct mt76_dev, sdio);
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 
 	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
 		queue_work(mdev->wq, &dev->pm.wake_work);
@@ -38,7 +38,7 @@ static void mt7921s_txrx_worker(struct mt76_worker *w)
 	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
 }
 
-static void mt7921s_unregister_device(struct mt7921_dev *dev)
+static void mt7921s_unregister_device(struct mt792x_dev *dev)
 {
 	struct mt76_connac_pm *pm = &dev->pm;
 
@@ -122,7 +122,7 @@ static int mt7921s_probe(struct sdio_func *func,
 		.fw_own = mt7921s_mcu_fw_pmctrl,
 	};
 	struct ieee80211_ops *ops;
-	struct mt7921_dev *dev;
+	struct mt792x_dev *dev;
 	struct mt76_dev *mdev;
 	u8 features;
 	int ret;
@@ -136,7 +136,7 @@ static int mt7921s_probe(struct sdio_func *func,
 	if (!mdev)
 		return -ENOMEM;
 
-	dev = container_of(mdev, struct mt7921_dev, mt76);
+	dev = container_of(mdev, struct mt792x_dev, mt76);
 	dev->fw_features = features;
 	dev->hif_ops = &mt7921_sdio_ops;
 	sdio_set_drvdata(func, dev);
@@ -196,7 +196,7 @@ static int mt7921s_probe(struct sdio_func *func,
 
 static void mt7921s_remove(struct sdio_func *func)
 {
-	struct mt7921_dev *dev = sdio_get_drvdata(func);
+	struct mt792x_dev *dev = sdio_get_drvdata(func);
 
 	mt7921s_unregister_device(dev);
 }
@@ -204,7 +204,7 @@ static void mt7921s_remove(struct sdio_func *func)
 static int mt7921s_suspend(struct device *__dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(__dev);
-	struct mt7921_dev *dev = sdio_get_drvdata(func);
+	struct mt792x_dev *dev = sdio_get_drvdata(func);
 	struct mt76_connac_pm *pm = &dev->pm;
 	struct mt76_dev *mdev = &dev->mt76;
 	int err;
@@ -277,7 +277,7 @@ static int mt7921s_suspend(struct device *__dev)
 static int mt7921s_resume(struct device *__dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(__dev);
-	struct mt7921_dev *dev = sdio_get_drvdata(func);
+	struct mt792x_dev *dev = sdio_get_drvdata(func);
 	struct mt76_connac_pm *pm = &dev->pm;
 	struct mt76_dev *mdev = &dev->mt76;
 	int err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index cff9925c41ea..8edd0291c128 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -30,7 +30,7 @@ static u32 mt7921s_read_whcr(struct mt76_dev *dev)
 	return sdio_readl(dev->sdio.func, MCR_WHCR, NULL);
 }
 
-int mt7921s_wfsys_reset(struct mt7921_dev *dev)
+int mt7921s_wfsys_reset(struct mt792x_dev *dev)
 {
 	struct mt76_sdio *sdio = &dev->mt76.sdio;
 	u32 val, status;
@@ -71,7 +71,7 @@ int mt7921s_wfsys_reset(struct mt7921_dev *dev)
 	return 0;
 }
 
-int mt7921s_init_reset(struct mt7921_dev *dev)
+int mt7921s_init_reset(struct mt792x_dev *dev)
 {
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 
@@ -91,7 +91,7 @@ int mt7921s_init_reset(struct mt7921_dev *dev)
 	return 0;
 }
 
-int mt7921s_mac_reset(struct mt7921_dev *dev)
+int mt7921s_mac_reset(struct mt792x_dev *dev)
 {
 	int err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
index 177679ce1c80..360de6a0de2b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
@@ -16,7 +16,7 @@ static int
 mt7921s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			 int cmd, int *seq)
 {
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	enum mt7921_sdio_pkt_type type = MT7921_SDIO_CMD;
 	enum mt76_mcuq_id txq = MT_MCUQ_WM;
 	int ret, pad;
@@ -51,14 +51,14 @@ mt7921s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	return ret;
 }
 
-static u32 mt7921s_read_rm3r(struct mt7921_dev *dev)
+static u32 mt7921s_read_rm3r(struct mt792x_dev *dev)
 {
 	struct mt76_sdio *sdio = &dev->mt76.sdio;
 
 	return sdio_readl(sdio->func, MCR_D2HRM3R, NULL);
 }
 
-static u32 mt7921s_clear_rm3r_drv_own(struct mt7921_dev *dev)
+static u32 mt7921s_clear_rm3r_drv_own(struct mt792x_dev *dev)
 {
 	struct mt76_sdio *sdio = &dev->mt76.sdio;
 	u32 val;
@@ -71,7 +71,7 @@ static u32 mt7921s_clear_rm3r_drv_own(struct mt7921_dev *dev)
 	return val;
 }
 
-int mt7921s_mcu_init(struct mt7921_dev *dev)
+int mt7921s_mcu_init(struct mt792x_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7921s_mcu_ops = {
 		.headroom = MT_SDIO_HDR_SIZE +
@@ -97,7 +97,7 @@ int mt7921s_mcu_init(struct mt7921_dev *dev)
 	return 0;
 }
 
-int mt7921s_mcu_drv_pmctrl(struct mt7921_dev *dev)
+int mt7921s_mcu_drv_pmctrl(struct mt792x_dev *dev)
 {
 	struct sdio_func *func = dev->mt76.sdio.func;
 	struct mt76_phy *mphy = &dev->mt76.phy;
@@ -133,7 +133,7 @@ int mt7921s_mcu_drv_pmctrl(struct mt7921_dev *dev)
 	return 0;
 }
 
-int mt7921s_mcu_fw_pmctrl(struct mt7921_dev *dev)
+int mt7921s_mcu_fw_pmctrl(struct mt792x_dev *dev)
 {
 	struct sdio_func *func = dev->mt76.sdio.func;
 	struct mt76_phy *mphy = &dev->mt76.phy;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
index 208dcb2afbe7..3c2165095ddd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
@@ -31,7 +31,7 @@ static const struct nla_policy mt7921_tm_policy[NUM_MT7921_TM_ATTRS] = {
 };
 
 static int
-mt7921_tm_set(struct mt7921_dev *dev, struct mt7921_tm_cmd *req)
+mt7921_tm_set(struct mt792x_dev *dev, struct mt7921_tm_cmd *req)
 {
 	struct mt7921_rftest_cmd cmd = {
 		.action = req->action,
@@ -82,7 +82,7 @@ mt7921_tm_set(struct mt7921_dev *dev, struct mt7921_tm_cmd *req)
 }
 
 static int
-mt7921_tm_query(struct mt7921_dev *dev, struct mt7921_tm_cmd *req,
+mt7921_tm_query(struct mt792x_dev *dev, struct mt7921_tm_cmd *req,
 		struct mt7921_tm_evt *evt_resp)
 {
 	struct mt7921_rftest_cmd cmd = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 1f302c430339..898cb1de9400 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -82,7 +82,7 @@ static void mt7921u_copy(struct mt76_dev *dev, u32 offset,
 	mutex_unlock(&usb->usb_ctrl_mtx);
 }
 
-int mt7921u_mcu_power_on(struct mt7921_dev *dev)
+int mt7921u_mcu_power_on(struct mt792x_dev *dev)
 {
 	int ret;
 
@@ -105,7 +105,7 @@ static int
 mt7921u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			 int cmd, int *seq)
 {
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	u32 pad, ep;
 	int ret;
 
@@ -131,7 +131,7 @@ mt7921u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	return ret;
 }
 
-static int mt7921u_mcu_init(struct mt7921_dev *dev)
+static int mt7921u_mcu_init(struct mt792x_dev *dev)
 {
 	static const struct mt76_mcu_ops mcu_ops = {
 		.headroom = MT_SDIO_HDR_SIZE +
@@ -157,13 +157,13 @@ static int mt7921u_mcu_init(struct mt7921_dev *dev)
 
 static void mt7921u_stop(struct ieee80211_hw *hw)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
 	mt76u_stop_tx(&dev->mt76);
 	mt7921_stop(hw);
 }
 
-static void mt7921u_cleanup(struct mt7921_dev *dev)
+static void mt7921u_cleanup(struct mt792x_dev *dev)
 {
 	clear_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 	mt7921u_wfsys_reset(dev);
@@ -207,7 +207,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 	struct usb_device *udev = interface_to_usbdev(usb_intf);
 	struct ieee80211_ops *ops;
 	struct ieee80211_hw *hw;
-	struct mt7921_dev *dev;
+	struct mt792x_dev *dev;
 	struct mt76_dev *mdev;
 	u8 features;
 	int ret;
@@ -222,7 +222,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 	if (!mdev)
 		return -ENOMEM;
 
-	dev = container_of(mdev, struct mt7921_dev, mt76);
+	dev = container_of(mdev, struct mt792x_dev, mt76);
 	dev->fw_features = features;
 	dev->hif_ops = &hif_ops;
 
@@ -284,7 +284,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 
 static void mt7921u_disconnect(struct usb_interface *usb_intf)
 {
-	struct mt7921_dev *dev = usb_get_intfdata(usb_intf);
+	struct mt792x_dev *dev = usb_get_intfdata(usb_intf);
 
 	cancel_work_sync(&dev->init_work);
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
@@ -302,7 +302,7 @@ static void mt7921u_disconnect(struct usb_interface *usb_intf)
 #ifdef CONFIG_PM
 static int mt7921u_suspend(struct usb_interface *intf, pm_message_t state)
 {
-	struct mt7921_dev *dev = usb_get_intfdata(intf);
+	struct mt792x_dev *dev = usb_get_intfdata(intf);
 	struct mt76_connac_pm *pm = &dev->pm;
 	int err;
 
@@ -329,7 +329,7 @@ static int mt7921u_suspend(struct usb_interface *intf, pm_message_t state)
 
 static int mt7921u_resume(struct usb_interface *intf)
 {
-	struct mt7921_dev *dev = usb_get_intfdata(intf);
+	struct mt792x_dev *dev = usb_get_intfdata(intf);
 	struct mt76_connac_pm *pm = &dev->pm;
 	bool reinit = true;
 	int err, i;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
index 50eb6e7fd6b5..f612873c704b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
@@ -32,7 +32,7 @@ static void mt7921u_uhw_wr(struct mt76_dev *dev, u32 addr, u32 val)
 	mutex_unlock(&dev->usb.usb_ctrl_mtx);
 }
 
-static void mt7921u_dma_prefetch(struct mt7921_dev *dev)
+static void mt7921u_dma_prefetch(struct mt792x_dev *dev)
 {
 	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(0),
 		 MT_WPDMA0_MAX_CNT_MASK, 4);
@@ -70,7 +70,7 @@ static void mt7921u_dma_prefetch(struct mt7921_dev *dev)
 		 MT_WPDMA0_BASE_PTR_MASK,  0x2c0);
 }
 
-static void mt7921u_wfdma_init(struct mt7921_dev *dev)
+static void mt7921u_wfdma_init(struct mt792x_dev *dev)
 {
 	mt7921u_dma_prefetch(dev);
 
@@ -90,7 +90,7 @@ static void mt7921u_wfdma_init(struct mt7921_dev *dev)
 	mt76_set(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
 }
 
-static int mt7921u_dma_rx_evt_ep4(struct mt7921_dev *dev)
+static int mt7921u_dma_rx_evt_ep4(struct mt792x_dev *dev)
 {
 	if (!mt76_poll(dev, MT_UWFDMA0_GLO_CFG,
 		       MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 1000))
@@ -104,7 +104,7 @@ static int mt7921u_dma_rx_evt_ep4(struct mt7921_dev *dev)
 	return 0;
 }
 
-static void mt7921u_epctl_rst_opt(struct mt7921_dev *dev, bool reset)
+static void mt7921u_epctl_rst_opt(struct mt792x_dev *dev, bool reset)
 {
 	u32 val;
 
@@ -121,7 +121,7 @@ static void mt7921u_epctl_rst_opt(struct mt7921_dev *dev, bool reset)
 	mt7921u_uhw_wr(&dev->mt76, MT_SSUSB_EPCTL_CSR_EP_RST_OPT, val);
 }
 
-int mt7921u_dma_init(struct mt7921_dev *dev, bool resume)
+int mt7921u_dma_init(struct mt792x_dev *dev, bool resume)
 {
 	int err;
 
@@ -148,7 +148,7 @@ int mt7921u_dma_init(struct mt7921_dev *dev, bool resume)
 	return 0;
 }
 
-int mt7921u_wfsys_reset(struct mt7921_dev *dev)
+int mt7921u_wfsys_reset(struct mt792x_dev *dev)
 {
 	u32 val;
 	int i;
@@ -180,7 +180,7 @@ int mt7921u_wfsys_reset(struct mt7921_dev *dev)
 	return 0;
 }
 
-int mt7921u_init_reset(struct mt7921_dev *dev)
+int mt7921u_init_reset(struct mt792x_dev *dev)
 {
 	set_bit(MT76_RESET, &dev->mphy.state);
 
@@ -197,7 +197,7 @@ int mt7921u_init_reset(struct mt7921_dev *dev)
 	return mt76u_resume_rx(&dev->mt76);
 }
 
-int mt7921u_mac_reset(struct mt7921_dev *dev)
+int mt7921u_mac_reset(struct mt792x_dev *dev)
 {
 	int err;
 
-- 
2.18.0

