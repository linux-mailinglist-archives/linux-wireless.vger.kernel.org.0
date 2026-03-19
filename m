Return-Path: <linux-wireless+bounces-33443-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGUODGNQu2lMigIAu9opvQ
	(envelope-from <linux-wireless+bounces-33443-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 02:24:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE032C463D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 02:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 254BF3022977
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 01:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65271C84A6;
	Thu, 19 Mar 2026 01:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="CQtDm/d5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C3540DFC9;
	Thu, 19 Mar 2026 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773883488; cv=none; b=WXMikqM07aaZ2TQfR9YmBav6f95ln28MprvmNphmjQpJrsNkRw2Mker7yHiyDcbdYbg7raUW9xIYC+78K3vjxXnk68lP8JvtIoOkNRHXfGmdIH9zV6VV/tBe+BR/4qBpbMRGPJFY3TiPXRgC19+ZFLR2fMzzdfx0pjcNDGK+JEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773883488; c=relaxed/simple;
	bh=8ubf7Oesv3USwYPbNYGyX0FFkvUmf6jc0413p3Ox4g0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QpMJwV1VmFoJ+VIU3pBVmeOcybxG6batmZaAPZgDe9V3iwbHlClNEoCPQSM5vXSqRGmOSx1NGvuGVRiRb/JKSL0qsob6tUed/cMkOg2R3p19BF8seLF+++n7fS2KHqDTrSkTcfmnSepcI0kKJR4vRHvjhjdZBa3RK1huuwgQxi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CQtDm/d5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62J1OhcL62754076, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773883483; bh=8ubf7Oesv3USwYPbNYGyX0FFkvUmf6jc0413p3Ox4g0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=CQtDm/d5A+zF1whYp6ZP1q6TSHbTUol1yZSv9C9apwvBaQbmdWK8lbGqgyraHh0pZ
	 SHtZlDSL1m6MdkBVsmxvUZVbL47zTeAeUJQOOdgF2w3X0U10wthovpjdryfIS/jkcS
	 k0UZWuyKl8LAM13DIwtY9iUntdACa7rgVSkJnpGZRd06H0NH7FTTHjDnssF7aNWLvf
	 vxqFK/348wAeTNW4Q2sjWJd+BiA9pii998jsGErrXNwbxwU1nlBbR3S+hSUf5KqVUy
	 ZbRQIqXcRFG9NL4r453Bmik+B8HfCqid7+M+e3iTdiDAwt6zqysy0PRqmmWb4F5p0l
	 G33s2xOFz6fYw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62J1OhcL62754076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 09:24:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 19 Mar 2026 09:24:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Thu, 19 Mar 2026 09:24:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: LB F <goainwo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Topic: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Index: AQHcsA6WTRRnBRFJhEKVxaR7JwwWq7Wm+M9wgAAbfgCAAX9nAIAAB6mAgAAK64CAAElZAIABMBnAgADMOgCAACdjAIAAB1+AgAJAYICAAB3nAIAAxOYAgAJBRiCAAKEnAIAA2QBQgAD06wCAAJVNMIAA+6oAgACVvSA=
Date: Thu, 19 Mar 2026 01:24:42 +0000
Message-ID: <dbe78a09fafe4a0ab16cd691049896a8@realtek.com>
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
 <cb32c1eefb614a8bb96ef6fe2c4f4989@realtek.com>
 <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
In-Reply-To: <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33443-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
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
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Queue-Id: 8CE032C463D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TEIgRiA8Z29haW53b0BnbWFpbC5jb20+IHdyb3RlOg0KPiBQaW5nLUtlIFNoaWggPHBrc2hpaEBy
ZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4gSSBhZGQgYSBwcmludGsgdG8gc2hvdyB0aGUgY2FzZSBW
SFQgYW5kIE5TUz09MCBhcyBiZWxvdy4gUGxlYXNlIGhlbHAgdG8NCj4gPiBjb2xsZWN0IHRoZSBv
dXRwdXQsIGFuZCB0aGVuIEkgY2FuIHNlZSB3aGF0IGl0IGhhcHBlbmVkLg0KPiANCj4gSGkgUGlu
Zy1LZSwNCj4gDQo+IEkgYXBwbGllZCB5b3VyIGRpYWdub3N0aWMgcGF0Y2ggKHVzaW5nIHByX2Vy
ciBmb3IgbWF4aW11bSBsb2cNCj4gdmlzaWJpbGl0eSkgYW5kIHNwZW50IHRoZSBsYXN0IGNvdXBs
ZSBvZiBkYXlzIHRlc3RpbmcgaXQgb24gdGhlDQo+IGFmZmVjdGVkIGhhcmR3YXJlLiBUaGUgcmVz
dWx0cyBhbnN3ZXIgYm90aCBvcGVuIHF1ZXN0aW9ucyBjbGVhbmx5Lg0KPiANCj4gLS0tDQo+IA0K
PiBSZWdhcmRpbmcgeW91ciBlYXJsaWVyIHF1ZXN0aW9uOg0KPiA+IE5vdCBzdXJlIGlmIHRoaXMg
aXMgYmVjYXVzZSBQQ0lFIGJyaWRnZSBoYXMgbm8gQVNQTSBjYXBhYmlsaXR5Pw0KPiANCj4gWW91
IHdlcmUgY29ycmVjdC4gVGhlIHZlcnkgYmVnaW5uaW5nIG9mIHRoZSBib290IGxvZyBzaG93czoN
Cj4gDQo+ICAgWzAuMTc3ODcyXSBBQ1BJIEZBRFQgZGVjbGFyZXMgdGhlIHN5c3RlbSBkb2Vzbid0
IHN1cHBvcnQgUENJZSBBU1BNLA0KPiAgICAgICAgICAgICAgIHNvIGRpc2FibGUgaXQNCj4gICBb
MTUuMTU3NzUyXSByODE2OSAwMDAwOjA3OjAwLjA6IGNhbid0IGRpc2FibGUgQVNQTTsgT1MgZG9l
c24ndCBoYXZlDQo+ICAgICAgICAgICAgICAgIEFTUE0gY29udHJvbA0KPiANCj4gVGhlIEJJT1Mg
b24gdGhpcyBIUCBsYXB0b3AgdXNlcyB0aGUgQUNQSSBGQURUIHRhYmxlIHRvIGdsb2JhbGx5IHJl
dm9rZQ0KPiBPUyBjb250cm9sIG92ZXIgUENJZSBBU1BNIGJlZm9yZSBMaW51eCBldmVuIHRha2Vz
IG92ZXIuIFRoaXMgaGFzIGFuDQo+IGltcG9ydGFudCBpbXBsaWNhdGlvbjogc2luY2UgQVNQTSBp
cyBhbHJlYWR5IGRpc2FibGVkIGF0IHRoZSBoYXJkd2FyZQ0KPiBsZXZlbCBieSBmaXJtd2FyZSwg
dGhlIGluc3RhYmlsaXR5IG9uIHRoaXMgc3BlY2lmaWMgU0tVIGlzIGNhdXNlZA0KPiBlbnRpcmVs
eSBieSBMUFMgRGVlcCBNb2RlLCBub3QgQVNQTSBpdHNlbGYuDQoNCkNoZWNraW5nIHJ0dzg4IGNv
ZGUgcmVsYXRlZCB0byBydHdfcGNpX2Rpc2FibGVfYXNwbSwgSSBmb3VuZCB0aGF0IGRyaXZlcg0K
ZG9lcyBjaGVjayBkZXZpY2UgQVNQTSBjYXBhYmlsaXR5IGJlZm9yZSBjb25maWd1cmluZyBBU1BN
LiBJdCBsb29rcyANCmEgbGl0dGxlIHdlaXJkIHdoeSBPUyBkb2Vzbid0IHR1cm4gb2ZmIHRoZXNl
IGNhcGFiaWxpdGllcyBvZiBkZXZpY2UuDQpNYXliZSB3ZSBzaG91bGQgY2hlY2sgdGhlIGNhcGFi
aWxpdGllcyBvZiBQQ0kgYnJpZGdlIHNpZGU/IA0KDQo+IA0KPiBUaGlzIGV4cGxhaW5zIHdoeSB0
aGUgQVNQTS1vbmx5IHF1aXJrICh2MSBwYXRjaCkgZGlkIG5vdCBzdG9wIHRoZSBoMmMNCj4gdGlt
ZW91dHMgLS0gQVNQTSB3YXMgbmV2ZXIgYWN0dWFsbHkgYWN0aXZlIG9uIHRoaXMgbWFjaGluZSB0
byBiZWdpbg0KPiB3aXRoLiBEaXNhYmxpbmcgTFBTIERlZXAgTW9kZSB2aWEgdGhlIHYyIHF1aXJr
IGlzIHdoYXQgZWxpbWluYXRlcyB0aGUNCj4gZmlybXdhcmUgdGltZW91dCBsb29wIGVudGlyZWx5
Lg0KDQpJIHRoaW5rIHRoZXJlIGFyZSB0d28gcHJvYmxlbXMuIE9uZSBpcyBBU1BNIGNhdXNpbmcg
c3lzdGVtIGZyb3plbiwgYW5kDQp0aGUgb3RoZXIgaXMgTFBTIGRlZXAgbW9kZSBjYXVzaW5nIEgy
QyB0aW1lb3V0cy4gSWYgeW91IHR1cm4gb24gQVNQTQ0KYW5kIGRpc2FibGUgTFBTIGRlZXAgbW9k
ZSwgSSBmZWVsIEgyQyB0aW1lb3V0IGNhbiBkaXNhcHBlYXIsIGJ1dCBpdA0KbWlnaHQgZ28gZnJv
emVuIGZpcnN0IHRob3VnaC4gDQoNClBpbmctS2UNCg0K

