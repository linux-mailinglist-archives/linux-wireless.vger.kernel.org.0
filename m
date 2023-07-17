Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D188575595C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jul 2023 04:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGQCGB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jul 2023 22:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGQCGA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jul 2023 22:06:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAD75E59
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jul 2023 19:05:57 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36H25bqW6008939, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36H25bqW6008939
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 17 Jul 2023 10:05:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 17 Jul 2023 10:05:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 17 Jul 2023 10:05:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 17 Jul 2023 10:05:45 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Sean Mollet <sean@malmoset.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] RTW88 firmware download issues - improvement, but not perfect
Thread-Topic: [PATCH] RTW88 firmware download issues - improvement, but not
 perfect
Thread-Index: AQHZtx+ZfIlqxfTQEkiCCTUOUI99I6+8Kt+AgAEJcJA=
Date:   Mon, 17 Jul 2023 02:05:44 +0000
Message-ID: <feadf58594b14c67bcf981dde6a60077@realtek.com>
References: <491EE697-0DFE-433A-97EA-F7D40E9FE0A5@malmoset.com>
 <09b6e6ab-5db4-ceb6-3590-f1a729f234d5@lwfinger.net>
In-Reply-To: <09b6e6ab-5db4-ceb6-3590-f1a729f234d5@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFycnkgRmluZ2VyIDxs
YXJyeS5maW5nZXJAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgTGFycnkgRmluZ2VyDQo+IFNlbnQ6
IE1vbmRheSwgSnVseSAxNywgMjAyMyAyOjAyIEFNDQo+IFRvOiBTZWFuIE1vbGxldCA8c2VhbkBt
YWxtb3NldC5jb20+OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gUlRXODggZmlybXdhcmUgZG93bmxvYWQgaXNzdWVzIC0gaW1wcm92ZW1lbnQs
IGJ1dCBub3QgcGVyZmVjdA0KPiANCj4gDQo+IFBhdGNoZXMgZm9yIHRoZSBydGx3aWZpLCBydHc4
OCwgYW5kIHJ0dzg5IGRyaXZlcnMgc2hvdWxkIGJlIGFkZHJlc3NlZCB0byBQaW5nLUtlDQo+IFNo
aWggPHBrc2hpaEByZWFsdGVrLmNvbT4uIEFueSBwYXRjaCBmb3IgYSBkcml2ZXIgaW4gZHJpdmVy
cy9uZXQvd2lyZWxlc3MvLi4uDQo+IHNob3VsZCBiZSBzZW50IHRvIEthbGxlIFZhbG8gPGt2YWxv
QGtlcm5lbC5vcmc+LiBDYyBsaW51eC13aXJlbGVzcy4NCg0KSSBzdWJzY3JpYmUgdGhpcyBtYWls
aW5nIGxpc3QgYW5kIHRyZWF0IHJ0bHdpZmkvcnR3ODgvcnR3ODkgd2l0aCBzcGVjaWFsIGZpbHRl
ciwgc28NCkkgdGhpbmsgSSBkb24ndCBtaXNzIHRoaXMgbWFpbC4gOi0pDQoNCj4gDQo+IFRoZSBz
dWJqZWN0IGxpbmUgc2hvdWxkIGJlICJ3aWZpOiBydHc4ODogLi4uLi4uIg0KDQpJIHRoaW5rIHRo
aXMgc2hvdWxkIGJlICJSRkMiIGluc3RlYWQgb2YgIlBBVENIIiBhcyBzdWJqZWN0LiANCj4gPiBA
QCAtNzk0LDE1ICs3OTQsMTUgQEAgc3RhdGljIGludCBfX3J0d19kb3dubG9hZF9maXJtd2FyZShz
dHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LA0KPiA+DQo+ID4gICAgICAgICAgd2xhbl9jcHVfZW5hYmxl
KHJ0d2RldiwgdHJ1ZSk7DQo+ID4NCj4gPiAtICAgICAgIGlmICghbHRlY29leF9yZWdfd3JpdGUo
cnR3ZGV2LCAweDM4LCBsdGVjb2V4X2Jja3ApKSB7DQo+ID4gLSAgICAgICAgICAgICAgIHJldCA9
IC1FQlVTWTsNCj4gPiAtICAgICAgICAgICAgICAgZ290byBkbGZ3X2ZhaWw7DQo+ID4gLSAgICAg
ICB9DQo+ID4gLQ0KPiA+ICAgICAgICAgIHJldCA9IGRvd25sb2FkX2Zpcm13YXJlX3ZhbGlkYXRl
KHJ0d2Rldik7DQo+ID4gICAgICAgICAgaWYgKHJldCkNCj4gPiAgICAgICAgICAgICAgICAgIGdv
dG8gZGxmd19mYWlsOw0KPiA+DQo+ID4gKyAgICAgICBpZiAoIWx0ZWNvZXhfcmVnX3dyaXRlKHJ0
d2RldiwgMHgzOCwgbHRlY29leF9iY2twKSkgew0KPiA+ICsgICAgICAgICAgICAgICByZXQgPSAt
RUJVU1k7DQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZGxmd19mYWlsOw0KPiA+ICsgICAgICAg
fQ0KPiA+ICsNCg0KVGhpcyBsb29rcyByZWFzb24gdG8gcmVzdG9yZSAweDM4IGFmdGVyIHZhbGlk
YXRpbmcgZmlybXdhcmUuIERvIHlvdSBoYXZlIGEgcmVzdWx0IA0KaG93IHRoaXMgY2hhbmdlIGNh
biBpbXByb3ZlPyANCg0KPiA+ICAgICAgICAgIC8qIHJlc2V0IGRlc2MgYW5kIGluZGV4ICovDQo+
ID4gICAgICAgICAgcnR3X2hjaV9zZXR1cChydHdkZXYpOw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L3V0aWwuYyBiL3V0aWwuYw0KPiA+IGluZGV4IGZmM2MyNjkuLmZiZDY1OTkgMTAwNjQ0DQo+ID4g
LS0tIGEvdXRpbC5jDQo+ID4gKysrIGIvdXRpbC5jDQo+ID4gQEAgLTEwLDExICsxMCwxMSBAQCBi
b29sIGNoZWNrX2h3X3JlYWR5KHN0cnVjdCBydHdfZGV2ICpydHdkZXYsIHUzMiBhZGRyLCB1MzIg
bWFzaywgdTMyIHRhcmdldCkNCj4gPiAgIHsNCj4gPiAgICAgICAgICB1MzIgY250Ow0KPiA+DQo+
ID4gLSAgICAgICBmb3IgKGNudCA9IDA7IGNudCA8IDEwMDA7IGNudCsrKSB7DQo+ID4gKyAgICAg
ICBmb3IgKGNudCA9IDA7IGNudCA8IDUwMDA7IGNudCsrKSB7DQo+ID4gICAgICAgICAgICAgICAg
ICBpZiAocnR3X3JlYWQzMl9tYXNrKHJ0d2RldiwgYWRkciwgbWFzaykgPT0gdGFyZ2V0KQ0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPg0KPiA+IC0gICAgICAg
ICAgICAgICB1ZGVsYXkoMTApOw0KPiA+ICsgICAgICAgICAgICAgICB1ZGVsYXkoNTApOw0KDQpJ
IGxvb2sgaW50byB0aGUgbGF0ZXN0IHZlbmRvciBkcml2ZXIsIGl0IHNob3dzIHRoYXQgY250IGJl
Y29tZXMgMTAsMDAwIGFuZCBkZWxheQ0KaXMgNTB1cyBhcyB5b3VyIGNoYW5nZS4gDQoNCj4gDQo+
IFlvdSBoYXZlIGluY3JlYXNlZCB0aGUgbWF4aW11bSBzdGFsbCB0aW1lIGZyb20gMTAgbXNlYyB0
byAyNTAgbXNlYy4gRG8geW91DQo+IHJlYWxseSBuZWVkIHRvIGxvY2sgdXAgYSBDUFUgZm9yIHRo
YXQgbG9uZz8gVGhpcyBpcyBhIHBsYWNlIHdoZXJlIHlvdSBzaG91bGQNCj4gZG9jdW1lbnQgaG93
IGxvbmcgaXQgYWN0dWFsbHkgdGFrZXMsIGlmIGl0IHJlYWxseSBpcyBtb3JlIHRoYW4gMTAgbXNl
Yy4gT24gbXkNCj4gcnR3ODgyMWNlIGNhcmQsIHRoZSBsb25nZXN0IGl0IHRvb2sgd2FzIDYuMjUg
bXNlYy4gVGhlIFVTQiBkZXZpY2Ugd2lsbCBsaWtlbHkNCj4gdGFrZSBsb25nZXIsIGJ1dCBJIHdv
dWxkIGJlIGludGVyZXN0ZWQgaW4geW91ciB3b3JzdCBjYXNlLg0KDQpNYXliZSwgd2UgY2FuIHNl
dCBjbnQvdWRlbGF5IGFjY29yZGluZyB0byAncnR3ZGV2LT5oY2kudHlwZScsIGFuZCBjaGFuZ2Ug
dWRlbGF5KCkNCnRvIGZzbGVlcCgpIGlmIGFsbCBjYWxsZXJzIGFyZSBydW5uaW5nIG9uIHRocmVh
ZCBjb250ZXh0LiANCg0KQW5vdGhlciBub3RlIGlzIHRoYXQgY2hlY2tfaHdfcmVhZHkoKSBpcyBh
bHNvIHVzZWQgYnkgbWFueSBvdGhlciBwbGFjZXMuDQoNCj4gRllJLCBJIGNoYW5nZWQNCj4gY2hl
Y2tfaHdfcmVhZHkoKSB0byByZWFkDQo+IA0KPiAgICAgICAgICAgICAgICAgIGZvciAoY250ID0g
MDsgY250IDwgNTAwMDsgY250KyspIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChy
dHdfcmVhZDMyX21hc2socnR3ZGV2LCBhZGRyLCBtYXNrKSA9PSB0YXJnZXQpIHsNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGNudCA+IDUwKQ0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByX2luZm8oImh3X3JlYWR5IGF0IGNvdW50ICVk
XG4iLCBjbnQpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ICAg
ICAgICAgICAgICAgICAgfQ0KPiANCj4gICAgICAgICAgICAgICAgICB1ZGVsYXkoNTApOw0KDQpU
aGlzIGxvb2tzIHdlaXJkLiBJZiB1ZGVsYXkoKSBpc24ndCBpbiBsb29wLCBQQ0lFIGRldmljZSBj
YW4gcnVuIHF1aWNrbHkgYW5kIGdldA0KYSByZXN1bHQgIm5vdCByZWFkeSIuIEJ1dCwgZm9yIHNs
b3cgSU8gVVNCL1NESU8sIHRoaXMgbWlnaHQgYmUgZmluZS4gDQoNClBpbmctS2UNCg0K
