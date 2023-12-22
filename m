Return-Path: <linux-wireless+bounces-1220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CD881C7ED
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592131C221B5
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EB017745;
	Fri, 22 Dec 2023 10:12:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9006917748
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BMACYK202062186, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BMACYK202062186
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 18:12:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 22 Dec 2023 18:12:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 22 Dec 2023 18:12:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 22 Dec 2023 18:12:34 +0800
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
Thread-Index: AQHaNHUvpBpgdM0KL0yoZX5WUI+EHrC0gaBA///qhYCAAAWQAIAACUAAgAADjACAABDkgA==
Date: Fri, 22 Dec 2023 10:12:34 +0000
Message-ID: <395c025f511f95dabd9b2784af33ff5a311561e3.camel@realtek.com>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
	 <20231221164353.603258-14-martin.kaistra@linutronix.de>
	 <CAKFoaw3o-LkqADNvfE0TXmvr8_LK19mpVQtUZ66CWS=AN5AkJQ@mail.gmail.com>
	 <f71b29e17ff14ee9b28dd514a94cf1be@realtek.com>
	 <b8764bec-4dc6-4779-a3c3-d22e7d5acce9@linutronix.de>
	 <f3949264-c530-43e1-a528-eedcc2b31d0d@linutronix.de>
	 <bbe5babe03b7b23c988af9ce8777df0d5302592b.camel@realtek.com>
	 <1bf08ae7-84bf-432f-93e9-c97c6deca5ba@linutronix.de>
In-Reply-To: <1bf08ae7-84bf-432f-93e9-c97c6deca5ba@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <095DC8B3ECBA3449B6DA69E3E6DBBFE7@realtek.com>
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

T24gRnJpLCAyMDIzLTEyLTIyIGF0IDEwOjEwICswMTAwLCBNYXJ0aW4gS2Fpc3RyYSB3cm90ZToN
Cj4gDQo+IEFtIDIyLjEyLjIzIHVtIDA5OjU5IHNjaHJpZWIgUGluZy1LZSBTaGloOg0KPiA+IE9u
IEZyaSwgMjAyMy0xMi0yMiBhdCAwOToyNSArMDEwMCwgTWFydGluIEthaXN0cmEgd3JvdGU6DQo+
ID4gPiBBbSAyMi4xMi4yMyB1bSAwOTowNSBzY2hyaWViIE1hcnRpbiBLYWlzdHJhOg0KPiA+ID4g
PiBBbSAyMi4xMi4yMyB1bSAwMjo0NSBzY2hyaWViIFBpbmctS2UgU2hpaDoNCj4gPiA+ID4gPiBP
biBGcmksIERlYyAyMiwgMjAyMyBhdCAxMjo0NeKAr0FNIE1hcnRpbiBLYWlzdHJhDQo+ID4gPiA+
ID4gPG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPiA+ID4gPiA+ID4gQ2hl
Y2sgZmlyc3Qgd2hldGhlciBwcml2LT52aWZzWzBdIGV4aXN0cyBhbmQgaXMgb2YgdHlwZSBTVEFU
SU9OLCB0aGVuIGdvDQo+ID4gPiA+ID4gPiB0byBwcml2LT52aWZzWzFdLiBNYWtlIHN1cmUgdG8g
Y2FsbCByZWZyZXNoX3JhdGVfbWFzayBmb3IgYm90aA0KPiA+ID4gPiA+ID4gaW50ZXJmYWNlcy4N
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gLSAgICAgICBpZiAodmlmICYmIHZpZi0+dHlwZSA9
PSBOTDgwMjExX0lGVFlQRV9TVEFUSU9OKSB7DQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAg
ICBpbnQgc2lnbmFsOw0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgc3RydWN0IGllZWU4
MDIxMV9zdGEgKnN0YTsNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQEAgLTcyMTUsMjIgKzcy
MTksMjEgQEAgc3RhdGljIHZvaWQgcnRsOHh4eHVfd2F0Y2hkb2dfY2FsbGJhY2soc3RydWN0DQo+
ID4gPiA+ID4gPiB3b3JrX3N0cnVjdCAqd29yaykNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfZGJnKGRldiwgIiVzOiBubyBzdGEgZm91bmRc
biIsIF9fZnVuY19fKTsNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmN1
X3JlYWRfdW5sb2NrKCk7DQo+ID4gPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICBnb3Rv
IG91dDsNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+
ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgfQ0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAg
ICAgcmN1X3JlYWRfdW5sb2NrKCk7DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgIHNpZ25hbCA9IGllZWU4MDIxMV9hdmVfcnNzaSh2aWYpOw0KPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiAtICAgICAgICAgICAgICAgcHJpdi0+Zm9wcy0+cmVwb3J0X3Jzc2kocHJp
diwgMCwNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBwcml2LT5mb3BzLT5yZXBvcnRfcnNz
aShwcml2LCBydGw4eHh4dV9nZXRfbWFjaWQocHJpdiwgc3RhKSwNCj4gPiA+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJ0bDh4eHh1X3NpZ25hbF90b19z
bnIoc2lnbmFsKSk7DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IC0gICAgICAgICAgICAgICBp
ZiAocHJpdi0+Zm9wcy0+c2V0X2NyeXN0YWxfY2FwKQ0KPiA+ID4gPiA+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgcnRsOHh4eHVfdHJhY2tfY2ZvKHByaXYpOw0KPiA+ID4gPiA+ID4gLQ0KPiA+
ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgcnRsOHh4eHVfcmVmcmVzaF9yYXRlX21hc2socHJp
diwgc2lnbmFsLCBzdGEsIGZhbHNlKTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJdCBzZWVtcyBs
aWtlICdzdGEnIGlzbid0IHByb3RlY3RlZCBieSBSQ1UgcmVhZCBsb2NrLg0KPiA+ID4gPiA+IChh
biBleGlzdGluZyBidWcsIG5vdCBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gpDQo+ID4gPiA+IA0K
PiA+ID4gPiBJIHdpbGwgYWRkIGEgcGF0Y2ggd2hpY2ggbW92ZXMgdGhlIHJjdV9yZWFkX3VubG9j
aygpIHRvIGZpeCB0aGlzLg0KPiA+ID4gDQo+ID4gPiBBY3R1YWxseSwgbG9va2luZyBhdCB0aGUg
Y29kZSBhZ2FpbiwgcnRsOHh4eHVfcmVmcmVzaF9yYXRlX21hc2soKSBzZWVtcyB0bw0KPiA+ID4g
YWxyZWFkeSBjb250YWluIGNhbGxzIHRvIHJjdV9yZWFkX2xvY2soKS4gSnVzdCB0aGUgY2FsbCB0
bw0KPiA+ID4gcnRsOHh4eHVfZ2V0X21hY2lkKHByaXYsIHN0YSkgaW4gdGhlcmUgbWlnaHQgbmVl
ZCBhZGRpdGlvbmFsIHByb3RlY3Rpb24uDQo+ID4gPiANCj4gPiANCj4gPiBXZSBtdXN0IHVzZSBS
Q1UgbG9jayB0byBwcm90ZWN0ICdzdGEnIGZyb20gZGVyZWZlcmVuY2UgdG8gd2hvbGUgYWNjZXNz
LCBidXQNCj4gPiBpdCBsb29rcyBsaWtlDQo+ID4gDQo+ID4gcnRsOHh4eHVfd2F0Y2hkb2dfY2Fs
bGJhY2soKQ0KPiA+IA0KPiA+ICAgICAgIHJjdV9yZWFkX2xvY2soKTsNCj4gPiAgICAgICBzdGEg
PSAuLi4NCj4gPiAgICAgICByY3VfcmVhZF91bmxvY2soKSAvLyBhZnRlciB0aGlzIHBvaW50LCB1
c2UgJ3N0YScgaXMgdW5zYWZlLi4NCj4gPiANCj4gPiAgICAgICBydGw4eHh4dV9yZWZyZXNoX3Jh
dGVfbWFzayhzdGEpDQo+ID4gICAgICAgICAgICAgICByY3VfcmVhZF9sb2NrKCk7DQo+ID4gICAg
ICAgICAgICAgICByYXRlX2JpdG1hcCA9IHN0YS0+Li4uDQo+ID4gICAgICAgICAgICAgICByY3Vf
cmVhZF91bmxvY2soKTsNCj4gPiANCj4gPiANCj4gSWYgaXQgaXMgbm90IGFuIGVhc3kgZml4LCBk
b2VzIGl0IG1ha2Ugc2Vuc2UgdG8geW91IHRvIGRvIHRoaXMgYWxzbyBzZXBhcmF0ZWx5DQo+IGZy
b20gdGhpcyBzZXJpZXM/DQoNClN1cmUuIEFzIEkgc2FpZCwgdGhpcyBpc24ndCBpbnRyb2R1Y2Vk
IGJ5IHRoaXMgcGF0Y2hzZXQuIFdlIGNhbiBmaXggaXQgbGF0ZXIuDQoNCg0K

