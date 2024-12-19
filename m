Return-Path: <linux-wireless+bounces-16566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3279F7245
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 02:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268A7188ED87
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 01:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E164914A0AA;
	Thu, 19 Dec 2024 01:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="UuCQ3Yi/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFACF70828
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 01:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572771; cv=none; b=Bl1Jxr22ES2x3vddN3pKVvO/RUy+Si9V7ZDAYuHGQ7Ezsw42zmwWlIjEvYFWm4AXfKHpZgc6whZQDLTmB07OEG/ludsv4FfobA3XsjoQr9Z4iXiyntmXZcRFbPx7OI7gqBOnOSavqEQRdBSQQ9FDFavtLkAqVafFeBAvyJYuGsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572771; c=relaxed/simple;
	bh=h/VzLiiR1m5Cg7uM6+ZnlNxlAq1RzMdOnoa/Upl78b4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zo5lkt0ssxCT8a7MBlgky82yo+QQW5TNpHBvlX2VAP3OgfwvzFZ42i6jadDOE1G3qKHz4FSFSRXAWMmGP1D/9hKAz9YS4x/0aKQJXwWykVqFBv9z85zUwsItzQ3WOImyAifwwEkaS3M+1M6XQ4HiTs1CC/QQrGWc0wmh2rTIt+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=UuCQ3Yi/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BJ1k55S13210961, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734572765; bh=h/VzLiiR1m5Cg7uM6+ZnlNxlAq1RzMdOnoa/Upl78b4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=UuCQ3Yi/ObeqGIzY6O9ePKfIK/6AcU/Yip5cI07th+FanzunnPuTDlQ+qBnSUUWCq
	 6kP/KMemW+K8lKk+5Chb9THbyWOKHrOmGw39WJdw4uO/6RFeZ5FvFhSjtos9ZnZg8g
	 pYUg4Q+M0JaMfOgbZ8WfTgeMfJPmRBoH2K6gDM51S1RlwCz/9qIzEc0I/sxTAvPVeZ
	 ENaru1YIQv9iLObAMxCtCXDWXFnL46tPRfJEWZPmCCRgv75qPh7OCC/2jYRfC9qs/8
	 iLxejZSdgJUHfi2+iU7P/zslm2u8RLMSaR46mukoV9YhdM1WzsDOddjNx0D1uBxkSa
	 MDEUrbRWrnwew==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BJ1k55S13210961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 09:46:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Dec 2024 09:46:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 19 Dec
 2024 09:46:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH] wifi: rtw89: debug: print regd for QATAR/UK/THAILAND
Date: Thu, 19 Dec 2024 09:45:45 +0800
Message-ID: <20241219014545.9157-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The regd enum was extended for these countries. But, the dbgfs doesn't
recognize them yet. So, add them.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index fd86752d86f3..09fa977a6e6d 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -812,6 +812,9 @@ static void __print_regd(struct seq_file *m, struct rtw89_dev *rtwdev,
 	case_REGD(MEXICO);
 	case_REGD(UKRAINE);
 	case_REGD(CN);
+	case_REGD(QATAR);
+	case_REGD(UK);
+	case_REGD(THAILAND);
 	}
 }
 
-- 
2.25.1


