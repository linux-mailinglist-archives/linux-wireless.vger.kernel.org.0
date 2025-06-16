Return-Path: <linux-wireless+bounces-24113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECB9ADA5A9
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 03:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D707A7091
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 01:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD961B4231;
	Mon, 16 Jun 2025 01:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vEuRXPgY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6233928137C
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037579; cv=none; b=JBItAGqA5VnLuh43T7GiphY32mc/Z0RfB0QuMpghHzvXogu8Dh0eql5f0eMByCe7qPTTRBJv3jRprfwdc3sFRtY595Poec02cG9VopO+OKYYZLl8xEVh3JAY1199Srf9VHbTo9owvfKYOukiiu8sLgw3W3fttg9OUeJQ7qex9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037579; c=relaxed/simple;
	bh=Ej68rMNPS9xtGR0wA5gfuTM3NMqn/L4c6urPcLEyIvE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VOwunsMzKn+XfNWKKeBYaw/bNZadExyyg6aJvMoD3zEy+AhqMwIprZbs04SYSVdN4TFNmsUJIfx6UOCYuaYRiD23dLJkuu46HugSinhQaDmSV1H0nDc5aKCNrwJip+0XImC9VLOsKDAee2PdkB/RAlEKrBjwGuKyzN/NAdgavvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vEuRXPgY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G1Wrg363817606, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750037573; bh=Ej68rMNPS9xtGR0wA5gfuTM3NMqn/L4c6urPcLEyIvE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=vEuRXPgY/idWBgZKDt82MNVkZEKanxhUEOK1FlQuUPW/I0j9VzNje2cZ5XWfgaq8E
	 udqtWv4UJNaw5d5JgtiAHFH8xSHTRdGbK/EUNnOfN2XGAZG/O6cb3oDeLIp+HzymAy
	 FP0B1qKN9PlDh+MZgVM1pSIF/jddFJP1wltKFwP1pTUD7kqq70yABWtNm0I5ro+MOv
	 ZP6gTOEy07jos1Qnv15y7fcJUk7IyrxmqCI+pYLiaSWDVqkOVRwystIxQvUVbHOsXc
	 SLYA5ReJLRzGdyE5/dZJipQfHrSOdlSVaR2uvr9zW6aGbRUrgVlDJf6GbAOfCQm2Ra
	 hQnuyNdpbaNcQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G1Wrg363817606
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 09:32:53 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 09:32:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 16 Jun 2025 09:32:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 16 Jun 2025 09:32:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 05/14] wifi: rtw89: Add rtw8851b_hfc_param_ini_usb
Thread-Topic: [PATCH rtw-next v2 05/14] wifi: rtw89: Add
 rtw8851b_hfc_param_ini_usb
Thread-Index: AQHb2XSRM2Pvl+vbAEKfgBo0IcBoKLQFCTAQ
Date: Mon, 16 Jun 2025 01:32:47 +0000
Message-ID: <d79eedcbd75343df908f372aed1f86fe@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
 <e088be63-97a5-4b07-bed9-b8eac50f2ee9@gmail.com>
In-Reply-To: <e088be63-97a5-4b07-bed9-b8eac50f2ee9@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiAiaGZj
IiBzZWVtcyB0byBtZWFuICJoY2kgZmMiIHdoaWNoIG1heSBiZSAiSG9zdCBDb250cm9sIEludGVy
ZmFjZSBGbG93DQo+IENvbnRyb2wiLiANCg0KWWVzLCBpdCBpcy4gSnVzdCBtZW50aW9uIGl0IGlu
IGNlcnRhaW4gdGVuc2UuIA0KDQo+IFRoZXNlIGFyZSBzb21lIHBhcmFtZXRlcnMgbmVlZGVkIGZv
ciBSVEw4ODUxQlUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4
ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJl
YWx0ZWsuY29tPg0KDQoNCj4gLS0tDQo+IHYyOg0KPiAgLSBBZGFwdCB0byB0aGUgY2hhbmdlcyBp
biBwYXRjaCAzLg0KPiAgLSBBZGQgbW9yZSBpbmZvcm1hdGlvbiBpbiB0aGUgY29tbWl0IG1lc3Nh
Z2UuDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYyAg
ICAgIHwgIDEgKw0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9ydHc4ODUx
Yi5jIHwgNDYgKysrKysrKysrKysrKysrKysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0NiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODkvbWFjLmMNCj4gaW5kZXggOWNhODhhMjkzZjk5Li43ZjNjODE2ZDQ3MDQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMNCj4gKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYw0KPiBAQCAtODgxLDYg
Kzg4MSw3IEBAIHN0YXRpYyBpbnQgaGZjX3Jlc2V0X3BhcmFtKHN0cnVjdCBydHc4OV9kZXYgKnJ0
d2RldikNCj4gDQo+ICAgICAgICAgc3dpdGNoIChydHdkZXYtPmhjaS50eXBlKSB7DQo+ICAgICAg
ICAgY2FzZSBSVFc4OV9IQ0lfVFlQRV9QQ0lFOg0KPiArICAgICAgIGNhc2UgUlRXODlfSENJX1RZ
UEVfVVNCOg0KDQpMaWtlIEkgbWVudGlvbiBpbiBwYXRjaCAwMy8xNCwgeW91IHdpbGwgbm8gbmVl
ZCB0byBhZGQgdGhpcy4gDQoNCj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgIGRl
ZmF1bHQ6DQo+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCg0KDQo=

