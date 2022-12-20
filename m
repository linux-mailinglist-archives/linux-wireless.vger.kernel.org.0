Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AF9651AC3
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 07:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiLTGde (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 01:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiLTGd2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 01:33:28 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0012211C00
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 22:33:21 -0800 (PST)
X-UUID: 833ed0cc1c4b49a4a962d2e80d0191cd-20221220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=It9IlKV735nyPfQ96QZYC5opSvNo7kFtMMUrmilTyiw=;
        b=u+sCogf/Lxrd1NvXgFNxiaRh3oQ9DD1WtOOVFiKWYRkUSO6fitnjXqpj1hdUTTIB4LAgi/kvxcx9Jt7ioMHUyAo4h9kxZH7szYQKmdi3TKgR7e83gGnChTINifzuAhgwjhy69/z3aCEGYGRBjaojdnYIq23bCM+cGzk4RmCnoaI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:576925f4-2357-4c78-80cf-88d8ad2022ee,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:576925f4-2357-4c78-80cf-88d8ad2022ee,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:a0354152-dd49-462e-a4be-2143a3ddc739,B
        ulkID:221220143319MOJL2O2D,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 833ed0cc1c4b49a4a962d2e80d0191cd-20221220
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <sujuan.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 796686873; Tue, 20 Dec 2022 14:33:18 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 20 Dec 2022 14:33:17 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 20 Dec 2022 14:33:16 +0800
From:   Sujuan Chen <sujuan.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Subject: [PATCH,v3] wifi: mt76: mt7915: add wds support when wed is enabled
Date:   Tue, 20 Dec 2022 14:27:54 +0800
Message-ID: <6f80d1b49a97d2a08f6ec45f335a1fc8de21ebb9.1671454422.git.sujuan.chen@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
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
v2: 
 - drop duplicate setting in mmio
 - reduce the patch size by redefining mt76_wcid_alloc
v3:
 - rework wds wcid getting flow
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  9 +++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 32 ++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 13 ++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 drivers/net/wireless/mediatek/mt76/util.c     | 37 +++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/util.h     |  7 +++-
 6 files changed, 90 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 1037d23bc4d0..24d7d59d6ca7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -27,6 +27,9 @@
 
 #define MT76_TOKEN_FREE_THR	64
 
+#define MT76_WED_WDS_MIN    256
+#define MT76_WED_WDS_MAX    272
+
 #define MT_QFLAG_WED_RING	GENMASK(1, 0)
 #define MT_QFLAG_WED_TYPE	GENMASK(3, 2)
 #define MT_QFLAG_WED		BIT(4)
@@ -60,6 +63,12 @@ enum mt76_wed_type {
 	MT76_WED_Q_RX,
 };
 
+enum mt76_wed_state {
+	MT76_WED_DEFAULT,
+	MT76_WED_ACTIVE,
+	MT76_WED_WDS_ACTIVE,
+};
+
 struct mt76_bus_ops {
 	u32 (*rr)(struct mt76_dev *dev, u32 offset);
 	void (*wr)(struct mt76_dev *dev, u32 offset, u32 val);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 0511d6a505b0..ce95cfa1300d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -664,8 +664,15 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	bool ext_phy = mvif->phy != &dev->phy;
 	int ret, idx;
+	u8 flags = MT76_WED_DEFAULT;
 
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA);
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+	    !is_mt7915(&dev->mt76)) {
+		flags = test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags) ?
+		       MT76_WED_WDS_ACTIVE : MT76_WED_ACTIVE;
+	}
+
+	idx = __mt76_wcid_alloc(mdev->wcid_mask, MT7915_WTBL_STA, flags);
 	if (idx < 0)
 		return -ENOSPC;
 
@@ -1115,12 +1122,27 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	int min = MT76_WED_WDS_MIN, max = MT76_WED_WDS_MAX;
 
 	if (enabled)
 		set_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
 	else
 		clear_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
 
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+	    !is_mt7915(&dev->mt76) &&
+	    (msta->wcid.idx < min || msta->wcid.idx > max - 1)) {
+		struct ieee80211_sta *pre_sta;
+
+		pre_sta = kzalloc(sizeof(*sta) + sizeof(*msta), GFP_KERNEL);
+		mt76_sta_pre_rcu_remove(hw, vif, sta);
+		memmove(pre_sta, sta, sizeof(*sta) + sizeof(*msta));
+		mt7915_sta_add(hw, vif, sta);
+		synchronize_rcu();
+		mt7915_sta_remove(hw, vif, pre_sta);
+		kfree(pre_sta);
+	}
+
 	mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
 }
 
@@ -1485,15 +1507,19 @@ mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
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
index 37a3c1f082d9..c566ea0f5022 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2323,8 +2323,17 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	if (mtk_wed_device_active(&dev->mt76.mmio.wed) && is_mt7915(&dev->mt76))
-		mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY), 0, 0, 0);
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
+		if (is_mt7915(&dev->mt76))
+			ret = mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY),
+						0, 0, 0);
+		else
+			ret = mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
+						MCU_WA_PARAM_WED_VERSION,
+						dev->mt76.mmio.wed.rev_id, 0);
+		if (ret)
+			return ret;
+	}
 
 	ret = mt7915_mcu_set_mwds(dev, 1);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 29b5434bfdb8..f96cdf1cc626 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -278,6 +278,7 @@ enum {
 	MCU_WA_PARAM_PDMA_RX = 0x04,
 	MCU_WA_PARAM_CPU_UTIL = 0x0b,
 	MCU_WA_PARAM_RED = 0x0e,
+	MCU_WA_PARAM_WED_VERSION = 0x32,
 };
 
 enum mcu_mmps_mode {
diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index 581964425468..0112f1bd7219 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -42,9 +42,11 @@ bool __mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 }
 EXPORT_SYMBOL_GPL(__mt76_poll_msec);
 
-int mt76_wcid_alloc(u32 *mask, int size)
+int __mt76_wcid_alloc(u32 *mask, int size, u8 flag)
 {
 	int i, idx = 0, cur;
+	int min = MT76_WED_WDS_MIN;
+	int max = MT76_WED_WDS_MAX;
 
 	for (i = 0; i < DIV_ROUND_UP(size, 32); i++) {
 		idx = ffs(~mask[i]);
@@ -53,16 +55,45 @@ int mt76_wcid_alloc(u32 *mask, int size)
 
 		idx--;
 		cur = i * 32 + idx;
-		if (cur >= size)
+
+		switch (flag) {
+		case MT76_WED_ACTIVE:
+			if (cur >= min && cur < max)
+				continue;
+
+			if (cur >= size) {
+				u32 end = max - min - 1;
+
+				i = min / 32;
+				idx = ffs(~mask[i] & GENMASK(end, 0));
+				if (!idx)
+					goto error;
+				idx--;
+				cur = min + idx;
+			}
+
 			break;
+		case MT76_WED_WDS_ACTIVE:
+			if (cur < min)
+				continue;
+			if (cur >= max)
+				goto error;
+
+			break;
+		default:
+			if (cur >= size)
+				goto error;
+			break;
+		}
 
 		mask[i] |= BIT(idx);
 		return cur;
 	}
 
+error:
 	return -1;
 }
-EXPORT_SYMBOL_GPL(mt76_wcid_alloc);
+EXPORT_SYMBOL_GPL(__mt76_wcid_alloc);
 
 int mt76_get_min_avg_rssi(struct mt76_dev *dev, bool ext_phy)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/util.h b/drivers/net/wireless/mediatek/mt76/util.h
index 260965dde94c..99b7263c0a20 100644
--- a/drivers/net/wireless/mediatek/mt76/util.h
+++ b/drivers/net/wireless/mediatek/mt76/util.h
@@ -27,7 +27,12 @@ enum {
 #define MT76_INCR(_var, _size) \
 	(_var = (((_var) + 1) % (_size)))
 
-int mt76_wcid_alloc(u32 *mask, int size);
+int __mt76_wcid_alloc(u32 *mask, int size, u8 flags);
+
+static inline int mt76_wcid_alloc(u32 *mask, int size)
+{
+	return __mt76_wcid_alloc(mask, size, 0);
+}
 
 static inline void
 mt76_wcid_mask_set(u32 *mask, int idx)
-- 
2.18.0

