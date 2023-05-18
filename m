Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFED708392
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 16:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjEROJA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 10:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjEROI7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 10:08:59 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E294AA6
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 07:08:50 -0700 (PDT)
X-UUID: 7f8c7f96f58511ed9cb5633481061a41-20230518
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=UNQJ6UYhjogc5c1wDAOrvT+H4ssYX1133dol8QFtPq8=;
        b=r8FEtcGeIa82PjY4agXBiPBOjD28FV0wxhsK82be2FLTzUYi5h3RFJhBaMrG86YoW43S5yTSGjM9/nYPReudky+uU9Bs+y+VOzmg7AdhCAe7mq/cyltoBzpVDk5wHnQxZq2qAPxMC1sF0AT73IgT1vL+z8VXqm9ByMDjMzn9K5k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:c392e5d9-76f4-4927-aa1c-b0d196fa3b5e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:287a9b3b-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 7f8c7f96f58511ed9cb5633481061a41-20230518
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2052427463; Thu, 18 May 2023 22:08:43 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 18 May 2023 22:08:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 May 2023 22:08:42 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: fix non-PSC channel scan fail
Date:   Thu, 18 May 2023 22:08:14 +0800
Message-ID: <ee69ceae1809d39557e5e6872a7e9121b9d321f8.1684418645.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Due to the scan command may only request legacy bands and PSC channel
in 6GHz band, we are unable to scan the APs on non-PSC channel in this
case. Enable WIPHY_FLAG_SPLIT_SCAN_6GHZ to support non-PSC channel
(obtained during scan on legacy bands) in 6GHz scan request.

Fixes: 50ac15a511e3 ("mt76: mt7921: add 6GHz support")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index e929f6eb65ce..49f243d73336 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -113,7 +113,8 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->max_sched_scan_ssids = MT76_CONNAC_MAX_SCHED_SCAN_SSID;
 	wiphy->max_match_sets = MT76_CONNAC_MAX_SCAN_MATCH;
 	wiphy->max_sched_scan_reqs = 1;
-	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH |
+			WIPHY_FLAG_SPLIT_SCAN_6GHZ;
 	wiphy->reg_notifier = mt7921_regd_notifier;
 
 	wiphy->features |= NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
-- 
2.18.0

