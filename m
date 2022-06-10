Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE01545D55
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 09:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244158AbiFJH1Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 03:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346802AbiFJH0x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 03:26:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD75D571A
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 00:26:50 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25A7QjyhE010126, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25A7QjyhE010126
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jun 2022 15:26:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 15:26:45 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 10 Jun
 2022 15:26:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <damon.chen@realtek.com>,
        <phhuang@realtek.com>
Subject: [PATCH 02/11] rtw89: separate BSSID CAM operations
Date:   Fri, 10 Jun 2022 15:26:01 +0800
Message-ID: <20220610072610.27095-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610072610.27095-1-pkshih@realtek.com>
References: <20220610072610.27095-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 06/10/2022 07:06:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMTAgpFekyCAwNjowMDowMA==?=
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

Normally, we allocate a BSSID CAM to a vif. By hardware design, we must
allocate a BSSID CAM to each TDLS peer, so separate BSSID CAM operations
that will be used by later patches.

This patch doesn't change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c | 24 ++++++++++++++++--------
 drivers/net/wireless/realtek/rtw89/cam.h |  6 ++++++
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index db3c55f0ccd0d..d82a77c74b1b1 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -445,15 +445,22 @@ void rtw89_cam_deinit_addr_cam(struct rtw89_dev *rtwdev,
 	clear_bit(addr_cam->addr_cam_idx, cam_info->addr_cam_map);
 }
 
-void rtw89_cam_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+void rtw89_cam_deinit_bssid_cam(struct rtw89_dev *rtwdev,
+				struct rtw89_bssid_cam_entry *bssid_cam)
 {
 	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
+
+	bssid_cam->valid = false;
+	clear_bit(bssid_cam->bssid_cam_idx, cam_info->bssid_cam_map);
+}
+
+void rtw89_cam_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
 	struct rtw89_addr_cam_entry *addr_cam = &rtwvif->addr_cam;
 	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
 
 	rtw89_cam_deinit_addr_cam(rtwdev, addr_cam);
-	bssid_cam->valid = false;
-	clear_bit(bssid_cam->bssid_cam_idx, cam_info->bssid_cam_map);
+	rtw89_cam_deinit_bssid_cam(rtwdev, bssid_cam);
 }
 
 void rtw89_cam_reset_keys(struct rtw89_dev *rtwdev)
@@ -539,10 +546,11 @@ static int rtw89_cam_get_avail_bssid_cam(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-static int rtw89_cam_init_bssid_cam(struct rtw89_dev *rtwdev,
-				    struct rtw89_vif *rtwvif)
+int rtw89_cam_init_bssid_cam(struct rtw89_dev *rtwdev,
+			     struct rtw89_vif *rtwvif,
+			     struct rtw89_bssid_cam_entry *bssid_cam,
+			     const u8 *bssid)
 {
-	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
 	u8 bssid_cam_idx;
 	int ret;
 
@@ -563,7 +571,7 @@ static int rtw89_cam_init_bssid_cam(struct rtw89_dev *rtwdev,
 	bssid_cam->len = BSSID_CAM_ENT_SIZE;
 	bssid_cam->offset = 0;
 	bssid_cam->valid = true;
-	ether_addr_copy(bssid_cam->bssid, rtwvif->bssid);
+	ether_addr_copy(bssid_cam->bssid, bssid);
 
 	return 0;
 }
@@ -581,7 +589,7 @@ int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
 	int ret;
 
-	ret = rtw89_cam_init_bssid_cam(rtwdev, rtwvif);
+	ret = rtw89_cam_init_bssid_cam(rtwdev, rtwvif, bssid_cam, rtwvif->bssid);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to init bssid cam\n");
 		return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index 74a6c4748d64f..affc50d680d1e 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -359,6 +359,12 @@ int rtw89_cam_init_addr_cam(struct rtw89_dev *rtwdev,
 			    const struct rtw89_bssid_cam_entry *bssid_cam);
 void rtw89_cam_deinit_addr_cam(struct rtw89_dev *rtwdev,
 			       struct rtw89_addr_cam_entry *addr_cam);
+int rtw89_cam_init_bssid_cam(struct rtw89_dev *rtwdev,
+			     struct rtw89_vif *rtwvif,
+			     struct rtw89_bssid_cam_entry *bssid_cam,
+			     const u8 *bssid);
+void rtw89_cam_deinit_bssid_cam(struct rtw89_dev *rtwdev,
+				struct rtw89_bssid_cam_entry *bssid_cam);
 void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif *vif,
 				  struct rtw89_sta *rtwsta,
-- 
2.25.1

