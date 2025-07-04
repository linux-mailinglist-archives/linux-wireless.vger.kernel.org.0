Return-Path: <linux-wireless+bounces-24809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5FFAF8733
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 07:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9626F1C80A69
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 05:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2671FBE8C;
	Fri,  4 Jul 2025 05:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="lw/M1NUS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628E51FAC4B
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 05:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751606871; cv=none; b=Uo4ZerH2+XRVD5N/o87sfrOQUzmCE4G47MH5ksqy0BIxEgUak9UgYEg9oM25xPC1uzP+pGHNmSHhodoN66MVi6aPXnZsgK7WfTNJ+BYCOpnumsT/whiZ29L3cdCxSHBLQDlxps4FgVgnlnm+hPs7kpbSYtBPCpv5E80qC+Auv0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751606871; c=relaxed/simple;
	bh=CWwMSY3mxhI2/iBEJXsv9tebvD4n5JyvpigLDnDtWWk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I7Z1mcvtL8GeLRHi4WJzUM69aoTZexotTYwIpSui4EEx59efbznhXT6Tfk+Ym3Fxb8V2saZrYa8KlfpgREkXuAKf09FFr3iuko1A4VDI8qKK0RR1wkebngHcek86/C4DFe3JzcvTD0ogUoBBddcD0GXxLw25TFEOM48aMzCFGwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=lw/M1NUS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5645RbpW63795572, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751606858; bh=CWwMSY3mxhI2/iBEJXsv9tebvD4n5JyvpigLDnDtWWk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=lw/M1NUSMrBHhXDI9Za9DS3IV2mJzlxVJOVD60Iub/9N/J57H9TXVg4/pnh/wcPwU
	 6v8sOtyFS//LILHfcYOIruhsDSUI1hVY8PX1F/9i4SRmGFR1mkwXyvh44LAmz9bjAs
	 bUilNEdm64j50TL1FUJevkoGVlRp2vg+9HDDC3kUREOY8CayMmE7Thysm7DPr9b7d/
	 eK5yD6NeSn3pYWYJbBhDzKWmyUNeXu827wKwd/PF45rRN93J1qjSlNE6DqCxUBy8Y9
	 HkB+RjTN5AT4Db/4lmHzK1iL04JLpM6LNbVpJx7Uhg3bmLsxDNX13qwAaIA8mC+FJf
	 3xN7fAjlc4dyA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5645RbpW63795572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Jul 2025 13:27:37 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Jul 2025 13:28:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 4 Jul 2025 13:28:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 4 Jul 2025 13:28:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 1/6] wifi: rtw89: 8852bx: Accept USB devices and load their MAC address
Thread-Topic: [PATCH rtw-next 1/6] wifi: rtw89: 8852bx: Accept USB devices and
 load their MAC address
Thread-Index: AQHb6qGNt6yapqm0+Ee5CTXAW43W07Qhc3aw
Date: Fri, 4 Jul 2025 05:28:01 +0000
Message-ID: <8742dd35b5364b648a840cffcac4fb01@realtek.com>
References: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
 <b4ab007f-078e-4e06-965e-d6e4dd43124f@gmail.com>
In-Reply-To: <b4ab007f-078e-4e06-965e-d6e4dd43124f@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTZW50
OiBXZWRuZXNkYXksIEp1bHkgMiwgMjAyNSAxMjowMiBBTQ0KPiBNYWtlIF9fcnR3ODg1MmJ4X3Jl
YWRfZWZ1c2UoKSBhY2NlcHQgVVNCIGRldmljZXMgYW5kIGxvYWQgdGhlIE1BQw0KPiBhZGRyZXNz
IGZyb20gdGhlIGNvcnJlY3Qgb2Zmc2V0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1
ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNo
aWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

