Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E70A396605
	for <lists+linux-wireless@lfdr.de>; Mon, 31 May 2021 18:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhEaQzJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 12:55:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:42622 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231204AbhEaQwW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 12:52:22 -0400
X-UUID: f596e7ca21514637bfc319f3d70a5c1c-20210601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=jOyhX6Re5eXq28+/L1oMJ2keBDSoTs6sF7Oih/n0Kpk=;
        b=Ormfhnl0Onavzmf77P5ZCCClxetdPlaL5oAzhn6u4BzTP5wkfkuwEBJrAugqoUvurEfbFPQPPl8l+4pVowT+JKlsiXU6Mkq2L4p0gfFOqo0D+qpyUwvBVTQAizwDHd7lC3ZVI19AlVRWY70iBBvpmyfBRygpqMB3aoQj1YO9nWI=;
X-UUID: f596e7ca21514637bfc319f3d70a5c1c-20210601
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 32020009; Tue, 01 Jun 2021 00:50:38 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Jun 2021 00:50:37 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Jun 2021 00:50:36 +0800
Message-ID: <6188b37ca5f9aa74c7403c999c74540fe462a174.camel@mediatek.com>
Subject: Re: [PATCH] mt76: mt7921: enable random mac address during
 sched_scan
From:   Deren Wu <deren.wu@mediatek.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
        "Soul Huang" <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>, <jemele@google.com>,
        <yenlinlai@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Tue, 1 Jun 2021 00:50:36 +0800
In-Reply-To: <YLUQqIqbojUNRZVA@lore-desk>
References: <14360a28083d56520a2cabc87841d9dee3d97a01.1622476643.git.deren.wu@mediatek.com>
         <YLUQqIqbojUNRZVA@lore-desk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIxLTA1LTMxIGF0IDE4OjM2ICswMjAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiA+IEZyb206IERlcmVuIFd1IDxkZXJlbi53dUBtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4g
RW5hYmxlIHNyYyBhZGRyZXNzIHJhbmRvbWl6YXRpb24gZHVyaW5nIHNjaGVkdWxlZCBzY2Fubmlu
Zw0KPiA+IA0KPiA+IENvLWRldmVsb3BlZC1ieTogTG9yZW56byBCaWFuY29uaSA8bG9yZW56b0Br
ZXJuZWwub3JnPg0KPiANCj4gSGVyZSB3ZSBhcmUgbWlzc2luZyBteSBTb0IsIGl0IHNob3VsZCBi
ZToNCj4gDQo+IENvLWRldmVsb3BlZC1ieTogTG9yZW56byBCaWFuY29uaSA8bG9yZW56b0BrZXJu
ZWwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBMb3JlbnpvIEJpYW5jb25pIDxsb3JlbnpvQGtlcm5l
bC5vcmc+DQoNCkhpIExvcmUsDQoNClNvcnJ5IGZvciB0eXBvLiBJIHdpbGwgdXBkYXRlIGEgbmV3
IHZlcmlvbi4NCg0KDQpSZWdhcmRzLA0KRGVyZW4NCg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBE
ZXJlbiBXdSA8ZGVyZW4ud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWN1LmMgICB8IDE0ICsrKysrKysrDQo+
ID4gLS0tLS0tDQo+ID4gIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5h
Y19tY3UuaCAgIHwgIDQgKysrLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkyMS9pbml0LmMgICB8ICAzICsrLQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDEzIGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWN1LmMNCj4gPiBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWN1LmMNCj4gPiBp
bmRleCA3MzM1OWRlZmExNzYuLmIxNTVlN2I4ZDg5ZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzZfY29ubmFjX21jdS5jDQo+ID4gKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tY3UuYw0KPiA+
IEBAIC0xNTE1LDE0ICsxNTE1LDE2IEBAIGludCBtdDc2X2Nvbm5hY19tY3Vfc2NoZWRfc2Nhbl9y
ZXEoc3RydWN0DQo+ID4gbXQ3Nl9waHkgKnBoeSwNCj4gPiAgCXJlcS0+dmVyc2lvbiA9IDE7DQo+
ID4gIAlyZXEtPnNlcV9udW0gPSBtdmlmLT5zY2FuX3NlcV9udW0gfCBleHRfcGh5IDw8IDc7DQo+
ID4gIA0KPiA+IC0JaWYgKGlzX210NzY2MyhwaHktPmRldikgJiYNCj4gPiAtCSAgICAoc3JlcS0+
ZmxhZ3MgJiBOTDgwMjExX1NDQU5fRkxBR19SQU5ET01fQUREUikpIHsNCj4gPiAtCQlnZXRfcmFu
ZG9tX21hc2tfYWRkcihyZXEtPm10NzY2My5yYW5kb21fbWFjLCBzcmVxLQ0KPiA+ID5tYWNfYWRk
ciwNCj4gPiAtCQkJCSAgICAgc3JlcS0+bWFjX2FkZHJfbWFzayk7DQo+ID4gKwlpZiAoc3JlcS0+
ZmxhZ3MgJiBOTDgwMjExX1NDQU5fRkxBR19SQU5ET01fQUREUikgew0KPiA+ICsJCXU4ICphZGRy
ID0gaXNfbXQ3NjYzKHBoeS0+ZGV2KSA/IHJlcS0+bXQ3NjYzLnJhbmRvbV9tYWMNCj4gPiArCQkJ
CQkgICAgICAgOiByZXEtDQo+ID4gPm10NzkyMS5yYW5kb21fbWFjOw0KPiA+ICsNCj4gPiAgCQly
ZXEtPnNjYW5fZnVuYyA9IDE7DQo+ID4gLQl9IGVsc2UgaWYgKGlzX210NzkyMShwaHktPmRldikp
IHsNCj4gPiAtCQlyZXEtPm10NzkyMS5ic3NfaWR4ID0gbXZpZi0+aWR4Ow0KPiA+ICsJCWdldF9y
YW5kb21fbWFza19hZGRyKGFkZHIsIHNyZXEtPm1hY19hZGRyLA0KPiA+ICsJCQkJICAgICBzcmVx
LT5tYWNfYWRkcl9tYXNrKTsNCj4gPiAgCX0NCj4gPiArCWlmIChpc19tdDc5MjEocGh5LT5kZXYp
KQ0KPiA+ICsJCXJlcS0+bXQ3OTIxLmJzc19pZHggPSBtdmlmLT5pZHg7DQo+ID4gIA0KPiA+ICAJ
cmVxLT5zc2lkc19udW0gPSBzcmVxLT5uX3NzaWRzOw0KPiA+ICAJZm9yIChpID0gMDsgaSA8IHJl
cS0+c3NpZHNfbnVtOyBpKyspIHsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tY3UuaA0KPiA+IGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tY3UuaA0KPiA+IGluZGV4IGQ2NGI4MDU4
Yjc0NC4uMzA3NjQxN2VhZDVmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWN1LmgNCj4gPiArKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzZfY29ubmFjX21jdS5oDQo+ID4gQEAgLTc3OSw3ICs3
NzksOSBAQCBzdHJ1Y3QgbXQ3Nl9jb25uYWNfc2NoZWRfc2Nhbl9yZXEgew0KPiA+ICAJCX0gbXQ3
NjYzOw0KPiA+ICAJCXN0cnVjdCB7DQo+ID4gIAkJCXU4IGJzc19pZHg7DQo+ID4gLQkJCXU4IHBh
ZDJbNjNdOw0KPiA+ICsJCQl1OCBwYWQyWzE5XTsNCj4gPiArCQkJdTggcmFuZG9tX21hY1tFVEhf
QUxFTl07DQo+ID4gKwkJCXU4IHBhZDNbMzhdOw0KPiA+ICAJCX0gbXQ3OTIxOw0KPiA+ICAJfTsN
Cj4gPiAgfSBfX3BhY2tlZDsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvaW5pdC5jDQo+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzkyMS9pbml0LmMNCj4gPiBpbmRleCA1OWRhMjkwMzI2NDUuLjE5Y2U5
Y2E3MjU0MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkyMS9pbml0LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L210NzkyMS9pbml0LmMNCj4gPiBAQCAtNzYsNyArNzYsOCBAQCBtdDc5MjFfaW5pdF93
aXBoeShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodykNCj4gPiAgCXdpcGh5LT5mbGFncyB8PSBXSVBI
WV9GTEFHX0hBU19DSEFOTkVMX1NXSVRDSDsNCj4gPiAgCXdpcGh5LT5yZWdfbm90aWZpZXIgPSBt
dDc5MjFfcmVnZF9ub3RpZmllcjsNCj4gPiAgDQo+ID4gLQl3aXBoeS0+ZmVhdHVyZXMgfD0gTkw4
MDIxMV9GRUFUVVJFX1NDQU5fUkFORE9NX01BQ19BRERSOw0KPiA+ICsJd2lwaHktPmZlYXR1cmVz
IHw9IE5MODAyMTFfRkVBVFVSRV9TQ0hFRF9TQ0FOX1JBTkRPTV9NQUNfQUREUiB8DQo+ID4gKwkJ
CSAgIE5MODAyMTFfRkVBVFVSRV9TQ0FOX1JBTkRPTV9NQUNfQUREUjsNCj4gPiAgCXdpcGh5X2V4
dF9mZWF0dXJlX3NldCh3aXBoeSwNCj4gPiBOTDgwMjExX0VYVF9GRUFUVVJFX1NFVF9TQ0FOX0RX
RUxMKTsNCj4gPiAgDQo+ID4gIAlpZWVlODAyMTFfaHdfc2V0KGh3LCBTSU5HTEVfU0NBTl9PTl9B
TExfQkFORFMpOw0KPiA+IC0tIA0KPiA+IDIuMTguMA0KPiA+IA0K

