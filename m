Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C0A354B44
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Apr 2021 05:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243532AbhDFDez (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Apr 2021 23:34:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48682 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239413AbhDFDey (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Apr 2021 23:34:54 -0400
X-UUID: cfa7a33e6f744afba678dac0cf8a8b9f-20210406
X-UUID: cfa7a33e6f744afba678dac0cf8a8b9f-20210406
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 742298244; Tue, 06 Apr 2021 11:34:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 6 Apr 2021 11:34:41 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Apr 2021 11:34:41 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 4/6] mt76: mt7921: fix the insmod hangs
Date:   Tue, 6 Apr 2021 11:34:37 +0800
Message-ID: <7d78e01bfbdaa0041c6c88a6fc190989a20b1ec3.1617679693.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <4c5666ad0683e467f11ca4a4abb5be335be25696.1617679693.git.objelf@gmail.com>
References: <4c5666ad0683e467f11ca4a4abb5be335be25696.1617679693.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7D29E990F5B94B61EFA1C5145FB1283C5C91741CFE307F9DBDDF2401A3B0881A2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Fix the second insert module causing the device hangs after remove module.

Fixes: 1c099ab44727 ("mt76: mt7921: add MCU support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |  2 --
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |  3 +--
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    | 13 +------------
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |  1 +
 4 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 262c9d150bf0..9046bbfc0690 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -273,8 +273,6 @@ void mt7921_unregister_device(struct mt7921_dev *dev)
 {
 	mt76_unregister_device(&dev->mt76);
 	mt7921_mcu_exit(dev);
-	mt7921_dma_cleanup(dev);
-
 	mt7921_tx_token_put(dev);
 
 	tasklet_disable(&dev->irq_tasklet);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 6f13eef96078..94f178e28e20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1207,8 +1207,7 @@ void mt7921_update_channel(struct mt76_dev *mdev)
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 }
 
-static int
-mt7921_wfsys_reset(struct mt7921_dev *dev)
+int mt7921_wfsys_reset(struct mt7921_dev *dev)
 {
 	mt76_set(dev, 0x70002600, BIT(0));
 	msleep(200);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 353877f1c762..b233b12860ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -960,18 +960,7 @@ int mt7921_mcu_init(struct mt7921_dev *dev)
 
 void mt7921_mcu_exit(struct mt7921_dev *dev)
 {
-	u32 reg = mt7921_reg_map_l1(dev, MT_TOP_MISC);
-
-	__mt76_mcu_restart(&dev->mt76);
-	if (!mt76_poll_msec(dev, reg, MT_TOP_MISC_FW_STATE,
-			    FIELD_PREP(MT_TOP_MISC_FW_STATE,
-				       FW_STATE_FW_DOWNLOAD), 1000)) {
-		dev_err(dev->mt76.dev, "Failed to exit mcu\n");
-		return;
-	}
-
-	reg = mt7921_reg_map_l1(dev, MT_TOP_LPCR_HOST_BAND0);
-	mt76_wr(dev, reg, MT_TOP_LPCR_HOST_FW_OWN);
+	mt7921_wfsys_reset(dev);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index ebe51017dd55..e4211b049040 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -351,4 +351,5 @@ void mt7921_coredump_work(struct work_struct *work);
 int mt7921_mcu_update_arp_filter(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_bss_conf *info);
+int mt7921_wfsys_reset(struct mt7921_dev *dev);
 #endif
-- 
2.25.1

