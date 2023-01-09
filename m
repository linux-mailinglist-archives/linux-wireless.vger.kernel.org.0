Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF46662C30
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 18:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjAIRG3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 12:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbjAIQ6Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 11:58:16 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C4532271
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 08:58:09 -0800 (PST)
X-UUID: f4bed8999a7a44b0aad0802d6dd60d7c-20230110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LBtyWl3xBwubYwNLRwUnjRtwq/o0DZ3qA2MNE7i/b0c=;
        b=f3MdgkJInwk8LNUwWtI7Ub8GrU3TapiPLrJzCaEAJmERyGnEdU724XMAnZCzdkMepxeNqUgEaw2CX2GlNjeLwLJF8+KMTWvkkodngmqwpsNBUcWBxVKMtF7Ko/WDwGz4XjWLm8M3z+TIsVY72IaCU8eXfY3GPVuFsB8U/Qn5d9g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:26ef40d0-413f-4346-a348-bd958ff1b73f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:543e81c,CLOUDID:0eedbb8b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: f4bed8999a7a44b0aad0802d6dd60d7c-20230110
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 827041310; Tue, 10 Jan 2023 00:58:05 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
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
Subject: [PATCH 06/13] wifi: mt76: add EHT rate stats for ethtool
Date:   Tue, 10 Jan 2023 00:57:24 +0800
Message-ID: <20230109165731.682-7-shayne.chen@mediatek.com>
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

Add support to get EHT rate stats from ethtool.
This is the preliminary patch to add EHT support for mt7996.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index b3fd3abfdd9f..3d3c68b9e1cf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -272,7 +272,7 @@ enum mt76_phy_type {
 
 struct mt76_sta_stats {
 	u64 tx_mode[__MT_PHY_TYPE_MAX];
-	u64 tx_bw[4];		/* 20, 40, 80, 160 */
+	u64 tx_bw[5];		/* 20, 40, 80, 160, 320 */
 	u64 tx_nss[4];		/* 1, 2, 3, 4 */
 	u64 tx_mcs[16];		/* mcs idx */
 	u64 tx_bytes;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index c423b052e4f4..9ea2e1198477 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1084,10 +1084,14 @@ static const char mt7996_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"v_tx_mode_he_ext_su",
 	"v_tx_mode_he_tb",
 	"v_tx_mode_he_mu",
+	"v_tx_mode_eht_su",
+	"v_tx_mode_eht_trig",
+	"v_tx_mode_eht_mu",
 	"v_tx_bw_20",
 	"v_tx_bw_40",
 	"v_tx_bw_80",
 	"v_tx_bw_160",
+	"v_tx_bw_320",
 	"v_tx_mcs_0",
 	"v_tx_mcs_1",
 	"v_tx_mcs_2",
@@ -1100,6 +1104,8 @@ static const char mt7996_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"v_tx_mcs_9",
 	"v_tx_mcs_10",
 	"v_tx_mcs_11",
+	"v_tx_mcs_12",
+	"v_tx_mcs_13",
 };
 
 #define MT7996_SSTATS_LEN ARRAY_SIZE(mt7996_gstrings_stats)
-- 
2.25.1

