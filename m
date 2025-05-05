Return-Path: <linux-wireless+bounces-22423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B897AA8B13
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 04:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFDB3B1A5F
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 02:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D3878F26;
	Mon,  5 May 2025 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="EyKSUY0l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC223774;
	Mon,  5 May 2025 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746410851; cv=none; b=B+zNzn78dAS1aO8GZx1Wl6hDiJ48fBzxMetFgVcN9yI+ugMfHAOgBq3fj73rCMM7TgtLbavJ8qMQQpfeu7z40vz+KDviTOkWuRwHh2CxtoHZ1PVl2oWAIp745WPL863KRk9HKay0kRFsolvuRmUKWUafFB+zGAgQ8DKD4F3RzOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746410851; c=relaxed/simple;
	bh=Tav9PmQKZmzUsR5CxSkiwHa03hkbtc+B6Hulzn4UyvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dzkUr+iw/eNA3DPdZ03Z8rCRe51Aazku6/JeHmUGbqUZIFBvLS68kpzXXNIUKT9DNBz/vCn+3r0iWO5tUwEFn1atbRwMzCacH0sXq4tUg7p7YR/OtDtFaPwGeoxwil3nIZUS/q1iJNpildc1wCM/rVlL+sz7qKqI9Bpn0EeT8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=EyKSUY0l; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 54527MgD43409010, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746410842; bh=Tav9PmQKZmzUsR5CxSkiwHa03hkbtc+B6Hulzn4UyvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=EyKSUY0lf4o5de+0Ev5zkmGr+hLSNam3vWNhXCtCmNk9IFvcBWOf78GOs4Uh6yk8t
	 sXi2W5wea/QgMhOUAgOYsKBVWPqU7xl05n+l4pFb2ZabRlyNqJnzhv6ccdBpXtU40p
	 +AQHwunwSFAsr//IU6RwBnY/BreGtqgYddB87lO6Mr/900ro+x1Zie94RhbIEgxqEx
	 kUNwwr1l2QX+Xzp6oKghMeJRemAc21ZJXdRUYyfRAfCmCR4GvaUuhKqRa/Z955zBaZ
	 uABnQSPPt7UOx1u2HVyNO7p+WtvwJlZOIlrBooAUE0/H6bc55yvtUJ7l5/EDDAaKKc
	 pdZELm04fVLbA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 54527MgD43409010
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 May 2025 10:07:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 10:07:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 May 2025 10:07:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 5 May 2025 10:07:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] wifi: rtlwifi: Remove unused rtl_usb_{resume|suspend}
Thread-Topic: [PATCH 1/3] wifi: rtlwifi: Remove unused
 rtl_usb_{resume|suspend}
Thread-Index: AQHbtj1MyqAfTZ9NHkaxZ8n3RQE1GLPCyF+AgAACH4CAAIzxUA==
Date: Mon, 5 May 2025 02:07:21 +0000
Message-ID: <c1f8ed737bf9455da32725cac943ab76@realtek.com>
References: <20250425235340.288340-1-linux@treblig.org>
 <20250425235340.288340-2-linux@treblig.org>
 <c92a8101-e8fe-4727-9f85-e1e96ef5392c@RTEXMBS04.realtek.com.tw>
 <aBgW0UXKC7ZUo49S@gallifrey>
In-Reply-To: <aBgW0UXKC7ZUo49S@gallifrey>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> Did you see the question in the 0/3 cover letter asking why
> rtl8188ee_bt_hw_init() isn't called?

Checked vendor driver. For RTL8188E, only USB interface implements this fun=
ction,
but no caller. The PCI interface doesn't support Bluetooth.

I think you can find the vendor drivers in github or somewhere. That's not
too hard to address this.=20


