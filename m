Return-Path: <linux-wireless+bounces-37685-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X+pAFiZTK2pe6wMAu9opvQ
	(envelope-from <linux-wireless+bounces-37685-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 02:30:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E17E675EF4
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 02:30:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=LhGbktSK;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37685-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37685-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D52B530CAE2A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 00:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013246BB5B;
	Fri, 12 Jun 2026 00:30:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD6946A;
	Fri, 12 Jun 2026 00:30:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224226; cv=none; b=jizyp90P2wFRBUr/1J7qcvJjOoVvz+bX40PmR6kPw5qXtQ0+VlHN+8Mpxe0RCWZ4rXtjq5Xefneqy4Fq4zKc2OUD9LROrs0xW6Z1XuUWT7CtbK2XPS4cWpiyo0l7ybkybRe5ehVXjTF8WHlpsRc3D2+Fu51zKWfKs2XqBgLK2Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224226; c=relaxed/simple;
	bh=sl6TUBBBCoIQnTU7GsgG5is62CkRYeza+L8accszNvo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rAR3RWak4Pk6rK587p7rTAbZD2jM/k90KiqKMOnYLtX50rX9C2vg0jWLAv6DugEmjuqEzdQMEIKcQh7Za66+6YlAxKrQf+NFe/OtFaeGePWAzulMEYsix/ygPDSVr0QED59saj1Qb4Bv/PQS/Hy4eOww7Y37MDosOGCTU0yXcRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=LhGbktSK; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65C0UKrI42321161, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1781224220; bh=sl6TUBBBCoIQnTU7GsgG5is62CkRYeza+L8accszNvo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LhGbktSKfddXCX7iFwvvPZR/BHqIWRd+MzmUlLWaa4CWtox3QkbyosUqahZUGHRBB
	 4m0fFvz7ntdnaHfbRVP1N2/Z3o0Z9uWkKn4e8FZdjaQfF2BIHJL4egU1/2EzePSnZn
	 WjjKJruVU1+qxM2K3bvYIYlhk4tX0isyw9jW9HAtbfY4i5b0E/L5hn3+H1K07LQsYn
	 RzeoYEk+iKcVxAX0SYBjVINYRlF2t74DT4JHau0jNA5S5rk9LTnjdPu1IF+RrQsmOU
	 rLZQTU3rEwJG9pVuyDxWYqIaD6CGmVAFSsgfssLLYqs30LbtJHxWt6flaiJHVJ7r29
	 kBVHZoVrqRT5A==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65C0UKrI42321161
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Jun 2026 08:30:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Jun 2026 08:30:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Jun 2026 08:30:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Fri, 12 Jun 2026 08:30:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Giovanni Santini <giovannisantini93@yahoo.it>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: RE: rtw88: WiFi card is not offloaded properly when suspending the OS
Thread-Topic: rtw88: WiFi card is not offloaded properly when suspending the
 OS
Thread-Index: AQHc9MfBVY8tNqpB4kyHWDTYuLp5JLYzXc0ggAV6JACAAT8YUA==
Date: Fri, 12 Jun 2026 00:30:20 +0000
Message-ID: <b3d2c32150884cdcae21b3bec5062864@realtek.com>
References: <10da4c45-74ed-4deb-8c88-6d0b803465ba.ref@yahoo.it>
 <10da4c45-74ed-4deb-8c88-6d0b803465ba@yahoo.it>
 <efae0a4db2ab4b6193922b393d3dcdd6@realtek.com>
 <02e09f1a-2807-4fec-aacf-1bc4bbb1ccd1@yahoo.it>
In-Reply-To: <02e09f1a-2807-4fec-aacf-1bc4bbb1ccd1@yahoo.it>
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
	FORGED_RECIPIENTS(0.00)[m:giovannisantini93@yahoo.it,m:stable@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:regressions@lists.linux.dev,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37685-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yahoo.it:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:mid,realtek.com:from_mime];
	FREEMAIL_TO(0.00)[yahoo.it,vger.kernel.org];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E17E675EF4

Ly8gbm90IHRvcCBwb3N0aW5nLg0KDQpHaW92YW5uaSBTYW50aW5pIDxnaW92YW5uaXNhbnRpbmk5
M0B5YWhvby5pdD4gd3JvdGU6DQo+IE9uIDIwMjYtMDYtMDggMDM6MzIsIFBpbmctS2UgU2hpaCB3
cm90ZToNCj4gPiBHaW92YW5uaSBTYW50aW5pIDxnaW92YW5uaXNhbnRpbmk5M0B5YWhvby5pdD4g
d3JvdGU6DQo+ID4+IEp1biAwMiAxNzoyNTozMyBhcmNobGludXgtdHVnIGtlcm5lbDogcnR3ODhf
ODgyMmNlIDAwMDA6MDM6MDAuMDogZmFpbGVkDQo+ID4+IHRvIHNlbmQgaDJjIGNvbW1hbmQNCj4g
Pj4gSnVuIDAyIDE3OjI1OjMzIGFyY2hsaW51eC10dWcga2VybmVsOiBydHc4OF84ODIyY2UgMDAw
MDowMzowMC4wOiBmYWlsZWQNCj4gPj4gdG8gc2VuZCBoMmMgY29tbWFuZA0KPiA+PiBKdW4gMDIg
MTc6MjU6MzMgYXJjaGxpbnV4LXR1ZyBrZXJuZWw6IHJ0dzg4Xzg4MjJjZSAwMDAwOjAzOjAwLjA6
IGZhaWxlZA0KPiA+PiB0byBzZW5kIGgyYyBjb21tYW5kDQo+ID4+IEp1biAwMiAxNzoyNTozMyBh
cmNobGludXgtdHVnIGtlcm5lbDogcnR3ODhfODgyMmNlIDAwMDA6MDM6MDAuMDogZmFpbGVkDQo+
ID4+IHRvIHNlbmQgaDJjIGNvbW1hbmQNCj4gPj4gSnVuIDAyIDE3OjI1OjM2IGFyY2hsaW51eC10
dWcga2VybmVsOiBydHc4OF84ODIyY2UgMDAwMDowMzowMC4wOiBmYWlsZWQNCj4gPj4gdG8gcG9s
bCBvZmZzZXQ9MHg1IG1hc2s9MHgyIHZhbHVlPTB4MA0KPiA+PiBKdW4gMDIgMTc6MjU6MzYgYXJj
aGxpbnV4LXR1ZyBrZXJuZWw6IC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0K
PiA+PiBKdW4gMDIgMTc6MjU6MzYgYXJjaGxpbnV4LXR1ZyBrZXJuZWw6IGZhaWxlZCB0byByZWFk
IERCSSByZWdpc3RlciwNCj4gPj4gYWRkcj0weDA3MTkNCj4gPiBBZGQgdGhlc2UgYmVsb3cgdG8g
c2VlIGlmIGl0IGNhbiBoZWxwLg0KPiA+DQo+ID4gc3VkbyBuYW5vIC9ldGMvbW9kcHJvYmUuZC9y
dHc4OC5jb25mDQo+ID4gb3B0aW9ucyBydHc4OF9jb3JlIGRpc2FibGVfbHBzX2RlZXA9eQ0KPiA+
IG9wdGlvbnMgcnR3ODhfcGNpIGRpc2FibGVfYXNwbT15DQo+ID4NCj4gPiBBZnRlciBjb2xkIHJl
Ym9vdCwgY2hlY2sgL3N5cy9tb2R1bGVzL3J0dzg4XyovcGFyYW10ZXJzLyogdG8gc2VlIGlmDQo+
ID4gdGhlIG1vZGlmaWNhdGlvbiB0YWtlcyBlZmZlY3QuDQo+ID4NCj4gPj4gSSdtIGF0dGFjaGlu
ZyB0aGUgZnVsbCBib290IGxvZywgaWYgeW91IG5lZWQgYSBmcmVzaCBvbmUgSSBjYW4gcHJvdmlk
ZSBpdC4NCj4gPiBCZWZvcmUgImZhaWxlZCB0byBwb2xsIC4uLiIgbG9nLCBJIGFsc28gc2VlDQo+
ID4NCj4gPiBKdW4gMDIgMTc6MjU6MDIgYXJjaGxpbnV4LXR1ZyBrZXJuZWw6IHJ0dzg4Xzg4MjJj
ZSAwMDAwOjAzOjAwLjA6IEFNRC1WaToNCj4gPiAgIEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVM
VCBkb21haW49MHgwMDBlIGFkZHJlc3M9MHhhZTk2NjhiYyBmbGFncz0weDAwMDBdDQo+ID4NCj4g
PiBQbGVhc2UgdHJ5IHRvIHR1cm4gb2ZmIElPTU1VIGJ5IGVkaXRpbmcgL2V0Yy9kZWZhdWx0L2dy
dWINCj4gPiBHUlVCX0NNRExJTkVfTElOVVhfREVGQVVMVD0icXVpZXQgc3BsYXNoIGFtZF9pb21t
dT1vZmYgaW9tbXU9b2ZmIg0KPiA+DQo+ID4gQW5kIHRoZW4gdXBkYXRlLWdydWINCj4gPg0KPiA+
PiBJIHJ1biBBcmNoTGludXggd2l0aCBLREUgUGxhc21hLCBmb3IgbmV0d29ya2luZyBJIHVzZSBO
ZXR3b3JrTWFuYWdlciBhbmQNCj4gPj4gd3BhX3N1cHBsaWNhbnQuDQo+ID4+DQo+ID4+IElmIHlv
dSB3b3VsZCBsaWtlIG1lIHRvIHJ1biB0ZXN0cyB3aXRoIGUuZy4ganVzdCBpd2QgSSBjYW4gZG8g
c28sIGp1c3QNCj4gPj4gbGV0IG1lIGtub3cgd2hhdCBzZXR1cCB5b3Ugd291bGQgbGlrZSBtZSB0
byBoYXZlLg0KPiA+Pg0KPiA+PiBJIGRvIG5vdCBoYXZlIHRoaXMgaXNzdWUgd2l0aCB0aGUgTFRT
IGtlcm5lbCA2LjE4LjM0LiBUaGlzIGFmZmVjdHMgNy4wDQo+ID4+IGFuZCA3LjEuDQo+ID4+IEkg
YmVsaWV2ZSB0aGlzIGlzc3VlIHdhcyBub3QgcHJlc2VudCBpbiA8IDcga2VybmVscywgYnV0IEkg
Y2Fubm90IGd1YXJhbnRlZS4NCj4gPj4gSSBjYW4gaG93ZXZlciBkb3duZ3JhZGUgdG8gcHJldmlv
dXMga2VybmVscyB0byB1bmRlcnN0YW5kIHdoZXJlIHRoZQ0KPiA+PiBpc3N1ZSB3YXMgaW50cm9k
dWNlZC4NCj4gPiBUaGUgY29tbWl0cyBiZXR3ZWVuIDYuMTguMzQgfiA3LjAuMTAgYXJlIHF1aXRl
IGZldywgYW5kIEkgY2FuJ3QgZmluZCB0aGUNCj4gPiBvbmUgdGhhdCBjYW4gYWZmZWN0IHRoZSBi
ZWhhdmlvci4gUGxlYXNlIHN3aXRjaCB5b3VyIGtlcm5lbCBiYWNrIHRvIDYuMTguMzQsDQo+ID4g
YW5kIGFwcGx5IHJ0dzg4J3MgcGF0Y2hlcyBhZGRlZCB1bnRpbCA3LjAuMTAuDQo+ID4NCj4gPiBT
aW5jZSB0aGUgbGFzdCBjb21taXQgb2YgNi4xOCBpcyBmY2U2ZmVlMDgxN2I4ODk5ZTBlZTM4YWI2
Yjk4ZjBkN2U5MzljZWVkDQo+ID4NCj4gPiBQbGVhc2UgdXNlIGJlbG93IGNvbW1hbmRzIHRvIGdl
dCB0aGUgKDIwKSBwYXRjaGVzOg0KPiA+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODgkIGdpdCBmb3JtYXQtcGF0Y2gNCj4gdjcuMC4xMC4uLmZjZTZmZWUwODE3Yjg4OTllMGVlMzhh
YjZiOThmMGQ3ZTkzOWNlZWQgLS0gLi8NCj4gPg0KPiA+IFRoZW4geW91IGNhbiBhZGQgdGhlbSBv
bmUgYnkgb25lIHRvIHNlZSB3aGljaCBvbmUgaXMgdGhlIGNhdXNlLg0KPiA+DQo+ID4gVGhlIGdp
dCByZXBvc2l0b3J5IHlvdSBuZWVkIGlzOg0KPiA+IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXgtc3RhYmxlLmdpdA0KPiA+DQo+IA0KPiBJ
biBzaG9ydCBJIHNob3VsZCBidWlsZCB0aGUgTFRTIGtlcm5lbCB1c2luZyB0aGUgcHJvdmlkZWQg
c291cmNlIHdpdGgNCj4gYWxsIHRoZSBtb2R1bGUgcGF0Y2hlcyBhcHBsaWVkIG9uZSBieSBvbmUs
IGNvcnJlY3Q/DQoNClllcywgeW91IGNhbiB1c2UgTFRTIGtlcm5lbCBvciBkaXN0cm8gcmVsZWFz
ZSB2ZXJzaW9uLCBhbmQgb25seSByZS1idWlsZA0KYW5kIHJlcGxhY2UgZHJpdmVyLg0KDQo+IA0K
PiBJZiBzbywgc2hvdWxkIEkgYWxzbyBzZXQgdGhlIG1vZHByb2JlLmQgb3B0aW9ucyBwbHVzIGRp
c2FibGUgSU9NTVU/DQo+IA0KPiBBZnRlciBJIGtub3cgdGhpcyBJIGNhbiBzdGFydCB0ZXN0aW5n
Lg0KDQpUd28gZGlyZWN0aW9uczoNCg0KMS4gdHJ5IHRvIGZpeCBvbiAocHJvYmxlbWF0aWMpIDcu
MC4xMA0KDQogICBUcnkgbW9kcHJvYmUuZCBvcHRpb25zIGFuZC9vciBkaXNhYmxlIElPTU1VLg0K
DQoyLiBzdGFydCBmcm9tICh3b3JrYWJsZSkgNi4xOA0KDQogICBQaWNrIGFuZCBhcHBseSBwYXRj
aGVzIGZyb20gNi4xOCB0byA3LjAuMTAgb25lIGJ5IG9uZSB0byBmaW5kIHRoZSBjYXVzZS4NCg0K
ICAgQnV0IGFzIEkgbWVudGlvbmVkLCBJIGNhbid0IGZpbmQgd2hhdCBjYW4gYWZmZWN0IHRoZSBi
ZWhhdmlvciB5b3UgZW5jb3VudGVyZWQuDQoNCj4gDQo+IFNtYWxsIHVwZGF0ZTogdGhlIC4zNSBM
VFMga2VybmVsIGhhcyBubyBpc3N1ZXMgZm9yIG1lLCB3aGlsZSA3LjAuMTEgd29ya3MuDQoNCkRp
ZCB5b3UgbWVhbiA3LjAuMTAgZG9lc24ndCB3b3JrIHRvIHlvdSwgYnV0IDcuMC4xMSB3b3JrcyB3
ZWxsPw0KDQpIb3dldmVyLCB0aGUgcnR3ODggZHJpdmVyIGhhcyBubyBjaGFuZ2UgYmV0d2VlbiA3
LjAuMTAgYW5kIDcuMC4xMS4NCkkgZmVlbCB0aGUgY2F1c2UgbWlnaHQgYmUgY2hhbmdlcyBvZiBQ
Q0kgaG9zdCwgYnV0IGRyaXZlcnMvcGNpLyBoYXMgbm8gY2hhbmdlcw0KbmVpdGhlci4gTm8gb2J2
aW91cyBpZGVhIGZvciBub3cuDQoNCj4gDQo+IEkgd2FzIGFibGUgdG8gZ2V0IG15IGxhcHRvcCB0
byBzbGVlcCBhIGZldyB0aW1lcywgYnV0IGF0IGEgY2VydGFpbiBwb2ludA0KPiB0aGUgaXNzdWUg
aGFwcGVuZWQuDQo+IA0KPiBJdCBpcyBhIGJpdCBoYXJkIHRvIHJlcGxpY2F0ZSB0aGUgaXNzdWUs
IHNvIEkgd2lsbCB0cnkgbXkgYmVzdC4NCg0KSSBzdWdnZXN0IHRoYXQgeW91IGNhbiBnbyBiYWNr
IHRvIDcuMC4xMCBhbmQgdHJ5IDEwIG9yIDIwIHRpbWVzLCBhbmQgdGhlbg0KY29tcGFyZSB0aGUg
cmVzdWx0cyBiZXR3ZWVuIDcuMC4xMCBhbmQgNy4wLjExLg0KDQpQaW5nLUtlDQoNCg==

