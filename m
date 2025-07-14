Return-Path: <linux-wireless+bounces-25345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE5BB034A1
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 04:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821233AE169
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 02:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6170478F52;
	Mon, 14 Jul 2025 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sWyH2vWz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1B126F0A
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 02:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752461368; cv=none; b=IcaqY4NW5KWmcC3uQC0dRmFE02PMv2Q03PVD+i77CVPH+Fj0mrQ5ObDGokHUU298zv9dqSfB15UdmLkdejMDGr8EE8FHE2aBXr1FduMXSH0L3Fknyl8xrGJpzg4/NEoDebip4I8gV9EmiJ2HViGMg4cWMt+LCGk8pbE2q3tJLno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752461368; c=relaxed/simple;
	bh=JhZDJOBnujftPInIFqAZ8P1NQc7n1Fr0w5as178NEkE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BsDda4Rx6eMC1/4u4dSku5IKWsqwnjlhV2H/AoZXn5bg/Vqnx3EpM/wI7HWlMJE9HS5iFSHuzQM/SaY8++5HW0TWVsUCweBqzlmsQ+z7Wo8/Zi1M6tgYRgOh0WnQVSg56N434Jh7zlB7bYEaPQyZXKaiNj3kzo15xJyoxMPS2f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sWyH2vWz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56E2nJslD1446652, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752461360; bh=JhZDJOBnujftPInIFqAZ8P1NQc7n1Fr0w5as178NEkE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=sWyH2vWzrfZsKgXQrQGUDTVnGZxfpI6muqfhJuhK0I9QNyAEGyr9X5PyzsZ9MUXfG
	 M8HNbmKRg7WYUEQosECXlK/Xgf11qL/K1izG+rFOUveNekR9FppHBHK1aEO3C0GHx/
	 nm6k/1jFHdS2JLSdjFTkQEbAOeov+Dof21gU+UB8AsTLsjSrYeLpNWIaTX8YjygO/I
	 WYP1cx833t1SWhORU/upwAF0gncPyHVhjSFw1dqqgXndmR0Izhch5Xg/6gqyLsKhqS
	 g/gNXZ5kniqyy9FCTrf3oTh30SUcqWkjtIzWZbBf3qEeXjZNIX+e38jlTziz4gYnak
	 vP/xCsXHnA/kA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56E2nJslD1446652
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 10:49:20 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Jul 2025 10:49:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 14 Jul 2025 10:49:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Mon, 14 Jul 2025 10:49:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 1/2] wifi: rtw89: Increase polling delay in rtw89_fw_read_c2h_reg() for USB
Thread-Topic: [PATCH rtw-next 1/2] wifi: rtw89: Increase polling delay in
 rtw89_fw_read_c2h_reg() for USB
Thread-Index: AQHb8mIExRh8regsMUWLQVkqazNfxLQw3ZoQ
Date: Mon, 14 Jul 2025 02:49:18 +0000
Message-ID: <9ce9b78535d74f08927ce2ac9c7731e9@realtek.com>
References: <73f8bdbf-ff7f-4741-a6ea-b1d9026833c3@gmail.com>
In-Reply-To: <73f8bdbf-ff7f-4741-a6ea-b1d9026833c3@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGlz
IHJlYWRfcG9sbF90aW1lb3V0X2F0b21pYygpIHdpdGggYSBkZWxheSBvZiAxIMK1cyBhbmQgYSB0
aW1lb3V0IG9mDQo+IDEwMDAwMDAgwrVzIGNhbiB0YWtlIH4yNTAgc2Vjb25kcyBpbiB0aGUgd29y
c3QgY2FzZSBiZWNhdXNlIHNlbmRpbmcgYQ0KPiBVU0IgY29udHJvbCBtZXNzYWdlIHRha2VzIH4y
NTAgwrVzLg0KDQpJIHdhcyBub3QgYXdhcmUgb2YgdGhlIGNoYW5nZSBvZiBbMV0uIFRoZSBiZWhh
dmlvciBvZiBhdG9taWMgdmVyc2lvbiBiZWNvbWVzDQpkaWZmZXJlbnQgZnJvbSBub24tYXRvbWlj
IHZlcnNpb24uIA0KDQpGb3IgdGhpcyBwYXRjaCwgSSBmZWVsIHdlIGNhbiBrZWVwIGRlbGF5X3Vz
IHRvIDEgYW5kIHRyZWF0IHRpbWVvdXRfdXMgYXMNCidjb3VudCcsIHdoaWNoIFVTQiBkZXZpY2Vz
IGRvIHNtYWxsZXIgcmV0cmllcy4gVGhlIHNtYWxsZXIgZGVsYXlfdXMgY2FuDQpyZWR1Y2UgdG90
YWwgcG9sbGluZyB0aW1lLCBlc3BlY2lhbGx5IGZvciBQQ0lFIGRldmljZXMgKHNlZSBteSBjb21t
ZW50cyBiZWxvdykNCg0KVGhvdWdoIEkgZG9uJ3QgbWVhc3VyZSB0b3RhbCBwb2xsaW5nIHRpbWUg
b2YgcGF0Y2ggMi8yLCBJIGZlZWwgd2UgY2FuIGFwcGx5DQpzaW1pbGFyIGlkZWEuIA0KDQpbMV0g
NzM0OWE2OWNmMzEyICgiaW9wb2xsOiBEbyBub3QgdXNlIHRpbWVrZWVwaW5nIGluIHJlYWRfcG9s
bF90aW1lb3V0X2F0b21pYygpIikNCg0KPiANCj4gSW5jcmVhc2UgdGhlIGRlbGF5IHRvIDI1MCDC
tXMgaW4gb3JkZXIgdG8gcmVkdWNlIHRoZSBtYXhpbXVtIHBvbGxpbmcNCj4gdGltZSB0byB+MiBz
ZWNvbmRzLg0KPiANCj4gVGhpcyBwcm9ibGVtIHdhcyBvYnNlcnZlZCB3aXRoIFJUTDg4NTFCVSB3
aGlsZSBzdXNwZW5kaW5nIHRvIFJBTSB3aXRoDQo+IFdPV0xBTiBlbmFibGVkLiBUaGUgY29tcHV0
ZXIgc2F0IGZvciA0IG1pbnV0ZXMgd2l0aCBhIGJsYWNrIHNjcmVlbg0KPiBiZWZvcmUgc3VzcGVu
ZGluZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJm
ZTJAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODkvZncuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODkvZncuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZncuYw0KPiBp
bmRleCBjNjEzNDMxZTc1NGYuLjI3ZDg0NDY0MzQ3YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnR3ODkvZncuYw0KPiBAQCAtNjY2NSw3ICs2NjY1LDcgQEAgc3RhdGljIGlu
dCBydHc4OV9md19yZWFkX2MyaF9yZWcoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LA0KPiANCj4g
ICAgICAgICBpbmZvLT5pZCA9IFJUVzg5X0ZXQ01EX0MySFJFR19GVU5DX05VTEw7DQo+IA0KPiAt
ICAgICAgIHJldCA9IHJlYWRfcG9sbF90aW1lb3V0X2F0b21pYyhydHc4OV9yZWFkOCwgdmFsLCB2
YWwsIDEsDQo+ICsgICAgICAgcmV0ID0gcmVhZF9wb2xsX3RpbWVvdXRfYXRvbWljKHJ0dzg5X3Jl
YWQ4LCB2YWwsIHZhbCwgMjUwLA0KDQpBcyBteSBleHBlcmltZW50cywgUENJRSBkZXZpY2VzIHRh
a2UgYWJvdXQgMzB1cyBmb3IgdGhpcyBwb2xsaW5nLCB3aGVuDQpzZXR0aW5nIGRlbGF5IDEuIEJ1
dCBpdCB3aWxsIHRha2UgMjU2dXMsIGlmIGRlbGF5IGlzIGNoYW5nZWQgdG8gMjUwLg0KSSBmZWVs
IHdlIG5lZWQgdG8gc2V0IHRoaXMgdmFsdWUgYnkgSENJIHR5cGUgaWYgbmVlZGVkLg0KDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJUVzg5X0MySF9USU1FT1VULCBm
YWxzZSwgcnR3ZGV2LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
aGlwLT5jMmhfY3RybF9yZWcpOw0KPiAgICAgICAgIGlmIChyZXQpIHsNCj4gLS0NCj4gMi41MC4w
DQoNCg==

