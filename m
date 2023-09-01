Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BE278F876
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 08:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348367AbjIAGQs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 02:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348361AbjIAGQZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 02:16:25 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AEE410D2
        for <linux-wireless@vger.kernel.org>; Thu, 31 Aug 2023 23:16:22 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3816Fo8iA007319, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3816Fo8iA007319
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Sep 2023 14:15:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 1 Sep 2023 14:16:16 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 1 Sep 2023
 14:16:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 8/8] wifi: rtw89: 8922a: set memory heap address for secure firmware
Date:   Fri, 1 Sep 2023 14:15:07 +0800
Message-ID: <20230901061507.34312-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230901061507.34312-1-pkshih@realtek.com>
References: <20230901061507.34312-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Secure firmware is protected by public/private key cryptography. To help
firmware self verify integrity, configure a heap address for these
data before downloading firmware.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 4 ++++
 drivers/net/wireless/realtek/rtw89/reg.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index b27d3cb6f1d9..c5dff61c8ebd 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -912,6 +912,10 @@ static int rtw89_fw_download_suit(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
+	if (rtwdev->chip->chip_id == RTL8922A &&
+	    (fw_suit->type == RTW89_FW_NORMAL || fw_suit->type == RTW89_FW_WOWLAN))
+		rtw89_write32(rtwdev, R_BE_SECURE_BOOT_MALLOC_INFO, 0x20248000);
+
 	ret = mac->fwdl_check_path_ready(rtwdev, true);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]H2C path ready\n");
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 7798866d20c6..d37bb8273ff5 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3670,6 +3670,8 @@
 #define B_BE_LPS_STATUS BIT(3)
 #define B_BE_HCI_TXDMA_BUSY BIT(2)
 
+#define R_BE_SECURE_BOOT_MALLOC_INFO 0x0184
+
 #define R_BE_WCPU_FW_CTRL 0x01E0
 #define B_BE_RUN_ENV_MASK GENMASK(31, 30)
 #define B_BE_WCPU_FWDL_STATUS_MASK GENMASK(29, 26)
-- 
2.25.1

