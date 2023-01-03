Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C7965BBBB
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 09:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbjACIOA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 03:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbjACIN6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 03:13:58 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27F46D2F6
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 00:13:55 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3038CuMM2020166, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3038CuMM2020166
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 3 Jan 2023 16:12:56 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 3 Jan 2023 16:13:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 3 Jan 2023 16:13:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Tue, 3 Jan 2023 16:13:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 2/2] wifi: rtl8xxxu: Use a longer retry limit of 48
Thread-Topic: [PATCH 2/2] wifi: rtl8xxxu: Use a longer retry limit of 48
Thread-Index: AQHZHG9TJJPfpvDatUSgR8SzA9XUZq6MW9bA
Date:   Tue, 3 Jan 2023 08:13:51 +0000
Message-ID: <20da2e492e1e4c6ab00ddc53e7e0a79c@realtek.com>
References: <6fcaaead-876c-68d1-a049-f1e7f7ff81e7@gmail.com>
 <55813ec6-b99f-dd25-a1e2-7af9e3be3117@gmail.com>
In-Reply-To: <55813ec6-b99f-dd25-a1e2-7af9e3be3117@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJpdHRlcmJsdWUgU21pdGgg
PHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgRGVjZW1iZXIgMzEs
IDIwMjIgMTI6NTQgQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogSmVzIFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsgUGluZy1LZSBTaGloIDxw
a3NoaWhAcmVhbHRlay5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAyLzJdIHdpZmk6IHJ0bDh4eHh1
OiBVc2UgYSBsb25nZXIgcmV0cnkgbGltaXQgb2YgNDgNCj4gDQo+IFRoZSBSZWFsdGVrIHJhdGUg
Y29udHJvbCBhbGdvcml0aG0gZ29lcyBiYWNrIGFuZCBmb3J0aCBhIGxvdCBiZXR3ZWVuDQo+IHRo
ZSBoaWdoZXN0IGFuZCB0aGUgbG93ZXN0IHJhdGUgaXQncyBhbGxvd2VkIHRvIHVzZS4gVGhpcyBp
cyBkdWUgdG8NCj4gYSBsb3Qgb2YgZnJhbWVzIGJlaW5nIGRyb3BwZWQgYmVjYXVzZSB0aGUgcmV0
cnkgbGltaXRzIHNldCBieQ0KPiBJRUVFODAyMTFfQ09ORl9DSEFOR0VfUkVUUllfTElNSVRTIGFy
ZSB0b28gbG93LiAoRXhwZXJpbWVudGFsbHksIHRoZXkNCj4gYXJlIDQgZm9yIGxvbmcgZnJhbWVz
IGFuZCA3IGZvciBzaG9ydCBmcmFtZXMuKQ0KPiANCj4gVGhlIHZlbmRvciBkcml2ZXJzIGhhcmRj
b2RlIHRoZSB2YWx1ZSA0OCBmb3IgYm90aCByZXRyeSBsaW1pdHMgKGZvcg0KPiBzdGF0aW9uIG1v
ZGUpLCB3aGljaCBtYWtlcyBkcm9wcGVkIGZyYW1lcyB2ZXJ5IHJhcmUgYW5kIHRodXMgdGhlIHJh
dGUNCj4gY29udHJvbCBpcyBtb3JlIHN0YWJsZS4NCg0KSSBoYXZlIHNpbWlsYXIgZmVlbGluZyB3
aXRoIFJlYWx0ZWsgODAyLjExYWMgY2hpcHMgYXMgd2VsbCwgYnV0IEkgZGlkbid0DQpkaWcgZnVy
dGhlciB5ZWFycyBhZ28uIE1heWJlLCBpdCBjb3VsZCBoYXZlIFRYIEVWTSBwcm9ibGVtLg0KDQo+
IA0KPiBCZWNhdXNlIG1vc3QgUmVhbHRlayBjaGlwcyBoYW5kbGUgdGhlIHJhdGUgY29udHJvbCBp
biB0aGUgZmlybXdhcmUsDQo+IHdoaWNoIGNhbid0IGJlIG1vZGlmaWVkLCBpZ25vcmUgdGhlIGxp
bWl0cyBzZXQgYnkNCj4gSUVFRTgwMjExX0NPTkZfQ0hBTkdFX1JFVFJZX0xJTUlUUyBhbmQgdXNl
IHRoZSB2YWx1ZSA0OCAoc2V0IGR1cmluZw0KPiBjaGlwIGluaXRpYWxpc2F0aW9uKSwgc2FtZSBh
cyB0aGUgdmVuZG9yIGRyaXZlcnMuDQo+IA0KPiBGaXhlczogMjZmMWZhZDI5YWQ5ICgiTmV3IGRy
aXZlcjogcnRsOHh4eHUgKG1hYzgwMjExKSIpDQoNCk5vIHN1cmUgaWYgIkZpeGVzIiBpcyBzdWl0
YWJsZSB0byB0aGlzIHBhdGNoLCBiZWNhdXNlIG9yaWdpbmFsIGxvb2tzIHdlbGwgYnV0DQpiYWQg
cGVyZm9ybWFuY2UgaW4gcmVhbC4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRo
IDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMgfCA5IC0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBpbmRleCBmNWZkM2M0
NDg1ODcuLjliY2E1ZTgzNzU4MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gQEAgLTYxODQsNyArNjE4
NCw2IEBAIHN0YXRpYyBpbnQgcnRsOHh4eHVfY29uZmlnKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3
LCB1MzIgY2hhbmdlZCkNCj4gIHsNCj4gIAlzdHJ1Y3QgcnRsOHh4eHVfcHJpdiAqcHJpdiA9IGh3
LT5wcml2Ow0KPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwcml2LT51ZGV2LT5kZXY7DQo+IC0J
dTE2IHZhbDE2Ow0KPiAgCWludCByZXQgPSAwLCBjaGFubmVsOw0KPiAgCWJvb2wgaHQ0MDsNCj4g
DQo+IEBAIC02MTk0LDE0ICs2MTkzLDYgQEAgc3RhdGljIGludCBydGw4eHh4dV9jb25maWcoc3Ry
dWN0IGllZWU4MDIxMV9odyAqaHcsIHUzMiBjaGFuZ2VkKQ0KPiAgCQkJIF9fZnVuY19fLCBody0+
Y29uZi5jaGFuZGVmLmNoYW4tPmh3X3ZhbHVlLA0KPiAgCQkJIGNoYW5nZWQsIGh3LT5jb25mLmNo
YW5kZWYud2lkdGgpOw0KPiANCj4gLQlpZiAoY2hhbmdlZCAmIElFRUU4MDIxMV9DT05GX0NIQU5H
RV9SRVRSWV9MSU1JVFMpIHsNCj4gLQkJdmFsMTYgPSAoKGh3LT5jb25mLmxvbmdfZnJhbWVfbWF4
X3R4X2NvdW50IDw8DQo+IC0JCQkgIFJFVFJZX0xJTUlUX0xPTkdfU0hJRlQpICYgUkVUUllfTElN
SVRfTE9OR19NQVNLKSB8DQo+IC0JCQkoKGh3LT5jb25mLnNob3J0X2ZyYW1lX21heF90eF9jb3Vu
dCA8PA0KPiAtCQkJICBSRVRSWV9MSU1JVF9TSE9SVF9TSElGVCkgJiBSRVRSWV9MSU1JVF9TSE9S
VF9NQVNLKTsNCj4gLQkJcnRsOHh4eHVfd3JpdGUxNihwcml2LCBSRUdfUkVUUllfTElNSVQsIHZh
bDE2KTsNCj4gLQl9DQo+IC0NCj4gIAlpZiAoY2hhbmdlZCAmIElFRUU4MDIxMV9DT05GX0NIQU5H
RV9DSEFOTkVMKSB7DQo+ICAJCXN3aXRjaCAoaHctPmNvbmYuY2hhbmRlZi53aWR0aCkgew0KPiAg
CQljYXNlIE5MODAyMTFfQ0hBTl9XSURUSF8yMF9OT0hUOg0KPiAtLQ0KPiAyLjM4LjANCj4gDQo+
IC0tLS0tLVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRo
aXMgZS1tYWlsLg0K
