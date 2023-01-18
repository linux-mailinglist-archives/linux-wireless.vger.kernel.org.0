Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271B7670F52
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 02:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjARBEP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 20:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjARBDo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 20:03:44 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A46A54858F
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 16:53:00 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30I0qosnF002414, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30I0qosnF002414
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 18 Jan 2023 08:52:50 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 18 Jan 2023 08:52:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 18 Jan 2023 08:52:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Wed, 18 Jan 2023 08:52:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 1/4] wifi: rtl8xxxu: Register the LED and make it blink
Thread-Topic: [PATCH 1/4] wifi: rtl8xxxu: Register the LED and make it blink
Thread-Index: AQHZKr96qNWty18lDUSa9x9d5F0XZK6jV9UQ
Date:   Wed, 18 Jan 2023 00:52:51 +0000
Message-ID: <f2f52496d4274861b5870c1f425fa8e8@realtek.com>
References: <5c03ae42-a2fd-b39a-e754-f52d8528a167@gmail.com>
In-Reply-To: <5c03ae42-a2fd-b39a-e754-f52d8528a167@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTcg5LiL5Y2IIDEwOjAwOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAx
OCwgMjAyMyA2OjAzIEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMS80XSB3aWZpOiBydGw4eHh4
dTogUmVnaXN0ZXIgdGhlIExFRCBhbmQgbWFrZSBpdCBibGluaw0KPiANCj4gSWYgdGhlIGNoaXAg
Y2FuIGhhdmUgYW4gTEVELCByZWdpc3RlciBhIHN0cnVjdCBsZWRfY2xhc3NkZXYgYW5kIGVuYWJs
ZQ0KPiBoYXJkd2FyZS1jb250cm9sbGVkIGJsaW5raW5nLiBXaGVuIHRoZSBjaGlwIGlzIG5vdCB0
cmFuc21pdHRpbmcgb3INCj4gcmVjZWl2aW5nIGFueXRoaW5nIHRoZSBMRUQgaXMgb2ZmLiBPdGhl
cndpc2UgdGhlIExFRCB3aWxsIGJsaW5rDQo+IGZhc3RlciBvciBzbG93ZXIgYWNjb3JkaW5nIHRv
IHRoZSB0aHJvdWdocHV0Lg0KPiANCj4gVGhlIExFRCBjYW4gYmUgY29udHJvbGxlZCBmcm9tIHVz
ZXJzcGFjZSBieSB3cml0aW5nIDAsIDEsIG9yIDIgdG8NCj4gL3N5cy9jbGFzcy9sZWRzL3J0bDh4
eHh1LXVzYlgtWS9icmlnaHRuZXNzOg0KPiAwIC0gc29saWQgb2ZmLg0KPiAxIC0gc29saWQgb24u
DQo+IDIgLSBoYXJkd2FyZS1jb250cm9sbGVkIGJsaW5raW5nLg0KDQpTbywgZG8geW91IGxpa2UN
Cg0KI2RlZmluZSBSVEw4WFhYVV9IV19MRURfQkxJTktJTkcJMg0KDQo+IA0KPiBJbiB0aGlzIHBh
dGNoIG5vbmUgb2YgdGhlIGNoaXBzIGFkdmVydGlzZSBoYXZpbmcgYW4gTEVELiBUaGF0IHdpbGwg
YmUNCj4gYWRkZWQgaW4gdGhlIG5leHQgcGF0Y2hlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJp
dHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiAtLS0NCj4gIC4uLi9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dS5oICB8ICA4ICsrKysrDQo+ICAu
Li4vd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMgfCAzNCArKysrKysr
KysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4
eHh1LmgNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1
LmgNCj4gaW5kZXggOTAyNjg0NzlkM2FkLi5jOGNlZTRhMjQ3NTUgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHUuaA0KPiArKysgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1LmgNCj4gQEAgLTE0
NDMsNiArMTQ0Myw4IEBAIHN0cnVjdCBydGw4eHh4dV9jZm9fdHJhY2tpbmcgew0KPiAgCXUzMiBw
YWNrZXRfY291bnRfcHJlOw0KPiAgfTsNCj4gDQo+ICsjZGVmaW5lIFJUTDhYWFhVX0hXX0xFRF9D
T05UUk9MCTINCj4gKw0KPiAgc3RydWN0IHJ0bDh4eHh1X3ByaXYgew0KPiAgCXN0cnVjdCBpZWVl
ODAyMTFfaHcgKmh3Ow0KPiAgCXN0cnVjdCB1c2JfZGV2aWNlICp1ZGV2Ow0KPiBAQCAtMTU2NCw2
ICsxNTY2LDEwIEBAIHN0cnVjdCBydGw4eHh4dV9wcml2IHsNCj4gIAlzdHJ1Y3QgcnRsOHh4eHVf
cmFfcmVwb3J0IHJhX3JlcG9ydDsNCj4gIAlzdHJ1Y3QgcnRsOHh4eHVfY2ZvX3RyYWNraW5nIGNm
b190cmFja2luZzsNCj4gIAlzdHJ1Y3QgcnRsOHh4eHVfcmFfaW5mbyByYV9pbmZvOw0KPiArDQo+
ICsJYm9vbCBsZWRfcmVnaXN0ZXJlZDsNCj4gKwljaGFyIGxlZF9uYW1lWzMyXTsNCj4gKwlzdHJ1
Y3QgbGVkX2NsYXNzZGV2IGxlZF9jZGV2Ow0KPiAgfTsNCj4gDQo+ICBzdHJ1Y3QgcnRsOHh4eHVf
cnhfdXJiIHsNCj4gQEAgLTE2MTMsNiArMTYxOSw4IEBAIHN0cnVjdCBydGw4eHh4dV9maWxlb3Bz
IHsNCj4gIAkJCSAgICAgdTMyIHJ0c19yYXRlKTsNCj4gIAl2b2lkICgqc2V0X2NyeXN0YWxfY2Fw
KSAoc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYsIHU4IGNyeXN0YWxfY2FwKTsNCj4gIAlzOCAo
KmNja19yc3NpKSAoc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYsIHU4IGNja19hZ2NfcnB0KTsN
Cj4gKwlpbnQgKCpsZWRfY2xhc3NkZXZfYnJpZ2h0bmVzc19zZXQpIChzdHJ1Y3QgbGVkX2NsYXNz
ZGV2ICpsZWRfY2RldiwNCj4gKwkJCQkJICAgIGVudW0gbGVkX2JyaWdodG5lc3MgYnJpZ2h0bmVz
cyk7DQo+ICAJaW50IHdyaXRlTl9ibG9ja19zaXplOw0KPiAgCWludCByeF9hZ2dfYnVmX3NpemU7
DQo+ICAJY2hhciB0eF9kZXNjX3NpemU7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IGluZGV4IDM1ZGM3Nzdj
MWZiYS4uYjI3ZWRkNTAzYzIzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBAQCAtNjk1NSw2ICs2OTU1
LDM0IEBAIHN0YXRpYyBpbnQgcnRsOHh4eHVfcGFyc2VfdXNiKHN0cnVjdCBydGw4eHh4dV9wcml2
ICpwcml2LA0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+IA0KPiArc3RhdGljIHZvaWQgcnRsOHh4
eHVfaW5pdF9sZWQoc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYpDQo+ICt7DQo+ICsJc3RydWN0
IGxlZF9jbGFzc2RldiAqbGVkID0gJnByaXYtPmxlZF9jZGV2Ow0KPiArDQo+ICsJbGVkLT5icmln
aHRuZXNzX3NldF9ibG9ja2luZyA9IHByaXYtPmZvcHMtPmxlZF9jbGFzc2Rldl9icmlnaHRuZXNz
X3NldDsNCj4gKw0KPiArCXNucHJpbnRmKHByaXYtPmxlZF9uYW1lLCBzaXplb2YocHJpdi0+bGVk
X25hbWUpLA0KPiArCQkgInJ0bDh4eHh1LXVzYiVzIiwgZGV2X25hbWUoJnByaXYtPnVkZXYtPmRl
dikpOw0KPiArCWxlZC0+bmFtZSA9IHByaXYtPmxlZF9uYW1lOw0KPiArCWxlZC0+bWF4X2JyaWdo
dG5lc3MgPSBSVEw4WFhYVV9IV19MRURfQ09OVFJPTDsNCj4gKw0KPiArCWlmIChsZWRfY2xhc3Nk
ZXZfcmVnaXN0ZXIoJnByaXYtPnVkZXYtPmRldiwgbGVkKSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+
ICsJcHJpdi0+bGVkX3JlZ2lzdGVyZWQgPSB0cnVlOw0KPiArDQo+ICsJbGVkLT5icmlnaHRuZXNz
ID0gbGVkLT5tYXhfYnJpZ2h0bmVzczsNCj4gKwlwcml2LT5mb3BzLT5sZWRfY2xhc3NkZXZfYnJp
Z2h0bmVzc19zZXQobGVkLCBsZWQtPmJyaWdodG5lc3MpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMg
dm9pZCBydGw4eHh4dV9kZWluaXRfbGVkKHN0cnVjdCBydGw4eHh4dV9wcml2ICpwcml2KQ0KPiAr
ew0KPiArCXN0cnVjdCBsZWRfY2xhc3NkZXYgKmxlZCA9ICZwcml2LT5sZWRfY2RldjsNCj4gKw0K
PiArCXByaXYtPmZvcHMtPmxlZF9jbGFzc2Rldl9icmlnaHRuZXNzX3NldChsZWQsIExFRF9PRkYp
Ow0KPiArCWxlZF9jbGFzc2Rldl91bnJlZ2lzdGVyKGxlZCk7DQo+ICt9DQo+ICsNCj4gIHN0YXRp
YyBpbnQgcnRsOHh4eHVfcHJvYmUoc3RydWN0IHVzYl9pbnRlcmZhY2UgKmludGVyZmFjZSwNCj4g
IAkJCSAgY29uc3Qgc3RydWN0IHVzYl9kZXZpY2VfaWQgKmlkKQ0KPiAgew0KPiBAQCAtNzEzNSw2
ICs3MTYzLDkgQEAgc3RhdGljIGludCBydGw4eHh4dV9wcm9iZShzdHJ1Y3QgdXNiX2ludGVyZmFj
ZSAqaW50ZXJmYWNlLA0KPiAgCQlnb3RvIGVycl9zZXRfaW50ZmRhdGE7DQo+ICAJfQ0KPiANCj4g
KwlpZiAocHJpdi0+Zm9wcy0+bGVkX2NsYXNzZGV2X2JyaWdodG5lc3Nfc2V0KQ0KDQpJIHByZWZl
ciB0byBtb3ZlIHRoaXMgY2hlY2tpbmcgc3RhdGVtZW50IGludG8gcnRsOHh4eHVfaW5pdF9sZWQo
KS4gVGhlbiwNCnRoZSBmbG93IG9mIHJ0bDh4eHh1X3Byb2JlKCkgbG9va3MgY2xlYW4uIEFzIHdl
bGwgYXMgcnRsOHh4eHVfZGVpbml0X2xlZCgpLg0KSnVzdCBzb2Z0IHN1Z2dlc3Rpb24uDQoNCj4g
KwkJcnRsOHh4eHVfaW5pdF9sZWQocHJpdik7DQo+ICsNCj4gIAlyZXR1cm4gMDsNCj4gDQo+ICBl
cnJfc2V0X2ludGZkYXRhOg0KPiBAQCAtNzE1OSw2ICs3MTkwLDkgQEAgc3RhdGljIHZvaWQgcnRs
OHh4eHVfZGlzY29ubmVjdChzdHJ1Y3QgdXNiX2ludGVyZmFjZSAqaW50ZXJmYWNlKQ0KPiAgCWh3
ID0gdXNiX2dldF9pbnRmZGF0YShpbnRlcmZhY2UpOw0KPiAgCXByaXYgPSBody0+cHJpdjsNCj4g
DQo+ICsJaWYgKHByaXYtPmxlZF9yZWdpc3RlcmVkKQ0KPiArCQlydGw4eHh4dV9kZWluaXRfbGVk
KHByaXYpOw0KPiArDQo+ICAJaWVlZTgwMjExX3VucmVnaXN0ZXJfaHcoaHcpOw0KPiANCj4gIAlw
cml2LT5mb3BzLT5wb3dlcl9vZmYocHJpdik7DQo+IC0tDQo+IDIuMzguMA0KPiANCj4gLS0tLS0t
UGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlLW1h
aWwuDQo=
