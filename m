Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95E5119396A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 08:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCZHLo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 03:11:44 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57031 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgCZHLn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 03:11:43 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02Q7BYBf008490, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02Q7BYBf008490
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 15:11:34 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 26 Mar 2020 15:11:34 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 26 Mar 2020 15:11:34 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Thu, 26 Mar 2020 15:11:34 +0800
From:   Andy Huang <tehuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     Tony Chuang <yhchuang@realtek.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v6 1/2] rtw88: add regulatory process strategy for different chipset
Thread-Topic: [PATCH v6 1/2] rtw88: add regulatory process strategy for
 different chipset
Thread-Index: AQHWAbEl1VdHuwtD6ECbbBug2CjJDahXb1KAgAEZeTCAAQ4fgIAA4FVQ
Date:   Thu, 26 Mar 2020 07:11:34 +0000
Message-ID: <a6ba63574ce145cf9457429cbb3ca389@realtek.com>
References: <20200324075216.22553-1-yhchuang@realtek.com>
 <20200324075216.22553-2-yhchuang@realtek.com>
 <20200324165105.GA99185@google.com>
 <c17c6e7243e642679a38854e6e6cda96@realtek.com>
 <CA+ASDXM49NW1atMoGgEgU0R7siCnhLf6eRawReGiD=PNe-hMrA@mail.gmail.com>
In-Reply-To: <CA+ASDXM49NW1atMoGgEgU0R7siCnhLf6eRawReGiD=PNe-hMrA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.231]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gWyBJJ2xsIHByZWZhY2UgdGhpcyBieSBzYXlpbmcgdGhhdCB0aGUgbW9yZSBJIGxvb2sg
YXQgdGhlIHJlZ3VsYXRvcnkNCj4gY29yZSwgdGhlIG1vcmUgSSByZWFsaXplIEknbSBjb25mdXNl
ZCBvciB3cm9uZyBhdCB0aW1lcy4gU28gZm9yZ2l2ZSBtZQ0KPiBpZiBJJ3ZlIG1hZGUgZXJyb3Jz
IGFsb25nIHRoZSB3YXksIGFuZCBwbGVhc2UgZG8gY29ycmVjdCBtZS4gXQ0KPiANCj4gT24gVHVl
LCBNYXIgMjQsIDIwMjAgYXQgODoxMSBQTSBBbmR5IEh1YW5nIDx0ZWh1YW5nQHJlYWx0ZWsuY29t
PiB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgTWFyIDI0LCAyMDIwIGF0IDAzOjUyOjE1UE0gKzA4MDAs
IHloY2h1YW5nQHJlYWx0ZWsuY29tDQo+IHdyb3RlOg0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L0tjb25maWcNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9LY29uZmlnDQo+IA0KPiA+ID4gSSdtIHN0aWxsIG5v
dCBzdXJlIHdoeSBydHc4OCBuZWVkcyB0aGlzLCBhbmQgbm9ib2R5IGVsc2UgZG9lcy4gSSByZWFk
DQo+ID4NCj4gPiBJIHRoaW5rIGluIEF0aGVyb3MgZHJpdmVyLCBBVEhfUkVHX0RZTkFNSUNfVVNF
Ul9SRUdfSElOVFMgY29uZmlnDQo+IHNlcnZlcw0KPiA+IHRoZSBzYW1lIHB1cnBvc2UuDQo+IA0K
PiBBaCwgSSBmb3Jnb3QgYWJvdXQgdGhhdCBvbmUsIHNvcnJ5Lg0KPiANCj4gPiA+IHlvdXIgY29t
bWl0IG1lc3NhZ2UsIGJ1dCB0aGF0IGRvZXNuJ3Qgc291bmQgbGlrZSBzb21ldGhpbmcgdGhhdCBi
ZWxvbmdzDQo+ID4gPiBpbiBhIHNpbmdsZSBkcml2ZXIgc3RpbGwuDQo+ID4gPg0KPiA+DQo+ID4g
QXMgb3VyIHByZXZpb3VzIGNvbW1pdCBtZXNzYWdlIGNsYWltcywgaXQgaXMgZHVlIHRvIEZDQyBb
Li4uXQ0KPiANCj4gWWVzLCBJIHNhdyB0aGF0OiBteSBwb2ludCB3YXMgdGhhdCBlZmZlY3RpdmVs
eSBhbGwgZHJpdmVycyBhcmUgc3ViamVjdA0KPiB0byB0aGlzIEZDQyBydWxlLCBhbmQgc28gdGhp
cyBjb3VsZCBiZSBhIGNvbW1vbiBDT05GSUdfKi4gQnV0IGlmIHdlDQo+IGFscmVhZHkgaGF2ZSB0
aGUgQVRIXyogb25lIChJIG1pc3NlZCB0aGF0LCBhYm92ZSksIEkgZ3Vlc3Mgd2UgY2FuIGhhdmUN
Cj4gYW4gcnR3ODggb25lIHRvby4gSXQgbWlnaHQgYmUgbGVzcyBjb25mdXNpbmcgKGFuZCBtb3Jl
DQo+IHN0cmFpZ2h0Zm9yd2FyZGx5LWltcGxlbWVudGVkKSBpZiB3ZSBtb3ZlZCB0aGlzIHN0dWZm
IHRvIHRoZSBjb3JlDQo+IHNvbWVkYXksIHRob3VnaC4NCj4gDQo+ID4gPiA+ICsgICByZXQgPSBy
ZWd1bGF0b3J5X2hpbnQoaHctPndpcGh5LCBydHdkZXYtPmVmdXNlLmNvdW50cnlfY29kZSk7DQo+
ID4gPiA+ICsgICBpZiAocmV0KQ0KPiA+ID4gPiArICAgICAgICAgICBydHdfd2FybihydHdkZXYs
ICJmYWlsZWQgdG8gaGludCByZWd1bGF0b3J5OiAlZFxuIiwgcmV0KTsNCj4gPiA+DQo+ID4gPiBJ
IGRvbid0IHRoaW5rIHRoaXMgaXMgd2hhdCB5b3Ugd2FudDsgeW91IGhhZCBpdCByaWdodCBpbiBw
cmV2aW91cw0KPiA+ID4gcmV2aXNpb25zOg0KPiA+ID4NCj4gPiA+ICAgICAgIGlmICghcnR3ZGV2
LT5lZnVzZS5jb3VudHJ5X3dvcmxkd2lkZSkgew0KPiA+ID4gICAgICAgICAgICAgICBpZiAocmVn
dWxhdG9yeV9oaW50KGh3LT53aXBoeSwNCj4gcnR3ZGV2LT5lZnVzZS5jb3VudHJ5X2NvZGUpKQ0K
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgIHJ0d19lcnIoIC4uLiApOw0KPiA+ID4gICAgICAg
fQ0KPiA+ID4NCj4gPiA+IFdpdGhvdXQgdGhlICdjb3VudHJ5X3dvcmx3aWRlJyBjaGVjaywgeW91
IHN0YXJ0ICJoaW50aW5nIiAoZXZlbiBvbg0KPiA+ID4gd29ybGR3aWRlIGNoaXBzKSB0aGF0IHlv
dSByZWFsbHkgd2FudGVkICJjb3VudHJ5IiAwMCBvbmx5LCBhbmQgc28gd2UNCj4gPiA+ICpuZXZl
ciogYWRhcHQgdG8gbW9yZSBzdHJpY3QgY291bnRyeSBzZXR0aW5ncy4gVGhhdCdzIG5vdCBob3cg
d29ybGQtd2lkZQ0KPiA+ID4gc2V0dGluZ3MgYXJlIHN1cHBvc2VkIHRvIHdvcmsuDQo+ID4NCj4g
PiBJdCBkb2Vzbid0IG1lYW4gdGhhdCB3ZSB3YW50IGNvdW50cnkgMDAgb25seSwgd2Ugd2lsbCBn
ZXQgY291bnRyeSBub3RpZmllcw0KPiA+IGZyb20gc3RhY2ssIGFuZCB3ZSB3aWxsIGFwcGx5IGl0
IGlmIHdlIGFjY2VwdCBpdC4gV2UgZG9uJ3Qgd2FudCBzdGFjayB0bw0KPiBjaGFuZ2UNCj4gPiB0
aGUgY2hhbm5lbCBwbGFuIGZvciB1cy4NCj4gDQo+IEkgbm90ZWQgdGhpcyB0byB5b3UgcHJpdmF0
ZWx5LCBidXQgSSBkb24ndCBiZWxpZXZlIGl0J3MgZXhwZWN0ZWQgdG8NCj4gY2FsbCByZWd1bGF0
b3J5X2hpbnQoKSB3aXRoICIwMCIuIFNlZSB0aGUga2VybmVsZG9jOg0KPiANCj4gICogQGFscGhh
MjogdGhlIElTTy9JRUMgMzE2NiBhbHBoYTIgdGhlIGRyaXZlciBjbGFpbXMgaXRzIHJlZ3VsYXRv
cnkgZG9tYWluDQo+ICAqICAgICAgc2hvdWxkIGJlIGluLiBJZiBAcmQgaXMgc2V0IHRoaXMgc2hv
dWxkIGJlIE5VTEwuIE5vdGUgdGhhdCBpZiB5b3UNCj4gICogICAgICBzZXQgdGhpcyB0byBOVUxM
IHlvdSBzaG91bGQgc3RpbGwgc2V0IHJkLT5hbHBoYTIgdG8gc29tZSBhY2NlcHRlZA0KPiAgKiAg
ICAgIGFscGhhMi4NCj4gDQo+IE5vdGUgdGhhdCAiMDAiIGlzICpub3QqIGFjdHVhbGx5IGFuIElT
TyAzMTY2IGFscGhhMiBjb2RlLg0KPiANClllcywgSSB0aGluayB5b3UgbWFrZSBzZW5zZSwgd2Ug
d2lsbCBwcm92aWRlIHY3LCB3aGljaCB3aWxsIGJlIHNpbWlsYXIgdG8gdjUgd2l0aA0KbW9yZSBk
ZXRhaWxlZCBleHBsYWluIGluIGNvbW1pdCBsb2cuDQoNClR6dS1Fbg0KDQo+IFRoZSBrZXkgcHJv
YmxlbSBJJ20gc2VlaW5nOiBvbmNlIHlvdSBkbyB0aGlzLCB5b3UgZXN0YWJsaXNoIGENCj4gd2lw
aHktc3BlY2lmaWMgcmVnZCwgYW5kIHRoaXMgcmVnZCBuZXZlciB1cGRhdGVzIGl0cyBjb3VudHJ5
IGNvZGUgb3INCj4gREZTIHJlZ2lvbiBhY2NvcmRpbmcgdG8gSUUgdXBkYXRlcy4gU28gYXR0cmli
dXRlcyBsaWtlDQo+IE5MODAyMTFfQVRUUl9ERlNfUkVHSU9OIGFuZCBOTDgwMjExX0FUVFJfUkVH
X0FMUEhBMiByZW1haW4gdW5zZXQuDQo+IA0KPiBZb3VyIHByZXZpb3VzIHJldmlzaW9uIC0tIHdo
aWNoIGZvciBXVyBzZXR0aW5ncyB1c2VkDQo+IHdpcGh5X2FwcGx5X2N1c3RvbV9yZWd1bGF0b3J5
KCkgYW5kICpub3QqIHJlZ3VsYXRvcnlfaGludCgpIC0tIGRpZCBub3QNCj4gaGF2ZSB0aGF0IHBy
b2JsZW0uDQo+IA0KPiA+ID4gV2h5IGFyZSB5b3UgaWdub3JpbmcgU0VUX0JZX0RSSVZFUj8NCj4g
Pg0KPiA+IFNpbmNlIHRoZSBub3RpZmljYXRpb24gd2l0aCBOTDgwMjExX1JFR0RPTV9TRVRfQllf
RFJJVkVSIGZsYWcgbWlnaHQNCj4gPiBjb21lcyBmcm9tIGFuIGFub3RoZXIgY2hpcHNldCdzIHJl
Z3VsYXRvcnlfaGludCgpLg0KPiANCj4gQWNrLg0KPiANCj4gQnJpYW4NCj4gDQo+IC0tLS0tLVBs
ZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1tYWls
Lg0K
