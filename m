Return-Path: <linux-wireless+bounces-22890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E543DAB4A3E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 05:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF801744A5
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 03:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4617C146A66;
	Tue, 13 May 2025 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GyzgEuQg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B559978F4B
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 03:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747108228; cv=none; b=NwNeq/u1A4EWnjcF9gIoJbd4l0zfEGFuOnDcvWx/Uc2MZaPeOycJGwrdlslpUVltAsxZkFL9sv2E2M9C+7WyZK9vAAEayNrwYHs1s9rTxA5HUfgQWs6+K5ahdvKhk/OdJ+XQKDJ4ZMDlm4RKS2ZAHASB4GhlHEMaXVTtzaeIeb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747108228; c=relaxed/simple;
	bh=kEW8Mu9T6TJJ9oNgPQsz9XZaBI7Z/0Fzd1AGY0XeYAc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NAGn9ICOIEqULVcwMVTf1jrY+absi8fo6PLb9zYMu+NK0WFC0lAnmL7hd0AqAgfYSb1oHStu9fofDP6MksH4QSMbT1noAZGs84qym1rMcpp+LffvbZOzZx7lw7CzrOfsPQSDI1QJiNm7ORiCWItWRDcI4E1tYj5gYI8st24ul2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GyzgEuQg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54D3oLgL53626445, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747108221; bh=kEW8Mu9T6TJJ9oNgPQsz9XZaBI7Z/0Fzd1AGY0XeYAc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GyzgEuQgSRxxnIZLIodfiInHyCbg4BsxqXf3jdCNosqjRqNppJhyy97dqtlIZNx7J
	 iOxAkFjk41jaoZ+R4AJZta6KbJL4PVrQizoV5oerHfiR7NPXiaEOaLQ8LN4yN7Al7G
	 uO4pG2heuUYIq/h1o/uHfatBDA6JglvCR20zPOKHnEu5KZMhMH0Ib4cuaJHJh4I5mi
	 Wuy8PsPBhQYCnUbO8JA/Ray4NSYFGF4LoNYB5FWDZ8akHAlh6q3+3Syay3NA2DDWQ6
	 FlYgaru84Chl3bTCvr3v2+OWh+8VsQYaLzRkx/Ydf/mtONkbZmJ+ExniNUJb5t+2RA
	 D+c5iHy+EuEDQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54D3oLgL53626445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 11:50:21 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 11:50:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 May 2025 11:50:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 13 May 2025 11:50:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 09/13] wifi: rtw89: Fix rtw89_mac_power_switch() for USB
Thread-Topic: [PATCH rtw-next v1 09/13] wifi: rtw89: Fix
 rtw89_mac_power_switch() for USB
Thread-Index: AQHbvTaHijGDU5ebekWFF2h6IOIwyLPP+F+A
Date: Tue, 13 May 2025 03:50:21 +0000
Message-ID: <87a865d6dfc647cd8e14118904cb5d07@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <3df912fb-3a56-40d7-940f-c82a23212adc@gmail.com>
In-Reply-To: <3df912fb-3a56-40d7-940f-c82a23212adc@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBDbGVh
ciBzb21lIGJpdHMgaW4gc29tZSByZWdpc3RlcnMgaW4gb3JkZXIgdG8gYWxsb3cgUlRMODg1MUJV
IHRvIHBvd2VyDQo+IG9uLiBBbHNvIHRlc3RlZCB3aXRoIFJUTDg4MzJCVSBhbmQgUlRMODgzMkNV
Lg0KDQpJIHNlZSBtYWNfcHdyX29uX3BjaWVfODg1MWIoKSBhbmQgbWFjX3B3cl9vbl91c2JfODg1
MWIoKSBhdCBsZWFzdCBpbg0KdmVuZG9yIGRyaXZlci4gSWYgeW91IHVzZSB0aGUgcG93ZXIgb24v
b2ZmIGZ1bmN0aW9ucyBmb3IgVVNCIGRldmljZXMsDQp0aGUgcHJvYmxlbSBtYXkgZGlzYXBwZWFy
LiANCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZl
MkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4
OS9tYWMuYyB8IDggKysrKysrKysNCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODkvcmVnLmggfCAxICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMNCj4gaW5kZXggOTlmMDFm
ZmY5MGZlLi5kM2NmNjdkZmFiYzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnR3ODkvbWFjLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydHc4OS9tYWMuYw0KPiBAQCAtMTQ1OCw2ICsxNDU4LDE0IEBAIHN0YXRpYyBpbnQgcnR3ODlf
bWFjX3Bvd2VyX3N3aXRjaChzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsIGJvb2wgb24pDQo+ICAg
ICAgICAgaW50IHJldDsNCj4gICAgICAgICB1OCB2YWw7DQo+IA0KPiArICAgICAgIGlmIChydHdk
ZXYtPmhjaS50eXBlID09IFJUVzg5X0hDSV9UWVBFX1VTQiAmJg0KPiArICAgICAgICAgICBydHc4
OV9yZWFkMzJfbWFzayhydHdkZXYsIFJfQVhfR1BJT19NVVhDRkcsIEJfQVhfQk9PVF9NT0RFKSkg
ew0KDQpOb3QgcHJlZmVyIGNhbGxpbmcgYSBmdW5jdGlvbiBpbiBpZi1zdGF0ZW1lbnQuIFN1Z2dl
c3QgdG8gYWRkIGEgZnVuY3Rpb24uIA0KDQo+ICsgICAgICAgICAgICAgICBydHc4OV93cml0ZTMy
X2NscihydHdkZXYsIFJfQVhfU1lTX1BXX0NUUkwsIEJfQVhfQVBGTl9PTk1BQyk7DQo+ICsgICAg
ICAgICAgICAgICBydHc4OV93cml0ZTMyX2NscihydHdkZXYsIFJfQVhfU1lTX1NUQVRVUzEsIEJf
QVhfQVVUT19XTFBPTik7DQo+ICsgICAgICAgICAgICAgICBydHc4OV93cml0ZTMyX2NscihydHdk
ZXYsIFJfQVhfR1BJT19NVVhDRkcsIEJfQVhfQk9PVF9NT0RFKTsNCj4gKyAgICAgICAgICAgICAg
IHJ0dzg5X3dyaXRlMzJfY2xyKHJ0d2RldiwgUl9BWF9SU1ZfQ1RSTCwgQl9BWF9SX0RJU19QUlNU
KTsNCj4gKyAgICAgICB9DQo+ICsNCj4gICAgICAgICBpZiAob24pIHsNCj4gICAgICAgICAgICAg
ICAgIGNmZ19zZXEgPSBjaGlwLT5wd3Jfb25fc2VxOw0KPiAgICAgICAgICAgICAgICAgY2ZnX2Z1
bmMgPSBjaGlwLT5vcHMtPnB3cl9vbl9mdW5jOw0KDQo=

