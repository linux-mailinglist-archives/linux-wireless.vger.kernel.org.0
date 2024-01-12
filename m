Return-Path: <linux-wireless+bounces-1761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F8A82B8AB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 01:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45E5285B7C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 00:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7237379;
	Fri, 12 Jan 2024 00:40:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028562D
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 00:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40C0dxP331999840, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40C0dxP331999840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 08:39:59 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 12 Jan 2024 08:39:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 08:39:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Fri, 12 Jan 2024 08:39:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Viacheslav <adeep@lexina.in>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
CC: =?utf-8?B?SmVybmVqIMWga3JhYmVj?= <jernej.skrabec@gmail.com>
Subject: RE: rtw88: rtl8822cs AP mode not working
Thread-Topic: rtw88: rtl8822cs AP mode not working
Thread-Index: AQHaQ5OsSQGQ9nw7J0iwO3LVKmuk7LDSwwJA//+ZagCAAWoEsP//2HAAgAG4OSA=
Date: Fri, 12 Jan 2024 00:39:59 +0000
Message-ID: <0be52db8941c4e609bfda6c69a14184e@realtek.com>
References: <36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in>
 <11c7333aee0d45fd9fbfc65f6e2a3aa2@realtek.com>
 <216e8522-fa56-4d54-ae32-74c6008a2075@lexina.in>
 <0969b1ca039e423dbcc41de18db023c6@realtek.com>
 <cc54a8b2-2fea-406c-8d4a-24ddfd34f983@lexina.in>
In-Reply-To: <cc54a8b2-2fea-406c-8d4a-24ddfd34f983@lexina.in>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

SGkgTWFydGluLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpYWNo
ZXNsYXYgPGFkZWVwQGxleGluYS5pbj4NCj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMTEsIDIw
MjQgMjoxOSBQTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+OyBsaW51
eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEplcm5laiDFoGtyYWJlYyA8amVybmVq
LnNrcmFiZWNAZ21haWwuY29tPjsgTWFydGluIEJsdW1lbnN0aW5nbCA8bWFydGluLmJsdW1lbnN0
aW5nbEBnb29nbGVtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IHJ0dzg4OiBydGw4ODIyY3MgQVAg
bW9kZSBub3Qgd29ya2luZw0KPiANCj4gMTEvMDEvMjAyNCAwMy40MiwgUGluZy1LZSBTaGloINC/
0LjRiNC10YI6DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
PiBGcm9tOiBWaWFjaGVzbGF2IDxhZGVlcEBsZXhpbmEuaW4+DQo+ID4+IFNlbnQ6IFdlZG5lc2Rh
eSwgSmFudWFyeSAxMCwgMjAyNCA3OjA1IFBNDQo+ID4+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hp
aEByZWFsdGVrLmNvbT47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiA+PiBDYzog
SmVybmVqIMWga3JhYmVjIDxqZXJuZWouc2tyYWJlY0BnbWFpbC5jb20+OyBNYXJ0aW4gQmx1bWVu
c3RpbmdsDQo+IDxtYXJ0aW4uYmx1bWVuc3RpbmdsQGdvb2dsZW1haWwuY29tPg0KPiA+PiBTdWJq
ZWN0OiBSZTogcnR3ODg6IHJ0bDg4MjJjcyBBUCBtb2RlIG5vdCB3b3JraW5nDQo+ID4+DQo+ID4+
IEhpIQ0KPiA+Pg0KPiA+PiAxMC8wMS8yMDI0IDEyLjE1LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
ID4+Pg0KPiA+Pj4NCj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZy
b206IFZpYWNoZXNsYXYgPGFkZWVwQGxleGluYS5pbj4NCj4gPj4+PiBTZW50OiBXZWRuZXNkYXks
IEphbnVhcnkgMTAsIDIwMjQgMzowNyBQTQ0KPiA+Pj4+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2Vy
Lmtlcm5lbC5vcmcNCj4gPj4+PiBDYzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+
OyBKZXJuZWogxaBrcmFiZWMgPGplcm5lai5za3JhYmVjQGdtYWlsLmNvbT47IE1hcnRpbiBCbHVt
ZW5zdGluZ2wNCj4gPj4+PiA8bWFydGluLmJsdW1lbnN0aW5nbEBnb29nbGVtYWlsLmNvbT4NCj4g
Pj4+PiBTdWJqZWN0OiBydHc4ODogcnRsODgyMmNzIEFQIG1vZGUgbm90IHdvcmtpbmcNCj4gPj4+
Pg0KPiA+Pj4+IEhlbGxvIQ0KPiA+Pj4+DQo+ID4+Pj4gV2UgdXNlIFJUTDg4MjJDUyBtb2R1bGVz
IGluIG91ciBkZXZpY2VzIGFuZCB3ZSBzd2l0Y2hlZCB0byBydHc4OCBmcm9tIGFuDQo+ID4+Pj4g
ZXh0ZXJuYWwgZHJpdmVyIGJ5IFJlYWx0ZWsuIFN1ZGRlbmx5IHdlIGRpc2NvdmVyZWQgdGhhdCB0
aGUgQVAgbW9kZQ0KPiA+Pj4+IChob3RzcG90KSBzdG9wcGVkIHdvcmtpbmcuIFRoZSBob3RzcG90
IGlzIHNldCB1cCwgYnV0IGl0IGRvZXMgbm90DQo+ID4+Pj4gYXV0aG9yaXplIGNsaWVudCBjb25u
ZWN0aW9ucy4NCj4gPj4+Pg0KPiA+Pj4+IEluIGF0dGFjbWVudHMgbG9nIGFuZCBjb25maWcgZmls
ZXMuDQo+ID4+Pj4NCj4gPj4+PiBjbGllbnQgLSBub3RlYm9vayB3aXRoIGl3bHdpZmkgMDAwMDow
MDoxNC4zOiBEZXRlY3RlZCBLaWxsZXIoUikgV2ktRmkgNkUNCj4gPj4+PiBBWDE2NzVpIDE2ME1I
eiBXaXJlbGVzcyBOZXR3b3JrIEFkYXB0ZXIgKDIxMU5HVyksIFJFVj0weDM3MA0KPiA+Pj4+DQo+
ID4+Pg0KPiA+Pj4gSXQgaXMgcHJvYmFibHkgYmVjYXVzZSBSVEw4ODIyQ1MgZG9lc24ndCBpc3N1
ZSBiZWFjb24gcHJvcGVybHkuIFRyeWluZyB0bw0KPiA+Pj4gY2FwdHVyZSBhaXIgcGFja2V0cyB3
aWxsIGJlIGhlbHBmdWwgdG8gY2xhcmlmeSB0aGUgcHJvYmxlbS4NCj4gPj4NCj4gPj4gYWlyZHVt
cC1uZyByZXN1bHQgaW4gYXR0YWNobWVudC4NCj4gPj4gSSBkb24ndCBzZWUgYW55IGNhcHR1cmVk
IGJlYWNvbiBwYWNrZXRzLg0KPiA+DQo+ID4gU28sIHRoYXQgaXMgdGhlIHByb2JsZW0uIERpZCB5
b3Ugc2VlIGFueSB3ZWlyZCBtZXNzYWdlcyBpbiBrZXJuZWwgbG9nIHdoZW4NCj4gPiB5b3Ugd2Vy
ZSBzdGFydGluZyBob3N0YXBkPw0KPiA+DQo+ID4NCj4gZG1lc2cvam91cm5hbGN0bCBpcyBjbGVh
bi4gTm8gbWVzc2FnZXMgcmVsYXRlZCB0byB3aWZpLg0KPiANCg0KSGF2ZSB5b3UgZXZlciB0cmll
ZCBBUCBtb2RlIG9uIFNESU8gaW50ZXJmYWNlIHdpZmkgY2FyZHMsIGxpa2UgUlRMODgyMkNTPyAN
Ckl0IHNlZW1zIG5vIGJlYWNvbiBpc3N1ZXMgcHJvcGVybHksIGJ1dCBubyBvYnZpb3VzIGVycm9y
cyBkdXJpbmcgc3RhcnRpbmcNCkFQIG1vZGUuIA0KDQpJIGRvbid0IGhhdmUgdGhpcyBraW5kIG9m
IHdpZmkgY2FyZHMsIGNvdWxkIHlvdSBoZWxwIHRvIGNoZWNrIGlmIEFQIG1vZGUNCndvcmtzIGlu
IHlvdXIgc2lkZT8NCg0KVGhhbmsgeW91DQpQaW5nLUtlIA0KDQoNCg==

