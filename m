Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5FB6FA286
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjEHIoJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjEHIoH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:44:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0822421558
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:44:01 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3488hnOM3008152, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3488hnOM3008152
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 8 May 2023 16:43:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 8 May 2023 16:43:55 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 May 2023
 16:43:54 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: rtw89: suppress the log for specific SER called CMDPSR_FRZTO
Date:   Mon, 8 May 2023 16:43:35 +0800
Message-ID: <20230508084335.42953-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508084335.42953-1-pkshih@realtek.com>
References: <20230508084335.42953-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

For 8852CE, there is abnormal state called CMDPSR_FRZTO,
which occasionally happens in some platforms, and could be
found by firmware and fixed in current SER flow, so we add
suppress function to avoid verbose message for this resolved case.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c  | 36 +++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b71827751848a..154fec1a231d1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3939,6 +3939,7 @@ enum rtw89_ser_rcvy_step {
 	RTW89_SER_DRV_STOP_RX,
 	RTW89_SER_DRV_STOP_RUN,
 	RTW89_SER_HAL_STOP_DMA,
+	RTW89_SER_SUPPRESS_LOG,
 	RTW89_NUM_OF_SER_FLAGS
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index e5996a94c0def..acba53cf7cc31 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -644,6 +644,39 @@ static void rtw89_mac_dump_err_status(struct rtw89_dev *rtwdev,
 	rtw89_info(rtwdev, "<---\n");
 }
 
+static bool rtw89_mac_suppress_log(struct rtw89_dev *rtwdev, u32 err)
+{
+	struct rtw89_ser *ser = &rtwdev->ser;
+	u32 dmac_err, imr, isr;
+	int ret;
+
+	if (rtwdev->chip->chip_id == RTL8852C) {
+		ret = rtw89_mac_check_mac_en(rtwdev, 0, RTW89_DMAC_SEL);
+		if (ret)
+			return true;
+
+		if (err == MAC_AX_ERR_L1_ERR_DMAC) {
+			dmac_err = rtw89_read32(rtwdev, R_AX_DMAC_ERR_ISR);
+			imr = rtw89_read32(rtwdev, R_AX_TXPKTCTL_B0_ERRFLAG_IMR);
+			isr = rtw89_read32(rtwdev, R_AX_TXPKTCTL_B0_ERRFLAG_ISR);
+
+			if ((dmac_err & B_AX_TXPKTCTRL_ERR_FLAG) &&
+			    ((isr & imr) & B_AX_B0_ISR_ERR_CMDPSR_FRZTO)) {
+				set_bit(RTW89_SER_SUPPRESS_LOG, ser->flags);
+				return true;
+			}
+		} else if (err == MAC_AX_ERR_L1_RESET_DISABLE_DMAC_DONE) {
+			if (test_bit(RTW89_SER_SUPPRESS_LOG, ser->flags))
+				return true;
+		} else if (err == MAC_AX_ERR_L1_RESET_RECOVERY_DONE) {
+			if (test_and_clear_bit(RTW89_SER_SUPPRESS_LOG, ser->flags))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev)
 {
 	u32 err, err_scnr;
@@ -667,6 +700,9 @@ u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev)
 	else if (err_scnr == RTW89_RXI300_ERROR)
 		err = MAC_AX_ERR_RXI300;
 
+	if (rtw89_mac_suppress_log(rtwdev, err))
+		return err;
+
 	rtw89_fw_st_dbg_dump(rtwdev);
 	rtw89_mac_dump_err_status(rtwdev, err);
 
-- 
2.25.1

