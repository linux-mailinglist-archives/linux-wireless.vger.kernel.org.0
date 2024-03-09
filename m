Return-Path: <linux-wireless+bounces-4504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C11B876E12
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 01:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65651F23130
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 00:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90CA37A;
	Sat,  9 Mar 2024 00:19:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33E936E;
	Sat,  9 Mar 2024 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709943595; cv=none; b=a/+v5YT2CaNohpAFVPr1GUV7YLtS4MIMys/eehTGjQ7FNvWpdkJZxLF7Z8/HRKIz/CWlvy672q0sEboA5577FHhxaPYzveij6Aa3CdDuZqqJAmvKMmevPI9S68IO6E71gseQS2lGacx5DVoIoaetu/6tWB0XBz3i8nGYn7yE3ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709943595; c=relaxed/simple;
	bh=hgublxvBB0WVDZsVatODbqGkGHOgzWTNz3NCZI26pKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PC9Kn4R/n13SEMdeJE99MePW1iqebcejKnLWDm10cjOelxLnCs5M6nliWANj97swjbGuqWxmQB+H++ldBXTXrt2JXD1DIKjL3fXvIE8yZ7exzE4G04qxGePQaS4fdVIaNjehhmrqI6v4JfxBuu+2TaNC8qWsQzJUj3jPgziXV4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4290Jl7bA2356079, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4290Jl7bA2356079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 9 Mar 2024 08:19:47 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 9 Mar 2024 08:19:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 9 Mar 2024 08:19:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Sat, 9 Mar 2024 08:19:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        DeanKu
	<ku920601@realtek.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: pull-request: wireless-next-2024-03-08
Thread-Topic: pull-request: wireless-next-2024-03-08
Thread-Index: AQHacUAJ7oSqIHSLZEax02VmaRi8t7EtdrqAgACYMYP///czAA==
Date: Sat, 9 Mar 2024 00:19:46 +0000
Message-ID: <a73e5a8f7f6807b736c15a3ea25d063451aec6b5.camel@realtek.com>
References: <20240308100429.B8EA2C433F1@smtp.kernel.org>
	 <20240308074539.04512f66@kernel.org> <87wmqc4qik.fsf@kernel.org>
In-Reply-To: <87wmqc4qik.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <A80AC4CDEA649841BC595FE0A70ADC85@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gRnJpLCAyMDI0LTAzLTA4IGF0IDE4OjUwICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAN
Cj4gSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4gd3JpdGVzOg0KPiANCj4gPiBmb3Ig
YSBub24tdXJnZW50IGZvbGxvdyB1cC4gRG9lc24ndCBsb29rIGxpa2UgYW4gb2J2aW91cyBmYWxz
ZSBwb3NpdGl2ZS4NCj4gDQo+IFBpbmcsIGNvdWxkIHlvdSBmaXggdGhpcywgcGxlYXNlPyBJbiB0
aGUgcGF0Y2ggcGxlYXNlIGFkZCBDbG9zZXMgdGFnDQo+IHBvaW50aW5nIHRvIEpha3ViJ3MgZW1h
aWwgYW5kIG1hcmsgaXQgZm9yIHdpcmVsZXNzIHRyZWUgKGFzc3VtaW5nIHRoZQ0KPiBtZXJnZSB3
aW5kb3cgc3RhcnRzIG9uIFN1bmRheSwgb3RoZXJ3aXNlIHdlIHRha2UgaXQgdG8gd2lyZWxlc3Mt
bmV4dCkuDQo+IA0KDQpJIGhhdmUgc2VudCBhIGZpeCBbMV0sIGFuZCB0aGF0IGlzIGEgdHlwbyBp
bnN0ZWFkICgweDU1ZiB2cyAweDVmZikuDQpUaGFua3MgZm9yIHRoZSBmaW5kaW5nLg0KDQpQaW5n
LUtlDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy8yMDI0MDMw
OTAwMTM0OC45OTA2LTEtcGtzaGloQHJlYWx0ZWsuY29tL1QvI3UNCg0K

