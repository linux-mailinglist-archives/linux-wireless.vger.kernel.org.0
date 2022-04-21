Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120C7509F65
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Apr 2022 14:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383571AbiDUMNY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Apr 2022 08:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383795AbiDUMMq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Apr 2022 08:12:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FED9A8
        for <linux-wireless@vger.kernel.org>; Thu, 21 Apr 2022 05:09:56 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23LC9oYpA029049, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23LC9oYpA029049
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Apr 2022 20:09:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 20:09:50 +0800
Received: from localhost (172.16.16.159) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 21 Apr
 2022 20:09:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 14/14] rtw89: 8852c: add chip_ops related to BTC
Date:   Thu, 21 Apr 2022 20:09:03 +0800
Message-ID: <20220421120903.73715-15-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421120903.73715-1-pkshih@realtek.com>
References: <20220421120903.73715-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.159]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/21/2022 11:49:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjEgpFekyCAxMDowNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

Add some chip_ops to support BT coexistence to work properly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |   7 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 187 ++++++++++++++++++
 2 files changed, 194 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 6dc11e8e2a839..83cb509d2fbe9 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3048,11 +3048,18 @@
 #define B_AX_BT_CNT_RST_V1 BIT(1)
 #define B_AX_BT_CNT_EN BIT(0)
 
+#define R_BTC_BT_CNT_HIGH 0xDA14
+#define R_BTC_BT_CNT_LOW 0xDA18
+
 #define R_AX_BTC_FUNC_EN 0xDA20
 #define R_AX_BTC_FUNC_EN_C1 0xFA20
 #define B_AX_PTA_WL_TX_EN BIT(1)
 #define B_AX_PTA_EDCCA_EN BIT(0)
 
+#define R_BTC_COEX_WL_REQ 0xDA24
+#define B_BTC_TX_BCN_HI BIT(22)
+#define B_BTC_RSP_ACK_HI BIT(10)
+
 #define R_BTC_BREAK_TABLE 0xDA2C
 #define BTC_BREAK_PARAM 0xf0ffffff
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index f66e4e091e439..858611c64e6bf 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2338,6 +2338,33 @@ static u8 rtw8852c_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_p
 	return rtw89_read_rf(rtwdev, rf_path, RR_TM, RR_TM_VAL);
 }
 
+static void rtw8852c_btc_set_rfe(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_module *module = &btc->mdinfo;
+
+	module->rfe_type = rtwdev->efuse.rfe_type;
+	module->cv = rtwdev->hal.cv;
+	module->bt_solo = 0;
+	module->switch_type = BTC_SWITCH_INTERNAL;
+
+	if (module->rfe_type > 0)
+		module->ant.num = (module->rfe_type % 2 ? 2 : 3);
+	else
+		module->ant.num = 2;
+
+	module->ant.diversity = 0;
+	module->ant.isolation = 10;
+
+	if (module->ant.num == 3) {
+		module->ant.type = BTC_ANT_DEDICATED;
+		module->bt_pos = BTC_BT_ALONE;
+	} else {
+		module->ant.type = BTC_ANT_SHARED;
+		module->bt_pos = BTC_BT_BTG;
+	}
+}
+
 static void rtw8852c_ctrl_btg(struct rtw89_dev *rtwdev, bool btg)
 {
 	if (btg) {
@@ -2440,6 +2467,159 @@ static void rtw8852c_btc_init_cfg(struct rtw89_dev *rtwdev)
 	btc->cx.wl.status.map.init_ok = true;
 }
 
+static
+void rtw8852c_btc_set_wl_pri(struct rtw89_dev *rtwdev, u8 map, bool state)
+{
+	u32 bitmap = 0;
+	u32 reg = 0;
+
+	switch (map) {
+	case BTC_PRI_MASK_TX_RESP:
+		reg = R_BTC_COEX_WL_REQ;
+		bitmap = B_BTC_RSP_ACK_HI;
+		break;
+	case BTC_PRI_MASK_BEACON:
+		reg = R_BTC_COEX_WL_REQ;
+		bitmap = B_BTC_TX_BCN_HI;
+		break;
+	default:
+		return;
+	}
+
+	if (state)
+		rtw89_write32_set(rtwdev, reg, bitmap);
+	else
+		rtw89_write32_clr(rtwdev, reg, bitmap);
+}
+
+union rtw8852c_btc_wl_txpwr_ctrl {
+	u32 txpwr_val;
+	struct {
+		union {
+			u16 ctrl_all_time;
+			struct {
+				s16 data:9;
+				u16 rsvd:6;
+				u16 flag:1;
+			} all_time;
+		};
+		union {
+			u16 ctrl_gnt_bt;
+			struct {
+				s16 data:9;
+				u16 rsvd:7;
+			} gnt_bt;
+		};
+	};
+} __packed;
+
+static void
+rtw8852c_btc_set_wl_txpwr_ctrl(struct rtw89_dev *rtwdev, u32 txpwr_val)
+{
+	union rtw8852c_btc_wl_txpwr_ctrl arg = { .txpwr_val = txpwr_val };
+	s32 val;
+
+#define __write_ctrl(_reg, _msk, _val, _en, _cond)		\
+do {								\
+	const typeof(_msk) __msk = _msk;			\
+	const typeof(_en) __en = _en;				\
+	u32 _wrt = FIELD_PREP(__msk, _val);			\
+	BUILD_BUG_ON((__msk & __en) != 0);			\
+	if (_cond)						\
+		_wrt |= __en;					\
+	else							\
+		_wrt &= ~__en;					\
+	rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, _reg,	\
+				     __msk | __en, _wrt);	\
+} while (0)
+
+	switch (arg.ctrl_all_time) {
+	case 0xffff:
+		val = 0;
+		break;
+	default:
+		val = arg.all_time.data;
+		break;
+	}
+
+	__write_ctrl(R_AX_PWR_RATE_CTRL, B_AX_FORCE_PWR_BY_RATE_VALUE_MASK,
+		     val, B_AX_FORCE_PWR_BY_RATE_EN,
+		     arg.ctrl_all_time != 0xffff);
+
+	switch (arg.ctrl_gnt_bt) {
+	case 0xffff:
+		val = 0;
+		break;
+	default:
+		val = arg.gnt_bt.data;
+		break;
+	};
+
+	__write_ctrl(R_AX_PWR_COEXT_CTRL, B_AX_TXAGC_BT_MASK, val,
+		     B_AX_TXAGC_BT_EN, arg.ctrl_gnt_bt != 0xffff);
+
+#undef __write_ctrl
+}
+
+static
+s8 rtw8852c_btc_get_bt_rssi(struct rtw89_dev *rtwdev, s8 val)
+{
+	return clamp_t(s8, val, -100, 0) + 100;
+}
+
+static
+void rtw8852c_btc_bt_aci_imp(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_link_info *b = &bt->link_info;
+
+	/* fix LNA2 = level-5 for BT ACI issue at BTG */
+	if (btc->dm.wl_btg_rx && b->profile_cnt.now != 0)
+		dm->trx_para_level = 1;
+}
+
+static
+void rtw8852c_btc_update_bt_cnt(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_cx *cx = &btc->cx;
+	u32 val;
+
+	val = rtw89_read32(rtwdev, R_BTC_BT_CNT_HIGH);
+	cx->cnt_bt[BTC_BCNT_HIPRI_TX] = FIELD_GET(B_AX_STATIS_BT_HI_TX_MASK, val);
+	cx->cnt_bt[BTC_BCNT_HIPRI_RX] = FIELD_GET(B_AX_STATIS_BT_HI_RX_MASK, val);
+
+	val = rtw89_read32(rtwdev, R_BTC_BT_CNT_LOW);
+	cx->cnt_bt[BTC_BCNT_LOPRI_TX] = FIELD_GET(B_AX_STATIS_BT_LO_TX_1_MASK, val);
+	cx->cnt_bt[BTC_BCNT_LOPRI_RX] = FIELD_GET(B_AX_STATIS_BT_LO_RX_1_MASK, val);
+
+	/* clock-gate off before reset counter*/
+	rtw89_write32_set(rtwdev, R_AX_BTC_CFG, B_AX_DIS_BTC_CLK_G);
+	rtw89_write32_clr(rtwdev, R_AX_BT_CNT_CFG, B_AX_BT_CNT_RST);
+	rtw89_write32_set(rtwdev, R_AX_BT_CNT_CFG, B_AX_BT_CNT_RST);
+	rtw89_write32_clr(rtwdev, R_AX_BTC_CFG, B_AX_DIS_BTC_CLK_G);
+}
+
+static
+void rtw8852c_btc_wl_s1_standby(struct rtw89_dev *rtwdev, bool state)
+{
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x80000);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x1);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD1, RFREG_MASK, 0x620);
+
+	/* set WL standby = Rx for GNT_BT_Tx = 1->0 settle issue */
+	if (state)
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0,
+			       RFREG_MASK, 0x179c);
+	else
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0,
+			       RFREG_MASK, 0x208);
+
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x0);
+}
+
 static void rtw8852c_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
 					 struct rtw89_rx_phy_ppdu *phy_ppdu,
 					 struct ieee80211_rx_status *status)
@@ -2546,7 +2726,14 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx_v1,
 	.h2c_dctl_sec_cam	= rtw89_fw_h2c_dctl_sec_cam_v1,
 
+	.btc_set_rfe		= rtw8852c_btc_set_rfe,
 	.btc_init_cfg		= rtw8852c_btc_init_cfg,
+	.btc_set_wl_pri		= rtw8852c_btc_set_wl_pri,
+	.btc_set_wl_txpwr_ctrl	= rtw8852c_btc_set_wl_txpwr_ctrl,
+	.btc_get_bt_rssi	= rtw8852c_btc_get_bt_rssi,
+	.btc_bt_aci_imp		= rtw8852c_btc_bt_aci_imp,
+	.btc_update_bt_cnt	= rtw8852c_btc_update_bt_cnt,
+	.btc_wl_s1_standby	= rtw8852c_btc_wl_s1_standby,
 };
 
 const struct rtw89_chip_info rtw8852c_chip_info = {
-- 
2.25.1

