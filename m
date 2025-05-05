Return-Path: <linux-wireless+bounces-22548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E4CAAA7D6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC001885776
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BDC341BCB;
	Mon,  5 May 2025 22:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpXoRm95"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FAC341BC7;
	Mon,  5 May 2025 22:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484689; cv=none; b=NPMRp3tExIH1zubpksqDM+BB967SL415T7UWWnuNzkbwu5UHdenOLMc9VSqs4IxylTXLdqCLGANIqmcQ5lbwiXcXOHRjD3Y/pBqB/HeEU4Nq+EfJvFTSp0qrSf3ngzWDYBmPrfBoyIc5GeOJ4S9FsMeHEZqjSgJ3Oa9F2o7MakM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484689; c=relaxed/simple;
	bh=hlIGf+2rdPCTu+3jo+ddcne+4qkLwkFJbokjq/9pN4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iq5XwwHMxtIcOaBdhKIvtK98Dz++uNbubsrLhMVoW7O+azd/MV6RsKWigqWwd40yM7rKVLHnu6/02CF9W5ya9Nn16avsNrIhz+O3z3zldA4GORsopiayoWrSGfAVX9VsqCE2QCjrXoVxSxSglMB4InYUReA9iV8Lc0uVxPFc+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpXoRm95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EA6C4CEF1;
	Mon,  5 May 2025 22:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484689;
	bh=hlIGf+2rdPCTu+3jo+ddcne+4qkLwkFJbokjq/9pN4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TpXoRm954cH+dle9yjKli0F++nA5PWkELH2GQzs/wZQs6cLnE3RuzYyZzMqZFp6ro
	 eHUs+aiFDONuu01BKD/u4W6dE8nVTRXNnuSDAqCHEC4dqZ0IxeECrFnFxv2uSlok38
	 /xkB5WT4cm18t3sxPjpbggyH7w8ZxzLBcXGg+foJSimNKz875GnviEI5cvZrBGqiMl
	 re/P71asSfBwap9diqqvykBZnT+sZCVC7bNxeCs4/h0t0biYGsamGJeIiZxDCBkyXf
	 9pvFjdQDquZoNtyqGsbZv2JXtnSMvW5IAwwkETtXm0zXvCZ7gQEXdHBUMifEe3DxXE
	 ihYvZeZfkp5Gw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ching-Te Ku <ku920601@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 608/642] wifi: rtw89: coex: Separated Wi-Fi connecting event from Wi-Fi scan event
Date: Mon,  5 May 2025 18:13:44 -0400
Message-Id: <20250505221419.2672473-608-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Ching-Te Ku <ku920601@realtek.com>

[ Upstream commit 4a57346652154bb339c48b41166df9154cff33f5 ]

Wi-Fi connecting process don't need to assign to firmware slot control,
if assign firmware slot control for Wi-Fi connecting event, firmware will
not toggle slots because driver don't tell the slot schedule to firmware.
Wi-Fi connecting event end should also cancel the 4way handshake status.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250110015416.10704-3-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index d94a028555e20..7b10ee97c6277 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -5406,7 +5406,8 @@ static void _action_wl_scan(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
 
-	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw)) {
+	if (btc->cx.state_map != BTC_WLINKING &&
+	    RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw)) {
 		_action_wl_25g_mcc(rtwdev);
 		rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], Scan offload!\n");
 	} else if (rtwdev->dbcc_en) {
@@ -7221,6 +7222,8 @@ void rtw89_btc_ntfy_scan_finish(struct rtw89_dev *rtwdev, u8 phy_idx)
 		_fw_set_drv_info(rtwdev, CXDRVINFO_DBCC);
 	}
 
+	btc->dm.tdma_instant_excute = 1;
+
 	_run_coex(rtwdev, BTC_RSN_NTFY_SCAN_FINISH);
 }
 
@@ -7669,7 +7672,8 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 	else
 		wl->status.map.connecting = 0;
 
-	if (state == BTC_ROLE_MSTS_STA_DIS_CONN)
+	if (state == BTC_ROLE_MSTS_STA_DIS_CONN ||
+	    state == BTC_ROLE_MSTS_STA_CONN_END)
 		wl->status.map._4way = false;
 
 	_run_coex(rtwdev, BTC_RSN_NTFY_ROLE_INFO);
-- 
2.39.5


