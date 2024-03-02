Return-Path: <linux-wireless+bounces-4315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EAC86EDAA
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 01:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D941F23BB3
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 00:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDB16D39;
	Sat,  2 Mar 2024 00:59:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04E36AAD
	for <linux-wireless@vger.kernel.org>; Sat,  2 Mar 2024 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341184; cv=none; b=Pwl8vcSLD2XeNOW1wIxXem0ybpBWIbmnSxwoUAe2OS6AIFZPPLWWf8Fq2dcsvldTZs4IIuzQX6ehgFOS1kQqSN+feHTgLfErx5qQQlE5Sk8LAfJGR56OpXaJ8ouKlDAtxh4t0yIJO8Zeo1cQB0FLIAPX1Z3//ZV2Y0HFyuf3GII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341184; c=relaxed/simple;
	bh=7do9qPvmOxY7je7r+KshdXTg1TM8i6cj4tUlLmQYJj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDu0YrbBFQPjQbLMfwXsbLww4qnxSUKsGmQnH8XmNADJ404dC87TZCIhOKBcanYBf95oc5yDTr1oDEjrXVa3iBa5sbQc7Vv+MRfv4fNuSJwGFhuZDCvCwt6VNL06tUauVAsiMjBp+QKr5M5REJm8/ZdKywlgQczppwIWIIbdBpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4220xaRzB2370268, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4220xaRzB2370268
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 Mar 2024 08:59:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Sat, 2 Mar 2024 08:59:36 +0800
Received: from [127.0.1.1] (172.16.16.155) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 2 Mar
 2024 08:59:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/7] wifi: rtw89: wow: update WoWLAN status register for different generation
Date: Sat, 2 Mar 2024 08:58:23 +0800
Message-ID: <20240302005828.13666-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240302005828.13666-1-pkshih@realtek.com>
References: <20240302005828.13666-1-pkshih@realtek.com>
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

From: Chin-Yen Lee <timlee@realtek.com>

The statue register is for driver to check if WoWLAN mode works or stops
successfully. It is changed for new generation, so update it.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 1 +
 drivers/net/wireless/realtek/rtw89/mac.h    | 1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c | 1 +
 drivers/net/wireless/realtek/rtw89/reg.h    | 6 ++++++
 drivers/net/wireless/realtek/rtw89/wow.c    | 3 ++-
 5 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 908245ac46bd..28e07ff7eb2a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -6307,6 +6307,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 		.addr = R_AX_RXTRIG_TEST_USER_2,
 		.mask = B_AX_RXTRIG_RU26_DIS,
 	},
+	.wow_ctrl = {.addr = R_AX_WOW_CTRL, .mask = B_AX_WOW_WOWEN,},
 
 	.check_mac_en = rtw89_mac_check_mac_en_ax,
 	.sys_init = sys_init_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index db95509fad2f..8904ae222331 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -913,6 +913,7 @@ struct rtw89_mac_gen_def {
 	struct rtw89_reg_def muedca_ctrl;
 	struct rtw89_reg_def bfee_ctrl;
 	struct rtw89_reg_def narrow_bw_ru_dis;
+	struct rtw89_reg_def wow_ctrl;
 
 	int (*check_mac_en)(struct rtw89_dev *rtwdev, u8 band,
 			    enum rtw89_mac_hwmod_sel sel);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 320e88229971..ffa185ba0ab7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2406,6 +2406,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 		.addr = R_BE_RXTRIG_TEST_USER_2,
 		.mask = B_BE_RXTRIG_RU26_DIS,
 	},
+	.wow_ctrl = {.addr = R_BE_WOW_CTRL, .mask = B_BE_WOW_WOWEN,},
 
 	.check_mac_en = rtw89_mac_check_mac_en_be,
 	.sys_init = sys_init_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 37ccd8ffa87a..9419960d1faf 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -5535,6 +5535,12 @@
 #define B_BE_CUT_AMSDU_CHKLEN_L_TH_MASK GENMASK(23, 16)
 #define B_BE_CUT_AMSDU_CHKLEN_H_TH_MASK GENMASK(15, 0)
 
+#define R_BE_WOW_CTRL 0x9CB8
+#define B_BE_WOW_HCI BIT(5)
+#define B_BE_WOW_DROP BIT(2)
+#define B_BE_WOW_WOWEN BIT(1)
+#define B_BE_WOW_FORCE_WAKEUP BIT(0)
+
 #define R_BE_RX_HDRTRNS 0x9CC0
 #define B_BE_RX_MGN_MLD_ADDR_EN BIT(6)
 #define B_BE_HDR_INFO_MASK GENMASK(5, 4)
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index a3d93503717b..852f8a7794be 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -463,13 +463,14 @@ static int rtw89_wow_cfg_wake(struct rtw89_dev *rtwdev, bool wow)
 
 static int rtw89_wow_check_fw_status(struct rtw89_dev *rtwdev, bool wow_enable)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u8 polling;
 	int ret;
 
 	ret = read_poll_timeout_atomic(rtw89_read8_mask, polling,
 				       wow_enable == !!polling,
 				       50, 50000, false, rtwdev,
-				       R_AX_WOW_CTRL, B_AX_WOW_WOWEN);
+				       mac->wow_ctrl.addr, mac->wow_ctrl.mask);
 	if (ret)
 		rtw89_err(rtwdev, "failed to check wow status %s\n",
 			  wow_enable ? "enabled" : "disabled");
-- 
2.25.1


