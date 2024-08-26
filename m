Return-Path: <linux-wireless+bounces-11956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B32DA95ECA4
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7151D281674
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 09:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E8D13D8B8;
	Mon, 26 Aug 2024 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YcFiSLD1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DDA13D880
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663108; cv=none; b=LebtPNriq2fYP/QUicFUDdoDFrO4kboxR1pdwxttDXkuFBWHbYsUWMbhLVc3qFwxTEwMO/ScE5EPzqUYvbLqL0M9p89jrgQDHVouAYEjDX3ntkPR8MuQupCwC8B03Ji7aBMTdo4rXZshPLJRcUaio7+n9rP4XXM9bTG4g983Jro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663108; c=relaxed/simple;
	bh=kbDJScdkltOGSCX+s6r/KuXeJ33aLmN6vWb9oDCvdV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDMKNOwzJNHnO5o71fg0JZo06xe8SafWePqd+uH+iC+fehFDbrvwWyTMRYsDo4nHXN3PD+vaDevEtHMbsjJ1OaW9s46vnNyARx5rPE9H2Gb6p2JkUSDvPKaF8NFgqsTBRdjJAPNCzRpN79FNir53WsP5RddjrWhCBRaL61Q5pa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YcFiSLD1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47Q9535d83828689, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724663103; bh=kbDJScdkltOGSCX+s6r/KuXeJ33aLmN6vWb9oDCvdV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=YcFiSLD1r9IKPZnKv7VtZvc4MrJ07RLDGv4/JLUTbXm9V9Ib9pxWB6Zo4GJOMvYfA
	 Mo8Yvs8yWP1mbTn1j7ldQ0Y4vv329+ehioPesNMxQZ9gCnepYC24+V9KzERcjXO8YK
	 EG73WNlfQLW1O+GBOcLMpziSWMcr1ongF4HFrkcR4hmeRkzpwGbRsOzDqvjIvns0d9
	 Me0BaA8w3/vZaywaZpHIJ6OgCiOOUhYnSItP9ogz/YL7uRqchrOHKmU6/vy1Btlut8
	 aBFXIn5IAB2yPf+M9Y1hdI25P5ISa1XV8kryGT/m6wTMuc+xikmpdBYmCLuqHzh/x6
	 qWhfLqMCQHT9w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47Q9535d83828689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 17:05:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 17:05:03 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Aug
 2024 17:05:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 4/4] wifi: rtw89: wow: add scan interval option for net-detect
Date: Mon, 26 Aug 2024 17:04:39 +0800
Message-ID: <20240826090439.17242-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826090439.17242-1-pkshih@realtek.com>
References: <20240826090439.17242-1-pkshih@realtek.com>
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

The scan interval option is the period in unit of second for WoWLAN
firmware to do each scan. We get the option from cfg80211 and practice it.
If the interval is too short for firmware to finish one scan, the firmware
will start next scan immediately after finishing one and the WiFi chip
could never enter idle mode to reduce power consumption.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/wow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 0f0f4beec4d9..86e24e07780d 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1438,6 +1438,7 @@ static int rtw89_pno_scan_offload(struct rtw89_dev *rtwdev, bool enable)
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	int interval = rtw_wow->nd_config->scan_plans[0].interval;
 	struct rtw89_scan_option opt = {};
 	int ret;
 
@@ -1457,7 +1458,7 @@ static int rtw89_pno_scan_offload(struct rtw89_dev *rtwdev, bool enable)
 
 	opt.enable = enable;
 	opt.repeat = RTW89_SCAN_NORMAL;
-	opt.norm_pd = 10; /* in unit of 100ms */
+	opt.norm_pd = max(interval, 1) * 10; /* in unit of 100ms */
 	opt.delay = max(rtw_wow->nd_config->delay, 1);
 
 	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE) {
-- 
2.25.1


