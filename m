Return-Path: <linux-wireless+bounces-34128-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL6TFYLQyWkk2wUAu9opvQ
	(envelope-from <linux-wireless+bounces-34128-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 03:23:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF49354912
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 03:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 073183002329
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 01:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EC0248873;
	Mon, 30 Mar 2026 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IynAbEU2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4321453E0B;
	Mon, 30 Mar 2026 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774833791; cv=none; b=MNttGYKbGn+Y4kw28TaXrlY9ddqnfsvDvvf7gA26enVOySBCRJY04gqE/23J3qQWrO2KpDXzUO+QVNfp+Yc5/T37M9J/NC2eonCKe0R0j+ix/T5H0eaPghnnE3xz+s0pl435sCDuGOX2qnC6X8izBe3Ro5mm5HYsCRKMlHk3Lz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774833791; c=relaxed/simple;
	bh=3w4O7R64vTJS6bhAxe0MIjU5CkvT0NRoEaZEeanTqAg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=glCvMnevu+y+K4uHOgHwLPgVbJVbI3uiA7Vzzc2WLyI9nS4jXBZ+oJWqbxSryp3PFAJHmmWo39juJB+L/A9XcgCVaLKFYYaijLaSVpj+by3uxQQhV3bPH3XyNleuTwUxeBSSacNw6S9FjQ3PlQP48CRJGH8Mdsawvc77lN4mmkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IynAbEU2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U1N5a54041223, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774833785; bh=3w4O7R64vTJS6bhAxe0MIjU5CkvT0NRoEaZEeanTqAg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=IynAbEU2wcu0OacoT+3rzRcsrr/smPf4g6aQJDJZCPl8EzjVDeVPoFpWTLALzeSyZ
	 kYvgjy04rADFVYMsgVS+WXi38lLbaVMyPCfCkXv5W+n1BEZ53sTCWwrSqoHTZgWxjI
	 O6ofFf7kn291OkvUcZav1LzDvLZ0VXqBnMpBAykBXGfs3USc53krlyWPckIItUSnp3
	 TD68MnwKx9ZIJWoViB42ePn6QNmdm+7vQ2eonIQpbUJxuyZlCtdeqe2KA9wXJ4Pgag
	 +3Mq6jitls4+2jmpW4wXDWWixT1VZU2budKdPset2DZOUaLkBURpHeWJ09tXH6M5Zo
	 WpfFaFQsPlRcA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U1N5a54041223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 09:23:05 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 09:23:04 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 30 Mar 2026 09:23:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Mon, 30 Mar 2026 09:23:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>, LB F <goainwo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Topic: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Index: AQHcsA6WTRRnBRFJhEKVxaR7JwwWq7Wm+M9wgAAbfgCAAX9nAIAAB6mAgAAK64CAAElZAIABMBnAgADMOgCAACdjAIAAB1+AgAJAYICAAB3nAIAAxOYAgAJBRiCAAKEnAIAA2QBQgAD06wCAAJVNMIAA+6oAgACVvSCAAP1VgIAAC/kAgACJQ/D//4GPAIAAkThggAG2LgCAAwD/wIAD1wcAgAHIjgCAALhtgIABn92AgAAYAQCAAAl0AIAAVvuAgAKDYMA=
Date: Mon, 30 Mar 2026 01:23:02 +0000
Message-ID: <6898154c58c84536a0dd4351b3b026fb@realtek.com>
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com>
 <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com>
 <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com>
 <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com>
 <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com>
 <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com>
 <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
 <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com>
In-Reply-To: <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com>
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
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34128-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DFF49354912
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
T24gMjgvMDMvMjAyNiAxNTo0MCwgTEIgRiB3cm90ZToNCj4gPiBIaSBCaXR0ZXJibHVlLA0KPiA+
DQo+ID4gVGhhbmsgeW91IGZvciB0aGUgcXVpY2sgZmVlZGJhY2suIEZ1bGwgZG1lc2cgZnJvbSB0
aGUgY3VycmVudCBib290DQo+ID4gc2Vzc2lvbiBpcyBhdHRhY2hlZCAoZG1lc2dfYm9vdDBfY2xl
YW4udHh0LCAzMzJLLCAzMzQ5IGxpbmVzKS4NCj4gPg0KPiA+IEl0IGNvbnRhaW5zIGFsbCA3NiAi
dW51c2VkIHBoeSBzdGF0dXMgcGFnZSIgZXZlbnRzIHdpdGggYm90aCBoZXgNCj4gPiBkdW1wcyAo
NC1ieXRlIGdyb3VwZWQgYW5kIGJ5dGUtbGV2ZWwpIGluIGZ1bGwsIHBsdXMgYWxsIHN1cnJvdW5k
aW5nDQo+ID4ga2VybmVsIGNvbnRleHQuDQo+ID4NCj4gPiBUaGUgaW50ZXJlc3Rpbmcgb2JzZXJ2
YXRpb24geW91IG1hZGUgYWJvdXQgdGhlIE1BQyBhZGRyZXNzZXMgYmVpbmcNCj4gPiAyNCBieXRl
cyBsb3dlciB0aGFuIGV4cGVjdGVkIGlzIHZlcnkgaGVscGZ1bCDigJQgSSBoYWRuJ3Qgbm90aWNl
ZCB0aGUNCj4gPiBvZmZzZXQgZGlzY3JlcGFuY3kuIElmIHlvdSBuZWVkIHRoZSBhZGFwdGVyIGFu
ZCBBUCBNQUMgYWRkcmVzc2VzDQo+ID4gZm9yIHJlZmVyZW5jZToNCj4gPg0KPiA+ICAgQWRhcHRl
cjogOGM6Yzg6NGI6Njg6ZDE6NjMNCj4gPiAgIEFQOiAgICAgIDZjOjY4OmE0OjFjOjk3OjViDQo+
ID4NCj4gPiBBbmQgeWVzLCBhZGRpbmcgYSBOVUxMIGNoZWNrIGluIHJ0d19md19hZGFwdGl2aXR5
X3Jlc3VsdCgpIHNlZW1zDQo+ID4gbGlrZSBhIGdvb2QgZGVmZW5zaXZlIG1lYXN1cmUgcmVnYXJk
bGVzcyBvZiB0aGUgcm9vdCBjYXVzZS4NCj4gPg0KPiA+IExldCBtZSBrbm93IGlmIHlvdSBuZWVk
IGFueXRoaW5nIGVsc2Ugb3IgYSBkaWZmZXJlbnQgZm9ybWF0Lg0KPiA+DQo+ID4gQmVzdCByZWdh
cmRzLA0KPiA+IE9sZWtzYW5kciBIYXZyeWxvdg0KPiANCj4gSSBtYWRlIGEgbWlzdGFrZSB3aXRo
IHRoZSBzZWNvbmQgcHJpbnRfaGV4X2R1bXAuIEl0IHdhcyBzdXBwb3NlZCB0bw0KPiBwcmludCBm
cm9tIHJ4ZGVzYyArIDU2LiBCdXQgbm90IHRvIHdvcnJ5LCBJIHRoaW5rIHRoaXMgaXMgc3VmZmlj
aWVudC4NCj4gDQo+IFNvbWUgb2YgdGhlIGZyYW1lcyBoYXZlIHdoYXQgbG9va3MgbGlrZSBhIHZh
bGlkIFBIWSBzdGF0dXMgYXQgYnl0ZSAyNDoNCj4gDQo+IFsgOTkyNi4zNjUwNDhdIGNhY2h5b3Mt
eDg2NjQga2VybmVsOiBydHdfODgyMWNlIDAwMDA6MTM6MDAuMDogdW51c2VkIHBoeSBzdGF0dXMN
Cj4gcGFnZSAoNykNCj4gWyA5OTI2LjM2NTQ1MV0gY2FjaHlvcy14ODY2NCBrZXJuZWw6IDAwMDAw
MDAwOiAwNWRhMjZhYyBiNTg3ZjBhZiAwYWEyZTc2NQ0KPiBmNDhkNzhmNSAgLiYuLi4uLi5lLi4u
LnguLg0KPiBbIDk5MjYuMzY1NDc1XSBjYWNoeW9zLXg4NjY0IGtlcm5lbDogMDAwMDAwMTA6IDNm
ZmU5ZTAwIDQ5ZDExYTVjIDAwMDAyNzAxDQo+IDAxMmEwMDAwICAuLi4/XC4uSS4nLi4uLiouDQo+
IFsgOTkyNi4zNjU0OTZdIGNhY2h5b3MteDg2NjQga2VybmVsOiAwMDAwMDAyMDogMDAwMDAwMTQg
MjAwMDAwMDAgMDAwMDAwZTINCj4gMDAwMDAwMGEgIC4uLi4uLi4gLi4uLi4uLi4NCj4gWyA5OTI2
LjM2NTUzN10gY2FjaHlvcy14ODY2NCBrZXJuZWw6IDAwMDAwMDMwOiAwMDAwMDAxYw0KPiAwMDAw
MDAwMCAgICAgICAgICAgICAgICAgICAgLi4uLi4uLi4NCj4gDQo+IEJ1dCBSVFdfUlhfREVTQ19X
MF9TSElGVCBpcyBub3QgMC4gVGhlbiBydHc4OCBsb29rcyBmb3IgdGhlIFBIWQ0KPiBzdGF0dXMg
aW4gdGhlIHdyb25nIHBsYWNlLCBpbiB0aGlzIGNhc2UgYXQgYnl0ZSAyNS4gVGhlIG9mZmljaWFs
DQo+IGRyaXZlciBhbHdheXMgbG9va3MgZm9yIGl0IGF0IGJ5dGUgMjQ6DQo+IA0KPiBodHRwczov
L2dpdGh1Yi5jb20vbHdmaW5nZXIvcnR3ODgvYmxvYi9tYXN0ZXIvYWx0X3J0bDg4MjFjZS9oYWwv
cnRsODgyMWMvcGNpDQo+IC9ydGw4ODIxY2VfcmVjdi5jI0wyNzINCj4gDQo+IFVuZm9ydHVuYXRl
bHkgZml4aW5nIHRoYXQgd29uJ3QgYmUgZW5vdWdoLg0KPiANCj4gVGhlIHdheSBydHc4OCBjb25m
aWd1cmVzIHRoZSBjaGlwLCBSVFdfUlhfREVTQ19XMF9EUlZfSU5GT19TSVpFIGlzDQo+IHN1cHBv
c2VkIHRvIGJlIGVpdGhlciAwIG9yIDQsIGJ1dCBpbiB0aGVzZSBmcmFtZXMgaXQgaGFzIG1hbnkg
b3RoZXINCj4gdmFsdWVzLg0KPiANCj4gSW4gdGhpcyBjYXNlOg0KPiANCj4gWyA5OTg2LjIxNDAy
Ml0gY2FjaHlvcy14ODY2NCBrZXJuZWw6IHJ0d184ODIxY2UgMDAwMDoxMzowMC4wOiB1bnVzZWQg
cGh5IHN0YXR1cw0KPiBwYWdlICgyKQ0KPiBbIDk5ODYuMjE0NTEyXSBjYWNoeW9zLXg4NjY0IGtl
cm5lbDogMDAwMDAwMDA6IDk1NTE1NTg4IDUwYWQ2NmQxIDg5M2YyNTJmDQo+IDc3ZWYzNWFlICAu
VVEuLmYuUC8lPy4uNS53DQo+IFsgOTk4Ni4yMTQ1NDRdIGNhY2h5b3MteDg2NjQga2VybmVsOiAw
MDAwMDAxMDogM2ZmZTFlMDAgNGQ2MjY4ODkgMDA0MDQyODgNCj4gNjg0YmM4OGMgIC4uLj8uaGJN
LkJALi4uS2gNCj4gWyA5OTg2LjIxNDU3Ml0gY2FjaHlvcy14ODY2NCBrZXJuZWw6IDAwMDAwMDIw
OiA2ODZjNjNkMSA1Yjk3MWNhNCAxY2E0Njg2Yw0KPiA3MzIwNWE5NyAgLmNsaC4uLltsaC4uLlog
cw0KPiBbIDk5ODYuMjE0NTk5XSBjYWNoeW9zLXg4NjY0IGtlcm5lbDogMDAwMDAwMzA6IDRhNjcw
MDAwDQo+IDAwMGIyMDAwICAgICAgICAgICAgICAgICAgICAuLmdKLiAuLg0KPiANCj4gdGhlIDgw
Mi4xMSBoZWFkZXIgaW1tZWRpYXRlbHkgZm9sbG93cyB0aGUgUlggZGVzY3JpcHRvciAodGhlcmUg
aXMNCj4gbm8gUEhZIHN0YXR1cywgd2hpY2ggaXMgbm90IHVudXN1YWwpIGJ1dCBSVFdfUlhfREVT
Q19XMF9QSFlTVCBpcyAxLg0KPiANCj4gSW4gc3RhdGlvbiBtb2RlIFJUV19SWF9ERVNDX1cxX01B
Q0lEIGlzIHN1cHBvc2VkIHRvIGJlIDAgb3IgMSAoSSB0aGluayksDQo+IG1vc3RseSAwLiBJbiB0
aGVzZSBmcmFtZXMgaXQgaGFzIG1hbnkgb3RoZXIgdmFsdWVzLg0KPiANCj4gUlRXX1JYX0RFU0Nf
VzBfUEtUX0xFTiBzb21ldGltZXMgZXhjZWVkcyAxMTQ1NC4gSW4gb25lIGNhc2UgaXQncyAwLg0K
PiANCj4gSW4gbWFueSBvZiB0aGVzZSBmcmFtZXMgYnl0ZXMgMjUuLjMxIGRvbid0IGxvb2sgbGlr
ZSBhIFBIWSBzdGF0dXMNCj4gb3IgODAyLjExIGhlYWRlci4NCj4gDQo+IElmIHdlIGNhbid0IGZp
bmQgdGhlIHJlYXNvbiBmb3IgdGhlc2Ugd2VpcmQgZnJhbWVzLCBtYXliZSB0aGUgYmVzdA0KPiB3
YXkgdG8gZmlsdGVyIHRoZW0gb3V0IGlzIHRvIGNoZWNrIFJUV19SWF9ERVNDX1cwX0RSVl9JTkZP
X1NJWkUuDQo+IEl0IHRha2VzIGNhcmUgb2YgNjcgb3V0IG9mIHRoZSA3NiB3ZWlyZCBmcmFtZXMg
aW4gZG1lc2dfYm9vdDBfY2xlYW4udHh0Lg0KDQoNCkFncmVlLiBJdCBsb29rcyBsaWtlIHdlIG5l
ZWQgbW9yZSB2YWxpZGF0aW9ucyB0byBkcm9wIHdlaXJkIGZyYW1lcy4NCg0KSSBoYXZlIG5ldmVy
IHNlZW4gbG90cyBvZiB0aGlzIGtpbmQgb2Ygd2VpcmQgZnJhbWVzIGJlZm9yZS4NCk9sZWtzYW5k
ciwgaXMgaXQgcG9zc2libGUgdG8gc3VtIHVwIHRoZSBjb25kaXRpb25zIHRoZXNlIHdlaXJkIGZy
YW1lcw0KaGFwcGVuZWQ/IHN1Y2ggYXMgZW50ZXIgTFBTPyB3aXRoIEJUIGRldmljZXM/IG9yIHNv
bWV0aGluZyBlbHNlLiANCg0KUGluZy1LZQ0KDQo=

