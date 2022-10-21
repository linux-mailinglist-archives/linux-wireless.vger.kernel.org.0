Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999E9606F74
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 07:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJUFcF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 01:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJUFcE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 01:32:04 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D955D22C80E
        for <linux-wireless@vger.kernel.org>; Thu, 20 Oct 2022 22:32:01 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29L5VOO20029597, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29L5VOO20029597
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 21 Oct 2022 13:31:24 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 21 Oct 2022 13:31:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Oct 2022 13:31:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb]) by
 RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb%5]) with mapi id
 15.01.2375.007; Fri, 21 Oct 2022 13:31:56 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 3/5] wifi: rtl8xxxu: Recognise all possible chip cuts
Thread-Topic: [PATCH 3/5] wifi: rtl8xxxu: Recognise all possible chip cuts
Thread-Index: AQHY4YTl9/E4lOWx+kaFUP5V7I/Zb64YWWUg
Date:   Fri, 21 Oct 2022 05:31:56 +0000
Message-ID: <4294d0bed5e54862bb199bc2e8e4b6ae@realtek.com>
References: <2b29b6d9-c17e-76d6-c32f-630f24b407b7@gmail.com>
 <f7239792-028f-77dc-a86d-f89e3eeafa7d@gmail.com>
In-Reply-To: <f7239792-028f-77dc-a86d-f89e3eeafa7d@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzIxIOS4iuWNiCAwMTo0NTowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxNywg
MjAyMiAxOjMwIEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW1BBVENI
IDMvNV0gd2lmaTogcnRsOHh4eHU6IFJlY29nbmlzZSBhbGwgcG9zc2libGUgY2hpcCBjdXRzDQo+
IA0KPiBUaGUgY2hpcCBjdXQsIGFsc28ga25vd24gYXMgdGhlIGNoaXAgdmVyc2lvbiwgaXMgYSBs
ZXR0ZXIgZnJvbSBBICgwKQ0KPiB0byBQICgxNSkuIFJlY29nbmlzZSB0aGVtIGFsbCBpbnN0ZWFk
IG9mIHByaW50aW5nICJ1bmtub3duIiB3aGVuIGl0J3MNCj4gZ3JlYXRlciB0aGFuIEUuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNv
bT4NCj4gLS0tDQo+ICAuLi4vd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3Jl
LmMgfCAyNyArKysrKy0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCAyMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IGluZGV4IDJlZmM5
OTg5NmI5Ni4uYTg5MTQ2NTA4MTVlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBAQCAtMTU3MywzMSAr
MTU3MywxNiBAQCBydGw4eHh4dV9zZXRfc3BlY19zaWZzKHN0cnVjdCBydGw4eHh4dV9wcml2ICpw
cml2LCB1MTYgY2NrLCB1MTYgb2ZkbSkNCj4gDQo+ICBzdGF0aWMgdm9pZCBydGw4eHh4dV9wcmlu
dF9jaGlwaW5mbyhzdHJ1Y3QgcnRsOHh4eHVfcHJpdiAqcHJpdikNCj4gIHsNCj4gKwlzdGF0aWMg
Y29uc3QgY2hhciBjdXRzWzE2XSA9ICJBQkNERUZHSElKS0xNTk9QIjsNCj4gIAlzdHJ1Y3QgZGV2
aWNlICpkZXYgPSAmcHJpdi0+dWRldi0+ZGV2Ow0KPiAtCWNoYXIgKmN1dDsNCj4gKwljaGFyIGN1
dCA9ICc/JzsNCj4gDQo+IC0Jc3dpdGNoIChwcml2LT5jaGlwX2N1dCkgew0KPiAtCWNhc2UgMDoN
Cj4gLQkJY3V0ID0gIkEiOw0KPiAtCQlicmVhazsNCj4gLQljYXNlIDE6DQo+IC0JCWN1dCA9ICJC
IjsNCj4gLQkJYnJlYWs7DQo+IC0JY2FzZSAyOg0KPiAtCQljdXQgPSAiQyI7DQo+IC0JCWJyZWFr
Ow0KPiAtCWNhc2UgMzoNCj4gLQkJY3V0ID0gIkQiOw0KPiAtCQlicmVhazsNCj4gLQljYXNlIDQ6
DQo+IC0JCWN1dCA9ICJFIjsNCj4gLQkJYnJlYWs7DQo+IC0JZGVmYXVsdDoNCj4gLQkJY3V0ID0g
InVua25vd24iOw0KPiAtCX0NCj4gKwkvKiBDdXJyZW50bHkgYWx3YXlzIHRydWU6IGNoaXBfY3V0
IGlzIDQgYml0cy4gKi8NCj4gKwlpZiAocHJpdi0+Y2hpcF9jdXQgPD0gMTUpDQo+ICsJCWN1dCA9
IGN1dHNbcHJpdi0+Y2hpcF9jdXRdOw0KDQpIb3cgYWJvdXQ/DQoNCiAgIGN1dCA9ICdBJyArIHBy
aXYtPmNoaXBfY3V0Ow0KDQoNCj4gDQo+ICAJZGV2X2luZm8oZGV2LA0KPiAtCQkgIlJUTCVzIHJl
diAlcyAoJXMpICVpVCVpUiwgVFggcXVldWVzICVpLCBXaUZpPSVpLCBCVD0laSwgR1BTPSVpLCBI
SSBQQT0laVxuIiwNCj4gKwkJICJSVEwlcyByZXYgJWMgKCVzKSAlaVQlaVIsIFRYIHF1ZXVlcyAl
aSwgV2lGaT0laSwgQlQ9JWksIEdQUz0laSwgSEkgUEE9JWlcbiIsDQo+ICAJCSBwcml2LT5jaGlw
X25hbWUsIGN1dCwgcHJpdi0+Y2hpcF92ZW5kb3IsIHByaXYtPnR4X3BhdGhzLA0KPiAgCQkgcHJp
di0+cnhfcGF0aHMsIHByaXYtPmVwX3R4X2NvdW50LCBwcml2LT5oYXNfd2lmaSwNCj4gIAkJIHBy
aXYtPmhhc19ibHVldG9vdGgsIHByaXYtPmhhc19ncHMsIHByaXYtPmhpX3BhKTsNCj4gLS0NCj4g
Mi4zOC4wDQo+IA0KPiAtLS0tLS1QbGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9y
ZSBwcmludGluZyB0aGlzIGUtbWFpbC4NCg==
