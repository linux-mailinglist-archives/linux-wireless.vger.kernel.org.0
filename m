Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BEF672D5D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 01:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjASAZq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 19:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjASAZp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 19:25:45 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74D425F3A5
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 16:25:42 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30J0PauoE001549, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30J0PauoE001549
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 19 Jan 2023 08:25:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 19 Jan 2023 08:25:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 19 Jan 2023 08:25:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Thu, 19 Jan 2023 08:25:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 1/4] wifi: rtl8xxxu: Register the LED and make it blink
Thread-Topic: [PATCH 1/4] wifi: rtl8xxxu: Register the LED and make it blink
Thread-Index: AQHZKr96qNWty18lDUSa9x9d5F0XZK6jV9UQgABU6ICAATS8MA==
Date:   Thu, 19 Jan 2023 00:25:37 +0000
Message-ID: <ec33046591ca4838aacccdd7dd547ea3@realtek.com>
References: <5c03ae42-a2fd-b39a-e754-f52d8528a167@gmail.com>
 <f2f52496d4274861b5870c1f425fa8e8@realtek.com>
 <668921d6-cff5-7b42-3406-f42f445a15ef@gmail.com>
In-Reply-To: <668921d6-cff5-7b42-3406-f42f445a15ef@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTgg5LiL5Y2IIDEwOjAwOjAw?=
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
OCwgMjAyMyA5OjUzIFBNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47
IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogSmVzIFNvcmVuc2VuIDxKZXMu
U29yZW5zZW5AZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gd2lmaTogcnRs
OHh4eHU6IFJlZ2lzdGVyIHRoZSBMRUQgYW5kIG1ha2UgaXQgYmxpbmsNCj4gDQo+IE9uIDE4LzAx
LzIwMjMgMDI6NTIsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFj
ZXJmZTJAZ21haWwuY29tPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMTgsIDIwMjMg
NjowMyBBTQ0KPiA+PiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+ID4+IENj
OiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT4NCj4gPj4gU3ViamVjdDogW1BBVENIIDEvNF0gd2lmaTogcnRsOHh4
eHU6IFJlZ2lzdGVyIHRoZSBMRUQgYW5kIG1ha2UgaXQgYmxpbmsNCj4gPj4NCj4gPj4gSWYgdGhl
IGNoaXAgY2FuIGhhdmUgYW4gTEVELCByZWdpc3RlciBhIHN0cnVjdCBsZWRfY2xhc3NkZXYgYW5k
IGVuYWJsZQ0KPiA+PiBoYXJkd2FyZS1jb250cm9sbGVkIGJsaW5raW5nLiBXaGVuIHRoZSBjaGlw
IGlzIG5vdCB0cmFuc21pdHRpbmcgb3INCj4gPj4gcmVjZWl2aW5nIGFueXRoaW5nIHRoZSBMRUQg
aXMgb2ZmLiBPdGhlcndpc2UgdGhlIExFRCB3aWxsIGJsaW5rDQo+ID4+IGZhc3RlciBvciBzbG93
ZXIgYWNjb3JkaW5nIHRvIHRoZSB0aHJvdWdocHV0Lg0KPiA+Pg0KPiA+PiBUaGUgTEVEIGNhbiBi
ZSBjb250cm9sbGVkIGZyb20gdXNlcnNwYWNlIGJ5IHdyaXRpbmcgMCwgMSwgb3IgMiB0bw0KPiA+
PiAvc3lzL2NsYXNzL2xlZHMvcnRsOHh4eHUtdXNiWC1ZL2JyaWdodG5lc3M6DQo+ID4+IDAgLSBz
b2xpZCBvZmYuDQo+ID4+IDEgLSBzb2xpZCBvbi4NCj4gPj4gMiAtIGhhcmR3YXJlLWNvbnRyb2xs
ZWQgYmxpbmtpbmcuDQo+ID4NCj4gPiBTbywgZG8geW91IGxpa2UNCj4gPg0KPiA+ICNkZWZpbmUg
UlRMOFhYWFVfSFdfTEVEX0JMSU5LSU5HCTINCj4gPg0KPiBJJ20gbm90IHN1cmUgd2hhdCB5b3Ug
bWVhbi4gQ2FuIHlvdSBlbGFib3JhdGU/DQoNCk9yaWdpbmFsbHksIEkgd291bGQgbGlrZSB0byBy
ZXBsYWNlIFJUTDhYWFhVX0hXX0xFRF9DT05UUk9MIGJ5DQpSVEw4WFhYVV9IV19MRURfQkxJTktJ
TkcsIGJlY2F1c2UgY29tbWl0IG1lc3NhZ2VzIHNheSAiYmxpbmtpbmciLiANCkFmdGVyIHJldmll
d2luZyAyLzQsIDMvNCBhbmQgNC80LCBJIGF3YXJlIHRoYXQgdGhpcyBibGlua2luZyBpcw0KaGFy
ZHdhcmUgYmVoYXZpb3IuIFRoZW4sIGl0IGJlY29tZXMgaGFyZCB0byBtZSB0byBkZWNpZGUgd2hp
Y2gNCm5hbWUgaXMgY2xlYXIuIEFueXdheSwgb3JpZ2luYWwgaXMgZmluZSB0byBtZS4NCg0KPiAN
Cj4gPj4NCj4gPj4gSW4gdGhpcyBwYXRjaCBub25lIG9mIHRoZSBjaGlwcyBhZHZlcnRpc2UgaGF2
aW5nIGFuIExFRC4gVGhhdCB3aWxsIGJlDQo+ID4+IGFkZGVkIGluIHRoZSBuZXh0IHBhdGNoZXMu
DQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJm
ZTJAZ21haWwuY29tPg0KPiA+PiAtLS0NCj4gPj4gIC4uLi9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dGw4eHh4dS9ydGw4eHh4dS5oICB8ICA4ICsrKysrDQo+ID4+ICAuLi4vd2lyZWxlc3MvcmVhbHRl
ay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMgfCAzNCArKysrKysrKysrKysrKysrKysrDQo+ID4+
ICAyIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKykNCj4gPj4NCj4gPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHUuaA0KPiA+
PiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHUuaA0KPiA+
PiBpbmRleCA5MDI2ODQ3OWQzYWQuLmM4Y2VlNGEyNDc1NSAxMDA2NDQNCj4gPj4gLS0tIGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dS5oDQo+ID4+ICsrKyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHUuaA0KPiA+PiBA
QCAtMTQ0Myw2ICsxNDQzLDggQEAgc3RydWN0IHJ0bDh4eHh1X2Nmb190cmFja2luZyB7DQo+ID4+
ICAJdTMyIHBhY2tldF9jb3VudF9wcmU7DQo+ID4+ICB9Ow0KPiA+Pg0KPiA+PiArI2RlZmluZSBS
VEw4WFhYVV9IV19MRURfQ09OVFJPTAkyDQo+ID4+ICsNCj4gPj4gIHN0cnVjdCBydGw4eHh4dV9w
cml2IHsNCj4gPj4gIAlzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodzsNCj4gPj4gIAlzdHJ1Y3QgdXNi
X2RldmljZSAqdWRldjsNCj4gPj4gQEAgLTE1NjQsNiArMTU2NiwxMCBAQCBzdHJ1Y3QgcnRsOHh4
eHVfcHJpdiB7DQo+ID4+ICAJc3RydWN0IHJ0bDh4eHh1X3JhX3JlcG9ydCByYV9yZXBvcnQ7DQo+
ID4+ICAJc3RydWN0IHJ0bDh4eHh1X2Nmb190cmFja2luZyBjZm9fdHJhY2tpbmc7DQo+ID4+ICAJ
c3RydWN0IHJ0bDh4eHh1X3JhX2luZm8gcmFfaW5mbzsNCj4gPj4gKw0KPiA+PiArCWJvb2wgbGVk
X3JlZ2lzdGVyZWQ7DQo+ID4+ICsJY2hhciBsZWRfbmFtZVszMl07DQo+ID4+ICsJc3RydWN0IGxl
ZF9jbGFzc2RldiBsZWRfY2RldjsNCj4gPj4gIH07DQo+ID4+DQo+ID4+ICBzdHJ1Y3QgcnRsOHh4
eHVfcnhfdXJiIHsNCj4gPj4gQEAgLTE2MTMsNiArMTYxOSw4IEBAIHN0cnVjdCBydGw4eHh4dV9m
aWxlb3BzIHsNCj4gPj4gIAkJCSAgICAgdTMyIHJ0c19yYXRlKTsNCj4gPj4gIAl2b2lkICgqc2V0
X2NyeXN0YWxfY2FwKSAoc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYsIHU4IGNyeXN0YWxfY2Fw
KTsNCj4gPj4gIAlzOCAoKmNja19yc3NpKSAoc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYsIHU4
IGNja19hZ2NfcnB0KTsNCj4gPj4gKwlpbnQgKCpsZWRfY2xhc3NkZXZfYnJpZ2h0bmVzc19zZXQp
IChzdHJ1Y3QgbGVkX2NsYXNzZGV2ICpsZWRfY2RldiwNCj4gPj4gKwkJCQkJICAgIGVudW0gbGVk
X2JyaWdodG5lc3MgYnJpZ2h0bmVzcyk7DQo+ID4+ICAJaW50IHdyaXRlTl9ibG9ja19zaXplOw0K
PiA+PiAgCWludCByeF9hZ2dfYnVmX3NpemU7DQo+ID4+ICAJY2hhciB0eF9kZXNjX3NpemU7DQo+
ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0
bDh4eHh1X2NvcmUuYw0KPiA+PiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4
eHUvcnRsOHh4eHVfY29yZS5jDQo+ID4+IGluZGV4IDM1ZGM3NzdjMWZiYS4uYjI3ZWRkNTAzYzIz
IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1
L3J0bDh4eHh1X2NvcmUuYw0KPiA+PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiA+PiBAQCAtNjk1NSw2ICs2OTU1LDM0IEBAIHN0
YXRpYyBpbnQgcnRsOHh4eHVfcGFyc2VfdXNiKHN0cnVjdCBydGw4eHh4dV9wcml2ICpwcml2LA0K
PiA+PiAgCXJldHVybiByZXQ7DQo+ID4+ICB9DQo+ID4+DQo+ID4+ICtzdGF0aWMgdm9pZCBydGw4
eHh4dV9pbml0X2xlZChzdHJ1Y3QgcnRsOHh4eHVfcHJpdiAqcHJpdikNCj4gPj4gK3sNCj4gPj4g
KwlzdHJ1Y3QgbGVkX2NsYXNzZGV2ICpsZWQgPSAmcHJpdi0+bGVkX2NkZXY7DQo+ID4+ICsNCj4g
Pj4gKwlsZWQtPmJyaWdodG5lc3Nfc2V0X2Jsb2NraW5nID0gcHJpdi0+Zm9wcy0+bGVkX2NsYXNz
ZGV2X2JyaWdodG5lc3Nfc2V0Ow0KPiA+PiArDQo+ID4+ICsJc25wcmludGYocHJpdi0+bGVkX25h
bWUsIHNpemVvZihwcml2LT5sZWRfbmFtZSksDQo+ID4+ICsJCSAicnRsOHh4eHUtdXNiJXMiLCBk
ZXZfbmFtZSgmcHJpdi0+dWRldi0+ZGV2KSk7DQo+ID4+ICsJbGVkLT5uYW1lID0gcHJpdi0+bGVk
X25hbWU7DQo+ID4+ICsJbGVkLT5tYXhfYnJpZ2h0bmVzcyA9IFJUTDhYWFhVX0hXX0xFRF9DT05U
Uk9MOw0KPiA+PiArDQo+ID4+ICsJaWYgKGxlZF9jbGFzc2Rldl9yZWdpc3RlcigmcHJpdi0+dWRl
di0+ZGV2LCBsZWQpKQ0KPiA+PiArCQlyZXR1cm47DQo+ID4+ICsNCj4gPj4gKwlwcml2LT5sZWRf
cmVnaXN0ZXJlZCA9IHRydWU7DQo+ID4+ICsNCj4gPj4gKwlsZWQtPmJyaWdodG5lc3MgPSBsZWQt
Pm1heF9icmlnaHRuZXNzOw0KPiA+PiArCXByaXYtPmZvcHMtPmxlZF9jbGFzc2Rldl9icmlnaHRu
ZXNzX3NldChsZWQsIGxlZC0+YnJpZ2h0bmVzcyk7DQo+ID4+ICt9DQo+ID4+ICsNCj4gPj4gK3N0
YXRpYyB2b2lkIHJ0bDh4eHh1X2RlaW5pdF9sZWQoc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYp
DQo+ID4+ICt7DQo+ID4+ICsJc3RydWN0IGxlZF9jbGFzc2RldiAqbGVkID0gJnByaXYtPmxlZF9j
ZGV2Ow0KPiA+PiArDQo+ID4+ICsJcHJpdi0+Zm9wcy0+bGVkX2NsYXNzZGV2X2JyaWdodG5lc3Nf
c2V0KGxlZCwgTEVEX09GRik7DQo+ID4+ICsJbGVkX2NsYXNzZGV2X3VucmVnaXN0ZXIobGVkKTsN
Cj4gPj4gK30NCj4gPj4gKw0KPiA+PiAgc3RhdGljIGludCBydGw4eHh4dV9wcm9iZShzdHJ1Y3Qg
dXNiX2ludGVyZmFjZSAqaW50ZXJmYWNlLA0KPiA+PiAgCQkJICBjb25zdCBzdHJ1Y3QgdXNiX2Rl
dmljZV9pZCAqaWQpDQo+ID4+ICB7DQo+ID4+IEBAIC03MTM1LDYgKzcxNjMsOSBAQCBzdGF0aWMg
aW50IHJ0bDh4eHh1X3Byb2JlKHN0cnVjdCB1c2JfaW50ZXJmYWNlICppbnRlcmZhY2UsDQo+ID4+
ICAJCWdvdG8gZXJyX3NldF9pbnRmZGF0YTsNCj4gPj4gIAl9DQo+ID4+DQo+ID4+ICsJaWYgKHBy
aXYtPmZvcHMtPmxlZF9jbGFzc2Rldl9icmlnaHRuZXNzX3NldCkNCj4gPg0KPiA+IEkgcHJlZmVy
IHRvIG1vdmUgdGhpcyBjaGVja2luZyBzdGF0ZW1lbnQgaW50byBydGw4eHh4dV9pbml0X2xlZCgp
LiBUaGVuLA0KPiA+IHRoZSBmbG93IG9mIHJ0bDh4eHh1X3Byb2JlKCkgbG9va3MgY2xlYW4uIEFz
IHdlbGwgYXMgcnRsOHh4eHVfZGVpbml0X2xlZCgpLg0KPiA+IEp1c3Qgc29mdCBzdWdnZXN0aW9u
Lg0KPiA+DQo+IE9rYXkuIFRoYXQgd29ya3MgdG9vLg0KPiANCj4gPj4gKwkJcnRsOHh4eHVfaW5p
dF9sZWQocHJpdik7DQo+ID4+ICsNCj4gPj4gIAlyZXR1cm4gMDsNCj4gPj4NCj4gPj4gIGVycl9z
ZXRfaW50ZmRhdGE6DQo+ID4+IEBAIC03MTU5LDYgKzcxOTAsOSBAQCBzdGF0aWMgdm9pZCBydGw4
eHh4dV9kaXNjb25uZWN0KHN0cnVjdCB1c2JfaW50ZXJmYWNlICppbnRlcmZhY2UpDQo+ID4+ICAJ
aHcgPSB1c2JfZ2V0X2ludGZkYXRhKGludGVyZmFjZSk7DQo+ID4+ICAJcHJpdiA9IGh3LT5wcml2
Ow0KPiA+Pg0KPiA+PiArCWlmIChwcml2LT5sZWRfcmVnaXN0ZXJlZCkNCj4gPj4gKwkJcnRsOHh4
eHVfZGVpbml0X2xlZChwcml2KTsNCj4gPj4gKw0KPiA+PiAgCWllZWU4MDIxMV91bnJlZ2lzdGVy
X2h3KGh3KTsNCj4gPj4NCj4gPj4gIAlwcml2LT5mb3BzLT5wb3dlcl9vZmYocHJpdik7DQo+ID4+
IC0tDQo+ID4+IDIuMzguMA0KPiA+Pg0KPiA+PiAtLS0tLS1QbGVhc2UgY29uc2lkZXIgdGhlIGVu
dmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUtbWFpbC4NCg0K
