Return-Path: <linux-wireless+bounces-4718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEF187B5CD
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 01:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65F21C20C1E
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 00:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E127FD;
	Thu, 14 Mar 2024 00:28:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62117F
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 00:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710376119; cv=none; b=nAp968MiK5L+gTVbESkMYJsoqp2v4Qjb8BW7nzyShyXACySwbWJDQtSQXvd+qeRQjkP9VYNUogNf4xQVQ8CLYzPM7H/KErqzOSY1apxAxTMlBxB/QMVmeXrRogvktOyIYtE5bJV2o005LUQxC5E742Flw8jtU1Ycf22l5wJoEgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710376119; c=relaxed/simple;
	bh=oqeh4afUnx1l7yOM0mwpjkYbossG4cHJ52LODMr28T4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RfSG/35LjmW/aVSzT4yMibz9xDFEbEoUxbjXeOsNv8x4qNskG/t5W2bOOKw1ZT5MnSis0Q453ZHycnmsNz/IT8CHcA0RoKyNYP5FyByWWTSgMv9X63T01FU7qh7XXXuNo1pamnjrGJ7fyYxd5wOKI+S6tQ+FCwrCVJ6Gvzd37Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42E0SJdY41048873, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42E0SJdY41048873
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 08:28:19 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 08:28:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 08:28:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Thu, 14 Mar 2024 08:28:19 +0800
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
Thread-Index: AQHadMtD5PbM3LC0pEyBntnmuPy2drE0pKyAgAABjICAARlfgIAAHXeA
Date: Thu, 14 Mar 2024 00:28:19 +0000
Message-ID: <574c2693d2f3e02c0007d6275c161fabf784cf5e.camel@realtek.com>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
	 <20240313064917.527110c4@mir>
	 <4c4aa8160119935e48f9da679b502f80da4c0fc7.camel@realtek.com>
	 <5fa1ee44-fd9f-47ef-abb3-7d578dc7af0b@gmail.com>
In-Reply-To: <5fa1ee44-fd9f-47ef-abb3-7d578dc7af0b@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <D24EC19D61046747B51A91CB605505DE@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gVGh1LCAyMDI0LTAzLTE0IGF0IDAwOjQxICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gU2hvdWxkIEkgc2VuZCB5b3UgdGhlIGZpcm13YXJlIGxpa2UgdXN1YWw/DQoNCklm
IHlvdSBjYW4gaGVscCBtYWtpbmcgYSBwYXRjaCB0byBtZSBwcml2YXRlbHksIHRoYXQgd291bGQg
YmUgdmVyeSBoZWxwZnVsLiANCg0KDQo=

