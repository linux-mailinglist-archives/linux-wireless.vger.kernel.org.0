Return-Path: <linux-wireless+bounces-2130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3DE83108C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 01:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5BB3282FBF
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 00:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB0717C7;
	Thu, 18 Jan 2024 00:37:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF51217C3
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705538272; cv=none; b=lCDV0pTrZR8VYSXN6Yj77resw/vA9U3Ar0Yw5TwqNSjJjII9MyWtG7n3/fHlNh9iAMAVpqU3KtZwFZzdJA47n3uNNBW+x2dbhuHIFj9ef3U/j/sbBg5QkbUg/aV+734st8hNt1HKBGLtne4HuDEXzJsMEqek7syjw/EmlpeRQQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705538272; c=relaxed/simple;
	bh=GQW6PGJxMU6ZSSMQnzFbALIYufp/9YcMDssZdjid16k=;
	h=X-SpamFilter-By:Received:Received:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:x-originating-ip:
	 x-kse-serverinfo:x-kse-antispam-interceptor-info:
	 x-kse-antivirus-interceptor-info:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-KSE-AntiSpam-Interceptor-Info; b=tI/VbFZk61DB+TQBK/VjGxNO+0cVgZqT2Yc0TivI6TJ91+6AZ/AuHwAkbVzVWl/StIjvX9VY3mMKfVz1I7JS9Fyp0TAz9Nzjj4pptuLrysBrEyeWPnBU/2LulixKs6Id7ANTqabCvihemxtm3UOZZv4mIEZY5H7/nPAQOarux+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40I0bb1Y31208248, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40I0bb1Y31208248
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 08:37:37 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 18 Jan 2024 08:37:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 08:37:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Thu, 18 Jan 2024 08:37:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH v2] wifi: rtlwifi: Speed up firmware loading for USB
Thread-Topic: [PATCH v2] wifi: rtlwifi: Speed up firmware loading for USB
Thread-Index: AQHaSYFrQa8WDirFr0+YumezfZVwHrDeuEZA
Date: Thu, 18 Jan 2024 00:37:37 +0000
Message-ID: <69d5e71d354b48ef839fb3d3c47f09c7@realtek.com>
References: <d9bd4949-6e92-4f35-8b60-3b45f9ad74ab@gmail.com>
In-Reply-To: <d9bd4949-6e92-4f35-8b60-3b45f9ad74ab@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDE4
LCAyMDI0IDQ6MTIgQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+OyBMYXJyeSBGaW5nZXIgPExhcnJ5
LkZpbmdlckBsd2Zpbmdlci5uZXQ+DQo+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gd2lmaTogcnRsd2lm
aTogU3BlZWQgdXAgZmlybXdhcmUgbG9hZGluZyBmb3IgVVNCDQo+IA0KPiBDdXJyZW50bHkgaXQg
dGFrZXMgYWxtb3N0IDYgc2Vjb25kcyB0byB1cGxvYWQgdGhlIGZpcm13YXJlIGZvciBSVEw4MTky
Q1UNCj4gKGFuZCAxMSBzZWNvbmRzIGZvciBSVEw4MTkyRFUpLiBUaGF0J3MgYmVjYXVzZSB0aGUg
ZmlybXdhcmUgaXMgdXBsb2FkZWQNCj4gb25lIGJ5dGUgYXQgYSB0aW1lLg0KPiANCj4gQWxzbywg
YWZ0ZXIgcGx1Z2dpbmcgdGhlIGRldmljZSwgdGhlIGZpcm13YXJlIGdldHMgdXBsb2FkZWQgdGhy
ZWUgdGltZXMNCj4gYmVmb3JlIGEgY29ubmVjdGlvbiB0byB0aGUgQVAgaXMgZXN0YWJsaXNoZWQu
DQo+IA0KPiBNYXliZSB0aGlzIGlzIGZpbmUgZm9yIG1vc3QgdXNlcnMsIGJ1dCB3aGVuIHRlc3Rp
bmcgY2hhbmdlcyB0byB0aGUNCj4gZHJpdmVyIGl0J3MgcmVhbGx5IGFubm95aW5nIHRvIHdhaXQg
c28gbG9uZy4NCj4gDQo+IFNwZWVkIHVwIHRoZSBmaXJtd2FyZSB1cGxvYWQgYnkgd3JpdGluZyBj
aHVua3Mgb2YgNjQgYnl0ZXMgYXQgYSB0aW1lLg0KPiBUaGlzIHdheSBpdCB0YWtlcyBhYm91dCAx
MTAgbXMgZm9yIFJUTDgxOTJDVSAoYW5kIGFib3V0IDIxMCBtcyBmb3INCj4gUlRMODE5MkRVKS4N
Cj4gDQo+IFBDSSBkZXZpY2VzIGNvdWxkIHVwbG9hZCBpdCBpbiBjaHVua3Mgb2YgNCBieXRlcywg
YnV0IEkgZG9uJ3QgaGF2ZSBhbnkNCj4gdG8gdGVzdCBhbmQgY29tbWl0IDg5ZDMyYzkwNzFhYSAo
InJ0bHdpZmk6IERvd25sb2FkIGZpcm13YXJlIGFzIGJ5dGVzDQo+IHJhdGhlciB0aGFuIGFzIGR3
b3JkcyIpIGRlY2lkZWQgb3RoZXJ3aXNlIGFueXdheS4NCj4gDQo+IEFsbG9jYXRlIG1lbW9yeSBm
b3IgdGhlIGZpcm13YXJlIGltYWdlIHdpdGgga21hbGxvYyBpbnN0ZWFkIG9mIHZ6YWxsb2MNCj4g
YmVjYXVzZSB0aGlzIG1lbW9yeSBpcyBwYXNzZWQgZGlyZWN0bHkgdG8gdXNiX2NvbnRyb2xfbXNn
KCksIHdoaWNoDQo+IGNhbid0IHRha2UgbWVtb3J5IGFsbG9jYXRlZCBieSB2bWFsbG9jLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5j
b20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KWy4u
Ll0NCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZp
L3VzYi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3VzYi5jDQo+IGlu
ZGV4IDA3YTdlNmZhNDZhZi4uMWZjNDgwZmUxOGFkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvdXNiLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydGx3aWZpL3VzYi5jDQo+IEBAIC0xMjUsNiArMTI1LDE0IEBAIHN0YXRp
YyB2b2lkIF91c2Jfd3JpdGUzMl9zeW5jKHN0cnVjdCBydGxfcHJpdiAqcnRscHJpdiwgdTMyIGFk
ZHIsIHUzMiB2YWwpDQo+ICAgICAgICAgX3VzYl93cml0ZV9zeW5jKHJ0bHByaXYsIGFkZHIsIHZh
bCwgNCk7DQo+ICB9DQo+IA0KPiArc3RhdGljIHZvaWQgX3VzYl93cml0ZV9jaHVua19zeW5jKHN0
cnVjdCBydGxfcHJpdiAqcnRscHJpdiwgdTMyIGFkZHIsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1MzIgbGVuZ3RoLCB1OCAqZGF0YSkNCj4gK3sNCj4gKyAgICAgICBzdHJ1
Y3QgdXNiX2RldmljZSAqdWRldiA9IHRvX3VzYl9kZXZpY2UocnRscHJpdi0+aW8uZGV2KTsNCj4g
Kw0KPiArICAgICAgIF91c2JjdHJsX3ZlbmRvcnJlcV9zeW5jKHVkZXYsIFJFQUxURUtfVVNCX1ZF
TlFUX1dSSVRFLCBhZGRyLCBkYXRhLCBsZW5ndGgpOw0KDQpKdXN0IGN1cmlvdXMuIE9yaWdpbmFs
bHksIGl0IHVzZXMgMS8yLzQgYXMgbGVuZ3RoIGZvciB3cml0ZTgvMTYvMzIsIGFuZCB0aGlzDQpw
YXRjaCBhZGRpdGlvbmFsbHkgdXNlcyA4LzY0IGFzIGxlbmd0aC4gQW55IGxpbWl0YXRpb24gb2Yg
YXJndW1lbnQgJ2xlbmd0aCcgb2YNCnRoaXMgZnVuY3Rpb24/IElzIGFyYml0cmFyeSBudW1iZXIg
ZGlzYWxsb3dlZD8gDQoNCg0KPiArfQ0KPiArDQoNCg0KDQo=

