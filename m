Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5C46828FA
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 10:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjAaJgt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Jan 2023 04:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjAaJgo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Jan 2023 04:36:44 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8CA2E83A
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 01:36:39 -0800 (PST)
X-UUID: be8793f0a14a11ed945fc101203acc17-20230131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6tmXSaQkYPV+NxOlLmLNKBgs3dVLtw49KPDM3n+9sLQ=;
        b=IIw9La+C9hWneNduj7X6E97VOFIdHZnYWeKUplN3Q4ysFPJaIUyM2iiT4O4fqZC30uk8iitzx18lpDgcMD2ucGEy/8eV8yjq1NF8kJJGpkx0qxyGFNCxaPgSn0nM82c0/i1Y1wB6E3sauMjcULFnWQBZTzIT5pyFDA2u4W7UOqs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:6b7219a8-9be6-4d0d-8957-7e7563b00250,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.18,REQID:6b7219a8-9be6-4d0d-8957-7e7563b00250,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:3ca2d6b,CLOUDID:a632758d-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230131173633XAZOWSPB,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: be8793f0a14a11ed945fc101203acc17-20230131
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 796724045; Tue, 31 Jan 2023 17:36:31 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 31 Jan 2023 17:36:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 31 Jan 2023 17:36:30 +0800
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
Subject: [PATCH v2 12/13] wifi: mt76: mt7996: enable EHT support in firmware
Date:   Tue, 31 Jan 2023 17:36:10 +0800
Message-ID: <20230131093611.30914-13-shayne.chen@mediatek.com>
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

Add sta_rec_eht command and extend phymode setting.

Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 41 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   | 16 ++++++++
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index f42f18f00a26..e985b767a6c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -771,9 +771,8 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 	bss->dtim_period = vif->bss_conf.dtim_period;
 	bss->phymode = mt76_connac_get_phy_mode(phy, vif,
 						chandef->chan->band, NULL);
-
-	if (chandef->chan->band == NL80211_BAND_6GHZ)
-		bss->phymode_ext |= PHY_MODE_AX_6G;
+	bss->phymode_ext = mt76_connac_get_phy_mode_ext(phy, vif,
+							chandef->chan->band);
 
 	return 0;
 }
@@ -951,6 +950,35 @@ mt7996_mcu_sta_he_6g_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 	he_6g->capa = sta->deflink.he_6ghz_capa.capa;
 }
 
+static void
+mt7996_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct ieee80211_eht_mcs_nss_supp *mcs_map;
+	struct ieee80211_eht_cap_elem_fixed *elem;
+	struct sta_rec_eht *eht;
+	struct tlv *tlv;
+
+	if (!sta->deflink.eht_cap.has_eht)
+		return;
+
+	mcs_map = &sta->deflink.eht_cap.eht_mcs_nss_supp;
+	elem = &sta->deflink.eht_cap.eht_cap_elem;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_EHT, sizeof(*eht));
+
+	eht = (struct sta_rec_eht *)tlv;
+	eht->tid_bitmap = 0xff;
+	eht->mac_cap = cpu_to_le16(*(u16 *)elem->mac_cap_info);
+	eht->phy_cap = cpu_to_le64(*(u64 *)elem->phy_cap_info);
+	eht->phy_cap_ext = cpu_to_le64(elem->phy_cap_info[8]);
+
+	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_20)
+		memcpy(eht->mcs_map_bw20, &mcs_map->only_20mhz, sizeof(eht->mcs_map_bw20));
+	memcpy(eht->mcs_map_bw80, &mcs_map->bw._80, sizeof(eht->mcs_map_bw80));
+	memcpy(eht->mcs_map_bw160, &mcs_map->bw._160, sizeof(eht->mcs_map_bw160));
+	memcpy(eht->mcs_map_bw320, &mcs_map->bw._320, sizeof(eht->mcs_map_bw320));
+}
+
 static void
 mt7996_mcu_sta_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 {
@@ -1436,8 +1464,9 @@ mt7996_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7996_dev *dev,
 	ra->auto_rate = true;
 	ra->phy_mode = mt76_connac_get_phy_mode(mphy, vif, band, sta);
 	ra->channel = chandef->chan->hw_value;
-	ra->bw = sta->deflink.bandwidth;
-	ra->phy.bw = sta->deflink.bandwidth;
+	ra->bw = (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_320) ?
+		 CMD_CBW_320MHZ : sta->deflink.bandwidth;
+	ra->phy.bw = ra->bw;
 	ra->mmps_mode = mt7996_mcu_get_mmps_mode(sta->deflink.smps_mode);
 
 	if (supp_rate) {
@@ -1619,6 +1648,8 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		mt7996_mcu_sta_he_tlv(skb, sta);
 		/* starec he 6g*/
 		mt7996_mcu_sta_he_6g_tlv(skb, sta);
+		/* starec eht */
+		mt7996_mcu_sta_eht_tlv(skb, sta);
 		/* TODO: starec muru */
 		/* starec bfee */
 		mt7996_mcu_sta_bfee_tlv(dev, skb, vif, sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index 6084b2337598..dd0c5ac52703 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -347,6 +347,21 @@ struct sta_rec_ba_uni {
 	u8 __rsv[3];
 } __packed;
 
+struct sta_rec_eht {
+	__le16 tag;
+	__le16 len;
+	u8 tid_bitmap;
+	u8 _rsv;
+	__le16 mac_cap;
+	__le64 phy_cap;
+	__le64 phy_cap_ext;
+	u8 mcs_map_bw20[4];
+	u8 mcs_map_bw80[3];
+	u8 mcs_map_bw160[3];
+	u8 mcs_map_bw320[3];
+	u8 _rsv2[3];
+} __packed;
+
 struct sec_key_uni {
 	__le16 wlan_idx;
 	u8 mgmt_prot;
@@ -554,6 +569,7 @@ enum {
 					 sizeof(struct sta_rec_sec) +		\
 					 sizeof(struct sta_rec_ra_fixed) +	\
 					 sizeof(struct sta_rec_he_6g_capa) +	\
+					 sizeof(struct sta_rec_eht) +		\
 					 sizeof(struct sta_rec_hdrt) +		\
 					 sizeof(struct sta_rec_hdr_trans) +	\
 					 sizeof(struct tlv))
-- 
2.25.1

