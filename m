Return-Path: <linux-wireless+bounces-26049-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755D4B15462
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 22:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D774E6B99
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 20:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3E12367A9;
	Tue, 29 Jul 2025 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uHvSq5hZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00393746E
	for <linux-wireless@vger.kernel.org>; Tue, 29 Jul 2025 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753821932; cv=none; b=tURXiRU+xK/YontTdnZZvaszIFg09jdGrKMNZMA0Cg0FYiaJy6cRtCb6cp3ZTF7TdS4OSimmGNQxZuV840rB3+t1/Ary21t1iPiyJNO4Ctjl0rAg4S/ouzaNgymY6wj/7XWT4c80DJqeD38CS8ZHs7sGlGxA31zKbFyPLSOePJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753821932; c=relaxed/simple;
	bh=J2gjkUeDnIYKsWCq3pj968er5tm+PJ2C/x3bgwjJwTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oa56cKisgG9+fsuOgbjDB2FO7zqDaoX16yNMuPQ+3PVbIflkvslmL+pgSWLl6H7IcXRmvBOZ8An8lO/+os/H7NoAM4nlJJjeFJQTqTa/QPpFwDqYlPGQ4UO+bRiAxjXoAtG8dy7kogwoEW+pv/le8JgrnsED4XJQSwM/gexoB4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uHvSq5hZ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753821919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VO3sp8UXyHGIMVsYB6oFeeKi756LgvDYmMzB8Bvf4Hs=;
	b=uHvSq5hZo+dfx+4ulvoTcR3NcQ5NPPS1w4iBgXOKqpInCruLZOTPAnQbWOJUYfn2/5zd7z
	WG+4iYiCueesJMeJVS7ig+iTHIFbBdqqKtiPGULhs2ZkTOavFDUvTRgky8Ag6gnL4+pNpt
	1ktZqN+R6ZOZMKGfSR0cDkqMryzTvug=
From: Sean Anderson <sean.anderson@linux.dev>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2] wifi: rtw89: Print just once for unknown C2H classes
Date: Tue, 29 Jul 2025 16:44:37 -0400
Message-Id: <20250729204437.164320-1-sean.anderson@linux.dev>
In-Reply-To: <d2d62793-046c-4b55-93ed-1d1f43cff7f2@gmail.com>
References: <d2d62793-046c-4b55-93ed-1d1f43cff7f2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are more unsupported functions than just LOWRT_RTY. Improve on
commit 3b66519b023b ("wifi: rtw89: phy: add dummy c2h handler to avoid
warning message") by printing a message just once when we first
encounter an unsupported class. Do the same for each unsupported func of
the supported classes. This prevents messages like

rtw89_8922ae 0000:81:00.0: PHY c2h class 2 not support

from filling up dmesg.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Also suppress unsupported func messages

 drivers/net/wireless/realtek/rtw89/phy.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index f4eee642e5ce..9484d80eea9b 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3535,17 +3535,25 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 {
 	void (*handler)(struct rtw89_dev *rtwdev,
 			struct sk_buff *c2h, u32 len) = NULL;
+	static DECLARE_BITMAP(printed_ra, U8_MAX);
+	static DECLARE_BITMAP(printed_rfk_log, U8_MAX);
+	static DECLARE_BITMAP(printed_rfk_report, U8_MAX);
+	static DECLARE_BITMAP(printed_class, U8_MAX);
+	unsigned long *printed;
 
 	switch (class) {
 	case RTW89_PHY_C2H_CLASS_RA:
+		printed = printed_ra;
 		if (func < RTW89_PHY_C2H_FUNC_RA_MAX)
 			handler = rtw89_phy_c2h_ra_handler[func];
 		break;
 	case RTW89_PHY_C2H_RFK_LOG:
+		printed = printed_rfk_log;
 		if (func < ARRAY_SIZE(rtw89_phy_c2h_rfk_log_handler))
 			handler = rtw89_phy_c2h_rfk_log_handler[func];
 		break;
 	case RTW89_PHY_C2H_RFK_REPORT:
+		printed = printed_rfk_report;
 		if (func < ARRAY_SIZE(rtw89_phy_c2h_rfk_report_handler))
 			handler = rtw89_phy_c2h_rfk_report_handler[func];
 		break;
@@ -3554,12 +3562,16 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			return;
 		fallthrough;
 	default:
-		rtw89_info(rtwdev, "PHY c2h class %d not support\n", class);
+		if (!test_and_set_bit(class, printed_class))
+			rtw89_info(rtwdev, "PHY c2h class %d not supported\n",
+				   class);
 		return;
 	}
 	if (!handler) {
-		rtw89_info(rtwdev, "PHY c2h class %d func %d not support\n", class,
-			   func);
+		if (!test_and_set_bit(func, printed))
+			rtw89_info(rtwdev,
+				   "PHY c2h class %d func %d not supported\n",
+				   class, func);
 		return;
 	}
 	handler(rtwdev, skb, len);
-- 
2.35.1.1320.gc452695387.dirty


