Return-Path: <linux-wireless+bounces-33319-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BOGKkSuuGmHhgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33319-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 02:28:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7712A2897
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 02:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33D993009B3D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 01:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1219312831;
	Tue, 17 Mar 2026 01:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Is/48AbZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAEF4964F;
	Tue, 17 Mar 2026 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773710908; cv=none; b=NtY2JocXRpggufUqAJmvjScSVdYejr6Zx8fY5JNO4b3mHTGcdzSPxevzdSNZftxBbWgPxsSiSrTpwOkaxdLVG8YqGCjOrBMesPjJoYBQwHGa0K4EEwT6WZvLvf1mB6JZamxNk9/kRpTBvjQV2mQhoWWmt8XDzeJ9i4/tydS1Hu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773710908; c=relaxed/simple;
	bh=u3p/cDG65g3Mc9K3IzByF9exx3XeqEBRdpbPThTXbTA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G1K1SU9lK60Zss/QuAUaW90PKLah0lrcIdKHh+a8phdVpg94KMsVHz3UgxCrT6kgnkqxTcJhhX8NHBW2WfR9BOmhnn5dIa9eNeGfksPeql12UtOx6SZ2ctRE0OI3OEZZmSqExflNWfBraK3gChN/WlRCMrrL3VqyGmY+N9eOOUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Is/48AbZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62H1SLrqC2984330, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773710902; bh=u3p/cDG65g3Mc9K3IzByF9exx3XeqEBRdpbPThTXbTA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Is/48AbZxxHNjL7X+/yCEg9sUYlKDglWjmpdKzfjMCTpy2vCifvS5BHDJCbZstKYk
	 WsbpG6NDPqAefnUrbG7FvCm4P4/Xtl1E6Eb+SYB7CnSp0RCtS/2Qaa/z99accyx4Lp
	 cOK7Mm8V7wnCxsi2JLAAIBmIHHraoBx9/1xW4L82RfiXYBcAIz5hJ40Z80VRHAktWv
	 P2g2mxqKZWs/kTWoov7YDPyd97IUpArQ82SPYjxTRxvSqtLsT/RCi3qoMoSxjthtHg
	 naD2sI2NqZ8LJQp/wp2y+IM29KQrj+gOBgrE0WAk0nwMnsDlp76jeAqmz6AKEwMnhz
	 gEgCfe7c34t0g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62H1SLrqC2984330
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 09:28:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 17 Mar 2026 09:28:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Tue, 17 Mar 2026 09:28:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: LB F <goainwo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Topic: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Index: AQHcsA6WTRRnBRFJhEKVxaR7JwwWq7Wm+M9wgAAbfgCAAX9nAIAAB6mAgAAK64CAAElZAIABMBnAgADMOgCAACdjAIAAB1+AgAJAYICAAB3nAIAAxOYAgAJBRiCAAKEnAIAA2QBQ
Date: Tue, 17 Mar 2026 01:28:20 +0000
Message-ID: <e5f00d0a42994812b42df867718fa087@realtek.com>
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
In-Reply-To: <CALdGYqSMUPnPfW-_q1RgYr0_SjoXUejAaJJr-o+jpwCk1S7ndQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33319-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D7712A2897
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TEIgRiA8Z29haW53b0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+IE5vdCBzdXJlIGlmIHRoaXMgaXMgYmVjYXVzZSBQ
Q0lFIGJyaWRnZSBoYXMgbm8gQVNQTSBjYXBhYmlsaXR5Pw0KPiANCj4gVGhhdCBjb3VsZCBpbmRl
ZWQgYmUgdGhlIGNhc2UgLS0gSSBkbyBub3QgaGF2ZSBhIHdheSB0byBjb25maXJtDQo+IHdpdGhv
dXQgZnVydGhlciBoYXJkd2FyZS1sZXZlbCBpbnNwZWN0aW9uLg0KPiANCj4gPiBMTjU0OTEgKGtl
cm5lbCB2Ni4xOS42KSBpczoNCj4gPiAgICAgICAgICAgICAgICAgY2FzZSBSWF9FTkNfVkhUOg0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChXQVJOX09OQ0Uoc3RhdHVzLT5yYXRlX2lk
eCA+IDExIHx8DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAhc3Rh
dHVzLT5uc3MgfHwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
YXR1cy0+bnNzID4gOCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJSYXRlIG1hcmtlZCBhcyBhIFZIVCByYXRlIGJ1dCBkYXRhIGlzDQo+IGludmFsaWQ6IE1DUzog
JWQsIE5TUzogJWRcbiIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdGF0dXMtPnJhdGVfaWR4LCBzdGF0dXMtPm5zcykpDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIGRyb3A7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7DQo+ID4gTG9va3MgbGlrZSBkcml2ZXIgcmVwb3J0cyBpbXByb3BlciBWSFQgbnNzL3JhdGU/
IEJ1dCB0aGlzIHdhcm5zIG9uY2UsIGFuZA0KPiA+IHlvdSBtZXNzYWdlIGlzbid0IGxpa2UgdGhp
cy4NCj4gPiBDb3VsZCB5b3UgY2hlY2sgdGhlIHNvdXJjZSBjb2RlIExONTQ5MSB5b3UgYXJlIHVz
aW5nPw0KPiANCj4gVGhlIGZpbGUgbmV0L21hYzgwMjExL3J4LmMgaXMgbm90IGF2YWlsYWJsZSBv
biBkaXNrIG9uIG15IHN5c3RlbQ0KPiAoQ2FjaHlPUyBzaGlwcyBvbmx5IC5oIGZpbGVzIGluIHRo
ZSBoZWFkZXJzIHBhY2thZ2UpLCBidXQgSSBsb2NhdGVkDQo+IHRoZSBleGFjdCB3YXJuaW5nIG1l
c3NhZ2UgaW4gam91cm5hbGN0bDoNCj4gDQo+ICAgUmF0ZSBtYXJrZWQgYXMgYSBWSFQgcmF0ZSBi
dXQgZGF0YSBpcyBpbnZhbGlkOiBNQ1M6IDAsIE5TUzogMA0KPiANCj4gVGhpcyBjb25maXJtcyB0
aGF0IGxpbmUgNTQ5MSBpbiBteSBrZXJuZWwgbWF0Y2hlcyBleGFjdGx5IHdoYXQgeW91DQo+IHNo
b3dlZCBmcm9tIHY2LjE5LjYgLS0gdGhlIFJYX0VOQ19WSFQgY2FzZSBjaGVja2luZyBmb3INCj4g
c3RhdHVzLT5uc3MgPT0gMC4gVGhlIG9mZnNldCBpbiBteSB0cmFjZSBpcyBzbGlnaHRseSBkaWZm
ZXJlbnQNCj4gKCsweDE4MyB2cyArMHgxNzcpLCB3aGljaCBpcyBsaWtlbHkgZHVlIHRvIENhY2h5
T1MncyBMVE8vQXV0b0ZETw0KPiBjb21waWxlciBvcHRpbWl6YXRpb25zLg0KPiANCj4gVGhlIHdh
cm5pbmcgYXBwZWFyZWQgb25jZSBpbiBteSBpbml0aWFsIHRlc3Qgc2Vzc2lvbjoNCj4gDQo+ICAg
UmF0ZSBtYXJrZWQgYXMgYSBWSFQgcmF0ZSBidXQgZGF0YSBpcyBpbnZhbGlkOiBNQ1M6IDAsIE5T
UzogMA0KPiAgIFdBUk5JTkc6IG5ldC9tYWM4MDIxMS9yeC5jOjU0OTEgYXQgaWVlZTgwMjExX3J4
X2xpc3QrMHgxODMvMHgxMDIwIFttYWM4MDIxMV0NCj4gDQo+IEhvd2V2ZXIsIGluIHN1YnNlcXVl
bnQgbW9kdWxlIHJlbG9hZCBhbmQgcmVjb25uZWN0IGN5Y2xlcyBJIHdhcyB1bmFibGUNCj4gdG8g
cmVwcm9kdWNlIGl0LiBUaGlzIGlzIGNvbnNpc3RlbnQgd2l0aCBXQVJOX09OQ0UgYmVoYXZpb3Ig
LS0gaXQNCj4gbGlrZWx5IGZpcmVkIG9uIHRoZSBmaXJzdCBpbnZhbGlkIG5zcz0wIHBhY2tldCBh
ZnRlciB0aGUgaW5pdGlhbA0KPiBkcml2ZXIgbG9hZCBhbmQgaGFzIG5vdCB0cmlnZ2VyZWQgc2lu
Y2UuIEkgY2Fubm90IGNvbmZpcm0gaXQgYXMgYQ0KPiByZWxpYWJsZSBzeW1wdG9tLg0KDQpUbyBy
ZXByb2R1Y2UgdGhpcyByZWxpYWJsZSwgeW91IG5lZWQgdG8gcmVtb3ZlIGRyaXZlciBrbyBhbmQg
bWFjODAyMTEua28sDQphbmQgcmVpbnN0YWxsIHRoZW0uDQoNCkhvd2V2ZXIsIHlvdSBoYXZlIGNv
bmZpcm1lZCB0aGlzIGlzIHRoZSBzeW1wdG9tLiBJIHRoaW5rIG9ubHkgaWYgeW91DQp3YW50IHRv
IGRpZyB3aHkgdGhlIHJhdGUgcmVwb3J0ZWQgYnkgaGFyZHdhcmUgaXMgd2VpcmQsIG90aGVyd2lz
ZSB3ZQ0KY2FuIGlnbm9yZSB0aGlzIHdhcm5pbmcuDQoNCj4gDQo+IC0tLQ0KPiANCj4gUmVnYXJk
aW5nIHBhdGNoIHN0YWJpbGl0eTogdGhlIHJlc3VsdHMgYmVsb3cgYXJlIGZyb20gdGVzdGluZyB5
b3VyDQo+IG9yaWdpbmFsIFJGVCBwYXRjaCBbMV0sIG5vdCBhbnkgbmV3ZXIgc3VibWlzc2lvbi4g
SSB3YW50IHRvIGJlDQo+IGV4cGxpY2l0IHRvIGF2b2lkIGNvbmZ1c2lvbjoNCj4gDQo+ICAgWzFd
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzLzIwMjYwMzExMDIwODE2
LjcwNjUtMS1wa3NoaWhAcmVhbHRlay4NCj4gY29tLw0KPiANCj4gVGhpcyBpcyB0aGUgZXhhY3Qg
ZGlmZiBJIGNvbXBpbGVkIGFuZCB0ZXN0ZWQ6DQo+IA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg4L3BjaS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvcGNpLmMNCj4gQEAgLTIsNiArMiw3IEBADQo+ICAvKiBDb3B5cmlnaHQoYykg
MjAxOC0yMDE5ICBSZWFsdGVrIENvcnBvcmF0aW9uDQo+ICAgKi8NCj4gDQo+ICsjaW5jbHVkZSA8
bGludXgvZG1pLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ICAjaW5jbHVkZSA8
bGludXgvcGNpLmg+DQo+ICAjaW5jbHVkZSAibWFpbi5oIg0KPiBAQCAtMTc0NCw2ICsxNzQ1LDM0
IEBAIGNvbnN0IHN0cnVjdCBwY2lfZXJyb3JfaGFuZGxlcnMgcnR3X3BjaV9lcnJfaGFuZGxlciA9
IHsNCj4gIH07DQo+ICBFWFBPUlRfU1lNQk9MKHJ0d19wY2lfZXJyX2hhbmRsZXIpOw0KPiANCj4g
K2VudW0gcnR3ODhfcXVpcmtfZGlzX3BjaV9jYXBzIHsNCj4gKyBRVUlSS19ESVNfUENJX0NBUF9B
U1BNLA0KPiArfTsNCj4gKw0KPiArc3RhdGljIGludCBkaXNhYmxlX3BjaV9jYXBzKGNvbnN0IHN0
cnVjdCBkbWlfc3lzdGVtX2lkICpkbWkpDQo+ICt7DQo+ICsgdWludHB0cl90IGRpc19jYXBzID0g
KHVpbnRwdHJfdClkbWktPmRyaXZlcl9kYXRhOw0KPiArDQo+ICsgaWYgKGRpc19jYXBzICYgQklU
KFFVSVJLX0RJU19QQ0lfQ0FQX0FTUE0pKQ0KPiArIHJ0d19wY2lfZGlzYWJsZV9hc3BtID0gdHJ1
ZTsNCj4gKw0KPiArIHJldHVybiAxOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0
IGRtaV9zeXN0ZW1faWQgcnR3ODhfcGNpX3F1aXJrc1tdID0gew0KPiArIHsNCj4gKyAuY2FsbGJh
Y2sgPSBkaXNhYmxlX3BjaV9jYXBzLA0KPiArIC5pZGVudCA9ICJIUCBOb3RlYm9vayAtIFAzUzk1
RUEjQUNCIiwNCj4gKyAubWF0Y2hlcyA9IHsNCj4gKyBETUlfTUFUQ0goRE1JX1NZU19WRU5ET1Is
ICJIUCIpLA0KPiArIERNSV9NQVRDSChETUlfUFJPRFVDVF9OQU1FLCAiSFAgTm90ZWJvb2siKSwN
Cj4gKyBETUlfTUFUQ0goRE1JX1BST0RVQ1RfU0tVLCAiUDNTOTVFQSNBQ0IiKSwNCj4gKyB9LA0K
PiArIC5kcml2ZXJfZGF0YSA9ICh2b2lkICopQklUKFFVSVJLX0RJU19QQ0lfQ0FQX0FTUE0pLA0K
PiArIH0sDQo+ICsge30NCj4gK307DQo+ICsNCj4gIGludCBydHdfcGNpX3Byb2JlKHN0cnVjdCBw
Y2lfZGV2ICpwZGV2LA0KPiAgICAgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmlkKQ0KPiAg
ew0KPiBAQCAtMTgwOCw2ICsxODM3LDcgQEAgaW50IHJ0d19wY2lfcHJvYmUoc3RydWN0IHBjaV9k
ZXYgKnBkZXYsDQo+ICAgICAgIGJyaWRnZSAmJiBicmlkZ2UtPnZlbmRvciA9PSBQQ0lfVkVORE9S
X0lEX0lOVEVMKQ0KPiAgIHJ0d3BjaS0+cnhfbm9fYXNwbSA9IHRydWU7DQo+IA0KPiArIGRtaV9j
aGVja19zeXN0ZW0ocnR3ODhfcGNpX3F1aXJrcyk7DQo+ICAgcnR3X3BjaV9waHlfY2ZnKHJ0d2Rl
dik7DQo+IA0KPiAgIHJldCA9IHJ0d19yZWdpc3Rlcl9odyhydHdkZXYsIGh3KTsNCj4gDQo+IFJl
c3VsdHMgd2l0aCBvbmx5IHRoaXMgcGF0Y2ggYXBwbGllZDoNCj4gDQo+ICAgLSBUaGUgaGFyZCBm
cmVlemUgbG9ja3VwIGlzIGdvbmUuDQo+ICAgLSBIb3dldmVyLCBkdXJpbmcgaWRsZSB0aGUgbG9n
cyBhcmUgZmxvb2RlZCB3aXRoOg0KPiANCj4gICAgICAgcnR3ODhfODgyMWNlIDAwMDA6MTM6MDAu
MDogZmFpbGVkIHRvIHNlbmQgaDJjIGNvbW1hbmQNCj4gICAgICAgcnR3ODhfODgyMWNlIDAwMDA6
MTM6MDAuMDogZmlybXdhcmUgZmFpbGVkIHRvIGxlYXZlIGxwcyBzdGF0ZQ0KPiANCj4gICAtIFRv
IGdpdmUgYSBjb25jcmV0ZSBzZW5zZSBvZiB0aGUgdm9sdW1lOiBvdmVyIGFuIH44MC1taW51dGUN
Cj4gICAgIG9ic2VydmF0aW9uIHdpbmRvdyBhZnRlciBhIGNsZWFuIG1vZHVsZSByZWxvYWQsIEkg
cmVjb3JkZWQNCj4gICAgIDExLDc1NyAiZmFpbGVkIHRvIHNlbmQgaDJjIGNvbW1hbmQiIGV2ZW50
cyBhbmQgMiAiZmlybXdhcmUNCj4gICAgIGZhaWxlZCB0byBsZWF2ZSBscHMgc3RhdGUiIGV2ZW50
cyAtLSBhcHByb3hpbWF0ZWx5IDExMCBlcnJvcnMNCj4gICAgIHBlciBtaW51dGUgZHVyaW5nIGFj
dGl2ZSBwZXJpb2RzLg0KPiAgIC0gVGhlc2UgZXJyb3JzIGNhdXNlIEJsdWV0b290aCBhdWRpbyBz
dHV0dGVyaW5nIGFuZCBXaUZpDQo+ICAgICB0aHJvdWdocHV0IGRyb3BzLg0KPiANCj4gV2hlbiBJ
IGFkZGl0aW9uYWxseSBzZXQgZGlzYWJsZV9scHNfZGVlcD1ZIGFsb25nc2lkZSB5b3VyIEFTUE0g
cGF0Y2gsDQo+IGFsbCBoMmMgZXJyb3JzIHZhbmlzaCBjb21wbGV0ZWx5IGFuZCBCbHVldG9vdGgv
V2lGaSByZW1haW4gZnVsbHkNCj4gc3RhYmxlLiBUaGlzIGNvbmZpcm1zIHRoYXQgZGlzYWJsaW5n
IExQUyBEZWVwIGlzIG5lY2Vzc2FyeSBmb3INCj4gY29tcGxldGUgc3RhYmlsaXR5IG9uIHRoaXMg
c3BlY2lmaWMgSFAgU0tVLg0KPiANCj4gSSBhbHNvIG5vdGljZWQgd2hhdCBhcHBlYXJzIHRvIGJl
IGEgbmV3IHBhdGNoIGluIGEgc2VwYXJhdGUgbWFpbGluZw0KPiBsaXN0IHRocmVhZC4gSSB3aWxs
IHRlc3QgaXQgc2hvcnRseSBhbmQgcmVwb3J0IGJhY2sgd2l0aCB0aGUgcmVzdWx0cy4NCg0KVGhh
bmtzIGZvciB5b3VyIGV4cGVyaW1lbnRzIGluIGRldGFpbC4gOikNCg0KUGluZy1LZQ0KDQo=

