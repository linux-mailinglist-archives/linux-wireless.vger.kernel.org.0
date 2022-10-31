Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4D9613B7C
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Oct 2022 17:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiJaQk3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Oct 2022 12:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiJaQk0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Oct 2022 12:40:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDBC2DC3
        for <linux-wireless@vger.kernel.org>; Mon, 31 Oct 2022 09:40:21 -0700 (PDT)
X-UUID: 748114b388f7417c9494653e91e06ff0-20221101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=f5Y/njI4qNgjO+Lt3Iai2beqZSAc9SoasK098zh6e4Q=;
        b=V5+FVVNisGzXtMTO8N3MQcMMtmgQUJnAx7pRgbuqdGFBjelzpK0S8FpcD3duO2PGbL6uCeZzbIqxjlwaQa0+2HZ3s9mRFmGtUJiOwL7+Av2HVhHxBmksV9ctQnWHxaJgqtPe5G+3RKPFooVPJwdp1myMLmNaNfbGlbttQ6DhfKU=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:379051dc-916e-4b23-b9e7-afd423d4e241,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.12,REQID:379051dc-916e-4b23-b9e7-afd423d4e241,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:62cd327,CLOUDID:17152d81-3116-4fbc-b86b-83475c3df513,B
        ulkID:221101004015BHQTOZI1,BulkQuantity:0,Recheck:0,SF:28|16|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 748114b388f7417c9494653e91e06ff0-20221101
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1202499422; Tue, 01 Nov 2022 00:40:12 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 1 Nov 2022 00:40:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 1 Nov 2022 00:40:11 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH 02/10] wifi: mt76: connac: rework macros for unified command
Date:   Tue, 1 Nov 2022 00:39:52 +0800
Message-ID: <20221031164000.17063-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221031164000.17063-1-shayne.chen@mediatek.com>
References: <20221031164000.17063-1-shayne.chen@mediatek.com>
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

Rework some macros for connac3 unified command.
This is a preliminary patch to add mt7996 chipset support.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h   | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 8166722d4717..d3d5ba2d47ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -63,7 +63,7 @@ struct mt76_connac2_mcu_txd {
 } __packed __aligned(4);
 
 /**
- * struct mt76_connac2_mcu_uni_txd - mcu command descriptor for firmware v3
+ * struct mt76_connac2_mcu_uni_txd - mcu command descriptor for connac2 and connac3
  * @txd: hardware descriptor
  * @len: total length not including txd
  * @cid: command identifier
@@ -1074,10 +1074,11 @@ enum {
 
 #define MCU_CMD_ACK				BIT(0)
 #define MCU_CMD_UNI				BIT(1)
-#define MCU_CMD_QUERY				BIT(2)
+#define MCU_CMD_SET				BIT(2)
 
 #define MCU_CMD_UNI_EXT_ACK			(MCU_CMD_ACK | MCU_CMD_UNI | \
-						 MCU_CMD_QUERY)
+						 MCU_CMD_SET)
+#define MCU_CMD_UNI_QUERY_ACK			(MCU_CMD_ACK | MCU_CMD_UNI)
 
 #define __MCU_CMD_FIELD_ID			GENMASK(7, 0)
 #define __MCU_CMD_FIELD_EXT_ID			GENMASK(15, 8)
@@ -1085,6 +1086,7 @@ enum {
 #define __MCU_CMD_FIELD_UNI			BIT(17)
 #define __MCU_CMD_FIELD_CE			BIT(18)
 #define __MCU_CMD_FIELD_WA			BIT(19)
+#define __MCU_CMD_FIELD_WM			BIT(20)
 
 #define MCU_CMD(_t)				FIELD_PREP(__MCU_CMD_FIELD_ID,		\
 							   MCU_CMD_##_t)
@@ -1106,6 +1108,16 @@ enum {
 						 FIELD_PREP(__MCU_CMD_FIELD_EXT_ID, \
 							    MCU_WA_PARAM_CMD_##_t))
 
+#define MCU_WM_UNI_CMD(_t)			(MCU_UNI_CMD(_t) |		\
+						 __MCU_CMD_FIELD_WM)
+#define MCU_WM_UNI_CMD_QUERY(_t)		(MCU_UNI_CMD(_t) |		\
+						 __MCU_CMD_FIELD_QUERY |	\
+						 __MCU_CMD_FIELD_WM)
+#define MCU_WA_UNI_CMD(_t)			(MCU_UNI_CMD(_t) |		\
+						 __MCU_CMD_FIELD_WA)
+#define MCU_WMWA_UNI_CMD(_t)			(MCU_WM_UNI_CMD(_t) |		\
+						 __MCU_CMD_FIELD_WA)
+
 enum {
 	MCU_EXT_CMD_EFUSE_ACCESS = 0x01,
 	MCU_EXT_CMD_RF_REG_ACCESS = 0x02,
-- 
2.25.1

