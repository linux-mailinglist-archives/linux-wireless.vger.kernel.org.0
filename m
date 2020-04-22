Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FBD1B34F4
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 04:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgDVCVe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 22:21:34 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:56740 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgDVCVd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 22:21:33 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03M2LN7B0005439, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03M2LN7B0005439
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Apr 2020 10:21:23 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Apr 2020 10:21:23 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Apr 2020 10:21:22 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Wed, 22 Apr 2020 10:21:22 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>,
        "Tobias S. Predel" <tobias.predel@gmail.com>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: RE: rtw88: BUG: scheduling while atomic: kworker/u16:0/33416/0x00000002
Thread-Topic: rtw88: BUG: scheduling while atomic:
 kworker/u16:0/33416/0x00000002
Thread-Index: AQHWGCITFAxiEYb+/0iT6SQX4FMSkqiDqcCAgAC9KvA=
Date:   Wed, 22 Apr 2020 02:21:22 +0000
Message-ID: <f024b56130f7498a902dceb264a7df36@realtek.com>
References: <20200421211552.GA36171@t2b3>
 <CA+ASDXN==qo2T6g5YCWpUFPXAdFgcKgww5EbmsmUTvsrSSRHug@mail.gmail.com>
In-Reply-To: <CA+ASDXN==qo2T6g5YCWpUFPXAdFgcKgww5EbmsmUTvsrSSRHug@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.175]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QnJpYW4gTm9ycmlzIDxicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+IDoNCj4gDQo+IEknbSBub3Qg
c3VyZSBhYm91dCB0aGUgZmlyc3QgaGFsZiB5b3VyIHByb2JsZW0sIGJ1dCBmb3IgdGhlDQo+IHNj
aGVkdWxpbmctd2hpbGUtYXRvbWljOg0KPiANCj4gT24gVHVlLCBBcHIgMjEsIDIwMjAgYXQgMjox
NiBQTSBUb2JpYXMgUy4gUHJlZGVsDQo+IDx0b2JpYXMucHJlZGVsQGdtYWlsLmNvbT4gd3JvdGU6
DQo+ID4gWzI4MTI1LjQ4MjI1OV0gQlVHOiBzY2hlZHVsaW5nIHdoaWxlIGF0b21pYzoNCj4ga3dv
cmtlci91MTY6MC8zMzQxNi8weDAwMDAwMDAyDQo+IC4uLg0KPiA+IFsyODEyNS40ODI0MzZdIFBy
ZWVtcHRpb24gZGlzYWJsZWQgYXQ6DQo+ID4gWzI4MTI1LjQ4MjQ0M10gWzwwMDAwMDAwMDAwMDAw
MDAwPl0gMHgwDQo+IA0KPiBeXiBUaGlzIGxpbmUgaXMgYSBiaXQgd2VpcmQgLS0gc2hvdWxkbid0
IHRoaXMgaGF2ZSBhIHJlYWwgUEM/DQo+IA0KPiA+IFsyODEyNS40ODI0NTJdIENQVTogNSBQSUQ6
IDMzNDE2IENvbW06IGt3b3JrZXIvdTE2OjAgVGFpbnRlZDogRw0KPiBXICAgICAgICAgNS43LjAt
cmMyLW5leHQtMjAyMDA0MjEtMS1uZXh0LWdpdCAjMQ0KPiA+IFsyODEyNS40ODI0NTZdIEhhcmR3
YXJlIG5hbWU6IEhQIEhQIFByb0Jvb2sgNDMwIEc1LzgzNzcsIEJJT1MgUTg1DQo+IFZlci4gMDEu
MDkuMDEgMTAvMTUvMjAxOQ0KPiA+IFsyODEyNS40ODI0NzddIFdvcmtxdWV1ZTogcGh5MCBydHdf
d2F0Y2hfZG9nX3dvcmsgW3J0dzg4XQ0KPiA+IFsyODEyNS40ODI0ODFdIENhbGwgVHJhY2U6DQo+
ID4gWzI4MTI1LjQ4MjQ5NV0gIGR1bXBfc3RhY2srMHg2Ni8weDkwDQo+ID4gWzI4MTI1LjQ4MjUw
NV0gIF9fc2NoZWR1bGVfYnVnLmNvbGQrMHg4ZS8weDliDQo+ID4gWzI4MTI1LjQ4MjUxMl0gIF9f
c2NoZWR1bGUrMHg2ODYvMHg3YjANCj4gPiBbMjgxMjUuNDgyNTIwXSAgPyBfcmF3X3NwaW5fdW5s
b2NrX2lycXJlc3RvcmUrMHgyMC8weDQwDQo+ID4gWzI4MTI1LjQ4MjUyNV0gIHNjaGVkdWxlKzB4
NDYvMHhmMA0KPiA+IFsyODEyNS40ODI1MzFdICBzY2hlZHVsZV9ocnRpbWVvdXRfcmFuZ2VfY2xv
Y2srMHhhNS8weDEyMA0KPiA+IFsyODEyNS40ODI1NDBdICA/IGhydGltZXJfaW5pdF9zbGVlcGVy
KzB4YTAvMHhhMA0KPiA+IFsyODEyNS40ODI1NDZdICB1c2xlZXBfcmFuZ2UrMHg2Ny8weDkwDQo+
ID4gWzI4MTI1LjQ4MjU2OF0gIHJ0d19md19zZW5kX2gyY19jb21tYW5kKzB4ZTAvMHgxYTAgW3J0
dzg4XQ0KPiA+IFsyODEyNS40ODI1OTBdICBydHdfZndfc2V0X3B3cl9tb2RlKzB4OTUvMHhiMCBb
cnR3ODhdDQo+ID4gWzI4MTI1LjQ4MjYxMF0gIHJ0d19lbnRlcl9scHMrMHhhMS8weDEwMCBbcnR3
ODhdDQo+ID4gWzI4MTI1LjQ4MjYyNV0gIHJ0d193YXRjaF9kb2dfd29yaysweDIxYy8weDIzMCBb
cnR3ODhdDQo+ID4gWzI4MTI1LjQ4MjYzNV0gIHByb2Nlc3Nfb25lX3dvcmsrMHgxZGEvMHgzZDAN
Cj4gPiBbMjgxMjUuNDgyNjQzXSAgd29ya2VyX3RocmVhZCsweDRhLzB4M2QwDQo+ID4gWzI4MTI1
LjQ4MjY1MV0gIGt0aHJlYWQrMHgxMjIvMHgxNjANCj4gPiBbMjgxMjUuNDgyNjU4XSAgPyBwcm9j
ZXNzX29uZV93b3JrKzB4M2QwLzB4M2QwDQo+ID4gWzI4MTI1LjQ4MjY2M10gID8ga3RocmVhZF9w
YXJrKzB4OTAvMHg5MA0KPiA+IFsyODEyNS40ODI2NzBdICByZXRfZnJvbV9mb3JrKzB4MWYvMHg0
MA0KPiANCj4gVGhpcyBsb29rcyBsaWtlIGl0IG1pZ2h0IGJlIGEgcmVncmVzc2lvbiBoZXJlOg0K
PiANCj4gY29tbWl0IDYzNDNhNmQ0YjIxMzBiZTkzMjNmMzQ3ZDYwYWY4YTdiYThmNzI0MmMNCj4g
QXV0aG9yOiBLYWktSGVuZyBGZW5nIDxrYWkuaGVuZy5mZW5nQGNhbm9uaWNhbC5jb20+DQo+IERh
dGU6ICAgVHVlIEFwciA3IDE1OjMzOjMxIDIwMjAgKzA4MDANCj4gDQo+ICAgICBydHc4ODogQWRk
IGRlbGF5IG9uIHBvbGxpbmcgaDJjIGNvbW1hbmQgc3RhdHVzIGJpdA0KPiANCj4gVGhhdCBwb2xs
IG1hY3JvcyBpcyB1c2luZyB1c2xlZXAsIHdoaWNoIG9idmlvdXNseSBjYW4gc2xlZXAuIFdlIG5l
ZWQNCj4gdG8gYmUgdXNpbmcgYSB1ZGVsYXktdmFyaWFudCBpbnN0ZWFkLg0KPiANCg0KTWF5YmUg
d2UgbmVlZCBhbiBhdG9taWMgdmVyc2lvbiBvZiByZWFkX3BvbGxfdGltZW91dCgpID8NCkkgYW0g
bm90IHN1cmUgaWYgdGhpcyBpcyByZXF1aXJlZCwgYnV0IHNlZW1zIGxpa2UgaXQgaXMgdXNlZnVs
IGZvciBtZS4NCk5vdGljZWQgbXVjaCBvZiB0aGVtIGhhdmUgaXRzIGF0b21pYyB2ZXJzaW9uLCBi
dXQgbm90IGZvciB0aGlzIG5ldyBhZGRlZCBvbmUuDQoNClllbi1Ic3Vhbg0K
