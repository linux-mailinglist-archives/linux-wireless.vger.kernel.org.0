Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88BBF1324BB
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2020 12:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgAGLVi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jan 2020 06:21:38 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60126 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGLVi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jan 2020 06:21:38 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 007BLQ05013713, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 007BLQ05013713
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 7 Jan 2020 19:21:26 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTITCASV02.realtek.com.tw (172.21.6.19) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Tue, 7 Jan 2020 19:21:26 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 7 Jan 2020 19:21:26 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Tue, 7 Jan 2020 19:21:26 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Chris Chiu <chiu@endlessm.com>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        "mikhail.v.gavrilov@gmail.com" <mikhail.v.gavrilov@gmail.com>,
        "rtereguloff@gmail.com" <rtereguloff@gmail.com>
Subject: RE: [PATCH] rtw88: fix potential NULL skb access in TX ISR
Thread-Topic: [PATCH] rtw88: fix potential NULL skb access in TX ISR
Thread-Index: AQHVxTGiMOLXsg77gUalprFlQHz+SqfefTwAgACQ6FA=
Date:   Tue, 7 Jan 2020 11:21:26 +0000
Message-ID: <5ffa570167b34b77ab05cdf490812a59@realtek.com>
References: <20200107080807.14433-1-yhchuang@realtek.com>
 <CAB4CAwfxQJzsJfxScVE+Y_xYbdSigTf567b9Xv-LFyQQnOXEAA@mail.gmail.com>
In-Reply-To: <CAB4CAwfxQJzsJfxScVE+Y_xYbdSigTf567b9Xv-LFyQQnOXEAA@mail.gmail.com>
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

RnJvbTogQ2hyaXMgQ2hpdQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBydHc4ODogZml4IHBvdGVu
dGlhbCBOVUxMIHNrYiBhY2Nlc3MgaW4gVFggSVNSDQo+IA0KPiBPbiBUdWUsIEphbiA3LCAyMDIw
IGF0IDQ6MDggUE0gPHloY2h1YW5nQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206
IFlhbi1Ic3VhbiBDaHVhbmcgPHloY2h1YW5nQHJlYWx0ZWsuY29tPg0KPiA+DQo+ID4gU29tZXRp
bWVzIHRoZSBUWCBxdWV1ZSBtYXkgYmUgZW1wdHkgYW5kIHdlIGNvdWxkIHBvc3NpYmxlDQo+ID4g
ZGVxdWV1ZSBhIE5VTEwgcG9pbnRlciwgY3Jhc2ggdGhlIGtlcm5lbC4gSWYgdGhlIHNrYiBpcyBO
VUxMDQo+ID4gdGhlbiB0aGVyZSBpcyBub3RoaW5nIHRvIGRvLCBqdXN0IGxlYXZlIHRoZSBJU1Iu
DQo+ID4NCj4gPiBBbmQgdGhlIFRYIHF1ZXVlIHNob3VsZCBub3QgYmUgZW1wdHkgaGVyZSwgc28g
cHJpbnQgYW4gZXJyb3INCj4gPiB0byBzZWUgaWYgdGhlcmUgaXMgYW55dGhpbmcgd3JvbmcgZm9y
IERNQSByaW5nLg0KPiA+DQo+ID4gRml4ZXM6IGUzMDM3NDg1YzY4ZSAoInJ0dzg4OiBuZXcgUmVh
bHRlayA4MDIuMTFhYyBkcml2ZXIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFlhbi1Ic3VhbiBDaHVh
bmcgPHloY2h1YW5nQHJlYWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg4L3BjaS5jIHwgNSArKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OC9wY2kuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODgvcGNpLmMNCj4gPiBpbmRleCBhNThlODI3NmE0MWEuLmE2NzQ2YjVhOWZmMiAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BjaS5jDQo+ID4g
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9wY2kuYw0KPiA+IEBAIC04
MzIsNiArODMyLDExIEBAIHN0YXRpYyB2b2lkIHJ0d19wY2lfdHhfaXNyKHN0cnVjdCBydHdfZGV2
ICpydHdkZXYsDQo+IHN0cnVjdCBydHdfcGNpICpydHdwY2ksDQo+ID4NCj4gPiAgICAgICAgIHdo
aWxlIChjb3VudC0tKSB7DQo+ID4gICAgICAgICAgICAgICAgIHNrYiA9IHNrYl9kZXF1ZXVlKCZy
aW5nLT5xdWV1ZSk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmICghc2tiKSB7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgcnR3X2VycihydHdkZXYsICJmYWlsZWQgdG8gZGVxdWV1ZSAlZCBz
a2IgVFgNCj4gcXVldWUgJWQsIEJEPTB4JTA4eCwgcnAgJWQgLT4gJWRcbiIsDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb3VudCwgaHdfcXVldWUsIGJkX2lkeCwgcmluZy0+
ci5ycCwNCj4gY3VyX3JwKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4g
PiArICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgICAgICB0eF9kYXRhID0gcnR3X3Bj
aV9nZXRfdHhfZGF0YShza2IpOw0KPiA+ICAgICAgICAgICAgICAgICBwY2lfdW5tYXBfc2luZ2xl
KHJ0d3BjaS0+cGRldiwgdHhfZGF0YS0+ZG1hLA0KPiBza2ItPmxlbiwNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBQQ0lfRE1BX1RPREVWSUNFKTsNCj4gPiAtLQ0KPiA+IDIu
MTcuMQ0KPiA+DQo+IA0KPiBNYXliZSB3ZSBjYW4gc2ltcGx5IGRvICd3aGlsZSAoY291bnQgLS0g
JiYNCj4gIXNrYl9xdWV1ZV9lbXB0eSgmcmluZy0+cXVldWUpKScgdG8gYWNoaWV2ZSB0aGUgc2Ft
ZSB0aGluZz8NCj4gSSBkb24ndCB0aGluayBpdCB3b3J0aHMgdG8gcmFpc2UgYW4gZXJyb3IgdW5s
ZXNzIHRoZSBjb3VudCBpcyBleHBlY3RlZA0KPiB0byBleGFjdGx5IG1hdGNoIHRoZSBxdWV1ZSBs
ZW5ndGggaW4gYW55DQo+IGNpcmN1bXN0YW5jZXMuDQo+IA0KDQpZZXMsIEkgZXhwZWN0ZWQgdGhh
dCB0aGUgcXVldWUgbGVuZ3RoIHNob3VsZCBtYXRjaCB3aXRoIHRoZSBETUEgcmluZy4NCkFuZCBz
byBJIHByaW50ZWQgYW4gZXJyb3IgdG8gc2VlIHdoeSB0aGUgY291bnQgbWlzbWF0Y2hlZC4NCg0K
WWFuLUhzdWFuDQo=
