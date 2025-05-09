Return-Path: <linux-wireless+bounces-22759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFA4AB0720
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 02:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759214E8280
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 00:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79702111AD;
	Fri,  9 May 2025 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="TUIIH8nZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6010A1E
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 00:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746751098; cv=none; b=E4kjGhpMDXf89r3J42NQ02tqqtr63kaKaHQZi5fxRJdMZJuZZLs1sA6tSmmhoN0a2vxLX86d9tO4ckH0j+tUAmM10F5YTxjPx2UG4WXxho8ajkkuCjB9n70kFFwAjw13W1m09FtKlSsXocKhSatfYpm1BbQ7CYzFJ2gUUlkEgmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746751098; c=relaxed/simple;
	bh=42VWz7StHgwD5sXVU+lXgyOLydfd6dDsGcAk+UdlwQo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T+G8luMoC6JlR1EIFjlFet+ot1mj6ordpBkoYnRIyX6Bqa7bIHjjjQefk0HLzth/yOJRvMHaNNqzeLnMRLUqVzXW1ZBev8R4APKTMswvrrY9EXcW3hv7JczEMYRSpsraZsLNqzT22OnieQH/7NhExhwYSeaPmXlBdlEqOWpsmos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=TUIIH8nZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5490cAPy93252581, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746751090; bh=42VWz7StHgwD5sXVU+lXgyOLydfd6dDsGcAk+UdlwQo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=TUIIH8nZUMN7zNqriL6a1DuKSc62bv3a8kTSPVKbjZAZtn2h9EBjokREAUlbY9/a5
	 g4160PHbareJTNhXeMiMRt0dVxt1jLwSzXJUnLsW6/7Uhmtft/otxF6hn+NuStQi/J
	 kgoulm43yMJTNZ+uot3aNM9s97yoAgRrarQniVEL9aJW1Sz5qra/k97ZrZRPqewjWi
	 hXivjM/zAdUhgaSDTO739p93hc/RA9vgnySbR+lN5BMjmRvgj70Qkrk5XIgVRuZWAj
	 d9vLnO3YV/577l92xA79Rf1t5g+Qr2SMN3qOqnIZnA62aUDtmrnEiLlnPTXxmfWKYu
	 D87Ush9XVaYoQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5490cAPy93252581
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 08:38:10 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 May 2025 08:38:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 May 2025 08:38:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 9 May 2025 08:38:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Samuel Reyes <zohrlaffz@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: RTL8922AE driver issues
Thread-Topic: RTL8922AE driver issues
Thread-Index: AQHbvXDofJ7veYm0B0SRgsW1576rS7PDt/FQgAAI4oCAARqb4IACHsgAgAD3lUCAAL5jgIAAx0sw
Date: Fri, 9 May 2025 00:38:10 +0000
Message-ID: <f4355539f3ac46bbaf9c586d059a8cbb@realtek.com>
References: <CAD+XiyEJo0m8L6PbmBD=NPPa0E_wX3kk4ezn1qZ0d8JGXsS1qQ@mail.gmail.com>
 <0cf9bd4b99864f428175e34a2f2e014b@realtek.com>
 <CAD+XiyFkogCyQTk8Xhu8htGa892zFkY707+8WVCOdejb3FLNpg@mail.gmail.com>
 <ae5013a930574e68b96544df82f93157@realtek.com>
 <CAD+XiyEQPt9HGngt0XBB7Hf=0tDHHcU+3=E20vhPnC3VL1Y+vg@mail.gmail.com>
 <31b6571789b34b95aca2bca73dca2d62@realtek.com>
 <CAD+XiyEXU_cxgfk1DxFZLFMLXWbmo-cDf7d30Hb1F7_BqdBCQw@mail.gmail.com>
In-Reply-To: <CAD+XiyEXU_cxgfk1DxFZLFMLXWbmo-cDf7d30Hb1F7_BqdBCQw@mail.gmail.com>
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

U2FtdWVsIFJleWVzIDx6b2hybGFmZnpAZ21haWwuY29tPiB3cm90ZToNCj4gT24gV2VkLCBNYXkg
NywgMjAyNSBhdCA3OjIz4oCvUE0gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gU2FtdWVsIFJleWVzIDx6b2hybGFmZnpAZ21haWwuY29tPiB3cm90ZToN
Cj4gPiA+IE9uIE1vbiwgTWF5IDUsIDIwMjUgYXQgODoxMeKAr1BNIFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gU2FtdWVsIFJleWVzIDx6
b2hybGFmZnpAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+ID4gPiBCaWcgdXBkYXRlLCBJIHVwZGF0
ZWQgbXkgbW90aGVyYm9hcmQgdG8gdGhlIG5ld2VzdCBCSU9TICh2RjQpIGFuZCBpdA0KPiA+ID4g
PiA+IGhhcyBoZWxwZWQgZHJhbWF0aWNhbGx5IHdpdGggdGhlIGFtb3VudCBvZiBlcnJvcnMgaW4g
ZG1lc2cuIEJ1dCB0aGUNCj4gPiA+ID4gPiBpc3N1ZSB3aXRoIHRoZSBjb25uZWN0aW9uIGRyb3Bw
aW5nIGFmdGVyIHNvbWUgdGltZSByZW1haW5zLiBJIGFkZGVkDQo+ID4gPiA+ID4gYW1kX2lvbW11
PW9mZiB0byBteSBrZXJuZWwgcGFyYW1ldGVycyBhbmQgcmFuIHN1ZG8gaXcgd2xhbjAgc2V0DQo+
ID4gPiA+ID4gcG93ZXJfc2F2ZSBvZmYuIEkgZGlkIE5PVCBhcHBseSB0aGUga2VybmVsIHBhdGNo
IHlvdSBpbmNsdWRlZCB5ZXQuIEkNCj4gPiA+ID4gPiByYW4gZG1lc2cgd2hlbiBteSBjb25uZWN0
aW9uIGRyb3BwZWQgYW5kIHNhdyBhIGJ1bmNoIG9mICdmYWlsZWQgdG8NCj4gPiA+ID4gPiB1cGRh
dGUgWFggUlhCRCBpbmZvOiAtMTEnIGVycm9ycyBhZ2Fpbi4NCj4gPiA+ID4NCj4gPiA+ID4gSSBk
b24ndCBoYXZlIGNsZWFyIGlkZWEgbm93LiBQbGVhc2UgdHJ5IG15IHBhdGNoIGZpcnN0Lg0KPiA+
ID4gPiBJIHdpbGwgY2hlY2sgaW50ZXJuYWxseSBhbmQgd2lsbCBuZWVkIHlvdXIgaGVscCB0byBj
b2xsZWN0IG1vcmUgZGF0YS4NCj4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkgbWFuYWdl
ZCB0byBjYXB0dXJlIHRoZSBjb25uZWN0aW9uIGRyb3AgaW4gYSByZWNvcmRpbmcgc28geW91IGNh
biBzZWUNCj4gPiA+ID4gPiB3aGF0IGl0IGxvb2tzIGxpa2Ugb24gbXkgZW5kLiBNeSBjb25uZWN0
aW9uIHdpbGwgcmVtYWluICdicm9rZW4nDQo+ID4gPiA+ID4gaW5kZWZpbml0ZWx5IHVudGlsIEkg
dG9nZ2xlIGFpcnBsYW5lIG1vZGUuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBWaWRlbzogaHR0cHM6
Ly95b3V0dS5iZS9CYlZsVFU4SzlIZw0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IENhbiB5
b3Ugb3BlbiBhIHRlcm1pbmFsIHRvIHNob3cga2VybmVsIGxvZyBuZXh0IHRpbWU/IEkgd291bGQg
bGlrZSB0bw0KPiA+ID4gPiBrbm93IGRpc2Nvbm5lY3Rpb24gaGFwcGVucyBhbG9uZyAnZmFpbGVk
IHRvIHVwZGF0ZSBYWCBSWEJEIGluZm86IC0xMScuDQo+ID4gPiA+DQo+ID4gPiA+IEJ5IHRoZSB3
YXksIHBsZWFzZSBub3QgdG9wLXBvc3RpbmcgaW4gd2lyZWxlc3MgbWFpbGluZy4NCj4gPiA+ID4N
Cj4gPiA+DQo+ID4gPiBIaSENCj4gPiA+DQo+ID4gPiBUaGFua3MgYWdhaW4gZm9yIHlvdXIgYXNz
aXN0YW5jZS4NCj4gPiA+DQo+ID4gPiBJIHNwZW50IGFsbCBkYXkgeWVzdGVyZGF5IGFuZCB0aGlz
IG1vcm5pbmcgdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgaG93IHRvDQo+ID4gPiBhcHBseSB5b3VyIHBh
dGNoIGFuZCB3YXNuJ3QgYWJsZSB0byBkbyBpdC4gSSdtIGJ5IG5vIG1lYW5zIGFuIGV4cGVydA0K
PiA+ID4gYW5kIHF1aWNrbHkgZm91bmQgdGhhdCBwYXRjaGluZyBhIGtlcm5lbCBpcyBubyBlYXN5
IGZlYXQuDQo+ID4NCj4gPiBXaGF0IGFyZSB0aGUgcHJvYmxlbXMgeW91IG1ldD8gQmVsb3cgaXMg
dGhlIHJvdWdoIHN0ZXBzIHRvIGJ1aWxkIGRyaXZlcjoNCj4gPiAxLiBncmFiIGtlcm5lbCBzb3Vy
Y2UNCj4gPiAgICBnaXQgY2xvbmUgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3N0YWJsZS9saW51eC1zdGFibGUuZ2l0DQo+ID4gMi4gc3dpdGNoIHRvIHRhZyB5
b3UgYXJlIHVzaW5nDQo+ID4gICAgZWcuIGdpdCBjaGVja291dCB2Ni4xNC4yDQo+ID4gMy4gaW5z
dGFsbCB0b29sY2hhaW4va2VybmVsIGhlYWRlciBieSAnYXB0IGluc3RhbGwnDQo+ID4gICAgc3Vk
byBhcHQgaW5zdGFsbCBidWlsZC1lc3NlbnRpYWwNCj4gPiAgICAoSSBkb24ndCByZW1lbWJlciBo
b3cgdG8gaW5zdGFsbCBrZXJuZWwgaGVhZGVyLiBQbGVhc2UgZ29vZ2xlIGl0IHlvdXJzZWxmLikN
Cj4gPiA0LiBtYWtlIGRyaXZlcg0KPiA+ICAgIGUuZy4gbWFrZSAtQyAvbGliL21vZHVsZXMvNi4x
NC4yLTA2MTQwMi1nZW5lcmljL2J1aWxkDQo+IE09LyQoS0VSTkVMX1NPVVJDRV9QQVRIKS9kcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5Lw0KPiA+IDUuIHJtbW9kL2luc21vZA0KPiA+
ICAgIGBgYGxzbW9kIHwgZ3JlcCBydHc4OWBgYCBjYW4gc2VlIGFsbCBydHc4OSBtb2R1bGVzDQo+
ID4NCj4gPg0KPiA+ID4gSSB3YW50ZWQgdG8NCj4gPiA+IHJlY29yZCBhIGJlZm9yZSBhbmQgYWZ0
ZXIgdmlkZW8gKGJlZm9yZSB5b3VyIHBhdGNoIGFuZCBhZnRlcikgb2YgdGhlDQo+ID4gPiBkb3du
bG9hZCwgYnV0IHNpbmNlIEkgY291bGRuJ3QgZmlndXJlIG91dCBob3cgdG8gcGF0Y2ggbXkga2Vy
bmVsIEkNCj4gPiA+IG9ubHkgaGF2ZSBhIGJlZm9yZSB2aWRlby4gSXQgaGFzIHRoZSB0ZXJtaW5h
bCBydW5uaW5nIHNvIHlvdSBjYW4gc2VlDQo+ID4gPiB0aGUgZXJyb3JzIHBvcCB1cCBpbiByZWFs
IHRpbWUuIEl0J3MgcHJldHR5IGxvbmcgc2luY2UgSSByZWNvcmRlZCBpdA0KPiA+ID4gZnJvbSB0
aGUgdmVyeSBzdGFydCBvZiB0aGUgZG93bmxvYWQuIFRoZSBjcmFzaCBoYXBwZW5zIGF0IGFyb3Vu
ZCAxMTozMA0KPiA+ID4gaW50byB0aGUgdmlkZW86IGh0dHBzOi8veW91dHUuYmUvMm5yTE91WTZQ
d2sNCj4gPg0KPiA+IEkgZ3Vlc3MgdGhlIGNhdXNlIGlzIHRoYXQgUlhEIGNhbid0IGJlIHJlY29n
bml6ZWQgYW5kIHRoZW4NCj4gPiAiZmFpbGVkIHRvIHJlbGVhc2UgVFggc2ticyIgY2FuJ3QgZnJl
ZSBUWCBXRCBwcm9wZXJseSwgc28gcnVuIG91dCBvZg0KPiA+IFRYIHJlc291cmNlLiBUaGVyZWZv
cmUsIGxldCdzIHRyeSB0aGUgcGF0Y2ggdG8gc2VlIGlmIHdlIGNhbiByZXNvbHZlDQo+ID4gJ2Zh
aWxlZCB0byB1cGRhdGUgWFggUlhCRCBpbmZvOiAtMTEnIHByb2JsZW0gZmlyc3QuDQo+ID4NCj4g
PiA+DQo+ID4gPiBQLlMuIEkgaG9wZSB0aGlzIGlzIHdoYXQgeW91IG1lYW50IGFib3V0IHRvcC1w
b3N0aW5nLCBJIGFsc28gaGFkIHRvDQo+ID4gPiByZXNlYXJjaCB3aGF0IHRoYXQgbWVhbnQgYW5k
IGhvdyB0byBhdm9pZCBpdCA6UA0KPiA+DQo+ID4gWWVzLCBpdCBpcy4gOikNCj4gPg0KPiANCj4g
VGhlIG9ic3RhY2xlIHdhcyB1bmxvYWRpbmcgdGhlIG1vZHVsZSB3aGljaCB3YXMgaW4gdXNlIHRv
IGxvYWQgaW4gdGhlDQo+IHBhdGNoZWQgb25lLiBJIGRpZCBpdCB0aG91Z2gsIEkgaGFkIHRvIGJv
b3QgZnJvbSBhbiBBcmNoIGxpdmUNCj4gZW52aXJvbm1lbnQgb24gYSBVU0IuDQoNClRoYXQgd2ls
bCBiZSBlYXNpZXIgYWZ0ZXIgdGhpcyBzdWNjZXNzLiA6KQ0KDQo+IA0KPiBBbnl3YXlzIHRoZSBw
YXRjaCB3b3JrcyEhIGRtZXNnIGlzIGNsZWFyIG9mIHRob3NlIHBlc2t5IFJYQkQgbWVzc2FnZXMN
Cj4gYW5kIG15IGRvd25sb2FkIGNvbXBsZXRlZCB3aXRob3V0IGZhaWx1cmUuIFRoaXMgaXMgdGhl
IGZpcnN0IHRpbWUgSSd2ZQ0KPiBiZWVuIGFibGUgdG8gbWFrZSBhIGxhcmdlIGRvd25sb2FkIGxp
a2UgdGhhdCB3aXRob3V0IHRoZSBjb25uZWN0aW9uDQo+IGRyb3BwaW5nIDopDQoNCkdvb2QgdG8g
aGVhciB0aGUgZ29vZCBuZXdzLiBJIHdpbGwgbWFrZSBhIHBhdGNoIGZvciBpdC4gDQoNCj4gDQo+
IFlvdSdsbCBzZWUgdGhlIGRvd25sb2FkIHNwZWVkIGRpcCBhIGZldyB0aW1lcyAoZS5nLiBhcm91
bmQgNDo0NQ0KPiBtaW51dGVzIGluIHRoZSB2aWRlbykgb3ZlciB0aGUgY291cnNlIG9mIHRoZSBk
b3dubG9hZCwgYnV0IGl0IGFsd2F5cw0KPiByZWNvdmVycyBzdWNjZXNzZnVsbHkuIEluIHRoZSBw
YXN0IHRob3NlIGRpcHMgd2VyZSBhIHNpZ24gb2YgdGhlDQo+IGNvbm5lY3Rpb24gZHJvcHBpbmcu
DQo+IA0KDQpGb3IgbWUsIHRoZXNlIGRpcHMgc2VlbXMgdG8gYmUgYWNjZXB0YWJsZS4gSWYgeW91
IHdhbnQgdG8gZGlnIGZ1cnRoZXIsDQpJIHNob3VsZCBjaGVjayBQSFkgcmF0ZSBmaXJzdCB2aWEg
ZGVidWdmczoNCg0KICAgY2QgL3N5cy9rZXJuZWwvZGVidWcvaWVlZTgwMjExL3BoeTAvcnR3ODkN
CiAgIHdhdGNoIGNhdCBwaHlfaW5mbw0KDQpBbmQsIGNhcHR1cmUgdmlkZW8gYXMgYmVmb3JlLiAN
Cg0KSSBhZG1pdCB0aGlzIGlzIG9ubHkgZmlyc3Qgc3RlcCB0byBzZWUgaWYgdGhlIHN5bXB0b20g
aXMgY2F1c2VkIGJ5DQpQSFkgcmF0ZS4gSWYgeWVzLCBJIG5lZWQgYWlyIHNuaWZmZXIgdG8ga25v
dyBob3cgaXQgaGFwcGVucy4gSWYgbm90LA0KbWF5YmUgc3lzdGVtIGVudGVycyBwb3dlciBzYXZl
IG1vZGUgb3Igb3RoZXJzLiANCg0KDQo=

