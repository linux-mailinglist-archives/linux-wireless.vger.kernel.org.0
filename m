Return-Path: <linux-wireless+bounces-7814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EED8C8ED0
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 02:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC03E2829C6
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 00:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75457383;
	Sat, 18 May 2024 00:11:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ED036C
	for <linux-wireless@vger.kernel.org>; Sat, 18 May 2024 00:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715991107; cv=none; b=pjEsV6hmTgum9/xflNY8jNfKCdK8EDqeyIALC1GFbYgEPaqGtC9xoNmQ8dag3lSVoZGiAuqSeENsVvbun1PolHVJugUDCgoHrbP7hvFDOI541UW0ECf+jC3ITkxHbOSqo1As32kp8G3r8mnCrE8jl3P+mPxuq25Kzru6cJyDE+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715991107; c=relaxed/simple;
	bh=u+Bb206g1BHND5Tlpj3n7hARI5mFW+nFyjfoy8g5Hho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rBViObLghiskKrFFMj6csVPi23xmMOPbZmJFijNRV8ZY/x0OHErVXWSGTZtfD6nwKJnT8fRAJjas+N8MORzm7DM/gO+HYKkvdKJ1zrJd3km9vCStWnDihholNYJVD5oOUHpcT8FGfHg7CAH628hcDVaGWEJfmIvdRKa9iEp5BBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44I0BWQB02914147, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44I0BWQB02914147
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 May 2024 08:11:32 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 18 May 2024 08:11:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 18 May 2024 08:11:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Sat, 18 May 2024 08:11:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "Larry.Finger@gmail.com" <Larry.Finger@gmail.com>,
        "linux-firmware@vger.kernel.org" <linux-firmware@vger.kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] linux-firmware: Add ordinary firmware for RTL8821AU device
Thread-Topic: [PATCH] linux-firmware: Add ordinary firmware for RTL8821AU
 device
Thread-Index: AQHap6bD+Xfiq2Jq/E+4fpLkIeqV1LGamZSwgABZ3YCAAKbzgA==
Date: Sat, 18 May 2024 00:11:32 +0000
Message-ID: <1e37fa74f57d11f5ddc93626f348870f6a8931c0.camel@realtek.com>
References: <4un2klvz1fcd.fWFO2CHkJLwM7KZVnpZutA2@1EHFQ.trk.elasticemail.com>
	 <cd8bc792f1de46d4938e6a11c163f4b4@realtek.com>
	 <2c0950bd-f515-411d-a555-64ce7feaaa28@lwfinger.net>
In-Reply-To: <2c0950bd-f515-411d-a555-64ce7feaaa28@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5CE775159AFA74C93B358D79CC7CDA9@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gRnJpLCAyMDI0LTA1LTE3IGF0IDA5OjEzIC0wNTAwLCBMYXJyeSBGaW5nZXIgd3JvdGU6DQo+
IA0KPiBPbiA1LzE2LzI0IDc6NTUgUE0sIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiBJIHdvdWxk
IGxpa2UgdG8gY29tcGFyZSB0aGUgZmlybXdhcmUgbG9jYWxseSwgc28gYXBwbHkgdGhlIHBhdGNo
IGJ5DQo+ID4gJCBwd2NsaWVudCBnaXQtYW0gMTM2NjYzNDMNCj4gPiANCj4gPiBVbmZvcnR1bmF0
ZWx5IHRoZSBzaXplIG9mIHJ0dzg4L3J0dzg4MjFhX2Z3LmJpbiBpcyAwIGluIG15IHNpZGU6DQo+
ID4gICBXSEVOQ0UgICAgICAgICAgICAgICAgfCAxICsNCj4gPiAgIHJ0dzg4L1JFQURNRSAgICAg
ICAgICB8IDMgKysrDQo+ID4gICBydHc4OC9ydHc4ODIxYV9mdy5iaW4gfCAwDQo+ID4gICAzIGZp
bGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IE5vdCBzdXJlIHdoYXQgaGFw
cGVucy4gQ291bGQgeW91IHRyeSBpdCBpbiB5b3VyIHNpZGU/DQo+IA0KPiBQaW5nLUtlLA0KPiAN
Cj4gSXQgdG9vayBtZSBhIHdoaWxlIHRvIGdldCBwd2NsaWVudCBydW5uaW5nIGhlcmUsIGJ1dCAg
d2hlbiBJIGRpZCBpdCB0cnVuY2F0ZWQNCj4gdGhlIGZpcm13YXJlIGZpbGUgdG8gbGVuZ3RoIDAu
IElmIEkgYXBwbHkgdGhlIEUtbWFpbCBmaWxlIHRoYXQgSSBzZW50LCBpdCBjb21lcw0KPiBvdXQg
T0ssDQoNCkkgZG9uJ3Qga25vdyB3aHksIGFuZCBqdXN0IHdvbmRlciBpZiBtYWludGFpbmVycyBt
aWdodCBlbmNvdW50ZXIgdGhlIHNhbWUNCnByb2JsZW0gSSBtZXQuIEkgdHJpZWQgdG8gYWRkIHlv
dXIgYXR0YWNobWVudCBmaXJtd2FyZSB0byB0aGUgcGF0Y2ggbG9jYWxseQ0KYW5kIGdlbmVyYXRl
IGFuZCBjb21wYXJlIGxvY2FsIHBhdGNoIHdpdGggeW91ciBFLW1haWwgZmlsZSAtLSBubyBvYnZp
b3VzIA0KZGlmZmVyZW5jZSwgb25seSB0aGUgb3JkZXIgb2YgV0hFTkNFIGFuZCBSRUFETUUuIFRo
ZW4gSSB0cmllZCB0byBjaGFuZ2UNCnRoZSBvcmRlciBvZiB5b3VyIEUtbWFpbCBmaWxlLCBhbmQg
ZmluYWxseSBpdCB3b3JrcyBpbiBteSBzaWRlLiANCg0KSWYgeW91IHdhbnQgbWUgdG8gYXNzaXN0
IHNlbmRpbmcgYSBwdWxsLXJlcXVlc3QgdG8gcHJldmVudCBiYWNrIGFuZCBmb3J0aA0KanVzdCBi
ZWNhdXNlIG9mIGFib3ZlIHByb2JsZW0sIHBsZWFzZSBsZXQgbWUga25vdy4NCg0KQnkgdGhlIHdh
eSwgbXkgbWFpbCBzZXJ2ZXIgbm90aWNlZCBtZSBmYWlsZWQgdG8gZGVsaXZlciB0bw0KImxpbnV4
LWZpcm13YXJlQHZnZXIua2VybmVsLm9yZyINCkluc3RlYWQsIFJFQURNRS5tZCBzYXlzIGZpcm13
YXJlIHNob3VsZCBiZSBzZW50IHRvIA0KImxpbnV4LWZpcm13YXJlQGtlcm5lbC5vcmciDQoNCj4g
DQo+IEF0dGFjaGVkIGlzIHRoZSBmaXJtd2FyZSBmaWxlIHRoYXQgSSBzZW50Lg0KPiANCg0KSSBo
YXZlIGNvbmZpcm1lZCBhdHRhY2hlZCBmaXJtd2FyZSBpcyB0aGUgc2FtZSBhcyByZWxlYXNlZCBv
bmUsIGFuZCBhbHNvDQp0aGUgc2FtZSBhcyB0aGUgb25lIHlvdSBzZW50Lg0KDQpQaW5nLUtlDQoN
Cg0K

