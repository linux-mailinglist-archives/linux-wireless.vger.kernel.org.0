Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55826F292A
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Apr 2023 16:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjD3OQI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Apr 2023 10:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3OQG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Apr 2023 10:16:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414CC171E
        for <linux-wireless@vger.kernel.org>; Sun, 30 Apr 2023 07:16:02 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33UEFsdR6008080, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33UEFsdR6008080
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sun, 30 Apr 2023 22:15:54 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sun, 30 Apr 2023 22:15:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sun, 30 Apr 2023 22:15:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Sun, 30 Apr 2023 22:15:57 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC:     "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: Support new chip RTL8192FU
Thread-Topic: [PATCH] wifi: rtl8xxxu: Support new chip RTL8192FU
Thread-Index: AQHZd5tasrPlKIiNeUKI8XDI8zOKla9ACi8AgAM+XoCAAA+ggIAADvqA
Date:   Sun, 30 Apr 2023 14:15:57 +0000
Message-ID: <f8e71db2583ac2b9c7bf9862dd0bf07242757c5b.camel@realtek.com>
References: <90102fa5-5065-9598-d21f-3624629a0cb5@gmail.com>
         <867b2c35f606434bb82ecc17d0fd9336@realtek.com>
         <c36acc8f-5dca-ce60-043d-8da4d16a461b@gmail.com>
         <b6c6b5fa-00a3-b2a7-0c7d-a98b0b3c11e8@gmail.com>
In-Reply-To: <b6c6b5fa-00a3-b2a7-0c7d-a98b0b3c11e8@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.67.98]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <D259EDAD84D99247BAD73B859D4DE298@realtek.com>
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

T24gU3VuLCAyMDIzLTA0LTMwIGF0IDE2OjIyICswMzAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gT24gMzAvMDQvMjAyMyAxNToyNiwgQml0dGVyYmx1ZSBTbWl0aCB3cm90ZToNCj4g
PiBPbiAyOC8wNC8yMDIzIDA5OjIxLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gPiANCj4gPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gRnJvbTogQml0dGVyYmx1ZSBT
bWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+ID4gPiA+IFNlbnQ6IFdlZG5lc2RheSwg
QXByaWwgMjYsIDIwMjMgMToyOCBBTQ0KPiA+ID4gPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5r
ZXJuZWwub3JnDQo+ID4gPiA+IENjOiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5j
b20+OyBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gPiA+ID4gU3ViamVjdDog
W1BBVENIXSB3aWZpOiBydGw4eHh4dTogU3VwcG9ydCBuZXcgY2hpcCBSVEw4MTkyRlUNCj4gPiA+
ID4gDQo+ID4gPiA+IFRoaXMgaXMgYSBuZXdlciBjaGlwLCBzaW1pbGFyIHRvIHRoZSBSVEw4NzEw
QlUgaW4gdGhhdCBpdCB1c2VzIHRoZSBzYW1lDQo+ID4gPiA+IFBIWSBzdGF0dXMgc3RydWN0cy4N
Cj4gPiA+ID4gDQo+ID4gPiA+IEZlYXR1cmVzOiAyLjQgR0h6LCBiL2cvbiBtb2RlLCAyVDJSLCAz
MDAgTWJwcy4NCj4gPiA+ID4gDQo+ID4gPiA+IEl0IGNhbiBhbGxlZ2VkbHkgaGF2ZSBCbHVldG9v
dGgsIGJ1dCB0aGF0J3Mgbm90IGltcGxlbWVudGVkIGhlcmUuDQo+ID4gPiA+IA0KPiA+ID4gPiBU
aGlzIGNoaXAgY2FuIGhhdmUgbWFueSBSRkUgKFJGIGZyb250IGVuZCkgdHlwZXMsIG9mIHdoaWNo
IHR5cGUgNSBpcw0KPiA+ID4gPiB0aGUgb25seSBvbmUgdGVzdGVkLiBNYW55IG9mIHRoZSBvdGhl
ciB0eXBlcyBuZWVkIGRpZmZlcmVudA0KPiA+ID4gPiBpbml0aWFsaXNhdGlvbiB0YWJsZXMuIFRo
ZXkgY2FuIGJlIGFkZGVkIGlmIHNvbWVvbmUgd2FudHMgdGhlbS4NCj4gPiA+ID4gDQo+ID4gPiA+
IFRoZSB2ZW5kb3IgZHJpdmVyIHY1LjguNi4yXzM1NTM4LjIwMTkxMDI4X0NPRVgyMDE5MDkxMC0w
ZDAyIGZyb20NCj4gPiA+ID4gaHR0cHM6Ly9naXRodWIuY29tL0JyaWdodFgvcnRsODE5MmZ1IHdh
cyB1c2VkIGFzIHJlZmVyZW5jZS4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEJp
dHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiA+ID4gPiAtLS0NCj4g
PiA+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvS2NvbmZpZyB8ICAg
IDMgKy0NCj4gPiA+ID4gIC4uLi9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4
dS5oICB8ICAgNDcgKw0KPiA+ID4gPiAgLi4uL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODE4
OGYuYyAgICAgICAgIHwgICAgMyArLQ0KPiA+ID4gPiAgLi4uL3JlYWx0ZWsvcnRsOHh4eHUvcnRs
OHh4eHVfODE5MmYuYyAgICAgICAgIHwgMjA4MSArKysrKysrKysrKysrKysrKw0KPiA+ID4gPiAg
Li4uL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODcxMGIuYyAgICAgICAgIHwgICAgMSArDQo+
ID4gPiA+ICAuLi4vcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV84NzIzYi5jICAgICAgICAgfCAg
ICAxICsNCj4gPiA+ID4gIC4uLi93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2Nv
cmUuYyB8ICAxMDQgKy0NCj4gPiA+ID4gIC4uLi93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0
bDh4eHh1X3JlZ3MuaCB8ICAgMTUgKw0KPiA+ID4gPiAgOCBmaWxlcyBjaGFuZ2VkLCAyMjI1IGlu
c2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODE5MmYuYw0K
PiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gWy4uLl0NCj4gPiA+IA0KPiA+ID4gPiArc3RhdGljIHZv
aWQgcnRsODE5MmZ1X2NvbmZpZ19rZnJlZShzdHJ1Y3QgcnRsOHh4eHVfcHJpdiAqcHJpdiwgdTgg
Y2hhbm5lbCkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKyAgICAgICB1OCBiYl9nYWluWzNdID0geyBF
RlVTRV9VTkRFRklORUQsIEVGVVNFX1VOREVGSU5FRCwgRUZVU0VfVU5ERUZJTkVEIH07DQo+ID4g
PiA+ICsgICAgICAgdTggYmJfZ2Fpbl9wYXRoX21hc2tbMl0gPSB7IDB4MGYsIDB4ZjAgfTsNCj4g
PiA+ID4gKyAgICAgICBlbnVtIHJ0bDh4eHh1X3JmcGF0aCByZnBhdGg7DQo+ID4gPiA+ICsgICAg
ICAgdTggYmJfZ2Fpbl9mb3JfcGF0aDsNCj4gPiA+ID4gKyAgICAgICB1OCBjaGFubmVsX2lkeDsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGlmIChjaGFubmVsID49IDEgJiYgY2hhbm5lbCA8
PSAzKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgY2hhbm5lbF9pZHggPSAwOw0KPiA+ID4gPiAr
ICAgICAgIGlmIChjaGFubmVsID49IDQgJiYgY2hhbm5lbCA8PSA5KQ0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgY2hhbm5lbF9pZHggPSAxOw0KPiA+ID4gPiArICAgICAgIGlmIChjaGFubmVsID49
IDEwICYmIGNoYW5uZWwgPD0gMTQpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICBjaGFubmVsX2lk
eCA9IDI7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBydGw4eHh4dV9yZWFkX2VmdXNlOChw
cml2LCAweDFlZSwgJmJiX2dhaW5bMV0pOw0KPiA+ID4gPiArICAgICAgIHJ0bDh4eHh1X3JlYWRf
ZWZ1c2U4KHByaXYsIDB4MWVjLCAmYmJfZ2FpblswXSk7DQo+ID4gPiA+ICsgICAgICAgcnRsOHh4
eHVfcmVhZF9lZnVzZTgocHJpdiwgMHgxZWEsICZiYl9nYWluWzJdKTsNCj4gPiA+IA0KPiA+ID4g
Q2FuIHlvdSBkZWZpbmUgdGhlc2UgZmllbGRzIGluIHN0cnVjdCBydGw4MTkyZnVfZWZ1c2UsIGFu
ZCBhY2Nlc3MgdmlhDQo+ID4gPiB0aGUgc3RydWN0Pw0KPiA+ID4gDQo+ID4gPiANCj4gPiA+ID4g
Kw0KPiA+ID4gPiArICAgICAgIGlmIChiYl9nYWluWzFdID09IEVGVVNFX1VOREVGSU5FRCkNCj4g
PiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAg
IGlmIChiYl9nYWluWzBdID09IEVGVVNFX1VOREVGSU5FRCkNCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgIGJiX2dhaW5bMF0gPSBiYl9nYWluWzFdOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAg
aWYgKGJiX2dhaW5bMl0gPT0gRUZVU0VfVU5ERUZJTkVEKQ0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgYmJfZ2FpblsyXSA9IGJiX2dhaW5bMV07DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBm
b3IgKHJmcGF0aCA9IFJGX0E7IHJmcGF0aCA8IHByaXYtPnJmX3BhdGhzOyByZnBhdGgrKykgew0K
PiA+ID4gPiArICAgICAgICAgICAgICAgLyogcG93ZXJfdHJpbSBiYXNlZCBvbiA1NVsxOToxNF0g
Ki8NCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHJ0bDh4eHh1X3dyaXRlX3JmcmVnX21hc2socHJp
diwgcmZwYXRoLCBSRjYwNTJfUkVHX1VOS05PV05fNTUsDQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJVCg1KSwgMSk7DQo+ID4gPiA+ICsNCj4gPiA+
ID4gKyAgICAgICAgICAgICAgIC8qIGVuYWJsZSA1NVsxNF0gZm9yIDAuNWRiIHN0ZXAgKi8NCj4g
PiA+ID4gKyAgICAgICAgICAgICAgIHJ0bDh4eHh1X3dyaXRlX3JmcmVnX21hc2socHJpdiwgcmZw
YXRoLCAweGY1LCBCSVQoMTgpLCAxKTsNCj4gPiA+IA0KPiA+ID4gI2RlZmluZSBSRjYwNTJfUkVH
X0dBSU5fQ1RSTCAweDU1DQo+ID4gPiANCj4gPiANCj4gPiBKdXN0IHRvIGJlIHN1cmUsIHRoaXMg
aXMgdGhlIG5hbWUgZm9yIDB4NTUgb3IgMHhmNSA/DQoNCjB4ZjUuIFBsZWFzZSBmaXggaXQuDQoN
Cj4gDQo+IEFsc28sDQo+IA0KPiAjZGVmaW5lIFJFR19SRkVfT1BUNjIgICAgICAgICAgICAgICAg
ICAgMHgwOTY4DQo+IA0KPiBJcyBpdCA2MiBvciBqdXN0IDIgPw0KPiANCg0KNjIuIEJlY2F1c2Ug
MHgwOTY4WzBdIGlzIFJGRV9PUFRbNjJdLg0KDQoNCg==
