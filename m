Return-Path: <linux-wireless+bounces-5334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAFC88E508
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 15:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944A72A30BC
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 14:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887B914884B;
	Wed, 27 Mar 2024 12:43:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD11F13248B
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543399; cv=none; b=gFs/YG2jgsvXyh6HiLRHvpL8wuGbU5XYcTJquahUy+WOf0NEwv0ih+APEMG7+14d3+tcv7WRXXecqnGjybiy5EFjTzNa+O7IrdeBKjHzWpAUrthGCNK4q/D4ZuxjgXUyuilR7Bp7W8PxNIGmxR1hWtBhSlcN7t/yCJ0Yh3prRBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543399; c=relaxed/simple;
	bh=DL0wIRWQ92PZfn+D5B0g7hwpTzHw4wTxTgsuASsspog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EhKaSIgJWEzo49KvA9JDq2fVtR7U/ZzajfvOTr9Rx8RP3XQfk+DAdSsuZOFufibGJmjrZbpCmFW8tD++U4mVtz/skISBTpYVptC4EoCzKMmWKCyUdMufMNu2eEmgwH4ezdlfCNAvPVQgNn38YMWrzhkA55Suqu2dbnOxmIeZzkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42RCgfQX3929049, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42RCgfQX3929049
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 20:42:41 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 20:42:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 20:42:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Wed, 27 Mar 2024 20:42:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH v3 04/12] wifi: rtlwifi: Add rtl8192du/table.{c,h}
Thread-Topic: [PATCH v3 04/12] wifi: rtlwifi: Add rtl8192du/table.{c,h}
Thread-Index: AQHaev3qY3Nayk5vYE26xHTZIDMXTLFCmpOAgAcv14CAAY8s8v//fNcAgAA0JwCAAAGFAA==
Date: Wed, 27 Mar 2024 12:42:41 +0000
Message-ID: <cb5505ae874312b6027b8a6e60eae1cd538c12cb.camel@realtek.com>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
	 <ed50254c-889e-4dcd-93db-f63b776e3503@gmail.com>
	 <5170c29a7b565fdec2e004f9391d325328ef5a72.camel@realtek.com>
	 <8a90f3cb-7218-4f23-8aa7-fcc68e2f4a93@gmail.com>
	 <87y1a4yqvh.fsf@kernel.org>
	 <5d117cf09134b034e704b8a1b5167235963a9c88.camel@realtek.com>
	 <de1af6c3-25e2-4480-9da3-f3e5de1d6d5f@gmail.com>
In-Reply-To: <de1af6c3-25e2-4480-9da3-f3e5de1d6d5f@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4D345F65FDE774D867E1190B0DDACBC@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI0LTAzLTI3IGF0IDE0OjM2ICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gT24gMjcvMDMvMjAyNCAxMTozMCwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IE9u
IFdlZCwgMjAyNC0wMy0yNyBhdCAxMToxOCArMDIwMCwgS2FsbGUgVmFsbyB3cm90ZToNCj4gPiA+
IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPiB3cml0ZXM6DQo+ID4g
PiANCj4gPiA+ID4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9ydGw4MTkyZHUvdGFibGUuYw0KPiA+ID4gPiA+
ID4gQEAgLTAsMCArMSwxNjc1IEBADQo+ID4gPiA+ID4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjANCj4gPiA+ID4gPiA+ICsvKiBDb3B5cmlnaHQoYykgMjAwOS0yMDEyICBS
ZWFsdGVrIENvcnBvcmF0aW9uLiovDQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArI2luY2x1
ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArI2luY2x1ZGUg
InRhYmxlLmgiDQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArdTMyIHJ0bDgxOTJkdV9waHlf
cmVnXzJ0YXJyYXlbUEhZX1JFR18yVF9BUlJBWUxFTkdUSF0gPSB7DQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gc3RhdGljIGNvbnN0ID8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiA+ICt1MzIgcnRsODE5MmR1X3BoeV9yZWdfYXJyYXlfcGdbUEhZX1JFR19BUlJBWV9QR19MRU5H
VEhdID0gew0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IHN0YXRpYyBjb25zdCA/DQo+ID4gPiA+ID4g
DQo+ID4gPiA+IA0KPiA+ID4gPiBJIGNhbiBtYWtlIHRoZW0gc3RhdGljIGlmIEkgbW92ZSB0aGVt
IHRvIHRhYmxlLmguIE9ubHkgcGh5LmMNCj4gPiA+ID4gaW5jbHVkZXMgdGhpcyBoZWFkZXIsIHNv
IHRoYXQgc2hvdWxkIGJlIGZpbmUuDQo+ID4gPiANCj4gPiA+IERvIG5vdGUgdGhhdCAuaCBmaWxl
cyBjYW4ndCBjb250YWluIHN0YXRpYyB2YXJpYWJsZXMsIG90aGVyd2lzZSB0aGVyZQ0KPiA+ID4g
d2lsbCBiZSBkdXBsaWNhdGUgZGF0YS4NCj4gPiA+IA0KPiA+IA0KPiA+IEluZGVlZCwgc28gdGhl
c2UgY2FzZXMgc2hvdWxkIGJlICdjb25zdCB1MzInLCBubyBuZWVkICdzdGF0aWMnLg0KPiA+IA0K
PiA+IA0KPiANCj4gU28gSSBzaG91bGQgbGVhdmUgdGhlbSBpbiB0YWJsZS5jPyBPbmx5IHBoeS5j
IGluY2x1ZGVzIHRhYmxlLmgsDQo+IHNvIG5vdGhpbmcgd291bGQgYmUgZHVwbGljYXRlZC4NCg0K
SSB0aGluayBzby4gV2hhdCB5b3UgbmVlZCB0byBkbyBpcyB0byBhZGQgJ2NvbnN0JyB0byBlYWNo
IG9mIHRoZW0uIA0KDQoNCg==

