Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40557F0AFA
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 04:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjKTD2x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Nov 2023 22:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjKTD2t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Nov 2023 22:28:49 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB2C192
        for <linux-wireless@vger.kernel.org>; Sun, 19 Nov 2023 19:28:38 -0800 (PST)
X-UUID: dfdaab8c875411ee8051498923ad61e6-20231120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WHKjHgXikLGJDyv8AI/jp6CimfDylOTQp4C8AvVDv5Y=;
        b=o2uFmaFCJqx2Pfk3TTHuDe8cqPSZ357fL+je259U8ISI3KqBNYJeHyCZeMC2nlVdIBTlbC3KQl7xNpz6w3FLxWL5wPU6QREDDOXMXq0K7h7DeWBXyGWhfVMwnryzZR1gWWWTzgvduMewgG5c1Mf7yUwaXIS35VogOs0+hr4SC38=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:0333d20f-8ed2-4ba5-af97-cb81939143ac,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:2a0d9495-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dfdaab8c875411ee8051498923ad61e6-20231120
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <mingyen.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 604342940; Mon, 20 Nov 2023 11:28:29 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 20 Nov 2023 11:28:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 20 Nov 2023 11:28:27 +0800
From:   Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo@kernel.org>
CC:     <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>,
        <Ryder.Lee@mediatek.com>, <Shayne.Chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH 2/3] wifi: mt76: mt7921: fix CLC command timeout when suspend/resume
Date:   Mon, 20 Nov 2023 11:27:49 +0800
Message-ID: <20231120032750.19747-3-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231120032750.19747-1-mingyen.hsieh@mediatek.com>
References: <20231120032750.19747-1-mingyen.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.681300-8.000000
X-TMASE-MatchedRID: 53RBOU84eqnwa4iJAsefGEKcYi5Qw/RVG/VQKT/ZNQR+YFLISofIH2Xg
        eMJEe5Cm21PqNqqsX9ngfoEaEmt6A3wcnCGmNiJCG5mg0pzqmX6gD0t7xcmluqiDWKm0QmVU26Z
        8tetBUMDXmdTK29etzH51/Ce39OcTzrfv4DmGmcXJ5W6OZe5hherRJDUyDHkIxKLCLOyCW5D7UH
        KxrU+2pNivMxyivZ7HYMnhLsDOSO6Rs/CdRi4O05YsKSXWWrsHMZm0+sEE9mt+YesuCgkiXFmhl
        TC2eRES4vM1YF6AJbbCCfuIMF6xLcK21zBg2KlfGM6W3U+Lnne4SmePTZNPfdAWDkv38FJgJo1f
        EQQk/kYuMoaPF4sJVQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.681300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: DCF3AA004D444796D5CE39C212160FEB7489C5ED63A765BD73D1D29C4DEB94FD2000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

When enter suspend/resume while in a connected state, the upper layer
will trigger disconnection before entering suspend, and at the same time,
it will trigger regd_notifier() and update CLC, causing the CLC event to
not be received due to suspend, resulting in a command timeout.

Therefore, the update of CLC is postponed until resume, to ensure data
consistency and avoid the occurrence of command timeout.

Fixes: 4fc8df50fd41 ("wifi: mt76: mt7921: get regulatory information from the clc event")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  | 23 +++++++++++++++----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  3 +++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 7d6a9d746011..48433c6d5e7d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -110,24 +110,37 @@ mt7921_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
 	}
 }
 
+void mt7921_regd_update(struct mt792x_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	struct ieee80211_hw *hw = mdev->hw;
+	struct wiphy *wiphy = hw->wiphy;
+
+	mt7921_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env);
+	mt7921_regd_channel_update(wiphy, dev);
+	mt76_connac_mcu_set_channel_domain(hw->priv);
+	mt7921_set_tx_sar_pwr(hw, NULL);
+}
+EXPORT_SYMBOL_GPL(mt7921_regd_update);
+
 static void
 mt7921_regd_notifier(struct wiphy *wiphy,
 		     struct regulatory_request *request)
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_connac_pm *pm = &dev->pm;
 
 	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
 	dev->mt76.region = request->dfs_region;
 	dev->country_ie_env = request->country_ie_env;
 
+	if (pm->suspended)
+		return;
+
 	mt792x_mutex_acquire(dev);
-	mt7921_mcu_set_clc(dev, request->alpha2, request->country_ie_env);
-	mt76_connac_mcu_set_channel_domain(hw->priv);
-	mt7921_set_tx_sar_pwr(hw, NULL);
+	mt7921_regd_update(dev);
 	mt792x_mutex_release(dev);
-
-	mt7921_regd_channel_update(wiphy, dev);
 }
 
 int mt7921_mac_init(struct mt792x_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index f28621121927..5c4cc370e6ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -233,6 +233,7 @@ mt7921_l1_rmw(struct mt792x_dev *dev, u32 addr, u32 mask, u32 val)
 #define mt7921_l1_set(dev, addr, val)	mt7921_l1_rmw(dev, addr, 0, val)
 #define mt7921_l1_clear(dev, addr, val)	mt7921_l1_rmw(dev, addr, val, 0)
 
+void mt7921_regd_update(struct mt792x_dev *dev);
 int mt7921_mac_init(struct mt792x_dev *dev);
 bool mt7921_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask);
 int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index f04e7095e181..42fd456eb6fa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -507,6 +507,9 @@ static int mt7921_pci_resume(struct device *device)
 		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
 
 	err = mt76_connac_mcu_set_hif_suspend(mdev, false);
+
+	mt7921_regd_update(dev);
+
 failed:
 	pm->suspended = false;
 
-- 
2.18.0

