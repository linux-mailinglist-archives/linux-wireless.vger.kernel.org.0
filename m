Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E2B5952CB
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 08:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiHPGnc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 02:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiHPGnF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 02:43:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62329F2D6B
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 18:33:14 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 27G1WsQG2011759, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 27G1WsQG2011759
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 16 Aug 2022 09:32:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 16 Aug 2022 09:33:06 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 16 Aug
 2022 09:33:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/3] wifi: rtw89: 8852c: declare correct BA CAM number
Date:   Tue, 16 Aug 2022 09:32:45 +0800
Message-ID: <20220816013247.6243-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816013247.6243-1-pkshih@realtek.com>
References: <20220816013247.6243-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 08/16/2022 01:16:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvMTUgpFWkyCAxMDo1MjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

8852A has 2 BA CAM entries, but 8852C has 8 entries. Add a field to
discriminate their differences.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 14 +++++++++-----
 drivers/net/wireless/realtek/rtw89/core.h     | 14 ++++++++------
 drivers/net/wireless/realtek/rtw89/fw.c       |  4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a5880a54812e7..07aa722164203 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2266,13 +2266,15 @@ void rtw89_core_release_all_bits_map(unsigned long *addr, unsigned int nbits)
 	bitmap_zero(addr, nbits);
 }
 
-int rtw89_core_acquire_sta_ba_entry(struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx)
+int rtw89_core_acquire_sta_ba_entry(struct rtw89_dev *rtwdev,
+				    struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_ba_cam_entry *entry;
 	u8 idx;
 
-	idx = rtw89_core_acquire_bit_map(rtwsta->ba_cam_map, RTW89_BA_CAM_NUM);
-	if (idx == RTW89_BA_CAM_NUM) {
+	idx = rtw89_core_acquire_bit_map(rtwsta->ba_cam_map, chip->bacam_num);
+	if (idx == chip->bacam_num) {
 		/* allocate a static BA CAM to tid=0, so replace the existing
 		 * one if BA CAM is full. Hardware will process the original tid
 		 * automatically.
@@ -2290,12 +2292,14 @@ int rtw89_core_acquire_sta_ba_entry(struct rtw89_sta *rtwsta, u8 tid, u8 *cam_id
 	return 0;
 }
 
-int rtw89_core_release_sta_ba_entry(struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx)
+int rtw89_core_release_sta_ba_entry(struct rtw89_dev *rtwdev,
+				    struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_ba_cam_entry *entry;
 	int i;
 
-	for (i = 0; i < RTW89_BA_CAM_NUM; i++) {
+	for (i = 0; i < chip->bacam_num; i++) {
 		if (!test_bit(i, rtwsta->ba_cam_map))
 			continue;
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7a9d6f5d8a513..38228dbe2a7dd 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1915,8 +1915,6 @@ struct rtw89_ra_report {
 
 DECLARE_EWMA(rssi, 10, 16);
 
-#define RTW89_BA_CAM_NUM 2
-
 struct rtw89_ba_cam_entry {
 	u8 tid;
 };
@@ -1924,6 +1922,7 @@ struct rtw89_ba_cam_entry {
 #define RTW89_MAX_ADDR_CAM_NUM		128
 #define RTW89_MAX_BSSID_CAM_NUM		20
 #define RTW89_MAX_SEC_CAM_NUM		128
+#define RTW89_MAX_BA_CAM_NUM		8
 #define RTW89_SEC_CAM_IN_ADDR_CAM	7
 
 struct rtw89_addr_cam_entry {
@@ -1988,8 +1987,8 @@ struct rtw89_sta {
 	bool cctl_tx_retry_limit;
 	u32 data_tx_cnt_lmt:6;
 
-	DECLARE_BITMAP(ba_cam_map, RTW89_BA_CAM_NUM);
-	struct rtw89_ba_cam_entry ba_cam_entry[RTW89_BA_CAM_NUM];
+	DECLARE_BITMAP(ba_cam_map, RTW89_MAX_BA_CAM_NUM);
+	struct rtw89_ba_cam_entry ba_cam_entry[RTW89_MAX_BA_CAM_NUM];
 };
 
 struct rtw89_efuse {
@@ -2393,6 +2392,7 @@ struct rtw89_chip_info {
 	u8 acam_num;
 	u8 bcam_num;
 	u8 scam_num;
+	u8 bacam_num;
 
 	u8 sec_ctrl_efuse_size;
 	u32 physical_efuse_size;
@@ -3910,8 +3910,10 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev);
 u8 rtw89_core_acquire_bit_map(unsigned long *addr, unsigned long size);
 void rtw89_core_release_bit_map(unsigned long *addr, u8 bit);
 void rtw89_core_release_all_bits_map(unsigned long *addr, unsigned int nbits);
-int rtw89_core_acquire_sta_ba_entry(struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx);
-int rtw89_core_release_sta_ba_entry(struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx);
+int rtw89_core_acquire_sta_ba_entry(struct rtw89_dev *rtwdev,
+				    struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx);
+int rtw89_core_release_sta_ba_entry(struct rtw89_dev *rtwdev,
+				    struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx);
 void rtw89_vif_type_mapping(struct ieee80211_vif *vif, bool assoc);
 int rtw89_chip_info_setup(struct rtw89_dev *rtwdev);
 bool rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate, u16 *bitrate);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 6473015a6b2a1..4d39cf9185378 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -644,8 +644,8 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 	int ret;
 
 	ret = valid ?
-	      rtw89_core_acquire_sta_ba_entry(rtwsta, params->tid, &entry_idx) :
-	      rtw89_core_release_sta_ba_entry(rtwsta, params->tid, &entry_idx);
+	      rtw89_core_acquire_sta_ba_entry(rtwdev, rtwsta, params->tid, &entry_idx) :
+	      rtw89_core_release_sta_ba_entry(rtwdev, rtwsta, params->tid, &entry_idx);
 	if (ret) {
 		/* it still works even if we don't have static BA CAM, because
 		 * hardware can create dynamic BA CAM automatically.
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 81bd0c4fe21bc..4a1f7b5e83f6c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2125,6 +2125,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.acam_num		= 128,
 	.bcam_num		= 10,
 	.scam_num		= 128,
+	.bacam_num		= 2,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
 	.logical_efuse_size	= 1536,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index b697aef2faf2d..a74b4c550ec1a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2972,6 +2972,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.acam_num		= 128,
 	.bcam_num		= 20,
 	.scam_num		= 128,
+	.bacam_num		= 8,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
 	.logical_efuse_size	= 2048,
-- 
2.25.1

