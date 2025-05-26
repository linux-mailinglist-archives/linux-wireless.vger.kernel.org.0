Return-Path: <linux-wireless+bounces-23403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF916AC3830
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 05:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503B318923EF
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 03:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7D2846C;
	Mon, 26 May 2025 03:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XQK9rFw1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29EC2DCBF0
	for <linux-wireless@vger.kernel.org>; Mon, 26 May 2025 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748229546; cv=none; b=bvpvjgPXP0QTp793YT+u70/fXvL3JhYBmwAQj9FhYidD6ujS/dPScdU/fWngNB0ec39ZpLG1v3J1CUjZpwprOID7mHimza1qu30p5twifaKicb0gUf/NZ4B3Y/rpMxsgZaBlbBB4504RXAIQEApASyUTdIL+5Ih0c8Mko6zlQyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748229546; c=relaxed/simple;
	bh=5DFwbes61Ns3FmqTW2MvJVG20c185LIIDfCQIy+R10U=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gRxEjLeflhDkTOg/HgCeP40JnqlWS71vukb4KaIn7lMa/3NNKY7uTqDDJyOUhcSrhfCH2znVeG1eka+R9MDOf9oCz3yS08smGz2gf6vA9SgoJLRkucMVsexTC/a720pryOCOYVt5tU4cr6PRUQAf4DTylkfvDWle1rvVxTK/obA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XQK9rFw1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54Q3IxGsA3050428, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1748229539; bh=5DFwbes61Ns3FmqTW2MvJVG20c185LIIDfCQIy+R10U=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=XQK9rFw19npjBTnz3AuTmlj67qzuYDPs8lq0kJQLaFHxTkYgQEP3A7729ve3u4W/V
	 4gXUED0gisiCEqCgrF0vB1//gNXj9s/4jxlNNkXfewi2bFvJyPDEYTODvfUEuW15Nv
	 xqL5HeQWhGF5au+6XDuFOBn5nzc7IkOCNj4T+j6qRsIf3HFITZSfv7cSBojVkOX5Te
	 XmroXO28jxVd04OqtkNaQvczQ5VDdzCsKKE8MtcfohCBkV8UvweHl7dls4zsBQEpkl
	 x32eQ0Z4m0Y89JPd1OEkYDFq2Aq2eqvKTMqK9KUC0ZsDsQ9gft0TuGv+P41OZiXZ6R
	 /vlZ/DkFuYFYQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54Q3IxGsA3050428
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 11:18:59 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 May 2025 11:18:59 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 May 2025 11:18:59 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Mon, 26 May 2025 11:18:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 11/13] wifi: rtw89: Add usb.{c,h}
Thread-Topic: [PATCH rtw-next v1 11/13] wifi: rtw89: Add usb.{c,h}
Thread-Index: AQHbvTayQpeWS10Yc0a60fye0aPa/7PQAaLAgBN/foCAANcUYA==
Date: Mon, 26 May 2025 03:18:59 +0000
Message-ID: <5d96c9b2693143f7914dca322e518435@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <9a3d63a2-2a8f-4f1d-a9cb-b79c255c1a51@gmail.com>
 <60b78caaf3c049a1a5595bb89d553777@realtek.com>
 <f9f205bb-9084-42c0-9942-533d2787fd13@gmail.com>
In-Reply-To: <f9f205bb-9084-42c0-9942-533d2787fd13@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
My8wNS8yMDI1IDA5OjEyLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBBZGQgdmVyeSBiYXNpYyBV
U0Igc3VwcG9ydC4gTm8gVFgvUlggYWdncmVnYXRpb24sIG5vIFRYIHF1ZXVlcywgbm8NCj4gPj4g
c3dpdGNoaW5nIHRvIFVTQiAzIG1vZGUuDQo+ID4+DQo+ID4+IFJUTDg4NTFCVSBhbmQgUlRMODgz
MkJVIHdvcmsuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0
bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiA+PiAtLS0NCj4gPj4gIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnR3ODkvdXNiLmMgfCAxMDMwICsrKysrKysrKysrKysrKysrKysrKysNCj4g
Pj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvdXNiLmggfCAgIDYxICsrDQo+
ID4+ICAyIGZpbGVzIGNoYW5nZWQsIDEwOTEgaW5zZXJ0aW9ucygrKQ0KPiA+PiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvdXNiLmMNCj4gPj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3Vz
Yi5oDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg5L3VzYi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS91c2IuYw0K
PiA+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjZlOGE1
NDRiMzUyYw0KPiA+PiAtLS0gL2Rldi9udWxsDQo+ID4+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnR3ODkvdXNiLmMNCj4gPj4gQEAgLTAsMCArMSwxMDMwIEBADQo+ID4+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCBPUiBCU0QtMy1DbGF1c2UNCj4gPj4g
Ky8qIENvcHlyaWdodChjKSAyMDI1ICBSZWFsdGVrIENvcnBvcmF0aW9uDQo+ID4+ICsgKi8NCj4g
Pj4gKw0KPiA+PiArI2luY2x1ZGUgPGxpbnV4L3VzYi5oPg0KPiA+PiArI2luY2x1ZGUgImRlYnVn
LmgiDQo+ID4+ICsjaW5jbHVkZSAibWFjLmgiDQo+ID4+ICsjaW5jbHVkZSAicmVnLmgiDQo+ID4+
ICsjaW5jbHVkZSAidHhyeC5oIg0KPiA+PiArI2luY2x1ZGUgInVzYi5oIg0KPiA+PiArDQo+ID4+
ICtzdGF0aWMgdm9pZCBydHc4OV91c2JfdmVuZG9ycmVxKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2Rl
diwgdTMyIGFkZHIsDQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAq
ZGF0YSwgdTE2IGxlbiwgdTggcmVxdHlwZSkNCj4gPj4gK3sNCj4gPj4gKyAgICAgICBzdHJ1Y3Qg
cnR3ODlfdXNiICpydHd1c2IgPSBydHc4OV9nZXRfdXNiX3ByaXYocnR3ZGV2KTsNCj4gPj4gKyAg
ICAgICBzdHJ1Y3QgdXNiX2RldmljZSAqdWRldiA9IHJ0d3VzYi0+dWRldjsNCj4gPj4gKyAgICAg
ICB1bnNpZ25lZCBpbnQgcGlwZTsNCj4gPj4gKyAgICAgICB1MTYgdmFsdWUsIGluZGV4Ow0KPiA+
PiArICAgICAgIGludCBhdHRlbXB0LCByZXQ7DQo+ID4+ICsNCj4gPj4gKyAgICAgICB2YWx1ZSA9
IGFkZHIgJiAweDAwMDBmZmZmOw0KPiA+PiArICAgICAgIGluZGV4ID0gKGFkZHIgJiAweDAwZmYw
MDAwKSA+PiAxNjsNCj4gPg0KPiA+IHUxNl9nZXRfYml0cyhhZGRyLCBHRU5NQVNLKDIzLCAxNikp
ID8NCj4gPg0KPiA+DQo+ID4+ICsNCj4gPj4gKyAgICAgICBtdXRleF9sb2NrKCZydHd1c2ItPnZl
bmRvcl9yZXFfbXV0ZXgpOw0KPiA+DQo+ID4gcnR3ODkgdGFrZXMgd2lwaHlfbG9jayBmb3IgY29u
dHJvbCBwYXRoLiBJcyB0aGVyZSBhbnkgY2FzZSBtb3JlIHRoYW4NCj4gPiBvbmUgdGhyZWFkcyBy
dW4gYXQgdGhlIHNhbWUgdGltZT8NCj4gPg0KPiANCj4gTWF5YmUgbm90LiBJIGp1c3QgY29waWVk
IHRoaXMgZnJvbSB0aGUgdmVuZG9yIGRyaXZlci4gSG93IGNhbiBJIGJlDQo+IHN1cmUgb25seSBv
bmUgdGhyZWFkIHJ1bnM/DQoNCkZvciBydHc4OSwgY3VycmVudGx5IGFsbCBpZWVlODAyMTFfb3Bz
IHRha2Ugd2lwaHlfbG9jayBleGNlcHQgdG8gVFggcmVsYXRlZA0Kb3BzLiBUaGUgd29ya3MgZm9y
a2VkIGJ5IHJ0dzg5IHVzZSB3aXBoeSB3b3JrcyBiYXNpY2FsbHkuIFNvbWUgd29ya3Mgc3RpbGwg
DQp1c2UgaWVlZTgwMjExIHdvcmtzIG9ubHkgaWYgdGhleSBvbmx5IHNldCBhIHNpbXBsZSBmbGFn
cyBvciBzby4gDQoNCkhlcmUsIEkgd291bGQgbGlrZSB0byBhdm9pZCBhZGRpbmcgdW5uZWNlc3Nh
cnkgbXV0ZXggYXQgZGV2ZWxvcG1lbnQgc3RhZ2UsDQpiZWNhdXNlIGl0IGlzIGhhcmQgdG8gcmVt
b3ZlIGEgbXV0ZXggd2l0aCBzaW1wbGUgcmV2aWV3LiBZb3UgY2FuIHNlZSBvbmx5IA0Kb25lIGV4
aXN0aW5nIG11dGV4IGlzICdzdHJ1Y3QgbXV0ZXggcmZfbXV0ZXgnLiBJIHdhbnQgdG8gcmVtb3Zl
IGl0LCBidXQNCkknbSBzdGlsbCBhZnJhaWQgdGhhdCBJIG1pc3Mgc29tZXRoaW5nIGJ5IHJldmll
dy4gDQoNCj4gDQo+IEkgYWRkZWQgdGhpcyBhYm92ZSB0aGUgbXV0ZXhfbG9jaygpIHRvZGF5Og0K
PiANCj4gICAgICAgICBpZiAobXV0ZXhfaXNfbG9ja2VkKCZydHd1c2ItPnZlbmRvcl9yZXFfbXV0
ZXgpKQ0KPiAgICAgICAgICAgICAgICAgcHJfZXJyKCJtdXRleCBhbHJlYWR5IGxvY2tlZCBlbHNl
d2hlcmVcbiIpOw0KPiANCj4gU28gZmFyIGl0IGhhc24ndCBwcmludGVkIHRoZSBtZXNzYWdlLg0K
DQpOb3Qgc3VyZSBpZiB0aGlzIGZ1bmN0aW9uIGRlcGVuZHMgb24gbG9jayBkZWJ1Z2dpbmcgb2Yg
a2VybmVsIG9wdGlvbnMuDQoNCkJ5IHRoZSBleHBlcmltZW50cywgdGhpcyBtdXRleCBzZWVtcyB0
byBiZSB1bm5lY2Vzc2FyeSwgcmlnaHQ/DQoNCg0K

