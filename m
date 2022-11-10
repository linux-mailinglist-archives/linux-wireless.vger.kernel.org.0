Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8543E623EC3
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 10:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiKJJhL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 04:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiKJJhF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 04:37:05 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E176A755
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 01:37:03 -0800 (PST)
X-UUID: 164a12ee23034014ae5ca79a80c331a5-20221110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=af5/29UjuXFBRrxbph+wfriLW8Dqa9ZpqbKZqMmMSHA=;
        b=jjjopa82whbDPSgmFTaeIRpMLz6JFB2vX/qi1nB6QP3JkqMmC2FR5tzaI1LS8/Ul5GZjueUBrOUZjIIJ6QQX08JVaGsyPpSav35a1poSK3dtJZcq9YQZmG1aFD1fVklWjzuTAZcSGer1bHEWJAoqpRUjR9xUzuFfRA70YUR0sWE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:3905f83a-85dc-413e-9c7c-1aa6257024ed,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:2952e950-b7af-492d-8b40-b1032f90ce11,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 164a12ee23034014ae5ca79a80c331a5-20221110
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 571891603; Thu, 10 Nov 2022 17:36:52 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 10 Nov 2022 17:36:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 10 Nov 2022 17:36:50 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>
Subject: [PATCH v2 3/9] wifi: mt76: connac: rework fields for larger bandwidth support in sta_rec_bf
Date:   Thu, 10 Nov 2022 17:35:19 +0800
Message-ID: <20221110093525.29649-4-shayne.chen@mediatek.com>
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

Rename nrow_bw160 and ncol_bw160 since channel width 320 MHz will share
the same field.
This is a preliminary patch to add mt7996 chipset support.

Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 87c27a836e2b..9cca73df6644 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -463,8 +463,8 @@ struct sta_rec_bf {
 	u8 ibf_dbw;
 	u8 ibf_ncol;
 	u8 ibf_nrow;
-	u8 nrow_bw160;
-	u8 ncol_bw160;
+	u8 nrow_gt_bw80;
+	u8 ncol_gt_bw80;
 	u8 ru_start_idx;
 	u8 ru_end_idx;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 65ae959859e7..f3ba98746d44 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1131,7 +1131,7 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 		mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_160);
 		nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
 
-		bf->ncol_bw160 = nss_mcs;
+		bf->ncol_gt_bw80 = nss_mcs;
 	}
 
 	if (pe->phy_cap_info[0] &
@@ -1139,10 +1139,10 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 		mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_80p80);
 		nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
 
-		if (bf->ncol_bw160)
-			bf->ncol_bw160 = min_t(u8, bf->ncol_bw160, nss_mcs);
+		if (bf->ncol_gt_bw80)
+			bf->ncol_gt_bw80 = min_t(u8, bf->ncol_gt_bw80, nss_mcs);
 		else
-			bf->ncol_bw160 = nss_mcs;
+			bf->ncol_gt_bw80 = nss_mcs;
 	}
 
 	snd_dim = HE_PHY(CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK,
@@ -1150,7 +1150,7 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 	sts = HE_PHY(CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_MASK,
 		     pe->phy_cap_info[4]);
 
-	bf->nrow_bw160 = min_t(int, snd_dim, sts);
+	bf->nrow_gt_bw80 = min_t(int, snd_dim, sts);
 }
 
 static void
-- 
2.25.1

