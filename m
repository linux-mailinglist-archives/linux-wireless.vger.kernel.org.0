Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848FB633189
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 01:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiKVAqS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 19:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKVAqR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 19:46:17 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5BF61A819
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 16:46:12 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AM0jQEI1009370, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AM0jQEI1009370
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 22 Nov 2022 08:45:26 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 22 Nov 2022 08:46:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 22 Nov 2022 08:46:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Tue, 22 Nov 2022 08:46:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2] wifi: rtl8xxxu: Fix use after rcu_read_unlock in rtl8xxxu_bss_info_changed
Thread-Topic: [PATCH v2] wifi: rtl8xxxu: Fix use after rcu_read_unlock in
 rtl8xxxu_bss_info_changed
Thread-Index: AQHY/evQzO2fy2a9m0eTDdBpDIA7V65KGqKw
Date:   Tue, 22 Nov 2022 00:46:08 +0000
Message-ID: <48c40c3e6f3d428d98c009c417ebff74@realtek.com>
References: <3c82ad09-7593-3be1-1d2c-e58505fb43cb@gmail.com>
In-Reply-To: <3c82ad09-7593-3be1-1d2c-e58505fb43cb@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzIxIOS4i+WNiCAxMDowMDowMA==?=
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
PHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAyMiwg
MjAyMiA0OjU3IEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjJdIHdpZmk6IHJ0bDh4eHh1OiBG
aXggdXNlIGFmdGVyIHJjdV9yZWFkX3VubG9jayBpbiBydGw4eHh4dV9ic3NfaW5mb19jaGFuZ2Vk
DQo+IA0KPiBDb21taXQgYThiNWFlZjJjY2ExICgid2lmaTogcnRsOHh4eHU6IGdlbjI6IEVuYWJs
ZSA0MCBNSHogY2hhbm5lbCB3aWR0aCIpDQo+IGludHJvZHVjZWQgYSBsaW5lIHdoZXJlIHRoZSBw
b2ludGVyIHJldHVybmVkIGJ5IGllZWU4MDIxMV9maW5kX3N0YSgpIGlzDQo+IHVzZWQgYWZ0ZXIg
cmN1X3JlYWRfdW5sb2NrKCkuDQo+IA0KPiBNb3ZlIHJjdV9yZWFkX3VubG9jaygpIGEgYml0IGxv
d2VyIHRvIGZpeCB0aGlzLg0KPiANCj4gRml4ZXM6IGE4YjVhZWYyY2NhMSAoIndpZmk6IHJ0bDh4
eHh1OiBnZW4yOiBFbmFibGUgNDAgTUh6IGNoYW5uZWwgd2lkdGgiKQ0KPiBTaWduZWQtb2ZmLWJ5
OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo+IC0tLQ0KPiB2MjoNCj4g
IC0gQWRqdXN0IHRoZSBjb21taXQgbWVzc2FnZS4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYyB8IDIgKy0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMN
Cj4gaW5kZXggZThmY2Q1MzFjNDM3Li4yOGYxMzYwNjQyOTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+ICsrKyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+
IEBAIC00NjQ1LDcgKzQ2NDUsNiBAQCBydGw4eHh4dV9ic3NfaW5mb19jaGFuZ2VkKHN0cnVjdCBp
ZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0KPiAgCQkJaWYgKHN0
YS0+ZGVmbGluay5odF9jYXAuY2FwICYNCj4gIAkJCSAgICAoSUVFRTgwMjExX0hUX0NBUF9TR0lf
NDAgfCBJRUVFODAyMTFfSFRfQ0FQX1NHSV8yMCkpDQo+ICAJCQkJc2dpID0gMTsNCj4gLQkJCXJj
dV9yZWFkX3VubG9jaygpOw0KPiANCj4gIAkJCWhpZ2hlc3RfcmF0ZSA9IGZscyhyYW1hc2spIC0g
MTsNCj4gIAkJCWlmIChoaWdoZXN0X3JhdGUgPCBERVNDX1JBVEVfTUNTMCkgew0KPiBAQCAtNDY3
MCw2ICs0NjY5LDcgQEAgcnRsOHh4eHVfYnNzX2luZm9fY2hhbmdlZChzdHJ1Y3QgaWVlZTgwMjEx
X2h3ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwNCj4gIAkJCQllbHNlDQo+ICAJCQkJ
CXJhcnB0LT50eHJhdGUuYncgPSBSQVRFX0lORk9fQldfMjA7DQo+ICAJCQl9DQo+ICsJCQlyY3Vf
cmVhZF91bmxvY2soKTsNCj4gIAkJCWJpdF9yYXRlID0gY2ZnODAyMTFfY2FsY3VsYXRlX2JpdHJh
dGUoJnJhcnB0LT50eHJhdGUpOw0KPiAgCQkJcmFycHQtPmJpdF9yYXRlID0gYml0X3JhdGU7DQo+
ICAJCQlyYXJwdC0+ZGVzY19yYXRlID0gaGlnaGVzdF9yYXRlOw0KPiAtLQ0KPiAyLjM4LjANCj4g
DQo+IC0tLS0tLVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5n
IHRoaXMgZS1tYWlsLg0K
