Return-Path: <linux-wireless+bounces-17817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAECA18B9E
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 07:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1F23ABFFE
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 06:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F9175D47;
	Wed, 22 Jan 2025 06:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KG32HIUc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480FF199240
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 06:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525840; cv=none; b=VEYOsfOiQiKaWqfG/srMzS5E/6b8ULBTLitI9ccAYCF+748W0QegsS9zFfWPgiB3/mZKRkDvY8MNa0EjX34jV4RBWU/L+HyDQkdYe4AziU1BPA4VlajNYZvvIhYep6RR1Lh8ft7jkTwlpa0KJr6F5uYWMni5YdliARswK/n+z1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525840; c=relaxed/simple;
	bh=Tjfkd0sHFA/yfJ77+10Eu8c8qpZwkZUNUqSDTppdYXs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URxJaI8LoHUii/Kpa6De689jAwV3jx5ld0xOqrywwAbeLhJhDQ2AlT2G4OcF4+K8Vqe/szcxSAXafvd9MH7FYEuNRDeKOVZcUljsRHgvfVFx/beN5zweptxpTCbTjEljIn89V/0qxKzEy8RI9ysdnX1bOkmoNGP6sULjW2LxsSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KG32HIUc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50M63kbeE2494542, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737525826; bh=Tjfkd0sHFA/yfJ77+10Eu8c8qpZwkZUNUqSDTppdYXs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=KG32HIUc4XBtbfo1Mb0L34cN/EVFagTc/lxjg898+kK+8gsrUDIKo3xWVk87j5rfV
	 sPWVcHd4LWjfymd1OJSHXX9ikQFPnkgnDDH2yhMcU1P46KEepdFwt/qB9AVzhzolaT
	 ec0SArTKJlaOfFlXf6Y3+1ELyJTsmiffiDC+nTGhHV73GYBRoCRB1PuOJG1ryvw2NI
	 p987pSeL5FUVya3RDOf04NyQ0oihXZ2Q8a9aq35uYhWmQ/4D0TBsv/EDOvrhVTvpun
	 vUFTXCaqMHHdgeU6Q/vsZjFcY+N1bwnJxdjJm1Oz6jiwikYXf+5QwC+089dF0pS1Ts
	 CexbBtmP0FqxQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50M63kbeE2494542
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 14:03:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 Jan 2025 14:03:47 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 22 Jan
 2025 14:03:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 03/10] wifi: rtw89: debugfs: implement file_ops::read/write to replace seq_file
Date: Wed, 22 Jan 2025 14:03:03 +0800
Message-ID: <20250122060310.31976-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250122060310.31976-1-pkshih@realtek.com>
References: <20250122060310.31976-1-pkshih@realtek.com>
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

Since debugfs needs wiphy lock held, wiphy_locked_debugfs_{read,write}()
will be adopted, so implmenet file_ops::read/write along with their
arguments.

For reading part, it needs lots of changes because seq_file is not
suitable for wiphy_locked_debugfs_{read,write}(), so use spatch script
below to convert basically, and manually implement the functions.

  @ rule1 @
  identifier m;
  @@

  - seq_printf(m,
  + p += scnprintf(p, end - p,
    ...)

  @ rule2 @
  identifier m;
  @@

  - seq_puts(m,
  + p += scnprintf(p, end - p,
    ...)

For current version, only 4K buffer to output. To note ourselves, add
ellipsis symbol "..." to trailing if buffer is full. Later, add an option
to specify buffer size needed by a debugfs entry.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c  | 2737 +++++++++++---------
 drivers/net/wireless/realtek/rtw89/coex.h  |    2 +-
 drivers/net/wireless/realtek/rtw89/debug.c | 1917 ++++++++------
 drivers/net/wireless/realtek/rtw89/phy.c   |   16 +-
 drivers/net/wireless/realtek/rtw89/phy.h   |    4 +-
 drivers/net/wireless/realtek/rtw89/sar.c   |   40 +-
 drivers/net/wireless/realtek/rtw89/sar.h   |    5 +-
 drivers/net/wireless/realtek/rtw89/util.c  |   11 +
 drivers/net/wireless/realtek/rtw89/util.h  |    1 +
 9 files changed, 2584 insertions(+), 2149 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index c51c06909966..1065f610d80f 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -8153,7 +8153,7 @@ void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 
 #define BTC_CX_FW_OFFLOAD 0
 
-static void _show_cx_info(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_cx_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	union rtw89_btc_module_info *md = &rtwdev->btc.mdinfo;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
@@ -8165,40 +8165,43 @@ static void _show_cx_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	u32 ver_main = 0, ver_sub = 0, ver_hotfix = 0, id_branch = 0;
 	u8 cv, rfe, iso, ant_num, ant_single_pos;
+	char *p = buf, *end = buf + bufsz;
 
 	if (!(dm->coex_info_map & BTC_COEX_INFO_CX))
-		return;
+		return 0;
 
 	dm->cnt_notify[BTC_NCNT_SHOW_COEX_INFO]++;
 
-	seq_printf(m, "========== [BTC COEX INFO (%d)] ==========\n",
-		   chip->chip_id);
+	p += scnprintf(p, end - p,
+		       "========== [BTC COEX INFO (%d)] ==========\n",
+		       chip->chip_id);
 
 	ver_main = FIELD_GET(GENMASK(31, 24), RTW89_COEX_VERSION);
 	ver_sub = FIELD_GET(GENMASK(23, 16), RTW89_COEX_VERSION);
 	ver_hotfix = FIELD_GET(GENMASK(15, 8), RTW89_COEX_VERSION);
 	id_branch = FIELD_GET(GENMASK(7, 0), RTW89_COEX_VERSION);
-	seq_printf(m, " %-15s : Coex:%d.%d.%d(branch:%d), ",
-		   "[coex_version]", ver_main, ver_sub, ver_hotfix, id_branch);
+	p += scnprintf(p, end - p, " %-15s : Coex:%d.%d.%d(branch:%d), ",
+		       "[coex_version]", ver_main, ver_sub, ver_hotfix,
+		       id_branch);
 
 	ver_main = FIELD_GET(GENMASK(31, 24), wl->ver_info.fw_coex);
 	ver_sub = FIELD_GET(GENMASK(23, 16), wl->ver_info.fw_coex);
 	ver_hotfix = FIELD_GET(GENMASK(15, 8), wl->ver_info.fw_coex);
 	id_branch = FIELD_GET(GENMASK(7, 0), wl->ver_info.fw_coex);
-	seq_printf(m, "WL_FW_coex:%d.%d.%d(branch:%d)",
-		   ver_main, ver_sub, ver_hotfix, id_branch);
+	p += scnprintf(p, end - p, "WL_FW_coex:%d.%d.%d(branch:%d)",
+		       ver_main, ver_sub, ver_hotfix, id_branch);
 
 	ver_main = FIELD_GET(GENMASK(31, 24), chip->wlcx_desired);
 	ver_sub = FIELD_GET(GENMASK(23, 16), chip->wlcx_desired);
 	ver_hotfix = FIELD_GET(GENMASK(15, 8), chip->wlcx_desired);
-	seq_printf(m, "(%s, desired:%d.%d.%d), ",
-		   (wl->ver_info.fw_coex >= chip->wlcx_desired ?
-		   "Match" : "Mismatch"), ver_main, ver_sub, ver_hotfix);
+	p += scnprintf(p, end - p, "(%s, desired:%d.%d.%d), ",
+		       (wl->ver_info.fw_coex >= chip->wlcx_desired ?
+			"Match" : "Mismatch"), ver_main, ver_sub, ver_hotfix);
 
-	seq_printf(m, "BT_FW_coex:%d(%s, desired:%d)\n",
-		   bt->ver_info.fw_coex,
-		   (bt->ver_info.fw_coex >= chip->btcx_desired ?
-		   "Match" : "Mismatch"), chip->btcx_desired);
+	p += scnprintf(p, end - p, "BT_FW_coex:%d(%s, desired:%d)\n",
+		       bt->ver_info.fw_coex,
+		       (bt->ver_info.fw_coex >= chip->btcx_desired ?
+			"Match" : "Mismatch"), chip->btcx_desired);
 
 	if (bt->enable.now && bt->ver_info.fw == 0)
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_VER_INFO, true);
@@ -8209,10 +8212,11 @@ static void _show_cx_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	ver_sub = FIELD_GET(GENMASK(23, 16), wl->ver_info.fw);
 	ver_hotfix = FIELD_GET(GENMASK(15, 8), wl->ver_info.fw);
 	id_branch = FIELD_GET(GENMASK(7, 0), wl->ver_info.fw);
-	seq_printf(m, " %-15s : WL_FW:%d.%d.%d.%d, BT_FW:0x%x(%s)\n",
-		   "[sub_module]",
-		   ver_main, ver_sub, ver_hotfix, id_branch,
-		   bt->ver_info.fw, bt->run_patch_code ? "patch" : "ROM");
+	p += scnprintf(p, end - p,
+		       " %-15s : WL_FW:%d.%d.%d.%d, BT_FW:0x%x(%s)\n",
+		       "[sub_module]",
+		       ver_main, ver_sub, ver_hotfix, id_branch,
+		       bt->ver_info.fw, bt->run_patch_code ? "patch" : "ROM");
 
 	if (ver->fcxinit == 7) {
 		cv = md->md_v7.kt_ver;
@@ -8228,36 +8232,41 @@ static void _show_cx_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		ant_single_pos = md->md.ant.single_pos;
 	}
 
-	seq_printf(m, " %-15s : cv:%x, rfe_type:0x%x, ant_iso:%d, ant_pg:%d, %s",
-		   "[hw_info]", cv, rfe, iso, ant_num,
-		   ant_num > 1 ? "" :
-		   ant_single_pos ? "1Ant_Pos:S1, " : "1Ant_Pos:S0, ");
+	p += scnprintf(p, end - p,
+		       " %-15s : cv:%x, rfe_type:0x%x, ant_iso:%d, ant_pg:%d, %s",
+		       "[hw_info]", cv, rfe, iso, ant_num,
+		       ant_num > 1 ? "" :
+		       ant_single_pos ? "1Ant_Pos:S1, " : "1Ant_Pos:S0, ");
 
-	seq_printf(m, "3rd_coex:%d, dbcc:%d, tx_num:%d, rx_num:%d\n",
-		   btc->cx.other.type, rtwdev->dbcc_en, hal->tx_nss,
-		   hal->rx_nss);
+	p += scnprintf(p, end - p,
+		       "3rd_coex:%d, dbcc:%d, tx_num:%d, rx_num:%d\n",
+		       btc->cx.other.type, rtwdev->dbcc_en, hal->tx_nss,
+		       hal->rx_nss);
+
+	return p - buf;
 }
 
-static void _show_wl_role_info(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_wl_role_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_link_info *plink = NULL;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
 	struct rtw89_traffic_stats *t;
+	char *p = buf, *end = buf + bufsz;
 	u8 i;
 
 	if (rtwdev->dbcc_en) {
-		seq_printf(m,
-			   " %-15s : PHY0_band(op:%d/scan:%d/real:%d), ",
-			   "[dbcc_info]", wl_dinfo->op_band[RTW89_PHY_0],
-			   wl_dinfo->scan_band[RTW89_PHY_0],
-			   wl_dinfo->real_band[RTW89_PHY_0]);
-		seq_printf(m,
-			   "PHY1_band(op:%d/scan:%d/real:%d)\n",
-			   wl_dinfo->op_band[RTW89_PHY_1],
-			   wl_dinfo->scan_band[RTW89_PHY_1],
-			   wl_dinfo->real_band[RTW89_PHY_1]);
+		p += scnprintf(p, end - p,
+			       " %-15s : PHY0_band(op:%d/scan:%d/real:%d), ",
+			       "[dbcc_info]", wl_dinfo->op_band[RTW89_PHY_0],
+			       wl_dinfo->scan_band[RTW89_PHY_0],
+			       wl_dinfo->real_band[RTW89_PHY_0]);
+		p += scnprintf(p, end - p,
+			       "PHY1_band(op:%d/scan:%d/real:%d)\n",
+			       wl_dinfo->op_band[RTW89_PHY_1],
+			       wl_dinfo->scan_band[RTW89_PHY_1],
+			       wl_dinfo->real_band[RTW89_PHY_1]);
 	}
 
 	for (i = 0; i < RTW89_PORT_NUM; i++) {
@@ -8269,38 +8278,41 @@ static void _show_wl_role_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		if (!plink->active)
 			continue;
 
-		seq_printf(m,
-			   " [port_%d]        : role=%d(phy-%d), connect=%d(client_cnt=%d), mode=%d, center_ch=%d, bw=%d",
-			   plink->pid, (u32)plink->role, plink->phy,
-			   (u32)plink->connected, plink->client_cnt - 1,
-			   (u32)plink->mode, plink->ch, (u32)plink->bw);
+		p += scnprintf(p, end - p,
+			       " [port_%d]        : role=%d(phy-%d), connect=%d(client_cnt=%d), mode=%d, center_ch=%d, bw=%d",
+			       plink->pid, (u32)plink->role, plink->phy,
+			       (u32)plink->connected, plink->client_cnt - 1,
+			       (u32)plink->mode, plink->ch, (u32)plink->bw);
 
 		if (plink->connected == MLME_NO_LINK)
 			continue;
 
-		seq_printf(m,
-			   ", mac_id=%d, max_tx_time=%dus, max_tx_retry=%d\n",
-			   plink->mac_id, plink->tx_time, plink->tx_retry);
+		p += scnprintf(p, end - p,
+			       ", mac_id=%d, max_tx_time=%dus, max_tx_retry=%d\n",
+			       plink->mac_id, plink->tx_time, plink->tx_retry);
 
-		seq_printf(m,
-			   " [port_%d]        : rssi=-%ddBm(%d), busy=%d, dir=%s, ",
-			   plink->pid, 110 - plink->stat.rssi,
-			   plink->stat.rssi, plink->busy,
-			   plink->dir == RTW89_TFC_UL ? "UL" : "DL");
+		p += scnprintf(p, end - p,
+			       " [port_%d]        : rssi=-%ddBm(%d), busy=%d, dir=%s, ",
+			       plink->pid, 110 - plink->stat.rssi,
+			       plink->stat.rssi, plink->busy,
+			       plink->dir == RTW89_TFC_UL ? "UL" : "DL");
 
 		t = &plink->stat.traffic;
 
-		seq_printf(m,
-			   "tx[rate:%d/busy_level:%d], ",
-			   (u32)t->tx_rate, t->tx_tfc_lv);
+		p += scnprintf(p, end - p,
+			       "tx[rate:%d/busy_level:%d], ",
+			       (u32)t->tx_rate, t->tx_tfc_lv);
 
-		seq_printf(m, "rx[rate:%d/busy_level:%d/drop:%d]\n",
-			   (u32)t->rx_rate,
-			   t->rx_tfc_lv, plink->rx_rate_drop_cnt);
+		p += scnprintf(p, end - p,
+			       "rx[rate:%d/busy_level:%d/drop:%d]\n",
+			       (u32)t->rx_rate,
+			       t->rx_tfc_lv, plink->rx_rate_drop_cnt);
 	}
+
+	return p - buf;
 }
 
-static void _show_wl_info(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_wl_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
@@ -8311,12 +8323,13 @@ static void _show_wl_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
 	struct rtw89_btc_wl_role_info_v7 *wl_rinfo_v7 = &wl->role_info_v7;
 	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
+	char *p = buf, *end = buf + bufsz;
 	u8 mode;
 
 	if (!(btc->dm.coex_info_map & BTC_COEX_INFO_WL))
-		return;
+		return 0;
 
-	seq_puts(m, "========== [WL Status] ==========\n");
+	p += scnprintf(p, end - p, "========== [WL Status] ==========\n");
 
 	if (ver->fwlrole == 0)
 		mode = wl_rinfo->link_mode;
@@ -8329,24 +8342,28 @@ static void _show_wl_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	else if (ver->fwlrole == 8)
 		mode = wl_rinfo_v8->link_mode;
 	else
-		return;
+		goto out;
+
+	p += scnprintf(p, end - p, " %-15s : link_mode:%d, ", "[status]",
+		       mode);
 
-	seq_printf(m, " %-15s : link_mode:%d, ", "[status]", mode);
+	p += scnprintf(p, end - p,
+		       "rf_off:%d, power_save:%d, scan:%s(band:%d/phy_map:0x%x), ",
+		       wl->status.map.rf_off, wl->status.map.lps,
+		       wl->status.map.scan ? "Y" : "N",
+		       wl->scan_info.band[RTW89_PHY_0], wl->scan_info.phy_map);
 
-	seq_printf(m,
-		   "rf_off:%d, power_save:%d, scan:%s(band:%d/phy_map:0x%x), ",
-		   wl->status.map.rf_off, wl->status.map.lps,
-		   wl->status.map.scan ? "Y" : "N",
-		   wl->scan_info.band[RTW89_PHY_0], wl->scan_info.phy_map);
+	p += scnprintf(p, end - p,
+		       "connecting:%s, roam:%s, 4way:%s, init_ok:%s\n",
+		       wl->status.map.connecting ? "Y" : "N",
+		       wl->status.map.roaming ?  "Y" : "N",
+		       wl->status.map._4way ? "Y" : "N",
+		       wl->status.map.init_ok ? "Y" : "N");
 
-	seq_printf(m,
-		   "connecting:%s, roam:%s, 4way:%s, init_ok:%s\n",
-		   wl->status.map.connecting ? "Y" : "N",
-		   wl->status.map.roaming ?  "Y" : "N",
-		   wl->status.map._4way ? "Y" : "N",
-		   wl->status.map.init_ok ? "Y" : "N");
+	p += _show_wl_role_info(rtwdev, p, end - p);
 
-	_show_wl_role_info(rtwdev, m);
+out:
+	return p - buf;
 }
 
 enum btc_bt_a2dp_type {
@@ -8355,7 +8372,7 @@ enum btc_bt_a2dp_type {
 	BTC_A2DP_TWS_RELAY = 2,
 };
 
-static void _show_bt_profile_info(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_bt_profile_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_bt_link_info *bt_linfo = &btc->cx.bt.link_info;
@@ -8363,50 +8380,55 @@ static void _show_bt_profile_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_bt_hid_desc hid = bt_linfo->hid_desc;
 	struct rtw89_btc_bt_a2dp_desc a2dp = bt_linfo->a2dp_desc;
 	struct rtw89_btc_bt_pan_desc pan = bt_linfo->pan_desc;
+	char *p = buf, *end = buf + bufsz;
 
 	if (hfp.exist) {
-		seq_printf(m, " %-15s : type:%s, sut_pwr:%d, golden-rx:%d",
-			   "[HFP]", (hfp.type == 0 ? "SCO" : "eSCO"),
-			   bt_linfo->sut_pwr_level[0],
-			   bt_linfo->golden_rx_shift[0]);
+		p += scnprintf(p, end - p,
+			       " %-15s : type:%s, sut_pwr:%d, golden-rx:%d",
+			       "[HFP]", (hfp.type == 0 ? "SCO" : "eSCO"),
+			       bt_linfo->sut_pwr_level[0],
+			       bt_linfo->golden_rx_shift[0]);
 	}
 
 	if (hid.exist) {
-		seq_printf(m,
-			   "\n\r %-15s : type:%s%s%s%s%s pair-cnt:%d, sut_pwr:%d, golden-rx:%d\n",
-			   "[HID]",
-			   hid.type & BTC_HID_218 ? "2/18," : "",
-			   hid.type & BTC_HID_418 ? "4/18," : "",
-			   hid.type & BTC_HID_BLE ? "BLE," : "",
-			   hid.type & BTC_HID_RCU ? "RCU," : "",
-			   hid.type & BTC_HID_RCU_VOICE ? "RCU-Voice," : "",
-			   hid.pair_cnt, bt_linfo->sut_pwr_level[1],
-			   bt_linfo->golden_rx_shift[1]);
+		p += scnprintf(p, end - p,
+			       "\n\r %-15s : type:%s%s%s%s%s pair-cnt:%d, sut_pwr:%d, golden-rx:%d\n",
+			       "[HID]",
+			       hid.type & BTC_HID_218 ? "2/18," : "",
+			       hid.type & BTC_HID_418 ? "4/18," : "",
+			       hid.type & BTC_HID_BLE ? "BLE," : "",
+			       hid.type & BTC_HID_RCU ? "RCU," : "",
+			       hid.type & BTC_HID_RCU_VOICE ? "RCU-Voice," : "",
+			       hid.pair_cnt, bt_linfo->sut_pwr_level[1],
+			       bt_linfo->golden_rx_shift[1]);
 	}
 
 	if (a2dp.exist) {
-		seq_printf(m,
-			   " %-15s : type:%s, bit-pool:%d, flush-time:%d, ",
-			   "[A2DP]",
-			   a2dp.type == BTC_A2DP_LEGACY ? "Legacy" : "TWS",
-			    a2dp.bitpool, a2dp.flush_time);
+		p += scnprintf(p, end - p,
+			       " %-15s : type:%s, bit-pool:%d, flush-time:%d, ",
+			       "[A2DP]",
+			       a2dp.type == BTC_A2DP_LEGACY ? "Legacy" : "TWS",
+			       a2dp.bitpool, a2dp.flush_time);
 
-		seq_printf(m,
-			   "vid:0x%x, Dev-name:0x%x, sut_pwr:%d, golden-rx:%d\n",
-			   a2dp.vendor_id, a2dp.device_name,
-			   bt_linfo->sut_pwr_level[2],
-			   bt_linfo->golden_rx_shift[2]);
+		p += scnprintf(p, end - p,
+			       "vid:0x%x, Dev-name:0x%x, sut_pwr:%d, golden-rx:%d\n",
+			       a2dp.vendor_id, a2dp.device_name,
+			       bt_linfo->sut_pwr_level[2],
+			       bt_linfo->golden_rx_shift[2]);
 	}
 
 	if (pan.exist) {
-		seq_printf(m, " %-15s : sut_pwr:%d, golden-rx:%d\n",
-			   "[PAN]",
-			   bt_linfo->sut_pwr_level[3],
-			   bt_linfo->golden_rx_shift[3]);
+		p += scnprintf(p, end - p,
+			       " %-15s : sut_pwr:%d, golden-rx:%d\n",
+			       "[PAN]",
+			       bt_linfo->sut_pwr_level[3],
+			       bt_linfo->golden_rx_shift[3]);
 	}
+
+	return p - buf;
 }
 
-static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
@@ -8415,129 +8437,136 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 	union rtw89_btc_module_info *md = &btc->mdinfo;
+	char *p = buf, *end = buf + bufsz;
 	u8 *afh = bt_linfo->afh_map;
 	u8 *afh_le = bt_linfo->afh_map_le;
 	u8 bt_pos;
 
 	if (!(btc->dm.coex_info_map & BTC_COEX_INFO_BT))
-		return;
+		return 0;
 
 	if (ver->fcxinit == 7)
 		bt_pos = md->md_v7.bt_pos;
 	else
 		bt_pos = md->md.bt_pos;
 
-	seq_puts(m, "========== [BT Status] ==========\n");
-
-	seq_printf(m, " %-15s : enable:%s, btg:%s%s, connect:%s, ",
-		   "[status]", bt->enable.now ? "Y" : "N",
-		   bt->btg_type ? "Y" : "N",
-		   (bt->enable.now && (bt->btg_type != bt_pos) ?
-		   "(efuse-mismatch!!)" : ""),
-		   (bt_linfo->status.map.connect ? "Y" : "N"));
-
-	seq_printf(m, "igno_wl:%s, mailbox_avl:%s, rfk_state:0x%x\n",
-		   bt->igno_wl ? "Y" : "N",
-		   bt->mbx_avl ? "Y" : "N", bt->rfk_info.val);
-
-	seq_printf(m, " %-15s : profile:%s%s%s%s%s ",
-		   "[profile]",
-		   (bt_linfo->profile_cnt.now == 0) ? "None," : "",
-		   bt_linfo->hfp_desc.exist ? "HFP," : "",
-		   bt_linfo->hid_desc.exist ? "HID," : "",
-		   bt_linfo->a2dp_desc.exist ?
-		   (bt_linfo->a2dp_desc.sink ? "A2DP_sink," : "A2DP,") : "",
-		   bt_linfo->pan_desc.exist ? "PAN," : "");
-
-	seq_printf(m,
-		   "multi-link:%s, role:%s, ble-connect:%s, CQDDR:%s, A2DP_active:%s, PAN_active:%s\n",
-		   bt_linfo->multi_link.now ? "Y" : "N",
-		   bt_linfo->slave_role ? "Slave" : "Master",
-		   bt_linfo->status.map.ble_connect ? "Y" : "N",
-		   bt_linfo->cqddr ? "Y" : "N",
-		   bt_linfo->a2dp_desc.active ? "Y" : "N",
-		   bt_linfo->pan_desc.active ? "Y" : "N");
-
-	seq_printf(m,
-		   " %-15s : rssi:%ddBm(lvl:%d), tx_rate:%dM, %s%s%s",
-		   "[link]", bt_linfo->rssi - 100,
-		   bt->rssi_level,
-		   bt_linfo->tx_3m ? 3 : 2,
-		   bt_linfo->status.map.inq_pag ? " inq-page!!" : "",
-		   bt_linfo->status.map.acl_busy ? " acl_busy!!" : "",
-		   bt_linfo->status.map.mesh_busy ? " mesh_busy!!" : "");
-
-	seq_printf(m,
-		   "%s afh_map[%02x%02x_%02x%02x_%02x%02x_%02x%02x_%02x%02x], ",
-		   bt_linfo->relink.now ? " ReLink!!" : "",
-		   afh[0], afh[1], afh[2], afh[3], afh[4],
-		   afh[5], afh[6], afh[7], afh[8], afh[9]);
+	p += scnprintf(p, end - p, "========== [BT Status] ==========\n");
+
+	p += scnprintf(p, end - p,
+		       " %-15s : enable:%s, btg:%s%s, connect:%s, ",
+		       "[status]", bt->enable.now ? "Y" : "N",
+		       bt->btg_type ? "Y" : "N",
+		       (bt->enable.now && (bt->btg_type != bt_pos) ?
+			"(efuse-mismatch!!)" : ""),
+		       (bt_linfo->status.map.connect ? "Y" : "N"));
+
+	p += scnprintf(p, end - p,
+		       "igno_wl:%s, mailbox_avl:%s, rfk_state:0x%x\n",
+		       bt->igno_wl ? "Y" : "N",
+		       bt->mbx_avl ? "Y" : "N", bt->rfk_info.val);
+
+	p += scnprintf(p, end - p, " %-15s : profile:%s%s%s%s%s ",
+		       "[profile]",
+		       (bt_linfo->profile_cnt.now == 0) ? "None," : "",
+		       bt_linfo->hfp_desc.exist ? "HFP," : "",
+		       bt_linfo->hid_desc.exist ? "HID," : "",
+		       bt_linfo->a2dp_desc.exist ?
+		       (bt_linfo->a2dp_desc.sink ? "A2DP_sink," : "A2DP,") : "",
+		       bt_linfo->pan_desc.exist ? "PAN," : "");
+
+	p += scnprintf(p, end - p,
+		       "multi-link:%s, role:%s, ble-connect:%s, CQDDR:%s, A2DP_active:%s, PAN_active:%s\n",
+		       bt_linfo->multi_link.now ? "Y" : "N",
+		       bt_linfo->slave_role ? "Slave" : "Master",
+		       bt_linfo->status.map.ble_connect ? "Y" : "N",
+		       bt_linfo->cqddr ? "Y" : "N",
+		       bt_linfo->a2dp_desc.active ? "Y" : "N",
+		       bt_linfo->pan_desc.active ? "Y" : "N");
+
+	p += scnprintf(p, end - p,
+		       " %-15s : rssi:%ddBm(lvl:%d), tx_rate:%dM, %s%s%s",
+		       "[link]", bt_linfo->rssi - 100,
+		       bt->rssi_level,
+		       bt_linfo->tx_3m ? 3 : 2,
+		       bt_linfo->status.map.inq_pag ? " inq-page!!" : "",
+		       bt_linfo->status.map.acl_busy ? " acl_busy!!" : "",
+		       bt_linfo->status.map.mesh_busy ? " mesh_busy!!" : "");
+
+	p += scnprintf(p, end - p,
+		       "%s afh_map[%02x%02x_%02x%02x_%02x%02x_%02x%02x_%02x%02x], ",
+		       bt_linfo->relink.now ? " ReLink!!" : "",
+		       afh[0], afh[1], afh[2], afh[3], afh[4],
+		       afh[5], afh[6], afh[7], afh[8], afh[9]);
 
 	if (ver->fcxbtafh == 2 && bt_linfo->status.map.ble_connect)
-		seq_printf(m,
-			   "LE[%02x%02x_%02x_%02x%02x]",
-			   afh_le[0], afh_le[1], afh_le[2],
-			   afh_le[3], afh_le[4]);
-
-	seq_printf(m, "wl_ch_map[en:%d/ch:%d/bw:%d]\n",
-		   wl->afh_info.en, wl->afh_info.ch, wl->afh_info.bw);
-
-	seq_printf(m,
-		   " %-15s : retry:%d, relink:%d, rate_chg:%d, reinit:%d, reenable:%d, ",
-		   "[stat_cnt]", cx->cnt_bt[BTC_BCNT_RETRY],
-		   cx->cnt_bt[BTC_BCNT_RELINK], cx->cnt_bt[BTC_BCNT_RATECHG],
-		   cx->cnt_bt[BTC_BCNT_REINIT], cx->cnt_bt[BTC_BCNT_REENABLE]);
-
-	seq_printf(m,
-		   "role-switch:%d, afh:%d, inq_page:%d(inq:%d/page:%d), igno_wl:%d\n",
-		   cx->cnt_bt[BTC_BCNT_ROLESW], cx->cnt_bt[BTC_BCNT_AFH],
-		   cx->cnt_bt[BTC_BCNT_INQPAG], cx->cnt_bt[BTC_BCNT_INQ],
-		   cx->cnt_bt[BTC_BCNT_PAGE], cx->cnt_bt[BTC_BCNT_IGNOWL]);
-
-	_show_bt_profile_info(rtwdev, m);
-
-	seq_printf(m,
-		   " %-15s : raw_data[%02x %02x %02x %02x %02x %02x] (type:%s/cnt:%d/same:%d)\n",
-		   "[bt_info]", bt->raw_info[2], bt->raw_info[3],
-		   bt->raw_info[4], bt->raw_info[5], bt->raw_info[6],
-		   bt->raw_info[7],
-		   bt->raw_info[0] == BTC_BTINFO_AUTO ? "auto" : "reply",
-		   cx->cnt_bt[BTC_BCNT_INFOUPDATE],
-		   cx->cnt_bt[BTC_BCNT_INFOSAME]);
-
-	seq_printf(m,
-		   " %-15s : Hi-rx = %d, Hi-tx = %d, Lo-rx = %d, Lo-tx = %d (bt_polut_wl_tx = %d)",
-		   "[trx_req_cnt]", cx->cnt_bt[BTC_BCNT_HIPRI_RX],
-		   cx->cnt_bt[BTC_BCNT_HIPRI_TX], cx->cnt_bt[BTC_BCNT_LOPRI_RX],
-		   cx->cnt_bt[BTC_BCNT_LOPRI_TX], cx->cnt_bt[BTC_BCNT_POLUT]);
+		p += scnprintf(p, end - p,
+			       "LE[%02x%02x_%02x_%02x%02x]",
+			       afh_le[0], afh_le[1], afh_le[2],
+			       afh_le[3], afh_le[4]);
+
+	p += scnprintf(p, end - p, "wl_ch_map[en:%d/ch:%d/bw:%d]\n",
+		       wl->afh_info.en, wl->afh_info.ch, wl->afh_info.bw);
+
+	p += scnprintf(p, end - p,
+		       " %-15s : retry:%d, relink:%d, rate_chg:%d, reinit:%d, reenable:%d, ",
+		       "[stat_cnt]", cx->cnt_bt[BTC_BCNT_RETRY],
+		       cx->cnt_bt[BTC_BCNT_RELINK],
+		       cx->cnt_bt[BTC_BCNT_RATECHG],
+		       cx->cnt_bt[BTC_BCNT_REINIT],
+		       cx->cnt_bt[BTC_BCNT_REENABLE]);
+
+	p += scnprintf(p, end - p,
+		       "role-switch:%d, afh:%d, inq_page:%d(inq:%d/page:%d), igno_wl:%d\n",
+		       cx->cnt_bt[BTC_BCNT_ROLESW], cx->cnt_bt[BTC_BCNT_AFH],
+		       cx->cnt_bt[BTC_BCNT_INQPAG], cx->cnt_bt[BTC_BCNT_INQ],
+		       cx->cnt_bt[BTC_BCNT_PAGE], cx->cnt_bt[BTC_BCNT_IGNOWL]);
+
+	p += _show_bt_profile_info(rtwdev, p, end - p);
+
+	p += scnprintf(p, end - p,
+		       " %-15s : raw_data[%02x %02x %02x %02x %02x %02x] (type:%s/cnt:%d/same:%d)\n",
+		       "[bt_info]", bt->raw_info[2], bt->raw_info[3],
+		       bt->raw_info[4], bt->raw_info[5], bt->raw_info[6],
+		       bt->raw_info[7],
+		       bt->raw_info[0] == BTC_BTINFO_AUTO ? "auto" : "reply",
+		       cx->cnt_bt[BTC_BCNT_INFOUPDATE],
+		       cx->cnt_bt[BTC_BCNT_INFOSAME]);
+
+	p += scnprintf(p, end - p,
+		       " %-15s : Hi-rx = %d, Hi-tx = %d, Lo-rx = %d, Lo-tx = %d (bt_polut_wl_tx = %d)",
+		       "[trx_req_cnt]", cx->cnt_bt[BTC_BCNT_HIPRI_RX],
+		       cx->cnt_bt[BTC_BCNT_HIPRI_TX],
+		       cx->cnt_bt[BTC_BCNT_LOPRI_RX],
+		       cx->cnt_bt[BTC_BCNT_LOPRI_TX],
+		       cx->cnt_bt[BTC_BCNT_POLUT]);
 
 	if (!bt->scan_info_update) {
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_SCAN_INFO, true);
-		seq_puts(m, "\n");
+		p += scnprintf(p, end - p, "\n");
 	} else {
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_SCAN_INFO, false);
 		if (ver->fcxbtscan == 1) {
-			seq_printf(m,
-				   "(INQ:%d-%d/PAGE:%d-%d/LE:%d-%d/INIT:%d-%d)",
-				   le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INQ].win),
-				   le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INQ].intvl),
-				   le16_to_cpu(bt->scan_info_v1[BTC_SCAN_PAGE].win),
-				   le16_to_cpu(bt->scan_info_v1[BTC_SCAN_PAGE].intvl),
-				   le16_to_cpu(bt->scan_info_v1[BTC_SCAN_BLE].win),
-				   le16_to_cpu(bt->scan_info_v1[BTC_SCAN_BLE].intvl),
-				   le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INIT].win),
-				   le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INIT].intvl));
+			p += scnprintf(p, end - p,
+				       "(INQ:%d-%d/PAGE:%d-%d/LE:%d-%d/INIT:%d-%d)",
+				       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INQ].win),
+				       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INQ].intvl),
+				       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_PAGE].win),
+				       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_PAGE].intvl),
+				       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_BLE].win),
+				       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_BLE].intvl),
+				       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INIT].win),
+				       le16_to_cpu(bt->scan_info_v1[BTC_SCAN_INIT].intvl));
 		} else if (ver->fcxbtscan == 2) {
-			seq_printf(m,
-				   "(BG:%d-%d/INIT:%d-%d/LE:%d-%d)",
-				   le16_to_cpu(bt->scan_info_v2[CXSCAN_BG].win),
-				   le16_to_cpu(bt->scan_info_v2[CXSCAN_BG].intvl),
-				   le16_to_cpu(bt->scan_info_v2[CXSCAN_INIT].win),
-				   le16_to_cpu(bt->scan_info_v2[CXSCAN_INIT].intvl),
-				   le16_to_cpu(bt->scan_info_v2[CXSCAN_LE].win),
-				   le16_to_cpu(bt->scan_info_v2[CXSCAN_LE].intvl));
+			p += scnprintf(p, end - p,
+				       "(BG:%d-%d/INIT:%d-%d/LE:%d-%d)",
+				       le16_to_cpu(bt->scan_info_v2[CXSCAN_BG].win),
+				       le16_to_cpu(bt->scan_info_v2[CXSCAN_BG].intvl),
+				       le16_to_cpu(bt->scan_info_v2[CXSCAN_INIT].win),
+				       le16_to_cpu(bt->scan_info_v2[CXSCAN_INIT].intvl),
+				       le16_to_cpu(bt->scan_info_v2[CXSCAN_LE].win),
+				       le16_to_cpu(bt->scan_info_v2[CXSCAN_LE].intvl));
 		}
-		seq_puts(m, "\n");
+		p += scnprintf(p, end - p, "\n");
 	}
 
 	if (bt_linfo->profile_cnt.now || bt_linfo->status.map.ble_connect)
@@ -8557,6 +8586,8 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_DEVICE_INFO, true);
 	else
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_DEVICE_INFO, false);
+
+	return p - buf;
 }
 
 #define CASE_BTC_RSN_STR(e) case BTC_RSN_ ## e: return #e
@@ -8850,114 +8881,132 @@ static const char *id_to_ant(u32 id)
 }
 
 static
-void seq_print_segment(struct seq_file *m, const char *prefix, u16 *data,
-		       u8 len, u8 seg_len, u8 start_idx, u8 ring_len)
+int scnprintf_segment(char *buf, size_t bufsz, const char *prefix, const u16 *data,
+		      u8 len, u8 seg_len, u8 start_idx, u8 ring_len)
 {
-	u8 i;
+	char *p = buf, *end = buf + bufsz;
 	u8 cur_index;
+	u8 i;
 
 	for (i = 0; i < len ; i++) {
 		if ((i % seg_len) == 0)
-			seq_printf(m, " %-15s : ", prefix);
+			p += scnprintf(p, end - p, " %-15s : ", prefix);
 		cur_index = (start_idx + i) % ring_len;
 		if (i % 3 == 0)
-			seq_printf(m, "-> %-20s",
-				   steps_to_str(*(data + cur_index)));
+			p += scnprintf(p, end - p, "-> %-20s",
+				       steps_to_str(*(data + cur_index)));
 		else if (i % 3 == 1)
-			seq_printf(m, "-> %-15s",
-				   steps_to_str(*(data + cur_index)));
+			p += scnprintf(p, end - p, "-> %-15s",
+				       steps_to_str(*(data + cur_index)));
 		else
-			seq_printf(m, "-> %-13s",
-				   steps_to_str(*(data + cur_index)));
+			p += scnprintf(p, end - p, "-> %-13s",
+				       steps_to_str(*(data + cur_index)));
 		if (i == (len - 1) || (i % seg_len) == (seg_len - 1))
-			seq_puts(m, "\n");
+			p += scnprintf(p, end - p, "\n");
 	}
+
+	return p - buf;
 }
 
-static void _show_dm_step(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_dm_step(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
+	char *p = buf, *end = buf + bufsz;
 	u8 start_idx;
 	u8 len;
 
 	len = dm->dm_step.step_ov ? RTW89_BTC_DM_MAXSTEP : dm->dm_step.step_pos;
 	start_idx = dm->dm_step.step_ov ? dm->dm_step.step_pos : 0;
 
-	seq_print_segment(m, "[dm_steps]", dm->dm_step.step, len, 6, start_idx,
-			  ARRAY_SIZE(dm->dm_step.step));
+	p += scnprintf_segment(p, end - p, "[dm_steps]", dm->dm_step.step, len,
+			       6, start_idx, ARRAY_SIZE(dm->dm_step.step));
+
+	return p - buf;
 }
 
-static void _show_dm_info(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_dm_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	char *p = buf, *end = buf + bufsz;
 	u8 igno_bt;
 
 	if (!(dm->coex_info_map & BTC_COEX_INFO_DM))
-		return;
+		return 0;
 
-	seq_printf(m, "========== [Mechanism Status %s] ==========\n",
-		   (btc->manual_ctrl ? "(Manual)" : "(Auto)"));
+	p += scnprintf(p, end - p,
+		       "========== [Mechanism Status %s] ==========\n",
+		       (btc->manual_ctrl ? "(Manual)" : "(Auto)"));
 
-	seq_printf(m,
-		   " %-15s : type:%s, reason:%s(), action:%s(), ant_path:%s, init_mode:%s, run_cnt:%d\n",
-		   "[status]",
-		   btc->ant_type == BTC_ANT_SHARED ? "shared" : "dedicated",
-		   steps_to_str(dm->run_reason),
-		   steps_to_str(dm->run_action | BTC_ACT_EXT_BIT),
-		   id_to_ant(FIELD_GET(GENMASK(7, 0), dm->set_ant_path)),
-		   id_to_mode(wl->coex_mode),
-		   dm->cnt_dm[BTC_DCNT_RUN]);
+	p += scnprintf(p, end - p,
+		       " %-15s : type:%s, reason:%s(), action:%s(), ant_path:%s, init_mode:%s, run_cnt:%d\n",
+		       "[status]",
+		       btc->ant_type == BTC_ANT_SHARED ? "shared" : "dedicated",
+		       steps_to_str(dm->run_reason),
+		       steps_to_str(dm->run_action | BTC_ACT_EXT_BIT),
+		       id_to_ant(FIELD_GET(GENMASK(7, 0), dm->set_ant_path)),
+		       id_to_mode(wl->coex_mode),
+		       dm->cnt_dm[BTC_DCNT_RUN]);
 
-	_show_dm_step(rtwdev, m);
+	p += _show_dm_step(rtwdev, p, end - p);
 
 	if (ver->fcxctrl == 7)
 		igno_bt = btc->ctrl.ctrl_v7.igno_bt;
 	else
 		igno_bt = btc->ctrl.ctrl.igno_bt;
 
-	seq_printf(m, " %-15s : wl_only:%d, bt_only:%d, igno_bt:%d, free_run:%d, wl_ps_ctrl:%d, wl_mimo_ps:%d, ",
-		   "[dm_flag]", dm->wl_only, dm->bt_only, igno_bt,
-		   dm->freerun, btc->lps, dm->wl_mimo_ps);
+	p += scnprintf(p, end - p,
+		       " %-15s : wl_only:%d, bt_only:%d, igno_bt:%d, free_run:%d, wl_ps_ctrl:%d, wl_mimo_ps:%d, ",
+		       "[dm_flag]", dm->wl_only, dm->bt_only, igno_bt,
+		       dm->freerun, btc->lps, dm->wl_mimo_ps);
 
-	seq_printf(m, "leak_ap:%d, fw_offload:%s%s\n", dm->leak_ap,
-		   (BTC_CX_FW_OFFLOAD ? "Y" : "N"),
-		   (dm->wl_fw_cx_offload == BTC_CX_FW_OFFLOAD ?
-		    "" : "(Mismatch!!)"));
+	p += scnprintf(p, end - p, "leak_ap:%d, fw_offload:%s%s\n",
+		       dm->leak_ap,
+		       (BTC_CX_FW_OFFLOAD ? "Y" : "N"),
+		       (dm->wl_fw_cx_offload == BTC_CX_FW_OFFLOAD ?
+			"" : "(Mismatch!!)"));
 
 	if (dm->rf_trx_para.wl_tx_power == 0xff)
-		seq_printf(m,
-			   " %-15s : wl_rssi_lvl:%d, para_lvl:%d, wl_tx_pwr:orig, ",
-			   "[trx_ctrl]", wl->rssi_level, dm->trx_para_level);
+		p += scnprintf(p, end - p,
+			       " %-15s : wl_rssi_lvl:%d, para_lvl:%d, wl_tx_pwr:orig, ",
+			       "[trx_ctrl]", wl->rssi_level,
+			       dm->trx_para_level);
 
 	else
-		seq_printf(m,
-			   " %-15s : wl_rssi_lvl:%d, para_lvl:%d, wl_tx_pwr:%d, ",
-			   "[trx_ctrl]", wl->rssi_level, dm->trx_para_level,
-			   dm->rf_trx_para.wl_tx_power);
+		p += scnprintf(p, end - p,
+			       " %-15s : wl_rssi_lvl:%d, para_lvl:%d, wl_tx_pwr:%d, ",
+			       "[trx_ctrl]", wl->rssi_level,
+			       dm->trx_para_level,
+			       dm->rf_trx_para.wl_tx_power);
+
+	p += scnprintf(p, end - p,
+		       "wl_rx_lvl:%d, bt_tx_pwr_dec:%d, bt_rx_lna:%d(%s-tbl), wl_btg_rx:%d\n",
+		       dm->rf_trx_para.wl_rx_gain,
+		       dm->rf_trx_para.bt_tx_power,
+		       dm->rf_trx_para.bt_rx_gain,
+		       (bt->hi_lna_rx ? "Hi" : "Ori"), dm->wl_btg_rx);
 
-	seq_printf(m,
-		   "wl_rx_lvl:%d, bt_tx_pwr_dec:%d, bt_rx_lna:%d(%s-tbl), wl_btg_rx:%d\n",
-		   dm->rf_trx_para.wl_rx_gain, dm->rf_trx_para.bt_tx_power,
-		   dm->rf_trx_para.bt_rx_gain,
-		   (bt->hi_lna_rx ? "Hi" : "Ori"), dm->wl_btg_rx);
+	p += scnprintf(p, end - p,
+		       " %-15s : wl_tx_limit[en:%d/max_t:%dus/max_retry:%d], bt_slot_reg:%d-TU, bt_scan_rx_low_pri:%d\n",
+		       "[dm_ctrl]", dm->wl_tx_limit.enable,
+		       dm->wl_tx_limit.tx_time,
+		       dm->wl_tx_limit.tx_retry, btc->bt_req_len,
+		       bt->scan_rx_low_pri);
 
-	seq_printf(m,
-		   " %-15s : wl_tx_limit[en:%d/max_t:%dus/max_retry:%d], bt_slot_reg:%d-TU, bt_scan_rx_low_pri:%d\n",
-		   "[dm_ctrl]", dm->wl_tx_limit.enable, dm->wl_tx_limit.tx_time,
-		   dm->wl_tx_limit.tx_retry, btc->bt_req_len, bt->scan_rx_low_pri);
+	return p - buf;
 }
 
-static void _show_error(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_error(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	union rtw89_btc_fbtc_cysta_info *pcysta;
+	char *p = buf, *end = buf + bufsz;
 	u32 except_cnt, exception_map;
 
 	pcysta = &pfwinfo->rpt_fbtc_cysta.finfo;
@@ -8982,81 +9031,87 @@ static void _show_error(struct rtw89_dev *rtwdev, struct seq_file *m)
 		except_cnt = pcysta->v7.except_cnt;
 		exception_map = le32_to_cpu(pcysta->v7.except_map);
 	} else {
-		return;
+		return 0;
 	}
 
 	if (pfwinfo->event[BTF_EVNT_BUF_OVERFLOW] == 0 && except_cnt == 0 &&
 	    !pfwinfo->len_mismch && !pfwinfo->fver_mismch)
-		return;
+		return 0;
 
-	seq_printf(m, " %-15s : ", "[error]");
+	p += scnprintf(p, end - p, " %-15s : ", "[error]");
 
 	if (pfwinfo->event[BTF_EVNT_BUF_OVERFLOW]) {
-		seq_printf(m,
-			   "overflow-cnt: %d, ",
-			   pfwinfo->event[BTF_EVNT_BUF_OVERFLOW]);
+		p += scnprintf(p, end - p,
+			       "overflow-cnt: %d, ",
+			       pfwinfo->event[BTF_EVNT_BUF_OVERFLOW]);
 	}
 
 	if (pfwinfo->len_mismch) {
-		seq_printf(m,
-			   "len-mismatch: 0x%x, ",
-			   pfwinfo->len_mismch);
+		p += scnprintf(p, end - p,
+			       "len-mismatch: 0x%x, ",
+			       pfwinfo->len_mismch);
 	}
 
 	if (pfwinfo->fver_mismch) {
-		seq_printf(m,
-			   "fver-mismatch: 0x%x, ",
-			   pfwinfo->fver_mismch);
+		p += scnprintf(p, end - p,
+			       "fver-mismatch: 0x%x, ",
+			       pfwinfo->fver_mismch);
 	}
 
 	/* cycle statistics exceptions */
 	if (exception_map || except_cnt) {
-		seq_printf(m,
-			   "exception-type: 0x%x, exception-cnt = %d",
-			   exception_map, except_cnt);
+		p += scnprintf(p, end - p,
+			       "exception-type: 0x%x, exception-cnt = %d",
+			       exception_map, except_cnt);
 	}
-	seq_puts(m, "\n");
+	p += scnprintf(p, end - p, "\n");
+
+	return p - buf;
 }
 
-static void _show_fbtc_tdma(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_fbtc_tdma(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_fbtc_tdma *t = NULL;
+	char *p = buf, *end = buf + bufsz;
 
 	pcinfo = &pfwinfo->rpt_fbtc_tdma.cinfo;
 	if (!pcinfo->valid)
-		return;
+		return 0;
 
 	if (ver->fcxtdma == 1)
 		t = &pfwinfo->rpt_fbtc_tdma.finfo.v1;
 	else
 		t = &pfwinfo->rpt_fbtc_tdma.finfo.v3.tdma;
 
-	seq_printf(m,
-		   " %-15s : ", "[tdma_policy]");
-	seq_printf(m,
-		   "type:%d, rx_flow_ctrl:%d, tx_pause:%d, ",
-		   (u32)t->type,
-		   t->rxflctrl, t->txpause);
+	p += scnprintf(p, end - p,
+		       " %-15s : ", "[tdma_policy]");
+	p += scnprintf(p, end - p,
+		       "type:%d, rx_flow_ctrl:%d, tx_pause:%d, ",
+		       (u32)t->type,
+		       t->rxflctrl, t->txpause);
+
+	p += scnprintf(p, end - p,
+		       "wl_toggle_n:%d, leak_n:%d, ext_ctrl:%d, ",
+		       t->wtgle_n, t->leak_n, t->ext_ctrl);
 
-	seq_printf(m,
-		   "wl_toggle_n:%d, leak_n:%d, ext_ctrl:%d, ",
-		   t->wtgle_n, t->leak_n, t->ext_ctrl);
+	p += scnprintf(p, end - p,
+		       "policy_type:%d",
+		       (u32)btc->policy_type);
 
-	seq_printf(m,
-		   "policy_type:%d",
-		   (u32)btc->policy_type);
+	p += scnprintf(p, end - p, "\n");
 
-	seq_puts(m, "\n");
+	return p - buf;
 }
 
-static void _show_fbtc_slots(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_fbtc_slots(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
+	char *p = buf, *end = buf + bufsz;
 	u16 dur, cxtype;
 	u32 tbl;
 	u8 i = 0;
@@ -9071,28 +9126,30 @@ static void _show_fbtc_slots(struct rtw89_dev *rtwdev, struct seq_file *m)
 			tbl = le32_to_cpu(dm->slot_now.v7[i].cxtbl);
 			cxtype = le16_to_cpu(dm->slot_now.v7[i].cxtype);
 		} else {
-			return;
+			return 0;
 		}
 
 		if (i % 5 == 0)
-			seq_printf(m,
-				   " %-15s : %5s[%03d/0x%x/%d]",
-				   "[slot_list]",
-				   id_to_slot((u32)i),
-				   dur, tbl, cxtype);
+			p += scnprintf(p, end - p,
+				       " %-15s : %5s[%03d/0x%x/%d]",
+				       "[slot_list]",
+				       id_to_slot((u32)i),
+				       dur, tbl, cxtype);
 		else
-			seq_printf(m,
-				   ", %5s[%03d/0x%x/%d]",
-				   id_to_slot((u32)i),
-				   dur, tbl, cxtype);
+			p += scnprintf(p, end - p,
+				       ", %5s[%03d/0x%x/%d]",
+				       id_to_slot((u32)i),
+				       dur, tbl, cxtype);
 
 		if (i % 5 == 4)
-			seq_puts(m, "\n");
+			p += scnprintf(p, end - p, "\n");
 	}
-	seq_puts(m, "\n");
+	p += scnprintf(p, end - p, "\n");
+
+	return p - buf;
 }
 
-static void _show_fbtc_cysta_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_fbtc_cysta_v2(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
@@ -9101,63 +9158,64 @@ static void _show_fbtc_cysta_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_fbtc_cysta_v2 *pcysta_le32 = NULL;
 	union rtw89_btc_fbtc_rxflct r;
-	u8 i, cnt = 0, slot_pair;
 	u16 cycle, c_begin, c_end, store_index;
+	char *p = buf, *end = buf + bufsz;
+	u8 i, cnt = 0, slot_pair;
 
 	pcinfo = &pfwinfo->rpt_fbtc_cysta.cinfo;
 	if (!pcinfo->valid)
-		return;
+		return 0;
 
 	pcysta_le32 = &pfwinfo->rpt_fbtc_cysta.finfo.v2;
-	seq_printf(m,
-		   " %-15s : cycle:%d, bcn[all:%d/all_ok:%d/bt:%d/bt_ok:%d]",
-		   "[cycle_cnt]",
-		   le16_to_cpu(pcysta_le32->cycles),
-		   le32_to_cpu(pcysta_le32->bcn_cnt[CXBCN_ALL]),
-		   le32_to_cpu(pcysta_le32->bcn_cnt[CXBCN_ALL_OK]),
-		   le32_to_cpu(pcysta_le32->bcn_cnt[CXBCN_BT_SLOT]),
-		   le32_to_cpu(pcysta_le32->bcn_cnt[CXBCN_BT_OK]));
+	p += scnprintf(p, end - p,
+		       " %-15s : cycle:%d, bcn[all:%d/all_ok:%d/bt:%d/bt_ok:%d]",
+		       "[cycle_cnt]",
+		       le16_to_cpu(pcysta_le32->cycles),
+		       le32_to_cpu(pcysta_le32->bcn_cnt[CXBCN_ALL]),
+		       le32_to_cpu(pcysta_le32->bcn_cnt[CXBCN_ALL_OK]),
+		       le32_to_cpu(pcysta_le32->bcn_cnt[CXBCN_BT_SLOT]),
+		       le32_to_cpu(pcysta_le32->bcn_cnt[CXBCN_BT_OK]));
 
 	for (i = 0; i < CXST_MAX; i++) {
 		if (!le32_to_cpu(pcysta_le32->slot_cnt[i]))
 			continue;
-		seq_printf(m, ", %s:%d", id_to_slot((u32)i),
-			   le32_to_cpu(pcysta_le32->slot_cnt[i]));
+		p += scnprintf(p, end - p, ", %s:%d", id_to_slot((u32)i),
+			       le32_to_cpu(pcysta_le32->slot_cnt[i]));
 	}
 
 	if (dm->tdma_now.rxflctrl) {
-		seq_printf(m, ", leak_rx:%d",
-			   le32_to_cpu(pcysta_le32->leakrx_cnt));
+		p += scnprintf(p, end - p, ", leak_rx:%d",
+			       le32_to_cpu(pcysta_le32->leakrx_cnt));
 	}
 
 	if (le32_to_cpu(pcysta_le32->collision_cnt)) {
-		seq_printf(m, ", collision:%d",
-			   le32_to_cpu(pcysta_le32->collision_cnt));
+		p += scnprintf(p, end - p, ", collision:%d",
+			       le32_to_cpu(pcysta_le32->collision_cnt));
 	}
 
 	if (le32_to_cpu(pcysta_le32->skip_cnt)) {
-		seq_printf(m, ", skip:%d",
-			   le32_to_cpu(pcysta_le32->skip_cnt));
-	}
-	seq_puts(m, "\n");
-
-	seq_printf(m, " %-15s : avg_t[wl:%d/bt:%d/lk:%d.%03d]",
-		   "[cycle_time]",
-		   le16_to_cpu(pcysta_le32->tavg_cycle[CXT_WL]),
-		   le16_to_cpu(pcysta_le32->tavg_cycle[CXT_BT]),
-		   le16_to_cpu(pcysta_le32->tavg_lk) / 1000,
-		   le16_to_cpu(pcysta_le32->tavg_lk) % 1000);
-	seq_printf(m, ", max_t[wl:%d/bt:%d/lk:%d.%03d]",
-		   le16_to_cpu(pcysta_le32->tmax_cycle[CXT_WL]),
-		   le16_to_cpu(pcysta_le32->tmax_cycle[CXT_BT]),
-		   le16_to_cpu(pcysta_le32->tmax_lk) / 1000,
-		   le16_to_cpu(pcysta_le32->tmax_lk) % 1000);
-	seq_printf(m, ", maxdiff_t[wl:%d/bt:%d]\n",
-		   le16_to_cpu(pcysta_le32->tmaxdiff_cycle[CXT_WL]),
-		   le16_to_cpu(pcysta_le32->tmaxdiff_cycle[CXT_BT]));
+		p += scnprintf(p, end - p, ", skip:%d",
+			       le32_to_cpu(pcysta_le32->skip_cnt));
+	}
+	p += scnprintf(p, end - p, "\n");
+
+	p += scnprintf(p, end - p, " %-15s : avg_t[wl:%d/bt:%d/lk:%d.%03d]",
+		       "[cycle_time]",
+		       le16_to_cpu(pcysta_le32->tavg_cycle[CXT_WL]),
+		       le16_to_cpu(pcysta_le32->tavg_cycle[CXT_BT]),
+		       le16_to_cpu(pcysta_le32->tavg_lk) / 1000,
+		       le16_to_cpu(pcysta_le32->tavg_lk) % 1000);
+	p += scnprintf(p, end - p, ", max_t[wl:%d/bt:%d/lk:%d.%03d]",
+		       le16_to_cpu(pcysta_le32->tmax_cycle[CXT_WL]),
+		       le16_to_cpu(pcysta_le32->tmax_cycle[CXT_BT]),
+		       le16_to_cpu(pcysta_le32->tmax_lk) / 1000,
+		       le16_to_cpu(pcysta_le32->tmax_lk) % 1000);
+	p += scnprintf(p, end - p, ", maxdiff_t[wl:%d/bt:%d]\n",
+		       le16_to_cpu(pcysta_le32->tmaxdiff_cycle[CXT_WL]),
+		       le16_to_cpu(pcysta_le32->tmaxdiff_cycle[CXT_BT]));
 
 	if (le16_to_cpu(pcysta_le32->cycles) <= 1)
-		return;
+		goto out;
 
 	/* 1 cycle record 1 wl-slot and 1 bt-slot */
 	slot_pair = BTC_CYCLE_SLOT_MAX / 2;
@@ -9174,53 +9232,57 @@ static void _show_fbtc_cysta_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 		store_index = ((cycle - 1) % slot_pair) * 2;
 
 		if (cnt % (BTC_CYCLE_SLOT_MAX / 4) == 1)
-			seq_printf(m,
-				   " %-15s : ->b%02d->w%02d", "[cycle_step]",
-				   le16_to_cpu(pcysta_le32->tslot_cycle[store_index]),
-				   le16_to_cpu(pcysta_le32->tslot_cycle[store_index + 1]));
+			p += scnprintf(p, end - p,
+				       " %-15s : ->b%02d->w%02d",
+				       "[cycle_step]",
+				       le16_to_cpu(pcysta_le32->tslot_cycle[store_index]),
+				       le16_to_cpu(pcysta_le32->tslot_cycle[store_index + 1]));
 		else
-			seq_printf(m,
-				   "->b%02d->w%02d",
-				   le16_to_cpu(pcysta_le32->tslot_cycle[store_index]),
-				   le16_to_cpu(pcysta_le32->tslot_cycle[store_index + 1]));
+			p += scnprintf(p, end - p,
+				       "->b%02d->w%02d",
+				       le16_to_cpu(pcysta_le32->tslot_cycle[store_index]),
+				       le16_to_cpu(pcysta_le32->tslot_cycle[store_index + 1]));
 		if (cnt % (BTC_CYCLE_SLOT_MAX / 4) == 0 || cnt == c_end)
-			seq_puts(m, "\n");
+			p += scnprintf(p, end - p, "\n");
 	}
 
 	if (a2dp->exist) {
-		seq_printf(m,
-			   " %-15s : a2dp_ept:%d, a2dp_late:%d",
-			   "[a2dp_t_sta]",
-			   le16_to_cpu(pcysta_le32->a2dpept),
-			   le16_to_cpu(pcysta_le32->a2dpeptto));
-
-		seq_printf(m,
-			   ", avg_t:%d, max_t:%d",
-			   le16_to_cpu(pcysta_le32->tavg_a2dpept),
-			   le16_to_cpu(pcysta_le32->tmax_a2dpept));
+		p += scnprintf(p, end - p,
+			       " %-15s : a2dp_ept:%d, a2dp_late:%d",
+			       "[a2dp_t_sta]",
+			       le16_to_cpu(pcysta_le32->a2dpept),
+			       le16_to_cpu(pcysta_le32->a2dpeptto));
+
+		p += scnprintf(p, end - p,
+			       ", avg_t:%d, max_t:%d",
+			       le16_to_cpu(pcysta_le32->tavg_a2dpept),
+			       le16_to_cpu(pcysta_le32->tmax_a2dpept));
 		r.val = dm->tdma_now.rxflctrl;
 
 		if (r.type && r.tgln_n) {
-			seq_printf(m,
-				   ", cycle[PSTDMA:%d/TDMA:%d], ",
-				   le16_to_cpu(pcysta_le32->cycles_a2dp[CXT_FLCTRL_ON]),
-				   le16_to_cpu(pcysta_le32->cycles_a2dp[CXT_FLCTRL_OFF]));
-
-			seq_printf(m,
-				   "avg_t[PSTDMA:%d/TDMA:%d], ",
-				   le16_to_cpu(pcysta_le32->tavg_a2dp[CXT_FLCTRL_ON]),
-				   le16_to_cpu(pcysta_le32->tavg_a2dp[CXT_FLCTRL_OFF]));
-
-			seq_printf(m,
-				   "max_t[PSTDMA:%d/TDMA:%d]",
-				   le16_to_cpu(pcysta_le32->tmax_a2dp[CXT_FLCTRL_ON]),
-				   le16_to_cpu(pcysta_le32->tmax_a2dp[CXT_FLCTRL_OFF]));
+			p += scnprintf(p, end - p,
+				       ", cycle[PSTDMA:%d/TDMA:%d], ",
+				       le16_to_cpu(pcysta_le32->cycles_a2dp[CXT_FLCTRL_ON]),
+				       le16_to_cpu(pcysta_le32->cycles_a2dp[CXT_FLCTRL_OFF]));
+
+			p += scnprintf(p, end - p,
+				       "avg_t[PSTDMA:%d/TDMA:%d], ",
+				       le16_to_cpu(pcysta_le32->tavg_a2dp[CXT_FLCTRL_ON]),
+				       le16_to_cpu(pcysta_le32->tavg_a2dp[CXT_FLCTRL_OFF]));
+
+			p += scnprintf(p, end - p,
+				       "max_t[PSTDMA:%d/TDMA:%d]",
+				       le16_to_cpu(pcysta_le32->tmax_a2dp[CXT_FLCTRL_ON]),
+				       le16_to_cpu(pcysta_le32->tmax_a2dp[CXT_FLCTRL_OFF]));
 		}
-		seq_puts(m, "\n");
+		p += scnprintf(p, end - p, "\n");
 	}
+
+out:
+	return p - buf;
 }
 
-static void _show_fbtc_cysta_v3(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_fbtc_cysta_v3(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
@@ -9231,60 +9293,64 @@ static void _show_fbtc_cysta_v3(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_rpt_cmn_info *pcinfo;
 	u8 i, cnt = 0, slot_pair, divide_cnt;
 	u16 cycle, c_begin, c_end, store_index;
+	char *p = buf, *end = buf + bufsz;
 
 	pcinfo = &pfwinfo->rpt_fbtc_cysta.cinfo;
 	if (!pcinfo->valid)
-		return;
+		return 0;
 
 	pcysta = &pfwinfo->rpt_fbtc_cysta.finfo.v3;
-	seq_printf(m,
-		   " %-15s : cycle:%d, bcn[all:%d/all_ok:%d/bt:%d/bt_ok:%d]",
-		   "[cycle_cnt]",
-		   le16_to_cpu(pcysta->cycles),
-		   le32_to_cpu(pcysta->bcn_cnt[CXBCN_ALL]),
-		   le32_to_cpu(pcysta->bcn_cnt[CXBCN_ALL_OK]),
-		   le32_to_cpu(pcysta->bcn_cnt[CXBCN_BT_SLOT]),
-		   le32_to_cpu(pcysta->bcn_cnt[CXBCN_BT_OK]));
+	p += scnprintf(p, end - p,
+		       " %-15s : cycle:%d, bcn[all:%d/all_ok:%d/bt:%d/bt_ok:%d]",
+		       "[cycle_cnt]",
+		       le16_to_cpu(pcysta->cycles),
+		       le32_to_cpu(pcysta->bcn_cnt[CXBCN_ALL]),
+		       le32_to_cpu(pcysta->bcn_cnt[CXBCN_ALL_OK]),
+		       le32_to_cpu(pcysta->bcn_cnt[CXBCN_BT_SLOT]),
+		       le32_to_cpu(pcysta->bcn_cnt[CXBCN_BT_OK]));
 
 	for (i = 0; i < CXST_MAX; i++) {
 		if (!le32_to_cpu(pcysta->slot_cnt[i]))
 			continue;
 
-		seq_printf(m, ", %s:%d", id_to_slot(i),
-			   le32_to_cpu(pcysta->slot_cnt[i]));
+		p += scnprintf(p, end - p, ", %s:%d", id_to_slot(i),
+			       le32_to_cpu(pcysta->slot_cnt[i]));
 	}
 
 	if (dm->tdma_now.rxflctrl)
-		seq_printf(m, ", leak_rx:%d", le32_to_cpu(pcysta->leak_slot.cnt_rximr));
+		p += scnprintf(p, end - p, ", leak_rx:%d",
+			       le32_to_cpu(pcysta->leak_slot.cnt_rximr));
 
 	if (le32_to_cpu(pcysta->collision_cnt))
-		seq_printf(m, ", collision:%d", le32_to_cpu(pcysta->collision_cnt));
+		p += scnprintf(p, end - p, ", collision:%d",
+			       le32_to_cpu(pcysta->collision_cnt));
 
 	if (le32_to_cpu(pcysta->skip_cnt))
-		seq_printf(m, ", skip:%d", le32_to_cpu(pcysta->skip_cnt));
-
-	seq_puts(m, "\n");
-
-	seq_printf(m, " %-15s : avg_t[wl:%d/bt:%d/lk:%d.%03d]",
-		   "[cycle_time]",
-		   le16_to_cpu(pcysta->cycle_time.tavg[CXT_WL]),
-		   le16_to_cpu(pcysta->cycle_time.tavg[CXT_BT]),
-		   le16_to_cpu(pcysta->leak_slot.tavg) / 1000,
-		   le16_to_cpu(pcysta->leak_slot.tavg) % 1000);
-	seq_printf(m,
-		   ", max_t[wl:%d/bt:%d/lk:%d.%03d]",
-		   le16_to_cpu(pcysta->cycle_time.tmax[CXT_WL]),
-		   le16_to_cpu(pcysta->cycle_time.tmax[CXT_BT]),
-		   le16_to_cpu(pcysta->leak_slot.tmax) / 1000,
-		   le16_to_cpu(pcysta->leak_slot.tmax) % 1000);
-	seq_printf(m,
-		   ", maxdiff_t[wl:%d/bt:%d]\n",
-		   le16_to_cpu(pcysta->cycle_time.tmaxdiff[CXT_WL]),
-		   le16_to_cpu(pcysta->cycle_time.tmaxdiff[CXT_BT]));
+		p += scnprintf(p, end - p, ", skip:%d",
+			       le32_to_cpu(pcysta->skip_cnt));
+
+	p += scnprintf(p, end - p, "\n");
+
+	p += scnprintf(p, end - p, " %-15s : avg_t[wl:%d/bt:%d/lk:%d.%03d]",
+		       "[cycle_time]",
+		       le16_to_cpu(pcysta->cycle_time.tavg[CXT_WL]),
+		       le16_to_cpu(pcysta->cycle_time.tavg[CXT_BT]),
+		       le16_to_cpu(pcysta->leak_slot.tavg) / 1000,
+		       le16_to_cpu(pcysta->leak_slot.tavg) % 1000);
+	p += scnprintf(p, end - p,
+		       ", max_t[wl:%d/bt:%d/lk:%d.%03d]",
+		       le16_to_cpu(pcysta->cycle_time.tmax[CXT_WL]),
+		       le16_to_cpu(pcysta->cycle_time.tmax[CXT_BT]),
+		       le16_to_cpu(pcysta->leak_slot.tmax) / 1000,
+		       le16_to_cpu(pcysta->leak_slot.tmax) % 1000);
+	p += scnprintf(p, end - p,
+		       ", maxdiff_t[wl:%d/bt:%d]\n",
+		       le16_to_cpu(pcysta->cycle_time.tmaxdiff[CXT_WL]),
+		       le16_to_cpu(pcysta->cycle_time.tmaxdiff[CXT_BT]));
 
 	cycle = le16_to_cpu(pcysta->cycles);
 	if (cycle <= 1)
-		return;
+		goto out;
 
 	/* 1 cycle record 1 wl-slot and 1 bt-slot */
 	slot_pair = BTC_CYCLE_SLOT_MAX / 2;
@@ -9306,51 +9372,56 @@ static void _show_fbtc_cysta_v3(struct rtw89_dev *rtwdev, struct seq_file *m)
 		store_index = ((cycle - 1) % slot_pair) * 2;
 
 		if (cnt % divide_cnt == 1)
-			seq_printf(m, " %-15s : ", "[cycle_step]");
+			p += scnprintf(p, end - p, " %-15s : ",
+				       "[cycle_step]");
 
-		seq_printf(m, "->b%02d",
-			   le16_to_cpu(pcysta->slot_step_time[store_index]));
+		p += scnprintf(p, end - p, "->b%02d",
+			       le16_to_cpu(pcysta->slot_step_time[store_index]));
 		if (a2dp->exist) {
 			a2dp_trx = &pcysta->a2dp_trx[store_index];
-			seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
-				   a2dp_trx->empty_cnt,
-				   a2dp_trx->retry_cnt,
-				   a2dp_trx->tx_rate ? 3 : 2,
-				   a2dp_trx->tx_cnt,
-				   a2dp_trx->ack_cnt,
-				   a2dp_trx->nack_cnt);
+			p += scnprintf(p, end - p, "(%d/%d/%dM/%d/%d/%d)",
+				       a2dp_trx->empty_cnt,
+				       a2dp_trx->retry_cnt,
+				       a2dp_trx->tx_rate ? 3 : 2,
+				       a2dp_trx->tx_cnt,
+				       a2dp_trx->ack_cnt,
+				       a2dp_trx->nack_cnt);
 		}
-		seq_printf(m, "->w%02d",
-			   le16_to_cpu(pcysta->slot_step_time[store_index + 1]));
+		p += scnprintf(p, end - p, "->w%02d",
+			       le16_to_cpu(pcysta->slot_step_time[store_index + 1]));
 		if (a2dp->exist) {
 			a2dp_trx = &pcysta->a2dp_trx[store_index + 1];
-			seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
-				   a2dp_trx->empty_cnt,
-				   a2dp_trx->retry_cnt,
-				   a2dp_trx->tx_rate ? 3 : 2,
-				   a2dp_trx->tx_cnt,
-				   a2dp_trx->ack_cnt,
-				   a2dp_trx->nack_cnt);
+			p += scnprintf(p, end - p, "(%d/%d/%dM/%d/%d/%d)",
+				       a2dp_trx->empty_cnt,
+				       a2dp_trx->retry_cnt,
+				       a2dp_trx->tx_rate ? 3 : 2,
+				       a2dp_trx->tx_cnt,
+				       a2dp_trx->ack_cnt,
+				       a2dp_trx->nack_cnt);
 		}
 		if (cnt % divide_cnt == 0 || cnt == c_end)
-			seq_puts(m, "\n");
+			p += scnprintf(p, end - p, "\n");
 	}
 
 	if (a2dp->exist) {
-		seq_printf(m, " %-15s : a2dp_ept:%d, a2dp_late:%d",
-			   "[a2dp_t_sta]",
-			   le16_to_cpu(pcysta->a2dp_ept.cnt),
-			   le16_to_cpu(pcysta->a2dp_ept.cnt_timeout));
+		p += scnprintf(p, end - p,
+			       " %-15s : a2dp_ept:%d, a2dp_late:%d",
+			       "[a2dp_t_sta]",
+			       le16_to_cpu(pcysta->a2dp_ept.cnt),
+			       le16_to_cpu(pcysta->a2dp_ept.cnt_timeout));
 
-		seq_printf(m, ", avg_t:%d, max_t:%d",
-			   le16_to_cpu(pcysta->a2dp_ept.tavg),
-			   le16_to_cpu(pcysta->a2dp_ept.tmax));
+		p += scnprintf(p, end - p, ", avg_t:%d, max_t:%d",
+			       le16_to_cpu(pcysta->a2dp_ept.tavg),
+			       le16_to_cpu(pcysta->a2dp_ept.tmax));
 
-		seq_puts(m, "\n");
+		p += scnprintf(p, end - p, "\n");
 	}
+
+out:
+	return p - buf;
 }
 
-static void _show_fbtc_cysta_v4(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_fbtc_cysta_v4(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
@@ -9361,62 +9432,64 @@ static void _show_fbtc_cysta_v4(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_rpt_cmn_info *pcinfo;
 	u8 i, cnt = 0, slot_pair, divide_cnt;
 	u16 cycle, c_begin, c_end, store_index;
+	char *p = buf, *end = buf + bufsz;
 
 	pcinfo = &pfwinfo->rpt_fbtc_cysta.cinfo;
 	if (!pcinfo->valid)
-		return;
+		return 0;
 
 	pcysta = &pfwinfo->rpt_fbtc_cysta.finfo.v4;
-	seq_printf(m,
-		   " %-15s : cycle:%d, bcn[all:%d/all_ok:%d/bt:%d/bt_ok:%d]",
-		   "[cycle_cnt]",
-		   le16_to_cpu(pcysta->cycles),
-		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_ALL]),
-		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_ALL_OK]),
-		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_BT_SLOT]),
-		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_BT_OK]));
+	p += scnprintf(p, end - p,
+		       " %-15s : cycle:%d, bcn[all:%d/all_ok:%d/bt:%d/bt_ok:%d]",
+		       "[cycle_cnt]",
+		       le16_to_cpu(pcysta->cycles),
+		       le16_to_cpu(pcysta->bcn_cnt[CXBCN_ALL]),
+		       le16_to_cpu(pcysta->bcn_cnt[CXBCN_ALL_OK]),
+		       le16_to_cpu(pcysta->bcn_cnt[CXBCN_BT_SLOT]),
+		       le16_to_cpu(pcysta->bcn_cnt[CXBCN_BT_OK]));
 
 	for (i = 0; i < CXST_MAX; i++) {
 		if (!le16_to_cpu(pcysta->slot_cnt[i]))
 			continue;
 
-		seq_printf(m, ", %s:%d", id_to_slot(i),
-			   le16_to_cpu(pcysta->slot_cnt[i]));
+		p += scnprintf(p, end - p, ", %s:%d", id_to_slot(i),
+			       le16_to_cpu(pcysta->slot_cnt[i]));
 	}
 
 	if (dm->tdma_now.rxflctrl)
-		seq_printf(m, ", leak_rx:%d",
-			   le32_to_cpu(pcysta->leak_slot.cnt_rximr));
+		p += scnprintf(p, end - p, ", leak_rx:%d",
+			       le32_to_cpu(pcysta->leak_slot.cnt_rximr));
 
 	if (pcysta->collision_cnt)
-		seq_printf(m, ", collision:%d", pcysta->collision_cnt);
+		p += scnprintf(p, end - p, ", collision:%d",
+			       pcysta->collision_cnt);
 
 	if (le16_to_cpu(pcysta->skip_cnt))
-		seq_printf(m, ", skip:%d",
-			   le16_to_cpu(pcysta->skip_cnt));
-
-	seq_puts(m, "\n");
-
-	seq_printf(m, " %-15s : avg_t[wl:%d/bt:%d/lk:%d.%03d]",
-		   "[cycle_time]",
-		   le16_to_cpu(pcysta->cycle_time.tavg[CXT_WL]),
-		   le16_to_cpu(pcysta->cycle_time.tavg[CXT_BT]),
-		   le16_to_cpu(pcysta->leak_slot.tavg) / 1000,
-		   le16_to_cpu(pcysta->leak_slot.tavg) % 1000);
-	seq_printf(m,
-		   ", max_t[wl:%d/bt:%d/lk:%d.%03d]",
-		   le16_to_cpu(pcysta->cycle_time.tmax[CXT_WL]),
-		   le16_to_cpu(pcysta->cycle_time.tmax[CXT_BT]),
-		   le16_to_cpu(pcysta->leak_slot.tmax) / 1000,
-		   le16_to_cpu(pcysta->leak_slot.tmax) % 1000);
-	seq_printf(m,
-		   ", maxdiff_t[wl:%d/bt:%d]\n",
-		   le16_to_cpu(pcysta->cycle_time.tmaxdiff[CXT_WL]),
-		   le16_to_cpu(pcysta->cycle_time.tmaxdiff[CXT_BT]));
+		p += scnprintf(p, end - p, ", skip:%d",
+			       le16_to_cpu(pcysta->skip_cnt));
+
+	p += scnprintf(p, end - p, "\n");
+
+	p += scnprintf(p, end - p, " %-15s : avg_t[wl:%d/bt:%d/lk:%d.%03d]",
+		       "[cycle_time]",
+		       le16_to_cpu(pcysta->cycle_time.tavg[CXT_WL]),
+		       le16_to_cpu(pcysta->cycle_time.tavg[CXT_BT]),
+		       le16_to_cpu(pcysta->leak_slot.tavg) / 1000,
+		       le16_to_cpu(pcysta->leak_slot.tavg) % 1000);
+	p += scnprintf(p, end - p,
+		       ", max_t[wl:%d/bt:%d/lk:%d.%03d]",
+		       le16_to_cpu(pcysta->cycle_time.tmax[CXT_WL]),
+		       le16_to_cpu(pcysta->cycle_time.tmax[CXT_BT]),
+		       le16_to_cpu(pcysta->leak_slot.tmax) / 1000,
+		       le16_to_cpu(pcysta->leak_slot.tmax) % 1000);
+	p += scnprintf(p, end - p,
+		       ", maxdiff_t[wl:%d/bt:%d]\n",
+		       le16_to_cpu(pcysta->cycle_time.tmaxdiff[CXT_WL]),
+		       le16_to_cpu(pcysta->cycle_time.tmaxdiff[CXT_BT]));
 
 	cycle = le16_to_cpu(pcysta->cycles);
 	if (cycle <= 1)
-		return;
+		goto out;
 
 	/* 1 cycle record 1 wl-slot and 1 bt-slot */
 	slot_pair = BTC_CYCLE_SLOT_MAX / 2;
@@ -9438,51 +9511,56 @@ static void _show_fbtc_cysta_v4(struct rtw89_dev *rtwdev, struct seq_file *m)
 		store_index = ((cycle - 1) % slot_pair) * 2;
 
 		if (cnt % divide_cnt == 1)
-			seq_printf(m, " %-15s : ", "[cycle_step]");
+			p += scnprintf(p, end - p, " %-15s : ",
+				       "[cycle_step]");
 
-		seq_printf(m, "->b%02d",
-			   le16_to_cpu(pcysta->slot_step_time[store_index]));
+		p += scnprintf(p, end - p, "->b%02d",
+			       le16_to_cpu(pcysta->slot_step_time[store_index]));
 		if (a2dp->exist) {
 			a2dp_trx = &pcysta->a2dp_trx[store_index];
-			seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
-				   a2dp_trx->empty_cnt,
-				   a2dp_trx->retry_cnt,
-				   a2dp_trx->tx_rate ? 3 : 2,
-				   a2dp_trx->tx_cnt,
-				   a2dp_trx->ack_cnt,
-				   a2dp_trx->nack_cnt);
+			p += scnprintf(p, end - p, "(%d/%d/%dM/%d/%d/%d)",
+				       a2dp_trx->empty_cnt,
+				       a2dp_trx->retry_cnt,
+				       a2dp_trx->tx_rate ? 3 : 2,
+				       a2dp_trx->tx_cnt,
+				       a2dp_trx->ack_cnt,
+				       a2dp_trx->nack_cnt);
 		}
-		seq_printf(m, "->w%02d",
-			   le16_to_cpu(pcysta->slot_step_time[store_index + 1]));
+		p += scnprintf(p, end - p, "->w%02d",
+			       le16_to_cpu(pcysta->slot_step_time[store_index + 1]));
 		if (a2dp->exist) {
 			a2dp_trx = &pcysta->a2dp_trx[store_index + 1];
-			seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
-				   a2dp_trx->empty_cnt,
-				   a2dp_trx->retry_cnt,
-				   a2dp_trx->tx_rate ? 3 : 2,
-				   a2dp_trx->tx_cnt,
-				   a2dp_trx->ack_cnt,
-				   a2dp_trx->nack_cnt);
+			p += scnprintf(p, end - p, "(%d/%d/%dM/%d/%d/%d)",
+				       a2dp_trx->empty_cnt,
+				       a2dp_trx->retry_cnt,
+				       a2dp_trx->tx_rate ? 3 : 2,
+				       a2dp_trx->tx_cnt,
+				       a2dp_trx->ack_cnt,
+				       a2dp_trx->nack_cnt);
 		}
 		if (cnt % divide_cnt == 0 || cnt == c_end)
-			seq_puts(m, "\n");
+			p += scnprintf(p, end - p, "\n");
 	}
 
 	if (a2dp->exist) {
-		seq_printf(m, " %-15s : a2dp_ept:%d, a2dp_late:%d",
-			   "[a2dp_t_sta]",
-			   le16_to_cpu(pcysta->a2dp_ept.cnt),
-			   le16_to_cpu(pcysta->a2dp_ept.cnt_timeout));
+		p += scnprintf(p, end - p,
+			       " %-15s : a2dp_ept:%d, a2dp_late:%d",
+			       "[a2dp_t_sta]",
+			       le16_to_cpu(pcysta->a2dp_ept.cnt),
+			       le16_to_cpu(pcysta->a2dp_ept.cnt_timeout));
 
-		seq_printf(m, ", avg_t:%d, max_t:%d",
-			   le16_to_cpu(pcysta->a2dp_ept.tavg),
-			   le16_to_cpu(pcysta->a2dp_ept.tmax));
+		p += scnprintf(p, end - p, ", avg_t:%d, max_t:%d",
+			       le16_to_cpu(pcysta->a2dp_ept.tavg),
+			       le16_to_cpu(pcysta->a2dp_ept.tmax));
 
-		seq_puts(m, "\n");
+		p += scnprintf(p, end - p, "\n");
 	}
+
+out:
+	return p - buf;
 }
 
-static void _show_fbtc_cysta_v5(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_fbtc_cysta_v5(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
@@ -9493,58 +9571,60 @@ static void _show_fbtc_cysta_v5(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_rpt_cmn_info *pcinfo;
 	u8 i, cnt = 0, slot_pair, divide_cnt;
 	u16 cycle, c_begin, c_end, store_index;
+	char *p = buf, *end = buf + bufsz;
 
 	pcinfo = &pfwinfo->rpt_fbtc_cysta.cinfo;
 	if (!pcinfo->valid)
-		return;
+		return 0;
 
 	pcysta = &pfwinfo->rpt_fbtc_cysta.finfo.v5;
-	seq_printf(m,
-		   " %-15s : cycle:%d, bcn[all:%d/all_ok:%d/bt:%d/bt_ok:%d]",
-		   "[cycle_cnt]",
-		   le16_to_cpu(pcysta->cycles),
-		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_ALL]),
-		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_ALL_OK]),
-		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_BT_SLOT]),
-		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_BT_OK]));
+	p += scnprintf(p, end - p,
+		       " %-15s : cycle:%d, bcn[all:%d/all_ok:%d/bt:%d/bt_ok:%d]",
+		       "[cycle_cnt]",
+		       le16_to_cpu(pcysta->cycles),
+		       le16_to_cpu(pcysta->bcn_cnt[CXBCN_ALL]),
+		       le16_to_cpu(pcysta->bcn_cnt[CXBCN_ALL_OK]),
+		       le16_to_cpu(pcysta->bcn_cnt[CXBCN_BT_SLOT]),
+		       le16_to_cpu(pcysta->bcn_cnt[CXBCN_BT_OK]));
 
 	for (i = 0; i < CXST_MAX; i++) {
 		if (!le16_to_cpu(pcysta->slot_cnt[i]))
 			continue;
 
-		seq_printf(m, ", %s:%d", id_to_slot(i),
-			   le16_to_cpu(pcysta->slot_cnt[i]));
+		p += scnprintf(p, end - p, ", %s:%d", id_to_slot(i),
+			       le16_to_cpu(pcysta->slot_cnt[i]));
 	}
 
 	if (dm->tdma_now.rxflctrl)
-		seq_printf(m, ", leak_rx:%d",
-			   le32_to_cpu(pcysta->leak_slot.cnt_rximr));
+		p += scnprintf(p, end - p, ", leak_rx:%d",
+			       le32_to_cpu(pcysta->leak_slot.cnt_rximr));
 
 	if (pcysta->collision_cnt)
-		seq_printf(m, ", collision:%d", pcysta->collision_cnt);
+		p += scnprintf(p, end - p, ", collision:%d",
+			       pcysta->collision_cnt);
 
 	if (le16_to_cpu(pcysta->skip_cnt))
-		seq_printf(m, ", skip:%d",
-			   le16_to_cpu(pcysta->skip_cnt));
-
-	seq_puts(m, "\n");
-
-	seq_printf(m, " %-15s : avg_t[wl:%d/bt:%d/lk:%d.%03d]",
-		   "[cycle_time]",
-		   le16_to_cpu(pcysta->cycle_time.tavg[CXT_WL]),
-		   le16_to_cpu(pcysta->cycle_time.tavg[CXT_BT]),
-		   le16_to_cpu(pcysta->leak_slot.tavg) / 1000,
-		   le16_to_cpu(pcysta->leak_slot.tavg) % 1000);
-	seq_printf(m,
-		   ", max_t[wl:%d/bt:%d/lk:%d.%03d]\n",
-		   le16_to_cpu(pcysta->cycle_time.tmax[CXT_WL]),
-		   le16_to_cpu(pcysta->cycle_time.tmax[CXT_BT]),
-		   le16_to_cpu(pcysta->leak_slot.tmax) / 1000,
-		   le16_to_cpu(pcysta->leak_slot.tmax) % 1000);
+		p += scnprintf(p, end - p, ", skip:%d",
+			       le16_to_cpu(pcysta->skip_cnt));
+
+	p += scnprintf(p, end - p, "\n");
+
+	p += scnprintf(p, end - p, " %-15s : avg_t[wl:%d/bt:%d/lk:%d.%03d]",
+		       "[cycle_time]",
+		       le16_to_cpu(pcysta->cycle_time.tavg[CXT_WL]),
+		       le16_to_cpu(pcysta->cycle_time.tavg[CXT_BT]),
+		       le16_to_cpu(pcysta->leak_slot.tavg) / 1000,
+		       le16_to_cpu(pcysta->leak_slot.tavg) % 1000);
+	p += scnprintf(p, end - p,
+		       ", max_t[wl:%d/bt:%d/lk:%d.%03d]\n",
+		       le16_to_cpu(pcysta->cycle_time.tmax[CXT_WL]),
+		       le16_to_cpu(pcysta->cycle_time.tmax[CXT_BT]),
+		       le16_to_cpu(pcysta->leak_slot.tmax) / 1000,
+		       le16_to_cpu(pcysta->leak_slot.tmax) % 1000);
 
 	cycle = le16_to_cpu(pcysta->cycles);
 	if (cycle <= 1)
-		return;
+		goto out;
 
 	/* 1 cycle record 1 wl-slot and 1 bt-slot */
 	slot_pair = BTC_CYCLE_SLOT_MAX / 2;
@@ -9562,58 +9642,63 @@ static void _show_fbtc_cysta_v5(struct rtw89_dev *rtwdev, struct seq_file *m)
 		divide_cnt = BTC_CYCLE_SLOT_MAX / 4;
 
 	if (c_begin > c_end)
-		return;
+		goto out;
 
 	for (cycle = c_begin; cycle <= c_end; cycle++) {
 		cnt++;
 		store_index = ((cycle - 1) % slot_pair) * 2;
 
 		if (cnt % divide_cnt == 1)
-			seq_printf(m, " %-15s : ", "[cycle_step]");
+			p += scnprintf(p, end - p, " %-15s : ",
+				       "[cycle_step]");
 
-		seq_printf(m, "->b%02d",
-			   le16_to_cpu(pcysta->slot_step_time[store_index]));
+		p += scnprintf(p, end - p, "->b%02d",
+			       le16_to_cpu(pcysta->slot_step_time[store_index]));
 		if (a2dp->exist) {
 			a2dp_trx = &pcysta->a2dp_trx[store_index];
-			seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
-				   a2dp_trx->empty_cnt,
-				   a2dp_trx->retry_cnt,
-				   a2dp_trx->tx_rate ? 3 : 2,
-				   a2dp_trx->tx_cnt,
-				   a2dp_trx->ack_cnt,
-				   a2dp_trx->nack_cnt);
+			p += scnprintf(p, end - p, "(%d/%d/%dM/%d/%d/%d)",
+				       a2dp_trx->empty_cnt,
+				       a2dp_trx->retry_cnt,
+				       a2dp_trx->tx_rate ? 3 : 2,
+				       a2dp_trx->tx_cnt,
+				       a2dp_trx->ack_cnt,
+				       a2dp_trx->nack_cnt);
 		}
-		seq_printf(m, "->w%02d",
-			   le16_to_cpu(pcysta->slot_step_time[store_index + 1]));
+		p += scnprintf(p, end - p, "->w%02d",
+			       le16_to_cpu(pcysta->slot_step_time[store_index + 1]));
 		if (a2dp->exist) {
 			a2dp_trx = &pcysta->a2dp_trx[store_index + 1];
-			seq_printf(m, "(%d/%d/%dM/%d/%d/%d)",
-				   a2dp_trx->empty_cnt,
-				   a2dp_trx->retry_cnt,
-				   a2dp_trx->tx_rate ? 3 : 2,
-				   a2dp_trx->tx_cnt,
-				   a2dp_trx->ack_cnt,
-				   a2dp_trx->nack_cnt);
+			p += scnprintf(p, end - p, "(%d/%d/%dM/%d/%d/%d)",
+				       a2dp_trx->empty_cnt,
+				       a2dp_trx->retry_cnt,
+				       a2dp_trx->tx_rate ? 3 : 2,
+				       a2dp_trx->tx_cnt,
+				       a2dp_trx->ack_cnt,
+				       a2dp_trx->nack_cnt);
 		}
 		if (cnt % divide_cnt == 0 || cnt == c_end)
-			seq_puts(m, "\n");
+			p += scnprintf(p, end - p, "\n");
 	}
 
 	if (a2dp->exist) {
-		seq_printf(m, " %-15s : a2dp_ept:%d, a2dp_late:%d",
-			   "[a2dp_t_sta]",
-			   le16_to_cpu(pcysta->a2dp_ept.cnt),
-			   le16_to_cpu(pcysta->a2dp_ept.cnt_timeout));
+		p += scnprintf(p, end - p,
+			       " %-15s : a2dp_ept:%d, a2dp_late:%d",
+			       "[a2dp_t_sta]",
+			       le16_to_cpu(pcysta->a2dp_ept.cnt),
+			       le16_to_cpu(pcysta->a2dp_ept.cnt_timeout));
 
-		seq_printf(m, ", avg_t:%d, max_t:%d",
-			   le16_to_cpu(pcysta->a2dp_ept.tavg),
-			   le16_to_cpu(pcysta->a2dp_ept.tmax));
+		p += scnprintf(p, end - p, ", avg_t:%d, max_t:%d",
+			       le16_to_cpu(pcysta->a2dp_ept.tavg),
+			       le16_to_cpu(pcysta->a2dp_ept.tmax));
 
-		seq_puts(m, "\n");
+		p += scnprintf(p, end - p, "\n");
 	}
+
+out:
+	return p - buf;
 }
 
-static void _show_fbtc_cysta_v7(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_fbtc_cysta_v7(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc_bt_info *bt = &rtwdev->btc.cx.bt;
 	struct rtw89_btc_bt_a2dp_desc *a2dp = &bt->link_info.a2dp_desc;
@@ -9621,68 +9706,75 @@ static void _show_fbtc_cysta_v7(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_fbtc_cysta_v7 *pcysta = NULL;
 	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
 	struct rtw89_btc_rpt_cmn_info *pcinfo;
+	char *p = buf, *end = buf + bufsz;
 	u16 cycle, c_begin, c_end, s_id;
 	u8 i, cnt = 0, divide_cnt;
 	u8 slot_pair;
 
 	pcinfo = &pfwinfo->rpt_fbtc_cysta.cinfo;
 	if (!pcinfo->valid)
-		return;
+		return 0;
 
 	pcysta = &pfwinfo->rpt_fbtc_cysta.finfo.v7;
-	seq_printf(m, "\n\r %-15s : cycle:%d", "[slot_stat]",
-		   le16_to_cpu(pcysta->cycles));
+	p += scnprintf(p, end - p, "\n\r %-15s : cycle:%d", "[slot_stat]",
+		       le16_to_cpu(pcysta->cycles));
 
 	for (i = 0; i < CXST_MAX; i++) {
 		if (!le16_to_cpu(pcysta->slot_cnt[i]))
 			continue;
-		seq_printf(m, ", %s:%d",
-			   id_to_slot(i), le16_to_cpu(pcysta->slot_cnt[i]));
+		p += scnprintf(p, end - p, ", %s:%d",
+			       id_to_slot(i),
+			       le16_to_cpu(pcysta->slot_cnt[i]));
 	}
 
 	if (dm->tdma_now.rxflctrl)
-		seq_printf(m, ", leak_rx:%d",
-			   le32_to_cpu(pcysta->leak_slot.cnt_rximr));
+		p += scnprintf(p, end - p, ", leak_rx:%d",
+			       le32_to_cpu(pcysta->leak_slot.cnt_rximr));
 
 	if (pcysta->collision_cnt)
-		seq_printf(m, ", collision:%d", pcysta->collision_cnt);
+		p += scnprintf(p, end - p, ", collision:%d",
+			       pcysta->collision_cnt);
 
 	if (pcysta->skip_cnt)
-		seq_printf(m, ", skip:%d", le16_to_cpu(pcysta->skip_cnt));
-
-	seq_printf(m, "\n\r %-15s : avg_t[wl:%d/bt:%d/lk:%d.%03d]",
-		   "[cycle_stat]",
-		   le16_to_cpu(pcysta->cycle_time.tavg[CXT_WL]),
-		   le16_to_cpu(pcysta->cycle_time.tavg[CXT_BT]),
-		   le16_to_cpu(pcysta->leak_slot.tavg) / 1000,
-		   le16_to_cpu(pcysta->leak_slot.tavg) % 1000);
-	seq_printf(m, ", max_t[wl:%d/bt:%d(>%dms:%d)/lk:%d.%03d]",
-		   le16_to_cpu(pcysta->cycle_time.tmax[CXT_WL]),
-		   le16_to_cpu(pcysta->cycle_time.tmax[CXT_BT]),
-		   dm->bt_slot_flood, dm->cnt_dm[BTC_DCNT_BT_SLOT_FLOOD],
-		   le16_to_cpu(pcysta->leak_slot.tamx) / 1000,
-		   le16_to_cpu(pcysta->leak_slot.tamx) % 1000);
-	seq_printf(m, ", bcn[all:%d/ok:%d/in_bt:%d/in_bt_ok:%d]",
-		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_ALL]),
-		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_ALL_OK]),
-		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_BT_SLOT]),
-		   le16_to_cpu(pcysta->bcn_cnt[CXBCN_BT_OK]));
+		p += scnprintf(p, end - p, ", skip:%d",
+			       le16_to_cpu(pcysta->skip_cnt));
+
+	p += scnprintf(p, end - p,
+		       "\n\r %-15s : avg_t[wl:%d/bt:%d/lk:%d.%03d]",
+		       "[cycle_stat]",
+		       le16_to_cpu(pcysta->cycle_time.tavg[CXT_WL]),
+		       le16_to_cpu(pcysta->cycle_time.tavg[CXT_BT]),
+		       le16_to_cpu(pcysta->leak_slot.tavg) / 1000,
+		       le16_to_cpu(pcysta->leak_slot.tavg) % 1000);
+	p += scnprintf(p, end - p,
+		       ", max_t[wl:%d/bt:%d(>%dms:%d)/lk:%d.%03d]",
+		       le16_to_cpu(pcysta->cycle_time.tmax[CXT_WL]),
+		       le16_to_cpu(pcysta->cycle_time.tmax[CXT_BT]),
+		       dm->bt_slot_flood, dm->cnt_dm[BTC_DCNT_BT_SLOT_FLOOD],
+		       le16_to_cpu(pcysta->leak_slot.tamx) / 1000,
+		       le16_to_cpu(pcysta->leak_slot.tamx) % 1000);
+	p += scnprintf(p, end - p, ", bcn[all:%d/ok:%d/in_bt:%d/in_bt_ok:%d]",
+		       le16_to_cpu(pcysta->bcn_cnt[CXBCN_ALL]),
+		       le16_to_cpu(pcysta->bcn_cnt[CXBCN_ALL_OK]),
+		       le16_to_cpu(pcysta->bcn_cnt[CXBCN_BT_SLOT]),
+		       le16_to_cpu(pcysta->bcn_cnt[CXBCN_BT_OK]));
 
 	if (a2dp->exist) {
-		seq_printf(m,
-			   "\n\r %-15s : a2dp_ept:%d, a2dp_late:%d(streak 2S:%d/max:%d)",
-			   "[a2dp_stat]",
-			   le16_to_cpu(pcysta->a2dp_ept.cnt),
-			   le16_to_cpu(pcysta->a2dp_ept.cnt_timeout),
-			   a2dp->no_empty_streak_2s, a2dp->no_empty_streak_max);
+		p += scnprintf(p, end - p,
+			       "\n\r %-15s : a2dp_ept:%d, a2dp_late:%d(streak 2S:%d/max:%d)",
+			       "[a2dp_stat]",
+			       le16_to_cpu(pcysta->a2dp_ept.cnt),
+			       le16_to_cpu(pcysta->a2dp_ept.cnt_timeout),
+			       a2dp->no_empty_streak_2s,
+			       a2dp->no_empty_streak_max);
 
-		seq_printf(m, ", avg_t:%d, max_t:%d",
-			   le16_to_cpu(pcysta->a2dp_ept.tavg),
-			   le16_to_cpu(pcysta->a2dp_ept.tmax));
+		p += scnprintf(p, end - p, ", avg_t:%d, max_t:%d",
+			       le16_to_cpu(pcysta->a2dp_ept.tavg),
+			       le16_to_cpu(pcysta->a2dp_ept.tmax));
 	}
 
 	if (le16_to_cpu(pcysta->cycles) <= 1)
-		return;
+		goto out;
 
 	/* 1 cycle = 1 wl-slot + 1 bt-slot */
 	slot_pair = BTC_CYCLE_SLOT_MAX / 2;
@@ -9700,7 +9792,7 @@ static void _show_fbtc_cysta_v7(struct rtw89_dev *rtwdev, struct seq_file *m)
 		divide_cnt = 6;
 
 	if (c_begin > c_end)
-		return;
+		goto out;
 
 	for (cycle = c_begin; cycle <= c_end; cycle++) {
 		cnt++;
@@ -9708,129 +9800,142 @@ static void _show_fbtc_cysta_v7(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 		if (cnt % divide_cnt == 1) {
 			if (a2dp->exist)
-				seq_printf(m, "\n\r %-15s : ", "[slotT_wermtan]");
+				p += scnprintf(p, end - p, "\n\r %-15s : ",
+					       "[slotT_wermtan]");
 			else
-				seq_printf(m, "\n\r %-15s : ", "[slotT_rxerr]");
+				p += scnprintf(p, end - p, "\n\r %-15s : ",
+					       "[slotT_rxerr]");
 		}
 
-		seq_printf(m, "->b%d", le16_to_cpu(pcysta->slot_step_time[s_id]));
+		p += scnprintf(p, end - p, "->b%d",
+			       le16_to_cpu(pcysta->slot_step_time[s_id]));
 
 		if (a2dp->exist)
-			seq_printf(m, "(%d/%d/%d/%dM/%d/%d/%d)",
-				   pcysta->wl_rx_err_ratio[s_id],
-				   pcysta->a2dp_trx[s_id].empty_cnt,
-				   pcysta->a2dp_trx[s_id].retry_cnt,
-				   (pcysta->a2dp_trx[s_id].tx_rate ? 3 : 2),
-				   pcysta->a2dp_trx[s_id].tx_cnt,
-				   pcysta->a2dp_trx[s_id].ack_cnt,
-				   pcysta->a2dp_trx[s_id].nack_cnt);
+			p += scnprintf(p, end - p, "(%d/%d/%d/%dM/%d/%d/%d)",
+				       pcysta->wl_rx_err_ratio[s_id],
+				       pcysta->a2dp_trx[s_id].empty_cnt,
+				       pcysta->a2dp_trx[s_id].retry_cnt,
+				       (pcysta->a2dp_trx[s_id].tx_rate ? 3 : 2),
+				       pcysta->a2dp_trx[s_id].tx_cnt,
+				       pcysta->a2dp_trx[s_id].ack_cnt,
+				       pcysta->a2dp_trx[s_id].nack_cnt);
 		else
-			seq_printf(m, "(%d)", pcysta->wl_rx_err_ratio[s_id]);
+			p += scnprintf(p, end - p, "(%d)",
+				       pcysta->wl_rx_err_ratio[s_id]);
 
-		seq_printf(m, "->w%d", le16_to_cpu(pcysta->slot_step_time[s_id + 1]));
+		p += scnprintf(p, end - p, "->w%d",
+			       le16_to_cpu(pcysta->slot_step_time[s_id + 1]));
 
 		if (a2dp->exist)
-			seq_printf(m, "(%d/%d/%d/%dM/%d/%d/%d)",
-				   pcysta->wl_rx_err_ratio[s_id + 1],
-				   pcysta->a2dp_trx[s_id + 1].empty_cnt,
-				   pcysta->a2dp_trx[s_id + 1].retry_cnt,
-				   (pcysta->a2dp_trx[s_id + 1].tx_rate ? 3 : 2),
-				   pcysta->a2dp_trx[s_id + 1].tx_cnt,
-				   pcysta->a2dp_trx[s_id + 1].ack_cnt,
-				   pcysta->a2dp_trx[s_id + 1].nack_cnt);
+			p += scnprintf(p, end - p, "(%d/%d/%d/%dM/%d/%d/%d)",
+				       pcysta->wl_rx_err_ratio[s_id + 1],
+				       pcysta->a2dp_trx[s_id + 1].empty_cnt,
+				       pcysta->a2dp_trx[s_id + 1].retry_cnt,
+				       (pcysta->a2dp_trx[s_id + 1].tx_rate ? 3 : 2),
+				       pcysta->a2dp_trx[s_id + 1].tx_cnt,
+				       pcysta->a2dp_trx[s_id + 1].ack_cnt,
+				       pcysta->a2dp_trx[s_id + 1].nack_cnt);
 		else
-			seq_printf(m, "(%d)", pcysta->wl_rx_err_ratio[s_id + 1]);
+			p += scnprintf(p, end - p, "(%d)",
+				       pcysta->wl_rx_err_ratio[s_id + 1]);
 	}
+
+out:
+	return p - buf;
 }
 
-static void _show_fbtc_nullsta(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_fbtc_nullsta(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_rpt_cmn_info *pcinfo;
 	union rtw89_btc_fbtc_cynullsta_info *ns;
+	char *p = buf, *end = buf + bufsz;
 	u8 i = 0;
 
 	if (!btc->dm.tdma_now.rxflctrl)
-		return;
+		return 0;
 
 	pcinfo = &pfwinfo->rpt_fbtc_nullsta.cinfo;
 	if (!pcinfo->valid)
-		return;
+		return 0;
 
 	ns = &pfwinfo->rpt_fbtc_nullsta.finfo;
 	if (ver->fcxnullsta == 1) {
 		for (i = 0; i < 2; i++) {
-			seq_printf(m, " %-15s : ", "[NULL-STA]");
-			seq_printf(m, "null-%d", i);
-			seq_printf(m, "[ok:%d/",
-				   le32_to_cpu(ns->v1.result[i][1]));
-			seq_printf(m, "fail:%d/",
-				   le32_to_cpu(ns->v1.result[i][0]));
-			seq_printf(m, "on_time:%d/",
-				   le32_to_cpu(ns->v1.result[i][2]));
-			seq_printf(m, "retry:%d/",
-				   le32_to_cpu(ns->v1.result[i][3]));
-			seq_printf(m, "avg_t:%d.%03d/",
-				   le32_to_cpu(ns->v1.avg_t[i]) / 1000,
-				   le32_to_cpu(ns->v1.avg_t[i]) % 1000);
-			seq_printf(m, "max_t:%d.%03d]\n",
-				   le32_to_cpu(ns->v1.max_t[i]) / 1000,
-				   le32_to_cpu(ns->v1.max_t[i]) % 1000);
+			p += scnprintf(p, end - p, " %-15s : ", "[NULL-STA]");
+			p += scnprintf(p, end - p, "null-%d", i);
+			p += scnprintf(p, end - p, "[ok:%d/",
+				       le32_to_cpu(ns->v1.result[i][1]));
+			p += scnprintf(p, end - p, "fail:%d/",
+				       le32_to_cpu(ns->v1.result[i][0]));
+			p += scnprintf(p, end - p, "on_time:%d/",
+				       le32_to_cpu(ns->v1.result[i][2]));
+			p += scnprintf(p, end - p, "retry:%d/",
+				       le32_to_cpu(ns->v1.result[i][3]));
+			p += scnprintf(p, end - p, "avg_t:%d.%03d/",
+				       le32_to_cpu(ns->v1.avg_t[i]) / 1000,
+				       le32_to_cpu(ns->v1.avg_t[i]) % 1000);
+			p += scnprintf(p, end - p, "max_t:%d.%03d]\n",
+				       le32_to_cpu(ns->v1.max_t[i]) / 1000,
+				       le32_to_cpu(ns->v1.max_t[i]) % 1000);
 		}
 	} else if (ver->fcxnullsta == 7) {
 		for (i = 0; i < 2; i++) {
-			seq_printf(m, " %-15s : ", "[NULL-STA]");
-			seq_printf(m, "null-%d", i);
-			seq_printf(m, "[Tx:%d/",
-				   le32_to_cpu(ns->v7.result[i][4]));
-			seq_printf(m, "[ok:%d/",
-				   le32_to_cpu(ns->v7.result[i][1]));
-			seq_printf(m, "fail:%d/",
-				   le32_to_cpu(ns->v7.result[i][0]));
-			seq_printf(m, "on_time:%d/",
-				   le32_to_cpu(ns->v7.result[i][2]));
-			seq_printf(m, "retry:%d/",
-				   le32_to_cpu(ns->v7.result[i][3]));
-			seq_printf(m, "avg_t:%d.%03d/",
-				   le32_to_cpu(ns->v7.tavg[i]) / 1000,
-				   le32_to_cpu(ns->v7.tavg[i]) % 1000);
-			seq_printf(m, "max_t:%d.%03d]\n",
-				   le32_to_cpu(ns->v7.tmax[i]) / 1000,
-				   le32_to_cpu(ns->v7.tmax[i]) % 1000);
+			p += scnprintf(p, end - p, " %-15s : ", "[NULL-STA]");
+			p += scnprintf(p, end - p, "null-%d", i);
+			p += scnprintf(p, end - p, "[Tx:%d/",
+				       le32_to_cpu(ns->v7.result[i][4]));
+			p += scnprintf(p, end - p, "[ok:%d/",
+				       le32_to_cpu(ns->v7.result[i][1]));
+			p += scnprintf(p, end - p, "fail:%d/",
+				       le32_to_cpu(ns->v7.result[i][0]));
+			p += scnprintf(p, end - p, "on_time:%d/",
+				       le32_to_cpu(ns->v7.result[i][2]));
+			p += scnprintf(p, end - p, "retry:%d/",
+				       le32_to_cpu(ns->v7.result[i][3]));
+			p += scnprintf(p, end - p, "avg_t:%d.%03d/",
+				       le32_to_cpu(ns->v7.tavg[i]) / 1000,
+				       le32_to_cpu(ns->v7.tavg[i]) % 1000);
+			p += scnprintf(p, end - p, "max_t:%d.%03d]\n",
+				       le32_to_cpu(ns->v7.tmax[i]) / 1000,
+				       le32_to_cpu(ns->v7.tmax[i]) % 1000);
 		}
 	} else {
 		for (i = 0; i < 2; i++) {
-			seq_printf(m, " %-15s : ", "[NULL-STA]");
-			seq_printf(m, "null-%d", i);
-			seq_printf(m, "[Tx:%d/",
-				   le32_to_cpu(ns->v2.result[i][4]));
-			seq_printf(m, "[ok:%d/",
-				   le32_to_cpu(ns->v2.result[i][1]));
-			seq_printf(m, "fail:%d/",
-				   le32_to_cpu(ns->v2.result[i][0]));
-			seq_printf(m, "on_time:%d/",
-				   le32_to_cpu(ns->v2.result[i][2]));
-			seq_printf(m, "retry:%d/",
-				   le32_to_cpu(ns->v2.result[i][3]));
-			seq_printf(m, "avg_t:%d.%03d/",
-				   le32_to_cpu(ns->v2.avg_t[i]) / 1000,
-				   le32_to_cpu(ns->v2.avg_t[i]) % 1000);
-			seq_printf(m, "max_t:%d.%03d]\n",
-				   le32_to_cpu(ns->v2.max_t[i]) / 1000,
-				   le32_to_cpu(ns->v2.max_t[i]) % 1000);
+			p += scnprintf(p, end - p, " %-15s : ", "[NULL-STA]");
+			p += scnprintf(p, end - p, "null-%d", i);
+			p += scnprintf(p, end - p, "[Tx:%d/",
+				       le32_to_cpu(ns->v2.result[i][4]));
+			p += scnprintf(p, end - p, "[ok:%d/",
+				       le32_to_cpu(ns->v2.result[i][1]));
+			p += scnprintf(p, end - p, "fail:%d/",
+				       le32_to_cpu(ns->v2.result[i][0]));
+			p += scnprintf(p, end - p, "on_time:%d/",
+				       le32_to_cpu(ns->v2.result[i][2]));
+			p += scnprintf(p, end - p, "retry:%d/",
+				       le32_to_cpu(ns->v2.result[i][3]));
+			p += scnprintf(p, end - p, "avg_t:%d.%03d/",
+				       le32_to_cpu(ns->v2.avg_t[i]) / 1000,
+				       le32_to_cpu(ns->v2.avg_t[i]) % 1000);
+			p += scnprintf(p, end - p, "max_t:%d.%03d]\n",
+				       le32_to_cpu(ns->v2.max_t[i]) / 1000,
+				       le32_to_cpu(ns->v2.max_t[i]) % 1000);
 		}
 	}
+
+	return p - buf;
 }
 
-static void _show_fbtc_step_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_fbtc_step_v2(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	struct rtw89_btc_fbtc_steps_v2 *pstep = NULL;
 	const struct rtw89_btc_ver *ver = btc->ver;
+	char *p = buf, *end = buf + bufsz;
 	u8 type, val, cnt = 0, state = 0;
 	bool outloop = false;
 	u16 i, diff_t, n_start = 0, n_stop = 0;
@@ -9838,14 +9943,14 @@ static void _show_fbtc_step_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 	pcinfo = &pfwinfo->rpt_fbtc_step.cinfo;
 	if (!pcinfo->valid)
-		return;
+		return 0;
 
 	pstep = &pfwinfo->rpt_fbtc_step.finfo.v2;
 	pos_old = le16_to_cpu(pstep->pos_old);
 	pos_new = le16_to_cpu(pstep->pos_new);
 
 	if (pcinfo->req_fver != pstep->fver)
-		return;
+		return 0;
 
 	/* store step info by using ring instead of FIFO*/
 	do {
@@ -9874,13 +9979,15 @@ static void _show_fbtc_step_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 					continue;
 
 				if (cnt % 10 == 0)
-					seq_printf(m, " %-15s : ", "[steps]");
+					p += scnprintf(p, end - p,
+						       " %-15s : ", "[steps]");
 
-				seq_printf(m, "-> %s(%02d)(%02d)",
-					   (type == CXSTEP_SLOT ? "SLT" :
-					    "EVT"), (u32)val, diff_t);
+				p += scnprintf(p, end - p,
+					       "-> %s(%02d)(%02d)",
+					       (type == CXSTEP_SLOT ? "SLT" :
+						"EVT"), (u32)val, diff_t);
 				if (cnt % 10 == 9)
-					seq_puts(m, "\n");
+					p += scnprintf(p, end - p, "\n");
 				cnt++;
 			}
 
@@ -9897,29 +10004,32 @@ static void _show_fbtc_step_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 			break;
 		}
 	} while (!outloop);
+
+	return p - buf;
 }
 
-static void _show_fbtc_step_v3(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_fbtc_step_v3(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_rpt_cmn_info *pcinfo;
 	struct rtw89_btc_fbtc_steps_v3 *pstep;
 	u32 i, n_begin, n_end, array_idx, cnt = 0;
+	char *p = buf, *end = buf + bufsz;
 	u8 type, val;
 	u16 diff_t;
 
 	if ((pfwinfo->rpt_en_map &
 	     rtw89_btc_fw_rpt_ver(rtwdev, RPT_EN_FW_STEP_INFO)) == 0)
-		return;
+		return 0;
 
 	pcinfo = &pfwinfo->rpt_fbtc_step.cinfo;
 	if (!pcinfo->valid)
-		return;
+		return 0;
 
 	pstep = &pfwinfo->rpt_fbtc_step.finfo.v3;
 	if (pcinfo->req_fver != pstep->fver)
-		return;
+		return 0;
 
 	if (le32_to_cpu(pstep->cnt) <= FCXDEF_STEP)
 		n_begin = 1;
@@ -9929,7 +10039,7 @@ static void _show_fbtc_step_v3(struct rtw89_dev *rtwdev, struct seq_file *m)
 	n_end = le32_to_cpu(pstep->cnt);
 
 	if (n_begin > n_end)
-		return;
+		return 0;
 
 	/* restore step info by using ring instead of FIFO */
 	for (i = n_begin; i <= n_end; i++) {
@@ -9942,50 +10052,55 @@ static void _show_fbtc_step_v3(struct rtw89_dev *rtwdev, struct seq_file *m)
 			continue;
 
 		if (cnt % 10 == 0)
-			seq_printf(m, " %-15s : ", "[steps]");
+			p += scnprintf(p, end - p, " %-15s : ", "[steps]");
 
-		seq_printf(m, "-> %s(%02d)",
-			   (type == CXSTEP_SLOT ?
-			    id_to_slot((u32)val) :
-			    id_to_evt((u32)val)), diff_t);
+		p += scnprintf(p, end - p, "-> %s(%02d)",
+			       (type == CXSTEP_SLOT ?
+				id_to_slot((u32)val) :
+				id_to_evt((u32)val)), diff_t);
 
 		if (cnt % 10 == 9)
-			seq_puts(m, "\n");
+			p += scnprintf(p, end - p, "\n");
 
 		cnt++;
 	}
+
+	return p - buf;
 }
 
-static void _show_fw_dm_msg(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_fw_dm_msg(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
+	char *p = buf, *end = buf + bufsz;
 
 	if (!(btc->dm.coex_info_map & BTC_COEX_INFO_DM))
-		return;
+		goto out;
 
-	_show_error(rtwdev, m);
-	_show_fbtc_tdma(rtwdev, m);
-	_show_fbtc_slots(rtwdev, m);
+	p += _show_error(rtwdev, p, end - p);
+	p += _show_fbtc_tdma(rtwdev, p, end - p);
+	p += _show_fbtc_slots(rtwdev, p, end - p);
 
 	if (ver->fcxcysta == 2)
-		_show_fbtc_cysta_v2(rtwdev, m);
+		p += _show_fbtc_cysta_v2(rtwdev, p, end - p);
 	else if (ver->fcxcysta == 3)
-		_show_fbtc_cysta_v3(rtwdev, m);
+		p += _show_fbtc_cysta_v3(rtwdev, p, end - p);
 	else if (ver->fcxcysta == 4)
-		_show_fbtc_cysta_v4(rtwdev, m);
+		p += _show_fbtc_cysta_v4(rtwdev, p, end - p);
 	else if (ver->fcxcysta == 5)
-		_show_fbtc_cysta_v5(rtwdev, m);
+		p += _show_fbtc_cysta_v5(rtwdev, p, end - p);
 	else if (ver->fcxcysta == 7)
-		_show_fbtc_cysta_v7(rtwdev, m);
+		p += _show_fbtc_cysta_v7(rtwdev, p, end - p);
 
-	_show_fbtc_nullsta(rtwdev, m);
+	p += _show_fbtc_nullsta(rtwdev, p, end - p);
 
 	if (ver->fcxstep == 2)
-		_show_fbtc_step_v2(rtwdev, m);
+		p += _show_fbtc_step_v2(rtwdev, p, end - p);
 	else if (ver->fcxstep == 3)
-		_show_fbtc_step_v3(rtwdev, m);
+		p += _show_fbtc_step_v3(rtwdev, p, end - p);
 
+out:
+	return p - buf;
 }
 
 static void _get_gnt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_coex_gnt *gnt_cfg)
@@ -10030,12 +10145,13 @@ static void _get_gnt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_coex_gnt *gnt
 	}
 }
 
-static void _show_gpio_dbg(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_gpio_dbg(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &rtwdev->btc.fwinfo;
 	const struct rtw89_btc_ver *ver = rtwdev->btc.ver;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
 	union rtw89_btc_fbtc_gpio_dbg *gdbg = NULL;
+	char *p = buf, *end = buf + bufsz;
 	u8 *gpio_map, i;
 	u32 en_map;
 
@@ -10045,8 +10161,8 @@ static void _show_gpio_dbg(struct rtw89_dev *rtwdev, struct seq_file *m)
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): stop due rpt_fbtc_gpio_dbg.cinfo\n",
 			    __func__);
-		seq_puts(m, "\n");
-		return;
+		p += scnprintf(p, end - p, "\n");
+		goto out;
 	}
 
 	if (ver->fcxgpiodbg == 7) {
@@ -10058,20 +10174,24 @@ static void _show_gpio_dbg(struct rtw89_dev *rtwdev, struct seq_file *m)
 	}
 
 	if (!en_map)
-		return;
+		goto out;
 
-	seq_printf(m, " %-15s : enable_map:0x%08x",
-		   "[gpio_dbg]", en_map);
+	p += scnprintf(p, end - p, " %-15s : enable_map:0x%08x",
+		       "[gpio_dbg]", en_map);
 
 	for (i = 0; i < BTC_DBG_MAX1; i++) {
 		if (!(en_map & BIT(i)))
 			continue;
-		seq_printf(m, ", %s->GPIO%d", id_to_gdbg(i), gpio_map[i]);
+		p += scnprintf(p, end - p, ", %s->GPIO%d", id_to_gdbg(i),
+			       gpio_map[i]);
 	}
-	seq_puts(m, "\n");
+	p += scnprintf(p, end - p, "\n");
+
+out:
+	return p - buf;
 }
 
-static void _show_mreg_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_mreg_v1(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -10083,45 +10203,47 @@ static void _show_mreg_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_mac_ax_coex_gnt gnt_cfg = {};
 	struct rtw89_mac_ax_gnt gnt;
+	char *p = buf, *end = buf + bufsz;
 	u8 i = 0, type = 0, cnt = 0;
 	u32 val, offset;
 
 	if (!(btc->dm.coex_info_map & BTC_COEX_INFO_MREG))
-		return;
+		return 0;
 
-	seq_puts(m, "========== [HW Status] ==========\n");
+	p += scnprintf(p, end - p, "========== [HW Status] ==========\n");
 
-	seq_printf(m,
-		   " %-15s : WL->BT:0x%08x(cnt:%d), BT->WL:0x%08x(total:%d, bt_update:%d)\n",
-		   "[scoreboard]", wl->scbd, cx->cnt_wl[BTC_WCNT_SCBDUPDATE],
-		   bt->scbd, cx->cnt_bt[BTC_BCNT_SCBDREAD],
-		   cx->cnt_bt[BTC_BCNT_SCBDUPDATE]);
+	p += scnprintf(p, end - p,
+		       " %-15s : WL->BT:0x%08x(cnt:%d), BT->WL:0x%08x(total:%d, bt_update:%d)\n",
+		       "[scoreboard]", wl->scbd,
+		       cx->cnt_wl[BTC_WCNT_SCBDUPDATE],
+		       bt->scbd, cx->cnt_bt[BTC_BCNT_SCBDREAD],
+		       cx->cnt_bt[BTC_BCNT_SCBDUPDATE]);
 
 	btc->dm.pta_owner = rtw89_mac_get_ctrl_path(rtwdev);
 	_get_gnt(rtwdev, &gnt_cfg);
 
 	gnt = gnt_cfg.band[0];
-	seq_printf(m,
-		   " %-15s : pta_owner:%s, phy-0[gnt_wl:%s-%d/gnt_bt:%s-%d], ",
-		   "[gnt_status]",
-		   chip->chip_id == RTL8852C ? "HW" :
-		   btc->dm.pta_owner == BTC_CTRL_BY_WL ? "WL" : "BT",
-		   gnt.gnt_wl_sw_en ? "SW" : "HW", gnt.gnt_wl,
-		   gnt.gnt_bt_sw_en ? "SW" : "HW", gnt.gnt_bt);
+	p += scnprintf(p, end - p,
+		       " %-15s : pta_owner:%s, phy-0[gnt_wl:%s-%d/gnt_bt:%s-%d], ",
+		       "[gnt_status]",
+		       chip->chip_id == RTL8852C ? "HW" :
+		       btc->dm.pta_owner == BTC_CTRL_BY_WL ? "WL" : "BT",
+		       gnt.gnt_wl_sw_en ? "SW" : "HW", gnt.gnt_wl,
+		       gnt.gnt_bt_sw_en ? "SW" : "HW", gnt.gnt_bt);
 
 	gnt = gnt_cfg.band[1];
-	seq_printf(m, "phy-1[gnt_wl:%s-%d/gnt_bt:%s-%d]\n",
-		   gnt.gnt_wl_sw_en ? "SW" : "HW",
-		   gnt.gnt_wl,
-		   gnt.gnt_bt_sw_en ? "SW" : "HW",
-		   gnt.gnt_bt);
+	p += scnprintf(p, end - p, "phy-1[gnt_wl:%s-%d/gnt_bt:%s-%d]\n",
+		       gnt.gnt_wl_sw_en ? "SW" : "HW",
+		       gnt.gnt_wl,
+		       gnt.gnt_bt_sw_en ? "SW" : "HW",
+		       gnt.gnt_bt);
 
 	pcinfo = &pfwinfo->rpt_fbtc_mregval.cinfo;
 	if (!pcinfo->valid) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): stop due rpt_fbtc_mregval.cinfo\n",
 			    __func__);
-		return;
+		goto out;
 	}
 
 	pmreg = &pfwinfo->rpt_fbtc_mregval.finfo.v1;
@@ -10135,21 +10257,26 @@ static void _show_mreg_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
 		val = le32_to_cpu(pmreg->mreg_val[i]);
 
 		if (cnt % 6 == 0)
-			seq_printf(m, " %-15s : %d_0x%04x=0x%08x",
-				   "[reg]", (u32)type, offset, val);
+			p += scnprintf(p, end - p,
+				       " %-15s : %d_0x%04x=0x%08x",
+				       "[reg]", (u32)type, offset, val);
 		else
-			seq_printf(m, ", %d_0x%04x=0x%08x", (u32)type,
-				   offset, val);
+			p += scnprintf(p, end - p, ", %d_0x%04x=0x%08x",
+				       (u32)type,
+				       offset, val);
 		if (cnt % 6 == 5)
-			seq_puts(m, "\n");
+			p += scnprintf(p, end - p, "\n");
 		cnt++;
 
 		if (i >= pmreg->reg_num)
-			seq_puts(m, "\n");
+			p += scnprintf(p, end - p, "\n");
 	}
+
+out:
+	return p - buf;
 }
 
-static void _show_mreg_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_mreg_v2(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -10161,46 +10288,48 @@ static void _show_mreg_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_mac_ax_coex_gnt gnt_cfg = {};
 	struct rtw89_mac_ax_gnt gnt;
+	char *p = buf, *end = buf + bufsz;
 	u8 i = 0, type = 0, cnt = 0;
 	u32 val, offset;
 
 	if (!(btc->dm.coex_info_map & BTC_COEX_INFO_MREG))
-		return;
+		return 0;
 
-	seq_puts(m, "========== [HW Status] ==========\n");
+	p += scnprintf(p, end - p, "========== [HW Status] ==========\n");
 
-	seq_printf(m,
-		   " %-15s : WL->BT:0x%08x(cnt:%d), BT->WL:0x%08x(total:%d, bt_update:%d)\n",
-		   "[scoreboard]", wl->scbd, cx->cnt_wl[BTC_WCNT_SCBDUPDATE],
-		   bt->scbd, cx->cnt_bt[BTC_BCNT_SCBDREAD],
-		   cx->cnt_bt[BTC_BCNT_SCBDUPDATE]);
+	p += scnprintf(p, end - p,
+		       " %-15s : WL->BT:0x%08x(cnt:%d), BT->WL:0x%08x(total:%d, bt_update:%d)\n",
+		       "[scoreboard]", wl->scbd,
+		       cx->cnt_wl[BTC_WCNT_SCBDUPDATE],
+		       bt->scbd, cx->cnt_bt[BTC_BCNT_SCBDREAD],
+		       cx->cnt_bt[BTC_BCNT_SCBDUPDATE]);
 
 	btc->dm.pta_owner = rtw89_mac_get_ctrl_path(rtwdev);
 	_get_gnt(rtwdev, &gnt_cfg);
 
 	gnt = gnt_cfg.band[0];
-	seq_printf(m,
-		   " %-15s : pta_owner:%s, phy-0[gnt_wl:%s-%d/gnt_bt:%s-%d], polut_type:%s",
-		   "[gnt_status]",
-		   chip->chip_id == RTL8852C ? "HW" :
-		   btc->dm.pta_owner == BTC_CTRL_BY_WL ? "WL" : "BT",
-		   gnt.gnt_wl_sw_en ? "SW" : "HW", gnt.gnt_wl,
-		   gnt.gnt_bt_sw_en ? "SW" : "HW", gnt.gnt_bt,
-		   id_to_polut(wl->bt_polut_type[wl->pta_req_mac]));
+	p += scnprintf(p, end - p,
+		       " %-15s : pta_owner:%s, phy-0[gnt_wl:%s-%d/gnt_bt:%s-%d], polut_type:%s",
+		       "[gnt_status]",
+		       chip->chip_id == RTL8852C ? "HW" :
+		       btc->dm.pta_owner == BTC_CTRL_BY_WL ? "WL" : "BT",
+		       gnt.gnt_wl_sw_en ? "SW" : "HW", gnt.gnt_wl,
+		       gnt.gnt_bt_sw_en ? "SW" : "HW", gnt.gnt_bt,
+		       id_to_polut(wl->bt_polut_type[wl->pta_req_mac]));
 
 	gnt = gnt_cfg.band[1];
-	seq_printf(m, "phy-1[gnt_wl:%s-%d/gnt_bt:%s-%d]\n",
-		   gnt.gnt_wl_sw_en ? "SW" : "HW",
-		   gnt.gnt_wl,
-		   gnt.gnt_bt_sw_en ? "SW" : "HW",
-		   gnt.gnt_bt);
+	p += scnprintf(p, end - p, "phy-1[gnt_wl:%s-%d/gnt_bt:%s-%d]\n",
+		       gnt.gnt_wl_sw_en ? "SW" : "HW",
+		       gnt.gnt_wl,
+		       gnt.gnt_bt_sw_en ? "SW" : "HW",
+		       gnt.gnt_bt);
 
 	pcinfo = &pfwinfo->rpt_fbtc_mregval.cinfo;
 	if (!pcinfo->valid) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): stop due rpt_fbtc_mregval.cinfo\n",
 			    __func__);
-		return;
+		goto out;
 	}
 
 	pmreg = &pfwinfo->rpt_fbtc_mregval.finfo.v2;
@@ -10214,21 +10343,26 @@ static void _show_mreg_v2(struct rtw89_dev *rtwdev, struct seq_file *m)
 		val = le32_to_cpu(pmreg->mreg_val[i]);
 
 		if (cnt % 6 == 0)
-			seq_printf(m, " %-15s : %d_0x%04x=0x%08x",
-				   "[reg]", (u32)type, offset, val);
+			p += scnprintf(p, end - p,
+				       " %-15s : %d_0x%04x=0x%08x",
+				       "[reg]", (u32)type, offset, val);
 		else
-			seq_printf(m, ", %d_0x%04x=0x%08x", (u32)type,
-				   offset, val);
+			p += scnprintf(p, end - p, ", %d_0x%04x=0x%08x",
+				       (u32)type,
+				       offset, val);
 		if (cnt % 6 == 5)
-			seq_puts(m, "\n");
+			p += scnprintf(p, end - p, "\n");
 		cnt++;
 
 		if (i >= pmreg->reg_num)
-			seq_puts(m, "\n");
+			p += scnprintf(p, end - p, "\n");
 	}
+
+out:
+	return p - buf;
 }
 
-static void _show_mreg_v7(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_mreg_v7(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
@@ -10239,46 +10373,50 @@ static void _show_mreg_v7(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_bt_info *bt = &cx->bt;
 	struct rtw89_mac_ax_gnt *gnt = NULL;
 	struct rtw89_btc_dm *dm = &btc->dm;
+	char *p = buf, *end = buf + bufsz;
 	u8 i, type, cnt = 0;
 	u32 val, offset;
 
 	if (!(dm->coex_info_map & BTC_COEX_INFO_MREG))
-		return;
+		return 0;
 
-	seq_puts(m, "\n\r========== [HW Status] ==========");
+	p += scnprintf(p, end - p, "\n\r========== [HW Status] ==========");
 
-	seq_printf(m,
-		   "\n\r %-15s : WL->BT:0x%08x(cnt:%d), BT->WL:0x%08x(total:%d, bt_update:%d)",
-		   "[scoreboard]", wl->scbd, cx->cnt_wl[BTC_WCNT_SCBDUPDATE],
-		   bt->scbd, cx->cnt_bt[BTC_BCNT_SCBDREAD],
-		   cx->cnt_bt[BTC_BCNT_SCBDUPDATE]);
+	p += scnprintf(p, end - p,
+		       "\n\r %-15s : WL->BT:0x%08x(cnt:%d), BT->WL:0x%08x(total:%d, bt_update:%d)",
+		       "[scoreboard]", wl->scbd,
+		       cx->cnt_wl[BTC_WCNT_SCBDUPDATE],
+		       bt->scbd, cx->cnt_bt[BTC_BCNT_SCBDREAD],
+		       cx->cnt_bt[BTC_BCNT_SCBDUPDATE]);
 
 	/* To avoid I/O if WL LPS or power-off  */
 	dm->pta_owner = rtw89_mac_get_ctrl_path(rtwdev);
 
-	seq_printf(m,
-		   "\n\r %-15s : pta_owner:%s, pta_req_mac:MAC%d, rf_gnt_source: polut_type:%s",
-		   "[gnt_status]",
-		   rtwdev->chip->para_ver & BTC_FEAT_PTA_ONOFF_CTRL ? "HW" :
-		   dm->pta_owner == BTC_CTRL_BY_WL ? "WL" : "BT",
-		   wl->pta_req_mac, id_to_polut(wl->bt_polut_type[wl->pta_req_mac]));
+	p += scnprintf(p, end - p,
+		       "\n\r %-15s : pta_owner:%s, pta_req_mac:MAC%d, rf_gnt_source: polut_type:%s",
+		       "[gnt_status]",
+		       rtwdev->chip->para_ver & BTC_FEAT_PTA_ONOFF_CTRL ? "HW" :
+		       dm->pta_owner == BTC_CTRL_BY_WL ? "WL" : "BT",
+		       wl->pta_req_mac,
+		       id_to_polut(wl->bt_polut_type[wl->pta_req_mac]));
 
 	gnt = &dm->gnt.band[RTW89_PHY_0];
 
-	seq_printf(m, ", phy-0[gnt_wl:%s-%d/gnt_bt:%s-%d]",
-		   gnt->gnt_wl_sw_en ? "SW" : "HW", gnt->gnt_wl,
-		   gnt->gnt_bt_sw_en ? "SW" : "HW", gnt->gnt_bt);
+	p += scnprintf(p, end - p, ", phy-0[gnt_wl:%s-%d/gnt_bt:%s-%d]",
+		       gnt->gnt_wl_sw_en ? "SW" : "HW", gnt->gnt_wl,
+		       gnt->gnt_bt_sw_en ? "SW" : "HW", gnt->gnt_bt);
 
 	if (rtwdev->dbcc_en) {
 		gnt = &dm->gnt.band[RTW89_PHY_1];
-		seq_printf(m, ", phy-1[gnt_wl:%s-%d/gnt_bt:%s-%d]",
-			   gnt->gnt_wl_sw_en ? "SW" : "HW", gnt->gnt_wl,
-			   gnt->gnt_bt_sw_en ? "SW" : "HW", gnt->gnt_bt);
+		p += scnprintf(p, end - p,
+			       ", phy-1[gnt_wl:%s-%d/gnt_bt:%s-%d]",
+			       gnt->gnt_wl_sw_en ? "SW" : "HW", gnt->gnt_wl,
+			       gnt->gnt_bt_sw_en ? "SW" : "HW", gnt->gnt_bt);
 	}
 
 	pcinfo = &pfwinfo->rpt_fbtc_mregval.cinfo;
 	if (!pcinfo->valid)
-		return;
+		goto out;
 
 	pmreg = &pfwinfo->rpt_fbtc_mregval.finfo.v7;
 
@@ -10288,17 +10426,21 @@ static void _show_mreg_v7(struct rtw89_dev *rtwdev, struct seq_file *m)
 		val = le32_to_cpu(pmreg->mreg_val[i]);
 
 		if (cnt % 6 == 0)
-			seq_printf(m, "\n\r %-15s : %s_0x%x=0x%x", "[reg]",
-				   id_to_regtype(type), offset, val);
+			p += scnprintf(p, end - p,
+				       "\n\r %-15s : %s_0x%x=0x%x", "[reg]",
+				       id_to_regtype(type), offset, val);
 		else
-			seq_printf(m, ", %s_0x%x=0x%x",
-				   id_to_regtype(type), offset, val);
+			p += scnprintf(p, end - p, ", %s_0x%x=0x%x",
+				       id_to_regtype(type), offset, val);
 		cnt++;
 	}
-	seq_puts(m, "\n");
+	p += scnprintf(p, end - p, "\n");
+
+out:
+	return p - buf;
 }
 
-static void _show_summary_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_summary_v1(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
@@ -10309,56 +10451,59 @@ static void _show_summary_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 	struct rtw89_btc_bt_info *bt = &cx->bt;
 	u32 cnt_sum = 0, *cnt = btc->dm.cnt_notify;
+	char *p = buf, *end = buf + bufsz;
 	u8 i;
 
 	if (!(dm->coex_info_map & BTC_COEX_INFO_SUMMARY))
-		return;
+		return 0;
 
-	seq_puts(m, "========== [Statistics] ==========\n");
+	p += scnprintf(p, end - p, "========== [Statistics] ==========\n");
 
 	pcinfo = &pfwinfo->rpt_ctrl.cinfo;
 	if (pcinfo->valid && !wl->status.map.lps && !wl->status.map.rf_off) {
 		prptctrl = &pfwinfo->rpt_ctrl.finfo.v1;
 
-		seq_printf(m,
-			   " %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d), c2h_cnt=%d(fw_send:%d), ",
-			   "[summary]", pfwinfo->cnt_h2c,
-			   pfwinfo->cnt_h2c_fail, prptctrl->h2c_cnt,
-			   pfwinfo->cnt_c2h, prptctrl->c2h_cnt);
+		p += scnprintf(p, end - p,
+			       " %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d), c2h_cnt=%d(fw_send:%d), ",
+			       "[summary]", pfwinfo->cnt_h2c,
+			       pfwinfo->cnt_h2c_fail, prptctrl->h2c_cnt,
+			       pfwinfo->cnt_c2h, prptctrl->c2h_cnt);
 
-		seq_printf(m,
-			   "rpt_cnt=%d(fw_send:%d), rpt_map=0x%x, dm_error_map:0x%x",
-			   pfwinfo->event[BTF_EVNT_RPT], prptctrl->rpt_cnt,
-			   prptctrl->rpt_enable, dm->error.val);
+		p += scnprintf(p, end - p,
+			       "rpt_cnt=%d(fw_send:%d), rpt_map=0x%x, dm_error_map:0x%x",
+			       pfwinfo->event[BTF_EVNT_RPT],
+			       prptctrl->rpt_cnt,
+			       prptctrl->rpt_enable, dm->error.val);
 
 		if (dm->error.map.wl_fw_hang)
-			seq_puts(m, " (WL FW Hang!!)");
-		seq_puts(m, "\n");
-		seq_printf(m,
-			   " %-15s : send_ok:%d, send_fail:%d, recv:%d",
-			   "[mailbox]", prptctrl->mb_send_ok_cnt,
-			   prptctrl->mb_send_fail_cnt, prptctrl->mb_recv_cnt);
-
-		seq_printf(m,
-			   "(A2DP_empty:%d, A2DP_flowstop:%d, A2DP_full:%d)\n",
-			   prptctrl->mb_a2dp_empty_cnt,
-			   prptctrl->mb_a2dp_flct_cnt,
-			   prptctrl->mb_a2dp_full_cnt);
-
-		seq_printf(m,
-			   " %-15s : wl_rfk[req:%d/go:%d/reject:%d/timeout:%d]",
-			   "[RFK]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
-			   cx->cnt_wl[BTC_WCNT_RFK_GO],
-			   cx->cnt_wl[BTC_WCNT_RFK_REJECT],
-			   cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT]);
-
-		seq_printf(m,
-			   ", bt_rfk[req:%d/go:%d/reject:%d/timeout:%d/fail:%d]\n",
-			   prptctrl->bt_rfk_cnt[BTC_BCNT_RFK_REQ],
-			   prptctrl->bt_rfk_cnt[BTC_BCNT_RFK_GO],
-			   prptctrl->bt_rfk_cnt[BTC_BCNT_RFK_REJECT],
-			   prptctrl->bt_rfk_cnt[BTC_BCNT_RFK_TIMEOUT],
-			   prptctrl->bt_rfk_cnt[BTC_BCNT_RFK_FAIL]);
+			p += scnprintf(p, end - p, " (WL FW Hang!!)");
+		p += scnprintf(p, end - p, "\n");
+		p += scnprintf(p, end - p,
+			       " %-15s : send_ok:%d, send_fail:%d, recv:%d",
+			       "[mailbox]", prptctrl->mb_send_ok_cnt,
+			       prptctrl->mb_send_fail_cnt,
+			       prptctrl->mb_recv_cnt);
+
+		p += scnprintf(p, end - p,
+			       "(A2DP_empty:%d, A2DP_flowstop:%d, A2DP_full:%d)\n",
+			       prptctrl->mb_a2dp_empty_cnt,
+			       prptctrl->mb_a2dp_flct_cnt,
+			       prptctrl->mb_a2dp_full_cnt);
+
+		p += scnprintf(p, end - p,
+			       " %-15s : wl_rfk[req:%d/go:%d/reject:%d/timeout:%d]",
+			       "[RFK]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
+			       cx->cnt_wl[BTC_WCNT_RFK_GO],
+			       cx->cnt_wl[BTC_WCNT_RFK_REJECT],
+			       cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT]);
+
+		p += scnprintf(p, end - p,
+			       ", bt_rfk[req:%d/go:%d/reject:%d/timeout:%d/fail:%d]\n",
+			       prptctrl->bt_rfk_cnt[BTC_BCNT_RFK_REQ],
+			       prptctrl->bt_rfk_cnt[BTC_BCNT_RFK_GO],
+			       prptctrl->bt_rfk_cnt[BTC_BCNT_RFK_REJECT],
+			       prptctrl->bt_rfk_cnt[BTC_BCNT_RFK_TIMEOUT],
+			       prptctrl->bt_rfk_cnt[BTC_BCNT_RFK_FAIL]);
 
 		if (prptctrl->bt_rfk_cnt[BTC_BCNT_RFK_TIMEOUT] > 0)
 			bt->rfk_info.map.timeout = 1;
@@ -10367,42 +10512,44 @@ static void _show_summary_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 		dm->error.map.wl_rfk_timeout = bt->rfk_info.map.timeout;
 	} else {
-		seq_printf(m,
-			   " %-15s : h2c_cnt=%d(fail:%d), c2h_cnt=%d, rpt_cnt=%d, rpt_map=0x%x",
-			   "[summary]", pfwinfo->cnt_h2c,
-			   pfwinfo->cnt_h2c_fail, pfwinfo->cnt_c2h,
-			   pfwinfo->event[BTF_EVNT_RPT],
-			   btc->fwinfo.rpt_en_map);
-		seq_puts(m, " (WL FW report invalid!!)\n");
+		p += scnprintf(p, end - p,
+			       " %-15s : h2c_cnt=%d(fail:%d), c2h_cnt=%d, rpt_cnt=%d, rpt_map=0x%x",
+			       "[summary]", pfwinfo->cnt_h2c,
+			       pfwinfo->cnt_h2c_fail, pfwinfo->cnt_c2h,
+			       pfwinfo->event[BTF_EVNT_RPT],
+			       btc->fwinfo.rpt_en_map);
+		p += scnprintf(p, end - p, " (WL FW report invalid!!)\n");
 	}
 
 	for (i = 0; i < BTC_NCNT_NUM; i++)
 		cnt_sum += dm->cnt_notify[i];
 
-	seq_printf(m,
-		   " %-15s : total=%d, show_coex_info=%d, power_on=%d, init_coex=%d, ",
-		   "[notify_cnt]", cnt_sum, cnt[BTC_NCNT_SHOW_COEX_INFO],
-		   cnt[BTC_NCNT_POWER_ON], cnt[BTC_NCNT_INIT_COEX]);
+	p += scnprintf(p, end - p,
+		       " %-15s : total=%d, show_coex_info=%d, power_on=%d, init_coex=%d, ",
+		       "[notify_cnt]", cnt_sum, cnt[BTC_NCNT_SHOW_COEX_INFO],
+		       cnt[BTC_NCNT_POWER_ON], cnt[BTC_NCNT_INIT_COEX]);
+
+	p += scnprintf(p, end - p,
+		       "power_off=%d, radio_state=%d, role_info=%d, wl_rfk=%d, wl_sta=%d\n",
+		       cnt[BTC_NCNT_POWER_OFF], cnt[BTC_NCNT_RADIO_STATE],
+		       cnt[BTC_NCNT_ROLE_INFO], cnt[BTC_NCNT_WL_RFK],
+		       cnt[BTC_NCNT_WL_STA]);
 
-	seq_printf(m,
-		   "power_off=%d, radio_state=%d, role_info=%d, wl_rfk=%d, wl_sta=%d\n",
-		   cnt[BTC_NCNT_POWER_OFF], cnt[BTC_NCNT_RADIO_STATE],
-		   cnt[BTC_NCNT_ROLE_INFO], cnt[BTC_NCNT_WL_RFK],
-		   cnt[BTC_NCNT_WL_STA]);
+	p += scnprintf(p, end - p,
+		       " %-15s : scan_start=%d, scan_finish=%d, switch_band=%d, special_pkt=%d, ",
+		       "[notify_cnt]", cnt[BTC_NCNT_SCAN_START],
+		       cnt[BTC_NCNT_SCAN_FINISH], cnt[BTC_NCNT_SWITCH_BAND],
+		       cnt[BTC_NCNT_SPECIAL_PACKET]);
 
-	seq_printf(m,
-		   " %-15s : scan_start=%d, scan_finish=%d, switch_band=%d, special_pkt=%d, ",
-		   "[notify_cnt]", cnt[BTC_NCNT_SCAN_START],
-		   cnt[BTC_NCNT_SCAN_FINISH], cnt[BTC_NCNT_SWITCH_BAND],
-		   cnt[BTC_NCNT_SPECIAL_PACKET]);
+	p += scnprintf(p, end - p,
+		       "timer=%d, control=%d, customerize=%d\n",
+		       cnt[BTC_NCNT_TIMER], cnt[BTC_NCNT_CONTROL],
+		       cnt[BTC_NCNT_CUSTOMERIZE]);
 
-	seq_printf(m,
-		   "timer=%d, control=%d, customerize=%d\n",
-		   cnt[BTC_NCNT_TIMER], cnt[BTC_NCNT_CONTROL],
-		   cnt[BTC_NCNT_CUSTOMERIZE]);
+	return p - buf;
 }
 
-static void _show_summary_v4(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_summary_v4(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
@@ -10413,64 +10560,65 @@ static void _show_summary_v4(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 	struct rtw89_btc_bt_info *bt = &cx->bt;
 	u32 cnt_sum = 0, *cnt = btc->dm.cnt_notify;
+	char *p = buf, *end = buf + bufsz;
 	u8 i;
 
 	if (!(dm->coex_info_map & BTC_COEX_INFO_SUMMARY))
-		return;
+		return 0;
 
-	seq_puts(m, "========== [Statistics] ==========\n");
+	p += scnprintf(p, end - p, "========== [Statistics] ==========\n");
 
 	pcinfo = &pfwinfo->rpt_ctrl.cinfo;
 	if (pcinfo->valid && !wl->status.map.lps && !wl->status.map.rf_off) {
 		prptctrl = &pfwinfo->rpt_ctrl.finfo.v4;
 
-		seq_printf(m,
-			   " %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d), c2h_cnt=%d(fw_send:%d), ",
-			   "[summary]", pfwinfo->cnt_h2c,
-			   pfwinfo->cnt_h2c_fail,
-			   le32_to_cpu(prptctrl->rpt_info.cnt_h2c),
-			   pfwinfo->cnt_c2h,
-			   le32_to_cpu(prptctrl->rpt_info.cnt_c2h));
-
-		seq_printf(m,
-			   "rpt_cnt=%d(fw_send:%d), rpt_map=0x%x, dm_error_map:0x%x",
-			   pfwinfo->event[BTF_EVNT_RPT],
-			   le32_to_cpu(prptctrl->rpt_info.cnt),
-			   le32_to_cpu(prptctrl->rpt_info.en),
-			   dm->error.val);
+		p += scnprintf(p, end - p,
+			       " %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d), c2h_cnt=%d(fw_send:%d), ",
+			       "[summary]", pfwinfo->cnt_h2c,
+			       pfwinfo->cnt_h2c_fail,
+			       le32_to_cpu(prptctrl->rpt_info.cnt_h2c),
+			       pfwinfo->cnt_c2h,
+			       le32_to_cpu(prptctrl->rpt_info.cnt_c2h));
+
+		p += scnprintf(p, end - p,
+			       "rpt_cnt=%d(fw_send:%d), rpt_map=0x%x, dm_error_map:0x%x",
+			       pfwinfo->event[BTF_EVNT_RPT],
+			       le32_to_cpu(prptctrl->rpt_info.cnt),
+			       le32_to_cpu(prptctrl->rpt_info.en),
+			       dm->error.val);
 
 		if (dm->error.map.wl_fw_hang)
-			seq_puts(m, " (WL FW Hang!!)");
-		seq_puts(m, "\n");
-		seq_printf(m,
-			   " %-15s : send_ok:%d, send_fail:%d, recv:%d, ",
-			   "[mailbox]",
-			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_ok),
-			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_fail),
-			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_recv));
-
-		seq_printf(m,
-			   "A2DP_empty:%d(stop:%d, tx:%d, ack:%d, nack:%d)\n",
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_empty),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_flowctrl),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_tx),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_ack),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_nack));
-
-		seq_printf(m,
-			   " %-15s : wl_rfk[req:%d/go:%d/reject:%d/timeout:%d]",
-			   "[RFK]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
-			   cx->cnt_wl[BTC_WCNT_RFK_GO],
-			   cx->cnt_wl[BTC_WCNT_RFK_REJECT],
-			   cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT]);
-
-		seq_printf(m,
-			   ", bt_rfk[req:%d/go:%d/reject:%d/timeout:%d/fail:%d]\n",
-			   le32_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_REQ]),
-			   le32_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_GO]),
-			   le32_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_REJECT]),
-			   le32_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_TIMEOUT]),
-			   le32_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_FAIL]));
+			p += scnprintf(p, end - p, " (WL FW Hang!!)");
+		p += scnprintf(p, end - p, "\n");
+		p += scnprintf(p, end - p,
+			       " %-15s : send_ok:%d, send_fail:%d, recv:%d, ",
+			       "[mailbox]",
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_ok),
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_fail),
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_recv));
+
+		p += scnprintf(p, end - p,
+			       "A2DP_empty:%d(stop:%d, tx:%d, ack:%d, nack:%d)\n",
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_empty),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_flowctrl),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_tx),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_ack),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_nack));
+
+		p += scnprintf(p, end - p,
+			       " %-15s : wl_rfk[req:%d/go:%d/reject:%d/timeout:%d]",
+			       "[RFK]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
+			       cx->cnt_wl[BTC_WCNT_RFK_GO],
+			       cx->cnt_wl[BTC_WCNT_RFK_REJECT],
+			       cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT]);
+
+		p += scnprintf(p, end - p,
+			       ", bt_rfk[req:%d/go:%d/reject:%d/timeout:%d/fail:%d]\n",
+			       le32_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_REQ]),
+			       le32_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_GO]),
+			       le32_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_REJECT]),
+			       le32_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_TIMEOUT]),
+			       le32_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_FAIL]));
 
 		if (le32_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_TIMEOUT]) > 0)
 			bt->rfk_info.map.timeout = 1;
@@ -10479,42 +10627,44 @@ static void _show_summary_v4(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 		dm->error.map.wl_rfk_timeout = bt->rfk_info.map.timeout;
 	} else {
-		seq_printf(m,
-			   " %-15s : h2c_cnt=%d(fail:%d), c2h_cnt=%d, rpt_cnt=%d, rpt_map=0x%x",
-			   "[summary]", pfwinfo->cnt_h2c,
-			   pfwinfo->cnt_h2c_fail, pfwinfo->cnt_c2h,
-			   pfwinfo->event[BTF_EVNT_RPT],
-			   btc->fwinfo.rpt_en_map);
-		seq_puts(m, " (WL FW report invalid!!)\n");
+		p += scnprintf(p, end - p,
+			       " %-15s : h2c_cnt=%d(fail:%d), c2h_cnt=%d, rpt_cnt=%d, rpt_map=0x%x",
+			       "[summary]", pfwinfo->cnt_h2c,
+			       pfwinfo->cnt_h2c_fail, pfwinfo->cnt_c2h,
+			       pfwinfo->event[BTF_EVNT_RPT],
+			       btc->fwinfo.rpt_en_map);
+		p += scnprintf(p, end - p, " (WL FW report invalid!!)\n");
 	}
 
 	for (i = 0; i < BTC_NCNT_NUM; i++)
 		cnt_sum += dm->cnt_notify[i];
 
-	seq_printf(m,
-		   " %-15s : total=%d, show_coex_info=%d, power_on=%d, init_coex=%d, ",
-		   "[notify_cnt]", cnt_sum, cnt[BTC_NCNT_SHOW_COEX_INFO],
-		   cnt[BTC_NCNT_POWER_ON], cnt[BTC_NCNT_INIT_COEX]);
+	p += scnprintf(p, end - p,
+		       " %-15s : total=%d, show_coex_info=%d, power_on=%d, init_coex=%d, ",
+		       "[notify_cnt]", cnt_sum, cnt[BTC_NCNT_SHOW_COEX_INFO],
+		       cnt[BTC_NCNT_POWER_ON], cnt[BTC_NCNT_INIT_COEX]);
 
-	seq_printf(m,
-		   "power_off=%d, radio_state=%d, role_info=%d, wl_rfk=%d, wl_sta=%d\n",
-		   cnt[BTC_NCNT_POWER_OFF], cnt[BTC_NCNT_RADIO_STATE],
-		   cnt[BTC_NCNT_ROLE_INFO], cnt[BTC_NCNT_WL_RFK],
-		   cnt[BTC_NCNT_WL_STA]);
+	p += scnprintf(p, end - p,
+		       "power_off=%d, radio_state=%d, role_info=%d, wl_rfk=%d, wl_sta=%d\n",
+		       cnt[BTC_NCNT_POWER_OFF], cnt[BTC_NCNT_RADIO_STATE],
+		       cnt[BTC_NCNT_ROLE_INFO], cnt[BTC_NCNT_WL_RFK],
+		       cnt[BTC_NCNT_WL_STA]);
 
-	seq_printf(m,
-		   " %-15s : scan_start=%d, scan_finish=%d, switch_band=%d, special_pkt=%d, ",
-		   "[notify_cnt]", cnt[BTC_NCNT_SCAN_START],
-		   cnt[BTC_NCNT_SCAN_FINISH], cnt[BTC_NCNT_SWITCH_BAND],
-		   cnt[BTC_NCNT_SPECIAL_PACKET]);
+	p += scnprintf(p, end - p,
+		       " %-15s : scan_start=%d, scan_finish=%d, switch_band=%d, special_pkt=%d, ",
+		       "[notify_cnt]", cnt[BTC_NCNT_SCAN_START],
+		       cnt[BTC_NCNT_SCAN_FINISH], cnt[BTC_NCNT_SWITCH_BAND],
+		       cnt[BTC_NCNT_SPECIAL_PACKET]);
 
-	seq_printf(m,
-		   "timer=%d, control=%d, customerize=%d\n",
-		   cnt[BTC_NCNT_TIMER], cnt[BTC_NCNT_CONTROL],
-		   cnt[BTC_NCNT_CUSTOMERIZE]);
+	p += scnprintf(p, end - p,
+		       "timer=%d, control=%d, customerize=%d\n",
+		       cnt[BTC_NCNT_TIMER], cnt[BTC_NCNT_CONTROL],
+		       cnt[BTC_NCNT_CUSTOMERIZE]);
+
+	return p - buf;
 }
 
-static void _show_summary_v5(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_summary_v5(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
@@ -10524,112 +10674,118 @@ static void _show_summary_v5(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 	u32 cnt_sum = 0, *cnt = btc->dm.cnt_notify;
+	char *p = buf, *end = buf + bufsz;
 	u8 i;
 
 	if (!(dm->coex_info_map & BTC_COEX_INFO_SUMMARY))
-		return;
+		return 0;
 
-	seq_puts(m, "========== [Statistics] ==========\n");
+	p += scnprintf(p, end - p, "========== [Statistics] ==========\n");
 
 	pcinfo = &pfwinfo->rpt_ctrl.cinfo;
 	if (pcinfo->valid && !wl->status.map.lps && !wl->status.map.rf_off) {
 		prptctrl = &pfwinfo->rpt_ctrl.finfo.v5;
 
-		seq_printf(m,
-			   " %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d), c2h_cnt=%d(fw_send:%d, len:%d), ",
-			   "[summary]", pfwinfo->cnt_h2c, pfwinfo->cnt_h2c_fail,
-			   le16_to_cpu(prptctrl->rpt_info.cnt_h2c),
-			   pfwinfo->cnt_c2h,
-			   le16_to_cpu(prptctrl->rpt_info.cnt_c2h),
-			   le16_to_cpu(prptctrl->rpt_info.len_c2h));
-
-		seq_printf(m,
-			   "rpt_cnt=%d(fw_send:%d), rpt_map=0x%x",
-			   pfwinfo->event[BTF_EVNT_RPT],
-			   le16_to_cpu(prptctrl->rpt_info.cnt),
-			   le32_to_cpu(prptctrl->rpt_info.en));
+		p += scnprintf(p, end - p,
+			       " %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d), c2h_cnt=%d(fw_send:%d, len:%d), ",
+			       "[summary]", pfwinfo->cnt_h2c,
+			       pfwinfo->cnt_h2c_fail,
+			       le16_to_cpu(prptctrl->rpt_info.cnt_h2c),
+			       pfwinfo->cnt_c2h,
+			       le16_to_cpu(prptctrl->rpt_info.cnt_c2h),
+			       le16_to_cpu(prptctrl->rpt_info.len_c2h));
+
+		p += scnprintf(p, end - p,
+			       "rpt_cnt=%d(fw_send:%d), rpt_map=0x%x",
+			       pfwinfo->event[BTF_EVNT_RPT],
+			       le16_to_cpu(prptctrl->rpt_info.cnt),
+			       le32_to_cpu(prptctrl->rpt_info.en));
 
 		if (dm->error.map.wl_fw_hang)
-			seq_puts(m, " (WL FW Hang!!)");
-		seq_puts(m, "\n");
-		seq_printf(m,
-			   " %-15s : send_ok:%d, send_fail:%d, recv:%d, ",
-			   "[mailbox]",
-			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_ok),
-			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_fail),
-			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_recv));
-
-		seq_printf(m,
-			   "A2DP_empty:%d(stop:%d, tx:%d, ack:%d, nack:%d)\n",
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_empty),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_flowctrl),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_tx),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_ack),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_nack));
-
-		seq_printf(m,
-			   " %-15s : wl_rfk[req:%d/go:%d/reject:%d/tout:%d]",
-			   "[RFK/LPS]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
-			   cx->cnt_wl[BTC_WCNT_RFK_GO],
-			   cx->cnt_wl[BTC_WCNT_RFK_REJECT],
-			   cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT]);
-
-		seq_printf(m,
-			   ", bt_rfk[req:%d]",
-			   le16_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_REQ]));
-
-		seq_printf(m,
-			   ", AOAC[RF_on:%d/RF_off:%d]",
-			   le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_on),
-			   le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_off));
+			p += scnprintf(p, end - p, " (WL FW Hang!!)");
+		p += scnprintf(p, end - p, "\n");
+		p += scnprintf(p, end - p,
+			       " %-15s : send_ok:%d, send_fail:%d, recv:%d, ",
+			       "[mailbox]",
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_ok),
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_fail),
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_recv));
+
+		p += scnprintf(p, end - p,
+			       "A2DP_empty:%d(stop:%d, tx:%d, ack:%d, nack:%d)\n",
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_empty),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_flowctrl),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_tx),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_ack),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_nack));
+
+		p += scnprintf(p, end - p,
+			       " %-15s : wl_rfk[req:%d/go:%d/reject:%d/tout:%d]",
+			       "[RFK/LPS]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
+			       cx->cnt_wl[BTC_WCNT_RFK_GO],
+			       cx->cnt_wl[BTC_WCNT_RFK_REJECT],
+			       cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT]);
+
+		p += scnprintf(p, end - p,
+			       ", bt_rfk[req:%d]",
+			       le16_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_REQ]));
+
+		p += scnprintf(p, end - p,
+			       ", AOAC[RF_on:%d/RF_off:%d]",
+			       le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_on),
+			       le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_off));
 	} else {
-		seq_printf(m,
-			   " %-15s : h2c_cnt=%d(fail:%d), c2h_cnt=%d",
-			   "[summary]", pfwinfo->cnt_h2c,
-			   pfwinfo->cnt_h2c_fail, pfwinfo->cnt_c2h);
+		p += scnprintf(p, end - p,
+			       " %-15s : h2c_cnt=%d(fail:%d), c2h_cnt=%d",
+			       "[summary]", pfwinfo->cnt_h2c,
+			       pfwinfo->cnt_h2c_fail, pfwinfo->cnt_c2h);
 	}
 
 	if (!pcinfo->valid || pfwinfo->len_mismch || pfwinfo->fver_mismch ||
 	    pfwinfo->err[BTFRE_EXCEPTION]) {
-		seq_puts(m, "\n");
-		seq_printf(m,
-			   " %-15s : WL FW rpt error!![rpt_ctrl_valid:%d/len:"
-			   "0x%x/ver:0x%x/ex:%d/lps=%d/rf_off=%d]",
-			   "[ERROR]", pcinfo->valid, pfwinfo->len_mismch,
-			   pfwinfo->fver_mismch, pfwinfo->err[BTFRE_EXCEPTION],
-			   wl->status.map.lps, wl->status.map.rf_off);
+		p += scnprintf(p, end - p, "\n");
+		p += scnprintf(p, end - p,
+			       " %-15s : WL FW rpt error!![rpt_ctrl_valid:%d/len:"
+			       "0x%x/ver:0x%x/ex:%d/lps=%d/rf_off=%d]",
+			       "[ERROR]", pcinfo->valid, pfwinfo->len_mismch,
+			       pfwinfo->fver_mismch,
+			       pfwinfo->err[BTFRE_EXCEPTION],
+			       wl->status.map.lps, wl->status.map.rf_off);
 	}
 
 	for (i = 0; i < BTC_NCNT_NUM; i++)
 		cnt_sum += dm->cnt_notify[i];
 
-	seq_puts(m, "\n");
-	seq_printf(m,
-		   " %-15s : total=%d, show_coex_info=%d, power_on=%d, init_coex=%d, ",
-		   "[notify_cnt]",
-		   cnt_sum, cnt[BTC_NCNT_SHOW_COEX_INFO],
-		   cnt[BTC_NCNT_POWER_ON], cnt[BTC_NCNT_INIT_COEX]);
+	p += scnprintf(p, end - p, "\n");
+	p += scnprintf(p, end - p,
+		       " %-15s : total=%d, show_coex_info=%d, power_on=%d, init_coex=%d, ",
+		       "[notify_cnt]",
+		       cnt_sum, cnt[BTC_NCNT_SHOW_COEX_INFO],
+		       cnt[BTC_NCNT_POWER_ON], cnt[BTC_NCNT_INIT_COEX]);
 
-	seq_printf(m,
-		   "power_off=%d, radio_state=%d, role_info=%d, wl_rfk=%d, wl_sta=%d",
-		   cnt[BTC_NCNT_POWER_OFF], cnt[BTC_NCNT_RADIO_STATE],
-		   cnt[BTC_NCNT_ROLE_INFO], cnt[BTC_NCNT_WL_RFK],
-		   cnt[BTC_NCNT_WL_STA]);
+	p += scnprintf(p, end - p,
+		       "power_off=%d, radio_state=%d, role_info=%d, wl_rfk=%d, wl_sta=%d",
+		       cnt[BTC_NCNT_POWER_OFF], cnt[BTC_NCNT_RADIO_STATE],
+		       cnt[BTC_NCNT_ROLE_INFO], cnt[BTC_NCNT_WL_RFK],
+		       cnt[BTC_NCNT_WL_STA]);
 
-	seq_puts(m, "\n");
-	seq_printf(m,
-		   " %-15s : scan_start=%d, scan_finish=%d, switch_band=%d, special_pkt=%d, ",
-		   "[notify_cnt]",
-		   cnt[BTC_NCNT_SCAN_START], cnt[BTC_NCNT_SCAN_FINISH],
-		   cnt[BTC_NCNT_SWITCH_BAND], cnt[BTC_NCNT_SPECIAL_PACKET]);
+	p += scnprintf(p, end - p, "\n");
+	p += scnprintf(p, end - p,
+		       " %-15s : scan_start=%d, scan_finish=%d, switch_band=%d, special_pkt=%d, ",
+		       "[notify_cnt]",
+		       cnt[BTC_NCNT_SCAN_START], cnt[BTC_NCNT_SCAN_FINISH],
+		       cnt[BTC_NCNT_SWITCH_BAND],
+		       cnt[BTC_NCNT_SPECIAL_PACKET]);
 
-	seq_printf(m,
-		   "timer=%d, control=%d, customerize=%d",
-		   cnt[BTC_NCNT_TIMER], cnt[BTC_NCNT_CONTROL],
-		   cnt[BTC_NCNT_CUSTOMERIZE]);
+	p += scnprintf(p, end - p,
+		       "timer=%d, control=%d, customerize=%d",
+		       cnt[BTC_NCNT_TIMER], cnt[BTC_NCNT_CONTROL],
+		       cnt[BTC_NCNT_CUSTOMERIZE]);
+
+	return p - buf;
 }
 
-static void _show_summary_v105(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_summary_v105(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
@@ -10639,112 +10795,118 @@ static void _show_summary_v105(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 	u32 cnt_sum = 0, *cnt = btc->dm.cnt_notify;
+	char *p = buf, *end = buf + bufsz;
 	u8 i;
 
 	if (!(dm->coex_info_map & BTC_COEX_INFO_SUMMARY))
-		return;
+		return 0;
 
-	seq_puts(m, "========== [Statistics] ==========\n");
+	p += scnprintf(p, end - p, "========== [Statistics] ==========\n");
 
 	pcinfo = &pfwinfo->rpt_ctrl.cinfo;
 	if (pcinfo->valid && !wl->status.map.lps && !wl->status.map.rf_off) {
 		prptctrl = &pfwinfo->rpt_ctrl.finfo.v105;
 
-		seq_printf(m,
-			   " %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d), c2h_cnt=%d(fw_send:%d, len:%d), ",
-			   "[summary]", pfwinfo->cnt_h2c, pfwinfo->cnt_h2c_fail,
-			   le16_to_cpu(prptctrl->rpt_info.cnt_h2c),
-			   pfwinfo->cnt_c2h,
-			   le16_to_cpu(prptctrl->rpt_info.cnt_c2h),
-			   le16_to_cpu(prptctrl->rpt_info.len_c2h));
-
-		seq_printf(m,
-			   "rpt_cnt=%d(fw_send:%d), rpt_map=0x%x",
-			   pfwinfo->event[BTF_EVNT_RPT],
-			   le16_to_cpu(prptctrl->rpt_info.cnt),
-			   le32_to_cpu(prptctrl->rpt_info.en));
+		p += scnprintf(p, end - p,
+			       " %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d), c2h_cnt=%d(fw_send:%d, len:%d), ",
+			       "[summary]", pfwinfo->cnt_h2c,
+			       pfwinfo->cnt_h2c_fail,
+			       le16_to_cpu(prptctrl->rpt_info.cnt_h2c),
+			       pfwinfo->cnt_c2h,
+			       le16_to_cpu(prptctrl->rpt_info.cnt_c2h),
+			       le16_to_cpu(prptctrl->rpt_info.len_c2h));
+
+		p += scnprintf(p, end - p,
+			       "rpt_cnt=%d(fw_send:%d), rpt_map=0x%x",
+			       pfwinfo->event[BTF_EVNT_RPT],
+			       le16_to_cpu(prptctrl->rpt_info.cnt),
+			       le32_to_cpu(prptctrl->rpt_info.en));
 
 		if (dm->error.map.wl_fw_hang)
-			seq_puts(m, " (WL FW Hang!!)");
-		seq_puts(m, "\n");
-		seq_printf(m,
-			   " %-15s : send_ok:%d, send_fail:%d, recv:%d, ",
-			   "[mailbox]",
-			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_ok),
-			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_fail),
-			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_recv));
-
-		seq_printf(m,
-			   "A2DP_empty:%d(stop:%d, tx:%d, ack:%d, nack:%d)\n",
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_empty),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_flowctrl),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_tx),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_ack),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_nack));
-
-		seq_printf(m,
-			   " %-15s : wl_rfk[req:%d/go:%d/reject:%d/tout:%d]",
-			   "[RFK/LPS]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
-			   cx->cnt_wl[BTC_WCNT_RFK_GO],
-			   cx->cnt_wl[BTC_WCNT_RFK_REJECT],
-			   cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT]);
-
-		seq_printf(m,
-			   ", bt_rfk[req:%d]",
-			   le16_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_REQ]));
-
-		seq_printf(m,
-			   ", AOAC[RF_on:%d/RF_off:%d]",
-			   le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_on),
-			   le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_off));
+			p += scnprintf(p, end - p, " (WL FW Hang!!)");
+		p += scnprintf(p, end - p, "\n");
+		p += scnprintf(p, end - p,
+			       " %-15s : send_ok:%d, send_fail:%d, recv:%d, ",
+			       "[mailbox]",
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_ok),
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_fail),
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_recv));
+
+		p += scnprintf(p, end - p,
+			       "A2DP_empty:%d(stop:%d, tx:%d, ack:%d, nack:%d)\n",
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_empty),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_flowctrl),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_tx),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_ack),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_nack));
+
+		p += scnprintf(p, end - p,
+			       " %-15s : wl_rfk[req:%d/go:%d/reject:%d/tout:%d]",
+			       "[RFK/LPS]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
+			       cx->cnt_wl[BTC_WCNT_RFK_GO],
+			       cx->cnt_wl[BTC_WCNT_RFK_REJECT],
+			       cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT]);
+
+		p += scnprintf(p, end - p,
+			       ", bt_rfk[req:%d]",
+			       le16_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_REQ]));
+
+		p += scnprintf(p, end - p,
+			       ", AOAC[RF_on:%d/RF_off:%d]",
+			       le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_on),
+			       le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_off));
 	} else {
-		seq_printf(m,
-			   " %-15s : h2c_cnt=%d(fail:%d), c2h_cnt=%d",
-			   "[summary]", pfwinfo->cnt_h2c,
-			   pfwinfo->cnt_h2c_fail, pfwinfo->cnt_c2h);
+		p += scnprintf(p, end - p,
+			       " %-15s : h2c_cnt=%d(fail:%d), c2h_cnt=%d",
+			       "[summary]", pfwinfo->cnt_h2c,
+			       pfwinfo->cnt_h2c_fail, pfwinfo->cnt_c2h);
 	}
 
 	if (!pcinfo->valid || pfwinfo->len_mismch || pfwinfo->fver_mismch ||
 	    pfwinfo->err[BTFRE_EXCEPTION]) {
-		seq_puts(m, "\n");
-		seq_printf(m,
-			   " %-15s : WL FW rpt error!![rpt_ctrl_valid:%d/len:"
-			   "0x%x/ver:0x%x/ex:%d/lps=%d/rf_off=%d]",
-			   "[ERROR]", pcinfo->valid, pfwinfo->len_mismch,
-			   pfwinfo->fver_mismch, pfwinfo->err[BTFRE_EXCEPTION],
-			   wl->status.map.lps, wl->status.map.rf_off);
+		p += scnprintf(p, end - p, "\n");
+		p += scnprintf(p, end - p,
+			       " %-15s : WL FW rpt error!![rpt_ctrl_valid:%d/len:"
+			       "0x%x/ver:0x%x/ex:%d/lps=%d/rf_off=%d]",
+			       "[ERROR]", pcinfo->valid, pfwinfo->len_mismch,
+			       pfwinfo->fver_mismch,
+			       pfwinfo->err[BTFRE_EXCEPTION],
+			       wl->status.map.lps, wl->status.map.rf_off);
 	}
 
 	for (i = 0; i < BTC_NCNT_NUM; i++)
 		cnt_sum += dm->cnt_notify[i];
 
-	seq_puts(m, "\n");
-	seq_printf(m,
-		   " %-15s : total=%d, show_coex_info=%d, power_on=%d, init_coex=%d, ",
-		   "[notify_cnt]",
-		   cnt_sum, cnt[BTC_NCNT_SHOW_COEX_INFO],
-		   cnt[BTC_NCNT_POWER_ON], cnt[BTC_NCNT_INIT_COEX]);
+	p += scnprintf(p, end - p, "\n");
+	p += scnprintf(p, end - p,
+		       " %-15s : total=%d, show_coex_info=%d, power_on=%d, init_coex=%d, ",
+		       "[notify_cnt]",
+		       cnt_sum, cnt[BTC_NCNT_SHOW_COEX_INFO],
+		       cnt[BTC_NCNT_POWER_ON], cnt[BTC_NCNT_INIT_COEX]);
 
-	seq_printf(m,
-		   "power_off=%d, radio_state=%d, role_info=%d, wl_rfk=%d, wl_sta=%d",
-		   cnt[BTC_NCNT_POWER_OFF], cnt[BTC_NCNT_RADIO_STATE],
-		   cnt[BTC_NCNT_ROLE_INFO], cnt[BTC_NCNT_WL_RFK],
-		   cnt[BTC_NCNT_WL_STA]);
+	p += scnprintf(p, end - p,
+		       "power_off=%d, radio_state=%d, role_info=%d, wl_rfk=%d, wl_sta=%d",
+		       cnt[BTC_NCNT_POWER_OFF], cnt[BTC_NCNT_RADIO_STATE],
+		       cnt[BTC_NCNT_ROLE_INFO], cnt[BTC_NCNT_WL_RFK],
+		       cnt[BTC_NCNT_WL_STA]);
 
-	seq_puts(m, "\n");
-	seq_printf(m,
-		   " %-15s : scan_start=%d, scan_finish=%d, switch_band=%d, special_pkt=%d, ",
-		   "[notify_cnt]",
-		   cnt[BTC_NCNT_SCAN_START], cnt[BTC_NCNT_SCAN_FINISH],
-		   cnt[BTC_NCNT_SWITCH_BAND], cnt[BTC_NCNT_SPECIAL_PACKET]);
+	p += scnprintf(p, end - p, "\n");
+	p += scnprintf(p, end - p,
+		       " %-15s : scan_start=%d, scan_finish=%d, switch_band=%d, special_pkt=%d, ",
+		       "[notify_cnt]",
+		       cnt[BTC_NCNT_SCAN_START], cnt[BTC_NCNT_SCAN_FINISH],
+		       cnt[BTC_NCNT_SWITCH_BAND],
+		       cnt[BTC_NCNT_SPECIAL_PACKET]);
 
-	seq_printf(m,
-		   "timer=%d, control=%d, customerize=%d",
-		   cnt[BTC_NCNT_TIMER], cnt[BTC_NCNT_CONTROL],
-		   cnt[BTC_NCNT_CUSTOMERIZE]);
+	p += scnprintf(p, end - p,
+		       "timer=%d, control=%d, customerize=%d",
+		       cnt[BTC_NCNT_TIMER], cnt[BTC_NCNT_CONTROL],
+		       cnt[BTC_NCNT_CUSTOMERIZE]);
+
+	return p - buf;
 }
 
-static void _show_summary_v7(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_summary_v7(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &rtwdev->btc.fwinfo;
 	struct rtw89_btc_fbtc_rpt_ctrl_v7 *prptctrl = NULL;
@@ -10753,100 +10915,111 @@ static void _show_summary_v7(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 	u32 *cnt = rtwdev->btc.dm.cnt_notify;
+	char *p = buf, *end = buf + bufsz;
 	u32 cnt_sum = 0;
 	u8 i;
 
 	if (!(dm->coex_info_map & BTC_COEX_INFO_SUMMARY))
-		return;
+		return 0;
 
-	seq_printf(m, "%s", "\n\r========== [Statistics] ==========");
+	p += scnprintf(p, end - p, "%s",
+		       "\n\r========== [Statistics] ==========");
 
 	pcinfo = &pfwinfo->rpt_ctrl.cinfo;
 	if (pcinfo->valid && wl->status.map.lps != BTC_LPS_RF_OFF &&
 	    !wl->status.map.rf_off) {
 		prptctrl = &pfwinfo->rpt_ctrl.finfo.v7;
 
-		seq_printf(m,
-			   "\n\r %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d),"
-			   "c2h_cnt=%d(fw_send:%d, len:%d, max:%d), ",
-			   "[summary]", pfwinfo->cnt_h2c, pfwinfo->cnt_h2c_fail,
-			   le16_to_cpu(prptctrl->rpt_info.cnt_h2c), pfwinfo->cnt_c2h,
-			   le16_to_cpu(prptctrl->rpt_info.cnt_c2h),
-			   le16_to_cpu(prptctrl->rpt_info.len_c2h),
-			   rtwdev->btc.ver->info_buf);
-
-		seq_printf(m, "rpt_cnt=%d(fw_send:%d), rpt_map=0x%x",
-			   pfwinfo->event[BTF_EVNT_RPT],
-			   le16_to_cpu(prptctrl->rpt_info.cnt),
-			   le32_to_cpu(prptctrl->rpt_info.en));
+		p += scnprintf(p, end - p,
+			       "\n\r %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d),"
+			       "c2h_cnt=%d(fw_send:%d, len:%d, max:%d), ",
+			       "[summary]", pfwinfo->cnt_h2c,
+			       pfwinfo->cnt_h2c_fail,
+			       le16_to_cpu(prptctrl->rpt_info.cnt_h2c),
+			       pfwinfo->cnt_c2h,
+			       le16_to_cpu(prptctrl->rpt_info.cnt_c2h),
+			       le16_to_cpu(prptctrl->rpt_info.len_c2h),
+			       rtwdev->btc.ver->info_buf);
+
+		p += scnprintf(p, end - p,
+			       "rpt_cnt=%d(fw_send:%d), rpt_map=0x%x",
+			       pfwinfo->event[BTF_EVNT_RPT],
+			       le16_to_cpu(prptctrl->rpt_info.cnt),
+			       le32_to_cpu(prptctrl->rpt_info.en));
 
 		if (dm->error.map.wl_fw_hang)
-			seq_puts(m, " (WL FW Hang!!)");
-
-		seq_printf(m, "\n\r %-15s : send_ok:%d, send_fail:%d, recv:%d, ",
-			   "[mailbox]", le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_ok),
-			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_fail),
-			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_recv));
-
-		seq_printf(m, "A2DP_empty:%d(stop:%d/tx:%d/ack:%d/nack:%d)",
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_empty),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_flowctrl),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_tx),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_ack),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_nack));
-
-		seq_printf(m,
-			   "\n\r %-15s : wl_rfk[req:%d/go:%d/reject:%d/tout:%d/time:%dms]",
-			   "[RFK/LPS]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
-			   cx->cnt_wl[BTC_WCNT_RFK_GO],
-			   cx->cnt_wl[BTC_WCNT_RFK_REJECT],
-			   cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT],
-			   wl->rfk_info.proc_time);
-
-		seq_printf(m, ", bt_rfk[req:%d]",
-			   le16_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_REQ]));
-
-		seq_printf(m, ", AOAC[RF_on:%d/RF_off:%d]",
-			   le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_on),
-			   le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_off));
+			p += scnprintf(p, end - p, " (WL FW Hang!!)");
+
+		p += scnprintf(p, end - p,
+			       "\n\r %-15s : send_ok:%d, send_fail:%d, recv:%d, ",
+			       "[mailbox]",
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_ok),
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_fail),
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_recv));
+
+		p += scnprintf(p, end - p,
+			       "A2DP_empty:%d(stop:%d/tx:%d/ack:%d/nack:%d)",
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_empty),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_flowctrl),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_tx),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_ack),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_nack));
+
+		p += scnprintf(p, end - p,
+			       "\n\r %-15s : wl_rfk[req:%d/go:%d/reject:%d/tout:%d/time:%dms]",
+			       "[RFK/LPS]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
+			       cx->cnt_wl[BTC_WCNT_RFK_GO],
+			       cx->cnt_wl[BTC_WCNT_RFK_REJECT],
+			       cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT],
+			       wl->rfk_info.proc_time);
+
+		p += scnprintf(p, end - p, ", bt_rfk[req:%d]",
+			       le16_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_REQ]));
+
+		p += scnprintf(p, end - p, ", AOAC[RF_on:%d/RF_off:%d]",
+			       le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_on),
+			       le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_off));
 	} else {
-		seq_printf(m,
-			   "\n\r %-15s : h2c_cnt=%d(fail:%d), c2h_cnt=%d (lps=%d/rf_off=%d)",
-			   "[summary]",
-			   pfwinfo->cnt_h2c, pfwinfo->cnt_h2c_fail,
-			   pfwinfo->cnt_c2h,
-			   wl->status.map.lps, wl->status.map.rf_off);
+		p += scnprintf(p, end - p,
+			       "\n\r %-15s : h2c_cnt=%d(fail:%d), c2h_cnt=%d (lps=%d/rf_off=%d)",
+			       "[summary]",
+			       pfwinfo->cnt_h2c, pfwinfo->cnt_h2c_fail,
+			       pfwinfo->cnt_c2h,
+			       wl->status.map.lps, wl->status.map.rf_off);
 	}
 
 	for (i = 0; i < BTC_NCNT_NUM; i++)
 		cnt_sum += dm->cnt_notify[i];
 
-	seq_printf(m,
-		   "\n\r %-15s : total=%d, show_coex_info=%d, power_on=%d, init_coex=%d, ",
-		   "[notify_cnt]",
-		   cnt_sum, cnt[BTC_NCNT_SHOW_COEX_INFO],
-		   cnt[BTC_NCNT_POWER_ON], cnt[BTC_NCNT_INIT_COEX]);
+	p += scnprintf(p, end - p,
+		       "\n\r %-15s : total=%d, show_coex_info=%d, power_on=%d, init_coex=%d, ",
+		       "[notify_cnt]",
+		       cnt_sum, cnt[BTC_NCNT_SHOW_COEX_INFO],
+		       cnt[BTC_NCNT_POWER_ON], cnt[BTC_NCNT_INIT_COEX]);
 
-	seq_printf(m,
-		   "power_off=%d, radio_state=%d, role_info=%d, wl_rfk=%d, wl_sta=%d",
-		   cnt[BTC_NCNT_POWER_OFF], cnt[BTC_NCNT_RADIO_STATE],
-		   cnt[BTC_NCNT_ROLE_INFO], cnt[BTC_NCNT_WL_RFK],
-		   cnt[BTC_NCNT_WL_STA]);
+	p += scnprintf(p, end - p,
+		       "power_off=%d, radio_state=%d, role_info=%d, wl_rfk=%d, wl_sta=%d",
+		       cnt[BTC_NCNT_POWER_OFF], cnt[BTC_NCNT_RADIO_STATE],
+		       cnt[BTC_NCNT_ROLE_INFO], cnt[BTC_NCNT_WL_RFK],
+		       cnt[BTC_NCNT_WL_STA]);
 
-	seq_printf(m,
-		   "\n\r %-15s : scan_start=%d, scan_finish=%d, switch_band=%d, switch_chbw=%d, special_pkt=%d, ",
-		   "[notify_cnt]",
-		   cnt[BTC_NCNT_SCAN_START], cnt[BTC_NCNT_SCAN_FINISH],
-		   cnt[BTC_NCNT_SWITCH_BAND], cnt[BTC_NCNT_SWITCH_CHBW],
-		   cnt[BTC_NCNT_SPECIAL_PACKET]);
+	p += scnprintf(p, end - p,
+		       "\n\r %-15s : scan_start=%d, scan_finish=%d, switch_band=%d, switch_chbw=%d, special_pkt=%d, ",
+		       "[notify_cnt]",
+		       cnt[BTC_NCNT_SCAN_START], cnt[BTC_NCNT_SCAN_FINISH],
+		       cnt[BTC_NCNT_SWITCH_BAND], cnt[BTC_NCNT_SWITCH_CHBW],
+		       cnt[BTC_NCNT_SPECIAL_PACKET]);
 
-	seq_printf(m, "timer=%d, customerize=%d, hub_msg=%d, chg_fw=%d, send_cc=%d",
-		   cnt[BTC_NCNT_TIMER], cnt[BTC_NCNT_CUSTOMERIZE],
-		   rtwdev->btc.hubmsg_cnt, cnt[BTC_NCNT_RESUME_DL_FW],
-		   cnt[BTC_NCNT_COUNTRYCODE]);
+	p += scnprintf(p, end - p,
+		       "timer=%d, customerize=%d, hub_msg=%d, chg_fw=%d, send_cc=%d",
+		       cnt[BTC_NCNT_TIMER], cnt[BTC_NCNT_CUSTOMERIZE],
+		       rtwdev->btc.hubmsg_cnt, cnt[BTC_NCNT_RESUME_DL_FW],
+		       cnt[BTC_NCNT_COUNTRYCODE]);
+
+	return p - buf;
 }
 
-static void _show_summary_v8(struct rtw89_dev *rtwdev, struct seq_file *m)
+static int _show_summary_v8(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &rtwdev->btc.fwinfo;
 	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
@@ -10855,153 +11028,173 @@ static void _show_summary_v8(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 	u32 *cnt = rtwdev->btc.dm.cnt_notify;
+	char *p = buf, *end = buf + bufsz;
 	u32 cnt_sum = 0;
 	u8 i;
 
 	if (!(dm->coex_info_map & BTC_COEX_INFO_SUMMARY))
-		return;
+		return 0;
 
-	seq_printf(m, "%s", "\n\r========== [Statistics] ==========");
+	p += scnprintf(p, end - p, "%s",
+		       "\n\r========== [Statistics] ==========");
 
 	pcinfo = &pfwinfo->rpt_ctrl.cinfo;
 	if (pcinfo->valid && wl->status.map.lps != BTC_LPS_RF_OFF &&
 	    !wl->status.map.rf_off) {
 		prptctrl = &pfwinfo->rpt_ctrl.finfo.v8;
 
-		seq_printf(m,
-			   "\n\r %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d), c2h_cnt=%d(fw_send:%d, len:%d, max:fw-%d/drv-%d), ",
-			   "[summary]", pfwinfo->cnt_h2c, pfwinfo->cnt_h2c_fail,
-			   le16_to_cpu(prptctrl->rpt_info.cnt_h2c), pfwinfo->cnt_c2h,
-			   le16_to_cpu(prptctrl->rpt_info.cnt_c2h),
-			   le16_to_cpu(prptctrl->rpt_info.len_c2h),
-			   (prptctrl->rpt_len_max_h << 8) + prptctrl->rpt_len_max_l,
-			   rtwdev->btc.ver->info_buf);
-
-		seq_printf(m, "rpt_cnt=%d(fw_send:%d), rpt_map=0x%x",
-			   pfwinfo->event[BTF_EVNT_RPT],
-			   le16_to_cpu(prptctrl->rpt_info.cnt),
-			   le32_to_cpu(prptctrl->rpt_info.en));
+		p += scnprintf(p, end - p,
+			       "\n\r %-15s : h2c_cnt=%d(fail:%d, fw_recv:%d), c2h_cnt=%d(fw_send:%d, len:%d, max:fw-%d/drv-%d), ",
+			       "[summary]", pfwinfo->cnt_h2c,
+			       pfwinfo->cnt_h2c_fail,
+			       le16_to_cpu(prptctrl->rpt_info.cnt_h2c),
+			       pfwinfo->cnt_c2h,
+			       le16_to_cpu(prptctrl->rpt_info.cnt_c2h),
+			       le16_to_cpu(prptctrl->rpt_info.len_c2h),
+			       (prptctrl->rpt_len_max_h << 8) + prptctrl->rpt_len_max_l,
+			       rtwdev->btc.ver->info_buf);
+
+		p += scnprintf(p, end - p,
+			       "rpt_cnt=%d(fw_send:%d), rpt_map=0x%x",
+			       pfwinfo->event[BTF_EVNT_RPT],
+			       le16_to_cpu(prptctrl->rpt_info.cnt),
+			       le32_to_cpu(prptctrl->rpt_info.en));
 
 		if (dm->error.map.wl_fw_hang)
-			seq_puts(m, " (WL FW Hang!!)");
-
-		seq_printf(m, "\n\r %-15s : send_ok:%d, send_fail:%d, recv:%d, ",
-			   "[mailbox]", le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_ok),
-			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_fail),
-			   le32_to_cpu(prptctrl->bt_mbx_info.cnt_recv));
-
-		seq_printf(m, "A2DP_empty:%d(stop:%d/tx:%d/ack:%d/nack:%d)",
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_empty),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_flowctrl),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_tx),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_ack),
-			   le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_nack));
-
-		seq_printf(m,
-			   "\n\r %-15s : wl_rfk[req:%d/go:%d/reject:%d/tout:%d/time:%dms]",
-			   "[RFK/LPS]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
-			   cx->cnt_wl[BTC_WCNT_RFK_GO],
-			   cx->cnt_wl[BTC_WCNT_RFK_REJECT],
-			   cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT],
-			   wl->rfk_info.proc_time);
-
-		seq_printf(m, ", bt_rfk[req:%d]",
-			   le16_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_REQ]));
-
-		seq_printf(m, ", AOAC[RF_on:%d/RF_off:%d]",
-			   le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_on),
-			   le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_off));
+			p += scnprintf(p, end - p, " (WL FW Hang!!)");
+
+		p += scnprintf(p, end - p,
+			       "\n\r %-15s : send_ok:%d, send_fail:%d, recv:%d, ",
+			       "[mailbox]",
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_ok),
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_send_fail),
+			       le32_to_cpu(prptctrl->bt_mbx_info.cnt_recv));
+
+		p += scnprintf(p, end - p,
+			       "A2DP_empty:%d(stop:%d/tx:%d/ack:%d/nack:%d)",
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_empty),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_flowctrl),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_tx),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_ack),
+			       le32_to_cpu(prptctrl->bt_mbx_info.a2dp.cnt_nack));
+
+		p += scnprintf(p, end - p,
+			       "\n\r %-15s : wl_rfk[req:%d/go:%d/reject:%d/tout:%d/time:%dms]",
+			       "[RFK/LPS]", cx->cnt_wl[BTC_WCNT_RFK_REQ],
+			       cx->cnt_wl[BTC_WCNT_RFK_GO],
+			       cx->cnt_wl[BTC_WCNT_RFK_REJECT],
+			       cx->cnt_wl[BTC_WCNT_RFK_TIMEOUT],
+			       wl->rfk_info.proc_time);
+
+		p += scnprintf(p, end - p, ", bt_rfk[req:%d]",
+			       le16_to_cpu(prptctrl->bt_cnt[BTC_BCNT_RFK_REQ]));
+
+		p += scnprintf(p, end - p, ", AOAC[RF_on:%d/RF_off:%d]",
+			       le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_on),
+			       le16_to_cpu(prptctrl->rpt_info.cnt_aoac_rf_off));
 	} else {
-		seq_printf(m,
-			   "\n\r %-15s : h2c_cnt=%d(fail:%d), c2h_cnt=%d (lps=%d/rf_off=%d)",
-			   "[summary]",
-			   pfwinfo->cnt_h2c, pfwinfo->cnt_h2c_fail,
-			   pfwinfo->cnt_c2h,
-			   wl->status.map.lps, wl->status.map.rf_off);
+		p += scnprintf(p, end - p,
+			       "\n\r %-15s : h2c_cnt=%d(fail:%d), c2h_cnt=%d (lps=%d/rf_off=%d)",
+			       "[summary]",
+			       pfwinfo->cnt_h2c, pfwinfo->cnt_h2c_fail,
+			       pfwinfo->cnt_c2h,
+			       wl->status.map.lps, wl->status.map.rf_off);
 	}
 
 	for (i = 0; i < BTC_NCNT_NUM; i++)
 		cnt_sum += dm->cnt_notify[i];
 
-	seq_printf(m,
-		   "\n\r %-15s : total=%d, show_coex_info=%d, power_on=%d, init_coex=%d, ",
-		   "[notify_cnt]",
-		   cnt_sum, cnt[BTC_NCNT_SHOW_COEX_INFO],
-		   cnt[BTC_NCNT_POWER_ON], cnt[BTC_NCNT_INIT_COEX]);
+	p += scnprintf(p, end - p,
+		       "\n\r %-15s : total=%d, show_coex_info=%d, power_on=%d, init_coex=%d, ",
+		       "[notify_cnt]",
+		       cnt_sum, cnt[BTC_NCNT_SHOW_COEX_INFO],
+		       cnt[BTC_NCNT_POWER_ON], cnt[BTC_NCNT_INIT_COEX]);
 
-	seq_printf(m,
-		   "power_off=%d, radio_state=%d, role_info=%d, wl_rfk=%d, wl_sta=%d",
-		   cnt[BTC_NCNT_POWER_OFF], cnt[BTC_NCNT_RADIO_STATE],
-		   cnt[BTC_NCNT_ROLE_INFO], cnt[BTC_NCNT_WL_RFK],
-		   cnt[BTC_NCNT_WL_STA]);
+	p += scnprintf(p, end - p,
+		       "power_off=%d, radio_state=%d, role_info=%d, wl_rfk=%d, wl_sta=%d",
+		       cnt[BTC_NCNT_POWER_OFF], cnt[BTC_NCNT_RADIO_STATE],
+		       cnt[BTC_NCNT_ROLE_INFO], cnt[BTC_NCNT_WL_RFK],
+		       cnt[BTC_NCNT_WL_STA]);
 
-	seq_printf(m,
-		   "\n\r %-15s : scan_start=%d, scan_finish=%d, switch_band=%d, switch_chbw=%d, special_pkt=%d, ",
-		   "[notify_cnt]",
-		   cnt[BTC_NCNT_SCAN_START], cnt[BTC_NCNT_SCAN_FINISH],
-		   cnt[BTC_NCNT_SWITCH_BAND], cnt[BTC_NCNT_SWITCH_CHBW],
-		   cnt[BTC_NCNT_SPECIAL_PACKET]);
+	p += scnprintf(p, end - p,
+		       "\n\r %-15s : scan_start=%d, scan_finish=%d, switch_band=%d, switch_chbw=%d, special_pkt=%d, ",
+		       "[notify_cnt]",
+		       cnt[BTC_NCNT_SCAN_START], cnt[BTC_NCNT_SCAN_FINISH],
+		       cnt[BTC_NCNT_SWITCH_BAND], cnt[BTC_NCNT_SWITCH_CHBW],
+		       cnt[BTC_NCNT_SPECIAL_PACKET]);
 
-	seq_printf(m, "timer=%d, customerize=%d, hub_msg=%d, chg_fw=%d, send_cc=%d",
-		   cnt[BTC_NCNT_TIMER], cnt[BTC_NCNT_CUSTOMERIZE],
-		   rtwdev->btc.hubmsg_cnt, cnt[BTC_NCNT_RESUME_DL_FW],
-		   cnt[BTC_NCNT_COUNTRYCODE]);
+	p += scnprintf(p, end - p,
+		       "timer=%d, customerize=%d, hub_msg=%d, chg_fw=%d, send_cc=%d",
+		       cnt[BTC_NCNT_TIMER], cnt[BTC_NCNT_CUSTOMERIZE],
+		       rtwdev->btc.hubmsg_cnt, cnt[BTC_NCNT_RESUME_DL_FW],
+		       cnt[BTC_NCNT_COUNTRYCODE]);
+
+	return p - buf;
 }
 
-void rtw89_btc_dump_info(struct rtw89_dev *rtwdev, struct seq_file *m)
+ssize_t rtw89_btc_dump_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_fw_suit *fw_suit = &rtwdev->fw.normal;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_bt_info *bt = &cx->bt;
-
-	seq_puts(m, "=========================================\n");
-	seq_printf(m, "WL FW / BT FW		%d.%d.%d.%d / NA\n",
-		   fw_suit->major_ver, fw_suit->minor_ver,
-		   fw_suit->sub_ver, fw_suit->sub_idex);
-	seq_printf(m, "manual			%d\n", btc->manual_ctrl);
-
-	seq_puts(m, "=========================================\n");
-
-	seq_printf(m, "\n\r %-15s : raw_data[%02x %02x %02x %02x %02x %02x] (type:%s/cnt:%d/same:%d)",
-		   "[bt_info]",
-		   bt->raw_info[2], bt->raw_info[3],
-		   bt->raw_info[4], bt->raw_info[5],
-		   bt->raw_info[6], bt->raw_info[7],
-		   bt->raw_info[0] == BTC_BTINFO_AUTO ? "auto" : "reply",
-		   cx->cnt_bt[BTC_BCNT_INFOUPDATE],
-		   cx->cnt_bt[BTC_BCNT_INFOSAME]);
-
-	seq_puts(m, "\n=========================================\n");
-
-	_show_cx_info(rtwdev, m);
-	_show_wl_info(rtwdev, m);
-	_show_bt_info(rtwdev, m);
-	_show_dm_info(rtwdev, m);
-	_show_fw_dm_msg(rtwdev, m);
+	char *p = buf, *end = buf + bufsz;
+
+	p += scnprintf(p, end - p,
+		       "=========================================\n");
+	p += scnprintf(p, end - p,
+		       "WL FW / BT FW		%d.%d.%d.%d / NA\n",
+		       fw_suit->major_ver, fw_suit->minor_ver,
+		       fw_suit->sub_ver, fw_suit->sub_idex);
+	p += scnprintf(p, end - p, "manual			%d\n",
+		       btc->manual_ctrl);
+
+	p += scnprintf(p, end - p,
+		       "=========================================\n");
+
+	p += scnprintf(p, end - p,
+		       "\n\r %-15s : raw_data[%02x %02x %02x %02x %02x %02x] (type:%s/cnt:%d/same:%d)",
+		       "[bt_info]",
+		       bt->raw_info[2], bt->raw_info[3],
+		       bt->raw_info[4], bt->raw_info[5],
+		       bt->raw_info[6], bt->raw_info[7],
+		       bt->raw_info[0] == BTC_BTINFO_AUTO ? "auto" : "reply",
+		       cx->cnt_bt[BTC_BCNT_INFOUPDATE],
+		       cx->cnt_bt[BTC_BCNT_INFOSAME]);
+
+	p += scnprintf(p, end - p,
+		       "\n=========================================\n");
+
+	p += _show_cx_info(rtwdev, p, end - p);
+	p += _show_wl_info(rtwdev, p, end - p);
+	p += _show_bt_info(rtwdev, p, end - p);
+	p += _show_dm_info(rtwdev, p, end - p);
+	p += _show_fw_dm_msg(rtwdev, p, end - p);
 
 	if (ver->fcxmreg == 1)
-		_show_mreg_v1(rtwdev, m);
+		p += _show_mreg_v1(rtwdev, p, end - p);
 	else if (ver->fcxmreg == 2)
-		_show_mreg_v2(rtwdev, m);
+		p += _show_mreg_v2(rtwdev, p, end - p);
 	else if (ver->fcxmreg == 7)
-		_show_mreg_v7(rtwdev, m);
+		p += _show_mreg_v7(rtwdev, p, end - p);
 
-	_show_gpio_dbg(rtwdev, m);
+	p += _show_gpio_dbg(rtwdev, p, end - p);
 
 	if (ver->fcxbtcrpt == 1)
-		_show_summary_v1(rtwdev, m);
+		p += _show_summary_v1(rtwdev, p, end - p);
 	else if (ver->fcxbtcrpt == 4)
-		_show_summary_v4(rtwdev, m);
+		p += _show_summary_v4(rtwdev, p, end - p);
 	else if (ver->fcxbtcrpt == 5)
-		_show_summary_v5(rtwdev, m);
+		p += _show_summary_v5(rtwdev, p, end - p);
 	else if (ver->fcxbtcrpt == 105)
-		_show_summary_v105(rtwdev, m);
+		p += _show_summary_v105(rtwdev, p, end - p);
 	else if (ver->fcxbtcrpt == 7)
-		_show_summary_v7(rtwdev, m);
+		p += _show_summary_v7(rtwdev, p, end - p);
 	else if (ver->fcxbtcrpt == 8)
-		_show_summary_v8(rtwdev, m);
+		p += _show_summary_v8(rtwdev, p, end - p);
+
+	return p - buf;
 }
 
 void rtw89_coex_recognize_ver(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 30134f58d531..e3a1fcd79620 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -282,7 +282,7 @@ void rtw89_btc_ntfy_wl_rfk(struct rtw89_dev *rtwdev, u8 phy_map,
 void rtw89_btc_ntfy_wl_sta(struct rtw89_dev *rtwdev);
 void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			  u32 len, u8 class, u8 func);
-void rtw89_btc_dump_info(struct rtw89_dev *rtwdev, struct seq_file *m);
+ssize_t rtw89_btc_dump_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz);
 void rtw89_coex_act1_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_coex_bt_devinfo_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_coex_rfk_chk_work(struct wiphy *wiphy, struct wiphy_work *work);
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 09fa977a6e6d..db0e7a4beb07 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -13,6 +13,7 @@
 #include "ps.h"
 #include "reg.h"
 #include "sar.h"
+#include "util.h"
 
 #ifdef CONFIG_RTW89_DEBUGMSG
 unsigned int rtw89_debug_mask;
@@ -24,9 +25,12 @@ MODULE_PARM_DESC(debug_mask, "Debugging mask");
 #ifdef CONFIG_RTW89_DEBUGFS
 struct rtw89_debugfs_priv {
 	struct rtw89_dev *rtwdev;
-	int (*cb_read)(struct seq_file *m, void *v);
-	ssize_t (*cb_write)(struct file *filp, const char __user *buffer,
-			    size_t count, loff_t *loff);
+	ssize_t (*cb_read)(struct rtw89_dev *rtwdev,
+			   struct rtw89_debugfs_priv *debugfs_priv,
+			   char *buf, size_t bufsz);
+	ssize_t (*cb_write)(struct rtw89_dev *rtwdev,
+			    struct rtw89_debugfs_priv *debugfs_priv,
+			    const char *buf, size_t count);
 	union {
 		u32 cb_data;
 		struct {
@@ -74,6 +78,28 @@ struct rtw89_debugfs {
 	struct rtw89_debugfs_priv disable_dm;
 };
 
+struct rtw89_debugfs_iter_data {
+	char *buf;
+	size_t bufsz;
+	int written_sz;
+};
+
+static void rtw89_debugfs_iter_data_setup(struct rtw89_debugfs_iter_data *iter_data,
+					  char *buf, size_t bufsz)
+{
+	iter_data->buf = buf;
+	iter_data->bufsz = bufsz;
+	iter_data->written_sz = 0;
+}
+
+static void rtw89_debugfs_iter_data_next(struct rtw89_debugfs_iter_data *iter_data,
+					 char *buf, size_t bufsz, int written_sz)
+{
+	iter_data->buf = buf;
+	iter_data->bufsz = bufsz;
+	iter_data->written_sz += written_sz;
+}
+
 static const u16 rtw89_rate_info_bw_to_mhz_map[] = {
 	[RATE_INFO_BW_20] = 20,
 	[RATE_INFO_BW_40] = 40,
@@ -90,84 +116,78 @@ static u16 rtw89_rate_info_bw_to_mhz(enum rate_info_bw bw)
 	return 0;
 }
 
-static int rtw89_debugfs_single_show(struct seq_file *m, void *v)
+static ssize_t rtw89_debugfs_file_read(struct file *file, char __user *userbuf,
+				       size_t count, loff_t *ppos)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+	struct rtw89_debugfs_priv *debugfs_priv = file->private_data;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t bufsz = PAGE_SIZE;
+	char *buf;
+	ssize_t n;
 
-	return debugfs_priv->cb_read(m, v);
-}
+	buf = kvmalloc(bufsz, GFP_KERNEL);
+	if (!buf)
+		return 0;
 
-static ssize_t rtw89_debugfs_single_write(struct file *filp,
-					  const char __user *buffer,
-					  size_t count, loff_t *loff)
-{
-	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
+	n = debugfs_priv->cb_read(rtwdev, debugfs_priv, buf, bufsz);
+	rtw89_might_trailing_ellipsis(buf, bufsz, n);
 
-	return debugfs_priv->cb_write(filp, buffer, count, loff);
-}
+	n = simple_read_from_buffer(userbuf, count, ppos, buf, n);
 
-static ssize_t rtw89_debugfs_seq_file_write(struct file *filp,
-					    const char __user *buffer,
-					    size_t count, loff_t *loff)
-{
-	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
-	struct rtw89_debugfs_priv *debugfs_priv = seqpriv->private;
+	kvfree(buf);
 
-	return debugfs_priv->cb_write(filp, buffer, count, loff);
+	return n;
 }
 
-static int rtw89_debugfs_single_open(struct inode *inode, struct file *filp)
+static ssize_t rtw89_debugfs_file_write(struct file *file,
+					const char __user *userbuf,
+					size_t count, loff_t *loff)
 {
-	return single_open(filp, rtw89_debugfs_single_show, inode->i_private);
-}
+	struct rtw89_debugfs_priv *debugfs_priv = file->private_data;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	char *buf __free(kfree) = kmalloc(count + 1, GFP_KERNEL);
 
-static int rtw89_debugfs_close(struct inode *inode, struct file *filp)
-{
-	return 0;
+	if (!buf)
+		return -ENOMEM;
+
+	if (copy_from_user(buf, userbuf, count))
+		return -EFAULT;
+
+	buf[count] = '\0';
+
+	return debugfs_priv->cb_write(rtwdev, debugfs_priv, buf, count);
 }
 
 static const struct file_operations file_ops_single_r = {
 	.owner = THIS_MODULE,
-	.open = rtw89_debugfs_single_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
+	.read = rtw89_debugfs_file_read,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
 };
 
 static const struct file_operations file_ops_common_rw = {
 	.owner = THIS_MODULE,
-	.open = rtw89_debugfs_single_open,
-	.release = single_release,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.write = rtw89_debugfs_seq_file_write,
+	.read = rtw89_debugfs_file_read,
+	.write = rtw89_debugfs_file_write,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
 };
 
 static const struct file_operations file_ops_single_w = {
 	.owner = THIS_MODULE,
-	.write = rtw89_debugfs_single_write,
+	.write = rtw89_debugfs_file_write,
 	.open = simple_open,
-	.release = rtw89_debugfs_close,
+	.llseek = generic_file_llseek,
 };
 
 static ssize_t
-rtw89_debug_priv_read_reg_select(struct file *filp,
-				 const char __user *user_buf,
-				 size_t count, loff_t *loff)
+rtw89_debug_priv_read_reg_select(struct rtw89_dev *rtwdev,
+				 struct rtw89_debugfs_priv *debugfs_priv,
+				 const char *buf, size_t count)
 {
-	struct seq_file *m = (struct seq_file *)filp->private_data;
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
-	char buf[32];
-	size_t buf_size;
 	u32 addr, len;
 	int num;
 
-	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
 	num = sscanf(buf, "%x %x", &addr, &len);
 	if (num != 2) {
 		rtw89_info(rtwdev, "invalid format: <addr> <len>\n");
@@ -182,11 +202,13 @@ rtw89_debug_priv_read_reg_select(struct file *filp,
 	return count;
 }
 
-static int rtw89_debug_priv_read_reg_get(struct seq_file *m, void *v)
+static
+ssize_t rtw89_debug_priv_read_reg_get(struct rtw89_dev *rtwdev,
+				      struct rtw89_debugfs_priv *debugfs_priv,
+				      char *buf, size_t bufsz)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
-	u32 addr, end, data, k;
+	char *p = buf, *end = buf + bufsz;
+	u32 addr, addr_end, data, k;
 	u32 len;
 
 	len = debugfs_priv->read_reg.len;
@@ -210,41 +232,34 @@ static int rtw89_debug_priv_read_reg_get(struct seq_file *m, void *v)
 		return -EINVAL;
 	}
 
-	seq_printf(m, "get %d bytes at 0x%08x=0x%08x\n", len, addr, data);
+	p += scnprintf(p, end - p, "get %d bytes at 0x%08x=0x%08x\n", len,
+		       addr, data);
 
-	return 0;
+	return p - buf;
 
 ndata:
-	end = addr + len;
+	addr_end = addr + len;
 
-	for (; addr < end; addr += 16) {
-		seq_printf(m, "%08xh : ", 0x18600000 + addr);
+	for (; addr < addr_end; addr += 16) {
+		p += scnprintf(p, end - p, "%08xh : ", 0x18600000 + addr);
 		for (k = 0; k < 16; k += 4) {
 			data = rtw89_read32(rtwdev, addr + k);
-			seq_printf(m, "%08x ", data);
+			p += scnprintf(p, end - p, "%08x ", data);
 		}
-		seq_puts(m, "\n");
+		p += scnprintf(p, end - p, "\n");
 	}
 
-	return 0;
+	return p - buf;
 }
 
-static ssize_t rtw89_debug_priv_write_reg_set(struct file *filp,
-					      const char __user *user_buf,
-					      size_t count, loff_t *loff)
+static
+ssize_t rtw89_debug_priv_write_reg_set(struct rtw89_dev *rtwdev,
+				       struct rtw89_debugfs_priv *debugfs_priv,
+				       const char *buf, size_t count)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
-	char buf[32];
-	size_t buf_size;
 	u32 addr, val, len;
 	int num;
 
-	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
 	num = sscanf(buf, "%x %x %x", &addr, &val, &len);
 	if (num !=  3) {
 		rtw89_info(rtwdev, "invalid format: <addr> <val> <len>\n");
@@ -273,24 +288,14 @@ static ssize_t rtw89_debug_priv_write_reg_set(struct file *filp,
 }
 
 static ssize_t
-rtw89_debug_priv_read_rf_select(struct file *filp,
-				const char __user *user_buf,
-				size_t count, loff_t *loff)
+rtw89_debug_priv_read_rf_select(struct rtw89_dev *rtwdev,
+				struct rtw89_debugfs_priv *debugfs_priv,
+				const char *buf, size_t count)
 {
-	struct seq_file *m = (struct seq_file *)filp->private_data;
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
-	char buf[32];
-	size_t buf_size;
 	u32 addr, mask;
 	u8 path;
 	int num;
 
-	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
 	num = sscanf(buf, "%hhd %x %x", &path, &addr, &mask);
 	if (num != 3) {
 		rtw89_info(rtwdev, "invalid format: <path> <addr> <mask>\n");
@@ -310,10 +315,12 @@ rtw89_debug_priv_read_rf_select(struct file *filp,
 	return count;
 }
 
-static int rtw89_debug_priv_read_rf_get(struct seq_file *m, void *v)
+static
+ssize_t rtw89_debug_priv_read_rf_get(struct rtw89_dev *rtwdev,
+				     struct rtw89_debugfs_priv *debugfs_priv,
+				     char *buf, size_t bufsz)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	char *p = buf, *end = buf + bufsz;
 	u32 addr, data, mask;
 	u8 path;
 
@@ -323,28 +330,21 @@ static int rtw89_debug_priv_read_rf_get(struct seq_file *m, void *v)
 
 	data = rtw89_read_rf(rtwdev, path, addr, mask);
 
-	seq_printf(m, "path %d, rf register 0x%08x=0x%08x\n", path, addr, data);
+	p += scnprintf(p, end - p, "path %d, rf register 0x%08x=0x%08x\n",
+		       path, addr, data);
 
-	return 0;
+	return p - buf;
 }
 
-static ssize_t rtw89_debug_priv_write_rf_set(struct file *filp,
-					     const char __user *user_buf,
-					     size_t count, loff_t *loff)
+static
+ssize_t rtw89_debug_priv_write_rf_set(struct rtw89_dev *rtwdev,
+				      struct rtw89_debugfs_priv *debugfs_priv,
+				      const char *buf, size_t count)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
-	char buf[32];
-	size_t buf_size;
 	u32 addr, val, mask;
 	u8 path;
 	int num;
 
-	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
 	num = sscanf(buf, "%hhd %x %x %x", &path, &addr, &mask, &val);
 	if (num != 4) {
 		rtw89_info(rtwdev, "invalid format: <path> <addr> <mask> <val>\n");
@@ -363,29 +363,31 @@ static ssize_t rtw89_debug_priv_write_rf_set(struct file *filp,
 	return count;
 }
 
-static int rtw89_debug_priv_rf_reg_dump_get(struct seq_file *m, void *v)
+static
+ssize_t rtw89_debug_priv_rf_reg_dump_get(struct rtw89_dev *rtwdev,
+					 struct rtw89_debugfs_priv *debugfs_priv,
+					 char *buf, size_t bufsz)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	char *p = buf, *end = buf + bufsz;
 	u32 addr, offset, data;
 	u8 path;
 
 	for (path = 0; path < chip->rf_path_num; path++) {
-		seq_printf(m, "RF path %d:\n\n", path);
+		p += scnprintf(p, end - p, "RF path %d:\n\n", path);
 		for (addr = 0; addr < 0x100; addr += 4) {
-			seq_printf(m, "0x%08x: ", addr);
+			p += scnprintf(p, end - p, "0x%08x: ", addr);
 			for (offset = 0; offset < 4; offset++) {
 				data = rtw89_read_rf(rtwdev, path,
 						     addr + offset, RFREG_MASK);
-				seq_printf(m, "0x%05x  ", data);
+				p += scnprintf(p, end - p, "0x%05x  ", data);
 			}
-			seq_puts(m, "\n");
+			p += scnprintf(p, end - p, "\n");
 		}
-		seq_puts(m, "\n");
+		p += scnprintf(p, end - p, "\n");
 	}
 
-	return 0;
+	return p - buf;
 }
 
 struct txpwr_ent {
@@ -704,56 +706,71 @@ static const struct txpwr_map __txpwr_map_lmt_ru_be = {
 };
 
 static unsigned int
-__print_txpwr_ent(struct seq_file *m, const struct txpwr_ent *ent,
-		  const s8 *buf, const unsigned int cur)
+__print_txpwr_ent(char *buf, size_t bufsz, const struct txpwr_ent *ent,
+		  const s8 *bufp, const unsigned int cur, unsigned int *ate)
 {
+	char *p = buf, *end = buf + bufsz;
 	unsigned int cnt, i;
+	unsigned int eaten;
 	char *fmt;
 
 	if (ent->nested) {
-		for (cnt = 0, i = 0; i < ent->len; i++)
-			cnt += __print_txpwr_ent(m, ent->ptr + i, buf,
-						 cur + cnt);
-		return cnt;
+		for (cnt = 0, i = 0; i < ent->len; i++, cnt += eaten)
+			p += __print_txpwr_ent(p, end - p, ent->ptr + i, bufp,
+					       cur + cnt, &eaten);
+		*ate = cnt;
+		goto out;
 	}
 
 	switch (ent->len) {
 	case 0:
-		seq_printf(m, "\t<< %s >>\n", ent->txt);
-		return 0;
+		p += scnprintf(p, end - p, "\t<< %s >>\n", ent->txt);
+		*ate = 0;
+		goto out;
 	case 2:
 		fmt = "%s\t| %3d, %3d,\t\tdBm\n";
-		seq_printf(m, fmt, ent->txt, buf[cur], buf[cur + 1]);
-		return 2;
+		p += scnprintf(p, end - p, fmt, ent->txt, bufp[cur],
+			       bufp[cur + 1]);
+		*ate = 2;
+		goto out;
 	case 4:
 		fmt = "%s\t| %3d, %3d, %3d, %3d,\tdBm\n";
-		seq_printf(m, fmt, ent->txt, buf[cur], buf[cur + 1],
-			   buf[cur + 2], buf[cur + 3]);
-		return 4;
+		p += scnprintf(p, end - p, fmt, ent->txt, bufp[cur],
+			       bufp[cur + 1],
+			       bufp[cur + 2], bufp[cur + 3]);
+		*ate = 4;
+		goto out;
 	case 8:
 		fmt = "%s\t| %3d, %3d, %3d, %3d, %3d, %3d, %3d, %3d,\tdBm\n";
-		seq_printf(m, fmt, ent->txt, buf[cur], buf[cur + 1],
-			   buf[cur + 2], buf[cur + 3], buf[cur + 4],
-			   buf[cur + 5], buf[cur + 6], buf[cur + 7]);
-		return 8;
+		p += scnprintf(p, end - p, fmt, ent->txt, bufp[cur],
+			       bufp[cur + 1],
+			       bufp[cur + 2], bufp[cur + 3], bufp[cur + 4],
+			       bufp[cur + 5], bufp[cur + 6], bufp[cur + 7]);
+		*ate = 8;
+		goto out;
 	default:
 		return 0;
 	}
+
+out:
+	return p - buf;
 }
 
-static int __print_txpwr_map(struct seq_file *m, struct rtw89_dev *rtwdev,
-			     const struct txpwr_map *map)
+static ssize_t __print_txpwr_map(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
+				 const struct txpwr_map *map)
 {
 	u8 fct = rtwdev->chip->txpwr_factor_mac;
 	u8 path_num = rtwdev->chip->rf_path_num;
+	char *p = buf, *end = buf + bufsz;
 	unsigned int cur, i;
+	unsigned int eaten;
 	u32 max_valid_addr;
 	u32 val, addr;
-	s8 *buf, tmp;
+	s8 *bufp, tmp;
 	int ret;
 
-	buf = vzalloc(map->addr_to - map->addr_from + 4);
-	if (!buf)
+	bufp = vzalloc(map->addr_to - map->addr_from + 4);
+	if (!bufp)
 		return -ENOMEM;
 
 	if (path_num == 1)
@@ -773,31 +790,32 @@ static int __print_txpwr_map(struct seq_file *m, struct rtw89_dev *rtwdev,
 		for (i = 0; i < 4; i++, val >>= 8) {
 			/* signed 7 bits, and reserved BIT(7) */
 			tmp = sign_extend32(val, 6);
-			buf[cur + i] = tmp >> fct;
+			bufp[cur + i] = tmp >> fct;
 		}
 	}
 
-	for (cur = 0, i = 0; i < map->size; i++)
-		cur += __print_txpwr_ent(m, &map->ent[i], buf, cur);
+	for (cur = 0, i = 0; i < map->size; i++, cur += eaten)
+		p += __print_txpwr_ent(p, end - p, &map->ent[i], bufp, cur, &eaten);
 
-	vfree(buf);
-	return 0;
+	vfree(bufp);
+	return p - buf;
 }
 
 #define case_REGD(_regd) \
 	case RTW89_ ## _regd: \
-		seq_puts(m, #_regd "\n"); \
+		p += scnprintf(p, end - p, #_regd "\n"); \
 		break
 
-static void __print_regd(struct seq_file *m, struct rtw89_dev *rtwdev,
-			 const struct rtw89_chan *chan)
+static int __print_regd(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
+			const struct rtw89_chan *chan)
 {
+	char *p = buf, *end = buf + bufsz;
 	u8 band = chan->band_type;
 	u8 regd = rtw89_regd_get(rtwdev, band);
 
 	switch (regd) {
 	default:
-		seq_printf(m, "UNKNOWN: %d\n", regd);
+		p += scnprintf(p, end - p, "UNKNOWN: %d\n", regd);
 		break;
 	case_REGD(WW);
 	case_REGD(ETSI);
@@ -816,6 +834,8 @@ static void __print_regd(struct seq_file *m, struct rtw89_dev *rtwdev,
 	case_REGD(UK);
 	case_REGD(THAILAND);
 	}
+
+	return p - buf;
 }
 
 #undef case_REGD
@@ -844,96 +864,101 @@ static const struct dbgfs_txpwr_table *dbgfs_txpwr_tables[RTW89_CHIP_GEN_NUM] =
 };
 
 static
-void rtw89_debug_priv_txpwr_table_get_regd(struct seq_file *m,
-					   struct rtw89_dev *rtwdev,
-					   const struct rtw89_chan *chan)
+int rtw89_debug_priv_txpwr_table_get_regd(struct rtw89_dev *rtwdev,
+					  char *buf, size_t bufsz,
+					  const struct rtw89_chan *chan)
 {
 	const struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
 	const struct rtw89_reg_6ghz_tpe *tpe6 = &regulatory->reg_6ghz_tpe;
+	char *p = buf, *end = buf + bufsz;
 
-	seq_printf(m, "[Chanctx] band %u, ch %u, bw %u\n",
-		   chan->band_type, chan->channel, chan->band_width);
+	p += scnprintf(p, end - p, "[Chanctx] band %u, ch %u, bw %u\n",
+		       chan->band_type, chan->channel, chan->band_width);
 
-	seq_puts(m, "[Regulatory] ");
-	__print_regd(m, rtwdev, chan);
+	p += scnprintf(p, end - p, "[Regulatory] ");
+	p += __print_regd(rtwdev, p, end - p, chan);
 
 	if (chan->band_type == RTW89_BAND_6G) {
-		seq_printf(m, "[reg6_pwr_type] %u\n", regulatory->reg_6ghz_power);
+		p += scnprintf(p, end - p, "[reg6_pwr_type] %u\n",
+			       regulatory->reg_6ghz_power);
 
 		if (tpe6->valid)
-			seq_printf(m, "[TPE] %d dBm\n", tpe6->constraint);
+			p += scnprintf(p, end - p, "[TPE] %d dBm\n",
+				       tpe6->constraint);
 	}
+
+	return p - buf;
 }
 
-static int rtw89_debug_priv_txpwr_table_get(struct seq_file *m, void *v)
+static
+ssize_t rtw89_debug_priv_txpwr_table_get(struct rtw89_dev *rtwdev,
+					 struct rtw89_debugfs_priv *debugfs_priv,
+					 char *buf, size_t bufsz)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	enum rtw89_chip_gen chip_gen = rtwdev->chip->chip_gen;
 	const struct dbgfs_txpwr_table *tbl;
 	const struct rtw89_chan *chan;
-	int ret = 0;
+	char *p = buf, *end = buf + bufsz;
+	ssize_t n;
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
 	chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 
-	rtw89_debug_priv_txpwr_table_get_regd(m, rtwdev, chan);
+	p += rtw89_debug_priv_txpwr_table_get_regd(rtwdev, p, end - p, chan);
 
-	seq_puts(m, "[SAR]\n");
-	rtw89_print_sar(m, rtwdev, chan->freq);
+	p += scnprintf(p, end - p, "[SAR]\n");
+	p += rtw89_print_sar(rtwdev, p, end - p, chan->freq);
 
-	seq_puts(m, "[TAS]\n");
-	rtw89_print_tas(m, rtwdev);
+	p += scnprintf(p, end - p, "[TAS]\n");
+	p += rtw89_print_tas(rtwdev, p, end - p);
 
-	seq_puts(m, "[DAG]\n");
-	rtw89_print_ant_gain(m, rtwdev, chan);
+	p += scnprintf(p, end - p, "[DAG]\n");
+	p += rtw89_print_ant_gain(rtwdev, p, end - p, chan);
 
 	tbl = dbgfs_txpwr_tables[chip_gen];
 	if (!tbl) {
-		ret = -EOPNOTSUPP;
+		n = -EOPNOTSUPP;
 		goto err;
 	}
 
-	seq_puts(m, "\n[TX power byrate]\n");
-	ret = __print_txpwr_map(m, rtwdev, tbl->byr);
-	if (ret)
+	p += scnprintf(p, end - p, "\n[TX power byrate]\n");
+	n = __print_txpwr_map(rtwdev, p, end - p, tbl->byr);
+	if (n < 0)
 		goto err;
+	p += n;
 
-	seq_puts(m, "\n[TX power limit]\n");
-	ret = __print_txpwr_map(m, rtwdev, tbl->lmt);
-	if (ret)
+	p += scnprintf(p, end - p, "\n[TX power limit]\n");
+	n = __print_txpwr_map(rtwdev, p, end - p, tbl->lmt);
+	if (n < 0)
 		goto err;
+	p += n;
 
-	seq_puts(m, "\n[TX power limit_ru]\n");
-	ret = __print_txpwr_map(m, rtwdev, tbl->lmt_ru);
-	if (ret)
+	p += scnprintf(p, end - p, "\n[TX power limit_ru]\n");
+	n = __print_txpwr_map(rtwdev, p, end - p, tbl->lmt_ru);
+	if (n < 0)
 		goto err;
+	p += n;
+
+	mutex_unlock(&rtwdev->mutex);
+
+	return p - buf;
 
 err:
 	mutex_unlock(&rtwdev->mutex);
-	return ret;
+
+	return n;
 }
 
 static ssize_t
-rtw89_debug_priv_mac_reg_dump_select(struct file *filp,
-				     const char __user *user_buf,
-				     size_t count, loff_t *loff)
+rtw89_debug_priv_mac_reg_dump_select(struct rtw89_dev *rtwdev,
+				     struct rtw89_debugfs_priv *debugfs_priv,
+				     const char *buf, size_t count)
 {
-	struct seq_file *m = (struct seq_file *)filp->private_data;
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	char buf[32];
-	size_t buf_size;
 	int sel;
 	int ret;
 
-	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
 	ret = kstrtoint(buf, 0, &sel);
 	if (ret)
 		return ret;
@@ -957,99 +982,91 @@ rtw89_debug_priv_mac_reg_dump_select(struct file *filp,
 
 #define RTW89_MAC_PAGE_SIZE		0x100
 
-static int rtw89_debug_priv_mac_reg_dump_get(struct seq_file *m, void *v)
+static
+ssize_t rtw89_debug_priv_mac_reg_dump_get(struct rtw89_dev *rtwdev,
+					  struct rtw89_debugfs_priv *debugfs_priv,
+					  char *buf, size_t bufsz)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	enum rtw89_debug_mac_reg_sel reg_sel = debugfs_priv->cb_data;
-	u32 start, end;
+	char *p = buf, *end = buf + bufsz;
+	u32 start, end_addr;
 	u32 i, j, k, page;
 	u32 val;
 
 	switch (reg_sel) {
 	case RTW89_DBG_SEL_MAC_00:
-		seq_puts(m, "Debug selected MAC page 0x00\n");
+		p += scnprintf(p, end - p, "Debug selected MAC page 0x00\n");
 		start = 0x000;
-		end = 0x014;
+		end_addr = 0x014;
 		break;
 	case RTW89_DBG_SEL_MAC_30:
-		seq_puts(m, "Debug selected MAC page 0x30\n");
+		p += scnprintf(p, end - p, "Debug selected MAC page 0x30\n");
 		start = 0x030;
-		end = 0x033;
+		end_addr = 0x033;
 		break;
 	case RTW89_DBG_SEL_MAC_40:
-		seq_puts(m, "Debug selected MAC page 0x40\n");
+		p += scnprintf(p, end - p, "Debug selected MAC page 0x40\n");
 		start = 0x040;
-		end = 0x07f;
+		end_addr = 0x07f;
 		break;
 	case RTW89_DBG_SEL_MAC_80:
-		seq_puts(m, "Debug selected MAC page 0x80\n");
+		p += scnprintf(p, end - p, "Debug selected MAC page 0x80\n");
 		start = 0x080;
-		end = 0x09f;
+		end_addr = 0x09f;
 		break;
 	case RTW89_DBG_SEL_MAC_C0:
-		seq_puts(m, "Debug selected MAC page 0xc0\n");
+		p += scnprintf(p, end - p, "Debug selected MAC page 0xc0\n");
 		start = 0x0c0;
-		end = 0x0df;
+		end_addr = 0x0df;
 		break;
 	case RTW89_DBG_SEL_MAC_E0:
-		seq_puts(m, "Debug selected MAC page 0xe0\n");
+		p += scnprintf(p, end - p, "Debug selected MAC page 0xe0\n");
 		start = 0x0e0;
-		end = 0x0ff;
+		end_addr = 0x0ff;
 		break;
 	case RTW89_DBG_SEL_BB:
-		seq_puts(m, "Debug selected BB register\n");
+		p += scnprintf(p, end - p, "Debug selected BB register\n");
 		start = 0x100;
-		end = 0x17f;
+		end_addr = 0x17f;
 		break;
 	case RTW89_DBG_SEL_IQK:
-		seq_puts(m, "Debug selected IQK register\n");
+		p += scnprintf(p, end - p, "Debug selected IQK register\n");
 		start = 0x180;
-		end = 0x1bf;
+		end_addr = 0x1bf;
 		break;
 	case RTW89_DBG_SEL_RFC:
-		seq_puts(m, "Debug selected RFC register\n");
+		p += scnprintf(p, end - p, "Debug selected RFC register\n");
 		start = 0x1c0;
-		end = 0x1ff;
+		end_addr = 0x1ff;
 		break;
 	default:
-		seq_puts(m, "Selected invalid register page\n");
+		p += scnprintf(p, end - p, "Selected invalid register page\n");
 		return -EINVAL;
 	}
 
-	for (i = start; i <= end; i++) {
+	for (i = start; i <= end_addr; i++) {
 		page = i << 8;
 		for (j = page; j < page + RTW89_MAC_PAGE_SIZE; j += 16) {
-			seq_printf(m, "%08xh : ", 0x18600000 + j);
+			p += scnprintf(p, end - p, "%08xh : ", 0x18600000 + j);
 			for (k = 0; k < 4; k++) {
 				val = rtw89_read32(rtwdev, j + (k << 2));
-				seq_printf(m, "%08x ", val);
+				p += scnprintf(p, end - p, "%08x ", val);
 			}
-			seq_puts(m, "\n");
+			p += scnprintf(p, end - p, "\n");
 		}
 	}
 
-	return 0;
+	return p - buf;
 }
 
 static ssize_t
-rtw89_debug_priv_mac_mem_dump_select(struct file *filp,
-				     const char __user *user_buf,
-				     size_t count, loff_t *loff)
+rtw89_debug_priv_mac_mem_dump_select(struct rtw89_dev *rtwdev,
+				     struct rtw89_debugfs_priv *debugfs_priv,
+				     const char *buf, size_t count)
 {
-	struct seq_file *m = (struct seq_file *)filp->private_data;
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
-	char buf[32];
-	size_t buf_size;
 	u32 sel, start_addr, len;
 	int num;
 
-	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
 	num = sscanf(buf, "%x %x %x", &sel, &start_addr, &len);
 	if (num != 3) {
 		rtw89_info(rtwdev, "invalid format: <sel> <start> <len>\n");
@@ -1066,15 +1083,16 @@ rtw89_debug_priv_mac_mem_dump_select(struct file *filp,
 	return count;
 }
 
-static void rtw89_debug_dump_mac_mem(struct seq_file *m,
-				     struct rtw89_dev *rtwdev,
-				     u8 sel, u32 start_addr, u32 len)
+static int rtw89_debug_dump_mac_mem(struct rtw89_dev *rtwdev,
+				    char *buf, size_t bufsz,
+				    u8 sel, u32 start_addr, u32 len)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u32 filter_model_addr = mac->filter_model_addr;
 	u32 indir_access_addr = mac->indir_access_addr;
 	u32 base_addr, start_page, residue;
-	u32 i, j, p, pages;
+	char *p = buf, *end = buf + bufsz;
+	u32 i, j, pp, pages;
 	u32 dump_len, remain;
 	u32 val;
 
@@ -1085,30 +1103,33 @@ static void rtw89_debug_dump_mac_mem(struct seq_file *m,
 	base_addr = mac->mem_base_addrs[sel];
 	base_addr += start_page * MAC_MEM_DUMP_PAGE_SIZE;
 
-	for (p = 0; p < pages; p++) {
+	for (pp = 0; pp < pages; pp++) {
 		dump_len = min_t(u32, remain, MAC_MEM_DUMP_PAGE_SIZE);
 		rtw89_write32(rtwdev, filter_model_addr, base_addr);
 		for (i = indir_access_addr + residue;
 		     i < indir_access_addr + dump_len;) {
-			seq_printf(m, "%08xh:", i);
+			p += scnprintf(p, end - p, "%08xh:", i);
 			for (j = 0;
 			     j < 4 && i < indir_access_addr + dump_len;
 			     j++, i += 4) {
 				val = rtw89_read32(rtwdev, i);
-				seq_printf(m, "  %08x", val);
+				p += scnprintf(p, end - p, "  %08x", val);
 				remain -= 4;
 			}
-			seq_puts(m, "\n");
+			p += scnprintf(p, end - p, "\n");
 		}
 		base_addr += MAC_MEM_DUMP_PAGE_SIZE;
 	}
+
+	return p - buf;
 }
 
-static int
-rtw89_debug_priv_mac_mem_dump_get(struct seq_file *m, void *v)
+static ssize_t
+rtw89_debug_priv_mac_mem_dump_get(struct rtw89_dev *rtwdev,
+				  struct rtw89_debugfs_priv *debugfs_priv,
+				  char *buf, size_t bufsz)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	char *p = buf, *end = buf + bufsz;
 	bool grant_read = false;
 
 	if (debugfs_priv->mac_mem.sel >= RTW89_MAC_MEM_NUM)
@@ -1131,36 +1152,26 @@ rtw89_debug_priv_mac_mem_dump_get(struct seq_file *m, void *v)
 	rtw89_leave_ps_mode(rtwdev);
 	if (grant_read)
 		rtw89_write32_set(rtwdev, R_AX_TCR1, B_AX_TCR_FORCE_READ_TXDFIFO);
-	rtw89_debug_dump_mac_mem(m, rtwdev,
-				 debugfs_priv->mac_mem.sel,
-				 debugfs_priv->mac_mem.start,
-				 debugfs_priv->mac_mem.len);
+	p += rtw89_debug_dump_mac_mem(rtwdev, p, end - p,
+				      debugfs_priv->mac_mem.sel,
+				      debugfs_priv->mac_mem.start,
+				      debugfs_priv->mac_mem.len);
 	if (grant_read)
 		rtw89_write32_clr(rtwdev, R_AX_TCR1, B_AX_TCR_FORCE_READ_TXDFIFO);
 	mutex_unlock(&rtwdev->mutex);
 
-	return 0;
+	return p - buf;
 }
 
 static ssize_t
-rtw89_debug_priv_mac_dbg_port_dump_select(struct file *filp,
-					  const char __user *user_buf,
-					  size_t count, loff_t *loff)
+rtw89_debug_priv_mac_dbg_port_dump_select(struct rtw89_dev *rtwdev,
+					  struct rtw89_debugfs_priv *debugfs_priv,
+					  const char *buf, size_t count)
 {
-	struct seq_file *m = (struct seq_file *)filp->private_data;
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
-	char buf[32];
-	size_t buf_size;
 	int sel, set;
 	int num;
 	bool enable;
 
-	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
 	num = sscanf(buf, "%d %d", &sel, &set);
 	if (num != 2) {
 		rtw89_info(rtwdev, "invalid format: <sel> <set>\n");
@@ -1196,13 +1207,13 @@ rtw89_debug_priv_mac_dbg_port_dump_select(struct file *filp,
 }
 
 static int rtw89_debug_mac_dump_ss_dbg(struct rtw89_dev *rtwdev,
-				       struct seq_file *m)
+				       char *buf, size_t bufsz)
 {
 	return 0;
 }
 
 static int rtw89_debug_mac_dump_dle_dbg(struct rtw89_dev *rtwdev,
-					struct seq_file *m)
+				       char *buf, size_t bufsz)
 {
 #define DLE_DFI_DUMP(__type, __target, __sel)				\
 ({									\
@@ -1231,7 +1242,7 @@ static int rtw89_debug_mac_dump_dle_dbg(struct rtw89_dev *rtwdev,
 	__data;								\
 })
 
-#define DLE_DFI_FREE_PAGE_DUMP(__m, __type)				\
+#define DLE_DFI_FREE_PAGE_DUMP(__p, __end, __type)			\
 ({									\
 	u32 __freepg, __pubpg;						\
 	u32 __freepg_head, __freepg_tail, __pubpg_num;			\
@@ -1241,24 +1252,25 @@ static int rtw89_debug_mac_dump_dle_dbg(struct rtw89_dev *rtwdev,
 	__freepg_head = FIELD_GET(B_AX_DLE_FREE_HEADPG, __freepg);	\
 	__freepg_tail = FIELD_GET(B_AX_DLE_FREE_TAILPG, __freepg);	\
 	__pubpg_num = FIELD_GET(B_AX_DLE_PUB_PGNUM, __pubpg);		\
-	seq_printf(__m, "[%s] freepg head: %d\n",			\
-		   #__type, __freepg_head);				\
-	seq_printf(__m, "[%s] freepg tail: %d\n",			\
-		   #__type, __freepg_tail);				\
-	seq_printf(__m, "[%s] pubpg num  : %d\n",			\
-		  #__type, __pubpg_num);				\
+	__p += scnprintf(__p, __end - __p, "[%s] freepg head: %d\n",	\
+			 #__type, __freepg_head);			\
+	__p += scnprintf(__p, __end - __p, "[%s] freepg tail: %d\n",	\
+			 #__type, __freepg_tail);			\
+	__p += scnprintf(__p, __end - __p, "[%s] pubpg num  : %d\n",	\
+			 #__type, __pubpg_num);				\
 })
 
-#define case_QUOTA(__m, __type, __id)					\
+#define case_QUOTA(__p, __end, __type, __id)				\
 	case __type##_QTAID_##__id:					\
-		val32 = DLE_DFI_DUMP(__type, QUOTA, __type##_QTAID_##__id);	\
+		val32 = DLE_DFI_DUMP(__type, QUOTA, __type##_QTAID_##__id); \
 		rsv_pgnum = FIELD_GET(B_AX_DLE_RSV_PGNUM, val32);	\
 		use_pgnum = FIELD_GET(B_AX_DLE_USE_PGNUM, val32);	\
-		seq_printf(__m, "[%s][%s] rsv_pgnum: %d\n",		\
-			   #__type, #__id, rsv_pgnum);			\
-		seq_printf(__m, "[%s][%s] use_pgnum: %d\n",		\
-			   #__type, #__id, use_pgnum);			\
+		__p += scnprintf(__p, __end - __p, "[%s][%s] rsv_pgnum: %d\n", \
+				 #__type, #__id, rsv_pgnum);		\
+		__p += scnprintf(__p, __end - __p, "[%s][%s] use_pgnum: %d\n", \
+				 #__type, #__id, use_pgnum);		\
 		break
+	char *p = buf, *end = buf + bufsz;
 	u32 quota_id;
 	u32 val32;
 	u16 rsv_pgnum, use_pgnum;
@@ -1266,38 +1278,39 @@ static int rtw89_debug_mac_dump_dle_dbg(struct rtw89_dev *rtwdev,
 
 	ret = rtw89_mac_check_mac_en(rtwdev, 0, RTW89_DMAC_SEL);
 	if (ret) {
-		seq_puts(m, "[DLE]  : DMAC not enabled\n");
-		return ret;
+		p += scnprintf(p, end - p, "[DLE]  : DMAC not enabled\n");
+		goto out;
 	}
 
-	DLE_DFI_FREE_PAGE_DUMP(m, WDE);
-	DLE_DFI_FREE_PAGE_DUMP(m, PLE);
+	DLE_DFI_FREE_PAGE_DUMP(p, end, WDE);
+	DLE_DFI_FREE_PAGE_DUMP(p, end, PLE);
 	for (quota_id = 0; quota_id <= WDE_QTAID_CPUIO; quota_id++) {
 		switch (quota_id) {
-		case_QUOTA(m, WDE, HOST_IF);
-		case_QUOTA(m, WDE, WLAN_CPU);
-		case_QUOTA(m, WDE, DATA_CPU);
-		case_QUOTA(m, WDE, PKTIN);
-		case_QUOTA(m, WDE, CPUIO);
+		case_QUOTA(p, end, WDE, HOST_IF);
+		case_QUOTA(p, end, WDE, WLAN_CPU);
+		case_QUOTA(p, end, WDE, DATA_CPU);
+		case_QUOTA(p, end, WDE, PKTIN);
+		case_QUOTA(p, end, WDE, CPUIO);
 		}
 	}
 	for (quota_id = 0; quota_id <= PLE_QTAID_CPUIO; quota_id++) {
 		switch (quota_id) {
-		case_QUOTA(m, PLE, B0_TXPL);
-		case_QUOTA(m, PLE, B1_TXPL);
-		case_QUOTA(m, PLE, C2H);
-		case_QUOTA(m, PLE, H2C);
-		case_QUOTA(m, PLE, WLAN_CPU);
-		case_QUOTA(m, PLE, MPDU);
-		case_QUOTA(m, PLE, CMAC0_RX);
-		case_QUOTA(m, PLE, CMAC1_RX);
-		case_QUOTA(m, PLE, CMAC1_BBRPT);
-		case_QUOTA(m, PLE, WDRLS);
-		case_QUOTA(m, PLE, CPUIO);
+		case_QUOTA(p, end, PLE, B0_TXPL);
+		case_QUOTA(p, end, PLE, B1_TXPL);
+		case_QUOTA(p, end, PLE, C2H);
+		case_QUOTA(p, end, PLE, H2C);
+		case_QUOTA(p, end, PLE, WLAN_CPU);
+		case_QUOTA(p, end, PLE, MPDU);
+		case_QUOTA(p, end, PLE, CMAC0_RX);
+		case_QUOTA(p, end, PLE, CMAC1_RX);
+		case_QUOTA(p, end, PLE, CMAC1_BBRPT);
+		case_QUOTA(p, end, PLE, WDRLS);
+		case_QUOTA(p, end, PLE, CPUIO);
 		}
 	}
 
-	return 0;
+out:
+	return p - buf;
 
 #undef case_QUOTA
 #undef DLE_DFI_DUMP
@@ -1305,73 +1318,88 @@ static int rtw89_debug_mac_dump_dle_dbg(struct rtw89_dev *rtwdev,
 }
 
 static int rtw89_debug_mac_dump_dmac_dbg(struct rtw89_dev *rtwdev,
-					 struct seq_file *m)
+					 char *buf, size_t bufsz)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	char *p = buf, *end = buf + bufsz;
 	u32 dmac_err;
 	int i, ret;
 
 	ret = rtw89_mac_check_mac_en(rtwdev, 0, RTW89_DMAC_SEL);
 	if (ret) {
-		seq_puts(m, "[DMAC] : DMAC not enabled\n");
-		return ret;
+		p += scnprintf(p, end - p, "[DMAC] : DMAC not enabled\n");
+		goto out;
 	}
 
 	dmac_err = rtw89_read32(rtwdev, R_AX_DMAC_ERR_ISR);
-	seq_printf(m, "R_AX_DMAC_ERR_ISR=0x%08x\n", dmac_err);
-	seq_printf(m, "R_AX_DMAC_ERR_IMR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_DMAC_ERR_IMR));
+	p += scnprintf(p, end - p, "R_AX_DMAC_ERR_ISR=0x%08x\n", dmac_err);
+	p += scnprintf(p, end - p, "R_AX_DMAC_ERR_IMR=0x%08x\n",
+		       rtw89_read32(rtwdev, R_AX_DMAC_ERR_IMR));
 
 	if (dmac_err) {
-		seq_printf(m, "R_AX_WDE_ERR_FLAG_CFG=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_WDE_ERR_FLAG_CFG_NUM1));
-		seq_printf(m, "R_AX_PLE_ERR_FLAG_CFG=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_CFG_NUM1));
+		p += scnprintf(p, end - p, "R_AX_WDE_ERR_FLAG_CFG=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_WDE_ERR_FLAG_CFG_NUM1));
+		p += scnprintf(p, end - p, "R_AX_PLE_ERR_FLAG_CFG=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_CFG_NUM1));
 		if (chip->chip_id == RTL8852C) {
-			seq_printf(m, "R_AX_PLE_ERRFLAG_MSG=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_PLE_ERRFLAG_MSG));
-			seq_printf(m, "R_AX_WDE_ERRFLAG_MSG=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_WDE_ERRFLAG_MSG));
-			seq_printf(m, "R_AX_PLE_DBGERR_LOCKEN=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_PLE_DBGERR_LOCKEN));
-			seq_printf(m, "R_AX_PLE_DBGERR_STS=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_PLE_DBGERR_STS));
+			p += scnprintf(p, end - p,
+				       "R_AX_PLE_ERRFLAG_MSG=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_PLE_ERRFLAG_MSG));
+			p += scnprintf(p, end - p,
+				       "R_AX_WDE_ERRFLAG_MSG=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_WDE_ERRFLAG_MSG));
+			p += scnprintf(p, end - p,
+				       "R_AX_PLE_DBGERR_LOCKEN=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_PLE_DBGERR_LOCKEN));
+			p += scnprintf(p, end - p,
+				       "R_AX_PLE_DBGERR_STS=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_PLE_DBGERR_STS));
 		}
 	}
 
 	if (dmac_err & B_AX_WDRLS_ERR_FLAG) {
-		seq_printf(m, "R_AX_WDRLS_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_WDRLS_ERR_IMR));
-		seq_printf(m, "R_AX_WDRLS_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_WDRLS_ERR_ISR));
+		p += scnprintf(p, end - p, "R_AX_WDRLS_ERR_IMR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_WDRLS_ERR_IMR));
+		p += scnprintf(p, end - p, "R_AX_WDRLS_ERR_ISR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_WDRLS_ERR_ISR));
 		if (chip->chip_id == RTL8852C)
-			seq_printf(m, "R_AX_RPQ_RXBD_IDX=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_RPQ_RXBD_IDX_V1));
+			p += scnprintf(p, end - p,
+				       "R_AX_RPQ_RXBD_IDX=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_RPQ_RXBD_IDX_V1));
 		else
-			seq_printf(m, "R_AX_RPQ_RXBD_IDX=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_RPQ_RXBD_IDX));
+			p += scnprintf(p, end - p,
+				       "R_AX_RPQ_RXBD_IDX=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_RPQ_RXBD_IDX));
 	}
 
 	if (dmac_err & B_AX_WSEC_ERR_FLAG) {
 		if (chip->chip_id == RTL8852C) {
-			seq_printf(m, "R_AX_SEC_ERR_IMR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_ERROR_FLAG_IMR));
-			seq_printf(m, "R_AX_SEC_ERR_ISR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_ERROR_FLAG));
-			seq_printf(m, "R_AX_SEC_ENG_CTRL=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_ENG_CTRL));
-			seq_printf(m, "R_AX_SEC_MPDU_PROC=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_MPDU_PROC));
-			seq_printf(m, "R_AX_SEC_CAM_ACCESS=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_CAM_ACCESS));
-			seq_printf(m, "R_AX_SEC_CAM_RDATA=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_CAM_RDATA));
-			seq_printf(m, "R_AX_SEC_DEBUG1=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_DEBUG1));
-			seq_printf(m, "R_AX_SEC_TX_DEBUG=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_TX_DEBUG));
-			seq_printf(m, "R_AX_SEC_RX_DEBUG=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_RX_DEBUG));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_ERR_IMR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_ERROR_FLAG_IMR));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_ERR_ISR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_ERROR_FLAG));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_ENG_CTRL=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_ENG_CTRL));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_MPDU_PROC=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_MPDU_PROC));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_CAM_ACCESS=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_CAM_ACCESS));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_CAM_RDATA=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_CAM_RDATA));
+			p += scnprintf(p, end - p, "R_AX_SEC_DEBUG1=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_DEBUG1));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_TX_DEBUG=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_TX_DEBUG));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_RX_DEBUG=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_RX_DEBUG));
 
 			rtw89_write32_mask(rtwdev, R_AX_DBG_CTRL,
 					   B_AX_DBG_SEL0, 0x8B);
@@ -1382,187 +1410,229 @@ static int rtw89_debug_mac_dump_dmac_dbg(struct rtw89_dev *rtwdev,
 			for (i = 0; i < 0x10; i++) {
 				rtw89_write32_mask(rtwdev, R_AX_SEC_ENG_CTRL,
 						   B_AX_SEC_DBG_PORT_FIELD_MASK, i);
-				seq_printf(m, "sel=%x,R_AX_SEC_DEBUG2=0x%08x\n",
-					   i, rtw89_read32(rtwdev, R_AX_SEC_DEBUG2));
+				p += scnprintf(p, end - p,
+					       "sel=%x,R_AX_SEC_DEBUG2=0x%08x\n",
+					       i,
+					       rtw89_read32(rtwdev, R_AX_SEC_DEBUG2));
 			}
 		} else {
-			seq_printf(m, "R_AX_SEC_ERR_IMR_ISR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_DEBUG));
-			seq_printf(m, "R_AX_SEC_ENG_CTRL=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_ENG_CTRL));
-			seq_printf(m, "R_AX_SEC_MPDU_PROC=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_MPDU_PROC));
-			seq_printf(m, "R_AX_SEC_CAM_ACCESS=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_CAM_ACCESS));
-			seq_printf(m, "R_AX_SEC_CAM_RDATA=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_CAM_RDATA));
-			seq_printf(m, "R_AX_SEC_CAM_WDATA=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_CAM_WDATA));
-			seq_printf(m, "R_AX_SEC_TX_DEBUG=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_TX_DEBUG));
-			seq_printf(m, "R_AX_SEC_RX_DEBUG=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_RX_DEBUG));
-			seq_printf(m, "R_AX_SEC_TRX_PKT_CNT=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_TRX_PKT_CNT));
-			seq_printf(m, "R_AX_SEC_TRX_BLK_CNT=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_SEC_TRX_BLK_CNT));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_ERR_IMR_ISR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_DEBUG));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_ENG_CTRL=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_ENG_CTRL));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_MPDU_PROC=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_MPDU_PROC));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_CAM_ACCESS=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_CAM_ACCESS));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_CAM_RDATA=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_CAM_RDATA));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_CAM_WDATA=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_CAM_WDATA));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_TX_DEBUG=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_TX_DEBUG));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_RX_DEBUG=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_RX_DEBUG));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_TRX_PKT_CNT=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_TRX_PKT_CNT));
+			p += scnprintf(p, end - p,
+				       "R_AX_SEC_TRX_BLK_CNT=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_SEC_TRX_BLK_CNT));
 		}
 	}
 
 	if (dmac_err & B_AX_MPDU_ERR_FLAG) {
-		seq_printf(m, "R_AX_MPDU_TX_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_MPDU_TX_ERR_IMR));
-		seq_printf(m, "R_AX_MPDU_TX_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_MPDU_TX_ERR_ISR));
-		seq_printf(m, "R_AX_MPDU_RX_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_MPDU_RX_ERR_IMR));
-		seq_printf(m, "R_AX_MPDU_RX_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_MPDU_RX_ERR_ISR));
+		p += scnprintf(p, end - p, "R_AX_MPDU_TX_ERR_IMR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_MPDU_TX_ERR_IMR));
+		p += scnprintf(p, end - p, "R_AX_MPDU_TX_ERR_ISR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_MPDU_TX_ERR_ISR));
+		p += scnprintf(p, end - p, "R_AX_MPDU_RX_ERR_IMR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_MPDU_RX_ERR_IMR));
+		p += scnprintf(p, end - p, "R_AX_MPDU_RX_ERR_ISR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_MPDU_RX_ERR_ISR));
 	}
 
 	if (dmac_err & B_AX_STA_SCHEDULER_ERR_FLAG) {
-		seq_printf(m, "R_AX_STA_SCHEDULER_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_STA_SCHEDULER_ERR_IMR));
-		seq_printf(m, "R_AX_STA_SCHEDULER_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_STA_SCHEDULER_ERR_ISR));
+		p += scnprintf(p, end - p,
+			       "R_AX_STA_SCHEDULER_ERR_IMR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_STA_SCHEDULER_ERR_IMR));
+		p += scnprintf(p, end - p,
+			       "R_AX_STA_SCHEDULER_ERR_ISR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_STA_SCHEDULER_ERR_ISR));
 	}
 
 	if (dmac_err & B_AX_WDE_DLE_ERR_FLAG) {
-		seq_printf(m, "R_AX_WDE_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_WDE_ERR_IMR));
-		seq_printf(m, "R_AX_WDE_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_WDE_ERR_ISR));
-		seq_printf(m, "R_AX_PLE_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_PLE_ERR_IMR));
-		seq_printf(m, "R_AX_PLE_ERR_FLAG_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_ISR));
+		p += scnprintf(p, end - p, "R_AX_WDE_ERR_IMR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_WDE_ERR_IMR));
+		p += scnprintf(p, end - p, "R_AX_WDE_ERR_ISR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_WDE_ERR_ISR));
+		p += scnprintf(p, end - p, "R_AX_PLE_ERR_IMR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_PLE_ERR_IMR));
+		p += scnprintf(p, end - p, "R_AX_PLE_ERR_FLAG_ISR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_ISR));
 	}
 
 	if (dmac_err & B_AX_TXPKTCTRL_ERR_FLAG) {
 		if (chip->chip_id == RTL8852C) {
-			seq_printf(m, "R_AX_TXPKTCTL_B0_ERRFLAG_IMR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_B0_ERRFLAG_IMR));
-			seq_printf(m, "R_AX_TXPKTCTL_B0_ERRFLAG_ISR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_B0_ERRFLAG_ISR));
-			seq_printf(m, "R_AX_TXPKTCTL_B1_ERRFLAG_IMR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_B1_ERRFLAG_IMR));
-			seq_printf(m, "R_AX_TXPKTCTL_B1_ERRFLAG_ISR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_B1_ERRFLAG_ISR));
+			p += scnprintf(p, end - p,
+				       "R_AX_TXPKTCTL_B0_ERRFLAG_IMR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_TXPKTCTL_B0_ERRFLAG_IMR));
+			p += scnprintf(p, end - p,
+				       "R_AX_TXPKTCTL_B0_ERRFLAG_ISR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_TXPKTCTL_B0_ERRFLAG_ISR));
+			p += scnprintf(p, end - p,
+				       "R_AX_TXPKTCTL_B1_ERRFLAG_IMR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_TXPKTCTL_B1_ERRFLAG_IMR));
+			p += scnprintf(p, end - p,
+				       "R_AX_TXPKTCTL_B1_ERRFLAG_ISR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_TXPKTCTL_B1_ERRFLAG_ISR));
 		} else {
-			seq_printf(m, "R_AX_TXPKTCTL_ERR_IMR_ISR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR));
-			seq_printf(m, "R_AX_TXPKTCTL_ERR_IMR_ISR_B1=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR_B1));
+			p += scnprintf(p, end - p,
+				       "R_AX_TXPKTCTL_ERR_IMR_ISR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR));
+			p += scnprintf(p, end - p,
+				       "R_AX_TXPKTCTL_ERR_IMR_ISR_B1=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR_B1));
 		}
 	}
 
 	if (dmac_err & B_AX_PLE_DLE_ERR_FLAG) {
-		seq_printf(m, "R_AX_WDE_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_WDE_ERR_IMR));
-		seq_printf(m, "R_AX_WDE_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_WDE_ERR_ISR));
-		seq_printf(m, "R_AX_PLE_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_PLE_ERR_IMR));
-		seq_printf(m, "R_AX_PLE_ERR_FLAG_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_ISR));
-		seq_printf(m, "R_AX_WD_CPUQ_OP_0=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_0));
-		seq_printf(m, "R_AX_WD_CPUQ_OP_1=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_1));
-		seq_printf(m, "R_AX_WD_CPUQ_OP_2=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_2));
-		seq_printf(m, "R_AX_WD_CPUQ_OP_STATUS=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_STATUS));
-		seq_printf(m, "R_AX_PL_CPUQ_OP_0=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_0));
-		seq_printf(m, "R_AX_PL_CPUQ_OP_1=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_1));
-		seq_printf(m, "R_AX_PL_CPUQ_OP_2=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_2));
-		seq_printf(m, "R_AX_PL_CPUQ_OP_STATUS=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_STATUS));
+		p += scnprintf(p, end - p, "R_AX_WDE_ERR_IMR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_WDE_ERR_IMR));
+		p += scnprintf(p, end - p, "R_AX_WDE_ERR_ISR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_WDE_ERR_ISR));
+		p += scnprintf(p, end - p, "R_AX_PLE_ERR_IMR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_PLE_ERR_IMR));
+		p += scnprintf(p, end - p, "R_AX_PLE_ERR_FLAG_ISR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_ISR));
+		p += scnprintf(p, end - p, "R_AX_WD_CPUQ_OP_0=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_0));
+		p += scnprintf(p, end - p, "R_AX_WD_CPUQ_OP_1=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_1));
+		p += scnprintf(p, end - p, "R_AX_WD_CPUQ_OP_2=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_2));
+		p += scnprintf(p, end - p, "R_AX_WD_CPUQ_OP_STATUS=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_STATUS));
+		p += scnprintf(p, end - p, "R_AX_PL_CPUQ_OP_0=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_0));
+		p += scnprintf(p, end - p, "R_AX_PL_CPUQ_OP_1=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_1));
+		p += scnprintf(p, end - p, "R_AX_PL_CPUQ_OP_2=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_2));
+		p += scnprintf(p, end - p, "R_AX_PL_CPUQ_OP_STATUS=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_STATUS));
 		if (chip->chip_id == RTL8852C) {
-			seq_printf(m, "R_AX_RX_CTRL0=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_RX_CTRL0));
-			seq_printf(m, "R_AX_RX_CTRL1=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_RX_CTRL1));
-			seq_printf(m, "R_AX_RX_CTRL2=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_RX_CTRL2));
+			p += scnprintf(p, end - p, "R_AX_RX_CTRL0=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_RX_CTRL0));
+			p += scnprintf(p, end - p, "R_AX_RX_CTRL1=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_RX_CTRL1));
+			p += scnprintf(p, end - p, "R_AX_RX_CTRL2=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_RX_CTRL2));
 		} else {
-			seq_printf(m, "R_AX_RXDMA_PKT_INFO_0=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_0));
-			seq_printf(m, "R_AX_RXDMA_PKT_INFO_1=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_1));
-			seq_printf(m, "R_AX_RXDMA_PKT_INFO_2=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_2));
+			p += scnprintf(p, end - p,
+				       "R_AX_RXDMA_PKT_INFO_0=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_0));
+			p += scnprintf(p, end - p,
+				       "R_AX_RXDMA_PKT_INFO_1=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_1));
+			p += scnprintf(p, end - p,
+				       "R_AX_RXDMA_PKT_INFO_2=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_2));
 		}
 	}
 
 	if (dmac_err & B_AX_PKTIN_ERR_FLAG) {
-		seq_printf(m, "R_AX_PKTIN_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_PKTIN_ERR_IMR));
-		seq_printf(m, "R_AX_PKTIN_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_PKTIN_ERR_ISR));
+		p += scnprintf(p, end - p, "R_AX_PKTIN_ERR_IMR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_PKTIN_ERR_IMR));
+		p += scnprintf(p, end - p, "R_AX_PKTIN_ERR_ISR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_PKTIN_ERR_ISR));
 	}
 
 	if (dmac_err & B_AX_DISPATCH_ERR_FLAG) {
-		seq_printf(m, "R_AX_HOST_DISPATCHER_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_HOST_DISPATCHER_ERR_IMR));
-		seq_printf(m, "R_AX_HOST_DISPATCHER_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_HOST_DISPATCHER_ERR_ISR));
-		seq_printf(m, "R_AX_CPU_DISPATCHER_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_CPU_DISPATCHER_ERR_IMR));
-		seq_printf(m, "R_AX_CPU_DISPATCHER_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_CPU_DISPATCHER_ERR_ISR));
-		seq_printf(m, "R_AX_OTHER_DISPATCHER_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_OTHER_DISPATCHER_ERR_IMR));
-		seq_printf(m, "R_AX_OTHER_DISPATCHER_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_OTHER_DISPATCHER_ERR_ISR));
+		p += scnprintf(p, end - p,
+			       "R_AX_HOST_DISPATCHER_ERR_IMR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_HOST_DISPATCHER_ERR_IMR));
+		p += scnprintf(p, end - p,
+			       "R_AX_HOST_DISPATCHER_ERR_ISR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_HOST_DISPATCHER_ERR_ISR));
+		p += scnprintf(p, end - p,
+			       "R_AX_CPU_DISPATCHER_ERR_IMR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_CPU_DISPATCHER_ERR_IMR));
+		p += scnprintf(p, end - p,
+			       "R_AX_CPU_DISPATCHER_ERR_ISR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_CPU_DISPATCHER_ERR_ISR));
+		p += scnprintf(p, end - p,
+			       "R_AX_OTHER_DISPATCHER_ERR_IMR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_OTHER_DISPATCHER_ERR_IMR));
+		p += scnprintf(p, end - p,
+			       "R_AX_OTHER_DISPATCHER_ERR_ISR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_OTHER_DISPATCHER_ERR_ISR));
 	}
 
 	if (dmac_err & B_AX_BBRPT_ERR_FLAG) {
 		if (chip->chip_id == RTL8852C) {
-			seq_printf(m, "R_AX_BBRPT_COM_ERR_IMR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_BBRPT_COM_ERR_IMR));
-			seq_printf(m, "R_AX_BBRPT_COM_ERR_ISR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_BBRPT_COM_ERR_ISR));
-			seq_printf(m, "R_AX_BBRPT_CHINFO_ERR_ISR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_ISR));
-			seq_printf(m, "R_AX_BBRPT_CHINFO_ERR_IMR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_IMR));
-			seq_printf(m, "R_AX_BBRPT_DFS_ERR_IMR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_IMR));
-			seq_printf(m, "R_AX_BBRPT_DFS_ERR_ISR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_ISR));
+			p += scnprintf(p, end - p,
+				       "R_AX_BBRPT_COM_ERR_IMR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_BBRPT_COM_ERR_IMR));
+			p += scnprintf(p, end - p,
+				       "R_AX_BBRPT_COM_ERR_ISR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_BBRPT_COM_ERR_ISR));
+			p += scnprintf(p, end - p,
+				       "R_AX_BBRPT_CHINFO_ERR_ISR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_ISR));
+			p += scnprintf(p, end - p,
+				       "R_AX_BBRPT_CHINFO_ERR_IMR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_IMR));
+			p += scnprintf(p, end - p,
+				       "R_AX_BBRPT_DFS_ERR_IMR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_IMR));
+			p += scnprintf(p, end - p,
+				       "R_AX_BBRPT_DFS_ERR_ISR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_ISR));
 		} else {
-			seq_printf(m, "R_AX_BBRPT_COM_ERR_IMR_ISR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_BBRPT_COM_ERR_IMR_ISR));
-			seq_printf(m, "R_AX_BBRPT_CHINFO_ERR_ISR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_ISR));
-			seq_printf(m, "R_AX_BBRPT_CHINFO_ERR_IMR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_IMR));
-			seq_printf(m, "R_AX_BBRPT_DFS_ERR_IMR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_IMR));
-			seq_printf(m, "R_AX_BBRPT_DFS_ERR_ISR=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_ISR));
+			p += scnprintf(p, end - p,
+				       "R_AX_BBRPT_COM_ERR_IMR_ISR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_BBRPT_COM_ERR_IMR_ISR));
+			p += scnprintf(p, end - p,
+				       "R_AX_BBRPT_CHINFO_ERR_ISR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_ISR));
+			p += scnprintf(p, end - p,
+				       "R_AX_BBRPT_CHINFO_ERR_IMR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_IMR));
+			p += scnprintf(p, end - p,
+				       "R_AX_BBRPT_DFS_ERR_IMR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_IMR));
+			p += scnprintf(p, end - p,
+				       "R_AX_BBRPT_DFS_ERR_ISR=0x%08x\n",
+				       rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_ISR));
 		}
 	}
 
 	if (dmac_err & B_AX_HAXIDMA_ERR_FLAG && chip->chip_id == RTL8852C) {
-		seq_printf(m, "R_AX_HAXIDMA_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_HAXI_IDCT_MSK));
-		seq_printf(m, "R_AX_HAXIDMA_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_HAXI_IDCT));
+		p += scnprintf(p, end - p, "R_AX_HAXIDMA_ERR_IMR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_HAXI_IDCT_MSK));
+		p += scnprintf(p, end - p, "R_AX_HAXIDMA_ERR_ISR=0x%08x\n",
+			       rtw89_read32(rtwdev, R_AX_HAXI_IDCT));
 	}
 
-	return 0;
+out:
+	return p - buf;
 }
 
 static int rtw89_debug_mac_dump_cmac_err(struct rtw89_dev *rtwdev,
-					 struct seq_file *m,
+					 char *buf, size_t bufsz,
 					 enum rtw89_mac_idx band)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	char *p = buf, *end = buf + bufsz;
 	u32 offset = 0;
 	u32 cmac_err;
 	int ret;
@@ -1570,96 +1640,127 @@ static int rtw89_debug_mac_dump_cmac_err(struct rtw89_dev *rtwdev,
 	ret = rtw89_mac_check_mac_en(rtwdev, band, RTW89_CMAC_SEL);
 	if (ret) {
 		if (band)
-			seq_puts(m, "[CMAC] : CMAC1 not enabled\n");
+			p += scnprintf(p, end - p,
+				       "[CMAC] : CMAC1 not enabled\n");
 		else
-			seq_puts(m, "[CMAC] : CMAC0 not enabled\n");
-		return ret;
+			p += scnprintf(p, end - p,
+				       "[CMAC] : CMAC0 not enabled\n");
+		goto out;
 	}
 
 	if (band)
 		offset = RTW89_MAC_AX_BAND_REG_OFFSET;
 
 	cmac_err = rtw89_read32(rtwdev, R_AX_CMAC_ERR_ISR + offset);
-	seq_printf(m, "R_AX_CMAC_ERR_ISR [%d]=0x%08x\n", band,
-		   rtw89_read32(rtwdev, R_AX_CMAC_ERR_ISR + offset));
-	seq_printf(m, "R_AX_CMAC_FUNC_EN [%d]=0x%08x\n", band,
-		   rtw89_read32(rtwdev, R_AX_CMAC_FUNC_EN + offset));
-	seq_printf(m, "R_AX_CK_EN [%d]=0x%08x\n", band,
-		   rtw89_read32(rtwdev, R_AX_CK_EN + offset));
+	p += scnprintf(p, end - p, "R_AX_CMAC_ERR_ISR [%d]=0x%08x\n", band,
+		       rtw89_read32(rtwdev, R_AX_CMAC_ERR_ISR + offset));
+	p += scnprintf(p, end - p, "R_AX_CMAC_FUNC_EN [%d]=0x%08x\n", band,
+		       rtw89_read32(rtwdev, R_AX_CMAC_FUNC_EN + offset));
+	p += scnprintf(p, end - p, "R_AX_CK_EN [%d]=0x%08x\n", band,
+		       rtw89_read32(rtwdev, R_AX_CK_EN + offset));
 
 	if (cmac_err & B_AX_SCHEDULE_TOP_ERR_IND) {
-		seq_printf(m, "R_AX_SCHEDULE_ERR_IMR [%d]=0x%08x\n", band,
-			   rtw89_read32(rtwdev, R_AX_SCHEDULE_ERR_IMR + offset));
-		seq_printf(m, "R_AX_SCHEDULE_ERR_ISR [%d]=0x%08x\n", band,
-			   rtw89_read32(rtwdev, R_AX_SCHEDULE_ERR_ISR + offset));
+		p += scnprintf(p, end - p,
+			       "R_AX_SCHEDULE_ERR_IMR [%d]=0x%08x\n", band,
+			       rtw89_read32(rtwdev, R_AX_SCHEDULE_ERR_IMR + offset));
+		p += scnprintf(p, end - p,
+			       "R_AX_SCHEDULE_ERR_ISR [%d]=0x%08x\n", band,
+			       rtw89_read32(rtwdev, R_AX_SCHEDULE_ERR_ISR + offset));
 	}
 
 	if (cmac_err & B_AX_PTCL_TOP_ERR_IND) {
-		seq_printf(m, "R_AX_PTCL_IMR0 [%d]=0x%08x\n", band,
-			   rtw89_read32(rtwdev, R_AX_PTCL_IMR0 + offset));
-		seq_printf(m, "R_AX_PTCL_ISR0 [%d]=0x%08x\n", band,
-			   rtw89_read32(rtwdev, R_AX_PTCL_ISR0 + offset));
+		p += scnprintf(p, end - p, "R_AX_PTCL_IMR0 [%d]=0x%08x\n",
+			       band,
+			       rtw89_read32(rtwdev, R_AX_PTCL_IMR0 + offset));
+		p += scnprintf(p, end - p, "R_AX_PTCL_ISR0 [%d]=0x%08x\n",
+			       band,
+			       rtw89_read32(rtwdev, R_AX_PTCL_ISR0 + offset));
 	}
 
 	if (cmac_err & B_AX_DMA_TOP_ERR_IND) {
 		if (chip->chip_id == RTL8852C) {
-			seq_printf(m, "R_AX_RX_ERR_FLAG [%d]=0x%08x\n", band,
-				   rtw89_read32(rtwdev, R_AX_RX_ERR_FLAG + offset));
-			seq_printf(m, "R_AX_RX_ERR_FLAG_IMR [%d]=0x%08x\n", band,
-				   rtw89_read32(rtwdev, R_AX_RX_ERR_FLAG_IMR + offset));
+			p += scnprintf(p, end - p,
+				       "R_AX_RX_ERR_FLAG [%d]=0x%08x\n", band,
+				       rtw89_read32(rtwdev, R_AX_RX_ERR_FLAG + offset));
+			p += scnprintf(p, end - p,
+				       "R_AX_RX_ERR_FLAG_IMR [%d]=0x%08x\n",
+				       band,
+				       rtw89_read32(rtwdev, R_AX_RX_ERR_FLAG_IMR + offset));
 		} else {
-			seq_printf(m, "R_AX_DLE_CTRL [%d]=0x%08x\n", band,
-				   rtw89_read32(rtwdev, R_AX_DLE_CTRL + offset));
+			p += scnprintf(p, end - p,
+				       "R_AX_DLE_CTRL [%d]=0x%08x\n", band,
+				       rtw89_read32(rtwdev, R_AX_DLE_CTRL + offset));
 		}
 	}
 
 	if (cmac_err & B_AX_DMA_TOP_ERR_IND || cmac_err & B_AX_WMAC_RX_ERR_IND) {
 		if (chip->chip_id == RTL8852C) {
-			seq_printf(m, "R_AX_PHYINFO_ERR_ISR [%d]=0x%08x\n", band,
-				   rtw89_read32(rtwdev, R_AX_PHYINFO_ERR_ISR + offset));
-			seq_printf(m, "R_AX_PHYINFO_ERR_IMR [%d]=0x%08x\n", band,
-				   rtw89_read32(rtwdev, R_AX_PHYINFO_ERR_IMR + offset));
+			p += scnprintf(p, end - p,
+				       "R_AX_PHYINFO_ERR_ISR [%d]=0x%08x\n",
+				       band,
+				       rtw89_read32(rtwdev, R_AX_PHYINFO_ERR_ISR + offset));
+			p += scnprintf(p, end - p,
+				       "R_AX_PHYINFO_ERR_IMR [%d]=0x%08x\n",
+				       band,
+				       rtw89_read32(rtwdev, R_AX_PHYINFO_ERR_IMR + offset));
 		} else {
-			seq_printf(m, "R_AX_PHYINFO_ERR_IMR [%d]=0x%08x\n", band,
-				   rtw89_read32(rtwdev, R_AX_PHYINFO_ERR_IMR + offset));
+			p += scnprintf(p, end - p,
+				       "R_AX_PHYINFO_ERR_IMR [%d]=0x%08x\n",
+				       band,
+				       rtw89_read32(rtwdev, R_AX_PHYINFO_ERR_IMR + offset));
 		}
 	}
 
 	if (cmac_err & B_AX_TXPWR_CTRL_ERR_IND) {
-		seq_printf(m, "R_AX_TXPWR_IMR [%d]=0x%08x\n", band,
-			   rtw89_read32(rtwdev, R_AX_TXPWR_IMR + offset));
-		seq_printf(m, "R_AX_TXPWR_ISR [%d]=0x%08x\n", band,
-			   rtw89_read32(rtwdev, R_AX_TXPWR_ISR + offset));
+		p += scnprintf(p, end - p, "R_AX_TXPWR_IMR [%d]=0x%08x\n",
+			       band,
+			       rtw89_read32(rtwdev, R_AX_TXPWR_IMR + offset));
+		p += scnprintf(p, end - p, "R_AX_TXPWR_ISR [%d]=0x%08x\n",
+			       band,
+			       rtw89_read32(rtwdev, R_AX_TXPWR_ISR + offset));
 	}
 
 	if (cmac_err & B_AX_WMAC_TX_ERR_IND) {
 		if (chip->chip_id == RTL8852C) {
-			seq_printf(m, "R_AX_TRXPTCL_ERROR_INDICA [%d]=0x%08x\n", band,
-				   rtw89_read32(rtwdev, R_AX_TRXPTCL_ERROR_INDICA + offset));
-			seq_printf(m, "R_AX_TRXPTCL_ERROR_INDICA_MASK [%d]=0x%08x\n", band,
-				   rtw89_read32(rtwdev, R_AX_TRXPTCL_ERROR_INDICA_MASK + offset));
+			p += scnprintf(p, end - p,
+				       "R_AX_TRXPTCL_ERROR_INDICA [%d]=0x%08x\n",
+				       band,
+				       rtw89_read32(rtwdev,
+						    R_AX_TRXPTCL_ERROR_INDICA + offset));
+			p += scnprintf(p, end - p,
+				       "R_AX_TRXPTCL_ERROR_INDICA_MASK [%d]=0x%08x\n",
+				       band,
+				       rtw89_read32(rtwdev,
+						    R_AX_TRXPTCL_ERROR_INDICA_MASK + offset));
 		} else {
-			seq_printf(m, "R_AX_TMAC_ERR_IMR_ISR [%d]=0x%08x\n", band,
-				   rtw89_read32(rtwdev, R_AX_TMAC_ERR_IMR_ISR + offset));
+			p += scnprintf(p, end - p,
+				       "R_AX_TMAC_ERR_IMR_ISR [%d]=0x%08x\n",
+				       band,
+				       rtw89_read32(rtwdev,
+						    R_AX_TMAC_ERR_IMR_ISR + offset));
 		}
-		seq_printf(m, "R_AX_DBGSEL_TRXPTCL [%d]=0x%08x\n", band,
-			   rtw89_read32(rtwdev, R_AX_DBGSEL_TRXPTCL + offset));
+		p += scnprintf(p, end - p,
+			       "R_AX_DBGSEL_TRXPTCL [%d]=0x%08x\n", band,
+			       rtw89_read32(rtwdev, R_AX_DBGSEL_TRXPTCL + offset));
 	}
 
-	seq_printf(m, "R_AX_CMAC_ERR_IMR [%d]=0x%08x\n", band,
-		   rtw89_read32(rtwdev, R_AX_CMAC_ERR_IMR + offset));
+	p += scnprintf(p, end - p, "R_AX_CMAC_ERR_IMR [%d]=0x%08x\n", band,
+		       rtw89_read32(rtwdev, R_AX_CMAC_ERR_IMR + offset));
 
-	return 0;
+out:
+	return p - buf;
 }
 
 static int rtw89_debug_mac_dump_cmac_dbg(struct rtw89_dev *rtwdev,
-					 struct seq_file *m)
+					 char *buf, size_t bufsz)
 {
-	rtw89_debug_mac_dump_cmac_err(rtwdev, m, RTW89_MAC_0);
+	char *p = buf, *end = buf + bufsz;
+
+	p += rtw89_debug_mac_dump_cmac_err(rtwdev, p, end - p, RTW89_MAC_0);
 	if (rtwdev->dbcc_en)
-		rtw89_debug_mac_dump_cmac_err(rtwdev, m, RTW89_MAC_1);
+		p += rtw89_debug_mac_dump_cmac_err(rtwdev, p, end - p, RTW89_MAC_1);
 
-	return 0;
+	return p - buf;
 }
 
 static const struct rtw89_mac_dbg_port_info dbg_port_ptcl_c0 = {
@@ -2465,11 +2566,12 @@ static const struct rtw89_mac_dbg_port_info dbg_port_pcie_misc2 = {
 	.rd_msk = B_AX_DEBUG_ST_MASK
 };
 
-static const struct rtw89_mac_dbg_port_info *
-rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
-			     struct rtw89_dev *rtwdev, u32 sel)
+static int
+rtw89_debug_mac_dbg_port_sel(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
+			     u32 sel, const struct rtw89_mac_dbg_port_info **ppinfo)
 {
-	const struct rtw89_mac_dbg_port_info *info;
+	const struct rtw89_mac_dbg_port_info *info = NULL;
+	char *p = buf, *end = buf + bufsz;
 	u32 index;
 	u32 val32;
 	u16 val16;
@@ -2481,28 +2583,28 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 		val16 = rtw89_read16(rtwdev, R_AX_PTCL_DBG);
 		val16 |= B_AX_PTCL_DBG_EN;
 		rtw89_write16(rtwdev, R_AX_PTCL_DBG, val16);
-		seq_puts(m, "Enable PTCL C0 dbgport.\n");
+		p += scnprintf(p, end - p, "Enable PTCL C0 dbgport.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_PTCL_C1:
 		info = &dbg_port_ptcl_c1;
 		val16 = rtw89_read16(rtwdev, R_AX_PTCL_DBG_C1);
 		val16 |= B_AX_PTCL_DBG_EN;
 		rtw89_write16(rtwdev, R_AX_PTCL_DBG_C1, val16);
-		seq_puts(m, "Enable PTCL C1 dbgport.\n");
+		p += scnprintf(p, end - p, "Enable PTCL C1 dbgport.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_SCH_C0:
 		info = &dbg_port_sch_c0;
 		val32 = rtw89_read32(rtwdev, R_AX_SCH_DBG_SEL);
 		val32 |= B_AX_SCH_DBG_EN;
 		rtw89_write32(rtwdev, R_AX_SCH_DBG_SEL, val32);
-		seq_puts(m, "Enable SCH C0 dbgport.\n");
+		p += scnprintf(p, end - p, "Enable SCH C0 dbgport.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_SCH_C1:
 		info = &dbg_port_sch_c1;
 		val32 = rtw89_read32(rtwdev, R_AX_SCH_DBG_SEL_C1);
 		val32 |= B_AX_SCH_DBG_EN;
 		rtw89_write32(rtwdev, R_AX_SCH_DBG_SEL_C1, val32);
-		seq_puts(m, "Enable SCH C1 dbgport.\n");
+		p += scnprintf(p, end - p, "Enable SCH C1 dbgport.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_TMAC_C0:
 		info = &dbg_port_tmac_c0;
@@ -2519,7 +2621,7 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 		val32 = rtw89_read32(rtwdev, R_AX_SYS_STATUS1);
 		val32 = u32_replace_bits(val32, MAC_DBG_SEL, B_AX_SEL_0XC0_MASK);
 		rtw89_write32(rtwdev, R_AX_SYS_STATUS1, val32);
-		seq_puts(m, "Enable TMAC C0 dbgport.\n");
+		p += scnprintf(p, end - p, "Enable TMAC C0 dbgport.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_TMAC_C1:
 		info = &dbg_port_tmac_c1;
@@ -2536,7 +2638,7 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 		val32 = rtw89_read32(rtwdev, R_AX_SYS_STATUS1);
 		val32 = u32_replace_bits(val32, MAC_DBG_SEL, B_AX_SEL_0XC0_MASK);
 		rtw89_write32(rtwdev, R_AX_SYS_STATUS1, val32);
-		seq_puts(m, "Enable TMAC C1 dbgport.\n");
+		p += scnprintf(p, end - p, "Enable TMAC C1 dbgport.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_RMAC_C0:
 		info = &dbg_port_rmac_c0;
@@ -2558,7 +2660,7 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 		val8 = u8_replace_bits(val8, RMAC_CMAC_DBG_SEL,
 				       B_AX_DBGSEL_TRXPTCL_MASK);
 		rtw89_write8(rtwdev, R_AX_DBGSEL_TRXPTCL, val8);
-		seq_puts(m, "Enable RMAC C0 dbgport.\n");
+		p += scnprintf(p, end - p, "Enable RMAC C0 dbgport.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_RMAC_C1:
 		info = &dbg_port_rmac_c1;
@@ -2580,23 +2682,23 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 		val8 = u8_replace_bits(val8, RMAC_CMAC_DBG_SEL,
 				       B_AX_DBGSEL_TRXPTCL_MASK);
 		rtw89_write8(rtwdev, R_AX_DBGSEL_TRXPTCL_C1, val8);
-		seq_puts(m, "Enable RMAC C1 dbgport.\n");
+		p += scnprintf(p, end - p, "Enable RMAC C1 dbgport.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_RMACST_C0:
 		info = &dbg_port_rmacst_c0;
-		seq_puts(m, "Enable RMAC state C0 dbgport.\n");
+		p += scnprintf(p, end - p, "Enable RMAC state C0 dbgport.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_RMACST_C1:
 		info = &dbg_port_rmacst_c1;
-		seq_puts(m, "Enable RMAC state C1 dbgport.\n");
+		p += scnprintf(p, end - p, "Enable RMAC state C1 dbgport.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_RMAC_PLCP_C0:
 		info = &dbg_port_rmac_plcp_c0;
-		seq_puts(m, "Enable RMAC PLCP C0 dbgport.\n");
+		p += scnprintf(p, end - p, "Enable RMAC PLCP C0 dbgport.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_RMAC_PLCP_C1:
 		info = &dbg_port_rmac_plcp_c1;
-		seq_puts(m, "Enable RMAC PLCP C1 dbgport.\n");
+		p += scnprintf(p, end - p, "Enable RMAC PLCP C1 dbgport.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_TRXPTCL_C0:
 		info = &dbg_port_trxptcl_c0;
@@ -2608,7 +2710,7 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 		val32 = rtw89_read32(rtwdev, R_AX_SYS_STATUS1);
 		val32 = u32_replace_bits(val32, MAC_DBG_SEL, B_AX_SEL_0XC0_MASK);
 		rtw89_write32(rtwdev, R_AX_SYS_STATUS1, val32);
-		seq_puts(m, "Enable TRXPTCL C0 dbgport.\n");
+		p += scnprintf(p, end - p, "Enable TRXPTCL C0 dbgport.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_TRXPTCL_C1:
 		info = &dbg_port_trxptcl_c1;
@@ -2620,131 +2722,137 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 		val32 = rtw89_read32(rtwdev, R_AX_SYS_STATUS1);
 		val32 = u32_replace_bits(val32, MAC_DBG_SEL, B_AX_SEL_0XC0_MASK);
 		rtw89_write32(rtwdev, R_AX_SYS_STATUS1, val32);
-		seq_puts(m, "Enable TRXPTCL C1 dbgport.\n");
+		p += scnprintf(p, end - p, "Enable TRXPTCL C1 dbgport.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_TX_INFOL_C0:
 		info = &dbg_port_tx_infol_c0;
 		val32 = rtw89_read32(rtwdev, R_AX_TCR1);
 		val32 |= B_AX_TCR_FORCE_READ_TXDFIFO;
 		rtw89_write32(rtwdev, R_AX_TCR1, val32);
-		seq_puts(m, "Enable tx infol dump.\n");
+		p += scnprintf(p, end - p, "Enable tx infol dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_TX_INFOH_C0:
 		info = &dbg_port_tx_infoh_c0;
 		val32 = rtw89_read32(rtwdev, R_AX_TCR1);
 		val32 |= B_AX_TCR_FORCE_READ_TXDFIFO;
 		rtw89_write32(rtwdev, R_AX_TCR1, val32);
-		seq_puts(m, "Enable tx infoh dump.\n");
+		p += scnprintf(p, end - p, "Enable tx infoh dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_TX_INFOL_C1:
 		info = &dbg_port_tx_infol_c1;
 		val32 = rtw89_read32(rtwdev, R_AX_TCR1_C1);
 		val32 |= B_AX_TCR_FORCE_READ_TXDFIFO;
 		rtw89_write32(rtwdev, R_AX_TCR1_C1, val32);
-		seq_puts(m, "Enable tx infol dump.\n");
+		p += scnprintf(p, end - p, "Enable tx infol dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_TX_INFOH_C1:
 		info = &dbg_port_tx_infoh_c1;
 		val32 = rtw89_read32(rtwdev, R_AX_TCR1_C1);
 		val32 |= B_AX_TCR_FORCE_READ_TXDFIFO;
 		rtw89_write32(rtwdev, R_AX_TCR1_C1, val32);
-		seq_puts(m, "Enable tx infoh dump.\n");
+		p += scnprintf(p, end - p, "Enable tx infoh dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_TXTF_INFOL_C0:
 		info = &dbg_port_txtf_infol_c0;
 		val32 = rtw89_read32(rtwdev, R_AX_TCR1);
 		val32 |= B_AX_TCR_FORCE_READ_TXDFIFO;
 		rtw89_write32(rtwdev, R_AX_TCR1, val32);
-		seq_puts(m, "Enable tx tf infol dump.\n");
+		p += scnprintf(p, end - p, "Enable tx tf infol dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_TXTF_INFOH_C0:
 		info = &dbg_port_txtf_infoh_c0;
 		val32 = rtw89_read32(rtwdev, R_AX_TCR1);
 		val32 |= B_AX_TCR_FORCE_READ_TXDFIFO;
 		rtw89_write32(rtwdev, R_AX_TCR1, val32);
-		seq_puts(m, "Enable tx tf infoh dump.\n");
+		p += scnprintf(p, end - p, "Enable tx tf infoh dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_TXTF_INFOL_C1:
 		info = &dbg_port_txtf_infol_c1;
 		val32 = rtw89_read32(rtwdev, R_AX_TCR1_C1);
 		val32 |= B_AX_TCR_FORCE_READ_TXDFIFO;
 		rtw89_write32(rtwdev, R_AX_TCR1_C1, val32);
-		seq_puts(m, "Enable tx tf infol dump.\n");
+		p += scnprintf(p, end - p, "Enable tx tf infol dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_TXTF_INFOH_C1:
 		info = &dbg_port_txtf_infoh_c1;
 		val32 = rtw89_read32(rtwdev, R_AX_TCR1_C1);
 		val32 |= B_AX_TCR_FORCE_READ_TXDFIFO;
 		rtw89_write32(rtwdev, R_AX_TCR1_C1, val32);
-		seq_puts(m, "Enable tx tf infoh dump.\n");
+		p += scnprintf(p, end - p, "Enable tx tf infoh dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_WDE_BUFMGN_FREEPG:
 		info = &dbg_port_wde_bufmgn_freepg;
-		seq_puts(m, "Enable wde bufmgn freepg dump.\n");
+		p += scnprintf(p, end - p, "Enable wde bufmgn freepg dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_WDE_BUFMGN_QUOTA:
 		info = &dbg_port_wde_bufmgn_quota;
-		seq_puts(m, "Enable wde bufmgn quota dump.\n");
+		p += scnprintf(p, end - p, "Enable wde bufmgn quota dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_WDE_BUFMGN_PAGELLT:
 		info = &dbg_port_wde_bufmgn_pagellt;
-		seq_puts(m, "Enable wde bufmgn pagellt dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable wde bufmgn pagellt dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_WDE_BUFMGN_PKTINFO:
 		info = &dbg_port_wde_bufmgn_pktinfo;
-		seq_puts(m, "Enable wde bufmgn pktinfo dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable wde bufmgn pktinfo dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_WDE_QUEMGN_PREPKT:
 		info = &dbg_port_wde_quemgn_prepkt;
-		seq_puts(m, "Enable wde quemgn prepkt dump.\n");
+		p += scnprintf(p, end - p, "Enable wde quemgn prepkt dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_WDE_QUEMGN_NXTPKT:
 		info = &dbg_port_wde_quemgn_nxtpkt;
-		seq_puts(m, "Enable wde quemgn nxtpkt dump.\n");
+		p += scnprintf(p, end - p, "Enable wde quemgn nxtpkt dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_WDE_QUEMGN_QLNKTBL:
 		info = &dbg_port_wde_quemgn_qlnktbl;
-		seq_puts(m, "Enable wde quemgn qlnktbl dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable wde quemgn qlnktbl dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_WDE_QUEMGN_QEMPTY:
 		info = &dbg_port_wde_quemgn_qempty;
-		seq_puts(m, "Enable wde quemgn qempty dump.\n");
+		p += scnprintf(p, end - p, "Enable wde quemgn qempty dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_PLE_BUFMGN_FREEPG:
 		info = &dbg_port_ple_bufmgn_freepg;
-		seq_puts(m, "Enable ple bufmgn freepg dump.\n");
+		p += scnprintf(p, end - p, "Enable ple bufmgn freepg dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_PLE_BUFMGN_QUOTA:
 		info = &dbg_port_ple_bufmgn_quota;
-		seq_puts(m, "Enable ple bufmgn quota dump.\n");
+		p += scnprintf(p, end - p, "Enable ple bufmgn quota dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_PLE_BUFMGN_PAGELLT:
 		info = &dbg_port_ple_bufmgn_pagellt;
-		seq_puts(m, "Enable ple bufmgn pagellt dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable ple bufmgn pagellt dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_PLE_BUFMGN_PKTINFO:
 		info = &dbg_port_ple_bufmgn_pktinfo;
-		seq_puts(m, "Enable ple bufmgn pktinfo dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable ple bufmgn pktinfo dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_PLE_QUEMGN_PREPKT:
 		info = &dbg_port_ple_quemgn_prepkt;
-		seq_puts(m, "Enable ple quemgn prepkt dump.\n");
+		p += scnprintf(p, end - p, "Enable ple quemgn prepkt dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_PLE_QUEMGN_NXTPKT:
 		info = &dbg_port_ple_quemgn_nxtpkt;
-		seq_puts(m, "Enable ple quemgn nxtpkt dump.\n");
+		p += scnprintf(p, end - p, "Enable ple quemgn nxtpkt dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_PLE_QUEMGN_QLNKTBL:
 		info = &dbg_port_ple_quemgn_qlnktbl;
-		seq_puts(m, "Enable ple quemgn qlnktbl dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable ple quemgn qlnktbl dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_PLE_QUEMGN_QEMPTY:
 		info = &dbg_port_ple_quemgn_qempty;
-		seq_puts(m, "Enable ple quemgn qempty dump.\n");
+		p += scnprintf(p, end - p, "Enable ple quemgn qempty dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_PKTINFO:
 		info = &dbg_port_pktinfo;
-		seq_puts(m, "Enable pktinfo dump.\n");
+		p += scnprintf(p, end - p, "Enable pktinfo dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_HDT_TX0:
 		rtw89_write32_mask(rtwdev, R_AX_DBG_CTRL,
@@ -2763,7 +2871,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 0);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, index);
-		seq_printf(m, "Enable Dispatcher hdt tx%x dump.\n", index);
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher hdt tx%x dump.\n", index);
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_HDT_TX6:
 		info = &dbg_port_dspt_hdt_tx6;
@@ -2771,7 +2880,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 0);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, 6);
-		seq_puts(m, "Enable Dispatcher hdt tx6 dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher hdt tx6 dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_HDT_TX7:
 		info = &dbg_port_dspt_hdt_tx7;
@@ -2779,7 +2889,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 0);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, 7);
-		seq_puts(m, "Enable Dispatcher hdt tx7 dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher hdt tx7 dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_HDT_TX8:
 		info = &dbg_port_dspt_hdt_tx8;
@@ -2787,7 +2898,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 0);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, 8);
-		seq_puts(m, "Enable Dispatcher hdt tx8 dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher hdt tx8 dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_HDT_TX9:
 	case RTW89_DBG_PORT_SEL_DSPT_HDT_TXA:
@@ -2799,7 +2911,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 0);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, index);
-		seq_printf(m, "Enable Dispatcher hdt tx%x dump.\n", index);
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher hdt tx%x dump.\n", index);
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_HDT_TXD:
 		info = &dbg_port_dspt_hdt_txD;
@@ -2807,7 +2920,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 0);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, 0xD);
-		seq_puts(m, "Enable Dispatcher hdt txD dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher hdt txD dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_CDT_TX0:
 		info = &dbg_port_dspt_cdt_tx0;
@@ -2815,7 +2929,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 1);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, 0);
-		seq_puts(m, "Enable Dispatcher cdt tx0 dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher cdt tx0 dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_CDT_TX1:
 		info = &dbg_port_dspt_cdt_tx1;
@@ -2823,7 +2938,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 1);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, 1);
-		seq_puts(m, "Enable Dispatcher cdt tx1 dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher cdt tx1 dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_CDT_TX3:
 		info = &dbg_port_dspt_cdt_tx3;
@@ -2831,7 +2947,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 1);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, 3);
-		seq_puts(m, "Enable Dispatcher cdt tx3 dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher cdt tx3 dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_CDT_TX4:
 		info = &dbg_port_dspt_cdt_tx4;
@@ -2839,7 +2956,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 1);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, 4);
-		seq_puts(m, "Enable Dispatcher cdt tx4 dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher cdt tx4 dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_CDT_TX5:
 	case RTW89_DBG_PORT_SEL_DSPT_CDT_TX6:
@@ -2851,7 +2969,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 1);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, index);
-		seq_printf(m, "Enable Dispatcher cdt tx%x dump.\n", index);
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher cdt tx%x dump.\n", index);
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_CDT_TX9:
 		info = &dbg_port_dspt_cdt_tx9;
@@ -2859,7 +2978,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 1);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, 9);
-		seq_puts(m, "Enable Dispatcher cdt tx9 dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher cdt tx9 dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_CDT_TXA:
 	case RTW89_DBG_PORT_SEL_DSPT_CDT_TXB:
@@ -2870,7 +2990,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 1);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, index);
-		seq_printf(m, "Enable Dispatcher cdt tx%x dump.\n", index);
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher cdt tx%x dump.\n", index);
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_HDT_RX0:
 		info = &dbg_port_dspt_hdt_rx0;
@@ -2878,7 +2999,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 2);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, 0);
-		seq_puts(m, "Enable Dispatcher hdt rx0 dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher hdt rx0 dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_HDT_RX1:
 	case RTW89_DBG_PORT_SEL_DSPT_HDT_RX2:
@@ -2888,7 +3010,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 2);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, index);
-		seq_printf(m, "Enable Dispatcher hdt rx%x dump.\n", index);
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher hdt rx%x dump.\n", index);
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_HDT_RX3:
 		info = &dbg_port_dspt_hdt_rx3;
@@ -2896,7 +3019,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 2);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, 3);
-		seq_puts(m, "Enable Dispatcher hdt rx3 dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher hdt rx3 dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_HDT_RX4:
 		info = &dbg_port_dspt_hdt_rx4;
@@ -2904,7 +3028,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 2);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, 4);
-		seq_puts(m, "Enable Dispatcher hdt rx4 dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher hdt rx4 dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_HDT_RX5:
 		info = &dbg_port_dspt_hdt_rx5;
@@ -2912,7 +3037,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 2);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, 5);
-		seq_puts(m, "Enable Dispatcher hdt rx5 dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher hdt rx5 dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_CDT_RX_P0_0:
 		info = &dbg_port_dspt_cdt_rx_p0_0;
@@ -2920,7 +3046,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 3);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, 0);
-		seq_puts(m, "Enable Dispatcher cdt rx part0 0 dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher cdt rx part0 0 dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_CDT_RX_P0:
 	case RTW89_DBG_PORT_SEL_DSPT_CDT_RX_P0_1:
@@ -2929,7 +3056,8 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 3);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, 1);
-		seq_puts(m, "Enable Dispatcher cdt rx part0 1 dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher cdt rx part0 1 dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_CDT_RX_P0_2:
 		info = &dbg_port_dspt_cdt_rx_p0_2;
@@ -2937,43 +3065,50 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 				   B_AX_DISPATCHER_INTN_SEL_MASK, 3);
 		rtw89_write16_mask(rtwdev, info->sel_addr,
 				   B_AX_DISPATCHER_CH_SEL_MASK, 2);
-		seq_puts(m, "Enable Dispatcher cdt rx part0 2 dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher cdt rx part0 2 dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_CDT_RX_P1:
 		info = &dbg_port_dspt_cdt_rx_p1;
 		rtw89_write8_mask(rtwdev, info->sel_addr,
 				  B_AX_DISPATCHER_INTN_SEL_MASK, 3);
-		seq_puts(m, "Enable Dispatcher cdt rx part1 dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher cdt rx part1 dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_STF_CTRL:
 		info = &dbg_port_dspt_stf_ctrl;
 		rtw89_write8_mask(rtwdev, info->sel_addr,
 				  B_AX_DISPATCHER_INTN_SEL_MASK, 4);
-		seq_puts(m, "Enable Dispatcher stf control dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher stf control dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_ADDR_CTRL:
 		info = &dbg_port_dspt_addr_ctrl;
 		rtw89_write8_mask(rtwdev, info->sel_addr,
 				  B_AX_DISPATCHER_INTN_SEL_MASK, 5);
-		seq_puts(m, "Enable Dispatcher addr control dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher addr control dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_WDE_INTF:
 		info = &dbg_port_dspt_wde_intf;
 		rtw89_write8_mask(rtwdev, info->sel_addr,
 				  B_AX_DISPATCHER_INTN_SEL_MASK, 6);
-		seq_puts(m, "Enable Dispatcher wde interface dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher wde interface dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_PLE_INTF:
 		info = &dbg_port_dspt_ple_intf;
 		rtw89_write8_mask(rtwdev, info->sel_addr,
 				  B_AX_DISPATCHER_INTN_SEL_MASK, 7);
-		seq_puts(m, "Enable Dispatcher ple interface dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher ple interface dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_DSPT_FLOW_CTRL:
 		info = &dbg_port_dspt_flow_ctrl;
 		rtw89_write8_mask(rtwdev, info->sel_addr,
 				  B_AX_DISPATCHER_INTN_SEL_MASK, 8);
-		seq_puts(m, "Enable Dispatcher flow control dump.\n");
+		p += scnprintf(p, end - p,
+			       "Enable Dispatcher flow control dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_PCIE_TXDMA:
 		info = &dbg_port_pcie_txdma;
@@ -2981,7 +3116,7 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 		val32 = u32_replace_bits(val32, PCIE_TXDMA_DBG_SEL, B_AX_DBG_SEL0);
 		val32 = u32_replace_bits(val32, PCIE_TXDMA_DBG_SEL, B_AX_DBG_SEL1);
 		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
-		seq_puts(m, "Enable pcie txdma dump.\n");
+		p += scnprintf(p, end - p, "Enable pcie txdma dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_PCIE_RXDMA:
 		info = &dbg_port_pcie_rxdma;
@@ -2989,7 +3124,7 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 		val32 = u32_replace_bits(val32, PCIE_RXDMA_DBG_SEL, B_AX_DBG_SEL0);
 		val32 = u32_replace_bits(val32, PCIE_RXDMA_DBG_SEL, B_AX_DBG_SEL1);
 		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
-		seq_puts(m, "Enable pcie rxdma dump.\n");
+		p += scnprintf(p, end - p, "Enable pcie rxdma dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_PCIE_CVT:
 		info = &dbg_port_pcie_cvt;
@@ -2997,7 +3132,7 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 		val32 = u32_replace_bits(val32, PCIE_CVT_DBG_SEL, B_AX_DBG_SEL0);
 		val32 = u32_replace_bits(val32, PCIE_CVT_DBG_SEL, B_AX_DBG_SEL1);
 		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
-		seq_puts(m, "Enable pcie cvt dump.\n");
+		p += scnprintf(p, end - p, "Enable pcie cvt dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_PCIE_CXPL:
 		info = &dbg_port_pcie_cxpl;
@@ -3005,7 +3140,7 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 		val32 = u32_replace_bits(val32, PCIE_CXPL_DBG_SEL, B_AX_DBG_SEL0);
 		val32 = u32_replace_bits(val32, PCIE_CXPL_DBG_SEL, B_AX_DBG_SEL1);
 		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
-		seq_puts(m, "Enable pcie cxpl dump.\n");
+		p += scnprintf(p, end - p, "Enable pcie cxpl dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_PCIE_IO:
 		info = &dbg_port_pcie_io;
@@ -3013,7 +3148,7 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 		val32 = u32_replace_bits(val32, PCIE_IO_DBG_SEL, B_AX_DBG_SEL0);
 		val32 = u32_replace_bits(val32, PCIE_IO_DBG_SEL, B_AX_DBG_SEL1);
 		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
-		seq_puts(m, "Enable pcie io dump.\n");
+		p += scnprintf(p, end - p, "Enable pcie io dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_PCIE_MISC:
 		info = &dbg_port_pcie_misc;
@@ -3021,7 +3156,7 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 		val32 = u32_replace_bits(val32, PCIE_MISC_DBG_SEL, B_AX_DBG_SEL0);
 		val32 = u32_replace_bits(val32, PCIE_MISC_DBG_SEL, B_AX_DBG_SEL1);
 		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
-		seq_puts(m, "Enable pcie misc dump.\n");
+		p += scnprintf(p, end - p, "Enable pcie misc dump.\n");
 		break;
 	case RTW89_DBG_PORT_SEL_PCIE_MISC2:
 		info = &dbg_port_pcie_misc2;
@@ -3029,14 +3164,16 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 		val16 = u16_replace_bits(val16, PCIE_MISC2_DBG_SEL,
 					 B_AX_PCIE_DBG_SEL_MASK);
 		rtw89_write16(rtwdev, R_AX_PCIE_DBG_CTRL, val16);
-		seq_puts(m, "Enable pcie misc2 dump.\n");
+		p += scnprintf(p, end - p, "Enable pcie misc2 dump.\n");
 		break;
 	default:
-		seq_puts(m, "Dbg port select err\n");
-		return NULL;
+		p += scnprintf(p, end - p, "Dbg port select err\n");
+		break;
 	}
 
-	return info;
+	*ppinfo = info;
+
+	return p - buf;
 }
 
 static bool is_dbg_port_valid(struct rtw89_dev *rtwdev, u32 sel)
@@ -3070,23 +3207,25 @@ static bool is_dbg_port_valid(struct rtw89_dev *rtwdev, u32 sel)
 }
 
 static int rtw89_debug_mac_dbg_port_dump(struct rtw89_dev *rtwdev,
-					 struct seq_file *m, u32 sel)
+					 char *buf, size_t bufsz, u32 sel)
 {
-	const struct rtw89_mac_dbg_port_info *info;
-	u8 val8;
-	u16 val16;
+	const struct rtw89_mac_dbg_port_info *info = NULL;
+	char *p = buf, *end = buf + bufsz;
 	u32 val32;
+	u16 val16;
+	u8 val8;
 	u32 i;
 
-	info = rtw89_debug_mac_dbg_port_sel(m, rtwdev, sel);
+	p += rtw89_debug_mac_dbg_port_sel(rtwdev, p, end - p, sel, &info);
+
 	if (!info) {
 		rtw89_err(rtwdev, "failed to select debug port %d\n", sel);
-		return -EINVAL;
+		goto out;
 	}
 
 #define case_DBG_SEL(__sel) \
 	case RTW89_DBG_PORT_SEL_##__sel: \
-		seq_puts(m, "Dump debug port " #__sel ":\n"); \
+		p += scnprintf(p, end - p, "Dump debug port " #__sel ":\n"); \
 		break
 
 	switch (sel) {
@@ -3182,8 +3321,8 @@ static int rtw89_debug_mac_dbg_port_dump(struct rtw89_dev *rtwdev,
 
 #undef case_DBG_SEL
 
-	seq_printf(m, "Sel addr = 0x%X\n", info->sel_addr);
-	seq_printf(m, "Read addr = 0x%X\n", info->rd_addr);
+	p += scnprintf(p, end - p, "Sel addr = 0x%X\n", info->sel_addr);
+	p += scnprintf(p, end - p, "Read addr = 0x%X\n", info->rd_addr);
 
 	for (i = info->srt; i <= info->end; i++) {
 		switch (info->sel_byte) {
@@ -3191,17 +3330,17 @@ static int rtw89_debug_mac_dbg_port_dump(struct rtw89_dev *rtwdev,
 		default:
 			rtw89_write8_mask(rtwdev, info->sel_addr,
 					  info->sel_msk, i);
-			seq_printf(m, "0x%02X: ", i);
+			p += scnprintf(p, end - p, "0x%02X: ", i);
 			break;
 		case 2:
 			rtw89_write16_mask(rtwdev, info->sel_addr,
 					   info->sel_msk, i);
-			seq_printf(m, "0x%04X: ", i);
+			p += scnprintf(p, end - p, "0x%04X: ", i);
 			break;
 		case 4:
 			rtw89_write32_mask(rtwdev, info->sel_addr,
 					   info->sel_msk, i);
-			seq_printf(m, "0x%04X: ", i);
+			p += scnprintf(p, end - p, "0x%04X: ", i);
 			break;
 		}
 
@@ -3212,77 +3351,75 @@ static int rtw89_debug_mac_dbg_port_dump(struct rtw89_dev *rtwdev,
 		default:
 			val8 = rtw89_read8_mask(rtwdev,
 						info->rd_addr, info->rd_msk);
-			seq_printf(m, "0x%02X\n", val8);
+			p += scnprintf(p, end - p, "0x%02X\n", val8);
 			break;
 		case 2:
 			val16 = rtw89_read16_mask(rtwdev,
 						  info->rd_addr, info->rd_msk);
-			seq_printf(m, "0x%04X\n", val16);
+			p += scnprintf(p, end - p, "0x%04X\n", val16);
 			break;
 		case 4:
 			val32 = rtw89_read32_mask(rtwdev,
 						  info->rd_addr, info->rd_msk);
-			seq_printf(m, "0x%08X\n", val32);
+			p += scnprintf(p, end - p, "0x%08X\n", val32);
 			break;
 		}
 	}
 
-	return 0;
+out:
+	return p - buf;
 }
 
 static int rtw89_debug_mac_dump_dbg_port(struct rtw89_dev *rtwdev,
-					 struct seq_file *m)
+					 char *buf, size_t bufsz)
 {
+	char *p = buf, *end = buf + bufsz;
+	ssize_t n;
 	u32 sel;
-	int ret = 0;
 
 	for (sel = RTW89_DBG_PORT_SEL_PTCL_C0;
 	     sel < RTW89_DBG_PORT_SEL_LAST; sel++) {
 		if (!is_dbg_port_valid(rtwdev, sel))
 			continue;
-		ret = rtw89_debug_mac_dbg_port_dump(rtwdev, m, sel);
-		if (ret) {
+		n = rtw89_debug_mac_dbg_port_dump(rtwdev, p, end - p, sel);
+		if (n < 0) {
 			rtw89_err(rtwdev,
 				  "failed to dump debug port %d\n", sel);
 			break;
 		}
+		p += n;
 	}
 
-	return ret;
+	return p - buf;
 }
 
-static int
-rtw89_debug_priv_mac_dbg_port_dump_get(struct seq_file *m, void *v)
+static ssize_t
+rtw89_debug_priv_mac_dbg_port_dump_get(struct rtw89_dev *rtwdev,
+				       struct rtw89_debugfs_priv *debugfs_priv,
+				       char *buf, size_t bufsz)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	char *p = buf, *end = buf + bufsz;
 
 	if (debugfs_priv->dbgpkg_en.ss_dbg)
-		rtw89_debug_mac_dump_ss_dbg(rtwdev, m);
+		p += rtw89_debug_mac_dump_ss_dbg(rtwdev, p, end - p);
 	if (debugfs_priv->dbgpkg_en.dle_dbg)
-		rtw89_debug_mac_dump_dle_dbg(rtwdev, m);
+		p += rtw89_debug_mac_dump_dle_dbg(rtwdev, p, end - p);
 	if (debugfs_priv->dbgpkg_en.dmac_dbg)
-		rtw89_debug_mac_dump_dmac_dbg(rtwdev, m);
+		p += rtw89_debug_mac_dump_dmac_dbg(rtwdev, p, end - p);
 	if (debugfs_priv->dbgpkg_en.cmac_dbg)
-		rtw89_debug_mac_dump_cmac_dbg(rtwdev, m);
+		p += rtw89_debug_mac_dump_cmac_dbg(rtwdev, p, end - p);
 	if (debugfs_priv->dbgpkg_en.dbg_port)
-		rtw89_debug_mac_dump_dbg_port(rtwdev, m);
+		p += rtw89_debug_mac_dump_dbg_port(rtwdev, p, end - p);
 
-	return 0;
+	return p - buf;
 };
 
-static u8 *rtw89_hex2bin_user(struct rtw89_dev *rtwdev,
-			      const char __user *user_buf, size_t count)
+static u8 *rtw89_hex2bin(struct rtw89_dev *rtwdev, const char *buf, size_t count)
 {
-	char *buf;
 	u8 *bin;
 	int num;
 	int err = 0;
 
-	buf = memdup_user(user_buf, count);
-	if (IS_ERR(buf))
-		return buf;
-
 	num = count / 2;
 	bin = kmalloc(num, GFP_KERNEL);
 	if (!bin) {
@@ -3297,22 +3434,18 @@ static u8 *rtw89_hex2bin_user(struct rtw89_dev *rtwdev,
 	}
 
 out:
-	kfree(buf);
-
 	return err ? ERR_PTR(err) : bin;
 }
 
-static ssize_t rtw89_debug_priv_send_h2c_set(struct file *filp,
-					     const char __user *user_buf,
-					     size_t count, loff_t *loff)
+static ssize_t rtw89_debug_priv_send_h2c_set(struct rtw89_dev *rtwdev,
+					     struct rtw89_debugfs_priv *debugfs_priv,
+					     const char *buf, size_t count)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	u8 *h2c;
 	int ret;
 	u16 h2c_len = count / 2;
 
-	h2c = rtw89_hex2bin_user(rtwdev, user_buf, count);
+	h2c = rtw89_hex2bin(rtwdev, buf, count);
 	if (IS_ERR(h2c))
 		return -EFAULT;
 
@@ -3323,34 +3456,34 @@ static ssize_t rtw89_debug_priv_send_h2c_set(struct file *filp,
 	return ret ? ret : count;
 }
 
-static int
-rtw89_debug_priv_early_h2c_get(struct seq_file *m, void *v)
+static ssize_t
+rtw89_debug_priv_early_h2c_get(struct rtw89_dev *rtwdev,
+			       struct rtw89_debugfs_priv *debugfs_priv,
+			       char *buf, size_t bufsz)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw89_early_h2c *early_h2c;
+	char *p = buf, *end = buf + bufsz;
 	int seq = 0;
 
 	mutex_lock(&rtwdev->mutex);
 	list_for_each_entry(early_h2c, &rtwdev->early_h2c_list, list)
-		seq_printf(m, "%d: %*ph\n", ++seq, early_h2c->h2c_len, early_h2c->h2c);
+		p += scnprintf(p, end - p, "%d: %*ph\n", ++seq,
+			       early_h2c->h2c_len, early_h2c->h2c);
 	mutex_unlock(&rtwdev->mutex);
 
-	return 0;
+	return p - buf;
 }
 
 static ssize_t
-rtw89_debug_priv_early_h2c_set(struct file *filp, const char __user *user_buf,
-			       size_t count, loff_t *loff)
+rtw89_debug_priv_early_h2c_set(struct rtw89_dev *rtwdev,
+			       struct rtw89_debugfs_priv *debugfs_priv,
+			       const char *buf, size_t count)
 {
-	struct seq_file *m = (struct seq_file *)filp->private_data;
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw89_early_h2c *early_h2c;
 	u8 *h2c;
 	u16 h2c_len = count / 2;
 
-	h2c = rtw89_hex2bin_user(rtwdev, user_buf, count);
+	h2c = rtw89_hex2bin(rtwdev, buf, count);
 	if (IS_ERR(h2c))
 		return -EFAULT;
 
@@ -3404,15 +3537,16 @@ static int rtw89_dbg_trigger_ctrl_error(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static int
-rtw89_debug_priv_fw_crash_get(struct seq_file *m, void *v)
+static ssize_t
+rtw89_debug_priv_fw_crash_get(struct rtw89_dev *rtwdev,
+			      struct rtw89_debugfs_priv *debugfs_priv,
+			      char *buf, size_t bufsz)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	char *p = buf, *end = buf + bufsz;
 
-	seq_printf(m, "%d\n",
-		   test_bit(RTW89_FLAG_CRASH_SIMULATING, rtwdev->flags));
-	return 0;
+	p += scnprintf(p, end - p, "%d\n",
+		       test_bit(RTW89_FLAG_CRASH_SIMULATING, rtwdev->flags));
+	return p - buf;
 }
 
 enum rtw89_dbg_crash_simulation_type {
@@ -3421,17 +3555,15 @@ enum rtw89_dbg_crash_simulation_type {
 };
 
 static ssize_t
-rtw89_debug_priv_fw_crash_set(struct file *filp, const char __user *user_buf,
-			      size_t count, loff_t *loff)
+rtw89_debug_priv_fw_crash_set(struct rtw89_dev *rtwdev,
+			      struct rtw89_debugfs_priv *debugfs_priv,
+			      const char *buf, size_t count)
 {
-	struct seq_file *m = (struct seq_file *)filp->private_data;
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	int (*sim)(struct rtw89_dev *rtwdev);
 	u8 crash_type;
 	int ret;
 
-	ret = kstrtou8_from_user(user_buf, count, 0, &crash_type);
+	ret = kstrtou8(buf, 0, &crash_type);
 	if (ret)
 		return -EINVAL;
 
@@ -3459,27 +3591,22 @@ rtw89_debug_priv_fw_crash_set(struct file *filp, const char __user *user_buf,
 	return count;
 }
 
-static int rtw89_debug_priv_btc_info_get(struct seq_file *m, void *v)
+static ssize_t rtw89_debug_priv_btc_info_get(struct rtw89_dev *rtwdev,
+					     struct rtw89_debugfs_priv *debugfs_priv,
+					     char *buf, size_t bufsz)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
-
-	rtw89_btc_dump_info(rtwdev, m);
-
-	return 0;
+	return rtw89_btc_dump_info(rtwdev, buf, bufsz);
 }
 
-static ssize_t rtw89_debug_priv_btc_manual_set(struct file *filp,
-					       const char __user *user_buf,
-					       size_t count, loff_t *loff)
+static ssize_t rtw89_debug_priv_btc_manual_set(struct rtw89_dev *rtwdev,
+					       struct rtw89_debugfs_priv *debugfs_priv,
+					       const char *buf, size_t count)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
 	int ret;
 
-	ret = kstrtobool_from_user(user_buf, count, &btc->manual_ctrl);
+	ret = kstrtobool(buf, &btc->manual_ctrl);
 	if (ret)
 		return ret;
 
@@ -3491,16 +3618,14 @@ static ssize_t rtw89_debug_priv_btc_manual_set(struct file *filp,
 	return count;
 }
 
-static ssize_t rtw89_debug_priv_fw_log_manual_set(struct file *filp,
-						  const char __user *user_buf,
-						  size_t count, loff_t *loff)
+static ssize_t rtw89_debug_priv_fw_log_manual_set(struct rtw89_dev *rtwdev,
+						  struct rtw89_debugfs_priv *debugfs_priv,
+						  const char *buf, size_t count)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw89_fw_log *log = &rtwdev->fw.log;
 	bool fw_log_manual;
 
-	if (kstrtobool_from_user(user_buf, count, &fw_log_manual))
+	if (kstrtobool(buf, &fw_log_manual))
 		goto out;
 
 	mutex_lock(&rtwdev->mutex);
@@ -3513,9 +3638,9 @@ static ssize_t rtw89_debug_priv_fw_log_manual_set(struct file *filp,
 	return count;
 }
 
-static void rtw89_sta_link_info_get_iter(struct seq_file *m,
-					 struct rtw89_dev *rtwdev,
-					 struct rtw89_sta_link *rtwsta_link)
+static int rtw89_sta_link_info_get_iter(struct rtw89_dev *rtwdev,
+					char *buf, size_t bufsz,
+					struct rtw89_sta_link *rtwsta_link)
 {
 	static const char * const he_gi_str[] = {
 		[NL80211_RATE_INFO_HE_GI_0_8] = "0.8",
@@ -3533,6 +3658,7 @@ static void rtw89_sta_link_info_get_iter(struct seq_file *m,
 	u8 ant_num = hal->ant_diversity ? 2 : rtwdev->chip->rf_path_num;
 	bool ant_asterisk = hal->tx_path_diversity || hal->ant_diversity;
 	struct ieee80211_link_sta *link_sta;
+	char *p = buf, *end = buf + bufsz;
 	u8 evm_min, evm_max, evm_1ss;
 	u16 max_rc_amsdu_len;
 	u8 rssi;
@@ -3546,107 +3672,136 @@ static void rtw89_sta_link_info_get_iter(struct seq_file *m,
 
 	rcu_read_unlock();
 
-	seq_printf(m, "TX rate [%u, %u]: ", rtwsta_link->mac_id, rtwsta_link->link_id);
+	p += scnprintf(p, end - p, "TX rate [%u, %u]: ", rtwsta_link->mac_id,
+		       rtwsta_link->link_id);
 
 	if (rate->flags & RATE_INFO_FLAGS_MCS)
-		seq_printf(m, "HT MCS-%d%s", rate->mcs,
-			   rate->flags & RATE_INFO_FLAGS_SHORT_GI ? " SGI" : "");
+		p += scnprintf(p, end - p, "HT MCS-%d%s", rate->mcs,
+			       rate->flags & RATE_INFO_FLAGS_SHORT_GI ? " SGI" : "");
 	else if (rate->flags & RATE_INFO_FLAGS_VHT_MCS)
-		seq_printf(m, "VHT %dSS MCS-%d%s", rate->nss, rate->mcs,
-			   rate->flags & RATE_INFO_FLAGS_SHORT_GI ? " SGI" : "");
+		p += scnprintf(p, end - p, "VHT %dSS MCS-%d%s", rate->nss,
+			       rate->mcs,
+			       rate->flags & RATE_INFO_FLAGS_SHORT_GI ? " SGI" : "");
 	else if (rate->flags & RATE_INFO_FLAGS_HE_MCS)
-		seq_printf(m, "HE %dSS MCS-%d GI:%s", rate->nss, rate->mcs,
-			   rate->he_gi <= NL80211_RATE_INFO_HE_GI_3_2 ?
-			   he_gi_str[rate->he_gi] : "N/A");
+		p += scnprintf(p, end - p, "HE %dSS MCS-%d GI:%s", rate->nss,
+			       rate->mcs,
+			       rate->he_gi <= NL80211_RATE_INFO_HE_GI_3_2 ?
+			       he_gi_str[rate->he_gi] : "N/A");
 	else if (rate->flags & RATE_INFO_FLAGS_EHT_MCS)
-		seq_printf(m, "EHT %dSS MCS-%d GI:%s", rate->nss, rate->mcs,
-			   rate->eht_gi < ARRAY_SIZE(eht_gi_str) ?
-			   eht_gi_str[rate->eht_gi] : "N/A");
+		p += scnprintf(p, end - p, "EHT %dSS MCS-%d GI:%s", rate->nss,
+			       rate->mcs,
+			       rate->eht_gi < ARRAY_SIZE(eht_gi_str) ?
+			       eht_gi_str[rate->eht_gi] : "N/A");
 	else
-		seq_printf(m, "Legacy %d", rate->legacy);
-	seq_printf(m, "%s", rtwsta_link->ra_report.might_fallback_legacy ? " FB_G" : "");
-	seq_printf(m, " BW:%u", rtw89_rate_info_bw_to_mhz(rate->bw));
-	seq_printf(m, " (hw_rate=0x%x)", rtwsta_link->ra_report.hw_rate);
-	seq_printf(m, " ==> agg_wait=%d (%d)\n", rtwsta_link->max_agg_wait,
-		   max_rc_amsdu_len);
-
-	seq_printf(m, "RX rate [%u, %u]: ", rtwsta_link->mac_id, rtwsta_link->link_id);
+		p += scnprintf(p, end - p, "Legacy %d", rate->legacy);
+	p += scnprintf(p, end - p, "%s",
+		       rtwsta_link->ra_report.might_fallback_legacy ? " FB_G" : "");
+	p += scnprintf(p, end - p, " BW:%u",
+		       rtw89_rate_info_bw_to_mhz(rate->bw));
+	p += scnprintf(p, end - p, " (hw_rate=0x%x)",
+		       rtwsta_link->ra_report.hw_rate);
+	p += scnprintf(p, end - p, " ==> agg_wait=%d (%d)\n",
+		       rtwsta_link->max_agg_wait,
+		       max_rc_amsdu_len);
+
+	p += scnprintf(p, end - p, "RX rate [%u, %u]: ", rtwsta_link->mac_id,
+		       rtwsta_link->link_id);
 
 	switch (status->encoding) {
 	case RX_ENC_LEGACY:
-		seq_printf(m, "Legacy %d", status->rate_idx +
-			   (status->band != NL80211_BAND_2GHZ ? 4 : 0));
+		p += scnprintf(p, end - p, "Legacy %d", status->rate_idx +
+			       (status->band != NL80211_BAND_2GHZ ? 4 : 0));
 		break;
 	case RX_ENC_HT:
-		seq_printf(m, "HT MCS-%d%s", status->rate_idx,
-			   status->enc_flags & RX_ENC_FLAG_SHORT_GI ? " SGI" : "");
+		p += scnprintf(p, end - p, "HT MCS-%d%s", status->rate_idx,
+			       status->enc_flags & RX_ENC_FLAG_SHORT_GI ? " SGI" : "");
 		break;
 	case RX_ENC_VHT:
-		seq_printf(m, "VHT %dSS MCS-%d%s", status->nss, status->rate_idx,
-			   status->enc_flags & RX_ENC_FLAG_SHORT_GI ? " SGI" : "");
+		p += scnprintf(p, end - p, "VHT %dSS MCS-%d%s", status->nss,
+			       status->rate_idx,
+			       status->enc_flags & RX_ENC_FLAG_SHORT_GI ? " SGI" : "");
 		break;
 	case RX_ENC_HE:
-		seq_printf(m, "HE %dSS MCS-%d GI:%s", status->nss, status->rate_idx,
-			   status->he_gi <= NL80211_RATE_INFO_HE_GI_3_2 ?
-			   he_gi_str[status->he_gi] : "N/A");
+		p += scnprintf(p, end - p, "HE %dSS MCS-%d GI:%s",
+			       status->nss, status->rate_idx,
+			       status->he_gi <= NL80211_RATE_INFO_HE_GI_3_2 ?
+			       he_gi_str[status->he_gi] : "N/A");
 		break;
 	case RX_ENC_EHT:
-		seq_printf(m, "EHT %dSS MCS-%d GI:%s", status->nss, status->rate_idx,
-			   status->eht.gi < ARRAY_SIZE(eht_gi_str) ?
-			   eht_gi_str[status->eht.gi] : "N/A");
+		p += scnprintf(p, end - p, "EHT %dSS MCS-%d GI:%s",
+			       status->nss, status->rate_idx,
+			       status->eht.gi < ARRAY_SIZE(eht_gi_str) ?
+			       eht_gi_str[status->eht.gi] : "N/A");
 		break;
 	}
-	seq_printf(m, " BW:%u", rtw89_rate_info_bw_to_mhz(status->bw));
-	seq_printf(m, " (hw_rate=0x%x)\n", rtwsta_link->rx_hw_rate);
+	p += scnprintf(p, end - p, " BW:%u",
+		       rtw89_rate_info_bw_to_mhz(status->bw));
+	p += scnprintf(p, end - p, " (hw_rate=0x%x)\n",
+		       rtwsta_link->rx_hw_rate);
 
 	rssi = ewma_rssi_read(&rtwsta_link->avg_rssi);
-	seq_printf(m, "RSSI: %d dBm (raw=%d, prev=%d) [",
-		   RTW89_RSSI_RAW_TO_DBM(rssi), rssi, rtwsta_link->prev_rssi);
+	p += scnprintf(p, end - p, "RSSI: %d dBm (raw=%d, prev=%d) [",
+		       RTW89_RSSI_RAW_TO_DBM(rssi), rssi,
+		       rtwsta_link->prev_rssi);
 	for (i = 0; i < ant_num; i++) {
 		rssi = ewma_rssi_read(&rtwsta_link->rssi[i]);
-		seq_printf(m, "%d%s%s", RTW89_RSSI_RAW_TO_DBM(rssi),
-			   ant_asterisk && (hal->antenna_tx & BIT(i)) ? "*" : "",
-			   i + 1 == ant_num ? "" : ", ");
+		p += scnprintf(p, end - p, "%d%s%s",
+			       RTW89_RSSI_RAW_TO_DBM(rssi),
+			       ant_asterisk && (hal->antenna_tx & BIT(i)) ? "*" : "",
+			       i + 1 == ant_num ? "" : ", ");
 	}
-	seq_puts(m, "]\n");
+	p += scnprintf(p, end - p, "]\n");
 
 	evm_1ss = ewma_evm_read(&rtwsta_link->evm_1ss);
-	seq_printf(m, "EVM: [%2u.%02u, ", evm_1ss >> 2, (evm_1ss & 0x3) * 25);
+	p += scnprintf(p, end - p, "EVM: [%2u.%02u, ", evm_1ss >> 2,
+		       (evm_1ss & 0x3) * 25);
 	for (i = 0; i < (hal->ant_diversity ? 2 : 1); i++) {
 		evm_min = ewma_evm_read(&rtwsta_link->evm_min[i]);
 		evm_max = ewma_evm_read(&rtwsta_link->evm_max[i]);
 
-		seq_printf(m, "%s(%2u.%02u, %2u.%02u)", i == 0 ? "" : " ",
-			   evm_min >> 2, (evm_min & 0x3) * 25,
-			   evm_max >> 2, (evm_max & 0x3) * 25);
+		p += scnprintf(p, end - p, "%s(%2u.%02u, %2u.%02u)",
+			       i == 0 ? "" : " ",
+			       evm_min >> 2, (evm_min & 0x3) * 25,
+			       evm_max >> 2, (evm_max & 0x3) * 25);
 	}
-	seq_puts(m, "]\t");
+	p += scnprintf(p, end - p, "]\t");
 
 	snr = ewma_snr_read(&rtwsta_link->avg_snr);
-	seq_printf(m, "SNR: %u\n", snr);
+	p += scnprintf(p, end - p, "SNR: %u\n", snr);
+
+	return p - buf;
 }
 
 static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 {
-	struct seq_file *m = (struct seq_file *)data;
+	struct rtw89_debugfs_iter_data *iter_data =
+		(struct rtw89_debugfs_iter_data *)data;
 	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
 	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
 	struct rtw89_sta_link *rtwsta_link;
+	size_t bufsz = iter_data->bufsz;
+	char *buf = iter_data->buf;
+	char *p = buf, *end = buf + bufsz;
 	unsigned int link_id;
 
 	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id)
-		rtw89_sta_link_info_get_iter(m, rtwdev, rtwsta_link);
+		p += rtw89_sta_link_info_get_iter(rtwdev, p, end - p, rtwsta_link);
+
+	rtw89_debugfs_iter_data_next(iter_data, p, end - p, p - buf);
 }
 
-static void
-rtw89_debug_append_rx_rate(struct seq_file *m, struct rtw89_pkt_stat *pkt_stat,
+static int
+rtw89_debug_append_rx_rate(char *buf, size_t bufsz, struct rtw89_pkt_stat *pkt_stat,
 			   enum rtw89_hw_rate first_rate, int len)
 {
+	char *p = buf, *end = buf + bufsz;
 	int i;
 
 	for (i = 0; i < len; i++)
-		seq_printf(m, "%s%u", i == 0 ? "" : ", ",
-			   pkt_stat->rx_rate_cnt[first_rate + i]);
+		p += scnprintf(p, end - p, "%s%u", i == 0 ? "" : ", ",
+			       pkt_stat->rx_rate_cnt[first_rate + i]);
+
+	return p - buf;
 }
 
 #define FIRST_RATE_SAME(rate) {RTW89_HW_RATE_ ## rate, RTW89_HW_RATE_ ## rate}
@@ -3671,34 +3826,40 @@ static const struct rtw89_rx_rate_cnt_info {
 	{FIRST_RATE_GEV1(EHT_NSS2_MCS0), 14, 0, "EHT 2SS:"},
 };
 
-static int rtw89_debug_priv_phy_info_get(struct seq_file *m, void *v)
+static ssize_t rtw89_debug_priv_phy_info_get(struct rtw89_dev *rtwdev,
+					     struct rtw89_debugfs_priv *debugfs_priv,
+					     char *buf, size_t bufsz)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw89_traffic_stats *stats = &rtwdev->stats;
 	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.last_pkt_stat;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_debugfs_iter_data iter_data;
 	const struct rtw89_rx_rate_cnt_info *info;
 	struct rtw89_hal *hal = &rtwdev->hal;
+	char *p = buf, *end = buf + bufsz;
 	enum rtw89_hw_rate first_rate;
 	u8 rssi;
 	int i;
 
 	rssi = ewma_rssi_read(&rtwdev->phystat.bcn_rssi);
 
-	seq_printf(m, "TP TX: %u [%u] Mbps (lv: %d",
-		   stats->tx_throughput, stats->tx_throughput_raw, stats->tx_tfc_lv);
+	p += scnprintf(p, end - p, "TP TX: %u [%u] Mbps (lv: %d",
+		       stats->tx_throughput, stats->tx_throughput_raw,
+		       stats->tx_tfc_lv);
 	if (hal->thermal_prot_lv)
-		seq_printf(m, ", duty: %d%%",
-			   100 - hal->thermal_prot_lv * RTW89_THERMAL_PROT_STEP);
-	seq_printf(m, "), RX: %u [%u] Mbps (lv: %d)\n",
-		   stats->rx_throughput, stats->rx_throughput_raw, stats->rx_tfc_lv);
-	seq_printf(m, "Beacon: %u (%d dBm), TF: %u\n", pkt_stat->beacon_nr,
-		   RTW89_RSSI_RAW_TO_DBM(rssi), stats->rx_tf_periodic);
-	seq_printf(m, "Avg packet length: TX=%u, RX=%u\n", stats->tx_avg_len,
-		   stats->rx_avg_len);
-
-	seq_puts(m, "RX count:\n");
+		p += scnprintf(p, end - p, ", duty: %d%%",
+			       100 - hal->thermal_prot_lv * RTW89_THERMAL_PROT_STEP);
+	p += scnprintf(p, end - p, "), RX: %u [%u] Mbps (lv: %d)\n",
+		       stats->rx_throughput, stats->rx_throughput_raw,
+		       stats->rx_tfc_lv);
+	p += scnprintf(p, end - p, "Beacon: %u (%d dBm), TF: %u\n",
+		       pkt_stat->beacon_nr,
+		       RTW89_RSSI_RAW_TO_DBM(rssi), stats->rx_tf_periodic);
+	p += scnprintf(p, end - p, "Avg packet length: TX=%u, RX=%u\n",
+		       stats->tx_avg_len,
+		       stats->rx_avg_len);
+
+	p += scnprintf(p, end - p, "RX count:\n");
 
 	for (i = 0; i < ARRAY_SIZE(rtw89_rx_rate_cnt_infos); i++) {
 		info = &rtw89_rx_rate_cnt_infos[i];
@@ -3706,189 +3867,240 @@ static int rtw89_debug_priv_phy_info_get(struct seq_file *m, void *v)
 		if (first_rate >= RTW89_HW_RATE_NR)
 			continue;
 
-		seq_printf(m, "%10s [", info->rate_mode);
-		rtw89_debug_append_rx_rate(m, pkt_stat,
-					   first_rate, info->len);
+		p += scnprintf(p, end - p, "%10s [", info->rate_mode);
+		p += rtw89_debug_append_rx_rate(p, end - p, pkt_stat,
+						first_rate, info->len);
 		if (info->ext) {
-			seq_puts(m, "][");
-			rtw89_debug_append_rx_rate(m, pkt_stat,
-						   first_rate + info->len, info->ext);
+			p += scnprintf(p, end - p, "][");
+			p += rtw89_debug_append_rx_rate(p, end - p, pkt_stat,
+							first_rate + info->len, info->ext);
 		}
-		seq_puts(m, "]\n");
+		p += scnprintf(p, end - p, "]\n");
 	}
 
-	ieee80211_iterate_stations_atomic(rtwdev->hw, rtw89_sta_info_get_iter, m);
+	rtw89_debugfs_iter_data_setup(&iter_data, p, end - p);
+	ieee80211_iterate_stations_atomic(rtwdev->hw, rtw89_sta_info_get_iter, &iter_data);
+	p += iter_data.written_sz;
 
-	return 0;
+	return p - buf;
 }
 
-static void rtw89_dump_addr_cam(struct seq_file *m,
-				struct rtw89_dev *rtwdev,
-				struct rtw89_addr_cam_entry *addr_cam)
+static int rtw89_dump_addr_cam(struct rtw89_dev *rtwdev,
+			       char *buf, size_t bufsz,
+			       struct rtw89_addr_cam_entry *addr_cam)
 {
 	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
 	const struct rtw89_sec_cam_entry *sec_entry;
+	char *p = buf, *end = buf + bufsz;
 	u8 sec_cam_idx;
 	int i;
 
-	seq_printf(m, "\taddr_cam_idx=%u\n", addr_cam->addr_cam_idx);
-	seq_printf(m, "\t-> bssid_cam_idx=%u\n", addr_cam->bssid_cam_idx);
-	seq_printf(m, "\tsec_cam_bitmap=%*ph\n", (int)sizeof(addr_cam->sec_cam_map),
-		   addr_cam->sec_cam_map);
+	p += scnprintf(p, end - p, "\taddr_cam_idx=%u\n",
+		       addr_cam->addr_cam_idx);
+	p += scnprintf(p, end - p, "\t-> bssid_cam_idx=%u\n",
+		       addr_cam->bssid_cam_idx);
+	p += scnprintf(p, end - p, "\tsec_cam_bitmap=%*ph\n",
+		       (int)sizeof(addr_cam->sec_cam_map),
+		       addr_cam->sec_cam_map);
 	for_each_set_bit(i, addr_cam->sec_cam_map, RTW89_SEC_CAM_IN_ADDR_CAM) {
 		sec_cam_idx = addr_cam->sec_ent[i];
 		sec_entry = cam_info->sec_entries[sec_cam_idx];
 		if (!sec_entry)
 			continue;
-		seq_printf(m, "\tsec[%d]: sec_cam_idx %u", i, sec_entry->sec_cam_idx);
+		p += scnprintf(p, end - p, "\tsec[%d]: sec_cam_idx %u", i,
+			       sec_entry->sec_cam_idx);
 		if (sec_entry->ext_key)
-			seq_printf(m, ", %u", sec_entry->sec_cam_idx + 1);
-		seq_puts(m, "\n");
+			p += scnprintf(p, end - p, ", %u",
+				       sec_entry->sec_cam_idx + 1);
+		p += scnprintf(p, end - p, "\n");
 	}
+
+	return p - buf;
 }
 
-__printf(3, 4)
-static void rtw89_dump_pkt_offload(struct seq_file *m, struct list_head *pkt_list,
-				   const char *fmt, ...)
+__printf(4, 5)
+static int rtw89_dump_pkt_offload(char *buf, size_t bufsz, struct list_head *pkt_list,
+				  const char *fmt, ...)
 {
+	char *p = buf, *end = buf + bufsz;
 	struct rtw89_pktofld_info *info;
 	struct va_format vaf;
 	va_list args;
 
 	if (list_empty(pkt_list))
-		return;
+		return 0;
 
 	va_start(args, fmt);
 	vaf.va = &args;
 	vaf.fmt = fmt;
 
-	seq_printf(m, "%pV", &vaf);
+	p += scnprintf(p, end - p, "%pV", &vaf);
 
 	va_end(args);
 
 	list_for_each_entry(info, pkt_list, list)
-		seq_printf(m, "%d ", info->id);
+		p += scnprintf(p, end - p, "%d ", info->id);
+
+	p += scnprintf(p, end - p, "\n");
 
-	seq_puts(m, "\n");
+	return p - buf;
 }
 
-static void rtw89_vif_link_ids_get(struct seq_file *m, u8 *mac,
-				   struct rtw89_dev *rtwdev,
-				   struct rtw89_vif_link *rtwvif_link)
+static int rtw89_vif_link_ids_get(struct rtw89_dev *rtwdev,
+				  char *buf, size_t bufsz, u8 *mac,
+				  struct rtw89_vif_link *rtwvif_link)
 {
 	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif_link->bssid_cam;
-
-	seq_printf(m, "    [%u] %pM\n", rtwvif_link->mac_id, rtwvif_link->mac_addr);
-	seq_printf(m, "\tlink_id=%u\n", rtwvif_link->link_id);
-	seq_printf(m, "\tbssid_cam_idx=%u\n", bssid_cam->bssid_cam_idx);
-	rtw89_dump_addr_cam(m, rtwdev, &rtwvif_link->addr_cam);
-	rtw89_dump_pkt_offload(m, &rtwvif_link->general_pkt_list,
-			       "\tpkt_ofld[GENERAL]: ");
+	char *p = buf, *end = buf + bufsz;
+
+	p += scnprintf(p, end - p, "    [%u] %pM\n", rtwvif_link->mac_id,
+		       rtwvif_link->mac_addr);
+	p += scnprintf(p, end - p, "\tlink_id=%u\n", rtwvif_link->link_id);
+	p += scnprintf(p, end - p, "\tbssid_cam_idx=%u\n",
+		       bssid_cam->bssid_cam_idx);
+	p += rtw89_dump_addr_cam(rtwdev, p, end - p, &rtwvif_link->addr_cam);
+	p += rtw89_dump_pkt_offload(p, end - p, &rtwvif_link->general_pkt_list,
+				    "\tpkt_ofld[GENERAL]: ");
+
+	return p - buf;
 }
 
 static
 void rtw89_vif_ids_get_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 {
-	struct seq_file *m = (struct seq_file *)data;
+	struct rtw89_debugfs_iter_data *iter_data =
+		(struct rtw89_debugfs_iter_data *)data;
 	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
 	struct rtw89_vif_link *rtwvif_link;
+	size_t bufsz = iter_data->bufsz;
+	char *buf = iter_data->buf;
+	char *p = buf, *end = buf + bufsz;
 	unsigned int link_id;
 
-	seq_printf(m, "VIF %pM\n", rtwvif->mac_addr);
+	p += scnprintf(p, end - p, "VIF %pM\n", rtwvif->mac_addr);
 	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
-		rtw89_vif_link_ids_get(m, mac, rtwdev, rtwvif_link);
+		p += rtw89_vif_link_ids_get(rtwdev, p, end - p, mac, rtwvif_link);
+
+	rtw89_debugfs_iter_data_next(iter_data, p, end - p, p - buf);
 }
 
-static void rtw89_dump_ba_cam(struct seq_file *m, struct rtw89_dev *rtwdev,
-			      struct rtw89_sta_link *rtwsta_link)
+static int rtw89_dump_ba_cam(struct rtw89_dev *rtwdev,
+			     char *buf, size_t bufsz,
+			     struct rtw89_sta_link *rtwsta_link)
 {
 	struct rtw89_ba_cam_entry *entry;
+	char *p = buf, *end = buf + bufsz;
 	bool first = true;
 
 	list_for_each_entry(entry, &rtwsta_link->ba_cam_list, list) {
 		if (first) {
-			seq_puts(m, "\tba_cam ");
+			p += scnprintf(p, end - p, "\tba_cam ");
 			first = false;
 		} else {
-			seq_puts(m, ", ");
+			p += scnprintf(p, end - p, ", ");
 		}
-		seq_printf(m, "tid[%u]=%d", entry->tid,
-			   (int)(entry - rtwdev->cam_info.ba_cam_entry));
+		p += scnprintf(p, end - p, "tid[%u]=%d", entry->tid,
+			       (int)(entry - rtwdev->cam_info.ba_cam_entry));
 	}
-	seq_puts(m, "\n");
+	p += scnprintf(p, end - p, "\n");
+
+	return p - buf;
 }
 
-static void rtw89_sta_link_ids_get(struct seq_file *m,
-				   struct rtw89_dev *rtwdev,
-				   struct rtw89_sta_link *rtwsta_link)
+static int rtw89_sta_link_ids_get(struct rtw89_dev *rtwdev,
+				  char *buf, size_t bufsz,
+				  struct rtw89_sta_link *rtwsta_link)
 {
 	struct ieee80211_link_sta *link_sta;
+	char *p = buf, *end = buf + bufsz;
 
 	rcu_read_lock();
 
 	link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
 
-	seq_printf(m, "    [%u] %pM\n", rtwsta_link->mac_id, link_sta->addr);
+	p += scnprintf(p, end - p, "    [%u] %pM\n", rtwsta_link->mac_id,
+		       link_sta->addr);
 
 	rcu_read_unlock();
 
-	seq_printf(m, "\tlink_id=%u\n", rtwsta_link->link_id);
-	rtw89_dump_addr_cam(m, rtwdev, &rtwsta_link->addr_cam);
-	rtw89_dump_ba_cam(m, rtwdev, rtwsta_link);
+	p += scnprintf(p, end - p, "\tlink_id=%u\n", rtwsta_link->link_id);
+	p += rtw89_dump_addr_cam(rtwdev, p, end - p, &rtwsta_link->addr_cam);
+	p += rtw89_dump_ba_cam(rtwdev, p, end - p, rtwsta_link);
+
+	return p - buf;
 }
 
 static void rtw89_sta_ids_get_iter(void *data, struct ieee80211_sta *sta)
 {
-	struct seq_file *m = (struct seq_file *)data;
+	struct rtw89_debugfs_iter_data *iter_data =
+		(struct rtw89_debugfs_iter_data *)data;
 	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
 	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
 	struct rtw89_sta_link *rtwsta_link;
+	size_t bufsz = iter_data->bufsz;
+	char *buf = iter_data->buf;
+	char *p = buf, *end = buf + bufsz;
 	unsigned int link_id;
 
-	seq_printf(m, "STA %pM %s\n", sta->addr, sta->tdls ? "(TDLS)" : "");
+	p += scnprintf(p, end - p, "STA %pM %s\n", sta->addr,
+		       sta->tdls ? "(TDLS)" : "");
 	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id)
-		rtw89_sta_link_ids_get(m, rtwdev, rtwsta_link);
+		p += rtw89_sta_link_ids_get(rtwdev, p, end - p, rtwsta_link);
+
+	rtw89_debugfs_iter_data_next(iter_data, p, end - p, p - buf);
 }
 
-static int rtw89_debug_priv_stations_get(struct seq_file *m, void *v)
+static ssize_t rtw89_debug_priv_stations_get(struct rtw89_dev *rtwdev,
+					     struct rtw89_debugfs_priv *debugfs_priv,
+					     char *buf, size_t bufsz)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
+	struct rtw89_debugfs_iter_data iter_data;
+	char *p = buf, *end = buf + bufsz;
 	u8 idx;
 
 	mutex_lock(&rtwdev->mutex);
 
-	seq_puts(m, "map:\n");
-	seq_printf(m, "\tmac_id:    %*ph\n", (int)sizeof(rtwdev->mac_id_map),
-		   rtwdev->mac_id_map);
-	seq_printf(m, "\taddr_cam:  %*ph\n", (int)sizeof(cam_info->addr_cam_map),
-		   cam_info->addr_cam_map);
-	seq_printf(m, "\tbssid_cam: %*ph\n", (int)sizeof(cam_info->bssid_cam_map),
-		   cam_info->bssid_cam_map);
-	seq_printf(m, "\tsec_cam:   %*ph\n", (int)sizeof(cam_info->sec_cam_map),
-		   cam_info->sec_cam_map);
-	seq_printf(m, "\tba_cam:    %*ph\n", (int)sizeof(cam_info->ba_cam_map),
-		   cam_info->ba_cam_map);
-	seq_printf(m, "\tpkt_ofld:  %*ph\n", (int)sizeof(rtwdev->pkt_offload),
-		   rtwdev->pkt_offload);
+	p += scnprintf(p, end - p, "map:\n");
+	p += scnprintf(p, end - p, "\tmac_id:    %*ph\n",
+		       (int)sizeof(rtwdev->mac_id_map),
+		       rtwdev->mac_id_map);
+	p += scnprintf(p, end - p, "\taddr_cam:  %*ph\n",
+		       (int)sizeof(cam_info->addr_cam_map),
+		       cam_info->addr_cam_map);
+	p += scnprintf(p, end - p, "\tbssid_cam: %*ph\n",
+		       (int)sizeof(cam_info->bssid_cam_map),
+		       cam_info->bssid_cam_map);
+	p += scnprintf(p, end - p, "\tsec_cam:   %*ph\n",
+		       (int)sizeof(cam_info->sec_cam_map),
+		       cam_info->sec_cam_map);
+	p += scnprintf(p, end - p, "\tba_cam:    %*ph\n",
+		       (int)sizeof(cam_info->ba_cam_map),
+		       cam_info->ba_cam_map);
+	p += scnprintf(p, end - p, "\tpkt_ofld:  %*ph\n",
+		       (int)sizeof(rtwdev->pkt_offload),
+		       rtwdev->pkt_offload);
 
 	for (idx = NL80211_BAND_2GHZ; idx < NUM_NL80211_BANDS; idx++) {
 		if (!(rtwdev->chip->support_bands & BIT(idx)))
 			continue;
-		rtw89_dump_pkt_offload(m, &rtwdev->scan_info.pkt_list[idx],
-				       "\t\t[SCAN %u]: ", idx);
+		p += rtw89_dump_pkt_offload(p, end - p, &rtwdev->scan_info.pkt_list[idx],
+					    "\t\t[SCAN %u]: ", idx);
 	}
 
+	rtw89_debugfs_iter_data_setup(&iter_data, p, end - p);
 	ieee80211_iterate_active_interfaces_atomic(rtwdev->hw,
-		IEEE80211_IFACE_ITER_NORMAL, rtw89_vif_ids_get_iter, m);
+		IEEE80211_IFACE_ITER_NORMAL, rtw89_vif_ids_get_iter, &iter_data);
+	p += iter_data.written_sz;
 
-	ieee80211_iterate_stations_atomic(rtwdev->hw, rtw89_sta_ids_get_iter, m);
+	rtw89_debugfs_iter_data_setup(&iter_data, p, end - p);
+	ieee80211_iterate_stations_atomic(rtwdev->hw, rtw89_sta_ids_get_iter, &iter_data);
+	p += iter_data.written_sz;
 
 	mutex_unlock(&rtwdev->mutex);
 
-	return 0;
+	return p - buf;
 }
 
 #define DM_INFO(type) {RTW89_DM_ ## type, #type}
@@ -3901,41 +4113,42 @@ static const struct rtw89_disabled_dm_info {
 	DM_INFO(THERMAL_PROTECT),
 };
 
-static int
-rtw89_debug_priv_disable_dm_get(struct seq_file *m, void *v)
+static ssize_t
+rtw89_debug_priv_disable_dm_get(struct rtw89_dev *rtwdev,
+				struct rtw89_debugfs_priv *debugfs_priv,
+				char *buf, size_t bufsz)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	const struct rtw89_disabled_dm_info *info;
 	struct rtw89_hal *hal = &rtwdev->hal;
+	char *p = buf, *end = buf + bufsz;
 	u32 disabled;
 	int i;
 
-	seq_printf(m, "Disabled DM: 0x%x\n", hal->disabled_dm_bitmap);
+	p += scnprintf(p, end - p, "Disabled DM: 0x%x\n",
+		       hal->disabled_dm_bitmap);
 
 	for (i = 0; i < ARRAY_SIZE(rtw89_disabled_dm_infos); i++) {
 		info = &rtw89_disabled_dm_infos[i];
 		disabled = BIT(info->type) & hal->disabled_dm_bitmap;
 
-		seq_printf(m, "[%d] %s: %c\n", info->type, info->name,
-			   disabled ? 'X' : 'O');
+		p += scnprintf(p, end - p, "[%d] %s: %c\n", info->type,
+			       info->name,
+			       disabled ? 'X' : 'O');
 	}
 
-	return 0;
+	return p - buf;
 }
 
 static ssize_t
-rtw89_debug_priv_disable_dm_set(struct file *filp, const char __user *user_buf,
-				size_t count, loff_t *loff)
+rtw89_debug_priv_disable_dm_set(struct rtw89_dev *rtwdev,
+				struct rtw89_debugfs_priv *debugfs_priv,
+				const char *buf, size_t count)
 {
-	struct seq_file *m = (struct seq_file *)filp->private_data;
-	struct rtw89_debugfs_priv *debugfs_priv = m->private;
-	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u32 conf;
 	int ret;
 
-	ret = kstrtou32_from_user(user_buf, count, 0, &conf);
+	ret = kstrtou32(buf, 0, &conf);
 	if (ret)
 		return -EINVAL;
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 2f8694fe4bd1..fc8a93573144 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2070,24 +2070,28 @@ s16 rtw89_phy_ant_gain_pwr_offset(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_phy_ant_gain_pwr_offset);
 
-void rtw89_print_ant_gain(struct seq_file *m, struct rtw89_dev *rtwdev,
-			  const struct rtw89_chan *chan)
+int rtw89_print_ant_gain(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
+			 const struct rtw89_chan *chan)
 {
 	struct rtw89_ant_gain_info *ant_gain = &rtwdev->ant_gain;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u8 regd = rtw89_regd_get(rtwdev, chan->band_type);
+	char *p = buf, *end = buf + bufsz;
 	s8 offset_patha, offset_pathb;
 
 	if (!chip->support_ant_gain || !(ant_gain->regd_enabled & BIT(regd))) {
-		seq_puts(m, "no DAG is applied\n");
-		return;
+		p += scnprintf(p, end - p, "no DAG is applied\n");
+		goto out;
 	}
 
 	offset_patha = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_A, chan->freq);
 	offset_pathb = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_B, chan->freq);
 
-	seq_printf(m, "ChainA offset: %d dBm\n", offset_patha);
-	seq_printf(m, "ChainB offset: %d dBm\n", offset_pathb);
+	p += scnprintf(p, end - p, "ChainA offset: %d dBm\n", offset_patha);
+	p += scnprintf(p, end - p, "ChainB offset: %d dBm\n", offset_pathb);
+
+out:
+	return p - buf;
 }
 
 static const u8 rtw89_rs_idx_num_ax[] = {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index cec165e222e7..e20fff9bac3e 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -835,8 +835,8 @@ s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev, u8 band, u8 bw,
 void rtw89_phy_ant_gain_init(struct rtw89_dev *rtwdev);
 s16 rtw89_phy_ant_gain_pwr_offset(struct rtw89_dev *rtwdev,
 				  const struct rtw89_chan *chan);
-void rtw89_print_ant_gain(struct seq_file *m, struct rtw89_dev *rtwdev,
-			  const struct rtw89_chan *chan);
+int rtw89_print_ant_gain(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
+			 const struct rtw89_chan *chan);
 void rtw89_phy_load_txpwr_byrate(struct rtw89_dev *rtwdev,
 				 const struct rtw89_txpwr_table *tbl);
 s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 94db695e78e6..1f67a2fbce81 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -178,12 +178,14 @@ s8 rtw89_query_sar(struct rtw89_dev *rtwdev, u32 center_freq)
 	return rtw89_txpwr_sar_to_mac(rtwdev, fct, cfg);
 }
 
-void rtw89_print_sar(struct seq_file *m, struct rtw89_dev *rtwdev, u32 center_freq)
+int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
+		    u32 center_freq)
 {
 	const enum rtw89_sar_sources src = rtwdev->sar.src;
 	/* its members are protected by rtw89_sar_set_src() */
 	const struct rtw89_sar_handler *sar_hdl = &rtw89_sar_handlers[src];
 	const u8 fct_mac = rtwdev->chip->txpwr_factor_mac;
+	char *p = buf, *end = buf + bufsz;
 	int ret;
 	s32 cfg;
 	u8 fct;
@@ -191,36 +193,46 @@ void rtw89_print_sar(struct seq_file *m, struct rtw89_dev *rtwdev, u32 center_fr
 	lockdep_assert_held(&rtwdev->mutex);
 
 	if (src == RTW89_SAR_SOURCE_NONE) {
-		seq_puts(m, "no SAR is applied\n");
-		return;
+		p += scnprintf(p, end - p, "no SAR is applied\n");
+		goto out;
 	}
 
-	seq_printf(m, "source: %d (%s)\n", src, sar_hdl->descr_sar_source);
+	p += scnprintf(p, end - p, "source: %d (%s)\n", src,
+		       sar_hdl->descr_sar_source);
 
 	ret = sar_hdl->query_sar_config(rtwdev, center_freq, &cfg);
 	if (ret) {
-		seq_printf(m, "config: return code: %d\n", ret);
-		seq_printf(m, "assign: max setting: %d (unit: 1/%lu dBm)\n",
-			   RTW89_SAR_TXPWR_MAC_MAX, BIT(fct_mac));
-		return;
+		p += scnprintf(p, end - p, "config: return code: %d\n", ret);
+		p += scnprintf(p, end - p,
+			       "assign: max setting: %d (unit: 1/%lu dBm)\n",
+			       RTW89_SAR_TXPWR_MAC_MAX, BIT(fct_mac));
+		goto out;
 	}
 
 	fct = sar_hdl->txpwr_factor_sar;
 
-	seq_printf(m, "config: %d (unit: 1/%lu dBm)\n", cfg, BIT(fct));
+	p += scnprintf(p, end - p, "config: %d (unit: 1/%lu dBm)\n", cfg,
+		       BIT(fct));
+
+out:
+	return p - buf;
 }
 
-void rtw89_print_tas(struct seq_file *m, struct rtw89_dev *rtwdev)
+int rtw89_print_tas(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_tas_info *tas = &rtwdev->tas;
+	char *p = buf, *end = buf + bufsz;
 
 	if (!tas->enable) {
-		seq_puts(m, "no TAS is applied\n");
-		return;
+		p += scnprintf(p, end - p, "no TAS is applied\n");
+		goto out;
 	}
 
-	seq_printf(m, "DPR gap: %d\n", tas->dpr_gap);
-	seq_printf(m, "TAS delta: %d\n", tas->delta);
+	p += scnprintf(p, end - p, "DPR gap: %d\n", tas->dpr_gap);
+	p += scnprintf(p, end - p, "TAS delta: %d\n", tas->delta);
+
+out:
+	return p - buf;
 }
 
 static int rtw89_apply_sar_common(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/sar.h b/drivers/net/wireless/realtek/rtw89/sar.h
index 4ae081d2d3b4..095277df5a71 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.h
+++ b/drivers/net/wireless/realtek/rtw89/sar.h
@@ -19,8 +19,9 @@ struct rtw89_sar_handler {
 extern const struct cfg80211_sar_capa rtw89_sar_capa;
 
 s8 rtw89_query_sar(struct rtw89_dev *rtwdev, u32 center_freq);
-void rtw89_print_sar(struct seq_file *m, struct rtw89_dev *rtwdev, u32 center_freq);
-void rtw89_print_tas(struct seq_file *m, struct rtw89_dev *rtwdev);
+int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
+		    u32 center_freq);
+int rtw89_print_tas(struct rtw89_dev *rtwdev, char *buf, size_t bufsz);
 int rtw89_ops_set_sar_specs(struct ieee80211_hw *hw,
 			    const struct cfg80211_sar_specs *sar);
 void rtw89_tas_init(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/util.c b/drivers/net/wireless/realtek/rtw89/util.c
index e71956ce9853..33be26873473 100644
--- a/drivers/net/wireless/realtek/rtw89/util.c
+++ b/drivers/net/wireless/realtek/rtw89/util.c
@@ -104,3 +104,14 @@ u64 rtw89_db_2_linear(u32 db)
 	return linear;
 }
 EXPORT_SYMBOL(rtw89_db_2_linear);
+
+void rtw89_might_trailing_ellipsis(char *buf, size_t size, ssize_t used)
+{
+	static const char ellipsis[] = "...";
+
+	/* length of null terminiator isn't included in 'used' */
+	if (used + 1 < size || size < sizeof(ellipsis))
+		return;
+
+	memcpy(buf + size - sizeof(ellipsis), ellipsis, sizeof(ellipsis));
+}
diff --git a/drivers/net/wireless/realtek/rtw89/util.h b/drivers/net/wireless/realtek/rtw89/util.h
index e669544cafd3..71c7d3502202 100644
--- a/drivers/net/wireless/realtek/rtw89/util.h
+++ b/drivers/net/wireless/realtek/rtw89/util.h
@@ -77,5 +77,6 @@ static inline void ether_addr_copy_mask(u8 *dst, const u8 *src, u8 mask)
 
 u32 rtw89_linear_2_db(u64 linear);
 u64 rtw89_db_2_linear(u32 db);
+void rtw89_might_trailing_ellipsis(char *buf, size_t size, ssize_t used);
 
 #endif
-- 
2.25.1


