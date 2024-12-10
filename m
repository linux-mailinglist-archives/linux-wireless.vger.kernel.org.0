Return-Path: <linux-wireless+bounces-16123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339FC9EA3AC
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 01:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C70282DA0
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 00:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F37111AD;
	Tue, 10 Dec 2024 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="DxP29+ir"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403393C0C;
	Tue, 10 Dec 2024 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733790437; cv=none; b=UyjJwIPGbEj7nupSGyp7gUrclgybavodeaKJZWw1cTcNXzHcbNOy9YTE36dJUq8eWCx0R/9PliDmx0gH8EXI+NkjvLFugOojIB7UrkoH9Odr1AN0IbtjguEsQR5lkFJ3SLGyYE0LHBTmrBaWyKm7+z6oROroImjcSA+ZuaGcOjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733790437; c=relaxed/simple;
	bh=ek6ouMtERzjgwZhGmlmAV8/bU3B8j04YvwGPt9ZUO6g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uj0HMnF/EFbHoe9bpO+XT5LLcUkPcfgkRH45dKfWddf+ru1wp/cuvapKgc1Rsilz49eegaECP30B+RcKge15fQmjWXI2uJOMfxQY6GqSiCberdEYOzCimKxZX1cdmGEQv5Kui60u64ztoG+jB/IpCwCmlUf99cAnXHo3XWVhZ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=DxP29+ir; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BA0QqRqA1289184, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733790412; bh=ek6ouMtERzjgwZhGmlmAV8/bU3B8j04YvwGPt9ZUO6g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=DxP29+irD2kmxQ8sbPnc9YFBjQOkafrnRqXYlqqqagaozRYSVQ/kyUL2/tjm2Pgit
	 6tZu7kX7nu068eypEBQF8/LNFYxEO62qFxO31wYFI3iLElKLby8jDzqyPXrq8E6OBa
	 awsm9+ae4dfpnuaXO2W+whpTIx20Fb3pPMKkobL8EzOPxU/TmWv+t1GCWUpVLPlPwN
	 b1LLhbzOnYxu/xaU0aMc54Dzclbshi4pVNr5vCqbyQN4EDrRG9JPHYJhFH5s9kka/9
	 p1WVp5eF92ZG6J06eYA7g63Ym8s3Ye6k9OsB2YeOUP3rh/q/UkhROjj2lEkdofEY2i
	 E5EWZOdNopsVg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BA0QqRqA1289184
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 08:26:52 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 08:26:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 10 Dec 2024 08:26:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 10 Dec 2024 08:26:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Hans de Goede <hdegoede@redhat.com>, Kalle Valo <kvalo@kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
Thread-Topic: [PATCH] wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
Thread-Index: AQHbMR7R6Gvee4SdJkqElRUs0WKrm7K72VoAgCAvYgCAATWcgIAAAo+AgACwZhr//3rOgIABZGXg
Date: Tue, 10 Dec 2024 00:26:51 +0000
Message-ID: <5736c7a2cf7843fab0b491d1482bb292@realtek.com>
References: <20241107140833.274986-1-hdegoede@redhat.com>
 <6cf370a2-4777-4f25-95ab-43f5c7add127@RTEXMBS04.realtek.com.tw>
 <094431c4-1f82-43e0-b3f0-e9c127198e98@redhat.com>
 <8e0a643ecdc2469f936c607dbd555b4c@realtek.com>
 <1d59a602-053a-47f1-9dac-5c95483d07b6@redhat.com> <87ldwpt90g.fsf@kernel.org>
 <5f0bb4c4-57f0-4976-a6c2-2419500ffe4d@redhat.com>
In-Reply-To: <5f0bb4c4-57f0-4976-a6c2-2419500ffe4d@redhat.com>
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

SGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IEhpLA0KPiANCj4g
T24gOS1EZWMtMjQgMTI6MDEgUE0sIEthbGxlIFZhbG8gd3JvdGU6DQo+ID4gSGFucyBkZSBHb2Vk
ZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4gd3JpdGVzOg0KPiA+DQo+ID4+IEhpLA0KPiA+Pg0KPiA+
PiBPbiA5LURlYy0yNCAxOjI2IEFNLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+PiBIYW5zIGRl
IEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPiB3cm90ZToNCj4gPj4+PiBIaSwNCj4gPj4+Pg0K
PiA+Pj4+IE9uIDE4LU5vdi0yNCAzOjIzIEFNLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+Pj4+
IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+IHdyb3RlOg0KPiA+Pj4+Pg0KPiA+
Pj4+Pj4gVGhlIHJ0bDh4eHh1IGhhcyBhbGwgdGhlIHJ0bDgxOTJjdSBVU0IgSURzIGZyb20gcnRs
d2lmaS9ydGw4MTkyY3Uvc3cuYw0KPiA+Pj4+Pj4gZXhjZXB0IGZvciB0aGUgZm9sbG93aW5nIDEw
LCBhZGQgdGhlc2UgdG8gdGhlIHVudGVzdGVkIHNlY3Rpb24gc28gdGhleQ0KPiA+Pj4+Pj4gY2Fu
IGJlIHVzZWQgd2l0aCB0aGUgcnRsOHh4eHUgYXMgdGhlIHJ0bDgxOTJjdSBhcmUgd2VsbCBzdXBw
b3J0ZWQuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gVGhpcyBmaXhlcyB0aGVzZSB3aWZpIG1vZHVsZXMg
bm90IHdvcmtpbmcgb24gZGlzdHJpYnV0aW9ucyB3aGljaCBoYXZlDQo+ID4+Pj4+PiBkaXNhYmxl
ZCBDT05GSUdfUlRMODE5MkNVIHJlcGxhY2luZyBpdCB3aXRoIENPTkZJR19SVEw4WFhYVV9VTlRF
U1RFRCwNCj4gPj4+Pj4+IGxpa2UgRmVkb3JhLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IENsb3Nlczog
aHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0yMzIxNTQwDQo+ID4+
Pj4+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+Pj4+Pj4gQ2M6IFBldGVyIFJvYmlu
c29uIDxwYnJvYmluc29uQGdtYWlsLmNvbT4NCj4gPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEhhbnMg
ZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+DQo+ID4+Pj4+PiBSZXZpZXdlZC1ieTogUGV0
ZXIgUm9iaW5zb24gPHBicm9iaW5zb25AZ21haWwuY29tPg0KPiA+Pj4+Pg0KPiA+Pj4+PiAxIHBh
dGNoKGVzKSBhcHBsaWVkIHRvIHJ0dy1uZXh0IGJyYW5jaCBvZiBydHcuZ2l0LCB0aGFua3MuDQo+
ID4+Pj4+DQo+ID4+Pj4+IDMxYmUzMTc1YmQ3YiB3aWZpOiBydGw4eHh4dTogYWRkIG1vcmUgbWlz
c2luZyBydGw4MTkyY3UgVVNCIElEcw0KPiA+Pj4+DQo+ID4+Pj4gVGhhbmsgeW91IGZvciBtZXJn
aW5nIHRoaXMsIHNpbmNlIHRoaXMgaXMgYSBidWdmaXggcGF0Y2gsIHNlZSBlLmcuIDoNCj4gPj4+
Pg0KPiA+Pj4+IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MjMy
MTU0MA0KPiA+Pj4+DQo+ID4+Pj4gSSB3YXMgZXhwZWN0aW5nIHRoaXMgcGF0Y2ggdG8gc2hvdyB1
cCBpbiA2LjEzLXJjMSBidXQgaXQgZG9lcw0KPiA+Pj4+IG5vdCBhcHBlYXIgdG8gYmUgdGhlcmUu
DQo+ID4+Pj4NCj4gPj4+PiBDYW4geW91IHBsZWFzZSBpbmNsdWRlIHRoaXMgaW4gYSBmaXhlcy1w
dWxsLXJlcXVlc3QgdG8gdGhlIG5ldHdvcmsNCj4gPj4+PiBtYWludGFpbmVyIHNvIHRoYXQgZ2V0
cyBhZGRlZCB0byBhIDYuMTMtcmMjIHJlbGVhc2Ugc29vbiBhbmQgdGhlbg0KPiA+Pj4+IGNhbiBi
ZSBiYWNrcG9ydGVkIHRvIHZhcmlvdXMgc3RhYmxlIGtlcm5lbHMgPw0KPiA+Pj4+DQo+ID4+Pg0K
PiA+Pj4gVGhpcyBwYXRjaCBzdGF5cyBpbiBydHcuZ2l0IGFuZCA2LjE0IHdpbGwgaGF2ZSBpdCwg
YW5kIHRoZW4gZHJhaW4gdG8gc3RhYmxlDQo+ID4+PiB0cmVlcy4gRm9yIHRoZSByZWRoYXQgdXNl
cnMsIGNvdWxkIHlvdSBhc2sgdGhlIGRpc3RybyBtYWludGFpbmVyIHRvIHRha2UgdGhpcw0KPiA+
Pj4gcGF0Y2ggYWhlYWQ/DQo+ID4+DQo+ID4+IFRoYXQgaXMgbm90IGhvdyB0aGluZ3MgYXJlIHN1
cHBvc2VkIHRvIHdvcmsuIFlvdSBhcmUgc3VwcG9zZWQgdG8gaGF2ZSBhIGZpeGVzDQo+ID4+IHRy
ZWUvYnJhbmNoIGFuZCBhIG5leHQgdHJlZS9icmFuY2ggYW5kIGZpeGVzIHNob3VsZCBiZSBzZW5k
IG91dCBBU0FQLg0KPiA+DQo+ID4gUGxlYXNlIHVuZGVyc3RhbmQgdGhhdCB3ZSBhcmUgbW9yZSBv
ciBsZXNzIHZvbHVudGVlcnMgYW5kIHdvcmtpbmcgd2l0aA0KPiA+IGxpbWl0ZWQgdGltZS4NCj4g
Pg0KPiA+PiBJZGVhbGx5IHlvdSB3b3VsZCBoYXZlIGFscmVhZHkgc2VuZCB0aGlzIG91dCBhcyBh
IGZpeGVzIHB1bGwtcmVxdWVzdCBmb3INCj4gPj4gNi4xMiBidXQgd2FpdGluZyB0aWxsIDYuMTQg
cmVhbGx5IGlzIG5vdCBhY2NlcHRhYmxlIElNSE8uDQo+ID4NCj4gPiBJZiB5b3UgaGF2ZSBhbiBp
bXBvcnRhbnQgZml4IHBsZWFzZSBkb2N1bWVudCB0aGF0IHNvbWVob3csIGZvciBleGFtcGxlDQo+
ID4gIltQQVRDSCB3aXJlbGVzc10iIG9yICJbUEFUQ0ggdjYuMTNdIi4gSWYgdGhlcmUncyBub3Ro
aW5nIGxpa2UgdGhhdCBtb3N0DQo+ID4gbGlrZWx5IHRoZSBwYXRjaCBnb2VzIHRvIC1uZXh0LCB3
ZSAoaW4gd2lyZWxlc3MpIGRvbid0IHRha2UgZXZlcnkgZml4IHRvDQo+IA0KPiBPaywgc28gaG93
IGRvIHdlIG1vdmUgZm9yd2FyZCB3aXRoIHRoaXMgcGF0Y2ggbm93ID8NCj4gDQoNCklNSE8gdGhl
IG1pc3NlZCBJRCBoYXMgYmVlbiBtYW55IHllYXJzLCBsZXQncyB3YWl0IGFkZGl0aW9uYWwgdGhy
ZWUgbW9udGhzLg0KVGhlIGZsb3cgb2YgcGF0Y2ggcHJvY2VzcyBmb3IgbWFpbnRhaW5lcnMgd2ls
bCBiZSBtb3JlIHNtb290aC4gDQpGb3IgbmV3bHkgYWRkZWQgSUQgbmV4dCB0aW1lLCBJIHdpbGwg
Y2hlY2sgcGVvcGxlIGlmIHRoYXQgaXMgdXJnZW50IG9yIG5vdC4NCg0KDQo=

