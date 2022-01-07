Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB5648715B
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 04:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345892AbiAGDnQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 22:43:16 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51078 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345888AbiAGDnP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 22:43:15 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2073hAiQ5022953, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2073hAiQ5022953
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Jan 2022 11:43:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 7 Jan 2022 11:43:10 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 11:43:10 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 08/19] rtw89: rename vif_maintain to role_maintain
Date:   Fri, 7 Jan 2022 11:42:28 +0800
Message-ID: <20220107034239.22002-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107034239.22002-1-pkshih@realtek.com>
References: <20220107034239.22002-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/07/2022 03:26:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvNyCkV6TIIDAxOjMzOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The H2C_FUNC_MAC_FWROLE_MAINTAIN also maintains the roles of all connected
stations; not just the role of VIF. So, I correct the name, but don't
change the logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 10 +++++-----
 drivers/net/wireless/realtek/rtw89/fw.c   | 14 +++++++-------
 drivers/net/wireless/realtek/rtw89/fw.h   |  6 +++---
 drivers/net/wireless/realtek/rtw89/mac.c  |  4 ++--
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 542afe2133b0f..ae8943d4fb43d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -140,11 +140,11 @@ enum rtw89_wifi_role {
 };
 
 enum rtw89_upd_mode {
-	RTW89_VIF_CREATE,
-	RTW89_VIF_REMOVE,
-	RTW89_VIF_TYPE_CHANGE,
-	RTW89_VIF_INFO_CHANGE,
-	RTW89_VIF_CON_DISCONN
+	RTW89_ROLE_CREATE,
+	RTW89_ROLE_REMOVE,
+	RTW89_ROLE_TYPE_CHANGE,
+	RTW89_ROLE_INFO_CHANGE,
+	RTW89_ROLE_CON_DISCONN
 };
 
 enum rtw89_self_role {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index e9f27382d2ba8..5209813275676 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -990,19 +990,19 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-#define H2C_VIF_MAINTAIN_LEN 4
-int rtw89_fw_h2c_vif_maintain(struct rtw89_dev *rtwdev,
-			      struct rtw89_vif *rtwvif,
-			      enum rtw89_upd_mode upd_mode)
+#define H2C_ROLE_MAINTAIN_LEN 4
+int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
+			       struct rtw89_vif *rtwvif,
+			       enum rtw89_upd_mode upd_mode)
 {
 	struct sk_buff *skb;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_VIF_MAINTAIN_LEN);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_ROLE_MAINTAIN_LEN);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c join\n");
 		return -ENOMEM;
 	}
-	skb_put(skb, H2C_VIF_MAINTAIN_LEN);
+	skb_put(skb, H2C_ROLE_MAINTAIN_LEN);
 	SET_FWROLE_MAINTAIN_MACID(skb->data, rtwvif->mac_id);
 	SET_FWROLE_MAINTAIN_SELF_ROLE(skb->data, rtwvif->self_role);
 	SET_FWROLE_MAINTAIN_UPD_MODE(skb->data, upd_mode);
@@ -1011,7 +1011,7 @@ int rtw89_fw_h2c_vif_maintain(struct rtw89_dev *rtwdev,
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_MEDIA_RPT,
 			      H2C_FUNC_MAC_FWROLE_MAINTAIN, 0, 1,
-			      H2C_VIF_MAINTAIN_LEN);
+			      H2C_ROLE_MAINTAIN_LEN);
 
 	if (rtw89_h2c_tx(rtwdev, skb, false)) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 55f11e7886d52..b30cf0a2cc1e0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1884,9 +1884,9 @@ int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *vif,
 		     struct rtw89_sta *rtwsta, const u8 *scan_mac_addr);
 void rtw89_fw_c2h_irqsafe(struct rtw89_dev *rtwdev, struct sk_buff *c2h);
 void rtw89_fw_c2h_work(struct work_struct *work);
-int rtw89_fw_h2c_vif_maintain(struct rtw89_dev *rtwdev,
-			      struct rtw89_vif *rtwvif,
-			      enum rtw89_upd_mode upd_mode);
+int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
+			       struct rtw89_vif *rtwvif,
+			       enum rtw89_upd_mode upd_mode);
 int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			   struct rtw89_sta *rtwsta, bool dis_conn);
 int rtw89_fw_h2c_macid_pause(struct rtw89_dev *rtwdev, u8 sh, u8 grp,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 58f47b46c2f95..a0ff3d8a3f61b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2982,7 +2982,7 @@ int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	if (ret)
 		return ret;
 
-	ret = rtw89_fw_h2c_vif_maintain(rtwdev, rtwvif, RTW89_VIF_CREATE);
+	ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, RTW89_ROLE_CREATE);
 	if (ret)
 		return ret;
 
@@ -3005,7 +3005,7 @@ int rtw89_mac_vif_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	int ret;
 
-	ret = rtw89_fw_h2c_vif_maintain(rtwdev, rtwvif, RTW89_VIF_REMOVE);
+	ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, RTW89_ROLE_REMOVE);
 	if (ret)
 		return ret;
 
-- 
2.25.1

