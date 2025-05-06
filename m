Return-Path: <linux-wireless+bounces-22649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AB6AAB901
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 08:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D903C506AFC
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6526220F58;
	Tue,  6 May 2025 04:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="rfFWH15g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7022C2853F6
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 01:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746496582; cv=none; b=l0uHw/HY0E2GfWWceF5je74pVMhMuElhC2JC3lROOEPE6yQSG0N9k2KgXvEXpYk2sBWHBHBzn3kWXzi1Lcxgi0cQ4Zc6EwCs/De1C9WUhvtvb8XO+Q4MExKKoHnP4dpBF2vVDc9ic1PYTh0MhLb3Yi4du9eWfRkG25GwBExOedM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746496582; c=relaxed/simple;
	bh=hMj/DX06qnVG8vMCWmczoQgLe+ML7HLHrv6AJ5fuxuc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GLdVzUxZUv1NjZFF9745swGx7CGLAuyXUERyfti+HGuCAnOyO05YEXgc+6OxcCxiWQd0F4GEgmlw4YqLXuKJi1QJYhQ3dNtD07s32scrHqHeJ6axNQqQro/KoZPV2VtVXjwrC1wqDucSwoLvF8np6dKCr6JCTwsBN8ZEECvg5dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=rfFWH15g; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5461uF5z91544392, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746496576; bh=hMj/DX06qnVG8vMCWmczoQgLe+ML7HLHrv6AJ5fuxuc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rfFWH15g9shELXNxL4fu6F4d49291Xq90h/wg4SckR8KAmQB+5catVVxSHyqy0Bpd
	 8hXqBe7CxxC3+jB3w3cEQM438jPKZAeKXrKOpTEQ2vtU7R0CxPbYol0VVhgtGDhiYm
	 aeiULlrerqLN1WKUHDnI9BHt+haw9aGp98vJmCTBgQwsVPzYUUwb7Lg1czB4Jt9C/R
	 gRnH1cJsCTRlQvfDgHTjdZvH2SqVx5ajb/j31unNqXOr9QKNTCi/+xObRsHtjvB/Yb
	 kVimDTnALM5UjqamQbKHu7UiCkBPwkcZsQCKj0ZBH/UHuefwLy1rWzNKZO6Bsq+1yC
	 5sef5LK21YqEA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5461uF5z91544392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 09:56:16 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 May 2025 09:56:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 May 2025 09:56:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 6 May 2025 09:56:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 1/2] wifi: rtw88: Fix RX aggregation settings for RTL8723DS
Thread-Topic: [PATCH rtw-next v2 1/2] wifi: rtw88: Fix RX aggregation settings
 for RTL8723DS
Thread-Index: AQHbu1g2keO++OToo0SJCbdFTG8i17PDNLawgAA23ICAAXGD0A==
Date: Tue, 6 May 2025 01:56:15 +0000
Message-ID: <e057b56d05bb4d26b95932a05a1c50f9@realtek.com>
References: <4c79fdc1-54bc-4986-9931-bb3ceb418b97@gmail.com>
 <43ff8b6babd649b895e8af8993d53c36@realtek.com>
 <ff57b627-5842-44ee-adcf-f1b4bdfac1b9@gmail.com>
In-Reply-To: <ff57b627-5842-44ee-adcf-f1b4bdfac1b9@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAw
NS8wNS8yMDI1IDAzOjQ1LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBVc2UgdGhlIHNhbWUgUlgg
YWdncmVnYXRpb24gc2l6ZSBhbmQgdGltZW91dCB1c2VkIGJ5IHRoZSBvdXQtb2YtdHJlZQ0KPiA+
PiBSVEw4NzIzRFMgZHJpdmVyLiBBbHNvIHNldCBteXN0ZXJ5IGJpdCAzMSBvZiBSRUdfUlhETUFf
QUdHX1BHX1RILiBUaGlzDQo+ID4+IGltcHJvdmVzIHRoZSBSWCBzcGVlZCBmcm9tIH40NCBNYnBz
IHRvIH42NyBNYnBzLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRo
IDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gPj4gLS0tDQo+ID4+IHYyOg0KPiA+PiAgLSBS
ZXN0b3JlIHRoZSBvcmlnaW5hbCBiZWhhdmlvdXIgZm9yIFJUTDg4MjFBIGFuZCBSVEw4ODEyQS4N
Cj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWN0dWFsbHkgcmVzdG9yZXMgdGhlIGJlaGF2aW9yIG9mIFJU
TDg4MjFBIGFuZCBSVEw4ODEyQS4gQnV0DQo+ID4gdGhleSBhcmUgODAyLjExYWMgY2hpcHMgWzFd
IFsyXSwgc29tZWhvdyBkZWZpbmVkIGFzIFJUV19XQ1BVXzExTi4NCj4gPg0KPiA+IEkgY2FuIGFj
Y2VwdCB0aGlzIHBhdGNoIGFoZWFkLiBQbGVhc2UgaGVscCB0byB0aGluayBob3cgd2UgY2FuIGNv
cnJlY3QNCj4gPiB0aGlzIG1pc3Rha2UuDQo+ID4NCj4gDQo+IFllcywgdGhlIGVudW1zIFJUV19X
Q1BVXzExQUMgYW5kIFJUV19XQ1BVXzExTiBoYXZlIHdyb25nIG5hbWVzLg0KPiBSVEw4ODIxQSBh
bmQgUlRMODgxMkEgYXJlIDExYWMgY2hpcHMgYnV0IHRoZWlyIE1DVSBpcyB0aGUNCj4gUlRXX1dD
UFVfMTFOIHR5cGUuIFJUTDg3MzNCVSAobm90IHN1cHBvcnRlZCBpbiBydHc4OCkgaXMgMTFuIGJ1
dCBpdHMNCj4gTUNVIGlzIHRoZSBSVFdfV0NQVV8xMUFDIHR5cGUuDQo+IA0KPiBJIHdhcyB0aGlu
a2luZyB0byByZW5hbWUgdGhlbToNCj4gDQo+IFJUV19XQ1BVXzExTiAgLT4gUlRXX1dDUFVfODA1
MQ0KPiBSVFdfV0NQVV8xMUFDIC0+IFJUV19XQ1BVXzMwODENCj4gDQo+IDgwNTEgYW5kIDMwODEg
YXJlIHRoZSBuYW1lcyB1c2VkIGluIHRoZSB2ZW5kb3IgZHJpdmVyczoNCj4gDQo+ICNkZWZpbmUg
UEhZRE1fSUNfODA1MV9TRVJJRVMgICAgKE9ETV9SVEw4ODgxQSB8IE9ETV9SVEw4ODEyIHwgT0RN
X1JUTDg4MjEgfFwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT0RNX1JUTDgx
OTJFIHwgT0RNX1JUTDg3MjNCIHwgT0RNX1JUTDg3MDNCIHxcDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIE9ETV9SVEw4MTg4RiB8IE9ETV9SVEw4MTkyRiB8IE9ETV9SVEw4NzIx
RCB8XA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPRE1fUlRMODcxMEMpDQo+
ICNkZWZpbmUgUEhZRE1fSUNfMzA4MV9TRVJJRVMgICAgKE9ETV9SVEw4ODE0QSB8IE9ETV9SVEw4
ODIyQiB8IE9ETV9SVEw4MTk3RiB8XA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBPRE1fUlRMODgyMUMgfCBPRE1fUlRMODE5NUIgfCBPRE1fUlRMODE5OEYgfFwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgT0RNX1JUTDg4MjJDIHwgT0RNX1JUTDg4MTJGIHwg
T0RNX1JUTDg4MTRCIHxcDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9ETV9S
VEw4MTk3RykNCg0KVGhhbmtzLiBQbGVhc2UgaGVscCBtYWtpbmcgYSBwYXRjaC4gDQoNCg0K

