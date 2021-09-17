Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E64101EF
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Sep 2021 02:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbhIRABb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 20:01:31 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:53665 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241169AbhIRABa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 20:01:30 -0400
X-UUID: 89d4021512fd46048e52abcc76097976-20210917
X-UUID: 89d4021512fd46048e52abcc76097976-20210917
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1502780333; Fri, 17 Sep 2021 17:00:05 -0700
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Sep 2021 17:00:00 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 18 Sep 2021 08:00:00 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 05/16] mt76: mt7921: add MT7921_COMMON module
Date:   Sat, 18 Sep 2021 07:59:21 +0800
Message-ID: <23bf9455d505c19fc484de533098b98b08804935.1631918993.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1631918993.git.objelf@gmail.com>
References: <cover.1631918993.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This is a preliminary patch to introduce mt7921s support.

MT7921_COMMON module grouping bus independent objects the both mt7921e and
mt7921s can share with and have to rely on.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/Kconfig  | 8 ++++++--
 drivers/net/wireless/mediatek/mt76/mt7921/Makefile | 7 ++++---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   | 7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    | 9 +++++++++
 6 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
index 001f2b9cec26..071746809b1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
@@ -1,8 +1,12 @@
 # SPDX-License-Identifier: ISC
-config MT7921E
-	tristate "MediaTek MT7921E (PCIe) support"
+config MT7921_COMMON
+	tristate
 	select MT76_CONNAC_LIB
 	select WANT_DEV_COREDUMP
+
+config MT7921E
+	tristate "MediaTek MT7921E (PCIe) support"
+	select MT7921_COMMON
 	depends on MAC80211
 	depends on PCI
 	help
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index 4cb0b000cfe1..8cea896d5965 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -1,9 +1,10 @@
 # SPDX-License-Identifier: ISC
 
+obj-$(CONFIG_MT7921_COMMON) += mt7921-common.o
 obj-$(CONFIG_MT7921E) += mt7921e.o
 
 CFLAGS_trace.o := -I$(src)
 
-mt7921e-y := pci.o pci_mac.o pci_mcu.o mac.o mcu.o dma.o eeprom.o main.o \
-	     init.o debugfs.o trace.o
-mt7921e-$(CONFIG_NL80211_TESTMODE) += testmode.o
+mt7921-common-y := mac.o mcu.o eeprom.o main.o init.o debugfs.o trace.o
+mt7921-common-$(CONFIG_NL80211_TESTMODE) += testmode.o
+mt7921e-y := pci.o pci_mac.o pci_mcu.o dma.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index f0fd32c424c6..d310d6e1e566 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -145,6 +145,7 @@ int mt7921_mac_init(struct mt7921_dev *dev)
 
 	return mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b, 0);
 }
+EXPORT_SYMBOL_GPL(mt7921_mac_init);
 
 static int __mt7921_init_hardware(struct mt7921_dev *dev)
 {
@@ -285,3 +286,4 @@ int mt7921_register_device(struct mt7921_dev *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt7921_register_device);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 24f24a2d8395..5812b518a571 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -39,6 +39,7 @@ static struct mt76_wcid *mt7921_rx_get_wcid(struct mt7921_dev *dev,
 void mt7921_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps)
 {
 }
+EXPORT_SYMBOL_GPL(mt7921_sta_ps);
 
 bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask)
 {
@@ -169,6 +170,7 @@ void mt7921_mac_sta_poll(struct mt7921_dev *dev)
 
 	rcu_read_unlock();
 }
+EXPORT_SYMBOL_GPL(mt7921_mac_sta_poll);
 
 static void
 mt7921_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
@@ -920,6 +922,7 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
 	}
 }
+EXPORT_SYMBOL_GPL(mt7921_mac_write_txwi);
 
 void mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 {
@@ -944,6 +947,7 @@ void mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 	if (!test_and_set_bit(tid, &msta->ampdu_state))
 		ieee80211_start_tx_ba_session(sta, tid, 0);
 }
+EXPORT_SYMBOL_GPL(mt7921_tx_check_aggr);
 
 static bool
 mt7921_mac_add_txs_skb(struct mt7921_dev *dev, struct mt76_wcid *wcid, int pid,
@@ -1132,6 +1136,7 @@ void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		break;
 	}
 }
+EXPORT_SYMBOL_GPL(mt7921_queue_rx_skb);
 
 void mt7921_mac_reset_counters(struct mt7921_phy *phy)
 {
@@ -1247,6 +1252,7 @@ void mt7921_update_channel(struct mt76_phy *mphy)
 
 	mt76_connac_power_save_sched(mphy, &dev->pm);
 }
+EXPORT_SYMBOL_GPL(mt7921_update_channel);
 
 static void
 mt7921_vif_connect_iter(void *priv, u8 *mac,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index c51266e40cb4..cbffa8478329 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -237,6 +237,7 @@ int __mt7921_start(struct mt7921_phy *phy)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__mt7921_start);
 
 static int mt7921_start(struct ieee80211_hw *hw)
 {
@@ -646,6 +647,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt7921_mac_sta_add);
 
 void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			  struct ieee80211_sta *sta)
@@ -667,6 +669,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	mt7921_mutex_release(dev);
 }
+EXPORT_SYMBOL_GPL(mt7921_mac_sta_assoc);
 
 void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta)
@@ -698,6 +701,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 }
+EXPORT_SYMBOL_GPL(mt7921_mac_sta_remove);
 
 void mt7921_tx_worker(struct mt76_worker *w)
 {
@@ -1250,3 +1254,6 @@ const struct ieee80211_ops mt7921_ops = {
 	.flush = mt7921_flush,
 	.set_sar_specs = mt7921_set_sar_specs,
 };
+EXPORT_SYMBOL_GPL(mt7921_ops);
+
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 5553221b7f5c..866b8797f16e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -222,6 +222,8 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mt7921_mcu_parse_response);
+
 
 int mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			    int cmd, int *wait_seq)
@@ -319,6 +321,7 @@ int mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 
 	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[txq], skb, 0);
 }
+EXPORT_SYMBOL_GPL(mt7921_mcu_send_message);
 
 static void
 mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
@@ -600,6 +603,7 @@ int mt7921_mcu_restart(struct mt76_dev *dev)
 	return mt76_mcu_send_msg(dev, MCU_CMD_NIC_POWER_CTRL, &req,
 				 sizeof(req), false);
 }
+EXPORT_SYMBOL_GPL(mt7921_mcu_restart);
 
 static u32 mt7921_get_data_mode(struct mt7921_dev *dev, u32 info)
 {
@@ -903,11 +907,13 @@ int mt7921_run_firmware(struct mt7921_dev *dev)
 
 	return mt76_connac_mcu_get_nic_capability(&dev->mphy);
 }
+EXPORT_SYMBOL_GPL(mt7921_run_firmware);
 
 void mt7921_mcu_exit(struct mt7921_dev *dev)
 {
 	skb_queue_purge(&dev->mt76.mcu.res_q);
 }
+EXPORT_SYMBOL_GPL(mt7921_mcu_exit);
 
 int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 {
@@ -1033,6 +1039,7 @@ int mt7921_mcu_set_eeprom(struct mt7921_dev *dev)
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
 				 &req, sizeof(req), true);
 }
+EXPORT_SYMBOL_GPL(mt7921_mcu_set_eeprom);
 
 int mt7921_mcu_get_eeprom(struct mt7921_dev *dev, u32 offset)
 {
@@ -1215,6 +1222,7 @@ int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(mt7921_mcu_drv_pmctrl);
 
 int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev)
 {
@@ -1236,6 +1244,7 @@ int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(mt7921_mcu_fw_pmctrl);
 
 int mt7921_mcu_set_beacon_filter(struct mt7921_dev *dev,
 				 struct ieee80211_vif *vif,
-- 
2.25.1

