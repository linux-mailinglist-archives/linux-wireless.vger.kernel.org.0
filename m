Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357CC76B798
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjHAOeP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbjHAOeJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:34:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86771FF0
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:34:01 -0700 (PDT)
X-UUID: 6faf61c8307811eeb20a276fd37b9834-20230801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xdD3lbzW0D/9oomxCN16eTleOOdC7vYYUe/kJlTfSxY=;
        b=Gj8T4TX2a17Np+0b6ft2C5JFdCZ8zTSbG1LDINoVFJaY6i1EoHEmVZQ9IW6BwUkrbmMR8bhXOqsne+PkZG3KBmTYOiYQTBGsvz6RVm7Lg1F0R3rxWFOHmaw4+2/YxufnTZbdyZZ9jFydRNKIKPAVLCLGi6dYjLZU/DXeGa7gbqQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:63896996-889e-4ebd-ab5d-398715fa6190,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:1fcc6f8,CLOUDID:2efbc5a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6faf61c8307811eeb20a276fd37b9834-20230801
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 726114082; Tue, 01 Aug 2023 22:33:52 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Aug 2023 22:33:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 1 Aug 2023 22:33:51 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 1/8] wifi: mt76: connac: introduce helper for mt7925 chipset
Date:   Tue, 1 Aug 2023 22:30:25 +0800
Message-ID: <c5d2d448026513fec03855382dda9e33e63c1fe8.1690863143.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1690863143.git.deren.wu@mediatek.com>
References: <cover.1690863143.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce is_mt7925() helper for new chipset. mt7925 runs the same
firmware download and mmio map flow as mt7921.

This is a preliminary patch to support mt7925 driver.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h     | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 2 +-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 22878f088804..1f29d8cd900c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -172,6 +172,11 @@ struct mt76_connac_tx_free {
 
 extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
 
+static inline bool is_mt7925(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7925;
+}
+
 static inline bool is_mt7922(struct mt76_dev *dev)
 {
 	return mt76_chip(dev) == 0x7922;
@@ -245,6 +250,7 @@ static inline bool is_mt76_fw_txp(struct mt76_dev *dev)
 	switch (mt76_chip(dev)) {
 	case 0x7961:
 	case 0x7922:
+	case 0x7925:
 	case 0x7663:
 	case 0x7622:
 		return false;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index ee5177fd6dde..4e74861ee197 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -187,7 +187,7 @@ void mt76_connac_write_hw_txp(struct mt76_dev *dev,
 
 	txp->msdu_id[0] = cpu_to_le16(id | MT_MSDU_ID_VALID);
 
-	if (is_mt7663(dev) || is_mt7921(dev))
+	if (is_mt7663(dev) || is_mt7921(dev) || is_mt7925(dev))
 		last_mask = MT_TXD_LEN_LAST;
 	else
 		last_mask = MT_TXD_LEN_AMSDU_LAST |
@@ -231,7 +231,7 @@ mt76_connac_txp_skb_unmap_hw(struct mt76_dev *dev,
 	u32 last_mask;
 	int i;
 
-	if (is_mt7663(dev) || is_mt7921(dev))
+	if (is_mt7663(dev) || is_mt7921(dev) || is_mt7925(dev))
 		last_mask = MT_TXD_LEN_LAST;
 	else
 		last_mask = MT_TXD_LEN_MSDU_LAST;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 0f0a519f956f..21456692e790 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -66,6 +66,7 @@ int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
 
 	if ((!is_connac_v1(dev) && addr == MCU_PATCH_ADDRESS) ||
 	    (is_mt7921(dev) && addr == 0x900000) ||
+	    (is_mt7925(dev) && addr == 0x900000) ||
 	    (is_mt7996(dev) && addr == 0x900000))
 		cmd = MCU_CMD(PATCH_START_REQ);
 	else
@@ -3064,7 +3065,7 @@ static u32 mt76_connac2_get_data_mode(struct mt76_dev *dev, u32 info)
 {
 	u32 mode = DL_MODE_NEED_RSP;
 
-	if (!is_mt7921(dev) || info == PATCH_SEC_NOT_SUPPORT)
+	if ((!is_mt7921(dev) && !is_mt7925(dev)) || info == PATCH_SEC_NOT_SUPPORT)
 		return mode;
 
 	switch (FIELD_GET(PATCH_SEC_ENC_TYPE_MASK, info)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 4543e5bf0482..19be8556cd3c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1739,7 +1739,7 @@ mt76_connac_mcu_gen_dl_mode(struct mt76_dev *dev, u8 feature_set, bool is_wa)
 
 	ret |= feature_set & FW_FEATURE_SET_ENCRYPT ?
 	       DL_MODE_ENCRYPT | DL_MODE_RESET_SEC_IV : 0;
-	if (is_mt7921(dev))
+	if (is_mt7921(dev) || is_mt7925(dev))
 		ret |= feature_set & FW_FEATURE_ENCRY_MODE ?
 		       DL_CONFIG_ENCRY_MODE_SEL : 0;
 	ret |= FIELD_PREP(DL_MODE_KEY_IDX,
-- 
2.18.0

