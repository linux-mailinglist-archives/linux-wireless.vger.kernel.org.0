Return-Path: <linux-wireless+bounces-11453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE16952934
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 08:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A24F1C21C0B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 06:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4928817625E;
	Thu, 15 Aug 2024 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="UdIp5Yj6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3538DC8
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 06:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723702454; cv=none; b=NVw2EvGjf0a1PwO+6SkYLiT7sS19za84AFLto98qR49TAjuSl2ORWAJaFPRRAMB/Jw/xz1q3hIbfldkjnRoncuFOoUv2lMntR/DnVfA8mdnSQd4ZpAYezb8yZrQqC7DL4R6rg2ad8qOiULiHZks6t2fkB1c/G/LerkvZCK8rZMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723702454; c=relaxed/simple;
	bh=cfggovX3m/4PSjlBqnfOZBLvv9d0j/N1ozGyVa++/G4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ajiolKGsFuVkc4tKblyC87owrPl+FXAMikbVOpJJK1GPhvpKHDbWMKW5JQ+j+2DWp2sRcm/Xzxe4zoifelAtSoDkKTcW/dKmylKmR72lDdIL2I0VlfmiG1yNGJ084iPwUOE9uuZwvPAPItemKvsp8+MmhgTqLYVsODcoQ+86Qog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=UdIp5Yj6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F6E7JP03688745, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723702447; bh=cfggovX3m/4PSjlBqnfOZBLvv9d0j/N1ozGyVa++/G4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=UdIp5Yj6C8eQ6UPzCw99tlznJ2qT5pzC1E7J0IfecSS8YXtXWbZAmVESyHzmxUvMh
	 yeY/jkjmOzzRuL/8bPDPKrzgR/Z1ZHvUKRRHoHyggRYC5345LZ06pAqZcM6PPHO4MU
	 a+osS5zlpIUCoR9dYT6RRs4HQ5bHoAYplnVZufPgMuLjBRZ9I6PwMvk0GaB+bzMsdC
	 HSnjzkwA14Cwjo7o/1mULpoANWTXX/un0P/yZPecRbS3OJBQZj9YT/vYk5jVbCnAgn
	 rcfBLIlASrfl5EW1uECH7zgQtEy3haGVvX4vIeMCn8I96HeHBEz0wzTfd/tJVIJGeu
	 9Z4EBO7lC56XA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F6E7JP03688745
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 14:14:07 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 14:14:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 14:14:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 14:14:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 03/20] wifi: rtw88: Allow different C2H RA report sizes
Thread-Topic: [PATCH 03/20] wifi: rtw88: Allow different C2H RA report sizes
Thread-Index: AQHa7DDGvlj44vDEDUaIMp+2n642+LIn28Ng
Date: Thu, 15 Aug 2024 06:14:07 +0000
Message-ID: <6071028680d14afa8e0eed84821f51c6@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <e0de25fc-8742-4899-854e-7cbd93aaa582@gmail.com>
In-Reply-To: <e0de25fc-8742-4899-854e-7cbd93aaa582@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
UlRMODgyMUFVIGFuZCBSVEw4ODEyQVUgaGF2ZSBzbWFsbGVyIFJBIHJlcG9ydCBzaXplLCBvbmx5
IDQgYnl0ZXMuDQo+IEF2b2lkIHRoZSAiaW52YWxpZCByYSByZXBvcnQgYzJoIGxlbmd0aCIgZXJy
b3IuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUy
QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4
L2Z3LmMgICAgICAgfCA4ICsrKysrKy0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg4L21haW4uaCAgICAgfCAxICsNCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODgvcnR3ODcwM2IuYyB8IDEgKw0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OC9ydHc4NzIzZC5jIHwgMSArDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg4L3J0dzg4MjFjLmMgfCAxICsNCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODgvcnR3ODgyMmIuYyB8IDEgKw0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4
OC9ydHc4ODIyYy5jIHwgMSArDQo+ICA3IGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OC9mdy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9m
dy5jDQo+IGluZGV4IDc4MmYzNzc2ZTBhMC4uYWM1M2UzZTMwYWYwIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L2Z3LmMNCj4gKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9mdy5jDQo+IEBAIC0xNTcsNyArMTU3LDEwIEBAIHN0
YXRpYyB2b2lkIHJ0d19md19yYV9yZXBvcnRfaXRlcih2b2lkICpkYXRhLCBzdHJ1Y3QgaWVlZTgw
MjExX3N0YSAqc3RhKQ0KPiANCj4gICAgICAgICByYXRlID0gR0VUX1JBX1JFUE9SVF9SQVRFKHJh
X2RhdGEtPnBheWxvYWQpOw0KPiAgICAgICAgIHNnaSA9IEdFVF9SQV9SRVBPUlRfU0dJKHJhX2Rh
dGEtPnBheWxvYWQpOw0KPiAtICAgICAgIGJ3ID0gR0VUX1JBX1JFUE9SVF9CVyhyYV9kYXRhLT5w
YXlsb2FkKTsNCj4gKyAgICAgICBpZiAoc2ktPnJ0d2Rldi0+Y2hpcC0+YzJoX3JhX3JlcG9ydF9z
aXplIDwgNykNCg0KRXhwbGljaXRseSBzcGVjaWZ5ICc9PSA0JyBmb3IgdGhlIGNhc2Ugb2YgUlRM
ODgyMUFVIGFuZCBSVEw4ODEyQVUuDQoNCj4gKyAgICAgICAgICAgICAgIGJ3ID0gc2ktPmJ3X21v
ZGU7DQo+ICsgICAgICAgZWxzZQ0KPiArICAgICAgICAgICAgICAgYncgPSBHRVRfUkFfUkVQT1JU
X0JXKHJhX2RhdGEtPnBheWxvYWQpOw0KPiANCg0KDQo=

