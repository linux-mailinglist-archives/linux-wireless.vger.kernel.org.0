Return-Path: <linux-wireless+bounces-29678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD45CB734E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 22:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B299300F8A7
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 21:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D1C2877FC;
	Thu, 11 Dec 2025 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailb.org header.i=@mailb.org header.b="IidVu1I1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.mailb.org (mailb.org [138.201.70.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D962701CB
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.70.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765487848; cv=none; b=Xu9ttw3WOhYvsBBY3/Ds6ulFXeA1jIdv9O+T9qZ7VSg6MXzzJomolDfyWwtukQgDKXngBG1PGJXD3b1G1hRlQEwAqPGk4vtTYyRVcHH+izhHVWkrB2mL3y5y19i0fAN23ZGu5JdavpJOBMOnXVEowDw5qyrTcV90+tCujNjwxUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765487848; c=relaxed/simple;
	bh=vyL34LRgsv78NCg5PwtT0HUtbIVkFFw3TyoFpcf9PXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUoPQPHewPu7jpiYdnctkW5zhRkK+W9TJFm6kvfLdCS/jWJh4JgwZSpg9UOW/4Xc8yc+N/z/c4K4KNy6WVCYAc+wdA1iYU1Ama1vePJeu0uRkFizOoQahXSfp2mq/JyLg4ThHEVxpdNevQIZYQJxB+CTNrOPldA7OlGtJ5/Ojno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailb.org; spf=pass smtp.mailfrom=mailb.org; dkim=pass (2048-bit key) header.d=mailb.org header.i=@mailb.org header.b=IidVu1I1; arc=none smtp.client-ip=138.201.70.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailb.org
Received: from mx.mailb.org (localhost.localdomain [127.0.0.1])
	by mx.mailb.org (Postfix) with ESMTP id 0B29FB695596
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 21:17:22 +0000 (UTC)
Received: from authenticated-user (localhost [127.0.0.1])
	by mx.mailb.org (Postfix) with ESMTPSA id C83FCB695595;
	Thu, 11 Dec 2025 21:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailb.org; s=2024;
	t=1765487841; bh=vyL34LRgsv78NCg5PwtT0HUtbIVkFFw3TyoFpcf9PXE=;
	h=From:To:Cc:Subject:Date:From;
	b=IidVu1I1wukhLH4KnL/UrHAANkSGbVFy38tvDB3kN0pdThOyLI/Sea/zrZdmItZ81
	 UKxU3R1C0ZzmkMYt3Jno7XGojPbZIVcA5gpWTs/ofxuqq6B/RdN+JlZjb+Af6KF5Rp
	 M107gcgALr/4EbvwFcCuDI5N/aFc/pRlQjtHD34vGDiQr3rdJgLla2FvEUG3sg3JgA
	 5vjoAGfxuZYSYYiU7xybZujEALKA7FYWtYje5oDtbHvhAvJc/mVpySJZXT8y0W0daT
	 aTOYKnTx6lDO8fHWJViXhTgxkL4v95N1JZhrbGoXK+tFMu+mpo90T0f35gsR2kn6sO
	 QWBiZTy03/3Ng==
Received: from authenticated-user (localhost [127.0.0.1])
	id D91A430EE73A; Thu, 11 Dec 2025 22:17:20 +0100 (CET)
From: Jan Gerber <j@mailb.org>
To: linux-wireless@vger.kernel.org
Cc: Jan Gerber <j@mailb.org>
Subject: [PATCH] Add support for TP TX30U Plus
Date: Thu, 11 Dec 2025 22:16:39 +0100
Message-ID: <20251211211707.2020656-1-j@mailb.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

the device shows up like this and everything seams to work:

Bus 004 Device 003: ID 3625:010d Realtek 802.11ax WLAN Adapter
---
 drivers/net/wireless/realtek/rtw89/rtw8852au.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852au.c b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
index ca782469c..83a8321e8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852au.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
@@ -62,6 +62,8 @@ static const struct usb_device_id rtw_8852au_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010f, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010d, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8852au_id_table);
-- 
2.51.0


