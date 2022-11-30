Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803EA63CC8C
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Nov 2022 01:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiK3Aio (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 19:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiK3Ain (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 19:38:43 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBB146DFEF
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 16:38:39 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AU0boDqB016357, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AU0boDqB016357
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 30 Nov 2022 08:37:50 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 30 Nov 2022 08:38:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 30 Nov 2022 08:38:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Wed, 30 Nov 2022 08:38:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v3 2/3] wifi: rtl8xxxu: Fix the channel width reporting
Thread-Topic: [PATCH v3 2/3] wifi: rtl8xxxu: Fix the channel width reporting
Thread-Index: AQHZBCWv6dsy4YI6TkSvOSE3esai7K5Wnu+w
Date:   Wed, 30 Nov 2022 00:38:34 +0000
Message-ID: <4959ded326514badbb7bbfbf60e353d4@realtek.com>
References: <ba821a9d-af25-3ade-9fa8-0d3f4b58aec5@gmail.com>
 <aa0afff7-eccd-eac6-9b0d-6d5e94fb2c06@gmail.com>
In-Reply-To: <aa0afff7-eccd-eac6-9b0d-6d5e94fb2c06@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzI5IOS4i+WNiCAxMDowMDowMA==?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIg
MzAsIDIwMjIgMzowNiBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYzIDIvM10gd2lmaTogcnRs
OHh4eHU6IEZpeCB0aGUgY2hhbm5lbCB3aWR0aCByZXBvcnRpbmcNCj4gDQo+IFRoZSBnZW4gMiBj
aGlwcyBSVEw4MTkyRVUgYW5kIFJUTDgxODhGVSBwZXJpb2RpY2FsbHkgc2VuZCB0aGUgZHJpdmVy
DQo+IHJlcG9ydHMgYWJvdXQgdGhlIFRYIHJhdGUsIGFuZCB0aGUgZHJpdmVyIHBhc3NlcyB0aGVz
ZSByZXBvcnRzIHRvDQo+IHN0YV9zdGF0aXN0aWNzLiBUaGUgcmVwb3J0cyBmcm9tIFJUTDgxOTJF
VSBtYXkgb3IgbWF5IG5vdCBpbmNsdWRlIHRoZQ0KPiBjaGFubmVsIHdpZHRoLiBUaGUgcmVwb3J0
cyBmcm9tIFJUTDgxODhGVSBkbyBub3QgaW5jbHVkZSBpdC4NCj4gDQo+IE9ubHkgYWNjZXNzIHRo
ZSBjMmgtPnJhX3JlcG9ydC5idyBmaWVsZCBpZiB0aGUgcmVwb3J0IChza2IpIGlzIGJpZw0KPiBl
bm91Z2guDQo+IA0KPiBUaGUgb3RoZXIgcHJvYmxlbSBmaXhlZCBoZXJlIGlzIHRoYXQgdGhlIGNv
ZGUgd2FzIGFjdHVhbGx5IG5ldmVyDQo+IGNoYW5naW5nIHRoZSBjaGFubmVsIHdpZHRoIGluaXRp
YWxseSByZXBvcnRlZCBieQ0KPiBydGw4eHh4dV9ic3NfaW5mb19jaGFuZ2VkIGJlY2F1c2UgdGhl
IHZhbHVlIG9mIFJBVEVfSU5GT19CV18yMCBpcyAwLg0KPiANCj4gRml4ZXM6IDA5ODVkM2E0MTBh
YyAoInJ0bDh4eHh1OiBGZWVkIGN1cnJlbnQgdHhyYXRlIGluZm9ybWF0aW9uIGZvciBtYWM4MDIx
MSIpDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21h
aWwuY29tPg0KPiAtLS0NCj4gdjM6DQo+ICAtIERvbid0IGFzc3VtZSBidyB3aWxsIGFsd2F5cyBi
ZSAxIGJ5dGUuDQo+IA0KPiB2MjoNCj4gIC0gRWxpbWluYXRlIHRoZSBtYWdpYyBudW1iZXJzLg0K
PiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVf
Y29yZS5jIHwgMTEgKysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBpbmRleCAyOGYxMzYwNjQy
OTcuLjk3OTliYzVlZDYwYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gQEAgLTU1NjksNyArNTU2OSw2
IEBAIHN0YXRpYyB2b2lkIHJ0bDh4eHh1X2MyaGNtZF9jYWxsYmFjayhzdHJ1Y3Qgd29ya19zdHJ1
Y3QgKndvcmspDQo+ICAJCQlyYXJwdC0+dHhyYXRlLmZsYWdzID0gMDsNCj4gIAkJCXJhdGUgPSBj
MmgtPnJhX3JlcG9ydC5yYXRlOw0KPiAgCQkJc2dpID0gYzJoLT5yYV9yZXBvcnQuc2dpOw0KPiAt
CQkJYncgPSBjMmgtPnJhX3JlcG9ydC5idzsNCj4gDQo+ICAJCQlpZiAocmF0ZSA8IERFU0NfUkFU
RV9NQ1MwKSB7DQo+ICAJCQkJcmFycHQtPnR4cmF0ZS5sZWdhY3kgPQ0KPiBAQCAtNTU4Niw4ICs1
NTg1LDE0IEBAIHN0YXRpYyB2b2lkIHJ0bDh4eHh1X2MyaGNtZF9jYWxsYmFjayhzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKndvcmspDQo+ICAJCQkJCQlSQVRFX0lORk9fRkxBR1NfU0hPUlRfR0k7DQo+ICAJ
CQkJfQ0KPiANCj4gLQkJCQlpZiAoYncgPT0gUkFURV9JTkZPX0JXXzIwKQ0KPiAtCQkJCQlyYXJw
dC0+dHhyYXRlLmJ3IHw9IFJBVEVfSU5GT19CV18yMDsNCj4gKwkJCQlpZiAoc2tiLT5sZW4gPj0g
b2Zmc2V0b2YodHlwZW9mKCpjMmgpLCByYV9yZXBvcnQuYncpICsNCj4gKwkJCQkJCXNpemVvZihj
MmgtPnJhX3JlcG9ydC5idykpIHsNCg0KVG9kYXksIEkgbG9vayB1cCBpZiB3ZSBoYXZlIGEgYmV0
dGVyIGNob2ljZSwgYW5kIG9mZnNldG9mZW5kKCkgY2FuIG1ha2UgdGhpbmcgc2ltcGxlLg0KDQpp
ZiAoc2tiLT5sZW4gPj0gb2Zmc2V0b2ZlbmQodHlwZW9mKCpjMmgpLCByYV9yZXBvcnQuYncpKQ0K
DQpTb3JyeSBmb3IgdGhlIGxhdGUuDQoNCj4gKwkJCQkJaWYgKGMyaC0+cmFfcmVwb3J0LmJ3ID09
IFJUTDhYWFhVX0NIQU5ORUxfV0lEVEhfNDApDQo+ICsJCQkJCQlidyA9IFJBVEVfSU5GT19CV180
MDsNCj4gKwkJCQkJZWxzZQ0KPiArCQkJCQkJYncgPSBSQVRFX0lORk9fQldfMjA7DQo+ICsJCQkJ
CXJhcnB0LT50eHJhdGUuYncgPSBidzsNCj4gKwkJCQl9DQo+ICAJCQl9DQo+ICAJCQliaXRfcmF0
ZSA9IGNmZzgwMjExX2NhbGN1bGF0ZV9iaXRyYXRlKCZyYXJwdC0+dHhyYXRlKTsNCj4gIAkJCXJh
cnB0LT5iaXRfcmF0ZSA9IGJpdF9yYXRlOw0KPiAtLQ0KPiAyLjM4LjANCj4gDQo+IC0tLS0tLVBs
ZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1tYWls
Lg0K
