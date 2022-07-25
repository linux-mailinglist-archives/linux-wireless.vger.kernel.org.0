Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7440757F842
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 04:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiGYCgC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Jul 2022 22:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiGYCf7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Jul 2022 22:35:59 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32B2DE035
        for <linux-wireless@vger.kernel.org>; Sun, 24 Jul 2022 19:35:57 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 26P2ZeLW2014757, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 26P2ZeLW2014757
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 25 Jul 2022 10:35:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 10:35:46 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Mon, 25 Jul
 2022 10:35:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 7/9] rtw89: coex: Move _set_policy to chip_ops
Date:   Mon, 25 Jul 2022 10:35:07 +0800
Message-ID: <20220725023509.43114-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725023509.43114-1-pkshih@realtek.com>
References: <20220725023509.43114-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 07/25/2022 02:16:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzcvMjQgpFWkyCAxMToyOTowMA==?=
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

From: Ching-Te Ku <ku920601@realtek.com>

Due to the difference of Wi-Fi firmware supported feature, RTL8852C
need to defined more policy to enable the features.
(Ex: DBCC, Wi-Fi multi-role, TDMA instant and so on)

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     | 382 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/coex.h     |   2 +
 drivers/net/wireless/realtek/rtw89/core.h     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 5 files changed, 386 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index a7e7bbdbf9bc8..6c84d06bfbff3 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -261,6 +261,9 @@ enum btc_cx_poicy_type {
 	/* TDMA off + pri: WL_Hi-Tx > BT_Hi_Rx, BT_Hi > WL > BT_Lo */
 	BTC_CXP_OFF_BWB1 = (BTC_CXP_OFF << 8) | 7,
 
+	/* TDMA off + pri: WL_Hi-Tx > BT, BT_Hi > other-WL > BT_Lo */
+	BTC_CXP_OFF_BWB2 = (BTC_CXP_OFF << 8) | 8,
+
 	/* TDMA off+Bcn-Protect + pri: WL_Hi-Tx > BT_Hi_Rx, BT_Hi > WL > BT_Lo*/
 	BTC_CXP_OFFB_BWB0 = (BTC_CXP_OFFB << 8) | 0,
 
@@ -300,6 +303,9 @@ enum btc_cx_poicy_type {
 	/* TDMA Fix slot-9: W1:B1 = 40:20 */
 	BTC_CXP_FIX_TD4020 = (BTC_CXP_FIX << 8) | 9,
 
+	/* TDMA Fix slot-9: W1:B1 = 40:10 */
+	BTC_CXP_FIX_TD4010ISO = (BTC_CXP_FIX << 8) | 10,
+
 	/* PS-TDMA Fix slot-0: W1:B1 = 30:30 */
 	BTC_CXP_PFIX_TD3030 = (BTC_CXP_PFIX << 8) | 0,
 
@@ -2020,6 +2026,15 @@ union btc_btinfo {
 
 static void _set_policy(struct rtw89_dev *rtwdev, u16 policy_type,
 			enum btc_reason_and_action action)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	chip->ops->btc_set_policy(rtwdev, policy_type);
+	_fw_set_policy(rtwdev, policy_type, action);
+}
+
+#define BTC_B1_MAX 250 /* unit ms */
+void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
@@ -2316,9 +2331,372 @@ static void _set_policy(struct rtw89_dev *rtwdev, u16 policy_type,
 		}
 		break;
 	}
+}
+EXPORT_SYMBOL(rtw89_btc_set_policy);
 
-	_fw_set_policy(rtwdev, policy_type, action);
+void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_fbtc_tdma *t = &dm->tdma;
+	struct rtw89_btc_fbtc_slot *s = dm->slot;
+	struct rtw89_btc_bt_hid_desc *hid = &btc->cx.bt.link_info.hid_desc;
+	struct rtw89_btc_bt_hfp_desc *hfp = &btc->cx.bt.link_info.hfp_desc;
+	u8 type;
+	u32 tbl_w1, tbl_b1, tbl_b4;
+
+	type = FIELD_GET(BTC_CXP_MASK, policy_type);
+
+	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) {
+		if (btc->cx.wl.status.map._4way)
+			tbl_w1 = cxtbl[1];
+		else if (hid->exist && hid->type == BTC_HID_218)
+			tbl_w1 = cxtbl[7]; /* Ack/BA no break bt Hi-Pri-rx */
+		else
+			tbl_w1 = cxtbl[8];
+
+		if (dm->leak_ap &&
+		    (type == BTC_CXP_PFIX || type == BTC_CXP_PAUTO2)) {
+			tbl_b1 = cxtbl[3];
+			tbl_b4 = cxtbl[3];
+		} else if (hid->exist && hid->type == BTC_HID_218) {
+			tbl_b1 = cxtbl[4]; /* Ack/BA no break bt Hi-Pri-rx */
+			tbl_b4 = cxtbl[4];
+		} else {
+			tbl_b1 = cxtbl[2];
+			tbl_b4 = cxtbl[2];
+		}
+	} else {
+		tbl_w1 = cxtbl[16];
+		tbl_b1 = cxtbl[17];
+		tbl_b4 = cxtbl[17];
+	}
+
+	btc->bt_req_en = false;
+
+	switch (type) {
+	case BTC_CXP_USERDEF0:
+		btc->update_policy_force = true;
+		*t = t_def[CXTD_OFF];
+		s[CXST_OFF] = s_def[CXST_OFF];
+		_slot_set_tbl(btc, CXST_OFF, cxtbl[2]);
+		break;
+	case BTC_CXP_OFF: /* TDMA off */
+		_write_scbd(rtwdev, BTC_WSCB_TDMA, false);
+		*t = t_def[CXTD_OFF];
+		s[CXST_OFF] = s_def[CXST_OFF];
+
+		switch (policy_type) {
+		case BTC_CXP_OFF_BT:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[2]);
+			break;
+		case BTC_CXP_OFF_WL:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[1]);
+			break;
+		case BTC_CXP_OFF_EQ0:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[0]);
+			break;
+		case BTC_CXP_OFF_EQ1:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[16]);
+			break;
+		case BTC_CXP_OFF_EQ2:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[17]);
+			break;
+		case BTC_CXP_OFF_EQ3:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[18]);
+			break;
+		case BTC_CXP_OFF_BWB0:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[5]);
+			break;
+		case BTC_CXP_OFF_BWB1:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[8]);
+			break;
+		case BTC_CXP_OFF_BWB2:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[7]);
+			break;
+		default:
+			break;
+		}
+		break;
+	case BTC_CXP_OFFB: /* TDMA off + beacon protect */
+		_write_scbd(rtwdev, BTC_WSCB_TDMA, false);
+		*t = t_def[CXTD_OFF_B2];
+		s[CXST_OFF] = s_def[CXST_OFF];
+
+		switch (policy_type) {
+		case BTC_CXP_OFFB_BWB0:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[8]);
+			break;
+		default:
+			break;
+		}
+		break;
+	case BTC_CXP_OFFE: /* TDMA off + beacon protect + Ext_control */
+		btc->bt_req_en = true;
+		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		*t = t_def[CXTD_OFF_EXT];
+
+		/* To avoid wl-s0 tx break by hid/hfp tx */
+		if (hid->exist || hfp->exist)
+			tbl_w1 = cxtbl[16];
+
+		switch (policy_type) {
+		case BTC_CXP_OFFE_DEF:
+			s[CXST_E2G] = s_def[CXST_E2G];
+			s[CXST_E5G] = s_def[CXST_E5G];
+			s[CXST_EBT] = s_def[CXST_EBT];
+			s[CXST_ENULL] = s_def[CXST_ENULL];
+			break;
+		case BTC_CXP_OFFE_DEF2:
+			_slot_set(btc, CXST_E2G, 20, cxtbl[1], SLOT_ISO);
+			s[CXST_E5G] = s_def[CXST_E5G];
+			s[CXST_EBT] = s_def[CXST_EBT];
+			s[CXST_ENULL] = s_def[CXST_ENULL];
+			break;
+		default:
+			break;
+		}
+		break;
+	case BTC_CXP_FIX: /* TDMA Fix-Slot */
+		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		*t = t_def[CXTD_FIX];
+
+		switch (policy_type) {
+		case BTC_CXP_FIX_TD3030:
+			_slot_set(btc, CXST_W1, 30, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, 30, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_FIX_TD5050:
+			_slot_set(btc, CXST_W1, 50, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, 50, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_FIX_TD2030:
+			_slot_set(btc, CXST_W1, 20, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, 30, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_FIX_TD4010:
+			_slot_set(btc, CXST_W1, 40, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, 10, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_FIX_TD4010ISO:
+			_slot_set(btc, CXST_W1, 40, cxtbl[1], SLOT_ISO);
+			_slot_set(btc, CXST_B1, 10, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_FIX_TD7010:
+			_slot_set(btc, CXST_W1, 70, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, 10, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_FIX_TD2060:
+			_slot_set(btc, CXST_W1, 20, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, 60, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_FIX_TD3060:
+			_slot_set(btc, CXST_W1, 30, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, 60, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_FIX_TD2080:
+			_slot_set(btc, CXST_W1, 20, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, 80, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_FIX_TDW1B1: /* W1:B1 = user-define */
+			_slot_set(btc, CXST_W1, dm->slot_dur[CXST_W1],
+				  tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, dm->slot_dur[CXST_B1],
+				  tbl_b1, SLOT_MIX);
+			break;
+		default:
+			break;
+		}
+		break;
+	case BTC_CXP_PFIX: /* PS-TDMA Fix-Slot */
+		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		*t = t_def[CXTD_PFIX];
+
+		switch (policy_type) {
+		case BTC_CXP_PFIX_TD3030:
+			_slot_set(btc, CXST_W1, 30, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, 30, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_PFIX_TD5050:
+			_slot_set(btc, CXST_W1, 50, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, 50, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_PFIX_TD2030:
+			_slot_set(btc, CXST_W1, 20, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, 30, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_PFIX_TD2060:
+			_slot_set(btc, CXST_W1, 20, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, 60, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_PFIX_TD3070:
+			_slot_set(btc, CXST_W1, 30, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, 60, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_PFIX_TD2080:
+			_slot_set(btc, CXST_W1, 20, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, 80, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_PFIX_TDW1B1: /* W1:B1 = user-define */
+			_slot_set(btc, CXST_W1, dm->slot_dur[CXST_W1],
+				  tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, dm->slot_dur[CXST_B1],
+				  tbl_b1, SLOT_MIX);
+			break;
+		default:
+			break;
+		}
+		break;
+	case BTC_CXP_AUTO: /* TDMA Auto-Slot */
+		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		*t = t_def[CXTD_AUTO];
+
+		switch (policy_type) {
+		case BTC_CXP_AUTO_TD50B1:
+			_slot_set(btc, CXST_W1,  50, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_AUTO_TD60B1:
+			_slot_set(btc, CXST_W1,  60, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_AUTO_TD20B1:
+			_slot_set(btc, CXST_W1,  20, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_AUTO_TDW1B1: /* W1:B1 = user-define */
+			_slot_set(btc, CXST_W1, dm->slot_dur[CXST_W1],
+				  tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, dm->slot_dur[CXST_B1],
+				  tbl_b1, SLOT_MIX);
+			break;
+		default:
+			break;
+		}
+		break;
+	case BTC_CXP_PAUTO: /* PS-TDMA Auto-Slot */
+		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		*t = t_def[CXTD_PAUTO];
+
+		switch (policy_type) {
+		case BTC_CXP_PAUTO_TD50B1:
+			_slot_set(btc, CXST_W1,  50, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_PAUTO_TD60B1:
+			_slot_set(btc, CXST_W1,  60, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_PAUTO_TD20B1:
+			_slot_set(btc, CXST_W1,  20, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_PAUTO_TDW1B1:
+			_slot_set(btc, CXST_W1, dm->slot_dur[CXST_W1],
+				  tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, dm->slot_dur[CXST_B1],
+				  tbl_b1, SLOT_MIX);
+			break;
+		default:
+			break;
+		}
+		break;
+	case BTC_CXP_AUTO2: /* TDMA Auto-Slot2 */
+		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		*t = t_def[CXTD_AUTO2];
+
+		switch (policy_type) {
+		case BTC_CXP_AUTO2_TD3050:
+			_slot_set(btc, CXST_W1,  30, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
+			_slot_set(btc, CXST_B4,  50, tbl_b4, SLOT_MIX);
+			break;
+		case BTC_CXP_AUTO2_TD3070:
+			_slot_set(btc, CXST_W1,  30, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
+			_slot_set(btc, CXST_B4,  70, tbl_b4, SLOT_MIX);
+			break;
+		case BTC_CXP_AUTO2_TD5050:
+			_slot_set(btc, CXST_W1,  50, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
+			_slot_set(btc, CXST_B4,  50, tbl_b4, SLOT_MIX);
+			break;
+		case BTC_CXP_AUTO2_TD6060:
+			_slot_set(btc, CXST_W1,  60, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
+			_slot_set(btc, CXST_B4,  60, tbl_b4, SLOT_MIX);
+			break;
+		case BTC_CXP_AUTO2_TD2080:
+			_slot_set(btc, CXST_W1,  20, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
+			_slot_set(btc, CXST_B4,  80, tbl_b4, SLOT_MIX);
+			break;
+		case BTC_CXP_AUTO2_TDW1B4: /* W1:B1 = user-define */
+			_slot_set(btc, CXST_W1, dm->slot_dur[CXST_W1],
+				  tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, dm->slot_dur[CXST_B1],
+				  tbl_b1, SLOT_MIX);
+			_slot_set(btc, CXST_B4, dm->slot_dur[CXST_B4],
+				  tbl_b4, SLOT_MIX);
+			break;
+		default:
+			break;
+		}
+		break;
+	case BTC_CXP_PAUTO2: /* PS-TDMA Auto-Slot2 */
+		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
+		*t = t_def[CXTD_PAUTO2];
+
+		switch (policy_type) {
+		case BTC_CXP_PAUTO2_TD3050:
+			_slot_set(btc, CXST_W1,  30, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
+			_slot_set(btc, CXST_B4,  50, tbl_b4, SLOT_MIX);
+			break;
+		case BTC_CXP_PAUTO2_TD3070:
+			_slot_set(btc, CXST_W1,  30, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
+			_slot_set(btc, CXST_B4,  70, tbl_b4, SLOT_MIX);
+			break;
+		case BTC_CXP_PAUTO2_TD5050:
+			_slot_set(btc, CXST_W1,  50, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
+			_slot_set(btc, CXST_B4,  50, tbl_b4, SLOT_MIX);
+			break;
+		case BTC_CXP_PAUTO2_TD6060:
+			_slot_set(btc, CXST_W1,  60, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
+			_slot_set(btc, CXST_B4,  60, tbl_b4, SLOT_MIX);
+			break;
+		case BTC_CXP_PAUTO2_TD2080:
+			_slot_set(btc, CXST_W1,  20, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
+			_slot_set(btc, CXST_B4,  80, tbl_b4, SLOT_MIX);
+			break;
+		case BTC_CXP_PAUTO2_TDW1B4: /* W1:B1 = user-define */
+			_slot_set(btc, CXST_W1, dm->slot_dur[CXST_W1],
+				  tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, dm->slot_dur[CXST_B1],
+				  tbl_b1, SLOT_MIX);
+			_slot_set(btc, CXST_B4, dm->slot_dur[CXST_B4],
+				  tbl_b4, SLOT_MIX);
+			break;
+		default:
+			break;
+		}
+		break;
+	}
+
+	/* enter leak_slot after each null-1 */
+	if (dm->leak_ap && dm->tdma.leak_n > 1)
+		_tdma_set_lek(btc, 1);
+
+	if (dm->tdma_instant_excute) {
+		btc->dm.tdma.option_ctrl |= BIT(0);
+		btc->update_policy_force = true;
+	}
 }
+EXPORT_SYMBOL(rtw89_btc_set_policy_v1);
 
 static void _set_gnt_bt(struct rtw89_dev *rtwdev, u8 phy_map, u8 state)
 {
@@ -5285,6 +5663,7 @@ static const char *steps_to_str(u16 step)
 	CASE_BTC_POLICY_STR(OFF_EQ3);
 	CASE_BTC_POLICY_STR(OFF_BWB0);
 	CASE_BTC_POLICY_STR(OFF_BWB1);
+	CASE_BTC_POLICY_STR(OFF_BWB2);
 	CASE_BTC_POLICY_STR(OFFB_BWB0);
 	CASE_BTC_POLICY_STR(OFFE_DEF);
 	CASE_BTC_POLICY_STR(OFFE_DEF2);
@@ -5298,6 +5677,7 @@ static const char *steps_to_str(u16 step)
 	CASE_BTC_POLICY_STR(FIX_TD2080);
 	CASE_BTC_POLICY_STR(FIX_TDW1B1);
 	CASE_BTC_POLICY_STR(FIX_TD4020);
+	CASE_BTC_POLICY_STR(FIX_TD4010ISO);
 	CASE_BTC_POLICY_STR(PFIX_TD3030);
 	CASE_BTC_POLICY_STR(PFIX_TD5050);
 	CASE_BTC_POLICY_STR(PFIX_TD2030);
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index b48a441ae6e23..ca16afa97ec07 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -162,6 +162,8 @@ void rtw89_coex_act1_work(struct work_struct *work);
 void rtw89_coex_bt_devinfo_work(struct work_struct *work);
 void rtw89_coex_rfk_chk_work(struct work_struct *work);
 void rtw89_coex_power_on(struct rtw89_dev *rtwdev);
+void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type);
+void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type);
 
 static inline u8 rtw89_btc_phymap(struct rtw89_dev *rtwdev,
 				  enum rtw89_phy_idx phy_idx,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f4a3561ebcb85..99c9d162d9520 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2263,6 +2263,7 @@ struct rtw89_chip_ops {
 	void (*btc_bt_aci_imp)(struct rtw89_dev *rtwdev);
 	void (*btc_update_bt_cnt)(struct rtw89_dev *rtwdev);
 	void (*btc_wl_s1_standby)(struct rtw89_dev *rtwdev, bool state);
+	void (*btc_set_policy)(struct rtw89_dev *rtwdev, u16 policy_type);
 };
 
 enum rtw89_dma_ch {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 0dc92c16b4513..f09e997dbdbf3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2104,6 +2104,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.btc_bt_aci_imp		= rtw8852a_btc_bt_aci_imp,
 	.btc_update_bt_cnt	= rtw8852a_btc_update_bt_cnt,
 	.btc_wl_s1_standby	= rtw8852a_btc_wl_s1_standby,
+	.btc_set_policy		= rtw89_btc_set_policy,
 };
 
 const struct rtw89_chip_info rtw8852a_chip_info = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index f4012f1e04d91..7684723fb2730 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2934,6 +2934,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.btc_bt_aci_imp		= rtw8852c_btc_bt_aci_imp,
 	.btc_update_bt_cnt	= rtw8852c_btc_update_bt_cnt,
 	.btc_wl_s1_standby	= rtw8852c_btc_wl_s1_standby,
+	.btc_set_policy		= rtw89_btc_set_policy_v1,
 };
 
 const struct rtw89_chip_info rtw8852c_chip_info = {
-- 
2.25.1

