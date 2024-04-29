Return-Path: <linux-wireless+bounces-6958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BA18B4F9A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 04:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BCE1F217D9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 02:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE2D79F5;
	Mon, 29 Apr 2024 02:55:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB079E1
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714359307; cv=none; b=OcoNzcagbhcRGKcTVWdhR9P5doWBYaveJc4smeEocVr/KKv0KqxGAcRTVfBrbGrNOuij42UOBvvSrHHEiKaiCoc/FxlNyMEx/BxDsdcfCpw40dB8D5xqO2ryTNRTE4Hu89Xri6qfrRTTw3UFS+oDGBXMXWqdhOB4EWCRU56sa6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714359307; c=relaxed/simple;
	bh=LJqXLclgEXWgEq0wmjImzwHdCg/LLYPoRcBx7CxfuU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=MKvc/os6Oxiu2OoDD3PNKAVgRhXJm5/WI23UH5x1aJDsqHCAvGqKuZFdVyGnrlp7QUiIrWQ62MtYOEg1HH9VY8jl0a5imY37qqNWMCn2kndMf5KWhXXh14mA40r/5LSQsqiIHglwx9dcGTpzyTxb8yUCPmr4fhEwmMWTtuvoKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43T2st7aB2984716, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43T2st7aB2984716
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 10:54:55 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 10:54:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 10:54:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 29 Apr 2024 10:54:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/2] wifi: rtl8xxxu: remove some unused includes
Thread-Topic: [PATCH 1/2] wifi: rtl8xxxu: remove some unused includes
Thread-Index: AQHal+TKjpgPPiYrQUiGyEHZzIn5BLF+gaLggAAORjA=
Date: Mon, 29 Apr 2024 02:54:55 +0000
Message-ID: <2a9fdafb5b5843c58cb080f8933b1e0a@realtek.com>
References: <20240426141939.3881678-1-kvalo@kernel.org> 
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Ping-Ke Shih wrote:
> Kalle Valo <kvalo@kernel.org> wrote:
> > I noticed by random that rtl8xxxu includes linux/wireless.h even though=
 it
> > doesn't need it. While investigating a bit more I found even more unuse=
d
> > include files:
> >
> > #include <linux/init.h>
> > #include <linux/sched.h>
> > #include <linux/ethtool.h>
> >
> > It looks like that the includes are just copied to every file without c=
hecking
> > if the file really needs the include. So more includes could be removed=
 but
> > that would need more careful analysis per each file.
>=20
> I can do that. My ways will be to create an empty (new) C file to examine
> every driver's header file can be included individually, and then try-and=
-error
> to remove includes from existing C files.

I made a patch [1] followed above ways based on these two patches.

>=20
> However, this driver uses #ifdef. I will check if autoconf.h is included.

Make script of kernel will automatically include include/linux/kconfig.h, s=
o
I didn't need extra works for #ifdef.

[1] https://lore.kernel.org/linux-wireless/20240429024711.30992-1-pkshih@re=
altek.com/T/#u


