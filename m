Return-Path: <linux-wireless+bounces-20019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A7A577C4
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 03:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD8A188E21F
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 02:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8BA15B554;
	Sat,  8 Mar 2025 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="sEfFCYDl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D9E1487E1
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 02:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741402746; cv=none; b=NWjBgwYQFrTj6iqhiri9+EnX5+wUJDMnFYkFAM72Sm2mkdNWWdqu2kz7qndml6+pDNq+eOkVWY610lYw8XML3b0YVZwVdP9Si3snDW4g+uW8GPrk15w8vGL3CcGDTSgakEQ7PLc6sL5zCUjgYyGQVte5EATy7eWOAT1mypbaEW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741402746; c=relaxed/simple;
	bh=9Rd0XFKrxvy1l+uBuj+d8zqu3DQgRy/anMsHCWxL4hs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T05aE5xs4Y9WDHdzVqqAqJ9gDxmk03Fjpze7CsuDt3JLeE9B7arTXRmHUQJlF2xfjnr4we4/Pgd+2MMhC5Aze1E8Hpa+i+ptn/cSJjib1q6NFD4QZBT/qHGkvhN8E9w6mBSh8lsXo6Nuhk48Kbci97Mmow5/N2WAF4OL94Gn52g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=sEfFCYDl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5282wtKX32568076, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741402735; bh=9Rd0XFKrxvy1l+uBuj+d8zqu3DQgRy/anMsHCWxL4hs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=sEfFCYDla2V4JZ4WsiICxFZyfeQZgS3t8Su2x4PO5tdy/b0FnWE2ik2do0yRWUci3
	 pd2h8JR1QoiUJa0Zjf5hsZ5joLfMPBUgf/SJaBFD1qHLQxGWUGggv53hRfRKzDy7tZ
	 +8wtZn1/FoqtICvPuMV22SiACwPKXPE9KamLMuSbsQJBeeI9rD5z5T7yu0pATvLIh1
	 RBGqZsWY+J8adCNN9Qh3YJPQhC71TWdbe20HKYdL53kH6sutbjfmlfEpkajYU2vWkP
	 XhyydsebYRSEkxJfvVJmb3Ww/zPq5wD6qDGhP1K8Be7cVCKpngQ5IGcawPj2JptSJv
	 ZMo0dZJ1pfd6g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5282wtKX32568076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 8 Mar 2025 10:58:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 8 Mar 2025 10:58:50 +0800
Received: from [127.0.1.1] (172.16.23.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 8 Mar
 2025 10:58:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 1/4] wifi: rtw89: coex: RTL8852BT coexistence Wi-Fi firmware support for 0.29.122.0
Date: Sat, 8 Mar 2025 10:58:29 +0800
Message-ID: <20250308025832.10400-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250308025832.10400-1-pkshih@realtek.com>
References: <20250308025832.10400-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

Add format version of Wi-Fi firmware commands/events for firmware
version 0.29.122.0.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 858ff0cd1a23..f1a811c8713d 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -132,6 +132,14 @@ static const u32 cxtbl[] = {
 
 static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	/* firmware version must be in decreasing order for each chip */
+	{RTL8852BT, RTW89_FW_VER_CODE(0, 29, 122, 0),
+	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
+	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
+	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
+	 .fwlrole = 7,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
+	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 1, .info_buf = 1800,
+	 .max_role_num = 6,
+	},
 	{RTL8852BT, RTW89_FW_VER_CODE(0, 29, 90, 0),
 	 .fcxbtcrpt = 7, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
-- 
2.25.1


