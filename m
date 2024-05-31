Return-Path: <linux-wireless+bounces-8330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64788D56FE
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 02:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58175281339
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 00:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9ED4C7B;
	Fri, 31 May 2024 00:35:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43B44C6D;
	Fri, 31 May 2024 00:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717115745; cv=none; b=uDIp02ZCoIiX0W5aWTXFQpCdvVlCLwibRoF4zLkKyGcNhVCf6VqciDsuIfAJR+0aVWE07X+AYDObY02x17mj1/Uw1uDuEQ3zJbDgFqnsCi1MKGX/pZqy8xG6XDnONqBOsNDBK296CDIC2RXHx7GC1+YeXzj8qM2jVbilGYrihss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717115745; c=relaxed/simple;
	bh=n0W16ZB8rKgIlRPKmZ/8d+8VTHhnV74vUu4dvxg/fzA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ui0abWoPJuwgZKOZRzwcBFWpgr7Xq1TtkBcwN+AbVDlfgZwsH1/CMaFaADXn/ddjI6NZeZ/8Qz6gUh/Y5Czk6THNQ8dFiqM7fe1Ca31ZkOMOEUrXPX4N2coWsnCXzsBaz1fxZKSV+7ephHFOVht9DdW09pBSGsN1hxqcO15TY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44V0ZEHr81340470, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44V0ZEHr81340470
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 08:35:14 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 08:35:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 31 May 2024 08:35:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 31 May 2024 08:35:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Tim K <tpkuester@gmail.com>
CC: =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <marcin.slusarz@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <mslusarz@renau.com>,
        Larry Finger
	<Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: schedule rx work after everything is set up
Thread-Topic: [PATCH] wifi: rtw88: schedule rx work after everything is set up
Thread-Index: AQHasFekMjDEF5R7/k+0650S2/2b8bGrUuCQgACfb4CAAAQJAIABdicQgAHpfgCAAS0NwA==
Date: Fri, 31 May 2024 00:35:14 +0000
Message-ID: <7226128cc7b442c3b9c6a0a949ad590f@realtek.com>
References: <13e848c1544245e6aef4b89c3f38daf0@realtek.com>
 <20240528110246.477321-1-marcin.slusarz@gmail.com>
 <801bd77995184b1fa35bf4a32ab3a036@realtek.com>
 <CA+shoWSt44WxS6s=z8wR3AMRYFj9tuxWdkwVLG5i2mU34jn4Xw@mail.gmail.com>
In-Reply-To: <CA+shoWSt44WxS6s=z8wR3AMRYFj9tuxWdkwVLG5i2mU34jn4Xw@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

VGltIEsgPHRwa3Vlc3RlckBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gPiBJIGdhdmUgdGhpcyBz
dWdnZXN0aW9ucyB0b28gZWFybHksIHNpbmNlIHdlIGhhdmUgbm90IGdvdHRlbiB0ZXN0IHJlc3Vs
dCBmcm9tIFRpbS4NCj4gPiBJIHdpbGwgY2hhbmdlIHRoZW0gdG8gIkxpbms6IiBpZiBubyBBQ0sg
ZnJvbSBUaW0gd2hpbGUgbWVyZ2luZy4NCj4gDQo+IEhleSBhbGwsIHRoYW5rcyBmb3IgcmVhY2hp
bmcgb3V0IQ0KPiANCj4gU2FkbHkgSSdtIG5vdCBhYmxlIHRvIHdvcmsgb24gdGhpcyBwcm9qZWN0
IHJpZ2h0IG5vdywgYnV0IEkndmUNCj4gZm9yd2FyZGVkIHRoaXMgZW1haWwgdG8gYSBmZXcgY29s
bGVhZ3VlcyB0byBicmluZyB0aGVtIGluIHRoZSBsb29wLg0KPiBEaWQgeW91IGhhdmUgYSB0aW1l
bGluZSB5b3Ugd2VyZSBsb29raW5nIGF0IHRvIGNsb3NlIHRoaXMgb2ZmPw0KDQpUaGFua3MgZm9y
IHlvdXIgcmVwbHkuIEkgd291bGQgdGFrZSB0aGlzIHBhdGNoIHRvIDYuMTEsIHNvIHlvdSBoYXZl
IGFib3V0DQo0LTUgd2Vla3MuIElzIGl0IGVub3VnaCB0byB5b3U/DQoNClBpbmctS2UNCg0K

