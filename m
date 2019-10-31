Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70405EAB77
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 09:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfJaIRq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 04:17:46 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:54070 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfJaIRq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 04:17:46 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9V8Hb2t021015, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9V8Hb2t021015
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Oct 2019 16:17:38 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS11.realtek.com.tw ([fe80::7c6d:ced5:c4ff:8297%15]) with mapi id
 14.03.0468.000; Thu, 31 Oct 2019 16:17:37 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "g.schlmm@googlemail.com" <g.schlmm@googlemail.com>
Subject: RE: [PATCH 3/6] rtw88: use a module parameter to control LPS enter
Thread-Topic: [PATCH 3/6] rtw88: use a module parameter to control LPS enter
Thread-Index: AQHVixdU7Df1/OOTokC0rqDmBUERUKdz5d2AgACHtpA=
Date:   Thu, 31 Oct 2019 08:17:37 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D1914F4C@RTITMBSVM04.realtek.com.tw>
References: <20191025093345.22643-4-yhchuang@realtek.com>
 <20191031075911.3CCB86079C@smtp.codeaurora.org>
In-Reply-To: <20191031075911.3CCB86079C@smtp.codeaurora.org>
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

RnJvbTogS2FsbGUgVmFsbw0KPiA8eWhjaHVhbmdAcmVhbHRlay5jb20+IHdyb3RlOg0KPiANCj4g
PiBGcm9tOiBZYW4tSHN1YW4gQ2h1YW5nIDx5aGNodWFuZ0ByZWFsdGVrLmNvbT4NCj4gPg0KPiA+
IElmIHRoZSBudW1iZXIgb2YgcGFja2V0cyBpcyBsZXNzIHRoYW4gdGhlIExQUyB0aHJlc2hvbGQs
IGRyaXZlcg0KPiA+IGNhbiB0aGVuIGVudGVyIExQUyBtb2RlLg0KPiA+IEFuZCBkcml2ZXIgdXNl
ZCB0byB0YWtlIFJUV19MUFNfVEhSRVNIT0xEIGFzIHRoZSB0aHJlc2hvbGQuIEFzDQo+ID4gdGhl
IG1hY3JvIGNhbiBub3QgYmUgY2hhbmdlZCBhZnRlciBjb21waWxlZCwgdXNlIGEgcGFyYW1ldGVy
DQo+ID4gaW5zdGVhZC4NCj4gPg0KPiA+IFRoZSBsYXJnZXIgb2YgdGhlIHRocmVzaG9sZCwgdGhl
IG1vcmUgdHJhZmZpYyByZXF1aXJlZCB0byBsZWF2ZQ0KPiA+IHBvd2VyIHNhdmUgbW9kZSwgcmVz
cG9uc2l2ZSB0aW1lIGNvdWxkIGJlIGxvbmdlciwgYnV0IGFsc28gdGhlDQo+ID4gcG93ZXIgY29u
c3VtcHRpb24gY291bGQgYmUgbG93ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW4tSHN1
YW4gQ2h1YW5nIDx5aGNodWFuZ0ByZWFsdGVrLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQ2hyaXMg
Q2hpdSA8Y2hpdUBlbmRsZXNzbS5jb20+DQo+IA0KPiBJIGRvbid0IHRoaW5rIGEgbW9kdWxlIHBh
cmFtZXRlciBzaG91bGQgYmUgdXNlZCB0byBjb250cm9sIHBvd2VyIHNhdmUNCj4gbGV2ZWwsIGlu
c3RlYWQgdGhlcmUgc2hvdWxkIGJlIGEgZ2VuZXJpYyBpbnRlcmZhY2UgZm9yIHRoYXQuIEFsc28g
dGhlIGNvbW1pdA0KPiBsb2cgZG9lcyBub3QgZ2l2ZSBhbnkgZXhwbGFuYXRpb24gd2h5IHRoaXMg
bmVlZHMgdG8gYmUgYSBtb2R1bGUgcGFyYW1ldGVyLg0KPiANCj4gVG9ueSwgdGhlcmUncyBhIGhp
Z2ggYmFycmllciBmb3IgYWRkaW5nIG5ldyBtb2R1bGUgcGFyYW1ldGVycy4gSXQncyBhDQo+IGNv
bW1vbg0KPiBwaHJhc2UgZm9yIG1lIHRvIHNheSAibW9kdWxlIHBhcmFtZXRlcnMgYXJlIG5vdCB3
aW5kb3dzIC5pbmkgZmlsZXMiLiBBbmQgdG8NCj4gbWFrZSBpdA0KPiBlYXNpZXIgZm9yIGV2ZXJ5
b25lIGFsd2F5cyBzdWJtaXQgY29udHJvdmVyc2lhbCBwYXRjaGVzIHNlcGFyYXRlbHksIGRvIG5v
dA0KPiBoaWRlDQo+IHdpdGhpbiBhIGJpZ2dlciBwYXRjaHNldC4NCj4gDQoNCkFscmlnaHQsIEkg
d2FzIHRoaW5raW5nIG1vZHVsZSBwYXJhbWV0ZXJzIGFzIGEgY29udmVuaWVudCB0b29sIGZvciBk
cml2ZXIgdG8NCmNvbnRyb2wgdGhlIGJlaGF2aW9yIGZvciBkZWJ1Z2dpbmcgb3Igb3V0LW9mLWJh
bmQgYWRqdXN0aW5nLiBCdXQgaXQgc2VlbXMgbGlrZQ0KeW91IHRyZWF0IGl0IG1vcmUgY2FyZWZ1
bGx5Lg0KDQpBY3R1YWxseSB0aGlzIGlzIGp1c3QgZ29pbmcgdG8gYWxsb3cgdXMgdG8gc2V0IGRp
ZmZlcmVudCBkZWZhdWx0IHZhbHVlcyBmb3IgZGlmZmVyZW50DQp1c2UgY2FzZXMuIFNvIGlzIHRo
ZXJlIGEgYmV0dGVyIHdheSB0byBjb250cm9sIGl0LiBPciBJIHNob3VsZCBqdXN0IGNoYW5nZSB0
aGUNCnZhbHVlIHRvIGEgYmV0dGVyIG9uZS4gQnkgb3VyIGV4cGVyaWVuY2UsIHNldCB0aGlzIHRv
IDUwIGlzIGEgbW9yZSByZWFzb25hYmxlDQp2YWx1ZSwgc3VjaCB0aGF0IHNvbWUgd2ViIHN1cmZp
bmcgb3IgYmFja2dyb3VuZCB0cmFmZmljIHdvdWxkbid0IG1ha2UgdGhlDQpkcml2ZXIgdG8gbGVh
dmUgUFMgbW9kZS4NCg0KWWFuLUhzdWFuDQo=
