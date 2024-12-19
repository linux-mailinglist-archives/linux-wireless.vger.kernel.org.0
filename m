Return-Path: <linux-wireless+bounces-16574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D549F7379
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 04:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 841FE7A2B1A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 03:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8004F54727;
	Thu, 19 Dec 2024 03:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="gzuVsUyR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F78A3D76
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 03:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734580043; cv=none; b=sxrvE55o2EdtdGFilxq97jGwJe+5Jciq4ZY/cTo/F0N6QWiRmhKB3JpuEeTYwmss+4eAXyAwSY7XkyMQgwux+WpXKKBcZckzu405EXvMeHSV9VQIt333ddMJJJe1RE28MglRR8ye3+MN6etwwz5pb0r9g6X+8DxnudkAQ7tH9XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734580043; c=relaxed/simple;
	bh=+Z+wbMVqjxqGpowx4YW6ewKETSYI1Be8NhEKNkdz99k=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BqyuMve2/GyFAmscNx6SEdRh6s2YE3uuwYa+Fh88HGXk0yjAM5Wple//WnEMkHwasMbwtcMo2bfx2eziJRaSRJ3o5thE5iJ9Q3udI0suAHpmpCEiqHXl1MQY9D6M5oAqx/9gRTmHmQ7y5xYd7sE+OmxFLwBne7he6im+hJFfCLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=gzuVsUyR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BJ3lFHT13367793, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734580035; bh=+Z+wbMVqjxqGpowx4YW6ewKETSYI1Be8NhEKNkdz99k=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=gzuVsUyRsfkFe09BQnEfWqw6VMJ3yJi7APEf8GFvbCXgvTt8VrI+4ycKpNjcxVAkP
	 H9ERMTsJp8WhxcNRtpn+NH9jY75zljyMCehxZawyXp3CNcKd+DGCF8Gz+rpZIesHXk
	 neoMfZN/C0Z2SacxezOXPHPCWY2mhZqIRknumMp0Y3PiU74sJfpp2GOEVS49GsVkkL
	 Jr85o0Rv0fZAdHihpJZA2Q4wxnluy0FBjCuLmIlGmsmcgQroLEry90Dxqioj53Bjqj
	 DF6pkITmvXQNPeESXjClVfbbPZbdpYDr6rGqKcnaZY+fmIwdBf/jmZ79mOfFylogw0
	 5AETmUwd49ZTg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BJ3lFHT13367793
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 11:47:15 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Dec 2024 11:47:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 19 Dec 2024 11:47:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 19 Dec 2024 11:47:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtlwifi: rtl8821ae: Fix media status report
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8821ae: Fix media status report
Thread-Index: AQHbUNZ34DpJ6jNLJE+I7yGFX/o8crLs71nQ
Date: Thu, 19 Dec 2024 03:47:15 +0000
Message-ID: <c4fdab007c15450dbd37f4570095d157@realtek.com>
References: <754785b3-8a78-4554-b80d-de5f603b410b@gmail.com>
In-Reply-To: <754785b3-8a78-4554-b80d-de5f603b410b@gmail.com>
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
UlRMODgyMUFFIGlzIHN0dWNrIHRyYW5zbWl0dGluZyBhdCB0aGUgbG93ZXN0IHJhdGUgYWxsb3dl
ZCBieSB0aGUgcmF0ZQ0KPiBtYXNrLiBUaGlzIGlzIGJlY2F1c2UgdGhlIGZpcm13YXJlIGRvZXNu
J3Qga25vdyB0aGUgZGV2aWNlIGlzIGNvbm5lY3RlZA0KPiB0byBhIG5ldHdvcmsuDQo+IA0KPiBG
aXggdGhlIG1hY3JvcyBTRVRfSDJDQ01EX01TUlJQVF9QQVJNX09QTU9ERSBhbmQNCj4gU0VUX0gy
Q0NNRF9NU1JSUFRfUEFSTV9NQUNJRF9JTkQgdG8gd29yayBvbiB0aGUgZmlyc3QgYnl0ZSBvZiBf
X2NtZCwNCj4gbm90IHRoZSBzZWNvbmQuIE5vdyB0aGUgZmlybXdhcmUgaXMgY29ycmVjdGx5IG5v
dGlmaWVkIHdoZW4gdGhlIGRldmljZQ0KPiBpcyBjb25uZWN0ZWQgdG8gYSBuZXR3b3JrIGFuZCBp
dCBhY3RpdmF0ZXMgdGhlIHJhdGUgY29udHJvbC4NCj4gDQo+IEJlZm9yZSAoTUNTMyk6DQo+IA0K
PiBbICA1XSAgIDAuMDAtMS4wMCAgIHNlYyAgMTIuNSBNQnl0ZXMgICAxMDUgTWJpdHMvc2VjICAg
IDAgICAgMzM5IEtCeXRlcw0KPiBbICA1XSAgIDEuMDAtMi4wMCAgIHNlYyAgMTAuNiBNQnl0ZXMg
IDg5LjEgTWJpdHMvc2VjICAgIDAgICAgMzM5IEtCeXRlcw0KPiBbICA1XSAgIDIuMDAtMy4wMCAg
IHNlYyAgMTAuNiBNQnl0ZXMgIDg5LjEgTWJpdHMvc2VjICAgIDAgICAgMzg2IEtCeXRlcw0KPiBb
ICA1XSAgIDMuMDAtNC4wMCAgIHNlYyAgMTAuNiBNQnl0ZXMgIDg5LjEgTWJpdHMvc2VjICAgIDAg
ICAgMzg2IEtCeXRlcw0KPiBbICA1XSAgIDQuMDAtNS4wMCAgIHNlYyAgMTAuMiBNQnl0ZXMgIDg2
LjAgTWJpdHMvc2VjICAgIDAgICAgNDI3IEtCeXRlcw0KPiANCj4gQWZ0ZXIgKE1DUzkpOg0KPiAN
Cj4gWyAgNV0gICAwLjAwLTEuMDAgICBzZWMgIDMzLjkgTUJ5dGVzICAgMjg0IE1iaXRzL3NlYyAg
ICAwICAgIDc3MSBLQnl0ZXMNCj4gWyAgNV0gICAxLjAwLTIuMDAgICBzZWMgIDMxLjYgTUJ5dGVz
ICAgMjY1IE1iaXRzL3NlYyAgICAwICAgIDg2NSBLQnl0ZXMNCj4gWyAgNV0gICAyLjAwLTMuMDAg
ICBzZWMgIDI5LjkgTUJ5dGVzICAgMjUxIE1iaXRzL3NlYyAgICAwICAgIDk2MyBLQnl0ZXMNCj4g
WyAgNV0gICAzLjAwLTQuMDAgICBzZWMgIDI4LjIgTUJ5dGVzICAgMjM3IE1iaXRzL3NlYyAgICAw
ICAgIDk2MyBLQnl0ZXMNCj4gWyAgNV0gICA0LjAwLTUuMDAgICBzZWMgIDI2LjggTUJ5dGVzICAg
MjI0IE1iaXRzL3NlYyAgICAwICAgIDk2MyBLQnl0ZXMNCj4gDQo+IEZpeGVzOiAzOWY0MDcxMGQw
YjUgKCJydGx3aWZpOiBydGw4ODgyMWFlOiBSZW1vdmUgdXNhZ2Ugb2YgcHJpdmF0ZSBiaXQgbWFu
aXB1bGF0aW9uIG1hY3JvcyIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25l
ZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpB
Y2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCklzIHRoaXMgYW4g
dXJnZW50IHBhdGNoPyBvciBpdCdzIGZpbmUgdG8gZ28gdmlhIHJ0dy1uZXh0Pw0KDQoNCg==

