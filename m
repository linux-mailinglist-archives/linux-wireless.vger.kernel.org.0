Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19BE64533E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 06:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiLGFI2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 00:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLGFI1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 00:08:27 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3C655477E
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 21:08:25 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B756gND2016121, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B756gND2016121
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 7 Dec 2022 13:06:42 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Wed, 7 Dec 2022 13:07:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 7 Dec 2022 13:07:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Wed, 7 Dec 2022 13:07:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH resend 1/3] rtlwifi: rtl8821ae: don't call kfree_skb() under spin_lock_irqsave()
Thread-Topic: [PATCH resend 1/3] rtlwifi: rtl8821ae: don't call kfree_skb()
 under spin_lock_irqsave()
Thread-Index: AQHZCXTBd7UL9gBmHkG5RI2in6WwBq5hxFHw//9/AACAAIdsYP//iImAgACMaaA=
Date:   Wed, 7 Dec 2022 05:07:28 +0000
Message-ID: <15121361cd404c6e97508b8edce0003f@realtek.com>
References: <20221206131249.2181693-1-yangyingliang@huawei.com>
 <20221206131249.2181693-2-yangyingliang@huawei.com>
 <758b8caa9e8243bb84471baf50706e6d@realtek.com>
 <c9096bc2-8765-8bf5-484b-da949c99e236@huawei.com>
 <1bbd83a4cd6f48e5878c256c3e8f6334@realtek.com>
 <0fa6cc09-80b6-94bc-6d0a-dffacf896617@huawei.com>
In-Reply-To: <0fa6cc09-80b6-94bc-6d0a-dffacf896617@huawei.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzcg5LiK5Y2IIDAzOjI5OjAw?=
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWWFuZyBZaW5nbGlhbmcg
PHlhbmd5aW5nbGlhbmdAaHVhd2VpLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciA3
LCAyMDIyIDEyOjQxIFBNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47
IGt2YWxvQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsg
eWFuZ3lpbmdsaWFuZ0BodWF3ZWkuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggcmVzZW5kIDEv
M10gcnRsd2lmaTogcnRsODgyMWFlOiBkb24ndCBjYWxsIGtmcmVlX3NrYigpIHVuZGVyIHNwaW5f
bG9ja19pcnFzYXZlKCkNCj4gDQo+IE9uIDIwMjIvMTIvNyAxMTo1MiwgUGluZy1LZSBTaGloIHdy
b3RlOg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBZYW5nIFlp
bmdsaWFuZyA8eWFuZ3lpbmdsaWFuZ0BodWF3ZWkuY29tPg0KPiA+PiBTZW50OiBXZWRuZXNkYXks
IERlY2VtYmVyIDcsIDIwMjIgMTE6NDQgQU0NCj4gPj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGlo
QHJlYWx0ZWsuY29tPjsga3ZhbG9Aa2VybmVsLm9yZw0KPiA+PiBDYzogbGludXgtd2lyZWxlc3NA
dmdlci5rZXJuZWwub3JnOyB5YW5neWluZ2xpYW5nQGh1YXdlaS5jb20NCj4gPj4gU3ViamVjdDog
UmU6IFtQQVRDSCByZXNlbmQgMS8zXSBydGx3aWZpOiBydGw4ODIxYWU6IGRvbid0IGNhbGwga2Zy
ZWVfc2tiKCkgdW5kZXIgc3Bpbl9sb2NrX2lycXNhdmUoKQ0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAy
MDIyLzEyLzcgMTE6MzEsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPj4+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206IFlhbmcgWWluZ2xpYW5nIDx5YW5neWluZ2xpYW5n
QGh1YXdlaS5jb20+DQo+ID4+Pj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgNiwgMjAyMiA5OjEz
IFBNDQo+ID4+Pj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsga3ZhbG9A
a2VybmVsLm9yZw0KPiA+Pj4+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IHlh
bmd5aW5nbGlhbmdAaHVhd2VpLmNvbQ0KPiA+Pj4+IFN1YmplY3Q6IFtQQVRDSCByZXNlbmQgMS8z
XSBydGx3aWZpOiBydGw4ODIxYWU6IGRvbid0IGNhbGwga2ZyZWVfc2tiKCkgdW5kZXIgc3Bpbl9s
b2NrX2lycXNhdmUoKQ0KPiA+Pj4+DQo+ID4+Pj4gSXQgaXMgbm90IGFsbG93ZWQgdG8gY2FsbCBr
ZnJlZV9za2IoKSBmcm9tIGhhcmR3YXJlIGludGVycnVwdA0KPiA+Pj4+IGNvbnRleHQgb3Igd2l0
aCBpbnRlcnJ1cHRzIGJlaW5nIGRpc2FibGVkLiBTbyBhZGQgYWxsIHNrYiB0bw0KPiA+Pj4+IGEg
ZnJlZSBsaXN0LCB0aGVuIGZyZWUgdGhlbSBhZnRlciBzcGluX3VubG9ja19pcnFyZXN0b3JlKCkg
YXQNCj4gPj4+PiBvbmNlLg0KPiA+Pj4gVGhlIHBhdGNoIGRvZXNuJ3QgY2hhbmdlIGxvZ2ljLCBz
byBpdCBzaG91bGQgd29yay4gQnV0LCBJIHdvdWxkIGxpa2UgdG8ga25vdw0KPiA+Pj4gaWYgdGhl
cmUgaXMgYSBjb21tZW50IGFib3V0IHRoaXMgaW4ga2VybmVsIGNvZGUuIENvdWxkIHlvdSBwb2lu
dCBpdCBvdXQ/DQo+ID4+IFlvdSBjYW4gc2VlIGNvbW1lbnQgb2YgZGV2X2tmcmVlX3NrYl9pcnEo
KSBpbiBpbmNsdWRlL2xpbnV4L25ldGRldmljZS5oDQo+ID4+DQo+IGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2lu
Y2x1ZGUvbGludXgvbmV0ZGV2aWNlLmg/aD12Ng0KPiA+PiAuMS1yYzgNCj4gPj4NCj4gPiBJdCBz
ZWVtcyBsaWtlIHdlIGNhbiByZXBsYWNlIGtmcmVlX3NrYigpIGJ5IGRldl9rZnJlZV9za2JfaXJx
KCksIHJpZ2h0Pw0KPiA+IEJ1dCB5b3VyIG1ldGhvZCBpcyBtb3JlIGVmZmljaWVudC4gSXMgdGhh
dCB5b3VyIHBvaW50Pw0KPiBZZXMsIHRoZSBTS0JzIGhhdmUgYWxyZWFkeSBiZWVuIGRlcXVldWVk
IGZyb20gdGhlIHF1ZXVlLCBzbyB0aGV5IGNhbiBiZQ0KPiBmcmVlZCB0b2dldGhlciBhdCBvbmNl
Lg0KPiANCg0KVGhhbmtzLiBUaGlzIHBhdGNoc2V0IGlzIGdvb2QgdG8gbWUuIEJ1dCwgc3ViamVj
dCBwcmVmaXggc2hvdWxkIGJlICJ3aWZpOiBydGx3aWZpOiAuLi4iDQppZiB2MiBpcyBub3QgYSBo
YXJkIHdvcmsgdG8geW91LiBJIHN1cHBvc2UgdjIgY2FuIGNoYW5nZSBub3RoaW5nLCBzbyBhZGQg
bXkgQWNrZWQtYnk6DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNv
bT4NCg0KDQo=
