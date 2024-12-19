Return-Path: <linux-wireless+bounces-16577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6903F9F73F9
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 06:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E148188B3AC
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 05:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15201C5CB5;
	Thu, 19 Dec 2024 05:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="a78LZZKh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5202C7E575
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734586562; cv=none; b=OyifofK26LIjTibqNJ0n/nUJTYRgMWPWPNe8xPha6AZLoTQuzpcQt98w0BvF6fr5OvdrSYTzQcAR38iZCx29QygJdblQhc5JQ+u9SIAyOQXFqjIgrCc9I//wM6+wU9/xIJrdQlYnG54RXAXghqsXPTq8TmY55NP+R/28QcHCgg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734586562; c=relaxed/simple;
	bh=/H97gYsjqM5kr+jhKn0+Q3Ty5flNJQUHYhLnC0idbqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rw3lRjCE37C/GiwqzXXsfuBvlqY7/dRyM/IhCBR3Kr5p1PfXKhafj8Sr83BZDXEqCemLZLKW2Mwov1Wq0z8n1sY3eAPFeKfT0JcoiqbAxiiyQt7APB+49L/eYDSrywuT5/r5lWSdTxAbyovd/ct4NedqzQbuTSFeQxHxIm7kNj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=a78LZZKh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BJ5ZukoE3494485, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734586556; bh=/H97gYsjqM5kr+jhKn0+Q3Ty5flNJQUHYhLnC0idbqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=a78LZZKhjVXnvfvSoIH+yI5/SDl2tHBC7xarcobKCqa7wmhFC0xkTsuzRQNaELGQ+
	 E4VW+DPfTm4M/MkJD5+hBr/7tXLdvIAnEjKui5prFKZmMt5t/L2cTzpKB3s/FKh19C
	 /eM6+rN7eVuYIUpJ/lacO/UxF15766U4ZXcuoTH2Do8YKVt9w8KCR4fVZmq29+XysG
	 HZT3rQFpJ5c9PuTheVVppo1JbXQoSs59GWfxgz0K5uA3BzkYe6P2huQ8m2H8oPoBzI
	 Yaz8boRdw/U5LwHlJM8qZe59eMEdw5wUsMMSawMHbaCASoVxu84eHgLGSnX3emcOR9
	 AHjWOiPG6yaoQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BJ5ZukoE3494485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 13:35:56 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Dec 2024 13:35:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 19 Dec 2024 13:35:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 19 Dec 2024 13:35:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: Fix RTL8188EU firmware upload block size
Thread-Topic: [PATCH] wifi: rtl8xxxu: Fix RTL8188EU firmware upload block size
Thread-Index: AQHbUOKZHEQMMxj7/UOjeVAJV1LiCbLtDYsA
Date: Thu, 19 Dec 2024 05:35:56 +0000
Message-ID: <93c30be90a854b70ba1c85d3b5d0b8ca@realtek.com>
References: <146b1077-768a-44f9-86b3-a36814edf92a@gmail.com>
In-Reply-To: <146b1077-768a-44f9-86b3-a36814edf92a@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBIHVz
ZXIgcmVwb3J0cyB0aGF0IHRoZSBmaXJtd2FyZSB1cGxvYWQgY29uc2lzdGVudGx5IGZhaWxzIHdo
ZW4gaXQncw0KPiB1cGxvYWRlZCBpbiBjaHVua3Mgb2YgMTI4IGJ5dGVzLCBidXQgaXQgd29ya3Mg
d2hlbiB1cGxvYWRlZCBpbiBjaHVua3MNCj4gb2YgMTk2IGJ5dGVzLiBUaGUgb2ZmaWNpYWwgZHJp
dmVyIHVzZXMgMTk2IGJ5dGVzIGFsc28uDQo+IA0KPiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20v
YTVhNWFhNTU1b28vcnRsOHh4eHUvaXNzdWVzLzINCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1
ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBQaW5nLUtl
IFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0K

