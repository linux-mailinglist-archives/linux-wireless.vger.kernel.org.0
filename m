Return-Path: <linux-wireless+bounces-10089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B680E92AD6C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 02:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 583CEB20EB1
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 00:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F871EA8D;
	Tue,  9 Jul 2024 00:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="uJQC+hmL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC01EA80
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 00:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720486563; cv=none; b=DLjPNosETBYcKdFLFYaUhB2EcVBpCQO3o06zFpPVRAa5B9oWkTkl8TToJxBnj1bi59d0QxatMNBjQy/Kb8FIK73/45zhVAbBARKmd85VOYhw15ZoaoupmAS4HOAWCkchipyHXEv3m238MjO5zGHWJy27VkcOs3vmTHEUqkpXhSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720486563; c=relaxed/simple;
	bh=FcnvQ7m4iazgdxoorrp9VnTJR4kgFjdT5sATXh72ApI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aVFXZ8G6DzMyNrsRSpFj9hMX208utOJzkP5LRdwsmpVazIdo1GhffNckEEXKy+wTbnVDiDjs4j/HRJUEbvSBV+swg3pJ1H3u+sDs5RvM382LZMpz/bCio0ssQ1gDKJa+oWTaZPHXj1xPGc+I4dRpqulFu9+g2jehDv92pXoY9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=uJQC+hmL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4690to2uB068716, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720486550; bh=FcnvQ7m4iazgdxoorrp9VnTJR4kgFjdT5sATXh72ApI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=uJQC+hmLlhsmLzbx92dbw11WpCvcMd0tKwtPVfNIsExA7t0Fe+JBB1ea955Oo3n4i
	 ByDMead341kQH9VRjnll8+zu/YTIQ0L5UXgkuD+HmFBN/YBM/NVyLOuDvTM0ensWRL
	 vk7T5ejsKjZYoqs4AUqqB59XBMOHni3A0y5+cQhOlN2BQYH8Yjp/sS//nEVCMScOMl
	 FzK+yi8xQDa0m/xBsvkhW/uiROd8NCsnsVrNgn5b7vMQx45sBeFMq3vXncBhC0jcBU
	 j0OTcBBWISIxbiJPXNksClzuvYviQSa0xWL3M5BQ/beN0oRnHzwNgc+m5TUAu2zqFl
	 Z4NZLtzu+lPJQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4690to2uB068716
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 08:55:50 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 08:55:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jul 2024 08:55:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 9 Jul 2024 08:55:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>
Subject: RE: [PATCH] wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU
Thread-Topic: [PATCH] wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU
Thread-Index: AQHazyw5zmbg866JN0qvS/PnzliO+bHsjRUA//+yX4CAAVWigA==
Date: Tue, 9 Jul 2024 00:55:50 +0000
Message-ID: <57eec7c0f23b40059840086066ed74be@realtek.com>
References: <2378105e-041a-4973-937f-e3efdc9ce0e8@gmail.com>
 <a60a7a6d0ab04b3ab1690a2c473b8e69@realtek.com>
 <3f2900e7-9a98-4bc9-bc0d-631dd9de7da0@gmail.com>
In-Reply-To: <3f2900e7-9a98-4bc9-bc0d-631dd9de7da0@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAw
OC8wNy8yMDI0IDEyOjE5LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBAQCAtODk2LDYgKzk3Miwx
NCBAQCBpbnQgcnR3X3VzYl9wcm9iZShzdHJ1Y3QgdXNiX2ludGVyZmFjZSAqaW50ZiwgY29uc3Qg
c3RydWN0IHVzYl9kZXZpY2VfaWQgKmlkKQ0KPiA+PiAgICAgICAgICAgICAgICAgZ290byBlcnJf
ZGVzdHJveV9yeHdxOw0KPiA+PiAgICAgICAgIH0NCj4gPj4NCj4gPj4gKyAgICAgICByZXQgPSBy
dHdfdXNiX3N3aXRjaF9tb2RlKHJ0d2Rldik7DQo+ID4+ICsgICAgICAgaWYgKHJldCkgew0KPiA+
PiArICAgICAgICAgICAgICAgLyogTm90IGEgZmFpbCwgYnV0IHdlIGRvIG5lZWQgdG8gc2tpcCBy
dHdfcmVnaXN0ZXJfaHcuICovDQo+ID4+ICsgICAgICAgICAgICAgICBydHdfaW5mbyhydHdkZXYs
ICJzd2l0Y2hpbmcgdG8gVVNCIDMgbW9kZVxuIik7DQo+ID4NCj4gPiBBbGwgbG9ncyBpbiB0aGlz
IHBhdGNoZXMgc2hvdWxkIGJlIHJ0d19kYmcoKSwgYmVjYXVzZSB0aGVzZSBtZXNzYWdlcyBhcmUg
bm90DQo+ID4gaW1wb3J0YW50IHRvIHVzZXJzLg0KPiA+DQo+IA0KPiBPa2F5LCBJIHdpbGwgYWRk
IFJUV19EQkdfVVNCIHRvIGVudW0gcnR3X2RlYnVnX21hc2suDQo+IA0KPiA+DQo+ID4+ICsgICAg
ICAgICAgICAgICByZXQgPSAwOw0KDQpJIG1pc3NlZCB0aGlzIHBvaW50ICJyZXQgPSAwIiB0aGF0
IHJ0d191c2JfZGlzY29ubmVjdCgpIHdpbGwgYmUgY2FsbGVkIHdoZW4NClVTQiBkaXNjb25uZWN0
LiBDYW4ndCB3ZSBqdXN0IHJldHVybiBhbiBlcnJvciBjb2RlPyBhbnkgbmVnYXRpdmUgZWZmZWN0
Pw0KDQpNeSBwb2ludCBpcyB0byBhdm9pZCBjYWxsaW5nIHJ0d191c2JfZGlzY29ubmVjdCgpIGZv
ciB0aGUgY2FzZSBvZiBzd2l0Y2hpbmcNClVTQiAzLCBiZWNhdXNlIGFsbCBzdHVmZnMgaGF2ZSBi
ZWVuIGZyZWVkIGJ5IGZvbGxvd2luZyBlcnJvciBoYW5kbGVzLiANCg0KPiA+PiArICAgICAgICAg
ICAgICAgZ290byBlcnJfZGVzdHJveV9yeHdxOw0KPiA+PiArICAgICAgIH0NCj4gPj4gKw0KPiA+
PiAgICAgICAgIHJldCA9IHJ0d19yZWdpc3Rlcl9odyhydHdkZXYsIHJ0d2Rldi0+aHcpOw0KPiA+
PiAgICAgICAgIGlmIChyZXQpIHsNCj4gPj4gICAgICAgICAgICAgICAgIHJ0d19lcnIocnR3ZGV2
LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIGh3XG4iKTsNCj4gPj4gLS0NCj4gPj4gMi40NS4xDQo+ID4N
Cg0K

