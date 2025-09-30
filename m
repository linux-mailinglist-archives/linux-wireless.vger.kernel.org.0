Return-Path: <linux-wireless+bounces-27718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F40C7BAAEDE
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 03:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0961634C1
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 01:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE88137C52;
	Tue, 30 Sep 2025 01:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="n5Fj1BEU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C859168BD;
	Tue, 30 Sep 2025 01:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197355; cv=none; b=AI8SXQbinRPKo/mSuhxWOD0AJzqp+61bKyY/wku5CaFJrxX30mXMFSqkA43Exe5z78AdZGBGxJYfBAT+Gl2Le+5ZhtECQIO44hWh0IyoHulnydrb9YtQLuEJCW4CB2ffVMnfemZLFTCPIOz0Hzq5JUk6ShxOT52Ls3B5PvCRTW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197355; c=relaxed/simple;
	bh=yaSawZhStnaagyr5oQDuM0OWFtc8pcOtM4wM1lRbPoI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PHB0u9s1jeUEVY0jFpawdjUYn7LWlWY8E/RHG4r5iRFlbAmmRwWXwFBRzJlom6GUKCJuSAwEoKf6mFB1ivucwP371RPp6JyAjCjK7zWCo4sf0y74KUisTY0RYtqKEgK5f+xP2OdJI0SAL2aM+TuhCZYVpp8VlovqrKyGyB1BkRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=n5Fj1BEU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58U1tPeQ5233946, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1759197325; bh=yaSawZhStnaagyr5oQDuM0OWFtc8pcOtM4wM1lRbPoI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=n5Fj1BEU/VIW3G4/pOwMlMOqYJPKofMftir4AINL1JRktLFlWo5EUVmhSXwu+Jifp
	 XJOdp2tUPXgHMMHZRrIIeAcY1eYBFisAPr/EEwr4SmWxdIOFhGxCl/TFXaohlFWZMZ
	 CXFiw3iimaCFZCjwELeRkjAcEzveDwcq7GXI8ehBRJkR7K9OKP2pi1PrTtvQBG++PR
	 hw4nlpv4iHt/2iUk4P5BFQuN3fEF7XO/ueISRnC5hyCotMD9JLGFDXagj+0LIUQApO
	 pH5+/Ogm8lErCp5byyrJjzPtY9vUeucEFH1irEavWrU8sNc8pIP2GnYFf+FlF9Qb59
	 7WDsfEEoGxi0g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58U1tPeQ5233946
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 09:55:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 30 Sep 2025 09:55:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 30 Sep 2025 09:55:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Zong-Zhe Yang
	<kevin_yang@realtek.com>,
        Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next 4/6] wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Thread-Topic: [PATCH rtw-next 4/6] wifi: rtw89: handle
 IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Thread-Index: AQHcKjJqi/Jzq1+F0kmqtZl8ZrJi1LSiFmVggAemeICAAUXHQA==
Date: Tue, 30 Sep 2025 01:55:25 +0000
Message-ID: <ccf7e2c563e14f90ac3bb900b09a5f45@realtek.com>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
 <20250920132614.277719-5-pchelkin@ispras.ru>
 <de5673b6c65d460187b9d99a14783a7e@realtek.com>
 <20250929130524-9e0c010a824ad34c47c2e1c4-pchelkin@ispras>
In-Reply-To: <20250929130524-9e0c010a824ad34c47c2e1c4-pchelkin@ispras>
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

RmVkb3IgUGNoZWxraW4gPHBjaGVsa2luQGlzcHJhcy5ydT4gd3JvdGU6DQo+ID4gPiArICAgICAg
IGllZWU4MDIxMV90eF9pbmZvX2NsZWFyX3N0YXR1cyhpbmZvKTsNCj4gPiA+ICsgICAgICAgaWYg
KGFja2VkKQ0KPiA+ID4gKyAgICAgICAgICAgICAgIGluZm8tPmZsYWdzIHw9IElFRUU4MDIxMV9U
WF9TVEFUX0FDSzsNCj4gPiA+ICsgICAgICAgZWxzZQ0KPiA+ID4gKyAgICAgICAgICAgICAgIGlu
Zm8tPmZsYWdzICY9IH5JRUVFODAyMTFfVFhfU1RBVF9BQ0s7DQo+ID4gPiArDQo+ID4gPiArICAg
ICAgIGllZWU4MDIxMV90eF9zdGF0dXNfaXJxc2FmZShydHdkZXYtPmh3LCBza2IpOw0KPiA+DQo+
ID4gSSdtIG5vdCBhd2FyZSBVU0IgdXNlIF9pcnFzYWZlIHZlcnNpb24gYmVmb3JlLiBDYW4gSSBr
bm93IHRoZSBjb250ZXh0IG9mDQo+ID4gcnR3ODlfdXNiX3dyaXRlX3BvcnRfY29tcGxldGUoKT8g
SXMgaXQgSVJRIGNvbnRleHQ/DQo+ID4NCj4gDQo+IERlcGVuZHMgb24gdGhlIFVTQiBob3N0IGNv
bnRyb2xsZXIgaWYgSSdtIG5vdCBtaXN0YWtlbi4gIFVSQiBjb21wbGV0aW9uDQo+IGNhbGxiYWNr
IG1heSBiZSBpbnZva2VkIGVpdGhlciBpbiBoYXJkIElSUSBvciBCSCBjb250ZXh0Lg0KPiB1c2Jf
aGNkX2dpdmViYWNrX3VyYigpIGhhcyBhbiB1cGRhdGVkIGRvYyBzdGF0aW5nOg0KPiANCj4gICog
Q29udGV4dDogYXRvbWljLiBUaGUgY29tcGxldGlvbiBjYWxsYmFjayBpcyBpbnZva2VkIGVpdGhl
ciBpbiBhIHdvcmsgcXVldWUNCj4gICogKEJIKSBjb250ZXh0IG9yIGluIHRoZSBjYWxsZXIncyBj
b250ZXh0LCBkZXBlbmRpbmcgb24gd2hldGhlciB0aGUgSENEX0JIDQo+ICAqIGZsYWcgaXMgc2V0
IGluIHRoZSBAaGNkIHN0cnVjdHVyZSwgZXhjZXB0IHRoYXQgVVJCcyBzdWJtaXR0ZWQgdG8gdGhl
DQo+ICAqIHJvb3QgaHViIGFsd2F5cyBjb21wbGV0ZSBpbiBCSCBjb250ZXh0Lg0KPiANCj4gSWYg
SENEX0JIIGlzIG5vdCBzZXQgZm9yIHRoZSBob3N0IGNvbnRyb2xsZXIgaW4gdXNlIHRoZW4sIGRl
cGVuZGluZyBvbiBob3N0DQo+IGNvbnRyb2xsZXIsIFVSQiBoYW5kbGVyIG1pZ2h0IGJlIGV4ZWN1
dGVkIGluIGhhcmQgSVJRIGNvbnRleHQuDQoNClRoYW5rcyBmb3IgdGhlIGluZm8uIEkgd2lsbCB3
cml0ZSBkb3duIHRoaXMgZm9yIHJlZmVyZW5jZSBteXNlbGYuDQoNCj4gDQo+IEkgZ3Vlc3MgeW91
J3JlIGltcGx5aW5nIHRvIHVuaWZ5IHRoZSB1c2FnZSBvZiBpZWVlODAyMTFfdHhfc3RhdHVzXyog
Zm9yDQo+IFBDSWUgKHdoaWNoIGhhcyBpZWVlODAyMTFfdHhfc3RhdHVzX25pKSBhbmQgVVNCIHZh
cmlhbnRzIG9mIHJ0dzg5LiAgVGhlc2UNCj4gY2FsbHMgYXJlIG5vdCBtaXhlZCBmb3IgdGhlIHNp
bmdsZSBoYXJkd2FyZSBzbyB0aGVyZSBpcyBubyByZWFsIGlzc3VlDQo+IGZvciB1bmlmaWNhdGlv
bi4NCg0KSSBrbmV3IHRoaXMgYXJlbid0IG1peGVkIHVzZSBvZiBBUEkgZm9yIFBDSSBhbmQgVVNC
LiBJIGp1c3QgdGhpbmsgaWYgaXQncw0Kbm90IGluIElSUSBjb250ZXh0LCB3ZSBjYW4gYXZvaWQg
dG8gdXNlIHNwaW5fbG9ja19pcnFzYXZlKCksIGJ1dCBpbiBmYWN0DQppdCBkb2VzLg0KDQoNCj4g
DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gIHN0YXRpYyB2b2lkDQo+ID4gPiAgcnR3ODlfbWFj
X2MyaF90eF9ycHQoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqYzJo
LCB1MzIgbGVuKQ0KPiA+ID4gIHsNCj4gPiA+ICAgICAgICAgdTggc3dfZGVmaW5lID0gUlRXODlf
R0VUX01BQ19DMkhfVFhfUlBUX1NXX0RFRklORShjMmgtPmRhdGEpOw0KPiA+ID4gICAgICAgICB1
OCB0eF9zdGF0dXMgPSBSVFc4OV9HRVRfTUFDX0MySF9UWF9SUFRfVFhfU1RBVEUoYzJoLT5kYXRh
KTsNCj4gPiA+ICsgICAgICAgc3RydWN0IHNrX2J1ZmYgKmN1ciwgKnRtcDsNCj4gPiA+ICsgICAg
ICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiA+ICsgICAgICAgdTggKm47DQo+ID4gPg0KPiA+
ID4gICAgICAgICBydHc4OV9kZWJ1ZyhydHdkZXYsIFJUVzg5X0RCR19UWFJYLA0KPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAiQzJIIFRYIFJQVDogc24gJWQsIHR4X3N0YXR1cyAlZFxuIiwNCj4g
PiA+ICAgICAgICAgICAgICAgICAgICAgc3dfZGVmaW5lLCB0eF9zdGF0dXMpOw0KPiA+ID4gKw0K
PiA+ID4gKyAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmcnR3ZGV2LT50eF9ycHRfcXVldWUubG9j
aywgZmxhZ3MpOw0KPiA+ID4gKyAgICAgICBza2JfcXVldWVfd2Fsa19zYWZlKCZydHdkZXYtPnR4
X3JwdF9xdWV1ZSwgY3VyLCB0bXApIHsNCj4gPiA+ICsgICAgICAgICAgICAgICBuID0gKHU4ICop
UlRXODlfVFhfU0tCX0NCKGN1ciktPmhjaV9wcml2Ow0KPiA+DQo+ID4gVGhlICpuIGlzIHJ0dzg5
X3VzYl90eF9kYXRhOjpzbiwgcmlnaHQ/IEkgZmVlbCB0aGlzIGlzIGhhcmQgdG8gZW5zdXJlDQo+
ID4gY29ycmVjdG5lc3MuIFdoeSBub3QganVzdCBkZWZpbmUgdGhpcyBpbiBzdHJ1Y3QgcnR3ODlf
dHhfc2tiX2RhdGE/DQo+ID4gU28gbm8gbmVlZCBSVFc4OV9VU0JfVFhfU0tCX0NCKCkgZm9yIHRo
aXMuDQo+IA0KPiBBaCwgdGhpcyBzaG91bGQgd29yayBiZWNhdXNlIHJlY2VudCBjb21taXQgMTk5
ODljODA3MzRjICgid2lmaTogcnR3ODk6IHVzZQ0KPiBpZWVlODAyMTFfdHhfaW5mbzo6ZHJpdmVy
X2RhdGEgdG8gc3RvcmUgZHJpdmVyIFRYIGluZm8iKSBoYXMgYWxsb3dlZA0KPiBzdG9yaW5nIG1v
cmUgdGhhbiAyICd2b2lkIConIHBvaW50ZXJzIGluIHByaXZhdGUgZGF0YS4NCg0KSSBmZWVsIGJl
Zm9yZSB0aGUgY29tbWl0LCBpdCBhbHNvIGFsbG93IDIgJ3ZvaWQgKicgc2luY2UgDQogICAiIHZv
aWQgKnN0YXR1c19kcml2ZXJfZGF0YVsxNiAvIHNpemVvZih2b2lkICopXTsiDQoNCkJ1dCBab25n
LVpoZSBub3RlZCBtZSB0aGF0IG9yaWdpbmFsIGRlZmluaXRpb24gaXMgd2VpcmQsIHNvIEkgY2hh
bmdlIGl0IHRvDQpiZSBtb3JlIHJlYXNvbmFibGUgKEkgaG9wZSkuDQoNCj4gDQo+ID4NCj4gPiA+
ICsgICAgICAgICAgICAgICBpZiAoKm4gPT0gc3dfZGVmaW5lKSB7DQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBfX3NrYl91bmxpbmsoY3VyLCAmcnR3ZGV2LT50eF9ycHRfcXVldWUpOw0K
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcnR3ODlfdHhfcnB0X3R4X3N0YXR1cyhydHdk
ZXYsIGN1ciwgdHhfc3RhdHVzID09IFJUVzg5X1RYX0RPTkUpOw0KPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ID4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ID4gKyAgICAg
ICB9DQo+ID4gPiArICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnJ0d2Rldi0+dHhfcnB0
X3F1ZXVlLmxvY2ssIGZsYWdzKTsNCj4gPg0KPiA+IElmIHdlIGNhbiB1c2UgaWVlZTgwMjExX3R4
X3N0YXR1c19uaSgpIG9yIGllZWU4MDIxMV90eF9zdGF0dXNfc2tiKCksDQo+IA0KPiBXZSBjYW4n
dCB1c2Ugbm9uLV9pcnFzYWZlIHZlcnNpb25zIGhlcmUgdW5sZXNzIHJ0dzg5X3VzYl93cml0ZV9w
b3J0X2NvbXBsZXRlKCkNCj4gaXMgcmV3b3JrZWQgbm90IHRvIHVzZSBfaXJxc2FmZSBvbmUuICBB
bmQgdGhlcmUgaXMgbm8gd2F5IG90aGVyIHRoYW4NCj4gdHJhbnNmZXJpbmcgdGhpcyB3b3JrIGZy
b20gVVJCIGNvbXBsZXRpb24gaGFuZGxlciB0byBzb21lIG90aGVyIGFzeW5jDQo+IHdvcmtlciAo
aW4gQkggY29udGV4dCBvciBzaW1pbGFyKS4gIE5vdCBzdXJlIGl0J2xsIGJlIGJldHRlciBvdmVy
YWxsLg0KDQpBcyB5b3VyIGFib3ZlIGluZm9ybWF0aW9uIGFib3V0IGNvbnRleHQsIGp1c3QgaWdu
b3JlIHRoaXMuIA0KDQpJIGp1c3QgdGhvdWdodCBpZiB3ZSBjYW4gcmVkdWNlIGNyaXRpY2FsIHNl
Y3Rpb24gb2Ygc3Bpbl9sb2NrX2lycXNhdmUoKSwNCmJ1dCBpdCBzZWVtcyB0byBiZSBubyB3YXku
IFNvIGtlZXAgaXQgYXMgd2FzIGlmIHdlIHN0aWxsIG5vIGJldHRlciBpZGVhDQpiZWZvcmUgZ2V0
dGluZyBtZXJnZWQuIA0KDQo+IA0KPiA+IEknZCBsaWtlIHVzZSBza2JfcXVldWVfc3BsaWNlKCkg
dG8gY3JlYXRlIGEgbG9jYWwgc2tiIGxpc3QsIGFuZCBpdGVyYXRlIHRoZQ0KPiA+IGxvY2FsIGxp
c3QsIGFuZCB0aGVuIHNwbGljZSBiYWNrIHRvIG9yaWdpbmFsLg0KPiA+DQo+ID4gKFJlZmVyZW5j
ZSB0byBtZXNoX3BhdGhfbW92ZV90b19xdWV1ZSgpKQ0KPiANCj4gUGVyaGFwcyB3ZSBjYW4gZG8g
dGhhdCB3aXRoIGllZWU4MDIxMV90eF9zdGF0dXNfaXJxc2FmZSgpIHN0aWxsIGluIHBsYWNlLg0K
DQpOb3Qgc3VyZSBob3cgeW91IHdpbGwgZG8uIExldCdzIHNlZSBpdCBpbiB5b3VyIG5leHQgdmVy
c2lvbi4gOi0pDQoNCj4gDQo+ID4NCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gIHN0YXRpYyB2b2lk
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9w
Y2kuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcGNpLmMNCj4gPiA+IGlu
ZGV4IDBlZTVmODU3OTQ0Ny4uZmRmMTQyZDc3ZWNjIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9wY2kuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9wY2kuYw0KPiA+ID4gQEAgLTQ2NzUsNiArNDY3NSw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcnR3ODlfaGNpX29wcyBydHc4OV9wY2lfb3BzID0gew0K
PiA+ID4gICAgICAgICAucGF1c2UgICAgICAgICAgPSBydHc4OV9wY2lfb3BzX3BhdXNlLA0KPiA+
ID4gICAgICAgICAuc3dpdGNoX21vZGUgICAgPSBydHc4OV9wY2lfb3BzX3N3aXRjaF9tb2RlLA0K
PiA+ID4gICAgICAgICAucmVjYWxjX2ludF9taXQgPSBydHc4OV9wY2lfcmVjYWxjX2ludF9taXQs
DQo+ID4gPiArICAgICAgIC50eF9ycHRfZW5hYmxlICA9IE5VTEwsIC8qIGFsd2F5cyBlbmFibGVk
ICovDQo+ID4NCj4gPiBUaGUgY29tbWVudCBpcyB3ZWlyZC4gUENJIGRldmljZXMgZG9uJ3QgbmV2
ZXIgdXNlIFRYIHJlcG9ydCwgbm8/DQo+IA0KPiBJdCdzIG1lIG1peGluZyB1cCB0aGUgdGVybWlu
b2xvZ3ksIHNvcnJ5LiAgVGhlIGNvbW1lbnQgd2FzIHN1cHBvc2VkIHRvDQo+IGluZGljYXRlIHRo
YXQgUENJIGFsd2F5cyBoYXZlIFRYIHN0YXR1cyByZXBvcnRlZC4gIChidXQgaXQncyBkb25lIHZp
YSBSUFANCj4gZmVhdHVyZSB3aGljaCBpcyBhY3R1YWxseSBhIHNlcGFyYXRlIHRoaW5nIGNvbXBh
cmVkIHRvIFRYIFJlcG9ydCwgb2theSkNCj4gDQo+IEknZCByYXRoZXIgcmVwbGFjZSBpdCB3aXRo
ICJUWCBzdGF0dXMgaXMgcmVwb3J0ZWQgdmlhIFJQUCIgaWYgdGhhdCBjb21tZW50DQo+IGlzIGhl
bHBmdWwuDQoNClllcywgaXQgbG9va3MgYmV0dGVyLiBUaGFua3MuDQoNCg==

