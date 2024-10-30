Return-Path: <linux-wireless+bounces-14703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829F99B59E9
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 03:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47018284C05
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 02:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9872E1C9EAB;
	Wed, 30 Oct 2024 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="AFGhh2ZE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3663A1C578E
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 02:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254954; cv=none; b=WndUdr74R+6INb4F2FedgMTuhYxXJCXf4nIblxTcUNakAGcj74a8jnZoRBLmRWp/ehG6TpwWue8PS6ZDe06LohNYwYImP+FrwT+NIuyqSph+WJr1RHpUpdjKtrVjCsvrR1QX+TLE11BS5HvNu5Yy/iK6903YnV1ebxbZRJea2JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254954; c=relaxed/simple;
	bh=7SuyLp+Z6PDcK70ZVVTYQ9oAsTAWREQT4LpUEIbZ5aw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyXLF35CvMFCrREBioVZc3fendCHw0swHFuhd73psDp3vga+6yN6UlBy/7IhYKtb3R8FzHBzh/e7nm/m1tvxdP5UQWerY7otiq4R8uJMNEEJmq3HvW0lfOYhwp0Cgz+lx1M2RB7fN3ofXzIEFFWFyJQruGvwtpmqIRMScg2Mg84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=AFGhh2ZE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49U2MU8403310681, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730254950; bh=7SuyLp+Z6PDcK70ZVVTYQ9oAsTAWREQT4LpUEIbZ5aw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=AFGhh2ZE0/eKdTJEk4hHcCp1M1Ego5BeljjrhsZ4remCito/WtDlHzl6M64KIul+s
	 Y5DlNqysSYTS/DbOTYXW3ogJMhyn1SYiWiAlZwDh8P8iOSg54/zOW+WjC/sRLLYGoW
	 /IWqKFHBfdrYRN1TDlWAqID9+b0axbTF4JhGIDn/Tb5sDmVFdIntqxvyl4xri23/Cr
	 OJpUz9qIR4qz5J8ZfGb4cc0yuCZhuTua73wNzzY5Y3DJBLx901WuSEx+x277loFSBF
	 HvD+0hAZ9yOfVlsBbdXA+1qz9/9ies+pJg3sYw0tlpspIvygYobokFTi7ckTvvNm7P
	 bMd8vY5e1V7bA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49U2MU8403310681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 10:22:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 10:22:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 30 Oct
 2024 10:22:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 8/8] wifi: rtw89: mac: no configure CMAC/DMAC tables for firmware secure boot
Date: Wed, 30 Oct 2024 10:21:35 +0800
Message-ID: <20241030022135.11688-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030022135.11688-1-pkshih@realtek.com>
References: <20241030022135.11688-1-pkshih@realtek.com>
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

The initial CMAC/DMAC tables used by WiFi 6 chips are not needed to be
called for firmware secure boot. Otherwise, it causes firmware abnormal
and throw warnings.

  rtw89_8852be 0000:03:00.0: FW status = 0x1400
  rtw89_8852be 0000:03:00.0: FW BADADDR = 0xb872f800
  rtw89_8852be 0000:03:00.0: FW EPC/RA = 0xb89333b7
  rtw89_8852be 0000:03:00.0: FW MISC = 0x0
  rtw89_8852be 0000:03:00.0: R_AX_HALT_C2H = 0x10002010
  rtw89_8852be 0000:03:00.0: R_AX_SER_DBG_INFO = 0x0
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb89a2c97
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb89a2c95
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb89a2c99
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb89a2c9b
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb89a2c9f
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb89a2c9b
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb89a2c99
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb89a2c9d
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb89a2c97
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb89a2c97
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb89a2c97
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb89a2c99
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb89a2c97
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb89a2c9f
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb89a2c99

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 8985bd8fa38f..7907b84d204b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4000,9 +4000,10 @@ int rtw89_mac_init(struct rtw89_dev *rtwdev)
 
 static void rtw89_mac_dmac_tbl_init(struct rtw89_dev *rtwdev, u8 macid)
 {
+	struct rtw89_fw_secure *sec = &rtwdev->fw.sec;
 	u8 i;
 
-	if (rtwdev->chip->chip_gen != RTW89_CHIP_AX)
+	if (rtwdev->chip->chip_gen != RTW89_CHIP_AX || sec->secure_boot)
 		return;
 
 	for (i = 0; i < 4; i++) {
@@ -4014,7 +4015,9 @@ static void rtw89_mac_dmac_tbl_init(struct rtw89_dev *rtwdev, u8 macid)
 
 static void rtw89_mac_cmac_tbl_init(struct rtw89_dev *rtwdev, u8 macid)
 {
-	if (rtwdev->chip->chip_gen != RTW89_CHIP_AX)
+	struct rtw89_fw_secure *sec = &rtwdev->fw.sec;
+
+	if (rtwdev->chip->chip_gen != RTW89_CHIP_AX || sec->secure_boot)
 		return;
 
 	rtw89_write32(rtwdev, R_AX_FILTER_MODEL_ADDR,
-- 
2.25.1


