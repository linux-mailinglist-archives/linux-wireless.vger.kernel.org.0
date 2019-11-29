Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD25010D089
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 03:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfK2C3x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 21:29:53 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47667 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfK2C3x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 21:29:53 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAT2TfKg029454, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAT2TfKg029454
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 10:29:41 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Fri, 29 Nov 2019 10:29:41 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 Nov 2019 10:29:41 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::7d15:f8ee:cfc7:88ce]) by
 RTEXMB04.realtek.com.tw ([fe80::7d15:f8ee:cfc7:88ce%6]) with mapi id
 15.01.1779.005; Fri, 29 Nov 2019 10:29:41 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Chris Chiu <chiu@endlessm.com>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: RE: [PATCH v3 1/2] rtw88: add regulatory process strategy for different chipset
Thread-Topic: [PATCH v3 1/2] rtw88: add regulatory process strategy for
 different chipset
Thread-Index: AQHViMFAaPadjXgXtE6wjez3nesvPqdqOC0AgDdv31A=
Date:   Fri, 29 Nov 2019 02:29:41 +0000
Message-ID: <f93341159e4342479e646e49ec2ab8d2@realtek.com>
References: <20191022101229.26044-1-yhchuang@realtek.com>
 <20191022101229.26044-2-yhchuang@realtek.com>
 <CAB4CAwf9vanVf7JA5ZD52Yn-ngtEkA6S6YqhUZssXaLsHYio1w@mail.gmail.com>
In-Reply-To: <CAB4CAwf9vanVf7JA5ZD52Yn-ngtEkA6S6YqhUZssXaLsHYio1w@mail.gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXMgQ2hpdSBbbWFp
bHRvOmNoaXVAZW5kbGVzc20uY29tXQ0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMjUsIDIwMTkg
MTE6NTQgQU0NCj4gVG86IFRvbnkgQ2h1YW5nDQo+IENjOiBLYWxsZSBWYWxvOyBsaW51eC13aXJl
bGVzczsgQnJpYW4gTm9ycmlzDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8yXSBydHc4ODog
YWRkIHJlZ3VsYXRvcnkgcHJvY2VzcyBzdHJhdGVneSBmb3INCj4gZGlmZmVyZW50IGNoaXBzZXQN
Cj4gDQo+IE9uIFR1ZSwgT2N0IDIyLCAyMDE5IGF0IDY6MTIgUE0gPHloY2h1YW5nQHJlYWx0ZWsu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IFR6dS1FbiBIdWFuZyA8dGVodWFuZ0ByZWFsdGVr
LmNvbT4NCj4gPg0KPiA+IFRoZXJlIGFyZSB0d28ga2luZHMgb2YgY291bnRyeS9yZWd1bGF0b3J5
IGVmdXNlIHNldHRpbmdzDQo+ID4gZm9yIFJlYWx0ZWsncyBjaGlwc2V0LCBvbmUgaXMgd29ybGR3
aWRlIGFuZCB0aGUgb3RoZXIgaXMNCj4gPiBhIHNwZWNpZmljIGNvdW50cnkuIEZvciBib3RoIHNl
dHRpbmdzLCBSRUdVTEFUT1JZX1NUUklDVF9SRUcNCj4gPiB3aWxsIGJlIHNldCwgdGVsbGluZyBz
dGFjayB0aGF0IGRldmljZXMgb3JpZ2luYWwgcmVndWxhdG9yeSBpcw0KPiA+IHRoZSBzdXBlcnNl
dCBvZiBhbnkgZnVydGhlciBzZXR0aW5ncy4NCj4gPg0KPiA+IEZvciB0aGUgY2hpcHNldCB3aXRo
IHRoZSBjb3VudHJ5IHNldHRpbmcgYmVpbmcgYSBzcGVjaWZpYw0KPiA+IGNvdW50cnksIFJlYWx0
ZWsgZG9lcyBub3QgYXBwbHkgYW55IG5ldyByZWd1bGF0b3J5IHNldHRpbmcNCj4gPiBub3RpZmll
cnMgdG8gdGhlIGNhcmQuDQo+ID4NCj4gPiBGb3IgdGhlIGNoaXBzZXQgd2l0aCBhIHdvcmxkd2lk
ZSByZWd1bGF0b3J5IHNldHRpbmcsDQo+ID4gUmVhbHRlaydzIGN1c3RvbSB3b3JsZHdpZGUgcmVn
dWxhdG9yeSBzZXR0aW5nIHdpbGwgYmUNCj4gPiBwcm92aWRlZCB2aWEgd2lwaHlfYXBwbHlfY3Vz
dG9tX3JlZ3VsYXRvcnkoKS4NCj4gPiBBbmQgaWYgYSBuZXcgcmVndWxhdG9yeSBub3RpZmljYXRp
b24gaXMgc2V0IGJ5DQo+ID4gTkw4MDIxMV9SRUdET01fU0VUX0JZX0NPVU5UUllfSUUsIHRoZSBu
ZXcgc2V0dGluZyB3aWxsIGJlDQo+ID4gYXBwbGllZCB0byB0aGUgY2FyZC4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFR6dS1FbiBIdWFuZyA8dGVodWFuZ0ByZWFsdGVrLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBZYW4tSHN1YW4gQ2h1YW5nIDx5aGNodWFuZ0ByZWFsdGVrLmNvbT4NCj4gUmV2
aWV3ZWQtYnk6IENocmlzIENoaXUgPGNoaXVAZW5kbGVzc20uY29tPg0KPiANCj4gTG9va3MgZ29v
ZCB0byBtZS4NCj4gDQo+IENocmlzDQoNCkdlbnRsZSBwaW5nIG9mIHRoaXMgcGF0Y2ggc2V0IDop
DQoNCllhbi1Ic3Vhbg0K
