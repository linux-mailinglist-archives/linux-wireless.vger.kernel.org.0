Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563AE654F11
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Dec 2022 11:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiLWKQt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Dec 2022 05:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiLWKQm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Dec 2022 05:16:42 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34031C117
        for <linux-wireless@vger.kernel.org>; Fri, 23 Dec 2022 02:16:40 -0800 (PST)
X-UUID: cdb4a5d009d6441c844c71543034ce44-20221223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hy0CmzTQE73ei2a3CPbMsjO25cSAWzLtKhHWkwKDlac=;
        b=KwrQlALDb68ZD4kA/fCLFSstg0Ym8MrL7S6/BaoCQjA8shtpUAEEH+723l0v4EJdhiT9cSoTj+nN1EoC4eXFB0zYYfHJULO+oAis+qjC/6+wv1Skq+jgz4rfdtdzSAN8S/DzyHOZR0GWdQOwSth+V9j1iiqklhhfSVt7YZCp1lM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:fe62eef4-b911-4d51-91a2-4681aef45d9e,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.14,REQID:fe62eef4-b911-4d51-91a2-4681aef45d9e,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:dcaaed0,CLOUDID:218dc7f3-ff42-4fb0-b929-626456a83c14,B
        ulkID:221223181634Q29SJXWV,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: cdb4a5d009d6441c844c71543034ce44-20221223
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1905078482; Fri, 23 Dec 2022 18:16:31 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 23 Dec 2022 18:16:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 23 Dec 2022 18:16:30 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 2/4] wifi: mt76: mt7996: update register for CFEND_RATE
Date:   Fri, 23 Dec 2022 18:13:46 +0800
Message-ID: <20221223101348.11504-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221223101348.11504-1-shayne.chen@mediatek.com>
References: <20221223101348.11504-1-shayne.chen@mediatek.com>
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

In newer chipsets, CFEND_RATE setting has been moved to different hw
module.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h | 15 ++++++++-------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 0b3e28748e76..ce4242f90e9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1690,7 +1690,7 @@ void mt7996_mac_set_timing(struct mt7996_phy *phy)
 	else
 		val = MT7996_CFEND_RATE_11B;
 
-	mt76_rmw_field(dev, MT_AGG_ACR0(band_idx), MT_AGG_ACR_CFEND_RATE, val);
+	mt76_rmw_field(dev, MT_RATE_HRCR0(band_idx), MT_RATE_HRCR0_CFEND_RATE, val);
 	mt76_clear(dev, MT_ARB_SCR(band_idx),
 		   MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 60781d046216..d8a2c1a744b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -21,6 +21,7 @@ static const struct __base mt7996_reg_base[] = {
 	[WF_ETBF_BASE]		= { { 0x820ea000, 0x820fa000, 0x830ea000 } },
 	[WF_LPON_BASE]		= { { 0x820eb000, 0x820fb000, 0x830eb000 } },
 	[WF_MIB_BASE]		= { { 0x820ed000, 0x820fd000, 0x830ed000 } },
+	[WF_RATE_BASE]		= { { 0x820ee000, 0x820fe000, 0x830ee000 } },
 };
 
 static const struct __map mt7996_reg_map[] = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 42980b97b4d4..7a28cae34e34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -33,6 +33,7 @@ enum base_rev {
 	WF_ETBF_BASE,
 	WF_LPON_BASE,
 	WF_MIB_BASE,
+	WF_RATE_BASE,
 	__MT_REG_BASE_MAX,
 };
 
@@ -235,13 +236,6 @@ enum base_rev {
 						 FIELD_PREP(MT_WTBL_LMAC_ID, _id) | \
 						 FIELD_PREP(MT_WTBL_LMAC_DW, _dw))
 
-/* AGG: band 0(0x820e2000), band 1(0x820f2000), band 2(0x830e2000) */
-#define MT_WF_AGG_BASE(_band)			__BASE(WF_AGG_BASE, (_band))
-#define MT_WF_AGG(_band, ofs)			(MT_WF_AGG_BASE(_band) + (ofs))
-
-#define MT_AGG_ACR0(_band)			MT_WF_AGG(_band, 0x054)
-#define MT_AGG_ACR_CFEND_RATE			GENMASK(13, 0)
-
 /* ARB: band 0(0x820e3000), band 1(0x820f3000), band 2(0x830e3000) */
 #define MT_WF_ARB_BASE(_band)			__BASE(WF_ARB_BASE, (_band))
 #define MT_WF_ARB(_band, ofs)			(MT_WF_ARB_BASE(_band) + (ofs))
@@ -300,6 +294,13 @@ enum base_rev {
 #define MT_WF_RMAC_RSVD0(_band)			MT_WF_RMAC(_band, 0x03e0)
 #define MT_WF_RMAC_RSVD0_EIFS_CLR		BIT(21)
 
+/* RATE: band 0(0x820ee000), band 1(0x820fe000), band 2(0x830ee000) */
+#define MT_WF_RATE_BASE(_band)			__BASE(WF_RATE_BASE, (_band))
+#define MT_WF_RATE(_band, ofs)			(MT_WF_RATE_BASE(_band) + (ofs))
+
+#define MT_RATE_HRCR0(_band)			MT_WF_RATE(_band, 0x050)
+#define MT_RATE_HRCR0_CFEND_RATE		GENMASK(14, 0)
+
 /* WFDMA0 */
 #define MT_WFDMA0_BASE				0xd4000
 #define MT_WFDMA0(ofs)				(MT_WFDMA0_BASE + (ofs))
-- 
2.25.1

