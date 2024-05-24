Return-Path: <linux-wireless+bounces-8043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BFA8CE3E4
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 11:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394241F2312D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 09:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D981185642;
	Fri, 24 May 2024 09:48:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4C85628;
	Fri, 24 May 2024 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716544087; cv=none; b=kBED7PQtHKJykPwuWiRkYYNW3DPkZWrdkt1lWz6gY7/clVoqNfpFP0Omj63vLq3rGomc6iJuQtb8j2zA/9Vxi5g5/FPEssk4TUez7u2Q9jasNaP31CuF4jehft2N1sYjzm9DTq/yQfFKI1/hk6+aDVxoBYfqc4/IyaLHwSBf+2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716544087; c=relaxed/simple;
	bh=Q41UdNN1L/Xo9m8xKdZPS//ZMbYpJcai8czDTHfNs+0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ihk+oJwDeDYG0HHne/jIs2OpyjBZNA+0aTcrKqPeBWPgdysOHcOLSQcC08ZtB742be/F9NuvkOO3kBWlS8p3Cr7vWTAJ0odF1EhalGYAdtNBJXVGiqBlFNKu9+UI6uqiDA+y9WcN6QKwzBQpdxOKtc3K37zikbQUDD2+az71Z1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44O9lluvF1992534, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44O9lluvF1992534
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 17:47:47 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 17:47:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 24 May 2024 17:47:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 24 May 2024 17:47:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "jiapeng.chong@linux.alibaba.com" <jiapeng.chong@linux.alibaba.com>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "abaci@linux.alibaba.com"
	<abaci@linux.alibaba.com>
Subject: Re: [PATCH] wifi: rtw89: chan: Use swap() instead of open coding it
Thread-Topic: [PATCH] wifi: rtw89: chan: Use swap() instead of open coding it
Thread-Index: AQHarbAwZ9p5cpJBPEmLdmmf9C2pU7GlnUmA
Date: Fri, 24 May 2024 09:47:47 +0000
Message-ID: <7d3bbf5bcbe134edc8305bdc044b53edb88bbdab.camel@realtek.com>
References: <20240524075819.2789-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240524075819.2789-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <C52A7368B0692E4C9D0B3B609573282F@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

SGksDQoNClN1YmplY3QgIndpZmk6IHJ0dzg5OiBjaGFuOiBVc2Ugc3dhcCgpIGluc3RlYWQgb2Yg
b3BlbiBjb2RpbmcgaXQiIGlzIHRvbyBjb21tb24uDQpJZiBtb3JlIHRoYW4gb25lIHBhdGNoIGRv
ZXMgc2ltaWxhciB0aGluZywgd2UgY2FuJ3Qga25vdyB0aGUgY2hhbmdlIGZyb20NCnN1YmplY3Qu
IEl0IHdvdWxkIGJlIGJldHRlciB0byBtZW50aW9uICJzd2FwIHN1Yl9lbnRpdHkiLiANCg0KT3Ro
ZXJzIGFyZSBnb29kIHRvIG1lLiANCg0KDQpPbiBGcmksIDIwMjQtMDUtMjQgYXQgMTU6NTggKzA4
MDAsIEppYXBlbmcgQ2hvbmcgd3JvdGU6DQo+IA0KPiBTd2FwIGlzIGEgZnVuY3Rpb24gaW50ZXJm
YWNlIHRoYXQgcHJvdmlkZXMgZXhjaGFuZ2UgZnVuY3Rpb24uIFRvIGF2b2lkDQo+IGNvZGUgZHVw
bGljYXRpb24sIHdlIGNhbiB1c2Ugc3dhcCBmdW5jdGlvbi4NCj4gDQo+IC4vZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OS9jaGFuLmM6MjMzNjozMi0zMzogV0FSTklORyBvcHBvcnR1
bml0eSBmb3Igc3dhcCgpLg0KPiANCj4gUmVwb3J0ZWQtYnk6IEFiYWNpIFJvYm90IDxhYmFjaUBs
aW51eC5hbGliYWJhLmNvbT4NCj4gQ2xvc2VzOiBodHRwczovL2J1Z3ppbGxhLm9wZW5hbm9saXMu
Y24vc2hvd19idWcuY2dpP2lkPTkxNzQNCj4gU2lnbmVkLW9mZi1ieTogSmlhcGVuZyBDaG9uZyA8
amlhcGVuZy5jaG9uZ0BsaW51eC5hbGliYWJhLmNvbT4NCj4gDQo=

