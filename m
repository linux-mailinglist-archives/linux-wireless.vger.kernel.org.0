Return-Path: <linux-wireless+bounces-4314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA80686EDA9
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 01:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6626E1F23CA8
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 00:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6596153AC;
	Sat,  2 Mar 2024 00:59:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA3A523D
	for <linux-wireless@vger.kernel.org>; Sat,  2 Mar 2024 00:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341179; cv=none; b=t6mHs7jusehTTI+JhXxUIJHwFhio5F6av7F22lONhv4Gx0dv55RUVYwZf/39rzlC4Yj6Jcsm7FPg0JtAP7AW534+Lbi8RSQTkLw91UT8jizufJF3MfBUjPFiJDWCUVu2xaFtuzsueGCck/ragH50ajviKZ1/iQye6m0JsL1azzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341179; c=relaxed/simple;
	bh=pyxol5NrXJg4cLiup7agQm38EsRuxK5bsPsCuFInoOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7KXpf753Gdtwp8O0mLHJ94uWKXNmwyKagXx7naCsdjXRRfCrbAp9IttWd8KIp1VZHJqavC4KgnCPllZyQ5d8KZV3xPfnwDKjvyuwNRaQdoweYdftl1BIWJbM0zVT1J9Qf7D8SVwVbtFrMUXLnaO/NtUjxmIAKjDmYz4xBvjOOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4220xViK52370263, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4220xViK52370263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 Mar 2024 08:59:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Sat, 2 Mar 2024 08:59:31 +0800
Received: from [127.0.1.1] (172.16.16.155) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 2 Mar
 2024 08:59:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/7] wifi: rtw89: wow: update WoWLAN reason register for different chips
Date: Sat, 2 Mar 2024 08:58:22 +0800
Message-ID: <20240302005828.13666-2-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Chin-Yen Lee <timlee@realtek.com>

The WoWLAN reason register is used for driver to get the wakeup reason
for reporting to cfg80211, and it is different from chips. So put it
into chip information.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 1 +
 drivers/net/wireless/realtek/rtw89/wow.c      | 9 +--------
 7 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d62d23015c48..956864f0ff8b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3870,6 +3870,7 @@ struct rtw89_chip_info {
 	const u32 *c2h_regs;
 	struct rtw89_reg_def c2h_counter_reg;
 	const struct rtw89_page_regs *page_regs;
+	u32 wow_reason_reg;
 	bool cfo_src_fd;
 	bool cfo_hw_comp;
 	const struct rtw89_reg_def *dcfo_comp;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 83db0a686ee2..6f30be134d10 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2460,6 +2460,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.c2h_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_C2H_ENQ_CNT_MASK >> 8},
 	.c2h_regs		= rtw8851b_c2h_regs,
 	.page_regs		= &rtw8851b_page_regs,
+	.wow_reason_reg		= R_AX_C2HREG_DATA3 + 3,
 	.cfo_src_fd		= true,
 	.cfo_hw_comp		= true,
 	.dcfo_comp		= &rtw8851b_dcfo_comp,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 8e808ded5d52..98995b051e8c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2197,6 +2197,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.c2h_regs		= rtw8852a_c2h_regs,
 	.c2h_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_C2H_ENQ_CNT_MASK >> 8},
 	.page_regs		= &rtw8852a_page_regs,
+	.wow_reason_reg		= R_AX_C2HREG_DATA3 + 3,
 	.cfo_src_fd		= false,
 	.cfo_hw_comp            = false,
 	.dcfo_comp		= &rtw8852a_dcfo_comp,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 19454766f3de..33af6b40c2ce 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2631,6 +2631,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.c2h_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_C2H_ENQ_CNT_MASK >> 8},
 	.c2h_regs		= rtw8852b_c2h_regs,
 	.page_regs		= &rtw8852b_page_regs,
+	.wow_reason_reg		= R_AX_C2HREG_DATA3 + 3,
 	.cfo_src_fd		= true,
 	.cfo_hw_comp		= true,
 	.dcfo_comp		= &rtw8852b_dcfo_comp,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index ca8547fbd70e..f9f587452ad7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2971,6 +2971,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.c2h_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_C2H_ENQ_CNT_MASK >> 8},
 	.c2h_regs		= rtw8852c_c2h_regs,
 	.page_regs		= &rtw8852c_page_regs,
+	.wow_reason_reg		= R_AX_C2HREG_DATA3_V1 + 3,
 	.cfo_src_fd		= false,
 	.cfo_hw_comp            = false,
 	.dcfo_comp		= &rtw8852c_dcfo_comp,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 823f0d840df9..95460f8e658e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2341,6 +2341,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.c2h_counter_reg	= {R_BE_UDM1 + 1, B_BE_UDM1_HALMAC_C2H_ENQ_CNT_MASK >> 8},
 	.c2h_regs		= rtw8922a_c2h_regs,
 	.page_regs		= &rtw8922a_page_regs,
+	.wow_reason_reg		= R_AX_C2HREG_DATA3_V1 + 3,
 	.cfo_src_fd		= true,
 	.cfo_hw_comp            = true,
 	.dcfo_comp		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 4c17936795b6..a3d93503717b 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -85,21 +85,14 @@ static void rtw89_wow_set_rx_filter(struct rtw89_dev *rtwdev, bool enable)
 
 static void rtw89_wow_show_wakeup_reason(struct rtw89_dev *rtwdev)
 {
-	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	u32 wow_reason_reg = rtwdev->chip->wow_reason_reg;
 	struct cfg80211_wowlan_nd_info nd_info;
 	struct cfg80211_wowlan_wakeup wakeup = {
 		.pattern_idx = -1,
 	};
-	u32 wow_reason_reg;
 	u8 reason;
 
-	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B)
-		wow_reason_reg = R_AX_C2HREG_DATA3 + 3;
-	else
-		wow_reason_reg = R_AX_C2HREG_DATA3_V1 + 3;
-
 	reason = rtw89_read8(rtwdev, wow_reason_reg);
-
 	switch (reason) {
 	case RTW89_WOW_RSN_RX_DEAUTH:
 		wakeup.disconnect = true;
-- 
2.25.1


