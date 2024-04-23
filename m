Return-Path: <linux-wireless+bounces-6695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074EA8ADB47
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 02:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F401F225EB
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 00:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0AEDDB8;
	Tue, 23 Apr 2024 00:48:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AD7D26A
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713833322; cv=none; b=D9JziUTdMb6W3ncvpP+z9DdsA0jPYmar7l6DPD7dvqGBoQXRSR5tYlbS02cOONEdaeyuaU17Ifmc2WukIbJdL9aLeOvcakZpL4tHMTyDlKLd/co1Erw6iLJ/KGo0PmwCu7AQpwOMzY/XEPd3C0QjKYfEUfR9ZPamN6X18WDXn+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713833322; c=relaxed/simple;
	bh=Nbiz3m+8hb/vfRnTUO4TemL/hw2pO3JlkxM+ogxm5jo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r8FKHZ0ojdn93eiInm3kjMTz+84jzQ0cUsDskY74EF+9YlKZ8lXHMP+lJUnaULjeknSkmEzMzHfrsmuA8vhbGozCQw+vJ09lgMLzORgldJ+WvzDXl8xe3+p1FkxunI7oKLM5Gwo+U82t1l54tqy6q+PJDNnx9xCrYBECOk6X/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43N0m4j55623062, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43N0m4j55623062
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 08:48:04 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 08:48:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 08:48:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 23 Apr 2024 08:48:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v6 4/6] wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
Thread-Topic: [PATCH v6 4/6] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
Thread-Index: AQHakl7Lfjbq0AGUE0Omzg/aC716wbFzmqEggABuioCAAP+dwA==
Date: Tue, 23 Apr 2024 00:48:04 +0000
Message-ID: <054791df5141422fb0f8220eaeb66ff3@realtek.com>
References: <9d54a192-d389-4a56-9286-2e7721cbbc27@gmail.com>
 <459a193c-ce2e-4b89-827c-ff6721c470e0@gmail.com>
 <4e7bb78f7dad4383bc98f4a94a2c9b48@realtek.com>
 <509ded5b-6b31-4750-9f87-4d080ea4f71a@gmail.com>
In-Reply-To: <509ded5b-6b31-4750-9f87-4d080ea4f71a@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAy
Mi8wNC8yMDI0IDA1OjU1LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiArKysgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5MmQvbWFpbi5jDQo+ID4+IEBAIC0wLDAg
KzEsOSBAQA0KPiA+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPj4g
Ky8qIENvcHlyaWdodChjKSAyMDA5LTIwMTIgIFJlYWx0ZWsgQ29ycG9yYXRpb24uKi8NCj4gPj4g
Kw0KPiA+PiArI2luY2x1ZGUgIi4uL3dpZmkuaCINCj4gPj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1
bGUuaD4NCj4gPj4gKw0KPiA+PiArTU9EVUxFX0FVVEhPUigiUmVhbHRlayBXbGFuRkFFIDx3bGFu
ZmFlQHJlYWx0ZWsuY29tPiIpOw0KPiA+PiArTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KPiA+PiAr
TU9EVUxFX0RFU0NSSVBUSU9OKCJSZWFsdGVrIDgxOTJEIDgwMi4xMWFuIGNvbW1vbiByb3V0aW5l
cyIpOw0KPiA+DQo+ID4gTm90IHN1cmUgd2h5IHlvdSBlbXBoYXNpemUgJzgwMi4xMWFuJyBpbnN0
ZWFkIG9mIGp1c3QgJzgwMi4xMW4nLg0KPiA+DQo+ID4NCj4gDQo+IEkgc2F3IHNvbWV3aGVyZSBh
IGR1YWwtYmFuZCBjaGlwIGRlc2NyaWJlZCBhcyA4MDIuMTFhbi4NCj4gSXQgc2VlbWVkIGxpa2Ug
YSBnb29kIGlkZWEuIFNob3VsZCBJIGNoYW5nZSBpdD8NCg0KDQpJJ20gbm90IHN1cmUgd2hhdCAn
ODAyLjExYW4nIGRlZmluZXMsIGJ1dCB0aGlzIG9sZCBjaGlwIHNob3VsZCBub3Qgc3VwcG9ydCB0
aGF0Lg0KVGhlbiwgbWF5YmUgJzgwMi4xMWFuJyBoZXJlIG1lYW5zICc4MDIuMTFhLzgwMi4xMW4n
LCBidXQgSSBzdGlsbCBkb24ndCBrbm93IHRoZQ0KcmVsYXRpb24gd2l0aCBkdWFsLWJhbmQgY2hp
cC4NCg0KRllJOg0KODAyLjExYTogNUdIeiBiYW5kLCBDQ0svT0ZETQ0KODAyLjExYjogMkdIeiBi
YW5kLCBDQ0sNCjgwMi4xMWc6IDJHSHogYmFuZCwgQ0NLL09GRE0NCjgwMi4xMW46IDIvNUdIeiBi
YW5kcywgSFQNCg0KDQo=

