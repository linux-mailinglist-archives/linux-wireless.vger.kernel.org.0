Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E483B4569DF
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 06:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhKSGBC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 01:01:02 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:52524 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhKSGBC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 01:01:02 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AJ5vnD13013378, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AJ5vnD13013378
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Nov 2021 13:57:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 19 Nov 2021 13:57:48 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 19 Nov
 2021 13:57:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <dan.carpenter@oracle.com>
Subject: [PATCH] rtw89: fix potentially access out of range of RF register array
Date:   Fri, 19 Nov 2021 13:57:29 +0800
Message-ID: <20211119055729.12826-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 11/19/2021 05:42:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzE4IKRVpMggMTA6MzA6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/19/2021 05:39:55
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167351 [Nov 19 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/19/2021 05:42:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The RF register array is used to help firmware to restore RF settings.
The original code can potentially access out of range, if the size is
between (RTW89_H2C_RF_PAGE_SIZE * RTW89_H2C_RF_PAGE_NUM + 1) to
((RTW89_H2C_RF_PAGE_SIZE + 1) * RTW89_H2C_RF_PAGE_NUM). Fortunately,
current used size doesn't fall into the wrong case, and the size will not
change if we don't update RF parameter.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 33 ++++++++++++++----------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index ab134856baac7..d75e9de8df7c6 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -654,6 +654,12 @@ rtw89_phy_cofig_rf_reg_store(struct rtw89_dev *rtwdev,
 	u16 idx = info->curr_idx % RTW89_H2C_RF_PAGE_SIZE;
 	u8 page = info->curr_idx / RTW89_H2C_RF_PAGE_SIZE;
 
+	if (page >= RTW89_H2C_RF_PAGE_NUM) {
+		rtw89_warn(rtwdev, "RF parameters exceed size. path=%d, idx=%d",
+			   rf_path, info->curr_idx);
+		return;
+	}
+
 	info->rtw89_phy_config_rf_h2c[page][idx] =
 		cpu_to_le32((reg->addr << 20) | reg->data);
 	info->curr_idx++;
@@ -662,30 +668,29 @@ rtw89_phy_cofig_rf_reg_store(struct rtw89_dev *rtwdev,
 static int rtw89_phy_config_rf_reg_fw(struct rtw89_dev *rtwdev,
 				      struct rtw89_fw_h2c_rf_reg_info *info)
 {
-	u16 page = info->curr_idx / RTW89_H2C_RF_PAGE_SIZE;
-	u16 len = (info->curr_idx % RTW89_H2C_RF_PAGE_SIZE) * 4;
+	u16 remain = info->curr_idx;
+	u16 len = 0;
 	u8 i;
 	int ret = 0;
 
-	if (page > RTW89_H2C_RF_PAGE_NUM) {
+	if (remain > RTW89_H2C_RF_PAGE_NUM * RTW89_H2C_RF_PAGE_SIZE) {
 		rtw89_warn(rtwdev,
-			   "rf reg h2c total page num %d larger than %d (RTW89_H2C_RF_PAGE_NUM)\n",
-			   page, RTW89_H2C_RF_PAGE_NUM);
-		return -EINVAL;
+			   "rf reg h2c total len %d larger than %d\n",
+			   remain, RTW89_H2C_RF_PAGE_NUM * RTW89_H2C_RF_PAGE_SIZE);
+		ret = -EINVAL;
+		goto out;
 	}
 
-	for (i = 0; i < page; i++) {
-		ret = rtw89_fw_h2c_rf_reg(rtwdev, info,
-					  RTW89_H2C_RF_PAGE_SIZE * 4, i);
+	for (i = 0; i < RTW89_H2C_RF_PAGE_NUM && remain; i++, remain -= len) {
+		len = remain > RTW89_H2C_RF_PAGE_SIZE ? RTW89_H2C_RF_PAGE_SIZE : remain;
+		ret = rtw89_fw_h2c_rf_reg(rtwdev, info, len * 4, i);
 		if (ret)
-			return ret;
+			goto out;
 	}
-	ret = rtw89_fw_h2c_rf_reg(rtwdev, info, len, i);
-	if (ret)
-		return ret;
+out:
 	info->curr_idx = 0;
 
-	return 0;
+	return ret;
 }
 
 static void rtw89_phy_config_rf_reg(struct rtw89_dev *rtwdev,
-- 
2.25.1

