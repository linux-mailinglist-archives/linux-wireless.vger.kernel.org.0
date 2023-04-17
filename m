Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5E16E3D66
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 04:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDQCTi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 22:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjDQCTf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 22:19:35 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4878E30F5
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 19:19:02 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33H2IYnZ4031126, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33H2IYnZ4031126
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 17 Apr 2023 10:18:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 17 Apr 2023 10:18:01 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 17 Apr
 2023 10:18:00 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/7] wifi: rtw89: set capability of TX antenna diversity
Date:   Mon, 17 Apr 2023 10:17:02 +0800
Message-ID: <20230417021707.16369-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417021707.16369-1-pkshih@realtek.com>
References: <20230417021707.16369-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TX antenna diversity is a mechanism to select a proper antenna from two
antenna for single one hardware PHY chip. It chooses antenna with better
EVM or RSSI, and use GPIO to control SPDT to switch selected antenna.

RFE type from efuse is used to define if a module can support TX antenna
diversity when (type % 3) is 2.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 10 ++++++++--
 drivers/net/wireless/realtek/rtw89/core.h     |  2 ++
 drivers/net/wireless/realtek/rtw89/mac.c      |  9 +++++++++
 drivers/net/wireless/realtek/rtw89/mac80211.c |  7 ++++++-
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 157287ea86b46..44190f9843400 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3665,6 +3665,7 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	struct rtw89_hal *hal = &rtwdev->hal;
 	int ret;
 	int tx_headroom = IEEE80211_HT_CTL_LEN;
 
@@ -3703,8 +3704,13 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 				     BIT(NL80211_IFTYPE_P2P_CLIENT) |
 				     BIT(NL80211_IFTYPE_P2P_GO);
 
-	hw->wiphy->available_antennas_tx = BIT(rtwdev->chip->rf_path_num) - 1;
-	hw->wiphy->available_antennas_rx = BIT(rtwdev->chip->rf_path_num) - 1;
+	if (hal->ant_diversity) {
+		hw->wiphy->available_antennas_tx = 0x3;
+		hw->wiphy->available_antennas_rx = 0x3;
+	} else {
+		hw->wiphy->available_antennas_tx = BIT(rtwdev->chip->rf_path_num) - 1;
+		hw->wiphy->available_antennas_rx = BIT(rtwdev->chip->rf_path_num) - 1;
+	}
 
 	hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_TDLS |
 			    WIPHY_FLAG_TDLS_EXTERNAL_SETUP |
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index eab0abb9d213c..35413101a15ef 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3420,6 +3420,8 @@ struct rtw89_hal {
 	u8 tx_nss;
 	u8 rx_nss;
 	bool tx_path_diversity;
+	bool ant_diversity;
+	bool ant_diversity_fixed;
 	bool support_cckpd;
 	bool support_igi;
 	atomic_t roc_entity_idx;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 385e2a0dfea58..19aaa4a6dde94 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2596,6 +2596,7 @@ static int rtw89_mac_read_phycap(struct rtw89_dev *rtwdev,
 
 int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_mac_c2h_info c2h_info = {0};
@@ -2627,6 +2628,13 @@ int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev)
 		hal->tx_path_diversity = true;
 	}
 
+	if (chip->rf_path_num == 1) {
+		hal->antenna_tx = RF_A;
+		hal->antenna_rx = RF_A;
+		if ((efuse->rfe_type % 3) == 2)
+			hal->ant_diversity = true;
+	}
+
 	rtw89_debug(rtwdev, RTW89_DBG_FW,
 		    "phycap hal/phy/chip: tx_nss=0x%x/0x%x/0x%x rx_nss=0x%x/0x%x/0x%x\n",
 		    hal->tx_nss, tx_nss, chip->tx_nss,
@@ -2635,6 +2643,7 @@ int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev)
 		    "ant num/bitmap: tx=%d/0x%x rx=%d/0x%x\n",
 		    tx_ant, hal->antenna_tx, rx_ant, hal->antenna_rx);
 	rtw89_debug(rtwdev, RTW89_DBG_FW, "TX path diversity=%d\n", hal->tx_path_diversity);
+	rtw89_debug(rtwdev, RTW89_DBG_FW, "Antenna diversity=%d\n", hal->ant_diversity);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index b059aa8d88dbf..163a046d5cfa1 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -762,13 +762,18 @@ int rtw89_ops_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_hal *hal = &rtwdev->hal;
 
-	if (rx_ant != hw->wiphy->available_antennas_rx && rx_ant != hal->antenna_rx)
+	if (hal->ant_diversity) {
+		if (tx_ant != rx_ant || hweight32(tx_ant) != 1)
+			return -EINVAL;
+	} else if (rx_ant != hw->wiphy->available_antennas_rx && rx_ant != hal->antenna_rx) {
 		return -EINVAL;
+	}
 
 	mutex_lock(&rtwdev->mutex);
 	hal->antenna_tx = tx_ant;
 	hal->antenna_rx = rx_ant;
 	hal->tx_path_diversity = false;
+	hal->ant_diversity_fixed = true;
 	mutex_unlock(&rtwdev->mutex);
 
 	return 0;
-- 
2.25.1

