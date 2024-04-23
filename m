Return-Path: <linux-wireless+bounces-6731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0878AE763
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 15:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C6E9B25CD0
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 13:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57C5134CC2;
	Tue, 23 Apr 2024 13:06:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8F2134735
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877570; cv=none; b=W6hBDh5bBPymjjcLa3URrD2o/YZS+qeGEUqko4q6+4pqA5Vtj5i/fh5sWMFLbydoELRNpZWw0PSqhS8kVwZsUaGxwDrqgBYoM4ZLblK15zVPs82UPDOBf53s3bbi+MNUI54phbBxBU8Zgk1wIkvB6iSoqKCqSdbYQtV55QXwEl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877570; c=relaxed/simple;
	bh=2UypUZ2hSh3OoBmVK9OhcTYOi5AxrTpXVUnJmmNHU34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsnIshdCUdH79RYV4HZbpEPlahdSK0rPpCgVaFARMnxKyvk5pcw7oQjLvOYg71Cry3TanWYOovM2mxSPExCxKe59MOdKRUYEHOTIYN8krIMv+VdZnIfYp8ABiWUcoqCIkvxvKzy5XX+MyQcYRBEYwF+Rd5ngO62hgGkJ06yJn7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43ND64Cd81251254, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43ND64Cd81251254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 21:06:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 21:06:04 +0800
Received: from [127.0.1.1] (172.16.20.182) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 23 Apr
 2024 21:06:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 8/8] wifi: rtw89: coex: Check and enable reports after run coex
Date: Tue, 23 Apr 2024 21:05:02 +0800
Message-ID: <20240423130502.32682-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423130502.32682-1-pkshih@realtek.com>
References: <20240423130502.32682-1-pkshih@realtek.com>
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

If there is any changes with Wi-Fi/Bluetooth, the mechanism will
trigger run_coex to update information and coexistence mechanism.
Enable/Disable reports here can make sure the action take effect
in time.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 46 ++++++++++++++++++++---
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 0942a182976a..c443b39ab3c6 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -222,6 +222,22 @@ static const union rtw89_btc_wl_state_map btc_scanning_map = {
 	},
 };
 
+static u32 chip_id_to_bt_rom_code_id(u32 id)
+{
+	switch (id) {
+	case RTL8852A:
+	case RTL8852B:
+	case RTL8852C:
+		return 0x8852;
+	case RTL8851B:
+		return 0x8851;
+	case RTL8922A:
+		return 0x8922;
+	default:
+		return 0;
+	}
+}
+
 struct rtw89_btc_btf_tlv {
 	u8 type;
 	u8 len;
@@ -5035,11 +5051,14 @@ static void _set_bt_rx_scan_pri(struct rtw89_dev *rtwdev)
 	_write_scbd(rtwdev, BTC_WSCB_RXSCAN_PRI, (bool)(!!bt->scan_rx_low_pri));
 }
 
-/* TODO add these functions */
 static void _action_common(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_wl_smap *wl_smap = &wl->status.map;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	u32 bt_rom_code_id, bt_fw_ver;
 
 	_set_btg_ctrl(rtwdev);
 	_set_wl_preagc_ctrl(rtwdev);
@@ -5049,6 +5068,26 @@ static void _action_common(struct rtw89_dev *rtwdev)
 	_set_rf_trx_para(rtwdev);
 	_set_bt_rx_scan_pri(rtwdev);
 
+	bt_rom_code_id = chip_id_to_bt_rom_code_id(rtwdev->btc.ver->chip_id);
+	bt_fw_ver = bt->ver_info.fw & 0xffff;
+	if (bt->enable.now &&
+	    (bt_fw_ver == 0 ||
+	     (bt_fw_ver == bt_rom_code_id && bt->run_patch_code && rtwdev->chip->scbd)))
+		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_VER_INFO, 1);
+	else
+		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_VER_INFO, 0);
+
+	if (dm->run_reason == BTC_RSN_NTFY_INIT ||
+	    dm->run_reason == BTC_RSN_NTFY_RADIO_STATE ||
+	    dm->run_reason == BTC_RSN_NTFY_POWEROFF) {
+		_fw_set_drv_info(rtwdev, CXDRVINFO_ROLE);
+
+		if (wl_smap->rf_off == 1 || wl_smap->lps != BTC_LPS_OFF)
+			rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_ALL, 0);
+		else
+			rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_MREG, 1);
+	}
+
 	if (wl->scbd_change) {
 		rtw89_mac_cfg_sb(rtwdev, wl->scbd);
 		rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], write scbd: 0x%08x\n",
@@ -8020,11 +8059,6 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		seq_puts(m, "\n");
 	}
 
-	if (bt->enable.now && bt->ver_info.fw == 0)
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_VER_INFO, true);
-	else
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_VER_INFO, false);
-
 	if (bt_linfo->profile_cnt.now || bt_linfo->status.map.ble_connect)
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_AFH_MAP, true);
 	else
-- 
2.25.1


