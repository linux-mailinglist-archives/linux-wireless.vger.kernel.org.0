Return-Path: <linux-wireless+bounces-7824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846288C931B
	for <lists+linux-wireless@lfdr.de>; Sun, 19 May 2024 02:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F00B28196E
	for <lists+linux-wireless@lfdr.de>; Sun, 19 May 2024 00:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D9A39B;
	Sun, 19 May 2024 00:01:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15146163
	for <linux-wireless@vger.kernel.org>; Sun, 19 May 2024 00:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716076874; cv=none; b=oXMY9mQIFNi4RmXWZqcF+Mo1OgNkgCw6IU4H7MksL9edczdreNjdHeELAF8ZQ+CvQLC3J22N5Qb35kzuaPwgdfH9/mtFmJ+b+N81IUd88xHG94P2hKNcYCdXIpvbsFLIywK3Hpbm+pvjKEqkjJeozHEmdeiXkkjucqHIBxtB4C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716076874; c=relaxed/simple;
	bh=v3Tchi3rFlYycz7v77Gn+ugrRvUO7r9nv2KQuTtgd+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k8KtWL7jcc7pi6jcwyDyLVpiOJNv8Q75eiSTpAaggxwzGKCdGr2RV3CX4IsrTYGB/3kc8Xld3RWg+r2YBHfUeXbmTfp2W74d7Gh5vglqABMqtzYIAnzktbdvudPuqVoKHMw/hsAR1hveyoRT5/kGHDbQ3+hXAimVXAficpBTkao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44J00l3iA3873108, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44J00l3iA3873108
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 May 2024 08:00:47 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 19 May 2024 08:00:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 08:00:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Sun, 19 May 2024 08:00:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Larry.Finger@gmail.com" <Larry.Finger@gmail.com>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH v2] linux-firmware: Add ordinary firmware for RTL8821AU device
Thread-Topic: [PATCH v2] linux-firmware: Add ordinary firmware for RTL8821AU
 device
Thread-Index: AQHaqLyk9cuWMhljlkiILrPzprx6d7GdJ4uA
Date: Sun, 19 May 2024 00:00:46 +0000
Message-ID: <e40c53904baae78c4c605a9d389920288952e39a.camel@realtek.com>
References: <4un2zu7ofgoz.76eagbFcUhFoEANVDT3_qQ2@1EHFQ.trk.elasticemail.com>
In-Reply-To: <4un2zu7ofgoz.76eagbFcUhFoEANVDT3_qQ2@1EHFQ.trk.elasticemail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <625660ECCA55BE45BCF1E00182DD2EEC@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gU2F0LCAyMDI0LTA1LTE4IGF0IDAwOjQzICswMDAwLCBMYXJyeSBGaW5nZXIgd3JvdGU6DQo+
IA0KPiBUaGlzIGZpcm13YXJlIHdhcyBleHRyYWN0ZWQgZnJvbSB0aGUgMjAyMTA3MDggcmVsZWFz
ZSBvZiB0aGUgdmVuZG9yDQo+IGRyaXZlciBmb3IgdGhpcyBkZXZpY2UuIFRoZSBmaXJtd2FyZSBj
b3JyZXNwb25kcyB3aXRoIHRoZSBsYXRlc3QNCj4gcmVsZWFzZSBieSBSZWFsdGVrLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTGFycnkgRmluZ2VyIDxMYXJyeS5GaW5nZXJAbHdmaW5nZXIubmV0Pg0K
PiAtLS0NCj4gQ2hhbmdlcw0KPiB2MiAtIENoYW5nZWQgYWRkcmVzcyB0byBsaW51eC1maXJtd2Fy
ZUBrZXJuZWwub3JnDQo+IA0KDQpJIHN0aWxsIGhhdmUgdGhlIHNhbWUgcHJvYmxlbSBsaWtlIHYx
LCB3aGljaCBydHc4OC9ydHc4ODIxYV9mdy5iaW4NCndhcyB0cnVuY2F0ZWQgdG8gMCwgd2hlbiBJ
IGFwcGxpZWQgaXQgYnkgJ3B3Y2xpZW50IGdpdC1hbSAxMzY2NzQ3MCcuIA0KDQpUaGVuIEkgdXNl
ZCAncHdjbGllbnQgZ2V0IDEzNjY3NDcwJyB0byBnZXQgYSBsb2NhbCBmaWxlLCBhbmQgbW92ZWQN
ClJFQURNRSBhbmQgV0hFTkNFIGNodW5rIHVwd2FyZCwgYW5kIHRoZW4gSSBjYW4gZ2V0IGV4cGVj
dGVkDQpydHc4OC9ydHc4ODIxYV9mdy5iaW4sIHdoaWNoIGlzIGlkZW50aWNhbCB0byB0aGUgcmVs
ZWFzZWQgZmlybXdhcmUuDQoNCk5vdCBzdXJlIGlmIHRoYXQgaXMgbXkgbG9jYWwgZ2l0IHByb2Js
ZW0uIEFueXdheSBmaXJtd2FyZSBpcyBmaW5lDQp0byBtZSwgc28NCg0KUmV2aWV3ZWQtYnk6IFBp
bmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

