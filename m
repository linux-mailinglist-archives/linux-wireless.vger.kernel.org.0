Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026D5662C26
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 18:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjAIRGr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 12:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjAIQ6S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 11:58:18 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36238FC0
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 08:58:16 -0800 (PST)
X-UUID: f722288b34574e7291112a14711c3d01-20230110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0cx4i5kq2axNbLApFo03m1fGOc9QlXWO4hFEwYrzipY=;
        b=XoL9gfuY+ap/Zp+ErPuuY+hMh+ytKRiQ+Z2P2uCNeCKsVKNpQ1fU7kAM3hogSvJnLigmFZ3INoSwoQ2Ox4X0Qt3kxzdfuIyEqToM0ZVvpNLq3+XW2VEsjokltQ+2Opx+bxwv6x1tRzpstXG7l4BmsyVFw72EHFMtdnD37vo4lo4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:39a96d38-3370-46fa-a2b6-ff7e981f92ab,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.17,REQID:39a96d38-3370-46fa-a2b6-ff7e981f92ab,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:543e81c,CLOUDID:34edbb8b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230110005809TNZBEUCO,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0
X-CID-BVR: 0,NGT
X-UUID: f722288b34574e7291112a14711c3d01-20230110
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1871281923; Tue, 10 Jan 2023 00:58:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 10 Jan 2023 00:58:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 10 Jan 2023 00:58:05 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 08/13] wifi: mt76: mt7996: add helpers for wtbl and interface limit
Date:   Tue, 10 Jan 2023 00:57:26 +0800
Message-ID: <20230109165731.682-9-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230109165731.682-1-shayne.chen@mediatek.com>
References: <20230109165731.682-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add helpers to get the maximum wtbl size and interface num based
on hw caps.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/init.c    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c    |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/mt7996.h  | 17 +++++++++++++----
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 7a9692a66ed8..6bcf2649d8df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -256,7 +256,7 @@ static void mt7996_mac_init(struct mt7996_dev *dev)
 
 	mt76_clear(dev, MT_MDP_DCR2, MT_MDP_DCR2_RX_TRANS_SHORT);
 
-	for (i = 0; i < MT7996_WTBL_SIZE; i++)
+	for (i = 0; i < mt7996_wtbl_size(dev); i++)
 		mt7996_mac_wtbl_update(dev, i,
 				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index ce4242f90e9f..31e6c48985d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1486,7 +1486,7 @@ static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
 	if (pid < MT_PACKET_ID_FIRST)
 		return;
 
-	if (wcidx >= MT7996_WTBL_SIZE)
+	if (wcidx >= mt7996_wtbl_size(dev))
 		return;
 
 	rcu_read_lock();
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 9ea2e1198477..58f9ea0125e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -170,7 +170,7 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 		phy->monitor_vif = vif;
 
 	mvif->mt76.idx = __ffs64(~dev->mt76.vif_mask);
-	if (mvif->mt76.idx >= (MT7996_MAX_INTERFACES << dev->dbdc_support)) {
+	if (mvif->mt76.idx >= mt7996_max_interface_num(dev)) {
 		ret = -ENOSPC;
 		goto out;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 00f3beda74cc..b919a7bc606b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -11,12 +11,11 @@
 #include "../mt76_connac.h"
 #include "regs.h"
 
-#define MT7996_MAX_INTERFACES		19
+#define MT7996_MAX_INTERFACES		19	/* per-band */
 #define MT7996_MAX_WMM_SETS		4
-#define MT7996_WTBL_SIZE		544
-#define MT7996_WTBL_RESERVED		(MT7996_WTBL_SIZE - 1)
+#define MT7996_WTBL_RESERVED		(mt7996_wtbl_size(dev) - 1)
 #define MT7996_WTBL_STA			(MT7996_WTBL_RESERVED - \
-					 MT7996_MAX_INTERFACES)
+					 mt7996_max_interface_num(dev))
 
 #define MT7996_WATCHDOG_TIME		(HZ / 10)
 #define MT7996_RESET_TIMEOUT		(30 * HZ)
@@ -447,6 +446,16 @@ int mt7996_mcu_fw_dbg_ctrl(struct mt7996_dev *dev, u32 module, u8 level);
 void mt7996_mcu_rx_event(struct mt7996_dev *dev, struct sk_buff *skb);
 void mt7996_mcu_exit(struct mt7996_dev *dev);
 
+static inline u8 mt7996_max_interface_num(struct mt7996_dev *dev)
+{
+	return MT7996_MAX_INTERFACES * (1 + dev->dbdc_support + dev->tbtc_support);
+}
+
+static inline u16 mt7996_wtbl_size(struct mt7996_dev *dev)
+{
+	return (dev->wtbl_size_group << 8) + 64;
+}
+
 void mt7996_dual_hif_set_irq_mask(struct mt7996_dev *dev, bool write_reg,
 				  u32 clear, u32 set);
 
-- 
2.25.1

