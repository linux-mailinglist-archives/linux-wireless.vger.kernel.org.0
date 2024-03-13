Return-Path: <linux-wireless+bounces-4668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6D587A2F5
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 07:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9981C212FE
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 06:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FD8134C6;
	Wed, 13 Mar 2024 06:25:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C57134B7
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 06:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710311138; cv=none; b=IHL6kJGp8oHlFcPFUtnzWz7tH+r12NJfnMjOS0o5xAHOWdG4Ndm0lHm07eElkD0NPR+TQDy3cd8S3V94h6n/GFZL2Yw9JUO8QD41IbV/esmBLvCJzrobPcBVeq7O7ZlU/hQrMhGwJUcHrQF11uuZrzjrg7npCs7iM7ZRlU7ltrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710311138; c=relaxed/simple;
	bh=ySqM6YqPzO2N2wgiHRyxllwleOTwAZX6yD/Sjz/xTcc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uZ6tobDwTl1Yh3McffxeIFXyR0a4UNu6e2Vthl5zxmeEbK8/DrwPjq3zcKhg5dL/9jh2iBAhb2pmEAsm8pTKb0VQ2lcy/AH5XoKDo4+p5/ZKZSF+kGeFMTMJCc7Xl4V8XCaclS+M/bappcniWNENh7dtxwgIPa/BvDXEroIdosU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42D6PE6E0566709, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42D6PE6E0566709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 14:25:15 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 14:25:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 14:25:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Wed, 13 Mar 2024 14:25:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "s.l-h@gmx.de" <s.l-h@gmx.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "chewitt@libreelec.tv"
	<chewitt@libreelec.tv>
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
Thread-Topic: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
Thread-Index: AQHadMtD5PbM3LC0pEyBntnmuPy2drE0pKyAgAABjICAAAa2AIAAAYQA
Date: Wed, 13 Mar 2024 06:25:14 +0000
Message-ID: <cdee2e123ce2845f757ba74751f4871999fd5c5a.camel@realtek.com>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
	 <20240313064917.527110c4@mir>
	 <4c4aa8160119935e48f9da679b502f80da4c0fc7.camel@realtek.com>
	 <20240313071850.61a42e4f@mir>
In-Reply-To: <20240313071850.61a42e4f@mir>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FD0B7CD86F62143BE86F928BF98EE32@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI0LTAzLTEzIGF0IDA3OjE4ICswMTAwLCBTdGVmYW4gTGlwcGVycy1Ib2xsbWFu
biB3cm90ZToNCj4gDQo+IFRoZSBwZXJmb3JtYW5jZSBpcyBva2F5IC0gdGhlIGRyaXZlciBoYXMg
YmVlbiB3b3JraW5nIHJlbGlhYmx5IGFsbCBkYXkNCj4gbG9uZyAoV1BBMlNBRSBhbmQgV1BBMlBT
Sy8gQ0NNUCwgMi40IEdIeiBhbmQgNSBHSHosIGFnYWluc3QgYW4NCj4gaXBxODA3MWErcWNuNTAy
NCtxY241MDU0IEFQIHJ1bm5pbmcgcmVjZW50IE9wZW5XcnQpLg0KPiANCg0KVGhhbmtzLiBCb3Ro
IFBIWSByYXRlIGFuZCB0aHJvdWdocHV0IGxvb2sgZ29vZC4gDQoNCkJpdHRlcmJsdWUsIENhbiB5
b3UgbWFrZSBhIHJlY29yZCBpbiBjb21taXQgbWVzc2FnZSBvZiB0aGUgbGFzdCBjb21taXQNCnRo
YXQgZW5hYmxlcyA4MTkyRFU/DQoNClBpbmctS2UNCg0K

