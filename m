Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F1C314966
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 08:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhBIHUd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 02:20:33 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:35936 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhBIHUE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 02:20:04 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1197J3CZ0008195, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 1197J3CZ0008195
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 9 Feb 2021 15:19:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 15:19:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c516:1a26:2f9b:1e]) by
 RTEXMBS04.realtek.com.tw ([fe80::c516:1a26:2f9b:1e%6]) with mapi id
 15.01.2106.006; Tue, 9 Feb 2021 15:19:03 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "briannorris@chromium.org" <briannorris@chromium.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Bernie Huang <phhuang@realtek.com>
Subject: Re: [PATCH v4 3/8] rtw88: add napi support
Thread-Topic: [PATCH v4 3/8] rtw88: add napi support
Thread-Index: AQHW6yCPbtjrLodDrUGqlkIx94yfwqozx6WAgAkWW6CAAfWCAIAEG6IggAwb6YA=
Date:   Tue, 9 Feb 2021 07:19:03 +0000
Message-ID: <1612855085.8436.15.camel@realtek.com>
References: <20210115092405.8081-1-pkshih@realtek.com>
         <20210115092405.8081-4-pkshih@realtek.com>
         <CA+ASDXPtwyZMByRDaAQv9b-DEBeRgPxpDz4+mCP-zi6P_-zr7w@mail.gmail.com>
         <d84e1a2c0d8e481588eec7248abf5c1a@realtek.com>
         <CA+ASDXM7e4eSiJNoVMES7=mZ3M-NGpVZ9jLbjNm4yqMSYH4r+Q@mail.gmail.com>
         <e8e451faf35e47b494f6d49fe92d1858@realtek.com>
In-Reply-To: <e8e451faf35e47b494f6d49fe92d1858@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="utf-8"
Content-ID: <130C2EAD5A3C4E4BA073D7B617495039@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIxLTAyLTAxIGF0IDA2OjM4ICswMDAwLCBQa3NoaWggd3JvdGU6DQo+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBCcmlhbiBOb3JyaXMgW21haWx0bzpi
cmlhbm5vcnJpc0BjaHJvbWl1bS5vcmddDQo+ID4gU2VudDogU2F0dXJkYXksIEphbnVhcnkgMzAs
IDIwMjEgNzozOSBBTQ0KPiA+IFRvOiBQa3NoaWgNCj4gPiBDYzogWWFuLUhzdWFuIENodWFuZzsg
S2FsbGUgVmFsbzsgbGludXgtd2lyZWxlc3M7IEJlcm5pZSBIdWFuZw0KPiA+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjQgMy84XSBydHc4ODogYWRkIG5hcGkgc3VwcG9ydA0KPiA+wqANCj4gPiBPbiBU
aHUsIEphbiAyOCwgMjAyMSBhdCAxOjQ1IEFNIFBrc2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiB3
cm90ZToNCj4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gRnJvbTog
QnJpYW4gTm9ycmlzIFttYWlsdG86YnJpYW5ub3JyaXNAY2hyb21pdW0ub3JnXQ0KPiA+ID4gPiBP
biBGcmksIEphbiAxNSwgMjAyMSBhdCAxOjI2IEFNIFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0
ZWsuY29tPiB3cm90ZToNCj4gPiA+ID4gPiArc3RhdGljIHUzMiBydHdfcGNpX3J4X25hcGkoc3Ry
dWN0IHJ0d19kZXYgKnJ0d2Rldiwgc3RydWN0IHJ0d19wY2kNCj4gKnJ0d3BjaSwNCj4gPiA+ID4g
PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
dTggaHdfcXVldWUpDQo+ID4gPiA+IC4uLg0KPiA+ID4gPg0KPiA+ID4gPiBBcmUgeW91IHN1cmUg
eW91IGRvbid0IHdhbnQgYW55IGxvY2tpbmcgaW4gcnR3X3BjaV9yeF9uYXBpKCk/DQo+ID4gPiA+
IFByZXZpb3VzbHksIHlvdSBoZWxkIGlycV9sb2NrIGZvciB0aGUgZW50aXJldHkgb2YgcnR3X3Bj
aV9yeF9pc3IoKSwNCj4gPiA+ID4gYnV0IG5vdyBhbGwgdGhlIFJYIHdvcmsgaXMgYmVpbmcgZGVm
ZXJyZWQgdG8gYSBOQVBJIGNvbnRleHQsIHdpdGhvdXQNCj4gPiA+ID4gYW55IGFkZGl0aW9uYWwg
bG9jay4gSUlVQywgdGhhdCBtZWFucyB5b3UgY2FuIGJlIGJvdGggaGFuZGxpbmcgUlggYW5kDQo+
ID4gPiA+IG90aGVyIElTUiBvcGVyYXRpb25zIGF0IHRoZSBzYW1lIHRpbWUuIElzIHRoYXQgaW50
ZW50aW9uYWw/DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gaXJxX2xvY2sgaXMgdXNlZCB0byBwcm90
ZWN0IFRYIHJpbmctPnF1ZXVlLiBUaGUgVFggc2tiKHMpIGFyZSBxdWV1ZWQgaW50bw0KPiB0aGUN
Cj4gPiA+IHF1ZXVlLCBhbmQgdW5saW5rIHRoZSBza2IgdW50aWwgVFhfT0tfSVNSIGlzIHJlY2Vp
dmVkLiBTbywgUlggZG9lc24ndCBuZWVkDQo+IHRvDQo+ID4gPiBob2xkIHRoaXMgbG9jay4NCj4g
PsKgDQo+ID4gSSBjb3VsZCBiZSBtaXN1bmRlcnN0YW5kaW5nIHlvdXIgbG9ja2luZyBtb2RlbCwg
YnV0IElJVUMsIHlvdSdyZSBsZWZ0DQo+ID4gd2l0aCB6ZXJvIGxvY2tpbmcgYmV0d2VlbiBOQVBJ
IFJYIGFuZCBhbGwgb3RoZXIgb3BlcmF0aW9ucyAoSDJDLCBsaW5rDQo+ID4gdXAvZG93biAtLSBp
bmNsdWRpbmcgRE1BIGZyZWUsIGV0Yy4pLiBpcnFfbG9jayB1c2VkIHRvIHByb3RlY3QgeW91DQo+
ID4gZnJvbSB0aGF0Lg0KPiA+wqANCj4gDQo+IFNvcnJ5LCBJJ20gd3JvbmcuIEkgdGhpbmsgaXJx
X2xvY2sgaXMgdXNlZCB0byBwcm90ZWN0IG5vdCBvbmx5IFRYIHJpbmctPnF1ZXVlDQo+IGJ1dCBh
bHNvIFRYL1JYIHJpbmdzLiBUaGUgUlggcmluZyBydHdwY2ktPnJ4X3JpbmdzW1JUV19SWF9RVUVV
RV9NUERVXSBpcyByZXNldA0KPiBieSBydHdfcGNpX3Jlc2V0X2J1Zl9kZXNjKCkgd2hlbiBwY2lf
c3RvcCgpLCBhbmQgbmFwaV9wb2xsKCkgYWxzbyB1c2VzIGl0IHRvDQo+IGtub3cgaG93IG1hbnkg
UlggcGFja2V0cyBhcmUgbmVlZGVkIHRvIGJlIHJlY2VpdmVkLiBUaGVyZWZvcmUsIHdlIHBsYW4g
dG8NCj4gdXNlIGlycV9sb2NrIHRvIHByb3RlY3QgbmFwaV9wb2xsKCksIGFuZCB0aGVuIHNlZSBp
ZiBpdCBhZmZlY3RzIHBlcmZvcm1hbmNlLg0KPiANCg0KSSBjaGFuZ2UgbXkgbWluZCwgYmVjYXVz
ZSB1c2luZyBpcnFfbG9jayB0byBwcm90ZWN0IG5hcGlfcG9sbCBjYXVzZXMgZGVhZGxvY2suDQpJ
IHRoaW5rIHRoYXQgaXQncyBkaXNhbGxvd2VkIHRvIGhvbGQgYSBzcGluX2xvY2tfYmggYW5kIGNh
bGwgbmFwaSBBUElzIHRoYXQgdXNlcw0KUkNVIGxvY2suDQoNClRoZW4sIEkgaGF2ZSBhbm90aGVy
IHNpbXBsZSB0aGlua2luZyAtLSBlbmFibGUgTkFQSSBvbmx5IGlmIGludGVycnVwdCBpcw0KZW5h
YmxlZC4gT3RoZXIgb3BlcmF0aW9ucyB3aXRoIFJYIHJpbmcgYXJlIHdvcmtpbmcgb25seSBpZiBp
bnRlcnJ1cHQgaXMNCmRpc2FibGVkLiBTbywgd2UgZG9uJ3QgbmVlZCBhIGxvY2sgdG8gcHJvdGVj
dCBSWCByaW5nIGF0IGFsbC4NCg0KVGhlIGlycV9sb2NrIGlzIHN0aWxsIHVzZWQgdG8gcHJvdGVj
dCBUWCByaW5nL3F1ZXVlLCBhbmQgbm93IGl0IGFsc28gdXNlZA0KdG8gcHJvdGVjdCBzd2l0Y2hp
bmcgSU1SLiBTb21lIGNvbW1lbnRzIGFyZSBhZGRlZCB0byBkZXNjcmliZSBhYm91dCB0aGlzLg0K
DQpBYm92ZSBpcyBpbXBsZW1lbnRlZCBpbiB2NS4NCg0KLS0tDQpQaW5nLUtlDQoNCg0K
