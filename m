Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C74A5AB2DC
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbiIBOEp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbiIBOEG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:04:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 350D3AF0EB
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 06:33:02 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 282CiVIs9014095, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 282CiVIs9014095
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 2 Sep 2022 20:44:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Sep 2022 20:44:48 +0800
Received: from localhost (172.16.17.75) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 2 Sep 2022
 20:44:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/5] wifi: rtw89: configure TX path via H2C command
Date:   Fri, 2 Sep 2022 20:44:20 +0800
Message-ID: <20220902124422.13610-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902124422.13610-1-pkshih@realtek.com>
References: <20220902124422.13610-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.75]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/02/2022 12:31:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMiCkV6TIIDA3OjQ1OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to support TX diversity, add a function to control TX path.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 60 +++++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/fw.h |  2 +
 2 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 8e4d0e18fa715..91d2c40d9ea2a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -912,15 +912,26 @@ int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 	return -EBUSY;
 }
 
+static void __rtw89_fw_h2c_set_tx_path(struct rtw89_dev *rtwdev,
+				       struct sk_buff *skb)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 ntx_path = hal->antenna_tx ? hal->antenna_tx : RF_B;
+	u8 map_b = hal->antenna_tx == RF_AB ? 1 : 0;
+
+	SET_CMC_TBL_NTX_PATH_EN(skb->data, ntx_path);
+	SET_CMC_TBL_PATH_MAP_A(skb->data, 0);
+	SET_CMC_TBL_PATH_MAP_B(skb->data, map_b);
+	SET_CMC_TBL_PATH_MAP_C(skb->data, 0);
+	SET_CMC_TBL_PATH_MAP_D(skb->data, 0);
+}
+
 #define H2C_CMC_TBL_LEN 68
 int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif *rtwvif)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_hal *hal = &rtwdev->hal;
 	struct sk_buff *skb;
-	u8 ntx_path = hal->antenna_tx ? hal->antenna_tx : RF_B;
-	u8 map_b = hal->antenna_tx == RF_AB ? 1 : 0;
 	u8 macid = rtwvif->mac_id;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_CMC_TBL_LEN);
@@ -933,11 +944,7 @@ int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 	SET_CTRL_INFO_OPERATION(skb->data, 1);
 	if (chip->h2c_cctl_func_id == H2C_FUNC_MAC_CCTLINFO_UD) {
 		SET_CMC_TBL_TXPWR_MODE(skb->data, 0);
-		SET_CMC_TBL_NTX_PATH_EN(skb->data, ntx_path);
-		SET_CMC_TBL_PATH_MAP_A(skb->data, 0);
-		SET_CMC_TBL_PATH_MAP_B(skb->data, map_b);
-		SET_CMC_TBL_PATH_MAP_C(skb->data, 0);
-		SET_CMC_TBL_PATH_MAP_D(skb->data, 0);
+		__rtw89_fw_h2c_set_tx_path(rtwdev, skb);
 		SET_CMC_TBL_ANTSEL_A(skb->data, 0);
 		SET_CMC_TBL_ANTSEL_B(skb->data, 0);
 		SET_CMC_TBL_ANTSEL_C(skb->data, 0);
@@ -1133,6 +1140,43 @@ int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 	return -EBUSY;
 }
 
+int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
+				 struct rtw89_sta *rtwsta)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct sk_buff *skb;
+
+	if (chip->h2c_cctl_func_id != H2C_FUNC_MAC_CCTLINFO_UD)
+		return 0;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_CMC_TBL_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_CMC_TBL_LEN);
+	SET_CTRL_INFO_MACID(skb->data, rtwsta->mac_id);
+	SET_CTRL_INFO_OPERATION(skb->data, 1);
+
+	__rtw89_fw_h2c_set_tx_path(rtwdev, skb);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
+			      H2C_FUNC_MAC_CCTLINFO_UD, 0, 1,
+			      H2C_CMC_TBL_LEN);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
 #define H2C_BCN_BASE_LEN 12
 int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif *rtwvif)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index de70d012cd9bc..2746aacceee79 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2633,6 +2633,8 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 				struct ieee80211_sta *sta);
 int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta *rtwsta);
+int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
+				 struct rtw89_sta *rtwsta);
 int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif *rtwvif);
 int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *vif,
-- 
2.25.1

