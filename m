Return-Path: <linux-wireless+bounces-15701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BD19D8FE1
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 02:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518D3168DBA
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 01:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D268101DE;
	Tue, 26 Nov 2024 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="o9SLPyIs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39228D26D
	for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732584398; cv=none; b=BAQsHA0eus075gPZqClk9EsUREmMAZLrAwWiMhcQCY14lmGol68BpWqC5mABHKHbg3uPNsEkH2SvChENTngCeJFC7YRHdi91TxoiUFjRHTGsVgaZabmfIbW3JfvKhdoATxHtOaIuhjKwKyDr+ERcD1PtnpmFI/VE2YmR9gr/iPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732584398; c=relaxed/simple;
	bh=UbDtntgSevUtVdIVIPskxN2rctY5X/eYDeVURz2yyU8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A5qZsUZoDu0NIt4mNQ11/JMhbDsRKVJiqHOzzMegfCb2oWOQaxj/hSka10SDkpoDkx1cCzMGPxB2ZhbuqHh+yJED3Nxf8ignTL6ZlWo3H2P/qIs6w4guxYwU93SfSdmfMg9tfUEsGWNL7MwG6Y8IyRVcxZ1WdxebBy1NI40BDNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=o9SLPyIs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AQ1QR2x8206392, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732584387; bh=UbDtntgSevUtVdIVIPskxN2rctY5X/eYDeVURz2yyU8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=o9SLPyIsmq1n56x9EZFyCpMit+GLEt9O/YH4IlljDULeL1bNMu+icGTJDXQARjO3j
	 htNPAkBn4u0vIeCQcxnh+EG1elhaf9KN1PeTvIitzoMmxl0ZJCC3K8lEEpTDF6tCM7
	 TPjjjrUxnPkoli/XgqZZsDsEyA7Kih0vT96VAXYKLNWzt2m4zq9NYehxudCRN0BGcF
	 DloD6/6Yzf+BT+pChp7lZMfLxQyfWiklPEk/uRr9L5CLytZhDlgO+g9uMHa/IN9Wx4
	 fONNcf4nXNLXyX4sBBeBLboztXg+1eDFT4RQc5UwXiCoYzsIeP8GI0JJAjv0uip7Fj
	 ab7n2FV0+i0tg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AQ1QR2x8206392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 09:26:27 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 09:26:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Nov 2024 09:26:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 26 Nov 2024 09:26:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH 2/2] wifi: rtw88: usb: Preallocate and reuse the RX skbs
Thread-Topic: [PATCH 2/2] wifi: rtw88: usb: Preallocate and reuse the RX skbs
Thread-Index: AQHbNuoNEfF0t/4FMkGEgXvFb6QbxLK8ywXwgAtqaYCAAJ6jcA==
Date: Tue, 26 Nov 2024 01:26:26 +0000
Message-ID: <e467e5003335418cab2f90807ce07b7a@realtek.com>
References: <28b09f4d-5271-470d-99b6-a0bbe0224739@gmail.com>
 <4e83ae71-60e2-4f24-a251-18cd59543d6d@gmail.com>
 <3a9104bb97db4df6a285e94291fd84c7@realtek.com>
 <1546573d-ce4d-4629-8d05-925fff079493@gmail.com>
In-Reply-To: <1546573d-ce4d-4629-8d05-925fff079493@gmail.com>
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
OS8xMS8yMDI0IDAyOjUwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBUaGUgVVNCIGRyaXZlciB1
c2VzIGZvdXIgVVNCIFJlcXVlc3QgQmxvY2tzIGZvciBSWC4gQmVmb3JlIHN1Ym1pdHRpbmcNCj4g
Pj4gb25lLCBpdCBhbGxvY2F0ZXMgYSAzMjc2OCBieXRlIHNrYiBmb3IgdGhlIFJYIGRhdGEuIFRo
aXMgYWxsb2NhdGlvbiBjYW4NCj4gPj4gZmFpbCwgbWF5YmUgZHVlIHRvIHRlbXBvcmFyeSBtZW1v
cnkgZnJhZ21lbnRhdGlvbi4gV2hlbiB0aGUgYWxsb2NhdGlvbg0KPiA+PiBmYWlscywgdGhlIGNv
cnJlc3BvbmRpbmcgVVJCIGlzIG5ldmVyIHN1Ym1pdHRlZCBhZ2Fpbi4gQWZ0ZXIgZm91ciBzdWNo
DQo+ID4+IGFsbG9jYXRpb24gZmFpbHVyZXMsIGFsbCBSWCBzdG9wcyBiZWNhdXNlIHRoZSBkcml2
ZXIgaXMgbm90IHJlcXVlc3RpbmcNCj4gPj4gZGF0YSBmcm9tIHRoZSBkZXZpY2UgYW55bW9yZS4N
Cj4gPj4NCj4gPj4gRG9uJ3QgYWxsb2NhdGUgYSAzMjc2OCBieXRlIHNrYiB3aGVuIHN1Ym1pdHRp
bmcgYSBVU0IgUmVxdWVzdCBCbG9jaw0KPiA+PiAod2hpY2ggaGFwcGVucyB2ZXJ5IG9mdGVuKS4g
SW5zdGVhZCBwcmVhbGxvY2F0ZSA4IHN1Y2ggc2ticywgYW5kIHJldXNlDQo+ID4+IHRoZW0gb3Zl
ciBhbmQgb3Zlci4gSWYgYWxsIDggYXJlIGJ1c3ksIGFsbG9jYXRlIGEgbmV3IG9uZS4gVGhpcyBp
cw0KPiA+PiBwcmV0dHkgcmFyZS4gSWYgdGhlIGFsbG9jYXRpb24gZmFpbHMsIHVzZSBhIHdvcmsg
dG8gdHJ5IGFnYWluIGxhdGVyLg0KPiA+PiBXaGVuIHRoZXJlIGFyZSBlbm91Z2ggZnJlZSBza2Jz
IGFnYWluLCBmcmVlIHRoZSBleGNlc3Mgc2ticy4NCj4gPj4NCj4gPj4gQWxzbywgdXNlIFdRX0JI
IGZvciB0aGUgUlggd29ya3F1ZXVlLiBXaXRoIGEgbm9ybWFsIG9yIGhpZ2ggcHJpb3JpdHkNCj4g
Pj4gd29ya3F1ZXVlIHRoZSBza2JzIGFyZSBwcm9jZXNzZWQgdG9vIHNsb3dseSB3aGVuIHRoZSBz
eXN0ZW0gaXMgZXZlbiBhDQo+ID4+IGxpdHRsZSBidXN5LCBsaWtlIHdoZW4gb3BlbmluZyBhIG5l
dyBwYWdlIGluIGEgYnJvd3NlciwgYW5kIHRoZSBkcml2ZXINCj4gPj4gcnVucyBvdXQgb2YgZnJl
ZSBza2JzIGFuZCBhbGxvY2F0ZXMgYSBsb3Qgb2YgbmV3IG9uZXMuDQo+ID4+DQo+ID4+IE1vdmUg
QzJIX0FEQVBUSVZJVFkgdG8gdGhlIGMyaCB3b3JrcXVldWUgaW5zdGVhZCBvZiBoYW5kbGluZyBp
dCBkaXJlY3RseQ0KPiA+PiBmcm9tIHJ0d19md19jMmhfY21kX3J4X2lycXNhZmUoKSwgd2hpY2gg
cnVucyBpbiB0aGUgUlggd29ya3F1ZXVlLiBJdA0KPiA+PiByZWFkcyBoYXJkd2FyZSByZWdpc3Rl
cnMsIHdoaWNoIGlzIG5vdCAiaXJxc2FmZSIgd2l0aCBVU0IuDQo+ID4NCj4gPiBUaGlzIHBhcnQg
c2hvdWxkIGJlIGluIGEgc2VwYXJhdGVkIHBhdGNoLg0KPiA+DQo+IA0KPiBEbyB5b3UgbWVhbiBq
dXN0IEMySF9BREFQVElWSVRZIG9yIFdRX0JIIGFzIHdlbGw/DQoNCkp1c3QgQzJIX0FEQVBUSVZJ
VFkuDQoNCldpdGggcGF0Y2ggc3ViamVjdCwgcGVvcGxlIGNhbid0IHVuZGVyc3RhbmQgdGhpcyBj
aGFuZ2UuIA0KDQo+IA0KPiA+Pg0KPiA+PiBUaGlzIGlzIG1vcmUgb3IgbGVzcyB3aGF0IHRoZSBv
dXQtb2YtdHJlZSBSZWFsdGVrIGRyaXZlcnMgZG8sIGV4Y2VwdA0KPiA+PiB0aGV5IHVzZSBhIHRh
c2tsZXQgaW5zdGVhZCBvZiBhIEJIIHdvcmtxdWV1ZS4NCj4gPj4NCj4gPj4gVGVzdGVkIHdpdGgg
UlRMODcyM0RVLCBSVEw4ODIxQVUsIFJUTDg4MTJBVSwgUlRMODgxMkJVLCBSVEw4ODIyQ1UsDQo+
ID4+IFJUTDg4MTFDVS4NCj4gPj4NCj4gPj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC13aXJlbGVzcy82ZTdlY2I0Ny03ZWEwLTQzM2EtYTE5Zi0wNWY4OGEyZWRmNmJAZ21h
aWwuY29tLw0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2Vy
ZmUyQGdtYWlsLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg4L2Z3LmMgIHwgIDcgKy0tDQo+ID4+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg4L3VzYi5jIHwgNzMgKysrKysrKysrKysrKysrKysrKystLS0tDQo+ID4+ICBkcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3VzYi5oIHwgIDMgKw0KPiA+PiAgMyBmaWxl
cyBjaGFuZ2VkLCA2NyBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvZncuYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvZncuYw0KPiA+PiBpbmRleCBlNmU5OTQ2
ZmJmNDQuLjAyMzg5YjdjNjg3NiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OC9mdy5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvZncuYw0KPiA+PiBAQCAtMzMyLDYgKzMzMiw5IEBAIHZvaWQgcnR3X2Z3X2My
aF9jbWRfaGFuZGxlKHN0cnVjdCBydHdfZGV2ICpydHdkZXYsIHN0cnVjdCBza19idWZmICpza2Ip
DQo+ID4+ICAgICAgICAgY2FzZSBDMkhfUkFfUlBUOg0KPiA+PiAgICAgICAgICAgICAgICAgcnR3
X2Z3X3JhX3JlcG9ydF9oYW5kbGUocnR3ZGV2LCBjMmgtPnBheWxvYWQsIGxlbik7DQo+ID4+ICAg
ICAgICAgICAgICAgICBicmVhazsNCj4gPj4gKyAgICAgICBjYXNlIEMySF9BREFQVElWSVRZOg0K
PiA+PiArICAgICAgICAgICAgICAgcnR3X2Z3X2FkYXB0aXZpdHlfcmVzdWx0KHJ0d2RldiwgYzJo
LT5wYXlsb2FkLCBsZW4pOw0KPiA+PiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4+ICAgICAg
ICAgZGVmYXVsdDoNCj4gPj4gICAgICAgICAgICAgICAgIHJ0d19kYmcocnR3ZGV2LCBSVFdfREJH
X0ZXLCAiQzJIIDB4JXggaXNuJ3QgaGFuZGxlZFxuIiwgYzJoLT5pZCk7DQo+ID4+ICAgICAgICAg
ICAgICAgICBicmVhazsNCj4gPj4gQEAgLTM2NywxMCArMzcwLDYgQEAgdm9pZCBydHdfZndfYzJo
X2NtZF9yeF9pcnFzYWZlKHN0cnVjdCBydHdfZGV2ICpydHdkZXYsIHUzMiBwa3Rfb2Zmc2V0LA0K
PiA+PiAgICAgICAgICAgICAgICAgcnR3X2Z3X3NjYW5fcmVzdWx0KHJ0d2RldiwgYzJoLT5wYXls
b2FkLCBsZW4pOw0KPiA+PiAgICAgICAgICAgICAgICAgZGV2X2tmcmVlX3NrYl9hbnkoc2tiKTsN
Cj4gPj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+PiAtICAgICAgIGNhc2UgQzJIX0FEQVBU
SVZJVFk6DQo+ID4+IC0gICAgICAgICAgICAgICBydHdfZndfYWRhcHRpdml0eV9yZXN1bHQocnR3
ZGV2LCBjMmgtPnBheWxvYWQsIGxlbik7DQo+ID4+IC0gICAgICAgICAgICAgICBkZXZfa2ZyZWVf
c2tiX2FueShza2IpOw0KPiA+PiAtICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4+ICAgICAgICAg
ZGVmYXVsdDoNCj4gPj4gICAgICAgICAgICAgICAgIC8qIHBhc3Mgb2Zmc2V0IGZvciBmdXJ0aGVy
IG9wZXJhdGlvbiAqLw0KPiA+PiAgICAgICAgICAgICAgICAgKigodTMyICopc2tiLT5jYikgPSBw
a3Rfb2Zmc2V0Ow0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydHc4OC91c2IuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNiLmMN
Cj4gPj4gaW5kZXggNzI3NTY5ZDRlZjRiLi41YzJkZmEyY2VkOTIgMTAwNjQ0DQo+ID4+IC0tLSBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNiLmMNCj4gPj4gKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC91c2IuYw0KPiA+PiBAQCAtNTg1LDcgKzU4
NSw3IEBAIHN0YXRpYyB2b2lkIHJ0d191c2JfcnhfaGFuZGxlcihzdHJ1Y3Qgd29ya19zdHJ1Y3Qg
KndvcmspDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBza2lwX3Bh
Y2tldDsNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+Pg0KPiA+PiAtICAgICAg
ICAgICAgICAgICAgICAgICBza2IgPSBhbGxvY19za2Ioc2tiX2xlbiwgR0ZQX0tFUk5FTCk7DQo+
ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIHNrYiA9IGFsbG9jX3NrYihza2JfbGVuLCBHRlBf
QVRPTUlDKTsNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFza2IpIHsNCj4gPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBydHdfZGJnKHJ0d2RldiwgUlRXX0RCR19V
U0IsDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiZmFpbGVk
IHRvIGFsbG9jYXRlIFJYIHNrYiBvZiBzaXplICV1XG4iLA0KPiA+PiBAQCAtNjEyLDcgKzYxMiwx
MSBAQCBzdGF0aWMgdm9pZCBydHdfdXNiX3J4X2hhbmRsZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3
b3JrKQ0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICByeF9kZXNjICs9IG5leHRfcGt0Ow0K
PiA+PiAgICAgICAgICAgICAgICAgfSB3aGlsZSAocnhfZGVzYyArIHBrdF9kZXNjX3N6IDwgcnhf
c2tiLT5kYXRhICsgcnhfc2tiLT5sZW4pOw0KPiA+Pg0KPiA+PiAtICAgICAgICAgICAgICAgZGV2
X2tmcmVlX3NrYl9hbnkocnhfc2tiKTsNCj4gPj4gKyAgICAgICAgICAgICAgIGlmIChza2JfcXVl
dWVfbGVuKCZydHd1c2ItPnJ4X2ZyZWVfcXVldWUpID49DQo+ID4+ICsgICAgICAgICAgICAgICAg
ICAgUlRXX1VTQl9SWF9TS0JfTlVNIC0gUlRXX1VTQl9SWENCX05VTSkNCj4gPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgZGV2X2tmcmVlX3NrYl9hbnkocnhfc2tiKTsNCj4gPj4gKyAgICAgICAg
ICAgICAgIGVsc2UNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgc2tiX3F1ZXVlX3RhaWwo
JnJ0d3VzYi0+cnhfZnJlZV9xdWV1ZSwgcnhfc2tiKTsNCj4gPg0KPiA+IFdoeSBub3QganVzdCBx
dWV1ZSBhbmQgcmV1c2Ugcnhfc2tiIGZvciBhbGw/IFRoYXQgd291bGQgYmUgc2ltcGxlci4NCj4g
Pg0KPiANCj4gSSBkaWRuJ3Qgd2FudCB0byBsZXQgaXQgYWxsb2NhdGUgdG9vIG1hbnkgc2ticy4g
SSBkaWRuJ3QgZmluZCBhbnkga2luZA0KPiBvZiBsaW1pdCBpbiB0aGUgb2ZmaWNpYWwgZHJpdmVy
cywgc28gbWF5YmUgaXQgd291bGQgYmUgZmluZS4NCg0KVGhlIGNhc2UgJyBza2JfcXVldWVfbGVu
KCZydHd1c2ItPnJ4X2ZyZWVfcXVldWUpID49IDggLSA0JyBpcyByYXJlPyANCklmIHNvLCBJIHRo
aW5rIHRoaXMgaXMgZmluZS4gSWYgbm90LCB0byByZXBlYXRlZGx5IGFsbG9jYXRlIGFuZCBmcmVl
IA0Kd291bGQgY2F1c2UgbWVtb3J5IGZyYWdtZW50LCBhbmQgaGlnaGVyIHByb2JhYmlsaXR5IHRv
IGZhaWxlZCB0byBhbGxvY2F0ZQ0KbWVtb3J5IHdpdGggR0ZQX0FUT01JQy4gQWxzbyBzZWVtaW5n
bHkgYWRkaXRpb25hbCA0IHBlcnNpc3RlbnQgcnhfc2tiDQppcyBub3QgYSBiaWcgY29zdC4gDQoN
Cg0K

