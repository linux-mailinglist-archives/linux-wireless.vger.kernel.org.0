Return-Path: <linux-wireless+bounces-23935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 807F2AD388D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 15:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B5D1BA0BF6
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 13:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0EB23AB82;
	Tue, 10 Jun 2025 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="VQ2l3BL7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57612E62D3
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560495; cv=none; b=CS9N+KA/ErPGyQ6dXSzguYhNSkwgfziXFCDMQJyUI2DTE4oL/cUJH6RTx8tr3ZcFHVqBcnZJiQi+3ds9wGAm/1Vsv6ZR60r6Z7vjqenbk+f7w1tXxu2d1OneHlHAvEfkvW4HDiaE86fqlo71x93tzAiiZ9s3TlBhQZjD/COKcjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560495; c=relaxed/simple;
	bh=9vx2XmP/dcNtulIcmhP4vEm6vjoDngH0M4Y/cV2XtZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDb9wJ/n2T4DDvbv8x1GKd5wBAKSGB5pKgw/4o0DtgRbK0K+VRFeHrgkFXNbf8/KR1J+FNgEnZXC/rPu4EmpAsL76kofr9AKXWzX/qqUIYjMs6n8v1gKnvwUJTDYu+LQNW6g2kcmzI82VuMPX9y4RZnEurcnvduFELsgWugn/Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=VQ2l3BL7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55AD1U9302995544, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749560491; bh=nhGfkpvYQjauZjve6HCXCfOLdOZWXkk8nTaUSx9JINk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=VQ2l3BL7mqyt/JadsGpXmRJsS0MUi9p0v600kRV2xalxi1ipWtjc7/8Le6jg1JfR3
	 VvOT4Q4lHlb+g5R17muuoXtUFIhfHFSprFbgP62ZetPuRDlp4Mrb8AcxWtfTSSOJs5
	 uV94VINj/3/kIhMF5b6YMuP8xqQjy0ah0fnuVMgH6hxOiERAFcSqakCNdbp9tISW24
	 WAHG2a8nyi4pcnQc9g/WT3V8Bx/5uJOY+3wZjSEJ0r7zGHEgH8MP/xNhVlgLBmWSAt
	 iJAn0zxdLk3OPTml6ArRnQ9tI2DYqEV5pRzq7prtRCl0oKs5Dtni8CsJPpcB36qh3K
	 H2vF8HGhBs4fg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55AD1U9302995544
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 21:01:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 21:01:31 +0800
Received: from [127.0.1.1] (10.22.225.18) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 21:01:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 08/12] wifi: rtw89: mcc: enlarge scan time of GC when GO in MCC
Date: Tue, 10 Jun 2025 21:00:30 +0800
Message-ID: <20250610130034.14692-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250610130034.14692-1-pkshih@realtek.com>
References: <20250610130034.14692-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

In original scan, the scan time only 45ms. The GO in MCC mode only
stay 50ms and switch to STA role 50ms, which might cause GC can't scan
GO. Therefore, enlarge scan time to 105ms to ensure GC have time
overlapping with GO.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 4 ++++
 drivers/net/wireless/realtek/rtw89/fw.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index cde22f692dc2..608159d31e08 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -7264,6 +7264,8 @@ int rtw89_hw_scan_prep_chan_list_ax(struct rtw89_dev *rtwdev,
 		else if (channel->band == NL80211_BAND_6GHZ)
 			ch_info->period = RTW89_CHANNEL_TIME_6G +
 					  RTW89_DWELL_TIME_6G;
+		else if (rtwvif_link->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT)
+			ch_info->period = RTW89_P2P_CHAN_TIME;
 		else
 			ch_info->period = RTW89_CHANNEL_TIME;
 
@@ -7440,6 +7442,8 @@ int rtw89_hw_scan_prep_chan_list_be(struct rtw89_dev *rtwdev,
 			ch_info->period = req->duration;
 		else if (channel->band == NL80211_BAND_6GHZ)
 			ch_info->period = RTW89_CHANNEL_TIME_6G + RTW89_DWELL_TIME_6G;
+		else if (rtwvif_link->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT)
+			ch_info->period = RTW89_P2P_CHAN_TIME;
 		else
 			ch_info->period = RTW89_CHANNEL_TIME;
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index f9d5bcbc7c7e..d66333321de2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -320,6 +320,7 @@ struct rtw89_fw_macid_pause_sleep_grp {
 #define RTW89_CHANNEL_TIME_EXTRA_OP 30
 #define RTW89_DFS_CHAN_TIME 105
 #define RTW89_OFF_CHAN_TIME 100
+#define RTW89_P2P_CHAN_TIME 105
 #define RTW89_DWELL_TIME 20
 #define RTW89_DWELL_TIME_6G 10
 #define RTW89_SCAN_WIDTH 0
-- 
2.25.1


