Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335217125DB
	for <lists+linux-wireless@lfdr.de>; Fri, 26 May 2023 13:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbjEZLqh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 May 2023 07:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbjEZLqg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 May 2023 07:46:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AF2A7
        for <linux-wireless@vger.kernel.org>; Fri, 26 May 2023 04:46:34 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34QBkAMD1003985, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34QBkAMD1003985
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 26 May 2023 19:46:10 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 26 May 2023 19:46:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 26 May 2023 19:46:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 26 May 2023 19:46:21 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5/5] wifi: rtw89: use struct to access register-based H2C/C2H
Thread-Topic: [PATCH 5/5] wifi: rtw89: use struct to access register-based
 H2C/C2H
Thread-Index: AQHZjKk/VL7hv4hb3keNsgPN8Joo/69rLL3hgADDLIA=
Date:   Fri, 26 May 2023 11:46:21 +0000
Message-ID: <709fd6a89f3f4a637410c0974b32154a8a1b89fe.camel@realtek.com>
References: <20230522122513.13559-1-pkshih@realtek.com>
         <20230522122513.13559-6-pkshih@realtek.com> <87cz2ol7i5.fsf@kernel.org>
In-Reply-To: <87cz2ol7i5.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.76.140]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4C31EA651CD4F4E98C38E730C13EE1B@realtek.com>
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

T24gVGh1LCAyMDIzLTA1LTI1IGF0IDE5OjA3ICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAN
Cj4gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyaXRlczoNCj4gDQo+ID4gVGhl
IHJlZ2lzdGVyLWJhc2VkIEgyQy9DMkggYXJlIHVzZWQgdG8gZXhjaGFuZ2UgY29tbWFuZHMgYW5k
IGV2ZW50cyB3aXRoDQo+ID4gZmlybXdhcmUuIFRoZSBleGNoYW5nZSBkYXRhIGlzIGxpbWl0ZWQs
IGJ1dCBpdCBpcyByZWxhdGl2ZWx5IHNpbXBsZSwNCj4gPiBiZWNhdXNlIGl0IGNhbiB3b3JrIGJl
Zm9yZSBIQ0kgaW5pdGlhbGl6YXRpb24uIFRvIG1ha2UgdGhlc2UgY29kZSBjbGVhbiwNCj4gPiB1
c2Ugc3RydWN0IHRvIGFjY2VzcyB0aGVtLiBUaGlzIHBhdGNoIGRvZXNuJ3QgY2hhbmdlIGxvZ2lj
IGF0IGFsbC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEBy
ZWFsdGVrLmNvbT4NCj4gDQo+IFsuLi5dDQo+IA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnR3ODkvZncuaA0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODkvZncuaA0KPiA+IEBAIC0xOCwxNSArMTgsNTEgQEAgZW51bSBydHc4OV9md19k
bF9zdGF0dXMgew0KPiA+ICAgICAgIFJUVzg5X0ZXRExfV0NQVV9GV19JTklUX1JEWSA9IDcNCj4g
PiAgfTsNCj4gPiANCj4gPiAtI2RlZmluZSBSVFc4OV9HRVRfQzJIX0hEUl9GVU5DKGluZm8pIFwN
Cj4gPiAtICAgICB1MzJfZ2V0X2JpdHMoaW5mbywgR0VOTUFTSyg2LCAwKSkNCj4gPiAtI2RlZmlu
ZSBSVFc4OV9HRVRfQzJIX0hEUl9MRU4oaW5mbykgXA0KPiA+IC0gICAgIHUzMl9nZXRfYml0cyhp
bmZvLCBHRU5NQVNLKDExLCA4KSkNCj4gPiArc3RydWN0IHJ0dzg5X2MyaHJlZ19oZHIgew0KPiA+
ICsgICAgIHUzMiB3MDsNCj4gPiArfTsNCj4gDQo+IFdoeSB0aGlzIGlzIHUzMj8gU2hvdWxkbid0
IGl0IGJlIF9fbGUzMj8NCj4gDQo+ID4gKyNkZWZpbmUgUlRXODlfQzJIUkVHX0hEUl9GVU5DX01B
U0sgR0VOTUFTSyg2LCAwKQ0KPiA+ICsjZGVmaW5lIFJUVzg5X0MySFJFR19IRFJfQUNLIEJJVCg3
KQ0KPiA+ICsjZGVmaW5lIFJUVzg5X0MySFJFR19IRFJfTEVOX01BU0sgR0VOTUFTSygxMSwgOCkN
Cj4gPiArI2RlZmluZSBSVFc4OV9DMkhSRUdfSERSX1NFUV9NQVNLIEdFTk1BU0soMTUsIDEyKQ0K
PiA+ICsNCj4gPiArc3RydWN0IHJ0dzg5X2MyaHJlZ19waHljYXAgew0KPiA+ICsgICAgIHUzMiB3
MDsNCj4gPiArICAgICB1MzIgdzE7DQo+ID4gKyAgICAgdTMyIHcyOw0KPiA+ICsgICAgIHUzMiB3
MzsNCj4gPiArfSBfX3BhY2tlZDsNCj4gDQo+IEhlcmUgYXMgd2VsbD8gQW5kIEkgc2F3IG1vcmUg
aW4gdGhlIHBhdGNoLg0KPiANCj4gT2YgY291cnNlIHRoZXNlIHdlcmUgYWxyZWFkeSB0aGVyZSBz
byBpc24ndCBhIHByb2JsZW0gaW50cm9kdWNlZCBieSB0aGlzDQo+IHBhdGNoc2V0LCBidXQgSSBz
dGFydGVkIHdvbmRlcmluZyBpZiB3ZSBhcmUgbWlzc2luZyBzb21lIGxpdHRsZSBlbmRpYW4NCj4g
dHlwZXM/DQo+IA0KDQpJIGhhZCB0aGUgc2FtZSBxdWVzdGlvbiBhcyB5b3VycyB3aGVuIEkgZGlk
IHRoaXMgY29udmVyc2lvbiwgYnV0IHRoZXkNCmFyZSBjb3JyZWN0IGJlY2F1c2Ugd2UgYWNjZXNz
IHRoZXNlIEgyQyBjb21tYW5kcy9DMkggZXZlbnRzIHZpYSByZWdpc3RlcnMNCndoaWNoIGFyZSBD
UFUgb3JkZXIuDQoNCkEgYnVnIEkgZm91bmQgaXMgdGhhdCB1c2Ugc3RydWN0IGJpdC1maWVsZCB0
byBhY2Nlc3MgdGhlc2UgZGF0YS4gVGhpcyANCndpbGwgY2F1c2UgYmlnLWVuZGlhbiBtYWNoaW5l
IHdyb25nLCBhbmQgSSBmaXggdGhlbSBieSB0aGlzIHBhdGNoIGFzIHdlbGwuIA0KDQpJIGhvcGUg
d2UgZG9uJ3QgbWlzcyBzb21ldGhpbmcuIA0KDQpQaW5nLUtlDQoNCg0K
