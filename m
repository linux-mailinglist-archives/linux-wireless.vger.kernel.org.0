Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF3F30645B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 20:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344482AbhA0Tks (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jan 2021 14:40:48 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:43364 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1344545AbhA0TgD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jan 2021 14:36:03 -0500
X-UUID: 1de4e96ff8ed4134b560e5dcd1adb9f5-20210128
X-UUID: 1de4e96ff8ed4134b560e5dcd1adb9f5-20210128
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 109639921; Thu, 28 Jan 2021 03:34:03 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Jan 2021 03:34:02 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Jan 2021 03:34:02 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Ryder.Lee@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v8 20/20] mt76: mt7663: introduce coredump support
Date:   Thu, 28 Jan 2021 03:33:57 +0800
Message-ID: <5063091713e76355ec0dd5bfd00079350e190f7f.1611774181.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1611774181.git.objelf@gmail.com>
References: <cover.1611774181.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Similar to mt7921 devices, introduce coredump support for mt7663 chipset

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/Kconfig |  1 +
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 17 ++++++++
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  2 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 43 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  5 +++
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  4 +-
 7 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
index 5418bc96ee3b..30fba36ff46b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
@@ -2,6 +2,7 @@
 
 config MT7615_COMMON
 	tristate
+	select WANT_DEV_COREDUMP
 	select MT76_CONNAC_LIB
 
 config MT7615E
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 4d5e3f8b2a62..7ae48b4fa564 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -21,6 +21,20 @@ mt7615_radar_pattern_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_radar_pattern, NULL,
 			 mt7615_radar_pattern_set, "%lld\n");
 
+static int mt7615_config(void *data, u64 val)
+{
+	struct mt7615_dev *dev = data;
+	int ret;
+
+	mt7615_mutex_acquire(dev);
+	ret = mt76_connac_mcu_chip_config(&dev->mt76);
+	mt7615_mutex_release(dev);
+
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_config, NULL, mt7615_config, "%lld\n");
+
 static int
 mt7615_scs_set(void *data, u64 val)
 {
@@ -525,6 +539,9 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 	debugfs_create_u32("rf_regidx", 0600, dir, &dev->debugfs_rf_reg);
 	debugfs_create_file_unsafe("rf_regval", 0600, dir, dev,
 				   &fops_rf_reg);
+	if (is_mt7663(&dev->mt76))
+		debugfs_create_file("chip_config", 0600, dir, dev,
+				    &fops_config);
 	if (mt76_is_sdio(&dev->mt76))
 		debugfs_create_devm_seqfile(dev->mt76.dev, "sched-quota", dir,
 					    mt7663s_sched_quota_read);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index b994da51b48d..a10ba2377240 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -488,7 +488,9 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	set_bit(MT76_STATE_PM, &dev->mphy.state);
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7615_mac_work);
 	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7615_scan_work);
+	INIT_DELAYED_WORK(&dev->coredump.work, mt7615_coredump_work);
 	skb_queue_head_init(&dev->phy.scan_event_list);
+	skb_queue_head_init(&dev->coredump.msg_list);
 	INIT_LIST_HEAD(&dev->sta_poll_list);
 	spin_lock_init(&dev->sta_poll_lock);
 	init_waitqueue_head(&dev->reset_wait);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 6a3e1a609852..59fdd0fc2ad4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -7,6 +7,7 @@
  *         Lorenzo Bianconi <lorenzo@kernel.org>
  */
 
+#include <linux/devcoredump.h>
 #include <linux/etherdevice.h>
 #include <linux/timekeeping.h>
 #include "mt7615.h"
@@ -14,6 +15,7 @@
 #include "../dma.h"
 #include "mt7615_trace.h"
 #include "mac.h"
+#include "mcu.h"
 
 #define to_rssi(field, rxv)		((FIELD_GET(field, rxv) - 220) / 2)
 
@@ -2272,3 +2274,44 @@ int mt7615_mac_set_beacon_filter(struct mt7615_phy *phy,
 
 	return 0;
 }
+
+void mt7615_coredump_work(struct work_struct *work)
+{
+	struct mt7615_dev *dev;
+	char *dump, *data;
+
+	dev = (struct mt7615_dev *)container_of(work, struct mt7615_dev,
+						coredump.work.work);
+
+	if (time_is_after_jiffies(dev->coredump.last_activity +
+				  4 * MT76_CONNAC_COREDUMP_TIMEOUT)) {
+		queue_delayed_work(dev->mt76.wq, &dev->coredump.work,
+				   MT76_CONNAC_COREDUMP_TIMEOUT);
+		return;
+	}
+
+	dump = vzalloc(MT76_CONNAC_COREDUMP_SZ);
+	data = dump;
+
+	while (true) {
+		struct sk_buff *skb;
+
+		spin_lock_bh(&dev->mt76.lock);
+		skb = __skb_dequeue(&dev->coredump.msg_list);
+		spin_unlock_bh(&dev->mt76.lock);
+
+		if (!skb)
+			break;
+
+		skb_pull(skb, sizeof(struct mt7615_mcu_rxd));
+		if (data + skb->len - dump > MT76_CONNAC_COREDUMP_SZ)
+			break;
+
+		memcpy(data, skb->data, skb->len);
+		data += skb->len;
+
+		dev_kfree_skb(skb);
+	}
+	dev_coredumpv(dev->mt76.dev, dump, MT76_CONNAC_COREDUMP_SZ,
+		      GFP_KERNEL);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index af2979c294e0..b418316a8446 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -543,6 +543,10 @@ mt7615_mcu_rx_unsolicited_event(struct mt7615_dev *dev, struct sk_buff *skb)
 	case MCU_EVENT_BSS_ABSENCE:
 		mt7615_mcu_bss_event(dev, skb);
 		break;
+	case MCU_EVENT_COREDUMP:
+		mt76_connac_mcu_coredump_event(&dev->mt76, skb,
+					       &dev->coredump);
+		return;
 	default:
 		break;
 	}
@@ -561,6 +565,7 @@ void mt7615_mcu_rx_event(struct mt7615_dev *dev, struct sk_buff *skb)
 	    rxd->eid == MCU_EVENT_SCHED_SCAN_DONE ||
 	    rxd->eid == MCU_EVENT_BSS_ABSENCE ||
 	    rxd->eid == MCU_EVENT_SCAN_DONE ||
+	    rxd->eid == MCU_EVENT_COREDUMP ||
 	    rxd->eid == MCU_EVENT_ROC ||
 	    !rxd->seq)
 		mt7615_mcu_rx_unsolicited_event(dev, skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 446c6abf44d8..3874f45da9eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -92,6 +92,7 @@ enum {
 	MCU_EVENT_SCHED_SCAN_DONE = 0x23,
 	MCU_EVENT_EXT = 0xed,
 	MCU_EVENT_RESTART_DL = 0xef,
+	MCU_EVENT_COREDUMP = 0xf0,
 };
 
 /* ext event table */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 1bd79dae0171..491841bc6291 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -8,7 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/ktime.h>
 #include <linux/regmap.h>
-#include "../mt76_connac.h"
+#include "../mt76_connac_mcu.h"
 #include "regs.h"
 
 #define MT7615_MAX_INTERFACES		16
@@ -277,6 +277,7 @@ struct mt7615_dev {
 	u32 muar_mask;
 
 	struct mt76_connac_pm pm;
+	struct mt76_connac_coredump coredump;
 };
 
 enum tx_pkt_queue_idx {
@@ -554,6 +555,7 @@ int mt7615_mcu_update_arp_filter(struct ieee80211_hw *hw,
 int __mt7663_load_firmware(struct mt7615_dev *dev);
 u32 mt7615_mcu_reg_rr(struct mt76_dev *dev, u32 offset);
 void mt7615_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val);
+void mt7615_coredump_work(struct work_struct *work);
 
 /* usb */
 int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
-- 
2.25.1

