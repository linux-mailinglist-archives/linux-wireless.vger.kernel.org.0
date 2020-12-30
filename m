Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FBB2E75A0
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Dec 2020 03:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgL3COE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Dec 2020 21:14:04 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:54761 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgL3COD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Dec 2020 21:14:03 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0BU2DBloC023723, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs03.realtek.com.tw[172.21.6.96])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0BU2DBloC023723
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 30 Dec 2020 10:13:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 30 Dec 2020 10:13:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833]) by
 RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833%12]) with mapi id
 15.01.2106.006; Wed, 30 Dec 2020 10:13:10 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "hugh.chao@canonical.com" <hugh.chao@canonical.com>,
        "ethan.hsieh@canonical.com" <ethan.hsieh@canonical.com>
Subject: Re: 802.11ac AP mode support on Realtek 8821AE?
Thread-Topic: 802.11ac AP mode support on Realtek 8821AE?
Thread-Index: AQHW2fh5IvEZMJBzZUWoIZotvMuBPqoGCFqAgACnLICAB7jzAA==
Date:   Wed, 30 Dec 2020 02:13:10 +0000
Message-ID: <1609294366.3846.3.camel@realtek.com>
References: <CAAd53p7oymvge7DZ1_+7aA45EpNjG=FZ3PNJDv=_UT0ghv+rqQ@mail.gmail.com>
         <e90f1953-cda0-baf7-1b5c-56c649df6b90@lwfinger.net>
         <CAAd53p4=tAmyCE3QhFP8N9We3T_CGvnLWYgZAH8naWc_njtrOQ@mail.gmail.com>
In-Reply-To: <CAAd53p4=tAmyCE3QhFP8N9We3T_CGvnLWYgZAH8naWc_njtrOQ@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="utf-8"
Content-ID: <29D09AFADC91BD40986689570501A579@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIwLTEyLTI1IGF0IDEyOjE2ICswODAwLCBLYWktSGVuZyBGZW5nIHdyb3RlOg0K
PiBPbiBGcmksIERlYyAyNSwgMjAyMCBhdCAyOjE4IEFNIExhcnJ5IEZpbmdlciA8TGFycnkuRmlu
Z2VyQGx3ZmluZ2VyLm5ldD4NCj4gd3JvdGU6DQo+ID4NCj4gPiBPbiAxMi8yNC8yMCA3OjI2IEFN
LCBLYWktSGVuZyBGZW5nIHdyb3RlOg0KPiA+ID4gSGkgUGluZy1LZSwNCj4gPiA+DQo+ID4gPiBX
ZSd2ZSBmb3VuZCB0aGF0IHdoZW4gY3JlYXRpbmcgNUcgQVAgb24gODgyMUFFLCBpdCdzIG5vdCBv
biBvdGhlcg0KPiA+ID4gZGV2aWNlcycgd2lmaSBsaXN0Lg0KPiA+ID4NCj4gPiA+IEhlcmUncyB0
aGUgc3RlcHMgSSB1c2VkIHRvIGNyZWF0ZSBhbiBBUDoNCj4gPiA+ICQgbm1jbGkgYyBhZGQgdHlw
ZSB3aWZpIGlmbmFtZSB3bHAzczAgY29uLW5hbWUgaGVsbG8gYXV0b2Nvbm5lY3Qgbm8gc3NpZA0K
PiBoZWxsbw0KPiA+ID4gJCBubWNsaSBjIG1vZGlmeSBoZWxsbyA4MDItMTEtd2lyZWxlc3MubW9k
ZSBhcCBpcHY0Lm1ldGhvZCBzaGFyZWQNCj4gPiA+IDgwMi0xMS13aXJlbGVzcy5iYW5kIGENCj4g
PiA+ICQgbm1jbGkgY29ubmVjdGlvbiB1cCBoZWxsbw0KPiA+ID4NCj4gPiA+IElmIHdlIGNoYW5n
ZSAiODAyLTExLXdpcmVsZXNzLmJhbmQiIHRvICJiZyIsIHRoZW4gdGhlIEFQIGNhbiBiZQ0KPiA+
ID4gc2Nhbm5lZCBieSBvdGhlciBkZXZpY2VzLg0KPiA+ID4gRG9lcyA4ODIxQUUgaGF2ZSBoYXJk
d2FyZSBjYXBhYmlsaXR5IHRvIHN1cHBvcnQgNUcgQVA/DQoNClllcywgaXQgaGFzIGhhcmR3YXJl
IGNhcGFiaWxpdHkgb2YgNUcgQVAuDQoNCkkgd2FudCB0byBtYWtlIHN1cmUgd2hpY2ggY2hpcCB5
b3UgdXNlLiA4ODIxQUUgd2l0aCBydGx3aWZpLCBvciA4ODIxQ0Ugd2l0aA0KcnR3ODg/DQoNCi0t
LQ0KUGluZy1LZQ0KDQo=
