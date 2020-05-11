Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858E91CD200
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 08:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgEKGnl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 02:43:41 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55840 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgEKGnk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 02:43:40 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04B6hP5R1012387, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04B6hP5R1012387
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 May 2020 14:43:25 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 11 May 2020 14:43:25 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 11 May 2020 14:43:24 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Mon, 11 May 2020 14:43:24 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Tony Chuang <yhchuang@realtek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH 28/40] rtw88: 8723d: Add shutdown callback to disable BT USB suspend
Thread-Topic: [PATCH 28/40] rtw88: 8723d: Add shutdown callback to disable BT
 USB suspend
Thread-Index: AQHWFIxjqUfp76n5/Um/OMmxE13LEqiZH+SAgADO4ICAASRJgIAAjRMAgAb0cGA=
Date:   Mon, 11 May 2020 06:43:24 +0000
Message-ID: <f5a7fea0459741368ab047a4cbfab4ea@realtek.com>
References: <20200417074653.15591-1-yhchuang@realtek.com>
 <20200417074653.15591-29-yhchuang@realtek.com>
 <20200505141455.k2mk7tmuiujfv2sh@linutronix.de>
 <c7083dc760464c1a9017888457c1718d@realtek.com>
 <20200506200129.suid6lfkdwuoapzl@linutronix.de>
 <2ee629b3bb374532b0830a39b57c2389@realtek.com>
In-Reply-To: <2ee629b3bb374532b0830a39b57c2389@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgVG9ueSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUb255IENo
dWFuZw0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDA3LCAyMDIwIDEyOjI2IFBNDQo+IFRvOiBTZWJh
c3RpYW4gQW5kcnplaiBTaWV3aW9yDQo+IENjOiBrdmFsb0Bjb2RlYXVyb3JhLm9yZzsgUGtzaGlo
OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IGJyaWFubm9ycmlzQGNocm9taXVtLm9y
ZzsgS2V2aW4NCj4gWWFuZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDI4LzQwXSBydHc4ODogODcy
M2Q6IEFkZCBzaHV0ZG93biBjYWxsYmFjayB0byBkaXNhYmxlIEJUIFVTQiBzdXNwZW5kDQo+IA0K
PiBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yIDxiaWdlYXN5QGxpbnV0cm9uaXguZGU+IHdyaXRl
cw0KPiA+IE9uIDIwMjAtMDUtMDYgMDI6MzU6MjEgWyswMDAwXSwgVG9ueSBDaHVhbmcgd3JvdGU6
DQo+ID4gPiA+IE9uIDIwMjAtMDQtMTcgMTU6NDY6NDEgWyswODAwXSwgeWhjaHVhbmdAcmVhbHRl
ay5jb20gd3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRl
ay5jb20+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBXaXRob3V0IHRoaXMgcGF0Y2gsIHdpZmkgY2Fy
ZCBjYW4ndCBpbml0aWFsaXplIHByb3Blcmx5IGR1ZSB0byBCVCBpbiBVU0INCj4gPiA+ID4gPiBz
dXNwZW5kIHN0YXRlLiBTbywgd2UgZGlzYWJsZSBCVCBVU0Igc3VzcGVuZCAod2FrZXVwKSBpbiBz
aHV0ZG93bg0KPiA+IGNhbGxiYWNrDQo+ID4gPiA+ID4gdGhhdCBpcyB0aGUgbW9tZW50IGJlZm9y
ZSByZWJvb3RpbmcuIFRvIHNhdmUgQlQgVVNCIHBvd2VyLCB3ZSBjYW4ndCBkbw0KPiA+IHRoaXMN
Cj4gPiA+ID4gPiBpbiAncmVtb3ZlJyBjYWxsYmFjay4NCj4gPiA+ID4NCj4gPiA+ID4gU28geW91
IGNhbid0IGluaXRpYWxpemUgdGhlIFVTQiBwYXJ0IGJlY2F1c2UgaXQgaXMgaW4gc3VzcGVuZCBh
bmQgdGhlDQo+ID4gPiA+IG9ubHkgd2F5IHRvIGF2b2lkIGl0IHRvIGRpc2FibGUgaXQgb24gdGhl
IFBDSSBzaWRlLiBUaGF0IG1lYW5zIHlvdSBkb24ndA0KPiA+ID4gPiBzZWUgaXQgZW51bWVyYXRl
ZCBvbiB0aGUgVVNCIGJ1cyBhdCBhbGw/DQo+ID4gPg0KPiA+ID4gWWVzLCBpZiB3ZSBkb24ndCBk
aXNhYmxlIGl0IG9uIFBDSSBzaWRlLCB0aGVuIHRoZSBVU0IgcGFydCBjYW5ub3QgYmUNCj4gPiA+
IHByb2JlZCBvbiBVU0IgYnVzLg0KPiA+DQo+ID4gV2UgdGFsayBoZXJlIGFib3V0IFVTQidzIHJ1
bnRpbWUtc3VzcGVuZCAvIGF1dG9zdXNwZW5kPyBJZiBzbywgYXJlIHlvdQ0KPiA+IGF3YXJlIG9m
IGNvbW1pdA0KPiA+ICAgN2VjYWNhZmMyNDA2MyAoIkJsdWV0b290aDogYnR1c2I6IERpc2FibGUg
cnVudGltZSBzdXNwZW5kIG9uIFJlYWx0ZWsNCj4gPiBkZXZpY2VzIikNCj4gPg0KPiA+IG9yIGlz
IHRoaXMgYW4gYXR0ZW1wdCB0byBnZXQgcmlkIG9mIHRoaXMgY2hhbmdlIGluIGZhdm91ciBvZiB0
aGlzIG9uZQ0KPiA+IChzbyB0aGF0IHRoZSBkZXZpY2UgY2FuIGVudGVyIHN1c3BlbmQtbW9kZSk/
DQo+ID4NCj4gDQo+IFBpbmctS2UsIGNhbiB5b3UgcGxlYXNlIGhlbHAgdG8gY2hlY2sgb24gdGhp
cyA/DQo+IExvb2tzIGxpa2UgS2FpLUhlbmcgaXMgZG9pbmcgdGhlIG11Y2ggc2FtZSB0aGluZyBo
ZXJlLg0KPiANCg0KVGhlIEthaS1IZW5nJ3MgcGF0Y2ggdHVybnMgb2ZmIHN1c3BlbmQgZW50aXJl
bHksIHNvIEkgYmVsaWV2ZSBpZiB0aGUgcGF0Y2gNCmlzIGV4aXN0aW5nLCB0aGlzIHBhdGNoIGRv
ZXNuJ3QgYWZmZWN0IHRoZSByZXN1bHQuDQpIb3dldmVyLCB0aGUgcGF0Y2ggc2VlbXMgbGlrZSBh
IHRlbXBvcmFsIGZpeCwgc28gdGhpcyBwYXRjaCBpcyBuZWVkZWQuDQoNCg0KPiBCdXQgaXQncyBz
dGlsbCB3b3J0aCB0byBkbyBpdCBpbiB3aWZpIHNpZGUgSSB0aGluaywgYmVjYXVzZSBpdCdzIGRp
ZmZpY3VsdCB0bw0KPiBtYWtlIHN1cmUgdGhlIHN5bmNocm9uaXphdGlvbiBvZiBCVCBhbmQgV2lm
aSBwYXRjaC4NCj4gDQpBZ3JlZS4NCg0KDQpUaGFuayB5b3UNClBLDQoNCg0KDQo=
