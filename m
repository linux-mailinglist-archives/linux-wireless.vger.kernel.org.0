Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C668752E3F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jul 2023 02:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjGNAUm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jul 2023 20:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjGNAUm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jul 2023 20:20:42 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5EA82D50
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 17:20:40 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36E0KTH20014095, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36E0KTH20014095
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 14 Jul 2023 08:20:29 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 14 Jul 2023 08:20:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 14 Jul 2023 08:20:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 14 Jul 2023 08:20:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH RFC] wifi: rtl8xxxu: Fix the TX power of RTL8192CU, RTL8723AU
Thread-Topic: [PATCH RFC] wifi: rtl8xxxu: Fix the TX power of RTL8192CU,
 RTL8723AU
Thread-Index: AQHZspSGOtt7g+TK3EqOf7swN4bu+K+yN0+AgAU7GQCAAPom4A==
Date:   Fri, 14 Jul 2023 00:20:35 +0000
Message-ID: <46e638c9a44841b28cf11e10d95111ec@realtek.com>
References: <52c28b65-6f28-2cc0-7281-179bb1087c2a@gmail.com>
 <509e09b7bfa445fb81f4e3dc3a83dd65@realtek.com>
 <6894e812-975b-cb00-3ff9-4c6796158980@gmail.com>
In-Reply-To: <6894e812-975b-cb00-3ff9-4c6796158980@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSAxNCwgMjAy
MyAxOjI0IEFNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47IGxpbnV4
LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogSmVzIFNvcmVuc2VuIDxKZXMuU29yZW5z
ZW5AZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJGQ10gd2lmaTogcnRsOHh4eHU6
IEZpeCB0aGUgVFggcG93ZXIgb2YgUlRMODE5MkNVLCBSVEw4NzIzQVUNCj4gDQo+IE9uIDEwLzA3
LzIwMjMgMDQ6NDIsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFj
ZXJmZTJAZ21haWwuY29tPg0KPiA+PiBTZW50OiBNb25kYXksIEp1bHkgMTAsIDIwMjMgMjozOCBB
TQ0KPiA+PiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+ID4+IENjOiBKZXMg
U29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWggPHBrc2hpaEBy
ZWFsdGVrLmNvbT4NCj4gPj4gU3ViamVjdDogW1BBVENIIFJGQ10gd2lmaTogcnRsOHh4eHU6IEZp
eCB0aGUgVFggcG93ZXIgb2YgUlRMODE5MkNVLCBSVEw4NzIzQVUNCj4gPj4NCj4gPj4gICAgICAg
ICBmb3IgKGkgPSAwOyBpIDwgMzsgaSsrKSB7DQo+ID4+ICAgICAgICAgICAgICAgICBpZiAoaSAh
PSAyKQ0KPiA+PiAtICAgICAgICAgICAgICAgICAgICAgICB2YWw4ID0gKG1jc2Jhc2VbMF0gPiA4
KSA/IChtY3NiYXNlWzBdIC0gOCkgOiAwOw0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICB2
YWw4ID0gKHZhbDggPiA4KSA/ICh2YWw4IC0gOCkgOiAwOw0KPiA+PiAgICAgICAgICAgICAgICAg
ZWxzZQ0KPiA+PiAtICAgICAgICAgICAgICAgICAgICAgICB2YWw4ID0gKG1jc2Jhc2VbMF0gPiA2
KSA/IChtY3NiYXNlWzBdIC0gNikgOiAwOw0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICB2
YWw4ID0gKHZhbDggPiA2KSA/ICh2YWw4IC0gNikgOiAwOw0KPiA+DQo+ID4gV291bGQgeW91IGxp
a2UgdmFsOCA9IG1pbl90KGludCwgdmFsOCAtIDYsIDApOyA/DQo+ID4NCj4gPiBFdmVuLCBtZXJn
ZSB0d28gYnJhbmNoZXMgaW50byBvbmUuDQo+ID4gICBiYXNlID0gaSAhPSAyID8gOCA6IDY7DQo+
ID4gICB2YWw4ID0gbWluX3QoaW50LCB2YWw4IC0gYmFzZSwgMCk7DQo+ID4NCj4gPiBbLi4uXQ0K
PiA+DQo+IA0KPiBJIHRoaW5rIG1heF90LCBidXQgb3RoZXJ3aXNlIHllcywgdGhhdCBsb29rcyBn
b29kLg0KPiANCg0KT29wcy4gWW91IGFyZSByaWdodC4gU29ycnkgZm9yIHRoZSBtaXN0YWtlcy4N
Cg0KDQoNCg==
