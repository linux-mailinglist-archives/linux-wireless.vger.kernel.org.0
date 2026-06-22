Return-Path: <linux-wireless+bounces-37962-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LoEyKj7VOGoliwcAu9opvQ
	(envelope-from <linux-wireless+bounces-37962-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 08:25:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C262B6ACF04
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 08:25:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=ci8qyPP9;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37962-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37962-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9763E301702B
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 06:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B3A35E1C8;
	Mon, 22 Jun 2026 06:25:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8823546C0;
	Mon, 22 Jun 2026 06:24:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782109500; cv=none; b=YisARWfEs8nffe14Y2dDRJva+oB+m7X1vhsEkehn9A+1OHul4JVOUARudhW5U4603B5yvXds+QAj9Q5ySNQ2FxXwAsBkwGRYwHIpc5L6wQ/iLLeBQW9oL738CeYWyocRfBbbAn7e6QURtrLRSTzse7kMZc5G8RYQXxgVMkeyyjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782109500; c=relaxed/simple;
	bh=fV2UcBA/1SwV/7dyaY+J3rocD/sCI7vscBKLjV1EY0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b7vmcEApO0OXGnHWww7wDF+aixDkQhzmbhFVuvMSgPBhXKorkMHJL72NRDHYa0QunIpGsVLijBaNUGXcJGnPNOPboMy0K2DvCX5bPYz8XsHMabq/lXqELnUcB7p7gk0WgI5/HlAv4EOOjDC0AvR8q0B/30tIbAcv+OXWShL4AR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ci8qyPP9; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65M6OrBoA2277287, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782109493; bh=fV2UcBA/1SwV/7dyaY+J3rocD/sCI7vscBKLjV1EY0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ci8qyPP9+wbtjHGLZOaZWch1V4XOMsHfV+5pGiGFjpYko4ZUv8ALwaQ6Zs3G5KEtx
	 eBulv+1fOUIx/XTQwHu/QRTRf85yCyCjUUDKQ5v1/FuYQBfgf6SjAKkiSwmJc1Kk//
	 EBYqsZa29bg2skRO16sEDPmcX18NkcaJ/rWQVFE3HEITYtEahX438mYfTLoVEE+mNU
	 Mj7lVuNm4sGQW/AmvUExwc15olrVYVC93PoHPKpNU+lAjleSX4XIV/GtWSNBgT0qr+
	 IR+vjriZuVC12YSALzIZ/+4YUgymKFBI1RyiHkh+rHimg2zUyDTXrENlYKif3V429H
	 BAccl/XLL4UYg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65M6OrBoA2277287
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jun 2026 14:24:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Jun 2026 14:24:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Jun 2026 14:24:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 22 Jun 2026 14:24:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Lucas Tanure <lucas.tanure@neat.no>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Krzysztof
 Opasiak" <krzysztof.opasiak@neat.no>, =?utf-8?B?QW5kZXJzIFLDuG5uaW5nZW4=?=
	<anders@neat.no>, Hilda Wu <hildawu@realtek.com>, Max Chou
	<max.chou@realtek.com>
Subject: RE: wifi: rtw88: 8822cs/bs: Issues migrating RTL8822CS/BS from
 downstream to upstream driver
Thread-Topic: wifi: rtw88: 8822cs/bs: Issues migrating RTL8822CS/BS from
 downstream to upstream driver
Thread-Index: AQHc/M6yNX20ldC4UEmoq6jLtFqOPbZAXPhggAAim4CAAv6acA==
Date: Mon, 22 Jun 2026 06:24:53 +0000
Message-ID: <fc896e3ad87541dbbb76caa8e48d23bf@realtek.com>
References: <CALt7t=EDVdn7eGbXgXWU8rgbek52+frbbeYMHwzbH7J0xGXWzg@mail.gmail.com>
 <049000e56f004b4b9d58b74eaed17aef@realtek.com>
 <CALt7t=G_ssGBb1i+knq1_tbcpwi_TcrK+7GBMH3vNLQ3+rcetA@mail.gmail.com>
In-Reply-To: <CALt7t=G_ssGBb1i+knq1_tbcpwi_TcrK+7GBMH3vNLQ3+rcetA@mail.gmail.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37962-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lucas.tanure@neat.no,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzysztof.opasiak@neat.no,m:anders@neat.no,m:hildawu@realtek.com,m:max.chou@realtek.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C262B6ACF04

THVjYXMgVGFudXJlIDxsdWNhcy50YW51cmVAbmVhdC5ubz4gd3JvdGU6DQo+IEhpIFBpbmctS2Us
DQo+IA0KPiBPbiBUdWUsIEp1biAxNiwgMjAyNiBhdCA0OjMw4oCvQU0gUGluZy1LZSBTaGloIDxw
a3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGksDQo+ID4NCj4gPiBMdWNhcyBU
YW51cmUgPGx1Y2FzLnRhbnVyZUBuZWF0Lm5vPiB3cm90ZToNCj4gPiA+IEhpIFBpbmctS2UsDQo+
ID4gPg0KPiA+ID4gV2UgYXJlIGJyaW5naW5nIHVwIGFuIFJUTDg4MjJCUyAvIFJUTDg4MjJDUyBj
b21ibyBvbiBhIFJvY2tjaGlwIFBYMzANCj4gPiA+IGJvYXJkIChrZXJuZWwgNi4xLjExOCksIFdp
LUZpIG92ZXIgU0RJTywgQlQgb24gdGhlIHNhbWUgZGllIG92ZXIgVUFSVA0KPiA+ID4gdmlhIGJ0
cnRsICsgaGNpX2g1Lg0KPiA+ID4NCj4gPiA+IFdlJ3JlIGRlbGliZXJhdGVseSBtaWdyYXRpbmcg
b2ZmIFJlYWx0ZWsncyBvdXQtb2YtdHJlZSBTRElPIHZlbmRvcg0KPiA+ID4gZHJpdmVyIHRvIG1h
aW5saW5lIHJ0dzg4OiB0aGUgdmVuZG9yIGRyaXZlciBoaXRzIG1lbW9yeS1jb3JydXB0aW9uDQo+
ID4gPiBidWdzIHdlJ3ZlIGJlZW4gdW5hYmxlIHRvIGdldCBzdXBwb3J0IG9uLCBhbmQgbWFpbmxp
bmUgaXMgdGhlIGJldHRlcg0KPiA+ID4gbG9uZy10ZXJtIHBhdGguDQo+ID4gPiBUaGF0IG1pZ3Jh
dGlvbiBsZWF2ZXMgdXMgdHdvIGdhcHMgSSdkIGFwcHJlY2lhdGUgeW91ciBndWlkYW5jZSBvbjoN
Cj4gPiA+DQo+ID4gPiAxKSBQb3dlci1wYXJhbWV0ZXIgdGFibGVzLiBNYWlubGluZSBjYXJyaWVz
IHRoZSBUWC1wb3dlciBkYXRhIGFzIGdlbmVyYXRlZA0KPiA+ID4gICAgQyBhcnJheXMgaW4gcnR3
ODh4eGNfdGFibGUuYywgd2hpbGUgdGhlIHZlbmRvciBkcml2ZXIgc2hpcHMgdGhlIHNhbWUNCj4g
PiA+ICAgIGRhdGEgYXMgdGV4dCBmaWxlcy4NCj4gPiA+DQo+ID4gPiAgICBUaGUgVFgtcG93ZXIg
bGltaXRzIGxvb2sgbGlrZSB0aGlzIChUWFBXUl9MTVQudHh0KToNCj4gPiA+DQo+ID4gPiAgICAg
ICAgIyMgIDIuNEcsIDIwTSwgMVQsIENDSywgLy8oMU07Mk07NS41TTsxMU0pDQo+ID4gPiAgICAg
ICAgIyMgIFNUQVJUDQo+ID4gPiAgICAgICAgIyMgICMzIyAgRkNDICBFVFNJICBNS0sNCj4gPiA+
ICAgICAgICBDSDAxICAxNiAgMTUgIDE1DQo+ID4gPiAgICAgICAgQ0gwMiAgMTYgIDE1ICAxNQ0K
PiA+ID4gICAgICAgICMjICBFTkQNCj4gPg0KPiA+IFRoZSB0b29sIGZyb20gLnR4dCB0byBDIGFy
cmF5cyBmb3IgdmVuZG9yIGRyaXZlciBpcyBub3QgbWFpbnRhaW5lZCBieSBteSB0ZWFtLA0KPiA+
IGJ1dCBJIHRoaW5rIGl0IGlzbid0IHRvbyBoYXJkIHRvIHVzZSBBSSB0b29sIHRvIGNvbnZlcnQg
dGhlIGZvcm1hdC4NCj4gDQo+IElmIFJlYWx0ZWsgaGFzIGFuIGludGVybmFsIC50eHQgLT4gQyBj
b252ZXJzaW9uIHRvb2wsIGNvdWxkIHlvdSBzaGFyZSBpdD8NCj4gT3RoZXJ3aXNlLCBjb3VsZCB5
b3UgcHV0IHVzIGluIGNvbnRhY3Qgd2l0aCB0aGUgdGVhbSB0aGF0IGNhbiB2ZXJpZnkNCj4gb3Vy
IGNvbnZlcnRlZCB0YWJsZXM/DQoNClRoZSBiZXR0ZXIgd2F5IGlzIHRvIGNoZWNrIGhvdyB2ZW5k
b3IgZHJpdmVyIGNvbnZlcnQgLnR4dCBpbnRvIGRyaXZlciwgYW5kDQp3aGF0IGl0IHdyaXRlcyB0
byByZWdpc3RlcnMuDQoNCj4gDQo+ID4NCj4gPiBUaGUgQyBhcnJheSBmcm9tIHZlbmRvciBkcml2
ZXIgdG8gcnR3ODggc3RydWN0IGlzIGFsc28gYSBzaW1wbGUgY29udmVyc2lvbg0KPiA+IHlvdSBj
YW4gdXNlIEFJIHRvIGFzc2lzdCB0aGlzLg0KPiA+DQo+ID4gSWYgeW91IGhhdmUgdHJhY2VkIHJ0
dzg4LCB0aGUgc3RydWN0IGZvciBUWCBwb3dlciBsaW1pdCBpczoNCj4gPg0KPiA+IHN0cnVjdCBy
dHdfdHhwd3JfbG10X2NmZ19wYWlyIHsNCj4gPiAgICAgICAgIHU4IHJlZ2Q7DQo+ID4gICAgICAg
ICB1OCBiYW5kOw0KPiA+ICAgICAgICAgdTggYnc7DQo+ID4gICAgICAgICB1OCByczsNCj4gPiAg
ICAgICAgIHU4IGNoOw0KPiA+ICAgICAgICAgczggdHhwd3JfbG10Ow0KPiA+IH07DQo+ID4NCj4g
PiA+DQo+ID4gPiAgICBhbmQgdGhlIHBvd2VyLWJ5LXJhdGUgbGlrZSB0aGlzIChQSFlfUkVHX1BH
LnR4dCk6DQo+ID4gPg0KPiA+ID4gICAgICAgICNbMi40R11bQV0jDQo+ID4gPiAgICAgICAgWzFU
eF0gMHhjMjAgIDB4ZmZmZmZmZmYgIDE4IDE5IDE5IDE5ICAvLyB7MTFNIDUuNU0gMk0gMU19DQo+
ID4gPiAgICAgICAgWzFUeF0gMHhjMjQgIDB4ZmZmZmZmZmYgIDE4IDE4IDE4IDE4ICAvLyB7MThN
IDEyTSA5TSA2TX0NCj4gPg0KPiA+IFRYIHBvd2VyIGJ5IHJhdGUgaXM6DQo+ID4NCj4gPiBzdHJ1
Y3QgcnR3X3BoeV9wZ19jZmdfcGFpciB7DQo+ID4gICAgICAgICB1MzIgYmFuZDsNCj4gPiAgICAg
ICAgIHUzMiByZl9wYXRoOw0KPiA+ICAgICAgICAgdTMyIHR4X251bTsNCj4gPiAgICAgICAgIHUz
MiBhZGRyOw0KPiA+ICAgICAgICAgdTMyIGJpdG1hc2s7DQo+ID4gICAgICAgICB1MzIgZGF0YTsN
Cj4gPiB9Ow0KPiA+DQo+ID4gPg0KPiA+ID4gICAgSXMgdGhlcmUgYW55IHdheSB0byBjb252ZXJ0
IHRoZXNlIC5UWFQgZmlsZXMgaW50byB0aGUgQyB0YWJsZXM/IEl0DQo+ID4gPiBzZWVtcyB0aGUg
dmVuZG9yIGRyaXZlciBhbmQgdGhlIG1haW5saW5lIGRyaXZlciBwb3dlciBjb25maWd1cmF0aW9u
DQo+ID4gPiBkb24ndCBoYXZlIGFueXRoaW5nIGluIGNvbW1vbi4NCj4gPg0KPiA+IFRoZSBwdXJw
b3NlIGlzIGRpZmZlcmVudC4gVGhlIC5UWFQgaXMgZnJvbSBodW1hbiBwb2ludCBvZiB2aWV3IHRv
IGJlIGVhc2llcg0KPiA+IHRvIGZpbGwgY2FsaWJyYXRpb24gZGF0YSBvbmUgYnkgb25lLiBUaGUg
ZGVzaWduIG9mIEMgYXJyYXlzIGlzIHRvIGxvb2sgdXAgdGFibGUNCj4gPiBxdWlja2x5IChpdCBp
c24ndCBzbyBxdWlja2x5IHRob3VnaCkuDQo+IA0KPiBJIHVzZWQgQ2xhdWRlLCBhbmQgaXQgY29u
dmVydGVkIG91ciB2ZW5kb3IgVFhQV1JfTE1ULnR4dCAvDQo+IFBIWV9SRUdfUEcudHh0IGludG8g
dGhlIHJ0dzg4IEMgYXJyYXlzLg0KPiBIZXJlIGlzIGV4YWN0bHkgaG93IENsYXVkZSBkaWQgaXQg
LSBwbGVhc2UgdGVsbCB1cyBpZiBhbnkgc3RlcCBpcyB3cm9uZy4NCj4gDQo+IFJvdyBtYXBwaW5n
IChvbmUgVFhQV1JfTE1ULnR4dCBsaW5lIC0+IHJ0d190eHB3cl9sbXRfY2ZnX3BhaXIgcm93cyk6
DQo+ICAgaGVhZGVyICIjIyAyLjRHLCAyME0sIDFULCBDQ0siICArICAiQ0gwMSAgMTYgIDE1ICAx
NSIgICAoY29sdW1ucyBGQ0MgRVRTSSBNS0spDQo+ICAgICAtPiAgeyAwLCAwLCAwLCAwLCAxLCA2
NCB9ICAgIEZDQyAgKHJlZ2QgMCkNCj4gICAgICAgICB7IDIsIDAsIDAsIDAsIDEsIDYwIH0gICAg
RVRTSSAocmVnZCAyKQ0KPiAgICAgICAgIHsgMSwgMCwgMCwgMCwgMSwgNjAgfSAgICBNS0sgIChy
ZWdkIDEpDQo+ICAgT25lIGxpbmUgLT4gMyByb3dzIChvbmUgcGVyIHJlZ3VsYXRvcnkgY29sdW1u
KS4gRmllbGRzIHtyZWdkLCBiYW5kLA0KPiBidywgcnMsIGNoLA0KPiAgIHZhbHVlfTogcmVnZCBG
Q0MvTUtLL0VUU0kgPSAwLzEvMjsgYmFuZC9idy9ycyBjb21lIGZyb20gdGhlIGhlYWRlcjsNCj4g
dmFsdWUgPSBkQm0qVS4NCj4gDQo+IFVuaXQgKHZhbHVlID0gcmVhbF9kQm0gKiBVKToNCj4gICA4
ODIyYywgVT00IChtYXhfcG93ZXJfaW5kZXggMHg3Zik6DQo+ICAgICAgIGJiX3BnIDB4YzIwID0g
MHg0ODRjNTA1NCA9IHsxOCwxOSwyMCwyMX0gICAgICAoMHg0OD03Mj0xOCo0KQ0KPiAgICAgICB0
eHB3cl9sbXQgRVRTSS9DQ0svY2gxID0gNjAgPSAxNSBkQm0NCj4gICA4ODIyYiwgVT0yIChtYXhf
cG93ZXJfaW5kZXggMHgzZik6DQo+ICAgICAgIHR4cHdyX2xtdCBGQ0MvQ0NLL2NoMSA9IDMyID0g
MTYgZEJtDQo+ICAgQm90aCBlcXVhbCBvdXIgdmVuZG9yIC50eHQgKHJlYWwgZEJtKSwgc28gdHhw
d3JfbG10ID0gZEJtICogVSBhbmQNCj4gICBiYl9wZyBieXRlID0gY29kZXdvcmQgKiBVIChwYWNr
ZWQgaGlnaC0+bG93KS4NCj4gDQo+IElzIHRoaXMgY29ycmVjdD8NCg0KSSBkb24ndCByZW1lbWJl
ciB0aGUgZXhhY3QgdW5pdHMgdGhlc2UgY2hpcHMgdXNlLiBCeSB0aGUgcnR3ODggZHJpdmVyLA0K
ICAudHhnaV9mYWN0b3IgPSAxIC8gMiBmb3IgUlRMODgyMkIgYW5kIFJUTDg4MjJDDQpTbyBJIHRo
aW5rIHRoZSB1bml0cyBhcmUgY29ycmVjdC4gDQoNCkZvciBUWCBwb3dlciB1bml0LCBJIHJlbWVt
YmVyIGl0IGlzIG5vdCBkQm0sIGJ1dCB3aXRoIGFuIG9mZnNldCwgc28geW91IGNhbg0KZmluZCBm
dW5jdGlvbiBuYW1lcyBvZiBkcml2ZXIgY2FsbGluZyAqX3Bvd2VyX2luZGV4XyouIEJ1dCB0cmVh
dGluZyBpdCBpbg0KdW5pdCBvZiBkQm0gd291bGQgYmUgZWFzaWVyIHRvIHVuZGVyc3RhbmQuDQoN
Cg0KSSB0aGluayB0aGUgYnVpbHQtaW4gdGFibGVzIGluIGRyaXZlciBhcmUgdmVyeSBzaW1pbGFy
IHRvIHRoZSB0YWJsZXMgeW91DQpjb252ZXJ0ZWQgZnJvbSAudHh0LiBJJ2Qgc3VnZ2VzdCB1c2lu
ZyBBSSB0byBjb21wYXJlIHRoZWlyIGRpZmZlcmVuY2UgYXMNCmEgdmFsaWRhdGlvbiAtLSB0aGUg
ZGlmZmVyZW5jZSAoVFggcG93ZXIgaW4gZEIpIHdpbGwgYmUgc21hbGwgKGFib3V0IDENCm9yIDIg
ZEIuIEkgZ3Vlc3MpLg0KDQoNCg==

