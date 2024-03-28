Return-Path: <linux-wireless+bounces-5418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC7E88F4E2
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 02:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEAF292E5A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 01:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0358E1804A;
	Thu, 28 Mar 2024 01:49:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E063C8F6B
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711590598; cv=none; b=N+/rWzgSIn/qnx/Du2aqpi9bKFe5xC1bnnvRN5FUNLEB8mFxrOcl7wnq3vSfcaBaJNCm5yX8LWr9gkJeXXLxtz93kXkLCeh1MfGIcCxCGOt/q7WwV0GkwErCfKgPzel/wKeyRIc1hirzaomprTBqEB20qTfO25k0ZMsy6MtgC2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711590598; c=relaxed/simple;
	bh=4gyEy2b+G/ZyZMIwU5aJ3FHMYKXFS3cx+XmxnmKxc+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K+mwf7jaVxqwZ4Tvlloll4KSWBK14xciBOd/irTf3gDphVKS6zk6nVYqraSzkpyJNdu0/LQ2Airn5qpuEGYgwWgx1pze9i+4Z+yE1/4xlopCc/5Dr+Al3g6pP63F387B7xjXmRJdtFPg/LjS4uxztjJz2T9fio2rUi0sZK6klwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42S1nW5U11705731, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42S1nW5U11705731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:49:32 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 09:49:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 09:49:31 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Thu, 28 Mar 2024 09:49:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
Thread-Topic: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
Thread-Index: AQHaev7lVhGGoQ4nQ0GxbEPAiHfc3rFCwUMAgAhizQCAAMPfgA==
Date: Thu, 28 Mar 2024 01:49:31 +0000
Message-ID: <d9575c867c3641f343e53805eb4c8e0b89459353.camel@realtek.com>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
	 <2eb79c8c-cf2c-4696-b958-e8d961628e17@gmail.com>
	 <f86a40493745a53ff73083f87b3e8fae215eac77.camel@realtek.com>
	 <66565618-3638-47e5-afe5-3530214da0c9@gmail.com>
In-Reply-To: <66565618-3638-47e5-afe5-3530214da0c9@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2CAD51AB91E294CA0C7D46616888E7A@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gV2VkLCAyMDI0LTAzLTI3IGF0IDE2OjA3ICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gSSBjb3VsZG4ndCB0aGluayBvZiBhIHN1ZmZpY2llbnRseSBzaG9ydCBuYW1lLCBs
aWtlDQo+ICJsb2NrX21hYzBfMmdfbWFjMV81ZyIsIHNvIEkgdXNlZCBtdXRleF9pc19sb2NrZWQo
KS4gVGhhdCdzIHByb2JhYmx5DQo+IGEgYmFkIGlkZWEuIEl0IHNob3VsZCBiZSBsaWtlIHRoaXM6
DQo+IA0KPiAgICAgICAgIC8qIExldCB0aGUgZmlyc3Qgc3RhcnRpbmcgbWFjIGxvYWQgUkYgcGFy
YW1ldGVycyBhbmQgZG8gTENLICovDQo+ICAgICAgICAgaWYgKHJ0bGhhbC0+bWFjcGh5bW9kZSA9
PSBEVUFMTUFDX0RVQUxQSFkgJiYNCj4gICAgICAgICAgICAgKChydGxoYWwtPmludGVyZmFjZWlu
ZGV4ID09IDAgJiYgcnRsaGFsLT5iYW5kc2V0ID09IEJBTkRfT05fMl80RykgfHwNCj4gICAgICAg
ICAgICAgIChydGxoYWwtPmludGVyZmFjZWluZGV4ID09IDEgJiYgcnRsaGFsLT5iYW5kc2V0ID09
IEJBTkRfT05fNUcpKSkgew0KDQpBZnRlciB0cmFjaW5nIHRoZSBjb2RlLCBJIGZlZWwgaGVyZSBj
YW4gb25seSBjaGVjayBydGxoYWwtPm1hY3BoeW1vZGUuIA0KDQoNCj4gICAgICAgICAgICAgICAg
IG11dGV4X2xvY2soJmdsb2JhbG11dGV4X2Zvcl9tYWMwXzJnX21hYzFfNWcpOw0KPiAgICAgICAg
ICAgICAgICAgbG9ja19tYWMwXzJnX21hYzFfNWcgPSB0cnVlOw0KPiAgICAgICAgIH0NCj4gDQo+
ICAgICAgICAgLi4uLg0KPiANCj4gICAgICAgICBpZiAobG9ja19tYWMwXzJnX21hYzFfNWcpDQo+
ICAgICAgICAgICAgICAgICBtdXRleF91bmxvY2soJmdsb2JhbG11dGV4X2Zvcl9tYWMwXzJnX21h
YzFfNWcpOw0KPiANCg==

