Return-Path: <linux-wireless+bounces-1950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25D382E7B8
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 02:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4031C22CE8
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 01:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB812F9CD;
	Tue, 16 Jan 2024 01:25:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D459F511
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 01:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40G1PErG44099965, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40G1PErG44099965
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 09:25:14 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 16 Jan 2024 09:25:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 16 Jan 2024 09:25:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Tue, 16 Jan 2024 09:25:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>,
        Zenm Chen <zenmchen@gmail.com>
Subject: RE: [PATCH v2 19/21] wifi: rtl8xxxu: add hw crypto support for AP mode
Thread-Topic: [PATCH v2 19/21] wifi: rtl8xxxu: add hw crypto support for AP
 mode
Thread-Index: AQHaNC0sDGaHcKZrXkiVSN0UWy+01bDV2+dQgASeqYCAAUrdoA==
Date: Tue, 16 Jan 2024 01:25:13 +0000
Message-ID: <a6f7104243e14894a6638679c0e347b6@realtek.com>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
 <20231221164353.603258-20-martin.kaistra@linutronix.de>
 <92fa5949e8094739883e665abb23ac01@realtek.com>
 <87e04cfe-f8ed-40da-bb2c-edccfe385b6e@linutronix.de>
In-Reply-To: <87e04cfe-f8ed-40da-bb2c-edccfe385b6e@linutronix.de>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFydGluIEthaXN0cmEg
PG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAx
NSwgMjAyNCA5OjEzIFBNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47
IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogSmVzIFNvcmVuc2VuIDxKZXMu
U29yZW5zZW5AZ21haWwuY29tPjsgS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz47IEJpdHRl
cmJsdWUgU21pdGgNCj4gPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPjsgU2ViYXN0aWFuIEFuZHJ6
ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPjsgWmVubSBDaGVuDQo+IDx6ZW5tY2hl
bkBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTkvMjFdIHdpZmk6IHJ0bDh4
eHh1OiBhZGQgaHcgY3J5cHRvIHN1cHBvcnQgZm9yIEFQIG1vZGUNCj4gDQo+IEhpIFBpbmctS2Us
DQo+IA0KPiBBbSAxMi4wMS4yNCB1bSAwNzo1MiBzY2hyaWViIFBpbmctS2UgU2hpaDoNCj4gPiBI
aSBNYXJ0aW4sDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJv
bTogTWFydGluIEthaXN0cmEgPG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+DQo+ID4+IFNl
bnQ6IEZyaWRheSwgRGVjZW1iZXIgMjIsIDIwMjMgMTI6NDQgQU0NCj4gPj4gVG86IGxpbnV4LXdp
cmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiA+PiBDYzogSmVzIFNvcmVuc2VuIDxKZXMuU29yZW5z
ZW5AZ21haWwuY29tPjsgS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz47IFBpbmctS2UgU2hp
aA0KPiA+PiA8cGtzaGloQHJlYWx0ZWsuY29tPjsgQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNl
cmZlMkBnbWFpbC5jb20+OyBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yDQo+ID4+IDxiaWdlYXN5
QGxpbnV0cm9uaXguZGU+DQo+ID4+IFN1YmplY3Q6IFtQQVRDSCB2MiAxOS8yMV0gd2lmaTogcnRs
OHh4eHU6IGFkZCBodyBjcnlwdG8gc3VwcG9ydCBmb3IgQVAgbW9kZQ0KPiA+Pg0KPiA+DQo+ID4g
Wy4uLl0NCj4gPg0KPiA+IFplbm0gcmVwb3J0ZWQgWzFdIGhpcyBSVEw4MTkyRVUgYW5kIFJUTDgx
OTJGVSBkb24ndCB3b3JrIGluIHN0YXRpb24gbW9kZSwNCj4gPiBhbmQgY2F1c2UgaXMgdGhpcyBw
YXRjaC4gUGxlYXNlIHRyeSBpZiB5b3UgY2FuIHJlcHJvZHVjZSB0aGUgc3ltcHRvbSwgYW5kDQo+
ID4gYXBwbHkgbXkgc3VnZ2VzdGlvbiB0byBzZWUgaWYgaGVscC4NCj4gPg0KPiA+IFsxXQ0KPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy8yMDI0MDExMjA0NTEwNC4xMjI4
Mi0xLXplbm1jaGVuQGdtYWlsLmNvbS9ULyNtZTA5NDBmNTIyMjQ5YmVjZjQNCj4gOWYyNWJjMjgx
ZjE5OTJjNTIzNjczZjYNCj4gDQo+IEkgbWFuYWdlZCB0byBmaW5kIHR3byBvdGhlciBSZWFsdGVr
IFVTQiBXaWZpIGRldmljZXMgdGhhdCBhcmUgc3VwcG9ydGVkIGJ5IHRoZQ0KPiBydGw4eHh4dSBk
cml2ZXIgKFJUTDgxODhFVSBhbmQgUlRMODE5MkNVKSBhbmQgSSBjYW4gcmVwcm9kdWNlIHRoZSBp
c3N1ZSB3aXRoDQo+IGJvdGggb2YgdGhlbS4NCj4gDQo+IEkgYWxzbyB0cmllZCBjcmVhdGluZyBh
IHBhdGNoIHdpdGggeW91ciBzdWdnZXN0aW9ucyBhbmQgdGhpcyBzZWVtcyB0byBoZWxwLg0KPiAN
Cj4gTG9va2luZyBhdCBpdCBtb3JlIGNsb3NlbHkgaG93ZXZlciwgSSB0aGluayB0aGUgbWFpbiBw
cm9ibGVtIGlzLCB0aGF0DQo+IGZvcHMtPm1heF9zZWNfY2FtX251bSBpcyBub3Qgc2V0IGZvciB0
aGUgb3RoZXIgdmFyaWFudHMuIFdpdGhvdXQgdGhlIGFkZGl0aW9uYWwNCj4gcGF0Y2gsIHRoaXMg
Y2F1c2VzIHJ0bDh4eHh1X2dldF9mcmVlX3NlY19jYW0oKSB0byByZXR1cm4gMCBmb3IgcGFpcndp
c2UgYW5kDQo+IGdyb3VwIGtleSBhbmQgc28gdXNpbmcgdGhlIHNhbWUgc3BvdCBmb3IgYm90aCBr
ZXkgZW50cmllcy4NCj4gDQo+IEkgdGhlbiBjcmVhdGVkIGEgcGF0Y2ggdXNpbmcgdGhlIG51bWJl
cnMgc3VnZ2VzdGVkIGJ5IEJpdHRlcmJsdWUgU21pdGggaW4gWzFdDQo+IGFuZCB1c2luZyAzMiBm
b3IgUlRMODcyM0FVIGFuZCBSVEw4MTkyQ1UgbGlrZSB0aGUgcnRsd2lmaSBkcml2ZXIgc2VlbXMg
dG8gZG8uDQo+IFRoaXMgYWxzbyBzZWVtcyB0byBzb2x2ZSB0aGUgaXNzdWUgcmVwb3J0ZWQsIGV2
ZW4gd2l0aG91dCByZXNlcnZpbmcgdGhlIGZpcnN0IDQNCj4gc2xvdHMgZm9yIGdyb3VwIGtleXMu
DQo+IA0KPiBEbyB5b3UgdGhpbmsgd2UgbmVlZCBib3RoIHBhdGNoZXM/DQoNCkkgdGhpbmsgeW91
IG9ubHkgbmVlZCB0aGUgb25lIHRoYXQgZmlsbHMgZm9wcy0+bWF4X3NlY19jYW1fbnVtLg0KDQpU
aGUgc2VhcmNoIHJ1bGUgb2YgaGFyZHdhcmUgc2VjdXJpdHkgQ0FNIGlzIHRvIGZpbmQgYW4gZW50
cnkgdGhhdCBtYXRjaGVzIGFkZHJlc3MNCmFuZCBrZXlfaWR4LCBhbmQgdGhlbiB1c2UgaXQgdG8g
ZW5jcnlwdC9kZWNyeXB0IHBhY2tldHMuIElmIG5vIGVudHJ5IGZvdW5kLCBpdA0Kc2VsZWN0IGVu
dHJ5IGJ5IGtleV9pZHggKGkuZS4ga2V5X2lkeD0wLzEvMi8zIHVzZSBlbnRyeT0wLzEvMi8zKS4g
QXMgSSBjYW4NCnJlbWVtYmVyLCBXRVAgbmVlZHMgdG8gcmVzZXJ2ZSA0IGVudHJpZXMsIGJ1dCBJ
IGJlbGlldmUgbm8gb25lIHVzZXMgaXQgbm93Lg0KDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3MvZjczYjVhZmMtZDY5Zi00YTdjLThiZjAtODc3YTQ1
MzI3ZTBiQGdtYWlsLmNvbS8NCj4gDQo+ID4+ICAgICAgICAgIGNhc2UgRElTQUJMRV9LRVk6DQo+
ID4+ICAgICAgICAgICAgICAgICAgcnRsOHh4eHVfd3JpdGUzMihwcml2LCBSRUdfQ0FNX1dSSVRF
LCAweDAwMDAwMDAwKTsNCj4gPj4gICAgICAgICAgICAgICAgICB2YWwzMiA9IENBTV9DTURfUE9M
TElORyB8IENBTV9DTURfV1JJVEUgfA0KPiA+PiAtICAgICAgICAgICAgICAgICAgICAgICBrZXkt
PmtleWlkeCA8PCBDQU1fQ01EX0tFWV9TSElGVDsNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAga2V5LT5od19rZXlfaWR4IDw8IENBTV9DTURfS0VZX1NISUZUOw0KPiA+PiAgICAgICAgICAg
ICAgICAgIHJ0bDh4eHh1X3dyaXRlMzIocHJpdiwgUkVHX0NBTV9DTUQsIHZhbDMyKTsNCj4gPj4g
KyAgICAgICAgICAgICAgIHJ0bHZpZi0+aHdfa2V5X2lkeCA9IDB4ZmY7DQo+ID4+ICsgICAgICAg
ICAgICAgICBjbGVhcl9iaXQoa2V5LT5od19rZXlfaWR4LCBwcml2LT5jYW1fbWFwKTsNCj4gPg0K
PiA+IFNob3VsZG4ndCBzd2FwIHRoZXNlIHR3byBzdGF0ZW1lbnRzPyBJIG1pc3NlZCB0aGF0IGR1
cmluZyByZXZpZXdpbmcuDQo+IA0KPiBJIGRvbid0IHRoaW5rIHRoYXQgd291bGQgbWFrZSBhIGRp
ZmZlcmVuY2UuIHJ0bHZpZi0+aHdfa2V5X2lkeCBpcyBzZXQgZm9yIHVzZSBpbg0KPiBydGw4eHh4
dV90eCgpIGFuZCB0aGUgc2Vjb25kIGxpbmUgdXNlcyBrZXktPmh3X2tleV9pZHggdG8gY2xlYXIg
dGhlIG1hcCBlbnRyeS4NCj4gDQoNClNvcnJ5LCBJIG1pc3JlYWQgdGhlICJydGx2aWYtPi4uLiIg
YW5kICJrZXktPi4uLiIgdGhhdCBhcmUgZGlmZmVyZW50LiANCg0KDQoNCg==

