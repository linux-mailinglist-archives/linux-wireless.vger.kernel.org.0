Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE796220F0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 01:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKIAn5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 19:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiKIAnx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 19:43:53 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA0C448744
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 16:43:52 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2A90hBn45010020, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2A90hBn45010020
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 9 Nov 2022 08:43:11 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Wed, 9 Nov 2022 08:43:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 9 Nov 2022 08:43:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Wed, 9 Nov 2022 08:43:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 2/3] wifi: rtl8xxxu: Use strscpy instead of sprintf
Thread-Topic: [PATCH 2/3] wifi: rtl8xxxu: Use strscpy instead of sprintf
Thread-Index: AQHY86PRBv09jR152kKilhEZuJ1Efq41wO+Q
Date:   Wed, 9 Nov 2022 00:43:49 +0000
Message-ID: <bdac79b421594a6ca693e8d0244ccf87@realtek.com>
References: <91f59414-86f7-f0ed-a138-19f0ab63bb0b@gmail.com>
 <1db11152-efc1-2027-565a-a0373cccd117@gmail.com>
In-Reply-To: <1db11152-efc1-2027-565a-a0373cccd117@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzgg5LiL5Y2IIDEwOjI4OjAw?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIg
OSwgMjAyMiAyOjU2IEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMi8zXSB3aWZpOiBydGw4eHh4
dTogVXNlIHN0cnNjcHkgaW5zdGVhZCBvZiBzcHJpbnRmDQo+IA0KPiBGaWxsIHByaXYtPmNoaXBf
bmFtZSBhbmQgcHJpdi0+Y2hpcF92ZW5kb3Igd2l0aCBzdHJzY3B5IGluc3RlYWQgb2YNCj4gc3By
aW50Zi4gVGhpcyBpcyBqdXN0IHRvIHByZXZlbnQgZnV0dXJlIGJ1Z3MgaW4gY2FzZSB0aGUgbmFt
ZSBvZiBhDQo+IGNoaXAvdmVuZG9yIGJlY29tZXMgbG9uZ2VyIHRoYW4gdGhlIHNpemUgb2YgY2hp
cF9uYW1lL2NoaXBfdmVuZG9yLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRs
ODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hp
aEByZWFsdGVrLmNvbT4NCg0KPiAtLS0NCj4gVGhpcyBwYXRjaCBzaG91bGQgYmUgYXBwbGllZCBh
ZnRlciBteSBvbGRlciBwYXRjaDoNCj4gIltQQVRDSCB2MiAyLzNdIHdpZmk6IHJ0bDh4eHh1OiBT
cGxpdCB1cCBydGw4eHh4dV9pZGVudGlmeV9jaGlwIg0KPiAtLS0NCj4gIC4uLi9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV84MTg4Zi5jICAgfCAgMiArLQ0KPiAgLi4uL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxOTJjLmMgICB8ICA4ICsrKyst
LS0tDQo+ICAuLi4vbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODE5MmUu
YyAgIHwgIDQgKystLQ0KPiAgLi4uL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4
eHh1Xzg3MjNhLmMgICB8ICAyICstDQo+ICAuLi4vbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4
eHUvcnRsOHh4eHVfODcyM2IuYyAgIHwgIDIgKy0NCj4gIC4uLi9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMgICAgfCAxMiArKysrKystLS0tLS0NCj4gIDYgZmls
ZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+IA0KDQpbLi4u
XQ0KDQo=
