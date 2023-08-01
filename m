Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EA276B792
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjHAOeJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjHAOeI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:34:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8521FEE
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:33:58 -0700 (PDT)
X-UUID: 6fe7aad8307811ee9cb5633481061a41-20230801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Ybu9C7FLKv1YFdvWsjqZeEsvZBRRJlTzLuHC2rmE1vA=;
        b=uw34l8rTyuAOVp0gtaW9e+YTFsHzJELInnmH3oXKFvOcQRi97fOafN8W2QvjuOfi7Usdeq28OiceyQ5Z3K0Um7hqSpW5DNeWw5BpHox3DWlN86x4wtUPzFVWDVYFb7FpLiP8hOW0kmtg+Glk7kNgDprsksMeUa3F04ZrQcxnKs0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:9398e996-7c2f-40a6-8ff9-9613abbf7c0f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.30,REQID:9398e996-7c2f-40a6-8ff9-9613abbf7c0f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:1fcc6f8,CLOUDID:491f08b4-a467-4aa9-9e04-f584452e3794,B
        ulkID:2308012233531Q3H1ESH,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_ASC
X-UUID: 6fe7aad8307811ee9cb5633481061a41-20230801
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 55509616; Tue, 01 Aug 2023 22:33:52 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Aug 2023 22:33:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 1 Aug 2023 22:33:52 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 7/8] wifi: mt76: connac: add more unified command IDs
Date:   Tue, 1 Aug 2023 22:30:31 +0800
Message-ID: <1945af12c3c1c6077e29f47879d5bc7c672e8134.1690863143.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1690863143.git.deren.wu@mediatek.com>
References: <cover.1690863143.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add more unified command IDs which will be used in new chipset.

This is the preliminary patch for mt7925 support.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index ed70bde1428b..6ab86b1925f5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -796,6 +796,7 @@ enum {
 	STA_REC_PHY = 0x15,
 	STA_REC_HE_6G = 0x17,
 	STA_REC_HE_V2 = 0x19,
+	STA_REC_MLD = 0x20,
 	STA_REC_EHT = 0x22,
 	STA_REC_HDRT = 0x28,
 	STA_REC_HDR_TRANS = 0x2B,
@@ -1212,12 +1213,17 @@ enum {
 	MCU_UNI_CMD_RX_HDR_TRANS = 0x12,
 	MCU_UNI_CMD_SER = 0x13,
 	MCU_UNI_CMD_TWT = 0x14,
+	MCU_UNI_CMD_SET_DOMAIN_INFO = 0x15,
+	MCU_UNI_CMD_SCAN_REQ = 0x16,
 	MCU_UNI_CMD_RDD_CTRL = 0x19,
 	MCU_UNI_CMD_GET_MIB_INFO = 0x22,
+	MCU_UNI_CMD_GET_STAT_INFO = 0x23,
 	MCU_UNI_CMD_SNIFFER = 0x24,
 	MCU_UNI_CMD_SR = 0x25,
 	MCU_UNI_CMD_ROC = 0x27,
+	MCU_UNI_CMD_SET_DBDC_PARMS = 0x28,
 	MCU_UNI_CMD_TXPOWER = 0x2b,
+	MCU_UNI_CMD_SET_POWER_LIMIT = 0x2c,
 	MCU_UNI_CMD_EFUSE_CTRL = 0x2d,
 	MCU_UNI_CMD_RA = 0x2f,
 	MCU_UNI_CMD_MURU = 0x31,
@@ -1296,6 +1302,7 @@ enum {
 	UNI_BSS_INFO_IFS_TIME = 23,
 	UNI_BSS_INFO_OFFLOAD = 25,
 	UNI_BSS_INFO_MLD = 26,
+	UNI_BSS_INFO_PM_DISABLE = 27,
 };
 
 enum {
-- 
2.18.0

