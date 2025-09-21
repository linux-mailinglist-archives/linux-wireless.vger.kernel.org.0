Return-Path: <linux-wireless+bounces-27547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE29B8DD74
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Sep 2025 17:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14C518992C1
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Sep 2025 15:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E641212572;
	Sun, 21 Sep 2025 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfHiiIh6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA28211A09
	for <linux-wireless@vger.kernel.org>; Sun, 21 Sep 2025 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758469475; cv=none; b=iW1USuTv4aXkNgt/GQnuqqQ3thr8b4DP+Ru/QDtAHlQpVind3W+9CrLeGLgl8yHgBI7yfnJuQW42n9yJ7TRCv+49KOb+ou1L7Eljbvdu4ghH6nmzqTa33mlWKS5VfvwQitglNextnF07akZiuy/EuRlTcRkysSeJHELuPaFQQFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758469475; c=relaxed/simple;
	bh=TorXlnzo2MWNlQrV3lMZEG55rlMmiosJc6k61neyAcA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gmzdg2ORh4lqtBf3knWNH7dRX71WsMKQCCpIYFikh6qjuMYc42j9B8WzZr9GhwTyAwDKLsPyD+rHvXHRGyqRuTDS+KyVBkt1Tr3Ntd9cRVuf5/ZX2G0LVlJr88PKU+uUhv8HR8IsSKT6Mk77WJyhiTFo6F15bVIRD6AewBEp2Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfHiiIh6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-267f0fe72a1so23514445ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 21 Sep 2025 08:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758469473; x=1759074273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+EG28P0iOsg16EFPGe9CXi+kR66aQLbg4RmAzKPuYI0=;
        b=jfHiiIh605aU30Y2Y8nVy/QuIiEZcfXbAmRr3PPC1hp5UcU4DpXKhYnC3QzYUPzVRo
         e3MAOPe4mJi/8eL8aDEnS0OK+YFTs81k8+soRb8JgwuLtXVKSzbnCJ1HCE56YIMPS5Hv
         zEhNPT9bDeQu7ym97Ak7RC7V3KKVa7IoMDFLWREUVQ7uf2dgKtnU9UA4OctM0y7IzOL1
         PjtVAajUeEY6KpSQY/aXRHLbUkYmTXwL8r+ao5dfPEg1HTzHejQW61SHRr9FvFncfiiz
         kUqChY+kZYHuoF+UufaXTOKrGVa6ZtvtKNZP0M3iHzsuL6z6Tr1u1A8YnUM0FJIW/Iv5
         YLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758469473; x=1759074273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EG28P0iOsg16EFPGe9CXi+kR66aQLbg4RmAzKPuYI0=;
        b=vWI1CbUHXruu+hwlr7Q81mmBOy0kPQxF5T/hmm+VnexG7KKU1LyR7Gu7rTP8w1ewP2
         C4OMI1jqbIiAwVO4ootR2RuS8wiInP6oCetDTA2PRPOGwIGtFO5r7LrlUujpawSu0OdW
         HJJH+GNQA23SBpEj8/w4qaiELQlYMm24bGLAlS6JBORuomz3lDwgb/m3K36+Q+CFIVZM
         iIyuwK1HBnK1hCDRi9wenq6pIXBJZTVz9f1uC2rNp1Tq2UkufRERD7Y6BnB41Nx9AMbC
         1M9x6tMgmluVfKQDXaDag/A8AKk14xt/btZ7sag/80IAOz0dIIc9BmfbP2K5guc9X8cg
         rtvw==
X-Gm-Message-State: AOJu0YxlD0P4qibPxmvrhSVb9lklugXRZyTZEgFzm9JoYLjQmKCoWA5c
	o+69gx/QDdZ83vzLG4qkIn8q3mZ4JEuMBPN3oH/pqlsLvNCl9Cod0Fg0
X-Gm-Gg: ASbGnctP9+MI1RnUJZ/BLrrPIv2roHGQUO/lxAW1XXGzqRrwP8jEbltCCIZQq3mBG2K
	PuoKX5v/2dKOmc765JoASnnYqQTtF4J1E6rgve2gl/caC1KjBO+Rn3qzNHum+xGroVAaYT1cvxS
	5L+3HDYbcxX8LF7M7rdR6fjSEymyp7tYKnyHY3ElE8EdOALci/718qCNqWVIgY7UIuGXcCpEcle
	bpaFjhBZEuNprQOIioR+Q/dz6A6oqYkqQWFlQ0Xc1QnrNHKFURX7/cdGGb7bX5kvSS5LH4iFHWt
	uAotaaKX1xPDouTnsHn+aAJb7brJ7T1oRY/QQEdp9IeinIcQYFBm0tB4r2rC4PiP5haUHdvowfr
	lOA1sIM8U3RTJqd3aZcibJ7kWYyVz87yusYNIfh9Vb7ywQbfjGpZ8+qG8OyTJs/s=
X-Google-Smtp-Source: AGHT+IElssErqvSrdGuhyH0vVhCmFkqiSxBKWh3bqR5whmCN8++24mRRt9yp/basgQHIC2bBl/4ILw==
X-Received: by 2002:a17:902:f645:b0:269:b2e5:ee48 with SMTP id d9443c01a7336-269ba52e56emr145153705ad.52.1758469472698;
        Sun, 21 Sep 2025 08:44:32 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269a75d63eesm89692205ad.100.2025.09.21.08.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 08:44:32 -0700 (PDT)
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cy.huang@realtek.com,
	stanley_chang@realtek.com,
	jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw89: Replace hardcoded strings with helper functions
Date: Sun, 21 Sep 2025 23:44:10 +0800
Message-Id: <20250921154410.1202074-1-eleanor15x@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace hardcoded strings with 'str_on_off()', 'str_enable_disable()',
and 'str_read_write()'.

The change improves readability and enables potential string deduplication
by the linker, which may slightly reduce binary size.

Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c | 10 ++++++----
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c | 10 ++++++----
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c |  8 +++++---
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c | 11 ++++++-----
 drivers/net/wireless/realtek/rtw89/usb.c          |  3 ++-
 drivers/net/wireless/realtek/rtw89/wow.c          |  5 ++++-
 6 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index 84c46d2f4d85..000753061e38 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -2,6 +2,8 @@
 /* Copyright(c) 2022-2023  Realtek Corporation
  */
 
+#include <linux/string_choices.h>
+
 #include "coex.h"
 #include "debug.h"
 #include "mac.h"
@@ -1626,7 +1628,7 @@ static void _iqk_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	iqk_info->iqk_table_idx[path] = idx;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]S%d (PHY%d): / DBCC %s/ %s/ CH%d/ %s\n",
-		    path, phy, rtwdev->dbcc_en ? "on" : "off",
+		    path, phy, str_on_off(rtwdev->dbcc_en),
 		    iqk_info->iqk_band[path] == 0 ? "2G" :
 		    iqk_info->iqk_band[path] == 1 ? "5G" : "6G",
 		    iqk_info->iqk_ch[path],
@@ -1901,8 +1903,8 @@ static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] S%d[%d] (PHY%d): TSSI %s/ DBCC %s/ %s/ CH%d/ %s\n",
 		    path, dpk->cur_idx[path], phy,
-		    rtwdev->is_tssi_mode[path] ? "on" : "off",
-		    rtwdev->dbcc_en ? "on" : "off",
+		    str_on_off(rtwdev->is_tssi_mode[path]),
+		    str_on_off(rtwdev->dbcc_en),
 		    dpk->bp[path][kidx].band == 0 ? "2G" :
 		    dpk->bp[path][kidx].band == 1 ? "5G" : "6G",
 		    dpk->bp[path][kidx].ch,
@@ -2016,7 +2018,7 @@ static void _dpk_txpwr_bb_force(struct rtw89_dev *rtwdev,
 	rtw89_phy_write32_mask(rtwdev, R_TXPWRB_H + (path << 13), B_TXPWRB_RDY, force);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d txpwr_bb_force %s\n",
-		    path, force ? "on" : "off");
+		    path, str_on_off(force));
 }
 
 static void _dpk_kip_pwr_clk_onoff(struct rtw89_dev *rtwdev, bool turn_on)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index 9db8713ac99b..9ffde0894d8a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -2,6 +2,8 @@
 /* Copyright(c) 2019-2020  Realtek Corporation
  */
 
+#include <linux/string_choices.h>
+
 #include "coex.h"
 #include "debug.h"
 #include "mac.h"
@@ -1403,7 +1405,7 @@ static void _iqk_get_ch_info(struct rtw89_dev *rtwdev,
 		    path, iqk_info->iqk_ch[path]);
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[IQK]S%d (PHY%d): / DBCC %s/ %s/ CH%d/ %s\n", path, phy,
-		    rtwdev->dbcc_en ? "on" : "off",
+		    str_on_off(rtwdev->dbcc_en),
 		    iqk_info->iqk_band[path] == 0 ? "2G" :
 		    iqk_info->iqk_band[path] == 1 ? "5G" : "6G",
 		    iqk_info->iqk_ch[path],
@@ -1881,8 +1883,8 @@ static void _dpk_information(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] S%d[%d] (PHY%d): TSSI %s/ DBCC %s/ %s/ CH%d/ %s\n",
 		    path, dpk->cur_idx[path], phy,
-		    rtwdev->is_tssi_mode[path] ? "on" : "off",
-		    rtwdev->dbcc_en ? "on" : "off",
+		    str_on_off(rtwdev->is_tssi_mode[path]),
+		    str_on_off(rtwdev->dbcc_en),
 		    dpk->bp[path][kidx].band == 0 ? "2G" :
 		    dpk->bp[path][kidx].band == 1 ? "5G" : "6G",
 		    dpk->bp[path][kidx].ch,
@@ -2736,7 +2738,7 @@ static void _dpk_onoff(struct rtw89_dev *rtwdev,
 			       MASKBYTE3, 0x6 | val);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n", path,
-		    kidx, dpk->is_dpk_enable && !off ? "enable" : "disable");
+		    kidx, str_enable_disable(dpk->is_dpk_enable && !off));
 }
 
 static void _dpk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 4796588c0256..c156c64f4d5e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -2,6 +2,8 @@
 /* Copyright(c) 2019-2022  Realtek Corporation
  */
 
+#include <linux/string_choices.h>
+
 #include "chan.h"
 #include "coex.h"
 #include "debug.h"
@@ -1696,7 +1698,7 @@ static void _dpk_onoff(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, bool o
 			       MASKBYTE3, _dpk_order_convert(rtwdev) << 1 | val);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n", path,
-		    kidx, dpk->is_dpk_enable && !off ? "enable" : "disable");
+		    kidx, str_enable_disable(dpk->is_dpk_enable && !off));
 }
 
 static void _dpk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
@@ -1763,8 +1765,8 @@ static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] S%d[%d] (PHY%d): TSSI %s/ DBCC %s/ %s/ CH%d/ %s\n",
 		    path, dpk->cur_idx[path], phy,
-		    rtwdev->is_tssi_mode[path] ? "on" : "off",
-		    rtwdev->dbcc_en ? "on" : "off",
+		    str_on_off(rtwdev->is_tssi_mode[path]),
+		    str_on_off(rtwdev->dbcc_en),
 		    dpk->bp[path][kidx].band == 0 ? "2G" :
 		    dpk->bp[path][kidx].band == 1 ? "5G" : "6G",
 		    dpk->bp[path][kidx].ch,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index b92e2ce4f4ad..3d3de3641edd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /* Copyright(c) 2019-2022  Realtek Corporation
  */
+#include <linux/string_choices.h>
 
 #include "chan.h"
 #include "coex.h"
@@ -1344,7 +1345,7 @@ static void _iqk_get_ch_info(struct rtw89_dev *rtwdev,
 		    path, iqk_info->iqk_ch[path]);
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[IQK]S%d (PHY%d): / DBCC %s/ %s/ CH%d/ %s\n", path, phy,
-		    rtwdev->dbcc_en ? "on" : "off",
+		    str_on_off(rtwdev->dbcc_en),
 		    iqk_info->iqk_band[path] == 0 ? "2G" :
 		    iqk_info->iqk_band[path] == 1 ? "5G" : "6G",
 		    iqk_info->iqk_ch[path],
@@ -1920,8 +1921,8 @@ static void _dpk_information(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] S%d[%d] (PHY%d): TSSI %s/ DBCC %s/ %s/ CH%d/ %s\n",
 		    path, dpk->cur_idx[path], phy,
-		    rtwdev->is_tssi_mode[path] ? "on" : "off",
-		    rtwdev->dbcc_en ? "on" : "off",
+		    str_on_off(rtwdev->is_tssi_mode[path]),
+		    str_on_off(rtwdev->dbcc_en),
 		    dpk->bp[path][kidx].band == 0 ? "2G" :
 		    dpk->bp[path][kidx].band == 1 ? "5G" : "6G",
 		    dpk->bp[path][kidx].ch,
@@ -2000,7 +2001,7 @@ static void _dpk_txpwr_bb_force(struct rtw89_dev *rtwdev, u8 path, bool force)
 	rtw89_phy_write32_mask(rtwdev, R_TXPWRB_H + (path << 13), B_TXPWRB_RDY, force);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,  "[DPK] S%d txpwr_bb_force %s\n",
-		    path, force ? "on" : "off");
+		    path, str_on_off(force));
 }
 
 static void _dpk_kip_restore(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
@@ -2828,7 +2829,7 @@ static void _dpk_onoff(struct rtw89_dev *rtwdev,
 			       B_DPD_MEN, val);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n", path,
-		    kidx, dpk->is_dpk_enable && !off ? "enable" : "disable");
+		    kidx, str_enable_disable(dpk->is_dpk_enable && !off));
 }
 
 static void _dpk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 6cf89aee252e..c7c90ddea409 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2025  Realtek Corporation
  */
 
+#include <linux/string_choices.h>
 #include <linux/usb.h>
 #include "debug.h"
 #include "mac.h"
@@ -55,7 +56,7 @@ static void rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
 		else if (ret < 0)
 			rtw89_warn(rtwdev,
 				   "usb %s%u 0x%x fail ret=%d value=0x%x attempt=%d\n",
-				   reqtype == RTW89_USB_VENQT_READ ? "read" : "write",
+				   str_read_write(reqtype == RTW89_USB_VENQT_READ),
 				   len * 8, addr, ret,
 				   le32_to_cpup(rtwusb->vendor_req_buf),
 				   attempt);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 5faa51ad896a..6e4156ef898c 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /* Copyright(c) 2019-2022  Realtek Corporation
  */
+
+#include <linux/string_choices.h>
+
 #include "cam.h"
 #include "core.h"
 #include "debug.h"
@@ -1248,7 +1251,7 @@ static int rtw89_wow_check_fw_status(struct rtw89_dev *rtwdev, bool wow_enable)
 				       mac->wow_ctrl.addr, mac->wow_ctrl.mask);
 	if (ret)
 		rtw89_err(rtwdev, "failed to check wow status %s\n",
-			  wow_enable ? "enabled" : "disabled");
+			  str_enabled_disabled(wow_enable));
 	return ret;
 }
 
-- 
2.34.1


