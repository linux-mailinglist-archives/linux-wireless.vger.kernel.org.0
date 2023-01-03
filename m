Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3BD65C16C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 15:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbjACODm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 09:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237729AbjACODX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 09:03:23 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE7C9101DF
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 06:03:19 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 303E2G5d8016843, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 303E2G5d8016843
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 3 Jan 2023 22:02:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 3 Jan 2023 22:03:11 +0800
Received: from localhost (172.16.19.22) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 3 Jan 2023
 22:03:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/7] wifi: rtw89: coex: Update WiFi role info H2C report
Date:   Tue, 3 Jan 2023 22:02:38 +0800
Message-ID: <20230103140238.15601-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230103140238.15601-1-pkshih@realtek.com>
References: <20230103140238.15601-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.19.22]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/03/2023 13:50:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMyCkVaTIIDAxOjA0OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Change style to feature version separate. And because there are
different WiFi roles number in the firmware, it will make structure
length longer or shorter, so update the length calculator to cover
the difference.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c |  7 +++--
 drivers/net/wireless/realtek/rtw89/fw.c   | 36 +++++++++++++++--------
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 21d1011d50c9d..f97ddbcb51046 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1772,16 +1772,17 @@ static void _fw_set_policy(struct rtw89_dev *rtwdev, u16 policy_type,
 
 static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 type)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 
 	switch (type) {
 	case CXDRVINFO_INIT:
 		rtw89_fw_h2c_cxdrv_init(rtwdev);
 		break;
 	case CXDRVINFO_ROLE:
-		if (chip->chip_id == RTL8852A)
+		if (ver->fwlrole == 0)
 			rtw89_fw_h2c_cxdrv_role(rtwdev);
-		else
+		else if (ver->fwlrole == 1)
 			rtw89_fw_h2c_cxdrv_role_v1(rtwdev);
 		break;
 	case CXDRVINFO_CTRL:
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0328874a0d10e..19a49ef243fa4 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1818,33 +1818,36 @@ int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev)
 
 #define PORT_DATA_OFFSET 4
 #define H2C_LEN_CXDRVINFO_ROLE_DBCC_LEN 12
-#define H2C_LEN_CXDRVINFO_ROLE (4 + 12 * RTW89_PORT_NUM + H2C_LEN_CXDRVHDR)
-#define H2C_LEN_CXDRVINFO_ROLE_V1 (4 + 16 * RTW89_PORT_NUM + \
-				   H2C_LEN_CXDRVINFO_ROLE_DBCC_LEN + \
-				   H2C_LEN_CXDRVHDR)
+#define H2C_LEN_CXDRVINFO_ROLE_SIZE(max_role_num) \
+	(4 + 12 * (max_role_num) + H2C_LEN_CXDRVHDR)
+
 int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_role_info *role_info = &wl->role_info;
 	struct rtw89_btc_wl_role_info_bpos *bpos = &role_info->role_map.role;
 	struct rtw89_btc_wl_active_role *active = role_info->active_role;
 	struct sk_buff *skb;
+	u32 len;
 	u8 offset = 0;
 	u8 *cmd;
 	int ret;
 	int i;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LEN_CXDRVINFO_ROLE);
+	len = H2C_LEN_CXDRVINFO_ROLE_SIZE(ver->max_role_num);
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_role\n");
 		return -ENOMEM;
 	}
-	skb_put(skb, H2C_LEN_CXDRVINFO_ROLE);
+	skb_put(skb, len);
 	cmd = skb->data;
 
 	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, CXDRVINFO_ROLE);
-	RTW89_SET_FWCMD_CXHDR_LEN(cmd, H2C_LEN_CXDRVINFO_ROLE - H2C_LEN_CXDRVHDR);
+	RTW89_SET_FWCMD_CXHDR_LEN(cmd, len - H2C_LEN_CXDRVHDR);
 
 	RTW89_SET_FWCMD_CXROLE_CONNECT_CNT(cmd, role_info->connect_cnt);
 	RTW89_SET_FWCMD_CXROLE_LINK_MODE(cmd, role_info->link_mode);
@@ -1881,7 +1884,7 @@ int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev)
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, BTFC_SET,
 			      SET_DRV_INFO, 0, 0,
-			      H2C_LEN_CXDRVINFO_ROLE);
+			      len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
@@ -1896,28 +1899,35 @@ int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
+#define H2C_LEN_CXDRVINFO_ROLE_SIZE_V1(max_role_num) \
+	(4 + 16 * (max_role_num) + H2C_LEN_CXDRVINFO_ROLE_DBCC_LEN + H2C_LEN_CXDRVHDR)
+
 int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_role_info_v1 *role_info = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_bpos *bpos = &role_info->role_map.role;
 	struct rtw89_btc_wl_active_role_v1 *active = role_info->active_role_v1;
 	struct sk_buff *skb;
+	u32 len;
 	u8 *cmd, offset;
 	int ret;
 	int i;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LEN_CXDRVINFO_ROLE_V1);
+	len = H2C_LEN_CXDRVINFO_ROLE_SIZE_V1(ver->max_role_num);
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_role\n");
 		return -ENOMEM;
 	}
-	skb_put(skb, H2C_LEN_CXDRVINFO_ROLE_V1);
+	skb_put(skb, len);
 	cmd = skb->data;
 
 	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, CXDRVINFO_ROLE);
-	RTW89_SET_FWCMD_CXHDR_LEN(cmd, H2C_LEN_CXDRVINFO_ROLE_V1 - H2C_LEN_CXDRVHDR);
+	RTW89_SET_FWCMD_CXHDR_LEN(cmd, len - H2C_LEN_CXDRVHDR);
 
 	RTW89_SET_FWCMD_CXROLE_CONNECT_CNT(cmd, role_info->connect_cnt);
 	RTW89_SET_FWCMD_CXROLE_LINK_MODE(cmd, role_info->link_mode);
@@ -1953,7 +1963,7 @@ int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev)
 		RTW89_SET_FWCMD_CXROLE_ACT_NOA_DUR(cmd, active->noa_duration, i, offset);
 	}
 
-	offset = H2C_LEN_CXDRVINFO_ROLE_V1 - H2C_LEN_CXDRVINFO_ROLE_DBCC_LEN;
+	offset = len - H2C_LEN_CXDRVINFO_ROLE_DBCC_LEN;
 	RTW89_SET_FWCMD_CXROLE_MROLE_TYPE(cmd, role_info->mrole_type, offset);
 	RTW89_SET_FWCMD_CXROLE_MROLE_NOA(cmd, role_info->mrole_noa_duration, offset);
 	RTW89_SET_FWCMD_CXROLE_DBCC_EN(cmd, role_info->dbcc_en, offset);
@@ -1964,7 +1974,7 @@ int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev)
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, BTFC_SET,
 			      SET_DRV_INFO, 0, 0,
-			      H2C_LEN_CXDRVINFO_ROLE_V1);
+			      len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
-- 
2.25.1

