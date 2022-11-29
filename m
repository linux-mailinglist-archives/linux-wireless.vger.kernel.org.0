Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8CA63B716
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 02:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiK2BWg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 20:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiK2BWU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 20:22:20 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08B9040931
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 17:22:06 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AT1LHWf8030097, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AT1LHWf8030097
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 29 Nov 2022 09:21:17 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 29 Nov 2022 09:22:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 29 Nov 2022 09:22:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Tue, 29 Nov 2022 09:22:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2 2/3] wifi: rtl8xxxu: Fix the channel width reporting
Thread-Topic: [PATCH v2 2/3] wifi: rtl8xxxu: Fix the channel width reporting
Thread-Index: AQHZA1/TwRd3q64pU0STSbUq5EUCj65VFCeg
Date:   Tue, 29 Nov 2022 01:22:01 +0000
Message-ID: <c18a1ea252c340b8a876a62bc735c19e@realtek.com>
References: <d3018e30-92c6-1e73-3b63-311fc472a41f@gmail.com>
 <adc5b63e-7d8d-d613-661d-579bb9f9fadb@gmail.com>
In-Reply-To: <adc5b63e-7d8d-d613-661d-579bb9f9fadb@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzI4IOS4i+WNiCAxMTo0MjowMA==?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDI5
LCAyMDIyIDM6MzAgQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogSmVzIFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsgUGluZy1LZSBTaGloIDxw
a3NoaWhAcmVhbHRlay5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAyLzNdIHdpZmk6IHJ0bDh4
eHh1OiBGaXggdGhlIGNoYW5uZWwgd2lkdGggcmVwb3J0aW5nDQo+IA0KPiBUaGUgZ2VuIDIgY2hp
cHMgUlRMODE5MkVVIGFuZCBSVEw4MTg4RlUgcGVyaW9kaWNhbGx5IHNlbmQgdGhlIGRyaXZlcg0K
PiByZXBvcnRzIGFib3V0IHRoZSBUWCByYXRlLCBhbmQgdGhlIGRyaXZlciBwYXNzZXMgdGhlc2Ug
cmVwb3J0cyB0bw0KPiBzdGFfc3RhdGlzdGljcy4gVGhlIHJlcG9ydHMgZnJvbSBSVEw4MTkyRVUg
bWF5IG9yIG1heSBub3QgaW5jbHVkZSB0aGUNCj4gY2hhbm5lbCB3aWR0aC4gVGhlIHJlcG9ydHMg
ZnJvbSBSVEw4MTg4RlUgZG8gbm90IGluY2x1ZGUgaXQuDQo+IA0KPiBPbmx5IGFjY2VzcyB0aGUg
YzJoLT5yYV9yZXBvcnQuYncgZmllbGQgaWYgdGhlIHJlcG9ydCAoc2tiKSBpcyBiaWcNCj4gZW5v
dWdoLg0KPiANCj4gVGhlIG90aGVyIHByb2JsZW0gZml4ZWQgaGVyZSBpcyB0aGF0IHRoZSBjb2Rl
IHdhcyBhY3R1YWxseSBuZXZlcg0KPiBjaGFuZ2luZyB0aGUgY2hhbm5lbCB3aWR0aCBpbml0aWFs
bHkgcmVwb3J0ZWQgYnkNCj4gcnRsOHh4eHVfYnNzX2luZm9fY2hhbmdlZCBiZWNhdXNlIHRoZSB2
YWx1ZSBvZiBSQVRFX0lORk9fQldfMjAgaXMgMC4NCj4gDQo+IEZpeGVzOiAwOTg1ZDNhNDEwYWMg
KCJydGw4eHh4dTogRmVlZCBjdXJyZW50IHR4cmF0ZSBpbmZvcm1hdGlvbiBmb3IgbWFjODAyMTEi
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWls
LmNvbT4NCj4gLS0tDQo+IHYyOg0KPiAgLSBFbGltaW5hdGUgdGhlIG1hZ2ljIG51bWJlcnMuDQo+
IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dS5o
ICAgICAgfCAgMiArKw0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9y
dGw4eHh4dV9jb3JlLmMgfCAxMSArKysrKysrKy0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHUuaA0KPiBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHUuaA0KPiBpbmRleCBkMjZkZjQwOTVk
YTAuLjliZTUzZTBmMjVjYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydGw4eHh4dS9ydGw4eHh4dS5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHUuaA0KPiBAQCAtMTE4Nyw2ICsxMTg3LDggQEAgZW51bSBy
dGw4eHh4dV9id19tb2RlIHsNCj4gIAlSVEw4WFhYVV9DSEFOTkVMX1dJRFRIX01BWCA9IDUsDQo+
ICB9Ow0KPiANCj4gKyNkZWZpbmUgUlRMOFhYWFVfQzJIX0hEUl9MRU4JMiAvKiBpZCBhbmQgc2Vx
ICovDQo+ICsNCj4gIHN0cnVjdCBydGw4NzIzYnVfYzJoIHsNCj4gIAl1OCBpZDsNCj4gIAl1OCBz
ZXE7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1
L3J0bDh4eHh1X2NvcmUuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4
eHUvcnRsOHh4eHVfY29yZS5jDQo+IGluZGV4IDI4ZjEzNjA2NDI5Ny4uMzUyNzc5ZmU0Yjc4IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4
eHh1X2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1
L3J0bDh4eHh1X2NvcmUuYw0KPiBAQCAtNTU2OSw3ICs1NTY5LDYgQEAgc3RhdGljIHZvaWQgcnRs
OHh4eHVfYzJoY21kX2NhbGxiYWNrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gIAkJCXJh
cnB0LT50eHJhdGUuZmxhZ3MgPSAwOw0KPiAgCQkJcmF0ZSA9IGMyaC0+cmFfcmVwb3J0LnJhdGU7
DQo+ICAJCQlzZ2kgPSBjMmgtPnJhX3JlcG9ydC5zZ2k7DQo+IC0JCQlidyA9IGMyaC0+cmFfcmVw
b3J0LmJ3Ow0KPiANCj4gIAkJCWlmIChyYXRlIDwgREVTQ19SQVRFX01DUzApIHsNCj4gIAkJCQly
YXJwdC0+dHhyYXRlLmxlZ2FjeSA9DQo+IEBAIC01NTg2LDggKzU1ODUsMTQgQEAgc3RhdGljIHZv
aWQgcnRsOHh4eHVfYzJoY21kX2NhbGxiYWNrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4g
IAkJCQkJCVJBVEVfSU5GT19GTEFHU19TSE9SVF9HSTsNCj4gIAkJCQl9DQo+IA0KPiAtCQkJCWlm
IChidyA9PSBSQVRFX0lORk9fQldfMjApDQo+IC0JCQkJCXJhcnB0LT50eHJhdGUuYncgfD0gUkFU
RV9JTkZPX0JXXzIwOw0KPiArCQkJCWlmIChza2ItPmxlbiA+IFJUTDhYWFhVX0MySF9IRFJfTEVO
ICsNCj4gKwkJCQkJICAgICAgIG9mZnNldG9mKHR5cGVvZihjMmgtPnJhX3JlcG9ydCksIGJ3KSkg
ew0KDQpJIHRoaW5rIHRoaXMgaXMgbm90IHZlcnkgaW50dWl0aXZlLCBiZWNhdXNlIHRoaXMgbG9n
aWMgaXMgY29ycmVjdCBvbmx5IGlmICdidycgaXMgdTguDQoNClRoZW4sIHRoaXMgb3B0aW9uIG1h
eSBiZSBub3QgYmFkOg0KaWYgKHNrYi0+bGVuID49IFJUTDhYWFhVX0MySF9IRFJfTEVOICsgb2Zm
c2V0b2YodHlwZW9mKGMyaC0+cmFfcmVwb3J0KSwgYncpICsgc2l6ZW9mKGMyaC0+cmFfcmVwb3J0
LmJ3KSkNCg0Kb3IgDQpOb3QgbmVlZCBSVEw4WFhYVV9DMkhfSERSX0xFTi4gSnVzdCB1c2Ugb2Zm
c2V0b2YoKSB0byBjYWxjdWxhdGU6IA0KaWYgKHNrYi0+bGVuID49IG9mZnNldG9mKHR5cGVvZigq
YzJoKSwgcmFfcmVwb3J0LmJ3KSArIHNpemVvZihjMmgtPnJhX3JlcG9ydC5idykpDQoNCm9yDQpJ
ZiB5b3Ugc3RpbGwgcHJlZmVyICdza2ItPmxlbiA+JywgdGhpcyBtYXkgYmUgbW9yZSBjb25jaXNl
IHRoYW4gb3JpZ2luYWwgb25lLg0KaWYgKHNrYi0+bGVuID4gb2Zmc2V0b2YodHlwZW9mKCpjMmgp
LCByYV9yZXBvcnQuYncpKQ0KDQoNCj4gKwkJCQkJaWYgKGMyaC0+cmFfcmVwb3J0LmJ3ID09IFJU
TDhYWFhVX0NIQU5ORUxfV0lEVEhfNDApDQo+ICsJCQkJCQlidyA9IFJBVEVfSU5GT19CV180MDsN
Cj4gKwkJCQkJZWxzZQ0KPiArCQkJCQkJYncgPSBSQVRFX0lORk9fQldfMjA7DQo+ICsJCQkJCXJh
cnB0LT50eHJhdGUuYncgPSBidzsNCj4gKwkJCQl9DQo+ICAJCQl9DQo+ICAJCQliaXRfcmF0ZSA9
IGNmZzgwMjExX2NhbGN1bGF0ZV9iaXRyYXRlKCZyYXJwdC0+dHhyYXRlKTsNCj4gIAkJCXJhcnB0
LT5iaXRfcmF0ZSA9IGJpdF9yYXRlOw0KPiAtLQ0KPiAyLjM4LjANCj4gDQo+IC0tLS0tLVBsZWFz
ZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1tYWlsLg0K
