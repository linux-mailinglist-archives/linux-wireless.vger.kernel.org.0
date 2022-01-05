Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BC24851AD
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jan 2022 12:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbiAELQy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Jan 2022 06:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbiAELQr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Jan 2022 06:16:47 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77201C061792
        for <linux-wireless@vger.kernel.org>; Wed,  5 Jan 2022 03:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TFijVrLYNJD/shTltxhZxmYg1PhTs9YEs9C38Amyo6Y=; b=E+4pvw5ZFHhEACOlkbKH4ZUVIn
        VMRloN1tES5Ko9xd7bt0wrqe8LOJ+xbfFpwa0FeNvPqjZWcu1iSMZZEePdRbQr70OpWaPwALum2qK
        8uP4ytf8Tdt8x8Fl4U+l+jviekn2evVRxb/Gn0SbmlZ+YMVMHyFGUZiSyc0ZnH5lP+Jg=;
Received: from p54ae97a7.dip0.t-ipconnect.de ([84.174.151.167] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1n54Hb-0002oF-Sg
        for linux-wireless@vger.kernel.org; Wed, 05 Jan 2022 12:16:43 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7915: add support for passing chip/firmware debug data to user space
Date:   Wed,  5 Jan 2022 12:16:42 +0100
Message-Id: <20220105111642.80333-1-nbd@nbd.name>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This can be used to assist in debugging driver or firmware tx/rx issues.
The data is streamed to user space using a relay file in debugfs

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 142 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |   6 +
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |   1 +
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   7 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |   2 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   6 +
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |   2 +
 7 files changed, 162 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index c59ef08a5306..dad25dfb946c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -1,9 +1,13 @@
 // SPDX-License-Identifier: ISC
 /* Copyright (C) 2020 MediaTek Inc. */
 
+#include <linux/relay.h>
 #include "mt7915.h"
 #include "eeprom.h"
 #include "mcu.h"
+#include "mac.h"
+
+#define FW_BIN_LOG_MAGIC	0x44e98caf
 
 /** global debugfs **/
 
@@ -311,16 +315,31 @@ mt7915_fw_debug_wm_set(void *data, u64 val)
 		DEBUG_SPL,
 		DEBUG_RPT_RX,
 	} debug;
+	bool tx, rx, en;
 	int ret;
 
 	dev->fw_debug_wm = val ? MCU_FW_LOG_TO_HOST : 0;
 
-	ret = mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WM, dev->fw_debug_wm);
+	if (dev->fw_debug_bin)
+		val = 16;
+	else
+		val = dev->fw_debug_wm;
+
+	tx = dev->fw_debug_wm || (dev->fw_debug_bin & BIT(1));
+	rx = dev->fw_debug_wm || (dev->fw_debug_bin & BIT(2));
+	en = dev->fw_debug_wm || (dev->fw_debug_bin & BIT(0));
+
+	ret = mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WM, val);
 	if (ret)
 		return ret;
 
 	for (debug = DEBUG_TXCMD; debug <= DEBUG_RPT_RX; debug++) {
-		ret = mt7915_mcu_fw_dbg_ctrl(dev, debug, !!dev->fw_debug_wm);
+		if (debug == DEBUG_RPT_RX)
+			val = en && rx;
+		else
+			val = en && tx;
+
+		ret = mt7915_mcu_fw_dbg_ctrl(dev, debug, val);
 		if (ret)
 			return ret;
 	}
@@ -376,6 +395,65 @@ mt7915_fw_debug_wa_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug_wa, mt7915_fw_debug_wa_get,
 			 mt7915_fw_debug_wa_set, "%lld\n");
 
+static struct dentry *
+create_buf_file_cb(const char *filename, struct dentry *parent, umode_t mode,
+		   struct rchan_buf *buf, int *is_global)
+{
+	struct dentry *f;
+
+	f = debugfs_create_file("fwlog_data", mode, parent, buf,
+				&relay_file_operations);
+	if (IS_ERR(f))
+		return NULL;
+
+	*is_global = 1;
+
+	return f;
+}
+
+static int
+remove_buf_file_cb(struct dentry *f)
+{
+	debugfs_remove(f);
+
+	return 0;
+}
+
+static int
+mt7915_fw_debug_bin_set(void *data, u64 val)
+{
+	static struct rchan_callbacks relay_cb = {
+		.create_buf_file = create_buf_file_cb,
+		.remove_buf_file = remove_buf_file_cb,
+	};
+	struct mt7915_dev *dev = data;
+
+	if (!dev->relay_fwlog)
+		dev->relay_fwlog = relay_open("fwlog_data", dev->debugfs_dir,
+					    1500, 512, &relay_cb, NULL);
+	if (!dev->relay_fwlog)
+		return -ENOMEM;
+
+	dev->fw_debug_bin = val;
+
+	relay_reset(dev->relay_fwlog);
+
+	return mt7915_fw_debug_wm_set(dev, dev->fw_debug_wm);
+}
+
+static int
+mt7915_fw_debug_bin_get(void *data, u64 *val)
+{
+	struct mt7915_dev *dev = data;
+
+	*val = dev->fw_debug_bin;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug_bin, mt7915_fw_debug_bin_get,
+			 mt7915_fw_debug_bin_set, "%lld\n");
+
 static int
 mt7915_fw_util_wm_show(struct seq_file *file, void *data)
 {
@@ -757,6 +835,7 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 	debugfs_create_file("tx_stats", 0400, dir, phy, &mt7915_tx_stats_fops);
 	debugfs_create_file("fw_debug_wm", 0600, dir, dev, &fops_fw_debug_wm);
 	debugfs_create_file("fw_debug_wa", 0600, dir, dev, &fops_fw_debug_wa);
+	debugfs_create_file("fw_debug_bin", 0600, dir, dev, &fops_fw_debug_bin);
 	debugfs_create_file("fw_util_wm", 0400, dir, dev,
 			    &mt7915_fw_util_wm_fops);
 	debugfs_create_file("fw_util_wa", 0400, dir, dev,
@@ -775,9 +854,68 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 				    &fops_radar_trigger);
 	}
 
+	if (!ext_phy)
+		dev->debugfs_dir = dir;
+
 	return 0;
 }
 
+static void
+mt7915_debugfs_write_fwlog(struct mt7915_dev *dev, const void *hdr, int hdrlen,
+			 const void *data, int len)
+{
+	static DEFINE_SPINLOCK(lock);
+	unsigned long flags;
+	void *dest;
+
+	spin_lock_irqsave(&lock, flags);
+	dest = relay_reserve(dev->relay_fwlog, hdrlen + len + 4);
+	if (dest) {
+		*(u32 *)dest = hdrlen + len;
+		dest += 4;
+
+		if (hdrlen) {
+			memcpy(dest, hdr, hdrlen);
+			dest += hdrlen;
+		}
+
+		memcpy(dest, data, len);
+		relay_flush(dev->relay_fwlog);
+	}
+	spin_unlock_irqrestore(&lock, flags);
+}
+
+void mt7915_debugfs_rx_ics(struct mt7915_dev *dev, const void *data, int len)
+{
+	struct {
+		__le32 magic;
+		__le32 timestamp;
+		__le16 msg_type;
+		__le16 len;
+	} hdr = {
+		.magic = cpu_to_le32(FW_BIN_LOG_MAGIC),
+		.msg_type = PKT_TYPE_RX_ICS,
+	};
+
+	if (!dev->relay_fwlog)
+		return;
+
+	hdr.timestamp = mt76_rr(dev, MT_LPON_FRCR(0));
+	hdr.len = *(__le16 *)data;
+	mt7915_debugfs_write_fwlog(dev, &hdr, sizeof(hdr), data, len);
+}
+
+bool mt7915_debugfs_rx_log(struct mt7915_dev *dev, const void *data, int len)
+{
+	if (get_unaligned_le32(data) != FW_BIN_LOG_MAGIC)
+		return false;
+
+	if (dev->relay_fwlog)
+		mt7915_debugfs_write_fwlog(dev, NULL, 0, data, len);
+
+	return true;
+}
+
 #ifdef CONFIG_MAC80211_DEBUGFS
 /** per-station debugfs **/
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index e0200f84a2f9..a6770fd40b34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1691,6 +1691,9 @@ bool mt7915_rx_check(struct mt76_dev *mdev, void *data, int len)
 		for (rxd += 2; rxd + 8 <= end; rxd += 8)
 		    mt7915_mac_add_txs(dev, rxd);
 		return false;
+	case PKT_TYPE_RX_ICS:
+		mt7915_debugfs_rx_ics(dev, data, len);
+		return false;
 	default:
 		return true;
 	}
@@ -1722,6 +1725,9 @@ void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		    mt7915_mac_add_txs(dev, rxd);
 		dev_kfree_skb(skb);
 		break;
+	case PKT_TYPE_RX_ICS:
+		mt7915_debugfs_rx_ics(dev, skb->data, skb->len);
+		break;
 	case PKT_TYPE_NORMAL:
 		if (!mt7915_mac_fill_rx(dev, skb)) {
 			mt76_rx(&dev->mt76, q, skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index d79f0a56535f..7fef2f8fad65 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -23,6 +23,7 @@ enum rx_pkt_type {
 	PKT_TYPE_RETRIEVE,
 	PKT_TYPE_TXRX_NOTIFY,
 	PKT_TYPE_RX_EVENT,
+	PKT_TYPE_RX_ICS = 0x0c,
 };
 
 /* RXD DW1 */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 74cdfd3d13b9..66f8daf3168c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -368,9 +368,13 @@ mt7915_mcu_rx_log_message(struct mt7915_dev *dev, struct sk_buff *skb)
 	struct mt7915_mcu_rxd *rxd = (struct mt7915_mcu_rxd *)skb->data;
 	const char *data = (char *)&rxd[1];
 	const char *type;
+	int len = skb->len - sizeof(*rxd);
 
 	switch (rxd->s2d_index) {
 	case 0:
+		if (mt7915_debugfs_rx_log(dev, data, len))
+			return;
+
 		type = "WM";
 		break;
 	case 2:
@@ -381,8 +385,7 @@ mt7915_mcu_rx_log_message(struct mt7915_dev *dev, struct sk_buff *skb)
 		break;
 	}
 
-	wiphy_info(mt76_hw(dev)->wiphy, "%s: %.*s", type,
-		   (int)(skb->len - sizeof(*rxd)), data);
+	wiphy_info(mt76_hw(dev)->wiphy, "%s: %.*s", type, len, data);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index f1568f9059d8..e8ff686bd3f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -50,6 +50,7 @@ static const u32 mt7915_offs[] = {
 	[AGG_ATCR3]		= 0x0f4,
 	[LPON_UTTR0]		= 0x080,
 	[LPON_UTTR1]		= 0x084,
+	[LPON_FRCR]		= 0x314,
 	[MIB_SDR3]		= 0x014,
 	[MIB_SDR4]		= 0x018,
 	[MIB_SDR5]		= 0x01c,
@@ -121,6 +122,7 @@ static const u32 mt7916_offs[] = {
 	[AGG_ATCR3]		= 0x080,
 	[LPON_UTTR0]		= 0x360,
 	[LPON_UTTR1]		= 0x364,
+	[LPON_FRCR]		= 0x37c,
 	[MIB_SDR3]		= 0x698,
 	[MIB_SDR4]		= 0x788,
 	[MIB_SDR5]		= 0x780,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 5adde022d4e2..fff3065a3453 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -291,6 +291,10 @@ struct mt7915_dev {
 	bool ibf;
 	u8 fw_debug_wm;
 	u8 fw_debug_wa;
+	u8 fw_debug_bin;
+
+	struct dentry *debugfs_dir;
+	struct rchan *relay_fwlog;
 
 	void *cal;
 
@@ -537,6 +541,8 @@ void mt7915_update_channel(struct mt76_phy *mphy);
 int mt7915_mcu_muru_debug_set(struct mt7915_dev *dev, bool enable);
 int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy, void *ms);
 int mt7915_init_debugfs(struct mt7915_phy *phy);
+void mt7915_debugfs_rx_ics(struct mt7915_dev *dev, const void *data, int len);
+bool mt7915_debugfs_rx_log(struct mt7915_dev *dev, const void *data, int len);
 #ifdef CONFIG_MAC80211_DEBUGFS
 void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, struct dentry *dir);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index aa19e5940070..6a0f68180396 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -50,6 +50,7 @@ enum offs_rev {
 	AGG_ATCR3,
 	LPON_UTTR0,
 	LPON_UTTR1,
+	LPON_FRCR,
 	MIB_SDR3,
 	MIB_SDR4,
 	MIB_SDR5,
@@ -238,6 +239,7 @@ enum offs_rev {
 
 #define MT_LPON_UTTR0(_band)		MT_WF_LPON(_band, __OFFS(LPON_UTTR0))
 #define MT_LPON_UTTR1(_band)		MT_WF_LPON(_band, __OFFS(LPON_UTTR1))
+#define MT_LPON_FRCR(_band)		MT_WF_LPON(_band, __OFFS(LPON_FRCR))
 
 #define MT_LPON_TCR(_band, n)		MT_WF_LPON(_band, 0x0a8 +	\
 						   (((n) * 4) << 1))
-- 
2.34.1

