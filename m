Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CCE6320D8
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 12:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiKULjt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 06:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiKULj1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 06:39:27 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AB213F0E
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 03:37:52 -0800 (PST)
X-UUID: 74e4dcdb603548b68d48c76fa88c1437-20221121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Jj0xKO78J994+Xb/7+4NEwIzjmVOKi8XbGyIIc9e5a8=;
        b=YgDMwJ4XV+Yh7YExJxmoLgCAC/MQ4HYa5PQ17zqJgFsJt+SLs41KRqNXuC+0CYWphohDPV4Vi8Hc3OmhCew8/hHt3kMbZrK96WLOg4DG8+c8mm5RCuejdnVVmxAV74COqYgeCWmJFspnnCPwYD+I8NZBFsV/1xrAB774DZTqavE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:344ff1d6-7e5d-4e8e-9933-6c304fd5c6dd,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:be42612f-2938-482e-aafd-98d66723b8a9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 74e4dcdb603548b68d48c76fa88c1437-20221121
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <sujuan.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1254681796; Mon, 21 Nov 2022 19:37:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 21 Nov 2022 19:37:46 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 21 Nov 2022 19:37:45 +0800
From:   Sujuan Chen <sujuan.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7915: add wds support when wed is enabled
Date:   Mon, 21 Nov 2022 19:37:43 +0800
Message-ID: <af04db938bf9633225c4358058a39aa3be0e218e.1669022945.git.sujuan.chen@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The current WED only supports 256 wcid, whereas mt7986 can support up to 512 entries,
so firmware provides a rule to get sta_info by DA when wcid is set to 0x3ff by txd.
Also, WED provides a register to overwrite txd wcid, that is, wcid[9:8] can
be overwritten by 0x3 and wcid[7:0] is set to 0xff by host driver.

However, firmware is unable to get sta_info from DA as DA != RA for 4addr cases,
so firmware and wifi host driver both use wcid (256 - 271) and (768 ~ 783)
for sync up to get correct sta_info

Tested-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
This patch is based on 
https://patchwork.kernel.org/project/linux-mediatek/list/?series=697444
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  6 +++
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  2 +-
 .../wireless/mediatek/mt76/mt7615/pci_init.c  |  2 +-
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 24 +++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 11 ++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  3 ++
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/util.c     | 42 ++++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/util.h     |  2 +-
 17 files changed, 91 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 33f87e518d68..1763b582c020 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -38,6 +38,12 @@
 #define MT_WED_Q_RX(_n)		__MT_WED_Q(MT76_WED_Q_RX, _n)
 #define MT_WED_Q_TXFREE		__MT_WED_Q(MT76_WED_Q_TXFREE, 0)
 
+enum mt76_wed_state {
+	MT76_WED_DISABLED,
+	MT76_WED_ACTIVE,
+	MT76_WED_WDS_ACTIVE,
+};
+
 struct mt76_dev;
 struct mt76_phy;
 struct mt76_wcid;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index ca50feb0b3a9..d788bb59a113 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -347,7 +347,7 @@ mt7603_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	int idx;
 	int ret = 0;
 
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7603_WTBL_STA - 1);
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7603_WTBL_STA - 1, 0);
 	if (idx < 0)
 		return -ENOSPC;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index ab4c1b4478aa..5e2901a21e4c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -625,7 +625,7 @@ int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7615_phy *phy;
 	int idx, err;
 
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7615_WTBL_STA - 1);
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7615_WTBL_STA - 1, 0);
 	if (idx < 0)
 		return -ENOSPC;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index 87b4aa52ee0f..8e0ef9ce5b68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -55,7 +55,7 @@ static int mt7615_init_hardware(struct mt7615_dev *dev)
 	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
 	/* Beacon and mgmt frames should occupy wcid 0 */
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7615_WTBL_STA - 1);
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7615_WTBL_STA - 1, 0);
 	if (idx)
 		return -ENOSPC;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index 0052d103e276..9dcd1f6970b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -292,7 +292,7 @@ static int mt7663_usb_sdio_init_hardware(struct mt7615_dev *dev)
 	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
 	/* Beacon and mgmt frames should occupy wcid 0 */
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7615_WTBL_STA - 1);
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7615_WTBL_STA - 1, 0);
 	if (idx)
 		return -ENOSPC;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 604ddcc21123..253c8ce32f8f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -246,7 +246,7 @@ int mt76x02_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	memset(msta, 0, sizeof(*msta));
 
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT76x02_N_WCIDS);
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT76x02_N_WCIDS, 0);
 	if (idx < 0)
 		return -ENOSPC;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index b48c2ba9273d..e5c85f422621 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -710,7 +710,7 @@ mt7915_init_hardware(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 	}
 
 	/* Beacon and mgmt frames should occupy wcid 0 */
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA);
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA, 0);
 	if (idx)
 		return -ENOSPC;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 90c5d8fe4f73..3cab2f73ce23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -662,8 +662,15 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	bool ext_phy = mvif->phy != &dev->phy;
 	int ret, idx;
+	u8 flag = MT76_WED_DISABLED;
 
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA);
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+	    !is_mt7915(&dev->mt76)) {
+		flag = test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags) ?
+		       MT76_WED_WDS_ACTIVE : MT76_WED_ACTIVE;
+	}
+
+	idx = mt76_wcid_alloc(mdev->wcid_mask, MT7915_WTBL_STA, flag);
 	if (idx < 0)
 		return -ENOSPC;
 
@@ -1117,6 +1124,13 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
 	else
 		clear_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
 
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+	    !is_mt7915(&dev->mt76)) {
+		mt7915_sta_remove(hw, vif, sta);
+		mt76_sta_pre_rcu_remove(hw, vif, sta);
+		mt7915_sta_add(hw, vif, sta);
+	}
+
 	mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
 }
 
@@ -1448,15 +1462,19 @@ mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
 	if (!mtk_wed_device_active(wed))
 		return -ENODEV;
 
-	if (msta->wcid.idx > 0xff)
+	if (msta->wcid.idx > MT7915_WTBL_STA)
 		return -EIO;
 
 	path->type = DEV_PATH_MTK_WDMA;
 	path->dev = ctx->dev;
 	path->mtk_wdma.wdma_idx = wed->wdma_idx;
 	path->mtk_wdma.bss = mvif->mt76.idx;
-	path->mtk_wdma.wcid = is_mt7915(&dev->mt76) ? msta->wcid.idx : 0x3ff;
 	path->mtk_wdma.queue = phy != &dev->phy;
+	if (test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags) ||
+	    is_mt7915(&dev->mt76))
+		path->mtk_wdma.wcid = msta->wcid.idx;
+	else
+		path->mtk_wdma.wcid = 0x3ff;
 
 	ctx->dev = NULL;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 2769d6c897d9..aeeeff9b2143 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2303,8 +2303,15 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	if (mtk_wed_device_active(&dev->mt76.mmio.wed) && is_mt7915(&dev->mt76))
-		mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY), 0, 0, 0);
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
+		if (is_mt7915(&dev->mt76))
+			mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY),
+					  0, 0, 0);
+		else
+			mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
+					  MCU_WA_PARAM_WED_VERSION,
+					  dev->mt76.mmio.wed.rev_id, 0);
+	}
 
 	ret = mt7915_mcu_set_mwds(dev, 1);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index c19b5d66c0e1..59e1ea35f77f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -260,6 +260,7 @@ enum {
 	MCU_WA_PARAM_PDMA_RX = 0x04,
 	MCU_WA_PARAM_CPU_UTIL = 0x0b,
 	MCU_WA_PARAM_RED = 0x0e,
+	MCU_WA_PARAM_WED_VERSION = 0x32,
 };
 
 enum mcu_mmps_mode {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 1fcf34f57a16..d90793d082b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -773,6 +773,9 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 
 	dev->mt76.rx_token_size = wed->wlan.rx_npkt;
 
+	if (!is_mt7915(&dev->mt76))
+		wed->wlan.wcid_512 = true;
+
 	if (mtk_wed_device_attach(wed))
 		return 0;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 79b8055ce4c4..702ff300f8f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -283,7 +283,7 @@ static int mt7921_init_wcid(struct mt7921_dev *dev)
 	int idx;
 
 	/* Beacon and mgmt frames should occupy wcid 0 */
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1, 0);
 	if (idx)
 		return -ENOSPC;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 41df17efdb3a..3d8771fcb847 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -814,7 +814,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
 	int ret, idx;
 
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1, 0);
 	if (idx < 0)
 		return -ENOSPC;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index cd1657e3585d..4cf055040519 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -433,7 +433,7 @@ static int mt7996_init_hardware(struct mt7996_dev *dev)
 		return ret;
 
 	/* Beacon and mgmt frames should occupy wcid 0 */
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA);
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA, 0);
 	if (idx)
 		return -ENOSPC;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 21dea3fa7dc1..fd40b515cc5b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -579,7 +579,7 @@ int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	u8 band_idx = mvif->phy->mt76->band_idx;
 	int ret, idx;
 
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA);
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA, 0);
 	if (idx < 0)
 		return -ENOSPC;
 
diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index 581964425468..0850149f4200 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -42,9 +42,14 @@ bool __mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 }
 EXPORT_SYMBOL_GPL(__mt76_poll_msec);
 
-int mt76_wcid_alloc(u32 *mask, int size)
+int mt76_wcid_alloc(u32 *mask, int size, u8 flag)
 {
+#define MT76_WED_WDS_MIN    256
+#define MT76_WED_WDS_CNT    16
+
 	int i, idx = 0, cur;
+	int min = MT76_WED_WDS_MIN;
+	int max = min + MT76_WED_WDS_CNT;
 
 	for (i = 0; i < DIV_ROUND_UP(size, 32); i++) {
 		idx = ffs(~mask[i]);
@@ -53,13 +58,46 @@ int mt76_wcid_alloc(u32 *mask, int size)
 
 		idx--;
 		cur = i * 32 + idx;
-		if (cur >= size)
+
+		switch (flag) {
+		case MT76_WED_DISABLED:
+			if (cur >= size)
+				goto error;
+
 			break;
+		case MT76_WED_ACTIVE:
+			if (cur >= min && cur < max)
+				continue;
+
+			if (cur >= size) {
+				u32 end = MT76_WED_WDS_CNT - 1;
+
+				i = min / 32;
+				idx = ffs(~mask[i] & GENMASK(end, 0));
+				if (!idx)
+					goto error;
+				idx--;
+				cur = min + idx;
+			}
+
+			break;
+		case MT76_WED_WDS_ACTIVE:
+			if (cur < min)
+				continue;
+			if (cur >= max)
+				goto error;
+
+			break;
+		default:
+			WARN_ON(1);
+			break;
+		}
 
 		mask[i] |= BIT(idx);
 		return cur;
 	}
 
+error:
 	return -1;
 }
 EXPORT_SYMBOL_GPL(mt76_wcid_alloc);
diff --git a/drivers/net/wireless/mediatek/mt76/util.h b/drivers/net/wireless/mediatek/mt76/util.h
index 260965dde94c..c72460e78389 100644
--- a/drivers/net/wireless/mediatek/mt76/util.h
+++ b/drivers/net/wireless/mediatek/mt76/util.h
@@ -27,7 +27,7 @@ enum {
 #define MT76_INCR(_var, _size) \
 	(_var = (((_var) + 1) % (_size)))
 
-int mt76_wcid_alloc(u32 *mask, int size);
+int mt76_wcid_alloc(u32 *mask, int size, u8 flag);
 
 static inline void
 mt76_wcid_mask_set(u32 *mask, int idx)
-- 
2.18.0

