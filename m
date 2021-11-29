Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0763460CAA
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 03:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241406AbhK2Cay (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Nov 2021 21:30:54 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39858 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbhK2C2x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Nov 2021 21:28:53 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AT2PUHQ0013623, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AT2PUHQ0013623
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Nov 2021 10:25:30 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 10:25:29 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 28 Nov 2021 18:25:29 -0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::b4ec:3ff6:125f:9d2d]) by
 RTEXDAG02.realtek.com.tw ([fe80::b4ec:3ff6:125f:9d2d%7]) with mapi id
 15.01.2308.020; Mon, 29 Nov 2021 10:25:29 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "yhchuang@realtek.com" <yhchuang@realtek.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>
Subject: RE: [PATCH] rtw88: add debugfs to fix tx rate
Thread-Topic: [PATCH] rtw88: add debugfs to fix tx rate
Thread-Index: AQHX4uGzmkpG7RrVLEqK/hOvpYxRiKwZxdnA
Date:   Mon, 29 Nov 2021 02:25:29 +0000
Message-ID: <8af935cc65414354b937a4508ccdb794@realtek.com>
References: <20200313065114.23433-1-yhchuang@realtek.com>
 <163794357152.10370.14049415292167225860.kvalo@codeaurora.org>
In-Reply-To: <163794357152.10370.14049415292167225860.kvalo@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzI4IOS4i+WNiCAxMTo0MzowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGt2YWxvPWNvZGVhdXJvcmEu
b3JnQG1nLmNvZGVhdXJvcmEub3JnIDxrdmFsbz1jb2RlYXVyb3JhLm9yZ0BtZy5jb2RlYXVyb3Jh
Lm9yZz4gT24gQmVoYWxmIE9mIEthbGxlDQo+IFZhbG8NCj4gU2VudDogU2F0dXJkYXksIE5vdmVt
YmVyIDI3LCAyMDIxIDEyOjIwIEFNDQo+IFRvOiB5aGNodWFuZ0ByZWFsdGVrLmNvbQ0KPiBDYzog
bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcnR3ODg6IGFkZCBkZWJ1Z2ZzIHRvIGZpeCB0eCByYXRl
DQo+IA0KPiA8eWhjaHVhbmdAcmVhbHRlay5jb20+IHdyb3RlOg0KPiANCj4gPiBGcm9tOiBZYW4t
SHN1YW4gQ2h1YW5nIDx5aGNodWFuZ0ByZWFsdGVrLmNvbT4NCj4gPg0KPiA+IEl0IGlzIHVzZWZ1
bCB0byBmaXggdGhlIGJpdCByYXRlIG9mIFRYIHBhY2tldHMuIEZvciBleGFtcGxlLCBpZg0KPiA+
IHNvbWVvbmUgaXMgbWVhc3VyaW5nIHRoZSBUWCBwb3dlciwgb3IgZGVidWdnaW5nIHdpdGggdGhl
IGlzc3Vlcw0KPiA+IG9mIHRoZSBUWCB0aHJvdWdocHV0IG9uIHRoZSBmaWVsZC4NCj4gPg0KPiA+
IFRvIHNldCB0aGUgdmFsdWUgb2YgZml4ZWQgcmF0ZSwgb25lIHNob3VsZCBpbnB1dCBjb3JyZXNw
b25kaW5nDQo+ID4gZGVzYyByYXRlIGluZGV4IChleCwgMHgwYiBmb3IgREVTQ19SQVRFNTRNIHRv
IGZpeCBhdCA1NCBNYnBzKS4NCj4gPiBTZXQgYSB2YWx1ZSBsYXJnZXIgdGhhbiBERVNDX1JBVEVf
TUFYIHdpbGwgZGlzYWJsZSBmaXggcmF0ZSwgc28NCj4gPiB0aGUgcmF0ZSBhZGFwdGl2ZSBtZWNo
YW5pc20gY2FuIHJlc3VtZSB0byB3b3JrLg0KPiA+DQo+ID4gRXhhbXBsZSwNCj4gPiAgIFRvIGZp
eCByYXRlIGF0IE1DUyAxOg0KPiA+ICAgZWNobyAweDBkID4gL3N5cy9rZXJuZWwvZGVidWcvaWVl
ZTgwMjExL3BoeTAvcnR3ODgvZml4X3JhdGUNCj4gPg0KPiA+ICAgVG8gbm90IHRvIGZpeCByYXRl
Og0KPiA+ICAgZWNobyAweGZmID4gL3N5cy9rZXJuZWwvZGVidWcvaWVlZTgwMjExL3BoeTAvcnR3
ODgvZml4X3JhdGUNCj4gPg0KPiA+ICAgVG8ga25vdyB3aGljaCByYXRlIHdhcyBmaXhlZCBhdDoN
Cj4gPiAgIGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9pZWVlODAyMTEvcGh5MC9ydHc4OC9maXhfcmF0
ZQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWFuLUhzdWFuIENodWFuZyA8eWhjaHVhbmdAcmVh
bHRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEJyaWFuIE5vcnJpcyA8YnJpYW5ub3JyaXNAY2hy
b21pdW0ub3JnPg0KPiA+IFRlc3RlZC1ieTogQnJpYW4gTm9ycmlzIDxicmlhbm5vcnJpc0BjaHJv
bWl1bS5vcmc+DQo+IA0KPiBTbyB0aGUgY29uY2Vuc3VzIHdhcyB0aGF0IGRvaW5nIHRoaXMgZnJv
bSBkZWJ1Z2ZzIGlzIG9rLCBidXQNCj4gdW5mb3J0dW5hdGVseSB0aGlzIGRvZXNuJ3QgYXBwbHkg
YW55bW9yZS4gUGxlYXNlIHJlc3Bpbi4NCj4gDQo+IFJlY29yZGVkIHByZWltYWdlIGZvciAnZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC90eC5jJw0KPiBlcnJvcjogRmFpbGVkIHRv
IG1lcmdlIGluIHRoZSBjaGFuZ2VzLg0KPiBoaW50OiBVc2UgJ2dpdCBhbSAtLXNob3ctY3VycmVu
dC1wYXRjaCcgdG8gc2VlIHRoZSBmYWlsZWQgcGF0Y2gNCj4gQXBwbHlpbmc6IHJ0dzg4OiBhZGQg
ZGVidWdmcyB0byBmaXggdHggcmF0ZQ0KPiBVc2luZyBpbmRleCBpbmZvIHRvIHJlY29uc3RydWN0
IGEgYmFzZSB0cmVlLi4uDQo+IE0JZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9k
ZWJ1Zy5jDQo+IE0JZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmMNCj4g
TQlkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uaA0KPiBNCWRyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdHguYw0KPiBGYWxsaW5nIGJhY2sgdG8gcGF0Y2hp
bmcgYmFzZSBhbmQgMy13YXkgbWVyZ2UuLi4NCj4gQXV0by1tZXJnaW5nIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnR3ODgvdHguYw0KPiBDT05GTElDVCAoY29udGVudCk6IE1lcmdlIGNv
bmZsaWN0IGluIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdHguYw0KPiBBdXRv
LW1lcmdpbmcgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmgNCj4gQXV0
by1tZXJnaW5nIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5jDQo+IEF1
dG8tbWVyZ2luZyBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L2RlYnVnLmMNCj4g
UGF0Y2ggZmFpbGVkIGF0IDAwMDEgcnR3ODg6IGFkZCBkZWJ1Z2ZzIHRvIGZpeCB0eCByYXRlDQo+
IA0KPiBQYXRjaCBzZXQgdG8gQ2hhbmdlcyBSZXF1ZXN0ZWQuDQo+IA0KDQpJIGhhdmUgZG9uZSBy
ZWJhc2UgYW5kIHNlbnQgb3V0Lg0KVGhhbmsgeW91DQoNClsxXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC13aXJlbGVzcy8yMDIxMTEyOTAyMDUwNi42MjczLTEtcGtzaGloQHJlYWx0ZWsu
Y29tL1QvI3UNCg0KLS0NClBpbmctS2UNCg0K
