Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6394AB57E
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 08:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiBGHDk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 02:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357057AbiBGGnK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 01:43:10 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC77C043181
        for <linux-wireless@vger.kernel.org>; Sun,  6 Feb 2022 22:43:08 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2176dQMX1024318, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2176dQMX1024318
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Feb 2022 14:39:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Feb 2022 14:39:26 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 7 Feb
 2022 14:39:25 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/7] rtw89: extend role_maintain to support AP mode
Date:   Mon, 7 Feb 2022 14:38:54 +0800
Message-ID: <20220207063900.43643-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207063900.43643-1-pkshih@realtek.com>
References: <20220207063900.43643-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/07/2022 06:18:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvNyCkV6TIIDAzOjUyOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

Fill mac_id and self_role depends on the operation mode.

In AP mode, echo connected station has an unique mac_id, and each vif also
has one mac_id to represent itself.

The self_role is assigned to vif if the operation mode is decided, and
RTW89_SELF_ROLE_AP_CLIENT is assigned to the connected STA in AP mode,

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 16 ++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h  |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c |  4 ++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2d5b6323b607d..7fa60fd00143a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -993,9 +993,21 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 #define H2C_ROLE_MAINTAIN_LEN 4
 int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif *rtwvif,
+			       struct rtw89_sta *rtwsta,
 			       enum rtw89_upd_mode upd_mode)
 {
 	struct sk_buff *skb;
+	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
+	u8 self_role;
+
+	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE) {
+		if (rtwsta)
+			self_role = RTW89_SELF_ROLE_AP_CLIENT;
+		else
+			self_role = rtwvif->self_role;
+	} else {
+		self_role = rtwvif->self_role;
+	}
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_ROLE_MAINTAIN_LEN);
 	if (!skb) {
@@ -1003,8 +1015,8 @@ int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 		return -ENOMEM;
 	}
 	skb_put(skb, H2C_ROLE_MAINTAIN_LEN);
-	SET_FWROLE_MAINTAIN_MACID(skb->data, rtwvif->mac_id);
-	SET_FWROLE_MAINTAIN_SELF_ROLE(skb->data, rtwvif->self_role);
+	SET_FWROLE_MAINTAIN_MACID(skb->data, mac_id);
+	SET_FWROLE_MAINTAIN_SELF_ROLE(skb->data, self_role);
 	SET_FWROLE_MAINTAIN_UPD_MODE(skb->data, upd_mode);
 	SET_FWROLE_MAINTAIN_WIFI_ROLE(skb->data, rtwvif->wifi_role);
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index b30cf0a2cc1e0..83f4eaaf90f3b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1886,6 +1886,7 @@ void rtw89_fw_c2h_irqsafe(struct rtw89_dev *rtwdev, struct sk_buff *c2h);
 void rtw89_fw_c2h_work(struct work_struct *work);
 int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif *rtwvif,
+			       struct rtw89_sta *rtwsta,
 			       enum rtw89_upd_mode upd_mode);
 int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			   struct rtw89_sta *rtwsta, bool dis_conn);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 2e95d9007c41d..2ced6a8b36c2d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3025,7 +3025,7 @@ int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	if (ret)
 		return ret;
 
-	ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, RTW89_ROLE_CREATE);
+	ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, NULL, RTW89_ROLE_CREATE);
 	if (ret)
 		return ret;
 
@@ -3048,7 +3048,7 @@ int rtw89_mac_vif_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	int ret;
 
-	ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, RTW89_ROLE_REMOVE);
+	ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, NULL, RTW89_ROLE_REMOVE);
 	if (ret)
 		return ret;
 
-- 
2.25.1

