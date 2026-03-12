Return-Path: <linux-wireless+bounces-33034-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH4YKY0jsmnlIwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33034-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 03:23:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E423826C2D6
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 03:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07BA0305B47A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 02:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBDF276058;
	Thu, 12 Mar 2026 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="A5dmyMEd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF84330307;
	Thu, 12 Mar 2026 02:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282139; cv=none; b=t84LA9qzLlRtrp4ksz9YNWP9JxDRvPVpLydh40Tjf5OrH0g7wyxY4yhUIp9HczLURJtN5vAZW1EPs4gnx4fMaVlVCyDrVxQd5kfIuxadKVsd/CEGXqcYYT45WxG7sQShyHcttdRK3HH2RJZZvg2Rl8nqPsisMLzWBUAxit6c7eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282139; c=relaxed/simple;
	bh=1SWcbEIUkbRY+kW+0x3JFmGtV6cRVRJ46khMDTUAuAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dEel0AnjMvyUFp7Y5/WwtkuXx/ofGeIFrsmdSujfwCtWWQS3Hv8vNwZE3XhY1ow5+83eduo+sNJ/L6j5ix3AP8lmPDndvS3pzneHJB+3Foc/dMSbyww21vbz7vyQK9gQ4hszs5Xcu+BVmtNyPQjTXay4tp/gvoYlYvEKfK7u4GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=A5dmyMEd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62C2MEYe81641847, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773282134; bh=1SWcbEIUkbRY+kW+0x3JFmGtV6cRVRJ46khMDTUAuAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=A5dmyMEdeiiQYxs3EYeEfKlTRi3BMuSXBnVYQyUgCx0OesDuAHVNN5Gjj1z5RuDSz
	 azLnCyx/nOcvMhCEjDBxWCAvAMpJUgkEpLuR8eAPvCWkFJNKINuMts7YliqvAFMCeE
	 +wKVy3BUiOxXG/OV0P4yNgC1NfeLdjoJk0wnLdcsyxQtEC/wotceoFB6dNBM7RBqH8
	 dHn7sBmKI9EZhfM8bTjFad1AG6xXoO2EvMaEQFEMF1mGmVxO6njNT1tyt92U4D/j6z
	 gJauLyN5k/RfRu5eqSx5rZyYc1jQ2ySKAuhY/BSuLK+TarTqFqOAp/S9nk/4RQCaFf
	 o95anFv+DDl/g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62C2MEYe81641847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 10:22:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 12 Mar 2026 10:22:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Thu, 12 Mar 2026 10:22:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Christian Hewitt <christianshewitt@gmail.com>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
Thread-Topic: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
Thread-Index: AQHcqTNMihHWcqnNfk6dLicVJRRJxLWavE1Q//99hoCAAIbrQP//fzIAgAtGLdCAAgS2AIABJ37Q//+R6YAAPhAkoA==
Date: Thu, 12 Mar 2026 02:22:13 +0000
Message-ID: <bac9b823342141bb9ed561ac5ccfd71d@realtek.com>
References: <20260301042422.195491-1-christianshewitt@gmail.com>
 <c751f9505a664f6895bacecb62bc534a@realtek.com>
 <E6E752BD-5F3D-4F30-9820-CB44FA767E69@gmail.com>
 <c764f16a880a400686c8c5f639fa98c3@realtek.com>
 <903C7E52-033F-455E-89DC-B78C67C0C732@gmail.com>
 <5ad1b7d20d1745bab0638d15731e7ccd@realtek.com>
 <CC1F2CDA-830F-4351-A855-8C921B148F8D@gmail.com>
 <2ab692371ff94a3f960d41b04288a084@realtek.com>
 <B9D5D4CC-0729-4867-AD1B-18D80D78841B@gmail.com>
In-Reply-To: <B9D5D4CC-0729-4867-AD1B-18D80D78841B@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33034-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,libreelec.tv:url]
X-Rspamd-Queue-Id: E423826C2D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Q2hyaXN0aWFuIEhld2l0dCA8Y2hyaXN0aWFuc2hld2l0dEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+
IE9uIDExIE1hciAyMDI2LCBhdCA3OjA14oCvYW0sIFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0
ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IENocmlzdGlhbiBIZXdpdHQgPGNocmlzdGlhbnNoZXdp
dHRAZ21haWwuY29tPiB3cm90ZToNCj4gPj4NCj4gPj4+IE9uIDkgTWFyIDIwMjYsIGF0IDY6MzXi
gK9hbSwgUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+Pj4NCj4g
Pj4+IENocmlzdGlhbiBIZXdpdHQgPGNocmlzdGlhbnNoZXdpdHRAZ21haWwuY29tPiB3cm90ZToN
Cj4gPj4+Pg0KPiA+Pj4+PiBPbiAyIE1hciAyMDI2LCBhdCAxMDowNOKAr2FtLCBQaW5nLUtlIFNo
aWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4+Pj4+DQo+ID4+Pj4+IENocmlzdGlh
biBIZXdpdHQgPGNocmlzdGlhbnNoZXdpdHRAZ21haWwuY29tPiB3cm90ZToNCj4gPj4+Pj4+PiBP
biAyIE1hciAyMDI2LCBhdCA5OjQ34oCvYW0sIFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsu
Y29tPiB3cm90ZToNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IENocmlzdGlhbiBIZXdpdHQgPGNocmlz
dGlhbnNoZXdpdHRAZ21haWwuY29tPiB3cm90ZToNCj4gPj4+Pj4+Pj4gT24gUmFkeGEgUm9jayA1
QiB3aXRoIGEgUlRMODg1MkJFIGNvbWJvIFdpRmkvQlQgY2FyZCwgdGhlIGVmdXNlDQo+ID4+Pj4+
Pj4+IHBoeXNpY2FsIG1hcCBkdW1wIGludGVybWl0dGVudGx5IGZhaWxzIHdpdGggLUVCVVNZIGR1
cmluZyBwcm9iZS4NCj4gPj4+Pj4+Pj4gVGhlIGZhaWx1cmUgb2NjdXJzIGluIHJ0dzg5X2R1bXBf
cGh5c2ljYWxfZWZ1c2VfbWFwX2RkdigpIHdoZXJlDQo+ID4+Pj4+Pj4+IHJlYWRfcG9sbF90aW1l
b3V0X2F0b21pYygpIHRpbWVzIG91dCB3YWl0aW5nIGZvciB0aGUgQl9BWF9FRl9SRFkNCj4gPj4+
Pj4+Pj4gYml0IGFmdGVyIDEgc2Vjb25kLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gSSdtIGNoZWNr
aW5nIGludGVybmFsbHkgaG93IHdlIGhhbmRsZSB0aGlzIGNhc2UuDQo+ID4+Pg0KPiA+Pj4gU29y
cnkgZm9yIHRoZSBsYXRlLg0KPiA+Pj4NCj4gPj4+IFdlIGVuY291bnRlcmVkIFdpRmkvQlQgcmVh
ZGluZyBlZnVzZSBhdCB0aGUgc2FtZSB0aW1lIGNhdXNpbmcgc2ltaWxhcg0KPiA+Pj4gcHJvYmxl
bSBhcyB5b3Vycy4gVGhlIHdvcmthcm91bmQgaXMgbGlrZSB5b3Vycywgd2hpY2ggYWRkcyB0aW1l
b3V0DQo+ID4+PiB0aW1lLg0KPiA+Pj4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IFsuLi5dDQo+ID4+
Pj4+Pj4NCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gRm9yIGNvbnRleHQsIGZpcm13YXJlIGFsc28g
ZmFpbHMgKGFuZCByZWNvdmVycykgc29tZXRpbWVzOg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gRGlk
IHlvdSBtZWFuIHRoaXMgZG9lc24ndCBhbHdheXMgaGFwcGVuPyBzb21ldGltZXM/DQo+ID4+Pj4+
Pg0KPiA+Pj4+Pj4gSXTigJlzIGFub3RoZXIgaW50ZXJtaXR0ZW50IGJlaGF2aW91ciBvYnNlcnZl
ZCBvbiB0aGlzIGJvYXJkIChhbmQgbm90DQo+ID4+Pj4+PiByZWxhdGVkIHRvIHRoZSBpc3N1ZSB0
aGlzIHBhdGNoIHRhcmdldHMpLiBJdCBvY2N1cnMgbGVzcyBmcmVxdWVudGx5DQo+ID4+Pj4+PiB0
aGFuIHRoZSBlZnVzZSBpc3N1ZSBhbmQgdGhlIGV4aXN0aW5nIHJldHJ5IG1lY2hhbmlzbSBpbiB0
aGUgZHJpdmVyDQo+ID4+Pj4+PiBlbnN1cmVzIGZpcm13YXJlIGxvYWQgYWx3YXlzIHN1Y2NlZWRz
Lg0KPiA+Pj4NCj4gPj4+IFRoaXMgbWlnaHQgYmUgdGhlIHNhbWUgY2F1c2UgZHVlIHRvIHJlYWRp
bmcgZWZ1c2UgaW4gZmlybXdhcmUuDQo+ID4+Pg0KPiA+Pj4gVGhvdWdoIHdlIGNhbiBhZGQgbW9y
ZSB0aW1lb3V0IGFuZCByZXRyeSB0aW1lcyBhcyB3b3JrYXJvdW5kLCBJIHdvbmRlcg0KPiA+Pj4g
aWYgeW91IGNhbiBjb250cm9sIGxvYWRpbmcgdGltZSBvZiBXaUZpIGFuZCBCVCBrZXJuZWwgbW9k
dWxlcz8NCj4gPj4+DQo+ID4+PiBNb3JlLCBjYW4geW91IGRvIGV4cGVyaW1lbnQgdGhhdCB5b3Ug
bG9hZCBCVCBtb2R1bGUgZmlyc3QsIGFuZCB0aGVuIGxvYWQNCj4gPj4+IFdpRmkgbW9kdWxlIGFm
dGVyIDEwIHNlY29uZHMgKGNob29zZSBhIGxhcmdlIG51bWJlciBpbnRlbnRpb25hbGx5LCBvcg0K
PiA+Pj4gZXZlbiBsYXJnZXIpPw0KPiA+Pg0KPiA+PiBodHRwczovL3Bhc3RlLmxpYnJlZWxlYy50
di9jaGFybWVkLXR1cmtleS5zaA0KPiA+Pg0KPiA+PiBJ4oCZdmUgcnVuIHRoZSBhYm92ZSBzY3Jp
cHQgXiB3aGljaCByZW1vdmVzIHRoZSB3aWZpIGFuZCBidCBtb2R1bGVzIGluDQo+ID4+IHNlcXVl
bmNlIHRoZW4gcmVsb2FkcyB0aGVtIGluIHRoZSByZXZlcnNlIG9yZGVyIHdpdGggYSBkZWxheSBi
ZXR3ZWVuDQo+ID4+IGJ0IGFuZCB3aWZpIG1vZHVsZXMgbG9hZGluZywgdGhlbiBjaGVja3MgZm9y
IGVycm9yIG1lc3NhZ2VzLiBPdmVyIDIwMA0KPiA+PiB0ZXN0IGN5Y2xlcyB3aXRoIGEgMTBzIGRl
bGF5IGFsbCB3ZXJlIGNsZWFuIChubyBlcnJvcnMpLiBJIGFsc28gcmFuDQo+ID4+IGN5Y2xlcyB3
aXRoIGEgMiBzZWNvbmQgZGVsYXkgYW5kIDAgc2Vjb25kIGRlbGF5IGJlZm9yZSBzdGFydGluZyB3
aWZpDQo+ID4+IG1vZHVsZSBsb2FkIGFuZCB0aG9zZSB3ZXJlIGNsZWFyIHRvby4gSSBndWVzcyB0
aGF0IHByb3ZlcyBzZXF1ZW5jaW5nDQo+ID4+IGF2b2lkcyB0aGUgZWZ1c2UgY29udGVudGlvbiBp
c3N1ZT8gLSBhbHRob3VnaCBpdOKAmXMgbm90IHBvc3NpYmxlIGluDQo+ID4+IHRoZSByZWFsLXdv
cmxkIHNvIG5vdCBzdXJlIHRoZXJl4oCZcyBodWdlIHZhbHVlIGluIGtub3dpbmcgdGhhdCA6KQ0K
PiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgZXhwZXJpbWVudHMuDQo+ID4NCj4gPiBTdGlsbCB3YW50
IHRvIGtub3cgaXMgaXQgcG9zc2libGUgdG8gY2hhbmdlIHNlcXVlbmNlL3RpbWUgb2YgbG9hZGlu
Zw0KPiA+IGtlcm5lbCBtb2R1bGVzIGF0IGJvb3QgdGltZSBmcm9tIHN5c3RlbSBsZXZlbD8gSSBt
ZWFuIGNhbiB5b3UgYWRqdXN0DQo+ID4gdGhlIHNlcXVlbmNlIGluIHRoZSBSb2NrIDVCIGJvYXJk
Pw0KPiANCj4gSeKAmW0gbm90IGEga2VybmVsIGV4cGVydCwgYnV0IEnigJl2ZSBhbHdheXMgdW5k
ZXJzdG9vZCBtb2R1bGUgcHJvYmUgYW5kDQo+IGxvYWQgb3JkZXJpbmcgdG8gbm90IGJlIGd1YXJh
bnRlZWQ7IGFzIG1hbnkgdGhpbmdzIHJ1biBpbiBwYXJhbGxlbCBhbmQNCj4gYXJlIGhpZ2hseSBz
dWJqZWN0aXZlIHRvIHRoZSBzcGVjaWZpYyBoYXJkd2FyZSBjYXBhYmlsaXRpZXMgYW5kIGtlcm5l
bA0KPiBjb25maWcgYmVpbmcgdXNlZC4NCg0KSSBoYXZlIGhlYXJkIHBlb3BsZSBhYm91dCBjaGFu
Z2luZyBzZXF1ZW5jZS90aW1lIG9mIGtlcm5lbCBtb2R1bGVzLCBzbw0KSSdkIGxpa2UgeW91IGNh
biB0cnkgdGhpcyBtZXRob2QuIA0KDQpJIGRpZCBhc2sgQUksIGl0IHNhaWQgaXQgaXMgcG9zc2li
bGUgdG8gY3JlYXRlIGEgLmNvbmYgZmlsZSB1bmRlcg0KL2V0Yy9tb2Rwcm9iZS5kLyBhbmQgdXNl
IGBzb2Z0ZGVwYCBzeW50YXggdG8gZW5zdXJlIGxvYWRpbmcgc2VxdWVuY2UuDQpDb3VsZCB5b3Ug
dHJ5IHRoaXM/DQoNCj4gDQo+ID4gSW4gYWRkaXRpb24sIGRpZCBiZWxvdyBtZXNzYWdlcyBub3Qg
YXBwZWFyIGluIHRoZXNlIGV4cGVyaW1lbnRzPw0KPiA+DQo+ID4gWyAgICA3Ljg2NDE0OF0gcnR3
ODlfODg1MmJlIDAwMDI6MjE6MDAuMDogZncgc2VjdXJpdHkgZmFpbA0KPiA+IFsgICAgNy44NjQx
NTRdIHJ0dzg5Xzg4NTJiZSAwMDAyOjIxOjAwLjA6IGRvd25sb2FkIGZpcm13YXJlIGZhaWwNCj4g
DQo+IE5vLCBiZWNhdXNlIGV2ZW4gaWYgd2UgaGF2ZSBhIDBzIGRlbGF5IGJldHdlZW4gZWFjaCBn
cm91cCBvZiBtb2R1bGVzDQo+IGJlaW5nIGxvYWRlZCwgdGhleSBhcmUgbG9hZGVkIGluIHNlcmll
cywgc28gd2Ugd29ya2Fyb3VuZCB0aGUgaXNzdWUuDQo+IFR3ZWFraW5nIHRoZSBzY3JpcHQgdG8g
YmFja2dyb3VuZCB0aGUgbW9kdWxlIGxvYWQgbG9vcHMgc28gYm90aCBydW4NCj4gaW4gcGFyYWxs
ZWwgd291bGQgYmUgY2xvc2VyIHRvIG5vcm1hbCBjb25kaXRpb25zLCBhbmQgSSB3b3VsZCBleHBl
Y3QNCj4gdG8gc3RhcnQgc2VlaW5nIGZhaWx1cmVzIGFuZCB0aGUgcmV0cnkgbWVjaGFuaXNtcyB3
aXRoaW4gdGhlIG1vZHVsZXMNCj4gKGFzIGFkZGVkIGluIHRoaXMgcGF0Y2gpIGJlaW5nIHRyaWdn
ZXJlZC4NCg0KQWRkaXRpb25hbCBxdWVzdGlvbiBmb3IgZG93bmxvYWRpbmcgZmlybXdhcmUuIEFz
IHlvdSByZXBvcnRlZCB0aGlzDQppc3N1ZSBpbml0aWFsbHkgKGxvYWQgbW9kdWxlcyBhdCBib290
IHRpbWUgaW4gcGFyYWxsZWwpLCBpdCBzZWVtcyANCmFwcGVhciB0aGlzIG1lc3NhZ2UgYnkgY2hh
bmNlLiBTaW5jZSB0aGlzIGRyaXZlciB3aWxsIHJldHJ5IHRvIGRvd25sb2FkDQpmaXJtd2FyZSwg
d2lsbCBpdCBzdWNjZXNzZnVsbHkgZG93bmxvYWRzIGZpcm13YXJlIGZpbmFsbHk/IE9yIGl0IHN0
aWxsDQpmYWlscyB0byBkb3dubG9hZCBhZnRlciA1IHRpbWVzIHJldHJ5Pw0KDQpQaW5nLUtlDQoN
Cg==

