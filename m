Return-Path: <linux-wireless+bounces-21821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0619DA95C4A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 04:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6E83A7A03
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 02:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C99433C9;
	Tue, 22 Apr 2025 02:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="JjFqbMka"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235556DCE1
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 02:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745289861; cv=none; b=U7Chwlc6gYk9ZqTwyAl4S1POAoFjxgNPCh6xLcgN0/pfwmYByirxMbCJvZp+LqUtWqf+CcuiuOQcPq6E20wP0BwxtvjRqKiTM38gvoT5262KNVl0+IyPfR/0/6Wgx/JM+46OXK5IZHRPakQ8NZqiDHWh3jUxtQZFpOQ0uP7vaPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745289861; c=relaxed/simple;
	bh=8D8E8/pg4EeNaV6F4cY6a9Mab7VSIMPUmYsKvLqo+y8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W83dsElCNa+kQulDHEBiQhqsklqppfSC8jWHPUOy2tA5F1k2e2bd8gNCtPZgomT+NdwpAJKsWkuXlfvDS4mMPAvtJVqjGU2GaQJsVGTayhD99d2YKpfpimcKuRLAYKk+6ZaQmY7NkZe7ZDS6Uhq7DksJp4QGbFixteA0Dw0oU6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=JjFqbMka; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53M2i71614000298, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745289847; bh=8D8E8/pg4EeNaV6F4cY6a9Mab7VSIMPUmYsKvLqo+y8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=JjFqbMka72fWl8LmKvVLVFmtRK95k1R1IEyvy67IGskAXIdUQUo4MtmDvR2lNSfbr
	 3MS9Et/3sqrWhlUbsXAPWTfwDWIJfhtSUmwlUmv4mzOqpPMsj7nXVnK2PRSr4CYpxi
	 Adb8yvePtChJugt0iNQ43DpYxPrdHIBVplOV63WRKdPUbEGQCgj3W0aPIc/FMu/r2U
	 jYaFFNhu98tHeRmRvbJr4iaK9qgEyzkTk10ikJLDp7zWei98QxmS005dKlRUSItU+C
	 M0Sa/fpEADM54yTkDsDy/Jw7EQET2x19ljPvU+YtZMk2VWUcmOmN4hiMoKs1oBs/Pe
	 oBXt7NAamWysQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53M2i71614000298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 10:44:07 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 10:44:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 22 Apr 2025 10:44:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 22 Apr 2025 10:44:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Shengyu Qu <wiagn233@outlook.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: RTL8852BS support?
Thread-Topic: RTL8852BS support?
Thread-Index: AQHbsy9boGOfpfTKJU26UgLVv2G3qLOudFnQ
Date: Tue, 22 Apr 2025 02:44:07 +0000
Message-ID: <b41abb5302d54df2a6819a57ef059f52@realtek.com>
References: <TYCPR01MB8437584CFB57F0290F816DBA98BB2@TYCPR01MB8437.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB8437584CFB57F0290F816DBA98BB2@TYCPR01MB8437.jpnprd01.prod.outlook.com>
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

U2hlbmd5dSBRdSA8d2lhZ24yMzNAb3V0bG9vay5jb20+IHdyb3RlOg0KPiANCj4gSGksDQo+IA0K
PiBJJ20gZ29pbmcgdG8gYnV5IGEgQlBJLUYzIGJvYXJkIHdoaWNoIHVzZXMgYSBSVEw4ODUyQlMg
Y2hpcCBhcyBXSUZJDQo+IGNhcmQuIEJ1dCBpdCBzZWVtcyBub3Qgc3VwcG9ydGVkIGJ5IGN1cnJl
bnQgbWFpbmxpbmUgcnR3ODgvODkgZHJpdmVyLg0KPiBXaWxsIGl0IGdldCBzdXBwb3J0ZWQgaW4g
dGhlIGZ1dHVyZT8NCg0KRm9yIG5vdywgd2UgZG9uJ3QgaGF2ZSBwbGFuIHRvIHN1cHBvcnQgU0RJ
TyBjaGlwcy4gSWYgcGVvcGxlIGFyZQ0KaW50ZXJlc3RlZCBpbiBwb3J0aW5nIHZlbmRvciBkcml2
ZXIgdG8gcnR3ODksIEkgY2FuIGhlbHAgYXMgYSBicmlkZ2UNCnRvIGNvbnRhY3QgU0RJTyBleHBl
cnRzIGlmIGFueSBwcm9ibGVtcy4gDQoNCg0K

