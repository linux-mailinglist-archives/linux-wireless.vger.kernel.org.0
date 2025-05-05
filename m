Return-Path: <linux-wireless+bounces-22418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABA5AA8A68
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 02:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A813E16FD55
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 00:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E2E4C85;
	Mon,  5 May 2025 00:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wMPrqOd7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3A96F30C
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 00:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746405913; cv=none; b=E/rBkelH8u7phsix+oKCQl13/ruhgzLI4FHvoXBM6uXlkmhiQgAlnCcmmscU1qeoMlYJZk4Hc/mauKOx23lCzz/BtZq6dhy3mpBDJ0WwMnHQo6XLqJnTI5Ka0dg6YcIXVfEeUFoILYIwqPK8FMX6NHaNBQxXpDCU93kMeEUyfWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746405913; c=relaxed/simple;
	bh=+fWpaTEUHfp85Vyx4q9ZQhFu8kyDE2e74f+VVwYArv0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ct9TKmlR3iDYbjKMyufoLj5PFecefPkEqmbHj5c0iLVx8gLXqllbyYyyjtedP5sxekz2zUO6Ez2zkEdjWGtfJDMBUWNy+3d7rvvmohZO5//cKCgTzZPoyrYhge9gFhgfZ3PgORZglV4jqij48/Jh4Q741hfE9UclU/Mm7+pIBCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wMPrqOd7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5450j6xqD3293126, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746405906; bh=+fWpaTEUHfp85Vyx4q9ZQhFu8kyDE2e74f+VVwYArv0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=wMPrqOd7+BXdwnVCY588dVm4HUnF4D43GBvx4/zrKky23pdep52AiKVlqf8fN1PXI
	 7uKPansJCME2M50Azp0+MXB3AhMqZmX/CofqFnJS2GA77jolltsdxIeFab0dlOHaba
	 USHD/0YO4e4bFZweflP/S4hEJEH5mBToatK0HT7NOX/pfv1v7Taent+fLKT9sS5oGg
	 pNvuoUo1EyJWrZKoZF6U4djy15bAXcxC1hibmCVvS/T1rniGyX7Wadk/ZhBA3Nnz25
	 8W/S5XHiwp3cCyp/lX4W+kSP8GqjcITa2clXlXMvp9qev7x15/j6htAiOO5Yz2Qy0G
	 Drpvxvb8nTkXA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5450j6xqD3293126
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 May 2025 08:45:06 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 08:45:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 May 2025 08:45:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 5 May 2025 08:45:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 1/2] wifi: rtw88: Fix RX aggregation settings for RTL8723DS
Thread-Topic: [PATCH rtw-next v2 1/2] wifi: rtw88: Fix RX aggregation settings
 for RTL8723DS
Thread-Index: AQHbu1g2keO++OToo0SJCbdFTG8i17PDNLaw
Date: Mon, 5 May 2025 00:45:06 +0000
Message-ID: <43ff8b6babd649b895e8af8993d53c36@realtek.com>
References: <4c79fdc1-54bc-4986-9931-bb3ceb418b97@gmail.com>
In-Reply-To: <4c79fdc1-54bc-4986-9931-bb3ceb418b97@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBVc2Ug
dGhlIHNhbWUgUlggYWdncmVnYXRpb24gc2l6ZSBhbmQgdGltZW91dCB1c2VkIGJ5IHRoZSBvdXQt
b2YtdHJlZQ0KPiBSVEw4NzIzRFMgZHJpdmVyLiBBbHNvIHNldCBteXN0ZXJ5IGJpdCAzMSBvZiBS
RUdfUlhETUFfQUdHX1BHX1RILiBUaGlzDQo+IGltcHJvdmVzIHRoZSBSWCBzcGVlZCBmcm9tIH40
NCBNYnBzIHRvIH42NyBNYnBzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IC0tLQ0KPiB2MjoNCj4gIC0gUmVzdG9yZSB0
aGUgb3JpZ2luYWwgYmVoYXZpb3VyIGZvciBSVEw4ODIxQSBhbmQgUlRMODgxMkEuDQoNClRoaXMg
cGF0Y2ggYWN0dWFsbHkgcmVzdG9yZXMgdGhlIGJlaGF2aW9yIG9mIFJUTDg4MjFBIGFuZCBSVEw4
ODEyQS4gQnV0DQp0aGV5IGFyZSA4MDIuMTFhYyBjaGlwcyBbMV0gWzJdLCBzb21laG93IGRlZmlu
ZWQgYXMgUlRXX1dDUFVfMTFOLiANCg0KSSBjYW4gYWNjZXB0IHRoaXMgcGF0Y2ggYWhlYWQuIFBs
ZWFzZSBoZWxwIHRvIHRoaW5rIGhvdyB3ZSBjYW4gY29ycmVjdA0KdGhpcyBtaXN0YWtlLiANCg0K
QWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQpbMV0gaHR0cHM6
Ly93d3cucmVhbHRlay5jb20vUHJvZHVjdC9JbmRleD9pZD01NzcmY2F0ZV9pZD0xOTQNClsyXSBo
dHRwczovL3d3dy5yZWFsdGVrLmNvbS9Qcm9kdWN0L0luZGV4P2lkPTU5MCZjYXRlX2lkPTE5NA0K
DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9zZGlvLmMgfCAx
NCArKysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OC9zZGlvLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3Nk
aW8uYw0KPiBpbmRleCBjNTdmNjgzZDlhZjguLjcxY2JlNDliNmM1OSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9zZGlvLmMNCj4gKysrIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9zZGlvLmMNCj4gQEAgLTY3NywxMiArNjc3LDIy
IEBAIHN0YXRpYyB2b2lkIHJ0d19zZGlvX2VuYWJsZV9yeF9hZ2dyZWdhdGlvbihzdHJ1Y3QgcnR3
X2RldiAqcnR3ZGV2KQ0KPiAgew0KPiAgICAgICAgIHU4IHNpemUsIHRpbWVvdXQ7DQo+IA0KPiAt
ICAgICAgIGlmIChydHdfY2hpcF93Y3B1XzExbihydHdkZXYpKSB7DQo+ICsgICAgICAgc3dpdGNo
IChydHdkZXYtPmNoaXAtPmlkKSB7DQo+ICsgICAgICAgY2FzZSBSVFdfQ0hJUF9UWVBFXzg3MDNC
Og0KPiArICAgICAgIGNhc2UgUlRXX0NISVBfVFlQRV84ODIxQToNCj4gKyAgICAgICBjYXNlIFJU
V19DSElQX1RZUEVfODgxMkE6DQo+ICAgICAgICAgICAgICAgICBzaXplID0gMHg2Ow0KPiAgICAg
ICAgICAgICAgICAgdGltZW91dCA9IDB4NjsNCj4gLSAgICAgICB9IGVsc2Ugew0KPiArICAgICAg
ICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgY2FzZSBSVFdfQ0hJUF9UWVBFXzg3MjNEOg0KPiAr
ICAgICAgICAgICAgICAgc2l6ZSA9IDB4YTsNCj4gKyAgICAgICAgICAgICAgIHRpbWVvdXQgPSAw
eDM7DQo+ICsgICAgICAgICAgICAgICBydHdfd3JpdGU4X3NldChydHdkZXYsIFJFR19SWERNQV9B
R0dfUEdfVEggKyAzLCBCSVQoNykpOw0KPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAg
ICAgZGVmYXVsdDoNCj4gICAgICAgICAgICAgICAgIHNpemUgPSAweGZmOw0KPiAgICAgICAgICAg
ICAgICAgdGltZW91dCA9IDB4MTsNCj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAg
IH0NCj4gDQo+ICAgICAgICAgLyogTWFrZSB0aGUgZmlybXdhcmUgaG9ub3IgdGhlIHNpemUgbGlt
aXQgY29uZmlndXJlZCBiZWxvdyAqLw0KPiAtLQ0KPiAyLjQ5LjANCg0K

