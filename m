Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790D830A237
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Feb 2021 07:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhBAGm7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Feb 2021 01:42:59 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:49560 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbhBAGjV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Feb 2021 01:39:21 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1116cJkG5029187, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs03.realtek.com.tw[172.21.6.96])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 1116cJkG5029187
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 1 Feb 2021 14:38:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Feb 2021 14:38:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833]) by
 RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833%12]) with mapi id
 15.01.2106.006; Mon, 1 Feb 2021 14:38:19 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Bernie Huang <phhuang@realtek.com>
Subject: RE: [PATCH v4 3/8] rtw88: add napi support
Thread-Topic: [PATCH v4 3/8] rtw88: add napi support
Thread-Index: AQHW6yCPbtjrLodDrUGqlkIx94yfwqozx6WAgAkWW6CAAfWCAIAEG6Ig
Date:   Mon, 1 Feb 2021 06:38:19 +0000
Message-ID: <e8e451faf35e47b494f6d49fe92d1858@realtek.com>
References: <20210115092405.8081-1-pkshih@realtek.com>
 <20210115092405.8081-4-pkshih@realtek.com>
 <CA+ASDXPtwyZMByRDaAQv9b-DEBeRgPxpDz4+mCP-zi6P_-zr7w@mail.gmail.com>
 <d84e1a2c0d8e481588eec7248abf5c1a@realtek.com>
 <CA+ASDXM7e4eSiJNoVMES7=mZ3M-NGpVZ9jLbjNm4yqMSYH4r+Q@mail.gmail.com>
In-Reply-To: <CA+ASDXM7e4eSiJNoVMES7=mZ3M-NGpVZ9jLbjNm4yqMSYH4r+Q@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJyaWFuIE5vcnJpcyBbbWFp
bHRvOmJyaWFubm9ycmlzQGNocm9taXVtLm9yZ10NCj4gU2VudDogU2F0dXJkYXksIEphbnVhcnkg
MzAsIDIwMjEgNzozOSBBTQ0KPiBUbzogUGtzaGloDQo+IENjOiBZYW4tSHN1YW4gQ2h1YW5nOyBL
YWxsZSBWYWxvOyBsaW51eC13aXJlbGVzczsgQmVybmllIEh1YW5nDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjQgMy84XSBydHc4ODogYWRkIG5hcGkgc3VwcG9ydA0KPiANCj4gT24gVGh1LCBKYW4g
MjgsIDIwMjEgYXQgMTo0NSBBTSBQa3NoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6DQo+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQnJpYW4gTm9ycmlz
IFttYWlsdG86YnJpYW5ub3JyaXNAY2hyb21pdW0ub3JnXQ0KPiA+ID4gT24gRnJpLCBKYW4gMTUs
IDIwMjEgYXQgMToyNiBBTSBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6
DQo+ID4gPiA+ICtzdGF0aWMgdTMyIHJ0d19wY2lfcnhfbmFwaShzdHJ1Y3QgcnR3X2RldiAqcnR3
ZGV2LCBzdHJ1Y3QgcnR3X3BjaSAqcnR3cGNpLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1OCBod19xdWV1ZSkNCj4gPiA+IC4uLg0KPiA+ID4NCj4gPiA+IEFyZSB5b3Ugc3Vy
ZSB5b3UgZG9uJ3Qgd2FudCBhbnkgbG9ja2luZyBpbiBydHdfcGNpX3J4X25hcGkoKT8NCj4gPiA+
IFByZXZpb3VzbHksIHlvdSBoZWxkIGlycV9sb2NrIGZvciB0aGUgZW50aXJldHkgb2YgcnR3X3Bj
aV9yeF9pc3IoKSwNCj4gPiA+IGJ1dCBub3cgYWxsIHRoZSBSWCB3b3JrIGlzIGJlaW5nIGRlZmVy
cmVkIHRvIGEgTkFQSSBjb250ZXh0LCB3aXRob3V0DQo+ID4gPiBhbnkgYWRkaXRpb25hbCBsb2Nr
LiBJSVVDLCB0aGF0IG1lYW5zIHlvdSBjYW4gYmUgYm90aCBoYW5kbGluZyBSWCBhbmQNCj4gPiA+
IG90aGVyIElTUiBvcGVyYXRpb25zIGF0IHRoZSBzYW1lIHRpbWUuIElzIHRoYXQgaW50ZW50aW9u
YWw/DQo+ID4gPg0KPiA+DQo+ID4gaXJxX2xvY2sgaXMgdXNlZCB0byBwcm90ZWN0IFRYIHJpbmct
PnF1ZXVlLiBUaGUgVFggc2tiKHMpIGFyZSBxdWV1ZWQgaW50byB0aGUNCj4gPiBxdWV1ZSwgYW5k
IHVubGluayB0aGUgc2tiIHVudGlsIFRYX09LX0lTUiBpcyByZWNlaXZlZC4gU28sIFJYIGRvZXNu
J3QgbmVlZCB0bw0KPiA+IGhvbGQgdGhpcyBsb2NrLg0KPiANCj4gSSBjb3VsZCBiZSBtaXN1bmRl
cnN0YW5kaW5nIHlvdXIgbG9ja2luZyBtb2RlbCwgYnV0IElJVUMsIHlvdSdyZSBsZWZ0DQo+IHdp
dGggemVybyBsb2NraW5nIGJldHdlZW4gTkFQSSBSWCBhbmQgYWxsIG90aGVyIG9wZXJhdGlvbnMg
KEgyQywgbGluaw0KPiB1cC9kb3duIC0tIGluY2x1ZGluZyBETUEgZnJlZSwgZXRjLikuIGlycV9s
b2NrIHVzZWQgdG8gcHJvdGVjdCB5b3UNCj4gZnJvbSB0aGF0Lg0KPiANCg0KU29ycnksIEknbSB3
cm9uZy4gSSB0aGluayBpcnFfbG9jayBpcyB1c2VkIHRvIHByb3RlY3Qgbm90IG9ubHkgVFggcmlu
Zy0+cXVldWUNCmJ1dCBhbHNvIFRYL1JYIHJpbmdzLiBUaGUgUlggcmluZyBydHdwY2ktPnJ4X3Jp
bmdzW1JUV19SWF9RVUVVRV9NUERVXSBpcyByZXNldA0KYnkgcnR3X3BjaV9yZXNldF9idWZfZGVz
YygpIHdoZW4gcGNpX3N0b3AoKSwgYW5kIG5hcGlfcG9sbCgpIGFsc28gdXNlcyBpdCB0bw0Ka25v
dyBob3cgbWFueSBSWCBwYWNrZXRzIGFyZSBuZWVkZWQgdG8gYmUgcmVjZWl2ZWQuIFRoZXJlZm9y
ZSwgd2UgcGxhbiB0bw0KdXNlIGlycV9sb2NrIHRvIHByb3RlY3QgbmFwaV9wb2xsKCksIGFuZCB0
aGVuIHNlZSBpZiBpdCBhZmZlY3RzIHBlcmZvcm1hbmNlLg0KDQo+IElmIEknbSByaWdodCwgbWF5
YmUgaXQgbmVlZHMgYSByZW5hbWUgYW5kL29yIHNvbWUgYWRkaXRpb25hbCBjb21tZW50cy4NCj4g
DQoNClRoZSBvcmlnaW5hbCBuYW1lIGFuZCBjb21tZW50Og0KCS8qIFVzZWQgZm9yIFBDSSBUWCBx
dWV1ZWluZy4gKi8NCglzcGlubG9ja190IGlycV9sb2NrOw0KV2lsbCBjaGFuZ2UgdG8NCgkvKiBV
c2VkIGZvciBQQ0kgVFgvUlggcmluZ3MgYW5kIFRYIHF1ZXVlaW5nLiAqLw0KCXNwaW5sb2NrX3Qg
aXJxX2xvY2s7DQoNCi0tLQ0KUGluZy1LZQ0KDQo=
