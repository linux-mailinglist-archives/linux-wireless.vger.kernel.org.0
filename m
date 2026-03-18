Return-Path: <linux-wireless+bounces-33367-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CcvMdD4uWkMQAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33367-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 01:58:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3562C2B4C0A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 01:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFCB3306740D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 00:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650BA21CA0D;
	Wed, 18 Mar 2026 00:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="S2OsSqXl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A908149C6F;
	Wed, 18 Mar 2026 00:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773795534; cv=none; b=niuLjIiy68ErA/fpIkbaYuUJ2IFTYXEymz51tAhB76OHAuRfkuv84qvJ4TJaxR0IJiG0UfHKpJ5118dCULr3s6VPCWYLpshJscAZ2eIOi9ABtNj0UZ4HVpJwPE6Q2wW/7LwOQuCfZgA9QGmp0D36hXnc2TVJvK5JKMaCibKeqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773795534; c=relaxed/simple;
	bh=YlTT5m2+thgBlad5I2qjDQPKVLambcx1RoJpX3rqyWI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T8Nh2PcoXT13yAgeGZOF5urtR4pAuFoWXLD0hTuJZ9dbyidnuPkTsUBUzz/eDkwogZogIF3IOdsihUbUoHE5nrgbH/ZTyzPac06clMLIXooRMuvlGjJURA/wE/P1m0LqVr4pqREbLkzFD2MAcsXnvRkXOLJFyr5t9CW2+M/AzAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=S2OsSqXl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62I0wmJM3781169, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773795528; bh=YlTT5m2+thgBlad5I2qjDQPKVLambcx1RoJpX3rqyWI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=S2OsSqXlB9Bg5aZ//FKhY48uqLBMY2abegEHAZY/k/QVJF7tqq97FBQXE9EF9vIu8
	 oEC+soogGBpLYyXebJu9Yw/PrO8RiHinybv4fjnj1uG1wcF+i7SQWNHfnZcUPo93V9
	 rMYKz53V4ArfTgjXDTQR+gGr8zgET6nmoT6w7M85eBXeMW0oqRHT8N68ypR5uRX6QX
	 FJwjgTykAbAFDWemktagLTsymEnEOq2rLbtprWURyog8WGw3joYyDH+sCeVEXp5B9N
	 eTQrdK4ceGRWzihbboi2nY9N7GZzw8gGs/G/QCWsE4Z1GH1fX6r9RpW2NZcI/EKdW3
	 lsZU6vNVkAg0g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62I0wmJM3781169
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 08:58:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 18 Mar 2026 08:58:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Wed, 18 Mar 2026 08:58:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: LB F <goainwo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Topic: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Index: AQHcsA6WTRRnBRFJhEKVxaR7JwwWq7Wm+M9wgAAbfgCAAX9nAIAAB6mAgAAK64CAAElZAIABMBnAgADMOgCAACdjAIAAB1+AgAJAYICAAB3nAIAAxOYAgAJBRiCAAKEnAIAA2QBQgAD06wCAAJVNMA==
Date: Wed, 18 Mar 2026 00:58:48 +0000
Message-ID: <cb32c1eefb614a8bb96ef6fe2c4f4989@realtek.com>
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com>
 <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
 <792645eed36041f0b3df951f1b28a08a@realtek.com>
 <e6720993c8c14245981432cfa4ae902b@realtek.com>
 <CALdGYqQn8GGXXjZTsL+a5Mfdmw5HRYB2Jyvqq5M5SUwxK9yd_g@mail.gmail.com>
 <CALdGYqQee1sjgdBAPJSyb1gL6ksK4z8Uw_v3ANTnyXE+LXFAiA@mail.gmail.com>
 <458ed80e39734ea99610050140bb31ce@realtek.com>
 <CALdGYqQykO9ZzO=-+D17R_8LC=Win5nGN6-9zFqChtNEyUzEfg@mail.gmail.com>
 <CALdGYqTHz5Pz3uSGLbrVuNMWAXaqniUCuOSQACXUYHSL22ySvw@mail.gmail.com>
 <CALdGYqQ5K0iuxjjX4TwNLi9Km5O+YL3Y9r6Bwfk9BaiuV3BHPA@mail.gmail.com>
 <CALdGYqRYVxGbg+qRNUvRNr9V4f2YVZ7p=amwq1ktdmZVkwxjQg@mail.gmail.com>
 <CALdGYqSq416qqqZ7t+wG5fir9NWfi3578+brdaj05q-42Gj14w@mail.gmail.com>
 <CALdGYqSf66mBiufysr3tjm74A_w98LRN50fik0U9WGVvkBJ_5g@mail.gmail.com>
 <1bd495ffe57c47eb827eec084729afa2@realtek.com>
 <CALdGYqSMUPnPfW-_q1RgYr0_SjoXUejAaJJr-o+jpwCk1S7ndQ@mail.gmail.com>
 <e5f00d0a42994812b42df867718fa087@realtek.com>
 <CALdGYqRbkV7_w7WDiqD-vYMa8MUFV7nSYz-=q2FzotgLHRy=HA@mail.gmail.com>
In-Reply-To: <CALdGYqRbkV7_w7WDiqD-vYMa8MUFV7nSYz-=q2FzotgLHRy=HA@mail.gmail.com>
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
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33367-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Queue-Id: 3562C2B4C0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TEIgRiA8Z29haW53b0BnbWFpbC5jb20+IHdyb3RlOg0KPiBQaW5nLUtlIFNoaWggPHBrc2hpaEBy
ZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4gVG8gcmVwcm9kdWNlIHRoaXMgcmVsaWFibGUsIHlvdSBu
ZWVkIHRvIHJlbW92ZSBkcml2ZXIga28gYW5kIG1hYzgwMjExLmtvLA0KPiA+IGFuZCByZWluc3Rh
bGwgdGhlbS4NCj4gPg0KPiA+IEhvd2V2ZXIsIHlvdSBoYXZlIGNvbmZpcm1lZCB0aGlzIGlzIHRo
ZSBzeW1wdG9tLiBJIHRoaW5rIG9ubHkgaWYgeW91DQo+ID4gd2FudCB0byBkaWcgd2h5IHRoZSBy
YXRlIHJlcG9ydGVkIGJ5IGhhcmR3YXJlIGlzIHdlaXJkLCBvdGhlcndpc2Ugd2UNCj4gPiBjYW4g
aWdub3JlIHRoaXMgd2FybmluZy4NCj4gDQo+IEZvbGxvd2luZyB5b3VyIHN1Z2dlc3Rpb24sIEkg
cGVyZm9ybWVkIGEgZnVsbCBzdGFjayByZWxvYWQgaW5jbHVkaW5nDQo+IG1hYzgwMjExLmtvIGFu
ZCBjZmc4MDIxMS5rbywgYW5kIHdhcyBhYmxlIHRvIHJlcHJvZHVjZSB0aGUgd2FybmluZzoNCj4g
DQo+ICAgWzE1Mi4yMjYwNTVdIFJhdGUgbWFya2VkIGFzIGEgVkhUIHJhdGUgYnV0IGRhdGEgaXMg
aW52YWxpZDogTUNTOiAwLCBOU1M6IDANCj4gICBbMTUyLjIyNjA1N10gV0FSTklORzogbmV0L21h
YzgwMjExL3J4LmM6NTQ5MSBhdA0KPiBpZWVlODAyMTFfcnhfbGlzdCsweDE3Ny8weDEwMjAgW21h
YzgwMjExXQ0KPiAgIFsxNTIuMjI2MzM2XSBDUFU6IDIgVUlEOiAwIFBJRDogNjM4IENvbW06IGly
cS81Ni1ydHdfcGNpIFRhaW50ZWQ6IEcNCj4gSU9FIDYuMTkuNy0xLWNhY2h5b3MNCj4gICBbMTUy
LjIyNjM0NF0gSGFyZHdhcmUgbmFtZTogSFAgSFAgTm90ZWJvb2svODFGMCwgQklPUyBGLjUwIDEx
LzIwLzIwMjANCj4gDQo+IE9uZSBvYnNlcnZhdGlvbiB3b3J0aCBtZW50aW9uaW5nOiB0aGUgd2Fy
bmluZyB0cmlnZ2VyZWQgYXBwcm94aW1hdGVseQ0KPiA3MiBzZWNvbmRzIGFmdGVyIGluaXRpYWwg
YXNzb2NpYXRpb24sIGNvaW5jaWRpbmcgd2l0aCBhIEJsdWV0b290aA0KPiBkZXZpY2UgY29ubmVj
dGluZyB0byB0aGUgc3lzdGVtLiBUaGlzIG1heSBzdWdnZXN0IHRoZSBOU1M9MCBjb25kaXRpb24N
Cj4gb2NjdXJzIGR1cmluZyBCVCBjb2V4aXN0ZW5jZSBuZWdvdGlhdGlvbiByYXRoZXIgdGhhbiBk
dXJpbmcgbm9ybWFsDQo+IFdpRmkgdHJhZmZpYy4gSSBhbSBub3Qgc3VyZSBpZiB0aGlzIGlzIHJl
bGV2YW50LCBidXQgSSB3YW50ZWQgdG8NCj4gbWVudGlvbiBpdCBpbiBjYXNlIGl0IGhlbHBzIG5h
cnJvdyBkb3duIHRoZSByb290IGNhdXNlLg0KPiANCj4gSSBhbHNvIG5vdGljZWQgdGhlIG9mZnNl
dCBpcyBub3cgKzB4MTc3LCB3aGljaCBtYXRjaGVzIGV4YWN0bHkgd2hhdA0KPiB5b3Ugc2hvd2Vk
IGZyb20gdjYuMTkuNi4gVGhlIGVhcmxpZXIgKzB4MTgzIHdhcyBsaWtlbHkgYW4gYXJ0aWZhY3Qg
b2YNCj4gQ2FjaHlPUydzIExUTyBvcHRpbWl6YXRpb25zIHdoaWxlIG1hYzgwMjExIGhhZCBiZWVu
IHJlc2lkZW50IGZvciBhDQo+IGxvbmcgdGltZS4NCj4gDQo+IEFzIHlvdSBub3RlZCwgdGhpcyBh
cHBlYXJzIHRvIGJlIGEgc2VwYXJhdGUgaXNzdWUgZnJvbSB0aGUgZnJlZXplIGFuZA0KPiBoMmMg
dGltZW91dCBwcm9ibGVtcywgc28gSSBsZWF2ZSBpdCB0byB5b3VyIGp1ZGdtZW50IHdoZXRoZXIg
aXQNCj4gd2FycmFudHMgZnVydGhlciBpbnZlc3RpZ2F0aW9uLg0KDQpJIGFkZCBhIHByaW50ayB0
byBzaG93IHRoZSBjYXNlIFZIVCBhbmQgTlNTPT0wIGFzIGJlbG93LiBQbGVhc2UgaGVscCB0bw0K
Y29sbGVjdCB0aGUgb3V0cHV0LCBhbmQgdGhlbiBJIGNhbiBzZWUgd2hhdCBpdCBoYXBwZW5lZC4g
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J4LmMg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J4LmMNCmluZGV4IDhiMGFmYWFm
ZmFhMC4uYTRlM2EzYmNlNzQ4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OC9yeC5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4
L3J4LmMNCkBAIC0yMzAsNiArMjMwLDExIEBAIHN0YXRpYyB2b2lkIHJ0d19yeF9maWxsX3J4X3N0
YXR1cyhzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJnJ4X3N0YXR1cy0+bnNzKTsNCiAgICAgICAgfQ0KDQorICAgICAgIGlmIChyeF9z
dGF0dXMtPmVuY29kaW5nID09IFJYX0VOQ19WSFQgJiYgcnhfc3RhdHVzLT5uc3MgPT0gMCkgew0K
KyAgICAgICAgICAgICAgIHByaW50aygiVkhUIE5TUz0wIHBrdF9zdGF0LT5yYXRlPTB4JXggcnhf
c3RhdHVzLT5iYW5kPSVkIHJ4X3N0YXR1cy0+cmF0ZV9pZHg9JWRcbiIsDQorICAgICAgICAgICAg
ICAgICAgICAgICBwa3Rfc3RhdC0+cmF0ZSwgcnhfc3RhdHVzLT5iYW5kLCByeF9zdGF0dXMtPnJh
dGVfaWR4KTsNCisgICAgICAgfQ0KKw0KICAgICAgICByeF9zdGF0dXMtPmZsYWcgfD0gUlhfRkxB
R19NQUNUSU1FX1NUQVJUOw0KICAgICAgICByeF9zdGF0dXMtPm1hY3RpbWUgPSBwa3Rfc3RhdC0+
dHNmX2xvdzsNCg0KPiANCj4gLS0tDQo+IA0KPiBJIHdvdWxkIGxpa2UgdG8gdGFrZSB0aGlzIG9w
cG9ydHVuaXR5IHRvIHRoYW5rIHlvdSBzaW5jZXJlbHkgZm9yIHlvdXINCj4gdGltZSwgcGF0aWVu
Y2UsIGFuZCBleHBlcnRpc2UgdGhyb3VnaG91dCB0aGlzIHdob2xlIHByb2Nlc3MuIEZyb20geW91
cg0KPiB2ZXJ5IGZpcnN0IHJlc3BvbnNlIHRvIHRoZSBmaW5hbCB2MiBwYXRjaCwgeW91ciBndWlk
YW5jZSBtYWRlIGl0DQo+IHBvc3NpYmxlIHRvIHByb3Blcmx5IGlkZW50aWZ5IGFuZCByZXNvbHZl
IGEgYnVnIHRoYXQgaGFkIGJlZW4gY2F1c2luZw0KPiByZWFsIGZydXN0cmF0aW9uIGZvciB1c2Vy
cyBvZiB0aGlzIGhhcmR3YXJlIGZvciBhIGxvbmcgdGltZS4NCg0KSSBhbHNvIHRoYW5rcyBmb3Ig
eW91ciB0aW1lIGFuZCBoZWxwLiA6KQ0KDQpQaW5nLUtlDQoNCg==

