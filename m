Return-Path: <linux-wireless+bounces-10343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 233FE934897
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 09:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38CC1F220E6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 07:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDF08488;
	Thu, 18 Jul 2024 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GX60k3Ok"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79DC41C7F
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721286419; cv=none; b=hcjF3aM/Cm0Zqmni0kAu2nFKG/DgWFvPsK+WGy5mZ7j99+kRc5C5//dsobKwBl1aHMAKFDkKb+/8wZECFc7vA5l5iBltJJwSINzT2iq6Ma0DCldEQk46JimRcrIZuHWysoVjhV0F+OL+4r9Nm//+VZRhMFR56rUHPqVPrRs3MnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721286419; c=relaxed/simple;
	bh=Qq3i2sW8w05AixKZYKoZSlpUhcOw2mfyMiHUeKsomVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHRcHbr5GF3Oe0/w3a0nIClJVKKTRncYrQdkRo8b+nj2+IFYkPP+bQFBq7IkvQern7FmypQtAXtQLniv95gaRboSKq8kbwMqOG2GU0WeuydJ4S/rV9gDk5I0iS94zsMUlXVUwdCG/SqJUcgz4SEJ67/xkMcXh1J1HtKBj2X0h9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GX60k3Ok; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46I76su463097212, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721286414; bh=Qq3i2sW8w05AixKZYKoZSlpUhcOw2mfyMiHUeKsomVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GX60k3OkPSwnxG/0D/oqKeBJqkEq99NgieXxqOl80FrVO+DnrgEDvxuOI1C4ifltb
	 w280y1qVajDXaGjsm+75EE1UXmNZeUECBNPxQneY0wcAFkJlzuvwEm3brxd67/a3Ab
	 B6fmsTNrc0u3HS+jX+ye2XKDlvuI/1p1EkcctVPQTUc02tBvS/3EYpVpoAgMFUJQTe
	 AMWCgbFTuDmYU3SkQzo7kiIBZ65GOLUklQfLMRCzOiDVvDgX+YHgshom26o8J8kXfJ
	 b6yisffH1HUeXjPHJ5ok7j7a8IIkF4OI7rqMvS3iuUZAs7nKU6O7dg4lUtgDtg2I2Q
	 DmnboynKSdjrA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46I76su463097212
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 15:06:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 15:06:54 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Jul
 2024 15:06:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 2/2] wifi: rtw89: select WANT_DEV_COREDUMP
Date: Thu, 18 Jul 2024 15:06:16 +0800
Message-ID: <20240718070616.42217-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240718070616.42217-1-pkshih@realtek.com>
References: <20240718070616.42217-1-pkshih@realtek.com>
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

We have invoked device coredump when fw crash.
Should select WANT_DEV_COREDUMP by ourselves.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
index 3c9f864805b1..6278fd74e98e 100644
--- a/drivers/net/wireless/realtek/rtw89/Kconfig
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -12,6 +12,7 @@ if RTW89
 
 config RTW89_CORE
 	tristate
+	select WANT_DEV_COREDUMP
 
 config RTW89_PCI
 	tristate
-- 
2.25.1


