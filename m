Return-Path: <linux-wireless+bounces-5132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496828865A1
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 04:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 982DFB219AC
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 03:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6315E6116;
	Fri, 22 Mar 2024 03:46:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C564A3E
	for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 03:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711079196; cv=none; b=chSkbCHVi9onxeP/G2mCPmJNkpsp7ub1XPwdsjDJfm4Odj5TxNb6kuK6c4Vt/sA9ALhsJeHrdpMjVqYebX8qb2BosNFPRMrFejbW8hhUTrLbkBwqzZJMYAfH2eiHkG2e3Op+ErwFGJh42TFMRNRUQJBiD9cpf6knn3L9P4k7vnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711079196; c=relaxed/simple;
	bh=qj+KLNgbPa7Xp7r1HLLcnqjPHIKCKLF0tXll+XUqbYI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gzb7HmAUaVNYdj/LltpoPOGwJpztMDyyrOKEDgSMmfVwUAkeYTz0fNfmKZUfFVvYobM8O7IX85Vhj0jWFZ0Y0B8loEDDBuhb3FzqlMiwdvI1ArgblleHSTtic6CsH5avQ+tZJJIgVfPP01GapfoUTisfIi+qJyMpPRDHnlsRU+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42M3kCF911448652, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42M3kCF911448652
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 11:46:12 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 11:46:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 11:46:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Fri, 22 Mar 2024 11:46:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH v3 04/12] wifi: rtlwifi: Add rtl8192du/table.{c,h}
Thread-Topic: [PATCH v3 04/12] wifi: rtlwifi: Add rtl8192du/table.{c,h}
Thread-Index: AQHaev3qY3Nayk5vYE26xHTZIDMXTLFCmpOA
Date: Fri, 22 Mar 2024 03:46:12 +0000
Message-ID: <5170c29a7b565fdec2e004f9391d325328ef5a72.camel@realtek.com>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
	 <ed50254c-889e-4dcd-93db-f63b776e3503@gmail.com>
In-Reply-To: <ed50254c-889e-4dcd-93db-f63b776e3503@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5204BC7A425014B97147F10D77D01C8@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gV2VkLCAyMDI0LTAzLTIwIGF0IDIxOjM2ICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gVGhlc2UgY29udGFpbiB0aGUgTUFDLCBCQiwgUkYsIGFuZCBBR0MgaW5pdGlhbGlz
YXRpb24gdGFibGVzIGZvcg0KPiBSVEw4MTkyRFUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0
ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gLS0tDQo+IHYzOg0KPiAg
LSBObyBjaGFuZ2UuDQo+IA0KPiB2MjoNCj4gIC0gUGF0Y2ggaXMgbmV3IGluIHYyLCBzcGxpdCBm
cm9tIHBhdGNoIDMvMyBpbiB2MS4NCj4gLS0tDQo+ICAuLi4vcmVhbHRlay9ydGx3aWZpL3J0bDgx
OTJkdS90YWJsZS5jICAgICAgICAgfCAxNjc1ICsrKysrKysrKysrKysrKysrDQo+ICAuLi4vcmVh
bHRlay9ydGx3aWZpL3J0bDgxOTJkdS90YWJsZS5oICAgICAgICAgfCAgIDMwICsNCj4gIDIgZmls
ZXMgY2hhbmdlZCwgMTcwNSBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS90YWJsZS5jDQo+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0
bDgxOTJkdS90YWJsZS5oDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS90YWJsZS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS90YWJsZS5jDQo+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uNmY1NzEyNTVjMWE1DQo+IC0tLSAvZGV2L251bGwN
Cj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS90
YWJsZS5jDQo+IEBAIC0wLDAgKzEsMTY3NSBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjANCj4gKy8qIENvcHlyaWdodChjKSAyMDA5LTIwMTIgIFJlYWx0ZWsgQ29ycG9y
YXRpb24uKi8NCj4gKw0KPiArI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ICsNCj4gKyNpbmNs
dWRlICJ0YWJsZS5oIg0KPiArDQo+ICt1MzIgcnRsODE5MmR1X3BoeV9yZWdfMnRhcnJheVtQSFlf
UkVHXzJUX0FSUkFZTEVOR1RIXSA9IHsNCg0Kc3RhdGljIGNvbnN0ID8NCg0KPiArDQo+ICt1MzIg
cnRsODE5MmR1X3BoeV9yZWdfYXJyYXlfcGdbUEhZX1JFR19BUlJBWV9QR19MRU5HVEhdID0gew0K
DQpzdGF0aWMgY29uc3QgPw0KDQpbLi4uXQ0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5MmR1L3RhYmxlLmgNCj4gYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5MmR1L3RhYmxlLmgNCj4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi43MWQ5NDMxNThjNWYNCj4gLS0tIC9k
ZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRs
ODE5MmR1L3RhYmxlLmgNCj4gQEAgLTAsMCArMSwzMCBAQA0KPiArLyogU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4gKy8qIENvcHlyaWdodChjKSAyMDA5LTIwMTIgIFJlYWx0
ZWsgQ29ycG9yYXRpb24uKi8NCj4gKw0KPiArI2lmbmRlZiBfX1JUTDkyREVfVEFCTEVfX0hfDQo+
ICsjZGVmaW5lIF9fUlRMOTJERV9UQUJMRV9fSF8NCj4gKw0KPiArLypDcmVhdGVkIG9uICAyMDEx
LyAxLzE0LCAgMTozNSovDQoNCk5vdCBzdXJlIHdoYXQgaXQgbWVhbnM/IEluIGZhY3QsIHZlcnNp
b24gaW5mbyBpcyBhZGRlZCBpbiB0aGVzZSB0YWJsZXMNCmFscmVhZHkuDQoNCj4gKw0KPiArI2Rl
ZmluZSBQSFlfUkVHXzJUX0FSUkFZTEVOR1RIIDM3Mg0KPiArZXh0ZXJuIHUzMiBydGw4MTkyZHVf
cGh5X3JlZ18ydGFycmF5W1BIWV9SRUdfMlRfQVJSQVlMRU5HVEhdOw0KPiArI2RlZmluZSBQSFlf
UkVHX0FSUkFZX1BHX0xFTkdUSCA2MjQNCj4gK2V4dGVybiB1MzIgcnRsODE5MmR1X3BoeV9yZWdf
YXJyYXlfcGdbUEhZX1JFR19BUlJBWV9QR19MRU5HVEhdOw0KPiArI2RlZmluZSBSQURJT0FfMlRf
QVJSQVlMRU5HVEggMzc4DQo+ICtleHRlcm4gdTMyIHJ0bDgxOTJkdV9yYWRpb2FfMnRhcnJheVtS
QURJT0FfMlRfQVJSQVlMRU5HVEhdOw0KPiArI2RlZmluZSBSQURJT0JfMlRfQVJSQVlMRU5HVEgg
Mzg0DQo+ICtleHRlcm4gdTMyIHJ0bDgxOTJkdV9yYWRpb2JfMnRhcnJheVtSQURJT0JfMlRfQVJS
QVlMRU5HVEhdOw0KPiArI2RlZmluZSBSQURJT0FfMlRfSU5UX1BBX0FSUkFZTEVOR1RIIDM3OA0K
PiArZXh0ZXJuIHUzMiBydGw4MTkyZHVfcmFkaW9hXzJ0X2ludF9wYWFycmF5W1JBRElPQV8yVF9J
TlRfUEFfQVJSQVlMRU5HVEhdOw0KPiArI2RlZmluZSBSQURJT0JfMlRfSU5UX1BBX0FSUkFZTEVO
R1RIIDM4NA0KPiArZXh0ZXJuIHUzMiBydGw4MTkyZHVfcmFkaW9iXzJ0X2ludF9wYWFycmF5W1JB
RElPQl8yVF9JTlRfUEFfQVJSQVlMRU5HVEhdOw0KPiArI2RlZmluZSBNQUNfMlRfQVJSQVlMRU5H
VEggMTkyDQo+ICtleHRlcm4gdTMyIHJ0bDgxOTJkdV9tYWNfMnRhcnJheVtNQUNfMlRfQVJSQVlM
RU5HVEhdOw0KPiArI2RlZmluZSBBR0NUQUJfQVJSQVlMRU5HVEggMzg2DQo+ICtleHRlcm4gdTMy
IHJ0bDgxOTJkdV9hZ2N0YWJfYXJyYXlbQUdDVEFCX0FSUkFZTEVOR1RIXTsNCj4gKyNkZWZpbmUg
QUdDVEFCXzVHX0FSUkFZTEVOR1RIIDE5NA0KPiArZXh0ZXJuIHUzMiBydGw4MTkyZHVfYWdjdGFi
XzVnYXJyYXlbQUdDVEFCXzVHX0FSUkFZTEVOR1RIXTsNCj4gKyNkZWZpbmUgQUdDVEFCXzJHX0FS
UkFZTEVOR1RIIDE5NA0KPiArZXh0ZXJuIHUzMiBydGw4MTkyZHVfYWdjdGFiXzJnYXJyYXlbQUdD
VEFCXzJHX0FSUkFZTEVOR1RIXTsNCj4gKw0KPiArI2VuZGlmDQo+IC0tDQo+IDIuNDMuMg0K

