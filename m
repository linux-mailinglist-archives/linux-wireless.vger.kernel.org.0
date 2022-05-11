Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AE2524085
	for <lists+linux-wireless@lfdr.de>; Thu, 12 May 2022 01:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348991AbiEKXGt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 May 2022 19:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348992AbiEKXGr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 May 2022 19:06:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F28C58E78
        for <linux-wireless@vger.kernel.org>; Wed, 11 May 2022 16:06:46 -0700 (PDT)
X-UUID: a699043d41874012a1ac4fa8184518d5-20220512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:b8fdebb4-7d1f-4cde-a936-682c15338f09,OB:0,LO
        B:0,IP:0,URL:35,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:15
X-CID-META: VersionHash:faefae9,CLOUDID:bd4d24e6-38f2-431d-8de7-bf8fac490b0a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: a699043d41874012a1ac4fa8184518d5-20220512
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1481564193; Thu, 12 May 2022 07:06:40 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 12 May 2022 07:06:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 May 2022 07:06:39 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 12 May 2022 07:06:39 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Deren Wu" <deren.wu@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH v2 2/2] mt76: mt7921: add ipv6 NS offload support
Date:   Thu, 12 May 2022 07:06:36 +0800
Message-ID: <c2f708be2647783c97e597991111826292016917.1652310294.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <51d96f159ec37c2610d3c444177508ffc7781e2c.1652310294.git.objelf@gmail.com>
References: <51d96f159ec37c2610d3c444177508ffc7781e2c.1652310294.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Add ipv6 NS offload for WoWLAN state.

Tested in this way:
1. Put device-A into WoW state.
2. ping6 from device-B to device-A.
3. In sniffer, see Neighbour advertisement from device-A.

Reviewed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2: fix we cannot allocate skb with GFP_KERNEL in softirq context
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  4 ++
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 26 +++++++
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 67 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 44 ++++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  8 +++
 5 files changed, 148 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index f9e1255bd9c7..4a8675634f80 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -264,6 +264,10 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7921_mac_work);
 	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7921_scan_work);
 	INIT_DELAYED_WORK(&dev->coredump.work, mt7921_coredump_work);
+#if IS_ENABLED(CONFIG_IPV6)
+	INIT_WORK(&dev->ipv6_ns_work, mt7921_set_ipv6_ns_work);
+	skb_queue_head_init(&dev->ipv6_ns_list);
+#endif
 	skb_queue_head_init(&dev->phy.scan_event_list);
 	skb_queue_head_init(&dev->coredump.msg_list);
 	INIT_LIST_HEAD(&dev->sta_poll_list);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index e67c3d17d36c..a630ddbf19e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1726,3 +1726,29 @@ bool mt7921_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update)
 	return false;
 }
 EXPORT_SYMBOL_GPL(mt7921_usb_sdio_tx_status_data);
+
+#if IS_ENABLED(CONFIG_IPV6)
+void mt7921_set_ipv6_ns_work(struct work_struct *work)
+{
+	struct mt7921_dev *dev = container_of(work, struct mt7921_dev,
+						ipv6_ns_work);
+	struct sk_buff *skb;
+	int ret = 0;
+
+	do {
+		skb = skb_dequeue(&dev->ipv6_ns_list);
+
+		if (!skb)
+			break;
+
+		mt7921_mutex_acquire(dev);
+		ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+					    MCU_UNI_CMD(OFFLOAD), true);
+		mt7921_mutex_release(dev);
+
+	} while (!ret);
+
+	if (ret)
+		skb_queue_purge(&dev->ipv6_ns_list);
+}
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index e3db08e3a79f..80279f342109 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -5,6 +5,7 @@
 #include <linux/platform_device.h>
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <net/ipv6.h>
 #include "mt7921.h"
 #include "mcu.h"
 
@@ -1332,7 +1333,7 @@ static int mt7921_suspend(struct ieee80211_hw *hw,
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
-					    mt76_connac_mcu_set_suspend_iter,
+					    mt7921_mcu_set_suspend_iter,
 					    &dev->mphy);
 
 	mt7921_mutex_release(dev);
@@ -1407,6 +1408,67 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 					     MCU_UNI_CMD(STA_REC_UPDATE));
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
+static void mt7921_ipv6_addr_change(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct inet6_dev *idev)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mvif->phy->dev;
+	struct inet6_ifaddr *ifa;
+	struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
+	struct sk_buff *skb;
+	u8 i, idx = 0;
+
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_arpns_tlv arpns;
+	} req_hdr = {
+		.hdr = {
+			.bss_idx = mvif->mt76.idx,
+		},
+		.arpns = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ND),
+			.mode = 2,  /* update */
+			.option = 1, /* update only */
+		},
+	};
+
+	read_lock_bh(&idev->lock);
+	list_for_each_entry(ifa, &idev->addr_list, if_list) {
+		if (ifa->flags & IFA_F_TENTATIVE)
+			continue;
+		ns_addrs[idx] = ifa->addr;
+		if (++idx >= IEEE80211_BSS_ARP_ADDR_LIST_LEN)
+			break;
+	}
+	read_unlock_bh(&idev->lock);
+
+	if (!idx)
+		return;
+
+	skb = __mt76_mcu_msg_alloc(&dev->mt76, NULL, sizeof(req_hdr) +
+				   idx * sizeof(struct in6_addr), GFP_ATOMIC);
+	if (!skb)
+		return;
+
+	req_hdr.arpns.ips_num = idx;
+	req_hdr.arpns.len = cpu_to_le16(sizeof(struct mt76_connac_arpns_tlv)
+					+ idx * sizeof(struct in6_addr));
+	skb_put_data(skb, &req_hdr, sizeof(req_hdr));
+
+	for (i = 0; i < idx; i++)
+		skb_put_data(skb, &ns_addrs[i].in6_u, sizeof(struct in6_addr));
+
+	skb_queue_tail(&dev->ipv6_ns_list, skb);
+
+	ieee80211_queue_work(dev->mt76.hw, &dev->ipv6_ns_work);
+}
+#endif
+
 static int mt7921_set_sar_specs(struct ieee80211_hw *hw,
 				const struct cfg80211_sar_specs *sar)
 {
@@ -1452,6 +1514,9 @@ const struct ieee80211_ops mt7921_ops = {
 	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
 	.set_key = mt7921_set_key,
 	.sta_set_decap_offload = mt7921_sta_set_decap_offload,
+#if IS_ENABLED(CONFIG_IPV6)
+	.ipv6_addr_change = mt7921_ipv6_addr_change,
+#endif /* CONFIG_IPV6 */
 	.ampdu_action = mt7921_ampdu_action,
 	.set_rts_threshold = mt7921_set_rts_threshold,
 	.wake_tx_queue = mt76_wake_tx_queue,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 1ecbbe4fa498..ee3c2c09cd27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -224,6 +224,50 @@ int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(mt7921_mcu_fill_message);
 
+#ifdef CONFIG_PM
+
+static int
+mt7921_mcu_set_ipv6_ns_filter(struct mt76_dev *dev,
+			      struct ieee80211_vif *vif, bool suspend)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_arpns_tlv arpns;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->mt76.idx,
+		},
+		.arpns = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ND),
+			.len =
+			      cpu_to_le16(sizeof(struct mt76_connac_arpns_tlv)),
+			.mode = suspend,
+		},
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD_OFFLOAD, &req, sizeof(req),
+				 true);
+}
+
+void mt7921_mcu_set_suspend_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	if (IS_ENABLED(CONFIG_IPV6)) {
+		struct mt76_phy *phy = priv;
+
+		mt7921_mcu_set_ipv6_ns_filter(phy->dev, vif,
+					      !test_bit(MT76_STATE_RUNNING,
+					      &phy->state));
+	}
+
+	mt76_connac_mcu_set_suspend_iter(priv, mac, vif);
+}
+
+#endif /* CONFIG_PM */
+
 static void
 mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index adbdb2e22934..5ca584bb2fc6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -211,6 +211,10 @@ struct mt7921_dev {
 	struct mt76_connac_pm pm;
 	struct mt76_connac_coredump coredump;
 	const struct mt7921_hif_ops *hif_ops;
+
+	struct work_struct ipv6_ns_work;
+	/* IPv6 addresses for WoWLAN */
+	struct sk_buff_head ipv6_ns_list;
 };
 
 enum {
@@ -449,6 +453,10 @@ int mt7921s_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921s_mcu_fw_pmctrl(struct mt7921_dev *dev);
 void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data);
 void mt7921_set_runtime_pm(struct mt7921_dev *dev);
+void mt7921_mcu_set_suspend_iter(void *priv, u8 *mac,
+				 struct ieee80211_vif *vif);
+void mt7921_set_ipv6_ns_work(struct work_struct *work);
+
 int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 			   bool enable);
 
-- 
2.25.1

