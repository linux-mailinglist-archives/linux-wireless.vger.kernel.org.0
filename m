Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8AA48715F
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 04:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345905AbiAGDnX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 22:43:23 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51099 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345895AbiAGDnW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 22:43:22 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2073hHpmD022989, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2073hHpmD022989
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Jan 2022 11:43:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 11:43:17 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 11:43:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 12/19] rtw89: separate {init,deinit}_addr_cam functions
Date:   Fri, 7 Jan 2022 11:42:32 +0800
Message-ID: <20220107034239.22002-13-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Each stations connected to AP needs to set an address CAM, so don't combine
address and BSSID CAM.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c  | 34 ++++++++++++++---------
 drivers/net/wireless/realtek/rtw89/cam.h  |  5 ++++
 drivers/net/wireless/realtek/rtw89/core.h |  1 -
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index bd34e4bbe107b..2114d117b603d 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -427,15 +427,23 @@ static void rtw89_cam_reset_key_iter(struct ieee80211_hw *hw,
 	rtw89_cam_deinit(rtwdev, rtwvif);
 }
 
+void rtw89_cam_deinit_addr_cam(struct rtw89_dev *rtwdev,
+			       struct rtw89_addr_cam_entry *addr_cam)
+{
+	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
+
+	addr_cam->valid = false;
+	clear_bit(addr_cam->addr_cam_idx, cam_info->addr_cam_map);
+}
+
 void rtw89_cam_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
 	struct rtw89_addr_cam_entry *addr_cam = &rtwvif->addr_cam;
 	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
 
-	addr_cam->valid = false;
+	rtw89_cam_deinit_addr_cam(rtwdev, addr_cam);
 	bssid_cam->valid = false;
-	clear_bit(addr_cam->addr_cam_idx, cam_info->addr_cam_map);
 	clear_bit(bssid_cam->bssid_cam_idx, cam_info->bssid_cam_map);
 }
 
@@ -464,10 +472,10 @@ static int rtw89_cam_get_avail_addr_cam(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-static int rtw89_cam_init_addr_cam(struct rtw89_dev *rtwdev,
-				   struct rtw89_vif *rtwvif)
+int rtw89_cam_init_addr_cam(struct rtw89_dev *rtwdev,
+			    struct rtw89_addr_cam_entry *addr_cam,
+			    const struct rtw89_bssid_cam_entry *bssid_cam)
 {
-	struct rtw89_addr_cam_entry *addr_cam = &rtwvif->addr_cam;
 	u8 addr_cam_idx;
 	int i;
 	int ret;
@@ -484,14 +492,17 @@ static int rtw89_cam_init_addr_cam(struct rtw89_dev *rtwdev,
 	addr_cam->valid = true;
 	addr_cam->addr_mask = 0;
 	addr_cam->mask_sel = RTW89_NO_MSK;
+	addr_cam->sec_ent_mode = RTW89_ADDR_CAM_SEC_NORMAL;
 	bitmap_zero(addr_cam->sec_cam_map, RTW89_SEC_CAM_IN_ADDR_CAM);
-	ether_addr_copy(addr_cam->sma, rtwvif->mac_addr);
 
 	for (i = 0; i < RTW89_SEC_CAM_IN_ADDR_CAM; i++) {
 		addr_cam->sec_ent_keyid[i] = 0;
 		addr_cam->sec_ent[i] = 0;
 	}
 
+	/* associate addr cam with bssid cam */
+	addr_cam->bssid_cam_idx = bssid_cam->bssid_cam_idx;
+
 	return 0;
 }
 
@@ -549,21 +560,18 @@ int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
 	int ret;
 
-	ret = rtw89_cam_init_addr_cam(rtwdev, rtwvif);
+	ret = rtw89_cam_init_bssid_cam(rtwdev, rtwvif);
 	if (ret) {
-		rtw89_err(rtwdev, "failed to init addr cam\n");
+		rtw89_err(rtwdev, "failed to init bssid cam\n");
 		return ret;
 	}
 
-	ret = rtw89_cam_init_bssid_cam(rtwdev, rtwvif);
+	ret = rtw89_cam_init_addr_cam(rtwdev, addr_cam, bssid_cam);
 	if (ret) {
-		rtw89_err(rtwdev, "failed to init bssid cam\n");
+		rtw89_err(rtwdev, "failed to init addr cam\n");
 		return ret;
 	}
 
-	/* associate addr cam with bssid cam */
-	addr_cam->bssid_cam_idx = bssid_cam->bssid_cam_idx;
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index 33a3ad582b818..3a6a786530d17 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -346,6 +346,11 @@ static inline void FWCMD_SET_ADDR_BSSID_BSSID5(void *cmd, u32 value)
 
 int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 void rtw89_cam_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
+int rtw89_cam_init_addr_cam(struct rtw89_dev *rtwdev,
+			    struct rtw89_addr_cam_entry *addr_cam,
+			    const struct rtw89_bssid_cam_entry *bssid_cam);
+void rtw89_cam_deinit_addr_cam(struct rtw89_dev *rtwdev,
+			       struct rtw89_addr_cam_entry *addr_cam);
 void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif *vif,
 				  struct rtw89_sta *rtwsta,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8cb907da6cb05..2dd5c4f0a3636 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1884,7 +1884,6 @@ struct rtw89_addr_cam_entry {
 	u8 wapi		: 1;
 	u8 mask_sel	: 2;
 	u8 bssid_cam_idx: 6;
-	u8 sma[ETH_ALEN];
 
 	u8 sec_ent_mode;
 	DECLARE_BITMAP(sec_cam_map, RTW89_SEC_CAM_IN_ADDR_CAM);
-- 
2.25.1

