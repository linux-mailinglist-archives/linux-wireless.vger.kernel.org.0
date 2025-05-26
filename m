Return-Path: <linux-wireless+bounces-23415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AD8AC39E4
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 08:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8DC3A7776
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 06:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF321C3C18;
	Mon, 26 May 2025 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="tAWqSAs+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2F91DD529
	for <linux-wireless@vger.kernel.org>; Mon, 26 May 2025 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748240971; cv=none; b=pz97lXADLlZ+7Xlyz5xjmPzmGkh1SH9fKJGs9BHobqWV3q8HRp8gWq8YX4MHYC4eesS/nMyRXhfz4148cRWG65wCUoGXrO21OZJl80NHT4R8uFTJhbkGIsQcwoqwXDTUXhRIO4zby5Q5HJwzq7ucilZKzbQtpfrzXfrYFKSxJEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748240971; c=relaxed/simple;
	bh=q2qQ3bBHXk9z7DPaQGQVRxTVpO7/h8xpzXndtL0DacY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ivWstnASifuRjFP70aaNQ+ErJmfJ6JFf/6LjE4eaneEAu9YSr0a/yJ2ZwZKqhca1gZNZdTFjKf25kkt8E/z9kgZ0OWz+z7sC1TsEe0Vq9uGbGiMFpSKsNqRgbZbAmEq1jsE8yMtqYDXeH2ge0r3M+wjGCzSfPc0CDBMN7pL52OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=tAWqSAs+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54Q6TNvZ43311244, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1748240963; bh=q2qQ3bBHXk9z7DPaQGQVRxTVpO7/h8xpzXndtL0DacY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=tAWqSAs+WWEMx07LTWG+4VN7H4+uJCzoruLRhl0RL3jAV0tJ95bp3G8dTvBmiXrdW
	 1Hk9bZ3eGDNm6ymTWoEulhy6DcB62Til37dKpGk8DOZE55k2YtCggOMiSz7IQjJMuf
	 akc2hgASGBetXDxro1qqNp2ONfGNnwk/wU5SYPlOTEN6M0TMYyW00So4OxtyepgUCw
	 jsOmHWGgXj0fbu0g2vnf0T0KigXW3w2D2x2i4+u6Gzutss9a31sKaItns2oAsx/AYi
	 OV1f0gI60C1XDexvqVMW90+1i5XXtvqsBUk45JOkJYl2sl4a4Ujlx9Duw2Oil4IAGV
	 9QDcJnHmb+lfw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54Q6TNvZ43311244
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 14:29:23 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 May 2025 14:29:23 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 May 2025 14:29:21 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Mon, 26 May 2025 14:29:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 05/13] wifi: rtw89: Add hfc_param_ini_usb
Thread-Topic: [PATCH rtw-next v1 05/13] wifi: rtw89: Add hfc_param_ini_usb
Thread-Index: AQHbvTZDNKnS9J5ShUCIArSJPri3ObPP7fyggBOQ6gCAAMQpYIAATPEg
Date: Mon, 26 May 2025 06:29:21 +0000
Message-ID: <14ed20822a1e4890a30965123825cb5f@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <348b0c94-2db6-4ae9-819c-6fa7f9c3ac56@gmail.com>
 <54b050dc237e46fcb96576e19451ae97@realtek.com>
 <9c3980f3-c22e-4213-bab3-15d25bdc1b59@gmail.com>
 <fc4c3f9b333a49e6bb078e7b1bd67e57@realtek.com>
In-Reply-To: <fc4c3f9b333a49e6bb078e7b1bd67e57@realtek.com>
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

UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiBCaXR0ZXJibHVlIFNt
aXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gT24gMTMvMDUvMjAyNSAw
NjoxMiwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+ID4gQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgy
MWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4+IEFkZCBoZmNfcGFyYW1faW5pX3VzYiB0
byBzdHJ1Y3QgcnR3ODlfY2hpcF9pbmZvLiBGb3Igbm93IGluaXRpYWxpc2UgaXQNCj4gPiA+PiBv
bmx5IGZvciBSVEw4ODUxQi4NCj4gPiA+Pg0KPiA+ID4+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJs
dWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiA+ID4+IC0tLQ0KPiA+ID4NCj4g
PiA+IFsuLi5dDQo+ID4gPg0KPiA+ID4NCj4gPiA+PiArDQo+ID4gPj4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgcnR3ODlfaGZjX3BhcmFtX2luaSBydHc4ODUxYl9oZmNfcGFyYW1faW5pX3VzYltdID0g
ew0KPiA+ID4+ICsgICAgICAgW1JUVzg5X1FUQV9TQ0NdID0ge3J0dzg4NTFiX2hmY19jaGNmZ191
c2IsICZydHc4ODUxYl9oZmNfcHViY2ZnX3VzYiwNCj4gPiA+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAmcnR3ODg1MWJfaGZjX3ByZWNjZmdfdXNiLCBSVFc4OV9IQ0lGQ19TVEZ9LA0KPiA+
ID4NCj4gPiA+IFtSVFc4OV9RVEFfV09XXSBpcyBtaXNzaW5nLiBJJ20gbm90IHN1cmUgaWYgY3Vy
cmVudCBjYW4gaGFuZGxlIHRoaXMgY29ycmVjdGx5Lg0KPiA+ID4gQ291bGQgeW91IHRyeSB0byBk
byBXb1dMQU4gd2l0aCBVU0I/IEF0IGxlYXN0LCBpdCBzaG91bGRuJ3QgY3Jhc2guDQo+ID4gPg0K
PiA+DQo+ID4gUlRXODlfUVRBX1dPVyBpcyBtaXNzaW5nIGJlY2F1c2UgSSBkaWRuJ3QgZmluZCBh
biBlcXVpdmFsZW50IGluDQo+ID4gZW51bSBtYWNfYXhfcXRhX21vZGUgaW4gdGhlIHZlbmRvciBk
cml2ZXIuDQo+IA0KPiBZZXMsIHZlbmRvciBkcml2ZXIgZG9lc24ndCBoYXZlIHRoYXQuIEFzIEkg
a25vdywgaXQgZG9lcyBzb21lIG1vZGlmaWNhdGlvbnMNCj4gZnJvbSBvcmlnaW5hbCBub3JtYWwg
b3BlcmF0aW9uIHF1b3RhLCBzdWNoIGFzIFJUVzg5X1FUQV9TQ0MsIGJlY2F1c2Ugd2Ugd2FudA0K
PiBjb25zdGFudCBkZWZpbml0aW9uIGluIHVwc3RyZWFtIGRyaXZlci4gSSB3aWxsIGNoZWNrIGlu
dGVybmFsbHkgYW5kIGdldCBiYWNrDQo+IHRvIHlvdSBob3cgaXQgc2hvdWxkIGJlIGZvciBVU0Ig
ZGV2aWNlcy4NCg0KVGhlIG1haW4gZnVuY3Rpb24gdG8gZ2V0IFFUQV9XT1cgaXMgcmVkdV93b3ds
YW5fcnhfcXRhKCkuIA0KDQpUYWtlIFJUTDg4NTFCRSBhcyBhbiBleGFtcGxlLCANCg0KQmFzZWQg
b24gUlRXODlfUVRBX1NDQzoNCiAgY2ZnLT5wbGVfc2l6ZS0+cGdlX3NpemUgPT5ydHc4OV9tYWNf
c2l6ZS5wbGVfc2l6ZTYNCiAgPT4ucGxlX3NpemU2ID0ge1JUVzg5X1BMRV9QR18xMjgsIDQ5Niwg
MTYsfSwNCiAgcmR1X3BnX251bSA9IFBMRV9RVEFfUEcxMjhCXzEyS0IgPSA5Ng0KDQpRVEE2Og0K
ICAucGxlX3F0MTggPSB7MTQ3LCAwLCAxNiwgMjAsIDE3LCAxMywgODksIDAsIDMyLCAxNCwgOCwg
MCx9LCAvL21pbg0KICAucGxlX3F0NTggPSB7MTQ3LCAwLCAxNiwgMjAsIDE1NywgMTMsIDIyOSwg
MCwgMTcyLCAxNCwgMjQsIDAsfSwgLy9tYXgNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF5eXl4NCiAgcXRhX21pbiA9IDg5DQogIHF0YV9tYXggPSAyMjkNCg0KICBuZXdf
cXRhID0gKHF0YV9tYXggLSBxdGFfbWluKSA8IHJkdV9wZ19udW0gPw0K4oCD4oCDICAgICAgICBx
dGFfbWluIDogKHF0YV9tYXggLSByZHVfcGdfbnVtKTsNCuKAg+KAgyAgICAgID0gMjI5IC0gOTYg
PSAxMzMNCg0KUVRBNzoNCg0KICAucGxlX3F0MTggPSB7MTQ3LCAwLCAxNiwgMjAsIDE3LCAxMywg
ODksIDAsIDMyLCAxNCwgOCwgMCx9LCAvL21pbg0KICAucGxlX3F0NTggPSB7MTQ3LCAwLCAxNiwg
MjAsIDE1NywgMTMsIDIyOSwgMCwgMTcyLCAxNCwgMjQsIDAsfSwgLy9tYXgNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eDQoNCiAgcXRhX21pbiA9IDAgDQog
IHF0YV9tYXggPSAwDQoNCiAgbmV3X3F0YSA9IChxdGFfbWF4IC0gcXRhX21pbikgPCByZHVfcGdf
bnVtID8NCiAgICAgIOKAg+KAgyAgcXRhX21pbiA6IChxdGFfbWF4IC0gcmR1X3BnX251bSk7DQri
gIPigIMgICAgICAgID0gMA0KDQpGaW5hbGx5Og0KDQogIC5wbGVfcXRfNTFiX3dvdyA9IHsxNDcs
IDAsIDE2LCAyMCwgMTU3LCAxMywgMTMzLCAwLCAxNzIsIDE0LCAyNCwgMCx9LA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXg0KDQpBIHdheSBpcyB0
byBpbmR1Y2UgdGhlIHF1b3RhIGJ5IGV5ZXMuIEFub3RoZXIgd2F5IGlzIHRvIGFkZCBkZWJ1ZyBt
ZXNzYWdlDQppbiB2ZW5kb3IgZHJpdmVyIHRvIHNob3cgdGhlc2UgcXVvdGEgLS0gdGhpcyB3b3Vs
ZCBiZSBtdWNoIHNpbXBsZXIuIA0KDQoNCg==

