Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE1C62D37C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Nov 2022 07:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbiKQGbI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 01:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbiKQGa7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 01:30:59 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C63DA6B23C
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 22:30:58 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AH6UBJF0014864, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AH6UBJF0014864
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 17 Nov 2022 14:30:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 17 Nov 2022 14:30:52 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 17 Nov
 2022 14:30:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: read CFO from FD or preamble CFO field of phy status ie_type 1 accordingly
Date:   Thu, 17 Nov 2022 14:30:00 +0800
Message-ID: <20221117063001.42967-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117063001.42967-1-pkshih@realtek.com>
References: <20221117063001.42967-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 11/17/2022 06:09:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzE3IKRXpMggMDM6MzM6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Eric Huang <echuang@realtek.com>

Add macro to get FD(frequency domain) CFO field from ie_type 1, and correct
the naming for preamble CFO field. Each IC could assign the CFO source to
either FD CFO or preamble CFO in chip_info. Based on the suggestion from HW
designer, rtw8852b and its derived versions will have better CFO tracking
performance with FD CFO.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 6 +++++-
 drivers/net/wireless/realtek/rtw89/core.h     | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 1 +
 drivers/net/wireless/realtek/rtw89/txrx.h     | 4 +++-
 6 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index f30aadc41f2be..c0a4667fd7e2d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1196,7 +1196,11 @@ static void rtw89_core_parse_phy_status_ie01(struct rtw89_dev *rtwdev, u8 *addr,
 	if (phy_ppdu->rate < RTW89_HW_RATE_OFDM6)
 		return;
 	/* sign conversion for S(12,2) */
-	cfo = sign_extend32(RTW89_GET_PHY_STS_IE01_CFO(addr), 11);
+	if (rtwdev->chip->cfo_src_fd)
+		cfo = sign_extend32(RTW89_GET_PHY_STS_IE01_FD_CFO(addr), 11);
+	else
+		cfo = sign_extend32(RTW89_GET_PHY_STS_IE01_PREMB_CFO(addr), 11);
+
 	rtw89_phy_cfo_parse(rtwdev, cfo, phy_ppdu);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b60de6662548b..ba4ccbde5ecf9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2755,6 +2755,7 @@ struct rtw89_chip_info {
 	u32 c2h_ctrl_reg;
 	const u32 *c2h_regs;
 	const struct rtw89_page_regs *page_regs;
+	bool cfo_src_fd;
 	const struct rtw89_reg_def *dcfo_comp;
 	u8 dcfo_comp_sft;
 	const struct rtw89_imr_info *imr_info;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 4cea5fb4327d7..f38a330698e9a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2143,6 +2143,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.c2h_ctrl_reg		= R_AX_C2HREG_CTRL,
 	.c2h_regs		= rtw8852a_c2h_regs,
 	.page_regs		= &rtw8852a_page_regs,
+	.cfo_src_fd		= false,
 	.dcfo_comp		= &rtw8852a_dcfo_comp,
 	.dcfo_comp_sft		= 3,
 	.imr_info		= &rtw8852a_imr_info,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 85dfc1ebb0d97..22b3c86ee7d86 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2512,6 +2512,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.c2h_ctrl_reg		= R_AX_C2HREG_CTRL,
 	.c2h_regs		= rtw8852b_c2h_regs,
 	.page_regs		= &rtw8852b_page_regs,
+	.cfo_src_fd		= true,
 	.dcfo_comp		= &rtw8852b_dcfo_comp,
 	.dcfo_comp_sft		= 3,
 	.imr_info		= &rtw8852b_imr_info,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 6619ba7307199..01e6358fa1a29 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2953,6 +2953,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.c2h_ctrl_reg		= R_AX_C2HREG_CTRL_V1,
 	.c2h_regs		= rtw8852c_c2h_regs,
 	.page_regs		= &rtw8852c_page_regs,
+	.cfo_src_fd		= false,
 	.dcfo_comp		= &rtw8852c_dcfo_comp,
 	.dcfo_comp_sft		= 5,
 	.imr_info		= &rtw8852c_imr_info,
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index b889e7bf34c0c..9d4c6b6fa1250 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -298,7 +298,9 @@
 	le32_get_bits(*((const __le32 *)ie), GENMASK(11, 5))
 #define RTW89_GET_PHY_STS_IE01_CH_IDX(ie) \
 	le32_get_bits(*((const __le32 *)ie), GENMASK(23, 16))
-#define RTW89_GET_PHY_STS_IE01_CFO(ie) \
+#define RTW89_GET_PHY_STS_IE01_FD_CFO(ie) \
+	le32_get_bits(*((const __le32 *)(ie) + 1), GENMASK(19, 8))
+#define RTW89_GET_PHY_STS_IE01_PREMB_CFO(ie) \
 	le32_get_bits(*((const __le32 *)(ie) + 1), GENMASK(31, 20))
 
 enum rtw89_tx_channel {
-- 
2.25.1

