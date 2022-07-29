Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A975585362
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jul 2022 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbiG2QZe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Jul 2022 12:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiG2QZd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Jul 2022 12:25:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C71418340
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 09:25:27 -0700 (PDT)
X-UUID: 694d9abefd3e4dd9a110025bf4f439c6-20220730
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:f4126faa-9971-4da1-8705-d3915a69cbb1,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:e04fb6d0-841b-4e95-ad42-8f86e18f54fc,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 694d9abefd3e4dd9a110025bf4f439c6-20220730
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1051595895; Sat, 30 Jul 2022 00:25:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with ShadowRedundancy id 15.2.792.3;
 Fri, 29 Jul 2022 16:23:53 +0000
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 29 Jul 2022 22:45:08 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 29 Jul 2022 22:45:08 +0800
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
Subject: [PATCH RESEND v2 2/2] mt76: mt7921: add mt7921_mutex_acquire at mt7921_sta_set_decap_offload
Date:   Fri, 29 Jul 2022 22:44:57 +0800
Message-ID: <aa6418271cc601dd25a165d05cfd7136a1d6930a.1659105379.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <6353fe62ebeb0f78aa34b40e9c1745061b229f6c.1659105379.git.objelf@gmail.com>
References: <6353fe62ebeb0f78aa34b40e9c1745061b229f6c.1659105379.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add mt7921_mutex_acquire at mt7921_[start, stop]_ap to fix the race
with the context holding dev->muxtex and the driver might access the
device in low power state.

Fixes: 24299fc869f7 ("mt76: mt7921: enable rx header traslation offload")
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 63fd33dcd3af..7214735011d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1404,6 +1404,8 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 
+	mt7921_mutex_acquire(dev);
+
 	if (enabled)
 		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
 	else
@@ -1411,6 +1413,8 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 
 	mt76_connac_mcu_sta_update_hdr_trans(&dev->mt76, vif, &msta->wcid,
 					     MCU_UNI_CMD(STA_REC_UPDATE));
+
+	mt7921_mutex_release(dev);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.25.1

