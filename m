Return-Path: <linux-wireless+bounces-353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79981802CBC
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 09:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 028BCB209D4
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 08:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DB4E569;
	Mon,  4 Dec 2023 08:09:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40F1D6
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 00:09:15 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B4892erC1945248, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B4892erC1945248
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 16:09:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 4 Dec 2023 16:09:03 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 4 Dec 2023
 16:09:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <leo.li@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/5] wifi: rtw89: fw: extend program counter dump for Wi-Fi 7 chip
Date: Mon, 4 Dec 2023 16:07:48 +0800
Message-ID: <20231204080751.15354-3-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Extend FW program counter dump for Wi-Fi 7 chip.
They poll different addresses.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 10 +++++++++-
 drivers/net/wireless/realtek/rtw89/reg.h |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0b9c3c76b273..81034b6ce4b0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -957,16 +957,24 @@ static int rtw89_fw_download_main(struct rtw89_dev *rtwdev,
 
 static void rtw89_fw_prog_cnt_dump(struct rtw89_dev *rtwdev)
 {
+	enum rtw89_chip_gen chip_gen = rtwdev->chip->chip_gen;
+	u32 addr = R_AX_DBG_PORT_SEL;
 	u32 val32;
 	u16 index;
 
+	if (chip_gen == RTW89_CHIP_BE) {
+		addr = R_BE_WLCPU_PORT_PC;
+		goto dump;
+	}
+
 	rtw89_write32(rtwdev, R_AX_DBG_CTRL,
 		      FIELD_PREP(B_AX_DBG_SEL0, FW_PROG_CNTR_DBG_SEL) |
 		      FIELD_PREP(B_AX_DBG_SEL1, FW_PROG_CNTR_DBG_SEL));
 	rtw89_write32_mask(rtwdev, R_AX_SYS_STATUS1, B_AX_SEL_0XC0_MASK, MAC_DBG_SEL);
 
+dump:
 	for (index = 0; index < 15; index++) {
-		val32 = rtw89_read32(rtwdev, R_AX_DBG_PORT_SEL);
+		val32 = rtw89_read32(rtwdev, addr);
 		rtw89_err(rtwdev, "[ERR]fw PC = 0x%x\n", val32);
 		fsleep(10);
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 1bd91c62678d..690fa835c054 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4023,6 +4023,8 @@
 #define B_BE_USB_HCISYS_PWR_STE_MASK GENMASK(3, 2)
 #define B_BE_PCIE_HCISYS_PWR_STE_MASK GENMASK(1, 0)
 
+#define R_BE_WLCPU_PORT_PC 0x03FC
+
 #define R_BE_DCPU_PLATFORM_ENABLE 0x0888
 #define B_BE_DCPU_SYM_DPLT_MEM_MUX_EN BIT(10)
 #define B_BE_DCPU_WARM_EN BIT(9)
-- 
2.25.1


