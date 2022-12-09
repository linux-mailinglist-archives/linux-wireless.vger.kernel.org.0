Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE11647EE3
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 09:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiLIIDp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Dec 2022 03:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiLIIDo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Dec 2022 03:03:44 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C0975AE1F
        for <linux-wireless@vger.kernel.org>; Fri,  9 Dec 2022 00:03:42 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B982oJ32002457, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B982oJ32002457
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 9 Dec 2022 16:02:50 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 9 Dec 2022 16:03:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 9 Dec 2022 16:03:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Fri, 9 Dec 2022 16:03:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
Subject: RE: [PATCH 2/2] wifi: rtl8xxxu: Add rate control code for RTL8188EU
Thread-Topic: [PATCH 2/2] wifi: rtl8xxxu: Add rate control code for RTL8188EU
Thread-Index: AQHZCbyDN81dayZcqECzxC5tK/ABJ65lMKRg
Date:   Fri, 9 Dec 2022 08:03:37 +0000
Message-ID: <9d717c58f61149d1ac8b4db889911316@realtek.com>
References: <00c4bd4a-10e0-02e6-4e09-f450909414ac@gmail.com>
 <ad8e37cf-3653-acde-5259-84768e3d3c8e@gmail.com>
In-Reply-To: <ad8e37cf-3653-acde-5259-84768e3d3c8e@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzkg5LiK5Y2IIDA3OjIzOjAw?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIg
NywgMjAyMiA1OjQ5IEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPjsgQW5kcmVhIE1lcmVsbG8NCj4gPGFuZHJlYS5tZXJlbGxvQGdt
YWlsLmNvbT47IFRhZWhlZSBZb28gPGFwNDIwMDczQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIIDIvMl0gd2lmaTogcnRsOHh4eHU6IEFkZCByYXRlIGNvbnRyb2wgY29kZSBmb3IgUlRMODE4
OEVVDQo+IA0KPiBDb3BpZWQgZnJvbSB0aGUgbmV3ZXIgdmVuZG9yIGRyaXZlciwgdjUuMi4yLjQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdt
YWlsLmNvbT4NCj4gLS0tDQo+IFRoaXMgcGF0Y2ggc2hvdWxkIGJlIGFwcGxpZWQgYWZ0ZXIgbXkg
b2xkZXIgcGF0Y2g6DQo+ICJbUEFUQ0ggdjQgMy8zXSB3aWZpOiBydGw4eHh4dTogSW50cm9kdWNl
IHJ0bDh4eHh1X3VwZGF0ZV9yYV9yZXBvcnQiDQo+IC0tLQ0KPiAgLi4uL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1LmggIHwgIDM5ICsrDQo+ICAuLi4vcmVhbHRlay9ydGw4
eHh4dS9ydGw4eHh4dV84MTg4ZS5jICAgICAgICAgfCA2MDAgKysrKysrKysrKysrKysrKystDQo+
ICAuLi4vd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMgfCAxMjkgKysr
LQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA3MzggaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25zKC0p
DQo+IA0KDQpbLi4uXQ0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxODhlLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxODhlLmMNCj4gaW5kZXggOWViOWFlMDNjYTgxLi5k
NjIwYzdhNGQzYzYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnRsOHh4eHUvcnRsOHh4eHVfODE4OGUuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxODhlLmMNCg0KWy4uLl0NCg0KPiBAQCAtMTI1MSw2
ICsxMzc3LDQ3OCBAQCBzdGF0aWMgczggcnRsODE4OGVfY2NrX3Jzc2koc3RydWN0IHJ0bDh4eHh1
X3ByaXYgKnByaXYsIHU4IGNja19hZ2NfcnB0KQ0KPiAgCXJldHVybiByeF9wd3JfYWxsOw0KPiAg
fQ0KPiANCj4gK3N0YXRpYyB2b2lkIHJ0bDgxODhlX3NldF90eF9ycHRfdGltaW5nKHN0cnVjdCBy
dGw4eHh4dV9yYV9pbmZvICpyYSwgdTggdGltaW5nKQ0KPiArew0KPiArCXU4IGlkeCA9IDA7DQoN
Cm5vIG5lZWQgJz0wJw0KDQo+ICsNCj4gKwlmb3IgKGlkeCA9IDA7IGlkeCA8IDU7IGlkeCsrKQ0K
PiArCQlpZiAoZHluYW1pY190eF9ycHRfdGltaW5nW2lkeF0gPT0gcmEtPnJwdF90aW1lKQ0KPiAr
CQkJYnJlYWs7DQo+ICsNCj4gKwlpZiAodGltaW5nID09IERFRkFVTFRfVElNSU5HKSB7DQo+ICsJ
CWlkeCA9IDA7IC8qIDIwMG1zICovDQo+ICsJfSBlbHNlIGlmICh0aW1pbmcgPT0gSU5DUkVBU0Vf
VElNSU5HKSB7DQo+ICsJCWlmIChpZHggPCA1KQ0KPiArCQkJaWR4Kys7DQo+ICsJfSBlbHNlIGlm
ICh0aW1pbmcgPT0gREVDUkVBU0VfVElNSU5HKSB7DQo+ICsJCWlmIChpZHggPiAwKQ0KPiArCQkJ
aWR4LS07DQo+ICsJfQ0KPiArDQo+ICsJcmEtPnJwdF90aW1lID0gZHluYW1pY190eF9ycHRfdGlt
aW5nW2lkeF07DQo+ICt9DQoNClsuLi5dDQoNCj4gK3N0YXRpYyB2b2lkIHJ0bDgxODhlX3Bvd2Vy
X3RyYWluaW5nX3RyeV9zdGF0ZShzdHJ1Y3QgcnRsOHh4eHVfcmFfaW5mbyAqcmEpDQo+ICt7DQo+
ICsJcmEtPnB0X3RyeV9zdGF0ZSA9IDA7DQo+ICsJc3dpdGNoIChyYS0+cHRfbW9kZV9zcykgew0K
PiArCWNhc2UgMzoNCj4gKwkJaWYgKHJhLT5kZWNpc2lvbl9yYXRlID49IERFU0NfUkFURV9NQ1Mx
MykNCj4gKwkJCXJhLT5wdF90cnlfc3RhdGUgPSAxOw0KPiArCQlicmVhazsNCj4gKwljYXNlIDI6
DQo+ICsJCWlmIChyYS0+ZGVjaXNpb25fcmF0ZSA+PSBERVNDX1JBVEVfTUNTNSkNCj4gKwkJCXJh
LT5wdF90cnlfc3RhdGUgPSAxOw0KPiArCQlicmVhazsNCj4gKwljYXNlIDE6DQo+ICsJCWlmIChy
YS0+ZGVjaXNpb25fcmF0ZSA+PSBERVNDX1JBVEVfNDhNKQ0KPiArCQkJcmEtPnB0X3RyeV9zdGF0
ZSA9IDE7DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgMDoNCj4gKwkJaWYgKHJhLT5kZWNpc2lvbl9y
YXRlID49IERFU0NfUkFURV8xMU0pDQo+ICsJCQlyYS0+cHRfdHJ5X3N0YXRlID0gMTsNCj4gKwkJ
YnJlYWs7DQo+ICsJZGVmYXVsdDoNCj4gKwkJcmEtPnB0X3RyeV9zdGF0ZSA9IDA7DQoNCmJyZWFr
Ow0KDQo+ICsJfQ0KPiArDQo+ICsJaWYgKHJhLT5yc3NpX3N0YV9yYSA8IDQ4KSB7DQo+ICsJCXJh
LT5wdF9zdGFnZSA9IDA7DQo+ICsJfSBlbHNlIGlmIChyYS0+cHRfdHJ5X3N0YXRlID09IDEpIHsN
Cj4gKwkJaWYgKChyYS0+cHRfc3RvcF9jb3VudCA+PSAxMCkgfHwNCj4gKwkJICAgIChyYS0+cHRf
cHJlX3Jzc2kgPiByYS0+cnNzaV9zdGFfcmEgKyA1KSB8fA0KPiArCQkgICAgKHJhLT5wdF9wcmVf
cnNzaSA8IHJhLT5yc3NpX3N0YV9yYSAtIDUpIHx8DQo+ICsJCSAgICAocmEtPmRlY2lzaW9uX3Jh
dGUgIT0gcmEtPnB0X3ByZV9yYXRlKSkgew0KPiArCQkJaWYgKHJhLT5wdF9zdGFnZSA9PSAwKQ0K
PiArCQkJCXJhLT5wdF9zdGFnZSA9IDE7DQo+ICsJCQllbHNlIGlmIChyYS0+cHRfc3RhZ2UgPT0g
MSkNCj4gKwkJCQlyYS0+cHRfc3RhZ2UgPSAzOw0KPiArCQkJZWxzZQ0KPiArCQkJCXJhLT5wdF9z
dGFnZSA9IDU7DQo+ICsNCj4gKwkJCXJhLT5wdF9wcmVfcnNzaSA9IHJhLT5yc3NpX3N0YV9yYTsN
Cj4gKwkJCXJhLT5wdF9zdG9wX2NvdW50ID0gMDsNCj4gKwkJfSBlbHNlIHsNCj4gKwkJCXJhLT5y
YV9zdGFnZSA9IDA7DQo+ICsJCQlyYS0+cHRfc3RvcF9jb3VudCsrOw0KPiArCQl9DQo+ICsJfSBl
bHNlIHsNCj4gKwkJcmEtPnB0X3N0YWdlID0gMDsNCj4gKwkJcmEtPnJhX3N0YWdlID0gMDsNCj4g
Kwl9DQo+ICsNCj4gKwlyYS0+cHRfcHJlX3JhdGUgPSByYS0+ZGVjaXNpb25fcmF0ZTsNCj4gKw0K
PiArCS8qIFRPRE86IGltcGxlbWVudCB0aGUgImZhbHNlIGFsYXJtIiBzdGF0aXN0aWNzIGZvciB0
aGlzICovDQo+ICsJLyogRGlzYWJsZSBwb3dlciB0cmFpbmluZyB3aGVuIG5vaXN5IGVudmlyb25t
ZW50ICovDQo+ICsJLyogaWYgKHBfZG1fb2RtLT5pc19kaXNhYmxlX3Bvd2VyX3RyYWluaW5nKSB7
ICovDQo+ICsJaWYgKDEpIHsNCj4gKwkJcmEtPnB0X3N0YWdlID0gMDsNCj4gKwkJcmEtPnJhX3N0
YWdlID0gMDsNCj4gKwkJcmEtPnB0X3N0b3BfY291bnQgPSAwOw0KPiArCX0NCj4gK30NCg0KWy4u
Ll0NCg0KPiBAQCAtNTc1Nyw2ICs1NzgwLDQyIEBAIHN0YXRpYyB2b2lkIHJ0bDg3MjNidV9oYW5k
bGVfYzJoKHN0cnVjdCBydGw4eHh4dV9wcml2ICpwcml2LA0KPiAgCXNjaGVkdWxlX3dvcmsoJnBy
aXYtPmMyaGNtZF93b3JrKTsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgdm9pZCBydGw4MTg4ZV9jMmhj
bWRfY2FsbGJhY2soc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiArew0KPiArCXN0cnVjdCBy
dGw4eHh4dV9wcml2ICpwcml2ID0gY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCBydGw4eHh4dV9w
cml2LCBjMmhjbWRfd29yayk7DQo+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJnByaXYtPnVkZXYt
PmRldjsNCj4gKwlzdHJ1Y3Qgc2tfYnVmZiAqc2tiID0gTlVMTDsNCj4gKwlzdHJ1Y3QgcnRsOHh4
eHVfcnhkZXNjMTYgKnJ4X2Rlc2M7DQo+ICsNCj4gKwl3aGlsZSAoIXNrYl9xdWV1ZV9lbXB0eSgm
cHJpdi0+YzJoY21kX3F1ZXVlKSkgew0KPiArCQlza2IgPSBza2JfZGVxdWV1ZSgmcHJpdi0+YzJo
Y21kX3F1ZXVlKTsNCj4gKw0KPiArCQlyeF9kZXNjID0gKHN0cnVjdCBydGw4eHh4dV9yeGRlc2Mx
NiAqKShza2ItPmRhdGEgLSBzaXplb2Yoc3RydWN0IHJ0bDh4eHh1X3J4ZGVzYzE2KSk7DQo+ICsN
Cj4gKwkJc3dpdGNoIChyeF9kZXNjLT5ycHRfc2VsKSB7DQo+ICsJCWNhc2UgMToNCj4gKwkJCWRl
dl9kYmcoZGV2LCAiQzJIIFRYIHJlcG9ydCB0eXBlIDFcbiIpOw0KPiArDQo+ICsJCQlicmVhazsN
Cj4gKwkJY2FzZSAyOg0KPiArCQkJZGV2X2RiZyhkZXYsICJDMkggVFggcmVwb3J0IHR5cGUgMlxu
Iik7DQo+ICsNCj4gKwkJCXJ0bDgxODhlX2hhbmRsZV9yYV90eF9yZXBvcnQyKHByaXYsIHNrYik7
DQo+ICsNCj4gKwkJCWJyZWFrOw0KPiArCQljYXNlIDM6DQo+ICsJCQlkZXZfZGJnKGRldiwgIkMy
SCBVU0IgaW50ZXJydXB0IHJlcG9ydFxuIik7DQo+ICsNCj4gKwkJCWJyZWFrOw0KPiArCQlkZWZh
dWx0Og0KPiArCQkJZGV2X3dhcm4oZGV2LCAiJXM6IHJwdF9zZWwgc2hvdWxkIG5vdCBiZSAlZFxu
IiwNCj4gKwkJCQkgX19mdW5jX18sIHJ4X2Rlc2MtPnJwdF9zZWwpOw0KDQpicmVhazsNCg0KPiAr
CQl9DQo+ICsNCj4gKwkJZGV2X2tmcmVlX3NrYihza2IpOw0KPiArCX0NCj4gK30NCj4gKw0KPiAg
aW50IHJ0bDh4eHh1X3BhcnNlX3J4ZGVzYzE2KHN0cnVjdCBydGw4eHh4dV9wcml2ICpwcml2LCBz
dHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KDQpbLi4uXQ0KDQpJIGFkbWl0IHRoYXQgSSBkb24ndCBxdWl0
ZSB1bmRlcnN0YW5kIHJhdGUgY29udHJvbCBjb2RlLCBzbyBJIGp1c3QgcmV2aWV3DQpzdXJmYWNl
LCBidXQgaXQgd291bGQgYmUgZmluZSBpZiBpdCB3b3JrcyBmaW5lIHRvIHlvdS4gOi0pDQoNCi0t
DQpQaW5nLUtlDQoNCg0K
