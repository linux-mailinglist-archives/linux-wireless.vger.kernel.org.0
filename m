Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BA94B1FC4
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 09:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347875AbiBKIAh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 03:00:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347873AbiBKIAb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 03:00:31 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDAABC4
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 00:00:29 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21B80HSl8023903, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21B80HSl8023903
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Feb 2022 16:00:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Feb 2022 16:00:17 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 11 Feb
 2022 16:00:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 1/6] rtw89: make rfk helpers common across chips
Date:   Fri, 11 Feb 2022 15:59:48 +0800
Message-ID: <20220211075953.40421-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211075953.40421-1-pkshih@realtek.com>
References: <20220211075953.40421-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/11/2022 07:45:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMTEgpFekyCAwNjowMDowMA==?=
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

These rfk helpers are also useful for the chip which is under planning.
So, move them to common code to avoid duplicate stuff in the future.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c      | 52 ++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      | 59 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c | 60 -------------------
 .../realtek/rtw89/rtw8852a_rfk_table.h        | 49 +--------------
 4 files changed, 112 insertions(+), 108 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 130db2f46f49e..c491a11536815 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3037,3 +3037,55 @@ void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif
 	rtw89_phy_write32_idx(rtwdev, R_BSS_CLR_MAP, B_BSS_CLR_MAP_STAID,
 			      vif->bss_conf.aid, phy_idx);
 }
+
+static void
+_rfk_write_rf(struct rtw89_dev *rtwdev, const struct rtw89_reg5_def *def)
+{
+	rtw89_write_rf(rtwdev, def->path, def->addr, def->mask, def->data);
+}
+
+static void
+_rfk_write32_mask(struct rtw89_dev *rtwdev, const struct rtw89_reg5_def *def)
+{
+	rtw89_phy_write32_mask(rtwdev, def->addr, def->mask, def->data);
+}
+
+static void
+_rfk_write32_set(struct rtw89_dev *rtwdev, const struct rtw89_reg5_def *def)
+{
+	rtw89_phy_write32_set(rtwdev, def->addr, def->mask);
+}
+
+static void
+_rfk_write32_clr(struct rtw89_dev *rtwdev, const struct rtw89_reg5_def *def)
+{
+	rtw89_phy_write32_clr(rtwdev, def->addr, def->mask);
+}
+
+static void
+_rfk_delay(struct rtw89_dev *rtwdev, const struct rtw89_reg5_def *def)
+{
+	udelay(def->data);
+}
+
+static void
+(*_rfk_handler[])(struct rtw89_dev *rtwdev, const struct rtw89_reg5_def *def) = {
+	[RTW89_RFK_F_WRF] = _rfk_write_rf,
+	[RTW89_RFK_F_WM] = _rfk_write32_mask,
+	[RTW89_RFK_F_WS] = _rfk_write32_set,
+	[RTW89_RFK_F_WC] = _rfk_write32_clr,
+	[RTW89_RFK_F_DELAY] = _rfk_delay,
+};
+
+static_assert(ARRAY_SIZE(_rfk_handler) == RTW89_RFK_F_NUM);
+
+void
+rtw89_rfk_parser(struct rtw89_dev *rtwdev, const struct rtw89_rfk_tbl *tbl)
+{
+	const struct rtw89_reg5_def *p = tbl->defs;
+	const struct rtw89_reg5_def *end = tbl->defs + tbl->size;
+
+	for (; p < end; p++)
+		_rfk_handler[p->flag](rtwdev, p);
+}
+EXPORT_SYMBOL(rtw89_rfk_parser);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 2cb68f49b4d6d..81bd4aeffc755 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -328,6 +328,65 @@ static inline u32 rtw89_phy_read32_mask(struct rtw89_dev *rtwdev,
 	return rtw89_read32_mask(rtwdev, addr | RTW89_PHY_ADDR_OFFSET, mask);
 }
 
+enum rtw89_rfk_flag {
+	RTW89_RFK_F_WRF = 0,
+	RTW89_RFK_F_WM = 1,
+	RTW89_RFK_F_WS = 2,
+	RTW89_RFK_F_WC = 3,
+	RTW89_RFK_F_DELAY = 4,
+	RTW89_RFK_F_NUM,
+};
+
+struct rtw89_rfk_tbl {
+	const struct rtw89_reg5_def *defs;
+	u32 size;
+};
+
+#define DECLARE_RFK_TBL(_name)			\
+const struct rtw89_rfk_tbl _name ## _tbl = {	\
+	.defs = _name,				\
+	.size = ARRAY_SIZE(_name),		\
+}
+
+#define DECL_RFK_WRF(_path, _addr, _mask, _data)	\
+	{.flag = RTW89_RFK_F_WRF,			\
+	 .path = _path,					\
+	 .addr = _addr,					\
+	 .mask = _mask,					\
+	 .data = _data,}
+
+#define DECL_RFK_WM(_addr, _mask, _data)	\
+	{.flag = RTW89_RFK_F_WM,		\
+	 .addr = _addr,				\
+	 .mask = _mask,				\
+	 .data = _data,}
+
+#define DECL_RFK_WS(_addr, _mask)	\
+	{.flag = RTW89_RFK_F_WS,	\
+	 .addr = _addr,			\
+	 .mask = _mask,}
+
+#define DECL_RFK_WC(_addr, _mask)	\
+	{.flag = RTW89_RFK_F_WC,	\
+	 .addr = _addr,			\
+	 .mask = _mask,}
+
+#define DECL_RFK_DELAY(_data)		\
+	{.flag = RTW89_RFK_F_DELAY,	\
+	 .data = _data,}
+
+void
+rtw89_rfk_parser(struct rtw89_dev *rtwdev, const struct rtw89_rfk_tbl *tbl);
+
+#define rtw89_rfk_parser_by_cond(dev, cond, tbl_t, tbl_f)	\
+	do {							\
+		typeof(dev) __dev = (dev);			\
+		if (cond)					\
+			rtw89_rfk_parser(__dev, (tbl_t));	\
+		else						\
+			rtw89_rfk_parser(__dev, (tbl_f));	\
+	} while (0)
+
 void rtw89_phy_write_reg3_tbl(struct rtw89_dev *rtwdev,
 			      const struct rtw89_phy_reg3_tbl *tbl);
 u8 rtw89_phy_get_txsc(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index c021e93eb07b0..aa326681b5090 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -12,66 +12,6 @@
 #include "rtw8852a_rfk_table.h"
 #include "rtw8852a_table.h"
 
-static void
-_rfk_write_rf(struct rtw89_dev *rtwdev, const struct rtw89_reg5_def *def)
-{
-	rtw89_write_rf(rtwdev, def->path, def->addr, def->mask, def->data);
-}
-
-static void
-_rfk_write32_mask(struct rtw89_dev *rtwdev, const struct rtw89_reg5_def *def)
-{
-	rtw89_phy_write32_mask(rtwdev, def->addr, def->mask, def->data);
-}
-
-static void
-_rfk_write32_set(struct rtw89_dev *rtwdev, const struct rtw89_reg5_def *def)
-{
-	rtw89_phy_write32_set(rtwdev, def->addr, def->mask);
-}
-
-static void
-_rfk_write32_clr(struct rtw89_dev *rtwdev, const struct rtw89_reg5_def *def)
-{
-	rtw89_phy_write32_clr(rtwdev, def->addr, def->mask);
-}
-
-static void
-_rfk_delay(struct rtw89_dev *rtwdev, const struct rtw89_reg5_def *def)
-{
-	udelay(def->data);
-}
-
-static void
-(*_rfk_handler[])(struct rtw89_dev *rtwdev, const struct rtw89_reg5_def *def) = {
-	[RTW89_RFK_F_WRF] = _rfk_write_rf,
-	[RTW89_RFK_F_WM] = _rfk_write32_mask,
-	[RTW89_RFK_F_WS] = _rfk_write32_set,
-	[RTW89_RFK_F_WC] = _rfk_write32_clr,
-	[RTW89_RFK_F_DELAY] = _rfk_delay,
-};
-
-static_assert(ARRAY_SIZE(_rfk_handler) == RTW89_RFK_F_NUM);
-
-static void
-rtw89_rfk_parser(struct rtw89_dev *rtwdev, const struct rtw89_rfk_tbl *tbl)
-{
-	const struct rtw89_reg5_def *p = tbl->defs;
-	const struct rtw89_reg5_def *end = tbl->defs + tbl->size;
-
-	for (; p < end; p++)
-		_rfk_handler[p->flag](rtwdev, p);
-}
-
-#define rtw89_rfk_parser_by_cond(rtwdev, cond, tbl_t, tbl_f)	\
-	do {							\
-		typeof(rtwdev) _dev = (rtwdev);			\
-		if (cond)					\
-			rtw89_rfk_parser(_dev, (tbl_t));	\
-		else						\
-			rtw89_rfk_parser(_dev, (tbl_f));	\
-	} while (0)
-
 static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]dbcc_en: %x,  PHY%d\n",
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk_table.h
index 4a4a45d778ff6..33e6c404ecf9b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk_table.h
@@ -5,54 +5,7 @@
 #ifndef __RTW89_8852A_RFK_TABLE_H__
 #define __RTW89_8852A_RFK_TABLE_H__
 
-#include "core.h"
-
-enum rtw89_rfk_flag {
-	RTW89_RFK_F_WRF = 0,
-	RTW89_RFK_F_WM = 1,
-	RTW89_RFK_F_WS = 2,
-	RTW89_RFK_F_WC = 3,
-	RTW89_RFK_F_DELAY = 4,
-	RTW89_RFK_F_NUM,
-};
-
-struct rtw89_rfk_tbl {
-	const struct rtw89_reg5_def *defs;
-	u32 size;
-};
-
-#define DECLARE_RFK_TBL(_name)			\
-const struct rtw89_rfk_tbl _name ## _tbl = {	\
-	.defs = _name,				\
-	.size = ARRAY_SIZE(_name),		\
-}
-
-#define DECL_RFK_WRF(_path, _addr, _mask, _data)	\
-	{.flag = RTW89_RFK_F_WRF,			\
-	 .path = _path,					\
-	 .addr = _addr,					\
-	 .mask = _mask,					\
-	 .data = _data,}
-
-#define DECL_RFK_WM(_addr, _mask, _data)	\
-	{.flag = RTW89_RFK_F_WM,		\
-	 .addr = _addr,				\
-	 .mask = _mask,				\
-	 .data = _data,}
-
-#define DECL_RFK_WS(_addr, _mask)	\
-	{.flag = RTW89_RFK_F_WS,	\
-	 .addr = _addr,			\
-	 .mask = _mask,}
-
-#define DECL_RFK_WC(_addr, _mask)	\
-	{.flag = RTW89_RFK_F_WC,	\
-	 .addr = _addr,			\
-	 .mask = _mask,}
-
-#define DECL_RFK_DELAY(_data)		\
-	{.flag = RTW89_RFK_F_DELAY,	\
-	 .data = _data,}
+#include "phy.h"
 
 extern const struct rtw89_rfk_tbl rtw8852a_tssi_sys_defs_tbl;
 extern const struct rtw89_rfk_tbl rtw8852a_tssi_sys_defs_2g_tbl;
-- 
2.25.1

