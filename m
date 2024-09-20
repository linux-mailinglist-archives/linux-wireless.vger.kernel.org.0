Return-Path: <linux-wireless+bounces-13029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E28797CFDF
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 04:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EF8EB20FFC
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 02:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F25C10F2;
	Fri, 20 Sep 2024 02:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="se90xW0y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C51382
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726798902; cv=none; b=OMvj7sSrwf2qtbBwVROsj2a27eytbDBGAhYjAHuCxp0FBGw2eVpLPtbJRpPdRYC6ZeB3c8+Pwwn7h+J/66lmYnK+CR4UIlT7zGeeaSm5wzADKzUlsOdkUgSQOIxEqF2AgKqVcxt4/jGBM2+X24f7jqekcopYnnZtL3TdSjtbVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726798902; c=relaxed/simple;
	bh=8HmXb0HgK8a3neNTk72Bfnl4lHPM0QB4PaNxssjHrPk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l2MufQVrLMvt0GdlzhIBw4/Z0npwq1stor1fmK/IiiBItcl6xkkuVjoOWe++NMj5HgUNiHwoxpQQdslihEn1sepamdQ7Kvl86xfHX168/rflRu+boIvNSkET7IpW5V9916LWhxMjtB0E8sDz+XXgoM2lIsD27o7anR9/rAtwz48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=se90xW0y; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48K2LYXs8426393, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726798894; bh=8HmXb0HgK8a3neNTk72Bfnl4lHPM0QB4PaNxssjHrPk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=se90xW0y3Aj0sWuyI69Y/51r33i6/xcEAJQ7akTOht3d1VCAwOF9WxA4zscxMewKP
	 N5djYGvcNYNDweB1yptKO1p4XwOC7kbjku50j2NUJT8Ku9jjUbDGqbOhjz4KLJ3ANZ
	 addekJ/yytLDkyuhj9+CobFP1GrWZR9LWZWcWBhmirVrDDenFSpWtMFmJ0FTU+zVJV
	 lBjrR21AIlyEJC6UKW/gg2Gn9pnexr+fJ7ZK2NXS8qOlQL6MtdCgyP2BDk4TAfqnTG
	 kg+obiC9PZS8E9FJEVk4L0A6uStiUUYR0MADLFUb63jCFF7Zace5yKwe0OC8PonLT/
	 GNCswWJVKZ7/g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48K2LYXs8426393
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 10:21:34 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 10:21:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 20 Sep 2024 10:21:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 20 Sep 2024 10:21:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 2/2] wifi: rtw88: Parse the RX descriptor with a single function
Thread-Topic: [PATCH 2/2] wifi: rtw88: Parse the RX descriptor with a single
 function
Thread-Index: AQHbCVTHPZPUC2YFj0Kyvt5h+Ka+k7Jf7HDg
Date: Fri, 20 Sep 2024 02:21:33 +0000
Message-ID: <47452b48615a4c4699ac86ccf2ab1a19@realtek.com>
References: <dae7994f-3491-40de-b537-ebf68df084bb@gmail.com>
 <6efd784f-d07f-42c2-a84f-4beba2db25dc@gmail.com>
In-Reply-To: <6efd784f-d07f-42c2-a84f-4beba2db25dc@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBydHc4
NzAzYl9xdWVyeV9yeF9kZXNjKCksIHJ0dzg3MjNkX3F1ZXJ5X3J4X2Rlc2MoKSwNCj4gcnR3ODgy
MWNfcXVlcnlfcnhfZGVzYygpLCBydHc4ODIyYl9xdWVyeV9yeF9kZXNjKCksIGFuZA0KPiBydHc4
ODIyY19xdWVyeV9yeF9kZXNjKCkgYXJlIGFsbW9zdCBpZGVudGljYWwsIHNvIHJlcGxhY2UgdGhl
bSBhbGwgd2l0aA0KPiBhIHNpbmdsZSBmdW5jdGlvbiwgcnR3X3J4X3F1ZXJ5X3J4X2Rlc2MoKS4N
Cj4gDQo+IEFsc28sIGFjY2VzcyB0aGUgUlggZGVzY3JpcHRvciB1c2luZyBhIHN0cnVjdCB3aXRo
IF9fbGUzMiBtZW1iZXJzIGFuZA0KPiBsZTMyX2dldF9iaXRzKCkuDQoNCkkgaGF2ZSB0ZXN0ZWQg
dGhpcyBwYXRjaCB3aXRoIFJUTDg3MjNERSBhbmQgUlRMODgyMkNFLCBhbmQgbG9va3MgZ29vZC4N
ClBsZWFzZSBhbHNvIGRlc2NyaWJlIHdoaWNoIGNoaXBzIHlvdSB0ZXN0ZWQuIA0KDQpbLi4uXQ0K
DQo+IC0NCj4gLSAgICAgICBwa3Rfc3RhdC0+ZHJ2X2luZm9fc3ogKj0gUlhfRFJWX0lORk9fU1pf
VU5JVF84NzAzQjsNCg0KRm9yIG5vdywgUlhfRFJWX0lORk9fU1pfVU5JVF84NzAzQiBpc24ndCB1
c2VkIGFueW1vcmUuIFdlIGNhbiByZW1vdmUgaXQuDQoNClsuLi5dDQoNCj4gKyAgICAgICAucXVl
cnlfcGh5X3N0YXR1cyAgICAgICA9IHF1ZXJ5X3BoeV9zdGF0dXMsDQoNCkFsbCBleGlzdGluZyBj
aGlwcyB1c2UgdGhlIHNhbWUgY2FsbGJhY2suIFdpbGwgaXQgYmUgZGlmZmVyZW50IGZvciBjb21p
bmcgY2hpcHM/DQoNClsuLi5dDQoNCj4gKw0KPiArdm9pZCBydHdfcnhfcXVlcnlfcnhfZGVzYyhz
dHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCB1OCAqcnhfZGVzYzgsDQoNCklmIHlvdSB1c2UgJ3ZvaWQg
KicgYXMgdHlwZSBvZiByeF9kZXNjOCwgd2UgY2FuIGF2b2lkIG1vc3QgY2FzdGluZy4gDQoNCg0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBydHdfcnhfcGt0X3N0YXQgKnBrdF9z
dGF0LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBpZWVlODAyMTFfcnhfc3Rh
dHVzICpyeF9zdGF0dXMpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IHJ0d19yeF9kZXNjICpyeF9k
ZXNjID0gKHN0cnVjdCBydHdfcnhfZGVzYyAqKXJ4X2Rlc2M4Ow0KDQpsaWtlIGhlcmUuIA0KDQo+
ICsNCj4gKyAgICAgICBwaHlfc3RhdHVzID0gcnhfZGVzYzggKyBkZXNjX3N6ICsgcGt0X3N0YXQt
PnNoaWZ0Ow0KPiArICAgICAgIGhkciA9IChzdHJ1Y3QgaWVlZTgwMjExX2hkciAqKShwaHlfc3Rh
dHVzICsgcGt0X3N0YXQtPmRydl9pbmZvX3N6KTsNCg0KYW5kIGhlcmUuDQoNCg0KDQo=

