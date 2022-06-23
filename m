Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8725B55724E
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jun 2022 06:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbiFWEpl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 00:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243111AbiFWDrj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 23:47:39 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD71038D90
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 20:47:37 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25N3lWRp9019195, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25N3lWRp9019195
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jun 2022 11:47:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 23 Jun 2022 11:47:31 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 23 Jun
 2022 11:47:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 09/13] rtw89: initialize entity and configure default chandef
Date:   Thu, 23 Jun 2022 11:46:31 +0800
Message-ID: <20220623034635.20964-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623034635.20964-1-pkshih@realtek.com>
References: <20220623034635.20964-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 06/23/2022 03:30:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMjMgpFekyCAxMjo1MTowMA==?=
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

While idle, we need a default chandef to set channel for things,
such as scan. Before support of mac80211 chanctx, mac80211 would
configure a default one on ieee80211_hw::conf::chandef. And we
just queried it whenever we did set channel. However, after support
of mac80211 chanctx, the flow won't work like before.

Besides, we don't now query chandef from ieee80211_hw::conf::chandef
either. So, similar to mac80211 without using chanctx, we configure
the default chandef with ieee80211_channel of index 0 in 2GHz.

Although we have not added the support of mac80211 chanctx here,
this configuration should be compatible before that. So, we commit
this ahead.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 16 ++++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h |  1 +
 drivers/net/wireless/realtek/rtw89/core.c |  7 +++++++
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/ser.c  |  2 ++
 5 files changed, 27 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index a9f0133f8089d..e0f1c89bbfa6b 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -138,3 +138,19 @@ void rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
 {
 	__rtw89_config_entity_chandef(rtwdev, idx, chandef, true);
 }
+
+static void rtw89_config_default_chandef(struct rtw89_dev *rtwdev)
+{
+	struct cfg80211_chan_def chandef = {0};
+
+	rtw89_get_default_chandef(&chandef);
+	__rtw89_config_entity_chandef(rtwdev, RTW89_SUB_ENTITY_0, &chandef, false);
+}
+
+void rtw89_entity_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	bitmap_zero(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
+	rtw89_config_default_chandef(rtwdev);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index b2022bb0afc6a..9c714f00c3c13 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -29,5 +29,6 @@ bool rtw89_assign_entity_chan(struct rtw89_dev *rtwdev,
 void rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
 				 enum rtw89_sub_entity_idx idx,
 				 const struct cfg80211_chan_def *chandef);
+void rtw89_entity_init(struct rtw89_dev *rtwdev);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 4c25fef476e01..04ba705a14a7b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -225,6 +225,12 @@ static void rtw89_traffic_stats_accu(struct rtw89_dev *rtwdev,
 	}
 }
 
+void rtw89_get_default_chandef(struct cfg80211_chan_def *chandef)
+{
+	cfg80211_chandef_create(chandef, &rtw89_channels_2ghz[0],
+				NL80211_CHAN_NO_HT);
+}
+
 static void rtw89_get_channel_params(const struct cfg80211_chan_def *chandef,
 				     struct rtw89_chan *chan)
 {
@@ -2935,6 +2941,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 	rtw89_ser_init(rtwdev);
+	rtw89_entity_init(rtwdev);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f8027b9a36a0c..3b6660d76f797 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3955,6 +3955,7 @@ void rtw89_core_deinit(struct rtw89_dev *rtwdev);
 int rtw89_core_register(struct rtw89_dev *rtwdev);
 void rtw89_core_unregister(struct rtw89_dev *rtwdev);
 void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev);
+void rtw89_get_default_chandef(struct cfg80211_chan_def *chandef);
 void rtw89_set_channel(struct rtw89_dev *rtwdev);
 u8 rtw89_core_acquire_bit_map(unsigned long *addr, unsigned long size);
 void rtw89_core_release_bit_map(unsigned long *addr, u8 bit);
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 726223f25dc69..74af916ac7423 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -5,6 +5,7 @@
 #include <linux/devcoredump.h>
 
 #include "cam.h"
+#include "chan.h"
 #include "debug.h"
 #include "fw.h"
 #include "mac.h"
@@ -601,6 +602,7 @@ static void ser_l2_reset_st_pre_hdl(struct rtw89_ser *ser)
 
 	ser_reset_mac_binding(rtwdev);
 	rtw89_core_stop(rtwdev);
+	rtw89_entity_init(rtwdev);
 	INIT_LIST_HEAD(&rtwdev->rtwvifs_list);
 }
 
-- 
2.25.1

