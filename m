Return-Path: <linux-wireless+bounces-3841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EE185D265
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 09:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2471C22F38
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 08:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4983B199;
	Wed, 21 Feb 2024 08:19:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464093B794
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708503582; cv=none; b=nPBKRxmkK6vfvmda+bLWXczOuIXR0GrwX7V+iDH/MX5/sPIuD2+23ZopYYdlqhKB9wSfdsbCKwXMCGeegPCFvOarDeIiqTWYgxsG6pXc8YjyjoWaYIL9ghAKh7FDHhQTH1xai8LE4ugwgch6pcJ3tkT3SXbSlxlwe83e92iDOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708503582; c=relaxed/simple;
	bh=3QNxUN+gdjc6i9qc7K/VxuuvKxATIOpcnulRK/0tI2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uj/EZRiaDIRxIvgxPuIEl5Rfs7E4IVhHVW3ju6bZ3K4Bf1qSATWNYNbgorwEqnyvRO8xrkyP6DFQtQEvL/ARYUrJU5E4pIxGPdKscH0bRWzq3cPbuBVdeopzGAVATuMSUS0wqDUM3Eq1MmbjwLjlPEi7UVHFasZHZQ5OB8vzvcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41L8JC8A0909455, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41L8JC8A0909455
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 16:19:14 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Wed, 21 Feb 2024 16:19:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 16:19:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Wed, 21 Feb 2024 16:19:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>, "Jouni
 Malinen" <j@w1.fi>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Arend van Spriel
	<arend.vanspriel@broadcom.com>,
        Felix Fietkau <nbd@openwrt.org>
Subject: RE: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch on link basis
Thread-Topic: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch
 on link basis
Thread-Index: AQHaU4YW43ZUC/cFnUyW8JfF3/48hLD//cCAgAAEzoCABc0KgIAACpsAgAB9JYCAAPMbgIAAOXcAgAAazYCAAAqOAIAAHYkAgAACHICADMP6oP//gIoAgACISOA=
Date: Wed, 21 Feb 2024 08:19:12 +0000
Message-ID: <00094ae0ca73461c88799c070ad9b55a@realtek.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
	 <20240130140918.1172387-5-quic_adisi@quicinc.com>
	 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
	 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
	 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
	 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
	 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
	 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
	 <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
	 <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
	 <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
	 <18c0d4de-392a-420c-8a05-466a83cd2eb8@quicinc.com>
	 <3c550ae335a9762a9cbd0c8109b6dd99faeb8f6f.camel@sipsolutions.net>
	 <5a89e63fb7644d12be72154c90c96199@realtek.com>
 <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
In-Reply-To: <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIEJlcmcgPGpv
aGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMjEs
IDIwMjQgNDoxMCBQTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+OyBB
ZGl0eWEgS3VtYXIgU2luZ2ggPHF1aWNfYWRpc2lAcXVpY2luYy5jb20+DQo+IENjOiBsaW51eC13
aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IEplZmYgSm9obnNvbiA8cXVpY19qam9obnNvbkBxdWlj
aW5jLmNvbT47IElsYW4gUGVlcg0KPiA8aWxhbi5wZWVyQGludGVsLmNvbT47IEpvdW5pIE1hbGlu
ZW4gPGpAdzEuZmk+OyBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+OyBBcmVuZCB2
YW4gU3ByaWVsDQo+IDxhcmVuZC52YW5zcHJpZWxAYnJvYWRjb20uY29tPjsgRmVsaXggRmlldGth
dSA8bmJkQG9wZW53cnQub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDQvNV0gd2lmaTog
bWFjODAyMTE6IHN0YXJ0IGFuZCBmaW5hbGl6ZSBjaGFubmVsIHN3aXRjaCBvbiBsaW5rIGJhc2lz
DQo+IA0KPiBJIGd1ZXNzIHRoYXQnZCBhbHNvIGFwcGx5IHRvIHByb2JlIHJlc3BvbnNlcz8gT3Ig
ZG9lcyBpdCBub3Qgc2VuZCB0aG9zZQ0KPiBhdCBhbGw/IEJ1dCB3ZSBkaXNjdXNzZWQgYmVmb3Jl
IHRoYXQgbWF5YmUgd2UgZG9uJ3QgaGF2ZSB0byBiZSBwZXJmZWN0DQo+IHRoZXJlLCBzbyBJIGd1
ZXNzIHdlIGNhbiBmaW5kIHNvbWUgc29sdXRpb24gdG8gdGhhdC4NCg0KVW5mb3J0dW5hdGVseSwg
UmVhbHRlayBmaXJtd2FyZSBkb2Vzbid0IHNlbmQgcHJvYmUgcmVzcG9uc2VzIGF0IGFsbC4gU3Rp
bGwNCm5lZWQgaG9zdGFwZCB0byByZXBseSB0aG9zZS4gDQoNClBpbmctS2UgDQoNCg==

