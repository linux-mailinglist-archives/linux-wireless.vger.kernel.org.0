Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F7260C258
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 05:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiJYDrE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 23:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJYDrC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 23:47:02 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4638F18E1F
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 20:46:55 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29P3kHllD024662, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29P3kHllD024662
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Oct 2022 11:46:17 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 25 Oct 2022 11:46:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 25 Oct 2022 11:46:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb]) by
 RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb%5]) with mapi id
 15.01.2375.007; Tue, 25 Oct 2022 11:46:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2 2/5] wifi: rtl8xxxu: Fix the CCK RSSI calculation
Thread-Topic: [PATCH v2 2/5] wifi: rtl8xxxu: Fix the CCK RSSI calculation
Thread-Index: AQHY5/ldtY14MVvhyEyBDz2twsUjo64eeFTQ
Date:   Tue, 25 Oct 2022 03:46:50 +0000
Message-ID: <7040619d7d5c4b198b320812093d33f9@realtek.com>
References: <1edda764-94ca-2123-0ba6-6b04a1b01709@gmail.com>
 <25b7381d-178c-d909-015e-1acf7698ec13@gmail.com>
In-Reply-To: <25b7381d-178c-d909-015e-1acf7698ec13@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzI0IOS4i+WNiCAxMTozMTowMA==?=
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjUs
IDIwMjIgNDo1NSBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRD
SCB2MiAyLzVdIHdpZmk6IHJ0bDh4eHh1OiBGaXggdGhlIENDSyBSU1NJIGNhbGN1bGF0aW9uDQo+
IA0KPiBUaGUgQ0NLIFJTU0kgY2FsY3VsYXRpb24gaXMgaW5jb3JyZWN0IGZvciB0aGUgUlRMODcy
M0JVLCBSVEw4MTkyRVUsDQo+IGFuZCBSVEw4MTg4RlUuIEFkZCBuZXcgZnVuY3Rpb25zIGZvciB0
aGVzZSBjaGlwcyB3aXRoIGNvZGUgY29waWVkIGZyb20NCj4gdGhlaXIgdmVuZG9yIGRyaXZlcnMu
IFVzZSB0aGUgb2xkIGNvZGUgb25seSBmb3IgdGhlIFJUTDg3MjNBVSBhbmQNCj4gUlRMODE5MkNV
Lg0KPiANCj4gSSBkaWRuJ3Qgbm90aWNlIGFueSBkaWZmZXJlbmNlIGluIHRoZSByZXBvcnRlZCBz
aWduYWwgc3RyZW5ndGggd2l0aCBteQ0KPiBSVEw4MTg4RlUsIGJ1dCBJIGRpZG4ndCBsb29rIHZl
cnkgaGFyZCBlaXRoZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxy
dGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gLS0tDQo+IHYyOg0KPiAgLSBObyBjaGFuZ2UuDQo+
IC0tLQ0KPiAgLi4uL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1LmggIHwg
IDMgKysNCj4gIC4uLi9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxODhmLmMgICAgICAgICB8
IDMyICsrKysrKysrKysrKysrKysNCj4gIC4uLi9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1Xzgx
OTJjLmMgICAgICAgICB8ICAxICsNCj4gIC4uLi9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1Xzgx
OTJlLmMgICAgICAgICB8IDIzICsrKysrKysrKysrDQo+ICAuLi4vcmVhbHRlay9ydGw4eHh4dS9y
dGw4eHh4dV84NzIzYS5jICAgICAgICAgfCAyMyArKysrKysrKysrKw0KPiAgLi4uL3JlYWx0ZWsv
cnRsOHh4eHUvcnRsOHh4eHVfODcyM2IuYyAgICAgICAgIHwgMjkgKysrKysrKysrKysrKysNCj4g
IC4uLi93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYyB8IDM4ICsrKysr
KysrKysrKy0tLS0tLS0NCj4gIDcgZmlsZXMgY2hhbmdlZCwgMTM1IGluc2VydGlvbnMoKyksIDE0
IGRlbGV0aW9ucygtKQ0KPiANCg0KWy4uLl0NCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBpbmRleCA4NmEz
NDU3ZmQ5NTEuLjcwMjNmNmFjY2RhNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gQEAgLTQzMjUsNiAr
NDMyNSwyOSBAQCBzdGF0aWMgaW50IHJ0bDh4eHh1X2luaXRfZGV2aWNlKHN0cnVjdCBpZWVlODAy
MTFfaHcgKmh3KQ0KPiAgCQl2YWwzMiAmPSAweGZmZjAwZmZmOw0KPiAgCQl2YWwzMiB8PSAweDAw
MDdlMDAwOw0KPiAgCQlydGw4eHh4dV93cml0ZTMyKHByaXYsIFJFR19BRkVfTUlTQywgdmFsMzIp
Ow0KPiArDQo+ICsJCS8qDQo+ICsJCSAqIDB4ODI0WzldID0gMHg4MkNbOV0gPSAweEE4MFs3XSB0
aG9zZSByZWdpc3RlcnMgc2V0dGluZw0KPiArCQkgKiBzaG91bGQgYmUgZXF1YWwgb3IgQ0NLIFJT
U0kgcmVwb3J0IG1heSBiZSBpbmNvcnJlY3QNCj4gKwkJICovDQo+ICsJCXZhbDMyID0gcnRsOHh4
eHVfcmVhZDMyKHByaXYsIFJFR19GUEdBMF9YQV9IU1NJX1BBUk0yKTsNCj4gKwkJcHJpdi0+Y2Nr
X2FnY19yZXBvcnRfdHlwZSA9IHZhbDMyICYgRlBHQTBfSFNTSV9QQVJNMl9DQ0tfSElHSF9QV1I7
DQo+ICsNCj4gKwkJdmFsMzIgPSBydGw4eHh4dV9yZWFkMzIocHJpdiwgUkVHX0ZQR0EwX1hCX0hT
U0lfUEFSTTIpOw0KPiArCQlpZiAocHJpdi0+Y2NrX2FnY19yZXBvcnRfdHlwZSAhPSAoYm9vbCko
dmFsMzIgJiBGUEdBMF9IU1NJX1BBUk0yX0NDS19ISUdIX1BXUikpIHsNCj4gKwkJCWlmIChwcml2
LT5jY2tfYWdjX3JlcG9ydF90eXBlKQ0KPiArCQkJCXZhbDMyIHw9IEZQR0EwX0hTU0lfUEFSTTJf
Q0NLX0hJR0hfUFdSOw0KPiArCQkJZWxzZQ0KPiArCQkJCXZhbDMyICY9IH5GUEdBMF9IU1NJX1BB
Uk0yX0NDS19ISUdIX1BXUjsNCj4gKwkJCXJ0bDh4eHh1X3dyaXRlMzIocHJpdiwgUkVHX0ZQR0Ew
X1hCX0hTU0lfUEFSTTIsIHZhbDMyKTsNCj4gKwkJfQ0KPiArDQo+ICsJCXZhbDMyID0gcnRsOHh4
eHVfcmVhZDMyKHByaXYsIDB4YTgwKTsNCj4gKwkJaWYgKHByaXYtPmNja19hZ2NfcmVwb3J0X3R5
cGUpDQo+ICsJCQl2YWwzMiB8PSBCSVQoNyk7DQo+ICsJCWVsc2UNCj4gKwkJCXZhbDMyICY9IH5C
SVQoNyk7DQoNCldlIGNhbiBnaXZlIGEgbmFtZSB0byAweEE4MFs3XTogDQoNCiNkZWZpbmUgUkVH
X0FHQ19SUFQgMHgwYTgwDQojZGVmaW5lIEFHQ19SVFBfQ0NLIEJJVCg3KQ0KDQoNCg==
