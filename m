Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED94755EC7
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jul 2023 10:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjGQIwY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jul 2023 04:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjGQIwX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jul 2023 04:52:23 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 370211AE
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jul 2023 01:52:19 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36H8ptiF7015019, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36H8ptiF7015019
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 17 Jul 2023 16:51:55 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 17 Jul 2023 16:52:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 17 Jul 2023 16:52:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 17 Jul 2023 16:52:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Sean Mollet <sean@malmoset.com>
CC:     Larry Finger <Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [RFC] RTW88 firmware download issues - improvement, but not perfect
Thread-Topic: [RFC] RTW88 firmware download issues - improvement, but not
 perfect
Thread-Index: AQHZuFXXwsZbD0zHVESFUhHFS8y9gq+9ouOA
Date:   Mon, 17 Jul 2023 08:52:03 +0000
Message-ID: <8d629c6ac46444d6b5920566ae2c7e52@realtek.com>
References: <feadf58594b14c67bcf981dde6a60077@realtek.com>
 <ACAD9039-DD62-477E-BBCF-B8053822E042@malmoset.com>
In-Reply-To: <ACAD9039-DD62-477E-BBCF-B8053822E042@malmoset.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2VhbiBNb2xsZXQgPHNl
YW5AbWFsbW9zZXQuY29tPg0KPiBTZW50OiBNb25kYXksIEp1bHkgMTcsIDIwMjMgMTA6MjQgQU0N
Cj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBDYzogTGFycnkgRmlu
Z2VyIDxMYXJyeS5GaW5nZXJAbHdmaW5nZXIubmV0PjsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFtSRkNdIFJUVzg4IGZpcm13YXJlIGRvd25sb2FkIGlzc3VlcyAt
IGltcHJvdmVtZW50LCBidXQgbm90IHBlcmZlY3QNCj4gDQo+IE9uIEp1bCAxNiwgMjAyMywgYXQg
OTowNSBQTSwgUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+DQo+
ID4gDQo+ID4NCj4gPj4+IEBAIC03OTQsMTUgKzc5NCwxNSBAQCBzdGF0aWMgaW50IF9fcnR3X2Rv
d25sb2FkX2Zpcm13YXJlKHN0cnVjdCBydHdfZGV2ICpydHdkZXYsDQo+ID4+Pg0KPiA+Pj4gICAg
ICAgICB3bGFuX2NwdV9lbmFibGUocnR3ZGV2LCB0cnVlKTsNCj4gPj4+DQo+ID4+PiAtICAgICAg
IGlmICghbHRlY29leF9yZWdfd3JpdGUocnR3ZGV2LCAweDM4LCBsdGVjb2V4X2Jja3ApKSB7DQo+
ID4+PiAtICAgICAgICAgICAgICAgcmV0ID0gLUVCVVNZOw0KPiA+Pj4gLSAgICAgICAgICAgICAg
IGdvdG8gZGxmd19mYWlsOw0KPiA+Pj4gLSAgICAgICB9DQo+ID4+PiAtDQo+ID4+PiAgICAgICAg
IHJldCA9IGRvd25sb2FkX2Zpcm13YXJlX3ZhbGlkYXRlKHJ0d2Rldik7DQo+ID4+PiAgICAgICAg
IGlmIChyZXQpDQo+ID4+PiAgICAgICAgICAgICAgICAgZ290byBkbGZ3X2ZhaWw7DQo+ID4+Pg0K
PiA+Pj4gKyAgICAgICBpZiAoIWx0ZWNvZXhfcmVnX3dyaXRlKHJ0d2RldiwgMHgzOCwgbHRlY29l
eF9iY2twKSkgew0KPiA+Pj4gKyAgICAgICAgICAgICAgIHJldCA9IC1FQlVTWTsNCj4gPj4+ICsg
ICAgICAgICAgICAgICBnb3RvIGRsZndfZmFpbDsNCj4gPj4+ICsgICAgICAgfQ0KPiA+Pj4gKw0K
PiA+DQo+ID4gVGhpcyBsb29rcyByZWFzb24gdG8gcmVzdG9yZSAweDM4IGFmdGVyIHZhbGlkYXRp
bmcgZmlybXdhcmUuIERvIHlvdSBoYXZlIGEgcmVzdWx0DQo+ID4gaG93IHRoaXMgY2hhbmdlIGNh
biBpbXByb3ZlPw0KPiA+DQo+IA0KPiBVc2luZyBhIFBpIDQgQ00gYXMgaG9zdCwgdGhpcyByZWR1
Y2VzIGZhaWx1cmVzIGZyb20gMSBpbiA1IHRvIDEgaW4gMjAuDQo+IA0KPiBJIGRvbuKAmXQga25v
dyB3aHksIGJ1dCBpdCBtYWtlcyBhIG1lYXN1cmFibGUgZGlmZmVyZW5jZS4NCg0KSSB3aWxsIGNo
ZWNrIHRoaXMgd2l0aCBteSBjb2xsZWFndWUgdG8gc2VlIGlmIHdlIGNhbiBhcHBseSB0aGlzIGNo
YW5nZS4gDQoNCj4gDQo+ID4+PiAgICAgICAgIC8qIHJlc2V0IGRlc2MgYW5kIGluZGV4ICovDQo+
ID4+PiAgICAgICAgIHJ0d19oY2lfc2V0dXAocnR3ZGV2KTsNCj4gPj4+DQo+ID4+PiBkaWZmIC0t
Z2l0IGEvdXRpbC5jIGIvdXRpbC5jDQo+ID4+PiBpbmRleCBmZjNjMjY5Li5mYmQ2NTk5IDEwMDY0
NA0KPiA+Pj4gLS0tIGEvdXRpbC5jDQo+ID4+PiArKysgYi91dGlsLmMNCj4gPj4+IEBAIC0xMCwx
MSArMTAsMTEgQEAgYm9vbCBjaGVja19od19yZWFkeShzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCB1
MzIgYWRkciwgdTMyIG1hc2ssIHUzMiB0YXJnZXQpDQo+ID4+PiAgew0KPiA+Pj4gICAgICAgICB1
MzIgY250Ow0KPiA+Pj4NCj4gPj4+IC0gICAgICAgZm9yIChjbnQgPSAwOyBjbnQgPCAxMDAwOyBj
bnQrKykgew0KPiA+Pj4gKyAgICAgICBmb3IgKGNudCA9IDA7IGNudCA8IDUwMDA7IGNudCsrKSB7
DQo+ID4+PiAgICAgICAgICAgICAgICAgaWYgKHJ0d19yZWFkMzJfbWFzayhydHdkZXYsIGFkZHIs
IG1hc2spID09IHRhcmdldCkNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiB0
cnVlOw0KPiA+Pj4NCj4gPj4+IC0gICAgICAgICAgICAgICB1ZGVsYXkoMTApOw0KPiA+Pj4gKyAg
ICAgICAgICAgICAgIHVkZWxheSg1MCk7DQo+ID4NCj4gPiBJIGxvb2sgaW50byB0aGUgbGF0ZXN0
IHZlbmRvciBkcml2ZXIsIGl0IHNob3dzIHRoYXQgY250IGJlY29tZXMgMTAsMDAwIGFuZCBkZWxh
eQ0KPiA+IGlzIDUwdXMgYXMgeW91ciBjaGFuZ2UuDQo+IEludGVyZXN0aW5nLiBJcyBpdCBwb3Nz
aWJsZSB0aGF0IHRoZSByZWFsIHByb2JsZW0gaXMgc2ltcGx5IG5vdCB3YWl0aW5nIGxvbmcgZW5v
dWdoPw0KPiANCj4gQ2FuIHlvdSBzaGFyZSBzb21lIGRldGFpbHMgb2Ygd2hhdCB0aGUgY2hpcCBp
cyBkb2luZyBhbmQgaG93IGxvbmcgaXQgc2hvdWxkIHRha2U/DQo+IA0KDQpJdCBzZWVtcyBsaWtl
IEkgbWlzcmVhZCB0aGUgY29kZSwgdGhlIGxhdGVzdCB2ZXJzaW9uIGlzIDUsMDAwIGFzIHlvdSBt
ZW50aW9uZWQuIA0KDQpJZiBmYWlsZWQgdG8gcG9sbGluZyByZWFkeSwgcGxlYXNlIHJlYWQgYW5k
IHByaW50IG91dCAweDFDNCBhbmQgMHgxMGZjIDIwIHRpbWVzDQp3aXRoIDFtcyBvciBtb3JlIGRl
bGF5LiBUaGVzZSBzdG9yZSBmaXJtd2FyZSBQQy1saWtlIGFkZHJlc3MsIHNvIHdlIGNhbiBjaGVj
aw0KaWYgZmlybXdhcmUgaXMgcnVubmluZyBvciBnZXR0aW5nIHN0dWNrLiANCg0KUGluZy1LZQ0K
DQo=
