Return-Path: <linux-wireless+bounces-9415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21FB911E4A
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8525128178C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DFC16D9B9;
	Fri, 21 Jun 2024 08:08:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF0D16DC18
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718957314; cv=none; b=DP6orEX9OwZblFctHxlWOzQKWMO0MQB08PZt+hOwUf1+lTwZhO1X3UUEn3MLIxECa6zGZDzZvJajAStaI33T/btkGSXmIHoysJcw0xcyn1vqlRbyx0d4TypY2S0LVwoWy0pYIMca96SRd4SbT76NjYhhF1a59RDHasWE0mE6TP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718957314; c=relaxed/simple;
	bh=+xqiUgbm+cDFprQpM2GFJ4ZUATj/B7omLYQdgJwSzLs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ylact2Lq2JBfzDJJyf81dZWi6nONUrsAnQOEO3zjaK4HSLxjWtm7qyAN47oA61g8S4WAhiWw4RVYyWXV4yEKU/oJ1FUWtenzEMHbL9kyYEzTsi0MB6WxVFu9RyuBSBXOzsulUIKep3MguoHdpUSBES6GSxNjrTvgrhLQR65bB4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45L88IbA43893534, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45L88IbA43893534
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 16:08:18 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 16:08:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 21 Jun 2024 16:08:17 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 21 Jun 2024 16:08:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "wens@kernel.org" <wens@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "wireless-regdb@lists.infradead.org" <wireless-regdb@lists.infradead.org>
Subject: RE: [PATCH 4/5] wireless-regdb: Update regulatory info for Costa Rica (CR) for 2021
Thread-Topic: [PATCH 4/5] wireless-regdb: Update regulatory info for Costa
 Rica (CR) for 2021
Thread-Index: AQHauILpfD9ajqwiO0a6TaHLj4CLJrHRT22AgACjR/A=
Date: Fri, 21 Jun 2024 08:08:17 +0000
Message-ID: <162a7af8f9524b499d4eb7e100246103@realtek.com>
References: <20240607023058.34002-1-pkshih@realtek.com>
 <20240607023058.34002-4-pkshih@realtek.com>
 <CAGb2v65k7M0=fiJoVaNUFxKCsRQXcv7mmXjDEJ0-OnV2uTUE1w@mail.gmail.com>
In-Reply-To: <CAGb2v65k7M0=fiJoVaNUFxKCsRQXcv7mmXjDEJ0-OnV2uTUE1w@mail.gmail.com>
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

Q2hlbi1ZdSBUc2FpIDx3ZW5zQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBKdW4g
NywgMjAyNCBhdCAxMDozMeKAr0FNIFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiB3
cm90ZToNCj4gPg0KPiA+ICsjIFNvdXJjZToNCj4gPiArIw0KPiBodHRwczovL3N0b3JhZ2UuZ29v
Z2xlYXBpcy5jb20vZWxlb3Njb21wbGlhbmNlMS5hcHBzcG90LmNvbS9wdWJsaWMvUE5BRiUyMG1v
ZGlmaWNhY2klQzMlQjNuJTIwQUxDQTg3XzMNCj4gMF8wNF8yMDIxLnBkZg0KPiA+ICBjb3VudHJ5
IENSOiBERlMtRkNDDQo+ID4gLSAgICAgICAoMjQwMiAtIDI0ODIgQCA0MCksICgyMCkNCj4gPiAt
ICAgICAgICg1MTcwIC0gNTI1MCBAIDIwKSwgKDE3KQ0KPiA+ICsgICAgICAgKDI0MDIgLSAyNDgy
IEAgNDApLCAoMzApDQo+ID4gKyAgICAgICAoNTE3MCAtIDUyNTAgQCAyMCksICgyNCkNCj4gPiAg
ICAgICAgICg1MjUwIC0gNTMzMCBAIDIwKSwgKDI0KSwgREZTDQo+ID4gICAgICAgICAoNTQ5MCAt
IDU3MzAgQCAyMCksICgyNCksIERGUw0KPiA+ICAgICAgICAgKDU3MzUgLSA1ODM1IEAgMjApLCAo
MzApDQo+ID4gKyAgICAgICAoNTg3NSAtIDU5MjUgQCAyMCksICgyNCkNCj4gPiArICAgICAgICg1
OTI1IC0gNzEyNSBAIDMyMCksICgyNCksIE5PLU9VVERPT1INCj4gDQo+IEkgYmVsaWV2ZSB0aGUg
a2VybmVsIHVzZXMgRUlSUCB2YWx1ZXMuIFRoYXQgbWVhbnMgdXNpbmcgdGhlIHZhbHVlcyBpbiB0
aGUNCj4gdGhpcmQgY29sdW1uIG9mIHRoZSB0YWJsZSBpbiB0aGUgcmVmZXJlbmNlLg0KDQpGaXhl
ZCBieSB2MiBbMV0uIFRoYW5rcy4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LXdpcmVsZXNzLzIwMjQwNjIxMDgwMzQ4LjU1NTA0LTEtcGtzaGloQHJlYWx0ZWsuY29tL1QvI21l
NzdkMDIzNDgwMTc0NmEwOWQyNmNmN2E1MWJlMDg4ODY0OThmNjI5DQoNCg==

