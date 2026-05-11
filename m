Return-Path: <linux-wireless+bounces-36182-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LqwGxMuAWpzRgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36182-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 03:17:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0CA506F64
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 03:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FC88300767A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 01:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4F2B672;
	Mon, 11 May 2026 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Uv3Ozqu+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EFD17A309
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 01:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778462223; cv=none; b=X7oHCl0M9T3GDqS0aVrf4QKMxNq8finCj0Qtg+5Jm2HfhVNVt+heADEsvcSt0kUQFNcHkylFe3s7hZ6qLYauif6M99ygSV/NhdOwsiMFiFtIkXafKtWlf1SCu/je4nhdCR6fUmfUIr1zWoY9/ds+WJLfOXpORIixbQZUqWVEdgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778462223; c=relaxed/simple;
	bh=W6zXKG8HZ/vGkERoMaMVZb85gRapl1poIRnugMiZZeo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MpWjjZ3wuKn1L/3jV6dGqCLPMPPC/bv19L1S16T3tZrgyk68RGnlSZ7F5YJjCa7ObqzVg4wuAp2V3dCan+7O28B9AVaAk8fh7VyRhXgvFjcAEX3byIhc3JN8zHzspIevy60yZ9bQHcET1/1Ekvf52yPpkU4Su8qpQDTkiWLuBog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Uv3Ozqu+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64B1GtQbA2173746, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778462216; bh=W6zXKG8HZ/vGkERoMaMVZb85gRapl1poIRnugMiZZeo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Uv3Ozqu+e7TD9lnchpwp7YFtXscx/uWGXsYI6yZwqCf2V+qZ/bUCy45+Cu8ZALaem
	 TUycDlSARLJwEcnGBxoMZDzll1zqJG70IALWV5UP/rRWg9Fk5N6iqvt+4VRMm7vpc4
	 8fmkJQgBLoHGu9kpnhA4spb91fsVIe47FHdCfdo8O41p1sAeW13zYmBiXAKXKPisFf
	 aAMNCj8o2qzzfhUxRuFNYqwLmhBDSX8n6MRO9MG1Y5Y/D9WtJj5H/T8lPBOjHOeY3G
	 YJcLUs0RLZZ3cgq7gsoOW9DK7euFN5GEcgfV0MDGqK47MAdYvQ4h5fwKrGGdmfz9Ca
	 twXqX1iSjscjA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64B1GtQbA2173746
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 09:16:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 09:16:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 09:16:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 11 May 2026 09:16:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?R2FicmllbCBWaW7DrWNpdXMgZGEgTWFpYQ==?=
	<gabriel_v_maia@estudante.sesisenai.org.br>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: add quirk to disable deep LPS for ASUS
 VivoBook X515JA
Thread-Topic: [PATCH] wifi: rtw88: add quirk to disable deep LPS for ASUS
 VivoBook X515JA
Thread-Index: AQHc2xzjD6zt3JEWlUKqZSzpebDyrbYAs5lggATJIYCAAAETgIACiwQg
Date: Mon, 11 May 2026 01:16:56 +0000
Message-ID: <3abf064f601c4836a4893d503c3ac7c4@realtek.com>
References: <20260503164944.27114-1-gabriel_v_maia@estudante.sesisenai.org.br>
 <af328c8d6bdc4047b08a33a4246c1061@realtek.com>
 <CAC1kGwEid2rT3KFV_Aqxd-Tz7uS+Yci2PNbaPWJ=R0x4zaVYug@mail.gmail.com>
 <CAC1kGwHi0AyV+kxjbRQE4TKvAc-3xq+uHUufCjfAnkfF8j=Y4g@mail.gmail.com>
In-Reply-To: <CAC1kGwHi0AyV+kxjbRQE4TKvAc-3xq+uHUufCjfAnkfF8j=Y4g@mail.gmail.com>
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
X-Rspamd-Queue-Id: CF0CA506F64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36182-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

R2FicmllbCBWaW7DrWNpdXMgZGEgTWFpYSA8bWFpbHRvOmdhYnJpZWxfdl9tYWlhQGVzdHVkYW50
ZS5zZXNpc2VuYWkub3JnLmJyPiB3cm90ZToNCj4gSSB3YXMgdW5hYmxlIHRvIHRlc3QgdGhlIHBh
dGNoIGluIHJ1bnRpbWUuIEJ1aWxkaW5nIHRoZSBtb2R1bGUgYWdhaW5zdA0KPiBteSBydW5uaW5n
IGtlcm5lbCAoNi4xOSkgZmFpbGVkIGR1ZSB0byB2ZXJzaW9uIG1pc21hdGNoIHdpdGggdGhlIHRy
ZWUNCj4gKDcuMS1yYzIpLCBzcGVjaWZpY2FsbHkgdGhlIGttYWxsb2Nfb2JqKCkgc3ltYm9sIGlu
dHJvZHVjZWQgaW4gdGhlDQo+IG5ld2VyIHZlcnNpb24uDQoNCkRpZCB5b3UgbWVhbiB0aGUgcGF0
Y2ggb24gNi4xOSB3b3JrcyBmaW5lIHRvIHlvdT8NCg0KPiANCj4gSSB0aGVuIGNvbXBpbGVkIHRo
ZSBmdWxsIGtlcm5lbCBmcm9tIHRoZSB0cmVlLCBidXQgdGhlIHJlc3VsdGluZw0KPiBidWlsZCBs
YWNrZWQgc2V2ZXJhbCBtb2R1bGVzIHJlcXVpcmVkIGJ5IEZlZG9yYSA0MyB0byBib290IHByb3Bl
cmx5LA0KPiBjYXVzaW5nIHRoZSBzeXN0ZW0gdG8gaGFuZyBkdXJpbmcgaW5pdGlhbGl6YXRpb24u
DQo+IA0KPiBIb3dldmVyLCB0aGUgcGF0Y2ggZm9sbG93cyB0aGUgc2FtZSBsb2dpYyBhcyBjb21t
aXQgYjJiZjlkNjFlMTRhLA0KPiB3aGljaCBkaXNhYmxlcyBkZWVwIExQUyBmb3IgYW4gSFAgbGFw
dG9wIHdpdGggdGhlIHNhbWUgUlRMODgyMUNFDQo+IGNoaXAgYW5kIGlkZW50aWNhbCBlcnJvciBt
ZXNzYWdlcy4gVGhlIGRtZXNnIG91dHB1dCBmcm9tIG15IHN5c3RlbQ0KPiBzaG93cyB0aGUgc2Ft
ZSBwYXR0ZXJuOg0KPiANCj4gICBydHc4OF84ODIxY2UgMDAwMDowMTowMC4wOiBmaXJtd2FyZSBm
YWlsZWQgdG8gbGVhdmUgbHBzIHN0YXRlDQo+ICAgcnR3ODhfODgyMWNlIDAwMDA6MDE6MDAuMDog
ZmFpbGVkIHRvIHNlbmQgaDJjIGNvbW1hbmQNCg0KTWF5YmUgeW91IGNhbiB0cnkgdG8gdHVybiBv
ZmYgZW50aXJlbHkgcG93ZXIgc2F2ZSBieQ0KICBpdyB3bGFuMCBzZXQgcG93ZXIgc2F2ZSBvZmYN
Cg0KQnV0IEkgd29uZGVyIGlmIHRoZXNlIG1lc3NhZ2VzIGNhbiBhZmZlY3QgeW91ciBkYWlseSB1
c2U/DQoNCj4gDQo+IEkgYWxzbyBpbnZlc3RpZ2F0ZWQgd2hldGhlciBlbmFibGluZyBGV19GRUFU
VVJFX0xQU19DMkggd291bGQgYmUgYQ0KPiBtb3JlIGdlbmVyYWwgZml4LCBidXQgaW5zcGVjdGlv
biBvZiBydHc4ODIxY19mdy5iaW4gKHZlcnNpb24gMjQuMTEuMCkNCj4gc2hvd3MgdGhlIGJpdCBp
cyBub3Qgc2V0IGFuZCBGV19GRUFUVVJFX1NJRyBpcyBhbHNvIGFic2VudCwgY2F1c2luZw0KPiB0
aGUgZHJpdmVyIHRvIGRpc2NhcmQgdGhlIGZlYXR1cmUgcmVwb3J0IGVudGlyZWx5Lg0KDQpJZiBG
V19GRUFUVVJFX0xQU19DMkggaXMgbm90IHNldCwgaXQgZ29lcyBpbnRvIA0KX19ydHdfZndfbGVh
dmVfbHBzX2NoZWNrX3JlZygpLiBNYXliZSB5b3UgY2FuIHRyeSB0byBlbmxhcmdlIHRoZSB0aW1l
b3V0DQp0aW1lIG9yIHJldHJ5IGNvdW50LiANCg0KDQo=

