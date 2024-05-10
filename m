Return-Path: <linux-wireless+bounces-7403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274208C1C3F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 03:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3B31F21E5B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 01:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102E913B5AF;
	Fri, 10 May 2024 01:55:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB812D769
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 01:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715306100; cv=none; b=IVQcoZrdBJit+iAzcDj1JTK5lUrygKKEMga9Bvo6dw+G06aIC1fbKq4eGWjvl/xBcP7d92bzS11qAEVWTI/AaWNW+ms82LdgnOFWaHoxwJnsbuvZIh7Iyp43EHBGO/UxRaRqUSG/Gw57O+7CSwdGWs+tS/mLVYGmq32iMg3YPF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715306100; c=relaxed/simple;
	bh=oKl+1Xy5oKwL4ryqIf7PUCKf831EoWGBvLsg0MmfTDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R3dN8d6BTM7DbVUmp/NjcETBbQGPHeSdu08ss6guwvWKLWho9I7HoTwymhI1peaa9Pyoomrd+cljT7YYvwNPEXG3w+tFPbJNQtzhvhiGTMEAQgUmpYWcZRJVOPr/dj6bBMx3t0xPFeWxYKjjfmX7J9Gh7Ihejn3ONONKiC/SjeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44A1sQbnD2210261, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44A1sQbnD2210261
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 09:54:26 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 09:54:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 09:54:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 10 May 2024 09:54:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v5 01/11] wifi: rtlwifi: Add rtl8192du/table.{c,h}
Thread-Topic: [PATCH v5 01/11] wifi: rtlwifi: Add rtl8192du/table.{c,h}
Thread-Index: AQHaoTUr3ffC+leB00aaSOZ+j9F9GbGPtYHw
Date: Fri, 10 May 2024 01:54:26 +0000
Message-ID: <5690f929d1aa4e7398058927fb7259df@realtek.com>
References: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
 <b8f1eb57-052c-482a-a949-543eef1b9d3a@gmail.com>
In-Reply-To: <b8f1eb57-052c-482a-a949-543eef1b9d3a@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVz
ZSBjb250YWluIHRoZSBNQUMsIEJCLCBSRiwgYW5kIEFHQyBpbml0aWFsaXNhdGlvbiB0YWJsZXMg
Zm9yDQo+IFJUTDgxOTJEVS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGgg
PHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiAtLS0NCj4gdjU6DQo+ICAtIE5vIGNoYW5nZS4N
Cj4gDQo+IHY0Og0KPiAgLSBGaXggdGFibGUuaCBoZWFkZXIgZ3VhcmQuDQo+ICAtIE1ha2UgdGhl
IGFycmF5cyBzdGF0aWMgY29uc3QgYW5kIGFkZCBhY2Nlc3NvciBmdW5jdGlvbnMgYXMgc3VnZ2Vz
dGVkDQo+ICAgIGJ5IEplZmYgSm9obnNvbi4NCj4gDQo+IHYzOg0KPiAgLSBObyBjaGFuZ2UuDQo+
IA0KPiB2MjoNCj4gIC0gUGF0Y2ggaXMgbmV3IGluIHYyLCBzcGxpdCBmcm9tIHBhdGNoIDMvMyBp
biB2MS4NCj4gLS0tDQo+ICAuLi4vcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS90YWJsZS5jICAg
ICAgICAgfCAxNzI1ICsrKysrKysrKysrKysrKysrDQo+ICAuLi4vcmVhbHRlay9ydGx3aWZpL3J0
bDgxOTJkdS90YWJsZS5oICAgICAgICAgfCAgIDI5ICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTc1
NCBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS90YWJsZS5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS90YWJsZS5o
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZp
L3J0bDgxOTJkdS90YWJsZS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3
aWZpL3J0bDgxOTJkdS90YWJsZS5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAw
MDAwMDAwMDAwMC4uZWZjOTZkYjU1MDU3DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS90YWJsZS5jDQo+IEBAIC0w
LDAgKzEsMTcyNSBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4g
Ky8qIENvcHlyaWdodChjKSAyMDA5LTIwMTIgIFJlYWx0ZWsgQ29ycG9yYXRpb24uKi8NCg0KVGhl
IHllYXIgc2hvdWxkIGJlIDIwMjQuDQoNCj4gKw0KPiArI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+
DQo+ICsNCj4gKyNpbmNsdWRlICJ0YWJsZS5oIg0KPiArDQo+ICtzdGF0aWMgY29uc3QgdTMyIHJ0
bDgxOTJkdV9waHlfcmVnXzJ0YXJyYXlbUEhZX1JFR18yVF9BUlJBWUxFTkdUSF0gPSB7DQo+ICsg
ICAgICAgMHg4MDAsIDB4ODAwNDAwMDIsDQo+ICsgICAgICAgMHg4MDQsIDB4MDAwMDAwMDMsDQoN
ClsuLi5dDQoNCj4gKyAgICAgICAweGY0YywgMHgwMDAwMDAwNCwNCj4gKyAgICAgICAweGYwMCwg
MHgwMDAwMDMwMCwNCj4gK307DQo+ICsNCj4gK2NvbnN0IHUzMiAqcnRsODE5MmR1X2dldF9waHlf
cmVnXzJ0YXJyYXkodm9pZCkNCj4gK3sNCj4gKyAgICAgICByZXR1cm4gcnRsODE5MmR1X3BoeV9y
ZWdfMnRhcnJheTsNCj4gK30NCg0KQ2hhbmdlICdzdGF0aWMgY29uc3QgdTMyJyBhcnJheSB0byAn
Y29uc3QgdTMyJywgYW5kIHRoZW4geW91IGRvbid0IG5lZWQgdGhpcw0KZ2V0LWhlbHBlciBmdW5j
dGlvbi4gSW5zdGVhZCwgJ2V4dGVybiBjb25zdCB1MzInIGluIGhlYWRlciBmaWxlLiBQbGVhc2UN
CmFwcGx5IHRoaXMgcnVsZSB0byBhbGwgYXJyYXlzLiANCg0KWy4uLl0NCg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS90YWJsZS5o
DQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS90YWJs
ZS5oDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uOTVlMDM2
N2FiYjVhDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydGx3aWZpL3J0bDgxOTJkdS90YWJsZS5oDQo+IEBAIC0wLDAgKzEsMjkgQEANCj4gKy8q
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovDQo+ICsvKiBDb3B5cmlnaHQoYykg
MjAwOS0yMDEyICBSZWFsdGVrIENvcnBvcmF0aW9uLiovDQoNCkNvcHlyaWdodCB5ZWFyLiANCg0K
PiArDQo+ICsjaWZuZGVmIF9fUlRMOTJEVV9UQUJMRV9IX18NCj4gKyNkZWZpbmUgX19SVEw5MkRV
X1RBQkxFX0hfXw0KPiArDQo+ICsjZGVmaW5lIFBIWV9SRUdfMlRfQVJSQVlMRU5HVEggMzcyDQo+
ICsjZGVmaW5lIFBIWV9SRUdfQVJSQVlfUEdfTEVOR1RIIDYyNA0KPiArI2RlZmluZSBSQURJT0Ff
MlRfQVJSQVlMRU5HVEggMzc4DQo+ICsjZGVmaW5lIFJBRElPQl8yVF9BUlJBWUxFTkdUSCAzODQN
Cj4gKyNkZWZpbmUgUkFESU9BXzJUX0lOVF9QQV9BUlJBWUxFTkdUSCAzNzgNCj4gKyNkZWZpbmUg
UkFESU9CXzJUX0lOVF9QQV9BUlJBWUxFTkdUSCAzODQNCj4gKyNkZWZpbmUgTUFDXzJUX0FSUkFZ
TEVOR1RIIDE5Mg0KPiArI2RlZmluZSBBR0NUQUJfQVJSQVlMRU5HVEggMzg2DQo+ICsjZGVmaW5l
IEFHQ1RBQl81R19BUlJBWUxFTkdUSCAxOTQNCj4gKyNkZWZpbmUgQUdDVEFCXzJHX0FSUkFZTEVO
R1RIIDE5NA0KPiArDQo+ICtjb25zdCB1MzIgKnJ0bDgxOTJkdV9nZXRfcGh5X3JlZ18ydGFycmF5
KHZvaWQpOw0KPiArY29uc3QgdTMyICpydGw4MTkyZHVfZ2V0X3BoeV9yZWdfYXJyYXlfcGcodm9p
ZCk7DQo+ICtjb25zdCB1MzIgKnJ0bDgxOTJkdV9nZXRfcmFkaW9hXzJ0YXJyYXkodm9pZCk7DQo+
ICtjb25zdCB1MzIgKnJ0bDgxOTJkdV9nZXRfcmFkaW9iXzJ0YXJyYXkodm9pZCk7DQo+ICtjb25z
dCB1MzIgKnJ0bDgxOTJkdV9nZXRfcmFkaW9hXzJ0X2ludF9wYWFycmF5KHZvaWQpOw0KPiArY29u
c3QgdTMyICpydGw4MTkyZHVfZ2V0X3JhZGlvYl8ydF9pbnRfcGFhcnJheSh2b2lkKTsNCj4gK2Nv
bnN0IHUzMiAqcnRsODE5MmR1X2dldF9tYWNfMnRhcnJheSh2b2lkKTsNCj4gK2NvbnN0IHUzMiAq
cnRsODE5MmR1X2dldF9hZ2N0YWJfYXJyYXkodm9pZCk7DQo+ICtjb25zdCB1MzIgKnJ0bDgxOTJk
dV9nZXRfYWdjdGFiXzVnYXJyYXkodm9pZCk7DQo+ICtjb25zdCB1MzIgKnJ0bDgxOTJkdV9nZXRf
YWdjdGFiXzJnYXJyYXkodm9pZCk7DQoNCkFzIGNvbW1lbnRzIGFib3ZlLCBwbGVhc2UNCiAgZXh0
ZXJuIGNvbnN0IHUzMiB4eHh4W107IA0KDQo+ICsNCj4gKyNlbmRpZg0KPiAtLQ0KPiAyLjQ0LjAN
Cg0K

