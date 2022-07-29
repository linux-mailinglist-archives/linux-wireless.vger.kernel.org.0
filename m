Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610605851C5
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jul 2022 16:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiG2OqW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Jul 2022 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiG2OqV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Jul 2022 10:46:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EA85727A
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 07:46:19 -0700 (PDT)
X-UUID: 72ee2f9bf55c4d51a0075121c6fd2936-20220729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:7e1a6f7a-a5a8-4025-a13c-07ce040802b4,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:314dbe24-a982-4824-82d2-9da3b6056c2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 72ee2f9bf55c4d51a0075121c6fd2936-20220729
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2008969697; Fri, 29 Jul 2022 22:46:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 29 Jul 2022 22:44:59 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 29 Jul 2022 22:44:59 +0800
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
        <jsiuda@google.com>, <frankgor@google.com>, <kuabhs@google.com>,
        <druth@google.com>, <abhishekpandit@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH RESEND v2 1/2] mt76: mt7921: add mt7921_mutex_acquire at mt7921_[start, stop]_ap
Date:   Fri, 29 Jul 2022 22:44:56 +0800
Message-ID: <6353fe62ebeb0f78aa34b40e9c1745061b229f6c.1659105379.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add mt7921_mutex_acquire at mt7921_[start, stop]_ap to fix the race
with the context holding dev->muxtex and the driver might access the
device in low power state.

Fixes: 9d958b60ebc2 ("mt76: mt7921: fix command timeout in AP stop period")
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: use "out" label instead and add the Tested-by tag from AngeloGioacchino
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 1438a9f8d1fd..63fd33dcd3af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1526,17 +1526,23 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	int err;
 
+	mt7921_mutex_acquire(dev);
+
 	err = mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid,
 					  true);
 	if (err)
-		return err;
+		goto out;
 
 	err = mt7921_mcu_set_bss_pm(dev, vif, true);
 	if (err)
-		return err;
+		goto out;
+
+	err = mt7921_mcu_sta_update(dev, NULL, vif, true,
+				    MT76_STA_INFO_STATE_NONE);
+out:
+	mt7921_mutex_release(dev);
 
-	return mt7921_mcu_sta_update(dev, NULL, vif, true,
-				     MT76_STA_INFO_STATE_NONE);
+	return err;
 }
 
 static void
@@ -1548,11 +1554,16 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	int err;
 
+	mt7921_mutex_acquire(dev);
+
 	err = mt7921_mcu_set_bss_pm(dev, vif, false);
 	if (err)
-		return;
+		goto out;
 
 	mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid, false);
+
+out:
+	mt7921_mutex_release(dev);
 }
 
 const struct ieee80211_ops mt7921_ops = {
-- 
2.25.1

