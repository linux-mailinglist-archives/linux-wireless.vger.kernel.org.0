Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2850A539ACE
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 03:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348987AbiFABkA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 May 2022 21:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiFABkA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 May 2022 21:40:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A200B72209
        for <linux-wireless@vger.kernel.org>; Tue, 31 May 2022 18:39:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2511ddolF005992, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2511ddolF005992
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 1 Jun 2022 09:39:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 1 Jun 2022 09:39:39 +0800
Received: from localhost (172.16.20.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 1 Jun
 2022 09:39:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <echuang@realtek.com>,
        <phhuang@realtek.com>
Subject: [PATCH 1/3] ieee80211: add trigger frame definition
Date:   Wed, 1 Jun 2022 09:39:15 +0800
Message-ID: <20220601013917.18814-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601013917.18814-1-pkshih@realtek.com>
References: <20220601013917.18814-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.31]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/01/2022 01:18:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMzEgpFWkyCAxMDoxMjowMA==?=
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

From: Po Hao Huang <phhuang@realtek.com>

Define trigger stype of control frame, and its checking function, struct
and trigger type within common_info of trigger.

Signed-off-by: Po Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 include/linux/ieee80211.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 75d40acb60c1c..f3b2d5b56d643 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -76,6 +76,7 @@
 #define IEEE80211_STYPE_ACTION		0x00D0
 
 /* control */
+#define IEEE80211_STYPE_TRIGGER		0x0020
 #define IEEE80211_STYPE_CTL_EXT		0x0060
 #define IEEE80211_STYPE_BACK_REQ	0x0080
 #define IEEE80211_STYPE_BACK		0x0090
@@ -295,6 +296,17 @@ static inline u16 ieee80211_sn_sub(u16 sn1, u16 sn2)
 
 #define IEEE80211_HT_CTL_LEN		4
 
+/* trigger type within common_info of trigger frame */
+#define IEEE80211_TRIGGER_TYPE_MASK		0xfULL
+#define IEEE80211_TRIGGER_TYPE_BASIC		0x0
+#define IEEE80211_TRIGGER_TYPE_BFRP		0x1
+#define IEEE80211_TRIGGER_TYPE_MU_BAR		0x2
+#define IEEE80211_TRIGGER_TYPE_MU_RTS		0x3
+#define IEEE80211_TRIGGER_TYPE_BSRP		0x4
+#define IEEE80211_TRIGGER_TYPE_GCR_MU_BAR	0x5
+#define IEEE80211_TRIGGER_TYPE_BQRP		0x6
+#define IEEE80211_TRIGGER_TYPE_NFRP		0x7
+
 struct ieee80211_hdr {
 	__le16 frame_control;
 	__le16 duration_id;
@@ -324,6 +336,15 @@ struct ieee80211_qos_hdr {
 	__le16 qos_ctrl;
 } __packed __aligned(2);
 
+struct ieee80211_trigger {
+	__le16 frame_control;
+	__le16 duration;
+	u8 ra[ETH_ALEN];
+	u8 ta[ETH_ALEN];
+	__le64 common_info;
+	u8 variable[];
+} __packed __aligned(2);
+
 /**
  * ieee80211_has_tods - check if IEEE80211_FCTL_TODS is set
  * @fc: frame control bytes in little-endian byteorder
@@ -729,6 +750,16 @@ static inline bool ieee80211_is_qos_nullfunc(__le16 fc)
 	       cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_NULLFUNC);
 }
 
+/**
+ * ieee80211_is_trigger - check if frame is trigger frame
+ * @fc: frame control field in little-endian byteorder
+ */
+static inline bool ieee80211_is_trigger(__le16 fc)
+{
+	return (fc & cpu_to_le16(IEEE80211_FCTL_FTYPE | IEEE80211_FCTL_STYPE)) ==
+	       cpu_to_le16(IEEE80211_FTYPE_CTL | IEEE80211_STYPE_TRIGGER);
+}
+
 /**
  * ieee80211_is_any_nullfunc - check if frame is regular or QoS nullfunc frame
  * @fc: frame control bytes in little-endian byteorder
-- 
2.25.1

