Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF1C701493
	for <lists+linux-wireless@lfdr.de>; Sat, 13 May 2023 08:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjEMGN0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 May 2023 02:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMGNZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 May 2023 02:13:25 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF97F1987
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 23:13:24 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34D6DC5w8029823, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34D6DC5w8029823
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 13 May 2023 14:13:12 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 13 May 2023 14:13:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 13 May 2023 14:13:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Sat, 13 May 2023 14:13:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC:     "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH v3 1/2] wifi: rtl8xxxu: Support new chip RTL8192FU
Thread-Topic: [PATCH v3 1/2] wifi: rtl8xxxu: Support new chip RTL8192FU
Thread-Index: AQHZhPRIWxnMPupUf0aw0RcUAAXWra9XM/QA
Date:   Sat, 13 May 2023 06:13:19 +0000
Message-ID: <094340810bbcbb7d85dd9c9c06b48d3a19aadd85.camel@realtek.com>
References: <98eff876-bb91-f51a-ffe9-b37d27518f9d@gmail.com>
In-Reply-To: <98eff876-bb91-f51a-ffe9-b37d27518f9d@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.17.85]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <70F4AD6CDA7F9C49983E8E5BB7EABBA1@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTEyIGF0IDIwOjA3ICswMzAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiBFeHRlcm5hbCBtYWlsLg0KPiANCj4gDQo+IA0KPiBUaGlzIGlzIGEgbmV3ZXIgY2hpcCwg
c2ltaWxhciB0byB0aGUgUlRMODcxMEJVIGluIHRoYXQgaXQgdXNlcyB0aGUgc2FtZQ0KPiBQSFkg
c3RhdHVzIHN0cnVjdHMuDQo+IA0KPiBGZWF0dXJlczogMi40IEdIeiwgYi9nL24gbW9kZSwgMlQy
UiwgMzAwIE1icHMuDQo+IA0KPiBJdCBjYW4gYWxsZWdlZGx5IGhhdmUgQmx1ZXRvb3RoLCBidXQg
dGhhdCdzIG5vdCBpbXBsZW1lbnRlZCBoZXJlLg0KPiANCj4gVGhpcyBjaGlwIGNhbiBoYXZlIG1h
bnkgUkZFIChSRiBmcm9udCBlbmQpIHR5cGVzLCBvZiB3aGljaCB0eXBlcyAxDQo+IGFuZCA1IGFy
ZSB0aGUgb25seSBvbmVzIHRlc3RlZC4gTWFueSBvZiB0aGUgb3RoZXIgdHlwZXMgbmVlZCBkaWZm
ZXJlbnQNCj4gaW5pdGlhbGlzYXRpb24gdGFibGVzLiBUaGV5IGNhbiBiZSBhZGRlZCBpZiBzb21l
b25lIHdhbnRzIHRoZW0uDQo+IA0KPiBUaGUgdmVuZG9yIGRyaXZlciB2NS44LjYuMl8zNTUzOC4y
MDE5MTAyOF9DT0VYMjAxOTA5MTAtMGQwMiBmcm9tDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9Ccmln
aHRYL3J0bDgxOTJmdSB3YXMgdXNlZCBhcyByZWZlcmVuY2UsIHdpdGgNCj4gYWRkaXRpb25hbCBk
ZXZpY2UgSURzIHRha2VuIGZyb20NCj4gaHR0cHM6Ly9naXRodWIuY29tL2tlbGViZWszMzMvcnRs
ODE5MmZ1LWRrbXMuDQo+IA0KPiBUaGUgdmVuZG9yIGRyaXZlciBhbHNvIGNsYWltcyB0byBzdXBw
b3J0IGRldmljZXMgd2l0aCBJRCAwYmRhOmE3MjUsDQo+IGJ1dCB0aGF0IGlzIGZvdW5kIGluIHNv
bWUgYmx1ZXRvb3RoLW9ubHkgZGV2aWNlcywgc28gaXQncyBub3Qgc3VwcG9ydGVkDQo+IGhlcmUu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdt
YWlsLmNvbT4NCj4gLS0tDQo+IHYzOg0KPiAgLSBSZWJhc2Ugb24gdG9wIG9mIHdpcmVsZXNzLW5l
eHQuDQo+ICAtIE1hcmsgZGV2aWNlIDBiMDU6MThiMSBhbmQgUkZFIHR5cGUgMSAoQVNVUyBVU0It
TjEzIEMxKSBhcyB0ZXN0ZWQuDQo+IA0KPiB2MjoNCj4gIC0gRmVlZGJhY2sgZnJvbSBQaW5nLUtl
IFNoaWg6DQo+ICAgIC0gQWRkIHJ0bDh4eHh1XzgxOTJmLm8gdG8gTWFrZWZpbGUuDQo+ICAgIC0g
SW5pdGlhbGlzZSB2YXJpYWJsZSBjaGFubmVsX2lkeCBpbiBydGw4MTkyZnVfY29uZmlnX2tmcmVl
KCkgYW5kDQo+ICAgICAgdmFyaWFibGUgbGVkY2ZnIGluIHJ0bDgxOTJmdV9sZWRfYnJpZ2h0bmVz
c19zZXQoKSB0byBhdm9pZA0KPiAgICAgIHdhcm5pbmdzLg0KPiAgICAtIEdpdmUgbmFtZXMgdG8g
YSBsb3Qgb2YgcmVnaXN0ZXJzLg0KPiAgICAtIEluaXRpYWxpc2UgYmJfZ2Fpbl9mb3JfcGF0aCBp
biBydGw4MTkyZnVfY29uZmlnX2tmcmVlKCkgaW4gdHdvDQo+ICAgICAgc3RlcHMuDQo+ICAgIC0g
RG9uJ3QgYXNzaWduIHRoZSByZXR1cm4gdmFsdWUgb2YgcnRsOHh4eHVfd3JpdGUzMl9tYXNrKCkg
dG8NCj4gICAgICB2YXJpYWJsZSB2YWwzMiBpbiBydGw4eHh4dV9maWxsX2lxa19tYXRyaXhfYigp
Lg0KPiAgLSBBZGQgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCBkZXZpY2UgSURzIHRvIHRoZSBjb21t
aXQgbWVzc2FnZS4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4
eHh1L0tjb25maWcgfCAgICAzICstDQo+ICAuLi4vbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4
eHUvTWFrZWZpbGUgICAgfCAgICAyICstDQo+ICAuLi4vbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRs
OHh4eHUvcnRsOHh4eHUuaCAgfCAgIDQ3ICsNCj4gIC4uLi9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4
eHh1XzgxODhmLmMgICAgICAgICB8ICAgIDMgKy0NCj4gIC4uLi9yZWFsdGVrL3J0bDh4eHh1L3J0
bDh4eHh1XzgxOTJmLmMgICAgICAgICB8IDIwOTAgKysrKysrKysrKysrKysrKysNCj4gIC4uLi9y
ZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1Xzg3MTBiLmMgICAgICAgICB8ICAgIDEgKw0KPiAgLi4u
L3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODcyM2IuYyAgICAgICAgIHwgICAgMSArDQo+ICAu
Li4vd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMgfCAgMTA3ICstDQo+
ICAuLi4vd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9yZWdzLmggfCAgIDM5ICsN
Cj4gIDkgZmlsZXMgY2hhbmdlZCwgMjI2MiBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkN
Cj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4
eHh1L3J0bDh4eHh1XzgxOTJmLmMNCj4gDQo+IA0KDQpbLi4uXQ0KDQo+IEBAIC03NDg0LDYgKzc1
MjIsOSBAQCBzdGF0aWMgaW50IHJ0bDh4eHh1X3Byb2JlKHN0cnVjdCB1c2JfaW50ZXJmYWNlICpp
bnRlcmZhY2UsDQo+ICAgICAgICAgICAgICAgICBpZiAoaWQtPmlkUHJvZHVjdCA9PSAweDAxMDkp
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHVudGVzdGVkID0gMDsNCj4gICAgICAgICAgICAg
ICAgIGJyZWFrOw0KPiArICAgICAgIGNhc2UgMHgwYjA1Og0KPiArICAgICAgICAgICAgICAgaWYg
KGlkLT5pZFByb2R1Y3QgPT0gMHgxOGYxKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICB1bnRl
c3RlZCA9IDA7DQoNCidicmVhazsnIGlzIG1pc3NpbmcuIA0KDQo+ICAgICAgICAgZGVmYXVsdDoN
Cj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgIH0NCj4gDQoNClsuLi5dDQoNCg==
