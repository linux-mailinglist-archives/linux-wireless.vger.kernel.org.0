Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05153672E5
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 20:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbhDUSyZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 14:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235329AbhDUSyY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 14:54:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 512A761264;
        Wed, 21 Apr 2021 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619031230;
        bh=1+p5vdVBhW+06FGH6tWOGL+LR5rL8j8pyzNOuZjzfec=;
        h=From:To:Cc:Subject:Date:From;
        b=AfIU6jZ/JvJ0iSFtVnzrr2dV3PrQ5iqsJ2KRsC1/6jvygRYmeRm1lV8BwQnpRPoAk
         VPDv25d0zbJC8YumfsfYGAUD3t12XJBFcIn35PD8e0GPtrIbE9xNQYHNnIme/+bv+D
         cyjHOE/io+m/DmLIbEquID66+r+YdUaIuY7ItCjcoX7KNdfjliGxPXA+7NFyKr5rwD
         RwfJvTRyHZzf0PFfomADFqjIFw/YzYNujwUx7OBTTld+N2XrgKNW40csow8h0GaBcb
         4ZvkR8aZkkV7dqzG71L/Lqo3uO6IQquXDQKYePDUnZBoQadsLB/YtsB5QF+27WQuuZ
         6VU5IexDs22YA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH] mt76: connac: move mt76_connac_mcu_update_arp_filter out of CONFIG_PM
Date:   Wed, 21 Apr 2021 20:53:44 +0200
Message-Id: <21a240760e605cfc5e1eb080dd7e1a2a9ecdfc61.1619031176.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following compilation error when CONFIG_PM is not set
drivers/net/wireless/mediatek/mt76/mt7615/main.c:584: undefined reference to `mt76_connac_mcu_update_arp_filter'
drivers/net/wireless/mediatek/mt76/mt7921/main.c:635: undefined reference to `mt76_connac_mcu_update_arp_filter'

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 84 +++++++++----------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 5e75152405c2..6feb0db387dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1750,6 +1750,48 @@ void mt76_connac_mcu_roc_event(struct mt76_phy *phy,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_roc_event);
 
+int mt76_connac_mcu_update_arp_filter(struct mt76_dev *dev,
+				      struct mt76_vif *vif,
+				      struct ieee80211_bss_conf *info)
+{
+	struct sk_buff *skb;
+	int i, len = min_t(int, info->arp_addr_cnt,
+			   IEEE80211_BSS_ARP_ADDR_LIST_LEN);
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_arpns_tlv arp;
+	} req_hdr = {
+		.hdr = {
+			.bss_idx = vif->idx,
+		},
+		.arp = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ARP),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_arpns_tlv)),
+			.ips_num = len,
+			.mode = 2,  /* update */
+			.option = 1,
+		},
+	};
+
+	skb = mt76_mcu_msg_alloc(dev, NULL,
+				 sizeof(req_hdr) + len * sizeof(__be32));
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &req_hdr, sizeof(req_hdr));
+	for (i = 0; i < len; i++) {
+		u8 *addr = (u8 *)skb_put(skb, sizeof(__be32));
+
+		memcpy(addr, &info->arp_addr_list[i], sizeof(__be32));
+	}
+
+	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD_OFFLOAD, true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_update_arp_filter);
+
 #ifdef CONFIG_PM
 
 const struct wiphy_wowlan_support mt76_connac_wowlan_support = {
@@ -1859,48 +1901,6 @@ mt76_connac_mcu_set_arp_filter(struct mt76_dev *dev, struct ieee80211_vif *vif,
 				 true);
 }
 
-int mt76_connac_mcu_update_arp_filter(struct mt76_dev *dev,
-				      struct mt76_vif *vif,
-				      struct ieee80211_bss_conf *info)
-{
-	struct sk_buff *skb;
-	int i, len = min_t(int, info->arp_addr_cnt,
-			   IEEE80211_BSS_ARP_ADDR_LIST_LEN);
-	struct {
-		struct {
-			u8 bss_idx;
-			u8 pad[3];
-		} __packed hdr;
-		struct mt76_connac_arpns_tlv arp;
-	} req_hdr = {
-		.hdr = {
-			.bss_idx = vif->idx,
-		},
-		.arp = {
-			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ARP),
-			.len = cpu_to_le16(sizeof(struct mt76_connac_arpns_tlv)),
-			.ips_num = len,
-			.mode = 2,  /* update */
-			.option = 1,
-		},
-	};
-
-	skb = mt76_mcu_msg_alloc(dev, NULL,
-				 sizeof(req_hdr) + len * sizeof(__be32));
-	if (!skb)
-		return -ENOMEM;
-
-	skb_put_data(skb, &req_hdr, sizeof(req_hdr));
-	for (i = 0; i < len; i++) {
-		u8 *addr = (u8 *)skb_put(skb, sizeof(__be32));
-
-		memcpy(addr, &info->arp_addr_list[i], sizeof(__be32));
-	}
-
-	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD_OFFLOAD, true);
-}
-EXPORT_SYMBOL_GPL(mt76_connac_mcu_update_arp_filter);
-
 static int
 mt76_connac_mcu_set_gtk_rekey(struct mt76_dev *dev, struct ieee80211_vif *vif,
 			      bool suspend)
-- 
2.30.2

