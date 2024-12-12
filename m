Return-Path: <linux-wireless+bounces-16281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB46F9EDDE0
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 04:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210DF1883E26
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 03:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A16661FEB;
	Thu, 12 Dec 2024 03:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ej4mF8NZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B342F44
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 03:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733973457; cv=none; b=T1OR56eVxf56o/uUeLbMsvFv34MZo5wh5+Iyea4ixluSwxoQp5m9gz9chL9wn/x/CKCmGwAyp+HzDVfJYPGlDOCo1DbMpI21GdvOE3M4uib2qREFVYouGROVVrY1PXn2geaadGl99GHK4iYTCqdhFaG5lvrACDk6Z7J0JmOmwDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733973457; c=relaxed/simple;
	bh=wieH9je3gdtSTR64Nw+xweMM+CTGIvRTyvSKIBb6jgc=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=QcQDeJ2719yBTdvkhLaTd3WmbxTx9OBfMKRmHu2rxgETgNMU9E3QgwZCrfwD/Svpz7M4N0e1iMgSSbDMvq12uNJFqsIJxyd9DNsjZQIPGUEjjJ4sZsef/mCjHsjwKACf0Q91D6fX61blqKJSEGhLA3r1WhEUkjuXZhaNF68A5z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ej4mF8NZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BC3HWmM4543481, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733973453; bh=wieH9je3gdtSTR64Nw+xweMM+CTGIvRTyvSKIBb6jgc=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=ej4mF8NZAzu1QQMZ6rxS8qsZHnBkiCyA6+RSKbdDDFD5yCURJsKsPV4f0YpX6BH4D
	 VPtFpjT9ZeVrAV9xdXC2+0LsdIyNrPtLPZ/IwRjKSi6ZClumV0gDzeZxcFRV3SwmFK
	 9S1WJzRfJsE0tzmokprx6qQajPUYePRDoU4hCcKsRRETI3aTxTVqTTLE7jFUWIYvsJ
	 wcJ6L5HRJmfOeMwahUewoclHXfXd/dUGyFgXPRhYRcXF24m1hgCC+5PNtw92Covr7e
	 qqeGgohefmsKGbW/GF1GXgDmYodJLXAU+MoCVRuaPYly47pyWQg5y+ccun8ni9eOjW
	 YLsBFJZo1UkwA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BC3HWmM4543481
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 11:17:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 11:17:33 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 12 Dec
 2024 11:17:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: phy: add dummy C2H event handler for report of TAS power
In-Reply-To: <20241209042127.21424-1-pkshih@realtek.com>
References: <20241209042127.21424-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <85f32ec7-7ade-4091-aa94-58ddcc5b7316@RTEXMBS04.realtek.com.tw>
Date: Thu, 12 Dec 2024 11:17:32 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The newer firmware, lik RTL8852C version 0.27.111.0, will notify driver
> report of TAS (Time Averaged SAR) power by new C2H events. This is to
> assist in higher accurate calculation of TAS.
> 
> For now, driver doesn't use the report yet, so add a dummy handler to
> avoid it throws info like:
>    rtw89_8852ce 0000:03:00.0: c2h class 9 func 6 not support
> 
> Also add "MAC" and "PHY" to the message to disambiguate the source of
> C2H event.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

09489812013f wifi: rtw89: phy: add dummy C2H event handler for report of TAS power

---
https://github.com/pkshih/rtw.git


