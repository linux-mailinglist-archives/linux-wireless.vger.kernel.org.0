Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B5F7D0D32
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 12:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376901AbjJTKcM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Oct 2023 06:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376891AbjJTKcM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Oct 2023 06:32:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA5CD60
        for <linux-wireless@vger.kernel.org>; Fri, 20 Oct 2023 03:32:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C17C433C8;
        Fri, 20 Oct 2023 10:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697797929;
        bh=wvRbHHAfmjeCx/FVVRZGvK+V2crX0gO3730CFi4KY+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C9WUbvbB18BbhwGx73/AG+X4/k0y3nIC4SEDAM/RFXyc9Ey842sr4ogs1y8AkA1a5
         da3Zz+2bAL9X9L7+YZJNmRjgG5kYACb6QA8nyOYEnLwBkJ8yFrpY8I8vmrXt67g6p8
         InSakJcZLHWK21U+utaNlxmFVjuGA4Fk0ZSDbZ4ulcznyHQkEdMkwrwjcWMC5GzkFd
         KsBcL4g1TUIld9/fzXu1wq0FEl4bmI0UA3NDOeGiLv3QixmfEkNiiChyu7HZfC3iEo
         fh/3FatjLk5aIJMfRtc2cgvQ+nn0aTpoae9lMs51i3eut6e0VoON/oYhkl7VX7HupL
         AQxj9POzcv9bQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 13/13] wifi: mt76: mt7996: add wed rro delete session garbage collector
Date:   Fri, 20 Oct 2023 12:31:00 +0200
Message-ID: <a7a398265bf32e4ce9fd5ac807414c8de853fdb2.1697797423.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697797422.git.lorenzo@kernel.org>
References: <cover.1697797422.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce the capability to clear WED rro session configured in the hw
according to the event reported by the MCU firmware

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 52 +++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  3 +
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 89 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   | 35 ++++++++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    | 10 +++
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  6 ++
 8 files changed, 197 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 482a280b7c25..f88192c402e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -404,6 +404,7 @@ struct mt76_rx_tid {
 	spinlock_t lock;
 	struct delayed_work reorder_work;
 
+	u16 id;
 	u16 head;
 	u16 size;
 	u16 nframes;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 0563b1b22f48..97822f7d46cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1022,6 +1022,7 @@ enum {
 	MCU_UNI_EVENT_ROC = 0x27,
 	MCU_UNI_EVENT_TX_DONE = 0x2d,
 	MCU_UNI_EVENT_NIC_CAPAB = 0x43,
+	MCU_UNI_EVENT_WED_RRO = 0x57,
 	MCU_UNI_EVENT_PER_STA_INFO = 0x6d,
 	MCU_UNI_EVENT_ALL_STA_INFO = 0x6e,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index a1adbc65ae00..5af85ddfdc36 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -641,6 +641,54 @@ static void mt7996_wed_rro_free(struct mt7996_dev *dev)
 #endif
 }
 
+static void mt7996_wed_rro_work(struct work_struct *work)
+{
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	struct mt7996_dev *dev;
+	LIST_HEAD(list);
+
+	dev = (struct mt7996_dev *)container_of(work, struct mt7996_dev,
+						wed_rro.work);
+
+	spin_lock_bh(&dev->wed_rro.lock);
+	list_splice_init(&dev->wed_rro.poll_list, &list);
+	spin_unlock_bh(&dev->wed_rro.lock);
+
+	while (!list_empty(&list)) {
+		struct mt7996_wed_rro_session_id *e;
+		int i;
+
+		e = list_first_entry(&list, struct mt7996_wed_rro_session_id,
+				     list);
+		list_del_init(&e->list);
+
+		for (i = 0; i < MT7996_RRO_WINDOW_MAX_LEN; i++) {
+			void *ptr = dev->wed_rro.session.ptr;
+			struct mt7996_wed_rro_addr *elem;
+			u32 idx, elem_id = i;
+
+			if (e->id == MT7996_RRO_MAX_SESSION)
+				goto reset;
+
+			idx = e->id / MT7996_RRO_BA_BITMAP_SESSION_SIZE;
+			if (idx >= ARRAY_SIZE(dev->wed_rro.addr_elem))
+				goto out;
+
+			ptr = dev->wed_rro.addr_elem[idx].ptr;
+			elem_id +=
+				(e->id % MT7996_RRO_BA_BITMAP_SESSION_SIZE) *
+				MT7996_RRO_WINDOW_MAX_LEN;
+reset:
+			elem = ptr + elem_id * sizeof(*elem);
+			elem->signature = 0xff;
+		}
+		mt7996_mcu_wed_rro_reset_sessions(dev, e->id);
+out:
+		kfree(e);
+	}
+#endif
+}
+
 static int mt7996_init_hardware(struct mt7996_dev *dev)
 {
 	int ret, idx;
@@ -648,6 +696,9 @@ static int mt7996_init_hardware(struct mt7996_dev *dev)
 	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
 
 	INIT_WORK(&dev->init_work, mt7996_init_work);
+	INIT_WORK(&dev->wed_rro.work, mt7996_wed_rro_work);
+	INIT_LIST_HEAD(&dev->wed_rro.poll_list);
+	spin_lock_init(&dev->wed_rro.lock);
 
 	dev->dbdc_support = true;
 	dev->tbtc_support = true;
@@ -1100,6 +1151,7 @@ int mt7996_register_device(struct mt7996_dev *dev)
 
 void mt7996_unregister_device(struct mt7996_dev *dev)
 {
+	cancel_work_sync(&dev->wed_rro.work);
 	mt7996_unregister_phy(mt7996_phy3(dev), MT_BAND2);
 	mt7996_unregister_phy(mt7996_phy2(dev), MT_BAND1);
 	mt7996_coredump_unregister(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 236a88b50e97..7e896af29404 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1822,6 +1822,7 @@ mt7996_mac_full_reset(struct mt7996_dev *dev)
 	if (phy3)
 		ieee80211_stop_queues(phy3->mt76->hw);
 
+	cancel_work_sync(&dev->wed_rro.work);
 	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	if (phy2)
 		cancel_delayed_work_sync(&phy2->mt76->mac_work);
@@ -1920,6 +1921,8 @@ void mt7996_mac_reset_work(struct work_struct *work)
 	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
+
+	cancel_work_sync(&dev->wed_rro.work);
 	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	if (phy2) {
 		set_bit(MT76_RESET, &phy2->mt76->state);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 5369f0a7800c..61de5e041627 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -526,6 +526,73 @@ mt7996_mcu_rx_unsolicited_event(struct mt7996_dev *dev, struct sk_buff *skb)
 	dev_kfree_skb(skb);
 }
 
+static void
+mt7996_mcu_wed_rro_event(struct mt7996_dev *dev, struct sk_buff *skb)
+{
+	struct mt7996_mcu_wed_rro_event *event = (void *)skb->data;
+
+	if (!dev->has_rro)
+		return;
+
+	skb_pull(skb, sizeof(struct mt7996_mcu_rxd) + 4);
+
+	switch (event->tag) {
+	case UNI_WED_RRO_BA_SESSION_STATUS: {
+		struct mt7996_mcu_wed_rro_ba_event *e;
+
+		while (skb->len >= sizeof(*e)) {
+			struct mt76_rx_tid *tid;
+			struct mt76_wcid *wcid;
+			u16 idx;
+
+			e = (void *)skb->data;
+			idx = le16_to_cpu(e->wlan_id);
+			if (idx >= ARRAY_SIZE(dev->mt76.wcid))
+				break;
+
+			wcid = rcu_dereference(dev->mt76.wcid[idx]);
+			if (!wcid || !wcid->sta)
+				break;
+
+			if (e->tid >= ARRAY_SIZE(wcid->aggr))
+				break;
+
+			tid = rcu_dereference(wcid->aggr[e->tid]);
+			if (!tid)
+				break;
+
+			tid->id = le16_to_cpu(e->id);
+			skb_pull(skb, sizeof(*e));
+		}
+		break;
+	}
+	case UNI_WED_RRO_BA_SESSION_DELETE: {
+		struct mt7996_mcu_wed_rro_ba_delete_event *e;
+
+		while (skb->len >= sizeof(*e)) {
+			struct mt7996_wed_rro_session_id *session;
+
+			e = (void *)skb->data;
+			session = kzalloc(sizeof(*session), GFP_ATOMIC);
+			if (!session)
+				break;
+
+			session->id = le16_to_cpu(e->session_id);
+
+			spin_lock_bh(&dev->wed_rro.lock);
+			list_add_tail(&session->list, &dev->wed_rro.poll_list);
+			spin_unlock_bh(&dev->wed_rro.lock);
+
+			ieee80211_queue_work(mt76_hw(dev), &dev->wed_rro.work);
+			skb_pull(skb, sizeof(*e));
+		}
+		break;
+	}
+	default:
+		break;
+	}
+}
+
 static void
 mt7996_mcu_uni_rx_unsolicited_event(struct mt7996_dev *dev, struct sk_buff *skb)
 {
@@ -544,6 +611,9 @@ mt7996_mcu_uni_rx_unsolicited_event(struct mt7996_dev *dev, struct sk_buff *skb)
 	case MCU_UNI_EVENT_ALL_STA_INFO:
 		mt7996_mcu_rx_all_sta_info_event(dev, skb);
 		break;
+	case MCU_UNI_EVENT_WED_RRO:
+		mt7996_mcu_wed_rro_event(dev, skb);
+		break;
 	default:
 		break;
 	}
@@ -4087,3 +4157,22 @@ int mt7996_mcu_get_all_sta_info(struct mt7996_phy *phy, u16 tag)
 	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(ALL_STA_INFO),
 				 &req, sizeof(req), false);
 }
+
+int mt7996_mcu_wed_rro_reset_sessions(struct mt7996_dev *dev, u16 id)
+{
+	struct {
+		u8 __rsv[4];
+
+		__le16 tag;
+		__le16 len;
+		__le16 session_id;
+		u8 pad[4];
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_RRO_DEL_BA_SESSION),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.session_id = cpu_to_le16(id),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(RRO), &req,
+				 sizeof(req), true);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index a4715b8e005b..e32a78d6622b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -179,6 +179,41 @@ struct mt7996_mcu_all_sta_info_event {
 	};
 } __packed;
 
+struct mt7996_mcu_wed_rro_event {
+	struct mt7996_mcu_rxd rxd;
+
+	u8 __rsv1[4];
+
+	__le16 tag;
+	__le16 len;
+} __packed;
+
+struct mt7996_mcu_wed_rro_ba_event {
+	__le16 tag;
+	__le16 len;
+
+	__le16 wlan_id;
+	u8 tid;
+	u8 __rsv1;
+	__le32 status;
+	__le16 id;
+	u8 __rsv2[2];
+} __packed;
+
+struct mt7996_mcu_wed_rro_ba_delete_event {
+	__le16 tag;
+	__le16 len;
+
+	__le16 session_id;
+	u8 __rsv2[2];
+} __packed;
+
+enum  {
+	UNI_WED_RRO_BA_SESSION_STATUS,
+	UNI_WED_RRO_BA_SESSION_TBL,
+	UNI_WED_RRO_BA_SESSION_DELETE,
+};
+
 enum mt7996_chan_mib_offs {
 	UNI_MIB_OBSS_AIRTIME = 26,
 	UNI_MIB_NON_WIFI_TIME = 27,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index f7b6945b7acc..e7818b2b253f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -182,6 +182,11 @@ struct mt7996_wed_rro_addr {
 	u32 signature : 8;
 };
 
+struct mt7996_wed_rro_session_id {
+	struct list_head list;
+	u16 id;
+};
+
 struct mt7996_phy {
 	struct mt76_phy *mt76;
 	struct mt7996_dev *dev;
@@ -276,6 +281,10 @@ struct mt7996_dev {
 			void *ptr;
 			dma_addr_t phy_addr;
 		} session;
+
+		struct work_struct work;
+		struct list_head poll_list;
+		spinlock_t lock;
 	} wed_rro;
 
 	bool ibf;
@@ -456,6 +465,7 @@ int mt7996_mcu_trigger_assert(struct mt7996_dev *dev);
 void mt7996_mcu_rx_event(struct mt7996_dev *dev, struct sk_buff *skb);
 void mt7996_mcu_exit(struct mt7996_dev *dev);
 int mt7996_mcu_get_all_sta_info(struct mt7996_phy *phy, u16 tag);
+int mt7996_mcu_wed_rro_reset_sessions(struct mt7996_dev *dev, u16 id);
 
 static inline u8 mt7996_max_interface_num(struct mt7996_dev *dev)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 49eb583399c5..e9edba830aff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -71,6 +71,12 @@ enum base_rev {
 #define MT_RRO_ACK_SN_CTRL_SN_MASK		GENMASK(27, 16)
 #define MT_RRO_ACK_SN_CTRL_SESSION_MASK		GENMASK(11, 0)
 
+#define MT_RRO_DBG_RD_CTRL			MT_RRO_TOP(0xe0)
+#define MT_RRO_DBG_RD_ADDR			GENMASK(15, 0)
+#define MT_RRO_DBG_RD_EXEC			BIT(31)
+
+#define MT_RRO_DBG_RDAT_DW(_n)			MT_RRO_TOP(0xf0 + (_n) * 0x4)
+
 #define MT_MCU_INT_EVENT			0x2108
 #define MT_MCU_INT_EVENT_DMA_STOPPED		BIT(0)
 #define MT_MCU_INT_EVENT_DMA_INIT		BIT(1)
-- 
2.41.0

