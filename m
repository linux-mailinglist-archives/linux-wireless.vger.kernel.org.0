Return-Path: <linux-wireless+bounces-33550-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCsrEreqvGmk1wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33550-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 03:02:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2A22D4F8A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 03:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2553E3006441
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 02:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ABA3002DC;
	Fri, 20 Mar 2026 02:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Dc9G4GkP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94BD2F6577;
	Fri, 20 Mar 2026 02:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773972147; cv=none; b=anU+VpkRwnXQp8ejOM9DfjBJcXSN2B179lEXxt8jR6jptndp9WTvh+u46wcHF8nnCKgvM1Dkz3Qrk1I/V+b5S0ThPpUUZ7AjuCuhTRG3HwSCTK4UlaiVvSbDVmueTylrftrn2R9jVoz/9QiYVdwdg8tcDCtmpDag8uFBP48o+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773972147; c=relaxed/simple;
	bh=809cfglp9XAc2eU3FNNQAf8pVs61JkpJK2dSUSqWKsQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JhwiT0cjmbDcMr/Zx3i6KB7ze2gy5BPauwiVU2ddfRIdcENfnkehR571LDVJZClmiHXOaFNcKby6MnGuWJNVxAbN1JkKR4gAaNfekjs9xupgoaiRbZTlOfVputHu7Rujs70X3LN799zXMgA256+gAkROSSIk+JU5eH7zy04HtPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Dc9G4GkP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62K22IPG0628811, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773972138; bh=809cfglp9XAc2eU3FNNQAf8pVs61JkpJK2dSUSqWKsQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Dc9G4GkP3KatZXk59h2bf7nERJwW51/NZeqOK7MOzmX1Dcr6x/1p4cX3/AjTL/WiF
	 mPoMEwcciiwISRUEAK+JY9sIT5Mxtq9T55+TOS2aagUpTw+jVeTZo417KkX8cVmItT
	 IJjHg5KynAANubNbOBq/I9khEU5bMzt/V1hAW8kwMBC52IdHcc3WZ2lY1TyIY/GuhG
	 Mj7U+yyqM4DdIsKu5DrqlgeRMAsAHFjUIGjyVDvX72HSo2f+ojeLVBZQ3M79KjPSz7
	 mvMMDPJRTmGQZUfxeimBMXccSUxO0OlEKWneLcKQOoyAdtfXWMncL00uXdIuY8x9P6
	 L+CiBgr5UKrMQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62K22IPG0628811
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 10:02:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 20 Mar 2026 10:02:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 20 Mar 2026 10:02:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Fri, 20 Mar 2026 10:02:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: LB F <goainwo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Topic: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Index: AQHcsA6WTRRnBRFJhEKVxaR7JwwWq7Wm+M9wgAAbfgCAAX9nAIAAB6mAgAAK64CAAElZAIABMBnAgADMOgCAACdjAIAAB1+AgAJAYICAAB3nAIAAxOYAgAJBRiCAAKEnAIAA2QBQgAD06wCAAJVNMIAA+6oAgACVvSCAAP1VgIAAC/kAgACJQ/D//4GPAIAAkThg
Date: Fri, 20 Mar 2026 02:02:17 +0000
Message-ID: <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com>
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
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com>
 <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com>
 <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
In-Reply-To: <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33550-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CC2A22D4F8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TEIgRiA8Z29haW53b0BnbWFpbC5jb20+IHdyb3RlOg0KPiBQaW5nLUtlIFNoaWggPHBrc2hpaEBy
ZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4gTm90IHN1cmUgd2hhdCBoYXJkd2FyZSBnZXQgd3Jvbmcu
IExldCdzIHZhbGlkYXRlIHJhdGUgd2hlbiByZWFkaW5nDQo+ID4gZnJvbSBoYXJkd2FyZS4gU2lu
Y2UgMU0gcmF0ZSBjYW4gb25seSAyME1IeiwgSSBzZXQgaXQgdG9nZXRoZXIuDQo+ID4gUGxlYXNl
IGhlbHAgdG8gdGVzdCBiZWxvdy4gSSBzdXBwb3NlIHlvdSBjYW4gc2VlICJ3ZWlyZCByYXRlPXh4
eCIsDQo+ID4gYnV0ICJXQVJOSU5HOiBuZXQvbWFjODAyMTEvcnguYzo1NDkxIiBkaXNhcHBlYXJz
Lg0KPiANCj4gSGkgUGluZy1LZSwNCj4gDQo+IEkgY2FuIGNvbmZpcm0geW91ciBwYXRjaCB3b3Jr
cyBhcyBleHBlY3RlZC4gSGVyZSBhcmUgdGhlIGZ1bGwgcmVzdWx0cy4NCj4gDQo+IC0tLSBUZXN0
IGVudmlyb25tZW50IC0tLQ0KPiANCj4gS2VybmVsOiAgNi4xOS43LTEtY2FjaHlvcw0KPiBQYXRj
aDogICB5b3VyIHJhdGUgdmFsaWRhdGlvbiBwYXRjaCBhcHBsaWVkIHRvIHJ0d19yeF9xdWVyeV9y
eF9kZXNjKCksDQo+ICAgICAgICAgIG9uIHRvcCBvZiB0aGUgdjIgRE1JIHF1aXJrIChBU1BNICsg
TFBTIERlZXAgZGlzYWJsZWQpDQo+IA0KPiAtLS0gQ2FwdHVyZWQgbG9nIChyZWxldmFudCBleGNl
cnB0KSAtLS0NCj4gDQo+ICAgWyAgNDMuMDQ2XSBpbnB1dDogU291bmRjb3JlIFExMGkgKEFWUkNQ
KSAgIDwtLSBCVCBoZWFkc2V0IGNvbm5lY3RlZA0KPiAgIFsgMTExLjU1MV0gcnR3Xzg4MjFjZSAw
MDAwOjEzOjAwLjA6IHVudXNlZCBwaHkgc3RhdHVzIHBhZ2UgKDEzKQ0KPiAgIFsgMTExLjYzNV0g
d2VpcmQgcmF0ZT0xMDENCj4gICBbIDExMS42MzVdIHJ0d184ODIxY2UgMDAwMDoxMzowMC4wOiB1
bnVzZWQgcGh5IHN0YXR1cyBwYWdlICg3KQ0KPiAgIFsgMTExLjc0MV0gd2VpcmQgcmF0ZT0xMDIN
Cj4gICBbIDExNS4wNDVdIHdlaXJkIHJhdGU9OTgNCj4gICBbIDExOC4zNzFdIHdlaXJkIHJhdGU9
MTA0DQo+IA0KPiAtLS0gQW5hbHlzaXMgLS0tDQo+IA0KPiAxLiBUaW1pbmc6IHRoZSBhbm9tYWxv
dXMgZXZlbnRzIGJlZ2FuIGFwcHJveGltYXRlbHkgNjggc2Vjb25kcyBhZnRlcg0KPiAgICB0aGUg
Qmx1ZXRvb3RoIEEyRFAgaGVhZHNldCAoU291bmRjb3JlIFExMGkpIGVzdGFibGlzaGVkIGl0cw0K
PiAgICBjb25uZWN0aW9uLiBObyBhbm9tYWxpZXMgd2VyZSBvYnNlcnZlZCBiZWZvcmUgQlQgY29u
bmVjdGVkLg0KPiANCj4gMi4gTXVsdGlwbGUgaW52YWxpZCByYXRlIHZhbHVlcyB3ZXJlIGNhcHR1
cmVkLCBub3QganVzdCAweDY1Og0KPiANCj4gICAgICB3ZWlyZCByYXRlPTEwMSAgKDB4NjUpDQo+
ICAgICAgd2VpcmQgcmF0ZT0xMDIgICgweDY2KQ0KPiAgICAgIHdlaXJkIHJhdGU9OTggICAoMHg2
MikNCj4gICAgICB3ZWlyZCByYXRlPTEwNCAgKDB4NjgpDQo+IA0KPiAgICBBbGwgZm91ciB2YWx1
ZXMgZXhjZWVkIERFU0NfUkFURV9NQVggKDB4NTMgPSA4MyBkZWNpbWFsKS4gVGhpcw0KPiAgICBz
dWdnZXN0cyB0aGUgaGFyZHdhcmUgb2NjYXNpb25hbGx5IHJlcG9ydHMgYSByYW5nZSBvZiBvdXQt
b2YtYm91bmRzDQo+ICAgIHJhdGUgdmFsdWVzIGR1cmluZyBCVC9XaS1GaSBjb2V4aXN0ZW5jZSwg
bm90IGEgc2luZ2xlIGZpeGVkIHZhbHVlLg0KPiANCj4gMy4gVGhlICJ1bnVzZWQgcGh5IHN0YXR1
cyBwYWdlIiBtZXNzYWdlcyAocGFnZXMgMTMgYW5kIDcpIGFwcGVhcmVkDQo+ICAgIGltbWVkaWF0
ZWx5IGJlZm9yZSBhbmQgYWxvbmdzaWRlIHRoZSAid2VpcmQgcmF0ZSIgZXZlbnRzLiBBcyBub3Rl
ZA0KPiAgICBpbiBteSBwcmV2aW91cyBtZXNzYWdlLCBvbmx5IHBhZ2VzIDAgYW5kIDEgYXJlIGV4
cGVjdGVkLiBUaGlzDQo+ICAgIGZ1cnRoZXIgc3VnZ2VzdHMgdGhlIGZpcm13YXJlIGxlYWtzIGlu
dGVybmFsIGNvZXhpc3RlbmNlIHN0YXRlDQo+ICAgIGludG8gdGhlIFJYIHJpbmcgZHVyaW5nIEJU
IGFudGVubmEgYXJiaXRyYXRpb24uDQo+IA0KPiA0LiBNb3N0IGltcG9ydGFudGx5OiB0aGUgV0FS
TklORzogbmV0L21hYzgwMjExL3J4LmM6NTQ5MSBkaWQgTk9UDQo+ICAgIGFwcGVhciBhbnl3aGVy
ZSBpbiB0aGUgbG9nLiBZb3VyIHJhdGUgY2xhbXBpbmcgcGF0Y2ggc3VjY2Vzc2Z1bGx5DQo+ICAg
IGludGVyY2VwdHMgdGhlIG91dC1vZi1ib3VuZHMgdmFsdWVzIGJlZm9yZSB0aGV5IHByb3BhZ2F0
ZSB0bw0KPiAgICBtYWM4MDIxMSwgcHJldmVudGluZyB0aGUgaW52YWxpZCBWSFQgTlNTPTAgd2Fy
bmluZyBlbnRpcmVseS4NCj4gDQo+IC0tLSBDb25jbHVzaW9uIC0tLQ0KPiANCj4gWW91ciBwYXRj
aCBhY2hpZXZlcyB0aGUgaW50ZW5kZWQgcmVzdWx0LiBUaGUgIndlaXJkIHJhdGUiIHByaW50aw0K
PiBjb25maXJtcyB0aGUgaGFyZHdhcmUgaXMgdGhlIHNvdXJjZSBvZiB0aGUgaW52YWxpZCB2YWx1
ZXMgKG9jY3VycmluZw0KPiBkdXJpbmcgQlQgY29leGlzdGVuY2UpLCBhbmQgdGhlIG1hYzgwMjEx
IFdBUk5JTkcgaXMgc3VwcHJlc3NlZC4NCj4gDQo+IFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ug
bmVlZCBhbnkgYWRkaXRpb25hbCBkYXRhIG9yIGZ1cnRoZXIgdGVzdGluZy4NCg0KSSdsbCBzZW5k
IGZvcm1hbCBwYXRjaCAoQ2MgeW91KSBmb3IgdGhlIGludmFsaWQgVkhUIE5TUz0wLCBidXQgbm90
IHRvDQpoYW5kbGUgInVudXNlZCBwaHkgc3RhdHVzIHBhZ2UiLiBQbGVhc2UgZ2l2ZSBtZSBUZXN0
ZWQtYnkgdGFnIG9uIHRoZQ0KcGF0Y2ggYWZ0ZXIgSSBzZW5kIGl0Lg0KDQpQaW5nLUtlDQoNCg==

