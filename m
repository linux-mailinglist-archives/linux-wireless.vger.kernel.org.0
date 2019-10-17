Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C95F5DA3EC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 04:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407274AbfJQCjS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Oct 2019 22:39:18 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59729 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392198AbfJQCjS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Oct 2019 22:39:18 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9H2dBAW005114, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9H2dBAW005114
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 17 Oct 2019 10:39:11 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV02.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Thu, 17 Oct
 2019 10:39:10 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] rtw88: use macro to check the current band
Thread-Topic: [PATCH v2 1/6] rtw88: use macro to check the current band
Thread-Index: AQHVhB3gqp/3yDV2i0e9GVot+26NAadc+skAgAEjtCA=
Date:   Thu, 17 Oct 2019 02:39:09 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D1900C92@RTITMBSVM04.realtek.com.tw>
References: <20191016123301.2649-1-yhchuang@realtek.com>
 <20191016123301.2649-2-yhchuang@realtek.com>
 <CA+ASDXNmMiW_FaqCKowzZW6fnBhA+JXcGBJOEToBA47EShu35A@mail.gmail.com>
In-Reply-To: <CA+ASDXNmMiW_FaqCKowzZW6fnBhA+JXcGBJOEToBA47EShu35A@mail.gmail.com>
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

RnJvbTogQnJpYW4gTm9ycmlzIA0KDQo+IE9uIFdlZCwgT2N0IDE2LCAyMDE5IGF0IDU6MzMgQU0g
PHloY2h1YW5nQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gPiBpbmRleCA0NzU5ZDZhMGNhNmUuLjQ5
MmEyYmZjMGQ1YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg4L21haW4uaA0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODgvbWFpbi5oDQo+ID4gQEAgLTU4LDYgKzU4LDE5IEBAIHN0cnVjdCBydHdfaGNpIHsNCj4gPiAg
ICAgICAgIHU4IGJ1bGtvdXRfbnVtOw0KPiA+ICB9Ow0KPiA+DQo+ID4gKyNkZWZpbmUgSVNfQ0hf
NUdfQkFORF8xKGNoYW5uZWwpICgoY2hhbm5lbCkgPj0gMzYgJiYgKGNoYW5uZWwgPD0gNDgpKQ0K
PiA+ICsjZGVmaW5lIElTX0NIXzVHX0JBTkRfMihjaGFubmVsKSAoKGNoYW5uZWwpID49IDUyICYm
IChjaGFubmVsIDw9IDY0KSkNCj4gPiArI2RlZmluZSBJU19DSF81R19CQU5EXzMoY2hhbm5lbCkg
KChjaGFubmVsKSA+PSAxMDAgJiYgKGNoYW5uZWwgPD0NCj4gMTQ0KSkNCj4gPiArI2RlZmluZSBJ
U19DSF81R19CQU5EXzQoY2hhbm5lbCkgKChjaGFubmVsKSA+PSAxNDkgJiYgKGNoYW5uZWwgPD0N
Cj4gMTc3KSkNCj4gDQo+IFRoZXJlIGFyZSBjaGFubmVscyBiZXR3ZWVuIDQ4IGFuZCA1MiwgNjQg
YW5kIDEwMCwgYW5kIDE0NCBhbmQgMTQ5Lg0KPiBXaGF0IGFyZSB5b3UgZG9pbmcgd2l0aCB0aG9z
ZT8NCg0KVGhlc2UgZGV2aWNlcyBhcmUgbm90IHN1cHBvcnRpbmcgdGhvc2UgY2hhbm5lbHMgeW91
IG1lbnRpb25lZC4NClNvIEkgaG9wZSBpZiBzb21lIHVuc3VwcG9ydGVkIGNoYW5uZWxzIGFyZSB1
c2VkLCB0aGV5IHNob3VsZCBoaXQgdGhlDQoiZWxzZSIgY2FzZSwgb3IgdGhyb3cgc3VjaCBhIHdh
cm4uDQoNCj4gDQo+ID4gKyNkZWZpbmUgSVNfQ0hfNUdfQkFORF9NSUQoY2hhbm5lbCkgXA0KPiA+
ICsgICAgICAgKElTX0NIXzVHX0JBTkRfMihjaGFubmVsKSB8fCBJU19DSF81R19CQU5EXzMoY2hh
bm5lbCkpDQo+ID4gKw0KPiA+ICsjZGVmaW5lIElTX0NIXzJHX0JBTkQoY2hhbm5lbCkgKChjaGFu
bmVsKSA8PSAxNCkNCj4gPiArI2RlZmluZSBJU19DSF81R19CQU5EKGNoYW5uZWwpIFwNCj4gPiAr
ICAgICAgIChJU19DSF81R19CQU5EXzEoY2hhbm5lbCkgfHwgSVNfQ0hfNUdfQkFORF8yKGNoYW5u
ZWwpIHx8IFwNCj4gPiArICAgICAgICBJU19DSF81R19CQU5EXzMoY2hhbm5lbCkgfHwgSVNfQ0hf
NUdfQkFORF80KGNoYW5uZWwpKQ0KPiANCj4gR2l2ZW4gdGhlIGFib3ZlICh5b3UgaGF2ZSBtYWpv
ciBob2xlcyBpbiA1R19CQU5EezEsMiwzLDR9KSwgdGhpcyBtYWNybw0KPiBzZWVtcyBsaWtlIGEg
cmVncmVzc2lvbi4NCj4gDQoNCllhbi1Ic3Vhbg0K
