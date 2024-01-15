Return-Path: <linux-wireless+bounces-1897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B094B82D306
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 02:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A362812D6
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 01:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9580323A7;
	Mon, 15 Jan 2024 01:55:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AEA23A2
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40F1tA1X13470006, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40F1tA1X13470006
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 09:55:10 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 15 Jan 2024 09:55:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 15 Jan 2024 09:55:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Mon, 15 Jan 2024 09:55:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH] wifi: rtlwifi: rtl8192de: Fix byte order of chip version
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8192de: Fix byte order of chip version
Thread-Index: AQHaRam9Hy6mYhlr3USS49QlLcoixLDaH/7A
Date: Mon, 15 Jan 2024 01:55:09 +0000
Message-ID: <a30c3c771436456e8364504cec082fff@realtek.com>
References: <81b6c452-e940-423a-acf7-4a7b7c5e7847@gmail.com>
In-Reply-To: <81b6c452-e940-423a-acf7-4a7b7c5e7847@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKYW51YXJ5IDEz
LCAyMDI0IDY6NTAgQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+OyBMYXJyeSBGaW5nZXIgPExhcnJ5
LkZpbmdlckBsd2Zpbmdlci5uZXQ+DQo+IFN1YmplY3Q6IFtQQVRDSF0gd2lmaTogcnRsd2lmaTog
cnRsODE5MmRlOiBGaXggYnl0ZSBvcmRlciBvZiBjaGlwIHZlcnNpb24NCj4gDQo+IFRoZSBjaGlw
IHZlcnNpb24gc3RvcmVkIGluIHRoZSBlZnVzZSBpcyBjdXJyZW50bHkgYXNzdW1lZCB0byBiZSBp
bg0KPiBiaWcgZW5kaWFuIG9yZGVyOg0KPiANCj4gI2RlZmluZSBFRVBST01FX0NISVBfVkVSU0lP
Tl9MICAgICAgICAgICAgICAgICAgMHgzRkYNCj4gI2RlZmluZSBFRVBST01FX0NISVBfVkVSU0lP
Tl9IICAgICAgICAgICAgICAgICAgMHgzRkUNCj4gDQo+IEJ1dCBvdGhlciAyLWJ5dGUgdGhpbmdz
IGluIHRoZSBlZnVzZSBhcmUgc3RvcmVkIGluIGxpdHRsZSBlbmRpYW4gb3JkZXIuDQo+IEZvciBl
eGFtcGxlLCB0aGUgRUVQUk9NIElELCB0aGUgdmVuZG9yIElELCB0aGUgcHJvZHVjdCBJRC4NCj4g
DQo+IFRoZSBvdXQtb2Yta2VybmVsIGRyaXZlciBmb3IgdGhlIFVTQiB2ZXJzaW9uIG9mIHRoZSBj
aGlwIHVzZXMgdGhlIHNhbWUNCj4gbWFjcm9zIGFuZCB2ZXJzaW9uIGRldGVjdGlvbiBjb2RlIGFz
IHRoaXMgZHJpdmVyLiBUaGV5IHJlY29nbmlzZQ0KPiAweGFhNTUsIDB4OTk2NiwgYW5kIDB4Y2Mz
MyBhcyBjb3JyZWN0IHZlcnNpb25zLiBXaXRoIHRoZSBvcmlnaW5hbA0KPiBtYWNyb3MsIG15IGRl
dmljZSdzIHZlcnNpb24gaXMgdGhlIHVucmVjb2duaXNlZCB2YWx1ZSBvZiAweDMzY2MuIFRoaXMN
Cj4gc2VlbXMgbGlrZSBhIG1pc3Rha2UuDQoNCkkgd2lsbCBjaGVjayB0aGlzIGludGVybmFsbHku
IFBsZWFzZSB3YWl0IGEgd2hpbGUuIA0KDQo=

