Return-Path: <linux-wireless+bounces-21577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A762A8ACFD
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 02:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E063B3DC9
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 00:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB51DE4DF;
	Wed, 16 Apr 2025 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jJ8RMW0D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2B1DE2CA;
	Wed, 16 Apr 2025 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764568; cv=none; b=aRPQr53PzAuRQiSpfoR3/kZ9E9CV99eejWbk80e7UfqHq2I4qiWhG4NQQ3BdonlZTOgXuBm2mvmzhAEVmWTR/72Z23e6Zh6723AGDkJ7QxFwsA7yyo0s7K7O7I8Ms6J5l/XaXC1xflrROxpkMj39/s7E6GCJEocUNmNbJMueVO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764568; c=relaxed/simple;
	bh=kWr7Zj6a5RU412b1cBjqAp4YZ2i9JTR5ymTqMoBF490=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YPRp78qRxreCKAJn/x68eDJMoK3Frp9v7qtzGyyrPn8e8nGe7Sojec+wzHMLxUDGmFuPgWuw/dorgvhkFs/JPDC5vKqbj4jRwMFCWAggShUEdJakWWv/H5qpeOKbujB5lMustUAH7eYA6Ldv2rjB4UDqRyPtRaH88qXQeS96uOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jJ8RMW0D; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53G0nL4o92331416, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744764561; bh=kWr7Zj6a5RU412b1cBjqAp4YZ2i9JTR5ymTqMoBF490=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jJ8RMW0Dv4vJEGDgnZ0/w15dJAX7xo1UEuOwhBFMY9f5+jAN5h+niLe4HltnDNg3X
	 UltJYjts2UgYGxD6gA4S9EqcHpQs/3wyeqwOQR9/mqDKOW1tWWiR+vYEs2v8wZ5sCO
	 6Z3sMJxmZYlJTZL7YCKo6hFW01JKIqsZa8h9BMgmOjFehgb/7/YQjlGAmCwCNOamgm
	 /tmEWwSUFjKplWNuuxJF2NcY9PyYG9UwdmHGD7/CjJPIsnc8nVb9HrrtwpXvl9RoKP
	 7wg4as2jE67FapjY8QUkxEpSEtYWUmXKv4gOqZk+02YAZRnfnBykL1e84+eUtlL+as
	 iphqcMGj+ynKQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53G0nL4o92331416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 08:49:21 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Apr 2025 08:49:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 16 Apr 2025 08:49:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 16 Apr 2025 08:49:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <boddah8794@gmail.com>, Bernie Huang <phhuang@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Bug report] rtw89: 8852b: IO_PAGE_FAULTs with beacon filter feature enabled
Thread-Topic: [Bug report] rtw89: 8852b: IO_PAGE_FAULTs with beacon filter
 feature enabled
Thread-Index: AQHbrfBpW2AH+n1rZEuyFH6rIsW1k7Olc7dQ
Date: Wed, 16 Apr 2025 00:49:20 +0000
Message-ID: <148ed65c53be4ef29246d372dd0fef8e@realtek.com>
References: <uidltsdsuujrczrtzgerhh5cw2tztxktfen6yvztnc7gttzgvk@jccomj7f4gul>
In-Reply-To: <uidltsdsuujrczrtzgerhh5cw2tztxktfen6yvztnc7gttzgvk@jccomj7f4gul>
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

RmVkb3IgUGNoZWxraW4gPGJvZGRhaDg3OTRAZ21haWwuY29tPiB3cm90ZToNCj4gSGksDQo+IA0K
PiB0aGVyZSBhcmUgSU9fUEFHRV9GQVVMVCBlcnJvcnMgb2NjYXNzaW9uYWxseSB0aHJvd24gaW50
byB0aGUgbG9nIHdpdGgNCj4gcnR3ODlfODg1MmJlLWNvbXBhdGlibGUgZGV2aWNlIGluIHVzZToN
Cj4gDQo+IFsgICAgNy4xMzU1MDldIHJ0dzg5Xzg4NTJiZSAwMDAwOjAzOjAwLjA6IGxvYWRlZCBm
aXJtd2FyZSBydHc4OS9ydHc4ODUyYl9mdy0xLmJpbg0KPiBbICAgIDcuMTM1NjEwXSBydHc4OV84
ODUyYmUgMDAwMDowMzowMC4wOiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMykNCj4gWyAg
ICA3LjEzNzA3NF0gcnR3ODlfODg1MmJlIDAwMDA6MDM6MDAuMDogRmlybXdhcmUgdmVyc2lvbiAw
LjI5LjI5LjggKDM5ZGJmNTBmKSwgY21kIHZlcnNpb24gMCwgdHlwZSA1DQo+IFsgICAgNy4xMzcw
NzldIHJ0dzg5Xzg4NTJiZSAwMDAwOjAzOjAwLjA6IEZpcm13YXJlIHZlcnNpb24gMC4yOS4yOS44
ICgzOWRiZjUwZiksIGNtZCB2ZXJzaW9uIDAsIHR5cGUgMw0KPiBbICAgIDcuNDIzODUyXSBydHc4
OV84ODUyYmUgMDAwMDowMzowMC4wOiBjaGlwIHJmZV90eXBlIGlzIDENCj4gWyAgICA3LjQ1Mjg0
M10gcnR3ODlfODg1MmJlIDAwMDA6MDM6MDAuMDogcmZraWxsIGhhcmR3YXJlIHN0YXRlIGNoYW5n
ZWQgdG8gZW5hYmxlDQo+IFsgICAgNy40Nzg0NjZdIHJ0dzg5Xzg4NTJiZSAwMDAwOjAzOjAwLjAg
d2xvMTogcmVuYW1lZCBmcm9tIHdsYW4wDQo+IC4uLg0KPiBbIDEzNjEuODAzMzg0XSBydHc4OV84
ODUyYmUgMDAwMDowMzowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCBk
b21haW49MHgwMDEwIGFkZHJlc3M9MHgwDQo+IGZsYWdzPTB4MDAwMF0NCj4gWyAxNDM0LjkxODAx
Ml0gcnR3ODlfODg1MmJlIDAwMDA6MDM6MDAuMDogQU1ELVZpOiBFdmVudCBsb2dnZWQgW0lPX1BB
R0VfRkFVTFQgZG9tYWluPTB4MDAxMCBhZGRyZXNzPTB4MA0KPiBmbGFncz0weDAwMDBdDQo+IFsg
MTU1MS41NTMzNDRdIHJ0dzg5Xzg4NTJiZSAwMDAwOjAzOjAwLjA6IEFNRC1WaTogRXZlbnQgbG9n
Z2VkIFtJT19QQUdFX0ZBVUxUIGRvbWFpbj0weDAwMTAgYWRkcmVzcz0weDANCj4gZmxhZ3M9MHgw
MDAwXQ0KPiBbIDE2NDkuMzQ2ODA0XSBydHc4OV84ODUyYmUgMDAwMDowMzowMC4wOiBBTUQtVmk6
IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCBkb21haW49MHgwMDEwIGFkZHJlc3M9MHgwDQo+
IGZsYWdzPTB4MDAwMF0NCj4gDQo+IA0KPiBhZGRyZXNzIGFuZCBmbGFncyBhcmUgYWx3YXlzIGFs
bCB6ZXJvcy4gSXQgaXMgcmVwcm9kdWNpYmxlIG9uIHRoZSBjdXJyZW50DQo+IG1haW5saW5lIHY2
LjE1LXJjMiBrZXJuZWwgYW5kIHYwLjI5LjI5LjggZncgdmVyc2lvbi4NCj4gDQo+IA0KPiBJdCBp
cyBtb3N0IHByb2JhYmx5IHJlbGF0ZWQgdG8gdGhlIGJlYWNvbiBmaWx0ZXIgZmVhdHVyZSBlbmFi
bGVkIGluIHRoZQ0KPiBmaXJtd2FyZS4gQmlzZWN0aW9uIGluIHRoZSBrZXJuZWwgbGVhZHMgdG8N
Cj4gDQo+IGNvbW1pdCBkNTZjMjYxZTUyMTRlNTFlMmM2ZDIyMTQ5ZjYzNTU1MDM5YjU2MDFlIChI
RUFEKQ0KPiBBdXRob3I6IFBvLUhhbyBIdWFuZyA8cGhodWFuZ0ByZWFsdGVrLmNvbT4NCj4gRGF0
ZTogICBUaHUgTm92IDI4IDEzOjU0OjI5IDIwMjQgKzA4MDANCj4gDQo+ICAgICB3aWZpOiBydHc4
OTogODg1MmI6IGFkZCBiZWFjb24gZmlsdGVyIGFuZCBDUU0gc3VwcG9ydA0KPiANCj4gDQo+IGFu
ZCBpbiBsaW51eC1maXJtd2FyZSB0bw0KPiANCj4gY29tbWl0IDIwY2FjZTFhZGY2YTMzY2FjNzM1
OTVlYTMyMDJlYjc4NGRlYTk4YTYNCj4gQXV0aG9yOiBQby1IYW8gSHVhbmcgPHBoaHVhbmdAcmVh
bHRlay5jb20+DQo+IERhdGU6ICAgVGh1IFNlcCAxOSAxNzowMjoyOCAyMDI0ICswODAwDQo+IA0K
PiAgICAgcnR3ODk6IDg4NTJiOiB1cGRhdGUgZncgdG8gdjAuMjkuMjkuNw0KPiANCj4gICAgIEVu
YWJsZSBiZWFjb24gZmlsdGVyIGZlYXR1cmUuDQo+IA0KPiANCg0KVGhhbmtzIGZvciB0aGUgcmVw
b3J0LiANCg0KQXMgYmlzZWN0aW9uLCBjYW4gSSBzdW1tYXJpemUgYXMgYmVsb3cgdGFibGU/DQoN
CiAgICBkNTZjMjYxZTUyICAgICAgICAgICBmaXJtd2FyZSAgICAgICAgICAgICBJT19QQUdFX0ZB
VUxUDQogICAoQ1FNIHN1cHBvcnQpDQogIC0tLS0tLS0tLS0tLS0tLSAgICAgIC0tLS0tLS0tLS0t
ICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tDQogICAgICBvICAgICAgICAgICAgICAgICAwLjI5
LjI5LjcgICAgICAgICAgICAgICAgICB5ZXMNCiAgICAgIG8gICAgICAgICAgICAgICAgIDAuMjku
MjkuNSAgICAgICAgICAgICAgICAgIG5vDQogICAgICB4ICAgICAgICAgICAgICAgICAwLjI5LjI5
LjcgICAgICAgICAgICAgICAgICBubw0KICAgICAgeCAgICAgICAgICAgICAgICAgMC4yOS4yOS41
ICAgICAgICAgICAgICAgICAgbm8NCg0KSWYgdGhpcyB0YWJsZSBpcyBjb3JyZWN0LCB3ZSB3aWxs
IGNoZWNrIHRoZSBiZWFjb24gZmlsdGVyIGZlYXR1cmUgaW4gZmlybXdhcmUuIA0KDQo=

