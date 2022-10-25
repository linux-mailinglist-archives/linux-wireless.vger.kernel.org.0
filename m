Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ABD60C16B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 03:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiJYBvO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 21:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiJYBuy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 21:50:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5229E83
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 18:48:14 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29P1lZ5A1005703, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29P1lZ5A1005703
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Oct 2022 09:47:35 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 25 Oct 2022 09:48:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 25 Oct 2022 09:48:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb]) by
 RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb%5]) with mapi id
 15.01.2375.007; Tue, 25 Oct 2022 09:48:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2 5/5] wifi: rtl8xxxu: Use dev_info instead of pr_info
Thread-Topic: [PATCH v2 5/5] wifi: rtl8xxxu: Use dev_info instead of pr_info
Thread-Index: AQHY5/lIVVuJE4I3s0amatkL+epUqq4eV6wA
Date:   Tue, 25 Oct 2022 01:48:08 +0000
Message-ID: <07458c00f00c4d048cfabe12b9495ba5@realtek.com>
References: <1edda764-94ca-2123-0ba6-6b04a1b01709@gmail.com>
 <fb69614a-a06a-ab59-fae2-9443e96e249b@gmail.com>
In-Reply-To: <fb69614a-a06a-ab59-fae2-9443e96e249b@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzI0IOS4i+WNiCAxMToyMzowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjUs
IDIwMjIgNDo1OSBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRD
SCB2MiA1LzVdIHdpZmk6IHJ0bDh4eHh1OiBVc2UgZGV2X2luZm8gaW5zdGVhZCBvZiBwcl9pbmZv
DQo+IA0KPiBSZXBsYWNlIHR3byBpbnN0YW5jZXMgb2YgYmFyZSBwcl9pbmZvIHdpdGggZGV2X2lu
Zm8uDQo+IA0KPiBBbHNvIG1ha2UgdGhlaXIgbWVzc2FnZXMgYSBsaXR0bGUgbW9yZSBpbmZvcm1h
dGl2ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJm
ZTJAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRl
ay5jb20+DQoNCj4gLS0tDQo+IHYyOg0KPiAgLSBObyBjaGFuZ2UuDQo+IC0tLQ0KPiAgZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMgfCA2ICsrKyst
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0
bDh4eHh1X2NvcmUuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUv
cnRsOHh4eHVfY29yZS5jDQo+IGluZGV4IDhiYWI3MjQ3NDYwZC4uOWQ1YWU4M2RhZDcwIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1
X2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0
bDh4eHh1X2NvcmUuYw0KPiBAQCAtMjAxNSw3ICsyMDE1LDggQEAgc3RhdGljIGludCBydGw4eHh4
dV9kb3dubG9hZF9maXJtd2FyZShzdHJ1Y3QgcnRsOHh4eHVfcHJpdiAqcHJpdikNCj4gDQo+ICAJ
dmFsOCA9IHJ0bDh4eHh1X3JlYWQ4KHByaXYsIFJFR19NQ1VfRldfREwpOw0KPiAgCWlmICh2YWw4
ICYgTUNVX0ZXX1JBTV9TRUwpIHsNCj4gLQkJcHJfaW5mbygiZG8gdGhlIFJBTSByZXNldFxuIik7
DQo+ICsJCWRldl9pbmZvKCZwcml2LT51ZGV2LT5kZXYsDQo+ICsJCQkgIkZpcm13YXJlIGlzIGFs
cmVhZHkgcnVubmluZywgcmVzZXR0aW5nIHRoZSBNQ1UuXG4iKTsNCj4gIAkJcnRsOHh4eHVfd3Jp
dGU4KHByaXYsIFJFR19NQ1VfRldfREwsIDB4MDApOw0KPiAgCQlwcml2LT5mb3BzLT5yZXNldF84
MDUxKHByaXYpOw0KPiAgCX0NCj4gQEAgLTU0MjAsNyArNTQyMSw4IEBAIHN0YXRpYyB2b2lkIHJ0
bDh4eHh1X3J4X3VyYl93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gIAkJCXJ0bDh4
eHh1X3F1ZXVlX3J4X3VyYihwcml2LCByeF91cmIpOw0KPiAgCQkJYnJlYWs7DQo+ICAJCWRlZmF1
bHQ6DQo+IC0JCQlwcl9pbmZvKCJmYWlsZWQgdG8gcmVxdWV1ZSB1cmIgJWlcbiIsIHJldCk7DQo+
ICsJCQlkZXZfaW5mbygmcHJpdi0+dWRldi0+ZGV2LA0KPiArCQkJCSAiZmFpbGVkIHRvIHJlcXVl
dWUgdXJiIHdpdGggZXJyb3IgJWlcbiIsIHJldCk7DQo+ICAJCQlza2IgPSAoc3RydWN0IHNrX2J1
ZmYgKilyeF91cmItPnVyYi5jb250ZXh0Ow0KPiAgCQkJZGV2X2tmcmVlX3NrYihza2IpOw0KPiAg
CQkJdXNiX2ZyZWVfdXJiKCZyeF91cmItPnVyYik7DQo+IC0tDQo+IDIuMzguMA0KPiANCj4gLS0t
LS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBl
LW1haWwuDQo=
