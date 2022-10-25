Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DC960C0B8
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 03:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiJYBO7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 21:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiJYBOf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 21:14:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9C565F0
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 17:31:09 -0700 (PDT)
X-UUID: 17981f4668864a4386296d375c3edf20-20221025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Hfoh3gTks+PoKuD/YhCze4rtA1NKdyMWVodyLUoe7cU=;
        b=WZ6PigxrHv4cGKF2yfJSnmks/Ln1DBltw8C1mA/PERYSvSnqS3zcv+ZonCw/lO//EDJUYgdIZab0FS1CdYNyWZ+A17ChSl8DOaGFE0qSjWtp1Ev6aHhilcPSU9UQvgoz45t+3+1NfBVJxlDELrjpqvXWvo0/6wmTf4IXoygJ8yQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:a689d6b9-f191-43bf-b336-030f6529107b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:2b168cc8-03ab-4171-989e-341ab5339257,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 17981f4668864a4386296d375c3edf20-20221025
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 480552330; Tue, 25 Oct 2022 08:31:04 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 25 Oct 2022 08:31:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 25 Oct 2022 08:31:03 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] wifi: mt76: mt7615: enable use_cts_prot support
Date:   Tue, 25 Oct 2022 08:31:01 +0800
Message-ID: <4aff52fcb41b69e9305f3ef78459d4717817607c.1666657715.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <f13c8c4ae61eb1374ca65e92b03e908c21073917.1666657715.git.ryder.lee@mediatek.com>
References: <f13c8c4ae61eb1374ca65e92b03e908c21073917.1666657715.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This adds selectable RTC/CTS enablement for each interface.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Change-Id: Id36a67f1f1ef21e42cfbbe97a5a502b7a2c2d786
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c   | 15 +++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/main.c  |  3 +++
 .../net/wireless/mediatek/mt76/mt7615/mt7615.h    |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h  |  2 ++
 4 files changed, 22 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 2ce1705c0f43..45cad911687d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1177,6 +1177,21 @@ void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 }
 EXPORT_SYMBOL_GPL(mt7615_mac_set_rates);
 
+void mt7615_mac_enable_rtscts(struct mt7615_dev *dev,
+			      struct ieee80211_vif *vif, bool enable)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	u32 addr;
+
+	addr = mt7615_mac_wtbl_addr(dev, mvif->sta.wcid.idx) + 3 * 4;
+
+	if (enable)
+		mt76_set(dev, addr, MT_WTBL_W3_RTS);
+	else
+		mt76_clear(dev, addr, MT_WTBL_W3_RTS);
+}
+EXPORT_SYMBOL_GPL(mt7615_mac_enable_rtscts);
+
 static int
 mt7615_mac_wtbl_update_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 8d4733f87cda..98f9e2155009 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -572,6 +572,9 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 		}
 	}
 
+	if (changed & BSS_CHANGED_ERP_CTS_PROT)
+		mt7615_mac_enable_rtscts(dev, vif, info->use_cts_prot);
+
 	if (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon) {
 		mt7615_mcu_add_bss_info(phy, vif, NULL, true);
 		mt7615_mcu_sta_add(phy, vif, NULL, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 060d52c81d9e..f632e6a99038 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -473,6 +473,8 @@ void mt7615_mac_reset_counters(struct mt7615_dev *dev);
 void mt7615_mac_cca_stats_reset(struct mt7615_phy *phy);
 void mt7615_mac_set_scs(struct mt7615_phy *phy, bool enable);
 void mt7615_mac_enable_nf(struct mt7615_dev *dev, bool ext_phy);
+void mt7615_mac_enable_rtscts(struct mt7615_dev *dev,
+			      struct ieee80211_vif *vif, bool enable);
 void mt7615_mac_sta_poll(struct mt7615_dev *dev);
 int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 			  struct sk_buff *skb, struct mt76_wcid *wcid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 6712ad9faeaa..fa1b9b26b399 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -446,6 +446,8 @@ enum mt7615_reg_base {
 #define MT_WTBL_RIUCR3_RATE6		GENMASK(19, 8)
 #define MT_WTBL_RIUCR3_RATE7		GENMASK(31, 20)
 
+#define MT_WTBL_W3_RTS			BIT(22)
+
 #define MT_WTBL_W5_CHANGE_BW_RATE	GENMASK(7, 5)
 #define MT_WTBL_W5_SHORT_GI_20		BIT(8)
 #define MT_WTBL_W5_SHORT_GI_40		BIT(9)
-- 
2.36.1

