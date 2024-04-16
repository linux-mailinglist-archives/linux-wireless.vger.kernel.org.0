Return-Path: <linux-wireless+bounces-6370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF678A6402
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 08:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEEF284321
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 06:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092E51E49D;
	Tue, 16 Apr 2024 06:36:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD5ED8
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249379; cv=none; b=t414yciLrKenxnTJ6cD1dojoYke9Wh+ndjq1ig5p+nDiDDaqTwxbEJeR3R24KYKM5IVmmjtQJ4YGSehbUyt1VLKjHwXRJW6mubjNbCc176bVs/9Gi0EZbrtklLE8DBmzh1mNkaNu20kWS0dtqTsGJYV390mUZOVDrsNT8hs08N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249379; c=relaxed/simple;
	bh=ngcuN/AkJUyqXkV7p7LaP2JQ2SZ0WthqSYOiHTarsrs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YCwpn5bOjnAvV+Sy0LqACxRkzUYwfQgi+pp6Z3xJRb93C2ksd5uBnN/XpMqv3JesC/3WCUujVzDOf9ahReczF8Sl3z+yxw++2S6RoXCeIFkLQub5e1X+3T9+kXGsEZNYWogE8bBCIvLP1Lv+/nX4z4QlcDqrIXxGwCx1Go3inwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43G6aD3z91923075, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43G6aD3z91923075
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 14:36:13 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 14:36:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 14:36:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 16 Apr 2024 14:36:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: Add LED control code for RTL8723BU
Thread-Topic: [PATCH] wifi: rtl8xxxu: Add LED control code for RTL8723BU
Thread-Index: AQHaj3oFmP4B9QohrkGn1K42kUFWl7FqcTfQ
Date: Tue, 16 Apr 2024 06:36:13 +0000
Message-ID: <869e5cb370274073821287c1a4e70cb0@realtek.com>
References: <6a0698cc-9389-414f-b172-7046bec01b3e@gmail.com>
In-Reply-To: <6a0698cc-9389-414f-b172-7046bec01b3e@gmail.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KDQo+IFRl
c3RlZCB3aXRoIEVEVVAgRVAtTjg1NjguDQoNClBsZWFzZSBkZXNjcmliZSB0aGUgTEVEIG1vZGVz
IHlvdSBoYXZlIHRlc3RlZC4gU2VuZCB2MiBvciBwYXN0ZSBkZXNjcmlwdGlvbg0KaGVyZSwgSSBj
YW4gYWRkIHRoZW0gZHVyaW5nIGJlaW5nIG1lcmdlZC4gDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1i
eTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+ICAuLi4vcmVh
bHRlay9ydGw4eHh4dS9ydGw4eHh4dV84NzIzYi5jICAgICAgICAgfCAyMyArKysrKysrKysrKysr
KysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODcy
M2IuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVf
ODcyM2IuYw0KPiBpbmRleCA5NjQwYzg0MWQyMGEuLmM2NzdhNDdlZDQ2ZCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV84NzIzYi5j
DQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVf
ODcyM2IuYw0KPiBAQCAtMTcwMSw2ICsxNzAxLDI4IEBAIHN0YXRpYyBzOCBydGw4NzIzYl9jY2tf
cnNzaShzdHJ1Y3QgcnRsOHh4eHVfcHJpdiAqcHJpdiwgc3RydWN0IHJ0bDg3MjNhdV9waHlfc3Rh
DQo+ICAgICAgICAgcmV0dXJuIHJ4X3B3cl9hbGw7DQo+ICB9DQo+IA0KPiArc3RhdGljIGludCBy
dGw4NzIzYnVfbGVkX2JyaWdodG5lc3Nfc2V0KHN0cnVjdCBsZWRfY2xhc3NkZXYgKmxlZF9jZGV2
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW51bSBsZWRfYnJp
Z2h0bmVzcyBicmlnaHRuZXNzKQ0KPiArew0KPiArICAgICAgIHN0cnVjdCBydGw4eHh4dV9wcml2
ICpwcml2ID0gY29udGFpbmVyX29mKGxlZF9jZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBydGw4eHh4dV9wcml2LA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxlZF9jZGV2KTsN
Cj4gKyAgICAgICB1OCBsZWRjZmcgPSBydGw4eHh4dV9yZWFkOChwcml2LCBSRUdfTEVEQ0ZHMik7
DQo+ICsgICAgICAgbGVkY2ZnICY9IExFRENGRzJfRFBEVF9TRUxFQ1Q7DQo+ICsNCj4gKyAgICAg
ICBpZiAoYnJpZ2h0bmVzcyA9PSBMRURfT0ZGKSB7DQo+ICsgICAgICAgICAgICAgICBsZWRjZmcg
fD0gTEVEQ0ZHMl9TV19MRURfQ09OVFJPTCB8IExFRENGRzJfU1dfTEVEX0RJU0FCTEU7DQo+ICsg
ICAgICAgfSBlbHNlIGlmIChicmlnaHRuZXNzID09IExFRF9PTikgew0KPiArICAgICAgICAgICAg
ICAgbGVkY2ZnIHw9IExFRENGRzJfU1dfTEVEX0NPTlRST0w7DQo+ICsgICAgICAgfSBlbHNlIGlm
IChicmlnaHRuZXNzID09IFJUTDhYWFhVX0hXX0xFRF9DT05UUk9MKSB7DQo+ICsgICAgICAgICAg
ICAgICBsZWRjZmcgfD0gTEVEQ0ZHMl9IV19MRURfQ09OVFJPTCB8IExFRENGRzJfSFdfTEVEX0VO
QUJMRTsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICBydGw4eHh4dV93cml0ZTgocHJpdiwg
UkVHX0xFRENGRzIsIGxlZGNmZyk7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gMDsNCj4gK30NCj4g
Kw0KPiAgc3RydWN0IHJ0bDh4eHh1X2ZpbGVvcHMgcnRsODcyM2J1X2ZvcHMgPSB7DQo+ICAgICAg
ICAgLmlkZW50aWZ5X2NoaXAgPSBydGw4NzIzYnVfaWRlbnRpZnlfY2hpcCwNCj4gICAgICAgICAu
cGFyc2VfZWZ1c2UgPSBydGw4NzIzYnVfcGFyc2VfZWZ1c2UsDQo+IEBAIC0xNzMxLDYgKzE3NTMs
NyBAQCBzdHJ1Y3QgcnRsOHh4eHVfZmlsZW9wcyBydGw4NzIzYnVfZm9wcyA9IHsNCj4gICAgICAg
ICAuZmlsbF90eGRlc2MgPSBydGw4eHh4dV9maWxsX3R4ZGVzY192MiwNCj4gICAgICAgICAuc2V0
X2NyeXN0YWxfY2FwID0gcnRsODcyM2Ffc2V0X2NyeXN0YWxfY2FwLA0KPiAgICAgICAgIC5jY2tf
cnNzaSA9IHJ0bDg3MjNiX2Nja19yc3NpLA0KPiArICAgICAgIC5sZWRfY2xhc3NkZXZfYnJpZ2h0
bmVzc19zZXQgPSBydGw4NzIzYnVfbGVkX2JyaWdodG5lc3Nfc2V0LA0KPiAgICAgICAgIC53cml0
ZU5fYmxvY2tfc2l6ZSA9IDEwMjQsDQo+ICAgICAgICAgLnR4X2Rlc2Nfc2l6ZSA9IHNpemVvZihz
dHJ1Y3QgcnRsOHh4eHVfdHhkZXNjNDApLA0KPiAgICAgICAgIC5yeF9kZXNjX3NpemUgPSBzaXpl
b2Yoc3RydWN0IHJ0bDh4eHh1X3J4ZGVzYzI0KSwNCj4gLS0NCj4gMi40NC4wDQoNCg==

