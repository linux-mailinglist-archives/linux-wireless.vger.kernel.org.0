Return-Path: <linux-wireless+bounces-24111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACCCADA581
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 03:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A9216CE82
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 01:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E59F3595A;
	Mon, 16 Jun 2025 01:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aW/H+muK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B0929408
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 01:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037193; cv=none; b=FFADKtDkA0GRXSeKq19RU/t4LHA7IHtcDxE8RVEuRyg6QUbZkQl5Wyzrb/ZuAl4Zdpnvi+FaD0cR8gameDlI9A/BNYQJ3s1eGsgiVXX/mW3QDlhUsCM22i6kurtvpaNsPwe1P9lQaluZuI7JSGJpI6Yl40utWWTkgVbnnIwkhg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037193; c=relaxed/simple;
	bh=tzJe2NoCMLfw3HF8nva4V+1Fp9oBzlcmGkYgZj/GVSE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JXI6HrYce4nmwfDi7jcIceM0WOO/OSPOdo/XyUrVk7EJTCbYAbaabLh1dP7VtwafrfHs93NeMAcLZNT7RnYgIRDYibJM5CpKGrE11xXXMl301odpx6L4o+e5FHsA/RXxDK1uSqAoTop6fUK1qJs1Govv5bzKPOJVRvAM/Yt29Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aW/H+muK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G1QQklC3798667, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750037186; bh=tzJe2NoCMLfw3HF8nva4V+1Fp9oBzlcmGkYgZj/GVSE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=aW/H+muKaX/tJAJZiyapO3Tp0DnaruqquZd4/xXhfRuWeTJBeU5J86JpxiWvecQ0m
	 U001v3SwowLE+dzsENppZ69ksd8kY1+vgi3GrVFZYmouR4b6tannlq+1DqJMfQ7VWX
	 fejqKtKwaJCj8FdiaRuXNI1urfuwWDNsHWj/TLmg4RBCDArQ+ps84hRg1fUgn8ETHF
	 w3tJ7TeU3YMmFUJuGWSJ5Mc5JKkZlcOJPvhVLnGT0zUdmpuXq9AGpMljbbOpv0P1DU
	 6Pcvdl7S4ZvnmgNhW64CSy95SOY1mcHWKgVCSYYxFo0Hlwvv9wtPEul+kZD4V4lqI3
	 nXk8uBn1P+wYg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G1QQklC3798667
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 09:26:26 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 09:26:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 16 Jun 2025 09:26:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 16 Jun 2025 09:26:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 03/14] wifi: rtw89: Make hfc_param_ini in rtw89_chip_info an array
Thread-Topic: [PATCH rtw-next v2 03/14] wifi: rtw89: Make hfc_param_ini in
 rtw89_chip_info an array
Thread-Index: AQHb2XRJk1S/xhBh70aY2evTrQI6trQFBhRA
Date: Mon, 16 Jun 2025 01:26:25 +0000
Message-ID: <646f0e43faad458493a3f060e623232d@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
 <7e05e8a7-d7cd-4cc2-87c5-143ba30e8c54@gmail.com>
In-Reply-To: <7e05e8a7-d7cd-4cc2-87c5-143ba30e8c54@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBVU0Ig
YW5kIFNESU8gd2lsbCBuZWVkIGRpZmZlcmVudCBzZXRzIG9mIHZhbHVlcywgc28gbWFrZSBoZmNf
cGFyYW1faW5pDQo+IGluIHN0cnVjdCBydHc4OV9jaGlwX2luZm8gYW4gYXJyYXkuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4N
Cg0KWy4uLl0NCg0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg5L21hYy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYw0K
PiBpbmRleCAyZWU3NjZlMzczMjIuLjBhMzYwM2YyZTZiZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYw0KPiArKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5jDQo+IEBAIC04ODEsMTMgKzg4MSwxNCBAQCBzdGF0
aWMgaW50IGhmY19yZXNldF9wYXJhbShzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYpDQoNCkJ5IHRo
ZSB3YXksIHBsZWFzZSBoZWxwIHRvIHJlbW92ZSB0aGUgaW5pdGlhbGl6ZXIgb2YgcGFyYW1faW5p
LCB3aGljaCBpcyB3ZWlyZA0KYW5kIHVubmVjZXNzYXJ5Og0KDQogICBzdHJ1Y3QgcnR3ODlfaGZj
X3BhcmFtX2luaSBwYXJhbV9pbmkgPSB7TlVMTH07DQoNCj4gDQo+ICAgICAgICAgc3dpdGNoIChy
dHdkZXYtPmhjaS50eXBlKSB7DQo+ICAgICAgICAgY2FzZSBSVFc4OV9IQ0lfVFlQRV9QQ0lFOg0K
PiAtICAgICAgICAgICAgICAgcGFyYW1faW5pID0gcnR3ZGV2LT5jaGlwLT5oZmNfcGFyYW1faW5p
W3F0YV9tb2RlXTsNCj4gLSAgICAgICAgICAgICAgIHBhcmFtLT5lbiA9IDA7DQo+ICAgICAgICAg
ICAgICAgICBicmVhazsNCj4gICAgICAgICBkZWZhdWx0Og0KPiAgICAgICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQo+ICAgICAgICAgfQ0KPiANCj4gKyAgICAgICBwYXJhbV9pbmkgPSBydHdk
ZXYtPmNoaXAtPmhmY19wYXJhbV9pbmlbcnR3ZGV2LT5oY2kudHlwZV1bcXRhX21vZGVdOw0KDQpM
aWtlIHBhdGNoIDAyLzE0LCB3ZSBjYW4gcmVtb3ZlIHN3aXRjaC4uLmNhc2UgYWJvdmUsIGFuZCBj
aGVjayANCnJ0d2Rldi0+Y2hpcC0+aGZjX3BhcmFtX2luaVtydHdkZXYtPmhjaS50eXBlXSB0byBr
bm93IGlmIHdlIGNhbiBzdXBwb3J0DQpjZXJ0YWluIEhDSSwgbGlrZQ0KDQpwYXJhbV9pbmlzID0g
cnR3ZGV2LT5jaGlwLT5oZmNfcGFyYW1faW5pW3J0d2Rldi0+aGNpLnR5cGVdOw0KaWYgKCFwYXJh
bV9pbmlzKQ0KICAgIHJldHVybiAtRUlOVkFMOw0KDQpwYXJhbV9pbmkgPSBwYXJhbV9pbmlzW3F0
YV9tb2RlXTsNCg0KDQo+ICsgICAgICAgcGFyYW0tPmVuID0gMDsNCj4gKw0KPiAgICAgICAgIGlm
IChwYXJhbV9pbmkucHViX2NmZykNCj4gICAgICAgICAgICAgICAgIHBhcmFtLT5wdWJfY2ZnID0g
KnBhcmFtX2luaS5wdWJfY2ZnOw0KPiANCg0KDQo=

