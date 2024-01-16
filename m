Return-Path: <linux-wireless+bounces-1949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D6A82E666
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 02:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8431D2856C8
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 01:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237708494;
	Tue, 16 Jan 2024 00:56:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0280848E
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 00:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40G0uKUw94085729, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40G0uKUw94085729
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 08:56:20 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 16 Jan 2024 08:56:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 16 Jan 2024 08:56:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Tue, 16 Jan 2024 08:56:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH] wifi: rtlwifi: rtl8192de: Fix byte order of chip version
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8192de: Fix byte order of chip version
Thread-Index: AQHaRam9Hy6mYhlr3USS49QlLcoixLDaXnbA///zCQCAAU4poA==
Date: Tue, 16 Jan 2024 00:56:20 +0000
Message-ID: <508550165dc24c3d932565d1adaf3766@realtek.com>
References: <81b6c452-e940-423a-acf7-4a7b7c5e7847@gmail.com>
 <c369eeb8b3014f068d1c60b42b44e206@realtek.com>
 <d4fa544d-46fc-4795-8da1-5dd6199bdea9@gmail.com>
In-Reply-To: <d4fa544d-46fc-4795-8da1-5dd6199bdea9@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAxNSwg
MjAyNCA4OjUxIFBNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47IGxp
bnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogTGFycnkgRmluZ2VyIDxMYXJyeS5G
aW5nZXJAbHdmaW5nZXIubmV0Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSB3aWZpOiBydGx3aWZp
OiBydGw4MTkyZGU6IEZpeCBieXRlIG9yZGVyIG9mIGNoaXAgdmVyc2lvbg0KPiANCj4gDQo+IGRp
ZmYgLS1naXQgYS9oYWwvcnRsODE5MmRfaGFsX2luaXQuYyBiL2hhbC9ydGw4MTkyZF9oYWxfaW5p
dC5jDQo+IGluZGV4IDE1NjU0MWIuLjE3NWM4NTYgMTAwNjQ0DQo+IC0tLSBhL2hhbC9ydGw4MTky
ZF9oYWxfaW5pdC5jDQo+ICsrKyBiL2hhbC9ydGw4MTkyZF9oYWxfaW5pdC5jDQo+IEBAIC0xNTY1
LDYgKzE1NjUsOCBAQCBoYWxfRWZ1c2VVcGRhdGVOb3JtYWxDaGlwVmVyc2lvbl85MkQoDQo+ICAg
ICAgICAgUmVhZEVGdXNlQnl0ZShBZGFwdGVyLEVFUFJPTUVfQ0hJUF9WRVJTSU9OX0wsJkN1dFZh
bHVlWzBdLCBfRkFMU0UpOw0KPiANCj4gICAgICAgICBDaGlwVmFsdWU9IChDdXRWYWx1ZVsxXTw8
OCl8Q3V0VmFsdWVbMF07DQo+ICsNCj4gKyAgICAgICBwcl9lcnIoIiVzOiBFRVBST01FX0NISVBf
VkVSU0lPTl9IOiAlI3ggRUVQUk9NRV9DSElQX1ZFUlNJT05fTDogJSN4IEN1dFZhbHVlWzFdOiAl
I3ggQ3V0VmFsdWVbMF06DQo+ICUjeCBDaGlwVmFsdWU6ICUjeFxuIiwgX19mdW5jX18sIEVFUFJP
TUVfQ0hJUF9WRVJTSU9OX0gsIEVFUFJPTUVfQ0hJUF9WRVJTSU9OX0wsIEN1dFZhbHVlWzFdLCBD
dXRWYWx1ZVswXSwNCj4gQ2hpcFZhbHVlKTsNCj4gICAgICAgICBzd2l0Y2goQ2hpcFZhbHVlKXsN
Cj4gICAgICAgICAgICAgICAgIGNhc2UgMHhBQTU1Og0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAvL0NoaXBWZXIgfD0gQ0hJUF85MkRfQ19DVVQ7DQo+IA0KPiBUaGlzIGlzIHRoZSBvdXRwdXQ6
DQo+IA0KPiBKYW4gMTUgMTQ6MzU6MjEgaWRlYXBhZDIga2VybmVsOiBoYWxfRWZ1c2VVcGRhdGVO
b3JtYWxDaGlwVmVyc2lvbl85MkQ6IEVFUFJPTUVfQ0hJUF9WRVJTSU9OX0g6IDB4M2ZlDQo+IEVF
UFJPTUVfQ0hJUF9WRVJTSU9OX0w6IDB4M2ZmIEN1dFZhbHVlWzFdOiAweDMzIEN1dFZhbHVlWzBd
OiAweGNjIENoaXBWYWx1ZTogMHgzM2NjDQoNCldpdGggdGhlIHNhbWUgYnJhbmNoIGFuZCB0aGUg
c2FtZSBjaGFuZ2VzIHlvdSBtZW50aW9uZWQsIG91dHB1dCBpczogDQoNCmhhbF9FZnVzZVVwZGF0
ZU5vcm1hbENoaXBWZXJzaW9uXzkyRDogRUVQUk9NRV9DSElQX1ZFUlNJT05fSDogMHgzZmUgRUVQ
Uk9NRV9DSElQX1ZFUlNJT05fTDogMHgzZmYgQ3V0VmFsdWVbMV06IDB4Y2MgQ3V0VmFsdWVbMF06
IDB4MzMgQ2hpcFZhbHVlOiAweGNjMzMNCg0KPiANCj4gTWF5YmUgbXkgZGV2aWNlIHJlYWxseSBp
cyBhIGRpZmZlcmVudCB2ZXJzaW9uLg0KDQpOb3Qgc3VyZSB3aGF0IGhhcHBlbnMuIEkgZmVlbCBu
byBvbmUgY2FuIHJlbWVtYmVyIHRoZSBkZWZpbml0aW9uIG9mIHRoZXNlIHZhbHVlcy4gDQpNYXli
ZSwgd2UgY2FuIGp1c3QgYWRkIGFuIG5ldyB2YWx1ZSAweDMzQ0MsIGFuZCB0ZXN0IGlmIGl0IHdv
cmtzIG5vcm1hbC4gDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0bHdpZmkvcnRsODE5MmRlL2h3LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
bHdpZmkvcnRsODE5MmRlL2h3LmMNCmluZGV4IDc0M2FjNjg3MWJmNC4uYzMzNmQ0YjM2MmY1IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJk
ZS9ody5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5
MmRlL2h3LmMNCkBAIC0xNjg0LDYgKzE2ODQsNyBAQCBzdGF0aWMgdm9pZCBfcnRsOTJkZV9lZnVz
ZV91cGRhdGVfY2hpcF92ZXJzaW9uKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KQ0KICAgICAgICAg
ICAgICAgIHJ0bF9kYmcocnRscHJpdiwgQ09NUF9JTklULCBEQkdfTE9VRCwgIkQtQ1VUISEhXG4i
KTsNCiAgICAgICAgICAgICAgICBicmVhazsNCiAgICAgICAgY2FzZSAweENDMzM6DQorICAgICAg
IGNhc2UgMHgzM0NDOg0KICAgICAgICAgICAgICAgIGNoaXB2ZXIgfD0gQ0hJUF85MkRfRV9DVVQ7
DQogICAgICAgICAgICAgICAgcnRsX2RiZyhydGxwcml2LCBDT01QX0lOSVQsIERCR19MT1VELCAi
RS1DVVQhISFcbiIpOw0KICAgICAgICAgICAgICAgIGJyZWFrOw0KDQpIb3cgZGlkIHlvdSBmaW5k
IHRoaXMgd2VpcmQgdmFsdWU/IFZlbmRvciBkcml2ZXIgZG9lc24ndCB3b3JrIGZvciB5b3U/DQoN
ClBpbmctS2UNCg0K

