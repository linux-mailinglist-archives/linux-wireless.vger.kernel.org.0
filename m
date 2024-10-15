Return-Path: <linux-wireless+bounces-13957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0262B99E2E9
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 11:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65014B22675
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0F01B0137;
	Tue, 15 Oct 2024 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="UCi50yug"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C01DDC08
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984959; cv=none; b=JeCtumtYqyFUCyR6Yt8iBt5N+6WDzjEbwNYEo1I0G6C32o4IQdG5whxP8bgap7SQe1LUt9EomZ4cHmriIo98A7D1NQwGYN1mQSSnFBQs1jmDkkJRSGbhZKzXi2D+1IrjkQQuTRgAzN+1Hk3k7I2D0wKS16EFgNHN8nUWEqp9Isk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984959; c=relaxed/simple;
	bh=VVyIcN4bjq5EiwWfyS9Vg1G8jVYSsIcS4f7bDsRAKSY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pVySKu4u0jh+9l4ZoMeb+qxZK8OHgVV753kQoe2g3yVyTAFY5t1mHq6Z20B6dbkq/yrYT4nJjnfDC8gXvPlR5KERszwq+xn3hFBhGhJ0gdfgicAmK7CuCaFmOkTdb0WyP3y0FhhUiMRijAgGxKe13+Ucod2UZ93W0Uggd0FSNTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=UCi50yug; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49F9ZdFxA1241444, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728984939; bh=VVyIcN4bjq5EiwWfyS9Vg1G8jVYSsIcS4f7bDsRAKSY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=UCi50yug2g10mBxx/4Zg27AKk+azqarKC3qDAQZeosiHbcO99ccuQksiG4bJQ4h5x
	 yQnljeNOLDCnlLS6mVdnXG9oJvDokd/ywvyCxvDlHSqTI7NLiBfH31cut5qgvEhFU2
	 hrjFfXHuAYqjt0B2HIHDpIRmCfV0kbaTwPjsiL9woFJ9kL9DmPj5xruKDCcGkPIoAB
	 eT5a1NlUKwyLdqF9cCyz4riwomNvfRJSmBVU+3faeM7PsKIAfhByT1UOz6KUgU2oRU
	 TBTSWXyL0o/LGu9iOyqIIYDN5ODdEkPTpjF5t4/5tfORPTTAgTbAQQNGvVZTXChjNw
	 SUkcBvMS98IZQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49F9ZdFxA1241444
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 17:35:39 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 17:35:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 15 Oct 2024 17:35:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 15 Oct 2024 17:35:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>, Bitterblue Smith <rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtlwifi: rtl8192du: Don't claim USB ID 0bda:8171
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8192du: Don't claim USB ID 0bda:8171
Thread-Index: AQHbGynxRkG6/djiCEqH16RdBt6+gbKHC1CAgACJOcA=
Date: Tue, 15 Oct 2024 09:35:39 +0000
Message-ID: <35868a383b4c488aa263aee9d32d3224@realtek.com>
References: <40245564-41fe-4a5e-881f-cd517255b20a@gmail.com>
 <172898420024.235905.11004494352014224008.kvalo@kernel.org>
In-Reply-To: <172898420024.235905.11004494352014224008.kvalo@kernel.org>
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

S2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz4gd3JvdGU6DQo+IEJpdHRlcmJsdWUgU21pdGgg
PHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+ID4gVGhpcyBJRCBhcHBlYXJz
IHRvIGJlIFJUTDgxODhTVSwgbm90IFJUTDgxOTJEVS4gVGhpcyBpcyB0aGUgd3JvbmcgZHJpdmVy
DQo+ID4gZm9yIFJUTDgxODhTVS4gVGhlIHI4NzEydSBkcml2ZXIgZnJvbSBzdGFnaW5nIGhhbmRs
ZXMgdGhpcyBJRC4NCj4gPg0KPiA+IEkgdGhpbmsgdGhpcyBJRCBjb21lcyBmcm9tIHRoZSBvcmln
aW5hbCBydGw4MTkyZHUgZHJpdmVyIGZyb20gUmVhbHRlay4NCj4gPiBJIGRvbid0IGtub3cgaWYg
dGhleSBhZGRlZCBpdCBieSBtaXN0YWtlLCBvciBpdCB3YXMgYWN0dWFsbHkgdXNlZCBmb3INCj4g
PiB0d28gZGlmZmVyZW50IGNoaXBzLg0KPiA+DQo+ID4gUlRMODE4OFNVIHdpdGggdGhpcyBJRCBl
eGlzdHMgaW4gdGhlIHdpbGQuIFJUTDgxOTJEVSB3aXRoIHRoaXMgSUQNCj4gPiBwcm9iYWJseSBk
b2Vzbid0Lg0KPiA+DQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyB2Ni4xMQ0KPiA+
IExpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9sd2Zpbmdlci9ydGw4MTkyZHUvaXNzdWVzLzEwNQ0K
PiA+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwu
Y29tPg0KPiA+IEFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4g
DQo+IEkgYXNzaWduZWQgdGhpcyB0byBtZSBvbiBwYXRjaHdvcmssIEknbGwgdGFrZSB0aGlzIHRv
IHdpcmVsZXNzIHRyZWUgYW5kIGFkZDoNCj4gDQo+IEZpeGVzOiBiNWRjODg3M2I2ZmYgKCJ3aWZp
OiBydGx3aWZpOiBBZGQgcnRsODE5MmR1L3N3LmMiKQ0KPiANCj4gT2s/DQoNCk9rLiBUaGFua3Mh
DQoNCg==

