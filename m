Return-Path: <linux-wireless+bounces-447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34956806530
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 03:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92A20B20F8E
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 02:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4803863CB;
	Wed,  6 Dec 2023 02:42:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29277129
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 18:41:59 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B62ft1qB3288601, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B62ft1qB3288601
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 10:41:55 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 6 Dec 2023 10:41:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 6 Dec 2023 10:41:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 6 Dec 2023 10:41:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ali Ghandour <gandour.ali@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Lenovo LOQ rtw_8852be
Thread-Topic: Lenovo LOQ rtw_8852be
Thread-Index: AQHaH+dudVZVMpW7Qk6t1f3PxKDyKLCNY6tQ///EsACAAAT0AIAAh+ZQgAeHaQCABKhgsP//2SiAgAHUHEA=
Date: Wed, 6 Dec 2023 02:41:50 +0000
Message-ID: <f5e03fd6c26544b48cb493ec428338fb@realtek.com>
References: <1700948088-16140-mlmmj-666d2532@vger.kernel.org>
 <CAOE0c97T1cVvqFkqfrP_h53X08yQ7kLinZP09L35nVHc_V89+g@mail.gmail.com>
 <5abfc98859504795b50f7f343784c886@realtek.com>
 <CAOE0c96uJ9x8gbJZdHiMEiOM5gTd_ZqM_rUV7Cs1NyA_t0Ncfg@mail.gmail.com>
 <CAOE0c97fDaLTfsMJVmEh4HxOAPY19kD60qsV5AKJbWW5nnqWzw@mail.gmail.com>
 <b4cfd676c0b24d98b82302aefac7f379@realtek.com>
 <CAOE0c97NvXFhttfNNm3+NsXw9SKV7sC-nJriwF43pujvJugvSg@mail.gmail.com>
 <1ad457d646ba4d9d99dc2f5cb8a1b590@realtek.com>
 <CAOE0c97cFjF=LGD8-nb95ihQhE0YRRqM=4PKud4nccQa06MVxw@mail.gmail.com>
In-Reply-To: <CAOE0c97cFjF=LGD8-nb95ihQhE0YRRqM=4PKud4nccQa06MVxw@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpIEdoYW5kb3VyIDxn
YW5kb3VyLmFsaUBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDUsIDIwMjMg
MjoxMyBQTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IENjOiBs
aW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IExlbm92byBMT1Eg
cnR3Xzg4NTJiZQ0KPiANCj4gDQo+ID4gPiA+ID4gPiAkIGxzcGNpIC10dg0KPiA+ID4gPiA+ID4g
LVswMDAwOjAwXS0rLTAwLjAgIEludGVsIENvcnBvcmF0aW9uIERldmljZSBhNzE1DQo+ID4gPiA+
PiBDYW4gSSBrbm93IHRoZSB0eXBlIG9mIHlvdXIgcGxhdG9mb3JtIExlbm92byBMT1E/IElzIGl0
IGEgcmVndWxhciBub3RlYm9vayBjb21wdXRlcj8NCj4gPiA+DQo+ID4gPiBMT1EgMTVJUkg4IC0g
VHlwZSA4MlhWDQo+ID4gPiBJIGFtIHVzaW5nIGEgZHVhbCBib290IHdpdGggV2luZG93cyBhbmQg
VWJ1bnR1IDIyLjA0DQo+ID4NCj4gPiBJIHN0aWxsIGNhbid0IGZpbmQgaW5mb3JtYXRpb24gYWJv
dXQgdGhlIGRldmljZSBhNzE1IHRoYXQgSSBhbHNvIGNhbid0IGZpbmQNCj4gPiB0aGlzIElEIGlu
IGtlcm5lbCBzb3VyY2UgY29kZS4gSSB3aWxsIGRpZyBrZXJuZWwgZnVydGhlciB3aGVuIEkgaGF2
ZSBmcmVlIHRpbWUuDQo+IA0KPiANCj4gQWNjb3JkaW5nIHRvIHRoZSBzcGVjczoNCj4gMXggMTN0
aCBHZW5lcmF0aW9uIEludGVsIENvcmUgaTctMTM2MjBIIFByb2Nlc3NvcihDb3JlIGk3LTEzNjIw
SCkNCj4gDQoNCkkgaGF2ZSBmb3VuZCB0aGUgSUQgaW4ga2VybmVsOiANCiAgYXJjaC94ODYvZXZl
bnRzL2ludGVsL3VuY29yZV9zbmIuYzoxMDE6I2RlZmluZSBQQ0lfREVWSUNFX0lEX0lOVEVMX1JQ
TF8xNV9JTUMgICAgICAgICAgIDB4QTcxNQ0KDQpCdXQgaG9uZXN0bHkgSSdtIG5vdCBmYW1pbGlh
ciB3aXRoIFBDSS4gSSdsbCBjb250aW51ZSB0byBkaWcgdG8gc2VlIGlmIEkgY2FuDQpmaW5kIHNv
bWV0aGluZy4uLg0KDQo+IA0KPiANCj4gPg0KPiA+ID4NCj4gPiA+ID4+IFRoZSBQQ0kgRVhUIGNh
cGFiaWxpdGllcyBsb2NhdGUgZnJvbSAxMDBoLiBOb3Qgc3VyZSBpZiBob3N0IGNvbnRyb2xsZXIg
ZHJpdmVyIGxpbWl0cyB0byBkaXNwbGF5IHRoZW0/DQo+ID4gPiBJIGRpZCBub3QgZ2V0IHlvdXIg
cXVlc3Rpb24uIENhbiB5b3Ugc2F5IGl0IGFnYWluIHBsZWFzZT8NCj4gPg0KPiA+IEkgbWVhbnQg
b2Zmc2V0IDEwMGggb2YgUENJIGNvbmZpZ3VyYXRpb24gc3BhY2UgaXMgYSBzdGFuZGFyZCBhcmVh
IFsxXS4NCj4gPg0KPiA+ICJQQ0kgRXhwcmVzcyBleHRlbmRzIHRoZSBDb25maWd1cmF0aW9uIFNw
YWNlIHRvIDQwOTYgYnl0ZXMgcGVyIEZ1bmN0aW9uIGFzIGNvbXBhcmVkIHRvIDI1NiBieXRlcw0K
PiA+IGFsbG93ZWQgYnkgUENJIExvY2FsIEJ1cyBTcGVjaWZpY2F0aW9uLiBQQ0kgRXhwcmVzcyBD
b25maWd1cmF0aW9uIFNwYWNlIGlzIGRpdmlkZWQgaW50byBhIFBDSSAzLjANCj4gPiBjb21wYXRp
YmxlIHJlZ2lvbiwgd2hpY2ggY29uc2lzdHMgb2YgdGhlIGZpcnN0IDI1NiBieXRlcyBvZiBhIEZ1
bmN0aW9u4oCZcyBDb25maWd1cmF0aW9uIFNwYWNlLCBhbmQgYQ0KPiA+IFBDSSBFeHByZXNzIEV4
dGVuZGVkIENvbmZpZ3VyYXRpb24gU3BhY2Ugd2hpY2ggY29uc2lzdHMgb2YgdGhlIHJlbWFpbmlu
ZyBDb25maWd1cmF0aW9uIFNwYWNlDQo+ID4gNSAoc2VlIEZpZ3VyZSA3LTMpLiINCj4gPg0KPiA+
IEkgZG9uJ3Qga25vdyB3aHkgdGhlIFBDSSBjb250cm9sbGVyIGluIHlvdXIgcGxhdGZvcm0gZG9l
c24ndCByZWNvZ25pemUgdGhlIHJlZ2lvbiwNCj4gPiBhbmQgdGhlbiBfcG9zc2libHlfIGNhdXNl
IGRyaXZlciBmYWlsZWQgdG8gYWNjZXNzIDcxOWguDQo+ID4NCj4gPg0KPiA+IFsxXSBodHRwczov
L2Jsb2cuY3Nkbi5uZXQvaHVhbmdrYW5neWluZy9hcnRpY2xlL2RldGFpbHMvNTA1NzA2MTINCj4g
DQo+IEFjY29yZGluZyB0byB0aGUgc3BlY3M6DQo+IDIgeCBNLjIgKFBDSSBFeHByZXNzIDQuMCB4
NCkgKDEgZnJlZSkNCj4gNTEyIEdCIFNTRCBNLjIgMjI0MiBQQ0llIDQuMCB4NCAtIE5WTSBFeHBy
ZXNzIChOVk1lKQ0KPiBhbmQgSSBoYXZlIGFjdHVhbGx5IGluc2VydGVkIGEgc2Vjb25kIFNTRCBt
eXNlbGYNCj4gDQo+IElzIHRoZSBkcml2ZXIgY29tcGF0aWJsZSB3aXRoIFBDSSA0LjA/DQoNCkkg
dGhpbmsgUENJIHNob3VsZCBiZSBiYWNrd2FyZCBjb21wYXRpYmxlIHRvIG9sZGVyIGRldmljZXMu
IA0KDQoNCkkgZGlkIHRyYWNlIFBDSSBjb2RlIGFuZCBmb3VuZCBwY2lfZGV2LT5jZmdfc2l6ZSBs
aW1pdCB0aGUgYWNjZXNzLCBzbyBwbGVhc2UgdHJ5DQpiZWxvdyBoYWNrIHBhdGNoIGluIGRyaXZl
ciBhbmQgc2VlIHBjaV9kZXYtPmNmZ19zaXplIGluIHlvdXIgcGxhdGZvcm0uDQoNCkBAIC0yMTEx
LDYgKzIxMTEsMTEgQEAgc3RhdGljIGludCBydHc4OV9wY2lfYXV0b19yZWZjbGtfY2FsKHN0cnVj
dCBydHc4OV9kZXYgKnJ0d2RldiwgYm9vbCBhdXRvb2tfZW4pDQogICAgICAgIHU4IHZhbDgsIGJk
cl9vcmk7DQogICAgICAgIGJvb2wgbDFfZmxhZyA9IGZhbHNlOw0KICAgICAgICBpbnQgcmV0ID0g
MDsNCisgICAgICAgc3RydWN0IHJ0dzg5X3BjaSAqcnR3cGNpID0gKHN0cnVjdCBydHc4OV9wY2kg
KilydHdkZXYtPnByaXY7DQorICAgICAgIHN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gcnR3cGNpLT5w
ZGV2Ow0KKw0KKyAgICAgICBwcmludGsoInBkZXYtPmNmZ19zaXplPSVkXG4iLCBwZGV2LT5jZmdf
c2l6ZSk7ICAvLyBpbiBteSBjb21wdXRlciwgdGhpcyBpcyA0MDk2IGFscmVhZHkNCisgICAgICAg
cGRldi0+Y2ZnX3NpemUgPSBQQ0lfQ0ZHX1NQQUNFX0VYUF9TSVpFOyAvLyA0MDk2DQoNCiAgICAg
ICAgaWYgKGNoaXBfaWQgIT0gUlRMODg1MkIgJiYgY2hpcF9pZCAhPSBSVEw4ODUxQikNCiAgICAg
ICAgICAgICAgICByZXR1cm4gMDsNCg0KUGluZy1LZQ0KDQo=

