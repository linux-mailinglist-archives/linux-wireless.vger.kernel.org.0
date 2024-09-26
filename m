Return-Path: <linux-wireless+bounces-13213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9557A986AF1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 04:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B144B24A63
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 02:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F551714CB;
	Thu, 26 Sep 2024 02:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="MszYosL/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7464D37B
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727317659; cv=none; b=ByXsu6AgRzkgI5q7r7Rqx5lWZTETSgDJKeB7VIquYxZwnix5a5pc/frqwtcyNk39gL3iQXMtZts6+uGSenYi21aPqmZudpig9aEOVkYlYvCz28sOYyTw7AsAVuOUTZ12R5F0zyJjYo+SYeRrF2raCzCUr9t6Hvbk3AQmSYM4aKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727317659; c=relaxed/simple;
	bh=csN8UahhTty6xcC/xkTCDu2S28VKd0ZH2di3n5lTD0w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kycykPgTLeqHwSFa5inCjPkaCpEzrJwPb9AO+2XFWtQ7blo/nsdOb1R5TFOGc8li/JiV7w9jAwDkvgdCOwQb8jt6jjwuwe4H+/Xz8Ui9sZjpEWdhTVUSklV3NEF+HAQ8Pmpxs+E34rzJiUO5Xc9I8mK/1ovcfApIBixjjvRfJFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=MszYosL/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48Q2RWg141306034, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727317652; bh=csN8UahhTty6xcC/xkTCDu2S28VKd0ZH2di3n5lTD0w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=MszYosL/tRya8eP1gADo/oZl20W3ZTbUtQWh7NJkFjKc6w8Q60Q5yBQgomQNCRM5M
	 Hiqo7ZDa83VdWzAx6jF2lKbq2qAlQ57PzeMOVE5Uf4wivT22gxg+InoEdfDISwkSHj
	 jHJ8kvDMRhmYoZWfX0WRep/MeOgrwkFYM8oa9SBERcycZMqg0+gfW3YTKvlcBqSbPh
	 Sv3zuJJpNcq24iuBDv4djvHDp9+J9jXoi2MOBKZHPt0ghzvbjP5GN19tdLe6KlECz7
	 cDHrX6/JdYsRQAiYGTDW4wsSrL88cKmc87z9+TUFUof2Goz13oYubf8DtVpecDLXDx
	 hC09/Ze3DcBzA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48Q2RWg141306034
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 10:27:32 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 10:27:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 26 Sep 2024 10:27:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 26 Sep 2024 10:27:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 18/20] wifi: rtw88: Add rtw8821a.{c,h}
Thread-Topic: [PATCH 18/20] wifi: rtw88: Add rtw8821a.{c,h}
Thread-Index: AQHa7DKP0miyRAHIW0qWSqezSXaH97IpJM5AgBHQWoCAFW7yIIADltQAgAEjSvCADXPMAIACikGAgAIUIQCAAMkHgIAAJEgAgAF+58A=
Date: Thu, 26 Sep 2024 02:27:32 +0000
Message-ID: <1e27a798215e4a5299f4ed27dca7413c@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <f25d00ab-4481-4540-956b-bc1028a501e1@gmail.com>
 <e365c61d730d4f49915b543dcb0063d5@realtek.com>
 <dafaac0c-fb55-4406-b8ff-69aa66d3fd06@gmail.com>
 <1aca96c68f914f90b6d1baf8780e6ce4@realtek.com>
 <bebaa40a-1c7a-4b1e-99cd-7c7aac7c76f4@gmail.com>
 <f583e9470ca84234ad2e00f3a0371664@realtek.com>
 <38553e79-6747-4ab3-9bf4-fa7f2af852cd@gmail.com>
 <73de8e7135554ae9a0f7968780644515@realtek.com>
 <b4c9ff5c-a8ca-401f-aa79-3798239ffd57@gmail.com>
 <9c991498a48043d0b0b06dc05356cbae@realtek.com>
 <d621b3ed-86f5-40d4-b826-79615a2def6e@gmail.com>
In-Reply-To: <d621b3ed-86f5-40d4-b826-79615a2def6e@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAy
NS8wOS8yMDI0IDA0OjI1LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBPbiAyMy8wOS8yMDI0IDA4
OjQ3LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+PiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIx
Y2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+Pj4+Pj4+Pj4gKw0KPiA+Pj4+Pj4+Pj4+ICtj
b25zdCBzdHJ1Y3QgcnR3X2NoaXBfaW5mbyBydHc4ODEyYV9od19zcGVjID0gew0KPiA+Pj4+Pj4+
Pj4NCj4gPj4+Pj4+Pj4+IElzIGl0IHBvc3NpYmxlIG1vdmluZyA4ODEyYSB0byBpbmRpdmlkdWFs
IGZpbGU/DQo+ID4+Pj4+Pj4+PiBTaW5jZSB5b3UgaGF2ZSBydHc4ODEyYXUuYyBhbmQgcnR3ODgy
MWF1LmMuDQo+ID4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBJIHRoaW5rIGl0IGlz
IHBvc3NpYmxlLiBCdXQgbW9zdCBvZiB0aGUgY29kZSBpcyBjb21tb24gdG8gYm90aCBjaGlwcy4N
Cj4gPj4+Pj4+Pj4gT25seSB0aGUgSVEgY2FsaWJyYXRpb24gY291bGQgYmUgbW92ZWQuDQo+ID4+
Pj4+Pj4NCj4gPj4+Pj4+PiBZZXAsIGRlcGVuZCBvbiBob3cgbXVjaCBJUUsgY29kZSBlY2hvIGNo
aXAgaGFzLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gVGhlIElRIGNhbGlicmF0aW9u
IGZvciBSVEw4ODEyQVUgaXMgYWJvdXQgNzAwIGxpbmVzLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBydHc4
ODEyYXUgIC0tLS0tPiAoYSkgcnR3ODgxMmENCj4gPj4+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgfA0KPiA+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICB2DQo+ID4+Pj4+ICAgICAgICAg
ICAgICAgICAgIChiKSBydHc4ODIxYV9jb21tb24gIChoYXJkIHRvIGdpdmUgYSBuYW1lKQ0KPiA+
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+ID4+Pj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgIHwNCj4gPj4+Pj4gcnR3ODgyMWF1ICAtLS0tLT4gKGMpIHJ0dzg4MjFhDQo+ID4+Pj4+
DQo+ID4+Pj4+IFB1dCBhbGwgY29tbW9uIGNvZGUgdG8gKGIpLiBJUUsgY29kZSBpbiAoYSkgb3Ig
KGMpLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBJIGZlZWwgeW91IGhhdmUgdGhvdWdodCBhYm92ZSBwaWN0
dXJlIGFscmVhZHkuIFdoYXQgYXJlIHByb2JsZW1zIHdlIHdpbGwgZW5jb3VudGVyPw0KPiA+Pj4+
PiBNYW55IGV4cG9ydCBzeW1ib2xzPyBJZiBzbywgaG93IGFib3V0IGJlbG93Pw0KPiA+Pj4+Pg0K
PiA+Pj4+PiBydHc4ODEyYXUgIC0tLS0tPiAoMSkgcnR3ODgxMmENCj4gPj4+Pj4gICAgICstLS0t
LS0tLS0rDQo+ID4+Pj4+ICAgICAgICAgICAgICAgKy0+ICgyKSBydHc4ODIxYV9jb21tb24gICho
YXJkIHRvIGdpdmUgYSBuYW1lKQ0KPiA+Pj4+PiAgICAgKy0tLS0tLS0tLSsNCj4gPj4+Pj4gcnR3
ODgyMWF1ICAtLS0tLT4gKDMpIHJ0dzg4MjFhDQo+ID4+Pj4+DQo+ID4+Pj4+IFB1dCBydHc4ODEy
YV9od19zcGVjIGFuZCBydHc4ODIxYV9od19zcGVjIGluICgyKS4gT25seSBJUUsgY29kZSBpbiAo
MSkgYW5kICgzKQ0KPiA+Pj4+PiByZXNwZWN0aXZlbHksIGFuZCBleHBvcnQgSVFLIGVudHJ5IG9u
bHkuIERvZXMgaXQgd29yaz8NCj4gPj4+Pj4NCj4gPj4+Pj4NCj4gPj4+PiBGb3IgdGhlIG5hbWUg
b2YgdGhlIGNvbW1vbiBtb2R1bGUsIEkgd2FzIHRoaW5raW5nIHJ0dzg4Xzg4eHhhLmtvLg0KPiA+
Pj4+DQo+ID4+Pj4gSSB3b25kZXIsIHdoYXQgaXMgdGhlIGdvYWw/IFRvIHB1dCB0aGUgY29kZSBp
biBzZXBhcmF0ZSBrZXJuZWwNCj4gPj4+PiBtb2R1bGVzLCBvciBqdXN0IHNlcGFyYXRlIGZpbGVz
Pw0KPiA+Pj4NCj4gPj4+IEkgd291bGQgbGlrZSB0byByZWR1Y2UgcnVudGltZSBtZW1vcnkuIEFz
IEkgYXNrZWQsIGhvdyBtYW55IElRSyBjb2RlIGFyZSBkaWZmZXJlbnQNCj4gPj4+IGZyb20gdGhl
bT8gSWYgeW91IGhhdmUgc2VwYXJhdGVkIGFuZCBjb21waWxlZCB0aGVtLCBjYW4geW91IHNoYXJl
IHNpemUgYnkgdGhlDQo+ID4+PiBvdXRwdXQgb2YgJ3NpemUnIGNvbW1hbmQ/DQo+ID4+Pg0KPiA+
Pg0KPiA+PiBJIHNlcGFyYXRlZCB0aGUgSVFLIGNvZGUgaW50byB0d28gZmlsZXMgKHN0aWxsIGp1
c3Qgb25lIG1vZHVsZSkuDQo+ID4+IHNpemUgc2F5czoNCj4gPj4NCj4gPj4gICAgdGV4dCAgICBk
YXRhICAgICBic3MgICAgIGRlYyAgICAgaGV4IGZpbGVuYW1lDQo+ID4+ICAgIDcxOTIgICAgICAz
MiAgICAgICAwICAgIDcyMjQgICAgMWMzOCBydHc4ODIxYS1pcWsubw0KPiA+PiAgIDEyMzE5ICAg
ICAgNDAgICAgICAgMCAgIDEyMzU5ICAgIDMwNDcgcnR3ODgxMmEtaXFrLm8NCj4gPj4NCj4gPj4g
VGhpcyBpcyB4ODZfNjQuDQo+ID4+DQo+ID4+Pj4NCj4gPj4+PiBJIHRoaW5rIHdlIGNhbiBoYXZl
IHJ0dzg4eHhhLmMgKGNvbW1vbiBjb2RlKSwgcnR3ODgyMWEuYyAoSVFLIGNvZGUsDQo+ID4+Pj4g
cnR3ODgyMWFfaHdfc3BlYywgYmx1ZXRvb3RoIHN0dWZmKSwgYW5kIHJ0dzg4MTJhLmMgKElRSyBj
b2RlLA0KPiA+Pj4+IHJ0dzg4MTJhX2h3X3NwZWMsIHNvbWUgZWZ1c2Ugc3R1ZmYsIGNoYW5uZWwg
c3dpdGNoaW5nKS4uLiBpZiB0aGVzZQ0KPiA+Pj4+IHRocmVlIGZpbGVzIGNvbXBpbGUgaW50byBh
IHNpbmdsZSBtb2R1bGUsIHJ0dzg4Xzg4eHhhLmtvLg0KPiA+Pj4+DQo+ID4+Pj4gSWYgZWFjaCBm
aWxlIGNvbXBpbGVzIGludG8gYSBtb2R1bGUgb2YgaXRzIG93biwgd2UgaGF2ZSBjaXJjdWxhcg0K
PiA+Pj4+IGRlcGVuZGVuY2llczogcnR3ODgyMWFfaHdfc3BlYyAtPiBjb21tb24gY29kZSAtPiBJ
UUsgY29kZS4NCj4gPj4+PiBJZiAqX2h3X3NwZWMgZ28gaW4gdGhlIGNvbW1vbiBtb2R1bGUsIGl0
IHN0aWxsIGRlcGVuZHMgb24gYm90aCBvZg0KPiA+Pj4+IHRoZSBvdGhlciB0d28gbW9kdWxlcywg
c28gd2hhdCB1c2UgaXMgaXQ/DQo+ID4+Pg0KPiA+Pj4gSWYgd2UgaGF2ZSBkZXBlbmRlbmN5IG9m
IGNvbW1vbiBjb2RlIC0+IElRSyBjb2RlLCB3ZSBjYW4ndCBzYXZlIHJ1bnRpbWUNCj4gPj4+IG1l
bW9yeSwgYmVjYXVzZSBjb21tb24gY29kZSByZWZlcmVuY2UgdG8gYm90aCBJUUsgY29kZS4gU28g
SSBmZWx0DQo+ID4+PiBkZXBlbmRlbmN5IG9mIElRSyBjb2RlIHdvdWxkIGJlIHJ0dzg4MTJhdSAt
LT4gSVFLIGNvZGUgYXMgYWJvdmUgc2Vjb25kDQo+ID4+PiBkaWFncmFtLg0KPiA+Pj4NCj4gPj4+
IEJ1dCBpZiB0aGUgd29yayBpcyBjb21wbGljYXRlZCBhbmQgc2F2ZSBub3QgZmV3IHJ1bnRpbWUg
bWVtb3J5LCB3ZSBjYW4NCj4gPj4+IHVzZSBzaW1wbGUgZGVzaWduIGFzIGN1cnJlbnQgZGlkLg0K
PiA+Pj4NCj4gPj4+DQo+ID4+DQo+ID4+IFRoZSBJUUsgY29kZSBjYW4gYmUgc2VwYXJhdGVkIGlu
dG8gZGlmZmVyZW50IG1vZHVsZXMgaWYgSSBkdXBsaWNhdGUNCj4gPj4gcnR3ODgyMWFfb3BzIGFu
ZCBydHc4ODIxYV9wd3JfdHJhY2ssIGFuZCBydHc4ODIxYV9waHlfcHdydHJhY2sgdGFrZXMNCj4g
Pj4gYSBwb2ludGVyIHRvIHRoZSBJUUsgZnVuY3Rpb24uIFRoZW4geW91ciBmaXJzdCBkaWFncmFt
IGFib3ZlIGNhbiB3b3JrLg0KPiA+DQo+ID4gTm90IHN1cmUgdGhlICJkdXBsaWNhdGUiIHlvdSBt
ZWFudC4gSWYgaXQgb25seSBhIHN0cnVjdCwgdGhhdCB3b3VsZCBiZSBmaW5lLg0KPiA+IE5vdCBw
cmVmZXIgZHVwbGljYXRlIG9mIHRhYmxlcy4NCj4gPg0KPiANCj4gWWVzLCBpdCdzIGEgc3RydWN0
IHJ0d19jaGlwX29wcy4NCj4gDQo+ID4+DQo+ID4+IFRoZSB0YWJsZXMgYWxzbyB0YWtlIHVwIGEg
Yml0IG9mIHNwYWNlOg0KPiA+Pg0KPiA+PiAgIHRleHQgICAgZGF0YSAgICAgYnNzICAgICBkZWMg
ICAgIGhleCBmaWxlbmFtZQ0KPiA+PiAgIDE2ODMyICAgICAgIDAgICAgICAgMCAgIDE2ODMyICAg
IDQxYzAgcnR3ODgyMWFfdGFibGUubw0KPiA+PiAgIDIxNTUyICAgICAgIDAgICAgICAgMCAgIDIx
NTUyICAgIDU0MzAgcnR3ODgxMmFfdGFibGUubw0KPiA+DQo+ID4gR29vZCBwb2ludC4NCj4gPg0K
PiA+Pg0KPiA+PiBJIGRvbid0IGtub3cgaG93IG1hbnkga2lsb2J5dGVzIGlzIGVub3VnaCB0byBt
YWtlIGl0IHdvcnRoDQo+ID4+IGNyZWF0aW5nIHR3byBtb3JlIG1vZHVsZXMuDQo+ID4NCj4gPiBJ
IHRoaW5rIHdlIGNhbiBsaXN0IGFsbCAqLm8gcmVsYXRlZCB0byBydHc4ODIxYS84ODEyYSwgYW5k
IGNoZWNrIHRoZQ0KPiA+IHBlcmNlbnRhZ2UgdG8gbWFrZSBkZWNpc2lvbnMuIEkgbWVhbiBpZiBp
dCBvY2N1cGllcyA1MCUsIEkgd2lsbCBwcmVmZXINCj4gPiB0byBoYXZlIHNlcGFyYXRlZCBtb2R1
bGUuIEJ1dCBJIGRvbid0IGhhdmUgYW4gZXhhY3QgbnVtYmVyIG5vdy4NCj4gPg0KPiANCj4gICAg
dGV4dCAgICBkYXRhICAgICBic3MgICAgIGRlYyAgICAgaGV4IGZpbGVuYW1lDQo+ICAgMTIzMTkg
ICAgICA0MCAgICAgICAwICAgMTIzNTkgICAgMzA0NyBydHc4ODEyYS1pcWsubw0KPiAgIDIxNTUy
ICAgICAgIDAgICAgICAgMCAgIDIxNTUyICAgIDU0MzAgcnR3ODgxMmFfdGFibGUubw0KPiAgICA3
MTkyICAgICAgMzIgICAgICAgMCAgICA3MjI0ICAgIDFjMzggcnR3ODgyMWEtaXFrLm8NCj4gICAx
NjgzMiAgICAgICAwICAgICAgIDAgICAxNjgzMiAgICA0MWMwIHJ0dzg4MjFhX3RhYmxlLm8NCj4g
ICAyOTQ0NSAgICAgNDI5ICAgICAgIDAgICAyOTg3NCAgICA3NGIyIHJ0dzg4MjFhLm8NCj4gPT09
PT09PT09DQo+ICAgODczNDAgdG90YWwuIFNvIGl0J3MgYWJvdXQgMzglIGZvciA4ODEyYSBhbmQg
MjclIGZvciA4ODIxYS4NCj4gTWF5YmUgYSBiaXQgbW9yZSBpbiB0aGUgZmluYWwgdmVyc2lvbi4N
Cg0KY2hpcCAgICBzZXBhcmF0ZWQoYSkgICBzaW5nbGUgb25lKGIpICAgaW5jcmVhc2UgcmF0ZShj
KQ0KLS0tLS0gICAtLS0tLS0tLS0tLS0gICAtLS0tLS0tLS0tLS0tICAgLS0tLS0tLS0tLS0tLS0t
LQ0KODgxMmEgICA2Myw3ODUgICAgICAgICA4Nyw4NDEgICAgICAgICAgMzglDQo4ODIxYSAgIDUz
LDkzMCAgICAgICAgIDg3LDg0MSAgICAgICAgICA2MyUNCg0KKiBpbmNyZWFzZSByYXRlIChjKSA9
IChiIC0gYSkgLyBhDQoNClNpbmNlIGluY3JlYXNpbmcgcmF0ZSBvZiA4ODIxYSBpcyA2MyUsIEkg
ZmVlbCBzZXBhcmF0ZWQgY2FzZSB3b3VsZCBiZSBiZXR0ZXIuIA0KDQoNCg==

