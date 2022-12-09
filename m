Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A26647C09
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 03:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLICLD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 21:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiLICK7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 21:10:59 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2412E9FD4
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 18:10:56 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B92A1XX0005396, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B92A1XX0005396
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 9 Dec 2022 10:10:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 9 Dec 2022 10:10:49 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 9 Dec 2022
 10:10:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: rtw89: 8852c: rfk: recover RX DCK failure
Date:   Fri, 9 Dec 2022 10:09:40 +0800
Message-ID: <20221209020940.9573-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221209020940.9573-1-pkshih@realtek.com>
References: <20221209020940.9573-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/09/2022 01:50:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzkgpFekyCAxMjoyMzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RX DCK stands for RX DC calibration that affects CCA, so abnormal
calibration values resulted from calibration failure can cause TX get
stuck.

To solve this, redo calibration if result is bad (over thresholds). When
retry count is over, do recovery that sets high gain fields of RX DCK
results from low gain fields.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  10 +
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 253 +++++++++++++++++-
 2 files changed, 256 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index ca6f6c3e63095..ec5b8d5750364 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3559,6 +3559,7 @@
 #define RR_MOD_IQK GENMASK(19, 4)
 #define RR_MOD_DPK GENMASK(19, 5)
 #define RR_MOD_MASK GENMASK(19, 16)
+#define RR_MOD_DCK GENMASK(14, 10)
 #define RR_MOD_RGM GENMASK(13, 4)
 #define RR_MOD_V_DOWN 0x0
 #define RR_MOD_V_STANDBY 0x1
@@ -3572,6 +3573,7 @@
 #define RR_MOD_NBW GENMASK(15, 14)
 #define RR_MOD_M_RXG GENMASK(13, 4)
 #define RR_MOD_M_RXBB GENMASK(9, 5)
+#define RR_MOD_LO_SEL BIT(1)
 #define RR_MODOPT 0x01
 #define RR_MODOPT_M_TXPWR GENMASK(5, 0)
 #define RR_WLSEL 0x02
@@ -3638,6 +3640,7 @@
 #define RR_LUTWA_M2 GENMASK(4, 0)
 #define RR_LUTWD1 0x3e
 #define RR_LUTWD0 0x3f
+#define RR_LUTWD0_MB GENMASK(11, 6)
 #define RR_LUTWD0_LB GENMASK(5, 0)
 #define RR_TM 0x42
 #define RR_TM_TRI BIT(19)
@@ -3731,10 +3734,14 @@
 #define RR_XALNA2_SW2 GENMASK(9, 8)
 #define RR_XALNA2_SW GENMASK(1, 0)
 #define RR_DCK 0x92
+#define RR_DCK_S1 GENMASK(19, 16)
+#define RR_DCK_TIA GENMASK(15, 9)
 #define RR_DCK_DONE GENMASK(7, 5)
 #define RR_DCK_FINE BIT(1)
 #define RR_DCK_LV BIT(0)
 #define RR_DCK1 0x93
+#define RR_DCK1_S1 GENMASK(19, 16)
+#define RR_DCK1_TIA GENMASK(15, 9)
 #define RR_DCK1_DONE BIT(5)
 #define RR_DCK1_CLR GENMASK(3, 0)
 #define RR_DCK1_SEL BIT(3)
@@ -3783,11 +3790,14 @@
 #define RR_LUTDBG 0xdf
 #define RR_LUTDBG_TIA BIT(12)
 #define RR_LUTDBG_LOK BIT(2)
+#define RR_LUTPLL 0xec
+#define RR_CAL_RW BIT(19)
 #define RR_LUTWE2 0xee
 #define RR_LUTWE2_RTXBW BIT(2)
 #define RR_LUTWE 0xef
 #define RR_LUTWE_LOK BIT(2)
 #define RR_RFC 0xf0
+#define RR_WCAL BIT(16)
 #define RR_RFC_CKEN BIT(1)
 
 #define R_UPD_P0 0x0000
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index f3a07b0e672f7..b0ea23d9f81fb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -59,6 +59,9 @@ static const u32 dpk_par_regs[RTW89_DPK_RF_PATH][4] = {
 	{0x81a8, 0x81c4, 0x81c8, 0x81e8},
 };
 
+static const u8 _dck_addr_bs[RF_PATH_NUM_8852C] = {0x0, 0x10};
+static const u8 _dck_addr[RF_PATH_NUM_8852C] = {0xc, 0x1c};
+
 static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]dbcc_en: %x,  PHY%d\n",
@@ -1536,6 +1539,155 @@ static void _iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool forc
 	}
 }
 
+static void _rx_dck_value_rewrite(struct rtw89_dev *rtwdev, u8 path, u8 addr,
+				  u8 val_i, u8 val_q)
+{
+	u32 ofst_val;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[RX_DCK] rewrite val_i = 0x%x, val_q = 0x%x\n", val_i, val_q);
+
+	/* val_i and val_q are 7 bits, and target is 6 bits. */
+	ofst_val = u32_encode_bits(val_q >> 1, RR_LUTWD0_MB) |
+		   u32_encode_bits(val_i >> 1, RR_LUTWD0_LB);
+
+	rtw89_write_rf(rtwdev, path, RR_LUTPLL, RR_CAL_RW, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_RFC, RR_WCAL, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_FINE, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_LUTWA, MASKBYTE0, addr);
+	rtw89_write_rf(rtwdev, path, RR_LUTWD0, RFREG_MASK, ofst_val);
+	rtw89_write_rf(rtwdev, path, RR_LUTWD0, RFREG_MASK, ofst_val);
+	rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_FINE, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_RFC, RR_WCAL, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_LUTPLL, RR_CAL_RW, 0x0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RX_DCK] Final val_i = 0x%x, val_q = 0x%x\n",
+		    u32_get_bits(ofst_val, RR_LUTWD0_LB) << 1,
+		    u32_get_bits(ofst_val, RR_LUTWD0_MB) << 1);
+}
+
+static bool _rx_dck_rek_check(struct rtw89_dev *rtwdev, u8 path)
+{
+	u8 i_even_bs, q_even_bs;
+	u8 i_odd_bs, q_odd_bs;
+	u8 i_even, q_even;
+	u8 i_odd, q_odd;
+	const u8 th = 10;
+	u8 i;
+
+	for (i = 0; i < RF_PATH_NUM_8852C; i++) {
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_DCK, _dck_addr_bs[i]);
+		i_even_bs = rtw89_read_rf(rtwdev, path, RR_DCK, RR_DCK_TIA);
+		q_even_bs = rtw89_read_rf(rtwdev, path, RR_DCK1, RR_DCK1_TIA);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RX_DCK] Gain[0x%x] i_even_bs/ q_even_bs = 0x%x/ 0x%x\n",
+			    _dck_addr_bs[i], i_even_bs, q_even_bs);
+
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_DCK, _dck_addr[i]);
+		i_even = rtw89_read_rf(rtwdev, path, RR_DCK, RR_DCK_TIA);
+		q_even = rtw89_read_rf(rtwdev, path, RR_DCK1, RR_DCK1_TIA);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RX_DCK] Gain[0x%x] i_even/ q_even = 0x%x/ 0x%x\n",
+			    _dck_addr[i], i_even, q_even);
+
+		if (abs(i_even_bs - i_even) > th || abs(q_even_bs - q_even) > th)
+			return true;
+
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_DCK, _dck_addr_bs[i] + 1);
+		i_odd_bs = rtw89_read_rf(rtwdev, path, RR_DCK, RR_DCK_TIA);
+		q_odd_bs = rtw89_read_rf(rtwdev, path, RR_DCK1, RR_DCK1_TIA);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RX_DCK] Gain[0x%x] i_odd_bs/ q_odd_bs = 0x%x/ 0x%x\n",
+			    _dck_addr_bs[i] + 1, i_odd_bs, q_odd_bs);
+
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_DCK, _dck_addr[i] + 1);
+		i_odd = rtw89_read_rf(rtwdev, path, RR_DCK, RR_DCK_TIA);
+		q_odd = rtw89_read_rf(rtwdev, path, RR_DCK1, RR_DCK1_TIA);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RX_DCK] Gain[0x%x] i_odd/ q_odd = 0x%x/ 0x%x\n",
+			    _dck_addr[i] + 1, i_odd, q_odd);
+
+		if (abs(i_odd_bs - i_odd) > th || abs(q_odd_bs - q_odd) > th)
+			return true;
+	}
+
+	return false;
+}
+
+static void _rx_dck_fix_if_need(struct rtw89_dev *rtwdev, u8 path, u8 addr,
+				u8 val_i_bs, u8 val_q_bs, u8 val_i, u8 val_q)
+{
+	const u8 th = 10;
+
+	if ((abs(val_i_bs - val_i) < th) && (abs(val_q_bs - val_q) <= th)) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RX_DCK] offset check PASS!!\n");
+		return;
+	}
+
+	if (abs(val_i_bs - val_i) > th) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RX_DCK] val_i over TH (0x%x / 0x%x)\n", val_i_bs, val_i);
+		val_i = val_i_bs;
+	}
+
+	if (abs(val_q_bs - val_q) > th) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RX_DCK] val_q over TH (0x%x / 0x%x)\n", val_q_bs, val_q);
+		val_q = val_q_bs;
+	}
+
+	_rx_dck_value_rewrite(rtwdev, path, addr, val_i, val_q);
+}
+
+static void _rx_dck_recover(struct rtw89_dev *rtwdev, u8 path)
+{
+	u8 i_even_bs, q_even_bs;
+	u8 i_odd_bs, q_odd_bs;
+	u8 i_even, q_even;
+	u8 i_odd, q_odd;
+	u8 i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RX_DCK] ===> recovery\n");
+
+	for (i = 0; i < RF_PATH_NUM_8852C; i++) {
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_DCK, _dck_addr_bs[i]);
+		i_even_bs = rtw89_read_rf(rtwdev, path, RR_DCK, RR_DCK_TIA);
+		q_even_bs = rtw89_read_rf(rtwdev, path, RR_DCK1, RR_DCK1_TIA);
+
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_DCK, _dck_addr_bs[i] + 1);
+		i_odd_bs = rtw89_read_rf(rtwdev, path, RR_DCK, RR_DCK_TIA);
+		q_odd_bs = rtw89_read_rf(rtwdev, path, RR_DCK1, RR_DCK1_TIA);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RX_DCK] Gain[0x%x] i_even_bs/ q_even_bs = 0x%x/ 0x%x\n",
+			    _dck_addr_bs[i], i_even_bs, q_even_bs);
+
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_DCK, _dck_addr[i]);
+		i_even = rtw89_read_rf(rtwdev, path, RR_DCK, RR_DCK_TIA);
+		q_even = rtw89_read_rf(rtwdev, path, RR_DCK1, RR_DCK1_TIA);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RX_DCK] Gain[0x%x] i_even/ q_even = 0x%x/ 0x%x\n",
+			    _dck_addr[i], i_even, q_even);
+		_rx_dck_fix_if_need(rtwdev, path, _dck_addr[i],
+				    i_even_bs, q_even_bs, i_even, q_even);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RX_DCK] Gain[0x%x] i_odd_bs/ q_odd_bs = 0x%x/ 0x%x\n",
+			    _dck_addr_bs[i] + 1, i_odd_bs, q_odd_bs);
+
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_DCK, _dck_addr[i] + 1);
+		i_odd = rtw89_read_rf(rtwdev, path, RR_DCK, RR_DCK_TIA);
+		q_odd = rtw89_read_rf(rtwdev, path, RR_DCK1, RR_DCK1_TIA);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RX_DCK] Gain[0x%x] i_odd/ q_odd = 0x%x/ 0x%x\n",
+			    _dck_addr[i] + 1, i_odd, q_odd);
+		_rx_dck_fix_if_need(rtwdev, path, _dck_addr[i] + 1,
+				    i_odd_bs, q_odd_bs, i_odd, q_odd);
+	}
+}
+
 static void _rx_dck_toggle(struct rtw89_dev *rtwdev, u8 path)
 {
 	int ret;
@@ -1573,6 +1725,37 @@ static void _set_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, u8 pat
 	}
 }
 
+static
+u8 _rx_dck_channel_calc(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan)
+{
+	u8 target_ch = 0;
+
+	if (chan->band_type == RTW89_BAND_5G) {
+		if (chan->channel >= 36 && chan->channel <= 64) {
+			target_ch = 100;
+		} else if (chan->channel >= 100 && chan->channel <= 144) {
+			target_ch = chan->channel + 32;
+			if (target_ch > 144)
+				target_ch = chan->channel + 33;
+		} else if (chan->channel >= 149 && chan->channel <= 177) {
+			target_ch = chan->channel - 33;
+		}
+	} else if (chan->band_type == RTW89_BAND_6G) {
+		if (chan->channel >= 1 && chan->channel <= 125)
+			target_ch = chan->channel + 32;
+		else
+			target_ch = chan->channel - 32;
+	} else {
+		target_ch = chan->channel;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[RX_DCK] cur_ch / target_ch = %d / %d\n",
+		    chan->channel, target_ch);
+
+	return target_ch;
+}
+
 #define RTW8852C_RF_REL_VERSION 34
 #define RTW8852C_DPK_VER 0x10
 #define RTW8852C_DPK_TH_AVG_NUM 4
@@ -3874,11 +4057,14 @@ void rtw8852c_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 
 #define RXDCK_VER_8852C 0xe
 
-void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool is_afe)
+static void _rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		    bool is_afe, u8 retry_limit)
 {
 	struct rtw89_rx_dck_info *rx_dck = &rtwdev->rx_dck;
 	u8 path, kpath;
 	u32 rf_reg5;
+	bool is_fail;
+	u8 rek_cnt;
 
 	kpath = _kpath(rtwdev, phy);
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
@@ -3895,7 +4081,27 @@ void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool is_a
 					       B_P0_TSSI_TRK_EN, 0x1);
 		rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x0);
 		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, RR_MOD_V_RX);
-		_set_rx_dck(rtwdev, phy, path, is_afe);
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_LO_SEL, rtwdev->dbcc_en);
+
+		for (rek_cnt = 0; rek_cnt < retry_limit; rek_cnt++) {
+			_set_rx_dck(rtwdev, phy, path, is_afe);
+
+			/* To reduce IO of dck_rek_check(), the last try is seen
+			 * as failure always, and then do recovery procedure.
+			 */
+			if (rek_cnt == retry_limit - 1) {
+				_rx_dck_recover(rtwdev, path);
+				break;
+			}
+
+			is_fail = _rx_dck_rek_check(rtwdev, path);
+			if (!is_fail)
+				break;
+		}
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RX_DCK] rek_cnt[%d]=%d",
+			    path, rek_cnt);
+
 		rx_dck->thermal[path] = ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]);
 		rtw89_write_rf(rtwdev, path, RR_RSV1, RFREG_MASK, rf_reg5);
 
@@ -3905,15 +4111,31 @@ void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool is_a
 	}
 }
 
-#define RTW8852C_RX_DCK_TH 8
+void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool is_afe)
+{
+	_rx_dck(rtwdev, phy, is_afe, 1);
+}
+
+#define RTW8852C_RX_DCK_TH 12
 
 void rtw8852c_rx_dck_track(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct rtw89_rx_dck_info *rx_dck = &rtwdev->rx_dck;
+	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u8 dck_channel;
 	u8 cur_thermal;
+	u32 tx_en;
 	int delta;
 	int path;
 
+	if (chan->band_type == RTW89_BAND_2G)
+		return;
+
+	if (rtwdev->scanning)
+		return;
+
 	for (path = 0; path < RF_PATH_NUM_8852C; path++) {
 		cur_thermal =
 			ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]);
@@ -3923,11 +4145,28 @@ void rtw8852c_rx_dck_track(struct rtw89_dev *rtwdev)
 			    "[RX_DCK] path=%d current thermal=0x%x delta=0x%x\n",
 			    path, cur_thermal, delta);
 
-		if (delta >= RTW8852C_RX_DCK_TH) {
-			rtw8852c_rx_dck(rtwdev, RTW89_PHY_0, false);
-			return;
-		}
+		if (delta >= RTW8852C_RX_DCK_TH)
+			goto trigger_rx_dck;
 	}
+
+	return;
+
+trigger_rx_dck:
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_START);
+	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
+
+	for (path = 0; path < RF_PATH_NUM_8852C; path++) {
+		dck_channel = _rx_dck_channel_calc(rtwdev, chan);
+		_ctrl_ch(rtwdev, RTW89_PHY_0, dck_channel, chan->band_type);
+	}
+
+	_rx_dck(rtwdev, RTW89_PHY_0, false, 20);
+
+	for (path = 0; path < RF_PATH_NUM_8852C; path++)
+		_ctrl_ch(rtwdev, RTW89_PHY_0, chan->channel, chan->band_type);
+
+	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_STOP);
 }
 
 void rtw8852c_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
-- 
2.25.1

