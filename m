Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2759A6220EB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 01:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKIAlv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 19:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKIAlu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 19:41:50 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA65912743
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 16:41:49 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2A90f7oP5009324, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2A90f7oP5009324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 9 Nov 2022 08:41:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 9 Nov 2022 08:41:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 9 Nov 2022 08:41:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Wed, 9 Nov 2022 08:41:45 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 1/3] wifi: rtl8xxxu: Name some bits used in burst init
Thread-Topic: [PATCH 1/3] wifi: rtl8xxxu: Name some bits used in burst init
Thread-Index: AQHY86OBdduXnERdvUuNUNKw7P+HbK41vvMA
Date:   Wed, 9 Nov 2022 00:41:45 +0000
Message-ID: <c357973fd0e547e69c03a8d7cfc092d2@realtek.com>
References: <91f59414-86f7-f0ed-a138-19f0ab63bb0b@gmail.com>
In-Reply-To: <91f59414-86f7-f0ed-a138-19f0ab63bb0b@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzgg5LiL5Y2IIDEwOjI4OjAw?=
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJpdHRlcmJsdWUgU21pdGgg
PHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDks
IDIwMjIgMjo1NCBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDEvM10gd2lmaTogcnRsOHh4eHU6
IE5hbWUgc29tZSBiaXRzIHVzZWQgaW4gYnVyc3QgaW5pdA0KPiANCj4gTmFtZXMgcHJvdmlkZWQg
YnkgUGluZy1LZSBTaGloLg0KDQpIYS4gVGhhdCBsb29rcyB3ZWlyZCB0byBzZWUgbXkgbmFtZSBp
biBjb21taXQgbWVzc2FnZS4gQ291bGQgeW91IHNheQ0KInVzZSBkZXNjcmlwdGl2ZSBuYW1lcyBp
bnN0ZWFkIG9mIG1hZ2ljIG51bWJlciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdD8NCg0KPiANCj4g
U3VnZ2VzdGVkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IC0t
LQ0KPiBUaGlzIHBhdGNoIHNob3VsZCBiZSBhcHBsaWVkIGFmdGVyIG15IG9sZGVyIHBhdGNoOg0K
PiAiW1BBVENIIHYyIDEvM10gd2lmaTogcnRsOHh4eHU6IE1vdmUgYnVyc3QgaW5pdCB0byBhIGZ1
bmN0aW9u4oCLIg0KDQpGb3IgbWUsIEkgaGF2ZSByZXZpZXdlZCB0aGUgZm9ybWVyIHBhdGNoc2V0
LCBzbyBpdCBpcyBmaW5lIHRvIG1lLg0KQnV0LCBJJ20gbm90IHN1cmUgaWYgb3RoZXIgcGVvcGxl
IHdhbnQgeW91IHRvIGNoYW5nZSBzb21ldGhpbmcNCmluIHRoZSBmb3JtZXIgcGF0Y2hzZXQgYnV0
IHlvdSBmaXggdGhlbSBpbiB0aGlzIHBhdGNoc2V0Lg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMgfCAxMCArKysrKy0tLS0t
DQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X3JlZ3Mu
aCB8ICA2ICsrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gaW5kZXggODM5ZTA1NDZmNWVjLi5lNGVi
MTdkMDNjZDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRs
OHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IEBAIC0zNzg2LDE2ICszNzg2LDE2IEBAIHZv
aWQgcnRsOHh4eHVfaW5pdF9idXJzdChzdHJ1Y3QgcnRsOHh4eHVfcHJpdiAqcHJpdikNCj4gIAkg
KiBGb3IgVVNCIGhpZ2ggc3BlZWQgc2V0IDUxMkIgcGFja2V0cw0KPiAgCSAqLw0KPiAgCXZhbDgg
PSBydGw4eHh4dV9yZWFkOChwcml2LCBSRUdfUlhETUFfUFJPXzg3MjNCKTsNCj4gLQl2YWw4ICY9
IH4oQklUKDQpIHwgQklUKDUpKTsNCj4gLQl2YWw4IHw9IEJJVCg0KTsNCj4gLQl2YWw4IHw9IEJJ
VCgxKSB8IEJJVCgyKSB8IEJJVCgzKTsNCj4gKwl1OHBfcmVwbGFjZV9iaXRzKCZ2YWw4LCAxLCBS
WERNQV9QUk9fRE1BX0JVUlNUX1NJWkUpOw0KPiArCXU4cF9yZXBsYWNlX2JpdHMoJnZhbDgsIDMs
IFJYRE1BX1BST19ETUFfQlVSU1RfQ05UKTsNCj4gKwl2YWw4IHw9IFJYRE1BX1BST19ETUFfTU9E
RTsNCj4gIAlydGw4eHh4dV93cml0ZTgocHJpdiwgUkVHX1JYRE1BX1BST184NzIzQiwgdmFsOCk7
DQo+IA0KPiAgCS8qDQo+ICAJICogRW5hYmxlIHNpbmdsZSBwYWNrZXQgQU1QRFUNCj4gIAkgKi8N
Cj4gIAl2YWw4ID0gcnRsOHh4eHVfcmVhZDgocHJpdiwgUkVHX0hUX1NJTkdMRV9BTVBEVV84NzIz
Qik7DQo+IC0JdmFsOCB8PSBCSVQoNyk7DQo+ICsJdmFsOCB8PSBIVF9TSU5HTEVfQU1QRFVfRU5B
QkxFOw0KPiAgCXJ0bDh4eHh1X3dyaXRlOChwcml2LCBSRUdfSFRfU0lOR0xFX0FNUERVXzg3MjNC
LCB2YWw4KTsNCj4gDQo+ICAJcnRsOHh4eHVfd3JpdGUxNihwcml2LCBSRUdfTUFYX0FHR1JfTlVN
LCAweDBjMTQpOw0KPiBAQCAtMzgyMCw3ICszODIwLDcgQEAgdm9pZCBydGw4eHh4dV9pbml0X2J1
cnN0KHN0cnVjdCBydGw4eHh4dV9wcml2ICpwcml2KQ0KPiANCj4gIAkvKiB0byBwcmV2ZW50IG1h
YyBpcyByZXNldGVkIGJ5IGJ1cy4gKi8NCj4gIAl2YWw4ID0gcnRsOHh4eHVfcmVhZDgocHJpdiwg
UkVHX1JTVl9DVFJMKTsNCj4gLQl2YWw4IHw9IEJJVCg1KSB8IEJJVCg2KTsNCj4gKwl2YWw4IHw9
IFJTVl9DVFJMX1dMT0NLXzFDIHwgUlNWX0NUUkxfRElTX1BSU1Q7DQo+ICAJcnRsOHh4eHVfd3Jp
dGU4KHByaXYsIFJFR19SU1ZfQ1RSTCwgdmFsOCk7DQo+ICB9DQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9yZWdzLmgNCj4g
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X3JlZ3MuaA0K
PiBpbmRleCAwNGJmNzc5NTlmYmEuLjVkNGNhYzRmNGMwNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9yZWdzLmgNCj4gKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9yZWdzLmgNCj4g
QEAgLTY4LDYgKzY4LDggQEANCj4gICNkZWZpbmUgUkVHX1NQU19PQ1BfQ0ZHCQkJMHgwMDE4DQo+
ICAjZGVmaW5lIFJFR184MTkyRV9MRE9WMTJfQ1RSTAkJMHgwMDE0DQo+ICAjZGVmaW5lIFJFR19S
U1ZfQ1RSTAkJCTB4MDAxYw0KPiArI2RlZmluZSAgUlNWX0NUUkxfV0xPQ0tfMUMJCUJJVCg1KQ0K
PiArI2RlZmluZSAgUlNWX0NUUkxfRElTX1BSU1QJCUJJVCg2KQ0KPiANCj4gICNkZWZpbmUgUkVH
X1JGX0NUUkwJCQkweDAwMWYNCj4gICNkZWZpbmUgIFJGX0VOQUJMRQkJCUJJVCgwKQ0KPiBAQCAt
NDcyLDYgKzQ3NCw5IEBADQo+ICAvKiBQcmVzdW1hYmx5IG9ubHkgZm91bmQgb24gbmV3ZXIgY2hp
cHMgc3VjaCBhcyA4NzIzYnUgKi8NCj4gICNkZWZpbmUgUkVHX1JYX0RNQV9DVFJMXzg3MjNCCQkw
eDAyODYNCj4gICNkZWZpbmUgUkVHX1JYRE1BX1BST184NzIzQgkJMHgwMjkwDQo+ICsjZGVmaW5l
ICBSWERNQV9QUk9fRE1BX01PREUJCUJJVCgxKQkJLyogU2V0IHRvIDB4MS4gKi8NCj4gKyNkZWZp
bmUgIFJYRE1BX1BST19ETUFfQlVSU1RfQ05UCUdFTk1BU0soMywgMikJLyogU2V0IHRvIDB4My4g
Ki8NCj4gKyNkZWZpbmUgIFJYRE1BX1BST19ETUFfQlVSU1RfU0laRQlHRU5NQVNLKDUsIDQpCS8q
IFNldCB0byAweDEuICovDQo+IA0KPiAgI2RlZmluZSBSRUdfUkZfQkJfQ01EX0FERFIJCTB4MDJj
MA0KPiAgI2RlZmluZSBSRUdfUkZfQkJfQ01EX0RBVEEJCTB4MDJjNA0KPiBAQCAtNTc3LDYgKzU4
Miw3IEBADQo+ICAjZGVmaW5lIFJFR19TVEJDX1NFVFRJTkcJCTB4MDRjNA0KPiAgI2RlZmluZSBS
RUdfUVVFVUVfQ1RSTAkJCTB4MDRjNg0KPiAgI2RlZmluZSBSRUdfSFRfU0lOR0xFX0FNUERVXzg3
MjNCCTB4MDRjNw0KPiArI2RlZmluZSAgSFRfU0lOR0xFX0FNUERVX0VOQUJMRQkJQklUKDcpDQo+
ICAjZGVmaW5lIFJFR19QUk9UX01PREVfQ1RSTAkJMHgwNGM4DQo+ICAjZGVmaW5lIFJFR19NQVhf
QUdHUl9OVU0JCTB4MDRjYQ0KPiAgI2RlZmluZSBSRUdfUlRTX01BWF9BR0dSX05VTQkJMHgwNGNi
DQo+IC0tDQo+IDIuMzguMA0KPiANCj4gLS0tLS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9u
bWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlLW1haWwuDQo=
