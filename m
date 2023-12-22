Return-Path: <linux-wireless+bounces-1205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14BD81C5FE
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 08:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36031C21750
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 07:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF53944B;
	Fri, 22 Dec 2023 07:55:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023529449
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 07:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BM7sqpI71987748, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BM7sqpI71987748
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 15:54:52 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 22 Dec 2023 15:54:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 22 Dec 2023 15:54:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 22 Dec 2023 15:54:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
Subject: RE: [PATCH v2 20/21] wifi: rtl8xxxu: make supporting AP mode only on port 0 transparent
Thread-Topic: [PATCH v2 20/21] wifi: rtl8xxxu: make supporting AP mode only on
 port 0 transparent
Thread-Index: AQHaNC0oaJY+qGCnXUKN9G8m+k3jo7C0ikyQ///d/4CAAIcoUA==
Date: Fri, 22 Dec 2023 07:54:52 +0000
Message-ID: <629b4778b0ac4bf2b6f201da964d4a12@realtek.com>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
 <20231221164353.603258-21-martin.kaistra@linutronix.de>
 <7bbb0d0b803d49088957b47ad716e99b@realtek.com>
 <6aaae1a4-5d34-476e-b64b-2c19b7a15473@linutronix.de>
In-Reply-To: <6aaae1a4-5d34-476e-b64b-2c19b7a15473@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFydGluIEthaXN0cmEg
PG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIg
MjIsIDIwMjMgMzo0OSBQTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+
OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEplcyBTb3JlbnNlbiA8SmVz
LlNvcmVuc2VuQGdtYWlsLmNvbT47IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+OyBCaXR0
ZXJibHVlIFNtaXRoDQo+IDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT47IFNlYmFzdGlhbiBBbmRy
emVqIFNpZXdpb3IgPGJpZ2Vhc3lAbGludXRyb25peC5kZT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAyMC8yMV0gd2lmaTogcnRsOHh4eHU6IG1ha2Ugc3VwcG9ydGluZyBBUCBtb2RlIG9ubHkg
b24gcG9ydCAwIHRyYW5zcGFyZW50DQo+IA0KPiBBbSAyMi4xMi4yMyB1bSAwMjo1NCBzY2hyaWVi
IFBpbmctS2UgU2hpaDoNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4+IEZyb206IE1hcnRpbiBLYWlzdHJhIDxtYXJ0aW4ua2Fpc3RyYUBsaW51dHJvbml4LmRl
Pg0KPiA+PiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDIyLCAyMDIzIDEyOjQ0IEFNDQo+ID4+IFRv
OiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gQ2M6IEplcyBTb3JlbnNlbiA8
SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+OyBQ
aW5nLUtlIFNoaWgNCj4gPj4gPHBrc2hpaEByZWFsdGVrLmNvbT47IEJpdHRlcmJsdWUgU21pdGgg
PHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPjsgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvcg0KPiA+
PiA8YmlnZWFzeUBsaW51dHJvbml4LmRlPg0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggdjIgMjAvMjFd
IHdpZmk6IHJ0bDh4eHh1OiBtYWtlIHN1cHBvcnRpbmcgQVAgbW9kZSBvbmx5IG9uIHBvcnQgMCB0
cmFuc3BhcmVudA0KPiA+Pg0KPiA+DQo+ID4gWy4uLl0NCj4gPg0KPiA+PiArDQo+ID4+ICsgICAg
ICAgLyoNCj4gPj4gKyAgICAgICAgKiBwcml2LT52aWZzWzBdIGlzIE5VTEwgaGVyZSwgYmFzZWQg
b24gaG93IHRoaXMgZnVuY3Rpb24gaXMgY3VycmVudGx5DQo+ID4+ICsgICAgICAgICogY2FsbGVk
IGZyb20gcnRsOHh4eHVfYWRkX2ludGVyZmFjZSgpLg0KPiA+PiArICAgICAgICAqIFdoZW4gdGhp
cyBmdW5jdGlvbiB3aWxsIGJlIHVzZWQgaW4gdGhlIGZ1dHVyZSBmb3IgYSBkaWZmZXJlbnQNCj4g
Pj4gKyAgICAgICAgKiBzY2VuYXJpbywgcGxlYXNlIGNoZWNrIHdoZXRoZXIgdmlmc1swXSBvciB2
aWZzWzFdIGNhbiBiZSBOVUxMIGFuZCBpZg0KPiA+PiArICAgICAgICAqIG5lY2Vzc2FyeSBhZGQg
Y29kZSB0byBzZXQgcG9ydF9udW0gPSAxLg0KPiA+PiArICAgICAgICAqLw0KPiA+DQo+ID4gRGlk
IHlvdSBydW4gc2NyaXB0cy9jaGVja3BhdGNoLnBsIHRvIHRoaXMgcGF0Y2g/IEluaXRpYWwgbGlu
ZSBvZiBjb21tZW50IGJsb2NrDQo+ID4gZm9yIG5ldHdvcmtpbmcgY29kZSBzaG91bGQgbm90IGVt
cHR5LCBzbyBpdCBzaG91bGQgYmUgYmVsb3c6DQo+ID4NCj4gPiArICAgICAgIC8qIHByaXYtPnZp
ZnNbMF0gaXMgTlVMTCBoZXJlLCBiYXNlZCBvbiBob3cgdGhpcyBmdW5jdGlvbiBpcyBjdXJyZW50
bHkNCj4gPiArICAgICAgICAqIGNhbGxlZCBmcm9tIHJ0bDh4eHh1X2FkZF9pbnRlcmZhY2UoKS4N
Cj4gPiArICAgICAgICAqIFdoZW4gdGhpcyBmdW5jdGlvbiB3aWxsIGJlIHVzZWQgaW4gdGhlIGZ1
dHVyZSBmb3IgYSBkaWZmZXJlbnQNCj4gPiArICAgICAgICAqIHNjZW5hcmlvLCBwbGVhc2UgY2hl
Y2sgd2hldGhlciB2aWZzWzBdIG9yIHZpZnNbMV0gY2FuIGJlIE5VTEwgYW5kIGlmDQo+ID4gKyAg
ICAgICAgKiBuZWNlc3NhcnkgYWRkIGNvZGUgdG8gc2V0IHBvcnRfbnVtID0gMS4NCj4gPiArICAg
ICAgICAqLw0KPiA+DQo+IA0KPiBJIGRpZCBydW4gY2hlY2twYXRjaC5wbCBhbmQgY2hvc2UgdG8g
aWdub3JlIHRoaXMgd2FybmluZyBiZWNhdXNlIGFsbCBvdGhlcg0KPiBtdWx0aWxpbmUgY29tbWVu
dHMgaW4gdGhlIHJ0bDh4eHh1IGRyaXZlciBhbHNvIGhhdmUgdGhpcyBpbml0aWFsIGVtcHR5IGxp
bmUuDQo+IA0KPiBEbyB5b3Ugc3RpbGwgd2FudCBtZSB0byBjaGFuZ2UgaXQ/DQoNClBlcnNvbmFs
bHksIEkgd291bGQgZml4IGFsbCBjaGVja3BhdGNoLnBsIHdhcm5pbmdzLiBJZiB0aGlzIGNoYW5n
ZSBkb2Vzbid0DQpib3RoZXIgeW91IHRvbyBtdWNoLCBJIHN1Z2dlc3QgdG8gZm9sbG93IHRoZSBy
dWxlLiANCg0KDQo=

