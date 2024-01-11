Return-Path: <linux-wireless+bounces-1682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0C982A545
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 01:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCC71F22DED
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 00:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24AF38F;
	Thu, 11 Jan 2024 00:42:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEA636A
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 00:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40B0gBUU11320451, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40B0gBUU11320451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 08:42:18 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 11 Jan 2024 08:42:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 08:42:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Thu, 11 Jan 2024 08:42:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Viacheslav <adeep@lexina.in>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: =?utf-8?B?SmVybmVqIMWga3JhYmVj?= <jernej.skrabec@gmail.com>,
        "Martin
 Blumenstingl" <martin.blumenstingl@googlemail.com>
Subject: RE: rtw88: rtl8822cs AP mode not working
Thread-Topic: rtw88: rtl8822cs AP mode not working
Thread-Index: AQHaQ5OsSQGQ9nw7J0iwO3LVKmuk7LDSwwJA//+ZagCAAWoEsA==
Date: Thu, 11 Jan 2024 00:42:11 +0000
Message-ID: <0969b1ca039e423dbcc41de18db023c6@realtek.com>
References: <36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in>
 <11c7333aee0d45fd9fbfc65f6e2a3aa2@realtek.com>
 <216e8522-fa56-4d54-ae32-74c6008a2075@lexina.in>
In-Reply-To: <216e8522-fa56-4d54-ae32-74c6008a2075@lexina.in>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmlhY2hlc2xhdiA8YWRl
ZXBAbGV4aW5hLmluPg0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMTAsIDIwMjQgNzowNSBQ
TQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+OyBsaW51eC13aXJlbGVz
c0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEplcm5laiDFoGtyYWJlYyA8amVybmVqLnNrcmFiZWNA
Z21haWwuY29tPjsgTWFydGluIEJsdW1lbnN0aW5nbCA8bWFydGluLmJsdW1lbnN0aW5nbEBnb29n
bGVtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IHJ0dzg4OiBydGw4ODIyY3MgQVAgbW9kZSBub3Qg
d29ya2luZw0KPiANCj4gSGkhDQo+IA0KPiAxMC8wMS8yMDI0IDEyLjE1LCBQaW5nLUtlIFNoaWgg
d3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBG
cm9tOiBWaWFjaGVzbGF2IDxhZGVlcEBsZXhpbmEuaW4+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwg
SmFudWFyeSAxMCwgMjAyNCAzOjA3IFBNDQo+ID4+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtl
cm5lbC5vcmcNCj4gPj4gQ2M6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgSmVy
bmVqIMWga3JhYmVjIDxqZXJuZWouc2tyYWJlY0BnbWFpbC5jb20+OyBNYXJ0aW4gQmx1bWVuc3Rp
bmdsDQo+ID4+IDxtYXJ0aW4uYmx1bWVuc3RpbmdsQGdvb2dsZW1haWwuY29tPg0KPiA+PiBTdWJq
ZWN0OiBydHc4ODogcnRsODgyMmNzIEFQIG1vZGUgbm90IHdvcmtpbmcNCj4gPj4NCj4gPj4gSGVs
bG8hDQo+ID4+DQo+ID4+IFdlIHVzZSBSVEw4ODIyQ1MgbW9kdWxlcyBpbiBvdXIgZGV2aWNlcyBh
bmQgd2Ugc3dpdGNoZWQgdG8gcnR3ODggZnJvbSBhbg0KPiA+PiBleHRlcm5hbCBkcml2ZXIgYnkg
UmVhbHRlay4gU3VkZGVubHkgd2UgZGlzY292ZXJlZCB0aGF0IHRoZSBBUCBtb2RlDQo+ID4+ICho
b3RzcG90KSBzdG9wcGVkIHdvcmtpbmcuIFRoZSBob3RzcG90IGlzIHNldCB1cCwgYnV0IGl0IGRv
ZXMgbm90DQo+ID4+IGF1dGhvcml6ZSBjbGllbnQgY29ubmVjdGlvbnMuDQo+ID4+DQo+ID4+IElu
IGF0dGFjbWVudHMgbG9nIGFuZCBjb25maWcgZmlsZXMuDQo+ID4+DQo+ID4+IGNsaWVudCAtIG5v
dGVib29rIHdpdGggaXdsd2lmaSAwMDAwOjAwOjE0LjM6IERldGVjdGVkIEtpbGxlcihSKSBXaS1G
aSA2RQ0KPiA+PiBBWDE2NzVpIDE2ME1IeiBXaXJlbGVzcyBOZXR3b3JrIEFkYXB0ZXIgKDIxMU5H
VyksIFJFVj0weDM3MA0KPiA+Pg0KPiA+DQo+ID4gSXQgaXMgcHJvYmFibHkgYmVjYXVzZSBSVEw4
ODIyQ1MgZG9lc24ndCBpc3N1ZSBiZWFjb24gcHJvcGVybHkuIFRyeWluZyB0bw0KPiA+IGNhcHR1
cmUgYWlyIHBhY2tldHMgd2lsbCBiZSBoZWxwZnVsIHRvIGNsYXJpZnkgdGhlIHByb2JsZW0uDQo+
IA0KPiBhaXJkdW1wLW5nIHJlc3VsdCBpbiBhdHRhY2htZW50Lg0KPiBJIGRvbid0IHNlZSBhbnkg
Y2FwdHVyZWQgYmVhY29uIHBhY2tldHMuDQoNClNvLCB0aGF0IGlzIHRoZSBwcm9ibGVtLiBEaWQg
eW91IHNlZSBhbnkgd2VpcmQgbWVzc2FnZXMgaW4ga2VybmVsIGxvZyB3aGVuDQp5b3Ugd2VyZSBz
dGFydGluZyBob3N0YXBkPw0KDQoNCg==

