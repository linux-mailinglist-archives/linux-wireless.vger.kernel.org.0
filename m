Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C9A6A930F
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Mar 2023 09:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCCIvr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Mar 2023 03:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCCIvq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Mar 2023 03:51:46 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AD64E5CC
        for <linux-wireless@vger.kernel.org>; Fri,  3 Mar 2023 00:51:44 -0800 (PST)
X-UUID: 7fa5e9feb99e11eda06fc9ecc4dadd91-20230303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Oca0RaExTuCZD7ua585iW2kol2woNjATQIOqheZzsXU=;
        b=gUUHAaPK5tqY9GqELwbvGGUa3ChFlMKSsPPgPNcUmD2yKuF7IQkY2SyauW3mhcH6ZmUAKjj0MMKEiAI6u3XthFcEmtX0cLYrSMUGlAvshaXSHsBjl8bnXOirVGTQZNl4WvN7F3/D0wyUGbqBNV/8mQb/aZM9cqNOkI9s/NauyQw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:e58f7684-86e7-4cd1-af8a-2e1c903688a9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:ae95a9f4-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 7fa5e9feb99e11eda06fc9ecc4dadd91-20230303
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1341652032; Fri, 03 Mar 2023 16:36:31 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
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
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 6/7] wifi: mt76: mt7996: remove mt7996_mcu_set_pm()
Date:   Fri, 3 Mar 2023 16:35:57 +0800
Message-ID: <20230303083558.3586-6-shayne.chen@mediatek.com>
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

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Currently using BSS_INFO_PS command will sometimes cause packet drop in
hw rx queue.
Temporarily remove this function until finding the cause.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  8 ------
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 26 -------------------
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  1 -
 3 files changed, 35 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 3e4da0350d96..f13f67b21d3e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -52,10 +52,6 @@ static int mt7996_start(struct ieee80211_hw *hw)
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
-	ieee80211_iterate_interfaces(dev->mt76.hw,
-				     IEEE80211_IFACE_ITER_RESUME_ALL,
-				     mt7996_mcu_set_pm, dev->mt76.hw);
-
 	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
 				     MT7996_WATCHDOG_TIME);
 
@@ -79,10 +75,6 @@ static void mt7996_stop(struct ieee80211_hw *hw)
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
-	ieee80211_iterate_interfaces(dev->mt76.hw,
-				     IEEE80211_IFACE_ITER_RESUME_ALL,
-				     mt7996_mcu_set_pm, dev->mt76.hw);
-
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index c11e92db5f07..1389d140a8c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3577,32 +3577,6 @@ int mt7996_mcu_twt_agrt_update(struct mt7996_dev *dev,
 				 &req, sizeof(req), true);
 }
 
-void mt7996_mcu_set_pm(void *priv, u8 *mac, struct ieee80211_vif *vif)
-{
-#define EXIT_PM_STATE	0
-#define ENTER_PM_STATE	1
-	struct ieee80211_hw *hw = priv;
-	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct bss_power_save *ps;
-	struct sk_buff *skb;
-	struct tlv *tlv;
-	bool running = test_bit(MT76_STATE_RUNNING, &phy->mt76->state);
-
-	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76,
-					 MT7996_BSS_UPDATE_MAX_SIZE);
-	if (IS_ERR(skb))
-		return;
-
-	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_PS, sizeof(*ps));
-	ps = (struct bss_power_save *)tlv;
-	ps->profile = running ? EXIT_PM_STATE : ENTER_PM_STATE;
-
-	mt76_mcu_skb_send_msg(&dev->mt76, skb,
-			      MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
-}
-
 int mt7996_mcu_set_rts_thresh(struct mt7996_phy *phy, u32 val)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index ae1210b0a82c..f27f519bec0a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -432,7 +432,6 @@ int mt7996_mcu_set_pulse_th(struct mt7996_dev *dev,
 int mt7996_mcu_set_radar_th(struct mt7996_dev *dev, int index,
 			    const struct mt7996_dfs_pattern *pattern);
 int mt7996_mcu_set_radio_en(struct mt7996_phy *phy, bool enable);
-void mt7996_mcu_set_pm(void *priv, u8 *mac, struct ieee80211_vif *vif);
 int mt7996_mcu_set_rts_thresh(struct mt7996_phy *phy, u32 val);
 int mt7996_mcu_get_chan_mib_info(struct mt7996_phy *phy, bool chan_switch);
 int mt7996_mcu_rdd_cmd(struct mt7996_dev *dev, int cmd, u8 index,
-- 
2.39.2

