Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDE6553D9F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jun 2022 23:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356001AbiFUVYy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jun 2022 17:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355761AbiFUVY1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jun 2022 17:24:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609C0C27
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 14:17:45 -0700 (PDT)
X-UUID: 102a0225717b429ab841ce57d46c8ba1-20220622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:d6209b91-8719-4f2b-a854-4fb6562955d4,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:105
X-CID-INFO: VERSION:1.1.6,REQID:d6209b91-8719-4f2b-a854-4fb6562955d4,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:105
X-CID-META: VersionHash:b14ad71,CLOUDID:421324ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:c0fbcd6b924b,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 102a0225717b429ab841ce57d46c8ba1-20220622
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1727542005; Wed, 22 Jun 2022 05:17:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 22 Jun 2022 05:17:41 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jun 2022 05:17:40 +0800
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
Subject: [PATCH v2 1/2] mt76: mt7921: enable HW beacon filter not depending on PM flag
Date:   Wed, 22 Jun 2022 05:17:38 +0800
Message-ID: <b85224ecea092174ee901e14afd5d322744d8fd9.1655846049.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
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

The hardware beacon filter works whether or not the PM flag is set, so we
drop redundant dependency checks on PM flags.

Additionally, the patch implicitly allow the MT7921[E, S, U] to have a
consistent configuration of the hardware beacon filter.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2:
1. refine git message to match with code change
2. rebase and apply to the latest mt76 tree
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index a9e0e00b764c..4070bedc8eae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -668,8 +668,7 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ASSOC) {
 		mt7921_mcu_sta_update(dev, NULL, vif, true,
 				      MT76_STA_INFO_STATE_ASSOC);
-		if (dev->pm.enable)
-			mt7921_mcu_set_beacon_filter(dev, vif, vif->cfg.assoc);
+		mt7921_mcu_set_beacon_filter(dev, vif, vif->cfg.assoc);
 	}
 
 	if (changed & BSS_CHANGED_ARP_FILTER) {
-- 
2.25.1

