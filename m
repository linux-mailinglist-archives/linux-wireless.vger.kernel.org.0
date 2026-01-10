Return-Path: <linux-wireless+bounces-30616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C884CD0CD0A
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 03:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B87830024EB
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 02:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1B924E4AF;
	Sat, 10 Jan 2026 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MwTo0GSE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549E2248896
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011636; cv=none; b=Uv9TCfslZpeLZJ0PuT8UUulHxrxAmWJCtedDCTeGIH0xCVzXH+/60tuCZo8z2j0pRYIBz1LLup8D2LeyLeKBI6bLtegirQNwBAzM2loz2PWNfJ7Vtl5ls2up8jHjZDf6JIvheVLwJElHfietTaqSlXPHdOx5RkLV5oBvtcnquNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011636; c=relaxed/simple;
	bh=7gO7XYjUhh2zR3LcpARVGMEh9VnvDIo8TSiHqvtznfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Td08XT8HH/WvG21+IhpRwo79J76/LGYa/LEy+Z0hEL5W9E0AAhPOF6/cMcmyy9mw2eYRbpEVlgvCi4QlbX+0DNFnzrU3LxKH48+SeWkhesptIODBmh2fMXJgW6t++5eeQGOs7W4swAiviBEC2JLb9+u+ebVUPXhcsEdic6qUtIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MwTo0GSE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60A2KU3X0241717, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768011630; bh=Zy5ANp2t5u42IqhHEE0naT6mIyz1IVWZybrLB0xjk6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=MwTo0GSE2BBuWffgFqV7PZzDV/JXqyEw7BLQv5DZeZ6GpUh/mJ8i9Iy8A7x9dhepo
	 PJtF1AqQbPhSY1O3HtXpxpSLDtGvdKUOX9CtEbV9YmNSBGVgCWPT2m8izwmL/+/D8r
	 pYY7AIz8KyTRCdWsbv97U0XoCrDSN9s1chaxZL8S/HqTWgWyqBo28wrhtH9HI3cJd2
	 mr5smGhfNB9wgJPKc2Z0tGo8fkDFRWayaR+B8bXE37O4eJ1GFbvLE2++V7St1MC0Uy
	 xLAZfKb7K+6H4BCArdBzjZ/uxNnl/oDaiSaNKdTEFZGA/4F/gsBt2NP542bzxkwfsX
	 q66bGI7Xp4fAw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60A2KU3X0241717
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 10:20:30 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 10 Jan 2026 10:20:30 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 10 Jan 2026 10:20:30 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 10 Jan 2026 10:20:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 2/8] wifi: rtw89: wow: add reason codes for disassociation in WoWLAN mode
Date: Sat, 10 Jan 2026 10:20:13 +0800
Message-ID: <20260110022019.2254969-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260110022019.2254969-1-pkshih@realtek.com>
References: <20260110022019.2254969-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Chin-Yen Lee <timlee@realtek.com>

Some APs disconnect clients by sending a Disassociation frame
rather than a Deauthentication frame. Since these frames use
different reason codes in WoWLAN mode, this commit adds support
for handling Disassociation to prevent missed disconnection events.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/wow.c | 4 ++++
 drivers/net/wireless/realtek/rtw89/wow.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 8224f0e3fb9a..5d3227e2b3e4 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -809,6 +809,10 @@ static void rtw89_wow_show_wakeup_reason(struct rtw89_dev *rtwdev)
 
 	reason = rtw89_read8(rtwdev, wow_reason_reg);
 	switch (reason) {
+	case RTW89_WOW_RSN_RX_DISASSOC:
+		wakeup.disconnect = true;
+		rtw89_debug(rtwdev, RTW89_DBG_WOW, "WOW: Rx disassoc\n");
+		break;
 	case RTW89_WOW_RSN_RX_DEAUTH:
 		wakeup.disconnect = true;
 		rtw89_debug(rtwdev, RTW89_DBG_WOW, "WOW: Rx deauth\n");
diff --git a/drivers/net/wireless/realtek/rtw89/wow.h b/drivers/net/wireless/realtek/rtw89/wow.h
index d2ba6cebc2a6..71e07f482174 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.h
+++ b/drivers/net/wireless/realtek/rtw89/wow.h
@@ -33,6 +33,7 @@
 enum rtw89_wake_reason {
 	RTW89_WOW_RSN_RX_PTK_REKEY = 0x1,
 	RTW89_WOW_RSN_RX_GTK_REKEY = 0x2,
+	RTW89_WOW_RSN_RX_DISASSOC = 0x4,
 	RTW89_WOW_RSN_RX_DEAUTH = 0x8,
 	RTW89_WOW_RSN_DISCONNECT = 0x10,
 	RTW89_WOW_RSN_RX_MAGIC_PKT = 0x21,
-- 
2.25.1


