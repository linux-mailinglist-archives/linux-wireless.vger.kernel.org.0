Return-Path: <linux-wireless+bounces-23399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B09CAC37D2
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 03:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500B83A14FF
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 01:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C2D3594B;
	Mon, 26 May 2025 01:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="tRG7T9o8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA05FC0E
	for <linux-wireless@vger.kernel.org>; Mon, 26 May 2025 01:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748224288; cv=none; b=VkIAg9zTOi2WXqCTgDZ0CCvJSpRGPz8p7JmL0MnwbG4DSf7JUw1rAmi6uwLccKjQWWHQRRitF6SoggtRSBIx9Vh4As5NG/dD6Cl1A9P9NWSsqqJ+BNHkIOjDUyEVgQVy9/iJZBIto+SYAx+3tTDTY+yM9OzjpryBGb2/BrclZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748224288; c=relaxed/simple;
	bh=fioRHzKgRzTQ+UMSyB8QmbOvCBpCWVh5xU+FBh6vDn0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JcIXZ+HBVT8QLG5ZVRpljdXlMAkgJOp4uPqsh+9leucfwGVgewAeZmnBG+u8axeZulvHQMqWUtS737sVobq909Q1hcuCOfAPY5TQi0HCM1bpcmPe/g1uSgl3irE/3Khs3zDwVSsCqPxsHe9rJ1vYwaOHUCoq9pA3/2t5zhpmDVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=tRG7T9o8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54Q1pJLE12854632, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1748224279; bh=fioRHzKgRzTQ+UMSyB8QmbOvCBpCWVh5xU+FBh6vDn0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=tRG7T9o8o0GEvFQcNhx1MRbcGhgv2kont9XSXXrioZ5MxCDh/7SPknrEoxQVqnwrI
	 M9gstHw5gAL5c3/huZcj8vceRz+JyK0AL+Zar6fKmLe/2IT1jash8IwYUj54zMDlW7
	 /Ac3M7PCx3e4XMpU5lrGe+Jv6nJ6jJaHyR8NyW1cqSTPoM6A1vNA063ef6YqTVns3F
	 hGPBKmltNFvUPOgnsAfpX8GKVuAeMsGBdLmXFKKjzFhXHsAr3kZCJAZ6xYlWLhG6uP
	 90mFZNYXMDmPFpNJsbKMMiHHxVaEgMZdQd+tds6nciMp7VfmCA5iVUCHH7qDoFhCpo
	 vtwvA3pyKXJAA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54Q1pJLE12854632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 09:51:19 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 May 2025 09:51:20 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 May 2025 09:51:20 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Mon, 26 May 2025 09:51:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 05/13] wifi: rtw89: Add hfc_param_ini_usb
Thread-Topic: [PATCH rtw-next v1 05/13] wifi: rtw89: Add hfc_param_ini_usb
Thread-Index: AQHbvTZDNKnS9J5ShUCIArSJPri3ObPP7fyggBOQ6gCAAMQpYA==
Date: Mon, 26 May 2025 01:51:20 +0000
Message-ID: <fc4c3f9b333a49e6bb078e7b1bd67e57@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <348b0c94-2db6-4ae9-819c-6fa7f9c3ac56@gmail.com>
 <54b050dc237e46fcb96576e19451ae97@realtek.com>
 <9c3980f3-c22e-4213-bab3-15d25bdc1b59@gmail.com>
In-Reply-To: <9c3980f3-c22e-4213-bab3-15d25bdc1b59@gmail.com>
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
My8wNS8yMDI1IDA2OjEyLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBBZGQgaGZjX3BhcmFtX2lu
aV91c2IgdG8gc3RydWN0IHJ0dzg5X2NoaXBfaW5mby4gRm9yIG5vdyBpbml0aWFsaXNlIGl0DQo+
ID4+IG9ubHkgZm9yIFJUTDg4NTFCLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJi
bHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gPj4gLS0tDQo+ID4NCj4gPiBb
Li4uXQ0KPiA+DQo+ID4NCj4gPj4gKw0KPiA+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBydHc4OV9o
ZmNfcGFyYW1faW5pIHJ0dzg4NTFiX2hmY19wYXJhbV9pbmlfdXNiW10gPSB7DQo+ID4+ICsgICAg
ICAgW1JUVzg5X1FUQV9TQ0NdID0ge3J0dzg4NTFiX2hmY19jaGNmZ191c2IsICZydHc4ODUxYl9o
ZmNfcHViY2ZnX3VzYiwNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgJnJ0dzg4NTFi
X2hmY19wcmVjY2ZnX3VzYiwgUlRXODlfSENJRkNfU1RGfSwNCj4gPg0KPiA+IFtSVFc4OV9RVEFf
V09XXSBpcyBtaXNzaW5nLiBJJ20gbm90IHN1cmUgaWYgY3VycmVudCBjYW4gaGFuZGxlIHRoaXMg
Y29ycmVjdGx5Lg0KPiA+IENvdWxkIHlvdSB0cnkgdG8gZG8gV29XTEFOIHdpdGggVVNCPyBBdCBs
ZWFzdCwgaXQgc2hvdWxkbid0IGNyYXNoLg0KPiA+DQo+IA0KPiBSVFc4OV9RVEFfV09XIGlzIG1p
c3NpbmcgYmVjYXVzZSBJIGRpZG4ndCBmaW5kIGFuIGVxdWl2YWxlbnQgaW4NCj4gZW51bSBtYWNf
YXhfcXRhX21vZGUgaW4gdGhlIHZlbmRvciBkcml2ZXIuDQoNClllcywgdmVuZG9yIGRyaXZlciBk
b2Vzbid0IGhhdmUgdGhhdC4gQXMgSSBrbm93LCBpdCBkb2VzIHNvbWUgbW9kaWZpY2F0aW9ucw0K
ZnJvbSBvcmlnaW5hbCBub3JtYWwgb3BlcmF0aW9uIHF1b3RhLCBzdWNoIGFzIFJUVzg5X1FUQV9T
Q0MsIGJlY2F1c2Ugd2Ugd2FudA0KY29uc3RhbnQgZGVmaW5pdGlvbiBpbiB1cHN0cmVhbSBkcml2
ZXIuIEkgd2lsbCBjaGVjayBpbnRlcm5hbGx5IGFuZCBnZXQgYmFjaw0KdG8geW91IGhvdyBpdCBz
aG91bGQgYmUgZm9yIFVTQiBkZXZpY2VzLiANCg0KPiANCj4gSSBlbmFibGVkIFdPV0xBTiB3aXRo
IHRoaXMgY29tbWFuZDoNCj4gDQo+IGl3IHBoeTAgd293bGFuIGVuYWJsZSBkaXNjb25uZWN0DQo+
IA0KPiBUaGVuIEkgcHV0IHRoZSBjb21wdXRlciB0byBzbGVlcCAoc3VzcGVuZCB0byBSQU0pLiBU
aGVyZSB3YXMgbm8gY3Jhc2gsDQo+IGp1c3Qgc29tZSBlcnJvciBtZXNzYWdlcy4gVGhlIGNvbXB1
dGVyIHdlbnQgdG8gc2xlZXAgYW5kIHdva2UgdXAgd2l0aG91dA0KPiBhbnkgb3RoZXIgcHJvYmxl
bXMuIE9mIGNvdXJzZSBpdCBkaWRuJ3Qgc3RheSBjb25uZWN0ZWQgdG8gdGhlIGFjY2Vzcw0KPiBw
b2ludCBkdXJpbmcgc2xlZXAuDQo+IA0KPiBNYXkgMjMgMjA6MTk6NDYgaWRlYXBhZDIga2VybmVs
OiBydHc4OV84ODUxYnUgMS0yOjEuMjogcXRhIG1vZGUgdW5tYXRjaCENCj4gTWF5IDIzIDIwOjE5
OjQ3IGlkZWFwYWQyIGtlcm5lbDogcnR3ODlfODg1MWJ1IDEtMjoxLjI6IFtFUlJdZ2V0X2RsZV9t
ZW1fY2ZnDQo+IE1heSAyMyAyMDoxOTo0NyBpZGVhcGFkMiBrZXJuZWw6IHJ0dzg5Xzg4NTFidSAx
LTI6MS4yOiBbRVJSXXBhdGNoIHJ4IHF0YSAtMjINCj4gTWF5IDIzIDIwOjE5OjQ3IGlkZWFwYWQy
IGtlcm5lbDogcnR3ODlfODg1MWJ1IDEtMjoxLjI6IGZhaWxlZCB0byBjb25maWcgbWFjDQo+IE1h
eSAyMyAyMDoxOTo0NyBpZGVhcGFkMiBrZXJuZWw6IHJ0dzg5Xzg4NTFidSAxLTI6MS4yOiB3b3c6
IGZhaWxlZCB0byBlbmFibGUgdHJ4X3Bvc3QNCj4gTWF5IDIzIDIwOjE5OjQ3IGlkZWFwYWQyIGtl
cm5lbDogcnR3ODlfODg1MWJ1IDEtMjoxLjI6IGZhaWxlZCB0byBlbmFibGUgd293DQo+IE1heSAy
MyAyMDoxOTo0NyBpZGVhcGFkMiBrZXJuZWw6IHJ0dzg5Xzg4NTFidSAxLTI6MS4yOiBmYWlsZWQg
dG8gc3VzcGVuZCBmb3Igd293IC0yMg0KPiANCj4gVGhhdCB3YXMgd2l0aG91dCBSVFc4OV9RVEFf
V09XLg0KPiANCj4gVGhlbiBJIHRyaWVkIHRvIGNvcHkgUlRXODlfUVRBX1NDQyBpbiBydHc4ODUx
Yl9oZmNfcGFyYW1faW5pX3VzYiBhbmQNCj4gcnR3ODg1MWJfZGxlX21lbV91c2IyLiBXaXRoIHRo
YXQgSSB0aGluayBpdCB3YXMgYWJsZSB0byB1cGxvYWQgdGhlIFdPVw0KPiBmaXJtd2FyZSBhbmQg
aXQgc3RheWVkIGNvbm5lY3RlZCB0byB0aGUgYWNjZXNzIHBvaW50LCBidXQgc29tZXRoaW5nDQo+
IGRpZG4ndCBsZXQgdGhlIGNvbXB1dGVyIGdvIHRvIHNsZWVwLiBJdCBzYXQgdGhlcmUgZm9yIHNl
dmVyYWwgbWludXRlcw0KPiB3aXRoIGEgYmxhY2sgc2NyZWVuLCB0aGUgcG93ZXIgTEVEIG9uLCBh
bmQgY29ubmVjdGVkIHRvIHRoZSBhY2Nlc3MNCj4gcG9pbnQgKGJ1dCB3aXRob3V0IGFuIElQIGFk
ZHJlc3MpLCB1bnRpbCBJIGNsaWNrZWQgdGhlICJEaXNjb25uZWN0Ig0KPiBidXR0b24gaW4gdGhl
IGFjY2VzcyBwb2ludCdzIHdlYiBpbnRlcmZhY2UgdG8gZGlzY29ubmVjdCB0aGlzIHN0YXRpb24u
DQo+IFRoYXQncyB3aGVuIHRoZSBjb21wdXRlciBmaW5hbGx5IHdlbnQgdG8gc2xlZXAuDQo+IA0K
PiBTbyBXT1dMQU4gd2l0aCBSVEw4ODUxQlUgbmVlZHMgbW9yZSB3b3JrLg0KDQpUaGFua3MgZm9y
IHRoZSB0ZXN0LiBJJ2QgYXNrIGludGVybmFsIGV4cGVydHMgaWYgVVNCIGRldmljZXMgY2FuIHN1
cHBvcnQNCldvVyBhbHJlYWR5LiBCdXQsIEkgZ3Vlc3MgdGhlIGFuc3dlciBpcyB5ZXMuIEhhdmUg
eW91IHRlc3RlZCBXb1cgd2l0aA0KdmVuZG9yIGRyaXZlcj8gDQoNCg0K

