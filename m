Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341F4700025
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 08:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbjELGND (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 02:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjELGNB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 02:13:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F2730E1
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 23:12:55 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34C6CYs34013918, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34C6CYs34013918
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 12 May 2023 14:12:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 12 May 2023 14:12:41 +0800
Received: from [127.0.1.1] (172.16.17.85) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 12 May
 2023 14:12:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/6] wifi: rtw89: 8851b: add to read efuse version to recognize hardware version B
Date:   Fri, 12 May 2023 14:12:15 +0800
Message-ID: <20230512061220.16544-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512061220.16544-1-pkshih@realtek.com>
References: <20230512061220.16544-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.85]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

8851B hardware version A and B use different firmware, but register version
code of these two are the same, so add this helper to read efuse version to
determine which version is installed.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/efuse.c | 21 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/efuse.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c b/drivers/net/wireless/realtek/rtw89/efuse.c
index 7bd4f8558e03b..2aaf4d013e464 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse.c
@@ -7,6 +7,10 @@
 #include "mac.h"
 #include "reg.h"
 
+#define EF_FV_OFSET 0x5ea
+#define EF_CV_MASK GENMASK(7, 4)
+#define EF_CV_INV 15
+
 enum rtw89_efuse_bank {
 	RTW89_EFUSE_BANK_WIFI,
 	RTW89_EFUSE_BANK_BT,
@@ -328,3 +332,20 @@ int rtw89_parse_phycap_map(struct rtw89_dev *rtwdev)
 
 	return ret;
 }
+
+int rtw89_read_efuse_ver(struct rtw89_dev *rtwdev, u8 *ecv)
+{
+	int ret;
+	u8 val;
+
+	ret = rtw89_dump_physical_efuse_map(rtwdev, &val, EF_FV_OFSET, 1, false);
+	if (ret)
+		return ret;
+
+	*ecv = u8_get_bits(val, EF_CV_MASK);
+	if (*ecv == EF_CV_INV)
+		return -ENOENT;
+
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_read_efuse_ver);
diff --git a/drivers/net/wireless/realtek/rtw89/efuse.h b/drivers/net/wireless/realtek/rtw89/efuse.h
index 622ff95e74763..79071aff28de3 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.h
+++ b/drivers/net/wireless/realtek/rtw89/efuse.h
@@ -9,5 +9,6 @@
 
 int rtw89_parse_efuse_map(struct rtw89_dev *rtwdev);
 int rtw89_parse_phycap_map(struct rtw89_dev *rtwdev);
+int rtw89_read_efuse_ver(struct rtw89_dev *rtwdev, u8 *efv);
 
 #endif
-- 
2.25.1

