Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7E664C2F1
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 04:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbiLND6u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Dec 2022 22:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbiLND6s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Dec 2022 22:58:48 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FBF414038
        for <linux-wireless@vger.kernel.org>; Tue, 13 Dec 2022 19:58:47 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BE3vslE7030736, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BE3vslE7030736
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 14 Dec 2022 11:57:54 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 14 Dec 2022 11:58:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 14 Dec 2022 11:58:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Wed, 14 Dec 2022 11:58:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
Subject: RE: [PATCH v2 1/5] wifi: rtl8xxxu: Deduplicate the efuse dumping code
Thread-Topic: [PATCH v2 1/5] wifi: rtl8xxxu: Deduplicate the efuse dumping
 code
Thread-Index: AQHZDxgjr9H+heonc0atvavXN3M/9a5sjprQ
Date:   Wed, 14 Dec 2022 03:58:42 +0000
Message-ID: <40b9a6949d22484493e49af0200ca65d@realtek.com>
References: <c9619d20-ba6b-1611-dafb-9fe14617e1ee@gmail.com>
In-Reply-To: <c9619d20-ba6b-1611-dafb-9fe14617e1ee@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzE0IOS4iuWNiCAxMjo0NjowMA==?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIg
MTQsIDIwMjIgMToyNyBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT47IEFuZHJlYSBNZXJlbGxvDQo+IDxhbmRyZWEubWVyZWxsb0Bn
bWFpbC5jb20+OyBUYWVoZWUgWW9vIDxhcDQyMDA3M0BnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSCB2MiAxLzVdIHdpZmk6IHJ0bDh4eHh1OiBEZWR1cGxpY2F0ZSB0aGUgZWZ1c2UgZHVtcGlu
ZyBjb2RlDQo+IA0KPiBFdmVyeSBjaGlwIGZhbWlseSBleGNlcHQgUlRMODcyM0FVIGhhcyBhIGNv
cHkgb2YgdGhlIGVmdXNlIGR1bXBpbmcNCj4gY29kZS4gUmVtb3ZlIHRoaXMgYW5kIGR1bXAgdGhl
IGVmdXNlIGZyb20gYSBzaW5nbGUgcGxhY2UgdXNpbmcgYSBuZXcNCj4gZnVuY3Rpb24gcnRsOHh4
eHVfZHVtcF9lZnVzZSgpLg0KPiANCj4gQWxzbywgdXNlIHByaW50X2hleF9kdW1wKCkgdG8gcHJp
bnQgdGhlIGVmdXNlIGluc3RlYWQgb2YgYSBsb29wIGFuZA0KPiBkZXZfaW5mbygpLiBJdCBzaG93
cyB0aGUgQVNDSUkgaW50ZXJwcmV0YXRpb24gb2YgdGhlIGJ5dGVzLCB3aGljaCBpcw0KPiBuaWNl
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBn
bWFpbC5jb20+DQo+IC0tLQ0KPiB2MjoNCj4gIC0gUGF0Y2ggaXMgbmV3IGluIHYyLg0KPiAtLS0N
Cj4gIC4uLi9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV84MTg4Zi5jIHwg
MTEgLS0tLS0tLS0tLS0NCj4gIC4uLi9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4
eHh4dV84MTkyYy5jIHwgMTAgLS0tLS0tLS0tLQ0KPiAgLi4uL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0bDh4eHh1L3J0bDh4eHh1XzgxOTJlLmMgfCAgOSAtLS0tLS0tLS0NCj4gIC4uLi9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV84NzIzYi5jIHwgMTEgLS0tLS0tLS0tLS0N
Cj4gIC4uLi9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMgIHwg
MTQgKysrKysrKysrKysrKysNCj4gIDUgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwg
NDEgZGVsZXRpb25zKC0pDQo+IA0KDQpbLi4uXQ0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IGluZGV4IDNl
ZDQzNTQwMWU1Ny4uODI3NjcyY2U5NTNkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBAQCAtMTgxMyw2
ICsxODEzLDE3IEBAIHN0YXRpYyBpbnQgcnRsOHh4eHVfcmVhZF9lZnVzZShzdHJ1Y3QgcnRsOHh4
eHVfcHJpdiAqcHJpdikNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiANCj4gK3N0YXRpYyB2b2lk
IHJ0bDh4eHh1X2R1bXBfZWZ1c2Uoc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYpDQo+ICt7DQo+
ICsJZGV2X2luZm8oJnByaXYtPnVkZXYtPmRldiwNCj4gKwkJICJEdW1waW5nIGVmdXNlIGZvciBS
VEwlcyAoMHglMDJ4IGJ5dGVzKTpcbiIsDQo+ICsJCSBwcml2LT5jaGlwX25hbWUsIEVGVVNFX1JF
QUxfQ09OVEVOVF9MRU5fODcyM0EpOw0KPiArDQo+ICsJcHJpbnRfaGV4X2R1bXAoS0VSTl9JTkZP
LCAiIiwgRFVNUF9QUkVGSVhfT0ZGU0VULCAxNiwgMSwNCj4gKwkJICAgICAgIHByaXYtPmVmdXNl
X3dpZmkucmF3LCBFRlVTRV9SRUFMX0NPTlRFTlRfTEVOXzg3MjNBLA0KDQpFRlVTRV9NQVBfTEVO
IHNlZW1zIHRvIGJlIG1vcmUgc3VpdGFibGUsIGJlY2F1c2U6DQoNCgl1bmlvbiB7DQoJCXU4IHJh
d1tFRlVTRV9NQVBfTEVOXTsNCgkJLi4uDQoJfSBlZnVzZV93aWZpOw0KDQphbmQsIHN1ZmZpeCBf
ODcyM0EgaXMgd2VpcmQgdG8gbWUuDQoNCj4gKwkJICAgICAgIHRydWUpOw0KPiArfQ0KPiArDQo+
ICB2b2lkIHJ0bDh4eHh1X3Jlc2V0XzgwNTEoc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYpDQo+
ICB7DQo+ICAJdTggdmFsODsNCj4gQEAgLTY4MzksNiArNjg1MCw5IEBAIHN0YXRpYyBpbnQgcnRs
OHh4eHVfcHJvYmUoc3RydWN0IHVzYl9pbnRlcmZhY2UgKmludGVyZmFjZSwNCj4gIAkJZ290byBl
cnJfc2V0X2ludGZkYXRhOw0KPiAgCX0NCj4gDQo+ICsJaWYgKHJ0bDh4eHh1X2RlYnVnICYgUlRM
OFhYWFVfREVCVUdfRUZVU0UpDQo+ICsJCXJ0bDh4eHh1X2R1bXBfZWZ1c2UocHJpdik7DQo+ICsN
Cj4gIAlydGw4eHh4dV9wcmludF9jaGlwaW5mbyhwcml2KTsNCj4gDQo+ICAJcmV0ID0gcHJpdi0+
Zm9wcy0+bG9hZF9maXJtd2FyZShwcml2KTsNCj4gLS0NCj4gMi4zOC4wDQo+IA0KPiAtLS0tLS1Q
bGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUtbWFp
bC4NCg==
