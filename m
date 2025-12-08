Return-Path: <linux-wireless+bounces-29574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D186DCABB31
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 01:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38E143008EB1
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 00:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D27935972;
	Mon,  8 Dec 2025 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="XIh2m6fo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2497404E
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 00:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765154422; cv=none; b=N1Wsq5YE1eq0xnMy3VmMrAt6Bhzpu3zTPc9OKJnmt86DWzfQOCI269t28t8lv6CTCBOMxUbhLy7XgN63/TcyniYx+vVEf1EqY+5RZfs9uzWo6NoNdoMKo59O1SHTsMtuFsLg1jUn8bEbzeWpp+sWAykjFMahWMJjonbpo09E5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765154422; c=relaxed/simple;
	bh=6WTK7DtkDzvm4ZUTDkS6s+rZPbj2G9MHcXIb2UTtJ68=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JCSzO/xG+xc80GfGsbepZF92MLFbpKNMFR9WV0edhEQMxUdxNIftpY7XrG+RhYBOOmokl3bZScTg9tBrZNjGsfPHG1wbNW7vDgmeTMgzPb6VtE8n0Iu7U/Y99L1J0EYUf0J/8rliUzuKb+wJtrlTwax/h0M1hBQCUt1YSoFa9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=XIh2m6fo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5B80eBwX52940959, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765154411; bh=6WTK7DtkDzvm4ZUTDkS6s+rZPbj2G9MHcXIb2UTtJ68=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=XIh2m6foP7TEUOokMppaY/zKQ8AzUkRXcd8Q/zZjwxfdnzP+UoLedADqXWsoQdUK1
	 7c1nM9UTk276FStKt53QRpfwZ0snBM1K4lf97F8l78lPIwCGj+a6SWKAjwgY8ECx7p
	 jiV5I9aI2+b4C2FU/7ay1xWziZVqT2MNPh/H5KpqlgogjkEPoHrbZfoASi2tlByM9q
	 x4daneXTCOqVtaUnF2O3QdmYE58DLWOKJCUEzSu32pHvdb0CNBBaspo/MFSLaMd51z
	 HJZUAcz+XJ2DJKpIqBkSV/kajG/M5hpbw3r6bq8kyuTqGCEutXhlbZIQqwL6k/EV8d
	 0pYilML+ffrLg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5B80eBwX52940959
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 08:40:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 8 Dec 2025 08:40:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 8 Dec 2025 08:40:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::2fa5:eccb:34ee:7bb%10]) with mapi id
 15.02.1544.027; Mon, 8 Dec 2025 08:40:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Marco
 Crivellari" <marco.crivellari@suse.com>
Subject: RE: [PATCH rtw-next] Revert "wifi: rtw88: add WQ_UNBOUND to
 alloc_workqueue users"
Thread-Topic: [PATCH rtw-next] Revert "wifi: rtw88: add WQ_UNBOUND to
 alloc_workqueue users"
Thread-Index: AQHcZt66JkU/0qBLKkWq0rXfVDO7QLUW53QQ
Date: Mon, 8 Dec 2025 00:40:11 +0000
Message-ID: <dcf31afec1614ce0b5e6c6d7f8cd2cb9@realtek.com>
References: <d57efe48-b8ff-4bf1-942c-7e808535eda6@gmail.com>
In-Reply-To: <d57efe48-b8ff-4bf1-942c-7e808535eda6@gmail.com>
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
IHJldmVydHMgY29tbWl0IDljMTk0ZmU0NjI1ZGIxOGY5M2Q1YWJjZmI3Zjc5OTc1NTdhMGIyOWQu
DQo+IA0KPiBUaGlzIGNvbW1pdCBicmVha3MgYWxsIFVTQiB3aWZpIGFkYXB0ZXJzIHN1cHBvcnRl
ZCBieSBydHc4ODoNCj4gDQo+IHVzYiAxLTI6IG5ldyBoaWdoLXNwZWVkIFVTQiBkZXZpY2UgbnVt
YmVyIDYgdXNpbmcgeGhjaV9oY2QNCj4gdXNiIDEtMjogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlk
VmVuZG9yPTIzNTcsIGlkUHJvZHVjdD0wMTM4LCBiY2REZXZpY2U9IDIuMTANCj4gdXNiIDEtMjog
TmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTEsIFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVyPTMN
Cj4gdXNiIDEtMjogUHJvZHVjdDogODAyLjExYWMgTklDDQo+IHVzYiAxLTI6IE1hbnVmYWN0dXJl
cjogUmVhbHRlaw0KPiB1c2IgMS0yOiBTZXJpYWxOdW1iZXI6IDEyMzQ1Ng0KPiAtLS0tLS0tLS0t
LS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4gV0FSTklORzogQ1BVOiAzIFBJRDogMTUyIGF0
IGtlcm5lbC93b3JrcXVldWUuYzo1NjY3IGFsbG9jX3dvcmtxdWV1ZV9ub3Byb2YrMHg2NzYvMHg3
NzANCj4gDQo+IFsuLi5dDQo+IA0KPiBDYWxsIFRyYWNlOg0KPiAgPFRBU0s+DQo+ICA/IHJ0d191
c2JfcHJvYmUrMHgzMGUvMHhhNWMgW3J0dzg4X3VzYiA0YWYzY2I2NGVlZGFmZWVjYmZiMDhmODBj
MWU5ZTI4OTNlMmVlN2E2XQ0KPiAgcnR3X3VzYl9wcm9iZSsweDNlYi8weGE1YyBbcnR3ODhfdXNi
IDRhZjNjYjY0ZWVkYWZlZWNiZmIwOGY4MGMxZTllMjg5M2UyZWU3YTZdDQo+ICB1c2JfcHJvYmVf
aW50ZXJmYWNlKzB4ZGQvMHgyYzANCj4gIHJlYWxseV9wcm9iZSsweGRiLzB4MzQwDQo+ICA/IHBt
X3J1bnRpbWVfYmFycmllcisweDU1LzB4OTANCj4gID8gX19wZnhfX19kZXZpY2VfYXR0YWNoX2Ry
aXZlcisweDEwLzB4MTANCj4gIF9fZHJpdmVyX3Byb2JlX2RldmljZSsweDc4LzB4MTQwDQo+ICBk
cml2ZXJfcHJvYmVfZGV2aWNlKzB4MWYvMHhhMA0KPiAgX19kZXZpY2VfYXR0YWNoX2RyaXZlcisw
eDg5LzB4MTEwDQo+ICBidXNfZm9yX2VhY2hfZHJ2KzB4OGYvMHhlMA0KPiAgX19kZXZpY2VfYXR0
YWNoKzB4YjAvMHgxYzANCj4gIGJ1c19wcm9iZV9kZXZpY2UrMHg5MC8weGEwDQo+ICBkZXZpY2Vf
YWRkKzB4NjYzLzB4ODgwDQo+ICB1c2Jfc2V0X2NvbmZpZ3VyYXRpb24rMHg1YTUvMHg4NzANCj4g
IHVzYl9nZW5lcmljX2RyaXZlcl9wcm9iZSsweDRhLzB4NzANCj4gIHVzYl9wcm9iZV9kZXZpY2Ur
MHgzZC8weDE0MA0KPiAgPyBkcml2ZXJfc3lzZnNfYWRkKzB4NTkvMHhkMA0KPiAgcmVhbGx5X3By
b2JlKzB4ZGIvMHgzNDANCj4gID8gcG1fcnVudGltZV9iYXJyaWVyKzB4NTUvMHg5MA0KPiAgPyBf
X3BmeF9fX2RldmljZV9hdHRhY2hfZHJpdmVyKzB4MTAvMHgxMA0KPiAgX19kcml2ZXJfcHJvYmVf
ZGV2aWNlKzB4NzgvMHgxNDANCj4gIGRyaXZlcl9wcm9iZV9kZXZpY2UrMHgxZi8weGEwDQo+ICBf
X2RldmljZV9hdHRhY2hfZHJpdmVyKzB4ODkvMHgxMTANCj4gIGJ1c19mb3JfZWFjaF9kcnYrMHg4
Zi8weGUwDQo+ICBfX2RldmljZV9hdHRhY2grMHhiMC8weDFjMA0KPiAgYnVzX3Byb2JlX2Rldmlj
ZSsweDkwLzB4YTANCj4gIGRldmljZV9hZGQrMHg2NjMvMHg4ODANCj4gIHVzYl9uZXdfZGV2aWNl
LmNvbGQrMHgxNDEvMHgzYjUNCj4gIGh1Yl9ldmVudCsweDExMzIvMHgxOTAwDQo+ICA/IHBhZ2Vf
Y291bnRlcl91bmNoYXJnZSsweDRhLzB4OTANCj4gIHByb2Nlc3Nfb25lX3dvcmsrMHgxOTAvMHgz
NTANCj4gIHdvcmtlcl90aHJlYWQrMHgyZDcvMHg0MTANCj4gID8gX19wZnhfd29ya2VyX3RocmVh
ZCsweDEwLzB4MTANCj4gIGt0aHJlYWQrMHhmOS8weDI0MA0KPiAgPyBfX3BmeF9rdGhyZWFkKzB4
MTAvMHgxMA0KPiAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMA0KPiAgcmV0X2Zyb21fZm9yaysw
eDFjMS8weDFmMA0KPiAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMA0KPiAgcmV0X2Zyb21fZm9y
a19hc20rMHgxYS8weDMwDQo+ICA8L1RBU0s+DQo+IC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAw
MDAwMDAgXS0tLQ0KPiBydHc4OF84ODIyYnUgMS0yOjEuMDogZmFpbGVkIHRvIGNyZWF0ZSBSWCB3
b3JrIHF1ZXVlDQo+IHJ0dzg4Xzg4MjJidSAxLTI6MS4wOiBmYWlsZWQgdG8gaW5pdCBVU0IgUlgN
Cj4gcnR3ODhfODgyMmJ1IDEtMjoxLjA6IEZpcm13YXJlIHZlcnNpb24gMjcuMi4wLCBIMkMgdmVy
c2lvbiAxMw0KPiBydHc4OF84ODIyYnUgMS0yOjEuMDogcHJvYmUgd2l0aCBkcml2ZXIgcnR3ODhf
ODgyMmJ1IGZhaWxlZCB3aXRoIGVycm9yIC0xMg0KPiANCj4gV1FfVU5CT1VORCBpcyBub3QgY29t
cGF0aWJsZSB3aXRoIFdRX0JILiBDb21tZW50IGluIGVudW0gd3FfZmxhZ3MgaW4NCj4gd29ya3F1
ZXVlLmggc2F5czoNCj4gDQo+ICAgICAgICAgLyogQkggd3Egb25seSBhbGxvd3MgdGhlIGZvbGxv
d2luZyBmbGFncyAqLw0KPiAgICAgICAgIF9fV1FfQkhfQUxMT1dTICAgICAgICAgID0gV1FfQkgg
fCBXUV9ISUdIUFJJIHwgV1FfUEVSQ1BVLA0KDQpUaGFua3MgZm9yIHRoZSBpbmZvLiBJJ2xsIHRh
a2UgdGhpcyBwYXRjaCB0byBydHcgdHJlZSBpbiAtcmMgY3ljbGUuDQoNCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tl
ZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+IEZvcnR1
bmF0ZWx5IHRoaXMgY29tbWl0IGlzIG5vdCBpbiBhbnkgcmVsZWFzZWQga2VybmVsIHlldC4NCj4g
LS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3VzYi5jIHwgMyArLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3VzYi5jIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC91c2IuYw0KPiBpbmRleCAyMmI5Y2Jm
MjI2OGEuLmJmNmJlZGY3Y2I1ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OC91c2IuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg4L3VzYi5jDQo+IEBAIC05NzIsOCArOTcyLDcgQEAgc3RhdGljIGludCBydHdfdXNiX2lu
aXRfcngoc3RydWN0IHJ0d19kZXYgKnJ0d2RldikNCj4gICAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAq
cnhfc2tiOw0KPiAgICAgICAgIGludCBpOw0KPiANCj4gLSAgICAgICBydHd1c2ItPnJ4d3EgPSBh
bGxvY193b3JrcXVldWUoInJ0dzg4X3VzYjogcnggd3EiLCBXUV9CSCB8IFdRX1VOQk9VTkQsDQo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDApOw0KDQpIaSBNYXJjbywN
Cg0KV2lsbCB5b3Ugc2VuZCBhIHBhdGNoIHRvIHBvaW50IG91dCBXUV9QRVJDUFUgZXhwbGljaXRs
eT8NCg0KPiArICAgICAgIHJ0d3VzYi0+cnh3cSA9IGFsbG9jX3dvcmtxdWV1ZSgicnR3ODhfdXNi
OiByeCB3cSIsIFdRX0JILCAwKTsNCj4gICAgICAgICBpZiAoIXJ0d3VzYi0+cnh3cSkgew0KPiAg
ICAgICAgICAgICAgICAgcnR3X2VycihydHdkZXYsICJmYWlsZWQgdG8gY3JlYXRlIFJYIHdvcmsg
cXVldWVcbiIpOw0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+IC0tDQo+IDIu
NTEuMQ0KDQo=

