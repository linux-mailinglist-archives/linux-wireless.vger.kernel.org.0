Return-Path: <linux-wireless+bounces-17272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5450A08513
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 02:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4636D188B102
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 01:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6EE13F43A;
	Fri, 10 Jan 2025 01:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="O7bvx99l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8EB158DC4
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736474083; cv=none; b=Iz6W1mxyD7YAp3WWuIRQMEXKpUOatfxPZG9ROmomXNjo5hdtl+cscuSZKQLxg1ywyiYHXl8T/as+RGgOK9y34AzGU7YnmrXq8f6zOQ7bOvDu7O6hpUo9jOed+vO6Xgq1sD11axIFoiHxa0ZTKP8HDy3Hu8zKWRKBA6okqSbOOb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736474083; c=relaxed/simple;
	bh=yJy/LQ7qBleSPrKkqgUOisY+sHrv78QTQ3xFHDoxWBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHNAY5NQ/ssJ6Q1R+hABu5nK1lqe1RcKh+YoGEPNO5Gjrfg0zotKJBQqBgqE5Ym8Ftw0Dgl4IzrvEUfnZAmoPfMQqNSzKJIZvmyasRKwlFPl6/h3fDUdq9zo0uqA5g7Ycmdklk2SKPmlG9nCIXoWqlGMal7cpmR8NuxmmqjXRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=O7bvx99l; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50A1sc8lB3982812, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736474078; bh=yJy/LQ7qBleSPrKkqgUOisY+sHrv78QTQ3xFHDoxWBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=O7bvx99lDrdage/0SaXbGuSxCwjq7oxhbVYSXHIAHBaLYUD+65MgrtiGOYS56uysv
	 nHheMBMl9xHcHsyQ5XuuEmrEfdNM5gNWa808fyYwL3Yf0sWotNDB5LGBIpPlg5NAFk
	 chSkhgiZrhAzb3KmndqCnvqGEQbLS+1bw/yjm+pAIoLkEnphwZMdnMyFP1XQzY5buQ
	 dLmJWZPuv9dnYb2/B7sYV+Zz+OdqVGEQdRP0W8aT27Ca/Xb5XRdXOX2JllkcghK+hM
	 d4MMBMHqYGEdoaIByTxG/Ct6l6KwOiqYsyckQItMSq0at50Hs8GDbFXlqpwSF9eY85
	 OIr5X+JpuqGTA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50A1sc8lB3982812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 09:54:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 10 Jan 2025 09:54:38 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 10 Jan
 2025 09:54:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 2/3] wifi: rtw89: coex: Separated Wi-Fi connecting event from Wi-Fi scan event
Date: Fri, 10 Jan 2025 09:54:15 +0800
Message-ID: <20250110015416.10704-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110015416.10704-1-pkshih@realtek.com>
References: <20250110015416.10704-1-pkshih@realtek.com>
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

Wi-Fi connecting process don't need to assign to firmware slot control,
if assign firmware slot control for Wi-Fi connecting event, firmware will
not toggle slots because driver don't tell the slot schedule to firmware.
Wi-Fi connecting event end should also cancel the 4way handshake status.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index d5b8091e7541..cde65ee43bac 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -5399,7 +5399,8 @@ static void _action_wl_scan(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
 
-	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw)) {
+	if (btc->cx.state_map != BTC_WLINKING &&
+	    RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw)) {
 		_action_wl_25g_mcc(rtwdev);
 		rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], Scan offload!\n");
 	} else if (rtwdev->dbcc_en) {
@@ -7214,6 +7215,8 @@ void rtw89_btc_ntfy_scan_finish(struct rtw89_dev *rtwdev, u8 phy_idx)
 		_fw_set_drv_info(rtwdev, CXDRVINFO_DBCC);
 	}
 
+	btc->dm.tdma_instant_excute = 1;
+
 	_run_coex(rtwdev, BTC_RSN_NTFY_SCAN_FINISH);
 }
 
@@ -7662,7 +7665,8 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 	else
 		wl->status.map.connecting = 0;
 
-	if (state == BTC_ROLE_MSTS_STA_DIS_CONN)
+	if (state == BTC_ROLE_MSTS_STA_DIS_CONN ||
+	    state == BTC_ROLE_MSTS_STA_CONN_END)
 		wl->status.map._4way = false;
 
 	_run_coex(rtwdev, BTC_RSN_NTFY_ROLE_INFO);
-- 
2.25.1


