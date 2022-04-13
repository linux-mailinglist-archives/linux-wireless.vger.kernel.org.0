Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8694B4FEC14
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Apr 2022 03:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiDMBLC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 21:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiDMBLB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 21:11:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAA525590
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 18:08:42 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23D18VBm8014614, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23D18VBm8014614
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Apr 2022 09:08:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Apr 2022 09:08:30 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 13 Apr
 2022 09:08:30 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 3/4] rtw89: configure security CAM for V1 chip
Date:   Wed, 13 Apr 2022 09:08:03 +0800
Message-ID: <20220413010804.8941-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413010804.8941-1-pkshih@realtek.com>
References: <20220413010804.8941-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/13/2022 00:46:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMTIgpFWkyCAxMDo1NzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

Add to configure security CAM while mac80211 calls set_key and del_key.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c      |  9 +++++++++
 drivers/net/wireless/realtek/rtw89/core.h     | 15 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 4 files changed, 26 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 08b9779163bb5..8a26adeb23fb2 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -244,6 +244,12 @@ static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 	addr_cam->sec_ent[key_idx] = sec_cam->sec_cam_idx;
 	addr_cam->sec_entries[key_idx] = sec_cam;
 	set_bit(key_idx, addr_cam->sec_cam_map);
+	ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif, rtwsta);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to update dctl cam sec entry: %d\n",
+			  ret);
+		return ret;
+	}
 	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to update addr cam sec entry: %d\n",
@@ -398,6 +404,9 @@ int rtw89_cam_sec_key_del(struct rtw89_dev *rtwdev,
 	clear_bit(key_idx, addr_cam->sec_cam_map);
 	addr_cam->sec_entries[key_idx] = NULL;
 	if (inform_fw) {
+		ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif, rtwsta);
+		if (ret)
+			rtw89_err(rtwdev, "failed to update dctl cam del key: %d\n", ret);
 		ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
 		if (ret)
 			rtw89_err(rtwdev, "failed to update cam del key: %d\n", ret);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2715dc1ff73ff..090d416569010 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2106,6 +2106,9 @@ struct rtw89_chip_ops {
 	int (*stop_sch_tx)(struct rtw89_dev *rtwdev, u8 mac_idx,
 			   u32 *tx_en, enum rtw89_sch_tx_sel sel);
 	int (*resume_sch_tx)(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en);
+	int (*h2c_dctl_sec_cam)(struct rtw89_dev *rtwdev,
+				struct rtw89_vif *rtwvif,
+				struct rtw89_sta *rtwsta);
 
 	void (*btc_set_rfe)(struct rtw89_dev *rtwdev);
 	void (*btc_init_cfg)(struct rtw89_dev *rtwdev);
@@ -3634,6 +3637,18 @@ int rtw89_chip_resume_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en)
 	return chip->ops->resume_sch_tx(rtwdev, mac_idx, tx_en);
 }
 
+static inline
+int rtw89_chip_h2c_dctl_sec_cam(struct rtw89_dev *rtwdev,
+				struct rtw89_vif *rtwvif,
+				struct rtw89_sta *rtwsta)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (!chip->ops->h2c_dctl_sec_cam)
+		return 0;
+	return chip->ops->h2c_dctl_sec_cam(rtwdev, rtwvif, rtwsta);
+}
+
 static inline u8 *get_hdr_bssid(struct ieee80211_hdr *hdr)
 {
 	__le16 fc = hdr->frame_control;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 6371bbf7a2fd5..975c504953049 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2075,6 +2075,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt,
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
+	.h2c_dctl_sec_cam	= NULL,
 
 	.btc_set_rfe		= rtw8852a_btc_set_rfe,
 	.btc_init_cfg		= rtw8852a_btc_init_cfg,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index d900129c1a7c8..d56d65661ce08 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -645,6 +645,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt_v1,
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx_v1,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx_v1,
+	.h2c_dctl_sec_cam	= rtw89_fw_h2c_dctl_sec_cam_v1,
 
 	.btc_init_cfg		= rtw8852c_btc_init_cfg,
 };
-- 
2.25.1

