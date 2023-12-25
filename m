Return-Path: <linux-wireless+bounces-1275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8C381DE05
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Dec 2023 04:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D03B1F214E7
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Dec 2023 03:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674B810F1;
	Mon, 25 Dec 2023 03:46:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBBB10EE
	for <linux-wireless@vger.kernel.org>; Mon, 25 Dec 2023 03:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BP3k19013682631, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BP3k19013682631
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Dec 2023 11:46:02 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Mon, 25 Dec 2023 11:46:02 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 11:46:02 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8]) by
 RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8%5]) with mapi id
 15.01.2375.007; Mon, 25 Dec 2023 11:46:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Larry Finger
	<Larry.Finger@lwfinger.net>
CC: linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: EFUSE in RTW8723DS
Thread-Topic: EFUSE in RTW8723DS
Thread-Index: AQHaFBQbaER/+8rOBUK6A5kkYXA52rB4/Z5QgAorOgCAAcI2AIAxf3CAgAL/WKA=
Date: Mon, 25 Dec 2023 03:46:02 +0000
Message-ID: <b73db8cd64534d329684027d40348d79@realtek.com>
References: <f3505110-b76b-4152-8375-37fa3184d3c1@lwfinger.net>
 <748b045e7aaa43eb9a7fb83ad924614f@realtek.com>
 <CAFBinCD=iLbyfWWTqQjLQ5CiqOn08r4UaVqyKHve8AoW_xeFEw@mail.gmail.com>
 <84dc9e8b-0850-4724-a55b-582c994d042f@lwfinger.net>
 <CAFBinCDD9kY-HLQXy=Ksi1QnLcOVpS0Vrnn6ksCZmTbf0MukSA@mail.gmail.com>
In-Reply-To: <CAFBinCDD9kY-HLQXy=Ksi1QnLcOVpS0Vrnn6ksCZmTbf0MukSA@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFydGluIEJsdW1lbnN0
aW5nbCA8bWFydGluLmJsdW1lbnN0aW5nbEBnb29nbGVtYWlsLmNvbT4NCj4gU2VudDogU2F0dXJk
YXksIERlY2VtYmVyIDIzLCAyMDIzIDY6NDAgUE0NCj4gVG86IExhcnJ5IEZpbmdlciA8TGFycnku
RmluZ2VyQGx3ZmluZ2VyLm5ldD4NCj4gQ2M6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsu
Y29tPjsgbGludXgtd2lyZWxlc3MgPGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZz4NCj4g
U3ViamVjdDogUmU6IEVGVVNFIGluIFJUVzg3MjNEUw0KPiANCj4gSGkgTGFycnksDQo+IA0KPiBh
cG9sb2dpZXMgZm9yIG15IGxhdGUgcmVwbHkuDQo+IA0KPiBPbiBUdWUsIE5vdiAyMSwgMjAyMyBh
dCAxMTo0N+KAr1BNIExhcnJ5IEZpbmdlciA8TGFycnkuRmluZ2VyQGx3ZmluZ2VyLm5ldD4gd3Jv
dGU6DQo+ID4NCj4gPg0KPiA+IE1hcnRpbiwNCj4gPg0KPiA+IEFzIHNob3duIGluDQo+ID4gaHR0
cHM6Ly9naXRodWIuY29tL2x3ZmluZ2VyL3J0dzg4L2lzc3Vlcy8xNTcjaXNzdWVjb21tZW50LTE4
MjA0MjE4MjEsIGRyaXZlcg0KPiA+IHJ0dzg4IHNob3dzIGEgbG90IHdvcnNlIHBlcmZvcm1hbmNl
IHRoYW4gdGhlIHZlbmRvciBkcml2ZXIgZm9yIGEgY2hpcCB3aXRoIGENCj4gPiBwcm9wZXJseSBl
bmNvZGVkIEVGVVNFLiBJcyB0aGlzIG5vdCBhIGNhc2Ugb2YgaW5jb3JyZWN0IHNldHRpbmcgb2Yg
dGhlDQo+ID4gY2FsaWJyYXRpb24gZGF0YT8NCj4gTXkgY3VycmVudCBhc3N1bXB0aW9uIGlzIHRo
YXQgdGhlIHdvcnNlIHBlcmZvcm1hbmNlICg9IHRocm91Z2hwdXQpIGlzDQo+IHJlbGF0ZWQgdG8g
dGhlIGltcGxlbWVudGF0aW9uIGluIHJ0dzg4J3MgU0RJTyBjb2RlLCBub3QgdGhlDQo+IHByb2dy
YW1taW5nIG9mIHRoZSBSRiBwYXJhbWV0ZXJzLg0KPiBJJ20gcGxhbm5pbmcgdG8gbG9vayBpbnRv
IHRoaXMgbmV4dCB3ZWVrLg0KPiBJJ2QgYXBwcmVjaWF0ZSBhbnkgaGludHMgZnJvbSBQaW5nLUtl
IG9uIHdoYXQgdG8gY2hlY2sgLyBob3cgdG8gY2hlY2sNCj4gKGFzIGxvbmcgYXMgSSBjYW4gZG8g
aXQgd2l0aCB2ZXJ5IGJhc2ljIGVxdWlwbWVudCAtIGluIG90aGVyIHdvcmRzOiBJDQo+IGRvbid0
IGhhdmUgYW4gUkYgYW5hbHl6ZXIpIDotKQ0KPiANCg0KU29ycnkgSSBkb24ndCBoYXZlIHRvbyBt
dWNoIGlkZWEuIEJhc2ljYWxseSwgSSB3b3VsZCBsaWtlIHRvIHVzZSBhIHNuaWZmZXIgdG8NCmNh
cHR1cmUgcGFja2V0cyBhbmQgY29tcGFyZSBkaWZmZXJlbmNlcyBiZXR3ZWVuIHJ0dzg5IGFuZCB2
ZW5kb3IgZHJpdmVyLCBhbmQNCnRoZW4gY2hlY2sgUEhZIHJhdGUgdG8gYmlzZWN0IGNhdXNlcy4g
DQoNClBpbmctS2UNCg0K

