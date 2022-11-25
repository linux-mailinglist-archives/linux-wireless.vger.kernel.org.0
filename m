Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A19638508
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Nov 2022 09:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiKYINZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Nov 2022 03:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKYINY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Nov 2022 03:13:24 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23F591A80D
        for <linux-wireless@vger.kernel.org>; Fri, 25 Nov 2022 00:13:23 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AP8CaqX6030000, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AP8CaqX6030000
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 25 Nov 2022 16:12:36 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 25 Nov 2022 16:13:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 25 Nov 2022 16:13:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Fri, 25 Nov 2022 16:13:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 2/2] wifi: rtl8xxxu: Introduce rtl8xxxu_update_ra_report
Thread-Topic: [PATCH 2/2] wifi: rtl8xxxu: Introduce rtl8xxxu_update_ra_report
Thread-Index: AQHY/4NNcaG0s681WUOP7nD3WcMmva5PSuQQ
Date:   Fri, 25 Nov 2022 08:13:19 +0000
Message-ID: <7afa29a186904e5e901ca711671e8421@realtek.com>
References: <00489244-ba7c-797a-28f0-8788a40f7974@gmail.com>
 <ee44c114-e7ba-797e-f7a8-8a8dde7d098a@gmail.com>
In-Reply-To: <ee44c114-e7ba-797e-f7a8-8a8dde7d098a@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzI1IOS4iuWNiCAwNjowMDowMA==?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAy
NCwgMjAyMiA1OjM0IEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSB3aWZpOiBydGw4eHh4
dTogSW50cm9kdWNlIHJ0bDh4eHh1X3VwZGF0ZV9yYV9yZXBvcnQNCj4gDQo+IFRoZSByYV9yZXBv
cnQgc3RydWN0IGlzIHVzZWQgZm9yIHJlcG9ydGluZyB0aGUgVFggcmF0ZSB2aWENCj4gc3RhX3N0
YXRpc3RpY3MuIFRoZSBjb2RlIHdoaWNoIGZpbGxzIGl0IG91dCBpcyBkdXBsaWNhdGVkIGluIHR3
bw0KPiBwbGFjZXMsIGFuZCB0aGUgUlRMODE4OEVVIHdpbGwgbmVlZCBpdCBpbiBhIHRoaXJkIHBs
YWNlLiBNb3ZlIHRoaXMNCj4gY29kZSBpbnRvIGEgbmV3IGZ1bmN0aW9uIHJ0bDh4eHh1X3VwZGF0
ZV9yYV9yZXBvcnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4
ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gLS0tDQo+IFRoaXMgcGF0Y2ggc2hvdWxkIGJlIGFwcGxp
ZWQgYWZ0ZXIgbXkgb3RoZXIgcGF0Y2g6DQo+ICJbUEFUQ0ggdjJdIHdpZmk6IHJ0bDh4eHh1OiBG
aXggdXNlIGFmdGVyIHJjdV9yZWFkX3VubG9jayBpbiBydGw4eHh4dV9ic3NfaW5mb19jaGFuZ2Vk
Ig0KPiAtLS0NCj4gIC4uLi93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUu
YyB8IDEwNSArKysrKysrKy0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRp
b25zKCspLCA2MCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IGluZGV4IDFjMjlk
MGJmMDllMi4uMmM4Nzk4Y2IzYjRiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBAQCAtNDU5OCw2ICs0
NTk4LDMyIEBAIHN0YXRpYyB2b2lkIHJ0bDh4eHh1X3NldF9haWZzKHN0cnVjdCBydGw4eHh4dV9w
cml2ICpwcml2LCB1OCBzbG90X3RpbWUpDQo+ICAJfQ0KPiAgfQ0KPiANCj4gK3N0YXRpYyB2b2lk
IHJ0bDh4eHh1X3VwZGF0ZV9yYV9yZXBvcnQoc3RydWN0IHJ0bDh4eHh1X3JhX3JlcG9ydCAqcmFy
cHQsDQo+ICsJCQkJICAgICAgdTggcmF0ZSwgdTggc2dpLCB1OCBidykNCj4gK3sNCj4gKwl1OCBt
Y3MsIG5zczsNCj4gKw0KPiArCXJhcnB0LT50eHJhdGUuZmxhZ3MgPSAwOw0KPiArDQo+ICsJaWYg
KHJhdGUgPCBERVNDX1JBVEVfTUNTMCkgew0KDQpJIHRoaW5rICdpZiAocmF0ZSA8PSBERVNDX1JB
VEVfNTRNKScgd291bGQgYmUgbW9yZSByZWFzb25hYmxlLCBiZWNhdXNlIA0KcnRsOHh4eHVfbGVn
YWN5X3JhdGV0YWJsZVtdIGFyZSBsaXN0IG9mIGxlZ2FjeSByYXRlcy4NCg0KWy4uLl0NCg0KUGlu
Zy1LZQ0KDQo=
