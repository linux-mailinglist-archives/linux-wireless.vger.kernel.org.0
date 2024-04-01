Return-Path: <linux-wireless+bounces-5704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237578936B0
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 03:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E841F2196D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 01:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E275A32;
	Mon,  1 Apr 2024 01:21:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC20623
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711934506; cv=none; b=MWeSclLZEdY8KVAnq2K7MBaYtuwoQ2dHuwxqpklJ/OhHceHKqODc/m9T4q53J24WKCM0BBuX1VeEJz4JS0aCGh8QlQebu37P32Wntz26cy+L0P/EzQTBwGq4soG0YnJ3qeSDj8UJDCR6Af7t95yd2oaNc+GdIYRk+ZItDszIJDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711934506; c=relaxed/simple;
	bh=diAKk23ngQqpmiHYqWcXvw+Wr8HHDQADLOGaKhB/vTQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eQ+/A/Jo6QYpbEHsEkZNPiy0MIGH+UcN3v3fSD94UhSWDz4fkzRqNBOmlAVpkFT6reg5yL/jUl5cJGvDsWbcfs9PPiPLWyNEXFWRY4WxCP44CjxEbK/s84a57oO9GqDqXgLhpywkPTXRwgeIezy3lvnfr5s38Ivi5LylTOxShU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4311L1pO42277031, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4311L1pO42277031
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Apr 2024 09:21:01 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 09:21:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 09:21:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::18c6:1095:cf1d:f7e6]) by
 RTEXMBS04.realtek.com.tw ([fe80::18c6:1095:cf1d:f7e6%5]) with mapi id
 15.01.2507.035; Mon, 1 Apr 2024 09:21:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: RE: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
Thread-Topic: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
Thread-Index: AQHaev7lVhGGoQ4nQ0GxbEPAiHfc3rFCwUMAgAhizQCAANTTI///vigAgAAwEwCAAMUwAIABPbAAgAPR/oCAAO0mAA==
Date: Mon, 1 Apr 2024 01:21:01 +0000
Message-ID: <7741a59a6ebf4e0f8c55b0f5c3f55a41@realtek.com>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
 <2eb79c8c-cf2c-4696-b958-e8d961628e17@gmail.com>
 <f86a40493745a53ff73083f87b3e8fae215eac77.camel@realtek.com>
 <66565618-3638-47e5-afe5-3530214da0c9@gmail.com> <87ttkrzf1m.fsf@kernel.org>
 <5696990a-4450-4d92-bbda-1d9ca3a9a619@gmail.com>
 <4672072ef782ae1200886a190c740e0f3ccec2c8.camel@realtek.com>
 <7873dee1-46a8-48a7-9059-bc300ac98c23@gmail.com>
 <1f8ebed6a04a4fbebf33b0a3edc2f50b@realtek.com>
 <ff3b97d0-118c-42b3-be0b-47cfcf06ab74@gmail.com>
In-Reply-To: <ff3b97d0-118c-42b3-be0b-47cfcf06ab74@gmail.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

PiANCj4gSSBhc2tlZCBsaW51eC11c2IgYW5kIHRoZXkgc2FpZCB0aGUgdHdvIGludGVyZmFjZXMg
YXJlIHByb2JlZA0KPiBhbmQgZGlzY29ubmVjdGVkIG9uZSBhdCBhIHRpbWUsIHNvIGl0IHNob3Vs
ZCBiZSBmaW5lIHdpdGhvdXQNCj4gYW5vdGhlciBtdXRleDoNCj4gDQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LXVzYi8yMDI0MDMyOTA3LXNtb2tlbGVzcy1pbXBlcmlhbC1mM2Y5QGdy
ZWdraC8NCg0KVGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbi4gVGhlbiwgd2lsbCB5b3UgZHlu
YW1pY2FsbHkgYWxsb2NhdGUgbXV0ZXgNCmJ5IGZpcnN0IGludGVyZmFjZSB3aXRoIHJlZl9jbnQ9
MSwgYW5kIHNlY29uZCBpbnRlcmZhY2Ugb2J0YWlucyBtdXRleCBmcm9tDQpmaXJzdCBpbnRlcmZh
Y2UgYW5kIGluY3JlYXNlcyByZWZfY250PTI/DQoNCldoZW4gVVNCIGRpc2Nvbm5lY3Rpb24sIGRl
Y3JlYXNlIHJlZl9jbnQgYW5kIGlmIHJlZl9jbnQ9PTAgZnJlZSB0aGUgbXV0ZXggDQpubyBtYXR0
ZXIgd2hpY2ggb25lIGRpc2Nvbm5lY3QgZmlyc3QuIA0KDQpNeSB0aGlua2luZyBhYm92ZSBpcyB0
aGUgc2FtZSBhcyB5b3Vycz8NCg0KDQo=

