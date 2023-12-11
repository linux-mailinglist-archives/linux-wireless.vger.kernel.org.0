Return-Path: <linux-wireless+bounces-612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A5680BED9
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 02:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8C62809E3
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 01:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0071110A1E;
	Mon, 11 Dec 2023 01:53:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6FEBD
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 17:53:28 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BB1rNtI52324843, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BB1rNtI52324843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 09:53:23 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 11 Dec 2023 09:53:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 11 Dec 2023 09:53:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 11 Dec 2023 09:53:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ali Ghandour <gandour.ali@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Lenovo LOQ rtw_8852be
Thread-Topic: Lenovo LOQ rtw_8852be
Thread-Index: AQHaH+dudVZVMpW7Qk6t1f3PxKDyKLCNY6tQ///EsACAAAT0AIAAh+ZQgAeHaQCABKhgsP//2SiAgAHUHECABgrNAIABysFg
Date: Mon, 11 Dec 2023 01:53:24 +0000
Message-ID: <973fe7f5ec2c474c8a88f8933c7dde83@realtek.com>
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
In-Reply-To: <CAOE0c94UMKymy8mV2unbNo9CRe9n0pUmg6dGQ-xnRRKZvMxNJA@mail.gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpIEdoYW5kb3VyIDxn
YW5kb3VyLmFsaUBnbWFpbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgRGVjZW1iZXIgMTAsIDIwMjMg
MjoyNCBQTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IENjOiBs
aW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IExlbm92byBMT1Eg
cnR3Xzg4NTJiZQ0KPiANCj4gSXQgZW5kZWQgdXAgc2hvd2luZyA0MDk2Lg0KDQpCdXQgc3RpbGwg
bm90IHdvcmsuIFBDSSBjb2RlIGlzIGhhcmQgdG8gbWUuIA0KDQpQbGVhc2UgdHJ5IGJlbG93IHdv
cmthcm91bmQgcGF0Y2ggdG8gaWdub3JlIHRoZSBzZXR0aW5nLiBJIGhhdmUgdHJpZWQgdGhhdCwg
YW5kDQppbiBteSBzaWRlIGl0IHN0aWxsIHdvcmtzIHdpdGhvdXQgb2J2aW91cyBwcm9ibGVtLiBJ
IHdpbGwgY2hlY2sgaW50ZXJuYWxseSB0bw0KY2hlY2sgaG93IG11Y2ggdGhpcyBjYW4gYWZmZWN0
LiBJZiBub3QsIEkgd291bGQgaWdub3JlIHRoaXMgaWYgY2VydGFpbiBwbGF0Zm9ybQ0KbGlrZSB5
b3VycyBjYW4ndCBhY2Nlc3MgUENJIHNwYWNlIG92ZXIgMHgxMDAuDQoNCg0KQEAgLTIwNjEsNiAr
MjA2MSw5IEBAIHN0YXRpYyBpbnQgcnR3ODlfcGNpX2F1dG9fcmVmY2xrX2NhbChzdHJ1Y3QgcnR3
ODlfZGV2ICpydHdkZXYsIGJvb2wgYXV0b29rX2VuKQ0KICAgICAgICBpZiAoY2hpcF9pZCAhPSBS
VEw4ODUyQiAmJiBjaGlwX2lkICE9IFJUTDg4NTFCKQ0KICAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KDQorICAgICAgIHByaW50aygibm8gYXV0b19yZWZjbGtfY2FsXG4iKTsNCisgICAgICAgcmV0
dXJuIDA7DQorDQogICAgICAgIHJldCA9IHJ0dzg5X3BjaV9yZWFkX2NvbmZpZ19ieXRlKHJ0d2Rl
diwgUlRXODlfUENJRV9QSFlfUkFURSwgJnZhbDgpOw0KICAgICAgICBpZiAocmV0KSB7DQogICAg
ICAgICAgICAgICAgcnR3ODlfZXJyKHJ0d2RldiwgIltFUlJdcGNpIGNvbmZpZyByZWFkICVYXG4i
LA0KDQoNClBpbmctS2UNCg0K

