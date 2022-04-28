Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6701751295B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Apr 2022 04:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbiD1CJW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 22:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiD1CJU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 22:09:20 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD4D5D1A1
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 19:06:03 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23S25mtqE032426, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23S25mtqE032426
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Apr 2022 10:05:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 10:05:48 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 28 Apr
 2022 10:05:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <gary.chang@realtek.com>
Subject: [PATCH 1/3] rtw88: add HT MPDU density value for each chip
Date:   Thu, 28 Apr 2022 10:05:19 +0800
Message-ID: <20220428020521.8015-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/28/2022 01:50:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjggpFekyCAwMTowOTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chih-Kang Chang <gary.chang@realtek.com>

Each chip have best ampdu density value, the correct setting can improve
throughput performance.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c     | 3 ++-
 drivers/net/wireless/realtek/rtw88/main.h     | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
 6 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 7431988b59859..14289f83feb54 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1461,6 +1461,7 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 			    struct ieee80211_sta_ht_cap *ht_cap)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
 
 	ht_cap->ht_supported = true;
 	ht_cap->cap = 0;
@@ -1478,7 +1479,7 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 				IEEE80211_HT_CAP_DSSSCCK40 |
 				IEEE80211_HT_CAP_SGI_40;
 	ht_cap->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
-	ht_cap->ampdu_density = IEEE80211_HT_MPDU_DENSITY_16;
+	ht_cap->ampdu_density = chip->ampdu_density;
 	ht_cap->mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
 	if (efuse->hw_cap.nss > 1) {
 		ht_cap->mcs.rx_mask[0] = 0xFF;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 2743074a42560..de149a3b3ba1b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1179,6 +1179,7 @@ struct rtw_chip_info {
 	bool rx_ldpc;
 	bool tx_stbc;
 	u8 max_power_index;
+	u8 ampdu_density;
 
 	u16 fw_fifo_addr[RTW_FW_FIFO_MAX];
 	const struct rtw_fwcd_segs *fwcd_segs;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index ad2b323a0423c..93cce44df5318 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2747,6 +2747,7 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.rx_ldpc = false,
 	.pwr_track_tbl = &rtw8723d_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
+	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
 
 	.coex_para_ver = 0x2007022f,
 	.bt_desired_ver = 0x2f,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index ec38a7c849517..ffee39ea5df69 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1923,6 +1923,7 @@ struct rtw_chip_info rtw8821c_hw_spec = {
 	.iqk_threshold = 8,
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
+	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_2,
 
 	.coex_para_ver = 0x19092746,
 	.bt_desired_ver = 0x46,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index eee7bf0354030..dccd722b8e624 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2548,6 +2548,7 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 	.edcca_th = rtw8822b_edcca_th,
 	.l2h_th_ini_cs = 10 + EDCCA_IGI_BASE,
 	.l2h_th_ini_ad = -14 + EDCCA_IGI_BASE,
+	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_2,
 
 	.coex_para_ver = 0x20070206,
 	.bt_desired_ver = 0x6,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index cd74607a61a28..c043b5c520b9a 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5368,6 +5368,7 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.edcca_th = rtw8822c_edcca_th,
 	.l2h_th_ini_cs = 60,
 	.l2h_th_ini_ad = 45,
+	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_2,
 
 #ifdef CONFIG_PM
 	.wow_fw_name = "rtw88/rtw8822c_wow_fw.bin",
-- 
2.25.1

