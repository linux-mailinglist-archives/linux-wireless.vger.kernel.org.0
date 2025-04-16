Return-Path: <linux-wireless+bounces-21597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE88A8B30A
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 10:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD455A15BD
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 08:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F5322F15C;
	Wed, 16 Apr 2025 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dE9ozqHd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3E322FF59
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791210; cv=none; b=DyDDy6fAneq7MifMAGOMuMWDGrWvPw8zJ1JuxFTv2WSGM/wwMseOKtyJmgMi2t2ORdaHpo789Mq3Sot9dbcDIf+9096eu8JJ/HW79YieKGBEj/oI7vPnAXQYw9llh6Xt0x+AQxT42yDOYXinyujYIu+zEr+pP6pFnuqOsH3Mnoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791210; c=relaxed/simple;
	bh=myBTwmQfeAtcuQRXQBe6PpizN8cdvypBXXqJ6lIf3LQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEVM5Y/MYKNe4/FdN5hnX3P7IcTebj9khhFNuqwQUkBj22DKnI6NMuhDN7KelOFoeD7zCEZCDtGxhLSMnHTkzFYhRLY6R9wcqCQCyA7P9GtmMztelWp7Q7mhRlv+ZHNThm8L4eu3+tJ7GVbf7ukzJ/rQwzHkXLfR+9W/KjlJeUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dE9ozqHd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53G8DQa142935268, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744791206; bh=myBTwmQfeAtcuQRXQBe6PpizN8cdvypBXXqJ6lIf3LQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dE9ozqHd1IaV8bk1wKQ20ZxYDN5XeHbgjloeuH4MTEql3j2kyHt1XlQiAEsVnrja5
	 ey5dtq18FNpGlHqLyszhib/SCeHahWPgWdQ96tOJqfLN68Swt6hnT/PVZe3BqhQ80o
	 y7+ZxZv4NNdEWuDRDXYl0IutziGL4rG0Xrk3AogCoH5bHGspt1WAvPHeUJib9Ht2ho
	 uIofQsfU0EHFVAnan1cENrTCLLifOTnzJO9f8xxaZ/RQVcxE0tLREV7nKP7okr3SNH
	 RwyRY7D39hXg0KVNAhNwRqedEjEL7EKheWDhXjS+LrZ/mZd7omZNO3rOqKWbDarTFR
	 sstUda++LS4bw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53G8DQa142935268
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 16:13:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Apr 2025 16:13:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 16 Apr
 2025 16:13:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 4/4] wifi: rtw89: set pre-calculated antenna matrices for HE trigger frame
Date: Wed, 16 Apr 2025 16:12:41 +0800
Message-ID: <20250416081241.36138-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250416081241.36138-1-pkshih@realtek.com>
References: <20250416081241.36138-1-pkshih@realtek.com>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

Pre-calculated antenna matrices can improve 160MHz uplink OFDMA
performance, but they are only needed for the HE trigger frame.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 869728922def..255109462517 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2060,10 +2060,21 @@ static void rtw89_stats_trigger_frame(struct rtw89_dev *rtwdev,
 			break;
 
 		if (aid == vif->cfg.aid) {
-			enum nl80211_he_ru_alloc rua = rtw89_he_rua_to_ru_alloc(tf_rua >> 1);
+			enum nl80211_he_ru_alloc rua;
 
 			rtwvif->stats.rx_tf_acc++;
 			rtwdev->stats.rx_tf_acc++;
+
+			/* The following only required for HE trigger frame, but we
+			 * cannot use UL HE-SIG-A2 reserved subfield to identify it
+			 * since some 11ax APs will fill it with all 0s, which will
+			 * be misunderstood as EHT trigger frame.
+			 */
+			if (bss_conf->eht_support)
+				break;
+
+			rua = rtw89_he_rua_to_ru_alloc(tf_rua >> 1);
+
 			if (tf_bw == IEEE80211_TRIGGER_ULBW_160_80P80MHZ &&
 			    rua <= NL80211_RATE_INFO_HE_RU_ALLOC_106)
 				rtwvif_link->pwr_diff_en = true;
-- 
2.25.1


