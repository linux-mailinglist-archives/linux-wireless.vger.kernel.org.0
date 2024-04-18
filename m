Return-Path: <linux-wireless+bounces-6485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF848A9112
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 04:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D2E281A43
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 02:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DCC29A9;
	Thu, 18 Apr 2024 02:13:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96F481A7
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 02:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406382; cv=none; b=YPl2m2lmDJyGGB71kXCbZkASSkBJpCWfBMUiuKZjHb3NHGGbXZexwRQuYU0iGOYl/dJ95TwIqIUIVsA608+pmIs9ZW8ZCBN+nW61f7UZfeOuPCxYzvHEhm9T/F3q9P6SV5i/aTEoWv6zOsN6DX9nPUpA9kH9bb0kRthBatQ2cZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406382; c=relaxed/simple;
	bh=ZkqGp5HCjddUliYjnQPQ1/Ukwgta1ITRPA6y3Y8XapQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKycoCmLNN5hL9G13T21Wh8XFoIZdKV0hUFJFJs57z/dwlAdxyZRLZufTWoqCkwXrVnf+sYYb+czWg4qZX3lAHJvLDqQa9pH7s1vrgNGhSPi09qxFNj/C9CiN62wje2oB+ZP5oFhoweb0tnnPYdqLhb+zOEXOE9zrn6ZAYmWS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43I2Cw8Q23994748, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43I2Cw8Q23994748
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 10:12:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 10:12:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 10:12:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 7/9] wifi: rtw89: coex: Add GPIO signal control version 7
Date: Thu, 18 Apr 2024 10:12:05 +0800
Message-ID: <20240418021207.32173-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418021207.32173-1-pkshih@realtek.com>
References: <20240418021207.32173-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Ching-Te Ku <ku920601@realtek.com>

The feature can help to know how the firmware mechanism working.
There are several trigger point set in firmware. If driver send
the H2C command to firmware to enable the trigger, firmware will
toggle GPIO to perform the firmware mechanism.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 160 +++++++++++++---------
 drivers/net/wireless/realtek/rtw89/coex.h |  35 +++++
 drivers/net/wireless/realtek/rtw89/core.h |  27 +++-
 3 files changed, 149 insertions(+), 73 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 95b163d60779..11ad1f692f9b 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1356,8 +1356,13 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_GPIO_DBG:
 		pcinfo = &pfwinfo->rpt_fbtc_gpio_dbg.cinfo;
-		pfinfo = &pfwinfo->rpt_fbtc_gpio_dbg.finfo;
-		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_gpio_dbg.finfo);
+		if (ver->fcxgpiodbg == 7) {
+			pfinfo = &pfwinfo->rpt_fbtc_gpio_dbg.finfo.v7;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_gpio_dbg.finfo.v7);
+		} else {
+			pfinfo = &pfwinfo->rpt_fbtc_gpio_dbg.finfo.v1;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_gpio_dbg.finfo.v1);
+		}
 		pcinfo->req_fver = ver->fcxgpiodbg;
 		break;
 	case BTC_RPT_TYPE_BT_VER:
@@ -7887,6 +7892,7 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 #define CASE_BTC_ANTPATH_STR(e) case BTC_ANT_##e: return #e
 #define CASE_BTC_POLUT_STR(e) case BTC_PLT_## e: return #e
 #define CASE_BTC_REGTYPE_STR(e) case REG_## e: return #e
+#define CASE_BTC_GDBG_STR(e) case BTC_DBG_## e: return #e
 
 static const char *id_to_polut(u32 id)
 {
@@ -7918,6 +7924,46 @@ static const char *id_to_regtype(u32 id)
 	}
 }
 
+static const char *id_to_gdbg(u32 id)
+{
+	switch (id) {
+	CASE_BTC_GDBG_STR(GNT_BT);
+	CASE_BTC_GDBG_STR(GNT_WL);
+	CASE_BTC_GDBG_STR(BCN_EARLY);
+	CASE_BTC_GDBG_STR(WL_NULL0);
+	CASE_BTC_GDBG_STR(WL_NULL1);
+	CASE_BTC_GDBG_STR(WL_RXISR);
+	CASE_BTC_GDBG_STR(TDMA_ENTRY);
+	CASE_BTC_GDBG_STR(A2DP_EMPTY);
+	CASE_BTC_GDBG_STR(BT_RETRY);
+	CASE_BTC_GDBG_STR(BT_RELINK);
+	CASE_BTC_GDBG_STR(SLOT_WL);
+	CASE_BTC_GDBG_STR(SLOT_BT);
+	CASE_BTC_GDBG_STR(WL_ERR);
+	CASE_BTC_GDBG_STR(WL_OK);
+	CASE_BTC_GDBG_STR(SLOT_B2W);
+	CASE_BTC_GDBG_STR(SLOT_W1);
+	CASE_BTC_GDBG_STR(SLOT_W2);
+	CASE_BTC_GDBG_STR(SLOT_W2B);
+	CASE_BTC_GDBG_STR(SLOT_B1);
+	CASE_BTC_GDBG_STR(SLOT_B2);
+	CASE_BTC_GDBG_STR(SLOT_B3);
+	CASE_BTC_GDBG_STR(SLOT_B4);
+	CASE_BTC_GDBG_STR(SLOT_LK);
+	CASE_BTC_GDBG_STR(SLOT_E2G);
+	CASE_BTC_GDBG_STR(SLOT_E5G);
+	CASE_BTC_GDBG_STR(SLOT_EBT);
+	CASE_BTC_GDBG_STR(SLOT_WLK);
+	CASE_BTC_GDBG_STR(SLOT_B1FDD);
+	CASE_BTC_GDBG_STR(BT_CHANGE);
+	CASE_BTC_GDBG_STR(WL_CCA);
+	CASE_BTC_GDBG_STR(BT_LEAUDIO);
+	CASE_BTC_GDBG_STR(USER_DEF);
+	default:
+		return "unknown";
+	}
+}
+
 static const char *steps_to_str(u16 step)
 {
 	switch (step) {
@@ -9286,6 +9332,47 @@ static void _get_gnt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_coex_gnt *gnt
 	}
 }
 
+static void _show_gpio_dbg(struct rtw89_dev *rtwdev, struct seq_file *m)
+{
+	struct rtw89_btc_btf_fwinfo *pfwinfo = &rtwdev->btc.fwinfo;
+	const struct rtw89_btc_ver *ver = rtwdev->btc.ver;
+	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
+	union rtw89_btc_fbtc_gpio_dbg *gdbg = NULL;
+	u8 *gpio_map, i;
+	u32 en_map;
+
+	pcinfo = &pfwinfo->rpt_fbtc_gpio_dbg.cinfo;
+	gdbg = &rtwdev->btc.fwinfo.rpt_fbtc_gpio_dbg.finfo;
+	if (!pcinfo->valid) {
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], %s(): stop due rpt_fbtc_gpio_dbg.cinfo\n",
+			    __func__);
+		seq_puts(m, "\n");
+		return;
+	}
+
+	if (ver->fcxgpiodbg == 7) {
+		en_map = le32_to_cpu(gdbg->v7.en_map);
+		gpio_map = gdbg->v7.gpio_map;
+	} else {
+		en_map = le32_to_cpu(gdbg->v1.en_map);
+		gpio_map = gdbg->v1.gpio_map;
+	}
+
+	if (!en_map)
+		return;
+
+	seq_printf(m, " %-15s : enable_map:0x%08x",
+		   "[gpio_dbg]", en_map);
+
+	for (i = 0; i < BTC_DBG_MAX1; i++) {
+		if (!(en_map & BIT(i)))
+			continue;
+		seq_printf(m, ", %s->GPIO%d", id_to_gdbg(i), gpio_map[i]);
+	}
+	seq_puts(m, "\n");
+}
+
 static void _show_mreg_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
@@ -9293,7 +9380,6 @@ static void _show_mreg_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_fbtc_mreg_val_v1 *pmreg = NULL;
-	struct rtw89_btc_fbtc_gpio_dbg *gdbg = NULL;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
@@ -9363,29 +9449,6 @@ static void _show_mreg_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
 		if (i >= pmreg->reg_num)
 			seq_puts(m, "\n");
 	}
-
-	pcinfo = &pfwinfo->rpt_fbtc_gpio_dbg.cinfo;
-	if (!pcinfo->valid) {
-		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC], %s(): stop due rpt_fbtc_gpio_dbg.cinfo\n",
-			    __func__);
-		seq_puts(m, "\n");
-		return;
-	}
-
-	gdbg = &pfwinfo->rpt_fbtc_gpio_dbg.finfo;
-	if (!gdbg->en_map)
-		return;
-
-	seq_printf(m, " %-15s : enable_map:0x%08x",
-		   "[gpio_dbg]", gdbg->en_map);
-
-	for (i = 0; i < BTC_DBG_MAX1; i++) {
-		if (!(gdbg->en_map & BIT(i)))
-			continue;
-		seq_printf(m, ", %d->GPIO%d", (u32)i, gdbg->gpio_map[i]);
-	}
-	seq_puts(m, "\n");
 }
 
 static void _show_mreg_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
@@ -9395,7 +9458,6 @@ static void _show_mreg_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_fbtc_mreg_val_v2 *pmreg = NULL;
-	struct rtw89_btc_fbtc_gpio_dbg *gdbg = NULL;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
@@ -9466,29 +9528,6 @@ static void _show_mreg_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 		if (i >= pmreg->reg_num)
 			seq_puts(m, "\n");
 	}
-
-	pcinfo = &pfwinfo->rpt_fbtc_gpio_dbg.cinfo;
-	if (!pcinfo->valid) {
-		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC], %s(): stop due rpt_fbtc_gpio_dbg.cinfo\n",
-			    __func__);
-		seq_puts(m, "\n");
-		return;
-	}
-
-	gdbg = &pfwinfo->rpt_fbtc_gpio_dbg.finfo;
-	if (!gdbg->en_map)
-		return;
-
-	seq_printf(m, " %-15s : enable_map:0x%08x",
-		   "[gpio_dbg]", gdbg->en_map);
-
-	for (i = 0; i < BTC_DBG_MAX1; i++) {
-		if (!(gdbg->en_map & BIT(i)))
-			continue;
-		seq_printf(m, ", %d->GPIO%d", (u32)i, gdbg->gpio_map[i]);
-	}
-	seq_puts(m, "\n");
 }
 
 static void _show_mreg_v7(struct rtw89_dev *rtwdev, struct seq_file *m)
@@ -9497,7 +9536,6 @@ static void _show_mreg_v7(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_fbtc_mreg_val_v7 *pmreg = NULL;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
-	struct rtw89_btc_fbtc_gpio_dbg *gdbg = NULL;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 	struct rtw89_btc_bt_info *bt = &cx->bt;
@@ -9559,23 +9597,7 @@ static void _show_mreg_v7(struct rtw89_dev *rtwdev, struct seq_file *m)
 				   id_to_regtype(type), offset, val);
 		cnt++;
 	}
-
-	pcinfo = &pfwinfo->rpt_fbtc_gpio_dbg.cinfo;
-	if (!pcinfo->valid)
-		return;
-
-	gdbg = &pfwinfo->rpt_fbtc_gpio_dbg.finfo;
-	if (!gdbg->en_map)
-		return;
-
-	seq_printf(m, "\n\r %-15s : enable_map:0x%08x", "[gpio_dbg]", gdbg->en_map);
-
-	for (i = 0; i < BTC_DBG_MAX1; i++) {
-		if (!(gdbg->en_map & BIT(i)))
-			continue;
-		seq_printf(m, ", %d->GPIO%d",
-			   i, gdbg->gpio_map[i]);
-	}
+	seq_puts(m, "\n");
 }
 
 static void _show_summary_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
@@ -10064,6 +10086,8 @@ void rtw89_btc_dump_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	else if (ver->fcxmreg == 7)
 		_show_mreg_v7(rtwdev, m);
 
+	_show_gpio_dbg(rtwdev, m);
+
 	if (ver->fcxbtcrpt == 1)
 		_show_summary_v1(rtwdev, m);
 	else if (ver->fcxbtcrpt == 4)
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 34771181f496..0e5f268616f7 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -222,6 +222,41 @@ enum btc_wl_mode {
 	BTC_WL_MODE_NUM,
 };
 
+enum btc_wl_gpio_debug {
+	BTC_DBG_GNT_BT = 0,
+	BTC_DBG_GNT_WL = 1,
+	BTC_DBG_BCN_EARLY = 2,
+	BTC_DBG_WL_NULL0 = 3,
+	BTC_DBG_WL_NULL1 = 4,
+	BTC_DBG_WL_RXISR = 5,
+	BTC_DBG_TDMA_ENTRY = 6,
+	BTC_DBG_A2DP_EMPTY = 7,
+	BTC_DBG_BT_RETRY = 8,
+	BTC_DBG_BT_RELINK = 9,
+	BTC_DBG_SLOT_WL = 10,
+	BTC_DBG_SLOT_BT = 11,
+	BTC_DBG_WL_ERR = 12,
+	BTC_DBG_WL_OK = 13,
+	BTC_DBG_SLOT_B2W = 14,
+	BTC_DBG_SLOT_W1 = 15,
+	BTC_DBG_SLOT_W2 = 16,
+	BTC_DBG_SLOT_W2B = 17,
+	BTC_DBG_SLOT_B1 = 18,
+	BTC_DBG_SLOT_B2 = 19,
+	BTC_DBG_SLOT_B3 = 20,
+	BTC_DBG_SLOT_B4 = 21,
+	BTC_DBG_SLOT_LK = 22,
+	BTC_DBG_SLOT_E2G = 23,
+	BTC_DBG_SLOT_E5G = 24,
+	BTC_DBG_SLOT_EBT = 25,
+	BTC_DBG_SLOT_WLK = 26,
+	BTC_DBG_SLOT_B1FDD = 27,
+	BTC_DBG_BT_CHANGE = 28,
+	BTC_DBG_WL_CCA = 29,
+	BTC_DBG_BT_LEAUDIO = 30,
+	BTC_DBG_USER_DEF = 31,
+};
+
 void rtw89_btc_ntfy_poweron(struct rtw89_dev *rtwdev);
 void rtw89_btc_ntfy_poweroff(struct rtw89_dev *rtwdev);
 void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ca5d4e078f8b..c66d52ee4700 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2251,15 +2251,32 @@ enum rtw89_btc_afh_map_type { /*AFH MAP TYPE */
 };
 
 #define BTC_DBG_MAX1  32
-struct rtw89_btc_fbtc_gpio_dbg {
+struct rtw89_btc_fbtc_gpio_dbg_v1 {
 	u8 fver; /* btc_ver::fcxgpiodbg */
 	u8 rsvd;
-	u16 rsvd2;
-	u32 en_map; /* which debug signal (see btc_wl_gpio_debug) is enable */
-	u32 pre_state; /* the debug signal is 1 or 0  */
+	__le16 rsvd2;
+	__le32 en_map; /* which debug signal (see btc_wl_gpio_debug) is enable */
+	__le32 pre_state; /* the debug signal is 1 or 0  */
 	u8 gpio_map[BTC_DBG_MAX1]; /*the debug signals to GPIO-Position */
 } __packed;
 
+struct rtw89_btc_fbtc_gpio_dbg_v7 {
+	u8 fver;
+	u8 rsvd0;
+	u8 rsvd1;
+	u8 rsvd2;
+
+	u8 gpio_map[BTC_DBG_MAX1];
+
+	__le32 en_map;
+	__le32 pre_state;
+} __packed;
+
+union rtw89_btc_fbtc_gpio_dbg {
+	struct rtw89_btc_fbtc_gpio_dbg_v1 v1;
+	struct rtw89_btc_fbtc_gpio_dbg_v7 v7;
+};
+
 struct rtw89_btc_fbtc_mreg_val_v1 {
 	u8 fver; /* btc_ver::fcxmreg */
 	u8 reg_num;
@@ -2870,7 +2887,7 @@ struct rtw89_btc_rpt_fbtc_mreg {
 
 struct rtw89_btc_rpt_fbtc_gpio_dbg {
 	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
-	struct rtw89_btc_fbtc_gpio_dbg finfo; /* info from fw */
+	union rtw89_btc_fbtc_gpio_dbg finfo; /* info from fw */
 };
 
 struct rtw89_btc_rpt_fbtc_btver {
-- 
2.25.1


