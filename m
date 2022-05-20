Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175CC52E83A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 11:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347324AbiETJEN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 05:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345270AbiETJEL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 05:04:11 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281C8EBA93
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 02:04:10 -0700 (PDT)
X-UUID: ca723ae28a8e4baa8e5479c87d53e56a-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:036f244f-e6cd-4412-a6a9-dbeec8727a28,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:100
X-CID-INFO: VERSION:1.1.5,REQID:036f244f-e6cd-4412-a6a9-dbeec8727a28,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:100
X-CID-META: VersionHash:2a19b09,CLOUDID:a814efe2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:c8c7156697e9,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: ca723ae28a8e4baa8e5479c87d53e56a-20220520
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1112631103; Fri, 20 May 2022 17:04:04 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 20 May 2022 17:04:03 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 May 2022 17:04:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 20 May 2022 17:04:03 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        "Eric-SY Chang" <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Shayne Chen" <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>,
        "Ming Yen Hsieh" <mingyen.hsieh@mediatek.com>
Subject: [PATCH v2 3/3] mt76: mt7921: introduce ACPI SAR config in tx power
Date:   Fri, 20 May 2022 17:03:39 +0800
Message-ID: <777ef51ddf8d871b16a634c8e220787b2e8a7e01.1653032296.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1653032296.git.deren.wu@mediatek.com>
References: <cover.1653032296.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Add new function mt7921_set_tx_sar_pwr() to update SAR power from
.set_sar_specs and ACPI setting. Both settings would be merged into
mt76_freq_range_power for final tx power value.

Reviewed-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 31 +++++++++++++------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 ++
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 0c4e973d002e..48a10aaecc62 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -34,14 +34,13 @@ mt7921_regd_notifier(struct wiphy *wiphy,
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 
 	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
 	dev->mt76.region = request->dfs_region;
 
 	mt7921_mutex_acquire(dev);
 	mt76_connac_mcu_set_channel_domain(hw->priv);
-	mt76_connac_mcu_set_rate_txpower(phy->mt76);
+	mt7921_set_tx_sar_pwr(hw, NULL);
 	mt7921_mutex_release(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 80279f342109..acf6567368b7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -257,7 +257,7 @@ int __mt7921_start(struct mt7921_phy *phy)
 	if (err)
 		return err;
 
-	err = mt76_connac_mcu_set_rate_txpower(phy->mt76);
+	err = mt7921_set_tx_sar_pwr(mphy->hw, NULL);
 	if (err)
 		return err;
 
@@ -548,7 +548,7 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 	mt7921_mutex_acquire(dev);
 
 	if (changed & IEEE80211_CONF_CHANGE_POWER) {
-		ret = mt76_connac_mcu_set_rate_txpower(phy->mt76);
+		ret = mt7921_set_tx_sar_pwr(hw, NULL);
 		if (ret)
 			goto out;
 	}
@@ -1469,20 +1469,33 @@ static void mt7921_ipv6_addr_change(struct ieee80211_hw *hw,
 }
 #endif
 
+int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
+			  const struct cfg80211_sar_specs *sar)
+{
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+
+	if (sar) {
+		err = mt76_init_sar_power(hw, sar);
+		if (err)
+			return err;
+	}
+
+	mt7921_init_acpi_sar_power(mt7921_hw_phy(hw), !sar);
+
+	err = mt76_connac_mcu_set_rate_txpower(mphy);
+
+	return err;
+}
+
 static int mt7921_set_sar_specs(struct ieee80211_hw *hw,
 				const struct cfg80211_sar_specs *sar)
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct mt76_phy *mphy = hw->priv;
 	int err;
 
 	mt7921_mutex_acquire(dev);
-	err = mt76_init_sar_power(hw, sar);
-	if (err)
-		goto out;
-
-	err = mt76_connac_mcu_set_rate_txpower(mphy);
-out:
+	err = mt7921_set_tx_sar_pwr(hw, sar);
 	mt7921_mutex_release(dev);
 
 	return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 8b26bece28ae..d9fc457e420d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -501,4 +501,6 @@ mt7921_init_acpi_sar_power(struct mt7921_phy *phy, bool set_default)
 	return 0;
 }
 #endif
+int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
+			  const struct cfg80211_sar_specs *sar);
 #endif
-- 
2.18.0

