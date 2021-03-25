Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A232E348B23
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Mar 2021 09:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhCYIGa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Mar 2021 04:06:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42742 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229659AbhCYIGP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Mar 2021 04:06:15 -0400
X-UUID: 3155596d0cfd4c89923cccd063cbdb75-20210325
X-UUID: 3155596d0cfd4c89923cccd063cbdb75-20210325
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 345796466; Thu, 25 Mar 2021 16:06:12 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 25 Mar 2021 16:06:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Mar 2021 16:06:08 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/5] mt76: mt7622: trigger hif interrupt for system reset
Date:   Thu, 25 Mar 2021 16:06:03 +0800
Message-ID: <fdf1a87df05dd4edfda3652fbb2ff3a4a14ccc83.1616657048.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20744fae1cbe0dcc098b3112b0a5ccb0b6254587.1616657048.git.ryder.lee@mediatek.com>
References: <20744fae1cbe0dcc098b3112b0a5ccb0b6254587.1616657048.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 83C2051780332E87DCD936F4975CBF7E14F2C82AE2C05767D9379E12B5C73B222000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

hif interrupt needs to be triggered after MT_MCU_INT_EVENT.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c   | 15 ++++++++++++---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mt7615.h    |  2 ++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 17aa3e4d67ca..3d9d893dbac5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2053,6 +2053,15 @@ void mt7615_tx_token_put(struct mt7615_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt7615_tx_token_put);
 
+static void
+mt7615_hif_int_event_trigger(struct mt7615_dev *dev, u8 event)
+{
+	mt76_wr(dev, MT_MCU_INT_EVENT, event);
+
+	mt7622_trigger_hif_int(dev, true);
+	mt7622_trigger_hif_int(dev, false);
+}
+
 void mt7615_mac_reset_work(struct work_struct *work)
 {
 	struct mt7615_phy *phy2;
@@ -2095,7 +2104,7 @@ void mt7615_mac_reset_work(struct work_struct *work)
 
 	mt7615_mutex_acquire(dev);
 
-	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_PDMA_STOPPED);
+	mt7615_hif_int_event_trigger(dev, MT_MCU_INT_EVENT_PDMA_STOPPED);
 
 	mt7615_tx_token_put(dev);
 	idr_init(&dev->token);
@@ -2105,7 +2114,7 @@ void mt7615_mac_reset_work(struct work_struct *work)
 
 		mt76_wr(dev, MT_WPDMA_MEM_RNG_ERR, 0);
 
-		mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_PDMA_INIT);
+		mt7615_hif_int_event_trigger(dev, MT_MCU_INT_EVENT_PDMA_INIT);
 		mt7615_wait_reset_state(dev, MT_MCU_CMD_RECOVERY_DONE);
 	}
 
@@ -2128,7 +2137,7 @@ void mt7615_mac_reset_work(struct work_struct *work)
 	if (ext_phy)
 		ieee80211_wake_queues(ext_phy->hw);
 
-	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
+	mt7615_hif_int_event_trigger(dev, MT_MCU_INT_EVENT_RESET_DONE);
 	mt7615_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
 
 	mt7615_update_beacons(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 4ca0d8d4c536..99c1676c9f0f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -274,7 +274,7 @@ int mt7615_rf_wr(struct mt7615_dev *dev, u32 wf, u32 reg, u32 val)
 				 sizeof(req), false);
 }
 
-static void mt7622_trigger_hif_int(struct mt7615_dev *dev, bool en)
+void mt7622_trigger_hif_int(struct mt7615_dev *dev, bool en)
 {
 	if (!is_mt7622(&dev->mt76))
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 84d06f2b41d4..484fc16f0c11 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -556,6 +556,8 @@ u32 mt7615_mcu_reg_rr(struct mt76_dev *dev, u32 offset);
 void mt7615_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val);
 void mt7615_coredump_work(struct work_struct *work);
 
+void mt7622_trigger_hif_int(struct mt7615_dev *dev, bool en);
+
 /* usb */
 int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 				   enum mt76_txq_id qid, struct mt76_wcid *wcid,
-- 
2.18.0

