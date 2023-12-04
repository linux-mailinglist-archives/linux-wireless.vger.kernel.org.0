Return-Path: <linux-wireless+bounces-352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A811802CBA
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 09:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37089280D04
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 08:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E465DF42;
	Mon,  4 Dec 2023 08:09:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AA9D3
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 00:09:14 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B4891d441945211, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B4891d441945211
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 16:09:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 4 Dec 2023 16:09:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 4 Dec 2023
 16:09:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <leo.li@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/5] wifi: rtw89: 8922a: configure CRASH_TRIGGER FW feature
Date: Mon, 4 Dec 2023 16:07:47 +0800
Message-ID: <20231204080751.15354-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204080751.15354-1-pkshih@realtek.com>
References: <20231204080751.15354-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Zong-Zhe Yang <kevin_yang@realtek.com>

RTL8922A FW supports CRASH_TRIGGER feature from v0.34.30.0.
After it, debugfs fw_crash can accept type 1 on RTL8922A to
trigger firmware crash and verify L2 recovery.

Besides, RTL8922A sync address offset of reserved payload engine.
And, SER (system error recovery) tweaks conversion from WCPU address
to indirect access address for RTL8922A. The new conversion works
for all supported chips.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  |  1 +
 drivers/net/wireless/realtek/rtw89/fw.h  |  2 --
 drivers/net/wireless/realtek/rtw89/ser.c | 10 +++++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index b11ed35e265d..0b9c3c76b273 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -453,6 +453,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 36, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 40, 0, CRASH_TRIGGER),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 56, 10, BEACON_FILTER),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 30, 0, CRASH_TRIGGER),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index d4db9ab0b5e8..2b2d14284465 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3651,8 +3651,6 @@ struct rtw89_fw_h2c_rf_get_mccch {
 
 #define RTW89_FW_RSVD_PLE_SIZE 0x800
 
-#define RTW89_WCPU_BASE_MASK GENMASK(27, 0)
-
 #define RTW89_FW_BACKTRACE_INFO_SIZE 8
 #define RTW89_VALID_FW_BACKTRACE_SIZE(_size) \
 	((_size) % RTW89_FW_BACKTRACE_INFO_SIZE == 0)
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 1e4a79a3b814..99896d85d2f8 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -590,6 +590,14 @@ struct __fw_backtrace_info {
 static_assert(RTW89_FW_BACKTRACE_INFO_SIZE ==
 	      sizeof(struct __fw_backtrace_info));
 
+static u32 convert_addr_from_wcpu(u32 wcpu_addr)
+{
+	if (wcpu_addr < 0x30000000)
+		return wcpu_addr;
+
+	return wcpu_addr & GENMASK(28, 0);
+}
+
 static int rtw89_ser_fw_backtrace_dump(struct rtw89_dev *rtwdev, u8 *buf,
 				       const struct __fw_backtrace_entry *ent)
 {
@@ -597,7 +605,7 @@ static int rtw89_ser_fw_backtrace_dump(struct rtw89_dev *rtwdev, u8 *buf,
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u32 filter_model_addr = mac->filter_model_addr;
 	u32 indir_access_addr = mac->indir_access_addr;
-	u32 fwbt_addr = ent->wcpu_addr & RTW89_WCPU_BASE_MASK;
+	u32 fwbt_addr = convert_addr_from_wcpu(ent->wcpu_addr);
 	u32 fwbt_size = ent->size;
 	u32 fwbt_key = ent->key;
 	u32 i;
-- 
2.25.1


