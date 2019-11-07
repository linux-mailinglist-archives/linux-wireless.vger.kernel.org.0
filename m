Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97B4DF260B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 04:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733162AbfKGDf2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Nov 2019 22:35:28 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:36282 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733150AbfKGDf2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Nov 2019 22:35:28 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xA73ZLLC031601, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xA73ZLLC031601
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Nov 2019 11:35:21 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS11.realtek.com.tw ([fe80::7c6d:ced5:c4ff:8297%15]) with mapi id
 14.03.0468.000; Thu, 7 Nov 2019 11:35:21 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] rtw88: use macro to check the current band
Thread-Topic: [PATCH v2 1/6] rtw88: use macro to check the current band
Thread-Index: AQHVhB3gqp/3yDV2i0e9GVot+26NAadc+skAgAEjtCCAIBu9AIAA9VYg
Date:   Thu, 7 Nov 2019 03:35:20 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D191E2D2@RTITMBSVM04.realtek.com.tw>
References: <20191016123301.2649-1-yhchuang@realtek.com>
 <20191016123301.2649-2-yhchuang@realtek.com>
 <CA+ASDXNmMiW_FaqCKowzZW6fnBhA+JXcGBJOEToBA47EShu35A@mail.gmail.com>
 <F7CD281DE3E379468C6D07993EA72F84D1900C92@RTITMBSVM04.realtek.com.tw>
 <CA+ASDXMg5hKuXUxsdAuig0_t0TNJL10ZcaZ-iQ79tVKPNjzMXg@mail.gmail.com>
In-Reply-To: <CA+ASDXMg5hKuXUxsdAuig0_t0TNJL10ZcaZ-iQ79tVKPNjzMXg@mail.gmail.com>
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvNl0gcnR3ODg6IHVzZSBtYWNybyB0byBjaGVjayB0
aGUgY3VycmVudCBiYW5kDQo+IA0KPiBBIGxpdHRsZSBsYXRlIG9uIHRoaXMuLi4NCj4gDQo+IE9u
IFdlZCwgT2N0IDE2LCAyMDE5IGF0IDc6MzkgUE0gVG9ueSBDaHVhbmcgPHloY2h1YW5nQHJlYWx0
ZWsuY29tPg0KPiB3cm90ZToNCj4gPiBGcm9tOiBCcmlhbiBOb3JyaXMNCj4gPiA+IE9uIFdlZCwg
T2N0IDE2LCAyMDE5IGF0IDU6MzMgQU0gPHloY2h1YW5nQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4g
PiA+ID4gaW5kZXggNDc1OWQ2YTBjYTZlLi40OTJhMmJmYzBkNWEgMTAwNjQ0DQo+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5oDQo+ID4gPiA+ICsr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5oDQo+ID4gPiA+IEBA
IC01OCw2ICs1OCwxOSBAQCBzdHJ1Y3QgcnR3X2hjaSB7DQo+ID4gPiA+ICAgICAgICAgdTggYnVs
a291dF9udW07DQo+ID4gPiA+ICB9Ow0KPiA+ID4gPg0KPiA+ID4gPiArI2RlZmluZSBJU19DSF81
R19CQU5EXzEoY2hhbm5lbCkgKChjaGFubmVsKSA+PSAzNiAmJiAoY2hhbm5lbCA8PQ0KPiA0OCkp
DQo+ID4gPiA+ICsjZGVmaW5lIElTX0NIXzVHX0JBTkRfMihjaGFubmVsKSAoKGNoYW5uZWwpID49
IDUyICYmIChjaGFubmVsIDw9DQo+IDY0KSkNCj4gPiA+ID4gKyNkZWZpbmUgSVNfQ0hfNUdfQkFO
RF8zKGNoYW5uZWwpICgoY2hhbm5lbCkgPj0gMTAwICYmIChjaGFubmVsIDw9DQo+ID4gPiAxNDQp
KQ0KPiA+ID4gPiArI2RlZmluZSBJU19DSF81R19CQU5EXzQoY2hhbm5lbCkgKChjaGFubmVsKSA+
PSAxNDkgJiYgKGNoYW5uZWwgPD0NCj4gPiA+IDE3NykpDQo+ID4gPg0KPiA+ID4gVGhlcmUgYXJl
IGNoYW5uZWxzIGJldHdlZW4gNDggYW5kIDUyLCA2NCBhbmQgMTAwLCBhbmQgMTQ0IGFuZCAxNDku
DQo+ID4gPiBXaGF0IGFyZSB5b3UgZG9pbmcgd2l0aCB0aG9zZT8NCj4gPg0KPiA+IFRoZXNlIGRl
dmljZXMgYXJlIG5vdCBzdXBwb3J0aW5nIHRob3NlIGNoYW5uZWxzIHlvdSBtZW50aW9uZWQuDQo+
ID4gU28gSSBob3BlIGlmIHNvbWUgdW5zdXBwb3J0ZWQgY2hhbm5lbHMgYXJlIHVzZWQsIHRoZXkg
c2hvdWxkIGhpdCB0aGUNCj4gPiAiZWxzZSIgY2FzZSwgb3IgdGhyb3cgc3VjaCBhIHdhcm4uDQo+
IA0KPiBNYXliZSB0aGF0IGFyZ3VtZW50IG1ha2VzIHNlbnNlIG9uIGl0cyBvd24sIGJ1dCBzZWUg
YmVsb3c6DQo+IA0KPiA+ID4gPiArI2RlZmluZSBJU19DSF81R19CQU5EX01JRChjaGFubmVsKSBc
DQo+ID4gPiA+ICsgICAgICAgKElTX0NIXzVHX0JBTkRfMihjaGFubmVsKSB8fCBJU19DSF81R19C
QU5EXzMoY2hhbm5lbCkpDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyNkZWZpbmUgSVNfQ0hfMkdfQkFO
RChjaGFubmVsKSAoKGNoYW5uZWwpIDw9IDE0KQ0KPiA+ID4gPiArI2RlZmluZSBJU19DSF81R19C
QU5EKGNoYW5uZWwpIFwNCj4gPiA+ID4gKyAgICAgICAoSVNfQ0hfNUdfQkFORF8xKGNoYW5uZWwp
IHx8IElTX0NIXzVHX0JBTkRfMihjaGFubmVsKQ0KPiB8fCBcDQo+ID4gPiA+ICsgICAgICAgIElT
X0NIXzVHX0JBTkRfMyhjaGFubmVsKSB8fA0KPiBJU19DSF81R19CQU5EXzQoY2hhbm5lbCkpDQo+
ID4gPg0KPiA+ID4gR2l2ZW4gdGhlIGFib3ZlICh5b3UgaGF2ZSBtYWpvciBob2xlcyBpbiA1R19C
QU5EezEsMiwzLDR9KSwgdGhpcyBtYWNybw0KPiA+ID4gc2VlbXMgbGlrZSBhIHJlZ3Jlc3Npb24u
DQo+IA0KPiBJIHN0aWxsIHRoaW5rIGl0J3MgYSB0ZXJyaWJsZSBpZGVhIHRvIHdyaXRlIGFuIGlu
dGVudGlvbmFsbHkNCj4gbWlzbGVhZGluZyBtYWNybyBuYW1lZCAiSVMgNUcgQkFORCIgdGhhdCBy
ZXR1cm5zIGZhbHNlIGZvciA1Rw0KPiBjaGFubmVscy4gSXQganVzdCBnaXZlcyB5b3UgYSBuaWNl
IHdheSB0byBzdHViIHlvdXIgdG9lIGlmIHlvdSBldmVyDQo+IGhhdmUgY2hpcHMgdGhhdCBkbyBz
dXBwb3J0IHRoZXNlIGNoYW5uZWxzLg0KPiANCg0KWW91J3JlIHByb2JhYmx5IHJpZ2h0LCBidXQg
SSByZWFsbHkgZG9uJ3QgdGhpbmsgdGhvc2UgODAyLjExYWMgZGV2aWNlcyBhcmUNCmdvaW5nIHRv
IHN1cHBvcnQgdGhlc2UgY2hhbm5lbHMsIHVubGVzcyBydHc4OCBpcyBnb2luZyB0byBhZGQgc3Vw
cG9ydA0KZm9yIDgwMi4xMWF4IGRldmljZXMuIEFuZCBJJ2xsIHRha2UgY2FyZSBvZiBpdCB3aGVu
IGl0IGNvbWVzLg0KDQpBdCBsZWFzdCB0aGUgY3VycmVudCA4MDIuMTFhYyBkZXZpY2VzIHN1Y2gg
YXMgODgyMUMvODgyMkIvODgyMkMgZG8NCm5vdCBzdXBwb3J0IGl0Lg0KDQpZYW4tSHN1YW4NCg0K
