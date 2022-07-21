Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E358857C8E6
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Jul 2022 12:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiGUK0m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Jul 2022 06:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiGUK0m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Jul 2022 06:26:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50235D5BC
        for <linux-wireless@vger.kernel.org>; Thu, 21 Jul 2022 03:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6354261655
        for <linux-wireless@vger.kernel.org>; Thu, 21 Jul 2022 10:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7006EC3411E;
        Thu, 21 Jul 2022 10:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658399199;
        bh=lSfo5CIqZ2O021BF/0lIn9a9PAfyVWNP6X97AUGoAUU=;
        h=From:To:Cc:Subject:Date:From;
        b=WG3kjBFI/My+nTStosoT5kM7kxV2GKFlUkmhI5qpaZj2LbArmhcKl3CuZovwv/Vjf
         j5aQ3WmjxmnIsJ+FMtjKJxkxTNUyE6+WhgCTbaf0EPb7b4FyRQkz1OAadmUWUdmPAA
         RBTeZhozfnx7FcPKkQPkm45djeuIoqwrM17YRPZHYxw2HOEDacmuQIp+dDJoJvODKU
         uCpRND1ImZzC/IQRREvJEJVa+oAJ4Hy+iBz1a7p3tV6cvrOc+Di9oVdrbHAFWEnAuL
         dyg6tUMUl96NsQ/I68hBtkfAwIpAP0WQBHt7eLceekPwxvz1PVyoi8/c49voYmoYFa
         N3nBWWrFYVClg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7921: move mt7921_rx_check and mt7921_queue_rx_skb in mac.c
Date:   Thu, 21 Jul 2022 12:26:07 +0200
Message-Id: <fe76aba8dbbe411dfe1a504e1ff52d5f19420ad1.1658399039.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since both mt7921_rx_check and mt7921_queue_rx_skb routines are used by
all chipsets (mmio, usb and sdio), move them in mac.c and remove
duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch is based on: "mt76: add rx_check callback for usb devices"
https://patchwork.kernel.org/project/linux-wireless/patch/1ce2555483783c2f62bb8fecc575ceca1aad8583.1658335993.git.lorenzo@kernel.org/
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 117 +++++++++++++-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   7 +-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |   4 +-
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   | 148 ------------------
 4 files changed, 119 insertions(+), 157 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index b00fb463b4f1..38f4ee93cbe1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -486,7 +486,7 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	return 0;
 }
 
-void mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
+static void mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 {
 	struct mt7921_sta *msta;
 	u16 fc, tid;
@@ -509,7 +509,6 @@ void mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 	if (!test_and_set_bit(tid, &msta->ampdu_state))
 		ieee80211_start_tx_ba_session(sta, tid, 0);
 }
-EXPORT_SYMBOL_GPL(mt7921_tx_check_aggr);
 
 void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
 {
@@ -552,7 +551,110 @@ void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
 out:
 	rcu_read_unlock();
 }
-EXPORT_SYMBOL_GPL(mt7921_mac_add_txs);
+
+void mt7921_txwi_free(struct mt7921_dev *dev, struct mt76_txwi_cache *t,
+		      struct ieee80211_sta *sta, bool clear_status,
+		      struct list_head *free_list)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	__le32 *txwi;
+	u16 wcid_idx;
+
+	mt76_connac_txp_skb_unmap(mdev, t);
+	if (!t->skb)
+		goto out;
+
+	txwi = (__le32 *)mt76_get_txwi_ptr(mdev, t);
+	if (sta) {
+		struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+
+		if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+			mt7921_tx_check_aggr(sta, txwi);
+
+		wcid_idx = wcid->idx;
+	} else {
+		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
+	}
+
+	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
+out:
+	t->skb = NULL;
+	mt76_put_txwi(mdev, t);
+}
+EXPORT_SYMBOL_GPL(mt7921_txwi_free);
+
+static void mt7921_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
+{
+	struct mt76_connac_tx_free *free = data;
+	__le32 *tx_info = (__le32 *)(data + sizeof(*free));
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_txwi_cache *txwi;
+	struct ieee80211_sta *sta = NULL;
+	struct sk_buff *skb, *tmp;
+	void *end = data + len;
+	LIST_HEAD(free_list);
+	bool wake = false;
+	u8 i, count;
+
+	/* clean DMA queues and unmap buffers first */
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BE], false);
+
+	count = le16_get_bits(free->ctrl, MT_TX_FREE_MSDU_CNT);
+	if (WARN_ON_ONCE((void *)&tx_info[count] > end))
+		return;
+
+	for (i = 0; i < count; i++) {
+		u32 msdu, info = le32_to_cpu(tx_info[i]);
+		u8 stat;
+
+		/* 1'b1: new wcid pair.
+		 * 1'b0: msdu_id with the same 'wcid pair' as above.
+		 */
+		if (info & MT_TX_FREE_PAIR) {
+			struct mt7921_sta *msta;
+			struct mt76_wcid *wcid;
+			u16 idx;
+
+			count++;
+			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
+			wcid = rcu_dereference(dev->mt76.wcid[idx]);
+			sta = wcid_to_sta(wcid);
+			if (!sta)
+				continue;
+
+			msta = container_of(wcid, struct mt7921_sta, wcid);
+			spin_lock_bh(&dev->sta_poll_lock);
+			if (list_empty(&msta->poll_list))
+				list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+			spin_unlock_bh(&dev->sta_poll_lock);
+			continue;
+		}
+
+		msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
+		stat = FIELD_GET(MT_TX_FREE_STATUS, info);
+
+		txwi = mt76_token_release(mdev, msdu, &wake);
+		if (!txwi)
+			continue;
+
+		mt7921_txwi_free(dev, txwi, sta, stat, &free_list);
+	}
+
+	if (wake)
+		mt76_set_tx_blocked(&dev->mt76, false);
+
+	list_for_each_entry_safe(skb, tmp, &free_list, list) {
+		skb_list_del_init(skb);
+		napi_consume_skb(skb, 1);
+	}
+
+	rcu_read_lock();
+	mt7921_mac_sta_poll(dev);
+	rcu_read_unlock();
+
+	mt76_worker_schedule(&dev->mt76.tx_worker);
+}
 
 bool mt7921_rx_check(struct mt76_dev *mdev, void *data, int len)
 {
@@ -564,6 +666,10 @@ bool mt7921_rx_check(struct mt76_dev *mdev, void *data, int len)
 	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
 
 	switch (type) {
+	case PKT_TYPE_TXRX_NOTIFY:
+		/* PKT_TYPE_TXRX_NOTIFY can be received only by mmio devices */
+		mt7921_mac_tx_free(dev, data, len); /* mmio */
+		return false;
 	case PKT_TYPE_TXS:
 		for (rxd += 2; rxd + 8 <= end; rxd += 8)
 			mt7921_mac_add_txs(dev, rxd);
@@ -590,6 +696,11 @@ void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		type = PKT_TYPE_NORMAL_MCU;
 
 	switch (type) {
+	case PKT_TYPE_TXRX_NOTIFY:
+		/* PKT_TYPE_TXRX_NOTIFY can be received only by mmio devices */
+		mt7921_mac_tx_free(dev, skb->data, skb->len);
+		napi_consume_skb(skb, 1);
+		break;
 	case PKT_TYPE_RX_EVENT:
 		mt7921_mcu_rx_event(dev, skb);
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 12c145a30c60..70cad3995403 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -411,14 +411,13 @@ int mt7921_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			void *data, int len);
 int mt7921_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
 			 struct netlink_callback *cb, void *data, int len);
-void mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi);
+void mt7921_txwi_free(struct mt7921_dev *dev, struct mt76_txwi_cache *t,
+		      struct ieee80211_sta *sta, bool clear_status,
+		      struct list_head *free_list);
 void mt7921_mac_sta_poll(struct mt7921_dev *dev);
 int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq);
 
-bool mt7921e_rx_check(struct mt76_dev *mdev, void *data, int len);
-void mt7921e_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-			  struct sk_buff *skb);
 int mt7921e_driver_own(struct mt7921_dev *dev);
 int mt7921e_mac_reset(struct mt7921_dev *dev);
 int mt7921e_mcu_init(struct mt7921_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 9d1ba838e54f..9b75756c2837 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -234,8 +234,8 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		.token_size = MT7921_TOKEN_SIZE,
 		.tx_prepare_skb = mt7921e_tx_prepare_skb,
 		.tx_complete_skb = mt76_connac_tx_complete_skb,
-		.rx_check = mt7921e_rx_check,
-		.rx_skb = mt7921e_queue_rx_skb,
+		.rx_check = mt7921_rx_check,
+		.rx_skb = mt7921_queue_rx_skb,
 		.rx_poll_complete = mt7921_rx_poll_complete,
 		.sta_ps = mt7921_sta_ps,
 		.sta_add = mt7921_mac_sta_add,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index e1800674089a..436f07ba9629 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -53,154 +53,6 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	return 0;
 }
 
-static void
-mt7921_txwi_free(struct mt7921_dev *dev, struct mt76_txwi_cache *t,
-		 struct ieee80211_sta *sta, bool clear_status,
-		 struct list_head *free_list)
-{
-	struct mt76_dev *mdev = &dev->mt76;
-	__le32 *txwi;
-	u16 wcid_idx;
-
-	mt76_connac_txp_skb_unmap(mdev, t);
-	if (!t->skb)
-		goto out;
-
-	txwi = (__le32 *)mt76_get_txwi_ptr(mdev, t);
-	if (sta) {
-		struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
-
-		if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
-			mt7921_tx_check_aggr(sta, txwi);
-
-		wcid_idx = wcid->idx;
-	} else {
-		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
-	}
-
-	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
-
-out:
-	t->skb = NULL;
-	mt76_put_txwi(mdev, t);
-}
-
-static void
-mt7921e_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
-{
-	struct mt76_connac_tx_free *free = data;
-	__le32 *tx_info = (__le32 *)(data + sizeof(*free));
-	struct mt76_dev *mdev = &dev->mt76;
-	struct mt76_txwi_cache *txwi;
-	struct ieee80211_sta *sta = NULL;
-	struct sk_buff *skb, *tmp;
-	void *end = data + len;
-	LIST_HEAD(free_list);
-	bool wake = false;
-	u8 i, count;
-
-	/* clean DMA queues and unmap buffers first */
-	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
-	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BE], false);
-
-	count = le16_get_bits(free->ctrl, MT_TX_FREE_MSDU_CNT);
-	if (WARN_ON_ONCE((void *)&tx_info[count] > end))
-		return;
-
-	for (i = 0; i < count; i++) {
-		u32 msdu, info = le32_to_cpu(tx_info[i]);
-		u8 stat;
-
-		/* 1'b1: new wcid pair.
-		 * 1'b0: msdu_id with the same 'wcid pair' as above.
-		 */
-		if (info & MT_TX_FREE_PAIR) {
-			struct mt7921_sta *msta;
-			struct mt76_wcid *wcid;
-			u16 idx;
-
-			count++;
-			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
-			wcid = rcu_dereference(dev->mt76.wcid[idx]);
-			sta = wcid_to_sta(wcid);
-			if (!sta)
-				continue;
-
-			msta = container_of(wcid, struct mt7921_sta, wcid);
-			spin_lock_bh(&dev->sta_poll_lock);
-			if (list_empty(&msta->poll_list))
-				list_add_tail(&msta->poll_list, &dev->sta_poll_list);
-			spin_unlock_bh(&dev->sta_poll_lock);
-			continue;
-		}
-
-		msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
-		stat = FIELD_GET(MT_TX_FREE_STATUS, info);
-
-		txwi = mt76_token_release(mdev, msdu, &wake);
-		if (!txwi)
-			continue;
-
-		mt7921_txwi_free(dev, txwi, sta, stat, &free_list);
-	}
-
-	if (wake)
-		mt76_set_tx_blocked(&dev->mt76, false);
-
-	list_for_each_entry_safe(skb, tmp, &free_list, list) {
-		skb_list_del_init(skb);
-		napi_consume_skb(skb, 1);
-	}
-
-	rcu_read_lock();
-	mt7921_mac_sta_poll(dev);
-	rcu_read_unlock();
-
-	mt76_worker_schedule(&dev->mt76.tx_worker);
-}
-
-bool mt7921e_rx_check(struct mt76_dev *mdev, void *data, int len)
-{
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
-	__le32 *rxd = (__le32 *)data;
-	__le32 *end = (__le32 *)&rxd[len / 4];
-	enum rx_pkt_type type;
-
-	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
-
-	switch (type) {
-	case PKT_TYPE_TXRX_NOTIFY:
-		mt7921e_mac_tx_free(dev, data, len);
-		return false;
-	case PKT_TYPE_TXS:
-		for (rxd += 2; rxd + 8 <= end; rxd += 8)
-			mt7921_mac_add_txs(dev, rxd);
-		return false;
-	default:
-		return true;
-	}
-}
-
-void mt7921e_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-			  struct sk_buff *skb)
-{
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
-	__le32 *rxd = (__le32 *)skb->data;
-	enum rx_pkt_type type;
-
-	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
-
-	switch (type) {
-	case PKT_TYPE_TXRX_NOTIFY:
-		mt7921e_mac_tx_free(dev, skb->data, skb->len);
-		napi_consume_skb(skb, 1);
-		break;
-	default:
-		mt7921_queue_rx_skb(mdev, q, skb);
-		break;
-	}
-}
-
 void mt7921_tx_token_put(struct mt7921_dev *dev)
 {
 	struct mt76_txwi_cache *txwi;
-- 
2.36.1

