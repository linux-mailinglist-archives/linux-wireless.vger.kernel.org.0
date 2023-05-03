Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E46D6F4E93
	for <lists+linux-wireless@lfdr.de>; Wed,  3 May 2023 03:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjECB32 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 May 2023 21:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECB31 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 May 2023 21:29:27 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0791BCA
        for <linux-wireless@vger.kernel.org>; Tue,  2 May 2023 18:29:25 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3431TGOO0015610, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3431TGOO0015610
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 3 May 2023 09:29:16 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 3 May 2023 09:29:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 3 May 2023 09:29:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 3 May 2023 09:29:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2 1/2] wifi: rtl8xxxu: Support new chip RTL8192FU
Thread-Topic: [PATCH v2 1/2] wifi: rtl8xxxu: Support new chip RTL8192FU
Thread-Index: AQHZfSVkj63eGOceWUe9esYNeBcvrq9HwKog
Date:   Wed, 3 May 2023 01:29:20 +0000
Message-ID: <4dcbedfc00ed429489872b5d1e6de5b9@realtek.com>
References: <c43d971c-21bf-6714-d852-c76e515438b0@gmail.com>
In-Reply-To: <c43d971c-21bf-6714-d852-c76e515438b0@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDMsIDIw
MjMgMjozOSBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBK
ZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWggPHBrc2hp
aEByZWFsdGVrLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYyIDEvMl0gd2lmaTogcnRsOHh4eHU6
IFN1cHBvcnQgbmV3IGNoaXAgUlRMODE5MkZVDQo+IA0KPiBUaGlzIGlzIGEgbmV3ZXIgY2hpcCwg
c2ltaWxhciB0byB0aGUgUlRMODcxMEJVIGluIHRoYXQgaXQgdXNlcyB0aGUgc2FtZQ0KPiBQSFkg
c3RhdHVzIHN0cnVjdHMuDQo+IA0KPiBGZWF0dXJlczogMi40IEdIeiwgYi9nL24gbW9kZSwgMlQy
UiwgMzAwIE1icHMuDQo+IA0KPiBJdCBjYW4gYWxsZWdlZGx5IGhhdmUgQmx1ZXRvb3RoLCBidXQg
dGhhdCdzIG5vdCBpbXBsZW1lbnRlZCBoZXJlLg0KPiANCj4gVGhpcyBjaGlwIGNhbiBoYXZlIG1h
bnkgUkZFIChSRiBmcm9udCBlbmQpIHR5cGVzLCBvZiB3aGljaCB0eXBlIDUgaXMNCj4gdGhlIG9u
bHkgb25lIHRlc3RlZC4gTWFueSBvZiB0aGUgb3RoZXIgdHlwZXMgbmVlZCBkaWZmZXJlbnQNCj4g
aW5pdGlhbGlzYXRpb24gdGFibGVzLiBUaGV5IGNhbiBiZSBhZGRlZCBpZiBzb21lb25lIHdhbnRz
IHRoZW0uDQo+IA0KPiBUaGUgdmVuZG9yIGRyaXZlciB2NS44LjYuMl8zNTUzOC4yMDE5MTAyOF9D
T0VYMjAxOTA5MTAtMGQwMiBmcm9tDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9CcmlnaHRYL3J0bDgx
OTJmdSB3YXMgdXNlZCBhcyByZWZlcmVuY2UsIHdpdGgNCj4gYWRkaXRpb25hbCBkZXZpY2UgSURz
IHRha2VuIGZyb20NCj4gaHR0cHM6Ly9naXRodWIuY29tL2tlbGViZWszMzMvcnRsODE5MmZ1LWRr
bXMuDQo+IA0KPiBUaGUgdmVuZG9yIGRyaXZlciBhbHNvIGNsYWltcyB0byBzdXBwb3J0IGRldmlj
ZXMgd2l0aCBJRCAwYmRhOmE3MjUsDQo+IGJ1dCB0aGF0IGlzIGZvdW5kIGluIHNvbWUgYmx1ZXRv
b3RoLW9ubHkgZGV2aWNlcywgc28gaXQncyBub3Qgc3VwcG9ydGVkDQo+IGhlcmUuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo+IC0t
LQ0KPiB2MjoNCj4gIC0gRmVlZGJhY2sgZnJvbSBQaW5nLUtlIFNoaWg6DQo+ICAgIC0gQWRkIHJ0
bDh4eHh1XzgxOTJmLm8gdG8gTWFrZWZpbGUuDQo+ICAgIC0gSW5pdGlhbGlzZSB2YXJpYWJsZSBj
aGFubmVsX2lkeCBpbiBydGw4MTkyZnVfY29uZmlnX2tmcmVlKCkgYW5kDQo+ICAgICAgdmFyaWFi
bGUgbGVkY2ZnIGluIHJ0bDgxOTJmdV9sZWRfYnJpZ2h0bmVzc19zZXQoKSB0byBhdm9pZA0KPiAg
ICAgIHdhcm5pbmdzLg0KPiAgICAtIEdpdmUgbmFtZXMgdG8gYSBsb3Qgb2YgcmVnaXN0ZXJzLg0K
PiAgICAtIEluaXRpYWxpc2UgYmJfZ2Fpbl9mb3JfcGF0aCBpbiBydGw4MTkyZnVfY29uZmlnX2tm
cmVlKCkgaW4gdHdvDQo+ICAgICAgc3RlcHMuDQo+ICAgIC0gRG9uJ3QgYXNzaWduIHRoZSByZXR1
cm4gdmFsdWUgb2YgcnRsOHh4eHVfd3JpdGUzMl9tYXNrKCkgdG8NCj4gICAgICB2YXJpYWJsZSB2
YWwzMiBpbiBydGw4eHh4dV9maWxsX2lxa19tYXRyaXhfYigpLg0KPiAgLSBBZGQgbW9yZSBpbmZv
cm1hdGlvbiBhYm91dCBkZXZpY2UgSURzIHRvIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gLS0tDQo+
ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L0tjb25maWcgfCAgICAzICst
DQo+ICAuLi4vbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvTWFrZWZpbGUgICAgfCAgICAy
ICstDQo+ICAuLi4vbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHUuaCAgfCAg
IDQ3ICsNCj4gIC4uLi9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxODhmLmMgICAgICAgICB8
ICAgIDMgKy0NCj4gIC4uLi9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxOTJmLmMgICAgICAg
ICB8IDIwOTAgKysrKysrKysrKysrKysrKysNCj4gIC4uLi9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4
eHh1Xzg3MTBiLmMgICAgICAgICB8ICAgIDEgKw0KPiAgLi4uL3JlYWx0ZWsvcnRsOHh4eHUvcnRs
OHh4eHVfODcyM2IuYyAgICAgICAgIHwgICAgMSArDQo+ICAuLi4vd2lyZWxlc3MvcmVhbHRlay9y
dGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMgfCAgMTA0ICstDQo+ICAuLi4vd2lyZWxlc3MvcmVhbHRl
ay9ydGw4eHh4dS9ydGw4eHh4dV9yZWdzLmggfCAgIDM5ICsNCj4gIDkgZmlsZXMgY2hhbmdlZCwg
MjI1OSBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxOTJmLmMN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1
L0tjb25maWcNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L0tjb25m
aWcNCj4gaW5kZXggODJiY2FmNDRhNjVmLi40NGFkOTQ3NTdhMDMgMTAwNjQ0DQoNClsuLi5dDQoN
Cg==
