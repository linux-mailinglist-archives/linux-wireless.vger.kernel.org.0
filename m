Return-Path: <linux-wireless+bounces-13078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220DA97E5B1
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 07:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8D7280DD7
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 05:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C99EEA9;
	Mon, 23 Sep 2024 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Z9ns9Wb1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287241FDA
	for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 05:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727070470; cv=none; b=Cyx95eMN3+H5miI9jAhguMkwzLwgjltMtjlde658XOhSdb7+sMNTIAYIbQSixoYnjq96B2gvJ+ZRrg4rdI7FBKbEpwfc1Koo692o6JffhNdUoST9qrgdD/X73d0u+PUCbXji2URXBf0WlM//rsbCTndTlhDFD/HDEMcr+6M3tkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727070470; c=relaxed/simple;
	bh=gOv52MAZZqld6ujHyOr5B+rgUbeHMn3TR397h0ckTvE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hm9uZy8KpKM0Q9HpZq6U/9gKEgK4SiUmXSeOLP7Om9VmdJGt/ZwuNLNgm3KmOi8hbq9soD4saw4LL0UiuD1SYfeh0owt+RkeIt/avpwaYB8dE64hwSkbGnN4XlOVugcQRLcguavUhQGfBHy0ywlbx5+kEbj5Jm86jwaa8B6qgpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Z9ns9Wb1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48N5lgArB853907, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727070462; bh=gOv52MAZZqld6ujHyOr5B+rgUbeHMn3TR397h0ckTvE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Z9ns9Wb1KfjH1X9j/mMzDSKTpgf34yuVkoeCnMogmdCGF8lHrqI5yO3Ib+UZfVj+c
	 VtRPdgC8Az4p5p4vu98QnEeycCSwX0qwpvEsGdSADFMJ3FdostQJXUL10HsWXLrWWC
	 O7ynSEDwnOiezxDSrtYD5sl3R3wFnQIK4u5aniq0U1aBM+gT3pQp+Us0FCTTnLiBRO
	 JQq3NEMituvKtn0gaYxYjSETZQdie+UCdjhMUKILgzV1e1xYidu6ez8cXiAvCZCAlc
	 FgQDGHuVHtNG3iGWl+UUUJ+wewA+14s0VwSxVKDednREfrwSSWOJoN1s37ZhjRLM+9
	 YUiBM9DWKG6XA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48N5lgArB853907
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 13:47:42 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 13:47:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 23 Sep 2024 13:47:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 23 Sep 2024 13:47:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 18/20] wifi: rtw88: Add rtw8821a.{c,h}
Thread-Topic: [PATCH 18/20] wifi: rtw88: Add rtw8821a.{c,h}
Thread-Index: AQHa7DKP0miyRAHIW0qWSqezSXaH97IpJM5AgBHQWoCAFW7yIIADltQAgAEjSvCADXPMAIACikGA
Date: Mon, 23 Sep 2024 05:47:42 +0000
Message-ID: <73de8e7135554ae9a0f7968780644515@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <f25d00ab-4481-4540-956b-bc1028a501e1@gmail.com>
 <e365c61d730d4f49915b543dcb0063d5@realtek.com>
 <dafaac0c-fb55-4406-b8ff-69aa66d3fd06@gmail.com>
 <1aca96c68f914f90b6d1baf8780e6ce4@realtek.com>
 <bebaa40a-1c7a-4b1e-99cd-7c7aac7c76f4@gmail.com>
 <f583e9470ca84234ad2e00f3a0371664@realtek.com>
 <38553e79-6747-4ab3-9bf4-fa7f2af852cd@gmail.com>
In-Reply-To: <38553e79-6747-4ab3-9bf4-fa7f2af852cd@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+Pj4+
Pj4gKw0KPiA+Pj4+Pj4gK2NvbnN0IHN0cnVjdCBydHdfY2hpcF9pbmZvIHJ0dzg4MTJhX2h3X3Nw
ZWMgPSB7DQo+ID4+Pj4+DQo+ID4+Pj4+IElzIGl0IHBvc3NpYmxlIG1vdmluZyA4ODEyYSB0byBp
bmRpdmlkdWFsIGZpbGU/DQo+ID4+Pj4+IFNpbmNlIHlvdSBoYXZlIHJ0dzg4MTJhdS5jIGFuZCBy
dHc4ODIxYXUuYy4NCj4gPj4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IEkgdGhpbmsgaXQgaXMgcG9zc2li
bGUuIEJ1dCBtb3N0IG9mIHRoZSBjb2RlIGlzIGNvbW1vbiB0byBib3RoIGNoaXBzLg0KPiA+Pj4+
IE9ubHkgdGhlIElRIGNhbGlicmF0aW9uIGNvdWxkIGJlIG1vdmVkLg0KPiA+Pj4NCj4gPj4+IFll
cCwgZGVwZW5kIG9uIGhvdyBtdWNoIElRSyBjb2RlIGVjaG8gY2hpcCBoYXMuDQo+ID4+Pg0KPiA+
Pg0KPiA+PiBUaGUgSVEgY2FsaWJyYXRpb24gZm9yIFJUTDg4MTJBVSBpcyBhYm91dCA3MDAgbGlu
ZXMuDQo+ID4NCj4gPiBydHc4ODEyYXUgIC0tLS0tPiAoYSkgcnR3ODgxMmENCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgdg0KPiA+ICAg
ICAgICAgICAgICAgICAgIChiKSBydHc4ODIxYV9jb21tb24gIChoYXJkIHRvIGdpdmUgYSBuYW1l
KQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICB8DQo+ID4gcnR3ODgyMWF1ICAtLS0tLT4gKGMpIHJ0dzg4MjFhDQo+ID4NCj4gPiBQdXQg
YWxsIGNvbW1vbiBjb2RlIHRvIChiKS4gSVFLIGNvZGUgaW4gKGEpIG9yIChjKS4NCj4gPg0KPiA+
IEkgZmVlbCB5b3UgaGF2ZSB0aG91Z2h0IGFib3ZlIHBpY3R1cmUgYWxyZWFkeS4gV2hhdCBhcmUg
cHJvYmxlbXMgd2Ugd2lsbCBlbmNvdW50ZXI/DQo+ID4gTWFueSBleHBvcnQgc3ltYm9scz8gSWYg
c28sIGhvdyBhYm91dCBiZWxvdz8NCj4gPg0KPiA+IHJ0dzg4MTJhdSAgLS0tLS0+ICgxKSBydHc4
ODEyYQ0KPiA+ICAgICArLS0tLS0tLS0tKw0KPiA+ICAgICAgICAgICAgICAgKy0+ICgyKSBydHc4
ODIxYV9jb21tb24gIChoYXJkIHRvIGdpdmUgYSBuYW1lKQ0KPiA+ICAgICArLS0tLS0tLS0tKw0K
PiA+IHJ0dzg4MjFhdSAgLS0tLS0+ICgzKSBydHc4ODIxYQ0KPiA+DQo+ID4gUHV0IHJ0dzg4MTJh
X2h3X3NwZWMgYW5kIHJ0dzg4MjFhX2h3X3NwZWMgaW4gKDIpLiBPbmx5IElRSyBjb2RlIGluICgx
KSBhbmQgKDMpDQo+ID4gcmVzcGVjdGl2ZWx5LCBhbmQgZXhwb3J0IElRSyBlbnRyeSBvbmx5LiBE
b2VzIGl0IHdvcms/DQo+ID4NCj4gPg0KPiBGb3IgdGhlIG5hbWUgb2YgdGhlIGNvbW1vbiBtb2R1
bGUsIEkgd2FzIHRoaW5raW5nIHJ0dzg4Xzg4eHhhLmtvLg0KPiANCj4gSSB3b25kZXIsIHdoYXQg
aXMgdGhlIGdvYWw/IFRvIHB1dCB0aGUgY29kZSBpbiBzZXBhcmF0ZSBrZXJuZWwNCj4gbW9kdWxl
cywgb3IganVzdCBzZXBhcmF0ZSBmaWxlcz8NCg0KSSB3b3VsZCBsaWtlIHRvIHJlZHVjZSBydW50
aW1lIG1lbW9yeS4gQXMgSSBhc2tlZCwgaG93IG1hbnkgSVFLIGNvZGUgYXJlIGRpZmZlcmVudA0K
ZnJvbSB0aGVtPyBJZiB5b3UgaGF2ZSBzZXBhcmF0ZWQgYW5kIGNvbXBpbGVkIHRoZW0sIGNhbiB5
b3Ugc2hhcmUgc2l6ZSBieSB0aGUNCm91dHB1dCBvZiAnc2l6ZScgY29tbWFuZD8gDQoNCj4gDQo+
IEkgdGhpbmsgd2UgY2FuIGhhdmUgcnR3ODh4eGEuYyAoY29tbW9uIGNvZGUpLCBydHc4ODIxYS5j
IChJUUsgY29kZSwNCj4gcnR3ODgyMWFfaHdfc3BlYywgYmx1ZXRvb3RoIHN0dWZmKSwgYW5kIHJ0
dzg4MTJhLmMgKElRSyBjb2RlLA0KPiBydHc4ODEyYV9od19zcGVjLCBzb21lIGVmdXNlIHN0dWZm
LCBjaGFubmVsIHN3aXRjaGluZykuLi4gaWYgdGhlc2UNCj4gdGhyZWUgZmlsZXMgY29tcGlsZSBp
bnRvIGEgc2luZ2xlIG1vZHVsZSwgcnR3ODhfODh4eGEua28uDQo+IA0KPiBJZiBlYWNoIGZpbGUg
Y29tcGlsZXMgaW50byBhIG1vZHVsZSBvZiBpdHMgb3duLCB3ZSBoYXZlIGNpcmN1bGFyDQo+IGRl
cGVuZGVuY2llczogcnR3ODgyMWFfaHdfc3BlYyAtPiBjb21tb24gY29kZSAtPiBJUUsgY29kZS4N
Cj4gSWYgKl9od19zcGVjIGdvIGluIHRoZSBjb21tb24gbW9kdWxlLCBpdCBzdGlsbCBkZXBlbmRz
IG9uIGJvdGggb2YNCj4gdGhlIG90aGVyIHR3byBtb2R1bGVzLCBzbyB3aGF0IHVzZSBpcyBpdD8N
Cg0KSWYgd2UgaGF2ZSBkZXBlbmRlbmN5IG9mIGNvbW1vbiBjb2RlIC0+IElRSyBjb2RlLCB3ZSBj
YW4ndCBzYXZlIHJ1bnRpbWUNCm1lbW9yeSwgYmVjYXVzZSBjb21tb24gY29kZSByZWZlcmVuY2Ug
dG8gYm90aCBJUUsgY29kZS4gU28gSSBmZWx0DQpkZXBlbmRlbmN5IG9mIElRSyBjb2RlIHdvdWxk
IGJlIHJ0dzg4MTJhdSAtLT4gSVFLIGNvZGUgYXMgYWJvdmUgc2Vjb25kDQpkaWFncmFtLiANCg0K
QnV0IGlmIHRoZSB3b3JrIGlzIGNvbXBsaWNhdGVkIGFuZCBzYXZlIG5vdCBmZXcgcnVudGltZSBt
ZW1vcnksIHdlIGNhbg0KdXNlIHNpbXBsZSBkZXNpZ24gYXMgY3VycmVudCBkaWQuIA0KDQoNCg==

