Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E041A4504
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2020 12:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDJKKI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Apr 2020 06:10:08 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:32796 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgDJKKI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Apr 2020 06:10:08 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03AA9xbcE027574, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03AA9xbcE027574
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Apr 2020 18:09:59 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Apr 2020 18:09:59 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Apr 2020 18:09:59 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 2/2] rtw88: add support for set/get antennas
Date:   Fri, 10 Apr 2020 18:09:50 +0800
Message-ID: <20200410100950.3199-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410100950.3199-1-yhchuang@realtek.com>
References: <20200410100950.3199-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

User space program such as iw can set antenna mask for the device.
So add set antenna support by configure the trx mode.

This is useful for some tests want to see the output of different
antenna configuration (e.g. path A v.s. path B).

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 33 +++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.c     |  3 ++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 35 +++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index d7d02e4c0184..a2e6ef4ad9ee 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -754,6 +754,37 @@ static int rtw_ops_set_bitrate_mask(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static int rtw_ops_set_antenna(struct ieee80211_hw *hw,
+			       u32 tx_antenna,
+			       u32 rx_antenna)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	int ret;
+
+	if (!chip->ops->set_antenna)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&rtwdev->mutex);
+	ret = chip->ops->set_antenna(rtwdev, tx_antenna, rx_antenna);
+	mutex_unlock(&rtwdev->mutex);
+
+	return ret;
+}
+
+static int rtw_ops_get_antenna(struct ieee80211_hw *hw,
+			       u32 *tx_antenna,
+			       u32 *rx_antenna)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+	struct rtw_hal *hal = &rtwdev->hal;
+
+	*tx_antenna = hal->antenna_tx;
+	*rx_antenna = hal->antenna_rx;
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int rtw_ops_suspend(struct ieee80211_hw *hw,
 			   struct cfg80211_wowlan *wowlan)
@@ -815,6 +846,8 @@ const struct ieee80211_ops rtw_ops = {
 	.sta_statistics		= rtw_ops_sta_statistics,
 	.flush			= rtw_ops_flush,
 	.set_bitrate_mask	= rtw_ops_set_bitrate_mask,
+	.set_antenna		= rtw_ops_set_antenna,
+	.get_antenna		= rtw_ops_get_antenna,
 #ifdef CONFIG_PM
 	.suspend		= rtw_ops_suspend,
 	.resume			= rtw_ops_resume,
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 7640e97706f5..1e1d2c774287 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1450,6 +1450,7 @@ EXPORT_SYMBOL(rtw_core_deinit);
 
 int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 {
+	struct rtw_hal *hal = &rtwdev->hal;
 	int max_tx_headroom = 0;
 	int ret;
 
@@ -1478,6 +1479,8 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 				     BIT(NL80211_IFTYPE_AP) |
 				     BIT(NL80211_IFTYPE_ADHOC) |
 				     BIT(NL80211_IFTYPE_MESH_POINT);
+	hw->wiphy->available_antennas_tx = hal->antenna_tx;
+	hw->wiphy->available_antennas_rx = hal->antenna_rx;
 
 	hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_TDLS |
 			    WIPHY_FLAG_TDLS_EXTERNAL_SETUP;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index dc07e6be38e8..c99b1de54bfc 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1890,6 +1890,40 @@ static void rtw8822c_set_tx_power_index(struct rtw_dev *rtwdev)
 	}
 }
 
+static int rtw8822c_set_antenna(struct rtw_dev *rtwdev,
+				u32 antenna_tx,
+				u32 antenna_rx)
+{
+	struct rtw_hal *hal = &rtwdev->hal;
+
+	switch (antenna_tx) {
+	case BB_PATH_A:
+	case BB_PATH_B:
+	case BB_PATH_AB:
+		break;
+	default:
+		rtw_info(rtwdev, "unsupport tx path 0x%x\n", antenna_tx);
+		return -EINVAL;
+	}
+
+	/* path B only is not available for RX */
+	switch (antenna_rx) {
+	case BB_PATH_A:
+	case BB_PATH_AB:
+		break;
+	default:
+		rtw_info(rtwdev, "unsupport rx path 0x%x\n", antenna_rx);
+		return -EINVAL;
+	}
+
+	hal->antenna_tx = antenna_tx;
+	hal->antenna_rx = antenna_rx;
+
+	rtw8822c_config_trx_mode(rtwdev, antenna_tx, antenna_rx, false);
+
+	return 0;
+}
+
 static void rtw8822c_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 {
 	u8 ldo_pwr;
@@ -3794,6 +3828,7 @@ static struct rtw_chip_ops rtw8822c_ops = {
 	.read_rf		= rtw_phy_read_rf,
 	.write_rf		= rtw_phy_write_rf_reg_mix,
 	.set_tx_power_index	= rtw8822c_set_tx_power_index,
+	.set_antenna		= rtw8822c_set_antenna,
 	.cfg_ldo25		= rtw8822c_cfg_ldo25,
 	.false_alarm_statistics	= rtw8822c_false_alarm_statistics,
 	.dpk_track		= rtw8822c_dpk_track,
-- 
2.17.1

