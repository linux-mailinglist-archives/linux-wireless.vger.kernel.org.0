Return-Path: <linux-wireless+bounces-29684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85804CB77E1
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 01:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7999530056EC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 00:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54F6239E97;
	Fri, 12 Dec 2025 00:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailb.org header.i=@mailb.org header.b="Qqffk3ZZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.mailb.org (mailb.org [138.201.70.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AB82459F7
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 00:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.70.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765500973; cv=none; b=kZuH7AbJmex+3uH4QtksGvipgnNGlVNCfOFEk9qMsV0NvWGxwI9KdXOxZEh+b10XSouOMS95Cmzv+ZPlFohH4ynOX0LqG80+DC62FGaWv52EqIccUoFwG0ES21Y3sRessJopWNpWu0renRvK899zSZ2rLqoSfWbEnTVIzRJoYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765500973; c=relaxed/simple;
	bh=DS1SiBDvIeRVbcGQz/eZnDF6CCewaP5K6/grztHQY1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHzXTT8e5ZRLyfgY6oVAmBvvPE00RK4dLaxWpuAQ+8o0OEd1WzyayHJ2YM9veAHW6w+sX5LvbNr6WHP+kPGOwinLhruKhG3l8JLRSKIUJnjDBiSH3bhhb/flB54L1z1oCoPljN6G82tTmYHDknoaHTRe4K9bXpRn5QocfgDWxKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailb.org; spf=pass smtp.mailfrom=mailb.org; dkim=pass (2048-bit key) header.d=mailb.org header.i=@mailb.org header.b=Qqffk3ZZ; arc=none smtp.client-ip=138.201.70.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailb.org
Received: from mx.mailb.org (localhost.localdomain [127.0.0.1])
	by mx.mailb.org (Postfix) with ESMTP id A0D9DB69867D
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 00:56:05 +0000 (UTC)
Received: from authenticated-user (localhost [127.0.0.1])
	by mx.mailb.org (Postfix) with ESMTPSA id 7222AB69867B;
	Fri, 12 Dec 2025 00:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailb.org; s=2024;
	t=1765500965; bh=DS1SiBDvIeRVbcGQz/eZnDF6CCewaP5K6/grztHQY1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qqffk3ZZ+p5DaC+KMGMBZ8wTwUCXfL46Hum9mEp2AdnCSdSLRZtJYGw+ekYZOvaij
	 M2x/m/1zIfT2mFihwbzuOkTm34eSfPTK7ru5VsQI1QhUT6fCVBlUO5fXlxL+jHTmlV
	 Z2g0xoj2uDxNS4X34zsg6sPgcRM/CsYbKKAafAG+FlX1pOQFgR4ZI6Kcx0lxrazCOi
	 sdOzm7EDQiFkGjP2Foo+BvJB1UFDOjAbXq0G/nNVrYGxUkJod8C4cu5kWv8ttya33y
	 VuqtBYLeIET1D1bSpXELNxYxfSxhutE3VmE7vrOBUCX9GB4YNPkeVbi2B1YiGrUCFZ
	 qSpNAi7UOvyrw==
Received: from authenticated-user (localhost [127.0.0.1])
	id 785C630F2198; Fri, 12 Dec 2025 01:56:03 +0100 (CET)
From: Jan Gerber <j@mailb.org>
To: linux-wireless@vger.kernel.org
Cc: Jan Gerber <j@mailb.org>
Subject: [PATCH] wifi: rtw89: 8852au: add support for TP TX30U Plus
Date: Fri, 12 Dec 2025 01:54:21 +0100
Message-ID: <20251212005515.2059533-1-j@mailb.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <5b26cb7740894638b84fedfcad52ca03@realtek.com>
References: <5b26cb7740894638b84fedfcad52ca03@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

the device shows up like this and everything seams to work:

Bus 004 Device 003: ID 3625:010d Realtek 802.11ax WLAN Adapter

Signed-off-by: Jan Gerber <j@mailb.org>
---
 drivers/net/wireless/realtek/rtw89/rtw8852au.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852au.c b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
index ca782469c..74a976c98 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852au.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
@@ -60,6 +60,8 @@ static const struct usb_device_id rtw_8852au_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0141, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010d, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010f, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{},
-- 
2.51.0


