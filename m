Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321806238F4
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 02:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiKJBh0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 20:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiKJBhY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 20:37:24 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAA2201A0
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 17:37:19 -0800 (PST)
X-UUID: 9448f9a5e0d24f6f932ccd484211528f-20221110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=t/3cMdplP6bvfk49doZdF/4hC0mH6rLs2Pb0c5MFHbc=;
        b=KdYJbhI/zKdVnDf7M5MufOE5fZmVgkME6R77/qIGGKR+n1mV5Ys3zKoOc11U32m7Pp8mk1ndFiGBBHwLdeJBaxBLehjSY9vPWj9fUIk8yb/kG3iUdGmgiyS5vaqmAe/c3Ekwel8G0aAVijP5vT62NwDa08GUEyEsYhK5jOZEUos=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:7bfdc15b-b660-40cc-9075-f9ea146ce1c1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:848ad950-b7af-492d-8b40-b1032f90ce11,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9448f9a5e0d24f6f932ccd484211528f-20221110
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1853231720; Thu, 10 Nov 2022 09:37:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 10 Nov 2022 09:37:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 10 Nov 2022 09:37:12 +0800
From:   Howard Hsu <howard-yh.hsu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Howard Hsu <howard-yh.hsu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7915: fix incorrect tx path number configuration
Date:   Thu, 10 Nov 2022 09:37:01 +0800
Message-ID: <20221110013701.14790-1-howard-yh.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For a variant of mt7916, it supports up to 3 tx/rx paths but only 2
spatial streams. This implies that it has one more path to support
beamform. The correct tx/rx path number shall be configured to make sure
beamform works properly.

Fixes: 66065073177b ("wifi: mt76: mt7915: deal with special variant of mt7916")
Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>

---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c  | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 6de49b93387e..0ebaed174d5d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -953,7 +953,7 @@ mt7915_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	int max_nss = hweight8(hw->wiphy->available_antennas_tx);
-	bool ext_phy = phy != &dev->phy;
+	u8 chainshift = dev->chainshift;
 
 	if (!tx_ant || tx_ant != rx_ant || ffs(tx_ant) > max_nss)
 		return -EINVAL;
@@ -963,10 +963,10 @@ mt7915_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	phy->mt76->antenna_mask = tx_ant;
 
 	/* handle a variant of mt7916 which has 3T3R but nss2 on 5 GHz band */
-	if (is_mt7916(&dev->mt76) && ext_phy && hweight8(tx_ant) == max_nss)
-		phy->mt76->chainmask = dev->chainmask >> dev->chainshift;
+	if (is_mt7916(&dev->mt76) && phy->band_idx && hweight8(tx_ant) == max_nss)
+		phy->mt76->chainmask = (dev->chainmask >> chainshift) << chainshift;
 	else
-		phy->mt76->chainmask = tx_ant << (dev->chainshift * ext_phy);
+		phy->mt76->chainmask = tx_ant << (chainshift * phy->band_idx);
 
 	mt76_set_stream_caps(phy->mt76, true);
 	mt7915_set_stream_vht_txbf_caps(phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 65ae959859e7..790d690fabc3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2632,8 +2632,8 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 		u8 control_ch;
 		u8 center_ch;
 		u8 bw;
-		u8 tx_streams_num;
-		u8 rx_streams;	/* mask or num */
+		u8 tx_path_num;
+		u8 rx_path;	/* mask or num */
 		u8 switch_reason;
 		u8 band_idx;
 		u8 center_ch2;	/* for 80+80 only */
@@ -2649,8 +2649,8 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 		.control_ch = chandef->chan->hw_value,
 		.center_ch = ieee80211_frequency_to_channel(freq1),
 		.bw = mt76_connac_chan_bw(chandef),
-		.tx_streams_num = hweight8(phy->mt76->antenna_mask),
-		.rx_streams = phy->mt76->antenna_mask,
+		.tx_path_num = hweight16(phy->mt76->chainmask),
+		.rx_path = phy->mt76->chainmask >> (dev->chainshift * phy->band_idx),
 		.band_idx = phy->band_idx,
 		.channel_band = ch_band[chandef->chan->band],
 	};
@@ -2658,13 +2658,13 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 #ifdef CONFIG_NL80211_TESTMODE
 	if (phy->mt76->test.tx_antenna_mask &&
 	    mt76_testmode_enabled(phy->mt76)) {
-		req.tx_streams_num = fls(phy->mt76->test.tx_antenna_mask);
-		req.rx_streams = phy->mt76->test.tx_antenna_mask;
+		req.tx_path_num = fls(phy->mt76->test.tx_antenna_mask);
+		req.rx_path = phy->mt76->test.tx_antenna_mask;
 	}
 #endif
 
 	if (mt76_connac_spe_idx(phy->mt76->antenna_mask))
-		req.tx_streams_num = fls(phy->mt76->antenna_mask);
+		req.tx_path_num = fls(phy->mt76->antenna_mask);
 
 	if (cmd == MCU_EXT_CMD(SET_RX_PATH) ||
 	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
@@ -2678,7 +2678,7 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 		req.switch_reason = CH_SWITCH_NORMAL;
 
 	if (cmd == MCU_EXT_CMD(CHANNEL_SWITCH))
-		req.rx_streams = hweight8(req.rx_streams);
+		req.rx_path = hweight8(req.rx_path);
 
 	if (chandef->width == NL80211_CHAN_WIDTH_80P80) {
 		int freq2 = chandef->center_freq2;
-- 
2.18.0

