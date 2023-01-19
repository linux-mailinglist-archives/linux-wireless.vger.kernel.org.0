Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FE96731C2
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 07:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjASGZl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 01:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjASGZc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 01:25:32 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF09465ECC
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 22:25:30 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30J6PF2U0005748, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30J6PF2U0005748
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 19 Jan 2023 14:25:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 19 Jan 2023 14:25:16 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 19 Jan
 2023 14:25:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/3] wifi: rtw89: split out generic part of rtw89_mac_port_tsf_sync()
Date:   Thu, 19 Jan 2023 14:24:52 +0800
Message-ID: <20230119062453.58341-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119062453.58341-1-pkshih@realtek.com>
References: <20230119062453.58341-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/19/2023 06:07:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTkgpFekyCAwMzozNzowMA==?=
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Originally, rtw89_mac_port_tsf_sync() contains randomization logic
internally. However, not all situation, we need the randomization.
So, split out the generic part from it. And, make the full logic of
original one contained in rtw89_mac_port_tsf_sync_rand(). It will
still be used by its original caller as before. Then, the generic
one will be used in MCC (multi-channel concurrency) management flow.
MCC will implement its logic to decide the offset for TSF sync.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 33 +++++++++++++++---------
 drivers/net/wireless/realtek/rtw89/mac.h |  4 +++
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index ea34b4df21a75..c13edd33b1a48 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3918,27 +3918,36 @@ static void rtw89_mac_port_cfg_tbtt_shift(struct rtw89_dev *rtwdev,
 				B_AX_TBTT_SHIFT_OFST_MASK, val);
 }
 
-static void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
-				    struct rtw89_vif *rtwvif,
-				    struct rtw89_vif *rtwvif_src, u8 offset,
-				    int *n_offset)
+void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
+			     struct rtw89_vif *rtwvif,
+			     struct rtw89_vif *rtwvif_src,
+			     u16 offset_tu)
 {
 	u32 val, reg;
 
+	val = RTW89_PORT_OFFSET_TU_TO_32US(offset_tu);
+	reg = rtw89_mac_reg_by_idx(R_AX_PORT0_TSF_SYNC + rtwvif->port * 4,
+				   rtwvif->mac_idx);
+
+	rtw89_write32_mask(rtwdev, reg, B_AX_SYNC_PORT_SRC, rtwvif_src->port);
+	rtw89_write32_mask(rtwdev, reg, B_AX_SYNC_PORT_OFFSET_VAL, val);
+	rtw89_write32_set(rtwdev, reg, B_AX_SYNC_NOW);
+}
+
+static void rtw89_mac_port_tsf_sync_rand(struct rtw89_dev *rtwdev,
+					 struct rtw89_vif *rtwvif,
+					 struct rtw89_vif *rtwvif_src,
+					 u8 offset, int *n_offset)
+{
 	if (rtwvif->net_type != RTW89_NET_TYPE_AP_MODE || rtwvif == rtwvif_src)
 		return;
 
 	/* adjust offset randomly to avoid beacon conflict */
 	offset = offset - offset / 4 + get_random_u32() % (offset / 2);
-	val = (*n_offset) * RTW89_PORT_OFFSET_TU_TO_32US(offset);
-	reg = rtw89_mac_reg_by_idx(R_AX_PORT0_TSF_SYNC + rtwvif->port * 4,
-				   rtwvif->mac_idx);
+	rtw89_mac_port_tsf_sync(rtwdev, rtwvif, rtwvif_src,
+				(*n_offset) * offset);
 
 	(*n_offset)++;
-
-	rtw89_write32_mask(rtwdev, reg, B_AX_SYNC_PORT_SRC, rtwvif_src->port);
-	rtw89_write32_mask(rtwdev, reg, B_AX_SYNC_PORT_OFFSET_VAL, val);
-	rtw89_write32_set(rtwdev, reg, B_AX_SYNC_NOW);
 }
 
 static void rtw89_mac_port_tsf_resync_all(struct rtw89_dev *rtwdev)
@@ -3960,7 +3969,7 @@ static void rtw89_mac_port_tsf_resync_all(struct rtw89_dev *rtwdev)
 	offset /= (vif_aps + 1);
 
 	rtw89_for_each_rtwvif(rtwdev, tmp)
-		rtw89_mac_port_tsf_sync(rtwdev, tmp, src, offset, &n_offset);
+		rtw89_mac_port_tsf_sync_rand(rtwdev, tmp, src, offset, &n_offset);
 }
 
 int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 2556271597441..4c50527aad61b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -906,6 +906,10 @@ int rtw89_mac_write_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 val);
 int rtw89_mac_read_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 *val);
 int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
+			     struct rtw89_vif *rtwvif,
+			     struct rtw89_vif *rtwvif_src,
+			     u16 offset_tu);
 void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 					struct ieee80211_vif *vif);
 void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
-- 
2.25.1

