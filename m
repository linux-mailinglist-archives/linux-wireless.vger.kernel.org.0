Return-Path: <linux-wireless+bounces-351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8625802CBB
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 09:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EAB5B20A63
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 08:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06D7DDA3;
	Mon,  4 Dec 2023 08:09:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A0DCB
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 00:09:14 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B4897Y701945273, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B4897Y701945273
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 16:09:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 4 Dec 2023 16:09:07 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 4 Dec 2023
 16:09:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <leo.li@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/5] wifi: rtw89: mac: refine SER setting during WiFi CPU power on
Date: Mon, 4 Dec 2023 16:07:51 +0800
Message-ID: <20231204080751.15354-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204080751.15354-1-pkshih@realtek.com>
References: <20231204080751.15354-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Don't enable firmware debug mode to prevent SER flow stuck due to fail
to reset payload buffer, and clear HALT_C2H_INT to avoid handling
unexpected interrupt at beginning.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index c3c920ccb2f9..7ad509787d72 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -384,8 +384,6 @@ static int wcpu_on(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw)
 	u32 val32;
 	int ret;
 
-	rtw89_write32_set(rtwdev, R_BE_UDM0, B_BE_UDM0_DBG_MODE_CTRL);
-
 	val32 = rtw89_read32(rtwdev, R_BE_HALT_C2H);
 	if (val32) {
 		rtw89_warn(rtwdev, "[SER] AON L2 Debug register not empty before Boot.\n");
@@ -409,6 +407,10 @@ static int wcpu_on(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw)
 	rtw89_write32(rtwdev, R_BE_HALT_H2C_CTRL, 0);
 	rtw89_write32(rtwdev, R_BE_HALT_C2H_CTRL, 0);
 
+	val32 = rtw89_read32(rtwdev, R_BE_HISR0);
+	rtw89_write32(rtwdev, R_BE_HISR0, B_BE_HALT_C2H_INT);
+	rtw89_debug(rtwdev, RTW89_DBG_SER, "HISR0=0x%x\n", val32);
+
 	rtw89_write32_set(rtwdev, R_BE_SYS_CLK_CTRL, B_BE_CPU_CLK_EN);
 	rtw89_write32_clr(rtwdev, R_BE_SYS_CFG5,
 			  B_BE_WDT_WAKE_PCIE_EN | B_BE_WDT_WAKE_USB_EN);
-- 
2.25.1


