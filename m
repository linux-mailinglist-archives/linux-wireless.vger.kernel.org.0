Return-Path: <linux-wireless+bounces-2070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1BE82FDEE
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 01:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970131F2551E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 00:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB0D79CC;
	Wed, 17 Jan 2024 00:16:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAE24685
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705450572; cv=none; b=k252G41CZrN6cEtR2dfS8DkWqbiTSm8myv1NVPo2SCcFs+VfAlgXgkmg6LOSE57mkS+29FJAeeyifHPuzlGKPRz1FG74Xv974saoFHsfZcOM+q9/HXJcS3uLqKRKgt6cIN9lXT+gjY4UY/IVogL2SyDeiKc4Hes6GkpJQD+BuyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705450572; c=relaxed/simple;
	bh=p/ufZXB1PLpJ6WKj7JxSISC5VFNgGut3qeq8TnjV8+Q=;
	h=X-SpamFilter-By:Received:Received:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:x-originating-ip:
	 x-kse-serverinfo:x-kse-antispam-interceptor-info:
	 x-kse-antivirus-interceptor-info:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-KSE-AntiSpam-Interceptor-Info:X-KSE-ServerInfo:
	 X-KSE-AntiSpam-Interceptor-Info:X-KSE-Antivirus-Interceptor-Info:
	 X-KSE-AntiSpam-Interceptor-Info; b=bL757iTcIMGw0iVrG6PnXl95r3zrkF/AT5XLN8VDQ21/VzQJYwAAuYioeYCmScZd+weUuQuLU6hoO2ULr1+8m2Yw6ci4lHpWPqRXQbOI1RRc/xbh+Qv8Id4boPYXrVOsNP1aMZTBxv8wBWNhJnZ549l5rFUCX8krJVU70oGZ0XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40H0Fu8iA521070, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40H0Fu8iA521070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 08:15:56 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 17 Jan 2024 08:15:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 17 Jan 2024 08:15:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Wed, 17 Jan 2024 08:15:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH] wifi: rtlwifi: rtl8192de: Fix byte order of chip version
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8192de: Fix byte order of chip version
Thread-Index: AQHaRam9Hy6mYhlr3USS49QlLcoixLDaXnbA///zCQCAAU4poIAActiAgAEWmvA=
Date: Wed, 17 Jan 2024 00:15:55 +0000
Message-ID: <de54fcd016e04aaa942566fd6488a48c@realtek.com>
References: <81b6c452-e940-423a-acf7-4a7b7c5e7847@gmail.com>
 <c369eeb8b3014f068d1c60b42b44e206@realtek.com>
 <d4fa544d-46fc-4795-8da1-5dd6199bdea9@gmail.com>
 <508550165dc24c3d932565d1adaf3766@realtek.com>
 <78d5f49b-1c97-4a7a-b366-ddcb6c102f6b@gmail.com>
In-Reply-To: <78d5f49b-1c97-4a7a-b366-ddcb6c102f6b@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMTYs
IDIwMjQgMTE6MzggUE0NCj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsg
bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBMYXJyeSBGaW5nZXIgPExhcnJ5
LkZpbmdlckBsd2Zpbmdlci5uZXQ+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHdpZmk6IHJ0bHdp
Zmk6IHJ0bDgxOTJkZTogRml4IGJ5dGUgb3JkZXIgb2YgY2hpcCB2ZXJzaW9uDQo+IA0KPiBJdCB3
b3JrcyBmaW5lLiBJIGp1c3Qgc2F3IHRoZSBtZXNzYWdlICJVbmtvd24gQ1VUISIgYW5kIGdvdCBj
dXJpb3VzOg0KPiBodHRwczovL2dpdGh1Yi5jb20vbHdmaW5nZXIvcnRsODE5MmR1L2lzc3Vlcy85
MiNpc3N1ZWNvbW1lbnQtMTE1NTQyMDI5MQ0KPiANCj4gSWYgdGhlIGFkZHJlc3NlcyBpbiB0aGUg
ZWZ1c2UgYXJlIGNvcnJlY3QsIHRoZW4gbXkgZGV2aWNlIGRvZXNuJ3QgbmVlZA0KPiBhbnkgcGF0
Y2guIFVua25vd24gY3V0IGlzIHRyZWF0ZWQgdGhlIHNhbWUgYXMgRCBjdXQsIHdoaWNoIGlzIHRy
ZWF0ZWQNCj4gdGhlIHNhbWUgYXMgRSBjdXQuDQo+IA0KDQpMZXQncyBrZWVwIGl0IGFzIGl0IHdh
cy4gDQoNCg0K

