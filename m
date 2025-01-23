Return-Path: <linux-wireless+bounces-17852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A8AA19D09
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 03:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12F9188CDA1
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 02:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531913596B;
	Thu, 23 Jan 2025 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qKynMFDH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A28635953;
	Thu, 23 Jan 2025 02:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737600769; cv=none; b=rWU91SBFDZUdvZxm2ShQKfMioDW7euANFLhWWr2OLr9BG89FqL5zjKD9muThsP41yA55BY3veVj3ZOUj8ZKwKbChGJS0FMVGWON1tWScS9WAl80T3bsYT+4GN8H0uleGqWwZTdWY7oEFyFqm7QnJEk3CwAtEAKD4/oZDQsN0DYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737600769; c=relaxed/simple;
	bh=70ZX58mdXw6jxKakY/0D08brVvXTPVBXFTDAzj9Vl2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N7+npkdO+BZSXP8c389mGI2noMBObRcVtQIkz/09z/SPGII0crgGzCJk6Cpgvxvy3X0bkxvR/Rz1cr4Syu1z+ESjQkJq8Zfr8ra9GzITquFvc1mnIvC80FB/OwJDo/DdbafsNTq9v4TMydOBvlOXxHfTM+EUePd/zkL9zQ0CqJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qKynMFDH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50N2qYRd93995438, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737600754; bh=70ZX58mdXw6jxKakY/0D08brVvXTPVBXFTDAzj9Vl2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qKynMFDHO7JQvl/rD11yEvTond5X49DqLOTQCYwGU60QMMsnvUQPU4IQW6cAuGfiR
	 b0l/fMZgsnoDxvD0Xu+KaEhnOqhFsEMHhAqDN2cjKGBLP4jo63FtaIoC9+uzvZ/Nrc
	 hgEVU2d8Hxz4NPGHfspH225v9X9wRAnq4hDFk/yY7DC3PC8HdE/VOtnf7fyjP99HjA
	 w9nuzk9cZGux2Gu+Y4aj3CxyOYz2a+2GMnXpXtgJ4peN+RSbnSKQMOkClqP3GkV5Ns
	 cr+nFM2jIL/aNnj0mT0gcb8SAUYK8xY6KTJEpNGkc1iGxK9IP3ugRt69uE4fPNZng1
	 yNouR4GHZoHJw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50N2qYRd93995438
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 10:52:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 Jan 2025 10:52:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 23 Jan 2025 10:52:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 23 Jan 2025 10:52:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Soeren Moch <smoch@web.de>
CC: Kalle Valo <kvalo@kernel.org>, Jes Sorensen <Jes.Sorensen@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtl8xxxu: retry firmware download on error
Thread-Topic: [PATCH] wifi: rtl8xxxu: retry firmware download on error
Thread-Index: AQHbbOLYBY6qgVShikadjNokwHFEw7MjfZHg//+M9ICAAJSckA==
Date: Thu, 23 Jan 2025 02:52:34 +0000
Message-ID: <9552269787c444de931b3f4476a41d71@realtek.com>
References: <20250122153156.373470-1-smoch@web.de>
 <e08051130a124fcfab8d42e6893c581a@realtek.com>
 <0fb6f633-7ce0-4229-a2fc-df65aeeefd83@web.de>
In-Reply-To: <0fb6f633-7ce0-4229-a2fc-df65aeeefd83@web.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

U29lcmVuIE1vY2ggPHNtb2NoQHdlYi5kZT4gd3JvdGU6DQo+ID4gQWxzbywgdGhpcyBtZXNzYWdl
DQo+ID4gaXNuJ3Qgc28gaW1wb3J0YW50IHRvIHVzZXIsIHNvIGRldl9kYmcoKSBpcyBtb3JlIHN1
aXRhYmxlLCBidXQgYWxyZWFkeSBwcmludGluZw0KPiA+ICIlczogZG93bmxvYWRfZmlybXdhcmUg
JWlcbiIgZm9yIGV2ZXJ5IHJldHJ5IGlzIGVub3VnaD8gT3IgbW92ZSBpdCBvdXQgb2YgbG9vcD8N
Cj4gSSB0aGluayB0aGlzIG1lc3NhZ2UgaXMgaW1wb3J0YW50IHNpbmNlIHRoZXJlIGlzIHRoZSAi
ZmFpbGVkIHRvIHdyaXRlIGJsb2NrIg0KPiBlcnJvciBtZXNzYWdlIGJlZm9yZToNCj4gDQo+IFvC
oMKgwqAgNi4yMzkyMDVdIHVzYiAyLTEuMTogUlRMODE4OEVVIHJldiBEIChUU01DKSByb212ZXIg
MCwgMVQxUiwgVFgNCj4gcXVldWVzIDIsIFdpRmk9MSwgQlQ9MCwgR1BTPTAsIEhJIFBBPTANCj4g
W8KgwqDCoCA2LjI0ODc5M10gdXNiIDItMS4xOiBSVEw4MTg4RVUgTUFDOiAwMDozMzowZTowMDox
NTo4ZQ0KPiBbwqDCoMKgIDYuMjU0MjE4XSB1c2IgMi0xLjE6IHJ0bDh4eHh1OiBMb2FkaW5nIGZp
cm13YXJlIHJ0bHdpZmkvcnRsODE4OGV1ZncuYmluDQo+IFvCoMKgwqAgNi4zNDM3NTNdIHVzYiAy
LTEuMTogRmlybXdhcmUgcmV2aXNpb24gMTEuMSAoc2lnbmF0dXJlIDB4ODhlMSkNCj4gW8KgwqDC
oCA2LjM3NDY1OV0gdXNiIDItMS4xOiBydGw4eHh4dV93cml0ZU46IEZhaWxlZCB0byB3cml0ZSBi
bG9jayBhdA0KPiBhZGRyOiAxYzgwIHNpemU6IDAwODANCj4gW8KgwqDCoCA2LjM4Mjg5NF0gdXNi
IDItMS4xOiByZXRyeSBmaXJtd2FyZSBkb3dubG9hZA0KPiBbwqDCoMKgIDcuMjIxNTA1XSB1c2Jj
b3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHJ0bDh4eHh1DQo+IA0KPiBTbyB0
aGUgcmV0cnkgbWVzc2FnZSBhZnRlciB0aGUgZXJyb3IgbWFrZXMgY2xlYXIgdGhhdCB0aGUgZXJy
b3Igd2lsbA0KPiBob3BlZnVsbHkNCj4gYmUgY29ycmVjdGVkLg0KPiANCj4gU2luY2UgcnRsOHh4
eHVfd3JpdGVOIGlzIG9ubHkgdXNlZCBmb3IgZmlybXdhcmUgZG93bmxvYWQsIGFuIG90aGVyIG9w
dGlvbg0KPiB3b3VsZCBiZSB0byBkb3duZ3JhZGUgYm90aCB0aGUgZXJyb3IgYW5kIHRoZSByZXRy
eSBtZXNzYWdlIHRvIGRldl9kYmcoKS4NCj4gDQo+IFdoYXQgZG8geW91IHRoaW5rPw0KPiANCg0K
SXQgbG9va3MgbGlrZSBydGw4eHh4dSB1c2VzIHRoaXMga2luZCBvZiBkZWJ1ZyBwYXR0ZXJuIGZv
ciB3cml0aW5nOiANCg0KCWlmIChydGw4eHh4dV9kZWJ1ZyAmIFJUTDhYWFhVX0RFQlVHX1JFR19X
UklURSkNCgkJZGV2X2luZm8oJnVkZXYtPmRldiwgIiVzKCUwNHgpID0gMHglMDh4XG4iLA0KCQkJ
IF9fZnVuY19fLCBhZGRyLCB2YWwpOw0KDQoNCk1heWJlIHJ0bDh4eHh1X3dyaXRlTigpIGNhbiB1
c2UgdGhlIHNhbWUgcGF0dGVybi4NClRoZW4sIG5vICJydGw4eHh4dV93cml0ZU46IEZhaWxlZCB0
byB3cml0ZSBibG9jayBhdC4uLiIgdG8gdXNlcnMuIA0KDQpQaW5nLUtlDQoNCg==

