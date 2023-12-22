Return-Path: <linux-wireless+bounces-1190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5BF81C2DE
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 02:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B53AFB24C9D
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 01:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569D26106;
	Fri, 22 Dec 2023 01:45:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D236111
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BM1jSSX11785353, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BM1jSSX11785353
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 09:45:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 22 Dec 2023 09:45:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 22 Dec 2023 09:45:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 22 Dec 2023 09:45:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
Subject: RE: [PATCH v2 13/21] wifi: rtl8xxxu: support multiple interfaces in watchdog_callback()
Thread-Topic: [PATCH v2 13/21] wifi: rtl8xxxu: support multiple interfaces in
 watchdog_callback()
Thread-Index: AQHaNHUvpBpgdM0KL0yoZX5WUI+EHrC0gaBA
Date: Fri, 22 Dec 2023 01:45:28 +0000
Message-ID: <f71b29e17ff14ee9b28dd514a94cf1be@realtek.com>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
 <20231221164353.603258-14-martin.kaistra@linutronix.de>
 <CAKFoaw3o-LkqADNvfE0TXmvr8_LK19mpVQtUZ66CWS=AN5AkJQ@mail.gmail.com>
In-Reply-To: <CAKFoaw3o-LkqADNvfE0TXmvr8_LK19mpVQtUZ66CWS=AN5AkJQ@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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

DQpPbiBGcmksIERlYyAyMiwgMjAyMyBhdCAxMjo0NeKAr0FNIE1hcnRpbiBLYWlzdHJhDQo8bWFy
dGluLmthaXN0cmFAbGludXRyb25peC5kZT4gd3JvdGU6DQo+DQo+IENoZWNrIGZpcnN0IHdoZXRo
ZXIgcHJpdi0+dmlmc1swXSBleGlzdHMgYW5kIGlzIG9mIHR5cGUgU1RBVElPTiwgdGhlbiBnbw0K
PiB0byBwcml2LT52aWZzWzFdLiBNYWtlIHN1cmUgdG8gY2FsbCByZWZyZXNoX3JhdGVfbWFzayBm
b3IgYm90aA0KPiBpbnRlcmZhY2VzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gS2Fpc3Ry
YSA8bWFydGluLmthaXN0cmFAbGludXRyb25peC5kZT4NCj4gLS0tDQo+ICAuLi4vd2lyZWxlc3Mv
cmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMgfCAxOSArKysrKysrKysrKy0tLS0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRs
OHh4eHVfY29yZS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4
eHh4dV9jb3JlLmMNCj4gaW5kZXggYzViNzE4OTIzNjljOS4uZmQwMTA4NjY4YmNkYSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9j
b3JlLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4
eHh4dV9jb3JlLmMNCj4gQEAgLTcyMDAsMTEgKzcyMDAsMTUgQEAgc3RhdGljIHZvaWQgcnRsOHh4
eHVfd2F0Y2hkb2dfY2FsbGJhY2soc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgew0KPiAg
ICAgICAgIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWY7DQo+ICAgICAgICAgc3RydWN0IHJ0bDh4
eHh1X3ByaXYgKnByaXY7DQo+ICsgICAgICAgaW50IGk7DQo+DQo+ICAgICAgICAgcHJpdiA9IGNv
bnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgcnRsOHh4eHVfcHJpdiwgcmFfd2F0Y2hkb2cud29yayk7
DQo+IC0gICAgICAgdmlmID0gcHJpdi0+dmlmOw0KPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBB
UlJBWV9TSVpFKHByaXYtPnZpZnMpOyBpKyspIHsNCj4gKyAgICAgICAgICAgICAgIHZpZiA9IHBy
aXYtPnZpZnNbaV07DQo+ICsNCj4gKyAgICAgICAgICAgICAgIGlmICghdmlmIHx8IHZpZi0+dHlw
ZSAhPSBOTDgwMjExX0lGVFlQRV9TVEFUSU9OKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBj
b250aW51ZTsNCg0KQ3VycmVudGx5LCB0aGlzIGxvb3AgYmVjb21lcyB0byBnZXQgUlNTSSBhbmQg
dXBkYXRlIHJhdGUgbWFzaywgYnV0IG9ubHkgZm9yIA0Kc3RhdGlvbiBtb2RlLiBUaGF0IG1lYW5z
IHdlIGRvbid0IHVwZGF0ZSB0aGVtIGZvciBwZWVyIHN0YXRpb25zIGluIEFQIG1vZGUuDQpNYXli
ZSwgd2UgbmVlZCBpZWVlODAyMTFfaXRlcmF0ZV9zdGF0aW9uc19hdG9taWMoKSBmb3IgYWxsIHN0
YXRpb25zLCBidXQNCmllZWU4MDIxMV9hdmVfcnNzaSgpIGlzIG9ubHkgZm9yICd2aWYnLCBzbyB3
ZSBuZWVkIHRvIGFkZCBhIGRyaXZlciBsZXZlbA0KUlNTSSBmb3IgYWxsIHN0YXRpb25zIChtYWNp
ZCkuIEFsc28sIHdlIG5lZWQgdG8gZXh0ZW5kIHByaXYtPnJzc2lfbGV2ZWwgZm9yDQphbGwgbWFj
aWQgYXMgd2VsbC4NCg0KSSBzdXBwb3NlIF9kZWZhdWx0XyB2YWx1ZSBjYW4gd29yayB0byBzdGF0
aW9ucyBpbiBBUCBtb2RlLCBzbyB5b3UgY2FuIGRlY2lkZQ0KaWYgeW91IHdpbGwgZGVmZXIgdGhp
cyBzdXBwb3J0IHRlbXBvcmFyaWx5LiANCg0KKFNvcnJ5LCBJIGRvbid0IGRpZyBydGw4eHh4dSB2
ZXJ5IGRlZXBseSwgc28gSSdtIG5vdCBhYmxlIHRvIHRlbGwgeW91IGFsbA0KdGhpbmdzIGluIG9u
ZSBnby4pDQoNCj4NCj4gLSAgICAgICBpZiAodmlmICYmIHZpZi0+dHlwZSA9PSBOTDgwMjExX0lG
VFlQRV9TVEFUSU9OKSB7DQo+ICAgICAgICAgICAgICAgICBpbnQgc2lnbmFsOw0KPiAgICAgICAg
ICAgICAgICAgc3RydWN0IGllZWU4MDIxMV9zdGEgKnN0YTsNCj4NCj4gQEAgLTcyMTUsMjIgKzcy
MTksMjEgQEAgc3RhdGljIHZvaWQgcnRsOHh4eHVfd2F0Y2hkb2dfY2FsbGJhY2soc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKQ0KPg0KPiAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfZGJnKGRl
diwgIiVzOiBubyBzdGEgZm91bmRcbiIsIF9fZnVuY19fKTsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgcmN1X3JlYWRfdW5sb2NrKCk7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGdvdG8g
b3V0Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gICAgICAgICAgICAg
ICAgIH0NCj4gICAgICAgICAgICAgICAgIHJjdV9yZWFkX3VubG9jaygpOw0KPg0KPiAgICAgICAg
ICAgICAgICAgc2lnbmFsID0gaWVlZTgwMjExX2F2ZV9yc3NpKHZpZik7DQo+DQo+IC0gICAgICAg
ICAgICAgICBwcml2LT5mb3BzLT5yZXBvcnRfcnNzaShwcml2LCAwLA0KPiArICAgICAgICAgICAg
ICAgcHJpdi0+Zm9wcy0+cmVwb3J0X3Jzc2kocHJpdiwgcnRsOHh4eHVfZ2V0X21hY2lkKHByaXYs
IHN0YSksDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBydGw4eHh4
dV9zaWduYWxfdG9fc25yKHNpZ25hbCkpOw0KPg0KPiAtICAgICAgICAgICAgICAgaWYgKHByaXYt
PmZvcHMtPnNldF9jcnlzdGFsX2NhcCkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcnRsOHh4
eHVfdHJhY2tfY2ZvKHByaXYpOw0KPiAtDQo+ICAgICAgICAgICAgICAgICBydGw4eHh4dV9yZWZy
ZXNoX3JhdGVfbWFzayhwcml2LCBzaWduYWwsIHN0YSwgZmFsc2UpOw0KDQpJdCBzZWVtcyBsaWtl
ICdzdGEnIGlzbid0IHByb3RlY3RlZCBieSBSQ1UgcmVhZCBsb2NrLiANCihhbiBleGlzdGluZyBi
dWcsIG5vdCBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gpDQoNCg0KPiAgICAgICAgIH0NCj4NCj4g
LW91dDoNCj4gKyAgICAgICBpZiAocHJpdi0+Zm9wcy0+c2V0X2NyeXN0YWxfY2FwKQ0KPiArICAg
ICAgICAgICAgICAgcnRsOHh4eHVfdHJhY2tfY2ZvKHByaXYpOw0KPiArDQo+ICAgICAgICAgc2No
ZWR1bGVfZGVsYXllZF93b3JrKCZwcml2LT5yYV93YXRjaGRvZywgMiAqIEhaKTsNCj4gIH0NCj4N
Cj4gLS0NCj4gMi4zOS4yDQo+DQo+DQo=

