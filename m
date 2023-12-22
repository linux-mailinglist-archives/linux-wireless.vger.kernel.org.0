Return-Path: <linux-wireless+bounces-1214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C0481C708
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ECB2B214C4
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 08:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C34D512;
	Fri, 22 Dec 2023 08:59:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FF3D50B
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BM8xPPM12035596, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BM8xPPM12035596
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 16:59:25 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 22 Dec 2023 16:59:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 22 Dec 2023 16:59:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 22 Dec 2023 16:59:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "martin.kaistra@linutronix.de" <martin.kaistra@linutronix.de>
CC: "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 13/21] wifi: rtl8xxxu: support multiple interfaces in watchdog_callback()
Thread-Topic: [PATCH v2 13/21] wifi: rtl8xxxu: support multiple interfaces in
 watchdog_callback()
Thread-Index: AQHaNHUvpBpgdM0KL0yoZX5WUI+EHrC0gaBA///qhYCAAAWQAIAACUAA
Date: Fri, 22 Dec 2023 08:59:23 +0000
Message-ID: <bbe5babe03b7b23c988af9ce8777df0d5302592b.camel@realtek.com>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
	 <20231221164353.603258-14-martin.kaistra@linutronix.de>
	 <CAKFoaw3o-LkqADNvfE0TXmvr8_LK19mpVQtUZ66CWS=AN5AkJQ@mail.gmail.com>
	 <f71b29e17ff14ee9b28dd514a94cf1be@realtek.com>
	 <b8764bec-4dc6-4779-a3c3-d22e7d5acce9@linutronix.de>
	 <f3949264-c530-43e1-a528-eedcc2b31d0d@linutronix.de>
In-Reply-To: <f3949264-c530-43e1-a528-eedcc2b31d0d@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <E657A9E50F247E44B580AF14432F7D5E@realtek.com>
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

T24gRnJpLCAyMDIzLTEyLTIyIGF0IDA5OjI1ICswMTAwLCBNYXJ0aW4gS2Fpc3RyYSB3cm90ZToN
Cj4gDQo+IEFtIDIyLjEyLjIzIHVtIDA5OjA1IHNjaHJpZWIgTWFydGluIEthaXN0cmE6DQo+ID4g
QW0gMjIuMTIuMjMgdW0gMDI6NDUgc2NocmllYiBQaW5nLUtlIFNoaWg6DQo+ID4gPiBPbiBGcmks
IERlYyAyMiwgMjAyMyBhdCAxMjo0NeKAr0FNIE1hcnRpbiBLYWlzdHJhDQo+ID4gPiA8bWFydGlu
LmthaXN0cmFAbGludXRyb25peC5kZT4gd3JvdGU6DQo+ID4gPiA+IENoZWNrIGZpcnN0IHdoZXRo
ZXIgcHJpdi0+dmlmc1swXSBleGlzdHMgYW5kIGlzIG9mIHR5cGUgU1RBVElPTiwgdGhlbiBnbw0K
PiA+ID4gPiB0byBwcml2LT52aWZzWzFdLiBNYWtlIHN1cmUgdG8gY2FsbCByZWZyZXNoX3JhdGVf
bWFzayBmb3IgYm90aA0KPiA+ID4gPiBpbnRlcmZhY2VzLg0KPiA+ID4gPiANCj4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogTWFydGluIEthaXN0cmEgPG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+
DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgIC4uLi93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0
bDh4eHh1X2NvcmUuYyB8IDE5ICsrKysrKysrKysrLS0tLS0tLS0NCj4gPiA+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4g
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0
bDh4eHh1X2NvcmUuYw0KPiA+ID4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRs
OHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+ID4gPiA+IGluZGV4IGM1YjcxODkyMzY5YzkuLmZkMDEw
ODY2OGJjZGEgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+ID4gPiA+IEBAIC03MjAw
LDExICs3MjAwLDE1IEBAIHN0YXRpYyB2b2lkIHJ0bDh4eHh1X3dhdGNoZG9nX2NhbGxiYWNrKHN0
cnVjdA0KPiA+ID4gPiB3b3JrX3N0cnVjdCAqd29yaykNCj4gPiA+ID4gICB7DQo+ID4gPiA+ICAg
ICAgICAgIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWY7DQo+ID4gPiA+ICAgICAgICAgIHN0cnVj
dCBydGw4eHh4dV9wcml2ICpwcml2Ow0KPiA+ID4gPiArICAgICAgIGludCBpOw0KPiA+ID4gPiAN
Cj4gPiA+ID4gICAgICAgICAgcHJpdiA9IGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgcnRsOHh4
eHVfcHJpdiwgcmFfd2F0Y2hkb2cud29yayk7DQo+ID4gPiA+IC0gICAgICAgdmlmID0gcHJpdi0+
dmlmOw0KPiA+ID4gPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHByaXYtPnZp
ZnMpOyBpKyspIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHZpZiA9IHByaXYtPnZpZnNbaV07
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGlmICghdmlmIHx8IHZpZi0+dHlw
ZSAhPSBOTDgwMjExX0lGVFlQRV9TVEFUSU9OKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBjb250aW51ZTsNCj4gPiA+IA0KPiA+ID4gQ3VycmVudGx5LCB0aGlzIGxvb3AgYmVjb21l
cyB0byBnZXQgUlNTSSBhbmQgdXBkYXRlIHJhdGUgbWFzaywgYnV0IG9ubHkgZm9yDQo+ID4gPiBz
dGF0aW9uIG1vZGUuIFRoYXQgbWVhbnMgd2UgZG9uJ3QgdXBkYXRlIHRoZW0gZm9yIHBlZXIgc3Rh
dGlvbnMgaW4gQVAgbW9kZS4NCj4gPiA+IE1heWJlLCB3ZSBuZWVkIGllZWU4MDIxMV9pdGVyYXRl
X3N0YXRpb25zX2F0b21pYygpIGZvciBhbGwgc3RhdGlvbnMsIGJ1dA0KPiA+ID4gaWVlZTgwMjEx
X2F2ZV9yc3NpKCkgaXMgb25seSBmb3IgJ3ZpZicsIHNvIHdlIG5lZWQgdG8gYWRkIGEgZHJpdmVy
IGxldmVsDQo+ID4gPiBSU1NJIGZvciBhbGwgc3RhdGlvbnMgKG1hY2lkKS4gQWxzbywgd2UgbmVl
ZCB0byBleHRlbmQgcHJpdi0+cnNzaV9sZXZlbCBmb3INCj4gPiA+IGFsbCBtYWNpZCBhcyB3ZWxs
Lg0KPiA+ID4gDQo+ID4gPiBJIHN1cHBvc2UgX2RlZmF1bHRfIHZhbHVlIGNhbiB3b3JrIHRvIHN0
YXRpb25zIGluIEFQIG1vZGUsIHNvIHlvdSBjYW4gZGVjaWRlDQo+ID4gPiBpZiB5b3Ugd2lsbCBk
ZWZlciB0aGlzIHN1cHBvcnQgdGVtcG9yYXJpbHkuDQo+ID4gPiANCj4gPiA+IChTb3JyeSwgSSBk
b24ndCBkaWcgcnRsOHh4eHUgdmVyeSBkZWVwbHksIHNvIEknbSBub3QgYWJsZSB0byB0ZWxsIHlv
dSBhbGwNCj4gPiA+IHRoaW5ncyBpbiBvbmUgZ28uKQ0KPiA+IA0KPiA+IEl0IHByb2JhYmx5IG1h
a2VzIHNlbnNlIHRvIGZpeCB0aGlzLCBob3dldmVyIGlmIGl0J3Mgb2sgZm9yIHlvdSwgSSB3b3Vs
ZCBsaWtlIHRvDQo+ID4gZG8gaXQgc2VwYXJhdGx5IGZyb20gdGhpcyBzZXJpZXMuDQoNCk9rIHRv
IG1lLiA6LSkNCg0KPiA+IA0KPiA+IA0KPiA+ID4gPiAtICAgICAgIGlmICh2aWYgJiYgdmlmLT50
eXBlID09IE5MODAyMTFfSUZUWVBFX1NUQVRJT04pIHsNCj4gPiA+ID4gICAgICAgICAgICAgICAg
ICBpbnQgc2lnbmFsOw0KPiA+ID4gPiAgICAgICAgICAgICAgICAgIHN0cnVjdCBpZWVlODAyMTFf
c3RhICpzdGE7DQo+ID4gPiA+IA0KPiA+ID4gPiBAQCAtNzIxNSwyMiArNzIxOSwyMSBAQCBzdGF0
aWMgdm9pZCBydGw4eHh4dV93YXRjaGRvZ19jYWxsYmFjayhzdHJ1Y3QNCj4gPiA+ID4gd29ya19z
dHJ1Y3QgKndvcmspDQo+ID4gPiA+IA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ZGV2X2RiZyhkZXYsICIlczogbm8gc3RhIGZvdW5kXG4iLCBfX2Z1bmNfXyk7DQo+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsNCj4gPiA+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnRpbnVlOw0KPiA+ID4gPiAgICAgICAgICAgICAgICAgIH0NCj4gPiA+ID4gICAgICAg
ICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsNCj4gPiA+ID4gDQo+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgc2lnbmFsID0gaWVlZTgwMjExX2F2ZV9yc3NpKHZpZik7DQo+ID4gPiA+IA0KPiA+
ID4gPiAtICAgICAgICAgICAgICAgcHJpdi0+Zm9wcy0+cmVwb3J0X3Jzc2kocHJpdiwgMCwNCj4g
PiA+ID4gKyAgICAgICAgICAgICAgIHByaXYtPmZvcHMtPnJlcG9ydF9yc3NpKHByaXYsIHJ0bDh4
eHh1X2dldF9tYWNpZChwcml2LCBzdGEpLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJ0bDh4eHh1X3NpZ25hbF90b19zbnIoc2lnbmFsKSk7DQo+ID4g
PiA+IA0KPiA+ID4gPiAtICAgICAgICAgICAgICAgaWYgKHByaXYtPmZvcHMtPnNldF9jcnlzdGFs
X2NhcCkNCj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgcnRsOHh4eHVfdHJhY2tfY2Zv
KHByaXYpOw0KPiA+ID4gPiAtDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgcnRsOHh4eHVfcmVm
cmVzaF9yYXRlX21hc2socHJpdiwgc2lnbmFsLCBzdGEsIGZhbHNlKTsNCj4gPiA+IA0KPiA+ID4g
SXQgc2VlbXMgbGlrZSAnc3RhJyBpc24ndCBwcm90ZWN0ZWQgYnkgUkNVIHJlYWQgbG9jay4NCj4g
PiA+IChhbiBleGlzdGluZyBidWcsIG5vdCBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gpDQo+ID4g
DQo+ID4gSSB3aWxsIGFkZCBhIHBhdGNoIHdoaWNoIG1vdmVzIHRoZSByY3VfcmVhZF91bmxvY2so
KSB0byBmaXggdGhpcy4NCj4gDQo+IEFjdHVhbGx5LCBsb29raW5nIGF0IHRoZSBjb2RlIGFnYWlu
LCBydGw4eHh4dV9yZWZyZXNoX3JhdGVfbWFzaygpIHNlZW1zIHRvDQo+IGFscmVhZHkgY29udGFp
biBjYWxscyB0byByY3VfcmVhZF9sb2NrKCkuIEp1c3QgdGhlIGNhbGwgdG8NCj4gcnRsOHh4eHVf
Z2V0X21hY2lkKHByaXYsIHN0YSkgaW4gdGhlcmUgbWlnaHQgbmVlZCBhZGRpdGlvbmFsIHByb3Rl
Y3Rpb24uDQo+IA0KDQoNCldlIG11c3QgdXNlIFJDVSBsb2NrIHRvIHByb3RlY3QgJ3N0YScgZnJv
bSBkZXJlZmVyZW5jZSB0byB3aG9sZSBhY2Nlc3MsIGJ1dA0KaXQgbG9va3MgbGlrZQ0KDQpydGw4
eHh4dV93YXRjaGRvZ19jYWxsYmFjaygpDQoNCglyY3VfcmVhZF9sb2NrKCk7DQoJc3RhID0gLi4u
DQoJcmN1X3JlYWRfdW5sb2NrKCkgLy8gYWZ0ZXIgdGhpcyBwb2ludCwgdXNlICdzdGEnIGlzIHVu
c2FmZS4uDQoNCglydGw4eHh4dV9yZWZyZXNoX3JhdGVfbWFzayhzdGEpDQoJCXJjdV9yZWFkX2xv
Y2soKTsNCgkJcmF0ZV9iaXRtYXAgPSBzdGEtPi4uLiANCgkJcmN1X3JlYWRfdW5sb2NrKCk7DQoN
Cg0KDQoNCg0KDQo=

