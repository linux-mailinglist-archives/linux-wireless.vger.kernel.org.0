Return-Path: <linux-wireless+bounces-16637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2053E9F88D7
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 01:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D7A165BA4
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 00:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9160ECC;
	Fri, 20 Dec 2024 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="fn4XFfp+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C743DEC4
	for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 00:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734653621; cv=none; b=OlJsyPOj88bEe57HA29bINww8skvf0xFQu02OApjoJlqxhulnVRqodlaYvNk1pezWqc5xtvxc48bkHctmphN3/NnT5y7aeNoHhYafd/mCKG45lGbPg4h8oKb32WhjZtBF8Km2W/a8JdbUjFMA4EzSmGdw5YB6LGmcany4lqOH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734653621; c=relaxed/simple;
	bh=9tY/oDP09Glu6Qjcf9YL6uWnWqofbpQwo1Eagxy123M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EMU/Eb6f6F31OSdD5ndnW/H99zJanX4fuU269Bc1Q/m5gRhO5QemMtcP7Bf19R3R3xNEFI1FqSnFHjGUK8ddpDyB69aYfOaIM62jZKycYCohU7tInirUm/fX4BArY0nImws1N84bbY4oZRRhgjm9tTvIDXy9gpEXIkcsOJAdQ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=fn4XFfp+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BK0DN300579105, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734653603; bh=9tY/oDP09Glu6Qjcf9YL6uWnWqofbpQwo1Eagxy123M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fn4XFfp+g6gXn2R100c5cH5AzRdQuzqAMZJH/ppwkF6ACGfR+Ojrz8myfncP7AuGE
	 n0F04tNQYyQpETv2rfOymkx3T+i7Sv0swmKj1/l4KuiGepGin3duVI8KBbogEYRGgk
	 NG+DTAVyXfkVjRrp121I5zukKCnjhQ6eK4EHZgVbCzVJFZahjJQfCgFO3hZey7HXYX
	 w8dV4iGGGSs2k4iwdp7ThLlhKO5Ky7ZRZ3hI6i4UA9I8PwpGaDJ9tglg/Uc1mEGZnj
	 BGoDeTxc+t2F9AniAwnm1MUaw3IMSS3maBEHQyhaRL9pNga6vRXq1sJuBMPMWcxzMy
	 8G0eoZfGozejg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BK0DN300579105
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Dec 2024 08:13:23 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Dec 2024 08:13:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 20 Dec 2024 08:13:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 20 Dec 2024 08:13:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH v2 1/3] wifi: rtw88: usb: Copy instead of cloning the RX skb
Thread-Topic: [PATCH v2 1/3] wifi: rtw88: usb: Copy instead of cloning the RX
 skb
Thread-Index: AQHbUZzcrmQVskseOke32iJUF4a4cLLtF2fw///NzoCAAV9fcA==
Date: Fri, 20 Dec 2024 00:13:23 +0000
Message-ID: <6aa9254f7ee84c289527e6e205d52bcb@realtek.com>
References: <8c9d4f9d-ebd8-4dc0-a0c4-9ebe430521dd@gmail.com>
 <7c4a0c905cec4bf4ba8c3bab78342196@realtek.com>
 <d7adb319-8840-47a3-b17c-87d9dd45f32f@gmail.com>
In-Reply-To: <d7adb319-8840-47a3-b17c-87d9dd45f32f@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
T24gMTkvMTIvMjAyNCAwODoxNywgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IEJpdHRlcmJsdWUg
U21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+PiArICAgICAg
ICAgICAgICAgICAgICAgICBza2IgPSBhbGxvY19za2Ioc2tiX2xlbiwgR0ZQX0tFUk5FTCk7DQo+
ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICghc2tiKSB7DQo+ID4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcnR3X2RiZyhydHdkZXYsIFJUV19EQkdfVVNCLA0KPiA+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImZhaWxlZCB0byBhbGxvY2F0
ZSBSWCBza2Igb2Ygc2l6ZSAldVxuIiwNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNrYl9sZW4pOw0KPiA+DQo+ID4gY2hlY2twYXRjaCB3YXJucyB0aGlzIGlz
IHVubmVjZXNzYXJ5Lg0KPiA+DQo+ID4gV0FSTklORzogUG9zc2libGUgdW5uZWNlc3NhcnkgJ291
dCBvZiBtZW1vcnknIG1lc3NhZ2UNCj4gPiAjOTQ6IEZJTEU6IGRyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnR3ODgvdXNiLmM6NTkxOg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlm
ICghc2tiKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBydHdfZGJnKHJ0
d2RldiwgUlRXX0RCR19VU0IsDQo+ID4NCj4gPg0KPiA+DQo+IA0KPiBjaGVja3BhdGNoIGlzIHdy
b25nIGFib3V0IHRoaXMgb25lLiBhbGxvY19za2IgZG9lc24ndCBzYXkNCj4gYW55dGhpbmcgd2hl
biBpdCBmYWlscy4NCg0KR290IGl0LiBUaGVuDQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

