Return-Path: <linux-wireless+bounces-22633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C09B5AAB2BB
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F693B0833
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA972DD78D;
	Tue,  6 May 2025 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGdYWSs0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80EE36AADA;
	Mon,  5 May 2025 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485778; cv=none; b=RkpaMrkZKEzES53nYiU+ikskafZCYxdMjfMN7dir6z0/UjCOVmvGE1HnU7DD4tKnLL9bwURH5tIiXloamLzgji/uK+DFd+BH0K8M2JeE0o9GCJxoAKjKa5eTWFT2/CXCEoD2VEANHGyUvtwREQEB8sW/Fr2QnO+UIM74Gw0a0Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485778; c=relaxed/simple;
	bh=q/+mYq37A2zsEi1sgl1dNJHL57ifGxjCo65jUBiAv88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p9ia4LyGGZIfa8suFpf1ZrLqm63bCbhGiVYkBtgCAOnF8QTmcB+a4wH+pQht+hzufF8FN6mSsvNbDAO95UO16ntz1DNnAHze0jaPX5SUiI1HrzAue5gBumtS9gMXkEosZ1q97OVuXs2BnbIX9v73xVMeRdVRYm7mP0elW6WqeF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGdYWSs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9416CC4CEEE;
	Mon,  5 May 2025 22:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485777;
	bh=q/+mYq37A2zsEi1sgl1dNJHL57ifGxjCo65jUBiAv88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGdYWSs0aj9+zVi+d8hgmXU5d3556lgbLqVl/SiW/E84h5ZVmY4usGkJox1YuyIo6
	 DllGYt/qQw3EJCbI0K7cMqLJFl4WmWYy0L88YUKhRvlwYTX8oAdpi0H26XKrJTBZLb
	 No53pJmTJmzGTq/3ey4bQ3rjxu4o8eJXlWde/N/ewsqRB56aAQMNhBdeR1pTmj5+SG
	 0Ogtj0fxrBbR0E6yQz5mlBgSbV7xzPtRec+GXs8qBuQ3eyN/zsyijll4TPSZMwCGE0
	 ipOuH+TR+JmN8VEpMLySJlRtV3rINFwblCgB4n4S1H4gYPB6fCZtVo+ArQzPIEBWUN
	 Fwb5cIttr4uMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ching-Te Ku <ku920601@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 479/486] wifi: rtw89: coex: Separated Wi-Fi connecting event from Wi-Fi scan event
Date: Mon,  5 May 2025 18:39:15 -0400
Message-Id: <20250505223922.2682012-479-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 5f878f086f7cf..6cdbf02f405ae 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -5356,7 +5356,8 @@ static void _action_wl_scan(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
 
-	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw)) {
+	if (btc->cx.state_map != BTC_WLINKING &&
+	    RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw)) {
 		_action_wl_25g_mcc(rtwdev);
 		rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], Scan offload!\n");
 	} else if (rtwdev->dbcc_en) {
@@ -7178,6 +7179,8 @@ void rtw89_btc_ntfy_scan_finish(struct rtw89_dev *rtwdev, u8 phy_idx)
 		_fw_set_drv_info(rtwdev, CXDRVINFO_DBCC);
 	}
 
+	btc->dm.tdma_instant_excute = 1;
+
 	_run_coex(rtwdev, BTC_RSN_NTFY_SCAN_FINISH);
 }
 
@@ -7630,7 +7633,8 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 	else
 		wl->status.map.connecting = 0;
 
-	if (state == BTC_ROLE_MSTS_STA_DIS_CONN)
+	if (state == BTC_ROLE_MSTS_STA_DIS_CONN ||
+	    state == BTC_ROLE_MSTS_STA_CONN_END)
 		wl->status.map._4way = false;
 
 	_run_coex(rtwdev, BTC_RSN_NTFY_ROLE_INFO);
-- 
2.39.5


