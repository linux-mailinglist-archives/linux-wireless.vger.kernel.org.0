Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2F44E6B4B
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2019 04:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfJ1DNK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Oct 2019 23:13:10 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:52351 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfJ1DNK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Oct 2019 23:13:10 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9S3Cvm0028398, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9S3Cvm0028398
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Oct 2019 11:12:57 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Mon, 28 Oct
 2019 11:12:57 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Chris Chiu <chiu@endlessm.com>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        "g.schlmm@googlemail.com" <g.schlmm@googlemail.com>
Subject: RE: [PATCH 3/6] rtw88: use a module parameter to control LPS enter
Thread-Topic: [PATCH 3/6] rtw88: use a module parameter to control LPS enter
Thread-Index: AQHVixdU7Df1/OOTokC0rqDmBUERUKdqqAoAgAS8baA=
Date:   Mon, 28 Oct 2019 03:12:55 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D1911E08@RTITMBSVM04.realtek.com.tw>
References: <20191025093345.22643-1-yhchuang@realtek.com>
 <20191025093345.22643-4-yhchuang@realtek.com>
 <CAB4CAwf_Y0tMG37nZDtsU9FmACaOB=eALCNCazVk1kbAvOE26Q@mail.gmail.com>
In-Reply-To: <CAB4CAwf_Y0tMG37nZDtsU9FmACaOB=eALCNCazVk1kbAvOE26Q@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.183]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiBPbiBGcmksIE9jdCAyNSwgMjAxOSBhdCA1OjMzIFBNIDx5aGNodWFuZ0ByZWFsdGVrLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBZYW4tSHN1YW4gQ2h1YW5nIDx5aGNodWFuZ0ByZWFsdGVr
LmNvbT4NCj4gPg0KPiA+IElmIHRoZSBudW1iZXIgb2YgcGFja2V0cyBpcyBsZXNzIHRoYW4gdGhl
IExQUyB0aHJlc2hvbGQsIGRyaXZlcg0KPiA+IGNhbiB0aGVuIGVudGVyIExQUyBtb2RlLg0KPiA+
IEFuZCBkcml2ZXIgdXNlZCB0byB0YWtlIFJUV19MUFNfVEhSRVNIT0xEIGFzIHRoZSB0aHJlc2hv
bGQuIEFzDQo+ID4gdGhlIG1hY3JvIGNhbiBub3QgYmUgY2hhbmdlZCBhZnRlciBjb21waWxlZCwg
dXNlIGEgcGFyYW1ldGVyDQo+ID4gaW5zdGVhZC4NCj4gPg0KPiA+IFRoZSBsYXJnZXIgb2YgdGhl
IHRocmVzaG9sZCwgdGhlIG1vcmUgdHJhZmZpYyByZXF1aXJlZCB0byBsZWF2ZQ0KPiA+IHBvd2Vy
IHNhdmUgbW9kZSwgcmVzcG9uc2l2ZSB0aW1lIGNvdWxkIGJlIGxvbmdlciwgYnV0IGFsc28gdGhl
DQo+ID4gcG93ZXIgY29uc3VtcHRpb24gY291bGQgYmUgbG93ZXIuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBZYW4tSHN1YW4gQ2h1YW5nIDx5aGNodWFuZ0ByZWFsdGVrLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmMgfCA3ICsrKysr
LS0NCj4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9wcy5oICAgfCAyIC0t
DQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgv
bWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmMNCj4g
PiBpbmRleCA3YzFiODljNGZiNmMuLmJmZjhhMGIxMjlkOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5jDQo+IA0KPiA+IEBAIC0xOTksOCArMjAy
LDggQEAgc3RhdGljIHZvaWQgcnR3X3dhdGNoX2RvZ193b3JrKHN0cnVjdA0KPiB3b3JrX3N0cnVj
dCAqd29yaykNCj4gPiAgICAgICAgIGlmIChidXN5X3RyYWZmaWMgIT0gdGVzdF9iaXQoUlRXX0ZM
QUdfQlVTWV9UUkFGRklDLA0KPiBydHdkZXYtPmZsYWdzKSkNCj4gPiAgICAgICAgICAgICAgICAg
cnR3X2NvZXhfd2xfc3RhdHVzX2NoYW5nZV9ub3RpZnkocnR3ZGV2KTsNCj4gPg0KPiA+IC0gICAg
ICAgaWYgKHN0YXRzLT50eF9jbnQgPiBSVFdfTFBTX1RIUkVTSE9MRCB8fA0KPiA+IC0gICAgICAg
ICAgIHN0YXRzLT5yeF9jbnQgPiBSVFdfTFBTX1RIUkVTSE9MRCkNCj4gPiArICAgICAgIGlmIChz
dGF0cy0+dHhfY250ID4gcnR3X2xwc190aHJlc2hvbGQgfHwNCj4gPiArICAgICAgICAgICBzdGF0
cy0+cnhfY250ID4gcnR3X2xwc190aHJlc2hvbGQpDQo+ID4gICAgICAgICAgICAgICAgIHBzX2Fj
dGl2ZSA9IHRydWU7DQo+ID4gICAgICAgICBlbHNlDQo+ID4gICAgICAgICAgICAgICAgIHBzX2Fj
dGl2ZSA9IGZhbHNlOw0KPiANCj4gVGhlIG5hbWluZyBvZiAncHNfYWN0aXZlJyBpcyBhIGJpdCBj
b25mdXNpbmcuIFBlciB0aGUgY29tbWl0IG1lc3NhZ2UsDQo+IGl0IHdpbGwgbGVhdmUgTFBTDQo+
IGl0IHR4L3J4IGNvdW50ID4gdGhyZXNob2xkLiBCdXQgSSdsbCBiZSBtaXNsZWQgYnkgdGhlIG5h
bWUgcHNfYWN0aXZlLg0KPiBEb2VzIGl0IG1lYW4gdGhlDQo+IGN1cnJlbnQgY29uZGl0aW9uIGlz
IFBTIGFjdGl2ZSBhbmQgcmVhZHkgdG8gcG93ZXIgc2xlZXA/IEknZCBsaWtlIHRvDQo+IHJlbmFt
ZSBpdCB0byBvbGQtZmFzaGlvbmVkDQo+ICdscHNfZW50ZXInIHRvIHJlcHJlc2VudCB0aGUgYWN0
aW9uIHRoYXQgd291bGQgYmUgdGFrZW4uIEl0IHdvdWxkIGJlDQo+IGVhc2llciBmb3IgbWUgdG8g
dW5kZXJzdGFuZC4NCj4gDQo+IENocmlzDQo+IA0KDQpJIHRoaW5rIGFjY29yZGluZyB0byB0aGUg
Y29udGV4dCwgcHNfYWN0aXZlIGlzIGdvb2QgZm9yIG1lLg0KQnV0IEkgY2FuIHN0aWxsIHNlbmQg
YSBzZXBhcmF0ZSBwYXRjaCB0byByZW5hbWUgaXQuDQpPciB5b3UgY2FuIDopDQoNCllhbi1Ic3Vh
bg0K
