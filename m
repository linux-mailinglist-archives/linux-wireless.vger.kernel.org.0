Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B78858D7C4
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 13:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiHILA6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 07:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbiHILAV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 07:00:21 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34E7425E3
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 04:00:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 279B02K30022119, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 279B02K30022119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 9 Aug 2022 19:00:03 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 9 Aug 2022 19:00:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 9 Aug 2022 19:00:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::d902:19b0:8613:5b97]) by
 RTEXMBS04.realtek.com.tw ([fe80::d902:19b0:8613:5b97%5]) with mapi id
 15.01.2375.007; Tue, 9 Aug 2022 19:00:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kevin Yang" <kevin_yang@realtek.com>
Subject: Re: [PATCH 13/13] rtw89: prohibit mac80211 chanctx ops without HW scan
Thread-Topic: [PATCH 13/13] rtw89: prohibit mac80211 chanctx ops without HW
 scan
Thread-Index: AQHYgiebmxK+fsrv0UewRp82PNlbwa1YF2M6//+ftYCABCdHAIBKVZUA
Date:   Tue, 9 Aug 2022 11:00:12 +0000
Message-ID: <b8f7720937e05c6fd7fde14b8ea57065879928a8.camel@realtek.com>
References: <20220617084954.61261-1-pkshih@realtek.com>
         <20220617084954.61261-14-pkshih@realtek.com> <877d5bprxn.fsf@kernel.org>
         <027f1de5f6ed0da21754c17154cc09411f2c5aa5.camel@realtek.com>
         <6f6682f8d8c7aec02d113330c87484cbcab14ff3.camel@realtek.com>
In-Reply-To: <6f6682f8d8c7aec02d113330c87484cbcab14ff3.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.191]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvOSDkuIrljYggMDg6NTQ6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <65765973ED158843B66372AE1C3F7C66@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIyLTA2LTIzIGF0IDExOjUwICswODAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
IE9uIE1vbiwgMjAyMi0wNi0yMCBhdCAxMjozNCArMDAwMCwgUGluZy1LZSBTaGloIHdyb3RlOg0K
PiA+IE9uIE1vbiwgMjAyMi0wNi0yMCBhdCAxMzowOSArMDMwMCwgS2FsbGUgVmFsbyB3cm90ZToN
Cj4gPiA+IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiB3cml0ZXM6DQo+ID4gPiAN
Cj4gPiA+ID4gRnJvbTogWm9uZy1aaGUgWWFuZyA8a2V2aW5feWFuZ0ByZWFsdGVrLmNvbT4NCj4g
PiA+ID4gDQo+ID4gPiA+IElmIGEgY2hpcCBpcyBjb25maWd1cmVkIHRvIHN1cHBvcnQgbWFjODAy
MTEgY2hhbmN0eCBvcHMsIHdlIGF2b2lkDQo+ID4gPiA+IHVzaW5nIG9sZGVyIEZXIHRoYXQgZG9l
cyBub3Qgc3VwcG9ydCBIVyBzY2FuIHRvIG1ha2UgbWFjODAyMTEgc3RhY2sNCj4gPiA+ID4gaGFu
ZGxlIHNjYW5uaW5nIGFzIGV4cGVjdGVkLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogWm9uZy1aaGUgWWFuZyA8a2V2aW5feWFuZ0ByZWFsdGVrLmNvbT4NCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+ID4gPiA+IC0tLQ0K
PiA+ID4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jIHwgOCArKysr
KysrKw0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiAN
Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkv
ZncuYw0KPiA+ID4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZncuYw0K
PiA+ID4gPiBpbmRleCAwZTEyNjI5Zjc4OWMzLi5hNDc0NTFkYzlkODFkIDEwMDY0NA0KPiA+ID4g
PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2Z3LmMNCj4gPiA+ID4g
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jDQo+ID4gPiA+IEBA
IC0yNTAsNiArMjUwLDcgQEAgc3RhdGljIHZvaWQgcnR3ODlfZndfcmVjb2duaXplX2ZlYXR1cmVz
KHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldikNCj4gPiA+ID4gIA0KPiA+ID4gPiAgaW50IHJ0dzg5
X2Z3X3JlY29nbml6ZShzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYpDQo+ID4gPiA+ICB7DQo+ID4g
PiA+ICsJY29uc3Qgc3RydWN0IHJ0dzg5X2NoaXBfaW5mbyAqY2hpcCA9IHJ0d2Rldi0+Y2hpcDsN
Cj4gPiA+ID4gIAlpbnQgcmV0Ow0KPiA+ID4gPiAgDQo+ID4gPiA+ICAJcmV0ID0gX19ydHc4OV9m
d19yZWNvZ25pemUocnR3ZGV2LCBSVFc4OV9GV19OT1JNQUwpOw0KPiA+ID4gPiBAQCAtMjYxLDYg
KzI2MiwxMyBAQCBpbnQgcnR3ODlfZndfcmVjb2duaXplKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2Rl
dikNCj4gPiA+ID4gIA0KPiA+ID4gPiAgCXJ0dzg5X2Z3X3JlY29nbml6ZV9mZWF0dXJlcyhydHdk
ZXYpOw0KPiA+ID4gPiAgDQo+ID4gPiA+ICsJaWYgKGNoaXAtPnN1cHBvcnRfY2hhbmN0eF9udW0g
IT0gMCAmJg0KPiA+ID4gPiArCSAgICAhUlRXODlfQ0hLX0ZXX0ZFQVRVUkUoU0NBTl9PRkZMT0FE
LCAmcnR3ZGV2LT5mdykpIHsNCj4gPiA+ID4gKwkJcnR3ODlfZXJyKHJ0d2RldiwNCj4gPiA+ID4g
KwkJCSAgInJlcXVpcmUgbmV3ZXIgRlcgdG8gc3VwcG9ydCBIVyBzY2FuIGZvciBjaGFuY3R4XG4i
KTsNCj4gPiA+ID4gKwkJcmV0dXJuIC1FTk9FTlQ7DQo+ID4gPiA+ICsJfQ0KPiA+ID4gDQo+ID4g
PiBTbyBpZiB0aGUgdXNlciBoYXMgbm90IHVwZGF0ZSB0aGUgZmlybXdhcmUgYSBrZXJuZWwgdXBn
cmFkZSB3aWxsIGJyZWFrDQo+ID4gPiB0aGVpciBpbnRlcm5ldD8gVGhhdCdzIG5vdCBnb29kLCB3
ZSBzaG91bGQgbm90IGJyZWFrIGV4aXN0aW5nIHNldHVwcy4gU28NCj4gPiA+IHdoYXQgZmlybXdh
cmUgdmVyc2lvbiBpcyByZXF1aXJlZD8NCj4gPiA+IA0KPiA+IA0KPiA+IEZpcm13YXJlIHZlcnNp
b24gMC4xMy4zNS4wIGlzIHJlcXVpcmVkLiBUaGUgZmlybXdhcmUgaGFzIGJlZW4gaW4NCj4gPiBs
aW51eC1maXJtd2FyZSByZXBvc2l0b3J5IG9uIDIwMjItMDItMTguIEkgdGhpbmsgcGVvcGxlIGJl
aW5nIGFibGUNCj4gPiB0byB1cGRhdGUga2VybmVsIGNhbiB1cGRhdGUgZmlybXdhcmUgYXMgd2Vs
bC4NCj4gPiANCj4gPiBUaGUgYWx0ZXJuYXRpdmUgd2F5cyBjb3VsZCBiZQ0KPiA+IDEuIGFkZCBh
IG1vZHVsZSBwYXJhbWV0ZXIsIGxpa2Ugbm9fY2hhbm5lbF9jb250ZXh0LiBXZSBjYW4gYWRkIGEN
Cj4gPiAgICBwcm9tcHQgdG8gbm90ZSBwZW9wbGUgY2FuIHNldCBpdCB0byAxIGZvciBvbGQgZmly
bXdhcmUuDQo+ID4gDQo+ID4gMi4gd2FpdCB2ZXJzaW9uIG9mIHJlcXVlc3RfZmlybXdhcmUoKSBh
cyBmaXJzdCBzdGVwIG9mIHBjaSBwcm9iZS4NCj4gPiAgICBUaGUgcHJvYmUgY291bGQgY29zdCBs
b25nZXIgdGltZSwgYmVjYXVzZSBjdXJyZW50bHkgd2UgdXNlDQo+ID4gICAgcmVxdWVzdF9maXJt
d2FyZV9ub3dhaXQoKSBhbmQgY29udGludWUgdG8gaW5pdGlhbGl6ZSBpbiBwYXJhbGxlbC4NCj4g
PiAgICBNb3JlLCBody0+cHJpdiBpc24ndCBhbGxvY2F0ZWQgYXQgdGhhdCBtb21lbnQsIHNvIGl0
IGNvdWxkIGJlIG5vdA0KPiA+ICAgIHNvIHN0cmFpZ2h0Zm9yd2FyZC4NCj4gPiANCj4gDQo+IFRv
IHByZXZlbnQgYnJlYWsgdXNlcnMnIGV4aXN0aW5nIHNldHVwcywgbW9kaWZpZWQgYXBwcm9hY2gg
MSBpcyBhZG9wdGVkDQo+IGJ5IHBhdGNoc2V0IHYyLiBXZSBhZGQgYSBtb2R1bGUgcGFyYW1ldGVy
IHJ0dzg5X3VzZV9jaGFuY3R4LCBhbmQgZGlzYWJsZQ0KPiBpdCBieSBkZWZhdWx0LiBTbywgdXNl
cnMnIHNldHVwcyB3aXRoIG9sZCBmaXJtd2FyZSBjYW4gc3RpbGwgd29yay4NCj4gDQo+IElmIGEg
dXNlciB3YW50cyBjaGFubmVsIGNvbnRleHQgdG8gc3VwcG9ydCBjb25jdXJyZW5jeSwgaGUgY2Fu
IHNldA0KPiBydHc4OV91c2VfY2hhbmN0eD0xIGFuZCB1cGdyYWRlIGZpcm13YXJlLiANCj4gDQo+
IEkgdGhpbmsgdGhpcyBjb3VsZCBiZSBhIGJldHRlciB1c2VyIGV4cGVyaWVuY2Ugb2Yga2VybmVs
Lg0KPiANCg0KV2UgaGF2ZSBhIGJldHRlciBpZGVhIHRoYXQgbG9hZCBmaXJtd2FyZSBoZWFkZXIg
YW5kIHBhcnNlIGZpcm13YXJlDQpmZWF0dXJlcyB3aGVuIHByb2JpbmcgYmVmb3JlIGllZWU4MDIx
MV9yZWdpc3Rlcl9odygpLiBJZiBmaXJtd2FyZQ0KZG9lc24ndCBzdXBwb3J0IGh3X3NjYW4sIGl0
IHN0aWxsIGNhbiB3b3JrIGFzIG9yaWdpbmFsLiBTbywgdXNlcnMNCmRvbid0IG5lZWQgdG8gdXBk
YXRlIGZpcm13YXJlIG9yIHNldCBtb2R1bGUgcGFyYW1ldGVycy4NCg0KSSBoYXZlIHNlbnQgdjMg
d2l0aCB0aGlzIGlkZWEgdGhhdCBpcyBmcmllbmRseSB0byB1c2Vycy4NCg0KUGluZy1LZQ0KDQoN
Cg==
