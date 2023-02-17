Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F7069B1FD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 18:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBQRrr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 12:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBQRrq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 12:47:46 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A866714A6
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 09:47:45 -0800 (PST)
X-UUID: 2b52d94caeeb11ed945fc101203acc17-20230218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=aNUT+++1EZBfVnzvrwU1iD84ekce1osmO1KrvW0OEpg=;
        b=bNiysFvXZYAdW3a9UNvRxwYvSo/sieKmM34XzUmpEhk0Dz5E4NqZvdPuMRpogIu33AT4ndB6l5z4n3NV7yhGiHe46/HM/8vE8La2zNiYYdYzdHtU6FoSO3IaR7C5Kpse2yPMBjgWyC3DaIGIyD1dmUg2XC8EQ/re1OxpZ+pHWxI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:b67773b0-26a4-4ce4-87a8-9cacc789a9cb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.19,REQID:b67773b0-26a4-4ce4-87a8-9cacc789a9cb,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:885ddb2,CLOUDID:5233cbb0-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:23021801474161ZS9E9U,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 2b52d94caeeb11ed945fc101203acc17-20230218
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1211726858; Sat, 18 Feb 2023 01:47:38 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 18 Feb 2023 01:47:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 18 Feb 2023 01:47:37 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Himanshu Goyal <himanshu.goyal@mediatek.com>
Subject: [PATCH] wifi: mt76: dynamic channel bandwidth changes in AP mode
Date:   Sat, 18 Feb 2023 01:47:32 +0800
Message-ID: <61b1b729baa0cc3160ef65cbdee74222c43ef2b3.1676609955.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

Allow AP to change channel width for 40Mhz intolerant STA on the
2.4 GHz band.

Signed-off-by: Himanshu Goyal <himanshu.goyal@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index b117e4467c87..5ebadf8367ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -418,7 +418,8 @@ mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 	SET_IEEE80211_DEV(hw, dev->dev);
 	SET_IEEE80211_PERM_ADDR(hw, phy->macaddr);
 
-	wiphy->features |= NL80211_FEATURE_ACTIVE_MONITOR;
+	wiphy->features |= NL80211_FEATURE_ACTIVE_MONITOR |
+			   NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH |
 			WIPHY_FLAG_SUPPORTS_TDLS |
 			WIPHY_FLAG_AP_UAPSD;
-- 
2.18.0

