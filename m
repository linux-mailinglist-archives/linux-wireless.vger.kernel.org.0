Return-Path: <linux-wireless+bounces-24139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C71ADAB96
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 11:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E0D7A9407
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D23270ED9;
	Mon, 16 Jun 2025 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="T4ztagIY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AEA270ECB
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750065275; cv=none; b=OKLxApwLmKFz3ZtBTAcnokhPrx/ARgzmbIsReeOaF1K40vCW5LGH/V/3NTgzhhjo791CelNfu/8LmcpuXMLSpwik10r6kx8B0rKKtNW8fVfwFIYhhX0oFZsO1lKj6p9chnblSWFbWtVE+2Y8FCmimwlSsFUiqlQnh6fPTwtu1pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750065275; c=relaxed/simple;
	bh=6tlo1oKUTX4QKbbUsd7z6uMgi1CBCOlsH8Vxv07idDA=;
	h=From:To:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=A9nJj40QnVLc7B1b+LM384vleOe+Kh71oPyeiB4H+9KyFwSgxOftQQWZ8o6AMHBerJbTHIY8slkmTtGXOAzP/WlVyhFKTGHkqhURirVLrl5FjA+HnwjhGpAp5UWlptFUdrTUizQpIEX7ILhbI3nLDTXnwnz0BaPhWDUpyl3puL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=T4ztagIY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G9EU5i8199065, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750065270; bh=6tlo1oKUTX4QKbbUsd7z6uMgi1CBCOlsH8Vxv07idDA=;
	h=From:To:Subject:Date:Message-ID:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=T4ztagIYDGXbQXRZ+ZnHJ9BIH3kyf9HtkpOUYVmqokVxGor6ziML2ZylEM3JViAMU
	 /4S7hrPLZu0WI0jrPrufh+BYWklOkz1NJQPYkr93kNWIBJjDlBB/gLflyL07wUw/fY
	 v9t9jKGgEtp9IFTdH+jzcGgaVy872sH9bPeHAql520kN98ZV9XVgx3BBhTIzxICSWS
	 6RsV0aj1TBAB9X0BbhwX3pdmBVfeIGh65/gfnduDLLqVi2tpKAldWAtgk/uVMIekH0
	 QA/KLoP29GblEzYEOxN36qEg0MPkxqSZ4CpxphMyLENVS/gG2/vKyOOXnMKQdCY+F9
	 Ek0Va3Aq4nmnw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G9EU5i8199065
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 17:14:30 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 17:14:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 16 Jun 2025 17:14:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 16 Jun 2025 17:14:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 10/14] wifi: rtw89: Fix rtw89_mac_power_switch() for USB
Thread-Topic: [PATCH rtw-next v2 10/14] wifi: rtw89: Fix
 rtw89_mac_power_switch() for USB
Thread-Index: AQHb2XUJUFHxlychD0Giom8L3zftw7QFEI4ggAB6R1A=
Date: Mon, 16 Jun 2025 09:14:23 +0000
Message-ID: <495e59f457b743a591ceba086902dbb0@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
 <1faf699e-b40c-4408-8655-b5bc8a6776e1@gmail.com> 
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

PiA+ICtzdGF0aWMgdm9pZCBydHc4OV9tYWNfcG93ZXJfc3dpdGNoX2Jvb3RfbW9kZShzdHJ1Y3Qg
cnR3ODlfZGV2ICpydHdkZXYpDQo+ID4gK3sNCj4gPiArICAgICAgIHUzMiBib290X21vZGU7DQo+
ID4gKw0KPiA+ICsgICAgICAgaWYgKHJ0d2Rldi0+aGNpLnR5cGUgIT0gUlRXODlfSENJX1RZUEVf
VVNCKQ0KPiANCj4gSSBjaGVja2VkIGludGVybmFsIGxvZyB0aGF0IGluaXRpYXRvciBvZiB0aGlz
IGNoYW5nZSBpcyBmb3IgVVNCIGRldmljZXMsIGJ1dA0KPiBub3QgY2hlY2sgdGhlIEhDSSB0eXBl
IHRob3VnaC4NCg0KRm9yZ2V0IHRvIHNheS4gVGhpcyBpcyBqdXN0IGFuIGluZm9ybWF0aW9uIGZv
ciB5b3UuIE5vIG5lZWQgdG8gY2hhbmdlIGhlcmUuDQoNCg0K

