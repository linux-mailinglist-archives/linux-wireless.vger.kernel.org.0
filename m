Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D0C6A930E
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Mar 2023 09:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCCIvq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Mar 2023 03:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCCIvo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Mar 2023 03:51:44 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A3E4DBF3
        for <linux-wireless@vger.kernel.org>; Fri,  3 Mar 2023 00:51:43 -0800 (PST)
X-UUID: 7fae3b72b99e11eda06fc9ecc4dadd91-20230303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IkXQkP4da8mUNlZce4Fs1EAaXDkAOn5QogpOZmkjTso=;
        b=Lx4DsVdmnERbXL3R1Nezxq7tBNnuMfP+UmlrxfaFZ28DmjRlbaByX5oKSz37/u/Bkqx6UzMJ6PLe8dzG+1EJIJIXquKrP+ZGBe8Rn8P5yIZUaqo3GhCN+nWcTI/FbKmg/tSSsJUO3rBClO/bwGI4ZTN2lLfwFf1Yd5KB4hSHVDw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:6cd161b5-09c6-4fc6-83f5-9be1c5796082,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:25b5999,CLOUDID:ec4c3b27-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 7fae3b72b99e11eda06fc9ecc4dadd91-20230303
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1910276329; Fri, 03 Mar 2023 16:36:31 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 3 Mar 2023 16:36:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 3 Mar 2023 16:36:31 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 7/7] wifi: mt76: mt7996: fix eeprom tx path bitfields
Date:   Fri, 3 Mar 2023 16:35:58 +0800
Message-ID: <20230303083558.3586-7-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230303083558.3586-1-shayne.chen@mediatek.com>
References: <20230303083558.3586-1-shayne.chen@mediatek.com>
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

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

Swap the tx path bitfields of band1 and band2 to read correct setting.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
index 5571881f639b..0c749774f6b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
@@ -31,11 +31,11 @@ enum mt7996_eeprom_field {
 #define MT_EE_WIFI_CONF2_BAND_SEL		GENMASK(2, 0)
 
 #define MT_EE_WIFI_CONF1_TX_PATH_BAND0		GENMASK(5, 3)
-#define MT_EE_WIFI_CONF2_TX_PATH_BAND1		GENMASK(5, 3)
-#define MT_EE_WIFI_CONF2_TX_PATH_BAND2		GENMASK(2, 0)
+#define MT_EE_WIFI_CONF2_TX_PATH_BAND1		GENMASK(2, 0)
+#define MT_EE_WIFI_CONF2_TX_PATH_BAND2		GENMASK(5, 3)
 #define MT_EE_WIFI_CONF4_STREAM_NUM_BAND0	GENMASK(5, 3)
-#define MT_EE_WIFI_CONF5_STREAM_NUM_BAND1	GENMASK(5, 3)
-#define MT_EE_WIFI_CONF5_STREAM_NUM_BAND2	GENMASK(2, 0)
+#define MT_EE_WIFI_CONF5_STREAM_NUM_BAND1	GENMASK(2, 0)
+#define MT_EE_WIFI_CONF5_STREAM_NUM_BAND2	GENMASK(5, 3)
 
 #define MT_EE_RATE_DELTA_MASK			GENMASK(5, 0)
 #define MT_EE_RATE_DELTA_SIGN			BIT(6)
-- 
2.39.2

