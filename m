Return-Path: <linux-wireless+bounces-2071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0615E82FE05
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 01:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C63EAB23072
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 00:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724244A19;
	Wed, 17 Jan 2024 00:36:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5F03FDC
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705451780; cv=none; b=hsXcpsbcO5AG66SRhAAiPlk2Zb2ll6p5UpIxgT/yqao++k0GSQXjqT2jwZ9QxShh9OV3duInbk3LbpxOcz0I7pMY9igNVZGCvovWXId+53jRQskAgrYQ/xa+ekwGYQIuhdrx0jJ/Ot0ZzSNhA73Oz/x5Qf/HGf5Xeo5oFQ+ib7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705451780; c=relaxed/simple;
	bh=6133weSQLTdTQy2kQzQ4UHunuzcCpgMu20kKLbkreAk=;
	h=X-SpamFilter-By:Received:Received:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:x-originating-ip:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-KSE-ServerInfo:X-KSE-AntiSpam-Interceptor-Info:
	 X-KSE-Antivirus-Interceptor-Info:X-KSE-AntiSpam-Interceptor-Info;
	b=ThcQUyH1x9DwRTkkx/sCcEG0NVNqN+BbzkY/FQr/DApDs3BYzWaYshwWcACFGY20LpZY42qn6LHDkY70iyj5+jXtfJl6STB3cIlPtFq7+IenHO8G/mpcUXoDoDGwpdPd3QZjTv7aENqXccZ70JrNH5Gn+hSh4FxN0d5vSqukp2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40H0ZhYO2523573, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40H0ZhYO2523573
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 08:35:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Wed, 17 Jan 2024 08:35:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 08:35:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Wed, 17 Jan 2024 08:35:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Viacheslav
	<adeep@lexina.in>, Sascha Hauer <s.hauer@pengutronix.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?SmVybmVqIMWga3JhYmVj?= <jernej.skrabec@gmail.com>
Subject: RE: rtw88: rtl8822cs AP mode not working
Thread-Topic: rtw88: rtl8822cs AP mode not working
Thread-Index: AQHaQ5OsSQGQ9nw7J0iwO3LVKmuk7LDSwwJA//+ZagCAAWoEsP//2HAAgAG4OSCAAoFvAIACTpowgAJcWgCAAK8A4A==
Date: Wed, 17 Jan 2024 00:35:42 +0000
Message-ID: <fe8cd87ad7dd43ecb41613530386dff4@realtek.com>
References: <36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in>
 <11c7333aee0d45fd9fbfc65f6e2a3aa2@realtek.com>
 <216e8522-fa56-4d54-ae32-74c6008a2075@lexina.in>
 <0969b1ca039e423dbcc41de18db023c6@realtek.com>
 <cc54a8b2-2fea-406c-8d4a-24ddfd34f983@lexina.in>
 <0be52db8941c4e609bfda6c69a14184e@realtek.com>
 <CAFBinCDT2Pj_BYqCtk+i7y8LPU2qwah-4Scdq29ONBqs3wt0pQ@mail.gmail.com>
 <8192e59807e14525b821317a5f550ea4@realtek.com>
 <CAFBinCBf2XM-W8-_YEGXydy4kLHHar7Fv5=GoKddjE9f0hTkAw@mail.gmail.com>
In-Reply-To: <CAFBinCBf2XM-W8-_YEGXydy4kLHHar7Fv5=GoKddjE9f0hTkAw@mail.gmail.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

KyBTYXNjaGEgZm9yIHF1ZXN0aW9uIDMpDQoNCihubyBvdGhlciBjb21tZW50cyBmb3Igbm93KQ0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcnRpbiBCbHVtZW5zdGlu
Z2wgPG1hcnRpbi5ibHVtZW5zdGluZ2xAZ29vZ2xlbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgSmFudWFyeSAxNywgMjAyNCA2OjA3IEFNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEBy
ZWFsdGVrLmNvbT47IFZpYWNoZXNsYXYgPGFkZWVwQGxleGluYS5pbj4NCj4gQ2M6IGxpbnV4LXdp
cmVsZXNzQHZnZXIua2VybmVsLm9yZzsgSmVybmVqIMWga3JhYmVjIDxqZXJuZWouc2tyYWJlY0Bn
bWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBydHc4ODogcnRsODgyMmNzIEFQIG1vZGUgbm90IHdv
cmtpbmcNCj4gDQo+IEhpIFBpbmctS2UgYW5kIFZpYWNoZXNsYXYsDQo+IA0KPiBPbiBNb24sIEph
biAxNSwgMjAyNCBhdCAzOjE34oCvQU0gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+
IHdyb3RlOg0KPiBbLi4uXQ0KPiA+ID4gPiBJIGRvbid0IGhhdmUgdGhpcyBraW5kIG9mIHdpZmkg
Y2FyZHMsIGNvdWxkIHlvdSBoZWxwIHRvIGNoZWNrIGlmIEFQIG1vZGUNCj4gPiA+ID4gd29ya3Mg
aW4geW91ciBzaWRlPw0KPiA+ID4gSSdsbCBjaGVjayB0aGF0IGluIHRoZSBuZXh0IGZldyBkYXlz
Lg0KPiBBUCBtb2RlIGlzIGFsc28gbm90IHdvcmtpbmcgZm9yIG1lLCBJIGdldCB0aGUgc2FtZSBw
cm9ibGVtIGFzDQo+IFZpYWNoZXNsYXYgcmVwb3J0ZWQuDQo+IA0KPiA+ID4gQWxzbyBJJ20gd29u
ZGVyaW5nIHdoZXJlIGNvZGUgZW5hYmxlcyBiZWFjb25zIChpcyBpdA0KPiA+ID4gcnR3X2NvcmVf
ZW5hYmxlX2JlYWNvbigpIG9yIGlzIHRoZXJlIGFub3RoZXIgcmVsZXZhbnQgZnVuY3Rpb24/KS4N
Cj4gPiA+IEtub3dpbmcgdGhhdCB3b3VsZCBiZSBoZWxwZnVsIHRvIGFuYWx5emUgdGhpcyBmdXJ0
aGVyLg0KPiA+DQo+ID4gVGhlIG1haW4gZnVuY3Rpb24gdG8gZ2V0IGFuZCBzZXQgYmVhY29uIHRl
bXBsYXRlIHRvIGZpcm13YXJlIGlzDQo+ID4gcnR3X2Z3X2Rvd25sb2FkX3JzdmRfcGFnZSgpLiBU
aGUgYmFzaWMgY29uY2VwdCBpcyB0byBwdXQgYmVhY29uIGZyYW1lIHZpYQ0KPiA+IHFzZWw9QkNO
IHRvIGEgc3BlY2lhbCBUWCBGSUZPIGFyZWEgY2FsbGVkICJyZXNlcnZlIHBhZ2UiLCBhbmQgdGhl
bg0KPiA+IGhhcmR3YXJlL2Zpcm13YXJlIHdpbGwgc2VuZCBiZWFjb24gaW4gaW50ZXJ2YWwgb2Yg
MTAwbXMuDQo+IFRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0aW9uIC0gdGhhdCBoZWxwZWQgbWUgZmlu
ZCBhIGJldHRlciBzdGFydGluZyBwb2ludCENCj4gDQo+IEkgZGlkbid0IGhhdmUgbXVjaCB0aW1l
IGluIHRoZSBwYXN0IGZldyBkYXlzLCBidXQgSSBoYXZlIHNvbWUgZmluZGluZ3MNCj4gYW5kIHF1
ZXN0aW9uczoNCj4gMSkgSSBmb3VuZCB0aGUgZm9sbG93aW5nIGNvbW1lbnQvY29kZSBpbiB0aGUg
ZG93bnN0cmVhbSBkcml2ZXIgWzBdOg0KPiAvKg0KPiAgKiBEaXNhYmxlIEh3IHByb3RlY3Rpb24g
Zm9yIGEgdGltZSB3aGljaCByZXZzZXJkIGZvciBIdyBzZW5kaW5nIGJlYWNvbi4NCj4gICogRml4
IGRvd25sb2FkIHJlc2VydmVkIHBhZ2UgcGFja2V0IGZhaWwgdGhhdCBhY2Nlc3MgY29sbGlzaW9u
IHdpdGgNCj4gdGhlIHByb3RlY3Rpb24gdGltZS4NCj4gICovDQo+IHZhbDggPSBydHdfcmVhZDgo
YWRhcHRlciwgUkVHX0JDTl9DVFJMXzg4MjJDKTsNCj4gcmVzdG9yZVsxXSA9IHZhbDg7DQo+IHZh
bDggJj0gfkJJVF9FTl9CQ05fRlVOQ1RJT05fODgyMkM7DQo+IHZhbDggfD0gQklUX0RJU19UU0Zf
VURUXzg4MjJDOw0KPiBydHdfd3JpdGU4KGFkYXB0ZXIsIFJFR19CQ05fQ1RSTF84ODIyQywgdmFs
OCk7DQo+IA0KPiBUaGlzIGlzIG5vdCBwYXJ0IG9mIHRoZSB1cHN0cmVhbSBydHc4OCBkcml2ZXIs
IHNvIEkgbWFkZSBhIHBhdGNoIGFuZA0KPiBhdHRhY2hlZCBpdC4NCj4gVW5mb3J0dW5hdGVseSBp
dCBkb2Vzbid0IGZpeCB0aGUgcHJvYmxlbS4NCj4gDQo+IDIpIFBDSSBpcyB0aGUgb25seSBIQ0kg
d2hpY2ggZG9lcyBub3QgbmVlZCB0aGUgY2hlY2tzdW0gaW4gdGhlDQo+IHBrdF9JbmZvIChVU0Ig
YW5kIFNESU8gbmVlZCB0aGUgY2hlY2tzdW0pLg0KPiBUaGUgY2hlY2tzdW0gaXMgYWRkZWQgYnkg
cnR3X3R4X2ZpbGxfdHhkZXNjX2NoZWNrc3VtKCkgd2hpY2ggaXMgb25seQ0KPiBjYWxsZWQgaW4g
dXNiLmMgYW5kIHNkaW8uYy4NCj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGZvciByZXNlcnZl
ZCBwYWdlcyB3ZSBjYW4gaGF2ZSBtb3JlIHRoYW4gb25lDQo+IHBrdF9pbmZvIGluIHRoZSBidWZm
ZXIgKG15IHN0YXJ0aW5nIHBvaW50IGZvciB0aGlzIHRob3VnaHQgaXMNCj4gcnR3X2ZpbGxfcnN2
ZF9wYWdlX2Rlc2MoKSBmcm9tIGZ3LmMpLg0KPiBJbiB1c2IuYyBhbmQgc2Rpby5jIHdlJ3JlIG9u
bHkgY2FsY3VsYXRpbmcgdGhlIGNoZWNrc3VtIGZvciB0aGUgdmVyeQ0KPiBmaXJzdCBwa3RfaW5m
bywgbm90IGZvciBhbnkgc3Vic2VxdWVudCBvbmVzIChJIGRpZG4ndCBldmVuIGtub3cgdGhhdA0K
PiBpdCdzIHBvc3NpYmxlIHRvIGhhdmUgbW9yZSB0aGFuIG9uZSBwa3RfSW5mbyBvdXRzaWRlIG9m
IFJYIGFuZCBUWA0KPiBhZ2dyZWdhdGlvbikuDQo+IEhvd2V2ZXIsIGl0IHNlZW1zIHRoYXQgdGhl
IGRvd25zdHJlYW0gY29kZSBjYWxjdWxhdGVzIHRoZSBUWCBjaGVja3N1bQ0KPiBmb3IgKmFsbCog
cGt0X2luZm8gaW4gdGhlIGJ1ZmZlciwgc2VlIFsxXQ0KPiBUaGlzIGNvZGUgaXMgbWlzc2luZyBm
cm9tIHJ0dzg4IGF0IHRoZSBtb21lbnQuIFNpbmNlIEkgZGlkbid0IGhhdmUNCj4gdGltZSBJIGRp
ZCBub3QgdHJ5IHRvIGltcGxlbWVudCB0aGlzIHlldC4NCj4gDQo+IDMpIEhhcyBhbnlib2R5IHRy
aWVkIEFQIG1vZGUgd2l0aCBydHc4OCBvbiBhIChzdXBwb3J0ZWQpIFVTQiBjaGlwc2V0Pw0KPiBJ
ZiBteSB0aG91Z2h0IChmcm9tICMyKSBpcyBjb3JyZWN0IHRoZW4gQVAgbW9kZSB3b3VsZCBzaG93
IHRoZSBzYW1lDQo+IHByb2JsZW1zIHRoZXJlLg0KPiANCj4gNCkgVmlhY2hlc2xhdiwgSSB0aGlu
ayB5b3UgcHJldmlvdXNseSBtZW50aW9uZWQgdGhhdCB5b3UgZGlkIGEgYml0IG9mDQo+IHdvcmsg
d2l0aCB0aGUgZG93bnN0cmVhbSBkcml2ZXIuDQo+IEl0IHdvdWxkIGJlIGF3ZXNvbWUgaWYgeW91
IGNvdWxkIGFsc28gdGFrZSBhIGxvb2sgYXQgdGhlIHJ0dzg4IGFuZA0KPiBkb3duc3RyZWFtIGRy
aXZlciBjb2RlIGFuZCBzdGFydCBjb21wYXJpbmcgdGhlbSAobG9naWMgdGhhdCdzDQo+IGRpZmZl
cmVudCBvciBjb21wbGV0ZWx5IG1pc3NpbmcgZnJvbSBydHc4OCBpcyBzdXNwaWNpb3VzKS4NCj4g
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IE1hcnRpbg0KPiANCj4gDQo+IFswXQ0KPiBodHRwczov
L2dpdGh1Yi5jb20vY2hld2l0dC9SVEw4ODIyQ1MvYmxvYi82MGNkODIxMzRkNjNhYTk0MzZiNDNj
NDI5MzNhODZkNmU1YTE5MWJhL2hhbC9ydGw4ODIyYy9ydGw4ODINCj4gMmNfb3BzLmMjTDE4ODUt
TDE4OTMNCj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9jaGV3aXR0L1JUTDg4MjJDUy9ibG9iL21h
aW4vaGFsL3J0bDg4MjJjL3NkaW8vcnRsODgyMmNzX3htaXQuYyNMMzExLUwzMTINCg==

