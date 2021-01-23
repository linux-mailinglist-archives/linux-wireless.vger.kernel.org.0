Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEAC3013F2
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Jan 2021 09:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbhAWIg3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Jan 2021 03:36:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50154 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726731AbhAWIgT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Jan 2021 03:36:19 -0500
X-UUID: 5629f8e23f4b40cebd19bfd4d088cdea-20210123
X-UUID: 5629f8e23f4b40cebd19bfd4d088cdea-20210123
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 470742246; Sat, 23 Jan 2021 16:35:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 23 Jan 2021 16:35:17 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 23 Jan 2021 16:35:17 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v7 20/22] mt76: mt7921: add coredump support
Date:   Sat, 23 Jan 2021 16:35:11 +0800
Message-ID: <dc7b33e2717a27cbafbe2265df676fb10431c06e.1611389300.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1611389300.git.objelf@gmail.com>
References: <cover.1611389300.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce coredump support to mt7921 driver.

The coredump would be produced when MCU met the fatal error or driver
sent out the specific cmd to force trigger it.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  9 ++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 34 +++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  4 ++
 .../net/wireless/mediatek/mt76/mt7921/Kconfig |  1 +
 .../wireless/mediatek/mt76/mt7921/debugfs.c   | 15 +++++++
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  2 +
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 43 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  5 +++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  1 +
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  4 +-
 10 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index ff244d4758ab..0d58606391b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -11,6 +11,9 @@
 #define MT76_CONNAC_MAX_SCHED_SCAN_SSID		10
 #define MT76_CONNAC_MAX_SCAN_MATCH		16
 
+#define MT76_CONNAC_COREDUMP_TIMEOUT		(HZ / 20)
+#define MT76_CONNAC_COREDUMP_SZ			(128 * 1024)
+
 enum {
 	CMD_CBW_20MHZ = IEEE80211_STA_RX_BW_20,
 	CMD_CBW_40MHZ = IEEE80211_STA_RX_BW_40,
@@ -57,6 +60,12 @@ struct mt76_connac_pm {
 	unsigned long idle_timeout;
 };
 
+struct mt76_connac_coredump {
+	struct sk_buff_head msg_list;
+	struct delayed_work work;
+	unsigned long last_activity;
+};
+
 extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
 
 static inline bool is_mt7921(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 40c10510b32a..6cbccfb05f8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1497,6 +1497,40 @@ int mt76_connac_mcu_sched_scan_enable(struct mt76_phy *phy,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sched_scan_enable);
 
+int mt76_connac_mcu_chip_config(struct mt76_dev *dev)
+{
+	struct {
+		__le16 id;
+		u8 type;
+		u8 resp_type;
+		__le16 data_size;
+		__le16 resv;
+		u8 data[320];
+	} req = {
+		.resp_type = 0,
+	};
+
+	memcpy(req.data, "assert", 7);
+
+	return mt76_mcu_send_msg(dev, MCU_CMD_CHIP_CONFIG, &req, sizeof(req),
+				 false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_chip_config);
+
+void mt76_connac_mcu_coredump_event(struct mt76_dev *dev, struct sk_buff *skb,
+				    struct mt76_connac_coredump *coredump)
+{
+	spin_lock_bh(&dev->lock);
+	__skb_queue_tail(&coredump->msg_list, skb);
+	spin_unlock_bh(&dev->lock);
+
+	coredump->last_activity = jiffies;
+
+	queue_delayed_work(dev->wq, &coredump->work,
+			   MT76_CONNAC_COREDUMP_TIMEOUT);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_coredump_event);
+
 #ifdef CONFIG_PM
 
 const struct wiphy_wowlan_support mt76_connac_wowlan_support = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 60aac6f2d16c..c1e1df5f7cd7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -561,6 +561,7 @@ enum {
 	MCU_CMD_SCHED_SCAN_REQ = MCU_CE_PREFIX | 0x62,
 	MCU_CMD_REG_WRITE = MCU_CE_PREFIX | 0xc0,
 	MCU_CMD_REG_READ = MCU_CE_PREFIX | MCU_QUERY_MASK | 0xc0,
+	MCU_CMD_CHIP_CONFIG = MCU_CE_PREFIX | 0xca,
 	MCU_CMD_FWLOG_2_HOST = MCU_CE_PREFIX | 0xc5,
 	MCU_CMD_GET_WTBL = MCU_CE_PREFIX | 0xcd,
 };
@@ -972,4 +973,7 @@ int mt76_connac_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
 int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend);
 void mt76_connac_mcu_set_suspend_iter(void *priv, u8 *mac,
 				      struct ieee80211_vif *vif);
+int mt76_connac_mcu_chip_config(struct mt76_dev *dev);
+void mt76_connac_mcu_coredump_event(struct mt76_dev *dev, struct sk_buff *skb,
+				    struct mt76_connac_coredump *coredump);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
index 92db70d11c36..001f2b9cec26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
@@ -2,6 +2,7 @@
 config MT7921E
 	tristate "MediaTek MT7921E (PCIe) support"
 	select MT76_CONNAC_LIB
+	select WANT_DEV_COREDUMP
 	depends on MAC80211
 	depends on PCI
 	help
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 390e0e49724d..0dc8e25e18e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -213,6 +213,20 @@ mt7921_pm_idle_timeout_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_pm_idle_timeout, mt7921_pm_idle_timeout_get,
 			 mt7921_pm_idle_timeout_set, "%lld\n");
 
+static int mt7921_config(void *data, u64 val)
+{
+	struct mt7921_dev *dev = data;
+	int ret;
+
+	mt7921_mutex_acquire(dev);
+	ret = mt76_connac_mcu_chip_config(&dev->mt76);
+	mt7921_mutex_release(dev);
+
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_config, NULL, mt7921_config, "%lld\n");
+
 int mt7921_init_debugfs(struct mt7921_dev *dev)
 {
 	struct dentry *dir;
@@ -230,6 +244,7 @@ int mt7921_init_debugfs(struct mt7921_dev *dev)
 	debugfs_create_file("runtime-pm", 0600, dir, dev, &fops_pm);
 	debugfs_create_file("idle-timeout", 0600, dir, dev,
 			    &fops_pm_idle_timeout);
+	debugfs_create_file("chip_config", 0600, dir, dev, &fops_config);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 2a80b68a588a..89a13b4a74a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -226,7 +226,9 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	INIT_LIST_HEAD(&dev->phy.stats_list);
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7921_mac_work);
 	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7921_scan_work);
+	INIT_DELAYED_WORK(&dev->coredump.work, mt7921_coredump_work);
 	skb_queue_head_init(&dev->phy.scan_event_list);
+	skb_queue_head_init(&dev->coredump.msg_list);
 	INIT_LIST_HEAD(&dev->sta_poll_list);
 	spin_lock_init(&dev->sta_poll_lock);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 006cf7fe1bff..3f9097481a5e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1,11 +1,13 @@
 // SPDX-License-Identifier: ISC
 /* Copyright (C) 2020 MediaTek Inc. */
 
+#include <linux/devcoredump.h>
 #include <linux/etherdevice.h>
 #include <linux/timekeeping.h>
 #include "mt7921.h"
 #include "../dma.h"
 #include "mac.h"
+#include "mcu.h"
 
 #define to_rssi(field, rxv)	((FIELD_GET(field, rxv) - 220) / 2)
 
@@ -1471,3 +1473,44 @@ int mt7921_mac_set_beacon_filter(struct mt7921_phy *phy,
 
 	return 0;
 }
+
+void mt7921_coredump_work(struct work_struct *work)
+{
+	struct mt7921_dev *dev;
+	char *dump, *data;
+
+	dev = (struct mt7921_dev *)container_of(work, struct mt7921_dev,
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
+		skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 6ad313fd398e..db125cd22b91 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -513,6 +513,10 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
 	case MCU_EVENT_DBG_MSG:
 		mt7921_mcu_debug_msg_event(dev, skb);
 		break;
+	case MCU_EVENT_COREDUMP:
+		mt76_connac_mcu_coredump_event(&dev->mt76, skb,
+					       &dev->coredump);
+		return;
 	default:
 		break;
 	}
@@ -534,6 +538,7 @@ void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
 	    rxd->eid == MCU_EVENT_BSS_ABSENCE ||
 	    rxd->eid == MCU_EVENT_SCAN_DONE ||
 	    rxd->eid == MCU_EVENT_DBG_MSG ||
+	    rxd->eid == MCU_EVENT_COREDUMP ||
 	    !rxd->seq)
 		mt7921_mcu_rx_unsolicited_event(dev, skb);
 	else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 52f9e5102727..2fdc62367b3f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -85,6 +85,7 @@ enum {
 	MCU_EVENT_CH_PRIVILEGE = 0x18,
 	MCU_EVENT_SCHED_SCAN_DONE = 0x23,
 	MCU_EVENT_DBG_MSG = 0x27,
+	MCU_EVENT_COREDUMP = 0xf0,
 };
 
 /* ext event table */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index c0f26eaa269e..46e6aeec35ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -6,7 +6,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/ktime.h>
-#include "../mt76_connac.h"
+#include "../mt76_connac_mcu.h"
 #include "regs.h"
 
 #define MT7921_MAX_INTERFACES		4
@@ -164,6 +164,7 @@ struct mt7921_dev {
 	u8 fw_debug;
 
 	struct mt76_connac_pm pm;
+	struct mt76_connac_coredump coredump;
 };
 
 enum {
@@ -337,4 +338,5 @@ int mt7921_mac_set_beacon_filter(struct mt7921_phy *phy,
 				 struct ieee80211_vif *vif,
 				 bool enable);
 void mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif);
+void mt7921_coredump_work(struct work_struct *work);
 #endif
-- 
2.25.1

