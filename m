Return-Path: <linux-wireless+bounces-24129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AB7ADAB67
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 11:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C9D1881E34
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 09:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6780F1DDC0F;
	Mon, 16 Jun 2025 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FKVbi+vQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68931F0E32
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064627; cv=none; b=k2tdcN0Mlw+yLLdAJybo/gaZGREuz8WLiMSvQ2vlup/lyW+U5lUrX5DK0D8jJ7BqGwSZTR5cFn2BL1Kevfq9CdpnD5dS5tN5Sruyir54lQPFfRIOeoTonKBf2hRw09QiHoZa43VjyX16JRR17Os3yAiOYE6zEoVgj6M9dsJYpGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064627; c=relaxed/simple;
	bh=WLaHjTFa845Gd++Q7pA4OysjSithyYUXpdapc8wkKTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYzC9Twv18IMMsbn6Cjap7/6EPbIgWzmj5hdAOFm9tIENegaIcPlv1+RGaYHuTfXG8u8yeJBsJw7KapoSXFaHydd+TEXz2NF5K3bFHRHL6V2QkdiF93v7oiUF7PUPnIsvtvRBQBS86K04CkSZAkRn0O+BDEP5deKBdlKVXjIgOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FKVbi+vQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G93eDtA175659, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750064620; bh=ZiJAD3C2O3Xt8ZJV9ioWVDz6Xud9i5skjElhsO7LwDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=FKVbi+vQVQtJTLWWhcaCCgJK0l/XLVy5ZA3i8HvbIOJIA/NvJbzL1MmxYuhfZuMwa
	 Q+j7VTusJoC/5P64/ZDI1a2I3eCUVz42kspYWs5g9RCjSL+S9q2EWR0IvN4+08uaDW
	 nl463P5RTdm7I2uJwLToO55sZJvX77VZJTb6p3YQ1EEsNcL+I86EKqyVe193VjypRg
	 AUMarRxmbLQbw7DMLAEwoTC9Gsumfp+bxX1qIy+BA5ij5polPHcbYoZnkl1eN0g6ev
	 +mt2RvhbZMGUtbBz42yUCYUVjXYcV6x3B7Ui4jHuRIOvexNnIsl3SPQXW9iREEMtED
	 txddogpyQXhMw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G93eDtA175659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 17:03:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 17:03:20 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 17:03:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 01/11] wifi: rtw89: coex: Add v1 Bluetooth AFH handshake for WiFi 7
Date: Mon, 16 Jun 2025 17:02:42 +0800
Message-ID: <20250616090252.51098-2-pkshih@realtek.com>
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

WiFi 7 generation has dual MAC, Coexistence need to find out the
2GHz WiFi connection in the connected links. And assign its channel
to Bluetooth to make Bluetooth not to hop into WiFi channel.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 111 +++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 934407dc53ea..d95ddc928e3d 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -3186,7 +3186,7 @@ static void _update_btc_state_map(struct rtw89_dev *rtwdev)
 	}
 }
 
-static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
+static void _set_bt_afh_info_v0(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -3355,6 +3355,115 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 	btc->cx.cnt_wl[BTC_WCNT_CH_UPDATE]++;
 }
 
+static void _set_bt_afh_info_v1(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
+	struct rtw89_btc_wl_afh_info *wl_afh = &wl->afh_info;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_wl_rlink *rlink;
+	u8 en = 0, ch = 0, bw = 0, buf[3] = {};
+	u8 i, j, link_mode;
+
+	if (btc->manual_ctrl || wl->status.map.scan)
+		return;
+
+	link_mode = wl_rinfo->link_mode;
+
+	for (i = 0; i < btc->ver->max_role_num; i++) {
+		for (j = RTW89_MAC_0; j < RTW89_MAC_NUM; j++) {
+			if (wl->status.map.rf_off || bt->whql_test ||
+			    link_mode == BTC_WLINK_NOLINK ||
+			    link_mode == BTC_WLINK_5G)
+				break;
+
+			rlink = &wl_rinfo->rlink[i][j];
+
+			/* Don't care no-connected/non-2G-band role */
+			if (!rlink->connected || !rlink->active ||
+			    rlink->rf_band != RTW89_BAND_2G)
+				continue;
+
+			en = 1;
+			ch = rlink->ch;
+			bw = rlink->bw;
+
+			if (link_mode == BTC_WLINK_2G_MCC &&
+			    (rlink->role == RTW89_WIFI_ROLE_AP ||
+			     rlink->role == RTW89_WIFI_ROLE_P2P_GO ||
+			     rlink->role == RTW89_WIFI_ROLE_P2P_CLIENT)) {
+				/* for 2.4G MCC, take role = ap/go/gc */
+				break;
+			} else if (link_mode != BTC_WLINK_2G_SCC ||
+				   rlink->bw == RTW89_CHANNEL_WIDTH_40) {
+				/* for 2.4G scc, take bw = 40M */
+				break;
+			}
+		}
+	}
+
+	/* default AFH channel sapn = center-ch +- 6MHz */
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_20:
+		if (btc->dm.freerun || btc->dm.fddt_train)
+			bw = 48;
+		else
+			bw = 20 + chip->afh_guard_ch * 2;
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		if (btc->dm.freerun)
+			bw = 40 + chip->afh_guard_ch * 2;
+		else
+			bw = 40;
+		break;
+	case RTW89_CHANNEL_WIDTH_5:
+		bw = 5 + chip->afh_guard_ch * 2;
+		break;
+	case RTW89_CHANNEL_WIDTH_10:
+		bw = 10 + chip->afh_guard_ch * 2;
+		break;
+	default:
+		en = false; /* turn off AFH info if invalid BW */
+		bw = 0;
+		ch = 0;
+		break;
+	}
+
+	if (!en || ch > 14 || ch == 0) {
+		en = false;
+		bw = 0;
+		ch = 0;
+	}
+
+	if (wl_afh->en == en &&
+	    wl_afh->ch == ch &&
+	    wl_afh->bw == bw &&
+	    (!bt->enable.now || bt->enable.last))
+		return;
+
+	wl_afh->en = buf[0];
+	wl_afh->ch = buf[1];
+	wl_afh->bw = buf[2];
+
+	if (_send_fw_cmd(rtwdev, BTFC_SET, SET_BT_WL_CH_INFO, &wl->afh_info, 3)) {
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], %s(): en=%d, ch=%d, bw=%d\n",
+			    __func__, en, ch, bw);
+
+		btc->cx.cnt_wl[BTC_WCNT_CH_UPDATE]++;
+	}
+}
+
+static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
+{
+	if (rtwdev->chip->chip_id == RTL8922A)
+		_set_bt_afh_info_v1(rtwdev);
+	else
+		_set_bt_afh_info_v0(rtwdev);
+}
+
 static bool _check_freerun(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-- 
2.25.1


