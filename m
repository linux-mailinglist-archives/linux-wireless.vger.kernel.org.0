Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0039623EBE
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 10:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiKJJhH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 04:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiKJJhE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 04:37:04 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B2067F63
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 01:37:00 -0800 (PST)
X-UUID: a23b0204e14c42b9a6f6653bf67d9150-20221110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nBCva3G+06WUJe/qtm7fbPHRrGmZg1th2u2GfqaNd1E=;
        b=OX8AD3+x/BEJMKmKSIDk1U5+jW40r4mpw9ervgzO1K02IWRICzj/xi1aMlGECmbrh5WJseDSVdgGOrdZAupqgslopqz5Wd7bwEnKrQV5DZ9fezesKeJSuDC/DJNU49i8BbzLBvRMpZnxmNB5Nv4QoC/Ag5JQ51iRka0duJR+mpU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:76c08a4e-c2f2-4d07-b44a-03207b82420b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:b8d9e485-088c-4756-8f76-577be701e693,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a23b0204e14c42b9a6f6653bf67d9150-20221110
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2000968775; Thu, 10 Nov 2022 17:36:52 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 10 Nov 2022 17:36:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 10 Nov 2022 17:36:51 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 4/9] wifi: mt76: connac: add more unified command IDs
Date:   Thu, 10 Nov 2022 17:35:20 +0800
Message-ID: <20221110093525.29649-5-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221110093525.29649-1-shayne.chen@mediatek.com>
References: <20221110093525.29649-1-shayne.chen@mediatek.com>
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

Add more unified command IDs which will be used in new chipset.
This is the preliminary patch for mt7996 support.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 9cca73df6644..f8f974f36554 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1172,10 +1172,32 @@ enum {
 	MCU_UNI_CMD_DEV_INFO_UPDATE = 0x01,
 	MCU_UNI_CMD_BSS_INFO_UPDATE = 0x02,
 	MCU_UNI_CMD_STA_REC_UPDATE = 0x03,
+	MCU_UNI_CMD_EDCA_UPDATE = 0x04,
 	MCU_UNI_CMD_SUSPEND = 0x05,
 	MCU_UNI_CMD_OFFLOAD = 0x06,
 	MCU_UNI_CMD_HIF_CTRL = 0x07,
+	MCU_UNI_CMD_BAND_CONFIG = 0x08,
+	MCU_UNI_CMD_REPT_MUAR = 0x09,
+	MCU_UNI_CMD_WSYS_CONFIG = 0x0b,
+	MCU_UNI_CMD_REG_ACCESS = 0x0d,
+	MCU_UNI_CMD_POWER_CREL = 0x0f,
+	MCU_UNI_CMD_RX_HDR_TRANS = 0x12,
+	MCU_UNI_CMD_SER = 0x13,
+	MCU_UNI_CMD_TWT = 0x14,
+	MCU_UNI_CMD_RDD_CTRL = 0x19,
+	MCU_UNI_CMD_GET_MIB_INFO = 0x22,
 	MCU_UNI_CMD_SNIFFER = 0x24,
+	MCU_UNI_CMD_SR = 0x25,
+	MCU_UNI_CMD_TXPOWER = 0x2b,
+	MCU_UNI_CMD_EFUSE_CTRL = 0x2d,
+	MCU_UNI_CMD_RA = 0x2f,
+	MCU_UNI_CMD_MURU = 0x31,
+	MCU_UNI_CMD_BF = 0x33,
+	MCU_UNI_CMD_CHANNEL_SWITCH = 0x34,
+	MCU_UNI_CMD_THERMAL = 0x35,
+	MCU_UNI_CMD_VOW = 0x37,
+	MCU_UNI_CMD_RRO = 0x57,
+	MCU_UNI_CMD_OFFCH_SCAN_CTRL = 0x58,
 };
 
 enum {
-- 
2.25.1

