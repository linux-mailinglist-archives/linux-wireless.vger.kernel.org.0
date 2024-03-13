Return-Path: <linux-wireless+bounces-4665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E6087A2CB
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 06:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9431C2094C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 05:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCE012E5E;
	Wed, 13 Mar 2024 05:56:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CD412E4E
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 05:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710309369; cv=none; b=IwXfjyboseEuU0qpaRcepq4Q3ufUqyYnQEdUbvwnbTambg7PTh+LLwX6MwHUZA6kiUh1Io04aLJgw8RjcYwcNv6Zc8xTE7Xj4dV+GnCcp1VAemUkBHAyzHqBD1Bo2MIWS4cjpLp13E8gQe+aefnP4Wbrh8S/RGD9MKwGatQhngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710309369; c=relaxed/simple;
	bh=EEQp5smiyc2Tlf/ENvjyjfivxM2iySAXNRkwgt+E9FA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P5Awgj17DYAigwb3DAi8LZ+xrxiGd5NCfMQYaxfUfFqUfpaOFT70c1/3YZrxe514hxAxAMEt6uKXriB8k6ydid50ls+NUiS4ZObVOkmPVvwozlk7CjQ/JuyOZt3b3q9GuXr89JoIOf3ST+HBn4nM0cTkKn+ig3NJmL7w8UcGeZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42D5tjt27537300, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42D5tjt27537300
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 13:55:46 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 13:55:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 13:55:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Wed, 13 Mar 2024 13:55:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "s.l-h@gmx.de" <s.l-h@gmx.de>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
Thread-Topic: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
Thread-Index: AQHadMtD5PbM3LC0pEyBntnmuPy2drE0pKyAgAABjIA=
Date: Wed, 13 Mar 2024 05:55:45 +0000
Message-ID: <4c4aa8160119935e48f9da679b502f80da4c0fc7.camel@realtek.com>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
	 <20240313064917.527110c4@mir>
In-Reply-To: <20240313064917.527110c4@mir>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEB67A7D63FFD243955C908DD1B6CC59@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gV2VkLCAyMDI0LTAzLTEzIGF0IDA2OjQ5ICswMTAwLCBTdGVmYW4gTGlwcGVycy1Ib2xsbWFu
biB3cm90ZToNCj4gDQo+IE9uIDIwMjQtMDMtMTMsIEJpdHRlcmJsdWUgU21pdGggd3JvdGU6DQo+
ID4gQ3JlYXRlIHRoZSBuZXcgbW9kdWxlIHJ0bDgxOTJkLWNvbW1vbiBhbmQgbW92ZSBzb21lIGNv
ZGUgaW50byBpdCBmcm9tDQo+ID4gcnRsODE5MmRlLiBOb3cgdGhlIHJ0bDgxOTJkZSBkcml2ZXIg
KFBDSSkgYW5kIHRoZSBuZXcgcnRsODE5MmR1IGRyaXZlcg0KPiA+IChVU0IpIGNhbiBzaGFyZSBz
b21lIG9mIHRoZSBjb2RlLg0KPiBbLi4uXQ0KPiA+IFRlc3RlZCBvbmx5IHdpdGggUlRMODE5MkRV
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJm
ZTJAZ21haWwuY29tPg0KPiANCj4gVGVzdGVkLWJ5OiBTdGVmYW4gTGlwcGVycy1Ib2xsbWFubiA8
cy5sLWhAZ214LmRlPg0KDQpUaGFua3MgZm9yIHRoZSByZXBvcnQuIENvdWxkIEkga25vdyB0aGUg
dGhyb3VnaHB1dCBwZXJmb3JtYW5jZSBpbiB5b3VyIHNpZGU/DQpKdXN0IGZvciBhIHJlY29yZC4g
DQoNCj4gDQo+IFVzaW5nIHRoZSBmaXJtd2FyZSBmcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9sd2Zp
bmdlci9ydGw4MTkyZHUvLA0KPiBpdCB3b3VsZCBiZSBncmVhdCBpZiBzb21lb25lIGNvdWxkIHB1
Ymxpc2ggdGhlIG5lY2Vzc2FyeSBmaXJtd2FyZQ0KPiB0byBsaW51eC1maXJtd2FyZS4NCg0KSSBj
YW4gZG8gdGhhdCBhZnRlciB0aGlzIHBhdGNoc2V0IGdldCBtZXJnZWQuIA0KDQpQaW5nLUtlIA0K
DQo=

