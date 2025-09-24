Return-Path: <linux-wireless+bounces-27625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EBDB97EEE
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 02:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728644C17BA
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 00:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E301DE2D7;
	Wed, 24 Sep 2025 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YigAopn5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448251BD035;
	Wed, 24 Sep 2025 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674648; cv=none; b=WmClsPIQe2FJHKjo6elMDOjhUnlhAVou+8iCxQ0JVvS3wZt3WY+ARCa/ZVBh87VfmuWZgevNvTyBJ0WwZo91O9e5TDmYXQGz0TA7vH9F/VgMLWlaxBBvGlQzkiSfEAIsDjWniPdKk7P6xOLjZWepcL/FkENd1TSHy+utNGsRMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674648; c=relaxed/simple;
	bh=5nonDeoHmGqMM1JB2ol7pbAYPtzvHyKsGZ5tODJXujI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Asi7wP8sGj0aP7tqcvGMA7Q1QP2w6fZlYBJrmfWA6qXjB7Z80HbZ3w5ZiAvVdn5Nqzo8EVuSz++s3yNddsWCSWx0XdkP8aXRqYou5Ed0DE6Ni0MP8l0/Mv6k6H4nNiKAWNm+OxBF2dZkokf7j/AuPXObM74VFFPPq6+OklvWPnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YigAopn5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58O0huqL72796800, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758674636; bh=5nonDeoHmGqMM1JB2ol7pbAYPtzvHyKsGZ5tODJXujI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=YigAopn5k3rtJSfq6nxv9VsJ9ojpM9pjTkAsR7gkKYPdo+oPzkX0G/gzhTz1dGw+1
	 QN/i5SgRCeasMoAAP58RoH/kBWk8ilKWCQSqPFjH1Sj+uZPVimX+ot2ScDSvZTXJfA
	 Rw0smmDOEQ6InKxFAqkI6JqeOQq+ccMRSjipQbbwSX/oWHqU1ZQlVP7aWzMt1pZdk1
	 088grUJq3v4LWY29xmFDTGeXWSt4QY8ao2qY6m4jFnckLigQQbplCS+3v6e+GL2Juo
	 1p5UkmfaCQXpc4Q0scB9Elony/6Wt9OsTUGf2ux6MLE+HMm8nKVkOMnj6hXVI/GpHb
	 Ep2jy4uLqvlTQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58O0huqL72796800
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 08:43:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 24 Sep 2025 08:43:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Wed, 24 Sep 2025 08:43:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Yu-Chun Lin <eleanor15x@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?big5?B?Q1lfSHVhbmdbtsDgsq7LXQ==?= <cy.huang@realtek.com>,
        =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>,
        "jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>,
        "visitorckw@gmail.com"
	<visitorckw@gmail.com>
Subject: RE: [PATCH rtw-next] wifi: rtw89: Replace hardcoded strings with helper functions
Thread-Topic: [PATCH rtw-next] wifi: rtw89: Replace hardcoded strings with
 helper functions
Thread-Index: AQHcKw6iw9xkJS2rJEiZoIdnDXLQ2rSesj7wgAG3LICAARhfEA==
Date: Wed, 24 Sep 2025 00:43:56 +0000
Message-ID: <51518b935e7649e3b5413e3a119d549b@realtek.com>
References: <20250921154410.1202074-1-eleanor15x@gmail.com>
 <715313b943d84cfeb3a337dc20be5f6a@realtek.com>
 <aNLDga29Wp1nwhem@visitorckw-System-Product-Name>
In-Reply-To: <aNLDga29Wp1nwhem@visitorckw-System-Product-Name>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

WXUtQ2h1biBMaW4gPGVsZWFub3IxNXhAZ21haWwuY29tPiB3cm90ZToNCj4gT24gTW9uLCBTZXAg
MjIsIDIwMjUgYXQgMDU6NTA6NTBBTSArMDAwMCwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IFl1
LUNodW4gTGluIDxlbGVhbm9yMTV4QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiBSZXBsYWNlIGhh
cmRjb2RlZCBzdHJpbmdzIHdpdGggJ3N0cl9vbl9vZmYoKScsICdzdHJfZW5hYmxlX2Rpc2FibGUo
KScsDQo+ID4gPiBhbmQgJ3N0cl9yZWFkX3dyaXRlKCknLg0KPiA+ID4NCj4gPiA+IFRoZSBjaGFu
Z2UgaW1wcm92ZXMgcmVhZGFiaWxpdHkgYW5kIGVuYWJsZXMgcG90ZW50aWFsIHN0cmluZyBkZWR1
cGxpY2F0aW9uDQo+ID4gPiBieSB0aGUgbGlua2VyLCB3aGljaCBtYXkgc2xpZ2h0bHkgcmVkdWNl
IGJpbmFyeSBzaXplLg0KPiA+DQo+ID4gSGF2ZSB5b3UgbWVhc3VyZWQgdGhlIGNoYW5nZSBvZiBi
aW5hcnkgc2l6ZT8gTWF5YmUgeW91IGNhbiBzaGFyZSB0aGUgcmVzdWx0DQo+ID4gaGVyZS4NCj4g
Pg0KPiANCj4gSSB0ZXN0ZWQgdGhlIHBhdGNoIGFuZCBkaWQgbm90IG9ic2VydmUgYW55IG1lYXN1
cmFibGUgY2hhbmdlIGluIHRoZSBiaW5hcnkgc2l6ZS4NCj4gVGhlIGNvbW1pdCBtZXNzYWdlIHdh
cyByZWZlcnMgdG8gdGhlIGRlc2NyaXB0aW9uIGluIHN0cmluZy1jaG9pY2UuaDoNCj4gDQo+ICIz
KSBEZWR1cGluZyBieSB0aGUgbGlua2VyLCB3aGljaCByZXN1bHRzIGluIGEgc21hbGxlciBiaW5h
cnkgZmlsZS4iDQoNCkl0IG1pZ2h0IHJlbHkgb24gTFRPIChsaW5rLXRpbWUgb3B0aW1pemF0aW9u
KS4gDQoNCg==

