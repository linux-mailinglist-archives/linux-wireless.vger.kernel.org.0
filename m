Return-Path: <linux-wireless+bounces-6484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953F08A9111
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 04:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2562B2163D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 02:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E59D29A9;
	Thu, 18 Apr 2024 02:12:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC9150251
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 02:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406379; cv=none; b=ku23xaSUYhiFbTQ4eNcS0ZK5OzMB2Pfd2YCypUXO4LCTodx8nsU4cDn8E15d6jUaYJBG9oN9KhWmAPNTn+XohYxCJv5pUPMQdH/OP8WyqeivMzTcgXzp2n5hfU2mQAQYSV5ey9G2xP+jAq91tbcom+ptJDhDt5DCNqYLUPPBffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406379; c=relaxed/simple;
	bh=QTe0uaCdtCKNR0LCm1kSJG3DQLb5oHifHxn7K7b1B1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6VA3cLfPEVvW3rdk9doATGKbLs5VrNQInabFsxgYSZWGhCMIPLuICEgaaHPs85hcnuwkODBChPFMMflOSo0chwvvqcCtoVNZBAZ6wJgPST9F6EHG+Irw/NSDg2abHkMw3VN2It5nZGwPcd1JxfzI9vkN5wWqHJ+QBCDg4GouJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43I2CsMY23994740, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43I2CsMY23994740
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 10:12:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 10:12:54 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 10:12:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 6/9] wifi: rtw89: coex: Add register monitor report v7 format
Date: Thu, 18 Apr 2024 10:12:04 +0800
Message-ID: <20240418021207.32173-7-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

To avoid driver I/O, firmware will periodic monitor the register
settings and update to driver. The v7 report adjust the structure
variables order, so driver does changes accordingly.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 170 ++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h |   9 ++
 2 files changed, 163 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index b296217d593a..95b163d60779 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -284,12 +284,24 @@ struct rtw89_btc_btf_set_slot_table_v7 {
 	struct rtw89_btc_fbtc_slot_v7 v7[CXST_MAX];
 } __packed;
 
-struct rtw89_btc_btf_set_mon_reg {
+struct rtw89_btc_btf_set_mon_reg_v1 {
 	u8 fver;
 	u8 reg_num;
 	struct rtw89_btc_fbtc_mreg regs[] __counted_by(reg_num);
 } __packed;
 
+struct rtw89_btc_btf_set_mon_reg_v7 {
+	u8 type;
+	u8 fver;
+	u8 len;
+	struct rtw89_btc_fbtc_mreg regs[] __counted_by(len);
+} __packed;
+
+union rtw89_fbtc_set_mon_reg {
+	struct rtw89_btc_btf_set_mon_reg_v1 v1;
+	struct rtw89_btc_btf_set_mon_reg_v7 v7;
+} __packed;
+
 struct _wl_rinfo_now {
 	u8 link_mode;
 	u32 dbcc_2g_phy: 2;
@@ -1334,6 +1346,9 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		} else if (ver->fcxmreg == 2) {
 			pfinfo = &pfwinfo->rpt_fbtc_mregval.finfo.v2;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_mregval.finfo.v2);
+		} else if (ver->fcxmreg == 7) {
+			pfinfo = &pfwinfo->rpt_fbtc_mregval.finfo.v7;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_mregval.finfo.v7);
 		} else {
 			goto err;
 		}
@@ -1792,6 +1807,8 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		}
 		break;
 	case BTC_RPT_TYPE_MREG:
+		if (ver->fcxmreg == 7)
+			break;
 		_get_reg_status(rtwdev, BTC_CSTATUS_BB_GNT_MUX_MON, &val);
 		if (dm->wl_btg_rx == BTC_BTGCTRL_BB_GNT_FWCTRL)
 			dm->wl_btg_rx_rb = BTC_BTGCTRL_BB_GNT_FWCTRL;
@@ -2245,8 +2262,9 @@ static void btc_fw_set_monreg(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_btc_ver *ver = rtwdev->btc.ver;
-	struct rtw89_btc_btf_set_mon_reg *monreg = NULL;
-	u8 n, ulen, cxmreg_max;
+	struct rtw89_btc_btf_set_mon_reg_v1 *v1 = NULL;
+	struct rtw89_btc_btf_set_mon_reg_v7 *v7 = NULL;
+	u8 i, n, ulen, cxmreg_max;
 	u16 sz = 0;
 
 	n = chip->mon_reg_num;
@@ -2255,10 +2273,8 @@ static void btc_fw_set_monreg(struct rtw89_dev *rtwdev)
 
 	if (ver->fcxmreg == 1)
 		cxmreg_max = CXMREG_MAX;
-	else if (ver->fcxmreg == 2)
-		cxmreg_max = CXMREG_MAX_V2;
 	else
-		return;
+		cxmreg_max = CXMREG_MAX_V2;
 
 	if (n > cxmreg_max) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -2267,21 +2283,37 @@ static void btc_fw_set_monreg(struct rtw89_dev *rtwdev)
 		return;
 	}
 
-	ulen = sizeof(monreg->regs[0]);
-	sz = struct_size(monreg, regs, n);
-	monreg = kmalloc(sz, GFP_KERNEL);
-	if (!monreg)
-		return;
+	ulen = sizeof(struct rtw89_btc_fbtc_mreg);
+
+	if (ver->fcxmreg == 7) {
+		sz = struct_size(v7, regs, n);
+		v7 = kmalloc(sz, GFP_KERNEL);
+		v7->type = RPT_EN_MREG;
+		v7->fver = ver->fcxmreg;
+		v7->len = n;
+		for (i = 0; i < n; i++) {
+			v7->regs[i].type = chip->mon_reg[i].type;
+			v7->regs[i].bytes = chip->mon_reg[i].bytes;
+			v7->regs[i].offset = chip->mon_reg[i].offset;
+		}
+
+		_send_fw_cmd(rtwdev, BTFC_SET, SET_MREG_TABLE, v7, sz);
+		kfree(v7);
+	} else {
+		sz = struct_size(v1, regs, n);
+		v1 = kmalloc(sz, GFP_KERNEL);
+		v1->fver = ver->fcxmreg;
+		v1->reg_num = n;
+		memcpy(v1->regs, chip->mon_reg, flex_array_size(v1, regs, n));
+
+		_send_fw_cmd(rtwdev, BTFC_SET, SET_MREG_TABLE, v1, sz);
+		kfree(v1);
+	}
 
-	monreg->fver = ver->fcxmreg;
-	monreg->reg_num = n;
-	memcpy(monreg->regs, chip->mon_reg, flex_array_size(monreg, regs, n));
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): sz=%d ulen=%d n=%d\n",
 		    __func__, sz, ulen, n);
 
-	_send_fw_cmd(rtwdev, BTFC_SET, SET_MREG_TABLE, (u8 *)monreg, sz);
-	kfree(monreg);
 	rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_MREG, 1);
 }
 
@@ -7854,6 +7886,7 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 #define CASE_BTC_INIT(e) case BTC_MODE_## e: return #e
 #define CASE_BTC_ANTPATH_STR(e) case BTC_ANT_##e: return #e
 #define CASE_BTC_POLUT_STR(e) case BTC_PLT_## e: return #e
+#define CASE_BTC_REGTYPE_STR(e) case REG_## e: return #e
 
 static const char *id_to_polut(u32 id)
 {
@@ -7869,6 +7902,22 @@ static const char *id_to_polut(u32 id)
 	}
 }
 
+static const char *id_to_regtype(u32 id)
+{
+	switch (id) {
+	CASE_BTC_REGTYPE_STR(MAC);
+	CASE_BTC_REGTYPE_STR(BB);
+	CASE_BTC_REGTYPE_STR(RF);
+	CASE_BTC_REGTYPE_STR(BT_RF);
+	CASE_BTC_REGTYPE_STR(BT_MODEM);
+	CASE_BTC_REGTYPE_STR(BT_BLUEWIZE);
+	CASE_BTC_REGTYPE_STR(BT_VENDOR);
+	CASE_BTC_REGTYPE_STR(BT_LE);
+	default:
+		return "unknown";
+	}
+}
+
 static const char *steps_to_str(u16 step)
 {
 	switch (step) {
@@ -9442,6 +9491,93 @@ static void _show_mreg_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 	seq_puts(m, "\n");
 }
 
+static void _show_mreg_v7(struct rtw89_dev *rtwdev, struct seq_file *m)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
+	struct rtw89_btc_fbtc_mreg_val_v7 *pmreg = NULL;
+	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
+	struct rtw89_btc_fbtc_gpio_dbg *gdbg = NULL;
+	struct rtw89_btc_cx *cx = &btc->cx;
+	struct rtw89_btc_wl_info *wl = &cx->wl;
+	struct rtw89_btc_bt_info *bt = &cx->bt;
+	struct rtw89_mac_ax_gnt *gnt = NULL;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	u8 i, type, cnt = 0;
+	u32 val, offset;
+
+	if (!(dm->coex_info_map & BTC_COEX_INFO_MREG))
+		return;
+
+	seq_puts(m, "\n\r========== [HW Status] ==========");
+
+	seq_printf(m,
+		   "\n\r %-15s : WL->BT:0x%08x(cnt:%d), BT->WL:0x%08x(total:%d, bt_update:%d)",
+		   "[scoreboard]", wl->scbd, cx->cnt_wl[BTC_WCNT_SCBDUPDATE],
+		   bt->scbd, cx->cnt_bt[BTC_BCNT_SCBDREAD],
+		   cx->cnt_bt[BTC_BCNT_SCBDUPDATE]);
+
+	/* To avoid I/O if WL LPS or power-off  */
+	dm->pta_owner = rtw89_mac_get_ctrl_path(rtwdev);
+
+	seq_printf(m,
+		   "\n\r %-15s : pta_owner:%s, pta_req_mac:MAC%d, rf_gnt_source: polut_type:%s",
+		   "[gnt_status]",
+		   rtwdev->chip->para_ver & BTC_FEAT_PTA_ONOFF_CTRL ? "HW" :
+		   dm->pta_owner == BTC_CTRL_BY_WL ? "WL" : "BT",
+		   wl->pta_req_mac, id_to_polut(wl->bt_polut_type[wl->pta_req_mac]));
+
+	gnt = &dm->gnt.band[RTW89_PHY_0];
+
+	seq_printf(m, ", phy-0[gnt_wl:%s-%d/gnt_bt:%s-%d]",
+		   gnt->gnt_wl_sw_en ? "SW" : "HW", gnt->gnt_wl,
+		   gnt->gnt_bt_sw_en ? "SW" : "HW", gnt->gnt_bt);
+
+	if (rtwdev->dbcc_en) {
+		gnt = &dm->gnt.band[RTW89_PHY_1];
+		seq_printf(m, ", phy-1[gnt_wl:%s-%d/gnt_bt:%s-%d]",
+			   gnt->gnt_wl_sw_en ? "SW" : "HW", gnt->gnt_wl,
+			   gnt->gnt_bt_sw_en ? "SW" : "HW", gnt->gnt_bt);
+	}
+
+	pcinfo = &pfwinfo->rpt_fbtc_mregval.cinfo;
+	if (!pcinfo->valid)
+		return;
+
+	pmreg = &pfwinfo->rpt_fbtc_mregval.finfo.v7;
+
+	for (i = 0; i < pmreg->reg_num; i++) {
+		type = (u8)le16_to_cpu(rtwdev->chip->mon_reg[i].type);
+		offset = le32_to_cpu(rtwdev->chip->mon_reg[i].offset);
+		val = le32_to_cpu(pmreg->mreg_val[i]);
+
+		if (cnt % 6 == 0)
+			seq_printf(m, "\n\r %-15s : %s_0x%x=0x%x", "[reg]",
+				   id_to_regtype(type), offset, val);
+		else
+			seq_printf(m, ", %s_0x%x=0x%x",
+				   id_to_regtype(type), offset, val);
+		cnt++;
+	}
+
+	pcinfo = &pfwinfo->rpt_fbtc_gpio_dbg.cinfo;
+	if (!pcinfo->valid)
+		return;
+
+	gdbg = &pfwinfo->rpt_fbtc_gpio_dbg.finfo;
+	if (!gdbg->en_map)
+		return;
+
+	seq_printf(m, "\n\r %-15s : enable_map:0x%08x", "[gpio_dbg]", gdbg->en_map);
+
+	for (i = 0; i < BTC_DBG_MAX1; i++) {
+		if (!(gdbg->en_map & BIT(i)))
+			continue;
+		seq_printf(m, ", %d->GPIO%d",
+			   i, gdbg->gpio_map[i]);
+	}
+}
+
 static void _show_summary_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -9925,6 +10061,8 @@ void rtw89_btc_dump_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		_show_mreg_v1(rtwdev, m);
 	else if (ver->fcxmreg == 2)
 		_show_mreg_v2(rtwdev, m);
+	else if (ver->fcxmreg == 7)
+		_show_mreg_v7(rtwdev, m);
 
 	if (ver->fcxbtcrpt == 1)
 		_show_summary_v1(rtwdev, m);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 517966423969..ca5d4e078f8b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2274,9 +2274,18 @@ struct rtw89_btc_fbtc_mreg_val_v2 {
 	__le32 mreg_val[CXMREG_MAX_V2];
 } __packed;
 
+struct rtw89_btc_fbtc_mreg_val_v7 {
+	u8 fver;
+	u8 reg_num;
+	u8 rsvd0;
+	u8 rsvd1;
+	__le32 mreg_val[CXMREG_MAX_V2];
+} __packed;
+
 union rtw89_btc_fbtc_mreg_val {
 	struct rtw89_btc_fbtc_mreg_val_v1 v1;
 	struct rtw89_btc_fbtc_mreg_val_v2 v2;
+	struct rtw89_btc_fbtc_mreg_val_v7 v7;
 };
 
 #define RTW89_DEF_FBTC_MREG(__type, __bytes, __offset) \
-- 
2.25.1


