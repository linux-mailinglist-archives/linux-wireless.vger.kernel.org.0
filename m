Return-Path: <linux-wireless+bounces-19360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 136ABA41294
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 02:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332DA16F72D
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 01:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C5418B03;
	Mon, 24 Feb 2025 01:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="e+fpQwIt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC7A28F1
	for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 01:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740359913; cv=none; b=LlRr5OPYO9O2ZaFiTxWZ9g5C2wWQm3n6OqtCJZ/9H5OODCs7fuujJOMcFRKwbE6XMKCP2sDhwyWcNFvxvvPaGuKdPYsjgzLnjcpdsUHednExycjFyrA+qqu/+UH8XrW5okXifBgxe9RU95Gby32uP2fpYgew+cGF1qJrRhZYl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740359913; c=relaxed/simple;
	bh=28YIXNDKMA/QiM84VabvPq3AaIwgTayLdE8EcOt2sVU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dzpd93WXaNBmEZITtfLlkKzeRlvs7NYhezOozQTQ/u0FMlgE7TD7hvHT9qjNHLotQy9CkLZR8unLjBT45QBLmRbP1F0SLd0ZHIhCPknouDsUtHbbOgHKQeWOXgu6Sdtu4z/upmrmi5pZBUO0Qnlt4Yxp73vX72N8LAVq3Kr7mGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=e+fpQwIt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51O1IIg142777736, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740359898; bh=28YIXNDKMA/QiM84VabvPq3AaIwgTayLdE8EcOt2sVU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=e+fpQwItmnnL7t2mXaFjYY2ps43USWXKlnt1lGIbf0N/WQBqIctwoLrt+O6mdvAZA
	 snSgk99z20sjkyfQeodGszOL6tIy9Q7C69PgHUwXQiqYohtzCDtdSmIdXanMPxPrps
	 5DzCFZ1mG/gmOgKPOhYxFBeXhK+vkjq8iPDLoqHRlGKxPlgmoZ9exzwpse9Il0xQpt
	 +1W+UN7NmKtfaRst6OVwY4lzHpNbimPWCVUIyB5HHZ6rMOYmXBWRNPzgTD5Rwrs/R+
	 H2wJWE34SQAWdKE/WEgUQzKE8IWfvSpv32sZrle3ItcSqUuNpkhaXTXuXtFsjGCJsr
	 XfxFLfx5Ry1wA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51O1IIg142777736
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 09:18:18 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Feb 2025 09:18:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 24 Feb 2025 09:18:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Mon, 24 Feb 2025 09:18:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: please use tree tags in patches
Thread-Topic: please use tree tags in patches
Thread-Index: AQHbhFq+62BYiV3itUS6AdtCRa4fPLNVocQw
Date: Mon, 24 Feb 2025 01:18:19 +0000
Message-ID: <a5451ef8e9534ed4b2223f50c3ddda14@realtek.com>
References: <ec3a3d891acfe5ed8763271a1df4151d75daf25f.camel@sipsolutions.net>
In-Reply-To: <ec3a3d891acfe5ed8763271a1df4151d75daf25f.camel@sipsolutions.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4gd3JvdGU6DQo+IEhpLA0K
PiANCj4gSSBjb3VsZG4ndCAoeWV0PykgZmlndXJlIG91dCBob3cgdG8gbWFrZSB0aGUgbmlwYSBi
b3Qgc3R1ZmYgcnVuDQo+IHByb3Blcmx5LCBzbyBwbGVhc2Ugc3RhcnQgdXNpbmcNCj4gDQo+ICAg
W1BBVENIIHdpcmVsZXNzXSB3aWZpOiB4eXoNCj4gDQo+IG9yDQo+IA0KPiAgIFtQQVRDSCB3aXJl
bGVzcy1uZXh0XSB3aWZpOiB4eXoNCj4gDQo+IGZvciB0aGUgc3ViamVjdCBsaW5lLiBUaGlzIHdh
eSB0aGUgYXV0b21hdGlvbiBjYW4gcGljayBpdCB1cCwgc2VlIGUuZy4NCj4gDQo+IGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9saXN0Lz9zZXJpZXM9
OTM2Mzc0DQo+IA0KPiBJJ2xsIG5lZWQgdG8gZml4IHNvbWUgdXNlcm5hbWUgc3R1ZmYgZXRjLg0K
PiANCj4gSSBsaWtlbHkgYWxzbyBuZWVkIHRvIGFkZCBtb3JlIHRyZWVzIHRvIGl0IC0gcGxlYXNl
IHJlcGx5IHdpdGggeW91cg0KPiBzdWJqZWN0IHRhZ3MsIHRyZWVzIGFuZCBicmFuY2hlcyB0byB1
c2UsIGUuZy4NCj4gDQo+IHdpcmVsZXNzOiBtYWluDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3dpcmVsZXNzL3dpcmVsZXNzLmdpdC8NCj4gDQo+IHdp
cmVsZXNzLW5leHQ6IG1haW4NCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvd2lyZWxlc3Mvd2lyZWxlc3MtbmV4dC5naXQvDQo+IA0KPiBidXQgcGVyaGFw
cyB3ZSB3YW50IHRvIGhhdmUNCj4gDQo+IHJ0dy1uZXh0OiBydHctbmV4dA0KPiBodHRwczovL2dp
dGh1Yi5jb20vcGtzaGloL3J0dw0KPiANCj4gb3Igc28/IE5vdCBzdXJlIGlmIHlvdSBtYWludGFp
biBhIGZpeGVzIGJyYW5jaCB0aGVyZSB0b28/DQo+IA0KPiANCj4gQW55d2F5LCBnb29kIGx1Y2sg
dG8gbWUsIGFuZCBwbGVhc2UgZG9uJ3QgdHJ5IHRvIGF0dGFjayBpdCA7LSkgSSBzcGVudA0KPiBh
bGwgZGF5IHNldHRpbmcgaXQgdXAsIGFuZCBoYXZlbid0IHB1bGxlZCBvdXQgZXZlcnl0aGluZyB5
ZXQuDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBhdXRvbWF0aW9uLiBJIHRoaW5rIGl0IHdpbGwgYmUg
dmVyeSB1c2VmdWwgZm9yIG1lIHRvIGRldGVjdA0KcGF0Y2ggZXJyb3JzIGVhcmxpZXIsIHNvIHN1
Ym1pdHRlcnMgY2FuIGZpeCBwcm9ibGVtcyBlYXJsaWVyIGJlZm9yZSBJJ20NCnRyeWluZyB0byBt
ZXJnZS4gDQoNCkkgaGF2ZSBjcmVhdGVkIHJ0dyBicmFuY2ggYXMgdGhlIGZpeGVzIGJyYW5jaCwg
c28NCg0KW1BBVENIIHJ0dy1uZXh0XQ0KaHR0cHM6Ly9naXRodWIuY29tL3Brc2hpaC9ydHcgcnR3
LW5leHQNCihjbG9uZSBmcm9tIHdpcmxlc3MtbmV4dC9tYWluOyB0aGlzIGlzIGZvciByZWd1bGFy
IGRldmVsb3BtZW50KQ0KDQpbUEFUQ0ggcnR3XQ0KaHR0cHM6Ly9naXRodWIuY29tL3Brc2hpaC9y
dHcgcnR3DQooY2xvbmUgZnJvbSB3aXJlbGVzcy9tYWluOyB0aGlzIGlzIGZvciB1cmdlbnQgZml4
ZXMpDQoNClBpbmctS2UNCg0K

