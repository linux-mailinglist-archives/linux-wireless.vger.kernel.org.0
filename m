Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5D61E8A3
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Nov 2022 03:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiKGCkp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Nov 2022 21:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKGCko (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Nov 2022 21:40:44 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FA15634D
        for <linux-wireless@vger.kernel.org>; Sun,  6 Nov 2022 18:40:41 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2A72dxcdF019933, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2A72dxcdF019933
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 7 Nov 2022 10:39:59 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Mon, 7 Nov 2022 10:40:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 7 Nov 2022 10:40:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Mon, 7 Nov 2022 10:40:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2 1/3] wifi: rtl8xxxu: Move burst init to a function
Thread-Topic: [PATCH v2 1/3] wifi: rtl8xxxu: Move burst init to a function
Thread-Index: AQHY8WlwVTok+UG34kSwmrVhoOozL64ytz5Q
Date:   Mon, 7 Nov 2022 02:40:36 +0000
Message-ID: <9c3088fb5e904415b5886852fe828827@realtek.com>
References: <bef90bf8-716f-c92f-9403-12ef2bfefc15@gmail.com>
In-Reply-To: <bef90bf8-716f-c92f-9403-12ef2bfefc15@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzYg5LiL5Y2IIDEwOjA2OjAw?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgTm92ZW1iZXIgNiwg
MjAyMiA2OjUzIEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW1BBVENI
IHYyIDEvM10gd2lmaTogcnRsOHh4eHU6IE1vdmUgYnVyc3QgaW5pdCB0byBhIGZ1bmN0aW9uDQo+
IA0KPiBObyBjaGFuZ2VzIHRvIGZ1bmN0aW9uYWxpdHksIGp1c3QgbW92aW5nIGNvZGUgdG8gbWFr
ZQ0KPiBydGw4eHh4dV9pbml0X2RldmljZSBsb29rIG5pY2VyLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IC0tLQ0KPiB2
MjoNCj4gIC0gTm8gY2hhbmdlLg0KPiAtLS0NCj4gIC4uLi9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dGw4eHh4dS9ydGw4eHh4dS5oICB8ICAyICsNCj4gIC4uLi9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4
eHh1XzgxODhmLmMgICAgICAgICB8ICAxICsNCj4gIC4uLi9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4
eHh1Xzg3MjNiLmMgICAgICAgICB8ICAxICsNCj4gIC4uLi93aXJlbGVzcy9yZWFsdGVrL3J0bDh4
eHh1L3J0bDh4eHh1X2NvcmUuYyB8IDg5ICsrKysrKysrKystLS0tLS0tLS0NCj4gIDQgZmlsZXMg
Y2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgNDEgZGVsZXRpb25zKC0pDQo+IA0KDQpbLi4uXQ0K
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0
bDh4eHh1X2NvcmUuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUv
cnRsOHh4eHVfY29yZS5jDQo+IGluZGV4IDAxOWY4ZGRkNDE4Yi4uMjgyYWQ4YTliNzNkIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1
X2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0
bDh4eHh1X2NvcmUuYw0KPiBAQCAtMzg4Niw2ICszODg2LDUyIEBAIHN0YXRpYyB2b2lkIHJ0bDh4
eHh1X2luaXRfcXVldWVfcmVzZXJ2ZWRfcGFnZShzdHJ1Y3QgcnRsOHh4eHVfcHJpdiAqcHJpdikN
Cj4gIAlydGw4eHh4dV93cml0ZTMyKHByaXYsIFJFR19SUVBOLCB2YWwzMik7DQo+ICB9DQo+IA0K
PiArdm9pZCBydGw4eHh4dV9pbml0X2J1cnN0KHN0cnVjdCBydGw4eHh4dV9wcml2ICpwcml2KQ0K
PiArew0KPiArCXU4IHZhbDg7DQo+ICsNCj4gKwkvKg0KPiArCSAqIEZvciBVU0IgaGlnaCBzcGVl
ZCBzZXQgNTEyQiBwYWNrZXRzDQo+ICsJICovDQo+ICsJdmFsOCA9IHJ0bDh4eHh1X3JlYWQ4KHBy
aXYsIFJFR19SWERNQV9QUk9fODcyM0IpOw0KPiArCXZhbDggJj0gfihCSVQoNCkgfCBCSVQoNSkp
Ow0KPiArCXZhbDggfD0gQklUKDQpOw0KPiArCXZhbDggfD0gQklUKDEpIHwgQklUKDIpIHwgQklU
KDMpOw0KDQpJIHRoaW5rIHdlIGNhbiBmaXggdGhlc2UgbWFnaWMgbnVtYmVycyBhbG9uZyB3aXRo
IHlvdXIgcGF0Y2guDQoNCiNkZWZpbmUgRE1BX01PREUgQklUKDEpICAvLyBzZXQgMHgxDQojZGVm
aW5lIERNQV9CVVJTVF9DTlQgR0VOTUFTSygzLCAyKSAvLyBzZXQgMHgzDQojZGVmaW5lIERNQV9C
VVJTVF9TSVpFIEdFTk1BU0soNSwgNCkgLy8gc2V0IDB4MQ0KDQoNCj4gKwlydGw4eHh4dV93cml0
ZTgocHJpdiwgUkVHX1JYRE1BX1BST184NzIzQiwgdmFsOCk7DQo+ICsNCj4gKwkvKg0KPiArCSAq
IEVuYWJsZSBzaW5nbGUgcGFja2V0IEFNUERVDQo+ICsJICovDQo+ICsJdmFsOCA9IHJ0bDh4eHh1
X3JlYWQ4KHByaXYsIFJFR19IVF9TSU5HTEVfQU1QRFVfODcyM0IpOw0KPiArCXZhbDggfD0gQklU
KDcpOw0KDQojZGVmaW5lIEVOX1NJTkdMRV9BTVBEVSBCSVQoNykNCg0KPiArCXJ0bDh4eHh1X3dy
aXRlOChwcml2LCBSRUdfSFRfU0lOR0xFX0FNUERVXzg3MjNCLCB2YWw4KTsNCj4gKw0KPiArCXJ0
bDh4eHh1X3dyaXRlMTYocHJpdiwgUkVHX01BWF9BR0dSX05VTSwgMHgwYzE0KTsNCj4gKwlpZiAo
cHJpdi0+cnRsX2NoaXAgPT0gUlRMODcyM0IpDQo+ICsJCXZhbDggPSAweDVlOw0KPiArCWVsc2Ug
aWYgKHByaXYtPnJ0bF9jaGlwID09IFJUTDgxODhGKQ0KPiArCQl2YWw4ID0gMHg3MDsgLyogMHg1
ZSB3b3VsZCBtYWtlIGl0IHZlcnkgc2xvdyAqLw0KPiArCXJ0bDh4eHh1X3dyaXRlOChwcml2LCBS
RUdfQU1QRFVfTUFYX1RJTUVfODcyM0IsIHZhbDgpOw0KPiArCXJ0bDh4eHh1X3dyaXRlMzIocHJp
diwgUkVHX0FHR0xFTl9MTVQsIDB4ZmZmZmZmZmYpOw0KPiArCXJ0bDh4eHh1X3dyaXRlOChwcml2
LCBSRUdfUlhfUEtUX0xJTUlULCAweDE4KTsNCj4gKwlydGw4eHh4dV93cml0ZTgocHJpdiwgUkVH
X1BJRlMsIDB4MDApOw0KPiArCWlmIChwcml2LT5ydGxfY2hpcCA9PSBSVEw4MTg4Rikgew0KPiAr
CQlydGw4eHh4dV93cml0ZTgocHJpdiwgUkVHX0ZXSFdfVFhRX0NUUkwsIEZXSFdfVFhRX0NUUkxf
QU1QRFVfUkVUUlkpOw0KPiArCQlydGw4eHh4dV93cml0ZTMyKHByaXYsIFJFR19GQVNUX0VEQ0Ff
Q1RSTCwgMHgwMzA4NjY2Nik7DQo+ICsJfQ0KPiArCWlmIChwcml2LT5ydGxfY2hpcCA9PSBSVEw4
NzIzQikNCj4gKwkJdmFsOCA9IDB4NTA7DQo+ICsJZWxzZSBpZiAocHJpdi0+cnRsX2NoaXAgPT0g
UlRMODE4OEYpDQo+ICsJCXZhbDggPSAweDI4OyAvKiAweDUwIHdvdWxkIG1ha2UgdGhlIHVwbG9h
ZCBzbG93ICovDQo+ICsJcnRsOHh4eHVfd3JpdGU4KHByaXYsIFJFR19VU1RJTUVfVFNGXzg3MjNC
LCB2YWw4KTsNCj4gKwlydGw4eHh4dV93cml0ZTgocHJpdiwgUkVHX1VTVElNRV9FRENBLCB2YWw4
KTsNCj4gKw0KPiArCS8qIHRvIHByZXZlbnQgbWFjIGlzIHJlc2V0ZWQgYnkgYnVzLiAqLw0KPiAr
CXZhbDggPSBydGw4eHh4dV9yZWFkOChwcml2LCBSRUdfUlNWX0NUUkwpOw0KPiArCXZhbDggfD0g
QklUKDUpIHwgQklUKDYpOw0KDQojZGVmaW5lIFdMT0NLXzFDIEJJVCg1KQ0KI2RlZmluZSBESVNf
UFJTVCBCSVQoNikNCg0KPiArCXJ0bDh4eHh1X3dyaXRlOChwcml2LCBSRUdfUlNWX0NUUkwsIHZh
bDgpOw0KPiArfQ0KPiArDQoNClsuLi5dDQoNCkkgZmluZCBzb21lIGJpdCBkZWZpbml0aW9ucywg
c28gd2UgY2FuIGhhdmUgdGhlbSBtZWFuaW5nZnVsIG5hbWVzLCBhbmQNCnBsZWFzZSBhZGQgcHJv
cGVyIHByZWZpeCBpZiBuZWVkLg0KDQpQaW5nLUtlDQoNCg==
