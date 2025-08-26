Return-Path: <linux-wireless+bounces-26599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9A9B35028
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 02:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88263B0EF7
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 00:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD5A216E32;
	Tue, 26 Aug 2025 00:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="V+EI6Efb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2344A21638D
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167743; cv=none; b=uClG+3IsgRbCW8CY3LtSYu7LUdr8d/Ay30Iz6hK2j/hp+GZV7RxsIdPKba4sGW0EOvpm1fu1DFytP325dEVeZpnM3TUFhk/t0gTZPf/Q0Cw+j6L9kzMBBxavk/AdMzwk9dqipK6jxx5gAGMirSqBRSSUVrOWjid+ImCKuPJtAK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167743; c=relaxed/simple;
	bh=lc8ReBpLKnPt0vlmbDqqI65XJ1fg7N/2QXWJr2iXCn0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T+yT5Bs9QfDlFDn+3JXmrC29xZFsS0GApPSELOOqjcw5puuIx/8VKyu6oP98yV/5eoueFMu/eHElXYUtp+F8lCb6vgazwgk8eVVCvtwYHre2eGE4WOqlEaiMCYU+JG9m5FDSejPrlVftzz2J9GiSQa3qdhuhj8C8e45XWLMv6l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=V+EI6Efb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57Q0MCHG0239700, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756167732; bh=lc8ReBpLKnPt0vlmbDqqI65XJ1fg7N/2QXWJr2iXCn0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=V+EI6EfbKtLa8V1qEIc7tk9Js2bbXTtrixYxCHj2PrWl1HKopPxGh8HxHxNPknmfj
	 cy31HkUS1keYuXlRqIjRNKuH8Hox8/SG18WUT9zIRZFIZXg9dwbCNenVdXLsqmchVs
	 QzlNX+4GTtHBLRUT6v8PuDTQfwY6XOBfs1K0qttFI9CYT8sDTu+oWlwfKfTsFnxa9i
	 7pdPkVPbbut4oY7VZPD4iuS7IEobRSH7B6LgnPmqHODoFOqYcteHALmRhSHeCmtvJ9
	 Cj4R537qFn1EtvG9DMkudz+rNxCaYep1mqEU9+UDrEo7BiricDDZM+PzwUKCaiI30X
	 XTx02HgpK+3RQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57Q0MCHG0239700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 08:22:12 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 26 Aug 2025 08:22:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 26 Aug 2025 08:22:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 26 Aug 2025 08:22:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        =?utf-8?B?0JDQu9C10LrRgdC10Lkg0KHQvNC40YDQvdC+0LI=?= <debugger94@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jes
 Sorensen" <Jes.Sorensen@gmail.com>
Subject: RE: Remove TL-WN722N V2 from untested devices
Thread-Topic: Remove TL-WN722N V2 from untested devices
Thread-Index: AQHcE0qp+1KL1vhWdkOEst7MHC1MGrRy4ccg///f4YCAAVXjEA==
Date: Tue, 26 Aug 2025 00:22:12 +0000
Message-ID: <1830368c466c4b17999a7f2c76b7f6c8@realtek.com>
References: <CAAN7eZ7QKEeQgNHEBuZKy4Gqg3oqpGi6BUdOVBOxPN7dedhVJQ@mail.gmail.com>
 <6851d6d86fb84b2d8f5a787906bc58cd@realtek.com>
 <d05522ce-48e6-4e7a-bbdd-327a6fb3dd99@gmail.com>
In-Reply-To: <d05522ce-48e6-4e7a-bbdd-327a6fb3dd99@gmail.com>
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

KyBKZXMNCg0KQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3Rl
Og0KPiBPbiAyNS8wOC8yMDI1IDA4OjU3LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4g0JDQu9C1
0LrRgdC10Lkg0KHQvNC40YDQvdC+0LIgPGRlYnVnZ2VyOTRAZ21haWwuY29tPiB3cm90ZToNCj4g
Pj4gSSBoYXZlIGJlZW4gdXNpbmcgdGhpcyBXaS1GaSBkb25nbGUgZm9yIG1hbnkgeWVhcnMgbm93
IGFuZCBoYXZlIGhhZCBubw0KPiA+PiBwcm9ibGVtcyB3aXRoIGl0LiBUaGUgZGV2aWNlIGlzIHF1
aXRlIG9sZCBhbmQga25vd24sIGR1bXBpbmcgaXRzIGVmdXNlIHRvDQo+ID4+IHRoZSBsb2cgYW5k
IGFza2luZyB0aGUgdXNlciB0byBzZW5kIHRoZSByZXN1bHRzIHRvIEplcy5Tb3JlbnNlbkBnbWFp
bC5jb20NCj4gPj4gb24gZXZlcnkgYm9vdCBtYWtlcyBsaXR0bGUgc2Vuc2UuIFBsZWFzZSBhcHBs
eToNCj4gPg0KPiA+IEknbGwgcmVwaHJhc2UgY29tbWl0IG1lc3NhZ2Ugd2hlbiBJIG1lcmdlIHRo
aXM6DQo+ID4NCj4gPiB3aWZpOiBydGw4eHh4dTogUmVtb3ZlIFRMLVdONzIyTiBWMiAoMHgyMzU3
OiAweDAxMGMpIGZyb20gdW50ZXN0ZWQgZGV2aWNlcw0KPiA+DQo+ID4gVGhpcyBXaS1GaSBkb25n
bGUgaGFzIGJlZW4gdXNlZCBmb3IgbWFueSB5ZWFycyBub3cgYW5kIGhhdmUgaGFkIG5vIHByb2Js
ZW1zDQo+ID4gd2l0aCBpdC4gVGhlIGRldmljZSBpcyBxdWl0ZSBvbGQgYW5kIGtub3duLCBkdW1w
aW5nIGl0cyBlZnVzZSB0byB0aGUgbG9nIGFuZA0KPiA+IGFza2luZyB0aGUgdXNlciB0byBzZW5k
IHRoZSByZXN1bHRzIHRvIEplcy5Tb3JlbnNlbkBnbWFpbC5jb20gb24gZXZlcnkgYm9vdA0KPiA+
IG1ha2VzIGxpdHRsZSBzZW5zZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6INCQ0LvQtdC60YHQ
tdC5INCh0LzQuNGA0L3QvtCyIDxkZWJ1Z2dlcjk0QGdtYWlsLmNvbT4NCj4gPiBSZXZpZXdlZC1i
eTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+ID4NCj4gPj4NCj4gPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvY29yZS5jDQo+
ID4+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9jb3JlLmMNCj4gPj4g
aW5kZXggODMxYjUwMjVjNjM0Li4xMTNlMDFkZjA5MDIgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvY29yZS5jDQo+ID4+ICsrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvY29yZS5jDQo+ID4+IEBAIC03ODE1LDcg
Kzc4MTUsNyBAQCBzdGF0aWMgaW50IHJ0bDh4eHh1X3Byb2JlKHN0cnVjdCB1c2JfaW50ZXJmYWNl
ICppbnRlcmZhY2UsDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgIHVudGVzdGVkID0gMDsN
Cj4gPj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+PiAgICAgICAgIGNhc2UgMHgyMzU3Og0K
PiA+PiAtICAgICAgICAgICAgICAgaWYgKGlkLT5pZFByb2R1Y3QgPT0gMHgwMTA5IHx8IGlkLT5p
ZFByb2R1Y3QgPT0gMHgwMTM1KQ0KPiA+PiArICAgICAgICAgICAgICAgaWYgKGlkLT5pZFByb2R1
Y3QgPT0gMHgwMTA5IHx8IGlkLT5pZFByb2R1Y3QgPT0gMHgwMTBjDQo+ID4+IHx8IGlkLT5pZFBy
b2R1Y3QgPT0gMHgwMTM1KQ0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICB1bnRlc3RlZCA9
IDA7DQo+ID4+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gPj4gICAgICAgICBjYXNlIDB4MGIw
NToNCj4gPg0KPiANCj4gSSBwcm9wb3NlIHdlIHNpbXBseSByZW1vdmUgdGhlIGVudGlyZSBsaXN0
IG9mIHRlc3RlZCBkZXZpY2VzLiBJdCdzIG5vdA0KPiBwYXJ0aWN1bGFybHkgdXNlZnVsIHRvIHRl
bGwgcGVvcGxlIHRvIHJlcG9ydCBpZiBhIGRldmljZSB3b3JrcyBvciBub3QuDQo+IElmIGl0IGRv
ZXNuJ3Qgd29yayB0aGV5IHdpbGwgcmVwb3J0IGl0IGFueXdheS4NCg0KVGhpcyB1bnRlc3RlZCBm
bGFnIHdhcyBhZGRlZCBzaW5jZSAyMDE1IGF0IGZpcnN0IGNvbW1pdCwgYnV0IEkgd2Fzbid0IGhl
cmUNCmF0IHRoYXQgdGltZS4gSmVzLCBjb3VsZCB5b3UgcGxlYXNlIGNvbW1lbnQgdGhpcyB1bnRl
c3RlZCByZXBvcnQgb2YgZWZ1c2UNCmlzIHN0aWxsIHVzZWZ1bCBub3c/DQoNCg0K

