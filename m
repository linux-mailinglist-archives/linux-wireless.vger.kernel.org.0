Return-Path: <linux-wireless+bounces-24135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 412F2ADAB77
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 11:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A11718890DE
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88403270EAB;
	Mon, 16 Jun 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KD2pWnSa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D71F1A7253
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064815; cv=none; b=HdImqNUFIWub3xJt92oDSHWFrCp962a6MxnGn4feIMBe+iy/T79tW4s+4ZxQc1D3joPiYBol+wam29NMRbusFLinSsRuMalR7WL9PE7RgQ7qDnHBf985JaUfw0KYzjqs5S/t2kPPdPDawXSatBDlN5sRh/7Bjgs8yE/8iJhzQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064815; c=relaxed/simple;
	bh=ZghER03/JtgHdTn+Vv7DeGeydt79EBLcKF0Tb0H/0sM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snqr2sYohrLT4vtKc248ttDCYBLZ/t/TV8jgwj2Up1dObk8ZwWdF5Ubp246WG6cjzMqoohx69AkilTQEXVb8oaK9PP04sTF07iID/OI+EU+C7mkhfe3B+RvmDCs1VlAj8HnTkQoocogdcNG2Y7r/Ugs0IdSY31SDEgetz1ythmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KD2pWnSa; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G96omkE178550, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750064810; bh=7oOo4wb8wGFdym++vizlfZnj4lgqk6kjJ3ra01MxxCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=KD2pWnSa/SnjVxiLQ6CLG/J4uGcGIPHwafD1D0E33yTk42oTowVj19DUiDbbR2/xp
	 MUvb67pBXHa2SaZ40VhSClmphmEVZ9pP6oPN53dVIevVOhdBIKs1K0/1VhsF5lq+bY
	 zyuSNpCwnCwY0cbKBYvmNAar+G1ogJlGxqfsKhVL6vR/bKGMjXDSjA2xJR/xTVbyoX
	 9R6jsbGr9zWMQX/ocHW/v/8i6PzC4aCKpm3ejaUuOW/yoStIJqAE4M2YJhqML5c5sC
	 miOxODM2HXiFLrMLRiHnfmZ7OhEXcDVEMtPg1ImEoekgBZr9aeFgVnG7DFfQ7aI7HY
	 lx2OB1wqvBlHQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G96omkE178550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 17:06:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 17:03:27 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 17:03:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 03/11] wifi: rtw89: coex: Query Bluetooth TX power when firmware support
Date: Mon, 16 Jun 2025 17:02:44 +0800
Message-ID: <20250616090252.51098-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616090252.51098-1-pkshih@realtek.com>
References: <20250616090252.51098-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Ching-Te Ku <ku920601@realtek.com>

Add firmware report to monitor Bluetooth TX power/gain settings, so that
we can check it works as expected or not.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 101 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h |  11 +++
 2 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 3c607f5548b8..d02725aad6c7 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -153,8 +153,8 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
-	 .fwlrole = 8,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
-	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 2, .info_buf = 1800,
+	 .fwlrole = 8,   .frptmap = 4,    .fcxctrl = 7,  .fcxinit = 7,
+	 .fwevntrptl = 1, .fwc2hfunc = 3, .drvinfo_type = 2, .info_buf = 1800,
 	 .max_role_num = 6, .fcxosi = 1,  .fcxmlo = 1,
 	},
 	{RTL8922A, RTW89_FW_VER_CODE(0, 35, 8, 0),
@@ -333,6 +333,7 @@ enum btc_btf_set_report_en {
 	RPT_EN_BT_DEVICE_INFO,
 	RPT_EN_BT_AFH_MAP,
 	RPT_EN_BT_AFH_MAP_LE,
+	RPT_EN_BT_TX_PWR_LVL,
 	RPT_EN_FW_STEP_INFO,
 	RPT_EN_TEST,
 	RPT_EN_WL_ALL,
@@ -896,6 +897,9 @@ static int _send_fw_cmd(struct rtw89_dev *rtwdev, u8 h2c_class, u8 h2c_func,
 	return ret;
 }
 
+#define BTC_BT_DEF_BR_TX_PWR 4
+#define BTC_BT_DEF_LE_TX_PWR 4
+
 static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -964,6 +968,9 @@ static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 
 	if (type & BTC_RESET_MDINFO)
 		memset(&btc->mdinfo, 0, sizeof(btc->mdinfo));
+
+	bt->link_info.bt_txpwr_desc.br_dbm = BTC_BT_DEF_BR_TX_PWR;
+	bt->link_info.bt_txpwr_desc.le_dbm = BTC_BT_DEF_LE_TX_PWR;
 }
 
 static u8 _search_reg_index(struct rtw89_dev *rtwdev, u8 mreg_num, u16 reg_type, u32 target)
@@ -2381,6 +2388,7 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 			bit_map = BIT(6);
 			break;
 		case 3:
+		case 4:
 			bit_map = BIT(5);
 			break;
 		default:
@@ -2395,6 +2403,7 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 			bit_map = BIT(5);
 			break;
 		case 3:
+		case 4:
 			bit_map = BIT(6);
 			break;
 		default:
@@ -2407,12 +2416,27 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 			bit_map = BIT(8);
 			break;
 		case 3:
+		case 4:
 			bit_map = BIT(7);
 			break;
 		default:
 			break;
 		}
 		break;
+	case RPT_EN_BT_TX_PWR_LVL:
+		switch (ver->frptmap) {
+		case 0:
+		case 1:
+		case 2:
+		case 3:
+			break;
+		case 4:
+			bit_map = BIT(8);
+			break;
+		default:
+			break;
+		}
+		break;
 	case RPT_EN_FW_STEP_INFO:
 		switch (ver->frptmap) {
 		case 1:
@@ -2422,6 +2446,9 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 		case 3:
 			bit_map = BIT(8);
 			break;
+		case 4:
+			bit_map = BIT(9);
+			break;
 		default:
 			break;
 		}
@@ -2439,6 +2466,9 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 		case 3:
 			bit_map = GENMASK(2, 0) | BIT(8);
 			break;
+		case 4:
+			bit_map = GENMASK(2, 0) | BIT(9);
+			break;
 		default:
 			break;
 		}
@@ -2455,6 +2485,9 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 		case 3:
 			bit_map = GENMASK(7, 3);
 			break;
+		case 4:
+			bit_map = GENMASK(8, 3);
+			break;
 		default:
 			break;
 		}
@@ -2471,6 +2504,9 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 		case 3:
 			bit_map = GENMASK(8, 0);
 			break;
+		case 4:
+			bit_map = GENMASK(9, 0);
+			break;
 		default:
 			break;
 		}
@@ -2487,6 +2523,9 @@ static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
 		case 3:
 			bit_map = GENMASK(8, 2);
 			break;
+		case 4:
+			bit_map = GENMASK(9, 2);
+			break;
 		default:
 			break;
 		}
@@ -7379,6 +7418,25 @@ static void _update_bt_scbd(struct rtw89_dev *rtwdev, bool only_update)
 		_run_coex(rtwdev, BTC_RSN_UPDATE_BT_SCBD);
 }
 
+#define BTC_BTINFO_PWR_LEN 5
+static void _update_bt_txpwr_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
+{
+	struct rtw89_btc_bt_info *bt = &rtwdev->btc.cx.bt;
+	struct rtw89_btc_bt_link_info *b = &bt->link_info;
+
+	if (len != BTC_BTINFO_PWR_LEN)
+		return;
+
+	if (!memcmp(bt->txpwr_info, buf, sizeof(bt->txpwr_info))) {
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], %s return by info duplicate!\n", __func__);
+		return;
+	}
+
+	memcpy(bt->txpwr_info, buf, BTC_BTINFO_MAX);
+	memcpy(&b->bt_txpwr_desc, &buf[2], sizeof(b->bt_txpwr_desc));
+}
+
 static bool _chk_wl_rfk_request(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -8617,6 +8675,8 @@ static u8 rtw89_btc_c2h_get_index_by_ver(struct rtw89_dev *rtwdev, u8 func)
 			return BTF_EVNT_BUF_OVERFLOW;
 		else if (ver->fwc2hfunc == 2)
 			return func;
+		else if (ver->fwc2hfunc == 3)
+			return BTF_EVNT_BUF_OVERFLOW;
 		else
 			return BTF_EVNT_MAX;
 	case BTF_EVNT_BUF_OVERFLOW:
@@ -8626,11 +8686,20 @@ static u8 rtw89_btc_c2h_get_index_by_ver(struct rtw89_dev *rtwdev, u8 func)
 			return BTF_EVNT_C2H_LOOPBACK;
 		else if (ver->fwc2hfunc == 2)
 			return func;
+		else if (ver->fwc2hfunc == 3)
+			return BTF_EVNT_C2H_LOOPBACK;
 		else
 			return BTF_EVNT_MAX;
 	case BTF_EVNT_C2H_LOOPBACK:
 		if (ver->fwc2hfunc == 2)
 			return func;
+		else if (ver->fwc2hfunc == 3)
+			return BTF_EVNT_BT_LEAUDIO_INFO;
+		else
+			return BTF_EVNT_MAX;
+	case BTF_EVNT_BT_QUERY_TXPWR:
+		if (ver->fwc2hfunc == 3)
+			return func;
 		else
 			return BTF_EVNT_MAX;
 	case BTF_EVNT_MAX:
@@ -8693,6 +8762,9 @@ void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	case BTF_EVNT_CX_RUNINFO:
 		btc->dm.cnt_dm[BTC_DCNT_CX_RUNINFO]++;
 		break;
+	case BTF_EVNT_BT_QUERY_TXPWR:
+		btc->cx.cnt_bt[BTC_BCNT_BTTXPWR_UPDATE]++;
+		_update_bt_txpwr_info(rtwdev, buf, len);
 	}
 }
 
@@ -8965,8 +9037,11 @@ static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_bt_info *bt = &cx->bt;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
+	u32 ver_main = FIELD_GET(GENMASK(31, 24), wl->ver_info.fw_coex);
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 	union rtw89_btc_module_info *md = &btc->mdinfo;
+	s8 br_dbm = bt->link_info.bt_txpwr_desc.br_dbm;
+	s8 le_dbm = bt->link_info.bt_txpwr_desc.le_dbm;
 	char *p = buf, *end = buf + bufsz;
 	u8 *afh = bt_linfo->afh_map;
 	u8 *afh_le = bt_linfo->afh_map_le;
@@ -9099,6 +9174,28 @@ static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 		p += scnprintf(p, end - p, "\n");
 	}
 
+	if (ver_main >= 9 && bt_linfo->profile_cnt.now)
+		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_TX_PWR_LVL, true);
+	else
+		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_TX_PWR_LVL, false);
+
+	if (cx->cnt_bt[BTC_BCNT_BTTXPWR_UPDATE]) {
+		p += scnprintf(p, end - p,
+			       " %-15s : br_index:0x%x, le_index:0x%x",
+			       "[bt_txpwr_lvl]",
+			       bt->link_info.bt_txpwr_desc.br_gain_index,
+			       bt->link_info.bt_txpwr_desc.le_gain_index);
+		p += scnprintf(p, end - p, ", br_dbm:%d dBm", br_dbm);
+		p += scnprintf(p, end - p, ", le_dbm:%d dBm", le_dbm);
+	} else {
+		p += scnprintf(p, end - p,
+			       " %-15s : br_index:NA, le_index:NA, br_dbm:%d dBm[def], le_dbm:%d dBm[def]",
+			       "[bt_txpwr_lvl]",
+			       bt->link_info.bt_txpwr_desc.br_dbm,
+			       bt->link_info.bt_txpwr_desc.le_dbm);
+	}
+	p += scnprintf(p, end - p, "\n");
+
 	if (bt_linfo->profile_cnt.now || bt_linfo->status.map.ble_connect)
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_AFH_MAP, true);
 	else
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 328d4e9352fe..3b046727e04a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1322,6 +1322,7 @@ enum rtw89_btc_bt_state_cnt {
 	BTC_BCNT_POLUT_NOW,
 	BTC_BCNT_POLUT_DIFF,
 	BTC_BCNT_RATECHG,
+	BTC_BCNT_BTTXPWR_UPDATE,
 	BTC_BCNT_NUM,
 };
 
@@ -1810,6 +1811,13 @@ union rtw89_btc_bt_state_map {
 #define BTC_BT_AFH_GROUP 12
 #define BTC_BT_AFH_LE_GROUP 5
 
+struct rtw89_btc_bt_txpwr_desc {
+	s8 br_dbm;
+	s8 le_dbm;
+	u8 br_gain_index;
+	u8 le_gain_index;
+};
+
 struct rtw89_btc_bt_link_info {
 	struct rtw89_btc_u8_sta_chg profile_cnt;
 	struct rtw89_btc_bool_sta_chg multi_link;
@@ -1819,6 +1827,7 @@ struct rtw89_btc_bt_link_info {
 	struct rtw89_btc_bt_a2dp_desc a2dp_desc;
 	struct rtw89_btc_bt_pan_desc pan_desc;
 	union rtw89_btc_bt_state_map status;
+	struct rtw89_btc_bt_txpwr_desc bt_txpwr_desc;
 
 	u8 sut_pwr_level[BTC_PROFILE_MAX];
 	u8 golden_rx_shift[BTC_PROFILE_MAX];
@@ -2089,6 +2098,7 @@ struct rtw89_btc_bt_info {
 	union rtw89_btc_bt_rfk_info_map rfk_info;
 
 	u8 raw_info[BTC_BTINFO_MAX]; /* raw bt info from mailbox */
+	u8 txpwr_info[BTC_BTINFO_MAX];
 	u8 rssi_level;
 
 	u32 scbd;
@@ -3042,6 +3052,7 @@ enum rtw89_btc_btf_fw_event {
 	BTF_EVNT_BT_LEAUDIO_INFO = 7, /* fwc2hfunc > 1 */
 	BTF_EVNT_BUF_OVERFLOW,
 	BTF_EVNT_C2H_LOOPBACK,
+	BTF_EVNT_BT_QUERY_TXPWR, /* fwc2hfunc > 3 */
 	BTF_EVNT_MAX,
 };
 
-- 
2.25.1


