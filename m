Return-Path: <linux-wireless+bounces-22653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E8CAABA72
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 09:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF145A122E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 07:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5601372;
	Tue,  6 May 2025 04:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="w0572cVC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447F02451C3
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 04:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746505112; cv=none; b=PT+Y2TDvqHehXne7DMutFn1msan51TFwXY+N2mx+lYdYqNXGJ5S10ACW1GmF1lCwy0m0TTsnkPRZkl/d691qAck+O+DM0If7flu0gv9VP5eY0fSSwqMaJ6KB9QFf9HxnS46aJS0qDJEtu5byXe92qCyCZsd27cPGzFWdnEzgoBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746505112; c=relaxed/simple;
	bh=Vv0Oh5mO95XY9jtbk02on+6wGqHHZ0N0bmJcCH59QdI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NaNDd0NvlawY9sjGAeTqAlyY+mhjdUYLnN79FOxuxQHx9KqgHdI+VqKjdT9N6+nYg+a8/EybMZWbtgQfEKXHMNnm9LmJSrtuizHcdnHu9J2IDS+a+czfss8TpWASOudTnxQLVPLDAXZHwtjUAE2U3sbcj5gIhV3Z2XIQ4BZJgnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=w0572cVC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5464IPUv81747443, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746505105; bh=Vv0Oh5mO95XY9jtbk02on+6wGqHHZ0N0bmJcCH59QdI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=w0572cVC5Ah5bmAj/AtF/urSAmoKvz7MobZhwYmkruAaIDB9fuJo5URJUCwdRqd4h
	 tPUcft3zaQl7jJHvmBg/6FkqFkbkRF0razs0VD/LLw182nz2VvwhFm/dG0SeiD+77Q
	 gM6XRt0I+TQm8FnNqAFMAyrx0WA6T/fXOtyQpDeBUblNN6mkYIUaMkfhZtQhW5PIkT
	 R2f/C64SAA98TlrsxatGZGj2MaFWg7OPeDRc6w2fQiSM6kDibMepmgvccLA2Sv0BR/
	 K3tlCy6o5z+PrfQpg+/tKfEYesVeY8MRP5HOm17qR9cgD3WTP2L+Oc5NQ91J+aYNqi
	 HmJGB8VXrx0kg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5464IPUv81747443
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 12:18:25 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 May 2025 12:18:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 May 2025 12:18:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 6 May 2025 12:18:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: rtw89: Null pointer dereference in rtw89_pci_setup_mapping()
Thread-Topic: rtw89: Null pointer dereference in rtw89_pci_setup_mapping()
Thread-Index: AQHbvcyal9ll0yX4oUKP6j5HRL/rSrPE/4Rg
Date: Tue, 6 May 2025 04:18:25 +0000
Message-ID: <2db2ad6de93842b0844456153399177c@realtek.com>
References: <ccaf49b6-ff41-4917-90f1-f53cadaaa0da@gmail.com>
In-Reply-To: <ccaf49b6-ff41-4917-90f1-f53cadaaa0da@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
UGVvcGxlIHRyeWluZyB0byBydW4gT3BlbndydCBpbiBRZW11IHJhbiBpbnRvIHRoaXMgc2l0dWF0
aW9uIHdoZXJlDQo+IHJ0d3BjaS0+bW1hcCBpcyB1c2VkIGJlZm9yZSBpdCdzIGluaXRpYWxpc2Vk
Og0KPiANCj4gcnR3ODlfcGNpX3Byb2JlKCkNCj4gICBydHc4OV9wY2lfc2V0dXBfcmVzb3VyY2Uo
KQ0KPiAgICAgcnR3ODlfcGNpX3NldHVwX21hcHBpbmcoKQ0KPiAgICAgICBydHc4OV9wY2lfY2Zn
X2RhYygpDQo+ICAgICAgICAgcnR3ODlfcGNpX2NvbmZpZ19ieXRlX3NldCgpDQo+ICAgICAgICAg
ICBydHc4OV9wY2lfcmVhZF9jb25maWdfYnl0ZSgpDQo+ICAgICAgICAgICAgIHJ0dzg5X2RiaV9y
ZWFkOCgpDQo+ICAgICAgICAgICAgICAgcnR3ODlfd3JpdGUxNigpDQo+ICAgICAgICAgICAgICAg
ICBydHc4OV9wY2lfb3BzX3dyaXRlMTYoKQ0KPiAgICAgICAgICAgICAgICAgICB3cml0ZXcoZGF0
YSwgcnR3cGNpLT5tbWFwICsgYWRkcik7DQo+IA0KPiBUaGVpciB3aWZpIGNhcmQgaXMgUlRMODg1
MkJFLg0KPiANCj4gSXQgbG9va3MgbGlrZSB0aGUgcHJvYmxlbSB3YXMgaW50cm9kdWNlZCBpbiBr
ZXJuZWwgNi4xMSBieSBjb21taXQNCj4gMWZkNGIzZmU1MmVmICgid2lmaTogcnR3ODk6IHBjaTog
c3VwcG9ydCAzNi1iaXQgUENJIERNQSBhZGRyZXNzIikuDQo+IA0KPiBUaGlzIGlzIG5vdCBteSBi
dWcsIEknbSBqdXN0IGZvcndhcmRpbmcgaXQgZnJvbQ0KPiBodHRwczovL2dpdGh1Yi5jb20vb3Bl
bndydC9vcGVud3J0L2lzc3Vlcy8xNzAyNS4NCg0KVGhhbmtzIGZvciB0aGUgcmVwb3J0LiBJIG1h
ZGUgYW5kIHNlbnQgYSBwYXRjaCBbMV0uDQpJIHdpbGwgYWxzbyBwb3N0IHRoaXMgaW5mb3JtYXRp
b24gb24gdGhlIGdpdGh1YiBpc3N1ZS4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LXdpcmVsZXNzLzIwMjUwNTA2MDE1MzU2Ljc5OTUtMS1wa3NoaWhAcmVhbHRlay5jb20vVC8j
dQ0KDQo=

