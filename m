Return-Path: <linux-wireless+bounces-33368-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JXxAtX9uWnZQAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33368-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 02:20:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5082B4EAE
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 02:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55D8A30C8174
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 01:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1F023AB88;
	Wed, 18 Mar 2026 01:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="fMd4uvuI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB61238C1A
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773796745; cv=none; b=W1HDLxzohpJuxKPnvYPzIrmG4Z6Yv4vxJAEVJIdlFMFA0zIiF3GCngBxBOLgM9evR6o4CqJYvIi1bmQJ0ccsaMj53r1UR9X8y6/z0LbCCuy4cSEf/JqvCLp7OW+pCHoh6s2W1v4sPCLE3tFtswLRisdFgHRpb8tewpAlCnfzp3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773796745; c=relaxed/simple;
	bh=aabhniP1PzR4hdZy8+1EYVqwIH8mlU+UXY1oSmm665E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qfViw2cPohUtq+5k2zDRA7ov62Y9drnvGQCqCPCnit6VjBhcAXY3HtJGag+TiX0kC3b9mDVoM6mzb4E3RQW7cR1DMoQsU9n5Oa61gB3WETKf05Lzjqa6cLzLPRrq/NpOnUoPvuP8Nud/d7xuHJXnQldcyhDIE8nY8fK05MyxymY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=fMd4uvuI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62I1IwOX2810374, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773796739; bh=aabhniP1PzR4hdZy8+1EYVqwIH8mlU+UXY1oSmm665E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fMd4uvuI52unzK317xCcheBwB6t9HXnHq7u9m539X7oY8HLhoxHtx9KZqmfk5zWMD
	 bQrisHjP/qpB7VaUjcRA4DDSu7erBeRm3Ny++ys4JsbBBJbq/SCXl3OkWCBK4BRAvh
	 qQ3Dkqzt4mMu3Z7zOgCa5kP39opc1YjDKocBGWV1aZSyHc5mg+bYzyMJYzhd78iHhV
	 DaXGoF93DOhh7NmPb4am329S6x1oTiTZ5j3PEs6XpEfyQgm4T3JQFA1dur2fR5T+OR
	 jP1LAP4l3pKsFA4i7ZFvRWIusrXzRc5J6Zt6EZ6LpS8Vbi6DA/uz/H2PUK4+DXc/uE
	 6cz8fDk8SuMTQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62I1IwOX2810374
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 09:18:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 18 Mar 2026 09:18:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Wed, 18 Mar 2026 09:18:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jason Kakandris <ikakandris@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: RTL8852BE fails to power on: "xtal si not ready" on ASUS TUF
 GAMING B650-PLUS WIFI
Thread-Topic: RTL8852BE fails to power on: "xtal si not ready" on ASUS TUF
 GAMING B650-PLUS WIFI
Thread-Index: AQHctU7OgydTptlp0UKTntkNNhXUfLWyCTcggAAIM4CAAWxCsA==
Date: Wed, 18 Mar 2026 01:18:59 +0000
Message-ID: <c3b224cabe564969ba4258b2b89efdfb@realtek.com>
References: <CAFR=mzkTDNVwypi_PvUw2PX0MM_ck0H61+PUAdJoo6h3yZfggw@mail.gmail.com>
 <b8cb73b5c8bf42b38ad275220b1d559e@realtek.com>
 <CAFR=mzmENf-SqdFYzfdjb3KtA153rGT1VDVXUrXTvK+Dd6teSg@mail.gmail.com>
In-Reply-To: <CAFR=mzmENf-SqdFYzfdjb3KtA153rGT1VDVXUrXTvK+Dd6teSg@mail.gmail.com>
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
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-33368-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Queue-Id: 7A5082B4EAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ly8gbWFpbGluZyBsaXN0IGRvZXNuJ3Qgd2FudCB0b3AtcG9zdGluZy4gSSBtb3ZlIHRoZSBwb3N0
IHRvIGJvdHRvbS4gDQoNCkphc29uIEtha2FuZHJpcyA8aWtha2FuZHJpc0BnbWFpbC5jb20+IHdy
b3RlOg0KPiDOo8+EzrnPgiDOpM+Bzq8gMTcgzpzOsc+BIDIwMjYgz4PPhM65z4IgNTowM+KAr8+A
Ls68Liwgzr8vzrcgUGluZy1LZSBTaGloDQo+IDxwa3NoaWhAcmVhbHRlay5jb20+IM6tzrPPgc6x
z4jOtToNCj4gPg0KPiA+IEphc29uIEtha2FuZHJpcyA8aWtha2FuZHJpc0BnbWFpbC5jb20+IHdy
b3RlOg0KPiA+ID4gU3lzdGVtIEluZm8NCj4gPiA+DQo+ID4gPiBEaXN0cm86IExpbnV4IE1pbnQg
MjIuMyBaZW5hIChVYnVudHUgMjQuMDQgYmFzZSkNCj4gPiA+IEtlcm5lbHMgdGVzdGVkOiA2LjE0
LjAtMzctZ2VuZXJpYywgNi4xNy4wLTE0LWdlbmVyaWMgKHNhbWUgZmFpbHVyZSBvbiBib3RoKQ0K
PiA+ID4gTW90aGVyYm9hcmQ6IEFTVVMgVFVGIEdBTUlORyBCNjUwLVBMVVMgV0lGSSAoUmV2IDEu
eHgpDQo+ID4gPiBCSU9TOiB2MzgyNyAoRmViIDIwMjYpDQo+ID4gPiBDUFU6IEFNRCBSeXplbiA3
IDc3MDBYDQo+ID4gPiBEcml2ZXI6IHJ0dzg5IHY3LjAgKGdpdCBjb21taXQgZDJmMTc1ZQ0KPiA+
ID4NCj4gaHR0cHM6Ly9naXRodWIuY29tL21vcnJvd25yL3J0dzg5L2NvbW1pdC9kMmYxNzVlYWZh
MGE0ZWY5Y2M2NWU3MDczYTc3ZTYwMjM4Yw0KPiA+ID4gYWU2MTQpDQo+ID4gPiBXaUZpIHdvcmtz
IGluIFdpbmRvd3M6IFllcw0KPiA+ID4NCj4gPiA+DQo+ID4gPiBQcm9ibGVtDQo+ID4gPiBUaGUg
UlRMODg1MkJFIFdpRmkgY2FyZCBmYWlscyB0byBpbml0aWFsaXplIHdpdGggeHRhbCBzaSBub3Qg
cmVhZHkgZXJyb3IuDQo+IE5vDQo+ID4gPiB3aXJlbGVzcyBpbnRlcmZhY2UgaXMgY3JlYXRlZC4N
Cj4gPiA+DQo+ID4gPg0KPiA+ID4gZG1lc2cgb3V0cHV0DQo+ID4gPg0KPiA+ID4gcnR3ODlfODg1
MmJlX2dpdCAwMDAwOjA4OjAwLjA6IGxvYWRlZCBmaXJtd2FyZSBydHc4OS9ydHc4ODUyYl9mdy0x
LmJpbg0KPiA+ID4gcnR3ODlfODg1MmJlX2dpdCAwMDAwOjA4OjAwLjA6IGVuYWJsaW5nIGRldmlj
ZSAoMDAwMCAtPiAwMDAzKQ0KPiA+DQo+ID4gSXQgbG9va3MgbGlrZSB5b3UgZGlkbid0IGVuY291
bnRlciBEM0NvbGQgcHJvYmxlbSwgYnV0IEkgdGhpbmsgeW91IGNhbg0KPiA+IGdpdmUgaXQgYSB0
cnkgWzFdLg0KPiA+DQo+ID4gWzFdIGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1
Zy5jZ2k/aWQ9MjIxMjEzDQo+ID4NCj4gPiA+IHJ0dzg5Xzg4NTJiZV9naXQgMDAwMDowODowMC4w
OiB4dGFsIHNpIG5vdCByZWFkeShSKTogb2Zmc2V0PTQxDQo+ID4gPiBydHc4OV84ODUyYmVfZ2l0
IDAwMDA6MDg6MDAuMDogeHRhbCBzaSBub3QgcmVhZHkoVyk6IG9mZnNldD05MCB2YWw9MTAgbWFz
az0xMA0KPiA+ID4gcnR3ODlfODg1MmJlX2dpdCAwMDAwOjA4OjAwLjA6IGZhaWxlZCB0byBwb3dl
ciBvbg0KPiA+ID4gcnR3ODlfODg1MmJlX2dpdCAwMDAwOjA4OjAwLjA6IGZhaWxlZCB0byBzZXR1
cCBjaGlwIGluZm9ybWF0aW9uDQo+ID4gPiBydHc4OV84ODUyYmVfZ2l0IDAwMDA6MDg6MDAuMDog
cHJvYmUgd2l0aCBkcml2ZXIgcnR3ODlfODg1MmJlX2dpdCBmYWlsZWQNCj4gd2l0aA0KPiA+ID4g
ZXJyb3IgLTExMA0KPiA+DQo+ID4gVGhlc2UgbWVzc2FnZXMgYXBwZWFyIHdoZW4gZmlyc3QgYm9v
dGluZyBvciBhZnRlciBzeXN0ZW0gcmVzdW1lPw0KPiA+IFJlY2VudGx5IHdlIHVwZGF0ZSBzb21l
dGhpbmcgcmVsYXRlZCB0byBzdXNwZW5kL3Jlc3VtZSBwcm9ibGVtLg0KPiA+IFBsZWFzZSB1c2Ug
dGhlIGxhdGVzdCBkcml2ZXIgKGtlcm5lbCA3LjAtcmM0KSB3aXRoIHRoZSBsYXRlc3QNCj4gPiBm
aXJtd2FyZSAodjAuMjkuMjkuMTUpLg0KPiA+DQo+ID4gPg0KPiA+ID4NCj4gPiA+IGxzcGNpDQo+
ID4gPg0KPiA+ID4gMDg6MDAuMCBOZXR3b3JrIGNvbnRyb2xsZXIgWzAyODBdOiBSZWFsdGVrIFNl
bWljb25kdWN0b3IgQ28uLCBMdGQuIFJUTDg4NTJCRQ0KPiA+ID4gUENJZSA4MDIuMTFheCBXaXJl
bGVzcyBOZXR3b3JrIENvbnRyb2xsZXIgWzEwZWM6Yjg1Ml0NCj4gPiA+IFN1YnN5c3RlbTogQXp1
cmVXYXZlIFJUTDg4NTJCRSBQQ0llIDgwMi4xMWF4IFdpcmVsZXNzIE5ldHdvcmsgQ29udHJvbGxl
cg0KPiA+ID4gWzFhM2I6NTQ3MV0NCj4gPiA+DQo+ID4gPiBXaGF0IEkndmUgdHJpZWQNCj4gPiA+
DQo+ID4gPiBLZXJuZWwgcGFyYW1ldGVyIHBjaWVfYXNwbT1vZmYNCj4gPiA+IE1vZHVsZSBwYXJh
bWV0ZXJzOiBkaXNhYmxlX2Nsa3JlcT1ZIGRpc2FibGVfYXNwbV9sMT1ZIGRpc2FibGVfYXNwbV9s
MXNzPVkNCj4gPiA+IGRpc2FibGVfcHNfbW9kZT15DQo+ID4NCj4gPiBBcyB5b3UgdHJ5IHRoaXMs
IHBsZWFzZSBlbnN1cmUgdGhhdCBhZGQgYSBjb25maWd1cmF0aW9uIGZpbGUgdG8gL2V0Yy9tb2R1
bGUuZC8sDQo+ID4gYW5kIGNvbGQgcmVib290Lg0KPiA+DQo+ID4gPiBVcGRhdGVkIEJJT1MgZnJv
bSB2MzA1NyB0byB2MzgyNw0KPiA+ID4gVXBkYXRlZCBmaXJtd2FyZSBmaWxlcyB2aWEgbWFrZSBp
bnN0YWxsX2Z3DQo+ID4gPiBUZXN0ZWQgb24ga2VybmVscyA2LjE0IGFuZCA2LjE3IOKAlCBzYW1l
IGZhaWx1cmUgb24gYm90aA0KPiA+ID4gSW4ta2VybmVsIGRyaXZlciBhbmQgbW9ycm93bnIgb3V0
LW9mLXRyZWUgZHJpdmVyIOKAlCBzYW1lIGZhaWx1cmUNCj4gPiA+IFdpRmkgd29ya3MgZmluZSBp
biBXaW5kb3dzIG9uIHRoZSBzYW1lIGhhcmR3YXJlDQo+ID4NCj4gLSBUaGUgZXJyb3IgYXBwZWFy
cyBvbiBmaXJzdCBib290LCBub3QgYWZ0ZXIgcmVzdW1lLiBJdCBoYXMgbmV2ZXINCj4gd29ya2Vk
IG9uIExpbnV4Lg0KPiAtIEkgaGF2ZSBzZXQgdXAgYSB1ZGV2IHJ1bGUgdG8gZGlzYWJsZSBEM0Nv
bGQgZm9yIHRoZSBkZXZpY2UgYW5kIHdpbGwNCj4gdGVzdCB3aXRoIGEgY29sZCBib290LiBJIHdp
bGwgYWxzbyB0cnkgdGhlIGxhdGVzdCBmaXJtd2FyZQ0KPiAodjAuMjkuMjkuMTUpIGFuZCByZXBv
cnQgYmFjay4NCj4gV2hlcmUgY2FuIEkgb2J0YWluIGZpcm13YXJlIHYwLjI5LjI5LjE1PyBJcyBp
dCBydHc4ODUyYl9mdy0yLmJpbiBmcm9tDQo+IGxpbnV4LWZpcm13YXJlLmdpdD8NCj4NCg0KWWVz
LiANCg0KSSByZXZpZXcgdGhlICJ4dGFsIHNpIG5vdCByZWFkeSIgbWVzc2FnZXMgYWdhaW4uIEl0
IGxvb2tzIGxpa2UgaXQgZmFpbHMgdG8NCnBvd2VyLW9uIGJlZm9yZSBkb3dubG9hZGluZyBmaXJt
d2FyZSwgc28gZmlybXdhcmUgbWlnaHQgbm90IHRoZSBjYXVzZQ0KeW91IGFyZSBlbmNvdW50ZXJp
bmcuIA0KDQpQbGVhc2UgdHJ5IHRvIHJlbW92ZSBtb2R1bGUgYW5kIHJlaW5zdGFsbCBtb2R1bGUg
YWZ0ZXIgYm9vdGluZyB0byBzZWUgaG93DQppdCB3aWxsIGJlLiBPcGVuIGEgdGVybWluYWwsIG1h
bnVhbGx5IGRvIGJlbG93IGNvbW1hbmRzICh0cnkgbW9yZSB0aGFuDQpvbmUgdGltZXMpLCBhbmQg
c2hhcmUga2VybmVsIGxvZyB0byB1cw0KDQogIHJtbW9kIHJ0dzg5Xzg4NTJiZQ0KICBtb2Rwcm9i
ZSBydHc4OV84ODUyYmUNCg0KUGluZy1LZQ0KDQo=

