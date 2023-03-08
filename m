Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC986AFE6B
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 06:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCHFdu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 00:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCHFds (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 00:33:48 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8776695E01
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 21:33:46 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3285XU4U0016699, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3285XU4U0016699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 8 Mar 2023 13:33:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 8 Mar 2023 13:33:30 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 8 Mar 2023
 13:33:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/7] wifi: rtw89: coex: Add register monitor report v2 format
Date:   Wed, 8 Mar 2023 13:32:22 +0800
Message-ID: <20230308053225.24377-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308053225.24377-1-pkshih@realtek.com>
References: <20230308053225.24377-1-pkshih@realtek.com>
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

The v2 firmware report reduce its maximum register numbers from 30 to 20,
it can help to save firmware code size.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 148 ++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h |  17 ++-
 2 files changed, 151 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 908ef8bb149a0..436d5e35ae49b 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -226,7 +226,6 @@ struct rtw89_btc_btf_set_slot_table {
 	u8 buf[];
 } __packed;
 
-#define BTF_SET_MON_REG_VER 1
 struct rtw89_btc_btf_set_mon_reg {
 	u8 fver;
 	u8 reg_num;
@@ -1078,8 +1077,15 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_MREG:
 		pcinfo = &pfwinfo->rpt_fbtc_mregval.cinfo;
-		pfinfo = &pfwinfo->rpt_fbtc_mregval.finfo;
-		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_mregval.finfo);
+		if (ver->fcxmreg == 1) {
+			pfinfo = &pfwinfo->rpt_fbtc_mregval.finfo.v1;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_mregval.finfo.v1);
+		} else if (ver->fcxmreg == 2) {
+			pfinfo = &pfwinfo->rpt_fbtc_mregval.finfo.v2;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_mregval.finfo.v2);
+		} else {
+			goto err;
+		}
 		pcinfo->req_fver = ver->fcxmreg;
 		break;
 	case BTC_RPT_TYPE_GPIO_DBG:
@@ -1709,18 +1715,26 @@ static void rtw89_btc_fw_set_slots(struct rtw89_dev *rtwdev, u8 num,
 static void btc_fw_set_monreg(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_btc_ver *ver = rtwdev->btc.ver;
 	struct rtw89_btc_btf_set_mon_reg *monreg = NULL;
-	u8 n, *ptr = NULL, ulen;
+	u8 n, *ptr = NULL, ulen, cxmreg_max;
 	u16 sz = 0;
 
 	n = chip->mon_reg_num;
-
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): mon_reg_num=%d\n", __func__, n);
-	if (n > CXMREG_MAX) {
+
+	if (ver->fcxmreg == 1)
+		cxmreg_max = CXMREG_MAX;
+	else if (ver->fcxmreg == 2)
+		cxmreg_max = CXMREG_MAX_V2;
+	else
+		return;
+
+	if (n > cxmreg_max) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): mon reg count %d > %d\n",
-			    __func__, n, CXMREG_MAX);
+			    __func__, n, cxmreg_max);
 		return;
 	}
 
@@ -1730,7 +1744,7 @@ static void btc_fw_set_monreg(struct rtw89_dev *rtwdev)
 	if (!monreg)
 		return;
 
-	monreg->fver = BTF_SET_MON_REG_VER;
+	monreg->fver = ver->fcxmreg;
 	monreg->reg_num = n;
 	ptr = &monreg->buf[0];
 	memcpy(ptr, chip->mon_reg, n * ulen);
@@ -7401,13 +7415,13 @@ static void _get_gnt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_coex_gnt *gnt
 	}
 }
 
-static void _show_mreg(struct rtw89_dev *rtwdev, struct seq_file *m)
+static void _show_mreg_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
-	struct rtw89_btc_fbtc_mreg_val *pmreg = NULL;
+	struct rtw89_btc_fbtc_mreg_val_v1 *pmreg = NULL;
 	struct rtw89_btc_fbtc_gpio_dbg *gdbg = NULL;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
@@ -7457,7 +7471,7 @@ static void _show_mreg(struct rtw89_dev *rtwdev, struct seq_file *m)
 		return;
 	}
 
-	pmreg = &pfwinfo->rpt_fbtc_mregval.finfo;
+	pmreg = &pfwinfo->rpt_fbtc_mregval.finfo.v1;
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): rpt_fbtc_mregval reg_num = %d\n",
 		    __func__, pmreg->reg_num);
@@ -7486,6 +7500,111 @@ static void _show_mreg(struct rtw89_dev *rtwdev, struct seq_file *m)
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): stop due rpt_fbtc_gpio_dbg.cinfo\n",
 			    __func__);
+		seq_puts(m, "\n");
+		return;
+	}
+
+	gdbg = &pfwinfo->rpt_fbtc_gpio_dbg.finfo;
+	if (!gdbg->en_map)
+		return;
+
+	seq_printf(m, " %-15s : enable_map:0x%08x",
+		   "[gpio_dbg]", gdbg->en_map);
+
+	for (i = 0; i < BTC_DBG_MAX1; i++) {
+		if (!(gdbg->en_map & BIT(i)))
+			continue;
+		seq_printf(m, ", %d->GPIO%d", (u32)i, gdbg->gpio_map[i]);
+	}
+	seq_puts(m, "\n");
+}
+
+static void _show_mreg_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
+	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
+	struct rtw89_btc_fbtc_mreg_val_v2 *pmreg = NULL;
+	struct rtw89_btc_fbtc_gpio_dbg *gdbg = NULL;
+	struct rtw89_btc_cx *cx = &btc->cx;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_mac_ax_coex_gnt gnt_cfg = {};
+	struct rtw89_mac_ax_gnt gnt;
+	u8 i = 0, type = 0, cnt = 0;
+	u32 val, offset;
+
+	if (!(btc->dm.coex_info_map & BTC_COEX_INFO_MREG))
+		return;
+
+	seq_puts(m, "========== [HW Status] ==========\n");
+
+	seq_printf(m,
+		   " %-15s : WL->BT:0x%08x(cnt:%d), BT->WL:0x%08x(total:%d, bt_update:%d)\n",
+		   "[scoreboard]", wl->scbd, cx->cnt_wl[BTC_WCNT_SCBDUPDATE],
+		   bt->scbd, cx->cnt_bt[BTC_BCNT_SCBDREAD],
+		   cx->cnt_bt[BTC_BCNT_SCBDUPDATE]);
+
+	/* To avoid I/O if WL LPS or power-off  */
+	if (!wl->status.map.lps && !wl->status.map.rf_off) {
+		btc->dm.pta_owner = rtw89_mac_get_ctrl_path(rtwdev);
+
+		_get_gnt(rtwdev, &gnt_cfg);
+		gnt = gnt_cfg.band[0];
+		seq_printf(m,
+			   " %-15s : pta_owner:%s, phy-0[gnt_wl:%s-%d/gnt_bt:%s-%d], ",
+			   "[gnt_status]",
+			   chip->chip_id == RTL8852C ? "HW" :
+			   btc->dm.pta_owner == BTC_CTRL_BY_WL ? "WL" : "BT",
+			   gnt.gnt_wl_sw_en ? "SW" : "HW", gnt.gnt_wl,
+			   gnt.gnt_bt_sw_en ? "SW" : "HW", gnt.gnt_bt);
+
+		gnt = gnt_cfg.band[1];
+		seq_printf(m, "phy-1[gnt_wl:%s-%d/gnt_bt:%s-%d]\n",
+			   gnt.gnt_wl_sw_en ? "SW" : "HW",
+			   gnt.gnt_wl,
+			   gnt.gnt_bt_sw_en ? "SW" : "HW",
+			   gnt.gnt_bt);
+	}
+	pcinfo = &pfwinfo->rpt_fbtc_mregval.cinfo;
+	if (!pcinfo->valid) {
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], %s(): stop due rpt_fbtc_mregval.cinfo\n",
+			    __func__);
+		return;
+	}
+
+	pmreg = &pfwinfo->rpt_fbtc_mregval.finfo.v2;
+	rtw89_debug(rtwdev, RTW89_DBG_BTC,
+		    "[BTC], %s(): rpt_fbtc_mregval reg_num = %d\n",
+		    __func__, pmreg->reg_num);
+
+	for (i = 0; i < pmreg->reg_num; i++) {
+		type = (u8)le16_to_cpu(chip->mon_reg[i].type);
+		offset = le32_to_cpu(chip->mon_reg[i].offset);
+		val = le32_to_cpu(pmreg->mreg_val[i]);
+
+		if (cnt % 6 == 0)
+			seq_printf(m, " %-15s : %d_0x%04x=0x%08x",
+				   "[reg]", (u32)type, offset, val);
+		else
+			seq_printf(m, ", %d_0x%04x=0x%08x", (u32)type,
+				   offset, val);
+		if (cnt % 6 == 5)
+			seq_puts(m, "\n");
+		cnt++;
+
+		if (i >= pmreg->reg_num)
+			seq_puts(m, "\n");
+	}
+
+	pcinfo = &pfwinfo->rpt_fbtc_gpio_dbg.cinfo;
+	if (!pcinfo->valid) {
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], %s(): stop due rpt_fbtc_gpio_dbg.cinfo\n",
+			    __func__);
+		seq_puts(m, "\n");
 		return;
 	}
 
@@ -7868,7 +7987,12 @@ void rtw89_btc_dump_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	_show_bt_info(rtwdev, m);
 	_show_dm_info(rtwdev, m);
 	_show_fw_dm_msg(rtwdev, m);
-	_show_mreg(rtwdev, m);
+
+	if (ver->fcxmreg == 1)
+		_show_mreg_v1(rtwdev, m);
+	else if (ver->fcxmreg == 2)
+		_show_mreg_v2(rtwdev, m);
+
 	if (ver->fcxbtcrpt == 1)
 		_show_summary_v1(rtwdev, m);
 	else if (ver->fcxbtcrpt == 4)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1d3614f5b2a2b..b021366f960d4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1524,6 +1524,7 @@ union rtw89_btc_fbtc_tdma_le32 {
 };
 
 #define CXMREG_MAX 30
+#define CXMREG_MAX_V2 20
 #define FCXMAX_STEP 255 /*STEP trace record cnt, Max:65535, default:255*/
 #define BTC_CYCLE_SLOT_MAX 48 /* must be even number, non-zero */
 
@@ -1750,13 +1751,25 @@ struct rtw89_btc_fbtc_gpio_dbg {
 	u8 gpio_map[BTC_DBG_MAX1]; /*the debug signals to GPIO-Position */
 } __packed;
 
-struct rtw89_btc_fbtc_mreg_val {
+struct rtw89_btc_fbtc_mreg_val_v1 {
 	u8 fver; /* btc_ver::fcxmreg */
 	u8 reg_num;
 	__le16 rsvd;
 	__le32 mreg_val[CXMREG_MAX];
 } __packed;
 
+struct rtw89_btc_fbtc_mreg_val_v2 {
+	u8 fver; /* btc_ver::fcxmreg */
+	u8 reg_num;
+	__le16 rsvd;
+	__le32 mreg_val[CXMREG_MAX_V2];
+} __packed;
+
+union rtw89_btc_fbtc_mreg_val {
+	struct rtw89_btc_fbtc_mreg_val_v1 v1;
+	struct rtw89_btc_fbtc_mreg_val_v2 v2;
+};
+
 #define RTW89_DEF_FBTC_MREG(__type, __bytes, __offset) \
 	{ .type = cpu_to_le16(__type), .bytes = cpu_to_le16(__bytes), \
 	  .offset = cpu_to_le32(__offset), }
@@ -2203,7 +2216,7 @@ struct rtw89_btc_rpt_fbtc_nullsta {
 
 struct rtw89_btc_rpt_fbtc_mreg {
 	struct rtw89_btc_rpt_cmn_info cinfo; /* common info, by driver */
-	struct rtw89_btc_fbtc_mreg_val finfo; /* info from fw */
+	union rtw89_btc_fbtc_mreg_val finfo; /* info from fw */
 };
 
 struct rtw89_btc_rpt_fbtc_gpio_dbg {
-- 
2.25.1

