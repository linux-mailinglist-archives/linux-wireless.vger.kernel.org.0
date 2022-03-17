Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B464DBF28
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 07:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiCQGSu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 02:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiCQGSF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 02:18:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC201877CF
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 22:56:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22H5ulrtF009805, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22H5ulrtF009805
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Mar 2022 13:56:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 17 Mar 2022 13:56:47 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 13:56:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <hsuan8331@realtek.com>, <yuanhan1020@realtek.com>
Subject: [PATCH v2 07/12] rtw89: initialize preload window of D-MAC
Date:   Thu, 17 Mar 2022 13:55:38 +0800
Message-ID: <20220317055543.40514-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317055543.40514-1-pkshih@realtek.com>
References: <20220317055543.40514-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/17/2022 05:41:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTcgpFekyCAwMzoyNjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

8852C add new hardware feature -- preload window, which is used to load
more data to D-MAC, so it can possibly yield better performance.

This patch is to configure preload and reserved size for next window.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 43 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h | 24 +++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index aa33ec95aa36b..83690656c3e8e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1545,6 +1545,43 @@ static int dle_init(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
 	return ret;
 }
 
+static int preload_init_set(struct rtw89_dev *rtwdev, enum rtw89_mac_idx mac_idx,
+			    enum rtw89_qta_mode mode)
+{
+	u32 reg, max_preld_size, min_rsvd_size;
+
+	max_preld_size = (mac_idx == RTW89_MAC_0 ?
+			  PRELD_B0_ENT_NUM : PRELD_B1_ENT_NUM) * PRELD_AMSDU_SIZE;
+	reg = mac_idx == RTW89_MAC_0 ?
+	      R_AX_TXPKTCTL_B0_PRELD_CFG0 : R_AX_TXPKTCTL_B1_PRELD_CFG0;
+	rtw89_write32_mask(rtwdev, reg, B_AX_B0_PRELD_USEMAXSZ_MASK, max_preld_size);
+	rtw89_write32_set(rtwdev, reg, B_AX_B0_PRELD_FEN);
+
+	min_rsvd_size = PRELD_AMSDU_SIZE;
+	reg = mac_idx == RTW89_MAC_0 ?
+	      R_AX_TXPKTCTL_B0_PRELD_CFG1 : R_AX_TXPKTCTL_B1_PRELD_CFG1;
+	rtw89_write32_mask(rtwdev, reg, B_AX_B0_PRELD_NXT_TXENDWIN_MASK, PRELD_NEXT_WND);
+	rtw89_write32_mask(rtwdev, reg, B_AX_B0_PRELD_NXT_RSVMINSZ_MASK, min_rsvd_size);
+
+	return 0;
+}
+
+static bool is_qta_poh(struct rtw89_dev *rtwdev)
+{
+	return rtwdev->hci.type == RTW89_HCI_TYPE_PCIE;
+}
+
+static int preload_init(struct rtw89_dev *rtwdev, enum rtw89_mac_idx mac_idx,
+			enum rtw89_qta_mode mode)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B || !is_qta_poh(rtwdev))
+		return 0;
+
+	return preload_init_set(rtwdev, mac_idx, mode);
+}
+
 static bool dle_is_txq_empty(struct rtw89_dev *rtwdev)
 {
 	u32 msk32;
@@ -1652,6 +1689,12 @@ static int dmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 		return ret;
 	}
 
+	ret = preload_init(rtwdev, RTW89_MAC_0, rtwdev->mac.qta_mode);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]preload init %d\n", ret);
+		return ret;
+	}
+
 	ret = hfc_init(rtwdev, true, true, true);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]HCI FC init %d\n", ret);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 94ec7b2aad9db..5c11c5d81c8bc 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -742,6 +742,30 @@
 #define R_AX_DBG_FUN_INTF_DATA 0x9F34
 #define B_AX_DFI_DATA_MASK GENMASK(31, 0)
 
+#define R_AX_TXPKTCTL_B0_PRELD_CFG0 0x9F48
+#define B_AX_B0_PRELD_FEN BIT(31)
+#define B_AX_B0_PRELD_USEMAXSZ_MASK GENMASK(25, 16)
+#define PRELD_B0_ENT_NUM 10
+#define PRELD_AMSDU_SIZE 52
+#define B_AX_B0_PRELD_CAM_G1ENTNUM_MASK GENMASK(12, 8)
+#define B_AX_B0_PRELD_CAM_G0ENTNUM_MASK GENMASK(4, 0)
+
+#define R_AX_TXPKTCTL_B0_PRELD_CFG1 0x9F4C
+#define B_AX_B0_PRELD_NXT_TXENDWIN_MASK GENMASK(11, 8)
+#define PRELD_NEXT_WND 1
+#define B_AX_B0_PRELD_NXT_RSVMINSZ_MASK GENMASK(7, 0)
+
+#define R_AX_TXPKTCTL_B1_PRELD_CFG0 0x9F88
+#define B_AX_B1_PRELD_FEN BIT(31)
+#define B_AX_B1_PRELD_USEMAXSZ_MASK GENMASK(25, 16)
+#define PRELD_B1_ENT_NUM 4
+#define B_AX_B1_PRELD_CAM_G1ENTNUM_MASK GENMASK(12, 8)
+#define B_AX_B1_PRELD_CAM_G0ENTNUM_MASK GENMASK(4, 0)
+
+#define R_AX_TXPKTCTL_B1_PRELD_CFG1 0x9F8C
+#define B_AX_B1_PRELD_NXT_TXENDWIN_MASK GENMASK(11, 8)
+#define B_AX_B1_PRELD_NXT_RSVMINSZ_MASK GENMASK(7, 0)
+
 #define R_AX_AFE_CTRL1 0x0024
 
 #define B_AX_R_SYM_WLCMAC1_P4_PC_EN BIT(4)
-- 
2.25.1

