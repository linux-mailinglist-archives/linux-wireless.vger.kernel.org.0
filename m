Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0ED7D3B13
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 17:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjJWPmM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 11:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWPmL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 11:42:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD3DBC
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 08:42:04 -0700 (PDT)
X-UUID: b44017f071ba11eea33bb35ae8d461a2-20231023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2REOYH0j4DuLhMFjIYfbpWERxP6N2lOAf4321S2DEdM=;
        b=fjknE8nVKJKOvfpqXLSISI992LSamwS1sOaoRtMb+ExeBIJnsJdWv3uYDLOBkqmwlBRpF5IVHAkOgzffsCmAV3Lk02RFoW7QW/NJCAAqcyrKlZ741y5d+Os2XIxE+qmyrRmToOtjXwo2VbaZu7JkE8oHhJiBeVPgMSBkwvXpPqY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:ba37e961-0b25-4820-8203-018fe195b3d4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:91db0d7d-ccd9-4df5-91ce-9df5fea3ae01,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b44017f071ba11eea33bb35ae8d461a2-20231023
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 866609867; Mon, 23 Oct 2023 23:41:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Oct 2023 23:41:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Oct 2023 23:41:59 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 09/11] wifi: mt76: mt7996: handle IEEE80211_RC_SMPS_CHANGED
Date:   Mon, 23 Oct 2023 23:38:52 +0800
Message-ID: <20231023153854.10708-9-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231023153854.10708-1-shayne.chen@mediatek.com>
References: <20231023153854.10708-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Make mt7996_mcu_set_fixed_field() non-static in order to handle
IEEE80211_RC_SMPS_CHANGED in mt7996_mac_sta_rc_work().

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 8 +++++---
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 2 ++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 89e23a95ecc2..f0dc47f56358 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2285,7 +2285,9 @@ void mt7996_mac_sta_rc_work(struct work_struct *work)
 			       IEEE80211_RC_BW_CHANGED))
 			mt7996_mcu_add_rate_ctrl(dev, vif, sta, true);
 
-		/* TODO: smps change */
+		if (changed & IEEE80211_RC_SMPS_CHANGED)
+			mt7996_mcu_set_fixed_field(dev, vif, sta, NULL,
+						   RATE_PARAM_MMPS_UPDATE);
 
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index dad5be748d7d..8e2037671c9b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1800,9 +1800,8 @@ int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
 				     MCU_WM_UNI_CMD(RA), true);
 }
 
-static int
-mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-			   struct ieee80211_sta *sta, void *data, u32 field)
+int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta, void *data, u32 field)
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
@@ -1830,6 +1829,9 @@ mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		if (phy)
 			ra->phy = *phy;
 		break;
+	case RATE_PARAM_MMPS_UPDATE:
+		ra->mmps_mode = mt7996_mcu_get_mmps_mode(sta->deflink.smps_mode);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index ed99432b2d03..0a150bcb2c19 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -452,6 +452,8 @@ int mt7996_mcu_set_chan_info(struct mt7996_phy *phy, u16 tag);
 int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif);
 int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
 				   void *data, u16 version);
+int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta, void *data, u32 field);
 int mt7996_mcu_set_eeprom(struct mt7996_dev *dev);
 int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset);
 int mt7996_mcu_get_eeprom_free_block(struct mt7996_dev *dev, u8 *block_num);
-- 
2.39.2

