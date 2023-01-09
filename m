Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ABB662C2B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 18:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjAIRGm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 12:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbjAIQ6R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 11:58:17 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA4F3DBE6
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 08:58:11 -0800 (PST)
X-UUID: 710418616ed94b41ba43fcdb367997b2-20230110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sZlMwvfhwoUkdzlQ3h62moM15CiXQy5uhi6PS/uNxPw=;
        b=Vfm/jzsSkLC7YftClLY5Nvhw9sSf/ATH8G9dpLITK66TvdDL5g0ibfzDJ9cPGyK3s4TuMPukIEuA621/z98qlEKiO7ni4EkbaCF09WxSZI473WnWuESOLqi/ZFUQgyQJ7BM2qHSvp+Bqsps8/UlpBOjAFSKxcM655NWA9cD4SFc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:6e8f5e50-703d-46f7-94de-2d16864d2438,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:543e81c,CLOUDID:0dedbb8b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 710418616ed94b41ba43fcdb367997b2-20230110
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1453480753; Tue, 10 Jan 2023 00:58:05 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 10 Jan 2023 00:58:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 10 Jan 2023 00:58:04 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 01/13] wifi: mt76: add EHT phy type
Date:   Tue, 10 Jan 2023 00:57:19 +0800
Message-ID: <20230109165731.682-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230109165731.682-1-shayne.chen@mediatek.com>
References: <20230109165731.682-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
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
index 1037d23bc4d0..9fa8c5f63801 100644
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
index 82fdf6d794bc..947b0900daec 100644
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

