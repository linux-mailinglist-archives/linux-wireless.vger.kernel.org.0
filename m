Return-Path: <linux-wireless+bounces-33033-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WaveCmkdsmldIwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33033-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 02:56:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4801F26C0B0
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 02:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF275303F077
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 01:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA72346782;
	Thu, 12 Mar 2026 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="EaYCOHT8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446A0846A;
	Thu, 12 Mar 2026 01:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280614; cv=none; b=eTpxYJcDR+4ss2/D2+ZWFdkiIcdE6TBU0uOUk0B0an3/Fpfm3rrx+zvyk/+g+jP11rjeoG58tf8b2jZ+g7hHFdI/HA8QRhJ7ZMHOSlRqs899v/ebd/SBxy1VzHu4HfyMRzJCpKF5oUxEDJKdbyn0gz1JYJOKMmdhPNg8TLKH4tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280614; c=relaxed/simple;
	bh=ie5iY1nm997/6aN5eEDpZ/0Kenrg+jJs+mH6GMWPZ0E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nAj0DjZbBdZeUUsjcAyxmKy243TgU1P+mtKjplh51rMszpPo6W296Gx4hQ9K59VH88/O/0ZOdusCR5Ljkqfzd38abkl3I/QBlPBjo5FGQQe8jSZI9MB6AIWFHBrzzakQSB1D0QucHg/zqfqA+vObq+2nIZxUZYUzQnLGA5H8nPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EaYCOHT8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62C1unYtB1598801, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773280609; bh=ie5iY1nm997/6aN5eEDpZ/0Kenrg+jJs+mH6GMWPZ0E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=EaYCOHT8IlRwoWsznA4o+4x4SsSVXsYAKDDOk8lh1RcExmr94sfHMVJB4hP9nX1Dq
	 u2KgdX9mzdfSHf/eJCNGxkFT4H6cwGU4CxyP7eR8BMTd+P51RTQN+PCcr2CMY0b+qb
	 j5vyk25bsjp88RxvnUqrneWDGruDNZJE/gF/DiFBJqqJAqySTrVxtq7oidv20MkDTW
	 2kr3QNWqSAx0g6CPiTexcAPREMbSbGnWJETf5h20KxVLj6z2Sw2ghOV1iSJR7E2t/n
	 7n24Ecuzr69moluUfphxEqLuHmwcvy8jAkkxgf9UD5iX8i1Le/PFdyd97WvmMuFNrL
	 DhCa9aeFR31NA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62C1unYtB1598801
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 09:56:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 12 Mar 2026 09:56:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Thu, 12 Mar 2026 09:56:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: LB F <goainwo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Topic: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Index: AQHcsA6WTRRnBRFJhEKVxaR7JwwWq7Wm+M9wgAAbfgCAAX9nAIAAB6mAgAAK64CAAElZAIABMBnA
Date: Thu, 12 Mar 2026 01:56:47 +0000
Message-ID: <458ed80e39734ea99610050140bb31ce@realtek.com>
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com>
 <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
 <792645eed36041f0b3df951f1b28a08a@realtek.com>
 <e6720993c8c14245981432cfa4ae902b@realtek.com>
 <CALdGYqQn8GGXXjZTsL+a5Mfdmw5HRYB2Jyvqq5M5SUwxK9yd_g@mail.gmail.com>
 <CALdGYqQee1sjgdBAPJSyb1gL6ksK4z8Uw_v3ANTnyXE+LXFAiA@mail.gmail.com>
In-Reply-To: <CALdGYqQee1sjgdBAPJSyb1gL6ksK4z8Uw_v3ANTnyXE+LXFAiA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33033-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4801F26C0B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TEIgRiA8Z29haW53b0BnbWFpbC5jb20+IHdyb3RlOg0KPiBIaSBQaW5nLUtlLA0KPiANCj4gSSBz
dWNjZXNzZnVsbHkgYXBwbGllZCB5b3VyIHBhdGNoIG91dC1vZi10cmVlIGFuZCBwZXJmb3JtZWQg
cmlnb3JvdXMNCj4gdGVzdGluZyBvbiB0aGUgaG9zdCBtYWNoaW5lLg0KPiANCj4gSSBjYW4gb2Zm
aWNpYWxseSBjb25maXJtIHRoYXQgdGhlIHBhdGNoIHdvcmtzIGZsYXdsZXNzbHkuIFRoZSBETUkN
Cj4gcXVpcmsgdHJpZ2dlcmVkIGNvcnJlY3RseSBhbmQgc3VjY2Vzc2Z1bGx5IHByZXZlbnRlZCB0
aGUNCj4gaGFyZHdhcmUtbGV2ZWwgUENJZSBidXMgbG9ja3VwcyBvbiBteSBIUCBQM1M5NUVBI0FD
Qi4NCg0KVGhhbmtzIGZvciB5b3VyIHF1aWNrbHkgdGVzdCB3aXRoIG15IHBhdGNoLiA6KQ0KDQo+
IA0KPiBUZXN0aW5nIEVudmlyb25tZW50ICYgTWV0aG9kb2xvZ3k6DQo+IC0gS2VybmVsOiBDYWNo
eU9TIExpbnV4IDYuMTkuNi0yLWNhY2h5b3MgeDg2XzY0DQo+IC0gVG9vbGNoYWluOiBDbGFuZy9M
TFZNIDIxLjEuOCAoYG1ha2UgQ0M9Y2xhbmcgTExWTT0xIG1vZHVsZXNgKQ0KPiAtIEV4dHJhY3Rp
b246IFdlIGZldGNoZWQgdGhlIHN0cmljdA0KPiBgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydHc4OGAgc3ViLXRyZWUgb3V0IG9mIHRoZQ0KPiB0b3J2YWxkcy9saW51eCBgdjYuMTlgIHRy
ZWUgdXRpbGl6aW5nIGBnaXQgc3BhcnNlLWNoZWNrb3V0YCB0byBjbGVhbmx5DQo+IGFwcGx5IHRo
ZSBwYXRjaCB3aXRob3V0IGhhdmluZyB0byBjb21waWxlIHRoZSBlbnRpcmUgMi41R0IrIGtlcm5l
bC4NCj4gLSBUaGUgcmVzdWx0aW5nIGAua29gIG9iamVjdCBmaWxlcyB3ZXJlIGNvbXByZXNzZWQg
dG8gYC56c3RgIGFuZA0KPiBpbnN0YWxsZWQgc3VjY2Vzc2Z1bGx5IG92ZXIgdGhlIGdlbmVyaWMg
Q2FjaHlPUyBzeXN0ZW0gZHJpdmVyIG9iamVjdHMuDQo+IA0KPiBWZXJpZmljYXRpb24gQ29uZGl0
aW9uczoNCj4gLSBSZW1vdmVkIEFMTCBsb2NhbCB3b3JrYXJvdW5kcy4gYGRpc2FibGVfYXNwbT1Z
YCBpcyBubyBsb25nZXIgZm9yY2VkDQo+IHZpYSBgL2V0Yy9tb2Rwcm9iZS5kL2Agb3ZlcnJpZGVz
Lg0KPiAtIFBvd2VyIHNhdmluZyByZW1haW5zIG5hdGl2ZWx5IE9OIGB3aWZpLnBvd2Vyc2F2ZSA9
IDNgIChtYW5hZ2VkIGJ5DQo+IE5ldHdvcmtNYW5hZ2VyKS4NCj4gLSBMZWZ0IHRoZSBsYXB0b3Ag
aW4gbXVsdGlwbGUgNS0xMCBtaW51dGUgY29tcGxldGUgaWRsZSBzdGF0ZXMgdG8NCj4gZW5mb3Jj
ZSBzbGVlcCBtb2Rlcy4NCj4gDQo+IFBvc3QtQm9vdCBMb2cgQW5hbHlzaXMgJiBQb3RlbnRpYWwg
SW1wcm92ZW1lbnQgUHJvcG9zaXRpb246DQo+IFRoZSBzeXN0ZW0gcmVtYWluZWQgMTAwJSBzdGFi
bGUgd2l0aG91dCBhbnkga2VybmVsIHBhbmljcyBvciBVSSBmcmVlemVzLg0KPiBIb3dldmVyLCBJ
IGNvbnRpbnVvdXNseSBtb25pdG9yZWQgdGhlIGBkbWVzZ2AgcmluZyBidWZmZXIgYW5kIG5vdGlj
ZWQNCj4gYW4gaW50cmlndWluZyBiZWhhdmlvci4gV2hpbGUgdGhlIGxhcHRvcCBzaXRzIGNvbXBs
ZXRlbHkgaWRsZQ0KPiAoTmV0d29ya01hbmFnZXIgY29ubmVjdGVkLCBidXQgbm8gYWN0aXZlIHRy
YWZmaWMpLCB0aGUgYHJ0dzg4YCBkcml2ZXINCj4gc3RhcnRzIGZsb29kZWQgdGhlIGxvZ3Mgd2l0
aCB0aG91c2FuZHMgb2YgZmlybXdhcmUgZXJyb3JzOg0KPiANCj4gWyAxMDg0Ljc0NjQ4NV0gcnR3
ODhfODgyMWNlIDAwMDA6MTM6MDAuMDogZmlybXdhcmUgZmFpbGVkIHRvIGxlYXZlIGxwcyBzdGF0
ZQ0KPiBbIDEwODQuNzQ5NjYyXSBydHc4OF84ODIxY2UgMDAwMDoxMzowMC4wOiBmYWlsZWQgdG8g
c2VuZCBoMmMgY29tbWFuZA0KPiBbIDEwODQuNzUyODk1XSBydHc4OF84ODIxY2UgMDAwMDoxMzow
MC4wOiBmYWlsZWQgdG8gc2VuZCBoMmMgY29tbWFuZA0KPiANCj4gSWYgbXkgdW5kZXJzdGFuZGlu
ZyBvZiB0aGlzIGFyY2hpdGVjdHVyZSBpcyBjb3JyZWN0LCBwcmV2aW91c2x5LCB3aGVuDQo+IEFT
UE0gd2Fzbid0IGRpc2FibGVkLCB0aGlzIGV4YWN0IGZhaWx1cmUgb2YgdGhlIGFkYXB0ZXIgZmly
bWFyZSBpbnNpZGUNCj4gYExQU19ERUVQX01PREVfTENMS2Agd291bGQgdmlvbGVudGx5IGxvY2sg
dXAgdGhlIFBDSWUgYnVzIGFuZCBjcmFzaA0KPiB0aGUgaG9zdC4gTm93LCB0aGFua3MgdG8geW91
ciBETUkgQVNQTSBxdWlyayBhdCB0aGUgYHJ0dzg4X3BjaWAgbGV2ZWwsDQo+IHRoZSBob3N0IFBD
SWUgY29udHJvbGxlciBkb2Vzbid0IGVudGVyIGBMMWAgYW5kIGlzIHBlcmZlY3RseSBzaGllbGRl
ZA0KPiBmcm9tIHRoZSBhZGFwdGVyIGxvY2tpbmcgaXRzZWxmIHVwISBUaGUgT1MgaGFuZGxlcyB0
aGUgdGltZW91dHMNCj4gZ3JhY2VmdWxseSBhbmQgZHJpdmVyIHJlY292ZXJ5IHByZXZlbnRzIGEg
aGFyZCBmcmVlemUuDQoNCkknbSByZWFsbHkgbm90IHN1cmUgaG93L3doeSBrZXJuZWwgYmVjb21l
cyBmcm96ZW4uIEFzIEkgbWVudGlvbmVkIGJlZm9yZQ0KaXQgbWlnaHQgYmVjYXVzZSBvZiByZWNl
aXZlZCBtYWxmb3JtZWQgZGF0YSBhbmQgbm8gY29tcGxldGUgdmFsaWRhdGlvbg0KYmVmb3JlIHJl
cG9ydGluZyBSWCBwYWNrZXQgdG8gbWFjODAyMTEuDQoNCk5vdCBzdXJlIGlmIHlvdSBjYW4gdHJ5
IHRvIGRpZyBhbmQgYWRkIHNvbWUgdmFsaWRhdGlvbj8NCg0KKEN1cnJlbnQgRE1JIHBhdGNoIGlz
IGZpbmUgdG8gbWUuKQ0KDQo+IA0KPiBBIHF1ZXN0aW9uIGZvciB5b3VyIGNvbnNpZGVyYXRpb246
IEdpdmVuIHRoZSBpbW1lbnNlIHZvbHVtZSBvZiB0aGVzZQ0KPiBgaDJjYCB0aW1lb3V0IGVycm9y
cyAoYW5kIHRoZSB1bmRlcmx5aW5nIGZpcm13YXJlJ3MgZnVuZGFtZW50YWwNCj4gaW5hYmlsaXR5
IHRvIGNsZWFubHkgZW50ZXIvZXhpdCBpdHMgb3duIHNsZWVwIHN0YXRlcyB3aXRob3V0IEwxDQo+
IHBhcnRpY2lwYXRpb24gb24gdGhpcyBIUCBtb2RlbCksIGRvIHlvdSB0aGluayBpdCB3b3VsZCBi
ZSBiZW5lZmljaWFsDQo+IHRvICphbHNvKiBkeW5hbWljYWxseSBkaXNhYmxlIExQUyBEZWVwIHNs
ZWVwIHdoZW4gdGhpcyBzcGVjaWZpYyBBU1BNDQo+IHF1aXJrIGlzIHRyaWdnZXJlZD8NCj4gDQo+
IEZvciBleGFtcGxlLCBkeW5hbWljYWxseSBmb3JjaW5nIGBydHdkZXYtPmxwc19jb25mLmRlZXBf
bW9kZSA9DQo+IExQU19ERUVQX01PREVfTk9ORWAgd2hlbiB0aGUgRE1JIEFTUE0gZmxhZyBpcyBh
Y3RpdmUsIHN0cmljdGx5IHRvDQo+IHByZXZlbnQgdGhlIGZpcm13YXJlIGZyb20gYXR0ZW1wdGlu
ZyBhIHNsZWVwIGN5Y2xlIHRoYXQgaXMgZG9vbWVkIHRvDQo+IGZhaWwgYW5kIHBvbGx1dGluZyB0
aGUgcXVldWVzIGFuZCBsb2dzPyBQZXJoYXBzIHRoaXMgbWlnaHQgYWxzbyBzYXZlDQo+IG1pY3Jv
c2NvcGljIENQVSBpbnRlcnJ1cHRzIGZyb20gY29udGludW91cyBIMkMgcG9sbGluZyB0aW1lb3V0
cz8NCg0KQXJlIHRoZSAnaDJjJyB0aW1lb3V0IG1lc3NhZ2VzIGZsb29kaW5nPyBvciBhcHBlYXJz
IHBlcmlvZGljYWxseT8gDQpEb2VzIGl0IHJlYWxseSBhZmZlY3QgY29ubmVjdGlvbiBzdGFibGU/
DQoNCklmIHlvdSBjaGFuZ2UgYW5vdGhlciBBUCBvciBjb25uZWN0aW9uIG9uIDVHSHogYmFuZCwg
ZG9lcyB0aGUgbWVzc2FnZXMNCnN0aWxsIHByZXNlbnQ/IA0KDQpJIHRoaW5rIGl0IGlzbid0IGVh
c3kgdG8gZmluZCBvdXQgdGhlIGNhdXNlIHdpdGhvdXQgbWVhc3VyaW5nIGhhcmR3YXJlDQpzaWdu
YWxzLCBzaW5jZSBJIHNhdyB0aGUgbWVzc2FnZSB2ZXJ5IHZlcnkgcmFyZS4gU28sIEknZCBhZG9w
dCB5b3VyDQpzdWdnZXN0aW9uIChkeW5hbWljIExQU19ERUVQX01PREVfTk9ORSkgaWYgdGhlIHRl
c3QgaXMgcG9zaXRpdmUuDQoNCj4gDQo+IElmIHlvdSBiZWxpZXZlIHRoYXQgc2ltcGx5IGxldHRp
bmcgdGhlIGRyaXZlciByZWNvdmVyIGFuZCB0b2xlcmF0aW5nDQo+IHRoZSBlcnJvciBzcGFtIGlu
IGBkbWVzZ2AgaXMgdGhlIHByZWZlcnJlZC9zYWZlciB1cHN0cmVhbSBhcHByb2FjaCwgSQ0KPiBh
bSBwZXJmZWN0bHkgaGFwcHkuIFRoZSBwYXRjaCBmdW5jdGlvbnMgYXMgYWR2ZXJ0aXNlZCBhbmQg
c3lzdGVtDQo+IHN0YWJpbGl0eSBpcyB1bmVxdWl2b2NhbGx5IHJlc3RvcmVkIQ0KPiANCj4gVGhh
bmsgeW91IGltbWVuc2VseSBmb3IgeW91ciByYXBpZCBkZWJ1Z2dpbmcgYW5kIGRlZmluaXRpdmUg
cGF0Y2ggZm9yDQo+IHRoaXMgbG9uZy1zdGFuZGluZyBpc3N1ZSBhbmQgZm9yIGJyaW5naW5nIHN0
YWJpbGl0eSB0byB0aGlzIG1vZGVsLg0KPiANCj4gVGVzdGVkLWJ5OiBPbGVrc2FuZHIgSGF2cnls
b3YgPGdvYWlud29AZ21haWwuY29tPg0KDQpJIHdpbGwgYWRkIHRoaXMgdG8gbXkgcGF0Y2ggdGhl
bi4NCg0KPiANCj4gKihOb3RlOiBJIHdhcyBhIGJpdCB1bnN1cmUgd2hpY2ggb2YgdGhlIHR3byBh
Y3RpdmUgbWFpbGluZyBsaXN0DQo+IHRocmVhZHMgd2FzIHRoZSBtb3N0IGFwcHJvcHJpYXRlIHBs
YWNlIGZvciB0aGlzIGZpbmFsIHJlcG9ydCDigJQgdGhlDQo+IG9yaWdpbmFsIGJ1ZyBkaXNjdXNz
aW9uIG9yIHRoZSBuZXcgUkZUIHBhdGNoIHN1Ym1pc3Npb24gdGhyZWFkIOKAlCBzbyBJDQo+IHJl
cGxpZWQgdG8gYm90aCBqdXN0IHRvIGVuc3VyZSBpdCBpcyBjb3JyZWN0bHkgYXR0YWNoZWQgdG8g
dGhlIHBhdGNoLg0KPiBBcG9sb2dpZXMgZm9yIHRoZSBkdXBsaWNhdGUgZW1haWwhKSoNCj4gDQoN
CkxldCdzIGRpc2N1c3MgaW4gdGhpcyB0aHJlYWQuIEZvciBSRlQgcGF0Y2gsIEkgc3VwcG9zZSB5
b3Ugb25seSByZXBseQ0KbWUgYWJvdXQgdGhlIHRlc3QgcmVzdWx0IGFuZCBnaXZlIG1lIFRlc3Rl
ZC1ieSB0YWcgaWYgaXQgd29ya3MuIA0KDQpCeSB0aGUgd2F5LCB5b3VyIHRoaXMgcmVwbHkgaXMg
dG9wIHBvc3RpbmcgdGhhdCBtYWlsaW5nIGxpc3QgaXNuJ3QNCnByZWZlcnJlZCwgc28gSSBkZWxl
dGUgb2xkIGRpc2N1c3Npb24uIFBsZWFzZSBhdm9pZCB0aGlzIGluIHRoZSBmdXR1cmUuDQoNClBp
bmctS2UNCg0K

