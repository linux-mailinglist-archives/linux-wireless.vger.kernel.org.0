Return-Path: <linux-wireless+bounces-1384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECB582162C
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 02:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047391C20D16
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 01:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4FEEBC;
	Tue,  2 Jan 2024 01:50:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136EEBD
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4021oExxD014350, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4021oExxD014350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 09:50:14 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Tue, 2 Jan 2024 09:50:15 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 09:50:00 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8]) by
 RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8%5]) with mapi id
 15.01.2375.007; Tue, 2 Jan 2024 09:50:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Zenm Chen <zenmchen@gmail.com>
Subject: RE: [PATCH v3] wifi: rtl8xxxu: Fix LED control code of RTL8192FU
Thread-Topic: [PATCH v3] wifi: rtl8xxxu: Fix LED control code of RTL8192FU
Thread-Index: AQHaO3H4S+q8yjnV80+pP8ZkfRe9b7DFxLtw
Date: Tue, 2 Jan 2024 01:50:00 +0000
Message-ID: <2c67bbe4a3c84b45acb74b2e945eb2a8@realtek.com>
References: <7a2c3158-3a45-4466-b11e-fc09802b20e2@gmail.com>
In-Reply-To: <7a2c3158-3a45-4466-b11e-fc09802b20e2@gmail.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgRGVjZW1iZXIgMzEs
IDIwMjMgNjo0NiBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT47IFplbm0gQ2hlbg0KPiA8emVubWNoZW5AZ21haWwuY29tPg0KPiBT
dWJqZWN0OiBbUEFUQ0ggdjNdIHdpZmk6IHJ0bDh4eHh1OiBGaXggTEVEIGNvbnRyb2wgY29kZSBv
ZiBSVEw4MTkyRlUNCj4gDQo+IFNvbWUgZGV2aWNlcywgbGlrZSB0aGUgQ29tZmFzdCBDRi04MjZG
LCB1c2UgTEVEMSwgd2hpY2ggYWxyZWFkeSB3b3Jrcy4NCj4gT3RoZXJzLCBsaWtlIEFzdXMgVVNC
LU4xMyBDMSwgdXNlIExFRDAsIHdoaWNoIGRvZXNuJ3Qgd29yayBjb3JyZWN0bHkuDQo+IA0KPiBX
cml0ZSB0aGUgcmlnaHQgdmFsdWVzIHRvIHRoZSBMRUQgY29udHJvbCByZWdpc3RlcnMgdG8gbWFr
ZSBMRUQwIHdvcmsNCj4gYXMgd2VsbC4NCj4gDQo+IFRoaXMgaXMgdW5mb3J0dW5hdGVseSB0ZXN0
ZWQgb25seSB3aXRoIHRoZSBDb21mYXN0IENGLTgyNkYuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBC
aXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KVGhhbmsgeW91IGFu
ZCBaZW5tIGZvciB0aGlzIHdvcmshIA0KDQpSZXZpZXdlZC1ieTogUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+DQoNCg0K

