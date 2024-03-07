Return-Path: <linux-wireless+bounces-4470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADE5875729
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 20:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48D328201A
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 19:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E300B136989;
	Thu,  7 Mar 2024 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="gA1CRGHt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA379136663
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839803; cv=none; b=FsVp8J7sFdm2l2hOE6Ecpsr5GeQ7IrXafazHD9SSVEz/Ra6xyNM6UVfJqLnnGmYUv8Bxfp/QAWkGJ98D5ii9/95oFw+9v6kbs98SNjfQRgJuHcuVyyP5zKfqMELDwE7LF2zU/ZrKlt5592hvOb4ZPwxqLEK/vRn/75beJpabzhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839803; c=relaxed/simple;
	bh=Glwf9GgdnsO9unBN0hj7DJOFV1142GiKdQmXqNcq5oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekUH/AsuwcPeXtgVaCLzuslVx41GFeAHi50x1aC4CdlGFpunoBYWShyKyRIwuaIPC+wIIjlwf50iaYp7obEWDVVBw/U9J/rrOvcT/V++SZzBOHfJWOjVAQrwqfbvZbxMhQd8yfkFe9nMRltGFjQUIQo1Nyxq68YIz3BMEIitRyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=gA1CRGHt; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0316CB00069
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 19:29:59 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 979DC13C2B1;
	Thu,  7 Mar 2024 11:29:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 979DC13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709839798;
	bh=Glwf9GgdnsO9unBN0hj7DJOFV1142GiKdQmXqNcq5oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gA1CRGHtHswHqKd5BxSx2dBZUGs2N1Hf0z3XM9T0Zu+T8Rj8mnWjRlD2cuEeeDuTZ
	 zZBI3mAo51TFWasfN9dUVCHKJ8OZtbY5+vM059XJl/e18gUqfy488v2/YtxsLMwz4L
	 3H3XxYv3HkaP3gODuDGWIjF/fZD5BBtPedQAwf10=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH 2/6] wifi: mt76: mt7996: add configured logging
Date: Thu,  7 Mar 2024 11:29:47 -0800
Message-ID: <20240307192951.3271156-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240307192951.3271156-1-greearb@candelatech.com>
References: <20240307192951.3271156-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1709839800-4SJFZLh4bTjA
X-MDID-O:
 us5;ut7;1709839800;4SJFZLh4bTjA;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

Allow module param and debugfs to configure a debug level
to allow adding more debug logic that is only enabled when
needed.

Similar to how ath10k and iwlwifi work in this regard.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c  | 24 ++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     | 17 +++++++++++
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  3 ++
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 28 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 18 ++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  4 +++
 6 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index ae83be572b94..bc16c3257540 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -100,6 +100,29 @@ void mt76_seq_puts_array(struct seq_file *file, const char *str,
 }
 EXPORT_SYMBOL_GPL(mt76_seq_puts_array);
 
+static int
+mt76_debug_lvl_set(void *data, u64 val)
+{
+	struct mt76_dev *dev = data;
+
+	dev->debug_lvl = val;
+
+	return 0;
+}
+
+static int
+mt76_debug_lvl_get(void *data, u64 *val)
+{
+	struct mt76_dev *dev = data;
+
+	*val = dev->debug_lvl;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_debug_lvl, mt76_debug_lvl_get,
+			 mt76_debug_lvl_set, "%lld\n");
+
 struct dentry *
 mt76_register_debugfs_fops(struct mt76_phy *phy,
 			   const struct file_operations *ops)
@@ -115,6 +138,7 @@ mt76_register_debugfs_fops(struct mt76_phy *phy,
 	debugfs_create_file_unsafe("regval", 0600, dir, dev, fops);
 	debugfs_create_file_unsafe("napi_threaded", 0600, dir, dev,
 				   &fops_napi_threaded);
+	debugfs_create_file("debug_lvl", 0600, dir, dev, &fops_debug_lvl);
 	debugfs_create_blob("eeprom", 0400, dir, &dev->eeprom);
 	if (dev->otp.data)
 		debugfs_create_blob("otp", 0400, dir, &dev->otp);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index c341915e4d62..dd8a24cda48a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -815,6 +815,7 @@ struct mt76_dev {
 	spinlock_t cc_lock;
 
 	u32 cur_cc_bss_rx;
+	u32 debug_lvl;
 
 	struct mt76_rx_status rx_ampdu_status;
 	u32 rx_ampdu_len;
@@ -1004,6 +1005,22 @@ struct mt76_mib_stats {
 	u32 ul_hetrig_4mu_cnt;
 };
 
+enum MTK_DEUBG {
+	MTK_DEBUG_TX		= 0x00000001, /* tx path */
+	MTK_DEBUG_TXV		= 0x00000002, /* verbose tx path */
+	MTK_DEBUG_FATAL		= 0x00000004,
+	MTK_DEBUG_WRN		= 0x00000008,
+	MTK_DEBUG_MSG		= 0x00000010, /* messages to/from firmware */
+	MTK_DEBUG_CFG		= 0x00000020, /* Configuration related */
+	MTK_DEBUG_ANY		= 0xffffffff
+};
+
+#define mtk_dbg(mt76, dbg_mask, fmt, ...)				\
+	do {								\
+		if ((mt76)->debug_lvl & MTK_DEBUG_##dbg_mask)		\
+			dev_info((mt76)->dev, fmt, ##__VA_ARGS__); \
+	} while (0)
+
 struct mt76_power_limits {
 	s8 cck[4];
 	s8 ofdm[8];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 0cf0d1fe420a..d3b72fb73c30 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -14,6 +14,8 @@
 #include "coredump.h"
 #include "eeprom.h"
 
+extern u32 debug_lvl; /* module param */
+
 static const struct ieee80211_iface_limit if_limits[] = {
 	{
 		.max = 1,
@@ -1309,6 +1311,7 @@ int mt7996_register_device(struct mt7996_dev *dev)
 	dev->phy.dev = dev;
 	dev->phy.mt76 = &dev->mt76.phy;
 	dev->mt76.phy.priv = &dev->phy;
+	dev->mt76.debug_lvl = debug_lvl;
 	INIT_WORK(&dev->rc_work, mt7996_mac_sta_rc_work);
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7996_mac_work);
 	INIT_LIST_HEAD(&dev->sta_rc_list);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 53258488d49f..9b4637867354 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -923,6 +923,9 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
 	u8 *txwi = (u8 *)txwi_ptr;
 
+	mtk_dbg(&dev->mt76, TXV, "mt7996-tx-prepare-skb, skb-len: %d\n",
+		tx_info->skb->len);
+
 	if (unlikely(tx_info->skb->len <= ETH_HLEN))
 		return -EINVAL;
 
@@ -933,8 +936,11 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	t->skb = tx_info->skb;
 
 	id = mt76_token_consume(mdev, &t);
-	if (id < 0)
+	if (id < 0) {
+		mtk_dbg(&dev->mt76, TXV, "mt7996-tx-prepare-skb, token_consume error: %d\n",
+			id);
 		return id;
+	}
 
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
 	mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
@@ -1124,6 +1130,9 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 			idx = FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
 			wcid = rcu_dereference(dev->mt76.wcid[idx]);
 			sta = wcid_to_sta(wcid);
+
+			mtk_dbg(mdev, TXV, "mt7996-mac-tx-free, new wcid pair, idx: %d sta: %p wcid: %p\n",
+				idx, sta, wcid);
 			if (!sta)
 				continue;
 
@@ -1157,8 +1166,14 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 
 			count++;
 			txwi = mt76_token_release(mdev, msdu, &wake);
-			if (!txwi)
+
+			mtk_dbg(mdev, TXV, "mt7996-mac-tx-free, msdu: %d, count: %d/%d\n",
+				msdu, count, total);
+
+			if (!txwi) {
+				WARN_ON_ONCE(1);
 				continue;
+			}
 
 			mt7996_txwi_free(dev, txwi, sta, &free_list);
 		}
@@ -1333,6 +1348,9 @@ static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
 	u16 wcidx;
 	u8 pid;
 
+	mtk_dbg(&dev->mt76, TX, "mt7996-mac-add-txs, format: %d\n",
+		le32_get_bits(txs_data[0], MT_TXS0_TXS_FORMAT));
+
 	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
 	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
 
@@ -1391,7 +1409,12 @@ bool mt7996_rx_check(struct mt76_dev *mdev, void *data, int len)
 	case PKT_TYPE_RX_FW_MONITOR:
 		mt7996_debugfs_rx_fw_monitor(dev, data, len);
 		return false;
+	case PKT_TYPE_RX_EVENT:
+	case PKT_TYPE_NORMAL:
+		/* These are handled elsewhere, do not warn about them. */
+		return true;
 	default:
+		mtk_dbg(mdev, MSG, "mt7996-rx-check, pkt-type: %d not handled.\n", type);
 		return true;
 	}
 }
@@ -1443,6 +1466,7 @@ void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		}
 		fallthrough;
 	default:
+		mtk_dbg(mdev, MSG, "mt7996-mac-queue-rx-skb, unhandled type: %d\n", type);
 		dev_kfree_skb(skb);
 		break;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 51deea84b642..f9a8a60a947e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -7,6 +7,19 @@
 #include "mcu.h"
 #include "mac.h"
 
+u32 debug_lvl = MTK_DEBUG_FATAL | MTK_DEBUG_WRN;
+module_param(debug_lvl, uint, 0644);
+MODULE_PARM_DESC(debug_lvl,
+		 "Enable debugging messages\n"
+		 "0x00001	tx path\n"
+		 "0x00002	tx path verbose\n"
+		 "0x00004	fatal/very-important messages\n"
+		 "0x00008	warning messages\n"
+		 "0x00010	Info about messages to/from firmware\n"
+		 "0x00020	Configuration logs.\n"
+		 "0xffffffff	any/all\n"
+	);
+
 static bool mt7996_dev_running(struct mt7996_dev *dev)
 {
 	struct mt7996_phy *phy;
@@ -76,6 +89,8 @@ static int mt7996_start(struct ieee80211_hw *hw)
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	int ret;
 
+	dev->mt76.debug_lvl = debug_lvl;
+
 	flush_work(&dev->init_work);
 
 	mutex_lock(&dev->mt76.mutex);
@@ -739,6 +754,9 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 		wcid = &mvif->sta.wcid;
 	}
 
+	mtk_dbg(&dev->mt76, TXV, "mt7996-tx, wcid: %d\n",
+		wcid->idx);
+
 	mt76_tx(mphy, control->sta, wcid, skb);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index a858a0914bf0..5550671cdaf6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -616,11 +616,15 @@ mt7996_mcu_rx_ext_event(struct mt7996_dev *dev, struct sk_buff *skb)
 {
 	struct mt7996_mcu_rxd *rxd = (struct mt7996_mcu_rxd *)skb->data;
 
+	mtk_dbg(&dev->mt76, MSG, "mt7996-mcu-rx-ext-event, ext-eid: %d\n", rxd->ext_eid);
+
 	switch (rxd->ext_eid) {
 	case MCU_EXT_EVENT_FW_LOG_2_HOST:
 		mt7996_mcu_rx_log_message(dev, skb);
 		break;
 	default:
+		/* in SDK, grep for EventExtEventHandler */
+		mtk_dbg(&dev->mt76, WRN, "mt7996, unhandled rx_ext_event: 0x%x", rxd->ext_eid);
 		break;
 	}
 }
-- 
2.42.0


