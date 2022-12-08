Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA2564669A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 02:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiLHBmY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 20:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiLHBmV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 20:42:21 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B8779077B
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 17:42:17 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B81eLXD1023738, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B81eLXD1023738
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 8 Dec 2022 09:40:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 8 Dec 2022 09:41:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 8 Dec 2022 09:41:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Thu, 8 Dec 2022 09:41:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtl8xxxu: don't call dev_kfree_skb() under spin_lock_irqsave()
Thread-Topic: [PATCH] wifi: rtl8xxxu: don't call dev_kfree_skb() under
 spin_lock_irqsave()
Thread-Index: AQHZCknMh5bOyluekkWY/C/aux+hXK5jJXAA//+HzoCAAIj/IA==
Date:   Thu, 8 Dec 2022 01:41:07 +0000
Message-ID: <594be2636427488785b244e5b5725c95@realtek.com>
References: <20221207143738.67721-1-yangyingliang@huawei.com>
 <0cfea9eaf08446d5a7dfcb85da34dcf2@realtek.com>
 <c3ca010a-3c1a-5c64-a58a-a66d31f5869b@huawei.com>
In-Reply-To: <c3ca010a-3c1a-5c64-a58a-a66d31f5869b@huawei.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzcg5LiL5Y2IIDEwOjAwOjAw?=
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlhbmcgWWluZ2xpYW5nIDx5
YW5neWluZ2xpYW5nQGh1YXdlaS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciA4LCAy
MDIyIDk6MjYgQU0NCj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgSmVz
LlNvcmVuc2VuQGdtYWlsLmNvbTsga3ZhbG9Aa2VybmVsLm9yZw0KPiBDYzogbGludXgtd2lyZWxl
c3NAdmdlci5rZXJuZWwub3JnOyB5YW5neWluZ2xpYW5nQGh1YXdlaS5jb20NCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gd2lmaTogcnRsOHh4eHU6IGRvbid0IGNhbGwgZGV2X2tmcmVlX3NrYigpIHVu
ZGVyIHNwaW5fbG9ja19pcnFzYXZlKCkNCj4gDQo+IA0KPiBPbiAyMDIyLzEyLzggODozOCwgUGlu
Zy1LZSBTaGloIHdyb3RlOg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBG
cm9tOiBZYW5nIFlpbmdsaWFuZyA8eWFuZ3lpbmdsaWFuZ0BodWF3ZWkuY29tPg0KPiA+PiBTZW50
OiBXZWRuZXNkYXksIERlY2VtYmVyIDcsIDIwMjIgMTA6MzggUE0NCj4gPj4gVG86IEplcy5Tb3Jl
bnNlbkBnbWFpbC5jb207IGt2YWxvQGtlcm5lbC5vcmcNCj4gPj4gQ2M6IGxpbnV4LXdpcmVsZXNz
QHZnZXIua2VybmVsLm9yZw0KPiA+PiBTdWJqZWN0OiBbUEFUQ0hdIHdpZmk6IHJ0bDh4eHh1OiBk
b24ndCBjYWxsIGRldl9rZnJlZV9za2IoKSB1bmRlciBzcGluX2xvY2tfaXJxc2F2ZSgpDQo+ID4+
DQo+ID4+IEl0IGlzIG5vdCBhbGxvd2VkIHRvIGNhbGwgY29uc3VtZV9za2IoKSBmcm9tIGhhcmR3
YXJlIGludGVycnVwdCBjb250ZXh0DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
Xl5eXl5eXl5eXl5eIGtmcmVlX3NrYigpPw0KPiA+IGJlY2F1c2UgdGhpcyBwYXRjaCBpcyB0byBy
ZXBsYWNlIGRldl9rZnJlZV9za2IoKS4NCj4gPg0KPiA+PiBvciB3aXRoIGludGVycnVwdHMgYmVp
bmcgZGlzYWJsZWQuIFNvIHJlcGxhY2UgZGV2X2tmcmVlX3NrYigpIHdpdGgNCj4gPj4gZGV2X2Nv
bnN1bWVfc2tiX2lycSgpIHVuZGVyIHNwaW5fbG9ja19pcnFzYXZlKCkuIENvbXBpbGUgdGVzdGVk
IG9ubHkuDQo+ID4+DQo+ID4+IEZpeGVzOiAyNmYxZmFkMjlhZDkgKCJOZXcgZHJpdmVyOiBydGw4
eHh4dSAobWFjODAyMTEpIikNCj4gPj4gU2lnbmVkLW9mZi1ieTogWWFuZyBZaW5nbGlhbmcgPHlh
bmd5aW5nbGlhbmdAaHVhd2VpLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMgfCAyICstDQo+ID4+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+DQo+ID4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1
X2NvcmUuYw0KPiA+PiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRs
OHh4eHVfY29yZS5jDQo+ID4+IGluZGV4IGFjNjQxYTU2ZWZiMC4uZDA2MDBhZjViZWY0IDEwMDY0
NA0KPiA+PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4
eHh1X2NvcmUuYw0KPiA+PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4
eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiA+PiBAQCAtNTI3NCw3ICs1Mjc0LDcgQEAgc3RhdGljIHZv
aWQgcnRsOHh4eHVfcXVldWVfcnhfdXJiKHN0cnVjdCBydGw4eHh4dV9wcml2ICpwcml2LA0KPiA+
PiAgIAkJcGVuZGluZyA9IHByaXYtPnJ4X3VyYl9wZW5kaW5nX2NvdW50Ow0KPiA+PiAgIAl9IGVs
c2Ugew0KPiA+PiAgIAkJc2tiID0gKHN0cnVjdCBza19idWZmICopcnhfdXJiLT51cmIuY29udGV4
dDsNCj4gPj4gLQkJZGV2X2tmcmVlX3NrYihza2IpOw0KPiA+PiArCQlkZXZfY29uc3VtZV9za2Jf
aXJxKHNrYik7DQo+ID4gV2h5IG5vdCBkZXZfa2ZyZWVfc2tiX2lycSgpIGluc3RlYWQ/IGFueSBy
ZWFzb24/DQo+ICNkZWZpbmUgZGV2X2tmcmVlX3NrYihhKcKgwqDCoMKgwqDCoMKgIGNvbnN1bWVf
c2tiKGEpDQo+IGRldl9rZnJlZV9za2IoKSBpcyBjb25zdW1lX3NrYigpLCBzbyB1c2UgZGV2X2Nv
bnN1bWVfc2tiX2lycSgpIGluc3RlYWQuDQo+IA0KPiBzdGF0aWMgaW5saW5lIHZvaWQgZGV2X2tm
cmVlX3NrYl9pcnEoc3RydWN0IHNrX2J1ZmYgKnNrYikNCj4gew0KPiAgwqDCoMKgwqDCoMKgwqAg
X19kZXZfa2ZyZWVfc2tiX2lycShza2IsIFNLQl9SRUFTT05fRFJPUFBFRCk7DQo+IH0NCj4gDQo+
IHN0YXRpYyBpbmxpbmUgdm9pZCBkZXZfY29uc3VtZV9za2JfaXJxKHN0cnVjdCBza19idWZmICpz
a2IpDQo+IHsNCj4gIMKgwqDCoMKgwqDCoMKgIF9fZGV2X2tmcmVlX3NrYl9pcnEoc2tiLCBTS0Jf
UkVBU09OX0NPTlNVTUVEKTsNCj4gfQ0KPiBUaGV5IGhhdmUgZGlmZmVyZW50IGZyZWUgcmVhc29u
cy4NCj4gDQoNCkl0IGZhbGxzIGludG8gdGhpcyBjYXNlIGJlY2F1c2Ugb2YgJ3ByaXYtPnNodXRk
b3duJywgc28gRFJPUFBFRCByZWFzb24gbWFrZXMNCnNlbnNlLCBubz8gT3IgSSBtaXN1bmRlcnN0
YW5kIHRoZSByZWFzb24/DQoNCi0tDQpQaW5nLUtlDQoNCg==
