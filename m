Return-Path: <linux-wireless+bounces-6497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0338A938F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 08:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDCA1C20BC6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 06:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC832D057;
	Thu, 18 Apr 2024 06:54:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B896BF9E9;
	Thu, 18 Apr 2024 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423268; cv=none; b=vFttEhXWzo1L7iHG9bd+RPfmQcZqefjAaRZB6rJXxx3ShZHEJXr8TNGWk600tlMofSZ8TXocHJRFaWmj/z1ts7mfvE/5Ch00gJ03Ff6Vn/8BeDHFCobplfjkdraCBvoFaQdE35mjJjGuYvFl9knrk/428DWwG1Mvdt1hrkQxqeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423268; c=relaxed/simple;
	bh=mhYZZNbDMNOgWfIaFRUNGRT0avxSypQAg5nsiFDhP7Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=slwY82MCAmR9oQdpO0zG+OrIZFvLCdTfeZCmQZtRfihVA6S5XSdeVpTicfT3ByZqPJ7MATJepNCOu2sB3HL2IEJRYi7JudU5RAfOsGhSbrpALLMBr7BVQEPMO3MO4MdhjH8nsePkEcOPEsC3l6RXVOnFRHxCS0qh4yMue7DxZ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43I6sFHP1037130, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43I6sFHP1037130
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 14:54:15 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 14:54:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 14:54:16 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 18 Apr 2024 14:54:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] wifi: rtl8xxxu: enable MFP support
Thread-Topic: [PATCH 2/2] wifi: rtl8xxxu: enable MFP support
Thread-Index: AQHakKpmN+k3bxFC206ySgnAPq76G7FtKcXg///nXICAAIdW0A==
Date: Thu, 18 Apr 2024 06:54:16 +0000
Message-ID: <d697a217e5a747f29c2c23bf6eb275b2@realtek.com>
References: <20240417093352.1840632-1-martin.kaistra@linutronix.de>
 <20240417093352.1840632-3-martin.kaistra@linutronix.de>
 <6a1571aadad1486eb83a19437e1d2437@realtek.com>
 <137a9ecb-d5de-4471-bbc1-32986b735f28@linutronix.de>
In-Reply-To: <137a9ecb-d5de-4471-bbc1-32986b735f28@linutronix.de>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

TWFydGluIEthaXN0cmEgPG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPiBB
bSAxOC4wNC4yNCB1bSAwMjoxOSBzY2hyaWViIFBpbmctS2UgU2hpaDoNCj4gPiBNYXJ0aW4gS2Fp
c3RyYSA8bWFydGluLmthaXN0cmFAbGludXRyb25peC5kZT4gd3JvdGU6DQo+ID4NCj4gPj4NCj4g
Pj4gSW4gb3JkZXIgdG8gY29ubmVjdCB0byBuZXR3b3JrcyB3aGljaCByZXF1aXJlIDgwMi4xMXcs
IGFkZCB0aGUNCj4gPj4gTUZQX0NBUEFCTEUgZmxhZyBhbmQgbGV0IG1hYzgwMjExIGRvIHRoZSBh
Y3R1YWwgY3J5cHRvIGluIHNvZnR3YXJlLg0KPiA+Pg0KPiA+PiBXaGVuIGEgcm9idXN0IG1hbmFn
ZW1lbnQgZnJhbWUgaXMgcmVjZWl2ZWQsIHJ4X2RlYy0+c3dkZWMgaXMgbm90IHNldCwNCj4gPj4g
ZXZlbiB0aG91Z2ggdGhlIEhXIGRpZCBub3QgZGVjcnlwdCBpdC4gRXh0ZW5kIHRoZSBjaGVjayBh
bmQgZG9uJ3Qgc2V0DQo+ID4+IFJYX0ZMQUdfREVDUllQVEVEIGZvciB0aGVzZSBmcmFtZXMgaW4g
b3JkZXIgdG8gdXNlIFNXIGRlY3J5cHRpb24uDQo+ID4+DQo+ID4+IFVzZSB0aGUgc2VjdXJpdHkg
ZmxhZyBpbiB0aGUgUlggZGVzY3JpcHRvciBmb3IgdGhpcyBwdXJwb3NlLCBsaWtlIGl0IGlzDQo+
ID4+IGRvbmUgaW4gdGhlIHJ0dzg4IGRyaXZlci4NCj4gPj4NCj4gPj4gQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gPj4gU2lnbmVkLW9mZi1ieTogTWFydGluIEthaXN0cmEgPG1hcnRpbi5r
YWlzdHJhQGxpbnV0cm9uaXguZGU+DQo+ID4NCj4gPiBJIHdvdWxkIGxpa2UgdG8gY2hhbmdlIHN1
YmplY3QgdG8NCj4gPiAid2lmaTogcnRsOHh4eHU6IGVuYWJsZSBNRlAgc3VwcG9ydCB3aXRoIHNl
Y3VyaXR5IGZsYWcgb2YgUlggZGVzY3JpcHRvciIsDQo+ID4gYmVjYXVzZSB0aGUgc2FtZSBzdWJq
ZWN0IGFzIGZvcm1lciBwYXRjaCBjYXVzZSBjb25mdXNpbmcuIEkgY2FuIGNoYW5nZSB0aGF0DQo+
ID4gZHVyaW5nIGNvbW1pdHRpbmcuDQo+ID4NCj4gPiBPdGhlcnMgYXJlIGdvb2QgdG8gbWUuDQo+
ID4NCj4gDQo+IG9rLCBzdWJqZWN0IGNoYW5nZSBpcyBmaW5lIGZvciBtZS4NCj4gSSBqdXN0IG5v
dGljZWQgdGhvdWdoLCB0aGF0IEkgbmFtZWQgdGhlIGVudW0gInJ0d19yeF9kZXNjX2VuYyIgaW5z
dGVhZCBvZiB0aGUNCj4gcHJvYmFibHkgbW9yZSBhcHByb3ByaWF0ZSAicnRsOHh4eHVfcnhfZGVz
Y19lbmMiLiBTaG91bGQgSSBjaGFuZ2UgdGhhdD8NCg0KSSBtaXNzZWQgdGhhdC4gUGxlYXNlIGRv
IGl0IGFuZCBjaGFuZ2UgdGhlIHN1YmplY3QgYnkgdGhlIHdheS4gVGhhbmtzLg0KDQpQaW5nLUtl
DQoNCg==

