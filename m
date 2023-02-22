Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F76969EC42
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 02:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjBVBQ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Feb 2023 20:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBVBQ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Feb 2023 20:16:27 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E59D298EE
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 17:16:24 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 31M1GGu94004905, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 31M1GGu94004905
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 22 Feb 2023 09:16:16 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 22 Feb 2023 09:16:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 22 Feb 2023 09:16:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Wed, 22 Feb 2023 09:16:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: Support new chip RTL8710BU aka RTL8188GU
Thread-Topic: [PATCH] wifi: rtl8xxxu: Support new chip RTL8710BU aka RTL8188GU
Thread-Index: AQHZRUX7Gjt8lv8a2kuNKiwIiP2NbK7YktzAgACm8QCAAPA7YA==
Date:   Wed, 22 Feb 2023 01:16:20 +0000
Message-ID: <d7e2cb860ca745dbb7b9ec428581af7a@realtek.com>
References: <5a9a264d-a59b-0d91-04f0-e5b38e6aaea0@gmail.com>
 <85c6facc8d0947e38668ed9b5f61bc48@realtek.com>
 <1de98de1-1c54-b6b1-b394-cafe8fa4d5f8@gmail.com>
In-Reply-To: <1de98de1-1c54-b6b1-b394-cafe8fa4d5f8@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkg
MjIsIDIwMjMgMjo1MCBBTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+
OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEplcyBTb3JlbnNlbiA8SmVz
LlNvcmVuc2VuQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gd2lmaTogcnRsOHh4
eHU6IFN1cHBvcnQgbmV3IGNoaXAgUlRMODcxMEJVIGFrYSBSVEw4MTg4R1UNCj4gDQo+IE9uIDIx
LzAyLzIwMjMgMDQ6NDUsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4
MjFjZXJmZTJAZ21haWwuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAyMSwgMjAy
MyAxMjoxMSBBTQ0KPiA+PiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+ID4+
IENjOiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gPj4gU3ViamVjdDogW1BBVENIXSB3aWZpOiBydGw4eHh4
dTogU3VwcG9ydCBuZXcgY2hpcCBSVEw4NzEwQlUgYWthIFJUTDgxODhHVQ0KPiA+Pg0KPiA+PiAr
DQo+ID4+ICsgICAgICAgZG8NCj4gPj4gKyAgICAgICAgICAgICAgIHZhbDMyID0gcnRsOHh4eHVf
cmVhZDMyKHByaXYsIFJFR19FRlVTRV9JTkRJUkVDVF9DVFJMXzg3MTBCKTsNCj4gPj4gKyAgICAg
ICB3aGlsZSAoKHZhbDMyICYgQklUKDMxKSkgJiYgKC0tcG9sbGluZ19jb3VudCA+IDApKTsNCj4g
Pg0KPiA+IFdpdGhvdXQgYSBwYWlyIG9mIGJyYWNlLCB0aGF0IGxvb2tzIGEgbGl0dGxlIG9kZCB0
byBtZSwgYnV0IHRoZSByZXN1bHQgc2hvdWxkDQo+ID4gYmUgY29ycmVjdC4NCj4gPg0KPiBJIHRo
aW5rIHRoZSBydWxlIGlzIHRoYXQgd2Ugc2hvdWxkIG5vdCB1c2UgYnJhY2VzIHdoZW4gdGhlcmUg
aXMgYSBzaW5nbGUNCj4gbGluZSBpbnNpZGUuIEkgYXNzdW1lZCB0aGF0IGFwcGxpZXMgdG8gZG8u
Li53aGlsZSBsb29wcyB0b28uDQoNCkkgZ2l2ZSBpdCBhIHRyeSBhYm91dCB0aGlzLCBhbmQgdGhl
IHJlc3VsdHMgYXJlDQoNCmNoZWNrcGF0Y2ggd2FybnMgJ3doaWxlJzoNCg0KKyAgICAgICB3aGls
ZSAoMSkgew0KKyAgICAgICAgICAgICAgIHggPSAxOw0KKyAgICAgICB9DQoNCg0KQnV0LCBkb24n
dCB3YXJuICdkby4uLndoaWxlJy4gKHlvdXIgY2FzZSkNCg0KKyAgICAgICBkbyB7DQorICAgICAg
ICAgICAgICAgeCA9IDE7DQorICAgICAgIH0gd2hpbGUgKDEpOw0KDQoNCkxvb2tpbmcgaW50byBj
aGVja3BhdGNoLCBJIGZvdW5kIGl0IGNoZWNrcyBzaW5nbGUgc3RhdGVtZW50IHVuZGVyIHRoZXNl
DQpjb25kaXRpb25zICdpZnx3aGlsZXxmb3J8ZWxzZScuDQoNCg0KUGluZy1LZQ0KDQo=
