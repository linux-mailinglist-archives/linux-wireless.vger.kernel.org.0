Return-Path: <linux-wireless+bounces-33748-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKHOGGzlwWkYXwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33748-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 02:14:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD9E30060D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 02:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 277FF30EB0CC
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 01:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C99114884C;
	Tue, 24 Mar 2026 01:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QIDHYjFI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911A2DB7B7
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 01:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774314430; cv=none; b=ZQ07jbFsdpfftI4hUmv0Y7hKL0w4ixNsmPXTIC9pduNx5wrNKmbPbtv11uyFwt3Uezj7T+NOc+PK1a8NUdOH0El+KcKZ1lbOirGkiefhnHDopV2xMFmdK8AYDAhbeywPvK5tYjsoyEsJ5c1qYMyHV9PBG4nEHEFNG/vXuLU/Z6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774314430; c=relaxed/simple;
	bh=brZT2lLO/BVs1aqqVt7hj8+5PG/Q4h+w4vGnyw34eHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A6WB01+GSKoPPMIr9v9S6dmDQnrE3SA4+NnILc0N56zxO9DAObGWERnORD3TFUnHTrVNzqFdkaSDo+/oIW8S7Hx+1m9l7NK41y5YNej7oNI2dD3l+6HCWmPc9b8sZMJ5rMrqNFzjSFw9CeMSHY8xb5L8zO9eXqV3D9NevKKyFS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QIDHYjFI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62O175cY4101046, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774314425; bh=brZT2lLO/BVs1aqqVt7hj8+5PG/Q4h+w4vGnyw34eHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QIDHYjFIDHtj7UxJXpYKuHAMPXVQInMvYAQacNuP0OUU2/6zqD+fKoZzWsWaMJPpA
	 k3sCD03t5oF3UpN7mVcJ9pe2nXcl90rbmR4gX+T8+TUKuIKOBG006bVBDxb4PoHvYX
	 5A+9DVHfYdcuwFtl07F/470ix6M6vllOJXDRqMXuJRYddrLOX2vJgtTS0XuTjunU/w
	 qgm3bsWG1jrmqb1wFHiOjDJEnUXsCrthxWoEJNkB8J5mmCem43VUuiu1d2KrXaEDd9
	 SP68Cx3RniC1tmj004tIUdUR5jGh0ZfUaSZdVfD3k8ES55hymNb5KTzduZ592NGEFe
	 DItUHQ7anyoEw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62O175cY4101046
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 09:07:05 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Mar 2026 09:07:05 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Tue, 24 Mar 2026 09:07:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: LB F <goainwo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: validate RX rate to prevent
 out-of-bound
Thread-Topic: [PATCH rtw-next] wifi: rtw88: validate RX rate to prevent
 out-of-bound
Thread-Index: AQHcumiuipQYWq0Jp0K/e3ofHIVNXLW8TC4AgACPWrA=
Date: Tue, 24 Mar 2026 01:07:05 +0000
Message-ID: <27c838b55d794708b875fef31758ae8e@realtek.com>
References: <20260323015849.9424-1-pkshih@realtek.com>
 <CALdGYqS_ROWrsYishahHxEthwYYfxurOxCCWJjOApgbnmekeWw@mail.gmail.com>
In-Reply-To: <CALdGYqS_ROWrsYishahHxEthwYYfxurOxCCWJjOApgbnmekeWw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33748-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
X-Rspamd-Queue-Id: 9DD9E30060D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TEIgRiA8Z29haW53b0BnbWFpbC5jb20+IHdyb3RlOg0KPiBQaW5nLUtlIFNoaWggPHBrc2hpaEBy
ZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4gVGhlIHJlcG9ydGVkIFJYIHJhdGUgbWlnaHQgYmUgdW5l
eHBlY3RlZCwgY2F1c2luZyBrZXJuZWwgd2FybnM6DQo+ID4gICBSYXRlIG1hcmtlZCBhcyBhIFZI
VCByYXRlIGJ1dCBkYXRhIGlzIGludmFsaWQ6IE1DUzogMCwgTlNTOiAwDQo+ID4gICBXQVJOSU5H
OiBuZXQvbWFjODAyMTEvcnguYzo1NDkxIGF0IGllZWU4MDIxMV9yeF9saXN0KzB4MTgzLzB4MTAy
MA0KPiBbbWFjODAyMTFdDQo+ID4gQXMgdGhlIFJYIHJhdGUgY2FuIGJlIGluZGV4IG9mIGFuIGFy
cmF5IHVuZGVyIGNlcnRhaW4gY29uZGl0aW9ucywgdmFsaWRhdGUNCj4gPiBpdCB0byBwcmV2ZW50
IGFjY2Vzc2luZyBhcnJheSBvdXQtb2YtYm91bmQgcG90ZW50aWFsbHkuDQo+IA0KPiBUZXN0ZWQg
b24gSFAgTm90ZWJvb2sgUDNTOTVFQSNBQ0IgKGtlcm5lbCA2LjE5LjktMS1jYWNoeW9zKToNCj4g
DQo+ICAgLSBObyBXQVJOSU5HOiBuZXQvbWFjODAyMTEvcnguYzo1NDkxIG9ic2VydmVkIGFmdGVy
IHBhdGNoLg0KPiAgIC0gU3lzdGVtIHJlbWFpbnMgZnVsbHkgc3RhYmxlIHRocm91Z2ggaWRsZSwg
bG9hZCwgQmx1ZXRvb3RoIEEyRFANCj4gICAgIHVzYWdlLCBhbmQgbXVsdGlwbGUgc3VzcGVuZC9y
ZXN1bWUgY3ljbGVzLg0KPiAgIC0gWmVybyBoMmMgb3IgbHBzIGVycm9ycyBpbiBkbWVzZy4NCj4g
DQo+IFRlc3RlZC1ieTogT2xla3NhbmRyIEhhdnJ5bG92IDxnb2FpbndvQGdtYWlsLmNvbT4NCg0K
VGhhbmtzIGZvciB5b3VyIHRlc3QuIEFzIHRoZSBjaGFuZ2UgaW4gZGF0YSBwYXRoLCBJJ2QgYWRk
IGFuIHVubGlrZWx5KCkNCmJ5IHYyLiBBbHNvLCB0YWtlIHlvdXIgdGVzdCBpbmZvLiBJZiB2MiBk
b2Vzbid0IHdvcmsgdG8geW91IChJIHRoaW5rDQp0aGUgcmVzdWx0IG9mIHYyIG11c3QgYmUgaWRl
bnRpY2FsIHRvIHYxKSwgcGxlYXNlIE5BQ0sgbWUgYnkgdjIgcGF0Y2gNCkkgd2lsbCBzZW5kIG91
dCByaWdodCBhd2F5Lg0KDQpQaW5nLUtlDQoNCg0K

