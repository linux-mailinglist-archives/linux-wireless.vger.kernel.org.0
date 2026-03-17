Return-Path: <linux-wireless+bounces-33323-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QITrGPfEuGnTjAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33323-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 04:05:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF52C2A3003
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 04:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F32C930401AC
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 03:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C01E1A4F2F;
	Tue, 17 Mar 2026 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="lhw3M1l2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6154EEB3
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716640; cv=none; b=Vn52ri0D8KRMfbGGZrskdWN1Lh8Oc18WGt470moz6UkqO6WoaFXBdcxJ+ftdN+pDhqvxp2G+afasXDyOVJEzVIvIpQHXV6SBCFpL/XjwdATOfdrLxNw5jq7gFwciPX6H38oh38DKc1RCq9rdfIEE4yZwvcq0xclWVq0iM5UOWog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716640; c=relaxed/simple;
	bh=U0MSr8ATzQm1Ke2c01ALA93OpnccarrExqIKLC/THEY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BVL1byZFWc2Wb9CXxT1kSUHQNu+zdDXGqinbDkS/5lEqL3Tvn/1qIRGf7KTwlUyQzTL/XoRsf8MFswqKHjQ8jOHV43f4rUY+FnO2IcqUiob1b943Rg4p45BI7JIrUMlJCY/RlUcu4Iy9x/fHkJaPXjixDC4xaugIaiMKEb157XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=lhw3M1l2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62H33sL023117966, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773716634; bh=U0MSr8ATzQm1Ke2c01ALA93OpnccarrExqIKLC/THEY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=lhw3M1l2b1tr7p7I/fH1jJ2U+tuAx9Cmu3/OHICVPCjojfnQ3iUPT5WwCf5sCHLtL
	 WTWJClLtjJWk8NAf025FF4VEXSDcAyo7NQiWK4t8Go79HYKcEomqYKCa6UH9A7SdbC
	 jeXR2kHKK0Ya3kkIDWYSPtMcGxUfYJHkuKtJ/0T5m66xBQ2EKKOLl9jegrmL0gmuqd
	 jig5kgXfY+y30G1YiC1KZebAQVzKJrpIriQ/KJZmh3rDHa//vrpB8tGS+KkT+YmLt0
	 lR8z7e09C33Jrn58/Gfv7IIaHsNoUbpR9FB47/42Laib7kRg5ATF1+t05zYcVwv9HM
	 Mv7Kj+bXdkImw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62H33sL023117966
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 11:03:54 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 17 Mar 2026 11:03:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 17 Mar 2026 11:03:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Tue, 17 Mar 2026 11:03:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jason Kakandris <ikakandris@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: RTL8852BE fails to power on: "xtal si not ready" on ASUS TUF
 GAMING B650-PLUS WIFI
Thread-Topic: RTL8852BE fails to power on: "xtal si not ready" on ASUS TUF
 GAMING B650-PLUS WIFI
Thread-Index: AQHctU7OgydTptlp0UKTntkNNhXUfLWyCTcg
Date: Tue, 17 Mar 2026 03:03:53 +0000
Message-ID: <b8cb73b5c8bf42b38ad275220b1d559e@realtek.com>
References: <CAFR=mzkTDNVwypi_PvUw2PX0MM_ck0H61+PUAdJoo6h3yZfggw@mail.gmail.com>
In-Reply-To: <CAFR=mzkTDNVwypi_PvUw2PX0MM_ck0H61+PUAdJoo6h3yZfggw@mail.gmail.com>
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
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-33323-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BF52C2A3003
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SmFzb24gS2FrYW5kcmlzIDxpa2FrYW5kcmlzQGdtYWlsLmNvbT4gd3JvdGU6DQo+IFN5c3RlbSBJ
bmZvDQo+IA0KPiBEaXN0cm86IExpbnV4IE1pbnQgMjIuMyBaZW5hIChVYnVudHUgMjQuMDQgYmFz
ZSkNCj4gS2VybmVscyB0ZXN0ZWQ6IDYuMTQuMC0zNy1nZW5lcmljLCA2LjE3LjAtMTQtZ2VuZXJp
YyAoc2FtZSBmYWlsdXJlIG9uIGJvdGgpDQo+IE1vdGhlcmJvYXJkOiBBU1VTIFRVRiBHQU1JTkcg
QjY1MC1QTFVTIFdJRkkgKFJldiAxLnh4KQ0KPiBCSU9TOiB2MzgyNyAoRmViIDIwMjYpDQo+IENQ
VTogQU1EIFJ5emVuIDcgNzcwMFgNCj4gRHJpdmVyOiBydHc4OSB2Ny4wIChnaXQgY29tbWl0IGQy
ZjE3NWUNCj4gaHR0cHM6Ly9naXRodWIuY29tL21vcnJvd25yL3J0dzg5L2NvbW1pdC9kMmYxNzVl
YWZhMGE0ZWY5Y2M2NWU3MDczYTc3ZTYwMjM4Yw0KPiBhZTYxNCkNCj4gV2lGaSB3b3JrcyBpbiBX
aW5kb3dzOiBZZXMNCj4gDQo+IA0KPiBQcm9ibGVtDQo+IFRoZSBSVEw4ODUyQkUgV2lGaSBjYXJk
IGZhaWxzIHRvIGluaXRpYWxpemUgd2l0aCB4dGFsIHNpIG5vdCByZWFkeSBlcnJvci4gTm8NCj4g
d2lyZWxlc3MgaW50ZXJmYWNlIGlzIGNyZWF0ZWQuDQo+IA0KPiANCj4gZG1lc2cgb3V0cHV0DQo+
IA0KPiBydHc4OV84ODUyYmVfZ2l0IDAwMDA6MDg6MDAuMDogbG9hZGVkIGZpcm13YXJlIHJ0dzg5
L3J0dzg4NTJiX2Z3LTEuYmluDQo+IHJ0dzg5Xzg4NTJiZV9naXQgMDAwMDowODowMC4wOiBlbmFi
bGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMykNCg0KSXQgbG9va3MgbGlrZSB5b3UgZGlkbid0IGVu
Y291bnRlciBEM0NvbGQgcHJvYmxlbSwgYnV0IEkgdGhpbmsgeW91IGNhbg0KZ2l2ZSBpdCBhIHRy
eSBbMV0uDQoNClsxXSBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lk
PTIyMTIxMw0KDQo+IHJ0dzg5Xzg4NTJiZV9naXQgMDAwMDowODowMC4wOiB4dGFsIHNpIG5vdCBy
ZWFkeShSKTogb2Zmc2V0PTQxDQo+IHJ0dzg5Xzg4NTJiZV9naXQgMDAwMDowODowMC4wOiB4dGFs
IHNpIG5vdCByZWFkeShXKTogb2Zmc2V0PTkwIHZhbD0xMCBtYXNrPTEwDQo+IHJ0dzg5Xzg4NTJi
ZV9naXQgMDAwMDowODowMC4wOiBmYWlsZWQgdG8gcG93ZXIgb24NCj4gcnR3ODlfODg1MmJlX2dp
dCAwMDAwOjA4OjAwLjA6IGZhaWxlZCB0byBzZXR1cCBjaGlwIGluZm9ybWF0aW9uDQo+IHJ0dzg5
Xzg4NTJiZV9naXQgMDAwMDowODowMC4wOiBwcm9iZSB3aXRoIGRyaXZlciBydHc4OV84ODUyYmVf
Z2l0IGZhaWxlZCB3aXRoDQo+IGVycm9yIC0xMTANCg0KVGhlc2UgbWVzc2FnZXMgYXBwZWFyIHdo
ZW4gZmlyc3QgYm9vdGluZyBvciBhZnRlciBzeXN0ZW0gcmVzdW1lPw0KUmVjZW50bHkgd2UgdXBk
YXRlIHNvbWV0aGluZyByZWxhdGVkIHRvIHN1c3BlbmQvcmVzdW1lIHByb2JsZW0uDQpQbGVhc2Ug
dXNlIHRoZSBsYXRlc3QgZHJpdmVyIChrZXJuZWwgNy4wLXJjNCkgd2l0aCB0aGUgbGF0ZXN0DQpm
aXJtd2FyZSAodjAuMjkuMjkuMTUpLg0KDQo+IA0KPiANCj4gbHNwY2kNCj4gDQo+IDA4OjAwLjAg
TmV0d29yayBjb250cm9sbGVyIFswMjgwXTogUmVhbHRlayBTZW1pY29uZHVjdG9yIENvLiwgTHRk
LiBSVEw4ODUyQkUNCj4gUENJZSA4MDIuMTFheCBXaXJlbGVzcyBOZXR3b3JrIENvbnRyb2xsZXIg
WzEwZWM6Yjg1Ml0NCj4gU3Vic3lzdGVtOiBBenVyZVdhdmUgUlRMODg1MkJFIFBDSWUgODAyLjEx
YXggV2lyZWxlc3MgTmV0d29yayBDb250cm9sbGVyDQo+IFsxYTNiOjU0NzFdDQo+IA0KPiBXaGF0
IEkndmUgdHJpZWQNCj4gDQo+IEtlcm5lbCBwYXJhbWV0ZXIgcGNpZV9hc3BtPW9mZg0KPiBNb2R1
bGUgcGFyYW1ldGVyczogZGlzYWJsZV9jbGtyZXE9WSBkaXNhYmxlX2FzcG1fbDE9WSBkaXNhYmxl
X2FzcG1fbDFzcz1ZDQo+IGRpc2FibGVfcHNfbW9kZT15DQoNCkFzIHlvdSB0cnkgdGhpcywgcGxl
YXNlIGVuc3VyZSB0aGF0IGFkZCBhIGNvbmZpZ3VyYXRpb24gZmlsZSB0byAvZXRjL21vZHVsZS5k
LywNCmFuZCBjb2xkIHJlYm9vdC4NCg0KPiBVcGRhdGVkIEJJT1MgZnJvbSB2MzA1NyB0byB2Mzgy
Nw0KPiBVcGRhdGVkIGZpcm13YXJlIGZpbGVzIHZpYSBtYWtlIGluc3RhbGxfZncNCj4gVGVzdGVk
IG9uIGtlcm5lbHMgNi4xNCBhbmQgNi4xNyDigJQgc2FtZSBmYWlsdXJlIG9uIGJvdGgNCj4gSW4t
a2VybmVsIGRyaXZlciBhbmQgbW9ycm93bnIgb3V0LW9mLXRyZWUgZHJpdmVyIOKAlCBzYW1lIGZh
aWx1cmUNCj4gV2lGaSB3b3JrcyBmaW5lIGluIFdpbmRvd3Mgb24gdGhlIHNhbWUgaGFyZHdhcmUN
Cg0K

