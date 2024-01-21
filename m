Return-Path: <linux-wireless+bounces-2295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 940E58354CF
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jan 2024 08:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFC01F23327
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jan 2024 07:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7CA36134;
	Sun, 21 Jan 2024 07:19:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3018236136
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jan 2024 07:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705821549; cv=none; b=iVtiiiQ57oMCC9Xjl5x34nY3aOlyasGNn6l3RCivLsGpPZIUXEoKTScxOKKeQzyCrNQWd04dH5bw5tfXiqm1h+WAqmH3PUDWsdjvu4LGJd7m53YEqiZArTGEIzfBZtcqdFnIakJ/2TXf+Z3UiIPnGOuk2TOdpGKiiQqTdKu674g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705821549; c=relaxed/simple;
	bh=DUhCKy54Szw4KS/OtETrlpxzBKoG31ljAoZiCMwWtOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsLbAtgd3m8yyy+7eWfRsT15EILlLKp+GMdxkBpB3/9MY9IdyvXalX5t8kagigJXp9IMNlvj8urNtkv406EzkbWFm8L5Jg8kU1s9s3+xXJpCNmBCgMKZY+0/djJEAtu2IfthB3J3zyMVHYenlR9jGgrk2eoHaxz06ICu6QumGR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40L7IsfZ63102115, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40L7IsfZ63102115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Jan 2024 15:18:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Sun, 21 Jan 2024 15:18:54 +0800
Received: from [127.0.1.1] (172.16.17.107) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 21 Jan
 2024 15:18:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/4] wifi: rtw89: pci: update SER timer unit and timeout time
Date: Sun, 21 Jan 2024 15:18:23 +0800
Message-ID: <20240121071826.10159-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240121071826.10159-1-pkshih@realtek.com>
References: <20240121071826.10159-1-pkshih@realtek.com>
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

Be higher resolution of SER timer unit from 32ms to 16ms to detect
abnormal situation more accurately, and set hardware watchdog timer to 4ms.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci_be.c | 5 +++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 629ffa4bee91..5c9e39357773 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -105,6 +105,10 @@ static void rtw89_pci_ctrl_trxdma_pcie_be(struct rtw89_dev *rtwdev,
 		val |= B_BE_STOP_AXI_MST;
 
 	rtw89_write32(rtwdev, R_BE_HAXI_INIT_CFG1, val);
+
+	if (io_en == MAC_AX_PCIE_ENABLE)
+		rtw89_write32_mask(rtwdev, R_BE_HAXI_MST_WDT_TIMEOUT_SEL_V1,
+				   B_BE_HAXI_MST_WDT_TIMEOUT_SEL_MASK, 4);
 }
 
 static void rtw89_pci_clr_idx_all_be(struct rtw89_dev *rtwdev)
@@ -257,6 +261,7 @@ static void rtw89_pci_ser_setting_be(struct rtw89_dev *rtwdev)
 	rtw89_write32(rtwdev, R_BE_PL1_DBG_INFO, 0x0);
 	rtw89_write32_set(rtwdev, R_BE_FWS1IMR, B_BE_PCIE_SER_TIMEOUT_INDIC_EN);
 	rtw89_write32_set(rtwdev, R_BE_SER_PL1_CTRL, B_BE_PL1_SER_PL1_EN);
+	rtw89_write32_mask(rtwdev, R_BE_SER_PL1_CTRL, B_BE_PL1_TIMER_UNIT_MASK, 1);
 
 	val32 = rtw89_read32(rtwdev, R_BE_REG_PL1_MASK);
 	val32 |= B_BE_SER_PMU_IMR | B_BE_SER_L1SUB_IMR | B_BE_SER_PM_MASTER_IMR |
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index b411bf726849..e1802fe04576 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -5727,6 +5727,9 @@
 #define B_BE_STOP_CH1 BIT(1)
 #define B_BE_STOP_CH0 BIT(0)
 
+#define R_BE_HAXI_MST_WDT_TIMEOUT_SEL_V1 0xB02C
+#define B_BE_HAXI_MST_WDT_TIMEOUT_SEL_MASK GENMASK(4, 0)
+
 #define R_BE_HAXI_IDCT_MSK 0xB0B8
 #define B_BE_HAXI_RRESP_ERR_IDCT_MSK BIT(7)
 #define B_BE_HAXI_BRESP_ERR_IDCT_MSK BIT(6)
-- 
2.25.1


