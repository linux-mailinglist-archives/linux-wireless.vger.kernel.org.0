Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C8765BB94
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 09:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjACIGL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 03:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjACIGH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 03:06:07 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C42842A5
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 00:06:01 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 303851UN0017507, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 303851UN0017507
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 3 Jan 2023 16:05:01 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 3 Jan 2023 16:05:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 3 Jan 2023 16:05:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Tue, 3 Jan 2023 16:05:56 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 1/2] wifi: rtl8xxxu: Report the RSSI to the firmware
Thread-Topic: [PATCH 1/2] wifi: rtl8xxxu: Report the RSSI to the firmware
Thread-Index: AQHZHG8dTTwBH5VVDk24fOPPF0Tp666MWl6w
Date:   Tue, 3 Jan 2023 08:05:56 +0000
Message-ID: <ec58ba471076464282fdd1ce7d093449@realtek.com>
References: <6fcaaead-876c-68d1-a049-f1e7f7ff81e7@gmail.com>
In-Reply-To: <6fcaaead-876c-68d1-a049-f1e7f7ff81e7@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMyDkuIrljYggMDY6MDA6MDA=?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBEZWNlbWJlciAz
MSwgMjAyMiAxMjo1MiBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDEvMl0gd2lmaTogcnRsOHh4
eHU6IFJlcG9ydCB0aGUgUlNTSSB0byB0aGUgZmlybXdhcmUNCj4gDQo+IE9yIGluIHRoZSBjYXNl
IG9mIFJUTDgxODhFVSwgcmVwb3J0IHRoZSBSU1NJIHRvIHRoZSByYXRlIGNvbnRyb2wgY29kZS4N
Cj4gDQo+IFRoZSByYXRlIGNvbnRyb2wgY29kZSBmb3IgUlRMODE4OEVVIGlzIGxlc3MgbGlrZWx5
IHRvIHN3aXRjaCB0byBhIGxvd2VyDQo+IHJhdGUgd2hlbiB0aGUgUlNTSSBpcyBoaWdoLiBUaGUg
ZmlybXdhcmUtYmFzZWQgcmF0ZSBjb250cm9sIGluIHRoZSBvdGhlcg0KPiBjaGlwcyBwcm9iYWJs
eSB3b3JrcyB0aGUgc2FtZSB3YXkuDQo+IA0KPiBUaGlzIGFmZmVjdHMgYWxsIHRoZSBjaGlwcywg
YnV0IGl0IHdhcyBvbmx5IHRlc3RlZCB3aXRoIFJUTDgxODhFVSwNCj4gUlRMODE4OEZVLCBhbmQg
UlRMODE5MkVVLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgy
MWNlcmZlMkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgLi4uL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
bDh4eHh1L3J0bDh4eHh1LmggIHwgMjMgKysrKysrKysrKysrKw0KPiAgLi4uL3JlYWx0ZWsvcnRs
OHh4eHUvcnRsOHh4eHVfODE4OGUuYyAgICAgICAgIHwgIDYgKysrKw0KPiAgLi4uL3JlYWx0ZWsv
cnRsOHh4eHUvcnRsOHh4eHVfODE4OGYuYyAgICAgICAgIHwgIDEgKw0KPiAgLi4uL3JlYWx0ZWsv
cnRsOHh4eHUvcnRsOHh4eHVfODE5MmMuYyAgICAgICAgIHwgIDEgKw0KPiAgLi4uL3JlYWx0ZWsv
cnRsOHh4eHUvcnRsOHh4eHVfODE5MmUuYyAgICAgICAgIHwgIDEgKw0KPiAgLi4uL3JlYWx0ZWsv
cnRsOHh4eHUvcnRsOHh4eHVfODcyM2EuYyAgICAgICAgIHwgIDEgKw0KPiAgLi4uL3JlYWx0ZWsv
cnRsOHh4eHUvcnRsOHh4eHVfODcyM2IuYyAgICAgICAgIHwgIDEgKw0KPiAgLi4uL3dpcmVsZXNz
L3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jIHwgMzQgKysrKysrKysrKysrKysrKysr
Kw0KPiAgOCBmaWxlcyBjaGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspDQo+IA0KDQpbLi4uXQ0KDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4
eHh1X2NvcmUuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRs
OHh4eHVfY29yZS5jDQo+IGluZGV4IGZkOTdjMDQwOTQ4YS4uZjVmZDNjNDQ4NTg3IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2Nv
cmUuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4
eHh1X2NvcmUuYw0KPiBAQCAtNDQ2MSw2ICs0NDYxLDM3IEBAIHZvaWQgcnRsOHh4eHVfZ2VuMl9y
ZXBvcnRfY29ubmVjdChzdHJ1Y3QgcnRsOHh4eHVfcHJpdiAqcHJpdiwNCj4gIAlydGw4eHh4dV9n
ZW4yX2gyY19jbWQocHJpdiwgJmgyYywgc2l6ZW9mKGgyYy5tZWRpYV9zdGF0dXNfcnB0KSk7DQo+
ICB9DQo+IA0KPiArdm9pZCBydGw4eHh4dV9nZW4xX3JlcG9ydF9yc3NpKHN0cnVjdCBydGw4eHh4
dV9wcml2ICpwcml2LCB1OCBtYWNpZCwgdTggcnNzaSkNCj4gK3sNCj4gKwlzdHJ1Y3QgaDJjX2Nt
ZCBoMmM7DQo+ICsJY29uc3QgaW50IGgyY19zaXplID0gMzsNCg0KU2hvdWxkbid0IGl0IGJlIDQ/
DQoNCgkJc3RydWN0IHsNCgkJCXU4IGNtZDsNCgkJCXU4IG1hY2lkOw0KCQkJdTggdW5rbm93bjA7
DQoJCQl1OCByc3NpOyAgLy8geW91IGZpbGwgdGhpcyBmaWVsZC4NCg0KPiArDQo+ICsJbWVtc2V0
KCZoMmMsIDAsIHNpemVvZihzdHJ1Y3QgaDJjX2NtZCkpOw0KPiArDQo+ICsJaDJjLnJzc2lfcmVw
b3J0LmNtZCA9IEgyQ19TRVRfUlNTSTsNCj4gKwloMmMucnNzaV9yZXBvcnQubWFjaWQgPSBtYWNp
ZDsNCj4gKwloMmMucnNzaV9yZXBvcnQucnNzaSA9IHJzc2k7DQo+ICsNCj4gKwlydGw4eHh4dV9n
ZW4xX2gyY19jbWQocHJpdiwgJmgyYywgaDJjX3NpemUpOw0KPiArfQ0KPiArDQoNClsuLi5dDQoN
Cg0K
