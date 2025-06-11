Return-Path: <linux-wireless+bounces-23954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A90AD47FB
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3291897396
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 01:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB2518EFD1;
	Wed, 11 Jun 2025 01:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SsuIigjb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF84158538
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605777; cv=none; b=Wwb0IFhQ0/4jHRs0DGXbtNZqozqBB2N8y7bZSRoKfDqkkjvPOEslhoP1NQHNRlCI+Z7vJuHi0a3TuodrE6HIJKM0Tm7Jn1roQqNT3hi46F7xBOfAMLrg2u/A2LKeWwvZ0IlOfDn9mf6pJwtCbGZswD91nOtCx9HO2llg5GmIRw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605777; c=relaxed/simple;
	bh=l4kh8nQOBB+k1hS7ml/rMHZHvU1JaywbqUf42DJXo5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sE91ZiDDmD8bBfkmgxn/G4Hh8bHzZHco8k7UyAYmEKmdzoPsD/O05iTvQDbUa48/z8036GvVOi/HIoCAAOoVB/Q6Bjd+vLpQuIEme5cowEKw4upP5QJkMW643CHKju7IFm4kGoYJQMl5zezFC0OKk0vErQiH9Or7IanapFbvz2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SsuIigjb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B1aEi753938219, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749605774; bh=eDaFdtU5KYOhx/epRAHSLPZer/Vjcfl9F3w2FCkM/Ws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=SsuIigjbmHwE7rtVCOl6s20de9HqE49gKrV6aKg3r3sSYaqivsEFEmCZhS4BD+Yur
	 Lh/PGcgykSt8OLwaYnGmbd/2Ilef5+1GjLJn15SXfgEFnsj3EqOfrmB//eyQ1j1Qxj
	 EVIz/FNx7gYkksnTK0uzenBggl090TOpxZs3l32+p9Wo3lOU/vh+tfNXauMjSxZXpm
	 qGUJ4bUwAp51Nzui31O1MO6HtnhCt141pz7jxNPjBH1waGa/Itm1xKgpSCikhPys+0
	 r8aNlkRJVwZGmin7lpxk1geunYZWcMrPPaXVSJlFqrFmOmL5g107X7cqhFSS4Cf5vn
	 i8lnS3wpYO+Dw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B1aEi753938219
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 09:36:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 09:36:13 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 11 Jun
 2025 09:36:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 09/10] wifi: rtw89: coex: Update hardware PTA resource binding logic
Date: Wed, 11 Jun 2025 09:35:09 +0800
Message-ID: <20250611013510.15519-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611013510.15519-1-pkshih@realtek.com>
References: <20250611013510.15519-1-pkshih@realtek.com>
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

WiFi 7 generation has 2 MAC, the PTA should bind the input/output to
correct MAC to do the packet arbitration as expected.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 41 ++++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/reg.h  |  1 +
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index bd258acc83d8..77df765dc607 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -5360,15 +5360,47 @@ static void _set_bt_rx_scan_pri(struct rtw89_dev *rtwdev)
 	_write_scbd(rtwdev, BTC_WSCB_RXSCAN_PRI, (bool)(!!bt->scan_rx_low_pri));
 }
 
+static void _wl_req_mac(struct rtw89_dev *rtwdev, u8 mac)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	u32 add;
+
+	if (mac == wl->pta_req_mac)
+		return;
+
+	dm->ost_info.pta_req_hw_band = mac;
+	wl->pta_req_mac = mac;
+	wl->pta_reg_mac_chg = true;
+
+	if (btc->ver->fcxosi)
+		return;
+
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE)
+		add = R_BE_BTC_CFG;
+	else
+		add = R_AX_BTC_CFG;
+
+	if (mac == RTW89_MAC_0)
+		rtw89_write32_clr(rtwdev, add, B_AX_WL_SRC);
+	else
+		rtw89_write32_set(rtwdev, add, B_AX_WL_SRC);
+}
+
 static void _action_common(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_wl_role_info_v8 *rinfo_v8 = &wl->role_info_v8;
 	struct rtw89_btc_wl_smap *wl_smap = &wl->status.map;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	u32 bt_rom_code_id, bt_fw_ver;
 
+	if (btc->ver->fwlrole == 8)
+		_wl_req_mac(rtwdev, rinfo_v8->pta_req_band);
+
 	_set_btg_ctrl(rtwdev);
 	_set_wl_preagc_ctrl(rtwdev);
 	_set_wl_tx_limit(rtwdev);
@@ -5405,6 +5437,7 @@ static void _action_common(struct rtw89_dev *rtwdev)
 		btc->cx.cnt_wl[BTC_WCNT_SCBDUPDATE]++;
 	}
 	btc->dm.tdma_instant_excute = 0;
+	wl->pta_reg_mac_chg = false;
 }
 
 static void _action_by_bt(struct rtw89_dev *rtwdev)
@@ -5867,14 +5900,6 @@ _update_rssi_state(struct rtw89_dev *rtwdev, u8 pre_state, u8 rssi, u8 thresh)
 	return next_state;
 }
 
-static void _wl_req_mac(struct rtw89_dev *rtwdev, u8 mac)
-{
-	if (mac == RTW89_MAC_0)
-		rtw89_write32_clr(rtwdev, R_AX_BTC_CFG, B_AX_WL_SRC);
-	else
-		rtw89_write32_set(rtwdev, R_AX_BTC_CFG, B_AX_WL_SRC);
-}
-
 static
 void _update_dbcc_band(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 255a8635b195..4a65b0c9c2d1 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -6070,6 +6070,7 @@
 #define B_BE_MACID_ACQ_GRP0_CLR_P BIT(2)
 #define B_BE_R_MACID_ACQ_CHK_EN BIT(0)
 
+#define R_BE_BTC_CFG 0x0E300
 #define R_BE_BT_BREAK_TABLE 0x0E344
 
 #define R_BE_GNT_SW_CTRL 0x0E348
-- 
2.25.1


