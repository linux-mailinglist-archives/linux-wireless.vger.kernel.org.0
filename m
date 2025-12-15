Return-Path: <linux-wireless+bounces-29749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7400CBD09E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 09:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2F4A303C2A9
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 08:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AF0329383;
	Mon, 15 Dec 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="eUL7bRL1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C5441C72
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788178; cv=none; b=T+vpvWc7IIc966J/HeIM+NNrEScNrpdYqTaJHBFHI8WlkYlUMJVXYcHN7WDTCJFS5Z09rCICDcUdeKeT2gnAiyHxYvVt32mliGjy9cWFw7VwjwBHW/Jbm64aZhIJftHi3W6Y7m/iwizOMHp84qvu9ZfxGPfcBopxPMVu88dI+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788178; c=relaxed/simple;
	bh=vTTP/fV8gnQczaaWPR9r9rPIMbQstK305O/WufEolnY=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=GCGHXdYum4rjpcLSgwOGvXna6Btb89zWwl3n7SipZjSZ4t4UxeMWE2Jj/BjaJceveBZt1qoe/vWczBP9mjiiWFTnj5ZEGbl3bnWLMzWJ/Temx8gecbIyVPf43XCA0Inkj94tl9GvtCt7v5roQFWTyD8VI8JGgJUpvWYehGBQsv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=eUL7bRL1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BF8gqZmB1493449, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765788172; bh=ZPLgK3k2qEGb+/mu2RkaC6ZPlywTdkOO0SYvdTf7YHA=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=eUL7bRL14c7xI7h9IISr/QLt/X1QiM4TGO6lC9ve+gXrFqK8FQPPEBCxhGrbQpOBv
	 fdKlIqWwrkTIYcHE4i1FhEQnM8yJIIqSEcL+jEaXGqAcRsyUBWqJOvcftvA4EZykpn
	 7j2YHS7f3ao18V26NL9lVZP3XTpfaBzFG0pShonhFWOtB5moAiYvsESzyqhrU6GYmX
	 628wHE/t0AJwUcU5b5QtgzOkCXZx2L4KLMbdc41VNE3swCOyebEfFJwT9nOmHgzJuE
	 AkFLviedseUvblrzb4Qk5cEg1O3fwgwHypa2EkLsG5sVdAy46BOvIdrUyglM1OmlYS
	 JU2HplEzOX2tQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BF8gqZmB1493449
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 16:42:52 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 15 Dec 2025 16:42:52 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 15 Dec 2025 16:42:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <andrej.skvortzov@gmail.com>
Subject: Re: [PATCH rtw] wifi: rtw88: limit indirect IO under powered off for RTL8822CS
In-Reply-To: <1764034729-1251-1-git-send-email-pkshih@realtek.com>
References: <1764034729-1251-1-git-send-email-pkshih@realtek.com>
Message-ID: <651c3c3e-1587-446e-8d22-f966075bb618@RTKEXHMBS03.realtek.com.tw>
Date: Mon, 15 Dec 2025 16:42:52 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The indirect IO is necessary for RTL8822CS, but not necessary for other
> chips. Otherwiese, it throws errors and becomes unusable.
> 
>  rtw88_8723cs mmc1:0001:1: WOW Firmware version 11.0.0, H2C version 0
>  rtw88_8723cs mmc1:0001:1: Firmware version 11.0.0, H2C version 0
>  rtw88_8723cs mmc1:0001:1: sdio read32 failed (0xf0): -110
>  rtw88_8723cs mmc1:0001:1: sdio write8 failed (0x1c): -110
>  rtw88_8723cs mmc1:0001:1: sdio read32 failed (0xf0): -110
> 
> By vendor driver, only RTL8822CS and RTL8822ES need indirect IO, but
> RTL8822ES isn't supported yet. Therefore, limit it to RTL8822CS only.
> 
> Reported-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> Closes: https://lore.kernel.org/linux-wireless/07a32e2d6c764eb1bd9415b5a921a652@realtek.com/T/#m997b4522f7209ba629561c776bfd1d13ab24c1d4
> Fixes: 58de1f91e033 ("wifi: rtw88: sdio: use indirect IO for device registers before power-on")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

1 patch(es) applied to rtw branch of rtw.git, thanks.

f3ccdfda345c wifi: rtw88: limit indirect IO under powered off for RTL8822CS

---
https://github.com/pkshih/rtw.git


