Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E0E2FDD1B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Jan 2021 00:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbhATWg6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jan 2021 17:36:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390587AbhATWQe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jan 2021 17:16:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11A222368A;
        Wed, 20 Jan 2021 22:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611180912;
        bh=yaGcuGk7/IsGBz36Eny+jmpQzSbht8Fwqlrlb8Q6lbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qnFyOKt6cUiL4vHZRn9A6I0Cq6ziw5PaMzbjDCza0MW+6FDfo63Wl6rTJZ6J/2xVP
         64ZM92ohOGvw9dmLHiIqIwK1UOCNG3INUZCqyObGZ3nI18HVa+WzdnjG9QU02IJezL
         Aws04jv4N1di5vBdClITOnZEQT5dkp1GgPLkZCXDrxFCwC4+224nOrXpFTyn5T3oFN
         VckOlsh9LuIR0QYfBgOAW5Ek/bEPYBQ9wrsas59sz1i9nVkqL14to0vu0GFV01pFWi
         3X2C8qEVMfGyun+OoXTFRsV3ztcz2pkZVhIdIqs0ziRQGEV05HZSg3/wWw0FJ/Ceib
         aG7njZlgI4vHw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 5/6] mt76: mt76_connac: move pm data struct in mt76_connac.h
Date:   Wed, 20 Jan 2021 23:14:39 +0100
Message-Id: <0df488005c62607565cd226cd9c59e34d1b8303b.1611180342.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611180342.git.lorenzo@kernel.org>
References: <cover.1611180342.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move runtime-pm mt7663 data structure in mt76_connac.h introducing
mt76_connac_pm data struct. This is a preliminary patch to share pm code
between mt7663 and mt7921

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  8 +--
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  4 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    | 19 +-----
 .../net/wireless/mediatek/mt76/mt76_connac.h  | 62 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 38 +-----------
 5 files changed, 70 insertions(+), 61 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 18b947f3bb9c..904a8348f94b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1875,16 +1875,14 @@ void mt7615_pm_wake_work(struct work_struct *work)
 
 	spin_lock_bh(&dev->pm.txq_lock);
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		struct mt7615_sta *msta = dev->pm.tx_q[i].msta;
+		struct mt76_wcid *wcid = dev->pm.tx_q[i].wcid;
 		struct ieee80211_sta *sta = NULL;
-		struct mt76_wcid *wcid;
 
 		if (!dev->pm.tx_q[i].skb)
 			continue;
 
-		wcid = msta ? &msta->wcid : &dev->mt76.global_wcid;
-		if (msta && wcid->sta)
-			sta = container_of((void *)msta, struct ieee80211_sta,
+		if (wcid && wcid->sta)
+			sta = container_of((void *)wcid, struct ieee80211_sta,
 					   drv_priv);
 
 		mt76_tx(mphy, sta, wcid, dev->pm.tx_q[i].skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index f726378fe9ea..3eafb9cbf827 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -31,7 +31,7 @@ static void mt7615_free_pending_tx_skbs(struct mt7615_dev *dev,
 
 	spin_lock_bh(&dev->pm.txq_lock);
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		if (msta && dev->pm.tx_q[i].msta != msta)
+		if (msta && dev->pm.tx_q[i].wcid != &msta->wcid)
 			continue;
 
 		dev_kfree_skb(dev->pm.tx_q[i].skb);
@@ -726,7 +726,7 @@ static void mt7615_tx(struct ieee80211_hw *hw,
 	spin_lock_bh(&dev->pm.txq_lock);
 	if (!dev->pm.tx_q[qid].skb) {
 		ieee80211_stop_queues(hw);
-		dev->pm.tx_q[qid].msta = msta;
+		dev->pm.tx_q[qid].wcid = wcid;
 		dev->pm.tx_q[qid].skb = skb;
 		queue_work(dev->mt76.wq, &dev->pm.wake_work);
 	} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index a03dd26d4970..99a1a1a93b3b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -8,7 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/ktime.h>
 #include <linux/regmap.h>
-#include "../mt76.h"
+#include "../mt76_connac.h"
 #include "regs.h"
 
 #define MT7615_MAX_INTERFACES		16
@@ -276,22 +276,7 @@ struct mt7615_dev {
 
 	u32 muar_mask;
 
-	struct {
-		bool enable;
-
-		spinlock_t txq_lock;
-		struct {
-			struct mt7615_sta *msta;
-			struct sk_buff *skb;
-		} tx_q[IEEE80211_NUM_ACS];
-
-		struct work_struct wake_work;
-		struct completion wake_cmpl;
-
-		struct delayed_work ps_work;
-		unsigned long last_activity;
-		unsigned long idle_timeout;
-	} pm;
+	struct mt76_connac_pm pm;
 };
 
 enum tx_pkt_queue_idx {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
new file mode 100644
index 000000000000..a20dc558e8f5
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT76_CONNAC_H
+#define __MT76_CONNAC_H
+
+#include "mt76.h"
+
+#define MT76_CONNAC_SCAN_IE_LEN			600
+#define MT76_CONNAC_MAX_SCHED_SCAN_INTERVAL	10
+#define MT76_CONNAC_MAX_SCHED_SCAN_SSID		10
+#define MT76_CONNAC_MAX_SCAN_MATCH		16
+
+enum {
+	CMD_CBW_20MHZ = IEEE80211_STA_RX_BW_20,
+	CMD_CBW_40MHZ = IEEE80211_STA_RX_BW_40,
+	CMD_CBW_80MHZ = IEEE80211_STA_RX_BW_80,
+	CMD_CBW_160MHZ = IEEE80211_STA_RX_BW_160,
+	CMD_CBW_10MHZ,
+	CMD_CBW_5MHZ,
+	CMD_CBW_8080MHZ,
+
+	CMD_HE_MCS_BW80 = 0,
+	CMD_HE_MCS_BW160,
+	CMD_HE_MCS_BW8080,
+	CMD_HE_MCS_BW_NUM
+};
+
+enum {
+	HW_BSSID_0 = 0x0,
+	HW_BSSID_1,
+	HW_BSSID_2,
+	HW_BSSID_3,
+	HW_BSSID_MAX = HW_BSSID_3,
+	EXT_BSSID_START = 0x10,
+	EXT_BSSID_1,
+	EXT_BSSID_15 = 0x1f,
+	EXT_BSSID_MAX = EXT_BSSID_15,
+	REPEATER_BSSID_START = 0x20,
+	REPEATER_BSSID_MAX = 0x3f,
+};
+
+struct mt76_connac_pm {
+	bool enable;
+
+	spinlock_t txq_lock;
+	struct {
+		struct mt76_wcid *wcid;
+		struct sk_buff *skb;
+	} tx_q[IEEE80211_NUM_ACS];
+
+	struct work_struct wake_work;
+	struct completion wake_cmpl;
+
+	struct delayed_work ps_work;
+	unsigned long last_activity;
+	unsigned long idle_timeout;
+};
+
+extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
+
+#endif /* __MT76_CONNAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index f9a30d70b79a..bd954ed92078 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -4,41 +4,7 @@
 #ifndef __MT76_CONNAC_MCU_H
 #define __MT76_CONNAC_MCU_H
 
-#include "mt76.h"
-
-#define MT76_CONNAC_SCAN_IE_LEN			600
-#define MT76_CONNAC_MAX_SCHED_SCAN_INTERVAL	10
-#define MT76_CONNAC_MAX_SCHED_SCAN_SSID		10
-#define MT76_CONNAC_MAX_SCAN_MATCH		16
-
-enum {
-	CMD_CBW_20MHZ = IEEE80211_STA_RX_BW_20,
-	CMD_CBW_40MHZ = IEEE80211_STA_RX_BW_40,
-	CMD_CBW_80MHZ = IEEE80211_STA_RX_BW_80,
-	CMD_CBW_160MHZ = IEEE80211_STA_RX_BW_160,
-	CMD_CBW_10MHZ,
-	CMD_CBW_5MHZ,
-	CMD_CBW_8080MHZ,
-
-	CMD_HE_MCS_BW80 = 0,
-	CMD_HE_MCS_BW160,
-	CMD_HE_MCS_BW8080,
-	CMD_HE_MCS_BW_NUM
-};
-
-enum {
-	HW_BSSID_0 = 0x0,
-	HW_BSSID_1,
-	HW_BSSID_2,
-	HW_BSSID_3,
-	HW_BSSID_MAX = HW_BSSID_3,
-	EXT_BSSID_START = 0x10,
-	EXT_BSSID_1,
-	EXT_BSSID_15 = 0x1f,
-	EXT_BSSID_MAX = EXT_BSSID_15,
-	REPEATER_BSSID_START = 0x20,
-	REPEATER_BSSID_MAX = 0x3f,
-};
+#include "mt76_connac.h"
 
 struct tlv {
 	__le16 tag;
@@ -905,8 +871,6 @@ struct mt76_connac_suspend_tlv {
 	u8 pad[5];
 } __packed;
 
-extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
-
 struct sk_buff *
 mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
 			      struct mt76_wcid *wcid);
-- 
2.29.2

