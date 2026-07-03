Return-Path: <linux-wireless+bounces-38534-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JdAUCaAFR2oLSQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38534-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 02:43:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D21CB6FDA34
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 02:43:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=PfENsDhY;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38534-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38534-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39063300B616
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 00:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5BF1A6807;
	Fri,  3 Jul 2026 00:43:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA26C8EB
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 00:43:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783039388; cv=none; b=pxJi14oex8ujTpOepwtlFIczysdhH+zEY1J/q4F1BSWW5SeA0iljD2S70WjJS4o3pMwtgRLXYtRa/oePOUqDtS2Av9eFjWYCME5buxHlgW9KfMs9VQYeDWjVbxI5LCV9YXPSEyXkiMPV2mvZTMESY1Yx3P4+AOJvui7NmNcfdnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783039388; c=relaxed/simple;
	bh=EVUm2tadxb2ODRuFIicfEW8AScuPX/1Ao+/2uhv9f4M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gPy0Kbe+cdGofEPm6ZEC7gLpXpjXrUSJc1S12k0oxccX3TA8nEtUOPLYrSjUNAEC/mYhAcE1gHag+tQCOTFbiH8YTcFH57pP0/EaFpjr/MZrwMzvpnbeLtPqvsbJMdPBohzeZEtJCh1w2d7acDEDlQGNT5M/bfwCcjUYFuAgu3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PfENsDhY; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6630h1A812313415, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783039381; bh=EVUm2tadxb2ODRuFIicfEW8AScuPX/1Ao+/2uhv9f4M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=PfENsDhYXjMBgY1Xx3xmRah5FJNCb43hqftlpmJo5T9r0kiqdVuGNtlVLfMCcXDh2
	 MLvr8T4icZF1Ph9nbvRuNfoAvuNCGv2DoMy3vH/oK7ed6Qp9JHFpOD/AFGsh2k68ts
	 e++tXhVqfBPqRld113kB3cufWN33J+135diVaEiQ6gS2unzkkilXYN1vK1ZWCiYUtd
	 KhEfe2t1N9zWFg0s9+PLSlwsxbRpCjtgFqI0pKMlW3dXqW9EMzk20LrC5v5aoMpnQJ
	 7qZwJPwQ6dTeYsiFESfeg8uQTaB4p+cwNYoPaUPYVE9E6A1jeU7q+na2Vp25uo1qsB
	 HbGJRsOd0hpEg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6630h1A812313415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 08:43:01 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 08:43:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 08:43:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Fri, 3 Jul 2026 08:43:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Doug Brewer <brewer.doug@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: rtw89: RTL8852BE P2P-device iftype and STA+P2P interface
 combination
Thread-Topic: rtw89: RTL8852BE P2P-device iftype and STA+P2P interface
 combination
Thread-Index: AQHdBsiUWEi4pimYHEaDlfxBkcAE67ZUyXVQ//+oOQCAAdAv0IABc4eAgAB8hQCAAsfFAA==
Date: Fri, 3 Jul 2026 00:43:01 +0000
Message-ID: <263dd9579f594178bccaf866e7c5db90@realtek.com>
References: <CAG0V13TRHzXtoMY=XZMOd=WjzS58Cu=aePFCz8mY6UoGYm5dXw@mail.gmail.com>
 <54e7877f76944bd29e57d6eafe5e3811@realtek.com>
 <CAG0V13Qfp+eVCR6NjQJydN-fL8tus_EyJCWGQqQxTkKA9ZXBFQ@mail.gmail.com>
 <02d3be993ed84cf983cf995e53c86f1f@realtek.com>
 <CAG0V13T_Ujautadyaqxjy_8zqWFbz1JiRp9bpWO-T7Gy9O+mnA@mail.gmail.com>
 <CAG0V13Si0iPLm-2KxgcEs_i+Jm4W4pM7O2KQS49dPM8HW7gK5w@mail.gmail.com>
In-Reply-To: <CAG0V13Si0iPLm-2KxgcEs_i+Jm4W4pM7O2KQS49dPM8HW7gK5w@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
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
	TAGGED_FROM(0.00)[bounces-38534-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:dkim,realtek.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D21CB6FDA34

RG91ZyBCcmV3ZXIgPGJyZXdlci5kb3VnQGdtYWlsLmNvbT4gd3JvdGU6DQo+IE9uIFdlZCwgSnVs
IDEsIDIwMjYgYXQgMjo0MOKAr1BNIERvdWcgQnJld2VyIHdyb3RlOg0KPiA+DQo+ID4gT24gVHVl
LCBKdW4gMzAsIDIwMjYgYXQgODo1MeKAr0FNIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiA+DQo+
ID4gPiBEb3VnIEJyZXdlciAgd3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgSnVuIDI5LCAyMDI2IGF0
IDEwOjEw4oCvQU0gUGluZy1LZSBTaGloICB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IERv
dWcgQnJld2VyIHdyb3RlOg0KPiA+ID4gPiA+ID4gSGksDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gSSdtIGV4cGVyaW1lbnRpbmcgd2l0aCBXaS1GaSBEaXNwbGF5IChNaXJhY2FzdCBzaW5rKSBj
b25jdXJyZW50IHdpdGggYW4NCj4gPiA+ID4gPiA+IFNUQSBjb25uZWN0aW9uIG9uIGFuIFJUTDg4
NTJCRSAoUENJZSkgdXNpbmcgdGhlIG1haW5saW5lIHJ0dzg5IGRyaXZlcg0KPiA+ID4gPiA+ID4g
KGtlcm5lbCA2LjE4LjM3KS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBpdyBwaHkgcmVwb3J0
czoNCj4gPiA+ID4gPiA+IFN1cHBvcnRlZCBpbnRlcmZhY2UgbW9kZXM6DQo+ID4gPiA+ID4gPiAg
ICAqIG1hbmFnZWQsIEFQLCBQMlAtY2xpZW50LCBQMlAtR08NCj4gPiA+ID4gPiA+ICAgIChubyBQ
MlAtZGV2aWNlKQ0KPiA+ID4gPiA+ID4gaW50ZXJmYWNlIGNvbWJpbmF0aW9ucyBhcmUgbm90IHN1
cHBvcnRlZA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEluIHByYWN0aWNlIHRoaXMgYmxvY2tz
IHRoZSBzdGFuZGFyZCBQMlAgZmxvdzogdGhlcmUgaXMgbm8gUDJQLWRldmljZQ0KPiA+ID4gPiA+
ID4gaWZ0eXBlIGZvciBhIGRlZGljYXRlZCBkaXNjb3ZlcnkgY29udGV4dCwgYW5kIG5vIGFkdmVy
dGlzZWQgaW50ZXJmYWNlDQo+ID4gPiA+ID4gPiBjb21iaW5hdGlvbiBmb3IgbWFuYWdlZCArIFAy
UC1jbGllbnQgY29leGlzdGVuY2UuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gTXkgcXVlc3Rp
b25zOg0KPiA+ID4gPiA+ID4gMS4gaXMgUDJQLWRldmljZSBpZnR5cGUgc3VwcG9ydCBwbGFubmVk
IGZvciBydHc4OSBvbiBSVEw4ODV4PyBJcyB0aGVyZSBhDQo+ID4gPiA+ID4gPiAgICAga25vd24g
dGVjaG5pY2FsIGJsb2NrZXIsIG9yIGlzIGl0IHNpbXBseSBub3QgeWV0IGltcGxlbWVudGVkPw0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gV2UgYXJlIHBsYW5uaW5nIHRvIGFkZCBQMlAtZGV2aWNlIGlm
dHlwZS4gSXQgbmVlZHMgdG8gY29uc2lkZXIgdGhlIGNhc2VzIG9mDQo+ID4gPiA+ID4gY2hhbm5l
bCBjb250ZXh0LCBjb25kaXRpb25zIG9mIHBvd2VyIHNhdmUsIGFuZCBldGMuIEl0IHdpbGwgdGFr
ZSBzb21lIHRpbWUuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJIHRoaW5rIGl0IHdvdWxkIGJlIG9r
YXkgdGhhdCB5b3UgdXNlIFNUQSBpbnRlcmZhY2UgdG8gZG8gUDJQIG5lZ290aWF0aW9uLA0KPiA+
ID4gPiA+IGFuZCB0aGVuIGNyZWF0ZSBQMlAtY2xpZW50IG9yIFAyUC1HTyBpZnR5cGUgdGhlbi4N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gMi4gd291bGQgYWR2ZXJ0aXNpbmcgYSBtYW5hZ2VkICsg
UDJQLWNsaWVudCBpbnRlcmZhY2UgY29tYmluYXRpb24NCj4gPiA+ID4gPiA+ICAgICAoc2luZ2xl
IGNoYW5uZWwpIGJlIGZlYXNpYmxlIG9uIHRoZSBjdXJyZW50IHJ0dzg5Pw0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gVGhpcyBpcyBhIFNDQyB3aGljaCBpcyBzdXBwb3J0ZWQuDQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+IDMuIGlzIE1DQyAoI2NoYW5uZWxzID4gMSkgb24gdGhlIHJvYWRtYXAsIG9yIGNv
bnNpZGVyZWQgb3V0IG9mIHNjb3BlPw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQ3VycmVudCBzdXBw
b3J0IE1DQyBhcyB3ZWxsLiBIb3dldmVyLCB3ZSBhcmUgY29va2luZyBuZXcgZmlybXdhcmUgdG8g
c3VwcG9ydA0KPiA+ID4gPiA+IGh3X3NjYW4gd2l0aCB0d28gb3BlcmF0aW9uIGNoYW5uZWxzIC0t
IHdoaWNoIGRvZXNuJ3QgbWF0dGVyIGlmIHlvdSBkb24ndCBuZWVkDQo+ID4gPiA+ID4gdG8gZG8g
c2NhbiB3aGVuIE1DQyBpcyBvcGVyYXRpbmcuDQo+ID4gPiA+DQo+ID4gPiA+IFRoYW5rcyBmb3Ig
dGhlIHN1Z2dlc3Rpb24uIEkgdHJpZWQgdXNpbmcgdGhlIFNUQSBpbnRlcmZhY2UgZm9yIFAyUA0K
PiA+ID4gPiBuZWdvdGlhdGlvbiwgYW5kIHdhbnRlZCB0byBzaGFyZSB3aGF0IEkgZm91bmQuDQo+
ID4gPiA+DQo+ID4gPiA+IFdpdGggdGhlIFNUQSBjb25uZWN0ZWQgKDIuNEdIeiBjaDExKSBhbmQg
YW4gYWN0aXZlIHAycF9jb25uZWN0LCBhDQo+ID4gPiA+IHdwYV9zdXBwbGljYW50IC1kZCB0cmFj
ZSBzaG93cyBHTyBuZWdvdGlhdGlvbiBnZXR0aW5nIGZhaXJseSBmYXI6DQo+ID4gPiA+DQo+ID4g
PiA+IFBlZXIncyBHTy1ORUcgUmVxdWVzdCBpcyByZWNlaXZlZA0KPiA+ID4gPiBzZW5kIHRoZSBH
Ty1ORUcgUmVzcG9uc2Ugb24gY2gxMSwgcGVlciBBQ0tzIGl0IChUWCBhY2s9MSkNCj4gPiA+ID4g
U3RhdGUgZ29lcyBHT19ORUcgLT4gQ09OTkVDVA0KPiA+ID4gPiB0aGVuIHRpbWUgb3V0IHdhaXRp
bmcgZm9yIHRoZSBHTy1ORUcgQ29uZmlybSwgc3RhdHVzPS0xDQo+ID4gPiA+DQo+ID4gPiA+IEkg
c2VsZWN0IGNoMTEgYXMgdGhlIFAyUCBvcGVyYXRpbmcgY2hhbm5lbCAoc2FtZSBhcyBTVEEsIFND
QyksIHdoaWxlDQo+ID4gPiA+IHRoZSBwZWVyJ3Mgb3BlcmF0aW5nIHByZWZlcmVuY2UgaXMgNUdI
eiBjaDE0OS4gSXQgbG9va3MgbGlrZSBhZnRlciB3ZSBUWA0KPiA+ID4gPiB0aGUgUmVzcG9uc2Us
IHRoZSByYWRpbyBkb2Vzbid0IHN0YXkgb24gY2gxMSB0byBsaXN0ZW4gZm9yIHRoZSBDb25maXJt
LA0KPiA+ID4gPiBzbyB0aGUgZnJhbWUgaXMgbWlzc2VkIC0tIHByZXN1bWFibHkgYmVjYXVzZSB0
aGUgc2luZ2xlIHJhZGlvIGlzIHNlcnZpbmcNCj4gPiA+ID4gdGhlIFNUQSBjb25uZWN0aW9uLg0K
PiA+ID4NCj4gPiA+IFNvLCBwZWVyIGRvZXNuJ3Qgc3RheSBjaDExIHRvIGNvbXBsZXRlIGhlIG5l
Z290aWF0aW9uLCByaWdodD8NCj4gPiA+DQo+ID4gPiBXaGF0IGlzIHRoZSBwZWVyIGRldmljZSB5
b3UgYXJlIHVzaW5nPyBDYW4geW91IHNldHVwIGFub3RoZXIgUlRMODg1MkJFPw0KPiA+ID4gSSBz
dWdnZXN0IHJ1bm5pbmcgc2ltcGxlIHNjZW5hcmlvIGZpcnN0IHRvIGRpZyBjYXVzZS4NCj4gPiA+
DQo+ID4gPiAxLiB0d28gcGVlcnMgbWFrZSBQMlAgZ3JvdXAgd2l0aG91dCBhbnkgU1RBIGNvbm5l
Y3Rpb24NCj4gPiA+IDIuIFJUTDg4NTJCRSB3aXRoIGEgU1RBIGNvbm5lY3Rpb24sIGFuZCBwZWVy
IHdpdGhvdXQgY29ubmVjdGlvbi4NCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEFhbHNvIHRlc3Rl
ZCB3aXRoIHRoZSBTVEEgb24gNUdIeiAoY2gxNDkpOyB0aGUgcmVzdWx0IGlzIHRoZSBzYW1lDQo+
ID4gPiA+IEdPLU5FRyBDb25maXJtIHRpbWVvdXQuDQo+ID4gPiA+DQo+ID4gPiA+IElzIHRoaXMg
dGhlIGNoYW5uZWwtY29udGV4dCBpc3N1ZSB0aGF0IFAyUC1kZXZpY2UgaWZ0eXBlIHdpbGwgYWRk
cmVzcz8NCj4gPiA+ID4gQW5kIHdpdGggdGhlIGN1cnJlbnQgZHJpdmVyLCBpcyB0aGVyZSBhbnkg
d2F5IHRvIGtlZXAgdGhlIFAyUCBsaXN0ZW4NCj4gPiA+ID4gY29udGV4dCBvbiB0aGUgb3BlcmF0
aW5nIGNoYW5uZWwgZHVyaW5nIEdPIG5lZ290aWF0aW9uIHdoaWxlIFNUQSBpcyB1cD8NCj4gPiA+
DQo+ID4gPiBCZWZvcmUgUDJQIG5lZ290aWF0aW9uIGNvbXBsZXRpb24sIHRoZXJlIGlzIG9ubHkg
b25lIGNoYW5uZWwgY29udGV4dC4NCj4gPiA+IFRoZSBzZWNvbmQgaW50ZXJmYWNlIChHQyBvciBH
TykgaXMgY3JlYXRlZCB3aGVuIHRoZSBQMlAgcm9sZSBpcyBkZWNpZGVkDQo+ID4gPiBieSBQMlAg
bmVnb3RpYXRpb24uDQo+ID4gPg0KPiA+ID4gWW91IG5lZWQgdG8gY2hlY2sgc3VwcGxpY2FudCBs
b2cgYWJvdXQgY2hhbm5lbHMgb24gYm90aCBwZWVycy4gSSB0aGluaw0KPiA+ID4gcmVtYWluLW9u
LWNoYW5uZWwgaXMgdGhlIG1ldGhvZCBzdXBwbGljYW50IHN3aXRjaCBjaGFubmVsIHRvIHNlbmQN
Cj4gPiA+IG5lZ290aWF0aW9uIGZyYW1lcyBhbmQgdG8gc3RheSBvbiBsaXN0ZW4gY2hhbm5lbC4N
Cj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IChGV0lXLCBwYXNzaW5nIGFuIGV4cGxpY2l0IGZyZXE9
IHRvIHAycF9jb25uZWN0IGlzIHJlamVjdGVkIHdpdGggRkFJTCwNCj4gPiA+ID4gd2hldGhlciBv
ciBub3QgaXQgbWF0Y2hlcyB0aGUgU1RBIGNoYW5uZWwuKQ0KPiA+ID4NCj4gPiA+IE5vdCBzdXJl
IHdoeS4gSW4gb3VyIHNpZGUsIGl0IHNlZW1zIHdvcmsuDQo+ID4gPg0KPiA+ID4NCj4gPiA+IEkn
ZCBzaGFyZSBhIHBhaXIgb2Ygd3BhX3N1cHBsaWNhbnQgLmNvbmYgYW5kIHdwYV9jbGkgY29tbWFu
ZHMgd2UgYXJlIHRlc3RpbmcNCj4gPiA+IGZvciByZWZlcmVuY2UuDQo+ID4NCj4gPiBHcmVhdCBw
cm9ncmVzcyB1c2luZyB5b3VyIHRlc3QgY29uZiBhbmQgYSBzZWNvbmQgUlRMODg1MkJFLiBSZXN1
bHRzOg0KPiA+DQo+ID4gVHdvIFJUTDg4NTJCRSBwZWVycywgbm8gU1RBIOKAlCBQMlAgY29ubmVj
dHMgZmluZSAoR08vY2xpZW50LCBncm91cCBmb3JtZWQsDQo+ID4gNC13YXkgSFMgY29tcGxldGVk
KS4NCj4gPg0KPiA+IE9uZSBSVEw4ODUyQkUgd2l0aCBTVEEgb24gNUdIeiBjaDE0OSwgdGhlIG90
aGVyIFJUTDg4NTJCRSB3aXRoIG5vIFNUQSwNCj4gPiBhbHNvIHN1Y2NlZWRzLiBUaGUgR08gY29t
ZXMgdXAgb24gY2gxNTMgd2hpbGUgdGhlIFNUQSBzdGF5cyBvbiBjaDE0OSAoc28gTUNDKSwNCj4g
PiBncm91cCBmb3JtZWQsIGNsaWVudCBjb25uZWN0ZWQuIEJvdGggc2lkZXMgY29uZmlybWVkIHZp
YSBpdyBkZXYNCj4gPiAoR08gb24gY2gxNTMgKyBTVEEgb24gY2gxNDk7IHBlZXIgY2xpZW50IG9u
IGNoMTUzKS4NCj4gPg0KPiA+IFNvIFNUQSArIFAyUCBjb2V4aXN0ZW5jZSwgaW5jbHVkaW5nIE1D
Qywgd29ya3MgZmluZSBiZXR3ZWVuIHR3byA4ODUyQkUgcGVlcnMuDQo+ID4NCj4gPiBwMnBfbm9f
Z3JvdXBfaWZhY2U9MSBpbiB5b3VyIGNvbmYgbWF5IGhhdmUgY29udHJpYnV0ZWQsIFAyUCBydW5z
IG9uIHRoZSBtYWluDQo+ID4gaW50ZXJmYWNlIGluc3RlYWQgb2YgYSBzZXBhcmF0ZSBncm91cCBp
bnRlcmZhY2UuDQo+ID4NCj4gPiBUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB0aGUgdGVzdCBjb25m
IGFuZCBndWlkYW5jZS4NCj4gDQo+IE9uZSBtb3JlIHVwZGF0ZS4gVHdvIFJUTDg4NTJCRSBwZWVy
cyAoU1RBICsgUDJQKSB3b3JrIHJlbGlhYmx5LCBhcw0KPiByZXBvcnRlZC4NCj4gDQo+IEhvd2V2
ZXIsIHdpdGggYSBTYW1zdW5nIHBob25lIGFzIHRoZSBwZWVyLCBHTyBuZWdvdGlhdGlvbiBpcw0K
PiBpbmNvbnNpc3RlbnQg4oCUIHVzaW5nIHlvdXIgY29uZiAoaW5jbHVkaW5nIHAycF9ub19ncm91
cF9pZmFjZT0xKSwgdGhlIHNhbWUNCj4gc2V0dXAgc29tZXRpbWVzIGNvbXBsZXRlcyBhbmQgc29t
ZXRpbWVzIGZhaWxzIHdpdGggR08tTkVHIENvbmZpcm0gdGltZW91dA0KPiAoc3RhdHVzPS0xKS4N
Cj4gDQo+IERvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9uIGZvciB0aGlzIGNhc2Ugd2l0aCBhIHJl
YWwgcGhvbmUgcGVlcj8NCg0KSSdkIHN1Z2dlc3QgdGhlIHNpbXBsZXN0IHVzZSBjYXNlIHdoaWNo
IHlvdXIgU2Ftc3VuZyBwaG9uZSBkb2Vzbid0IGNvbm5lY3QgdG8NCmFuIEFQLCBhbmQgcmVtb3Zl
IGFsbCBTVEEgbmV0d29ya3MgZnJvbSB0aGUgcGhvbmUuIFRoYXQgbWVhbnMgdGhlIHBob25lIG9u
bHkNCmhhcyBvbmUgaW50ZXJmYWNlIHdvcmtpbmcgb24gUDJQLiANCg0KSWYgeW91IG5lZWQgdG8g
ZGlnIHRoZSBwcm9ibGVtcyByZWxhdGVkIHRvIFAyUCBjaGFubmVscywgSSBzdWdnZXN0IHlvdSBj
YW4NCnNldHVwIFJUTDg4NTJCRSBzbmlmZmVyIHRvIGNhcHR1cmUgcGFja2V0cyBvbiB0d28gY2hh
bm5lbHMgc2ltdWx0YW5lb3VzbHkuDQpPbmUgbWV0aG9kIGlzIHRvIGluc3RhbGwgdHdvIFJUTDg4
NTJCRSBpbiBhIGNvbXB1dGVyLCBhbmQgdXNlIHNpbmdsZSBvbmUNCndpcmVzaGFyayB0byBjYXB0
dXJlIHR3byBpbnRlcmZhY2VzIChzZXR1cCB0aGUgdHdvIGNoYW5uZWxzIG1hbnVhbGx5KS4NClRo
ZSBvdGhlciBpcyB0byBzZXR1cCB0d28gY29tcHV0ZXJzIHRvIGNhcHR1cmUgZWFjaCBvZiB0d28g
Y2hhbm5lbHMsDQphbmQgdGhlbiBtZXJnZSB0aGUgc25pZmZlciBmaWxlcyAobm90ZSB0aGF0IHlv
dSBtdXN0IHN5bmNocm9uaXplIHRoZQ0KaG9zdCB0aW1lIHRvIG1lcmdlIHRoZSBmaWxlcyBwcm9w
ZXJseSkuDQoNClBpbmctS2UNCg0K

