Return-Path: <linux-wireless+bounces-33690-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCYMO+MIwWmtPwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33690-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 10:33:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5274D2EF216
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 10:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2680302D120
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 09:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3B6387349;
	Mon, 23 Mar 2026 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aDYqtESG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124438657F
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258308; cv=none; b=I5O56GNMZmToDZxhucaFNjUhin5gaIfsuWSlko8paJgs1Eye5dJ4AA+OUgb0m3RH/CKTKxzxDfJ4zISQyNB/CWqz6CZRjSRF0bRzoJREMRLzcbBpK6ZIvcNeEoO5D7ivtw5s8PTIDUFhzZVfkq7/mqbncsHxUIArZruX5Z701GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258308; c=relaxed/simple;
	bh=7JU/NtzCg9lqw30pud6sxq1Iw2T9TthZU20DPbDOTPg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YAK1ATmUXlJuK788NjUgPZX27sNvJ3NHZo1RH16PB1EkD0BMtEMj9ZZvUhzTv1GF/+ZByZgjpU3p++Qv/IPdeY5XzrXVWccJOrVCVd1ZO8XdfEv29Mzm8GSoC6fFrG33eiHjyDawRwRWKNqmw5oeacquv/19OpoZ8gLHXKvJ6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aDYqtESG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62N9V8dX42877691, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774258268; bh=7JU/NtzCg9lqw30pud6sxq1Iw2T9TthZU20DPbDOTPg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=aDYqtESG7SFyftbuNfqDDVo485Pdj1AQMbLTHVnkgrbSZYs4CSJxfNQ7OVAMWY9Xt
	 lO1HNF/fLbr/fBwLf3hEJTs6WuJ0wqFsr8bu9YDLcc/49dw8E6Qe5S3FIpcjDyDI+k
	 KpEWfxoH0PGnegBi/5Ns4F34PwEl6Qvj4LVdEHGzEbCRfXn040h4wHNTPKjDkCPwBo
	 nYIrv8AGbwiTm1stuo5UmZppBZBNFMj2WoIEI8Tsy874bxUnMLDSJDuqddxUk/f2V0
	 x5TR/HLsnAaLs4M3JPzWtJ+IGvX/+PRtso2OcMHBTv/S1J0GdvJSD153hDi87mGdmf
	 /K2eLfpHyGvgA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62N9V8dX42877691
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 17:31:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Mar 2026 17:31:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Mar 2026 17:31:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 23 Mar 2026 17:31:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Lucid Duck <lucid_duck@justthetip.ca>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH v2] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Topic: [PATCH v2] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Index: AQHcuOQb90SZVl0Vy0mC7JoZ7Dgc1LW71zvA
Date: Mon, 23 Mar 2026 09:31:08 +0000
Message-ID: <f2fca9db9deb445c91b1973c6b7ca72a@realtek.com>
References: <20260125221943.36001-1-lucid_duck@justthetip.ca>
 <20260321040000.31192-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260321040000.31192-1-lucid_duck@justthetip.ca>
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33690-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,justthetip.ca:email];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5274D2EF216
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

THVjaWQgRHVjayA8bHVjaWRfZHVja0BqdXN0dGhldGlwLmNhPiB3cm90ZToNCj4gRnJvbTogTHVj
aWQgRHVjayA8bHVjaWRfZHVja0BqdXN0dGhldGlwLmNhPg0KPiBEYXRlOiBUaHUsIDIwIE1hciAy
MDI2IDIwOjAwOjAwIC0wNzAwDQo+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gd2lmaTogcnR3ODk6IHVz
YjogZml4IFRYIGZsb3cgY29udHJvbCBieSB0cmFja2luZw0KPiAgaW4tZmxpZ2h0IFVSQnMNCg0K
V2hhdCBpcyB5b3VyIG1haWxlcj8gTm90ICdnaXQgc2VuZC1lbWFpbCc/DQpJJ20gbm90IHN1cmUg
aWYgSSBjYW4gYXBwbHkgdGhpcyBieSBwYXRjaHdvcmsgdG9vbC4NCg0KPiANCj4gcnR3ODlfdXNi
X29wc19jaGVja19hbmRfcmVjbGFpbV90eF9yZXNvdXJjZSgpIHJldHVybnMgYSBoYXJkY29kZWQN
Cj4gcGxhY2Vob2xkZXIgdmFsdWUgKDQyKSBpbnN0ZWFkIG9mIGFjdHVhbCBUWCByZXNvdXJjZSBh
dmFpbGFiaWxpdHkuDQo+IFRoaXMgdmlvbGF0ZXMgbWFjODAyMTEncyBmbG93IGNvbnRyb2wgY29u
dHJhY3QsIHByZXZlbnRpbmcgYmFja3ByZXNzdXJlDQo+IGFuZCBjYXVzaW5nIHVuY29udHJvbGxl
ZCBVUkIgYWNjdW11bGF0aW9uIHVuZGVyIHN1c3RhaW5lZCBUWCBsb2FkLg0KPiANCj4gRml4IGJ5
IGFkZGluZyBwZXItY2hhbm5lbCBhdG9taWMgY291bnRlcnMgKHR4X2luZmxpZ2h0W10pIHRoYXQg
dHJhY2sNCj4gaW4tZmxpZ2h0IFVSQnM6DQo+IA0KPiAtIEluY3JlbWVudCBiZWZvcmUgdXNiX3N1
Ym1pdF91cmIoKSB3aXRoIHJvbGxiYWNrIG9uIGZhaWx1cmUNCj4gLSBEZWNyZW1lbnQgaW4gY29t
cGxldGlvbiBjYWxsYmFjaw0KPiAtIFJldHVybiAoTUFYX1VSQlMgLSBpbmZsaWdodCkgdG8gbWFj
ODAyMTEsIG9yIDAgd2hlbiBhdCBjYXBhY2l0eQ0KPiAtIEV4Y2x1ZGUgZmlybXdhcmUgY29tbWFu
ZCBjaGFubmVsIChDSDEyKSBmcm9tIHRyYWNraW5nDQo+IA0KPiBUaGUgcHJlLWluY3JlbWVudCBw
YXR0ZXJuIHByZXZlbnRzIGEgcmFjZSB3aGVyZSB0aGUgVVNCIGNvcmUgY29tcGxldGVzDQo+IHRo
ZSBVUkIgKHBvc3NpYmx5IG9uIGFub3RoZXIgQ1BVKSBiZWZvcmUgdGhlIHN1Ym1pdHRpbmcgY29k
ZSBpbmNyZW1lbnRzDQo+IHRoZSBjb3VudGVyLg0KPiANCj4gVGVzdGVkIG9uIEQtTGluayBEV0Et
WDE4NTAgKFJUTDg4MzJBVSksIGtlcm5lbCA2LjE4LjM6DQo+IA0KPiAgICAgICAgICAgICAgICAg
ICAgICBVbnBhdGNoZWQgLT4gUGF0Y2hlZA0KPiAgIFVTQjMgNUdIeiBETDogICAgICA0OTQgLT4g
NzA5IE1icHMgKCs0NCUpDQo+ICAgVVNCMyA1R0h6IHJldHg6ICAgIDggLT4gMSAoLTg4JSkNCj4g
ICBVU0IzIDIuNEdIeiBETDogICAgNTQgLT4gNjggTWJwcyAoKzI1JSkNCj4gICBVU0IyIDVHSHog
REw6ICAgICAgMTk2IC0+IDIyNSBNYnBzICgrMTUlKQ0KPiAgIFVTQjIgMi40R0h6IERMOiAgICAx
MjMgLT4gMTMxIE1icHMgKCs2JSkNCg0KQXMgdGhpcyBwYXRjaCBkb2VzIFRYIGZsb3cgY29udHJv
bCwgY291bGQgeW91IHNoYXJlIHRoZSB1cGxpbmsgZGF0YQ0KYXMgd2VsbD8NCg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogTHVjaWQgRHVjayA8bHVjaWRfZHVja0BqdXN0dGhldGlwLmNhPg0KPiAtLS0N
Cj4gUmVzZW5kaW5nIHYyLiBUaGlzIHdhcyBwcmVwYXJlZCBpbiBsYXRlIEphbnVhcnkgYWZ0ZXIg
YWRkcmVzc2luZyB2MQ0KPiByZXZpZXcgZmVlZGJhY2ssIGJ1dCB0aGUgc2VuZCBmYWlsZWQgc2ls
ZW50bHkgKFNNVFAgbWlzY29uZmlndXJhdGlvbikNCj4gYW5kIG5ldmVyIGFwcGVhcmVkIG9uIGxv
cmUua2VybmVsLm9yZy4gQXBvbG9naWVzIGZvciB0aGUgZGVsYXkuDQo+IA0KPiBDaGFuZ2VzIHNp
bmNlIHYxOg0KPiAtIFJlbW92ZWQgZHVwbGljYXRlICJUWCBmbG93IGNvbnRyb2wiIGNvbW1lbnQg
KFBpbmctS2UgU2hpaCkNCj4gLSBBZGRlZCB0ZXN0IHJlc3VsdHMgdG8gY29tbWl0IG1lc3NhZ2Ug
KFBpbmctS2UgU2hpaCkNCj4gDQo+IEJpdHRlcmJsdWUncyBDSDEyIHF1ZXN0aW9uIGZyb20gdjE6
IHRoZSBDSDEyIGd1YXJkcyBpbiB0eF9raWNrX29mZigpDQo+IGFuZCB3cml0ZV9wb3J0X2NvbXBs
ZXRlKCkgYXJlIGEgbWF0Y2hlZCBwYWlyLiB0eF9raWNrX29mZigpIHNraXBzDQo+IGF0b21pY19p
bmMgZm9yIENIMTIsIHNvIHRoZSBjb21wbGV0aW9uIGhhbmRsZXIgbXVzdCBza2lwIGF0b21pY19k
ZWMNCj4gdG8gbWF0Y2guIFJlbW92aW5nIG9ubHkgdGhlIGNvbXBsZXRpb24gc2lkZSBjYXVzZXMg
Y291bnRlciB1bmRlcmZsb3cuDQo+IA0KPiBBZGRpdGlvbmFsIHZhbGlkYXRpb246IDEwMC1pdGVy
YXRpb24gc3RyZXNzIHRlc3QsIDUwLWl0ZXJhdGlvbg0KPiB0ZWFyZG93biAocm1tb2QvbW9kcHJv
YmUgdW5kZXIgbG9hZCksIDEweCBob3QtdW5wbHVnIGR1cmluZyBhY3RpdmUNCj4gVFgsIGFuZCAz
MC1taW51dGUgc29hayAtLSBhbGwgcGFzcyB3aXRoIGNvdW50ZXJzIGJhbGFuY2VkIGF0IGlkbGUu
DQo+IA0KPiBUaGUgMzItVVJCLXBlci1jaGFubmVsIGxpbWl0IGlzIGJhc2VkIG9uIHNpbWlsYXIg
VVNCIHdpcmVsZXNzIGRyaXZlcnMNCj4gKG10NzYsIGF0aDlrX2h0YykuIFRoZSBmaXhlZCB2YWx1
ZSB3b3JrcyB3ZWxsIGZvciBib3RoIFVTQjIgYW5kIFVTQjMuDQoNCkNhbiBpbmNyZWFzaW5nIDMy
IGdldCBiZXR0ZXIgcGVyZm9ybWFuY2U/IFRoZSBzdHJlc3MgdGVzdCB3aXRoIHNtYWxsDQpwYWNr
ZXRzIG1pZ2h0IHlpZWxkIGxvdyB0aHJvdWdocHV0PyAoSnVzdCBhIHF1ZXN0aW9uKQ0KDQo+IA0K
PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS91c2IuYyB8IDI2ICsrKysrKysr
KysrKysrKysrKy0tLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3Vz
Yi5oIHwgIDYgKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OS91c2IuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkv
dXNiLmMNCj4gaW5kZXggZWI0ODlkZi4uZmFhZmEzYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS91c2IuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg5L3VzYi5jDQo+IEBAIC0xNjEsMTYgKzE2MSwyNSBAQCBzdGF0aWMg
dTMyDQo+ICBydHc4OV91c2Jfb3BzX2NoZWNrX2FuZF9yZWNsYWltX3R4X3Jlc291cmNlKHN0cnVj
dCBydHc4OV9kZXYgKnJ0d2RldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1OCB0eGNoKQ0KPiAgew0KPiArICAgICAgIHN0cnVjdCBydHc4OV91c2IgKnJ0
d3VzYiA9IHJ0dzg5X3VzYl9wcml2KHJ0d2Rldik7DQo+ICsgICAgICAgaW50IGluZmxpZ2h0Ow0K
PiArDQo+ICsgICAgICAgLyogRmlybXdhcmUgY29tbWFuZCBjaGFubmVsIGlzIG5vdCB0cmFja2Vk
ICovDQo+ICAgICAgICAgaWYgKHR4Y2ggPT0gUlRXODlfVFhDSF9DSDEyKQ0KPiAgICAgICAgICAg
ICAgICAgcmV0dXJuIDE7DQo+IA0KPiAtICAgICAgIHJldHVybiA0MjsgLyogVE9ETyBzb21lIGtp
bmQgb2YgY2FsY3VsYXRpb24/ICovDQo+ICsgICAgICAgaW5mbGlnaHQgPSBhdG9taWNfcmVhZCgm
cnR3dXNiLT50eF9pbmZsaWdodFt0eGNoXSk7DQo+ICsgICAgICAgaWYgKGluZmxpZ2h0ID49IFJU
Vzg5X1VTQl9NQVhfVFhfVVJCU19QRVJfQ0gpDQoNCk91dCBvZiBjdXJpb3NpdHkuIElzIGl0IHBv
c3NpYmxlIGluZmxpZ2h0ID4gUlRXODlfVVNCX01BWF9UWF9VUkJTX1BFUl9DSD8NCg0KPiArICAg
ICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gUlRXODlfVVNCX01B
WF9UWF9VUkJTX1BFUl9DSCAtIGluZmxpZ2h0Ow0KPiAgfQ0KPiANCj4gIHN0YXRpYyB2b2lkIHJ0
dzg5X3VzYl93cml0ZV9wb3J0X2NvbXBsZXRlKHN0cnVjdCB1cmIgKnVyYikNCj4gIHsNCj4gICAg
ICAgICBzdHJ1Y3QgcnR3ODlfdXNiX3R4X2N0cmxfYmxvY2sgKnR4Y2IgPSB1cmItPmNvbnRleHQ7
DQo+ICAgICAgICAgc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2ID0gdHhjYi0+cnR3ZGV2Ow0KPiAr
ICAgICAgIHN0cnVjdCBydHc4OV91c2IgKnJ0d3VzYiA9IHJ0dzg5X3VzYl9wcml2KHJ0d2Rldik7
DQo+ICAgICAgICAgc3RydWN0IGllZWU4MDIxMV90eF9pbmZvICppbmZvOw0KPiAgICAgICAgIHN0
cnVjdCBydHc4OV90eHdkX2JvZHkgKnR4ZGVzYzsNCj4gICAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAq
c2tiOw0KPiBAQCAtMjI5LDYgKzIzOCwxMCBAQCBzdGF0aWMgdm9pZCBydHc4OV91c2Jfd3JpdGVf
cG9ydF9jb21wbGV0ZShzdHJ1Y3QgdXJiICp1cmIpDQo+ICAgICAgICAgICAgICAgICBicmVhazsN
Cj4gICAgICAgICB9DQo+IA0KPiArICAgICAgIC8qIERlY3JlbWVudCBpbi1mbGlnaHQgY291bnRl
ciAoc2tpcCBmaXJtd2FyZSBjb21tYW5kIGNoYW5uZWwpICovDQo+ICsgICAgICAgaWYgKHR4Y2It
PnR4Y2ggIT0gUlRXODlfVFhDSF9DSDEyKQ0KPiArICAgICAgICAgICAgICAgYXRvbWljX2RlYygm
cnR3dXNiLT50eF9pbmZsaWdodFt0eGNiLT50eGNoXSk7DQo+ICsNCj4gICAgICAgICBrZnJlZSh0
eGNiKTsNCj4gIH0NCj4gDQo+IEBAIC0zMDYsOSArMzE5LDE3IEBAIHN0YXRpYyB2b2lkIHJ0dzg5
X3VzYl9vcHNfdHhfa2lja19vZmYoc3RydWN0IHJ0dzg5X2Rldg0KPiAqcnR3ZGV2LCB1OCB0eGNo
KQ0KPiANCj4gICAgICAgICAgICAgICAgIHNrYl9xdWV1ZV90YWlsKCZ0eGNiLT50eF9hY2tfcXVl
dWUsIHNrYik7DQo+IA0KPiArICAgICAgICAgICAgICAgLyogSW5jcmVtZW50IEJFRk9SRSBzdWJt
aXQgdG8gYXZvaWQgcmFjZSB3aXRoIGNvbXBsZXRpb24gKi8NCj4gKyAgICAgICAgICAgICAgIGlm
ICh0eGNoICE9IFJUVzg5X1RYQ0hfQ0gxMikNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgYXRv
bWljX2luYygmcnR3dXNiLT50eF9pbmZsaWdodFt0eGNoXSk7DQo+ICsNCj4gICAgICAgICAgICAg
ICAgIHJldCA9IHJ0dzg5X3VzYl93cml0ZV9wb3J0KHJ0d2RldiwgdHhjaCwgc2tiLT5kYXRhLCBz
a2ItPmxlbiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHR4
Y2IpOw0KPiAgICAgICAgICAgICAgICAgaWYgKHJldCkgew0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAvKiBSb2xsYmFjayBpbmNyZW1lbnQgb24gZmFpbHVyZSAqLw0KPiArICAgICAgICAgICAg
ICAgICAgICAgICBpZiAodHhjaCAhPSBSVFc4OV9UWENIX0NIMTIpDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYXRvbWljX2RlYygmcnR3dXNiLT50eF9pbmZsaWdodFt0eGNoXSk7
DQo+ICsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJldCAhPSAtRU5PREVWKQ0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJ0dzg5X2VycihydHdkZXYsICJ3cml0ZSBw
b3J0IHR4Y2ggJWQgZmFpbGVkOg0KPiAlZFxuIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdHhjaCwgcmV0KTsNCj4gQEAgLTY2Niw4ICs2ODcsMTAgQEAgc3Rh
dGljIHZvaWQgcnR3ODlfdXNiX2luaXRfdHgoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2KQ0KPiAg
ICAgICAgIHN0cnVjdCBydHc4OV91c2IgKnJ0d3VzYiA9IHJ0dzg5X3VzYl9wcml2KHJ0d2Rldik7
DQo+ICAgICAgICAgaW50IGk7DQo+IA0KPiAtICAgICAgIGZvciAoaSA9IDA7IGkgPCBBUlJBWV9T
SVpFKHJ0d3VzYi0+dHhfcXVldWUpOyBpKyspDQo+ICsgICAgICAgZm9yIChpID0gMDsgaSA8IEFS
UkFZX1NJWkUocnR3dXNiLT50eF9xdWV1ZSk7IGkrKykgew0KPiAgICAgICAgICAgICAgICAgc2ti
X3F1ZXVlX2hlYWRfaW5pdCgmcnR3dXNiLT50eF9xdWV1ZVtpXSk7DQo+ICsgICAgICAgICAgICAg
ICBhdG9taWNfc2V0KCZydHd1c2ItPnR4X2luZmxpZ2h0W2ldLCAwKTsNCj4gKyAgICAgICB9DQo+
ICB9DQo+IA0KPiAgc3RhdGljIHZvaWQgcnR3ODlfdXNiX2RlaW5pdF90eChzdHJ1Y3QgcnR3ODlf
ZGV2ICpydHdkZXYpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg5L3VzYi5oDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS91c2Iu
aA0KPiBpbmRleCA5ZjU1NGI1Li4xNDU5MTIyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3VzYi5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnR3ODkvdXNiLmgNCj4gQEAgLTIwLDYgKzIwLDkgQEANCj4gICNkZWZpbmUgUlRX
ODlfTUFYX0VORFBPSU5UX05VTSAgICAgICAgIDkNCj4gICNkZWZpbmUgUlRXODlfTUFYX0JVTEtP
VVRfTlVNICAgICAgICAgIDcNCj4gDQo+ICsvKiBUWCBmbG93IGNvbnRyb2w6IG1heCBpbi1mbGln
aHQgVVJCcyBwZXIgY2hhbm5lbCAqLw0KDQpJIHRoaW5rIHRoZSBjb2RlIHNlbGYtZXhwbGFpbiB0
aGlzIGFscmVhZHkuIE5vIG5lZWQgdGhpcyBjb21tZW50LiANCkl0J2QgYmUgaGVscGZ1bCBpZiB5
b3UgY2FuIGV4cGxhaW4gaG93IHlvdSBkZWNpZGUgMzIuIA0KKEluIGNvbW1pdCBtZXNzYWdlLCB5
b3UgbWVudGlvbmVkIHRoaXMgaW1pdGF0ZSBvdGhlciBkcml2ZXJzLCBzbw0Kbm8gbmVlZCBjb21t
ZW50IGFib3V0IHRoYXQuKQ0KDQo+ICsjZGVmaW5lIFJUVzg5X1VTQl9NQVhfVFhfVVJCU19QRVJf
Q0ggICAzMg0KPiArDQo+ICBzdHJ1Y3QgcnR3ODlfdXNiX2luZm8gew0KPiAgICAgICAgIHUzMiB1
c2JfaG9zdF9yZXF1ZXN0XzI7DQo+ICAgICAgICAgdTMyIHVzYl93bGFuMF8xOw0KPiBAQCAtNjMs
NiArNjYsOSBAQCBzdHJ1Y3QgcnR3ODlfdXNiIHsNCj4gICAgICAgICBzdHJ1Y3QgdXNiX2FuY2hv
ciB0eF9zdWJtaXR0ZWQ7DQo+IA0KPiAgICAgICAgIHN0cnVjdCBza19idWZmX2hlYWQgdHhfcXVl
dWVbUlRXODlfVFhDSF9OVU1dOw0KPiArDQo+ICsgICAgICAgLyogVFggZmxvdyBjb250cm9sOiB0
cmFjayBpbi1mbGlnaHQgVVJCcyBwZXIgY2hhbm5lbCAqLw0KDQpJJ2Qgbm90IHByZWZlciB0aGlz
IGNvbW1lbnQgbmVpdGhlci4gDQoNCj4gKyAgICAgICBhdG9taWNfdCB0eF9pbmZsaWdodFtSVFc4
OV9UWENIX05VTV07DQo+ICB9Ow0KPiANCj4gIHN0YXRpYyBpbmxpbmUgc3RydWN0IHJ0dzg5X3Vz
YiAqcnR3ODlfdXNiX3ByaXYoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2KQ0KPiAtLQ0KPiAyLjUz
LjANCg==

