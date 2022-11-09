Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555D96220F4
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 01:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiKIAtG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 19:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiKIAtE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 19:49:04 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C146C3C6E9
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 16:49:03 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2A90mMsU5017383, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2A90mMsU5017383
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 9 Nov 2022 08:48:22 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Wed, 9 Nov 2022 08:49:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 9 Nov 2022 08:49:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Wed, 9 Nov 2022 08:48:59 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 3/3] wifi: rtl8xxxu: Use u32_get_bits in *_identify_chip
Thread-Topic: [PATCH 3/3] wifi: rtl8xxxu: Use u32_get_bits in *_identify_chip
Thread-Index: AQHY86QQhtVF0w5ZxkWEI8KJ4OJ6ua41wafw
Date:   Wed, 9 Nov 2022 00:48:59 +0000
Message-ID: <49301acbd2264605ae316d61a3a775a4@realtek.com>
References: <91f59414-86f7-f0ed-a138-19f0ab63bb0b@gmail.com>
 <0b053ab0-0760-485f-47df-1ab1705a011c@gmail.com>
In-Reply-To: <0b053ab0-0760-485f-47df-1ab1705a011c@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzgg5LiL5Y2IIDEwOjI4OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJpdHRlcmJsdWUgU21pdGgg
PHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDks
IDIwMjIgMjo1OCBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDMvM10gd2lmaTogcnRsOHh4eHU6
IFVzZSB1MzJfZ2V0X2JpdHMgaW4gKl9pZGVudGlmeV9jaGlwDQo+IA0KPiBJdCBzaW1wbGlmaWVz
IHRoZSBjb2RlIGEgYml0Lg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hp
aEByZWFsdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgy
MWNlcmZlMkBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEBy
ZWFsdGVrLmNvbT4NCg0KPiAtLS0NCj4gVGhpcyBwYXRjaCBzaG91bGQgYmUgYXBwbGllZCBhZnRl
ciBteSBvbGRlciBwYXRjaDoNCj4gIltQQVRDSCB2MiAyLzNdIHdpZmk6IHJ0bDh4eHh1OiBTcGxp
dCB1cCBydGw4eHh4dV9pZGVudGlmeV9jaGlwIg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODE4OGYuYyB8IDMgKy0tDQo+ICBkcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxOTJjLmMgfCA1ICsrLS0t
DQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxOTJl
LmMgfCA1ICsrLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0
bDh4eHh1Xzg3MjNhLmMgfCA1ICsrLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0bDh4eHh1L3J0bDh4eHh1Xzg3MjNiLmMgfCA1ICsrLS0tDQo+ICBkcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X3JlZ3MuaCAgfCAxIC0NCj4gIDYgZmlsZXMg
Y2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxODhm
LmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1Xzgx
ODhmLmMNCj4gaW5kZXggZWYzODg5MWRkYmQxLi4yYzRmNDAzYmE2OGYgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODE4OGYuYw0K
PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1Xzgx
ODhmLmMNCj4gQEAgLTMzNSw4ICszMzUsNyBAQCBzdGF0aWMgaW50IHJ0bDgxODhmdV9pZGVudGlm
eV9jaGlwKHN0cnVjdCBydGw4eHh4dV9wcml2ICpwcml2KQ0KPiAgCXByaXYtPmhhc193aWZpID0g
MTsNCj4gDQo+ICAJc3lzX2NmZyA9IHJ0bDh4eHh1X3JlYWQzMihwcml2LCBSRUdfU1lTX0NGRyk7
DQo+IC0JcHJpdi0+Y2hpcF9jdXQgPSAoc3lzX2NmZyAmIFNZU19DRkdfQ0hJUF9WRVJTSU9OX01B
U0spID4+DQo+IC0JCVNZU19DRkdfQ0hJUF9WRVJTSU9OX1NISUZUOw0KPiArCXByaXYtPmNoaXBf
Y3V0ID0gdTMyX2dldF9iaXRzKHN5c19jZmcsIFNZU19DRkdfQ0hJUF9WRVJTSU9OX01BU0spOw0K
DQpHb29kIHRvIHVzZSB1MzJfZ2V0X2JpdHMoKSBpbnN0ZWFkIG9mIEZJRUxEX0dFVCgpLg0KSSBn
dWVzcyB5b3Ugc2VlIEthbGxlIHJlbWluZGVkIG1lIHRvIHVzZSB1MzJfZW5jb2RlX2JpdHMoKSwg
YnV0IEkgZm9yZ2V0IHRvDQpmb3J3YXJkIHRoaXMgbWVzc2FnZSB0byB5b3UuIEFueXdheSwgdGhh
bmtzIGZvciB5b3VyIHdvcmtzLg0KDQpbLi4uXQ0KDQo=
