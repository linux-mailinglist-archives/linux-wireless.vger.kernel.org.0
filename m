Return-Path: <linux-wireless+bounces-3271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 210E884C488
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 06:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1777282672
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 05:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EDD1CD1B;
	Wed,  7 Feb 2024 05:58:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A901CD1F;
	Wed,  7 Feb 2024 05:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707285531; cv=none; b=tV+jEMXTJQzjc8z4HA3QJ0Rgh7wg9pJYijdWsTdYzN3/KCDaA/h0xY2XtQyuqlRAw/8SfRO/Eie6XQAmevAIv/awD1ieY6Gx3JdxXw4hFztQkspRj7PpaC9zCb1Oj/Sk+BEq6VfhR9uSEBDJPYaMYHVMnP2YhSwM2njddtY0iTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707285531; c=relaxed/simple;
	bh=XMGcQPjh6pOPXJY2YkxpMCyFKlzoRerrAk1l1Y91mPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jYUF+TNuuWR6DZ7dITVeyEab+9ksr3hcwVxqWVroRFExNI7Z8B/fqPtt7Alh9qOqEyqfqITqgv22OHIpNOCQnm3s2YpOcTBVr3tPRedoF8e0SwYHwHMWy3AOXjdg0qp2AtlwZgt+Xd39YM7bJMcAN610mqeGd9AL51A0zVJVrVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4175w6IW14062988, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4175w6IW14062988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Feb 2024 13:58:08 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Wed, 7 Feb 2024 13:58:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Feb 2024 13:58:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Wed, 7 Feb 2024 13:58:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pavel Machek
	<pavel@ucw.cz>,
        =?utf-8?B?T25kxZllaiBKaXJtYW4=?= <megi@xff.cz>
Subject: RE: [PATCH 5/9] wifi: rtw88: Add rtw8703b.c
Thread-Topic: [PATCH 5/9] wifi: rtw88: Add rtw8703b.c
Thread-Index: AQHaVdEYYqBCMRgw70+09sEUFj+8t7D7CVrAgACRqoCAAOzG4IAB4Lhw
Date: Wed, 7 Feb 2024 05:58:06 +0000
Message-ID: <96b723081b434800b91abaedf1df14a8@realtek.com>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <20240202121050.977223-6-fiona.klute@gmx.de>
 <8b20f91585694702bac414680ba937c9@realtek.com>
 <09d93cef-5338-4463-b656-dab934029c63@gmx.de>
 <28c1571cc90b49ce928ddb929e2bc93f@realtek.com>
In-Reply-To: <28c1571cc90b49ce928ddb929e2bc93f@realtek.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGluZy1LZSBTaGloIDxw
a3NoaWhAcmVhbHRlay5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDYsIDIwMjQgOToz
OCBBTQ0KPiBUbzogRmlvbmEgS2x1dGUgPGZpb25hLmtsdXRlQGdteC5kZT47IGxpbnV4LXdpcmVs
ZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz47
IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsgbGludXgtbW1jQHZnZXIua2Vy
bmVsLm9yZzsgUGF2ZWwNCj4gTWFjaGVrIDxwYXZlbEB1Y3cuY3o+OyBPbmTFmWVqIEppcm1hbiA8
bWVnaUB4ZmYuY3o+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggNS85XSB3aWZpOiBydHc4ODogQWRk
IHJ0dzg3MDNiLmMNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+IEZyb206IEZpb25hIEtsdXRlIDxmaW9uYS5rbHV0ZUBnbXguZGU+DQo+ID4gU2VudDogVHVl
c2RheSwgRmVicnVhcnkgNiwgMjAyNCAzOjA2IEFNDQo+ID4gVG86IFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPjsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+ID4gQ2M6
IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+OyBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25A
bGluYXJvLm9yZz47IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IFBhdmVsDQo+ID4gTWFj
aGVrIDxwYXZlbEB1Y3cuY3o+OyBPbmTFmWVqIEppcm1hbiA8bWVnaUB4ZmYuY3o+DQo+ID4gU3Vi
amVjdDogUmU6IFtQQVRDSCA1LzldIHdpZmk6IHJ0dzg4OiBBZGQgcnR3ODcwM2IuYw0KPiA+DQo+
ID4gPj4gKw0KPiA+ID4+ICsgICAgICAgaWYgKHJldCAhPSAwKQ0KPiA+ID4+ICsgICAgICAgICAg
ICAgICByZXR1cm4gcmV0Ow0KPiA+ID4+ICsNCj4gPiA+PiArI2lmZGVmIENPTkZJR19PRg0KPiA+
ID4+ICsgICAgICAgLyogUHJlZmVyIE1BQyBmcm9tIERULCBpZiBhdmFpbGFibGUuIE9uIHNvbWUg
ZGV2aWNlcyBsaWtlIHRoZQ0KPiA+ID4+ICsgICAgICAgICogUGluZXBob25lIHRoYXQgbWlnaHQg
YmUgdGhlIG9ubHkgd2F5IHRvIGdldCBhIHZhbGlkIE1BQy4NCj4gPiA+PiArICAgICAgICAqLw0K
PiA+ID4+ICsgICAgICAgc3RydWN0IGRldmljZV9ub2RlICpub2RlID0gcnR3ZGV2LT5kZXYtPm9m
X25vZGU7DQo+ID4gPg0KPiA+ID4gU2hvdWxkIG1vdmUgdGhpcyBzdGF0ZW1lbnQgdG8gdG9wbW9z
dCBvZiB0aGlzIGZ1bmN0aW9uPyBubyBjb21waWxlciB3YXJuaW5nPw0KPiA+ID4NCj4gPiA+IE9y
LCBtYWtlIGFuIGluZGl2aWR1YWwgZnVuY3Rpb24gdG8gcmVhZCBtYWMgYWRkciBmcm9tIERUPw0K
PiA+DQo+ID4gSSBjYW4gbW92ZSB0aGF0IHRvIGEgc2VwYXJhdGUgZnVuY3Rpb24gaWYgeW91IHBy
ZWZlciwgc2VlIGJlbG93IGZvciB0aGUNCj4gPiBjb21waWxlciB3YXJuaW5nLg0KPiANCj4gQmVj
YXVzZSB0aGlzIGlzIENPTkZJR19PRiBjaHVuaywgaXQgd2lsbCBsb29rIGxpa2UgYmVsb3cgaWYg
eW91IG1vdmUgZGVjbGFyYXRpb24gdXB3YXJkOg0KPiANCj4gI2lmZGVmIENPTkZJR19PRg0KPiAJ
c3RydWN0IGRldmljZV9ub2RlICpub2RlID0gcnR3ZGV2LT5kZXYtPm9mX25vZGU7DQo+ICNlbmRp
Zg0KPiAJLy8gb3RoZXIgZGVjbGFyYXRpb24gLi4uDQo+IA0KPiAJLy8gb3RoZXIgY29kZQ0KPiAj
aWZkZWYgQ09ORklHX09GDQo+IAlpZiAobm9kZSkgew0KPiAJCS4uLg0KPiAJfQ0KPiAjZW5kaWYN
Cj4gDQo+IEl0IHNlZW1zIGxpa2UgdG9vIG11Y2ggI2lmZGVmLiBXaXRoIGEgc2VwYXJhdGUgZnVu
Y3Rpb24sIGl0IGNhbiBiZSBzaW5nbGUgI2lmZGVmLg0KPiBUaGF0IGlzIG15IHBvaW50Lg0KPiAN
Cg0KSWYgQ09ORklHX09GIGlzbid0IGRlZmluZWQsIGNvbXBpbGVyIHdpbGwgc2VsZWN0IGEgc3Rh
dGljIGlubGluZSBmdW5jdGlvbiB0aGF0DQpqdXN0IHJldHVybnMgLUVOT0RFViBbMV0sIHNvIEkg
dGhpbmsgeW91IGRvbid0IG5lZWQgYSAjaWZkZWYgY2h1bmsgaGVyZS4gDQoNClsxXSBodHRwczov
L2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2luY2x1ZGUvbGludXgvb2Zf
bmV0LmgjTDI3DQoNCg0KDQo=

