Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9786553D99
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jun 2022 23:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355838AbiFUVYx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jun 2022 17:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355681AbiFUVY1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jun 2022 17:24:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49272C39
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 14:17:46 -0700 (PDT)
X-UUID: 730a5d4bd4e84445b141172e67a085da-20220622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:9cdd00ba-9d79-4ba2-80b1-4408a9ffeec4,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:100
X-CID-INFO: VERSION:1.1.6,REQID:9cdd00ba-9d79-4ba2-80b1-4408a9ffeec4,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:100
X-CID-META: VersionHash:b14ad71,CLOUDID:ba1f1938-5e4b-44d7-80b2-bb618cb09d29,C
        OID:58a0d2b83d43,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 730a5d4bd4e84445b141172e67a085da-20220622
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 18626580; Wed, 22 Jun 2022 05:17:43 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 22 Jun 2022 05:17:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jun 2022 05:17:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jun 2022 05:17:42 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 2/2] mt76: mt7921: enable HW beacon filter in the initialization stage
Date:   Wed, 22 Jun 2022 05:17:39 +0800
Message-ID: <d8edd12387a766e9a5c3745c5a921d5deba8fe41.1655846049.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <b85224ecea092174ee901e14afd5d322744d8fd9.1655846049.git.objelf@gmail.com>
References: <b85224ecea092174ee901e14afd5d322744d8fd9.1655846049.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

The current driver has worked with HW beacon filter and connection
monitor all the way, here we move the enablement into the initialization
stage like other HW features being done to get rid of others are
confused why these configurations would be changed at runtime.

We still leave a way to turn off these offload features in debugfs knobs
but that is just for debugging purposes.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2:
rebase and apply to the latest mt76 tree
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 16 +++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c  |  5 -----
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 79023992715e..29ccf58ede46 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -97,6 +97,7 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_PS);
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 	ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
+	ieee80211_hw_set(hw, CONNECTION_MONITOR);
 
 	if (dev->pm.enable)
 		ieee80211_hw_set(hw, CONNECTION_MONITOR);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 4070bedc8eae..29ff88892cae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -352,6 +352,7 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 		mtxq->wcid = idx;
 	}
 
+	vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
 out:
 	mt7921_mutex_release(dev);
 
@@ -495,8 +496,21 @@ static void
 mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	struct mt7921_dev *dev = priv;
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	bool pm_enable = dev->pm.enable;
+	int err;
 
-	mt7921_mcu_set_beacon_filter(dev, vif, dev->pm.enable);
+	err = mt7921_mcu_set_beacon_filter(dev, vif, pm_enable);
+	if (err < 0)
+		return;
+
+	if (pm_enable) {
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+		ieee80211_hw_set(hw, CONNECTION_MONITOR);
+	} else {
+		vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
+		__clear_bit(IEEE80211_HW_CONNECTION_MONITOR, hw->flags);
+	}
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index bc434e60dfc6..69834ecbad89 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -855,7 +855,6 @@ int mt7921_mcu_set_beacon_filter(struct mt7921_dev *dev,
 				 struct ieee80211_vif *vif,
 				 bool enable)
 {
-	struct ieee80211_hw *hw = mt76_hw(dev);
 	int err;
 
 	if (enable) {
@@ -863,8 +862,6 @@ int mt7921_mcu_set_beacon_filter(struct mt7921_dev *dev,
 		if (err)
 			return err;
 
-		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
-		ieee80211_hw_set(hw, CONNECTION_MONITOR);
 		mt76_set(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
 
 		return 0;
@@ -874,8 +871,6 @@ int mt7921_mcu_set_beacon_filter(struct mt7921_dev *dev,
 	if (err)
 		return err;
 
-	vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
-	__clear_bit(IEEE80211_HW_CONNECTION_MONITOR, hw->flags);
 	mt76_clear(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
 
 	return 0;
-- 
2.25.1

