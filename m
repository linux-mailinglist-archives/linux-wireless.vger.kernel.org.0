Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6D263198B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 06:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKUFjp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 00:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiKUFjo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 00:39:44 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 744941145E
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 21:39:42 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AL5cuMmB001593, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AL5cuMmB001593
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 21 Nov 2022 13:38:56 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 21 Nov 2022 13:39:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 21 Nov 2022 13:39:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Mon, 21 Nov 2022 13:39:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: Fix use after rcu_read_unlock()
Thread-Topic: [PATCH] wifi: rtl8xxxu: Fix use after rcu_read_unlock()
Thread-Index: AQHY/SEysfID9yMd4EWK3/WVKnGXw65I2dkA
Date:   Mon, 21 Nov 2022 05:39:38 +0000
Message-ID: <391fa36560424ac893d7fc52aa8e7a63@realtek.com>
References: <a4c4f176-8903-6bf7-3b31-880ff7ebf195@gmail.com>
In-Reply-To: <a4c4f176-8903-6bf7-3b31-880ff7ebf195@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzIxIOS4iuWNiCAwMzoyMTowMA==?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMjEs
IDIwMjIgNDo0NyBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRD
SF0gd2lmaTogcnRsOHh4eHU6IEZpeCB1c2UgYWZ0ZXIgcmN1X3JlYWRfdW5sb2NrKCkNCj4gDQo+
IC4uLiBpbiBydGw4eHh4dV9ic3NfaW5mb19jaGFuZ2VkKCkuDQoNCk1lbnRpb25lZCB3aGVyZSB5
b3UgbW9kaWZ5IGluIHN1YmplY3QgbWlnaHQgYmUgYmV0dGVyLg0KDQo+IA0KPiBDb21taXQgYThi
NWFlZjJjY2ExICgid2lmaTogcnRsOHh4eHU6IGdlbjI6IEVuYWJsZSA0MCBNSHogY2hhbm5lbCB3
aWR0aCIpDQo+IGludHJvZHVjZWQgYSBsaW5lIHdoZXJlIHRoZSBwb2ludGVyIHJldHVybmVkIGJ5
IGllZWU4MDIxMV9maW5kX3N0YSgpIGlzDQo+IHVzZWQgYWZ0ZXIgcmN1X3JlYWRfdW5sb2NrKCku
DQo+IA0KPiBNb3ZlIHJjdV9yZWFkX3VubG9jaygpIGEgYml0IGxvd2VyIHRvIGZpeCB0aGlzLg0K
PiANCj4gRml4ZXM6IGE4YjVhZWYyY2NhMSAoIndpZmk6IHJ0bDh4eHh1OiBnZW4yOiBFbmFibGUg
NDAgTUh6IGNoYW5uZWwgd2lkdGgiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRo
IDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gLS0tDQo+IE15IGJhZC4gSSdtIG5vdCBzdXJl
IGhvdyBzZXJpb3VzIHRoaXMgcHJvYmxlbSBpcyBiZWNhdXNlIEkndmUgYmVlbiB1c2luZw0KPiB0
aGlzIGNvZGUgYWxsIHRoaXMgdGltZSAoMisgbW9udGhzKSB3aXRob3V0IGFueSB0cm91YmxlLiBJ
IG9ubHkgbm90aWNlZA0KPiBpdCB3aGVuIG1vdmluZyBzb21lIG9mIHRoaXMgY29kZSBpbnRvIGEg
bmV3IGZ1bmN0aW9uLg0KDQonc3RhJyBjYW4gYmUgZnJlZWQgaWYgYSBzdGF0aW9uIGxlYXZlcywg
YW5kIHRoZW4gY2F1c2VzIHVzZS1hZnRlci1mcmVlLiBCdXQsDQpsdWNraWx5IGlmYWNlX3dvcmsg
cHJvY2Vzc2VzIHJ0bDh4eHh1X2Jzc19pbmZvX2NoYW5nZWQoKSBhbmQgJ3N0YScgbGVhdmluZywg
c28NCml0IHdpbGwgbm90IGhhcHBlbiBhdCB0aGUgc2FtZSB0aW1lLg0KDQo+IC0tLQ0KPiAgZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMgfCAyICst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4
eHh1X2NvcmUuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRs
OHh4eHVfY29yZS5jDQo+IGluZGV4IGU4ZmNkNTMxYzQzNy4uMjhmMTM2MDY0Mjk3IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2Nv
cmUuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4
eHh1X2NvcmUuYw0KPiBAQCAtNDY0NSw3ICs0NjQ1LDYgQEAgcnRsOHh4eHVfYnNzX2luZm9fY2hh
bmdlZChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwN
Cj4gIAkJCWlmIChzdGEtPmRlZmxpbmsuaHRfY2FwLmNhcCAmDQo+ICAJCQkgICAgKElFRUU4MDIx
MV9IVF9DQVBfU0dJXzQwIHwgSUVFRTgwMjExX0hUX0NBUF9TR0lfMjApKQ0KPiAgCQkJCXNnaSA9
IDE7DQo+IC0JCQlyY3VfcmVhZF91bmxvY2soKTsNCj4gDQo+ICAJCQloaWdoZXN0X3JhdGUgPSBm
bHMocmFtYXNrKSAtIDE7DQo+ICAJCQlpZiAoaGlnaGVzdF9yYXRlIDwgREVTQ19SQVRFX01DUzAp
IHsNCj4gQEAgLTQ2NzAsNiArNDY2OSw3IEBAIHJ0bDh4eHh1X2Jzc19pbmZvX2NoYW5nZWQoc3Ry
dWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsDQo+ICAJCQkJ
ZWxzZQ0KPiAgCQkJCQlyYXJwdC0+dHhyYXRlLmJ3ID0gUkFURV9JTkZPX0JXXzIwOw0KPiAgCQkJ
fQ0KPiArCQkJcmN1X3JlYWRfdW5sb2NrKCk7DQo+ICAJCQliaXRfcmF0ZSA9IGNmZzgwMjExX2Nh
bGN1bGF0ZV9iaXRyYXRlKCZyYXJwdC0+dHhyYXRlKTsNCj4gIAkJCXJhcnB0LT5iaXRfcmF0ZSA9
IGJpdF9yYXRlOw0KPiAgCQkJcmFycHQtPmRlc2NfcmF0ZSA9IGhpZ2hlc3RfcmF0ZTsNCj4gLS0N
Cj4gMi4zOC4wDQo+IA0KPiAtLS0tLS1QbGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJl
Zm9yZSBwcmludGluZyB0aGlzIGUtbWFpbC4NCg==
