Return-Path: <linux-wireless+bounces-22760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D900CAB072C
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 02:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF944E6E67
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 00:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A8BD531;
	Fri,  9 May 2025 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="RG5L8tjm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C36487BF
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746751391; cv=none; b=VYr30cqZO1TNEExoRkJUIfEMFK3qzj4sOXhgAVzhORaeLqOMH/e+uf7jd6w4IpQPtBa9E7DIh5cXJAvykRAr1bccXXSxlUuYSzphSU5NHrNRbqHgPlq6i+rDhM3ebhU0ZMp0MkLQ6rZvVaeWiZ0Ml705TOy9nZU5PIwqi10Ph+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746751391; c=relaxed/simple;
	bh=p69BJgCmvjtuTlPDQgSjQSNy6LQFuOmxw0CIRec8Ods=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HOoc6YKfr8zLwNogFkAhyaVwE6++sGiHmF6XcMN6iC3LKqyKPm0GuaMSnyIPCOmwqHf2A7iKpzedMHbjQ8iMXybpT0M3+AxGo/bHAaD8/xJPUGHuC4IL8bw+lmKhwxRL2pUMI0BKqPQUgnrPodv0Gi3DQXgIhJgbryRp09eZWMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=RG5L8tjm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5490h4qJ53259643, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746751384; bh=p69BJgCmvjtuTlPDQgSjQSNy6LQFuOmxw0CIRec8Ods=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=RG5L8tjmlHPoIEpDGlnm25VlqfYPb45rmXrpoxbguM3dXa4XNAH1/tapZI9NybhVJ
	 5bFeoFjlN7qvo/8HatcVqD+B04MeOeH2K3v3ef5gxPAJ0K5/XQv3ZtGJYhl0SncEPG
	 O0izFeiPbn0zllVqrZKJZfW6sWNjeVYbOkRFbVph0t6LfLb2xzokW2yvcWcYZM0kjE
	 nqrGTl5G8EHMXQHbaLXgdreq/eWGFrhUBpLe4/wL99xm1crjBi7N1GZ4pcrQd6FVZs
	 jEIIWSyGvQr+PqKksjFDiSuFLB9xVpVt+TDcZClqsd990H4ALfpWQz5fPwsI4p+tKL
	 AemrfaGkvgDjQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5490h4qJ53259643
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 08:43:04 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 May 2025 08:43:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 May 2025 08:43:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 9 May 2025 08:43:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 2/2] wifi: rtw88: usb: Upload the firmware in bigger chunks
Thread-Topic: [PATCH rtw-next 2/2] wifi: rtw88: usb: Upload the firmware in
 bigger chunks
Thread-Index: AQHbv1CyImz0neihfUW5/jPo1pGLVLPID6gQgABgjoCAAQbFoA==
Date: Fri, 9 May 2025 00:43:04 +0000
Message-ID: <0647d3ed8e7945a3807bd3d82c7fd2a6@realtek.com>
References: <af4d2d58-f567-4bdf-841b-8345d21f7035@gmail.com>
 <9faaa45f-9ba8-46dc-b507-f97b3b6f52d3@gmail.com>
 <670259643afc42f581632c7383fa7f3f@realtek.com>
 <0890b8b7-0426-404e-b833-0144b726e17e@gmail.com>
In-Reply-To: <0890b8b7-0426-404e-b833-0144b726e17e@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAw
OC8wNS8yMDI1IDA2OjI5LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gOiBCaXR0ZXJibHVlIFNt
aXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+IFJUTDg4MTFBVSBzdG9w
cyByZXNwb25kaW5nIGR1cmluZyB0aGUgZmlybXdhcmUgZG93bmxvYWQgb24gc29tZSBzeXN0ZW1z
Og0KPiA+Pg0KPiA+PiBbICA4MDkuMjU2NDQwXSBydHdfODgyMWF1IDUtMi4xOjEuMDogRmlybXdh
cmUgdmVyc2lvbiA0Mi40LjAsIEgyQyB2ZXJzaW9uIDANCj4gPj4gWyAgODEyLjc1OTE0Ml0gcnR3
Xzg4MjFhdSA1LTIuMToxLjAgd2xwNDhzMGY0dTJ1MTogcmVuYW1lZCBmcm9tIHdsYW4wDQo+ID4+
IFsgIDgzNy4zMTUzODhdIHJ0d184ODIxYXUgMS00OjEuMDogd3JpdGUgcmVnaXN0ZXIgMHgxZWY0
IGZhaWxlZCB3aXRoIC0xMTANCj4gPj4gWyAgODY3LjUyNDI1OV0gcnR3Xzg4MjFhdSAxLTQ6MS4w
OiB3cml0ZSByZWdpc3RlciAweDFlZjggZmFpbGVkIHdpdGggLTExMA0KPiA+PiBbICA4NjguOTMw
OTc2XSBydHdfODgyMWF1IDUtMi4xOjEuMCB3bHA0OHMwZjR1MnUxOiBlbnRlcmVkIHByb21pc2N1
b3VzIG1vZGUNCj4gPj4gWyAgODk3LjczMDk1Ml0gcnR3Xzg4MjFhdSAxLTQ6MS4wOiB3cml0ZSBy
ZWdpc3RlciAweDFlZmMgZmFpbGVkIHdpdGggLTExMA0KPiA+Pg0KPiA+PiBNYXliZSBpdCB0YWtl
cyB0b28gbG9uZyB3aGVuIHdyaXRpbmcgdGhlIGZpcm13YXJlIDQgYnl0ZXMgYXQgYSB0aW1lLg0K
PiA+Pg0KPiA+PiBXcml0ZSAxOTYgYnl0ZXMgYXQgYSB0aW1lIGZvciBSVEw4ODIxQVUsIFJUTDg4
MTFBVSwgYW5kIFJUTDg4MTJBVSwNCj4gPj4gYW5kIDI1NCBieXRlcyBhdCBhIHRpbWUgZm9yIFJU
TDg3MjNEVS4gVGhlc2UgYXJlIHRoZSBzaXplcyB1c2VkIGluDQo+ID4+IHRoZWlyIG9mZmljaWFs
IGRyaXZlcnMuIFRlc3RlZCB3aXRoIGFsbCB0aGVzZSBjaGlwcy4NCj4gPj4NCj4gPj4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gTGluazogaHR0cHM6Ly9naXRodWIuY29tL2x3Zmlu
Z2VyL3J0dzg4L2lzc3Vlcy8zNDQNCj4gPj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+ID4NCj4gPiBBY2tlZC1ieTogUGluZy1LZSBT
aGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+ID4NCj4gPiBbLi5dDQo+ID4NCj4gPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNiLmMgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3VzYi5jDQo+ID4+IGluZGV4IGIxNmRiNTc5ZmRj
ZS4uYWQxNWNlMTJhYjdmIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0dzg4L3VzYi5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODgvdXNiLmMNCj4gPj4gQEAgLTE2NSw2ICsxNjUsNjAgQEAgc3RhdGljIHZvaWQgcnR3
X3VzYl93cml0ZTMyKHN0cnVjdCBydHdfZGV2ICpydHdkZXYsIHUzMiBhZGRyLCB1MzIgdmFsKQ0K
PiA+PiAgICAgICAgIHJ0d191c2Jfd3JpdGUocnR3ZGV2LCBhZGRyLCB2YWwsIDQpOw0KPiA+PiAg
fQ0KPiA+Pg0KPiA+PiArc3RhdGljIHZvaWQgcnR3X3VzYl93cml0ZV9maXJtd2FyZV9wYWdlKHN0
cnVjdCBydHdfZGV2ICpydHdkZXYsIHUzMiBwYWdlLA0KPiA+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgY29uc3QgdTggKmRhdGEsIHUzMiBzaXplKQ0KPiA+PiArew0K
PiA+PiArICAgICAgIHN0cnVjdCBydHdfdXNiICpydHd1c2IgPSBydHdfZ2V0X3VzYl9wcml2KHJ0
d2Rldik7DQo+ID4+ICsgICAgICAgc3RydWN0IHVzYl9kZXZpY2UgKnVkZXYgPSBydHd1c2ItPnVk
ZXY7DQo+ID4+ICsgICAgICAgdTMyIGFkZHIgPSBGV184MTkyQ19TVEFSVF9BRERSRVNTOw0KPiA+
DQo+ID4gRldfODE5MkNfU1RBUlRfQUREUkVTUyBpcyBleGlzdGluZyBhbHJlYWR5LiBCdXQgc29t
ZXRoaW5nIGxpa2UNCj4gPiBSVFdfVVNCX0ZXX1NUQVJUX0FERFJFU1Mgd291bGQgYmUgYmV0dGVy
Lg0KPiA+DQo+IA0KPiBJIGFncmVlLCBiZWNhdXNlIHJ0dzg4IGRvZXNuJ3QgaGFuZGxlIFJUTDgx
OTJDLiBUaGVyZSBpcw0KPiBGV19TVEFSVF9BRERSX0xFR0FDWSBpbiBmdy5oLiBJIG11c3Qgbm90
IGhhdmUgbm90aWNlZCBpdCBiZWZvcmUuDQo+IFNob3VsZCBJIHNlbmQgdjIgZm9yIHRoaXM/DQoN
ClllcywgcGxlYXNlLiBJIGRvbid0IGNoYW5nZSBwYXRjaCBjb250ZW50IGR1cmluZyBjb21taXR0
aW5nIHRvIHByZXZlbnQgbWVzcyB1cA0Kc29tZXRoaW5nLiBTaW5jZSB5b3Ugb25seSBjaGFuZ2Ug
dGhlIG5hbWluZywgcGxlYXNlIGNhcnJ5IG15IEFjay1ieSB0byBuZXh0DQp2ZXJzaW9uLg0KDQo+
IA0KPiA+PiArICAgICAgIHU4ICpkYXRhX2R1cCwgKmJ1ZjsNCj4gPj4gKyAgICAgICB1MzIgbiwg
YmxvY2tfc2l6ZTsNCj4gPj4gKyAgICAgICBpbnQgcmV0Ow0KPiA+PiArDQo+ID4+ICsgICAgICAg
c3dpdGNoIChydHdkZXYtPmNoaXAtPmlkKSB7DQo+ID4+ICsgICAgICAgY2FzZSBSVFdfQ0hJUF9U
WVBFXzg3MjNEOg0KPiA+PiArICAgICAgICAgICAgICAgYmxvY2tfc2l6ZSA9IDI1NDsNCj4gPj4g
KyAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+PiArICAgICAgIGRlZmF1bHQ6DQo+ID4+ICsgICAg
ICAgICAgICAgICBibG9ja19zaXplID0gMTk2Ow0KPiA+PiArICAgICAgICAgICAgICAgYnJlYWs7
DQo+ID4+ICsgICAgICAgfQ0KPiA+PiArDQo+ID4+ICsgICAgICAgZGF0YV9kdXAgPSBrbWVtZHVw
KGRhdGEsIHNpemUsIEdGUF9LRVJORUwpOw0KPiA+DQo+ID4gVGhpcyBpcyBiZWNhdXNlIHR5cGUg
b2YgYXJndW1lbnQgYGRhdGFgIG9mIHVzYl9jb250cm9sX21zZygpIGlzIG5vdCBjb25zdCwgcmln
aHQ/DQo+ID4gRG8geW91IGtub3cgaWYgdXNiX2NvbnRyb2xfbXNnKCkgd2lsbCBhY3R1YWxseSBt
b2RpZnkgdGhlIGRhdGE/DQo+ID4NCj4gDQo+IE5vLCBpdCdzIGJlY2F1c2UgdXNiX2NvbnRyb2xf
bXNnKCkgcmVqZWN0cyBtZW1vcnkgYWxsb2NhdGVkIGJ5DQo+IHZtYWxsb2MoKS4gSSBkb24ndCBy
ZW1lbWJlciB3aGF0IGVycm9yIGl0IHByaW50ZWQuIE1heWJlIGJlY2F1c2UgdGhlDQo+IG1lbW9y
eSBpcyBub3Qgc3VpdGFibGUgZm9yIERNQS4NCg0KRG8geW91IG1lYW4gZmlybXdhcmUgaXMgcGxh
Y2VkIGluIG1lbW9yeSBhbGxvY2F0ZWQgYnkgdm1hbGxvYygpPw0KSWYgc28sIGl0IG1ha2VzIHNl
bnNlIHRvIHRoZSByZWFzb24geW91IHNhaWQuIA0KDQo=

