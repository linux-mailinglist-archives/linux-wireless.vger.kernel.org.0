Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A3F6828F8
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 10:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjAaJgr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Jan 2023 04:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjAaJgo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Jan 2023 04:36:44 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BF12E811
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 01:36:39 -0800 (PST)
X-UUID: bda51732a14a11eda06fc9ecc4dadd91-20230131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=31KkzywwTmUQf0/Odsorzo/YRX0yoJi5ZUuJlSr+odE=;
        b=gWwKQUURspsfjsrnnz47qFLQTlRfQA8hCeIBohxMV+jsSuJUD4c6bkxSBMvr4p4npzoUYviuufUEBXcbiFXWUYjvetlOjIUb6mXI5Z1XQEa8XHWlcqV9VHHIAzMYhFGGFsAuzEpGyqDQ0KmdX24Lpr2EYE//iGgjl9l8s2BCTLg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:36b0396a-aaca-448d-b47a-3d8de8d535e2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.18,REQID:36b0396a-aaca-448d-b47a-3d8de8d535e2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:3ca2d6b,CLOUDID:152c04f7-ff42-4fb0-b929-626456a83c14,B
        ulkID:230131173631QW1WEDTK,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-BVR: 0
X-UUID: bda51732a14a11eda06fc9ecc4dadd91-20230131
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1537849714; Tue, 31 Jan 2023 17:36:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 31 Jan 2023 17:36:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 31 Jan 2023 17:36:28 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 01/13] wifi: mt76: add EHT phy type
Date:   Tue, 31 Jan 2023 17:35:59 +0800
Message-ID: <20230131093611.30914-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230131093611.30914-1-shayne.chen@mediatek.com>
References: <20230131093611.30914-1-shayne.chen@mediatek.com>
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

Extend phy type and phymode bitfields for EHT support.
This is the preliminary patch to add EHT support for mt7996.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h            | 7 +++++--
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 4 ++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 48dc4236f8f8..8d05eee92099 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -264,11 +264,14 @@ enum mt76_phy_type {
 	MT_PHY_TYPE_HE_EXT_SU,
 	MT_PHY_TYPE_HE_TB,
 	MT_PHY_TYPE_HE_MU,
-	__MT_PHY_TYPE_HE_MAX,
+	MT_PHY_TYPE_EHT_SU = 13,
+	MT_PHY_TYPE_EHT_TRIG,
+	MT_PHY_TYPE_EHT_MU,
+	__MT_PHY_TYPE_MAX,
 };
 
 struct mt76_sta_stats {
-	u64 tx_mode[__MT_PHY_TYPE_HE_MAX];
+	u64 tx_mode[__MT_PHY_TYPE_MAX];
 	u64 tx_bw[4];		/* 20, 40, 80, 160 */
 	u64 tx_nss[4];		/* 1, 2, 3, 4 */
 	u64 tx_mcs[16];		/* mcs idx */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index bb92216741a3..ebd64bec9f68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -882,12 +882,16 @@ enum {
 #define PHY_MODE_AX_5G				BIT(7)
 
 #define PHY_MODE_AX_6G				BIT(0) /* phymode_ext */
+#define PHY_MODE_BE_24G				BIT(1)
+#define PHY_MODE_BE_5G				BIT(2)
+#define PHY_MODE_BE_6G				BIT(3)
 
 #define MODE_CCK				BIT(0)
 #define MODE_OFDM				BIT(1)
 #define MODE_HT					BIT(2)
 #define MODE_VHT				BIT(3)
 #define MODE_HE					BIT(4)
+#define MODE_EHT				BIT(5)
 
 #define STA_CAP_WMM				BIT(0)
 #define STA_CAP_SGI_20				BIT(4)
-- 
2.25.1

