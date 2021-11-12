Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6426444DF32
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 01:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhKLAi3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Nov 2021 19:38:29 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:40275 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbhKLAi0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Nov 2021 19:38:26 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AC0ZIIJ0001118, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AC0ZIIJ0001118
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 12 Nov 2021 08:35:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 12 Nov 2021 08:35:17 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 12 Nov
 2021 08:35:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tiwai@suse.de>,
        <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 3/3] rtw89: use inline function instead macro to set H2C and CAM
Date:   Fri, 12 Nov 2021 08:34:53 +0800
Message-ID: <20211112003453.5073-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112003453.5073-1-pkshih@realtek.com>
References: <20211112003453.5073-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 11/12/2021 00:17:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzExIKRVpMggMTA6MzA6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/12/2021 00:15:25
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167215 [Nov 11 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/12/2021 00:17:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to use compiler to check if we do improper cast of const* on
arguments of inline function.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Takashi Iwai <tiwai@suse.de>
Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/net/wireless/realtek/rtw89/cam.h |  468 ++++--
 drivers/net/wireless/realtek/rtw89/fw.h  | 1692 +++++++++++++---------
 2 files changed, 1307 insertions(+), 853 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index 90a20a5375c6b..41d7d27120276 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -9,140 +9,340 @@
 
 #define RTW89_SEC_CAM_LEN	20
 
-#define FWCMD_SET_ADDR_IDX(cmd, value)					\
-	le32p_replace_bits((__le32 *)(cmd) + 1, value, GENMASK(7, 0))
-#define FWCMD_SET_ADDR_OFFSET(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 1, value, GENMASK(15, 8))
-#define FWCMD_SET_ADDR_LEN(cmd, value)					\
-	le32p_replace_bits((__le32 *)(cmd) + 1, value, GENMASK(23, 16))
-#define FWCMD_SET_ADDR_VALID(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, BIT(0))
-#define FWCMD_SET_ADDR_NET_TYPE(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(2, 1))
-#define FWCMD_SET_ADDR_BCN_HIT_COND(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(4, 3))
-#define FWCMD_SET_ADDR_HIT_RULE(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(6, 5))
-#define FWCMD_SET_ADDR_BB_SEL(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, BIT(7))
-#define FWCMD_SET_ADDR_ADDR_MASK(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(13, 8))
-#define FWCMD_SET_ADDR_MASK_SEL(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(15, 14))
-#define FWCMD_SET_ADDR_SMA_HASH(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(23, 16))
-#define FWCMD_SET_ADDR_TMA_HASH(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(31, 24))
-#define FWCMD_SET_ADDR_BSSID_CAM_IDX(cmd, value)			\
-	le32p_replace_bits((__le32 *)(cmd) + 3, value, GENMASK(5, 0))
-#define FWCMD_SET_ADDR_SMA0(cmd, value)					\
-	le32p_replace_bits((__le32 *)(cmd) + 4, value, GENMASK(7, 0))
-#define FWCMD_SET_ADDR_SMA1(cmd, value)					\
-	le32p_replace_bits((__le32 *)(cmd) + 4, value, GENMASK(15, 8))
-#define FWCMD_SET_ADDR_SMA2(cmd, value)					\
-	le32p_replace_bits((__le32 *)(cmd) + 4, value, GENMASK(23, 16))
-#define FWCMD_SET_ADDR_SMA3(cmd, value)					\
-	le32p_replace_bits((__le32 *)(cmd) + 4, value, GENMASK(31, 24))
-#define FWCMD_SET_ADDR_SMA4(cmd, value)					\
-	le32p_replace_bits((__le32 *)(cmd) + 5, value, GENMASK(7, 0))
-#define FWCMD_SET_ADDR_SMA5(cmd, value)					\
-	le32p_replace_bits((__le32 *)(cmd) + 5, value, GENMASK(15, 8))
-#define FWCMD_SET_ADDR_TMA0(cmd, value)					\
-	le32p_replace_bits((__le32 *)(cmd) + 5, value, GENMASK(23, 16))
-#define FWCMD_SET_ADDR_TMA1(cmd, value)					\
-	le32p_replace_bits((__le32 *)(cmd) + 5, value, GENMASK(31, 24))
-#define FWCMD_SET_ADDR_TMA2(cmd, value)					\
-	le32p_replace_bits((__le32 *)(cmd) + 6, value, GENMASK(7, 0))
-#define FWCMD_SET_ADDR_TMA3(cmd, value)					\
-	le32p_replace_bits((__le32 *)(cmd) + 6, value, GENMASK(15, 8))
-#define FWCMD_SET_ADDR_TMA4(cmd, value)					\
-	le32p_replace_bits((__le32 *)(cmd) + 6, value, GENMASK(23, 16))
-#define FWCMD_SET_ADDR_TMA5(cmd, value)					\
-	le32p_replace_bits((__le32 *)(cmd) + 6, value, GENMASK(31, 24))
-#define FWCMD_SET_ADDR_MACID(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(7, 0))
-#define FWCMD_SET_ADDR_PORT_INT(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(10, 8))
-#define FWCMD_SET_ADDR_TSF_SYNC(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(13, 11))
-#define FWCMD_SET_ADDR_TF_TRS(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 8, value, BIT(14))
-#define FWCMD_SET_ADDR_LSIG_TXOP(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 8, value, BIT(15))
-#define FWCMD_SET_ADDR_TGT_IND(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(26, 24))
-#define FWCMD_SET_ADDR_FRM_TGT_IND(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(29, 27))
-#define FWCMD_SET_ADDR_AID12(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(11, 0))
-#define FWCMD_SET_ADDR_AID12_0(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(7, 0))
-#define FWCMD_SET_ADDR_AID12_1(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(11, 8))
-#define FWCMD_SET_ADDR_WOL_PATTERN(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, BIT(12))
-#define FWCMD_SET_ADDR_WOL_UC(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, BIT(13))
-#define FWCMD_SET_ADDR_WOL_MAGIC(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, BIT(14))
-#define FWCMD_SET_ADDR_WAPI(cmd, value)					\
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, BIT(15))
-#define FWCMD_SET_ADDR_SEC_ENT_MODE(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(17, 16))
-#define FWCMD_SET_ADDR_SEC_ENT0_KEYID(cmd, value)			\
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(19, 18))
-#define FWCMD_SET_ADDR_SEC_ENT1_KEYID(cmd, value)			\
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(21, 20))
-#define FWCMD_SET_ADDR_SEC_ENT2_KEYID(cmd, value)			\
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(23, 22))
-#define FWCMD_SET_ADDR_SEC_ENT3_KEYID(cmd, value)			\
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(25, 24))
-#define FWCMD_SET_ADDR_SEC_ENT4_KEYID(cmd, value)			\
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(27, 26))
-#define FWCMD_SET_ADDR_SEC_ENT5_KEYID(cmd, value)			\
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(29, 28))
-#define FWCMD_SET_ADDR_SEC_ENT6_KEYID(cmd, value)			\
-	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(31, 30))
-#define FWCMD_SET_ADDR_SEC_ENT_VALID(cmd, value)			\
-	le32p_replace_bits((__le32 *)(cmd) + 10, value, GENMASK(7, 0))
-#define FWCMD_SET_ADDR_SEC_ENT0(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 10, value, GENMASK(15, 8))
-#define FWCMD_SET_ADDR_SEC_ENT1(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 10, value, GENMASK(23, 16))
-#define FWCMD_SET_ADDR_SEC_ENT2(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 10, value, GENMASK(31, 24))
-#define FWCMD_SET_ADDR_SEC_ENT3(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 11, value, GENMASK(7, 0))
-#define FWCMD_SET_ADDR_SEC_ENT4(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 11, value, GENMASK(15, 8))
-#define FWCMD_SET_ADDR_SEC_ENT5(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 11, value, GENMASK(23, 16))
-#define FWCMD_SET_ADDR_SEC_ENT6(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 11, value, GENMASK(31, 24))
-#define FWCMD_SET_ADDR_BSSID_IDX(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 12, value, GENMASK(7, 0))
-#define FWCMD_SET_ADDR_BSSID_OFFSET(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 12, value, GENMASK(15, 8))
-#define FWCMD_SET_ADDR_BSSID_LEN(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 12, value, GENMASK(23, 16))
-#define FWCMD_SET_ADDR_BSSID_VALID(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 13, value, BIT(0))
-#define FWCMD_SET_ADDR_BSSID_BB_SEL(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 13, value, BIT(1))
-#define FWCMD_SET_ADDR_BSSID_BSS_COLOR(cmd, value)			\
-	le32p_replace_bits((__le32 *)(cmd) + 13, value, GENMASK(13, 8))
-#define FWCMD_SET_ADDR_BSSID_BSSID0(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 13, value, GENMASK(23, 16))
-#define FWCMD_SET_ADDR_BSSID_BSSID1(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 13, value, GENMASK(31, 24))
-#define FWCMD_SET_ADDR_BSSID_BSSID2(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(7, 0))
-#define FWCMD_SET_ADDR_BSSID_BSSID3(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(15, 8))
-#define FWCMD_SET_ADDR_BSSID_BSSID4(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(23, 16))
-#define FWCMD_SET_ADDR_BSSID_BSSID5(cmd, value)				\
-	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(31, 24))
+static inline void FWCMD_SET_ADDR_IDX(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 1, value, GENMASK(7, 0));
+}
+
+static inline void FWCMD_SET_ADDR_OFFSET(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 1, value, GENMASK(15, 8));
+}
+
+static inline void FWCMD_SET_ADDR_LEN(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 1, value, GENMASK(23, 16));
+}
+
+static inline void FWCMD_SET_ADDR_VALID(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, BIT(0));
+}
+
+static inline void FWCMD_SET_ADDR_NET_TYPE(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(2, 1));
+}
+
+static inline void FWCMD_SET_ADDR_BCN_HIT_COND(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(4, 3));
+}
+
+static inline void FWCMD_SET_ADDR_HIT_RULE(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(6, 5));
+}
+
+static inline void FWCMD_SET_ADDR_BB_SEL(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, BIT(7));
+}
+
+static inline void FWCMD_SET_ADDR_ADDR_MASK(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(13, 8));
+}
+
+static inline void FWCMD_SET_ADDR_MASK_SEL(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(15, 14));
+}
+
+static inline void FWCMD_SET_ADDR_SMA_HASH(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(23, 16));
+}
+
+static inline void FWCMD_SET_ADDR_TMA_HASH(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 2, value, GENMASK(31, 24));
+}
+
+static inline void FWCMD_SET_ADDR_BSSID_CAM_IDX(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 3, value, GENMASK(5, 0));
+}
+
+static inline void FWCMD_SET_ADDR_SMA0(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 4, value, GENMASK(7, 0));
+}
+
+static inline void FWCMD_SET_ADDR_SMA1(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 4, value, GENMASK(15, 8));
+}
+
+static inline void FWCMD_SET_ADDR_SMA2(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 4, value, GENMASK(23, 16));
+}
+
+static inline void FWCMD_SET_ADDR_SMA3(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 4, value, GENMASK(31, 24));
+}
+
+static inline void FWCMD_SET_ADDR_SMA4(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 5, value, GENMASK(7, 0));
+}
+
+static inline void FWCMD_SET_ADDR_SMA5(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 5, value, GENMASK(15, 8));
+}
+
+static inline void FWCMD_SET_ADDR_TMA0(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 5, value, GENMASK(23, 16));
+}
+
+static inline void FWCMD_SET_ADDR_TMA1(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 5, value, GENMASK(31, 24));
+}
+
+static inline void FWCMD_SET_ADDR_TMA2(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 6, value, GENMASK(7, 0));
+}
+
+static inline void FWCMD_SET_ADDR_TMA3(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 6, value, GENMASK(15, 8));
+}
+
+static inline void FWCMD_SET_ADDR_TMA4(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 6, value, GENMASK(23, 16));
+}
+
+static inline void FWCMD_SET_ADDR_TMA5(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 6, value, GENMASK(31, 24));
+}
+
+static inline void FWCMD_SET_ADDR_MACID(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(7, 0));
+}
+
+static inline void FWCMD_SET_ADDR_PORT_INT(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(10, 8));
+}
+
+static inline void FWCMD_SET_ADDR_TSF_SYNC(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(13, 11));
+}
+
+static inline void FWCMD_SET_ADDR_TF_TRS(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 8, value, BIT(14));
+}
+
+static inline void FWCMD_SET_ADDR_LSIG_TXOP(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 8, value, BIT(15));
+}
+
+static inline void FWCMD_SET_ADDR_TGT_IND(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(26, 24));
+}
+
+static inline void FWCMD_SET_ADDR_FRM_TGT_IND(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 8, value, GENMASK(29, 27));
+}
+
+static inline void FWCMD_SET_ADDR_AID12(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(11, 0));
+}
+
+static inline void FWCMD_SET_ADDR_AID12_0(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(7, 0));
+}
+
+static inline void FWCMD_SET_ADDR_AID12_1(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(11, 8));
+}
+
+static inline void FWCMD_SET_ADDR_WOL_PATTERN(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, BIT(12));
+}
+
+static inline void FWCMD_SET_ADDR_WOL_UC(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, BIT(13));
+}
+
+static inline void FWCMD_SET_ADDR_WOL_MAGIC(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, BIT(14));
+}
+
+static inline void FWCMD_SET_ADDR_WAPI(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, BIT(15));
+}
+
+static inline void FWCMD_SET_ADDR_SEC_ENT_MODE(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(17, 16));
+}
+
+static inline void FWCMD_SET_ADDR_SEC_ENT0_KEYID(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(19, 18));
+}
+
+static inline void FWCMD_SET_ADDR_SEC_ENT1_KEYID(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(21, 20));
+}
+
+static inline void FWCMD_SET_ADDR_SEC_ENT2_KEYID(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(23, 22));
+}
+
+static inline void FWCMD_SET_ADDR_SEC_ENT3_KEYID(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(25, 24));
+}
+
+static inline void FWCMD_SET_ADDR_SEC_ENT4_KEYID(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(27, 26));
+}
+
+static inline void FWCMD_SET_ADDR_SEC_ENT5_KEYID(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(29, 28));
+}
+
+static inline void FWCMD_SET_ADDR_SEC_ENT6_KEYID(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 9, value, GENMASK(31, 30));
+}
+
+static inline void FWCMD_SET_ADDR_SEC_ENT_VALID(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 10, value, GENMASK(7, 0));
+}
+
+static inline void FWCMD_SET_ADDR_SEC_ENT0(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 10, value, GENMASK(15, 8));
+}
+
+static inline void FWCMD_SET_ADDR_SEC_ENT1(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 10, value, GENMASK(23, 16));
+}
+
+static inline void FWCMD_SET_ADDR_SEC_ENT2(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 10, value, GENMASK(31, 24));
+}
+
+static inline void FWCMD_SET_ADDR_SEC_ENT3(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 11, value, GENMASK(7, 0));
+}
+
+static inline void FWCMD_SET_ADDR_SEC_ENT4(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 11, value, GENMASK(15, 8));
+}
+
+static inline void FWCMD_SET_ADDR_SEC_ENT5(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 11, value, GENMASK(23, 16));
+}
+
+static inline void FWCMD_SET_ADDR_SEC_ENT6(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 11, value, GENMASK(31, 24));
+}
+
+static inline void FWCMD_SET_ADDR_BSSID_IDX(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 12, value, GENMASK(7, 0));
+}
+
+static inline void FWCMD_SET_ADDR_BSSID_OFFSET(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 12, value, GENMASK(15, 8));
+}
+
+static inline void FWCMD_SET_ADDR_BSSID_LEN(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 12, value, GENMASK(23, 16));
+}
+
+static inline void FWCMD_SET_ADDR_BSSID_VALID(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 13, value, BIT(0));
+}
+
+static inline void FWCMD_SET_ADDR_BSSID_BB_SEL(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 13, value, BIT(1));
+}
+
+static inline void FWCMD_SET_ADDR_BSSID_BSS_COLOR(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 13, value, GENMASK(13, 8));
+}
+
+static inline void FWCMD_SET_ADDR_BSSID_BSSID0(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 13, value, GENMASK(23, 16));
+}
+
+static inline void FWCMD_SET_ADDR_BSSID_BSSID1(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 13, value, GENMASK(31, 24));
+}
+
+static inline void FWCMD_SET_ADDR_BSSID_BSSID2(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(7, 0));
+}
+
+static inline void FWCMD_SET_ADDR_BSSID_BSSID3(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(15, 8));
+}
+
+static inline void FWCMD_SET_ADDR_BSSID_BSSID4(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(23, 16));
+}
+
+static inline void FWCMD_SET_ADDR_BSSID_BSSID5(void *cmd, u32 value)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 14, value, GENMASK(31, 24));
+}
 
 int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 void rtw89_cam_deinit(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 2a9953d1ae0cd..cc5374c1c32b2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -156,96 +156,225 @@ struct rtw89_h2creg_sch_tx_en {
 	u16 rsvd:15;
 } __packed;
 
-#define RTW89_SET_FWCMD_RA_IS_DIS(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(0))
-#define RTW89_SET_FWCMD_RA_MODE(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(5, 1))
-#define RTW89_SET_FWCMD_RA_BW_CAP(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(7, 6))
-#define RTW89_SET_FWCMD_RA_MACID(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(15, 8))
-#define RTW89_SET_FWCMD_RA_DCM(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(16))
-#define RTW89_SET_FWCMD_RA_ER(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(17))
-#define RTW89_SET_FWCMD_RA_INIT_RATE_LV(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(19, 18))
-#define RTW89_SET_FWCMD_RA_UPD_ALL(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(20))
-#define RTW89_SET_FWCMD_RA_SGI(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(21))
-#define RTW89_SET_FWCMD_RA_LDPC(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(22))
-#define RTW89_SET_FWCMD_RA_STBC(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(23))
-#define RTW89_SET_FWCMD_RA_SS_NUM(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(26, 24))
-#define RTW89_SET_FWCMD_RA_GILTF(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(29, 27))
-#define RTW89_SET_FWCMD_RA_UPD_BW_NSS_MASK(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(30))
-#define RTW89_SET_FWCMD_RA_UPD_MASK(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(31))
-#define RTW89_SET_FWCMD_RA_MASK_0(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, GENMASK(7, 0))
-#define RTW89_SET_FWCMD_RA_MASK_1(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, GENMASK(15, 8))
-#define RTW89_SET_FWCMD_RA_MASK_2(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, GENMASK(23, 16))
-#define RTW89_SET_FWCMD_RA_MASK_3(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, GENMASK(31, 24))
-#define RTW89_SET_FWCMD_RA_MASK_4(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x02, val, GENMASK(7, 0))
-#define RTW89_SET_FWCMD_RA_BFEE_CSI_CTL(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x02, val, BIT(31))
-#define RTW89_SET_FWCMD_RA_BAND_NUM(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(7, 0))
-#define RTW89_SET_FWCMD_RA_RA_CSI_RATE_EN(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, BIT(8))
-#define RTW89_SET_FWCMD_RA_FIXED_CSI_RATE_EN(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, BIT(9))
-#define RTW89_SET_FWCMD_RA_CR_TBL_SEL(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, BIT(10))
-#define RTW89_SET_FWCMD_RA_FIXED_CSI_MCS_SS_IDX(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(23, 16))
-#define RTW89_SET_FWCMD_RA_FIXED_CSI_MODE(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(25, 24))
-#define RTW89_SET_FWCMD_RA_FIXED_CSI_GI_LTF(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(28, 26))
-#define RTW89_SET_FWCMD_RA_FIXED_CSI_BW(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(31, 29))
-
-#define RTW89_SET_FWCMD_SEC_IDX(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(7, 0))
-#define RTW89_SET_FWCMD_SEC_OFFSET(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(15, 8))
-#define RTW89_SET_FWCMD_SEC_LEN(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(23, 16))
-#define RTW89_SET_FWCMD_SEC_TYPE(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, GENMASK(3, 0))
-#define RTW89_SET_FWCMD_SEC_EXT_KEY(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, BIT(4))
-#define RTW89_SET_FWCMD_SEC_SPP_MODE(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, BIT(5))
-#define RTW89_SET_FWCMD_SEC_KEY0(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x02, val, GENMASK(31, 0))
-#define RTW89_SET_FWCMD_SEC_KEY1(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(31, 0))
-#define RTW89_SET_FWCMD_SEC_KEY2(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x04, val, GENMASK(31, 0))
-#define RTW89_SET_FWCMD_SEC_KEY3(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x05, val, GENMASK(31, 0))
-
-#define RTW89_SET_EDCA_SEL(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(1, 0))
-#define RTW89_SET_EDCA_BAND(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(3))
-#define RTW89_SET_EDCA_WMM(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(4))
-#define RTW89_SET_EDCA_AC(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(6, 5))
-#define RTW89_SET_EDCA_PARAM(cmd, val) \
-	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, GENMASK(31, 0))
+static inline void RTW89_SET_FWCMD_RA_IS_DIS(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(0));
+}
+
+static inline void RTW89_SET_FWCMD_RA_MODE(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(5, 1));
+}
+
+static inline void RTW89_SET_FWCMD_RA_BW_CAP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(7, 6));
+}
+
+static inline void RTW89_SET_FWCMD_RA_MACID(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_FWCMD_RA_DCM(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(16));
+}
+
+static inline void RTW89_SET_FWCMD_RA_ER(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(17));
+}
+
+static inline void RTW89_SET_FWCMD_RA_INIT_RATE_LV(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(19, 18));
+}
+
+static inline void RTW89_SET_FWCMD_RA_UPD_ALL(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(20));
+}
+
+static inline void RTW89_SET_FWCMD_RA_SGI(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(21));
+}
+
+static inline void RTW89_SET_FWCMD_RA_LDPC(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(22));
+}
+
+static inline void RTW89_SET_FWCMD_RA_STBC(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(23));
+}
+
+static inline void RTW89_SET_FWCMD_RA_SS_NUM(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(26, 24));
+}
+
+static inline void RTW89_SET_FWCMD_RA_GILTF(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(29, 27));
+}
+
+static inline void RTW89_SET_FWCMD_RA_UPD_BW_NSS_MASK(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(30));
+}
+
+static inline void RTW89_SET_FWCMD_RA_UPD_MASK(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(31));
+}
+
+static inline void RTW89_SET_FWCMD_RA_MASK_0(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_RA_MASK_1(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_FWCMD_RA_MASK_2(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, GENMASK(23, 16));
+}
+
+static inline void RTW89_SET_FWCMD_RA_MASK_3(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, GENMASK(31, 24));
+}
+
+static inline void RTW89_SET_FWCMD_RA_MASK_4(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x02, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_RA_BFEE_CSI_CTL(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x02, val, BIT(31));
+}
+
+static inline void RTW89_SET_FWCMD_RA_BAND_NUM(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_RA_RA_CSI_RATE_EN(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, BIT(8));
+}
+
+static inline void RTW89_SET_FWCMD_RA_FIXED_CSI_RATE_EN(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, BIT(9));
+}
+
+static inline void RTW89_SET_FWCMD_RA_CR_TBL_SEL(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, BIT(10));
+}
+
+static inline void RTW89_SET_FWCMD_RA_FIXED_CSI_MCS_SS_IDX(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(23, 16));
+}
+
+static inline void RTW89_SET_FWCMD_RA_FIXED_CSI_MODE(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(25, 24));
+}
+
+static inline void RTW89_SET_FWCMD_RA_FIXED_CSI_GI_LTF(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(28, 26));
+}
+
+static inline void RTW89_SET_FWCMD_RA_FIXED_CSI_BW(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(31, 29));
+}
+
+static inline void RTW89_SET_FWCMD_SEC_IDX(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_SEC_OFFSET(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_FWCMD_SEC_LEN(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(23, 16));
+}
+
+static inline void RTW89_SET_FWCMD_SEC_TYPE(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, GENMASK(3, 0));
+}
+
+static inline void RTW89_SET_FWCMD_SEC_EXT_KEY(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, BIT(4));
+}
+
+static inline void RTW89_SET_FWCMD_SEC_SPP_MODE(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, BIT(5));
+}
+
+static inline void RTW89_SET_FWCMD_SEC_KEY0(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x02, val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_FWCMD_SEC_KEY1(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x03, val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_FWCMD_SEC_KEY2(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x04, val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_FWCMD_SEC_KEY3(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x05, val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_EDCA_SEL(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(1, 0));
+}
+
+static inline void RTW89_SET_EDCA_BAND(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(3));
+}
+
+static inline void RTW89_SET_EDCA_WMM(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(4));
+}
+
+static inline void RTW89_SET_EDCA_AC(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(6, 5));
+}
+
+static inline void RTW89_SET_EDCA_PARAM(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)(cmd) + 0x01, val, GENMASK(31, 0));
+}
 #define FW_EDCA_PARAM_TXOPLMT_MSK GENMASK(26, 16)
 #define FW_EDCA_PARAM_CWMAX_MSK GENMASK(15, 12)
 #define FW_EDCA_PARAM_CWMIN_MSK GENMASK(11, 8)
@@ -287,638 +416,645 @@ static inline void SET_FW_HDR_PART_SIZE(void *fwhdr, u32 val)
 	le32p_replace_bits((__le32 *)fwhdr + 7, val, GENMASK(15, 0));
 }
 
-#define SET_CTRL_INFO_MACID(table, val) \
-	le32p_replace_bits((__le32 *)(table) + 0, val, GENMASK(6, 0))
-#define SET_CTRL_INFO_OPERATION(table, val) \
-	le32p_replace_bits((__le32 *)(table) + 0, val, BIT(7))
+static inline void SET_CTRL_INFO_MACID(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 0, val, GENMASK(6, 0));
+}
+
+static inline void SET_CTRL_INFO_OPERATION(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 0, val, BIT(7));
+}
 #define SET_CMC_TBL_MASK_DATARATE GENMASK(8, 0)
-#define SET_CMC_TBL_DATARATE(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(8, 0)); \
-	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DATARATE, \
-			   GENMASK(8, 0)); \
-} while (0)
+static inline void SET_CMC_TBL_DATARATE(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(8, 0));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DATARATE,
+			   GENMASK(8, 0));
+}
 #define SET_CMC_TBL_MASK_FORCE_TXOP BIT(0)
-#define SET_CMC_TBL_FORCE_TXOP(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(9)); \
-	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_FORCE_TXOP, \
-			   BIT(9)); \
-} while (0)
+static inline void SET_CMC_TBL_FORCE_TXOP(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(9));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_FORCE_TXOP,
+			   BIT(9));
+}
 #define SET_CMC_TBL_MASK_DATA_BW GENMASK(1, 0)
-#define SET_CMC_TBL_DATA_BW(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(11, 10)); \
-	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DATA_BW, \
-			   GENMASK(11, 10)); \
-} while (0)
+static inline void SET_CMC_TBL_DATA_BW(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(11, 10));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DATA_BW,
+			   GENMASK(11, 10));
+}
 #define SET_CMC_TBL_MASK_DATA_GI_LTF GENMASK(2, 0)
-#define SET_CMC_TBL_DATA_GI_LTF(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(14, 12)); \
-	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DATA_GI_LTF, \
-			   GENMASK(14, 12)); \
-} while (0)
+static inline void SET_CMC_TBL_DATA_GI_LTF(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(14, 12));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DATA_GI_LTF,
+			   GENMASK(14, 12));
+}
 #define SET_CMC_TBL_MASK_DARF_TC_INDEX BIT(0)
-#define SET_CMC_TBL_DARF_TC_INDEX(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(15)); \
-	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DARF_TC_INDEX, \
-			   BIT(15)); \
-} while (0)
+static inline void SET_CMC_TBL_DARF_TC_INDEX(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(15));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DARF_TC_INDEX,
+			   BIT(15));
+}
 #define SET_CMC_TBL_MASK_ARFR_CTRL GENMASK(3, 0)
-#define SET_CMC_TBL_ARFR_CTRL(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(19, 16)); \
-	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_ARFR_CTRL, \
-			   GENMASK(19, 16)); \
-} while (0)
+static inline void SET_CMC_TBL_ARFR_CTRL(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(19, 16));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_ARFR_CTRL,
+			   GENMASK(19, 16));
+}
 #define SET_CMC_TBL_MASK_ACQ_RPT_EN BIT(0)
-#define SET_CMC_TBL_ACQ_RPT_EN(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(20)); \
-	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_ACQ_RPT_EN, \
-			   BIT(20)); \
-} while (0)
+static inline void SET_CMC_TBL_ACQ_RPT_EN(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(20));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_ACQ_RPT_EN,
+			   BIT(20));
+}
 #define SET_CMC_TBL_MASK_MGQ_RPT_EN BIT(0)
-#define SET_CMC_TBL_MGQ_RPT_EN(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(21)); \
-	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_MGQ_RPT_EN, \
-			   BIT(21)); \
-} while (0)
+static inline void SET_CMC_TBL_MGQ_RPT_EN(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(21));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_MGQ_RPT_EN,
+			   BIT(21));
+}
 #define SET_CMC_TBL_MASK_ULQ_RPT_EN BIT(0)
-#define SET_CMC_TBL_ULQ_RPT_EN(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(22)); \
-	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_ULQ_RPT_EN, \
-			   BIT(22)); \
-} while (0)
+static inline void SET_CMC_TBL_ULQ_RPT_EN(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(22));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_ULQ_RPT_EN,
+			   BIT(22));
+}
 #define SET_CMC_TBL_MASK_TWTQ_RPT_EN BIT(0)
-#define SET_CMC_TBL_TWTQ_RPT_EN(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(23)); \
-	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_TWTQ_RPT_EN, \
-			   BIT(23)); \
-} while (0)
+static inline void SET_CMC_TBL_TWTQ_RPT_EN(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(23));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_TWTQ_RPT_EN,
+			   BIT(23));
+}
 #define SET_CMC_TBL_MASK_DISRTSFB BIT(0)
-#define SET_CMC_TBL_DISRTSFB(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(25)); \
-	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DISRTSFB, \
-			   BIT(25)); \
-} while (0)
+static inline void SET_CMC_TBL_DISRTSFB(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(25));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DISRTSFB,
+			   BIT(25));
+}
 #define SET_CMC_TBL_MASK_DISDATAFB BIT(0)
-#define SET_CMC_TBL_DISDATAFB(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(26)); \
-	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DISDATAFB, \
-			   BIT(26)); \
-} while (0)
+static inline void SET_CMC_TBL_DISDATAFB(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(26));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DISDATAFB,
+			   BIT(26));
+}
 #define SET_CMC_TBL_MASK_TRYRATE BIT(0)
-#define SET_CMC_TBL_TRYRATE(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(27)); \
-	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_TRYRATE, \
-			   BIT(27)); \
-} while (0)
+static inline void SET_CMC_TBL_TRYRATE(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(27));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_TRYRATE,
+			   BIT(27));
+}
 #define SET_CMC_TBL_MASK_AMPDU_DENSITY GENMASK(3, 0)
-#define SET_CMC_TBL_AMPDU_DENSITY(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(31, 28)); \
-	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_AMPDU_DENSITY, \
-			   GENMASK(31, 28)); \
-} while (0)
+static inline void SET_CMC_TBL_AMPDU_DENSITY(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(31, 28));
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_AMPDU_DENSITY,
+			   GENMASK(31, 28));
+}
 #define SET_CMC_TBL_MASK_DATA_RTY_LOWEST_RATE GENMASK(8, 0)
-#define SET_CMC_TBL_DATA_RTY_LOWEST_RATE(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 2, val, GENMASK(8, 0)); \
-	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_DATA_RTY_LOWEST_RATE, \
-			   GENMASK(8, 0)); \
-} while (0)
+static inline void SET_CMC_TBL_DATA_RTY_LOWEST_RATE(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 2, val, GENMASK(8, 0));
+	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_DATA_RTY_LOWEST_RATE,
+			   GENMASK(8, 0));
+}
 #define SET_CMC_TBL_MASK_AMPDU_TIME_SEL BIT(0)
-#define SET_CMC_TBL_AMPDU_TIME_SEL(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 2, val, BIT(9)); \
-	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_AMPDU_TIME_SEL, \
-			   BIT(9)); \
-} while (0)
+static inline void SET_CMC_TBL_AMPDU_TIME_SEL(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 2, val, BIT(9));
+	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_AMPDU_TIME_SEL,
+			   BIT(9));
+}
 #define SET_CMC_TBL_MASK_AMPDU_LEN_SEL BIT(0)
-#define SET_CMC_TBL_AMPDU_LEN_SEL(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 2, val, BIT(10)); \
-	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_AMPDU_LEN_SEL, \
-			   BIT(10)); \
-} while (0)
+static inline void SET_CMC_TBL_AMPDU_LEN_SEL(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 2, val, BIT(10));
+	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_AMPDU_LEN_SEL,
+			   BIT(10));
+}
 #define SET_CMC_TBL_MASK_RTS_TXCNT_LMT_SEL BIT(0)
-#define SET_CMC_TBL_RTS_TXCNT_LMT_SEL(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 2, val, BIT(11)); \
-	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_RTS_TXCNT_LMT_SEL, \
-			   BIT(11)); \
-} while (0)
+static inline void SET_CMC_TBL_RTS_TXCNT_LMT_SEL(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 2, val, BIT(11));
+	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_RTS_TXCNT_LMT_SEL,
+			   BIT(11));
+}
 #define SET_CMC_TBL_MASK_RTS_TXCNT_LMT GENMASK(3, 0)
-#define SET_CMC_TBL_RTS_TXCNT_LMT(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 2, val, GENMASK(15, 12)); \
-	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_RTS_TXCNT_LMT, \
-			   GENMASK(15, 12)); \
-} while (0)
+static inline void SET_CMC_TBL_RTS_TXCNT_LMT(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 2, val, GENMASK(15, 12));
+	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_RTS_TXCNT_LMT,
+			   GENMASK(15, 12));
+}
 #define SET_CMC_TBL_MASK_RTSRATE GENMASK(8, 0)
-#define SET_CMC_TBL_RTSRATE(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 2, val, GENMASK(24, 16)); \
-	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_RTSRATE, \
-			   GENMASK(24, 16)); \
-} while (0)
+static inline void SET_CMC_TBL_RTSRATE(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 2, val, GENMASK(24, 16));
+	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_RTSRATE,
+			   GENMASK(24, 16));
+}
 #define SET_CMC_TBL_MASK_VCS_STBC BIT(0)
-#define SET_CMC_TBL_VCS_STBC(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 2, val, BIT(27)); \
-	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_VCS_STBC, \
-			   BIT(27)); \
-} while (0)
+static inline void SET_CMC_TBL_VCS_STBC(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 2, val, BIT(27));
+	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_VCS_STBC,
+			   BIT(27));
+}
 #define SET_CMC_TBL_MASK_RTS_RTY_LOWEST_RATE GENMASK(3, 0)
-#define SET_CMC_TBL_RTS_RTY_LOWEST_RATE(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 2, val, GENMASK(31, 28)); \
-	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_RTS_RTY_LOWEST_RATE, \
-			   GENMASK(31, 28)); \
-} while (0)
+static inline void SET_CMC_TBL_RTS_RTY_LOWEST_RATE(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 2, val, GENMASK(31, 28));
+	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_RTS_RTY_LOWEST_RATE,
+			   GENMASK(31, 28));
+}
 #define SET_CMC_TBL_MASK_DATA_TX_CNT_LMT GENMASK(5, 0)
-#define SET_CMC_TBL_DATA_TX_CNT_LMT(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(5, 0)); \
-	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_DATA_TX_CNT_LMT, \
-			   GENMASK(5, 0)); \
-} while (0)
+static inline void SET_CMC_TBL_DATA_TX_CNT_LMT(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(5, 0));
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_DATA_TX_CNT_LMT,
+			   GENMASK(5, 0));
+}
 #define SET_CMC_TBL_MASK_DATA_TXCNT_LMT_SEL BIT(0)
-#define SET_CMC_TBL_DATA_TXCNT_LMT_SEL(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(6)); \
-	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_DATA_TXCNT_LMT_SEL, \
-			   BIT(6)); \
-} while (0)
+static inline void SET_CMC_TBL_DATA_TXCNT_LMT_SEL(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(6));
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_DATA_TXCNT_LMT_SEL,
+			   BIT(6));
+}
 #define SET_CMC_TBL_MASK_MAX_AGG_NUM_SEL BIT(0)
-#define SET_CMC_TBL_MAX_AGG_NUM_SEL(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(7)); \
-	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_MAX_AGG_NUM_SEL, \
-			   BIT(7)); \
-} while (0)
+static inline void SET_CMC_TBL_MAX_AGG_NUM_SEL(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(7));
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_MAX_AGG_NUM_SEL,
+			   BIT(7));
+}
 #define SET_CMC_TBL_MASK_RTS_EN BIT(0)
-#define SET_CMC_TBL_RTS_EN(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(8)); \
-	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_RTS_EN, \
-			   BIT(8)); \
-} while (0)
+static inline void SET_CMC_TBL_RTS_EN(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(8));
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_RTS_EN,
+			   BIT(8));
+}
 #define SET_CMC_TBL_MASK_CTS2SELF_EN BIT(0)
-#define SET_CMC_TBL_CTS2SELF_EN(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(9)); \
-	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_CTS2SELF_EN, \
-			   BIT(9)); \
-} while (0)
+static inline void SET_CMC_TBL_CTS2SELF_EN(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(9));
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_CTS2SELF_EN,
+			   BIT(9));
+}
 #define SET_CMC_TBL_MASK_CCA_RTS GENMASK(1, 0)
-#define SET_CMC_TBL_CCA_RTS(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(11, 10)); \
-	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_CCA_RTS, \
-			   GENMASK(11, 10)); \
-} while (0)
+static inline void SET_CMC_TBL_CCA_RTS(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(11, 10));
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_CCA_RTS,
+			   GENMASK(11, 10));
+}
 #define SET_CMC_TBL_MASK_HW_RTS_EN BIT(0)
-#define SET_CMC_TBL_HW_RTS_EN(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(12)); \
-	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_HW_RTS_EN, \
-			   BIT(12)); \
-} while (0)
+static inline void SET_CMC_TBL_HW_RTS_EN(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(12));
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_HW_RTS_EN,
+			   BIT(12));
+}
 #define SET_CMC_TBL_MASK_RTS_DROP_DATA_MODE GENMASK(1, 0)
-#define SET_CMC_TBL_RTS_DROP_DATA_MODE(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(14, 13)); \
-	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_RTS_DROP_DATA_MODE, \
-			   GENMASK(14, 13)); \
-} while (0)
+static inline void SET_CMC_TBL_RTS_DROP_DATA_MODE(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(14, 13));
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_RTS_DROP_DATA_MODE,
+			   GENMASK(14, 13));
+}
 #define SET_CMC_TBL_MASK_AMPDU_MAX_LEN GENMASK(10, 0)
-#define SET_CMC_TBL_AMPDU_MAX_LEN(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(26, 16)); \
-	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_AMPDU_MAX_LEN, \
-			   GENMASK(26, 16)); \
-} while (0)
+static inline void SET_CMC_TBL_AMPDU_MAX_LEN(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(26, 16));
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_AMPDU_MAX_LEN,
+			   GENMASK(26, 16));
+}
 #define SET_CMC_TBL_MASK_UL_MU_DIS BIT(0)
-#define SET_CMC_TBL_UL_MU_DIS(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(27)); \
-	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_UL_MU_DIS, \
-			   BIT(27)); \
-} while (0)
+static inline void SET_CMC_TBL_UL_MU_DIS(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(27));
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_UL_MU_DIS,
+			   BIT(27));
+}
 #define SET_CMC_TBL_MASK_AMPDU_MAX_TIME GENMASK(3, 0)
-#define SET_CMC_TBL_AMPDU_MAX_TIME(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(31, 28)); \
-	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_AMPDU_MAX_TIME, \
-			   GENMASK(31, 28)); \
-} while (0)
+static inline void SET_CMC_TBL_AMPDU_MAX_TIME(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(31, 28));
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_AMPDU_MAX_TIME,
+			   GENMASK(31, 28));
+}
 #define SET_CMC_TBL_MASK_MAX_AGG_NUM GENMASK(7, 0)
-#define SET_CMC_TBL_MAX_AGG_NUM(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(7, 0)); \
-	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_MAX_AGG_NUM, \
-			   GENMASK(7, 0)); \
-} while (0)
+static inline void SET_CMC_TBL_MAX_AGG_NUM(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(7, 0));
+	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_MAX_AGG_NUM,
+			   GENMASK(7, 0));
+}
 #define SET_CMC_TBL_MASK_BA_BMAP GENMASK(1, 0)
-#define SET_CMC_TBL_BA_BMAP(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(9, 8)); \
-	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_BA_BMAP, \
-			   GENMASK(9, 8)); \
-} while (0)
+static inline void SET_CMC_TBL_BA_BMAP(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(9, 8));
+	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_BA_BMAP,
+			   GENMASK(9, 8));
+}
 #define SET_CMC_TBL_MASK_VO_LFTIME_SEL GENMASK(2, 0)
-#define SET_CMC_TBL_VO_LFTIME_SEL(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(18, 16)); \
-	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_VO_LFTIME_SEL, \
-			   GENMASK(18, 16)); \
-} while (0)
+static inline void SET_CMC_TBL_VO_LFTIME_SEL(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(18, 16));
+	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_VO_LFTIME_SEL,
+			   GENMASK(18, 16));
+}
 #define SET_CMC_TBL_MASK_VI_LFTIME_SEL GENMASK(2, 0)
-#define SET_CMC_TBL_VI_LFTIME_SEL(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(21, 19)); \
-	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_VI_LFTIME_SEL, \
-			   GENMASK(21, 19)); \
-} while (0)
+static inline void SET_CMC_TBL_VI_LFTIME_SEL(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(21, 19));
+	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_VI_LFTIME_SEL,
+			   GENMASK(21, 19));
+}
 #define SET_CMC_TBL_MASK_BE_LFTIME_SEL GENMASK(2, 0)
-#define SET_CMC_TBL_BE_LFTIME_SEL(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(24, 22)); \
-	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_BE_LFTIME_SEL, \
-			   GENMASK(24, 22)); \
-} while (0)
+static inline void SET_CMC_TBL_BE_LFTIME_SEL(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(24, 22));
+	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_BE_LFTIME_SEL,
+			   GENMASK(24, 22));
+}
 #define SET_CMC_TBL_MASK_BK_LFTIME_SEL GENMASK(2, 0)
-#define SET_CMC_TBL_BK_LFTIME_SEL(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(27, 25)); \
-	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_BK_LFTIME_SEL, \
-			   GENMASK(27, 25)); \
-} while (0)
+static inline void SET_CMC_TBL_BK_LFTIME_SEL(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(27, 25));
+	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_BK_LFTIME_SEL,
+			   GENMASK(27, 25));
+}
 #define SET_CMC_TBL_MASK_SECTYPE GENMASK(3, 0)
-#define SET_CMC_TBL_SECTYPE(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(31, 28)); \
-	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_SECTYPE, \
-			   GENMASK(31, 28)); \
-} while (0)
+static inline void SET_CMC_TBL_SECTYPE(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(31, 28));
+	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_SECTYPE,
+			   GENMASK(31, 28));
+}
 #define SET_CMC_TBL_MASK_MULTI_PORT_ID GENMASK(2, 0)
-#define SET_CMC_TBL_MULTI_PORT_ID(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(2, 0)); \
-	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_MULTI_PORT_ID, \
-			   GENMASK(2, 0)); \
-} while (0)
+static inline void SET_CMC_TBL_MULTI_PORT_ID(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(2, 0));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_MULTI_PORT_ID,
+			   GENMASK(2, 0));
+}
 #define SET_CMC_TBL_MASK_BMC BIT(0)
-#define SET_CMC_TBL_BMC(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(3)); \
-	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_BMC, \
-			   BIT(3)); \
-} while (0)
+static inline void SET_CMC_TBL_BMC(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(3));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_BMC,
+			   BIT(3));
+}
 #define SET_CMC_TBL_MASK_MBSSID GENMASK(3, 0)
-#define SET_CMC_TBL_MBSSID(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(7, 4)); \
-	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_MBSSID, \
-			   GENMASK(7, 4)); \
-} while (0)
+static inline void SET_CMC_TBL_MBSSID(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(7, 4));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_MBSSID,
+			   GENMASK(7, 4));
+}
 #define SET_CMC_TBL_MASK_NAVUSEHDR BIT(0)
-#define SET_CMC_TBL_NAVUSEHDR(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(8)); \
-	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_NAVUSEHDR, \
-			   BIT(8)); \
-} while (0)
+static inline void SET_CMC_TBL_NAVUSEHDR(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(8));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_NAVUSEHDR,
+			   BIT(8));
+}
 #define SET_CMC_TBL_MASK_TXPWR_MODE GENMASK(2, 0)
-#define SET_CMC_TBL_TXPWR_MODE(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(11, 9)); \
-	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_TXPWR_MODE, \
-			   GENMASK(11, 9)); \
-} while (0)
+static inline void SET_CMC_TBL_TXPWR_MODE(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(11, 9));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_TXPWR_MODE,
+			   GENMASK(11, 9));
+}
 #define SET_CMC_TBL_MASK_DATA_DCM BIT(0)
-#define SET_CMC_TBL_DATA_DCM(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(12)); \
-	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_DATA_DCM, \
-			   BIT(12)); \
-} while (0)
+static inline void SET_CMC_TBL_DATA_DCM(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(12));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_DATA_DCM,
+			   BIT(12));
+}
 #define SET_CMC_TBL_MASK_DATA_ER BIT(0)
-#define SET_CMC_TBL_DATA_ER(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(13)); \
-	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_DATA_ER, \
-			   BIT(13)); \
-} while (0)
+static inline void SET_CMC_TBL_DATA_ER(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(13));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_DATA_ER,
+			   BIT(13));
+}
 #define SET_CMC_TBL_MASK_DATA_LDPC BIT(0)
-#define SET_CMC_TBL_DATA_LDPC(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(14)); \
-	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_DATA_LDPC, \
-			   BIT(14)); \
-} while (0)
+static inline void SET_CMC_TBL_DATA_LDPC(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(14));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_DATA_LDPC,
+			   BIT(14));
+}
 #define SET_CMC_TBL_MASK_DATA_STBC BIT(0)
-#define SET_CMC_TBL_DATA_STBC(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(15)); \
-	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_DATA_STBC, \
-			   BIT(15)); \
-} while (0)
+static inline void SET_CMC_TBL_DATA_STBC(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(15));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_DATA_STBC,
+			   BIT(15));
+}
 #define SET_CMC_TBL_MASK_A_CTRL_BQR BIT(0)
-#define SET_CMC_TBL_A_CTRL_BQR(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(16)); \
-	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_A_CTRL_BQR, \
-			   BIT(16)); \
-} while (0)
+static inline void SET_CMC_TBL_A_CTRL_BQR(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(16));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_A_CTRL_BQR,
+			   BIT(16));
+}
 #define SET_CMC_TBL_MASK_A_CTRL_UPH BIT(0)
-#define SET_CMC_TBL_A_CTRL_UPH(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(17)); \
-	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_A_CTRL_UPH, \
-			   BIT(17)); \
-} while (0)
+static inline void SET_CMC_TBL_A_CTRL_UPH(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(17));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_A_CTRL_UPH,
+			   BIT(17));
+}
 #define SET_CMC_TBL_MASK_A_CTRL_BSR BIT(0)
-#define SET_CMC_TBL_A_CTRL_BSR(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(18)); \
-	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_A_CTRL_BSR, \
-			   BIT(18)); \
-} while (0)
+static inline void SET_CMC_TBL_A_CTRL_BSR(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(18));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_A_CTRL_BSR,
+			   BIT(18));
+}
 #define SET_CMC_TBL_MASK_A_CTRL_CAS BIT(0)
-#define SET_CMC_TBL_A_CTRL_CAS(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(19)); \
-	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_A_CTRL_CAS, \
-			   BIT(19)); \
-} while (0)
+static inline void SET_CMC_TBL_A_CTRL_CAS(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(19));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_A_CTRL_CAS,
+			   BIT(19));
+}
 #define SET_CMC_TBL_MASK_DATA_BW_ER BIT(0)
-#define SET_CMC_TBL_DATA_BW_ER(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(20)); \
-	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_DATA_BW_ER, \
-			   BIT(20)); \
-} while (0)
+static inline void SET_CMC_TBL_DATA_BW_ER(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(20));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_DATA_BW_ER,
+			   BIT(20));
+}
 #define SET_CMC_TBL_MASK_LSIG_TXOP_EN BIT(0)
-#define SET_CMC_TBL_LSIG_TXOP_EN(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(21)); \
-	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_LSIG_TXOP_EN, \
-			   BIT(21)); \
-} while (0)
+static inline void SET_CMC_TBL_LSIG_TXOP_EN(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(21));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_LSIG_TXOP_EN,
+			   BIT(21));
+}
 #define SET_CMC_TBL_MASK_CTRL_CNT_VLD BIT(0)
-#define SET_CMC_TBL_CTRL_CNT_VLD(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(27)); \
-	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_CTRL_CNT_VLD, \
-			   BIT(27)); \
-} while (0)
+static inline void SET_CMC_TBL_CTRL_CNT_VLD(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(27));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_CTRL_CNT_VLD,
+			   BIT(27));
+}
 #define SET_CMC_TBL_MASK_CTRL_CNT GENMASK(3, 0)
-#define SET_CMC_TBL_CTRL_CNT(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(31, 28)); \
-	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_CTRL_CNT, \
-			   GENMASK(31, 28)); \
-} while (0)
+static inline void SET_CMC_TBL_CTRL_CNT(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(31, 28));
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_CTRL_CNT,
+			   GENMASK(31, 28));
+}
 #define SET_CMC_TBL_MASK_RESP_REF_RATE GENMASK(8, 0)
-#define SET_CMC_TBL_RESP_REF_RATE(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(8, 0)); \
-	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_RESP_REF_RATE, \
-			   GENMASK(8, 0)); \
-} while (0)
+static inline void SET_CMC_TBL_RESP_REF_RATE(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(8, 0));
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_RESP_REF_RATE,
+			   GENMASK(8, 0));
+}
 #define SET_CMC_TBL_MASK_ALL_ACK_SUPPORT BIT(0)
-#define SET_CMC_TBL_ALL_ACK_SUPPORT(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(12)); \
-	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_ALL_ACK_SUPPORT, \
-			   BIT(12)); \
-} while (0)
+static inline void SET_CMC_TBL_ALL_ACK_SUPPORT(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(12));
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_ALL_ACK_SUPPORT,
+			   BIT(12));
+}
 #define SET_CMC_TBL_MASK_BSR_QUEUE_SIZE_FORMAT BIT(0)
-#define SET_CMC_TBL_BSR_QUEUE_SIZE_FORMAT(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(13)); \
-	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_BSR_QUEUE_SIZE_FORMAT, \
-			   BIT(13)); \
-} while (0)
+static inline void SET_CMC_TBL_BSR_QUEUE_SIZE_FORMAT(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(13));
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_BSR_QUEUE_SIZE_FORMAT,
+			   BIT(13));
+}
 #define SET_CMC_TBL_MASK_NTX_PATH_EN GENMASK(3, 0)
-#define SET_CMC_TBL_NTX_PATH_EN(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(19, 16)); \
-	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_NTX_PATH_EN, \
-			   GENMASK(19, 16)); \
-} while (0)
+static inline void SET_CMC_TBL_NTX_PATH_EN(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(19, 16));
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_NTX_PATH_EN,
+			   GENMASK(19, 16));
+}
 #define SET_CMC_TBL_MASK_PATH_MAP_A GENMASK(1, 0)
-#define SET_CMC_TBL_PATH_MAP_A(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(21, 20)); \
-	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_PATH_MAP_A, \
-			   GENMASK(21, 20)); \
-} while (0)
+static inline void SET_CMC_TBL_PATH_MAP_A(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(21, 20));
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_PATH_MAP_A,
+			   GENMASK(21, 20));
+}
 #define SET_CMC_TBL_MASK_PATH_MAP_B GENMASK(1, 0)
-#define SET_CMC_TBL_PATH_MAP_B(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(23, 22)); \
-	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_PATH_MAP_B, \
-			   GENMASK(23, 22)); \
-} while (0)
+static inline void SET_CMC_TBL_PATH_MAP_B(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(23, 22));
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_PATH_MAP_B,
+			   GENMASK(23, 22));
+}
 #define SET_CMC_TBL_MASK_PATH_MAP_C GENMASK(1, 0)
-#define SET_CMC_TBL_PATH_MAP_C(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(25, 24)); \
-	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_PATH_MAP_C, \
-			   GENMASK(25, 24)); \
-} while (0)
+static inline void SET_CMC_TBL_PATH_MAP_C(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(25, 24));
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_PATH_MAP_C,
+			   GENMASK(25, 24));
+}
 #define SET_CMC_TBL_MASK_PATH_MAP_D GENMASK(1, 0)
-#define SET_CMC_TBL_PATH_MAP_D(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(27, 26)); \
-	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_PATH_MAP_D, \
-			   GENMASK(27, 26)); \
-} while (0)
+static inline void SET_CMC_TBL_PATH_MAP_D(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(27, 26));
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_PATH_MAP_D,
+			   GENMASK(27, 26));
+}
 #define SET_CMC_TBL_MASK_ANTSEL_A BIT(0)
-#define SET_CMC_TBL_ANTSEL_A(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(28)); \
-	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_ANTSEL_A, \
-			   BIT(28)); \
-} while (0)
+static inline void SET_CMC_TBL_ANTSEL_A(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(28));
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_ANTSEL_A,
+			   BIT(28));
+}
 #define SET_CMC_TBL_MASK_ANTSEL_B BIT(0)
-#define SET_CMC_TBL_ANTSEL_B(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(29)); \
-	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_ANTSEL_B, \
-			   BIT(29)); \
-} while (0)
+static inline void SET_CMC_TBL_ANTSEL_B(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(29));
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_ANTSEL_B,
+			   BIT(29));
+}
 #define SET_CMC_TBL_MASK_ANTSEL_C BIT(0)
-#define SET_CMC_TBL_ANTSEL_C(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(30)); \
-	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_ANTSEL_C, \
-			   BIT(30)); \
-} while (0)
+static inline void SET_CMC_TBL_ANTSEL_C(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(30));
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_ANTSEL_C,
+			   BIT(30));
+}
 #define SET_CMC_TBL_MASK_ANTSEL_D BIT(0)
-#define SET_CMC_TBL_ANTSEL_D(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(31)); \
-	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_ANTSEL_D, \
-			   BIT(31)); \
-} while (0)
+static inline void SET_CMC_TBL_ANTSEL_D(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(31));
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_ANTSEL_D,
+			   BIT(31));
+}
 #define SET_CMC_TBL_MASK_ADDR_CAM_INDEX GENMASK(7, 0)
-#define SET_CMC_TBL_ADDR_CAM_INDEX(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(7, 0)); \
-	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_ADDR_CAM_INDEX, \
-			   GENMASK(7, 0)); \
-} while (0)
+static inline void SET_CMC_TBL_ADDR_CAM_INDEX(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(7, 0));
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_ADDR_CAM_INDEX,
+			   GENMASK(7, 0));
+}
 #define SET_CMC_TBL_MASK_PAID GENMASK(8, 0)
-#define SET_CMC_TBL_PAID(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(16, 8)); \
-	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_PAID, \
-			   GENMASK(16, 8)); \
-} while (0)
+static inline void SET_CMC_TBL_PAID(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(16, 8));
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_PAID,
+			   GENMASK(16, 8));
+}
 #define SET_CMC_TBL_MASK_ULDL BIT(0)
-#define SET_CMC_TBL_ULDL(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 7, val, BIT(17)); \
-	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_ULDL, \
-			   BIT(17)); \
-} while (0)
+static inline void SET_CMC_TBL_ULDL(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 7, val, BIT(17));
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_ULDL,
+			   BIT(17));
+}
 #define SET_CMC_TBL_MASK_DOPPLER_CTRL GENMASK(1, 0)
-#define SET_CMC_TBL_DOPPLER_CTRL(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(19, 18)); \
-	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_DOPPLER_CTRL, \
-			   GENMASK(19, 18)); \
-} while (0)
+static inline void SET_CMC_TBL_DOPPLER_CTRL(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(19, 18));
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_DOPPLER_CTRL,
+			   GENMASK(19, 18));
+}
 #define SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING GENMASK(1, 0)
-#define SET_CMC_TBL_NOMINAL_PKT_PADDING(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(21, 20)); \
-	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING, \
-			   GENMASK(21, 20)); \
-} while (0)
-#define SET_CMC_TBL_NOMINAL_PKT_PADDING40(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(23, 22)); \
-	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING, \
-			   GENMASK(23, 22)); \
-} while (0)
+static inline void SET_CMC_TBL_NOMINAL_PKT_PADDING(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(21, 20));
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING,
+			   GENMASK(21, 20));
+}
+
+static inline void SET_CMC_TBL_NOMINAL_PKT_PADDING40(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(23, 22));
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING,
+			   GENMASK(23, 22));
+}
 #define SET_CMC_TBL_MASK_TXPWR_TOLERENCE GENMASK(3, 0)
-#define SET_CMC_TBL_TXPWR_TOLERENCE(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(27, 24)); \
-	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_TXPWR_TOLERENCE, \
-			   GENMASK(27, 24)); \
-} while (0)
-#define SET_CMC_TBL_NOMINAL_PKT_PADDING80(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(31, 30)); \
-	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING, \
-			   GENMASK(31, 30)); \
-} while (0)
+static inline void SET_CMC_TBL_TXPWR_TOLERENCE(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(27, 24));
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_TXPWR_TOLERENCE,
+			   GENMASK(27, 24));
+}
+
+static inline void SET_CMC_TBL_NOMINAL_PKT_PADDING80(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(31, 30));
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING,
+			   GENMASK(31, 30));
+}
 #define SET_CMC_TBL_MASK_NC GENMASK(2, 0)
-#define SET_CMC_TBL_NC(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(2, 0)); \
-	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_NC, \
-			   GENMASK(2, 0)); \
-} while (0)
+static inline void SET_CMC_TBL_NC(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(2, 0));
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_NC,
+			   GENMASK(2, 0));
+}
 #define SET_CMC_TBL_MASK_NR GENMASK(2, 0)
-#define SET_CMC_TBL_NR(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(5, 3)); \
-	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_NR, \
-			   GENMASK(5, 3)); \
-} while (0)
+static inline void SET_CMC_TBL_NR(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(5, 3));
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_NR,
+			   GENMASK(5, 3));
+}
 #define SET_CMC_TBL_MASK_NG GENMASK(1, 0)
-#define SET_CMC_TBL_NG(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(7, 6)); \
-	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_NG, \
-			   GENMASK(7, 6)); \
-} while (0)
+static inline void SET_CMC_TBL_NG(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(7, 6));
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_NG,
+			   GENMASK(7, 6));
+}
 #define SET_CMC_TBL_MASK_CB GENMASK(1, 0)
-#define SET_CMC_TBL_CB(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(9, 8)); \
-	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CB, \
-			   GENMASK(9, 8)); \
-} while (0)
+static inline void SET_CMC_TBL_CB(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(9, 8));
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CB,
+			   GENMASK(9, 8));
+}
 #define SET_CMC_TBL_MASK_CS GENMASK(1, 0)
-#define SET_CMC_TBL_CS(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(11, 10)); \
-	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CS, \
-			   GENMASK(11, 10)); \
-} while (0)
+static inline void SET_CMC_TBL_CS(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(11, 10));
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CS,
+			   GENMASK(11, 10));
+}
 #define SET_CMC_TBL_MASK_CSI_TXBF_EN BIT(0)
-#define SET_CMC_TBL_CSI_TXBF_EN(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 8, val, BIT(12)); \
-	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_TXBF_EN, \
-			   BIT(12)); \
-} while (0)
+static inline void SET_CMC_TBL_CSI_TXBF_EN(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 8, val, BIT(12));
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_TXBF_EN,
+			   BIT(12));
+}
 #define SET_CMC_TBL_MASK_CSI_STBC_EN BIT(0)
-#define SET_CMC_TBL_CSI_STBC_EN(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 8, val, BIT(13)); \
-	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_STBC_EN, \
-			   BIT(13)); \
-} while (0)
+static inline void SET_CMC_TBL_CSI_STBC_EN(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 8, val, BIT(13));
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_STBC_EN,
+			   BIT(13));
+}
 #define SET_CMC_TBL_MASK_CSI_LDPC_EN BIT(0)
-#define SET_CMC_TBL_CSI_LDPC_EN(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 8, val, BIT(14)); \
-	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_LDPC_EN, \
-			   BIT(14)); \
-} while (0)
+static inline void SET_CMC_TBL_CSI_LDPC_EN(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 8, val, BIT(14));
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_LDPC_EN,
+			   BIT(14));
+}
 #define SET_CMC_TBL_MASK_CSI_PARA_EN BIT(0)
-#define SET_CMC_TBL_CSI_PARA_EN(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 8, val, BIT(15)); \
-	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_PARA_EN, \
-			   BIT(15)); \
-} while (0)
+static inline void SET_CMC_TBL_CSI_PARA_EN(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 8, val, BIT(15));
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_PARA_EN,
+			   BIT(15));
+}
 #define SET_CMC_TBL_MASK_CSI_FIX_RATE GENMASK(8, 0)
-#define SET_CMC_TBL_CSI_FIX_RATE(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(24, 16)); \
-	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_FIX_RATE, \
-			   GENMASK(24, 16)); \
-} while (0)
+static inline void SET_CMC_TBL_CSI_FIX_RATE(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(24, 16));
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_FIX_RATE,
+			   GENMASK(24, 16));
+}
 #define SET_CMC_TBL_MASK_CSI_GI_LTF GENMASK(2, 0)
-#define SET_CMC_TBL_CSI_GI_LTF(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(27, 25)); \
-	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_GI_LTF, \
-			   GENMASK(27, 25)); \
-} while (0)
+static inline void SET_CMC_TBL_CSI_GI_LTF(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(27, 25));
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_GI_LTF,
+			   GENMASK(27, 25));
+}
 #define SET_CMC_TBL_MASK_CSI_GID_SEL BIT(0)
-#define SET_CMC_TBL_CSI_GID_SEL(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 8, val, BIT(29)); \
-	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_GID_SEL, \
-			   BIT(29)); \
-} while (0)
+static inline void SET_CMC_TBL_CSI_GID_SEL(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 8, val, BIT(29));
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_GID_SEL,
+			   BIT(29));
+}
 #define SET_CMC_TBL_MASK_CSI_BW GENMASK(1, 0)
-#define SET_CMC_TBL_CSI_BW(table, val) \
-do { \
-	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(31, 30)); \
-	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_BW, \
-			   GENMASK(31, 30)); \
-} while (0)
+static inline void SET_CMC_TBL_CSI_BW(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(31, 30));
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_BW,
+			   GENMASK(31, 30));
+}
 
 #define SET_FWROLE_MAINTAIN_MACID(h2c, val) \
 	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 0))
@@ -1054,72 +1190,165 @@ enum rtw89_btc_cxdrvinfo {
 	CXDRVINFO_MAX,
 };
 
-#define RTW89_SET_FWCMD_CXHDR_TYPE(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 0, val, GENMASK(7, 0))
-#define RTW89_SET_FWCMD_CXHDR_LEN(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 1, val, GENMASK(7, 0))
-
-#define RTW89_SET_FWCMD_CXINIT_ANT_TYPE(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 2, val, GENMASK(7, 0))
-#define RTW89_SET_FWCMD_CXINIT_ANT_NUM(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 3, val, GENMASK(7, 0))
-#define RTW89_SET_FWCMD_CXINIT_ANT_ISO(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 4, val, GENMASK(7, 0))
-#define RTW89_SET_FWCMD_CXINIT_ANT_POS(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 5, val, BIT(0))
-#define RTW89_SET_FWCMD_CXINIT_ANT_DIVERSITY(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 5, val, BIT(1))
-#define RTW89_SET_FWCMD_CXINIT_MOD_RFE(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 6, val, GENMASK(7, 0))
-#define RTW89_SET_FWCMD_CXINIT_MOD_CV(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 7, val, GENMASK(7, 0))
-#define RTW89_SET_FWCMD_CXINIT_MOD_BT_SOLO(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 8, val, BIT(0))
-#define RTW89_SET_FWCMD_CXINIT_MOD_BT_POS(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 8, val, BIT(1))
-#define RTW89_SET_FWCMD_CXINIT_MOD_SW_TYPE(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 8, val, BIT(2))
-#define RTW89_SET_FWCMD_CXINIT_WL_GCH(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 10, val, GENMASK(7, 0))
-#define RTW89_SET_FWCMD_CXINIT_WL_ONLY(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 11, val, BIT(0))
-#define RTW89_SET_FWCMD_CXINIT_WL_INITOK(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 11, val, BIT(1))
-#define RTW89_SET_FWCMD_CXINIT_DBCC_EN(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 11, val, BIT(2))
-#define RTW89_SET_FWCMD_CXINIT_CX_OTHER(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 11, val, BIT(3))
-#define RTW89_SET_FWCMD_CXINIT_BT_ONLY(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 11, val, BIT(4))
-
-#define RTW89_SET_FWCMD_CXROLE_CONNECT_CNT(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 2, val, GENMASK(7, 0))
-#define RTW89_SET_FWCMD_CXROLE_LINK_MODE(cmd, val) \
-	u8p_replace_bits((u8 *)(cmd) + 3, val, GENMASK(7, 0))
-#define RTW89_SET_FWCMD_CXROLE_ROLE_NONE(cmd, val) \
-	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(0))
-#define RTW89_SET_FWCMD_CXROLE_ROLE_STA(cmd, val) \
-	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(1))
-#define RTW89_SET_FWCMD_CXROLE_ROLE_AP(cmd, val) \
-	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(2))
-#define RTW89_SET_FWCMD_CXROLE_ROLE_VAP(cmd, val) \
-	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(3))
-#define RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC(cmd, val) \
-	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(4))
-#define RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC_MASTER(cmd, val) \
-	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(5))
-#define RTW89_SET_FWCMD_CXROLE_ROLE_MESH(cmd, val) \
-	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(6))
-#define RTW89_SET_FWCMD_CXROLE_ROLE_MONITOR(cmd, val) \
-	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(7))
-#define RTW89_SET_FWCMD_CXROLE_ROLE_P2P_DEV(cmd, val) \
-	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(8))
-#define RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GC(cmd, val) \
-	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(9))
-#define RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GO(cmd, val) \
-	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(10))
-#define RTW89_SET_FWCMD_CXROLE_ROLE_NAN(cmd, val) \
-	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(11))
+static inline void RTW89_SET_FWCMD_CXHDR_TYPE(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 0, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXHDR_LEN(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 1, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXINIT_ANT_TYPE(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 2, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXINIT_ANT_NUM(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 3, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXINIT_ANT_ISO(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 4, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXINIT_ANT_POS(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 5, val, BIT(0));
+}
+
+static inline void RTW89_SET_FWCMD_CXINIT_ANT_DIVERSITY(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 5, val, BIT(1));
+}
+
+static inline void RTW89_SET_FWCMD_CXINIT_MOD_RFE(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 6, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXINIT_MOD_CV(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 7, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXINIT_MOD_BT_SOLO(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 8, val, BIT(0));
+}
+
+static inline void RTW89_SET_FWCMD_CXINIT_MOD_BT_POS(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 8, val, BIT(1));
+}
+
+static inline void RTW89_SET_FWCMD_CXINIT_MOD_SW_TYPE(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 8, val, BIT(2));
+}
+
+static inline void RTW89_SET_FWCMD_CXINIT_WL_GCH(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 10, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXINIT_WL_ONLY(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 11, val, BIT(0));
+}
+
+static inline void RTW89_SET_FWCMD_CXINIT_WL_INITOK(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 11, val, BIT(1));
+}
+
+static inline void RTW89_SET_FWCMD_CXINIT_DBCC_EN(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 11, val, BIT(2));
+}
+
+static inline void RTW89_SET_FWCMD_CXINIT_CX_OTHER(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 11, val, BIT(3));
+}
+
+static inline void RTW89_SET_FWCMD_CXINIT_BT_ONLY(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 11, val, BIT(4));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_CONNECT_CNT(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 2, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_LINK_MODE(void *cmd, u32 val)
+{
+	u8p_replace_bits((u8 *)(cmd) + 3, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ROLE_NONE(void *cmd, u32 val)
+{
+	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(0));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ROLE_STA(void *cmd, u32 val)
+{
+	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(1));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ROLE_AP(void *cmd, u32 val)
+{
+	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(2));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ROLE_VAP(void *cmd, u32 val)
+{
+	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(3));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC(void *cmd, u32 val)
+{
+	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(4));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ROLE_ADHOC_MASTER(void *cmd, u32 val)
+{
+	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(5));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ROLE_MESH(void *cmd, u32 val)
+{
+	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(6));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ROLE_MONITOR(void *cmd, u32 val)
+{
+	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(7));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ROLE_P2P_DEV(void *cmd, u32 val)
+{
+	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(8));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GC(void *cmd, u32 val)
+{
+	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(9));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ROLE_P2P_GO(void *cmd, u32 val)
+{
+	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(10));
+}
+
+static inline void RTW89_SET_FWCMD_CXROLE_ROLE_NAN(void *cmd, u32 val)
+{
+	le16p_replace_bits((__le16 *)((u8 *)(cmd) + 4), val, BIT(11));
+}
 #define RTW89_SET_FWCMD_CXROLE_ACT_CONNECTED(cmd, val, n) \
 	u8p_replace_bits((u8 *)(cmd) + (6 + 12 * (n)), val, BIT(0))
 #define RTW89_SET_FWCMD_CXROLE_ACT_PID(cmd, val, n) \
@@ -1147,25 +1376,50 @@ enum rtw89_btc_cxdrvinfo {
 #define RTW89_SET_FWCMD_CXROLE_ACT_RX_RATE(cmd, val, n) \
 	le16p_replace_bits((__le16 *)((u8 *)(cmd) + (16 + 12 * (n))), val, GENMASK(15, 0))
 
-#define RTW89_SET_FWCMD_CXCTRL_MANUAL(cmd, val) \
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, BIT(0))
-#define RTW89_SET_FWCMD_CXCTRL_IGNORE_BT(cmd, val) \
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, BIT(1))
-#define RTW89_SET_FWCMD_CXCTRL_ALWAYS_FREERUN(cmd, val) \
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, BIT(2))
-#define RTW89_SET_FWCMD_CXCTRL_TRACE_STEP(cmd, val) \
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(18, 3))
-
-#define RTW89_SET_FWCMD_CXRFK_STATE(cmd, val) \
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(1, 0))
-#define RTW89_SET_FWCMD_CXRFK_PATH_MAP(cmd, val) \
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(5, 2))
-#define RTW89_SET_FWCMD_CXRFK_PHY_MAP(cmd, val) \
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(7, 6))
-#define RTW89_SET_FWCMD_CXRFK_BAND(cmd, val) \
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(9, 8))
-#define RTW89_SET_FWCMD_CXRFK_TYPE(cmd, val) \
-	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(17, 10))
+static inline void RTW89_SET_FWCMD_CXCTRL_MANUAL(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, BIT(0));
+}
+
+static inline void RTW89_SET_FWCMD_CXCTRL_IGNORE_BT(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, BIT(1));
+}
+
+static inline void RTW89_SET_FWCMD_CXCTRL_ALWAYS_FREERUN(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, BIT(2));
+}
+
+static inline void RTW89_SET_FWCMD_CXCTRL_TRACE_STEP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(18, 3));
+}
+
+static inline void RTW89_SET_FWCMD_CXRFK_STATE(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(1, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXRFK_PATH_MAP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(5, 2));
+}
+
+static inline void RTW89_SET_FWCMD_CXRFK_PHY_MAP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(7, 6));
+}
+
+static inline void RTW89_SET_FWCMD_CXRFK_BAND(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(9, 8));
+}
+
+static inline void RTW89_SET_FWCMD_CXRFK_TYPE(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(17, 10));
+}
 
 #define RTW89_C2H_HEADER_LEN 8
 
-- 
2.25.1

