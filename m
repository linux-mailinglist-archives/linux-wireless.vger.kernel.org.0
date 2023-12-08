Return-Path: <linux-wireless+bounces-572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FC4809C4C
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 07:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CB61C20A9F
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 06:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C757486;
	Fri,  8 Dec 2023 06:20:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728431723
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 22:20:44 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B86KY6s8674204, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B86KY6s8674204
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Dec 2023 14:20:34 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 8 Dec 2023 14:20:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 8 Dec 2023 14:20:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 8 Dec 2023 14:20:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "Leo.Li" <leo.li@realtek.com>, Kevin Yang <kevin_yang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 4/5] wifi: rtw89: 8922a: dump MAC registers when SER occurs
Thread-Topic: [PATCH 4/5] wifi: rtw89: 8922a: dump MAC registers when SER
 occurs
Thread-Index: AQHaKSlzEp2vLBwa90W1WC9IXSZBR7Ce6Dnw
Date: Fri, 8 Dec 2023 06:20:34 +0000
Message-ID: <3b27eaa39e064315b0f00ada7f08e2c2@realtek.com>
References: <20231204080751.15354-5-pkshih@realtek.com>
 <170196608744.2897000.6455822302893464057.kvalo@kernel.org>
In-Reply-To: <170196608744.2897000.6455822302893464057.kvalo@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2FsbGUgVmFsbyA8a3Zh
bG9Aa2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciA4LCAyMDIzIDEyOjIxIEFN
DQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gQ2M6IExlby5MaSA8
bGVvLmxpQHJlYWx0ZWsuY29tPjsgS2V2aW4gWWFuZyA8a2V2aW5feWFuZ0ByZWFsdGVrLmNvbT47
IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDQv
NV0gd2lmaTogcnR3ODk6IDg5MjJhOiBkdW1wIE1BQyByZWdpc3RlcnMgd2hlbiBTRVIgb2NjdXJz
DQo+IA0KPiBmb3IgZXhhbXBsZSBwcm92aWRpbmcgdGhlIGRhdGEgdXNpbmcgY29yZWR1bXAgZnJh
bWV3b3JrLg0KPiANCg0KVGhhbmtzIGZvciB0aGUgYWR2aWNlLiBXZSBtaWdodCBhZGQgYSBydHc4
OV9jb3JlZHVtcF9wcmludCgpIGZvciB0aGVzZQ0KaHVtYW4tcmVhZGFibGUgZGF0YSB0byBpbnRl
Z3JhdGUgdGhlbSBpbnRvIGNvcmVkdW1wLCBhbmQgYWRkIGEgcHJvbXB0DQptZXNzYWdlIGluIGRt
ZXNnIHRvIGhpbnQgdXNlcnMgdG8gcmVhZCBvdXQgdGhlIGRhdGEgZm9yIGZ1cnRoZXIgZGVidWcs
DQpiZWNhdXNlIGZpbGUgcGF0aCBvZiBjb3JlZHVtcCBzZWVtcyB0byBiZSBzdHJhbmdlIHRvIHVz
ZXJzLg0KDQpQaW5nLUtlIA0KDQo=

