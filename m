Return-Path: <linux-wireless+bounces-3322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D6C84D7D1
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 03:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC5BB22455
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 02:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5030200AE;
	Thu,  8 Feb 2024 02:30:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A4B1E89E
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359438; cv=none; b=oa1SQ71eJ78JtDxIkDIWSaalcRXitn/0zJRsUVr7sq9t1OlxxD38eTRXuITXbrHsVk82SEsGKQwfwW4my6e6pdUdJQ2Rtqmj3JOcrUsElSQOEMDnnz7cXWsrNyO07Q6vni1G0TDlcWaA1IISZ2D193MPMMrhLIMC94goHQBzFVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359438; c=relaxed/simple;
	bh=/aLcYv5SaWRp5DwEd0pGRpAS1JIHIRTGJfEV4cA/Vno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3RZucY1MFXNfqufksdHCmRHoTceyByYUYCLdHPbcJWmUMaUnGHwZCFiwHVDxubI5zp5CjOztvfHy9f3JxyosFIcoqb0fRACZ9q79OCai98tM0uHmLVYrn4eZ6Fbt7MXlLHtrLkBJA8lyMhaVPfwG1rNrnsg0q6EPEGmXubioRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4182UWSW0192115, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4182UWSW0192115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 10:30:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 8 Feb 2024 10:30:32 +0800
Received: from [127.0.1.1] (172.16.17.45) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 8 Feb
 2024 10:30:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 10/11] wifi: rtw89: reference quota mode when setting Tx power
Date: Thu, 8 Feb 2024 10:28:56 +0800
Message-ID: <20240208022857.14379-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208022857.14379-1-pkshih@realtek.com>
References: <20240208022857.14379-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Po-Hao Huang <phhuang@realtek.com>

Reference the current quota mode to avoid misleading warnings.
This patch is required after supporting DBCC quota mode.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 3 +--
 drivers/net/wireless/realtek/rtw89/mac_be.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 33cc2ce4bb74..917bbc482560 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5221,8 +5221,7 @@ bool rtw89_mac_get_txpwr_cr_ax(struct rtw89_dev *rtwdev,
 			       enum rtw89_phy_idx phy_idx,
 			       u32 reg_base, u32 *cr)
 {
-	const struct rtw89_dle_mem *dle_mem = rtwdev->chip->dle_mem;
-	enum rtw89_qta_mode mode = dle_mem->mode;
+	enum rtw89_qta_mode mode = rtwdev->mac.qta_mode;
 	u32 addr = rtw89_mac_reg_by_idx(rtwdev, reg_base, phy_idx);
 
 	if (addr < R_AX_PWR_RATE_CTRL || addr > CMAC1_END_ADDR_AX) {
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 6447353d35d3..320e88229971 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1896,8 +1896,7 @@ static bool rtw89_mac_get_txpwr_cr_be(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_idx phy_idx,
 				      u32 reg_base, u32 *cr)
 {
-	const struct rtw89_dle_mem *dle_mem = rtwdev->chip->dle_mem;
-	enum rtw89_qta_mode mode = dle_mem->mode;
+	enum rtw89_qta_mode mode = rtwdev->mac.qta_mode;
 	int ret;
 
 	ret = rtw89_mac_check_mac_en(rtwdev, (enum rtw89_mac_idx)phy_idx,
-- 
2.25.1


