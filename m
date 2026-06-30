Return-Path: <linux-wireless+bounces-38311-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ypyAF/oSQ2rCPAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38311-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 02:51:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA60D6DF748
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 02:51:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=a12h5ypg;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38311-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38311-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 679FC302B387
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 00:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB45D1A9F97;
	Tue, 30 Jun 2026 00:51:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667A1E885A
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 00:51:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782780663; cv=none; b=NUpwL1ul75X2JLJh3xrmkZ6CCe9VLerJnXKTYDSIX6xiUOmoO+a0vhHgZ6Ua7pZ4PJh/zf9NR4SKHo5M0q5kR2HdJ5y/sBm2MZSw7egJZAaRJiUn5lmOBaMRlyoqBqqk0HE+Ja056hU1bR4iggkiK9xBKlK9X7zB2jR6GFVX4OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782780663; c=relaxed/simple;
	bh=D6Av6vQVkS6t7L+yuNCac1E+6D7/FUD+nezg44h8OfQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nBOEZj6hba+jORG99SsOp9SRp3n7jV51YFQ0HDHGOdUqShS1SWiLYUqYJ4LxZ0eai98MFUxJdLWrbvm+X0EB6FbQXENBTiKknxqo/xqfIKT88jlIf95hHhgNsmrmLqWSQq7tJGM0lccahjNe4S6Wu8D0yVBN4QueYV0aef9BD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=a12h5ypg; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65U0ovl574030798, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782780657; bh=D6Av6vQVkS6t7L+yuNCac1E+6D7/FUD+nezg44h8OfQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=a12h5ypgbTW4fEE3Av0HOgtSKGbN9i1KURWKzqycheYbkP8c96U/CrRlmWUUns9Lc
	 SQdNn8Zf7A9lcVITBih7aeee/jaCYUhidtclNcISXqtJJ/E5bTW/qho9IoaLYJoIPc
	 I6sHOMlYZFmQFO0BfyxJB9HdF1Lbm1NMuP05xxRPhvwKEOgf6r3SbZfs4fA8i72Yo5
	 OmusWwlKDcb9s4AmmIU5baiLWU5Nctcb9qronpe3ngTRngiHDbiMN9wB+mHq2MLf4c
	 mrKuR8vWwjWqnVcrriEE1K/6AMfbxomB4QGk6nOsKFjxB4O84lPN8RPJxL5xgXfRF0
	 wfgLo09MTEt/A==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65U0ovl574030798
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jun 2026 08:50:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 30 Jun 2026 08:50:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 30 Jun 2026 08:50:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 30 Jun 2026 08:50:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Doug Brewer <brewer.doug@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: rtw89: RTL8852BE P2P-device iftype and STA+P2P interface
 combination
Thread-Topic: rtw89: RTL8852BE P2P-device iftype and STA+P2P interface
 combination
Thread-Index: AQHdBsiUWEi4pimYHEaDlfxBkcAE67ZUyXVQ//+oOQCAAdAv0A==
Date: Tue, 30 Jun 2026 00:50:58 +0000
Message-ID: <02d3be993ed84cf983cf995e53c86f1f@realtek.com>
References: <CAG0V13TRHzXtoMY=XZMOd=WjzS58Cu=aePFCz8mY6UoGYm5dXw@mail.gmail.com>
 <54e7877f76944bd29e57d6eafe5e3811@realtek.com>
 <CAG0V13Qfp+eVCR6NjQJydN-fL8tus_EyJCWGQqQxTkKA9ZXBFQ@mail.gmail.com>
In-Reply-To: <CAG0V13Qfp+eVCR6NjQJydN-fL8tus_EyJCWGQqQxTkKA9ZXBFQ@mail.gmail.com>
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
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brewer.doug@gmail.com,m:linux-wireless@vger.kernel.org,m:brewerdoug@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38311-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA60D6DF748

RG91ZyBCcmV3ZXIgPGJyZXdlci5kb3VnQGdtYWlsLmNvbT4gd3JvdGU6DQo+IE9uIE1vbiwgSnVu
IDI5LCAyMDI2IGF0IDEwOjEw4oCvQU0gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gRG91ZyBCcmV3ZXIgd3JvdGU6DQo+ID4gPiBIaSwNCj4gPiA+DQo+
ID4gPiBJJ20gZXhwZXJpbWVudGluZyB3aXRoIFdpLUZpIERpc3BsYXkgKE1pcmFjYXN0IHNpbmsp
IGNvbmN1cnJlbnQgd2l0aCBhbg0KPiA+ID4gU1RBIGNvbm5lY3Rpb24gb24gYW4gUlRMODg1MkJF
IChQQ0llKSB1c2luZyB0aGUgbWFpbmxpbmUgcnR3ODkgZHJpdmVyDQo+ID4gPiAoa2VybmVsIDYu
MTguMzcpLg0KPiA+ID4NCj4gPiA+IGl3IHBoeSByZXBvcnRzOg0KPiA+ID4gU3VwcG9ydGVkIGlu
dGVyZmFjZSBtb2RlczoNCj4gPiA+ICAgICogbWFuYWdlZCwgQVAsIFAyUC1jbGllbnQsIFAyUC1H
Tw0KPiA+ID4gICAgKG5vIFAyUC1kZXZpY2UpDQo+ID4gPiBpbnRlcmZhY2UgY29tYmluYXRpb25z
IGFyZSBub3Qgc3VwcG9ydGVkDQo+ID4gPg0KPiA+ID4gSW4gcHJhY3RpY2UgdGhpcyBibG9ja3Mg
dGhlIHN0YW5kYXJkIFAyUCBmbG93OiB0aGVyZSBpcyBubyBQMlAtZGV2aWNlDQo+ID4gPiBpZnR5
cGUgZm9yIGEgZGVkaWNhdGVkIGRpc2NvdmVyeSBjb250ZXh0LCBhbmQgbm8gYWR2ZXJ0aXNlZCBp
bnRlcmZhY2UNCj4gPiA+IGNvbWJpbmF0aW9uIGZvciBtYW5hZ2VkICsgUDJQLWNsaWVudCBjb2V4
aXN0ZW5jZS4NCj4gPiA+DQo+ID4gPiBNeSBxdWVzdGlvbnM6DQo+ID4gPiAxLiBpcyBQMlAtZGV2
aWNlIGlmdHlwZSBzdXBwb3J0IHBsYW5uZWQgZm9yIHJ0dzg5IG9uIFJUTDg4NXg/IElzIHRoZXJl
IGENCj4gPiA+ICAgICBrbm93biB0ZWNobmljYWwgYmxvY2tlciwgb3IgaXMgaXQgc2ltcGx5IG5v
dCB5ZXQgaW1wbGVtZW50ZWQ/DQo+ID4NCj4gPiBXZSBhcmUgcGxhbm5pbmcgdG8gYWRkIFAyUC1k
ZXZpY2UgaWZ0eXBlLiBJdCBuZWVkcyB0byBjb25zaWRlciB0aGUgY2FzZXMgb2YNCj4gPiBjaGFu
bmVsIGNvbnRleHQsIGNvbmRpdGlvbnMgb2YgcG93ZXIgc2F2ZSwgYW5kIGV0Yy4gSXQgd2lsbCB0
YWtlIHNvbWUgdGltZS4NCj4gPg0KPiA+IEkgdGhpbmsgaXQgd291bGQgYmUgb2theSB0aGF0IHlv
dSB1c2UgU1RBIGludGVyZmFjZSB0byBkbyBQMlAgbmVnb3RpYXRpb24sDQo+ID4gYW5kIHRoZW4g
Y3JlYXRlIFAyUC1jbGllbnQgb3IgUDJQLUdPIGlmdHlwZSB0aGVuLg0KPiA+DQo+ID4gPiAyLiB3
b3VsZCBhZHZlcnRpc2luZyBhIG1hbmFnZWQgKyBQMlAtY2xpZW50IGludGVyZmFjZSBjb21iaW5h
dGlvbg0KPiA+ID4gICAgIChzaW5nbGUgY2hhbm5lbCkgYmUgZmVhc2libGUgb24gdGhlIGN1cnJl
bnQgcnR3ODk/DQo+ID4NCj4gPiBUaGlzIGlzIGEgU0NDIHdoaWNoIGlzIHN1cHBvcnRlZC4NCj4g
Pg0KPiA+ID4gMy4gaXMgTUNDICgjY2hhbm5lbHMgPiAxKSBvbiB0aGUgcm9hZG1hcCwgb3IgY29u
c2lkZXJlZCBvdXQgb2Ygc2NvcGU/DQo+ID4NCj4gPiBDdXJyZW50IHN1cHBvcnQgTUNDIGFzIHdl
bGwuIEhvd2V2ZXIsIHdlIGFyZSBjb29raW5nIG5ldyBmaXJtd2FyZSB0byBzdXBwb3J0DQo+ID4g
aHdfc2NhbiB3aXRoIHR3byBvcGVyYXRpb24gY2hhbm5lbHMgLS0gd2hpY2ggZG9lc24ndCBtYXR0
ZXIgaWYgeW91IGRvbid0IG5lZWQNCj4gPiB0byBkbyBzY2FuIHdoZW4gTUNDIGlzIG9wZXJhdGlu
Zy4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24uIEkgdHJpZWQgdXNpbmcgdGhlIFNU
QSBpbnRlcmZhY2UgZm9yIFAyUA0KPiBuZWdvdGlhdGlvbiwgYW5kIHdhbnRlZCB0byBzaGFyZSB3
aGF0IEkgZm91bmQuDQo+IA0KPiBXaXRoIHRoZSBTVEEgY29ubmVjdGVkICgyLjRHSHogY2gxMSkg
YW5kIGFuIGFjdGl2ZSBwMnBfY29ubmVjdCwgYQ0KPiB3cGFfc3VwcGxpY2FudCAtZGQgdHJhY2Ug
c2hvd3MgR08gbmVnb3RpYXRpb24gZ2V0dGluZyBmYWlybHkgZmFyOg0KPiANCj4gUGVlcidzIEdP
LU5FRyBSZXF1ZXN0IGlzIHJlY2VpdmVkDQo+IHNlbmQgdGhlIEdPLU5FRyBSZXNwb25zZSBvbiBj
aDExLCBwZWVyIEFDS3MgaXQgKFRYIGFjaz0xKQ0KPiBTdGF0ZSBnb2VzIEdPX05FRyAtPiBDT05O
RUNUDQo+IHRoZW4gdGltZSBvdXQgd2FpdGluZyBmb3IgdGhlIEdPLU5FRyBDb25maXJtLCBzdGF0
dXM9LTENCj4gDQo+IEkgc2VsZWN0IGNoMTEgYXMgdGhlIFAyUCBvcGVyYXRpbmcgY2hhbm5lbCAo
c2FtZSBhcyBTVEEsIFNDQyksIHdoaWxlDQo+IHRoZSBwZWVyJ3Mgb3BlcmF0aW5nIHByZWZlcmVu
Y2UgaXMgNUdIeiBjaDE0OS4gSXQgbG9va3MgbGlrZSBhZnRlciB3ZSBUWA0KPiB0aGUgUmVzcG9u
c2UsIHRoZSByYWRpbyBkb2Vzbid0IHN0YXkgb24gY2gxMSB0byBsaXN0ZW4gZm9yIHRoZSBDb25m
aXJtLA0KPiBzbyB0aGUgZnJhbWUgaXMgbWlzc2VkIC0tIHByZXN1bWFibHkgYmVjYXVzZSB0aGUg
c2luZ2xlIHJhZGlvIGlzIHNlcnZpbmcNCj4gdGhlIFNUQSBjb25uZWN0aW9uLg0KDQpTbywgcGVl
ciBkb2Vzbid0IHN0YXkgY2gxMSB0byBjb21wbGV0ZSBoZSBuZWdvdGlhdGlvbiwgcmlnaHQ/DQoN
CldoYXQgaXMgdGhlIHBlZXIgZGV2aWNlIHlvdSBhcmUgdXNpbmc/IENhbiB5b3Ugc2V0dXAgYW5v
dGhlciBSVEw4ODUyQkU/DQpJIHN1Z2dlc3QgcnVubmluZyBzaW1wbGUgc2NlbmFyaW8gZmlyc3Qg
dG8gZGlnIGNhdXNlLg0KDQoxLiB0d28gcGVlcnMgbWFrZSBQMlAgZ3JvdXAgd2l0aG91dCBhbnkg
U1RBIGNvbm5lY3Rpb24NCjIuIFJUTDg4NTJCRSB3aXRoIGEgU1RBIGNvbm5lY3Rpb24sIGFuZCBw
ZWVyIHdpdGhvdXQgY29ubmVjdGlvbi4gDQoNCj4gDQo+IEFhbHNvIHRlc3RlZCB3aXRoIHRoZSBT
VEEgb24gNUdIeiAoY2gxNDkpOyB0aGUgcmVzdWx0IGlzIHRoZSBzYW1lDQo+IEdPLU5FRyBDb25m
aXJtIHRpbWVvdXQuDQo+IA0KPiBJcyB0aGlzIHRoZSBjaGFubmVsLWNvbnRleHQgaXNzdWUgdGhh
dCBQMlAtZGV2aWNlIGlmdHlwZSB3aWxsIGFkZHJlc3M/DQo+IEFuZCB3aXRoIHRoZSBjdXJyZW50
IGRyaXZlciwgaXMgdGhlcmUgYW55IHdheSB0byBrZWVwIHRoZSBQMlAgbGlzdGVuDQo+IGNvbnRl
eHQgb24gdGhlIG9wZXJhdGluZyBjaGFubmVsIGR1cmluZyBHTyBuZWdvdGlhdGlvbiB3aGlsZSBT
VEEgaXMgdXA/DQoNCkJlZm9yZSBQMlAgbmVnb3RpYXRpb24gY29tcGxldGlvbiwgdGhlcmUgaXMg
b25seSBvbmUgY2hhbm5lbCBjb250ZXh0Lg0KVGhlIHNlY29uZCBpbnRlcmZhY2UgKEdDIG9yIEdP
KSBpcyBjcmVhdGVkIHdoZW4gdGhlIFAyUCByb2xlIGlzIGRlY2lkZWQNCmJ5IFAyUCBuZWdvdGlh
dGlvbi4gDQoNCllvdSBuZWVkIHRvIGNoZWNrIHN1cHBsaWNhbnQgbG9nIGFib3V0IGNoYW5uZWxz
IG9uIGJvdGggcGVlcnMuIEkgdGhpbmsNCnJlbWFpbi1vbi1jaGFubmVsIGlzIHRoZSBtZXRob2Qg
c3VwcGxpY2FudCBzd2l0Y2ggY2hhbm5lbCB0byBzZW5kDQpuZWdvdGlhdGlvbiBmcmFtZXMgYW5k
IHRvIHN0YXkgb24gbGlzdGVuIGNoYW5uZWwuIA0KDQo+IA0KPiAoRldJVywgcGFzc2luZyBhbiBl
eHBsaWNpdCBmcmVxPSB0byBwMnBfY29ubmVjdCBpcyByZWplY3RlZCB3aXRoIEZBSUwsDQo+IHdo
ZXRoZXIgb3Igbm90IGl0IG1hdGNoZXMgdGhlIFNUQSBjaGFubmVsLikNCg0KTm90IHN1cmUgd2h5
LiBJbiBvdXIgc2lkZSwgaXQgc2VlbXMgd29yay4NCg0KDQpJJ2Qgc2hhcmUgYSBwYWlyIG9mIHdw
YV9zdXBwbGljYW50IC5jb25mIGFuZCB3cGFfY2xpIGNvbW1hbmRzIHdlIGFyZSB0ZXN0aW5nDQpm
b3IgcmVmZXJlbmNlLg0KDQpQZWVyIDE6DQpjdHJsX2ludGVyZmFjZT0vdmFyL3J1bi93cGFfc3Vw
cGxpY2FudA0KIA0KbmV0d29yaz17DQogICAgICAgIHNzaWQ9ImFwX3giDQogICAgICAgIGtleV9t
Z210PU5PTkUNCiANCn0NCiANCnVwZGF0ZV9jb25maWc9MQ0KZGV2aWNlX25hbWU9bXlfcDJwDQpt
YW51ZmFjdHVyZXI9UmVhbHRlaw0KbW9kZWxfbmFtZT1SVFdfU1RBDQptb2RlbF9udW1iZXI9V0xB
Tl9DVQ0Kc2VyaWFsX251bWJlcj0xMjM0NQ0KZGV2aWNlX3R5cGU9MS0wMDUwRjIwNC0xDQpvc192
ZXJzaW9uPTAxMDIwMzAwDQpjb25maWdfbWV0aG9kcz12aXJ0dWFsX2Rpc3BsYXkgdmlydHVhbF9w
dXNoX2J1dHRvbiBrZXlwYWQNCnAycF9saXN0ZW5fcmVnX2NsYXNzPTgxDQpwMnBfbGlzdGVuX2No
YW5uZWw9MQ0KcDJwX29wZXJfcmVnX2NsYXNzPTgxDQpwMnBfb3Blcl9jaGFubmVsPTENCnAycF9u
b19ncm91cF9pZmFjZT0xDQoNCg0Kd3BhX3N1cHBsaWNhbnQgLWkgd2xhbjAgLWMgcDJwLmNvbmYN
CndwYV9jbGkNCj4gcDJwX2ZpbmQNCj4gcDJwX2Nvbm5lY3QgJFNVVF9NQUNfQUREUiBwYmMgKGZy
ZXE9eHh4eCBnb19pbnRlbnQ9MTUpDQoNCg0KUGVlciAyOg0KY3RybF9pbnRlcmZhY2U9L3Zhci9y
dW4vd3BhX3N1cHBsaWNhbnQNCnVwZGF0ZV9jb25maWc9MQ0KZGV2aWNlX25hbWU9bXlfcDJwDQpt
YW51ZmFjdHVyZXI9UmVhbHRlaw0KbW9kZWxfbmFtZT1SVFdfU1RBDQptb2RlbF9udW1iZXI9V0xB
Tl9DVQ0Kc2VyaWFsX251bWJlcj0xMjM0NQ0KZGV2aWNlX3R5cGU9MS0wMDUwRjIwNC0xDQpvc192
ZXJzaW9uPTAxMDIwMzAwDQpjb25maWdfbWV0aG9kcz12aXJ0dWFsX2Rpc3BsYXkgdmlydHVhbF9w
dXNoX2J1dHRvbiBrZXlwYWQNCnAycF9saXN0ZW5fcmVnX2NsYXNzPTgxDQpwMnBfbGlzdGVuX2No
YW5uZWw9MQ0KcDJwX29wZXJfcmVnX2NsYXNzPTgxDQpwMnBfb3Blcl9jaGFubmVsPTENCnAycF9u
b19ncm91cF9pZmFjZT0xDQoNCndwYV9zdXBwbGljYW50IC1pIHdsYW4wIC1jIHAycC5jb25mDQp3
cGFfY2xpDQo+IHAycF9maW5kDQo+IHAycF9jb25uZWN0ICREVVRfTUFDX0FERFIgcGJjIChmcmVx
PXh4eHggZ29faW50ZW50PTEpDQoNClJlZ2FyZHMNClBpbmctS2UNCg0KDQo=

