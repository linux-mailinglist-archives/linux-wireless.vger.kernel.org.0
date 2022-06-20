Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0240E551917
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jun 2022 14:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbiFTMif (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jun 2022 08:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242830AbiFTMi3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jun 2022 08:38:29 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1C563DA
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 05:38:26 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25KCcDNr9018657, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25KCcDNr9018657
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Jun 2022 20:38:13 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 20 Jun 2022 20:38:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 20 Jun 2022 20:34:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.027; Mon, 20 Jun 2022 20:34:25 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kevin Yang" <kevin_yang@realtek.com>
Subject: Re: [PATCH 13/13] rtw89: prohibit mac80211 chanctx ops without HW scan
Thread-Topic: [PATCH 13/13] rtw89: prohibit mac80211 chanctx ops without HW
 scan
Thread-Index: AQHYgiebmxK+fsrv0UewRp82PNlbwa1YF2M6//+ftYA=
Date:   Mon, 20 Jun 2022 12:34:25 +0000
Message-ID: <027f1de5f6ed0da21754c17154cc09411f2c5aa5.camel@realtek.com>
References: <20220617084954.61261-1-pkshih@realtek.com>
         <20220617084954.61261-14-pkshih@realtek.com> <877d5bprxn.fsf@kernel.org>
In-Reply-To: <877d5bprxn.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.23.196]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMjAg5LiK5Y2IIDA4OjM2OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <686BDA53B6EB3A4C837C17466DA581E8@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

T24gTW9uLCAyMDIyLTA2LTIwIGF0IDEzOjA5ICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBGcm9tOiBa
b25nLVpoZSBZYW5nIDxrZXZpbl95YW5nQHJlYWx0ZWsuY29tPg0KPiA+IA0KPiA+IElmIGEgY2hp
cCBpcyBjb25maWd1cmVkIHRvIHN1cHBvcnQgbWFjODAyMTEgY2hhbmN0eCBvcHMsIHdlIGF2b2lk
DQo+ID4gdXNpbmcgb2xkZXIgRlcgdGhhdCBkb2VzIG5vdCBzdXBwb3J0IEhXIHNjYW4gdG8gbWFr
ZSBtYWM4MDIxMSBzdGFjaw0KPiA+IGhhbmRsZSBzY2FubmluZyBhcyBleHBlY3RlZC4NCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBab25nLVpoZSBZYW5nIDxrZXZpbl95YW5nQHJlYWx0ZWsuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2Z3LmMgfCA4
ICsrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jDQo+ID4gaW5kZXggMGUxMjYy
OWY3ODljMy4uYTQ3NDUxZGM5ZDgxZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg5L2Z3LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0dzg5L2Z3LmMNCj4gPiBAQCAtMjUwLDYgKzI1MCw3IEBAIHN0YXRpYyB2b2lkIHJ0
dzg5X2Z3X3JlY29nbml6ZV9mZWF0dXJlcyhzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYpDQo+ID4g
IA0KPiA+ICBpbnQgcnR3ODlfZndfcmVjb2duaXplKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldikN
Cj4gPiAgew0KPiA+ICsJY29uc3Qgc3RydWN0IHJ0dzg5X2NoaXBfaW5mbyAqY2hpcCA9IHJ0d2Rl
di0+Y2hpcDsNCj4gPiAgCWludCByZXQ7DQo+ID4gIA0KPiA+ICAJcmV0ID0gX19ydHc4OV9md19y
ZWNvZ25pemUocnR3ZGV2LCBSVFc4OV9GV19OT1JNQUwpOw0KPiA+IEBAIC0yNjEsNiArMjYyLDEz
IEBAIGludCBydHc4OV9md19yZWNvZ25pemUoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2KQ0KPiA+
ICANCj4gPiAgCXJ0dzg5X2Z3X3JlY29nbml6ZV9mZWF0dXJlcyhydHdkZXYpOw0KPiA+ICANCj4g
PiArCWlmIChjaGlwLT5zdXBwb3J0X2NoYW5jdHhfbnVtICE9IDAgJiYNCj4gPiArCSAgICAhUlRX
ODlfQ0hLX0ZXX0ZFQVRVUkUoU0NBTl9PRkZMT0FELCAmcnR3ZGV2LT5mdykpIHsNCj4gPiArCQly
dHc4OV9lcnIocnR3ZGV2LA0KPiA+ICsJCQkgICJyZXF1aXJlIG5ld2VyIEZXIHRvIHN1cHBvcnQg
SFcgc2NhbiBmb3IgY2hhbmN0eFxuIik7DQo+ID4gKwkJcmV0dXJuIC1FTk9FTlQ7DQo+ID4gKwl9
DQo+IA0KPiBTbyBpZiB0aGUgdXNlciBoYXMgbm90IHVwZGF0ZSB0aGUgZmlybXdhcmUgYSBrZXJu
ZWwgdXBncmFkZSB3aWxsIGJyZWFrDQo+IHRoZWlyIGludGVybmV0PyBUaGF0J3Mgbm90IGdvb2Qs
IHdlIHNob3VsZCBub3QgYnJlYWsgZXhpc3Rpbmcgc2V0dXBzLiBTbw0KPiB3aGF0IGZpcm13YXJl
IHZlcnNpb24gaXMgcmVxdWlyZWQ/DQo+IA0KDQpGaXJtd2FyZSB2ZXJzaW9uIDAuMTMuMzUuMCBp
cyByZXF1aXJlZC4gVGhlIGZpcm13YXJlIGhhcyBiZWVuIGluDQpsaW51eC1maXJtd2FyZSByZXBv
c2l0b3J5IG9uIDIwMjItMDItMTguIEkgdGhpbmsgcGVvcGxlIGJlaW5nIGFibGUNCnRvIHVwZGF0
ZSBrZXJuZWwgY2FuIHVwZGF0ZSBmaXJtd2FyZSBhcyB3ZWxsLg0KDQpUaGUgYWx0ZXJuYXRpdmUg
d2F5cyBjb3VsZCBiZQ0KMS4gYWRkIGEgbW9kdWxlIHBhcmFtZXRlciwgbGlrZSBub19jaGFubmVs
X2NvbnRleHQuIFdlIGNhbiBhZGQgYQ0KICAgcHJvbXB0IHRvIG5vdGUgcGVvcGxlIGNhbiBzZXQg
aXQgdG8gMSBmb3Igb2xkIGZpcm13YXJlLg0KDQoyLiB3YWl0IHZlcnNpb24gb2YgcmVxdWVzdF9m
aXJtd2FyZSgpIGFzIGZpcnN0IHN0ZXAgb2YgcGNpIHByb2JlLg0KICAgVGhlIHByb2JlIGNvdWxk
IGNvc3QgbG9uZ2VyIHRpbWUsIGJlY2F1c2UgY3VycmVudGx5IHdlIHVzZQ0KICAgcmVxdWVzdF9m
aXJtd2FyZV9ub3dhaXQoKSBhbmQgY29udGludWUgdG8gaW5pdGlhbGl6ZSBpbiBwYXJhbGxlbC4N
CiAgIE1vcmUsIGh3LT5wcml2IGlzbid0IGFsbG9jYXRlZCBhdCB0aGF0IG1vbWVudCwgc28gaXQg
Y291bGQgYmUgbm90DQogICBzbyBzdHJhaWdodGZvcndhcmQuDQoNCg0KUGluZy1LZQ0KDQo=
