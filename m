Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8575E5571FB
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jun 2022 06:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiFWEqI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 00:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243745AbiFWDvQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 23:51:16 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09DD3DA6B
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 20:51:14 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25N3p8aM5023855, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25N3p8aM5023855
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jun 2022 11:51:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 23 Jun 2022 11:51:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 11:51:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.027; Thu, 23 Jun 2022 11:51:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kevin Yang" <kevin_yang@realtek.com>
Subject: Re: [PATCH 13/13] rtw89: prohibit mac80211 chanctx ops without HW scan
Thread-Topic: [PATCH 13/13] rtw89: prohibit mac80211 chanctx ops without HW
 scan
Thread-Index: AQHYgiebmxK+fsrv0UewRp82PNlbwa1YF2M6//+ftYCABCdHAA==
Date:   Thu, 23 Jun 2022 03:51:07 +0000
Message-ID: <6f6682f8d8c7aec02d113330c87484cbcab14ff3.camel@realtek.com>
References: <20220617084954.61261-1-pkshih@realtek.com>
         <20220617084954.61261-14-pkshih@realtek.com> <877d5bprxn.fsf@kernel.org>
         <027f1de5f6ed0da21754c17154cc09411f2c5aa5.camel@realtek.com>
In-Reply-To: <027f1de5f6ed0da21754c17154cc09411f2c5aa5.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMjMg5LiK5Y2IIDEyOjUxOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB2CEA8F3412B546B395AC087A34A719@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIyLTA2LTIwIGF0IDEyOjM0ICswMDAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
IE9uIE1vbiwgMjAyMi0wNi0yMCBhdCAxMzowOSArMDMwMCwgS2FsbGUgVmFsbyB3cm90ZToNCj4g
PiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JpdGVzOg0KPiA+IA0KPiA+ID4g
RnJvbTogWm9uZy1aaGUgWWFuZyA8a2V2aW5feWFuZ0ByZWFsdGVrLmNvbT4NCj4gPiA+IA0KPiA+
ID4gSWYgYSBjaGlwIGlzIGNvbmZpZ3VyZWQgdG8gc3VwcG9ydCBtYWM4MDIxMSBjaGFuY3R4IG9w
cywgd2UgYXZvaWQNCj4gPiA+IHVzaW5nIG9sZGVyIEZXIHRoYXQgZG9lcyBub3Qgc3VwcG9ydCBI
VyBzY2FuIHRvIG1ha2UgbWFjODAyMTEgc3RhY2sNCj4gPiA+IGhhbmRsZSBzY2FubmluZyBhcyBl
eHBlY3RlZC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogWm9uZy1aaGUgWWFuZyA8a2V2
aW5feWFuZ0ByZWFsdGVrLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OS9mdy5jIHwgOCArKysrKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZncuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODkvZncuYw0KPiA+ID4gaW5kZXggMGUxMjYyOWY3ODljMy4uYTQ3NDUxZGM5ZDgxZCAx
MDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZncu
Yw0KPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jDQo+
ID4gPiBAQCAtMjUwLDYgKzI1MCw3IEBAIHN0YXRpYyB2b2lkIHJ0dzg5X2Z3X3JlY29nbml6ZV9m
ZWF0dXJlcyhzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYpDQo+ID4gPiAgDQo+ID4gPiAgaW50IHJ0
dzg5X2Z3X3JlY29nbml6ZShzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYpDQo+ID4gPiAgew0KPiA+
ID4gKwljb25zdCBzdHJ1Y3QgcnR3ODlfY2hpcF9pbmZvICpjaGlwID0gcnR3ZGV2LT5jaGlwOw0K
PiA+ID4gIAlpbnQgcmV0Ow0KPiA+ID4gIA0KPiA+ID4gIAlyZXQgPSBfX3J0dzg5X2Z3X3JlY29n
bml6ZShydHdkZXYsIFJUVzg5X0ZXX05PUk1BTCk7DQo+ID4gPiBAQCAtMjYxLDYgKzI2MiwxMyBA
QCBpbnQgcnR3ODlfZndfcmVjb2duaXplKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldikNCj4gPiA+
ICANCj4gPiA+ICAJcnR3ODlfZndfcmVjb2duaXplX2ZlYXR1cmVzKHJ0d2Rldik7DQo+ID4gPiAg
DQo+ID4gPiArCWlmIChjaGlwLT5zdXBwb3J0X2NoYW5jdHhfbnVtICE9IDAgJiYNCj4gPiA+ICsJ
ICAgICFSVFc4OV9DSEtfRldfRkVBVFVSRShTQ0FOX09GRkxPQUQsICZydHdkZXYtPmZ3KSkgew0K
PiA+ID4gKwkJcnR3ODlfZXJyKHJ0d2RldiwNCj4gPiA+ICsJCQkgICJyZXF1aXJlIG5ld2VyIEZX
IHRvIHN1cHBvcnQgSFcgc2NhbiBmb3IgY2hhbmN0eFxuIik7DQo+ID4gPiArCQlyZXR1cm4gLUVO
T0VOVDsNCj4gPiA+ICsJfQ0KPiA+IA0KPiA+IFNvIGlmIHRoZSB1c2VyIGhhcyBub3QgdXBkYXRl
IHRoZSBmaXJtd2FyZSBhIGtlcm5lbCB1cGdyYWRlIHdpbGwgYnJlYWsNCj4gPiB0aGVpciBpbnRl
cm5ldD8gVGhhdCdzIG5vdCBnb29kLCB3ZSBzaG91bGQgbm90IGJyZWFrIGV4aXN0aW5nIHNldHVw
cy4gU28NCj4gPiB3aGF0IGZpcm13YXJlIHZlcnNpb24gaXMgcmVxdWlyZWQ/DQo+ID4gDQo+IA0K
PiBGaXJtd2FyZSB2ZXJzaW9uIDAuMTMuMzUuMCBpcyByZXF1aXJlZC4gVGhlIGZpcm13YXJlIGhh
cyBiZWVuIGluDQo+IGxpbnV4LWZpcm13YXJlIHJlcG9zaXRvcnkgb24gMjAyMi0wMi0xOC4gSSB0
aGluayBwZW9wbGUgYmVpbmcgYWJsZQ0KPiB0byB1cGRhdGUga2VybmVsIGNhbiB1cGRhdGUgZmly
bXdhcmUgYXMgd2VsbC4NCj4gDQo+IFRoZSBhbHRlcm5hdGl2ZSB3YXlzIGNvdWxkIGJlDQo+IDEu
IGFkZCBhIG1vZHVsZSBwYXJhbWV0ZXIsIGxpa2Ugbm9fY2hhbm5lbF9jb250ZXh0LiBXZSBjYW4g
YWRkIGENCj4gICAgcHJvbXB0IHRvIG5vdGUgcGVvcGxlIGNhbiBzZXQgaXQgdG8gMSBmb3Igb2xk
IGZpcm13YXJlLg0KPiANCj4gMi4gd2FpdCB2ZXJzaW9uIG9mIHJlcXVlc3RfZmlybXdhcmUoKSBh
cyBmaXJzdCBzdGVwIG9mIHBjaSBwcm9iZS4NCj4gICAgVGhlIHByb2JlIGNvdWxkIGNvc3QgbG9u
Z2VyIHRpbWUsIGJlY2F1c2UgY3VycmVudGx5IHdlIHVzZQ0KPiAgICByZXF1ZXN0X2Zpcm13YXJl
X25vd2FpdCgpIGFuZCBjb250aW51ZSB0byBpbml0aWFsaXplIGluIHBhcmFsbGVsLg0KPiAgICBN
b3JlLCBody0+cHJpdiBpc24ndCBhbGxvY2F0ZWQgYXQgdGhhdCBtb21lbnQsIHNvIGl0IGNvdWxk
IGJlIG5vdA0KPiAgICBzbyBzdHJhaWdodGZvcndhcmQuDQo+IA0KDQpUbyBwcmV2ZW50IGJyZWFr
IHVzZXJzJyBleGlzdGluZyBzZXR1cHMsIG1vZGlmaWVkIGFwcHJvYWNoIDEgaXMgYWRvcHRlZA0K
YnkgcGF0Y2hzZXQgdjIuIFdlIGFkZCBhIG1vZHVsZSBwYXJhbWV0ZXIgcnR3ODlfdXNlX2NoYW5j
dHgsIGFuZCBkaXNhYmxlDQppdCBieSBkZWZhdWx0LiBTbywgdXNlcnMnIHNldHVwcyB3aXRoIG9s
ZCBmaXJtd2FyZSBjYW4gc3RpbGwgd29yay4NCg0KSWYgYSB1c2VyIHdhbnRzIGNoYW5uZWwgY29u
dGV4dCB0byBzdXBwb3J0IGNvbmN1cnJlbmN5LCBoZSBjYW4gc2V0DQpydHc4OV91c2VfY2hhbmN0
eD0xIGFuZCB1cGdyYWRlIGZpcm13YXJlLiANCg0KSSB0aGluayB0aGlzIGNvdWxkIGJlIGEgYmV0
dGVyIHVzZXIgZXhwZXJpZW5jZSBvZiBrZXJuZWwuDQoNClBpbmctS2UNCg0K
