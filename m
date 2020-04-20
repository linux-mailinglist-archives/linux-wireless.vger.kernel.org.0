Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFD31B0134
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2020 07:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDTFvW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Apr 2020 01:51:22 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42174 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgDTFvP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Apr 2020 01:51:15 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03K5p9gZ5000971, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03K5p9gZ5000971
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Apr 2020 13:51:09 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 20 Apr 2020 13:51:08 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 20 Apr 2020 13:51:08 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 7/8] rtw88: 8723d: Add new chip op efuse_grant() to control efuse access
Date:   Mon, 20 Apr 2020 13:50:53 +0800
Message-ID: <20200420055054.14592-8-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420055054.14592-1-yhchuang@realtek.com>
References: <20200420055054.14592-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

8723D devices need to grant efuse access before dumping physical efuse
map, other chips don't need it, so keep this ops as blank.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/efuse.c    |  4 ++++
 drivers/net/wireless/realtek/rtw88/main.h     | 13 +++++++++++++
 drivers/net/wireless/realtek/rtw88/reg.h      |  9 +++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 13 +++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/efuse.c b/drivers/net/wireless/realtek/rtw88/efuse.c
index 212c8376a8c9..df969d346b41 100644
--- a/drivers/net/wireless/realtek/rtw88/efuse.c
+++ b/drivers/net/wireless/realtek/rtw88/efuse.c
@@ -90,6 +90,8 @@ static int rtw_dump_physical_efuse_map(struct rtw_dev *rtwdev, u8 *map)
 	u32 addr;
 	u32 cnt;
 
+	rtw_chip_efuse_grant_on(rtwdev);
+
 	switch_efuse_bank(rtwdev);
 
 	/* disable 2.5V LDO */
@@ -113,6 +115,8 @@ static int rtw_dump_physical_efuse_map(struct rtw_dev *rtwdev, u8 *map)
 		*(map + addr) = (u8)(efuse_ctl & BIT_MASK_EF_DATA);
 	}
 
+	rtw_chip_efuse_grant_off(rtwdev);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 8f15fc113af0..74302181da53 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -811,6 +811,7 @@ struct rtw_chip_ops {
 			   u32 antenna_tx,
 			   u32 antenna_rx);
 	void (*cfg_ldo25)(struct rtw_dev *rtwdev, bool enable);
+	void (*efuse_grant)(struct rtw_dev *rtwdev, bool enable);
 	void (*false_alarm_statistics)(struct rtw_dev *rtwdev);
 	void (*phy_calibration)(struct rtw_dev *rtwdev);
 	void (*dpk_track)(struct rtw_dev *rtwdev);
@@ -1712,6 +1713,18 @@ static inline bool rtw_ssid_equal(struct cfg80211_ssid *a,
 	return true;
 }
 
+static inline void rtw_chip_efuse_grant_on(struct rtw_dev *rtwdev)
+{
+	if (rtwdev->chip->ops->efuse_grant)
+		rtwdev->chip->ops->efuse_grant(rtwdev, true);
+}
+
+static inline void rtw_chip_efuse_grant_off(struct rtw_dev *rtwdev)
+{
+	if (rtwdev->chip->ops->efuse_grant)
+		rtwdev->chip->ops->efuse_grant(rtwdev, false);
+}
+
 void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 			    struct rtw_channel_params *ch_param);
 bool check_hw_ready(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 target);
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 2afd547ebcc9..911d8e75db77 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -6,6 +6,7 @@
 #define __RTW_REG_DEF_H__
 
 #define REG_SYS_FUNC_EN		0x0002
+#define BIT_FEN_ELDR		BIT(12)
 #define BIT_FEN_CPUEN		BIT(2)
 #define BIT_FEN_BB_GLB_RST	BIT(1)
 #define BIT_FEN_BB_RSTB		BIT(0)
@@ -15,6 +16,10 @@
 #define REG_SYS_CLK_CTRL	0x0008
 #define BIT_CPU_CLK_EN		BIT(14)
 
+#define REG_SYS_CLKR		0x0008
+#define BIT_ANA8M		BIT(1)
+#define BIT_LOADER_CLK_EN	BIT(5)
+
 #define REG_RSV_CTRL		0x001C
 #define DISABLE_PI		0x3
 #define ENABLE_PI		0x2
@@ -87,6 +92,10 @@
 				 BIT_CHECK_SUM_OK)
 #define FW_READY_MASK		0xffff
 
+#define REG_EFUSE_ACCESS	0x00CF
+#define EFUSE_ACCESS_ON		0x69
+#define EFUSE_ACCESS_OFF	0x00
+
 #define REG_WLRF1		0x00EC
 #define REG_WIFI_BT_INFO	0x00AA
 #define BIT_BT_INT_EN		BIT(15)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 04f8d73e4e6c..756454d69fad 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -28,11 +28,24 @@ static void rtw8723d_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 	rtw_write8(rtwdev, REG_LDO_EFUSE_CTRL + 3, ldo_pwr);
 }
 
+static void rtw8723d_efuse_grant(struct rtw_dev *rtwdev, bool on)
+{
+	if (on) {
+		rtw_write8(rtwdev, REG_EFUSE_ACCESS, EFUSE_ACCESS_ON);
+
+		rtw_write16_set(rtwdev, REG_SYS_FUNC_EN, BIT_FEN_ELDR);
+		rtw_write16_set(rtwdev, REG_SYS_CLKR, BIT_LOADER_CLK_EN | BIT_ANA8M);
+	} else {
+		rtw_write8(rtwdev, REG_EFUSE_ACCESS, EFUSE_ACCESS_OFF);
+	}
+}
+
 static struct rtw_chip_ops rtw8723d_ops = {
 	.read_rf		= rtw_phy_read_rf_sipi,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
 	.set_antenna		= NULL,
 	.cfg_ldo25		= rtw8723d_cfg_ldo25,
+	.efuse_grant		= rtw8723d_efuse_grant,
 	.config_bfee		= NULL,
 	.set_gid_table		= NULL,
 	.cfg_csi_rate		= NULL,
-- 
2.17.1

