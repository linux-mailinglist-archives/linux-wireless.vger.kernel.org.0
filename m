Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8C75AB2D8
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbiIBOE2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239035AbiIBODy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:03:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 097871306E2
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 06:32:51 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 282Col853016071, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 282Col853016071
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 2 Sep 2022 20:50:47 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Sep 2022 20:51:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Sep 2022 20:51:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::d902:19b0:8613:5b97]) by
 RTEXMBS04.realtek.com.tw ([fe80::d902:19b0:8613:5b97%5]) with mapi id
 15.01.2375.007; Fri, 2 Sep 2022 20:51:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        DeanKu <ku920601@realtek.com>
Subject: Re: [PATCH v2 3/9] rtw89: coex: Add logic to parsing rtl8852c firmware type ctrl report
Thread-Topic: [PATCH v2 3/9] rtw89: coex: Add logic to parsing rtl8852c
 firmware type ctrl report
Thread-Index: AQHYn89LmSG721eAHkiGbBLHgdD4ya3L7Bmq///jawA=
Date:   Fri, 2 Sep 2022 12:51:03 +0000
Message-ID: <cfaf9a9a991a942bdac8f556372401e3f1e3aeb1.camel@realtek.com>
References: <20220725023509.43114-1-pkshih@realtek.com>
         <20220725023509.43114-4-pkshih@realtek.com> <87tu5qb816.fsf@kernel.org>
In-Reply-To: <87tu5qb816.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.17.75]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMiDkuIrljYggMDc6NDU6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <84F801366F32FC4284397BE3A8EAEBB0@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTAyIGF0IDA5OjMyICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBGcm9tOiBD
aGluZy1UZSBLdSA8a3U5MjA2MDFAcmVhbHRlay5jb20+DQo+ID4gDQo+ID4gQWRkIGEgcGFydCBv
ZiBsb2dpYyB0byBwYXJzZSB0eXBlIG9mIGN0cmwgcmVwb3J0IGZyb20gZmlybXdhcmUsIGFuZA0K
PiA+IHJlbW92ZSBCbHVldG9vdGggcGFja2V0IGNvdW50ZXIgY291bnQgZnJvbSBkcml2ZXIsIHRo
ZSBmZWF0dXJlIHdhcw0KPiA+IG1vdmVkIHRvIGZpcm13YXJlIGF0IHJ0bDg4NTJjLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IENoaW5nLVRlIEt1IDxrdTkyMDYwMUByZWFsdGVrLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9jb2V4LmMgICAgIHwg
NDQgKysrKysrKysrKystLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5
L2NvcmUuaCAgICAgfCA2MyArKysrKysrKysrKysrKysrKy0tDQo+ID4gIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3ODg1MmMuYyB8IDE4ICstLS0tLQ0KPiA+ICAzIGZpbGVz
IGNoYW5nZWQsIDk4IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2NvZXguYw0KPiA+
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9jb2V4LmMNCj4gPiBpbmRleCBm
OWM2N2FhMTU3MGRkLi4wMjBiMjYyOGVmMmM0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvY29leC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydHc4OS9jb2V4LmMNCj4gPiBAQCAtODc2LDcgKzg3Niw5IEBAIHN0YXRp
YyB1MzIgX2Noa19idGNfcmVwb3J0KHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwNCj4gPiAgCXN0
cnVjdCBydHc4OV9idGNfZG0gKmRtID0gJmJ0Yy0+ZG07DQo+ID4gIAlzdHJ1Y3QgcnR3ODlfYnRj
X3JwdF9jbW5faW5mbyAqcGNpbmZvID0gTlVMTDsNCj4gPiAgCXN0cnVjdCBydHc4OV9idGNfd2xf
aW5mbyAqd2wgPSAmYnRjLT5jeC53bDsNCj4gPiAtCXN0cnVjdCBydHc4OV9idGNfZmJ0Y19ycHRf
Y3RybCAqcHJwdCA9IE5VTEw7DQo+ID4gKwlzdHJ1Y3QgcnR3ODlfYnRjX2J0X2luZm8gKmJ0ID0g
JmJ0Yy0+Y3guYnQ7DQo+ID4gKwlzdHJ1Y3QgcnR3ODlfYnRjX2ZidGNfcnB0X2N0cmwgKnBycHQ7
DQo+ID4gKwlzdHJ1Y3QgcnR3ODlfYnRjX2ZidGNfcnB0X2N0cmxfdjEgKnBycHRfdjE7DQo+ID4g
IAlzdHJ1Y3QgcnR3ODlfYnRjX2ZidGNfY3lzdGEgKnBjeXN0YV9sZTMyID0gTlVMTDsNCj4gPiAg
CXN0cnVjdCBydHc4OV9idGNfZmJ0Y19jeXN0YV9jcHUgcGN5c3RhWzFdOw0KPiA+ICAJc3RydWN0
IHJ0dzg5X2J0Y19wcnB0ICpidGNfcHJwdCA9IE5VTEw7DQo+ID4gQEAgLTkwNyw4ICs5MDksMTMg
QEAgc3RhdGljIHUzMiBfY2hrX2J0Y19yZXBvcnQoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LA0K
PiA+ICAJc3dpdGNoIChycHRfdHlwZSkgew0KPiA+ICAJY2FzZSBCVENfUlBUX1RZUEVfQ1RSTDoN
Cj4gPiAgCQlwY2luZm8gPSAmcGZ3aW5mby0+cnB0X2N0cmwuY2luZm87DQo+ID4gLQkJcGZpbmZv
ID0gKHU4ICopKCZwZndpbmZvLT5ycHRfY3RybC5maW5mbyk7DQo+ID4gLQkJcGNpbmZvLT5yZXFf
bGVuID0gc2l6ZW9mKHBmd2luZm8tPnJwdF9jdHJsLmZpbmZvKTsNCj4gPiArCQlpZiAoY2hpcC0+
Y2hpcF9pZCA9PSBSVEw4ODUyQSkgew0KPiA+ICsJCQlwZmluZm8gPSAodTggKikoJnBmd2luZm8t
PnJwdF9jdHJsLmZpbmZvKTsNCj4gPiArCQkJcGNpbmZvLT5yZXFfbGVuID0gc2l6ZW9mKHBmd2lu
Zm8tPnJwdF9jdHJsLmZpbmZvKTsNCj4gPiArCQl9IGVsc2Ugew0KPiA+ICsJCQlwZmluZm8gPSAo
dTggKikoJnBmd2luZm8tPnJwdF9jdHJsLmZpbmZvX3YxKTsNCj4gPiArCQkJcGNpbmZvLT5yZXFf
bGVuID0gc2l6ZW9mKHBmd2luZm8tPnJwdF9jdHJsLmZpbmZvX3YxKTsNCj4gPiArCQl9DQo+IA0K
PiBUaGF0IHU4IGNhc3QgaXMgbm90IHJlYWxseSBwcmV0dHksIHNob3VsZG4ndCBwZmluZm8gYmUg
YSB2b2lkIHBvaW50ZXINCj4gYW5kIHRoZW4gYWxsIHRoZXNlIGNhc3RzIGNvdWxkIGJlIGF2b2lk
ZWQ/IEJ1dCBvZiBjb3Vyc2UgdGhhdCdzIG5vdA0KPiBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gg
c28gbmVlZCB0byByZXNlbmQgdGhlIHBhdGNoIGJlY2F1c2Ugb2YgdGhpcy4NCj4gDQoNClRoYW5r
cyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQsIEkgd2lsbCBjaGFuZ2UgcGluZm8gdG8gdm9pZCBwb2lu
dGVyDQphbG9uZyB3aXRoIG5leHQgcGF0Y2hzZXQgb2YgY29leCBjaGFuZ2VzLg0KDQpQaW5nLUtl
DQoNCg==
