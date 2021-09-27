Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D8E418DE5
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 05:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhI0DUd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Sep 2021 23:20:33 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:52567 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhI0DUc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Sep 2021 23:20:32 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 18R3IkxV6025389, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 18R3IkxV6025389
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Sep 2021 11:18:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 27 Sep 2021 11:18:46 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 27 Sep
 2021 11:18:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH] rtw88: fix RX clock gate setting while fifo dump
Date:   Mon, 27 Sep 2021 19:18:30 +0800
Message-ID: <20210927111830.5354-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/27/2021 02:58:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzkvMjYgpFWkyCAxMDoyOTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

When fw fifo dumps, RX clock gating should be disabled to avoid
something unexpected. However, the register operation ran into
a mistake. So, we fix it.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c  | 7 +++----
 drivers/net/wireless/realtek/rtw88/reg.h | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index ccd8221ab264..0c4f2a2f2d7f 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1582,12 +1582,10 @@ static void rtw_fw_read_fifo_page(struct rtw_dev *rtwdev, u32 offset, u32 size,
 	u32 i;
 	u16 idx = 0;
 	u16 ctl;
-	u8 rcr;
 
-	rcr = rtw_read8(rtwdev, REG_RCR + 2);
 	ctl = rtw_read16(rtwdev, REG_PKTBUF_DBG_CTRL) & 0xf000;
 	/* disable rx clock gate */
-	rtw_write8(rtwdev, REG_RCR, rcr | BIT(3));
+	rtw_write32_set(rtwdev, REG_RCR, BIT_DISGCLK);
 
 	do {
 		rtw_write16(rtwdev, REG_PKTBUF_DBG_CTRL, start_pg | ctl);
@@ -1606,7 +1604,8 @@ static void rtw_fw_read_fifo_page(struct rtw_dev *rtwdev, u32 offset, u32 size,
 
 out:
 	rtw_write16(rtwdev, REG_PKTBUF_DBG_CTRL, ctl);
-	rtw_write8(rtwdev, REG_RCR + 2, rcr);
+	/* restore rx clock gate */
+	rtw_write32_clr(rtwdev, REG_RCR, BIT_DISGCLK);
 }
 
 static void rtw_fw_read_fifo(struct rtw_dev *rtwdev, enum rtw_fw_fifo_sel sel,
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index abb7b490d8fa..84ba9ec489c3 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -408,6 +408,7 @@
 #define BIT_MFBEN		BIT(22)
 #define BIT_DISCHKPPDLLEN	BIT(21)
 #define BIT_PKTCTL_DLEN		BIT(20)
+#define BIT_DISGCLK		BIT(19)
 #define BIT_TIM_PARSER_EN	BIT(18)
 #define BIT_BC_MD_EN		BIT(17)
 #define BIT_UC_MD_EN		BIT(16)
-- 
2.25.1

