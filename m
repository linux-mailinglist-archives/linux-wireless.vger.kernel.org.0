Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150A64AB57B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 08:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbiBGHDe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 02:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357045AbiBGGnF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 01:43:05 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB9AC043181
        for <linux-wireless@vger.kernel.org>; Sun,  6 Feb 2022 22:43:03 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2176e3lwD024606, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2176e3lwD024606
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Feb 2022 14:40:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Feb 2022 14:40:03 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 7 Feb
 2022 14:40:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/7] rtw89: only STA mode change vif_type mapping dynamically
Date:   Mon, 7 Feb 2022 14:38:56 +0800
Message-ID: <20220207063900.43643-4-pkshih@realtek.com>
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

vif_type mapping indicates hardware operating mode corresponding to vif
type. In STA mode, hardware mode should be INFRA or NO_LINK mode
dynamically according to association status. Since AP mode don't need to
change this by association status intuitively, just do the mapping in
STA mode.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 4 ++--
 drivers/net/wireless/realtek/rtw89/mac80211.c | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 81575463a833f..8849f3172a341 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2047,7 +2047,8 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 	rtw89_mac_bf_disassoc(rtwdev, vif, sta);
 	rtw89_core_free_sta_pending_ba(rtwdev, sta);
 
-	rtw89_vif_type_mapping(vif, false);
+	if (vif->type == NL80211_IFTYPE_STATION)
+		rtw89_vif_type_mapping(vif, false);
 
 	ret = rtw89_fw_h2c_assoc_cmac_tbl(rtwdev, vif, sta);
 	if (ret) {
@@ -2079,7 +2080,6 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	int ret;
 
-	rtw89_vif_type_mapping(vif, true);
 
 	ret = rtw89_fw_h2c_assoc_cmac_tbl(rtwdev, vif, sta);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 02480a6bdf4c0..295d54c0fc94a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -324,6 +324,9 @@ static void rtw89_station_mode_sta_assoc(struct rtw89_dev *rtwdev,
 		rtw89_err(rtwdev, "can't find sta to set sta_assoc state\n");
 		return;
 	}
+
+	rtw89_vif_type_mapping(vif, true);
+
 	rtw89_core_sta_assoc(rtwdev, vif, sta);
 }
 
-- 
2.25.1

