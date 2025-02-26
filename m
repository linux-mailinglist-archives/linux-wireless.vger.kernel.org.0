Return-Path: <linux-wireless+bounces-19474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567B9A45996
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 10:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E373AB6D3
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C67A224247;
	Wed, 26 Feb 2025 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="m2xaKYf+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52946224227
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560987; cv=none; b=ZAjyFCK5L/RmxDfJscxuVGgLEo7/CrwM2ci3I0SCoacgy9xE0ZtCqDQx8yLgNQkEGTNjTZ28kCGnk5rYV+I/MT8dMZ5yNvqFQ16g2gKtTIwCTKqo/hxkcHLcy6l8pxkU/8hFadR1dm3K20Fy04N6wreF7W0z6jatDQMFPLXMFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560987; c=relaxed/simple;
	bh=unnc/GUtVum1/ZtPZ4P8ZcumxVLfe/wxAFezkkXx530=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qm7jy5EFfmxLpnn6BgRYsOqYGb4xlhlMsi/ENHDAg1+YCZZN04L26IFYLm0wPDvvyzvzzzX3T4BAsN9+DLdVzvDfUxRs9ikxZrbcagC+lxrwDpKIHkrL+G1KF+58aHdAXPd8PxEfnwybni6zN5HIXdm0t7sc5QdefTjI8K7rHAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=m2xaKYf+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51Q99A5U03465552, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740560950; bh=unnc/GUtVum1/ZtPZ4P8ZcumxVLfe/wxAFezkkXx530=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=m2xaKYf+fHYNftQKAis2DVgpHgMNfsJ0h892S07EaMe4MH4YcCDK8r9+xlzA4cWjF
	 hV9YnoDSRwfwG3K0Z7zOqDI9KffwVEqorqCt+vyR2XggRsYaEUB3La9OB5N5dLBY0y
	 NQ5AJGU4Ne+8fmg03g5tBpkMxp+ts/mFJEXaj9ujd3zA63PlgNCuo5snlnIYLVFNyX
	 ddI/ZLgDB6zhIxQw01n9zB2MaDSmQ4B/HHjVq5bbQcXtvAddZ+eQT0htwcNEh7lvcJ
	 Haso1XCodMe/9rSPhmrAKSHuCDvLLqvxNRgWRB9jwdy9/JpnM7a0WJ2KoEkXI2YbFE
	 VPGrZkHvOQ2sw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51Q99A5U03465552
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 17:09:10 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Feb 2025 17:09:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 26 Feb 2025 17:09:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Wed, 26 Feb 2025 17:09:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "wens@kernel.org" <wens@kernel.org>,
        "rmandrad@gmail.com"
	<rmandrad@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "wireless-regdb@lists.infradead.org" <wireless-regdb@lists.infradead.org>,
        Dennis Bland <dennis@dbperformance.com>
Subject: RE: wireless-regdb: Allow 6ghz in the US
Thread-Topic: wireless-regdb: Allow 6ghz in the US
Thread-Index: AduIInOm5OAeUzeORjOSV3pwYv+NMP//jiQA//93ctA=
Date: Wed, 26 Feb 2025 09:09:10 +0000
Message-ID: <ff6ad414457e4b1cb68e834978a553c3@realtek.com>
References: <000201db8822$98f28da0$cad7a8e0$@gmail.com>
 <CAGb2v65490c1m3W_1RkxJ-E7Q=3V_K8xqS2jmd6awcOdzWHXzQ@mail.gmail.com>
In-Reply-To: <CAGb2v65490c1m3W_1RkxJ-E7Q=3V_K8xqS2jmd6awcOdzWHXzQ@mail.gmail.com>
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

Q2hlbi1ZdSBUc2FpIDx3ZW5zQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gPiBiYXNlZCBvbiB0
aGlzIHJlbW92ZSBOTy1JUiBmbGFnIGFuZCBhbGxvdyAzMCBkQm0gbWF4IHBvd2VyDQo+IA0KPiBU
aGUgb3JpZ2luYWwgc3VibWlzc2lvbiBtZW50aW9uZWQgTk8tSVIgcmVxdWlyZW1lbnRzLCB0aG91
Z2ggSSBkaWQgbm90DQo+IGZpbmQgc3VjaCB3b3JkaW5nLiBEZW5uaXMsIGRvIHlvdSBoYXZlIGFu
eSBpZGVhcz8NCj4gDQoNCkZZSS4gVGhlIGRlc2NyaXB0aW9uIGJlbG93IGluIFsxXQ0KDQpJbiBh
bGwgY2FzZXMsIGFuIGV4Y2VwdGlvbiBleGlzdHMgZm9yIHRyYW5zbWl0dGluZyBicmllZiBtZXNz
YWdlcyB0byBhbg0KYWNjZXNzIHBvaW50IHdoZW4gYXR0ZW1wdGluZyB0byBqb2luIGl0cyBuZXR3
b3JrIGFmdGVyIGRldGVjdGluZyBhIHNpZ25hbA0KdGhhdCBjb25maXJtcyB0aGF0IGFuIGFjY2Vz
cyBwb2ludCBpcyBvcGVyYXRpbmcgb24gYSBwYXJ0aWN1bGFyIGNoYW5uZWwuDQoNClsxXSBodHRw
czovL3d3dy5mZWRlcmFscmVnaXN0ZXIuZ292L2RvY3VtZW50cy8yMDIwLzA1LzI2LzIwMjAtMTEy
MzYvdW5saWNlbnNlZC11c2Utb2YtdGhlLTYtZ2h6LWJhbmQNCg0KDQo=

