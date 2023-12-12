Return-Path: <linux-wireless+bounces-686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C9F80E421
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 07:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC011C208DA
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 06:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FCC156D6;
	Tue, 12 Dec 2023 06:01:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB49C7
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 22:01:45 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BC61ekJ63263887, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BC61ekJ63263887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 14:01:40 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 12 Dec 2023 14:01:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 12 Dec 2023 14:01:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 12 Dec 2023 14:01:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ali Ghandour <gandour.ali@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Lenovo LOQ rtw_8852be
Thread-Topic: Lenovo LOQ rtw_8852be
Thread-Index: AQHaH+dudVZVMpW7Qk6t1f3PxKDyKLCNY6tQ///EsACAAAT0AIAAh+ZQgAeHaQCABKhgsP//2SiAgAHUHECABgrNAIABysFggAFMj4CAAIfLEA==
Date: Tue, 12 Dec 2023 06:01:40 +0000
Message-ID: <d1675f8f84de45a5a44bc36041816762@realtek.com>
References: <1700948088-16140-mlmmj-666d2532@vger.kernel.org>
 <CAOE0c97T1cVvqFkqfrP_h53X08yQ7kLinZP09L35nVHc_V89+g@mail.gmail.com>
 <5abfc98859504795b50f7f343784c886@realtek.com>
 <CAOE0c96uJ9x8gbJZdHiMEiOM5gTd_ZqM_rUV7Cs1NyA_t0Ncfg@mail.gmail.com>
 <CAOE0c97fDaLTfsMJVmEh4HxOAPY19kD60qsV5AKJbWW5nnqWzw@mail.gmail.com>
 <b4cfd676c0b24d98b82302aefac7f379@realtek.com>
 <CAOE0c97NvXFhttfNNm3+NsXw9SKV7sC-nJriwF43pujvJugvSg@mail.gmail.com>
 <1ad457d646ba4d9d99dc2f5cb8a1b590@realtek.com>
 <CAOE0c97cFjF=LGD8-nb95ihQhE0YRRqM=4PKud4nccQa06MVxw@mail.gmail.com>
 <f5e03fd6c26544b48cb493ec428338fb@realtek.com>
 <CAOE0c94UMKymy8mV2unbNo9CRe9n0pUmg6dGQ-xnRRKZvMxNJA@mail.gmail.com>
 <973fe7f5ec2c474c8a88f8933c7dde83@realtek.com>
 <CAOE0c94tf8y2hv0QHKEiuo5a7Ly=oJAw+g4Uh6BktHOMdbWY1Q@mail.gmail.com>
In-Reply-To: <CAOE0c94tf8y2hv0QHKEiuo5a7Ly=oJAw+g4Uh6BktHOMdbWY1Q@mail.gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpIEdoYW5kb3VyIDxn
YW5kb3VyLmFsaUBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDEyLCAyMDIz
IDE6MzYgUE0NCj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBDYzog
bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBMZW5vdm8gTE9R
IHJ0d184ODUyYmUNCj4gDQo+ID4gUGxlYXNlIHRyeSBiZWxvdyB3b3JrYXJvdW5kIHBhdGNoIHRv
IGlnbm9yZSB0aGUgc2V0dGluZy4gSSBoYXZlIHRyaWVkIHRoYXQsIGFuZA0KPiA+IGluIG15IHNp
ZGUgaXQgc3RpbGwgd29ya3Mgd2l0aG91dCBvYnZpb3VzIHByb2JsZW0uIEkgd2lsbCBjaGVjayBp
bnRlcm5hbGx5IHRvDQo+ID4gY2hlY2sgaG93IG11Y2ggdGhpcyBjYW4gYWZmZWN0LiBJZiBub3Qs
IEkgd291bGQgaWdub3JlIHRoaXMgaWYgY2VydGFpbiBwbGF0Zm9ybQ0KPiA+IGxpa2UgeW91cnMg
Y2FuJ3QgYWNjZXNzIFBDSSBzcGFjZSBvdmVyIDB4MTAwLg0KPiANCj4gSSB3YXMgYWJsZSB0byBj
b25uZWN0LiBUaGFua3MgYSBsb3QgUGluZy1LZSENCj4gDQoNCkdvb2QuIFBsZWFzZSB1c2UgaXQg
YXMgdXN1YWwgYW5kIG1vbml0b3IgaWYgaXQgd29ya3Mgc3RhYmxlLiBJIHdvdWxkIGxpa2UNCnRh
a2UgeW91ciByZXN1bHRzIGFzIHJlZmVyZW5jZSB0byBkZWNpZGUgaG93IEkgY2FuIG1vZGlmeSB0
aGUgZHJpdmVyLiANCg0KPiBbICA2MDkuNzk2MTcxXSBydHc4OV84ODUyYmUgMDAwMDowOTowMC4w
OiBmYWlsZWQgdG8gc2V0IENMS1JFUSBEZWxheQ0KPiBbICA2MDkuNzk2MTc1XSBydHc4OV84ODUy
YmUgMDAwMDowOTowMC4wOiBmYWlsZWQgdG8gc2V0IENMS1JFUV9MMSwgcmV0PS0yMg0KPiBbICA2
MDkuNzk2MTc3XSBydHc4OV84ODUyYmUgMDAwMDowOTowMC4wOiBmYWlsZWQgdG8gcmVhZCBBU1BN
IERlbGF5DQo+IFsgIDYwOS43OTYxNzddIHJ0dzg5Xzg4NTJiZSAwMDAwOjA5OjAwLjA6IGZhaWxl
ZCB0byByZWFkIEFTUE0gRGVsYXkNCj4gWyAgNjA5Ljc5NjE3OF0gcnR3ODlfODg1MmJlIDAwMDA6
MDk6MDAuMDogZmFpbGVkIHRvIHNldCBBU1BNIEwxLCByZXQ9LTIyDQoNClRoZXNlIG1lYW4gd2Ug
ZmFpbCB0byBhY2Nlc3MgbW9yZSBQQ0kgY29uZmlnIHNwYWNlIG92ZXIgMHgxMDAuIEkgd2lsbA0K
Y29uc2lkZXIgdGhlc2UgY2FzZXMgYXMgd2VsbC4NCg0KUGluZy1LZQ0KDQoNCg==

