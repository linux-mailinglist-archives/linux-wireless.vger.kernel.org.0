Return-Path: <linux-wireless+bounces-20792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF06A6E880
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 04:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CCE1895842
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 03:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF5818DB0E;
	Tue, 25 Mar 2025 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="TgeGf+sJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD3BA50
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742872232; cv=none; b=tP5m9QueBEjUh65CrfV1NwEqAqZYLTgzDlvUt7oB9GVpy1U8TZO3bLBxnkgJd+3qmYZDpEUuyrx7Wmat1NpL9YqR2G9e3ObJ1tOM5otnRqbKjaQGRoHVOoWszzMrboy9ykG8aj0sAqrjudZSxShnmvhQ/UN1VM7eC1g9BxnhkRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742872232; c=relaxed/simple;
	bh=YDWEdShkrGCpNh3vQ9W7rijOjZVNbMmfbhcmFq+5qso=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nsXGxxJkS6C9h5TAd4GRFzQVuD5bVM0en3axe0XJG8qnLpIMOPoqLcHxPPEpvSGxWxn14jlwPS/Og8qITePOwK8qTEiHiaKq759vdnIMDPnShIrxeLJJ1fbWp0YUPj2dsphU4JFf5fw6YT05WGm8iKbK4NDMd7hElyxaEnjVk0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=TgeGf+sJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52P3AQeV43614091, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742872226; bh=YDWEdShkrGCpNh3vQ9W7rijOjZVNbMmfbhcmFq+5qso=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=TgeGf+sJx4EHaHIAUh+cOjwNMgLWN/gw0JAIPBy079LPZPYtKtTkX1ZnCbPY6wVZW
	 OHYXhb7fzaqOmiLBVgfRXFo0wBLy+6pKcpp2oskp6WImRa3VQhGs2ghFU3P++cxVJC
	 AtQMqxpbwwMHRpK7uLiYrta0zDNErSPEjT2XkUsUOte3AH9kE+JOjD8SbqtBhGFTSu
	 kE9XA1cIG91SMjW4VMECfaOx6zMkh0UacC5DZ+ANR/4ID3g5vQhsf4PX5q4rDI2Hs/
	 j2Hy72HX63jqwC8ag1+/4oA0ASzGIFZQV8w7SLfit3xTD+BSrQuELwYp+JSku5knY6
	 QMgv/jMpRChRA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52P3AQeV43614091
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 11:10:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Mar 2025 11:10:27 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 25 Mar
 2025 11:10:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next] wifi: rtw89: phy: reset value of force TX power for MAC ID
Date: Tue, 25 Mar 2025 11:10:21 +0800
Message-ID: <20250325031021.15619-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

The force TX power function is disabled, but the force TX power value is
preserved, causing misunderstand the behavior in debug. Clear all values.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy_be.c |  2 +-
 drivers/net/wireless/realtek/rtw89/reg.h    | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 37d8f254ae32..d321cf1fc485 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -362,7 +362,7 @@ static void rtw89_phy_bb_wrap_force_cr_init(struct rtw89_dev *rtwdev,
 	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_RU_ENON, 0);
 	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_RU_ON, 0);
 	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_FORCE_MACID, mac_idx);
-	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_MACID_ON, 0);
+	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_MACID_ALL, 0);
 	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_COEX_CTRL, mac_idx);
 	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_COEX_ON, 0);
 	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_RATE_CTRL, mac_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c776954ad360..6ef546d1b575 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7601,7 +7601,15 @@
 #define B_BE_PWR_FORCE_RU_ON BIT(18)
 #define B_BE_PWR_FORCE_RU_ENON BIT(28)
 #define R_BE_PWR_FORCE_MACID 0x11A48
-#define B_BE_PWR_FORCE_MACID_ON BIT(9)
+#define B_BE_PWR_FORCE_MACID_DBM_ON BIT(9)
+#define B_BE_PWR_FORCE_MACID_DBM_VAL GENMASK(17, 10)
+#define B_BE_PWR_FORCE_MACID_EN_VAL BIT(18)
+#define B_BE_PWR_FORCE_MACID_EN_ON BIT(19)
+#define B_BE_PWR_FORCE_MACID_ALL \
+	(B_BE_PWR_FORCE_MACID_DBM_ON | \
+	 B_BE_PWR_FORCE_MACID_DBM_VAL | \
+	 B_BE_PWR_FORCE_MACID_EN_VAL | \
+	 B_BE_PWR_FORCE_MACID_EN_ON)
 
 #define R_BE_PWR_REG_CTRL 0x11A50
 #define B_BE_PWR_BT_EN BIT(23)
-- 
2.25.1


