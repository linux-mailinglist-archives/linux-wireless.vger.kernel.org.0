Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8F0625429
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Nov 2022 07:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiKKG6F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Nov 2022 01:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKG6E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Nov 2022 01:58:04 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8333477202
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 22:58:03 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AB6vLBj9013997, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AB6vLBj9013997
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 11 Nov 2022 14:57:21 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 11 Nov 2022 14:58:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 11 Nov 2022 14:57:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Fri, 11 Nov 2022 14:57:59 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2 2/3] wifi: rtl8xxxu: Use strscpy instead of sprintf
Thread-Topic: [PATCH v2 2/3] wifi: rtl8xxxu: Use strscpy instead of sprintf
Thread-Index: AQHY9QyqlmTPr7D490yuAjZkqDS+Ca45S6lQ
Date:   Fri, 11 Nov 2022 06:57:59 +0000
Message-ID: <9a1b91cc334d4d27896f38946e5e2806@realtek.com>
References: <e7d05bd9-e096-8361-f1b4-3c8b8599a7eb@gmail.com>
 <5fc9cc0e-eecb-8428-aeb1-f745791c0f16@gmail.com>
In-Reply-To: <5fc9cc0e-eecb-8428-aeb1-f745791c0f16@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzExIOS4iuWNiCAwMjoxMDowMA==?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAx
MCwgMjAyMiA5OjU5IFBNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMi8zXSB3aWZpOiBydGw4
eHh4dTogVXNlIHN0cnNjcHkgaW5zdGVhZCBvZiBzcHJpbnRmDQo+IA0KPiBGaWxsIHByaXYtPmNo
aXBfbmFtZSBhbmQgcHJpdi0+Y2hpcF92ZW5kb3Igd2l0aCBzdHJzY3B5IGluc3RlYWQgb2YNCj4g
c3ByaW50Zi4gVGhpcyBpcyBqdXN0IHRvIHByZXZlbnQgZnV0dXJlIGJ1Z3MgaW4gY2FzZSB0aGUg
bmFtZSBvZiBhDQo+IGNoaXAvdmVuZG9yIGJlY29tZXMgbG9uZ2VyIHRoYW4gdGhlIHNpemUgb2Yg
Y2hpcF9uYW1lL2NoaXBfdmVuZG9yLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8
cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT4NCg0KPiAtLS0NCj4gdjI6DQo+ICAtIE5vIGNoYW5nZS4NCj4gLS0t
DQo+ICAuLi4vbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODE4OGYuYyAg
IHwgIDIgKy0NCj4gIC4uLi9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV84
MTkyYy5jICAgfCAgOCArKysrLS0tLQ0KPiAgLi4uL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4
eHh1L3J0bDh4eHh1XzgxOTJlLmMgICB8ICA0ICsrLS0NCj4gIC4uLi9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydGw4eHh4dS9ydGw4eHh4dV84NzIzYS5jICAgfCAgMiArLQ0KPiAgLi4uL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1Xzg3MjNiLmMgICB8ICAyICstDQo+ICAuLi4v
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jICAgIHwgMTIgKysr
KysrLS0tLS0tDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDE1IGRlbGV0
aW9ucygtKQ0KPiANCg0KWy4uLl0NCg0K
