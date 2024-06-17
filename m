Return-Path: <linux-wireless+bounces-9032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0790990A1C8
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 03:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2DE1C21025
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 01:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FABA3FEC;
	Mon, 17 Jun 2024 01:28:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A561B8465
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587726; cv=none; b=X22S5CDpi+pEPzhZTINPKg3rzaJwbVuZKq/j4lK6FMCu2Ka5OVgWnmig0cOTBeOHFcffjw/7Svj+ZUMrSb1MCpufR45hM/HrHYWhqsQA4hMJ7xfZnU+FMrvRXx8RGE635wJWpLKorDZ0iXPLuVivhPvPp2FVrLPaXKG9k6MJlfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587726; c=relaxed/simple;
	bh=XKriHNTuYRYMXPzRM/3jfvpCOhVW7uPAeFdKFm2y8+0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OUNhKwHepPQrxrIWcDHMhCjYo56B5OwxWFWQhhj6+sY0HLX7fnOqvorlh8iCmsgF9Dkgv8OwP9//XsBipQl4pFRqRde3J/i5VShi7AZ6rpDFm6O4dbimaLuKjxY91z9VXU6bril2ws92482RX+/75jXgLIAzInVfmGDcYnQlBwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45H1SSoJ42508382, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45H1SSoJ42508382
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 09:28:28 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 09:28:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 17 Jun 2024 09:28:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 17 Jun 2024 09:28:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH v3] wifi: rtw88: usb: Further limit the TX aggregation
Thread-Topic: [PATCH v3] wifi: rtw88: usb: Further limit the TX aggregation
Thread-Index: AQHawCNCcC7sJQa4hUaOYeyIC+MrjrHLKvGA
Date: Mon, 17 Jun 2024 01:28:28 +0000
Message-ID: <795aca2a59a34b86a0cb493d8a12ef68@realtek.com>
References: <cb46ea35-7e59-4742-9c1f-01ceeaad36fb@gmail.com>
In-Reply-To: <cb46ea35-7e59-4742-9c1f-01ceeaad36fb@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBDdXJy
ZW50bHkgdGhlIG51bWJlciBvZiBmcmFtZXMgc2VudCB0byB0aGUgY2hpcCBpbiBhIHNpbmdsZSBV
U0IgUmVxdWVzdA0KPiBCbG9jayBpcyBsaW1pdGVkIG9ubHkgYnkgdGhlIHNpemUgb2YgdGhlIFRY
IGJ1ZmZlciwgd2hpY2ggaXMgMjAgS2lCLg0KPiBUZXN0aW5nIHJldmVhbHMgdGhhdCBhcyBtYW55
IGFzIDEzIGZyYW1lcyBnZXQgYWdncmVnYXRlZC4gVGhpcyBpcyBtb3JlDQo+IHRoYW4gd2hhdCBh
bnkgb2YgdGhlIGNoaXBzIHdvdWxkIGxpa2UgdG8gcmVjZWl2ZS4gUlRMODgyMkNVLCBSVEw4ODIy
QlUsDQo+IGFuZCBSVEw4ODIxQ1Ugd2FudCBhdCBtb3N0IDMgZnJhbWVzLCBhbmQgUlRMODcyM0RV
IHdhbnRzIG9ubHkgMSBmcmFtZQ0KPiBwZXIgVVJCLg0KPiANCj4gUlRMODcyM0RVIGluIHBhcnRp
Y3VsYXIgcmVsaWFibHkgbWFsZnVuY3Rpb25zIGR1cmluZyBhIHNwZWVkIHRlc3QgaWYgaXQNCj4g
cmVjZWl2ZXMgbW9yZSB0aGFuIDEgZnJhbWUgcGVyIFVSQi4gQWxsIHRyYWZmaWMgc2VlbXMgdG8g
c3RvcC4gUGluZ2luZw0KPiB0aGUgQVAgbm8gbG9uZ2VyIHdvcmtzLg0KPiANCj4gRml4IHRoaXMg
cHJvYmxlbSBieSBsaW1pdGluZyB0aGUgbnVtYmVyIG9mIGZyYW1lcyBzZW50IHRvIHRoZSBjaGlw
IGluIGENCj4gc2luZ2xlIFVSQiBhY2NvcmRpbmcgdG8gd2hhdCBlYWNoIGNoaXAgbGlrZXMuDQo+
IA0KPiBBbHNvIGNvbmZpZ3VyZSBSVEw4ODIyQ1UsIFJUTDg4MjJCVSwgYW5kIFJUTDg4MjFDVSB0
byBleHBlY3QgMyBmcmFtZXMNCj4gcGVyIFVSQi4NCj4gDQo+IFJUTDg3MDNCIG1heSBvciBtYXkg
bm90IGJlIGZvdW5kIGluIFVTQiBkZXZpY2VzLiBEZWNsYXJlIHRoYXQgaXQgd2FudHMNCj4gb25s
eSAxIGZyYW1lIHBlciBVUkIsIGp1c3QgaW4gY2FzZS4NCj4gDQo+IFRlc3RlZCB3aXRoIFJUTDg3
MjNEVSBhbmQgUlRMODgxMUNVLg0KPiANCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
U2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+
DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0K

