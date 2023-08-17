Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948BD77F1B4
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 10:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348693AbjHQICd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 04:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348723AbjHQICY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 04:02:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C372D66
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 01:02:19 -0700 (PDT)
X-UUID: 5faeb9c83cd411ee9cb5633481061a41-20230817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Ud6IPe0NTEue6T8QSv+t8vOB+aNXxYWB2ZW4J6nU80g=;
        b=Tm5nnPcDGl1W6MdpBwwJyu456qDo7G10HjHY9nUzff1YPesrwNG4Fmd8Wi6xgLoS26I8Q9aVaLdWrmwJdNKOU5pqYRsMNquwBqMqdlsKKORvob/wePh6elNVnY0j7EyVierGfRGu+U1S4YxYXKmDMLI1UbfFpwN8kVmR2PakBUA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:19015c6b-9d7a-4af6-91e0-7aaaff640c43,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:9aa7a1ee-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5faeb9c83cd411ee9cb5633481061a41-20230817
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1775625258; Thu, 17 Aug 2023 16:02:13 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 17 Aug 2023 16:02:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 17 Aug 2023 16:02:11 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 7/9] wifi: mt76: mt7996: only set vif teardown cmds at remove interface
Date:   Thu, 17 Aug 2023 16:01:52 +0800
Message-ID: <20230817080154.16475-7-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230817080154.16475-1-shayne.chen@mediatek.com>
References: <20230817080154.16475-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Only send commands that disable vif when removing interface, this
reduces some unnecessary bss_info and sta_rec commands, especially for
station interface.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 21 ++++++-------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 600010cdb94e..6068e009c408 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -248,8 +248,8 @@ static void mt7996_remove_interface(struct ieee80211_hw *hw,
 	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	int idx = msta->wcid.idx;
 
-	mt7996_mcu_add_bss_info(phy, vif, false);
 	mt7996_mcu_add_sta(dev, vif, NULL, false);
+	mt7996_mcu_add_bss_info(phy, vif, false);
 
 	if (vif == phy->monitor_vif)
 		phy->monitor_vif = NULL;
@@ -570,17 +570,13 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 	/* station mode uses BSSID to map the wlan entry to a peer,
 	 * and then peer references bss_info_rfch to set bandwidth cap.
 	 */
-	if (changed & BSS_CHANGED_BSSID &&
-	    vif->type == NL80211_IFTYPE_STATION) {
-		bool join = !is_zero_ether_addr(info->bssid);
-
-		mt7996_mcu_add_bss_info(phy, vif, join);
-		mt7996_mcu_add_sta(dev, vif, NULL, join);
+	if ((changed & BSS_CHANGED_BSSID && !is_zero_ether_addr(info->bssid)) ||
+	    (changed & BSS_CHANGED_ASSOC && vif->cfg.assoc) ||
+	    (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon)) {
+		mt7996_mcu_add_bss_info(phy, vif, true);
+		mt7996_mcu_add_sta(dev, vif, NULL, true);
 	}
 
-	if (changed & BSS_CHANGED_ASSOC)
-		mt7996_mcu_add_bss_info(phy, vif, vif->cfg.assoc);
-
 	if (changed & BSS_CHANGED_ERP_CTS_PROT)
 		mt7996_mac_enable_rtscts(dev, vif, info->use_cts_prot);
 
@@ -601,11 +597,6 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 		mvif->basic_rates_idx =
 			mt7996_get_rates_table(hw, vif, false, false);
 
-	if (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon) {
-		mt7996_mcu_add_bss_info(phy, vif, true);
-		mt7996_mcu_add_sta(dev, vif, NULL, true);
-	}
-
 	/* ensure that enable txcmd_mode after bss_info */
 	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
 		mt7996_mcu_set_tx(dev, vif);
-- 
2.39.2

