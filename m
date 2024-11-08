Return-Path: <linux-wireless+bounces-15125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81009C1423
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 03:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8130B2516E
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 02:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F01126C0A;
	Fri,  8 Nov 2024 02:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="PI/mmkuU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027522940B
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 02:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731033366; cv=none; b=mIFhXeUfH7MF5v87JN4PIL8dEyQ4Bd5G+eeuHDYAtvYqFGmWUXGfJ5A/5owfHglZP9uhadiTTvucdJ/QQbWinHPNS2InhBKlBLdhii3VcJAV3AesFy7veMNxzPOU5tvBDbJL2mAF39AWDs2sW6k3aOcVWTWo3GMYIL2TQszpEK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731033366; c=relaxed/simple;
	bh=idzzoF11zVrdrhWql71yYWDHwkGjZk3yjIYoUrLDr2A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ipR7oNLFQMEP800g+ySafDKsSEvWseNsNSfW7WnGlSncQqH0adjLNw798TlL8UUVSO2c+lq41JradAkHi5k627SLYUQwsTwYBYfLFqGnCIMqt4RuM+0lVwwveWd2Ty6dLjnxGCHeN1aQ95BFcH0Qe4l4VvNaxmy2YRtbu5PBZKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=PI/mmkuU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A82a0yN51244141, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731033360; bh=idzzoF11zVrdrhWql71yYWDHwkGjZk3yjIYoUrLDr2A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=PI/mmkuU6jKV6TZb1aSXWerynsUasMvkWHeX4YpPhpdSc6mFsVPtoa4/ZNQvDW+Mo
	 YjZ9QH2UtrQgjQqtknCskyElJE1bYcDZ+/4Uzqd6syv5P1GlJJte3We42E416Ie4/e
	 NqYu6DwOBNy+sSIpD/MEoLC9ObY+3iKzfVwucsZby87HX0IzBsWmddeXhTHHCJSdWz
	 yTr18IiQRF7AviTZc4VB5jDPicc/PCaP1hkPvedE5YIx5J0gLr87FzYPM02eaK3RkU
	 CjAB52piqELq62kl5jSryREsE3U7VH250C4xKivZAFW0kalasBBlcNi4akTkwETirQ
	 jI4ZH3G4FylyQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A82a0yN51244141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 10:36:00 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 10:36:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Nov 2024 10:36:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 8 Nov 2024 10:36:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/2] wifi: rtw88: usb: Support USB 3 with RTL8812AU
Thread-Topic: [PATCH 1/2] wifi: rtw88: usb: Support USB 3 with RTL8812AU
Thread-Index: AQHbMW6KnqXz5qplSkmBk0FRdNVE87KsqmjQ
Date: Fri, 8 Nov 2024 02:36:00 +0000
Message-ID: <c053ea160bd1469e8b076247f3641193@realtek.com>
References: <78ca9bcb-cd48-4c53-8514-7967bad6dfcf@gmail.com>
In-Reply-To: <78ca9bcb-cd48-4c53-8514-7967bad6dfcf@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBZGQg
dGhlIGZ1bmN0aW9uIHRvIGF1dG9tYXRpY2FsbHkgc3dpdGNoIHRoZSBSVEw4ODEyQVUgaW50byBV
U0IgMyBtb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgy
MWNlcmZlMkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydHc4OC91c2IuYyB8IDM0ICsrKysrKysrKysrKysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC91c2IuYyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNiLmMNCj4gaW5kZXggNmZhM2MzNzIwNWY1Li43NTJi
Y2EwNWI5YWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODgvdXNiLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC91c2Iu
Yw0KPiBAQCAtOTMxLDYgKzkzMSwzMiBAQCBzdGF0aWMgdm9pZCBydHdfdXNiX2ludGZfZGVpbml0
KHN0cnVjdCBydHdfZGV2ICpydHdkZXYsDQo+ICAgICAgICAgdXNiX3NldF9pbnRmZGF0YShpbnRm
LCBOVUxMKTsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgaW50IHJ0d191c2Jfc3dpdGNoX21vZGVfb2xk
KHN0cnVjdCBydHdfZGV2ICpydHdkZXYpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IHJ0d191c2Ig
KnJ0d3VzYiA9IHJ0d19nZXRfdXNiX3ByaXYocnR3ZGV2KTsNCj4gKyAgICAgICBlbnVtIHVzYl9k
ZXZpY2Vfc3BlZWQgY3VyX3NwZWVkID0gcnR3dXNiLT51ZGV2LT5zcGVlZDsNCj4gKyAgICAgICB1
OCBoY2lfb3B0Ow0KPiArDQo+ICsgICAgICAgaWYgKGN1cl9zcGVlZCA9PSBVU0JfU1BFRURfSElH
SCkgew0KPiArICAgICAgICAgICAgICAgaGNpX29wdCA9IHJ0d19yZWFkOChydHdkZXYsIFJFR19I
Q0lfT1BUX0NUUkwpOw0KPiArDQo+ICsgICAgICAgICAgICAgICBpZiAoKGhjaV9vcHQgJiAoQklU
KDIpIHwgQklUKDMpKSkgIT0gQklUKDMpKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJ0
d193cml0ZTgocnR3ZGV2LCBSRUdfSENJX09QVF9DVFJMLCAweDgpOw0KPiArICAgICAgICAgICAg
ICAgICAgICAgICBydHdfd3JpdGU4KHJ0d2RldiwgUkVHX1NZU19TRElPX0NUUkwsIDB4Mik7DQo+
ICsgICAgICAgICAgICAgICAgICAgICAgIHJ0d193cml0ZTgocnR3ZGV2LCBSRUdfQUNMS19NT04s
IDB4MSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJ0d193cml0ZTgocnR3ZGV2LCAweDNk
LCAweDMpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAvKiB1c2IgZGlzY29ubmVjdCAqLw0K
PiArICAgICAgICAgICAgICAgICAgICAgICBydHdfd3JpdGU4KHJ0d2RldiwgUkVHX1NZU19QV19D
VFJMICsgMSwgMHg4MCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAxOw0KPiAr
ICAgICAgICAgICAgICAgfQ0KPiArICAgICAgIH0gZWxzZSBpZiAoY3VyX3NwZWVkID09IFVTQl9T
UEVFRF9TVVBFUikgew0KPiArICAgICAgICAgICAgICAgcnR3X3dyaXRlOF9jbHIocnR3ZGV2LCBS
RUdfU1lTX1NESU9fQ1RSTCwgQklUKDEpKTsNCj4gKyAgICAgICAgICAgICAgIHJ0d193cml0ZThf
Y2xyKHJ0d2RldiwgUkVHX0FDTEtfTU9OLCBCSVQoMCkpOw0KPiArICAgICAgIH0NCj4gKw0KPiAr
ICAgICAgIHJldHVybiAwOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IHJ0d191c2Jfc3dpdGNo
X21vZGVfbmV3KHN0cnVjdCBydHdfZGV2ICpydHdkZXYpDQo+ICB7DQo+ICAgICAgICAgZW51bSB1
c2JfZGV2aWNlX3NwZWVkIGN1cl9zcGVlZDsNCj4gQEAgLTk4NCw3ICsxMDEwLDggQEAgc3RhdGlj
IGludCBydHdfdXNiX3N3aXRjaF9tb2RlKHN0cnVjdCBydHdfZGV2ICpydHdkZXYpDQo+ICB7DQo+
ICAgICAgICAgdTggaWQgPSBydHdkZXYtPmNoaXAtPmlkOw0KPiANCj4gLSAgICAgICBpZiAoaWQg
IT0gUlRXX0NISVBfVFlQRV84ODIyQyAmJiBpZCAhPSBSVFdfQ0hJUF9UWVBFXzg4MjJCKQ0KPiAr
ICAgICAgIGlmIChpZCAhPSBSVFdfQ0hJUF9UWVBFXzg4MjJDICYmIGlkICE9IFJUV19DSElQX1RZ
UEVfODgyMkIgJiYNCj4gKyAgICAgICAgICAgaWQgIT0gUlRXX0NISVBfVFlQRV84ODEyQSkNCg0K
V291bGQgaXQgYmUgY2xlYXIgdG8gbGlzdCBwb3NpdGl2ZSBjaGlwcyBpbiBhIGZ1bmN0aW9uPyBh
bmQgcmV0dXJuIG5ldy9vbGQgdHlwZQ0KY2hpcCBpcyB1c2luZyBmb3IgbGF0dGVyIGNvbmRpdGlv
bi4gDQoNCj4gICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiANCj4gICAgICAgICBpZiAoIXJ0
d2Rldi0+ZWZ1c2UudXNiX21vZGVfc3dpdGNoKSB7DQo+IEBAIC05OTksNyArMTAyNiwxMCBAQCBz
dGF0aWMgaW50IHJ0d191c2Jfc3dpdGNoX21vZGUoc3RydWN0IHJ0d19kZXYgKnJ0d2RldikNCj4g
ICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiAgICAgICAgIH0NCj4gDQo+IC0gICAgICAgcmV0
dXJuIHJ0d191c2Jfc3dpdGNoX21vZGVfbmV3KHJ0d2Rldik7DQo+ICsgICAgICAgaWYgKGlkID09
IFJUV19DSElQX1RZUEVfODgxMkEpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gcnR3X3VzYl9z
d2l0Y2hfbW9kZV9vbGQocnR3ZGV2KTsNCj4gKyAgICAgICBlbHNlIC8qIFJUTDg4MjJDVSwgUlRM
ODgyMkJVICovDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gcnR3X3VzYl9zd2l0Y2hfbW9kZV9u
ZXcocnR3ZGV2KTsNCj4gIH0NCg0KDQoNCg==

