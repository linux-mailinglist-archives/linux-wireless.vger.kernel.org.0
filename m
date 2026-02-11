Return-Path: <linux-wireless+bounces-31713-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C2uJZnji2kVcgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31713-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 03:04:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C87120A6D
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 03:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50DE7301D4D2
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 02:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C862FD660;
	Wed, 11 Feb 2026 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="eNto+OpZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C469D2F60D1
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770775440; cv=none; b=sSkdqym7K0PdzQtpitZXnD9rxHL6Jw/XQus8Sj2fzI9RVijnNVf2dhsliFk67V9r4OPCJbDPzViSkkCor3QLHR359aTf+rvPV5mx7MeKI2JkiEEJXDt3Dojyqkg0sMGUvVYBFvYTIRBj0bqG0rr6u2wEmEu4E3ChGEzi6/AR59Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770775440; c=relaxed/simple;
	bh=zUE/3FONEDBvpUbOfwpsKJImTqncw422anlTT7742EE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oRrIL9K3fKGGVpijdLUX0Vu/heQX/bZOd0n4PQgBdyUMttLDUgt3LtFji7EOrK1KaX8kWvuJ6fKORm3izThufxKI4iKGnLkPndPtNEQuczZvb9c2MUG8WaazmGUu4+69kIEzjAQnhLD7FA82a1gcDF5Z2x0R011AK/zhv7JppjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=eNto+OpZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61B23t302802392, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770775435; bh=zUE/3FONEDBvpUbOfwpsKJImTqncw422anlTT7742EE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=eNto+OpZRUAbY0pmBOtJV6Os4IqeSONgrA21wgwD2VgJYhAOi7j63F/l+qW/8eRP2
	 RWWYZ/NEEiWHTfED8A5TYKDPbiEk/yNYvEMLLpjRWp0X6QhJiAcCCSX+pPe76QivZM
	 Fv3bDS+1qb9+GqG66Rj6eF1BecWE8S3CQdO3WPlTIhXzletBT0c093/ceeCVKMofLZ
	 3Kboo8iqyFi6tvhoIdlDo1AmlLYxXxdaaX10D8bpCPDUBQwtzrRrhxx15b3T9+d7O3
	 olaDX0QPy1Tg8NpvKXz1J4F5Jy36e023UlM6TN1uEYwMB6W6q34LSN6FwfWn53HDcI
	 J5MaYoGO3c13g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61B23t302802392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 10:03:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 11 Feb 2026 10:03:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Wed, 11 Feb 2026 10:03:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: Ignore TX report sequence number
 from the 8051 chips
Thread-Topic: [PATCH rtw-next] wifi: rtw88: Ignore TX report sequence number
 from the 8051 chips
Thread-Index: AQHcmIFUmn8F5SE8tkKhCC9anOXjZ7V6Bk9QgABO9gCAASjwkIAAdF4AgADO8DA=
Date: Wed, 11 Feb 2026 02:03:54 +0000
Message-ID: <f9652882eeb042f89463e0fa864f1412@realtek.com>
References: <4fc30feb-5616-4e2e-86d8-0d96e4f191c2@gmail.com>
 <04799d469547468abe15eadb2ec74255@realtek.com>
 <a95d43dc-58c7-4c9c-9b42-204f2134f099@gmail.com>
 <442b0555b369487b81ba96dcf410cf7d@realtek.com>
 <9110568d-419b-46a7-b0f0-808f958a6efc@gmail.com>
In-Reply-To: <9110568d-419b-46a7-b0f0-808f958a6efc@gmail.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31713-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Queue-Id: 20C87120A6D
X-Rspamd-Action: no action

DQpCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+IE9u
IDEwLzAyLzIwMjYgMDg6NDQsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiBCaXR0ZXJibHVlIFNt
aXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+IE9uIDA5LzAyLzIwMjYg
MTA6MTksIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPj4+IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4
MjFjZXJmZTJAZ21haWwuY29tPiB3cm90ZToNCj4gPj4+PiBXaGVuIGNvbm5lY3RlZCB0byBhIG5l
dHdvcmsgaW4gdGhlIDIuNCBHSHogYmFuZCwgd3BhX3N1cHBsaWNhbnQgKG9yDQo+ID4+Pj4gTmV0
d29ya01hbmFnZXI/KSB0cmlnZ2VycyBhIHNjYW4gZXZlcnkgZml2ZSBtaW51dGVzLiBEdXJpbmcg
dGhlc2Ugc2NhbnMNCj4gPj4+PiBtYWM4MDIxMSB0cmFuc21pdHMgbWFueSBRb1MgTnVsbCBmcmFt
ZXMgaW4gcXVpY2sgc3VjY2Vzc2lvbi4gQmVjYXVzZQ0KPiA+Pj4+IHRoZXNlIGZyYW1lcyBhcmUg
bWFya2VkIHdpdGggSUVFRTgwMjExX1RYX0NUTF9SRVFfVFhfU1RBVFVTLCBydHc4OA0KPiA+Pj4+
IGFza3MgdGhlIGZpcm13YXJlIHRvIHJlcG9ydCB0aGUgVFggQUNLIHN0YXR1cyBmb3IgZWFjaCBv
ZiB0aGVzZSBmcmFtZXMuDQo+ID4+Pj4gU29tZXRpbWVzIHRoZSBmaXJtd2FyZSBjYW4ndCBwcm9j
ZXNzIHRoZSBUWCBzdGF0dXMgcmVxdWVzdHMgcXVpY2tseQ0KPiA+Pj4+IGVub3VnaCwgdGhleSBh
ZGQgdXAsIGl0IG9ubHkgcHJvY2Vzc2VzIHNvbWUgb2YgdGhlbSwgYW5kIHRoZW4gbWFya3MNCj4g
Pj4+PiBldmVyeSBzdWJzZXF1ZW50IFRYIHN0YXR1cyByZXBvcnQgd2l0aCB0aGUgd3JvbmcgbnVt
YmVyLg0KPiA+Pj4NCj4gPj4+IERvZXMgaXQgbWVhbiBudW1iZXIgb2YgcmVwb3J0cyBpcyBjb3Jy
ZWN0PyBCdXQgd2l0aCBpbmNvcnJlY3Qgc2VxdWVuY2UgbnVtYmVyPw0KPiA+Pj4gVGhlbiwgeW91
IGp1c3QgaWdub3JlIGNoZWNraW5nICdzbicgYnV0IGFzc3VtZSAnc3QnIGlzIGNvcnJlY3QuDQo+
ID4+Pg0KPiA+Pg0KPiA+PiBUaGUgbnVtYmVyIG9mIHJlcG9ydHMgaXMgY29ycmVjdCBtb3N0IG9m
IHRoZSB0aW1lLiBPbmx5IHdoZW4gdGhlIGZpcm13YXJlDQo+ID4+IGlzIG92ZXJ3aGVsbWVkICg/
KSBpdCBkb2Vzbid0IHByb3ZpZGUgZXZlcnkgcmVwb3J0LCBidXQgbGF0ZXIgaXQgcmVjb3ZlcnMu
DQo+ID4+DQo+ID4NCj4gPiBJIHdhcyBub3QgYXdhcmUgdGhhdCB0aGlzIGhhcHBlbmVkIHdoaWxl
IHNjYW5uaW5nLCBzbyB3ZSBtaWdodCBhcHBseSB0aGlzIGxvb3NlDQo+ID4gY2hlY2tpbmcgdW5k
ZXIgc2NhbiBjb25kaXRpb24gLS0gdGVzdF9iaXQoUlRXX0ZMQUdfU0NBTk5JTkcsIHJ0d2Rldi0+
ZmxhZ3MpIj8NCj4gPiBJZiBUWCByZXBvcnQgaXMgYmVjYXVzZSBvZiByZS1rZXksIGl0IGNhbiBz
dGlsbCB1c2Ugb3JpZ2luYWwgcnVsZS4NCj4gPg0KPiA+IFsuLi5dDQo+ID4NCj4gDQo+IFdlIGNh
bid0IGRvIHRoYXQgYmVjYXVzZSB0aGUgc2VxdWVuY2UgbnVtYmVyIGlzIHBlcm1hbmVudGx5IG1l
c3NlZCB1cC4NCg0KSW5kZWVkLi4uDQoNCj4gDQo+IEkgdGhvdWdodCBhYm91dCBpZ25vcmluZyBJ
RUVFODAyMTFfVFhfQ1RMX1JFUV9UWF9TVEFUVVMgb24gbnVsbCBmcmFtZXMNCj4gc2VudCBkdXJp
bmcgc2NhbnMsIGJ1dCB1bmZvcnR1bmF0ZWx5IHRoZSBsYXN0IDIgb3IgMyBRT1MgTnVsbCBmcmFt
ZXMNCj4gYXJlIHNlbnQgYWZ0ZXIgUlRXX0ZMQUdfU0NBTk5JTkcgaXMgdW5zZXQsIGFuZCB0aGV5
IHN0aWxsIHRyaWdnZXIgdGhlDQo+IHByb2JsZW0uDQo+IA0KPiBXaGlsZSBwb2tpbmcgYXJvdW5k
IHRvZGF5IEkgbm90aWNlZCB0aGF0IG9ubHkgbm9uLVFPUyBudWxsIGZyYW1lcyBhcmUNCj4gdHJl
YXRlZCBsaWtlIG1hbmFnZW1lbnQgZnJhbWVzLiBRT1MgbnVsbCBmcmFtZXMgYXJlIHRyZWF0ZWQg
bGlrZSBkYXRhDQo+IGZyYW1lcy4gU28gSSB0cmllZCB0aGlzIGNoYW5nZToNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3R4LmMgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3R4LmMNCj4gaW5kZXggNzgzOTc1YWNkY2ZmLi5l
YTgzZGFhOWQ2MGQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODgvdHguYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3R4
LmMNCj4gQEAgLTQyNCw3ICs0MjQsNyBAQCB2b2lkIHJ0d190eF9wa3RfaW5mb191cGRhdGUoc3Ry
dWN0IHJ0d19kZXYgKnJ0d2RldiwNCj4gICAgICAgICAgICAgICAgIHBrdF9pbmZvLT5tYWNfaWQg
PSBydHd2aWYtPm1hY19pZDsNCj4gICAgICAgICB9DQo+IA0KPiAtICAgICAgIGlmIChpZWVlODAy
MTFfaXNfbWdtdChmYykgfHwgaWVlZTgwMjExX2lzX251bGxmdW5jKGZjKSkNCj4gKyAgICAgICBp
ZiAoaWVlZTgwMjExX2lzX21nbXQoZmMpIHx8IGllZWU4MDIxMV9pc19hbnlfbnVsbGZ1bmMoZmMp
KQ0KPiAgICAgICAgICAgICAgICAgcnR3X3R4X21nbXRfcGt0X2luZm9fdXBkYXRlKHJ0d2Rldiwg
cGt0X2luZm8sIHN0YSwgc2tiKTsNCj4gICAgICAgICBlbHNlIGlmIChpZWVlODAyMTFfaXNfZGF0
YShmYykpDQo+ICAgICAgICAgICAgICAgICBydHdfdHhfZGF0YV9wa3RfaW5mb191cGRhdGUocnR3
ZGV2LCBwa3RfaW5mbywgc3RhLCBza2IpOw0KPiANCj4gV2l0aCB0aGlzIEkgY2FuJ3QgdHJpZ2dl
ciB0aGUgcHJvYmxlbSBhbnltb3JlLiBUaGUgc2VxdWVuY2UgbnVtYmVycw0KPiBhcmUgbm9ybWFs
IGV2ZXJ5IHRpbWUuIFdlbGwsIGl0J3MgdG9vIHNvb24gdG8gYmUgc3VyZSwgc28gSSB3aWxsIGtl
ZXANCj4gdGVzdGluZyBmb3IgYSBmZXcgZGF5cy4NCg0KR29vZCBmaW5kaW5nLiBQbGVhc2Uga2Vl
cCB0ZXN0aW5nIGl0Lg0KDQpGWUkuIEhhdmluZyB0aGUgbHVuYXIgTmV3IFllYXIgbmV4dCB3ZWVr
LCBJIHdpbGwgbm90IHJlcGx5IHlvdXIgbWFpbCBzb29uLg0KDQo+IA0KPiA+Pg0KPiA+Pj4+DQo+
ID4+Pj4gVGhlIHN5bXB0b20gaXMgdGhhdCBhZnRlciBhIHdoaWxlIHRoZSB3YXJuaW5nICJmYWls
ZWQgdG8gZ2V0IHR4IHJlcG9ydA0KPiA+Pj4+IGZyb20gZmlybXdhcmUiIGFwcGVhcnMgZXZlcnkg
Zml2ZSBtaW51dGVzLg0KPiA+Pj4+DQo+ID4+Pj4gVGhpcyBwcm9ibGVtIGFwcGFyZW50bHkgaGFw
cGVucyBvbmx5IHdpdGggdGhlIG9sZGVyIFJUTDg3MjNELCBSVEw4ODIxQSwNCj4gPj4+PiBSVEw4
ODEyQSwgYW5kIHByb2JhYmx5IFJUTDg3MDNCIGNoaXBzLiBJZ25vcmUgdGhlIFRYIHJlcG9ydCBz
ZXF1ZW5jZQ0KPiA+Pj4+IG51bWJlciByZXBvcnRlZCBieSB0aGVzZSBjaGlwcyBhbmQgbWF0Y2gg
dGhlIHJlcG9ydHMgd2l0aCB0aGUgcmVxdWVzdHMNCj4gPj4+PiBpbiB0aGUgb3JkZXIgdGhleSBj
b21lIGluLg0KPiA+Pj4+DQo+ID4+Pj4gVGVzdGVkIHdpdGggUlRMODgyMUFVIGFuZCBSVEw4NzIz
RFUuDQo+ID4+Pj4NCj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4
ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gPj4+PiAtLS0NCj4gPj4+PiAgZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydHc4OC90eC5jIHwgMiArLQ0KPiA+Pj4+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPj4+Pg0KPiA+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3R4LmMgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3R4LmMNCj4gPj4+PiBpbmRleCBjMDRmZjMxZDBmMWUuLjk4
MjE1ZWNjODg0YSAxMDA2NDQNCj4gPj4+PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg4L3R4LmMNCj4gPj4+PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg4L3R4LmMNCj4gPj4+PiBAQCAtMjQ4LDcgKzI0OCw3IEBAIHZvaWQgcnR3X3R4X3JlcG9y
dF9oYW5kbGUoc3RydWN0IHJ0d19kZXYgKnJ0d2Rldiwgc3RydWN0IHNrX2J1ZmYgKnNrYiwgaW50
IHNyYykNCj4gPj4+PiAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZ0eF9yZXBvcnQtPnFfbG9j
aywgZmxhZ3MpOw0KPiA+Pj4+ICAgICAgICAgc2tiX3F1ZXVlX3dhbGtfc2FmZSgmdHhfcmVwb3J0
LT5xdWV1ZSwgY3VyLCB0bXApIHsNCj4gPj4+PiAgICAgICAgICAgICAgICAgbiA9ICh1OCAqKUlF
RUU4MDIxMV9TS0JfQ0IoY3VyKS0+c3RhdHVzLnN0YXR1c19kcml2ZXJfZGF0YTsNCj4gPj4+PiAt
ICAgICAgICAgICAgICAgaWYgKCpuID09IHNuKSB7DQo+ID4+Pj4gKyAgICAgICAgICAgICAgIGlm
ICgqbiA9PSBzbiB8fCBydHdfY2hpcF93Y3B1XzgwNTEocnR3ZGV2KSkgew0KPiA+Pj4NCj4gPj4+
IENhbiB3ZSBvbmx5IGxpbWl0IHRvIFVTQiBkZXZpY2VzIChvciBub24tUENJIGRldmljZXMpPw0K
PiA+Pj4NCj4gPj4NCj4gPj4gSSBkb24ndCB0aGluayBzby4gUlRMODgyMUFFIGFsc28gaGFzIHRo
aXMgcHJvYmxlbS4gSSBkaWRuJ3QgbWVudGlvbiBpdA0KPiA+PiBpbiB0aGUgY29tbWl0IG1lc3Nh
Z2UgYmVjYXVzZSBzdXBwb3J0IGZvciBSVEw4ODIxQUUgaW4gcnR3ODggaXMNCj4gPj4gdW5vZmZp
Y2lhbC4gKEkgbW9kaWZpZWQgcnR3ODhfcGNpIHRvIGhhbmRsZSB0aGUgb2xkZXIgZ2VuZXJhdGlv
biwgc2VlDQo+ID4+IHRoZSB1c2VfbmV3X3RyeF9mbG93PWZhbHNlIGNvZGUgcGF0aCBpbiBydGx3
aWZpLikNCj4gPg0KPiA+IEhvdyBhYm91dCBvZmZpY2lhbCBSVEw4NzIzREU/DQo+ID4NCj4gDQo+
IEkgZG9uJ3QgaGF2ZSBSVEw4NzIzREUuIEkgY2FuIHRyeSB3aXRoIFJUTDg3MjNEUywgYWx0aG91
Z2ggaXQncyBhbm5veWluZw0KPiB0byB1c2UuIChUaGUgaG9zdCBpcyBzb21lIGtpbmQgb2Ygc2lu
Z2xlIGJvYXJkIGNvbXB1dGVyLiBJdCBoYXMgb25seSBhDQo+IHNlcmlhbCBpbnRlcmZhY2UgYW5k
IHdoZW4gSSBjb25uZWN0IHRoYXQgdG8gbXkgbGFwdG9wIGl0IG1ha2VzIHRoZQ0KPiB0b3VjaHBh
ZCBzbG93IGZvciBzb21lIHJlYXNvbi4pDQoNCkkgZm91bmQgYSBSVEw4NzIzREUgYW5kIHRlc3Rl
ZCBzY2FuIGR1cmluZyBjb25uZWN0aW9uIG92ZXIgMTAgdGltZXMNCih3aXRoIGxvY2FsIG1vZGlm
aWNhdGlvbiB0byBwcmludCBUWC1zbi9SWC1zbikuDQpJJ2Qgc2F5IFJUTDg3MjNERSBkb2Vzbid0
IGhhdmUgdGhpcyBwcm9ibGVtLg0KDQo+IA0KPiA+Pg0KPiA+Pj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgIF9fc2tiX3VubGluayhjdXIsICZ0eF9yZXBvcnQtPnF1ZXVlKTsNCj4gPj4+PiAgICAg
ICAgICAgICAgICAgICAgICAgICBydHdfdHhfcmVwb3J0X3R4X3N0YXR1cyhydHdkZXYsIGN1ciwg
c3QgPT0gMCk7DQo+ID4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4+Pj4g
LS0NCj4gPj4+PiAyLjUyLjANCj4gPj4+DQo+ID4NCg0K

