Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960FE57317A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 10:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbiGMIse (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 04:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbiGMIs0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 04:48:26 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E429ECB88
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 01:48:24 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 26D8mFefD018985, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 26D8mFefD018985
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 13 Jul 2022 16:48:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 13 Jul 2022 16:48:17 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Wed, 13 Jul
 2022 16:48:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/7] wifi: rtw88: add mutex when set regulatory and get Tx power table
Date:   Wed, 13 Jul 2022 16:47:53 +0800
Message-ID: <20220713084758.41654-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713084758.41654-1-pkshih@realtek.com>
References: <20220713084758.41654-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 07/13/2022 08:26:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzcvMTMgpFekyCAwNjo1NDowMA==?=
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

From: Chih-Kang Chang <gary.chang@realtek.com>

Applying regulatory and getting Tx power table will access hal
data, it should hold rtwdev::mutex to avoid hal data changed during
setting flow.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c | 11 +++++++----
 drivers/net/wireless/realtek/rtw88/regd.c  |  2 ++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 7cde6bcf253b4..9ebe544e51d0d 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -621,11 +621,13 @@ static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 	struct rtw_debugfs_priv *debugfs_priv = m->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw_hal *hal = &rtwdev->hal;
-	u8 path, rate;
+	u8 path, rate, bw, ch, regd;
 	struct rtw_power_params pwr_param = {0};
-	u8 bw = hal->current_band_width;
-	u8 ch = hal->current_channel;
-	u8 regd = rtw_regd_get(rtwdev);
+
+	mutex_lock(&rtwdev->mutex);
+	bw = hal->current_band_width;
+	ch = hal->current_channel;
+	regd = rtw_regd_get(rtwdev);
 
 	seq_printf(m, "channel: %u\n", ch);
 	seq_printf(m, "bandwidth: %u\n", bw);
@@ -667,6 +669,7 @@ static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 	}
 
 	mutex_unlock(&hal->tx_power_mutex);
+	mutex_unlock(&rtwdev->mutex);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw88/regd.c b/drivers/net/wireless/realtek/rtw88/regd.c
index 315c2b193e92c..2f547cbcf6da5 100644
--- a/drivers/net/wireless/realtek/rtw88/regd.c
+++ b/drivers/net/wireless/realtek/rtw88/regd.c
@@ -479,6 +479,7 @@ void rtw_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	rtw_dbg(rtwdev, RTW_DBG_REGD, "regd state: %d -> %d\n",
 		rtwdev->regd.state, next_regd.state);
 
+	mutex_lock(&rtwdev->mutex);
 	rtwdev->regd = next_regd;
 	rtw_dbg_regd_dump(rtwdev, "get alpha2 %c%c from initiator %d: ",
 			  request->alpha2[0],
@@ -487,6 +488,7 @@ void rtw_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 
 	rtw_phy_adaptivity_set_mode(rtwdev);
 	rtw_phy_set_tx_power_level(rtwdev, hal->current_channel);
+	mutex_unlock(&rtwdev->mutex);
 }
 
 u8 rtw_regd_get(struct rtw_dev *rtwdev)
-- 
2.25.1

