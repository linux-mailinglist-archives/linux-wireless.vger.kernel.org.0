Return-Path: <linux-wireless+bounces-11168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC79B94CB22
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1801C229EF
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 07:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3877C174ED0;
	Fri,  9 Aug 2024 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="RGQWx0XV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6617335E
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188063; cv=none; b=cWoCAtk+WZaa9dysM2XH7dv7jS/nQVae7scVXwSwidWotqeCxIssRgL8X5W8X1ZhypM/DjW0yPXIhtNLoZrmekssMebSpauCeiYD6XqehizIz5yFt68JOFUcRGXe6KIQ7OVJbyzvo5dKsuW4+KBsIvpjUI20P+TzhCg3zwgFWa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188063; c=relaxed/simple;
	bh=jqXaz/oFnjs6SuG1hqWfpjS7t6bOOJSGtZ5NLkJdjts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRYyKzfwRIuxoizNJ0pw1J92+GXkHkBu8wTQBGzzmDAEQHnXjYKhILPkSvWJCDnDZ69bCrg7BWUYIs+w8bZ/uORVVzZ+gQEbv3marQqJ8TjOdi1c+vS3XiE2FxZKEMNL9bwYKLdjYR0hYW6wxdGHgAQuqLPxT76rKxyFwtE+Vhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=RGQWx0XV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4797KvhI6514077, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723188057; bh=jqXaz/oFnjs6SuG1hqWfpjS7t6bOOJSGtZ5NLkJdjts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=RGQWx0XVYzuvyrForS4I0AwyTyNcX73IvtNsF2mDFfmHKeK3tqWqCc9U1PrTK0PvG
	 E2b/kt6+SIOw0BggujE2hSN8Rg1QwKkYHfbbbmhucB4LKmjK94sFTrV1bPKva7e2eV
	 /x5Me09RHKbgdbmmn/u31gYqfQ3dTJruMQ7IRfK25F13TMzVRBWEz2IEGxKERISAFh
	 utnA2lyTbw7mwJsS7LJjhhpAsPWLR9buI+EP5PycW000dK+NLWqZWIyMtMjhLZkGmZ
	 xNmOI+8lQ4cdUUJJL1HUgG68rSvGUCRudbocDaTrvOpdop7ah/CrHaRMNvk7pGpNIe
	 F5JKsUgCQwOGw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4797KvhI6514077
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 9 Aug 2024 15:20:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 15:20:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Aug
 2024 15:20:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH 5/6] wifi: rtw89: 8852a: adjust ANA clock to 12M
Date: Fri, 9 Aug 2024 15:20:11 +0800
Message-ID: <20240809072012.84152-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809072012.84152-1-pkshih@realtek.com>
References: <20240809072012.84152-1-pkshih@realtek.com>
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

To reduce the I/O time from power save mode for 8852a,
adjust ANA clock from 500k to 12M.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index b073e041a16b..1cbea8d665a2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -337,6 +337,11 @@ static const struct rtw89_pwr_cfg rtw8852a_pwroff[] = {
 	 PWR_INTF_MSK_PCIE,
 	 PWR_BASE_MAC,
 	 PWR_CMD_WRITE, BIT(0), 0},
+	{0x0092,
+	 PWR_CV_MSK_ALL,
+	 PWR_INTF_MSK_PCIE,
+	 PWR_BASE_MAC,
+	 PWR_CMD_WRITE, BIT(4), BIT(4)},
 	{0x0005,
 	 PWR_CV_MSK_ALL,
 	 PWR_INTF_MSK_PCIE,
-- 
2.25.1


