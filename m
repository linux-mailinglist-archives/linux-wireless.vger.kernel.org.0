Return-Path: <linux-wireless+bounces-5141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA6588669B
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 07:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC94A1C218C7
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 06:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E04C121;
	Fri, 22 Mar 2024 06:06:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D7C8487
	for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711087609; cv=none; b=qtt8lfmxknUYWtSN/uzupEbe4rOfGz0gU15byZhmYfSnYFFaM5Y949LFsy707RD/ehdpXn6gR1qI9788sBluGGUqleJxKmWo5bmuOn9XfPGwaQSjD/NwU6yCkTU6o1ZhdW3x9alj3VIJaF+H/SdcWkLfjYNMaay3XehzzsE5z8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711087609; c=relaxed/simple;
	bh=hwvr+fCbKmNJG7xtNWoZm29mgfDKPO7Xom6I6ny/7dw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GocNKtDdsDUKC9vVUJFd8x3hQhMlOiw4e+rBOBXiq+fI1gIO3+kWiMa9GASDtn0EpK2UPioA56Yv2TvVgM9K0pxfLszoisT45ilN4M3ZiqqWidjq66ffq/ryLGyxUcJyIpaiIsvOkrp+L0uWGvZo/gJUxvB5yo/oMZrkKdzysDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42M66RnH41510007, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42M66RnH41510007
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 14:06:27 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 14:06:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 14:06:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Fri, 22 Mar 2024 14:06:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH v3 12/12] wifi: rtlwifi: Enable the new rtl8192du driver
Thread-Topic: [PATCH v3 12/12] wifi: rtlwifi: Enable the new rtl8192du driver
Thread-Index: AQHaev8N3wldoT5yxkWodb87veJZZbFCwb+A
Date: Fri, 22 Mar 2024 06:06:27 +0000
Message-ID: <99f2bb236acd3ac6fd9b55766229f5075b65bda4.camel@realtek.com>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
	 <5c56d4d0-eff2-41c0-95be-fb903abd4175@gmail.com>
In-Reply-To: <5c56d4d0-eff2-41c0-95be-fb903abd4175@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <560FBC9BA0948D429D8B75C2D18AED4C@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI0LTAzLTIwIGF0IDIxOjQ0ICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiBFeHRlcm5hbCBtYWlsLg0KPiANCj4gVGhlIFJUTDgxOTJEVSBpcyBhbiBvbGRlciBXaWZp
IDQgZHVhbCBiYW5kIGNoaXAuIEl0IGNvbWVzIGluIHR3bw0KPiBmbGF2b3Vyczogc2luZ2xlIE1B
QyBzaW5nbGUgUEhZIChsaWtlIG1vc3QgUmVhbHRlayBXaWZpIDQgVVNCIGRldmljZXMpLA0KPiBh
bmQgZHVhbCBNQUMgZHVhbCBQSFkuDQo+IA0KPiBUaGUgc2luZ2xlIE1BQyBzaW5nbGUgUEhZIHZl
cnNpb24gaXMgMlQyUiBhbmQgY2FuIHdvcmsgZWl0aGVyIGluIHRoZQ0KPiAyLjQgR0h6IGJhbmQg
b3IgdGhlIDUgR0h6IGJhbmQuDQo+IA0KPiBUaGUgZHVhbCBNQUMgZHVhbCBQSFkgdmVyc2lvbiBo
YXMgdHdvIFVTQiBpbnRlcmZhY2VzIGFuZCBhcHBlYXJzIHRvIHRoZQ0KPiBzeXN0ZW0gYXMgdHdv
IHNlcGFyYXRlIDFUMVIgV2lmaSBkZXZpY2VzLCBvbmUgd29ya2luZyBpbiB0aGUgMi40IEdIeg0K
PiBiYW5kLCB0aGUgb3RoZXIgaW4gdGhlIDUgR0h6IGJhbmQuDQo+IA0KPiBUaGlzIHdhcyB0ZXN0
ZWQgb25seSB3aXRoIGEgc2luZ2xlIE1BQyBzaW5nbGUgUEhZIGRldmljZSwgbW9zdGx5IGluDQo+
IHN0YXRpb24gbW9kZS4gVGhlIHNwZWVkcyBpbiB0aGUgMi40IEdIeiBiYW5kIHdpdGggMjAgTUh6
IGNoYW5uZWwgd2lkdGgNCj4gYXJlIHNpbWlsYXIgdG8gdGhlIG91dC1vZi10cmVlIGRyaXZlcjog
ODUvNTEgbWVnYWJpdHMvc2Vjb25kLg0KPiANCj4gU3RlZmFuIExpcHBlcnMtSG9sbG1hbm4gdGVz
dGVkIHRoZSBzcGVlZCBpbiB0aGUgNSBHSHogYmFuZCB3aXRoIDQwIE1Ieg0KPiBjaGFubmVsIHdp
ZHRoOiAxNzMvOTkgbWVnYWJpdHMvc2Vjb25kLg0KPiANCj4gSXQgd2FzIGFsc28gdGVzdGVkIGJy
aWVmbHkgaW4gQVAgbW9kZS4gSXQncyBlbWl0dGluZyBiZWFjb25zIGFuZCBteQ0KPiBwaG9uZSBj
YW4gY29ubmVjdCB0byBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGgg
PHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT4NCg0K

