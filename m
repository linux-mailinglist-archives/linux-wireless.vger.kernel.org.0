Return-Path: <linux-wireless+bounces-4873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F4987F4FB
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 02:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893021C21320
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 01:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743EE612F6;
	Tue, 19 Mar 2024 01:34:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0911F4C90
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 01:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812095; cv=none; b=pMF/zGMgI6dZFAlWwYlcULWOjQmloFOatIv9pLrXcPQycWIj4MY2Oo0XY5Y9N2v7DoVyCjADnDVgrPSRL0t+PDFjvjKY51LHXnSRpPHMgaNdxlZfUPMjAIsjjUitYj8W0OvbSRDutPDFxRk5GA3jkuCK2MxZUtf79e5aWZksCbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812095; c=relaxed/simple;
	bh=S/0AufeoDeubqwF6AwFUQnk7wMzmDaBGvxKd2fl6nn4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EXuyFhl1M/OwXwxSjceQEbmFGkn6w6sFaSgkMB1RSUZd3kR1ZDl+K0UDc/29dI+cBVs+lOECfGhLpXTYzZ0AO7z64KNivd/imsdssIcLSszkLO3Zd9Y2xuKcnkiBxKFCE8fi1Gw/1yogBO6SaSXL8qOkeX54NZwK2sqVgSNW94g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42J1XR6203695060, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42J1XR6203695060
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 09:33:27 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 09:33:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 09:33:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Tue, 19 Mar 2024 09:33:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "fiona.klute@gmx.de"
	<fiona.klute@gmx.de>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>,
        "Larry.Finger@lwfinger.net"
	<Larry.Finger@lwfinger.net>,
        "martin.kaistra@linutronix.de"
	<martin.kaistra@linutronix.de>,
        "martin.blumenstingl@googlemail.com"
	<martin.blumenstingl@googlemail.com>,
        "brianwitte@mailfence.com"
	<brianwitte@mailfence.com>
Subject: Git tree to manage Realtek WiFi drivers
Thread-Topic: Git tree to manage Realtek WiFi drivers
Thread-Index: AQHaeZ1wC1DGpCikcU2zHRKFE8bG1A==
Date: Tue, 19 Mar 2024 01:33:27 +0000
Message-ID: <503a9152324a817c251193ee486e1bbcb48d2fa8.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <42F6AE02FA36D148B1CF4AFBB01420CF@realtek.com>
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

SGksDQoNCkZpcnN0IG9mIGFsbCwgdGhhbmsgYWxsIGNvbnRyaWJ1dG9ycyAoQ2MnZWQpIHRvIGFk
ZCBuZXcgZmVhdHVyZXMgYW5kDQpjaGlwcyBzdXBwb3J0IG9mIFJlYWx0ZWsgV2lGaSB1bmRlciBk
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrLy4NCg0KVG8gYmFsYW5jZSBsb2FkIG9mIG1haW50
YWluZXJzLCBJIHdpbGwgc3RhcnQgYmVpbmcgdGhlIG1haW50YWluZXIgdG8gbWFuYWdlDQpSZWFs
dGVrIGRyaXZlcnMgWzFdIGJ5IGFuIG5ldyBnaXQgdHJlZSBbMl0gdGhhdCBJIGZvcmsgZnJvbSB3
aXJlbGVzcy1uZXh0LA0KYW5kIHRoZSBtYWluIGJyYW5jaCBpcyBydHctbmV4dC4gRm9yIHN1Ym1p
dHRlcnMsIGFsbCB0aGluZ3MgYXJlIHRoZSBzYW1lIGFzDQp1c3VhbCBleGNlcHQgdG8gY29kZWJh
c2UuDQoNCkFsc28gd2VsY29tZSB0byBoZWxwIHJldmlldyBwYXRjaGVzIGZyb20gb3RoZXIgY29u
dHJpYnV0b3JzLiBUaGF0IGlzDQpyZWFsbHkgaGVscGZ1bCB0byBnZXQgdGhlc2UgZHJpdmVycyBi
ZXR0ZXIuDQoNClBpbmctS2UNCg0KLS0tDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtd2lyZWxlc3MvMjAyNDAzMTkwMTE5MjUuNjg1NS0xLXBrc2hpaEByZWFsdGVrLmNvbS9ULyN1
DQpbMl0gaHR0cHM6Ly9naXRodWIuY29tL3Brc2hpaC9ydHcuZ2l0DQoNCg==

