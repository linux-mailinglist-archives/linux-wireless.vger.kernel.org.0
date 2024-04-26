Return-Path: <linux-wireless+bounces-6916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 205088B3016
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 08:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54E0AB229FD
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 06:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45A313A404;
	Fri, 26 Apr 2024 06:12:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30152F2F
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714111945; cv=none; b=fiFwvmBmcTWwcZcg48rj5EeCJ3Lu5gztZ7YSYkIuc/g+MdwxsQQNxPk75qkHnoyMA9ODWiNBQ7u7GhkpuZQ8f9D6HbPSDiatADI/+5v0X9mlJnrN3mt8RTGsppprSkxEaXwlooCSpVYWIrA2MZNP7j4w1I5CMtpFwurfgzoMkYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714111945; c=relaxed/simple;
	bh=oNwl4vsZvskc0XLnljYaN1bqV0eMd7sbfkxBYGiHKFY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bI37hIO2aTvopGJn2F8Gk/K3nJlJXeNUCKdmCGkLuGjRLlpfEjWuzLJOl8L1/ZZCQMrXbaOqMyEpmBedAuETy0TrUat8HI10sJOeOGkGLyQiEycPv6XT6Ztz+JvJKGS4zq7+2DsFE4G+pVvzPKUkqX6WRV5l3eZvSYo5ozOH3aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43Q6CJsjC161656, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43Q6CJsjC161656
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 14:12:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 14:12:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 14:12:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <timlee@realtek.com>
Subject: [PATCH 1/2] wifi: rtw89: reset AFEDIG register in power off sequence
Date: Fri, 26 Apr 2024 14:11:59 +0800
Message-ID: <20240426061200.44262-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

Some Wi-Fi chips meet card lost issue due to unstable hardware signal of
GPIO pins during power off. Reset AFEDIG register before BB reset in
power off sequence could avoid unstable signal and fix the issue.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 2e89c18fbf19..87b51823244d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2320,6 +2320,7 @@ static int rtw8851b_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 	u8 wl_rfc_s1;
 	int ret;
 
+	rtw89_write32_clr(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
 	rtw89_write8_clr(rtwdev, R_AX_SYS_FUNC_EN,
 			 B_AX_FEN_BBRSTB | B_AX_FEN_BB_GLB_RSTN);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 85908c55baa9..eebff5e6b403 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -550,6 +550,7 @@ static int rtw8852b_pwr_off_func(struct rtw89_dev *rtwdev)
 		return ret;
 
 	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
+	rtw89_write32_clr(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
 	rtw89_write8_clr(rtwdev, R_AX_SYS_FUNC_EN, B_AX_FEN_BB_GLB_RSTN | B_AX_FEN_BBRSTB);
 	rtw89_write32_clr(rtwdev, R_AX_SYS_ADIE_PAD_PWR_CTRL, B_AX_SYM_PADPDN_WL_RFC_1P3);
 
@@ -2469,6 +2470,7 @@ static int rtw8852b_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 	u8 wl_rfc_s1;
 	int ret;
 
+	rtw89_write32_clr(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
 	rtw89_write8_clr(rtwdev, R_AX_SYS_FUNC_EN,
 			 B_AX_FEN_BBRSTB | B_AX_FEN_BB_GLB_RSTN);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index db354afc486e..efc772eb79a4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -338,6 +338,7 @@ static int rtw8852c_pwr_off_func(struct rtw89_dev *rtwdev)
 		return ret;
 
 	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
+	rtw89_write32_clr(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
 	rtw89_write8_clr(rtwdev, R_AX_SYS_FUNC_EN, B_AX_FEN_BB_GLB_RSTN | B_AX_FEN_BBRSTB);
 	rtw89_write32_clr(rtwdev, R_AX_SYS_ISO_CTRL_EXTEND,
 			  B_AX_R_SYM_FEN_WLBBGLB_1 | B_AX_R_SYM_FEN_WLBBFUN_1);
@@ -2816,6 +2817,7 @@ static int rtw8852c_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 
 static int rtw8852c_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 {
+	rtw89_write32_clr(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
 	rtw89_write8_clr(rtwdev, R_AX_SYS_FUNC_EN,
 			 B_AX_FEN_BBRSTB | B_AX_FEN_BB_GLB_RSTN);
 
-- 
2.25.1


