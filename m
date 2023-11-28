Return-Path: <linux-wireless+bounces-137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E8D7FAF7A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 02:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F2A1C20AAD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 01:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA8817F8;
	Tue, 28 Nov 2023 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9FAD59
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 17:21:24 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AS1LKYk81664603, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AS1LKYk81664603
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 09:21:20 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 28 Nov 2023 09:21:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 28 Nov 2023 09:21:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 28 Nov 2023 09:21:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ali Ghandour <gandour.ali@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Lenovo LOQ rtw_8852be
Thread-Topic: Lenovo LOQ rtw_8852be
Thread-Index: AQHaH+dudVZVMpW7Qk6t1f3PxKDyKLCNY6tQ///EsACAAAT0AIAAh+ZQ
Date: Tue, 28 Nov 2023 01:21:19 +0000
Message-ID: <b4cfd676c0b24d98b82302aefac7f379@realtek.com>
References: <1700948088-16140-mlmmj-666d2532@vger.kernel.org>
 <CAOE0c97T1cVvqFkqfrP_h53X08yQ7kLinZP09L35nVHc_V89+g@mail.gmail.com>
 <5abfc98859504795b50f7f343784c886@realtek.com>
 <CAOE0c96uJ9x8gbJZdHiMEiOM5gTd_ZqM_rUV7Cs1NyA_t0Ncfg@mail.gmail.com>
 <CAOE0c97fDaLTfsMJVmEh4HxOAPY19kD60qsV5AKJbWW5nnqWzw@mail.gmail.com>
In-Reply-To: <CAOE0c97fDaLTfsMJVmEh4HxOAPY19kD60qsV5AKJbWW5nnqWzw@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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
YW5kb3VyLmFsaUBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMjcsIDIwMjMg
MjoxOSBQTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IENjOiBs
aW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IExlbm92byBMT1Eg
cnR3Xzg4NTJiZQ0KPiANCj4gc2VlbXMgbGlrZSB0aGUgc2FtZSBlcnJvciBwZXJzaXN0cyBhZnRl
ciBkb3duZ3JhZGluZzoNCj4gDQo+ICQgdW5hbWUgLXINCj4gNS4xNy4wLTEwMzUtb2VtDQo+IA0K
PiAkIHN1ZG8gZG1lc2cgfCBncmVwIHJ0dw0KPiBbICAgIDQuODU5ODQ4XSBydHc4OV84ODUyYmUg
MDAwMDowOTowMC4wOiBsb2FkZWQgZmlybXdhcmUNCj4gcnR3ODkvcnR3ODg1MmJfZnctMS5iaW4N
Cj4gWyAgICA0Ljg2MDIxNF0gcnR3ODlfODg1MmJlIDAwMDA6MDk6MDAuMDogZW5hYmxpbmcgZGV2
aWNlICgwMDAwIC0+IDAwMDMpDQo+IFsgICAgNC44NjE1NDZdIHJ0dzg5Xzg4NTJiZSAwMDAwOjA5
OjAwLjA6IEZpcm13YXJlIHZlcnNpb24gMC4yOS4yOS41DQo+IChkYTg3Y2NjZCksIGNtZCB2ZXJz
aW9uIDAsIHR5cGUgNQ0KPiBbICAgIDQuODYxNTUwXSBydHc4OV84ODUyYmUgMDAwMDowOTowMC4w
OiBGaXJtd2FyZSB2ZXJzaW9uIDAuMjkuMjkuNQ0KPiAoZGE4N2NjY2QpLCBjbWQgdmVyc2lvbiAw
LCB0eXBlIDMNCj4gWyAgICA0Ljg2MTU1Nl0gcnR3ODlfODg1MmJlIDAwMDA6MDk6MDAuMDogTUFD
IGhhcyBhbHJlYWR5IHBvd2VyZWQgb24NCj4gWyAgICA0Ljg2NzI0Nl0gcnR3ODlfODg1MmJlIDAw
MDA6MDk6MDAuMDogW0VSUl1wY2kgY29uZmlnIHJlYWQgNzE5DQoNCldlIGRpZCBjaGFuZ2VzIGFm
dGVyIDUuMTgsIGJ1dCB5b3VyIDUuMTcgcHJpbnQgb3V0IGVycm9yIHdpdGgNCiJwY2kgY29uZmln
IHJlYWQiIGluc3RlYWQgb2YgImRiaV9yOF9wY2llIi4gDQoNCi0gICAgICAgcmV0ID0gcnR3ODlf
ZGJpX3JlYWQ4KHJ0d2RldiwgUlRXODlfUENJRV9MMV9DVFJMLCAmYmRyX29yaSk7DQorICAgICAg
IHJldCA9IHJ0dzg5X3BjaV9yZWFkX2NvbmZpZ19ieXRlKHJ0d2RldiwgUlRXODlfUENJRV9MMV9D
VFJMLCAmYmRyX29yaSk7DQogICAgICAgIGlmIChyZXQpIHsNCi0gICAgICAgICAgICAgICBydHc4
OV9lcnIocnR3ZGV2LCAiW0VSUl1kYmlfcjhfcGNpZSAlWFxuIiwgUlRXODlfUENJRV9MMV9DVFJM
KTsgIC8vIDUuMTcNCisgICAgICAgICAgICAgICBydHc4OV9lcnIocnR3ZGV2LCAiW0VSUl1wY2kg
Y29uZmlnIHJlYWQgJVhcbiIsIFJUVzg5X1BDSUVfTDFfQ1RSTCk7IC8vIDUuMTgNCiAgICAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KICAgICAgICB9DQoNClVoLiBJIGtub3cgdGhlIHJlYXNvbiB3
aHkgeW91IHNlZSB0aGUgbmV3IG9uZSwgYmVjYXVzZSA4ODUyYmUgaXMgc3VwcG9ydGVkDQpieSBr
ZXJuZWwgNi4yLCBhbmQgZGlzdHJvIGJhY2twb3J0IHRoZSBkcml2ZXIgdG8gb2xkIGtlcm5lbC4N
Cg0KDQpJZiB5b3UgY2FuIGJ1aWxkIGRyaXZlciB5b3Vyc2VsZiwgcGxlYXNlIHJldmVydCBiZWxv
dyBwYXRjaCBhbmQgdHJ5IGFnYWluLg0KRml4ZXM6IGRiMzhkOWNkMjZjOSAoInJ0dzg5OiB1c2Ug
cGNpX3JlYWQvd3JpdGVfY29uZmlnIGluc3RlYWQgb2YgZGJpIHJlYWQvd3JpdGUiKQ0KDQo+ID4N
Cj4gPiAkIGxzcGNpIC10dg0KPiA+IC1bMDAwMDowMF0tKy0wMC4wICBJbnRlbCBDb3Jwb3JhdGlv
biBEZXZpY2UgYTcxNQ0KDQpJIHdpbGwgdHJ5IHRvIEdvb2dsZSB0byBzZWUgaWYgSSBjYW4gZmlu
ZCBzb21lIGluZm9ybWF0aW9uIGFib3V0IHRoaXMgUENJIGhvc3QgY29udHJvbGxlci4NCg0KQ2Fu
IEkga25vdyB0aGUgdHlwZSBvZiB5b3VyIHBsYXRvZm9ybSBMZW5vdm8gTE9RPyBJcyBpdCBhIHJl
Z3VsYXIgbm90ZWJvb2sgY29tcHV0ZXI/DQoNCj4gPg0KPiA+ICQgc3VkbyBsc3BjaSAtcyAwOTow
MC4wIC14eHh4DQo+ID4gMDk6MDAuMCBOZXR3b3JrIGNvbnRyb2xsZXI6IFJlYWx0ZWsgU2VtaWNv
bmR1Y3RvciBDby4sIEx0ZC4gRGV2aWNlIGI4NTINCg0KWy4uLl0NCg0KPiA+IGYwOiAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KDQpJbiBteSBzaWRlLCBs
c3BjaSB3aXRoICcteHh4eCcsIGl0IGNhbiBkaXNwbGF5IFBDSSBjb25maWd1cmF0aW9uIHNwYWNl
IDAgfiBmZjAuDQpJbiB5b3VyIHNpZGUsIGxzcGNpIGhhcyB0aGUgc2FtZSBiZWhhdmlvciBhcyBk
cml2ZXIgdGhhdCBjYW4ndCByZWFkIDB4NzE5Lg0KDQpUaGUgUENJIEVYVCBjYXBhYmlsaXRpZXMg
bG9jYXRlIGZyb20gMTAwaC4gTm90IHN1cmUgaWYgaG9zdCBjb250cm9sbGVyIGRyaXZlcg0KbGlt
aXRzIHRvIGRpc3BsYXkgdGhlbT8gDQoNClBpbmctS2UNCg0K

