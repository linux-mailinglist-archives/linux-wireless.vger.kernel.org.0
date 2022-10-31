Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013BC613B7D
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Oct 2022 17:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiJaQka (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Oct 2022 12:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiJaQk1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Oct 2022 12:40:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75732BE0
        for <linux-wireless@vger.kernel.org>; Mon, 31 Oct 2022 09:40:22 -0700 (PDT)
X-UUID: 8b4617501bac4d9eb311fc9a13ea21ab-20221101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nflQPBAE0y+qB/9hp4ypHQfRrj5WUvsPWuO2cvPBe2Q=;
        b=U5KHPCXCGEfTZ/Ug3LrczQ5BPTMh1GOTvZ2+zo3TTWz4uxIWW+afcTVRVd1UtN3GO+MZdXHwx4P90FZ2QQ0KrwDNvDF0VXn0tu7t4GaG/3+jnEctzyEoVk7wnWQaoa2G7etiRycCumm+M/gsjYvl2FgAkDiUh0vfm2B3IdoG8lY=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:8c9c6703-df6b-4855-93f8-35b215f18ef7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.12,REQID:8c9c6703-df6b-4855-93f8-35b215f18ef7,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:62cd327,CLOUDID:fea2fcea-84ac-4628-a416-bc50d5503da6,B
        ulkID:2211010040150KHYC6SM,BulkQuantity:0,Recheck:0,SF:28|16|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8b4617501bac4d9eb311fc9a13ea21ab-20221101
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 481548505; Tue, 01 Nov 2022 00:40:12 +0800
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
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 05/10] wifi: mt76: connac: add more unified command IDs
Date:   Tue, 1 Nov 2022 00:39:55 +0800
Message-ID: <20221031164000.17063-6-shayne.chen@mediatek.com>
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

Add more unified command IDs which will be used in new chipset.
This is the preliminary patch for mt7996 support.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 9cca73df6644..7f97d4b70e95 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1172,10 +1172,29 @@ enum {
 	MCU_UNI_CMD_DEV_INFO_UPDATE = 0x01,
 	MCU_UNI_CMD_BSS_INFO_UPDATE = 0x02,
 	MCU_UNI_CMD_STA_REC_UPDATE = 0x03,
+	MCU_UNI_CMD_EDCA_UPDATE = 0x04,
 	MCU_UNI_CMD_SUSPEND = 0x05,
 	MCU_UNI_CMD_OFFLOAD = 0x06,
 	MCU_UNI_CMD_HIF_CTRL = 0x07,
+	MCU_UNI_CMD_BAND_CONFIG = 0x08,
+	MCU_UNI_CMD_WSYS_CONFIG = 0x0b,
+	MCU_UNI_CMD_REG_ACCESS = 0x0d,
+	MCU_UNI_CMD_POWER_CREL = 0x0f,
+	MCU_UNI_CMD_RX_HDR_TRANS = 0x12,
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
 };
 
 enum {
-- 
2.25.1

