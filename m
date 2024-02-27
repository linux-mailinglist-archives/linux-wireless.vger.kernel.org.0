Return-Path: <linux-wireless+bounces-4041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8279B868770
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 03:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4242827EB
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 02:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A7D16426;
	Tue, 27 Feb 2024 02:57:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784172C688;
	Tue, 27 Feb 2024 02:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709002628; cv=none; b=mGIWuJ5f8AhibMz9vivZDScWbDY9SdXUUllnqV+smyhdsAEGCKD9jb0yZXut6fqc3Q0qFpHbs1I1ZwxdMSDjjsJ8IHLpEvaTzOTTVuFphRplSwPFcHySCnw+FGYemj/OxkbaR6Tqorv9j8/H88Hmuxksiq7Kb02hdbJs57XGE6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709002628; c=relaxed/simple;
	bh=RcPf2RS0b7LKd2TxSSvtUQDmU5vcnosac9HCQTKab80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K7Y3uoYR2aZevSVgMKObQsayOQ+tzUZJc06E4YBLde6T6tfh/h21TBLUiUbe5W4eE2tyl5xVEwP4IyKT+/j2BUacRLG1oAcsvrKvgiP9cQw1JMnooUBYcIQg4My4glLC1t01VkM7CKEZBJKo6Hkvgu9yEbKu9gLIoThzxdDpRLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41R2uixuF4128820, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41R2uixuF4128820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 10:56:44 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Tue, 27 Feb 2024 10:56:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 10:56:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Tue, 27 Feb 2024 10:56:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Larry Finger <Larry.Finger@gmail.com>, Kalle Valo <kvalo@kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Nick
 Morrow" <morrownr@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCHi V2] wifi: rtw88: Add missing VID/PIDs doe 8811CU and 8821CU
Thread-Topic: [PATCHi V2] wifi: rtw88: Add missing VID/PIDs doe 8811CU and
 8821CU
Thread-Index: AQHaaSWLtNodzrvQT02Wluts2911HLEdfimg
Date: Tue, 27 Feb 2024 02:56:43 +0000
Message-ID: <aab5bb779e1f470daeb0a4258e4bb764@realtek.com>
References: <4ume7mjw63u7.XlMUvUuacW2ErhOCdqlLkw2@1EHFQ.trk.elasticemail.com>
In-Reply-To: <4ume7mjw63u7.XlMUvUuacW2ErhOCdqlLkw2@1EHFQ.trk.elasticemail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgTGFycnksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFycnkg
RmluZ2VyIDxMYXJyeS5GaW5nZXJAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFy
eSAyNywgMjAyNCAxMDozNSBBTQ0KPiBUbzogS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz4N
Cj4gQ2M6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+OyBsaW51eC13
aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IE5pY2sgTW9ycm93DQo+IDxtb3Jyb3duckBnbWFpbC5j
b20+OyBMYXJyeSBGaW5nZXIgPExhcnJ5LkZpbmdlckBsd2Zpbmdlci5uZXQ+OyBQaW5nLUtlIFNo
aWggPHBrc2hpaEByZWFsdGVrLmNvbT47DQo+IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogW1BBVENIaSBWMl0gd2lmaTogcnR3ODg6IEFkZCBtaXNzaW5nIFZJRC9QSURzIGRvZSA4
ODExQ1UgYW5kIDg4MjFDVQ0KDQpOb3Qgc3VyZSBpZiAiZG9lIiBpcyB0eXBvPw0KDQo+IA0KPiBG
cm9tOiBOaWNrIE1vcnJvdyA8bW9ycm93bnJAZ21haWwuY29tPg0KPiANCj4gUHVycG9zZTogQWRk
IFZJRC9QSURzIHRoYXQgYXJlIGtub3duIHRvIGJlIG1pc3NpbmcgZm9yIHRoaXMgZHJpdmVyLg0K
PiAtIHJlbW92ZWQgIC8qIDg4MTFDVSAqLyBhbmQgLyogODgyMUNVICovIGFzIHRoZXkgYXJlIHJl
ZHVuZGFudA0KPiBzaW5jZSB0aGUgZmlsZSBpcyBzcGVjaWZpYyB0byB0aG9zZSBjaGlwcy4NCj4g
LSByZW1vdmVkIC8qIFRPVE9MSU5LIEE2NTBVQSB2MyAqLyBhcyB0aGUgbWFudWZhY3R1cmVyLiBJ
dCBoYXMgYSBSRUFMVEVLDQo+IFZJRCBzbyBpdCBtYXkgbm90IGJlIHNwZWNpZmljIHRvIHRoaXMg
YWRhcHRlci4NCj4gDQo+IFNvdXJjZSBpcw0KPiBodHRwczovLzFFSEZRLnRyay5lbGFzdGljZW1h
aWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9STgySDBZUl9XX2gxNzVMYjNOa2IwRDhpNklxdnVoRVNl
MFdMblk2UDdJVndSMVVLdkINCj4gMFNQeGQxT2xwM1BOSkVKVHFzdTRreXFCWGF5RTBCVmRfazd1
TEZ2bFRlNjVTeXgydXFMVUItVVFTZnNLS0xrdXlFLWZyTVpYU0NMN3E4MjRVRzNPZXI2MTRHR0Vl
RXotRE5FV0hoDQo+IDQzcF9lOG96N09vdVM2Z1JCRW5nMA0KPiBWZXJpZmllZCBhbmQgdGVzdGVk
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTmljayBNb3Jyb3cgPG1vcnJvd25yQGdtYWlsLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogTGFycnkgRmluZ2VyIDxMYXJyeS5GaW5nZXJAbHdmaW5nZXIubmV0
Pg0KPiBBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IA0KDQpE
aWQgeW91IGtlZXAgYSBibGFuayBsaW5lIGludGVudGlvbmFsbHk/IA0KDQo+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnDQoNCg0K

