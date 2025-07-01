Return-Path: <linux-wireless+bounces-24702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F4FAEEC6A
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 04:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F75D189BEF4
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 02:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F782E406;
	Tue,  1 Jul 2025 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="idm8Ny6u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758812B71
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751336496; cv=none; b=CkKelYASzyqu9PiICjLHVikNHZa94PGEh+gqBBD1yWRGEpe81+HrUFQVq/1Bg6ceFt40y8BOVCJnLpAlDtnwKMgJMTiZm4RQEaGThEboWddtSWeMFmbqdPZoo5bosoA++u0vpClC9cZjdxt9WDoTsv6V5GlP0RdNo837v3jhflI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751336496; c=relaxed/simple;
	bh=qnHusnkT3GRgAHpAi9aP6huU8HFxpQtUhqxTNCwGHCA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GfmGHqqsEkR7xJPayheEYTFvJAI1J46KREdHsDOqrPC9JwpdHupmzj4TYrtkT0PytRqPruNkiwjmzl/PLMSccTUpZds30gf2GsnWNSorTO1wpt8NY1eRt/O8e23cHllpAlH8PO+zQBQ/lhUnzNTfVCTHJozojh7/A25xp2pUEXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=idm8Ny6u; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5612LTC702109315, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751336489; bh=qnHusnkT3GRgAHpAi9aP6huU8HFxpQtUhqxTNCwGHCA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=idm8Ny6um0LOTQVIopZRBtO5vX7Htfb+C+QGxG8WGEjivfzSvh52h75w2E6nrB9kZ
	 ZgMAyik2TqCMqMWNsZ3iua21LWpe5XptKxYdftlN0pheITQ2DkUJopJ4I7aofCIAPE
	 /LVy+nEpnpz1E4PQGxNJ0HAR+DgfJghMloTqCnpuavIX1VVGg5g0bSgYvwKksS0pJ8
	 hK4hAPO5gnILO4F/MMwWH9IDZfcdRoSjSJ6hBe6cK8sBmRVzsTw/CLhDB3IWT+lviq
	 FEmguhq6kYNPiT0Cy+uBuAiAarxpRr2ziPr78EHpzrq/zpFCleg/Q6YeLhTpunCLmk
	 KM19JNYLwEKYA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5612LTC702109315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Jul 2025 10:21:29 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Jul 2025 10:21:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 1 Jul 2025 10:21:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 1 Jul 2025 10:21:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v4 12/14] wifi: rtw89: Add usb.{c,h}
Thread-Topic: [PATCH rtw-next v4 12/14] wifi: rtw89: Add usb.{c,h}
Thread-Index: AQHb6gAvPsOGWr2aeU2zbM/hzKPPMbQch9Og
Date: Tue, 1 Jul 2025 02:21:50 +0000
Message-ID: <bebb3b4c59ae45ee8e30e92c95680b86@realtek.com>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
 <f9ad1664-2d63-4a8f-88bf-c7b7bececbfe@gmail.com>
In-Reply-To: <f9ad1664-2d63-4a8f-88bf-c7b7bececbfe@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBZGQg
YmFzaWMgVVNCIHN1cHBvcnQuIE5vIFRYL1JYIGFnZ3JlZ2F0aW9uLCBubyBzd2l0Y2hpbmcgdG8g
VVNCIDMgbW9kZS4NCj4gDQo+IFJUTDg4NTFCVSBhbmQgUlRMODgzMkJVIHdvcmsuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4N
Cg0KU2luY2UgdjMgaXMgZ29vZCB0byBtZSwgSSBqdXN0IGNoZWNrZWQgdGhlIGRpZmZlcmVuY2Ug
YmV0d2VlbiB2MyBhbmQgdjQsIGFuZA0KaXQgbG9va3MgZ29vZCBhcyB3ZWxsLiBTbw0KDQpBY2tl
ZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+IHYyOg0K
PiAgLSBEb24ndCBkbyB2ZW5kb3IgcmVxdWVzdHMgd2hlbiB1bnBsdWdnZWQuDQo+ICAtIFJlbmFt
ZSBydHc4OV9nZXRfdXNiX3ByaXYoKSB0byBydHc4OV91c2JfcHJpdigpLg0KPiAgLSBNb3ZlIHJ0
dzg5X3VzYl9yZWFkX3BvcnRfY29tcGxldGUoKSBmb3J3YXJkIGRlY2xhcmF0aW9uIHRvIHRoZSB0
b3ANCj4gICAgb2YgdXNiLmMuDQo+ICAtIFJlbW92ZSB1bm5lY2Vzc2FyeSBlbXB0eSBsaW5lcy4N
Cj4gIC0gUmVuYW1lICJlcnJvciIgdmFyaWFibGUgdG8gInJldCIuDQo+ICAtIERvbid0IGNhbGwg
dXNiX2tpbGxfdXJiKCkgaW4gcnR3ODlfdXNiX2ZyZWVfcnhfYnVmcygpLg0KPiAgLSBVc2UgdTMy
X2dldF9iaXRzKCkgaW4gcnR3ODlfdXNiX3ZlbmRvcnJlcSgpLg0KPiAgLSBJbml0aWFsaXNlIHJ0
d2Rldi0+aGNpLmRsZV90eXBlLg0KPiAgLSBEZWxldGUgdmVuZG9yX3JlcV9tdXRleC4NCj4gDQo+
IHYzOg0KPiAgLSBBdm9pZCBza2Jfb3Zlcl9wYW5pYyBpbiBydHc4OV91c2JfZndjbWRfc3VibWl0
KCkgd2hlbiB0aGUgc2l6ZSBpcw0KPiAgICBhIG11bHRpcGxlIG9mIDUxMi4gV2UgY2FuJ3QganVz
dCBleHRlbmQgdGhlIHNrYiBieSA0IGJ5dGVzLCBpdCBoYXMNCj4gICAgdG8gYmUgY29waWVkLiBU
aGlzIHdhcyB0cmlnZ2VyZWQgYnkgdGhlIGhhcmR3YXJlIHNjYW4gb2ZmbG9hZCBmZWF0dXJlDQo+
ICAgIGluIHRoZSAiMDAiIHJlZ3VsYXRvcnkgZG9tYWluLg0KPiAgLSBDb252ZXJ0IHRoZSB3YXJu
aW5nIGluIHJ0dzg5X3VzYl9md2NtZF9zdWJtaXQoKSBpbnRvIGEgZGVidWcgbWVzc2FnZS4NCj4g
IC0gRGVsZXRlIGVtcHR5IGxpbmUgaW4gcnR3ODlfdXNiX2Z3Y21kX3N1Ym1pdCgpLg0KPiAgLSBS
ZXNjaGVkdWxlIHJ4X3dvcmsgd2hlbiBydHc4OV91c2JfcnhfaGFuZGxlcigpIGZpbmRzIG1vcmUg
dGhhbiAyMDANCj4gICAgZnJhbWVzIGluIHRoZSBxdWV1ZS4NCj4gIC0gVXNlIHNpemVvZigqcnR3
dXNiLT52ZW5kb3JfcmVxX2J1ZikgaW5zdGVhZCBvZiBzaXplb2YodTMyKSBpbg0KPiAgICBydHc4
OV91c2JfaW50Zl9pbml0KCkuDQo+IA0KPiB2NDoNCj4gIC0gSW1wbGVtZW50IFRYIHF1ZXVlcyBi
ZWNhdXNlIG90aGVyIHBhcnRzIG9mIHJ0dzg5IGV4cGVjdA0KPiAgICBydHc4OV91c2Jfb3BzX3R4
X3dyaXRlKCkgdG8ganVzdCBwdXQgYSBmcmFtZSBpbiBhIHF1ZXVlIGFuZA0KPiAgICBydHc4OV91
c2Jfb3BzX3R4X2tpY2tfb2ZmKCkgdG8gYWN0dWFsbHkgdHJhbnNtaXQuDQo+ICAtIE1lcmdlIHJ0
dzg5X3VzYl93cml0ZV9wb3J0X2NvbXBsZXRlX2Z3Y21kKCkgaW50bw0KPiAgICBydHc4OV91c2Jf
d3JpdGVfcG9ydF9jb21wbGV0ZSgpIGJlY2F1c2UgdGhleSB3ZXJlIHZlcnkgc2ltaWxhci4gQWRk
DQo+ICAgIHR4Y2ggbWVtYmVyIHRvIHN0cnVjdCBydHc4OV91c2JfdHhfY3RybF9ibG9jayBmb3Ig
dGhpcyBwdXJwb3NlLg0KPiAgLSBSZWFsbHkgY29udmVydCB0aGF0ICJhdm9pZGluZyBtdWx0aXBs
ZSBvZiA1MTIiIHdhcm5pbmcgaW50byBhIGRlYnVnDQo+ICAgIG1lc3NhZ2UuIEl0IHdhcyBzdXBw
b3NlZCB0byBiZSBkb25lIGluIHYzIGJ1dCBpdCBkaWRuJ3QgaGFwcGVuLg0KDQpJZiBjdXJyZW50
IHZlcnNpb24gaXMgd29ya2FibGUgZm9yIHVzZXJzLCBJJ2QgdGFrZSB0aGlzIHZlcnNpb24sIGFu
ZA0KdGhlbiB3ZSBjYW4gaW1wcm92ZSBpdCBpbiBzZXBhcmF0ZWQgcGF0Y2hlcy4gQWRkaW5nIG1v
cmUgYW5kIG1vcmUgc3R1ZmZzDQppbnRvIHRoaXMgKHF1aXRlIGJpZykgcGF0Y2ggaXMgbm90IGEg
Z29vZCBpZGVhIHRvIHJldmlldyBhbmQgbWFpbnRhaW4uDQoNCihJIGtuZXcgY2hhbmdlcyBvZiB2
NCBpcyBuZWNlc3NhcnkuKQ0KDQo=

