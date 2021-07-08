Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D303BF567
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jul 2021 08:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhGHGRu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jul 2021 02:17:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37412 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229608AbhGHGRu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jul 2021 02:17:50 -0400
X-UUID: 15549571d00342beb8b8421c3cc8008c-20210708
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=RDpr6ntUglGbkmdoj5Vw+AU6YP2+5ZVSFjZgAehYXhU=;
        b=ruYdacKVE2S7RePGOtuVS+QnGu9stWKXV1O3AM+3HhpXF59oQU5E7Gp0VuYo632clb7nf61w7ZQPdF6Nli89dK2nAXhadrdbuezLBHX01iSZgfY0D6Uv7Ht0p0JbQqMqUVpmTymZCXeI+JWBbqTILiec1IITSdPiOD4BFSvts1s=;
X-UUID: 15549571d00342beb8b8421c3cc8008c-20210708
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 217964000; Thu, 08 Jul 2021 14:15:05 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 8 Jul 2021 14:15:03 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Jul 2021 14:15:03 +0800
Message-ID: <60de68ca4e48d1388a90f0ec59f477a93f01ab3d.camel@mediatek.com>
Subject: Re: [PATCH 1/2] mt76: mt7921: fix mgmt frame using unexpected
 bitrate
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <sean.wang@mediatek.com>, <nbd@nbd.name>,
        <lorenzo.bianconi@redhat.com>
CC:     <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <jemele@google.com>,
        <yenlinlai@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 8 Jul 2021 14:15:03 +0800
In-Reply-To: <1625718546-14969-1-git-send-email-sean.wang@mediatek.com>
References: <1625718546-14969-1-git-send-email-sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIxLTA3LTA4IGF0IDEyOjI5ICswODAwLCBzZWFuLndhbmdAbWVkaWF0ZWsuY29t
IHdyb3RlOg0KPiBGcm9tOiBTZWFuIFdhbmcgPHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+DQo+IA0K
PiBGaXggdGhlIGN1cnJlbnQgZHJpdmVyIG1nbXQgZnJhbWUgaXMgbm90IHJlc3BlY3RpbmcgdGhl
IGJhc2ljIHJhdGVzDQo+IGZpZWxkDQo+IHByb3ZpZGVkIGJ5IHRoZSBBUCBhbmQgdGhlbiB1bmNv
bmRpdGlvbmFsbHkgaXMgdXNpbmcgdGhlIGxvd2VzdCAoMSBvcg0KPiA2DQo+IE1icHMpIHJhdGUu
DQo+IA0KPiBGb3IgZXhhbXBsZSwgaWYgdGhlIEFQIG9ubHkgc3VwcG9ydGVkIGJhc2ljIHJhdGUg
ezI0LCAzNiwgNDgsIDU0fQ0KPiBNYnBzLA0KPiBtdDc5MjEgY2Fubm90IHNlbmQgbWdtdCBmcmFt
ZSB3aXRoIHRoZSByYXRlIG5vdCBpbiB0aGUgZ3JvdXAuIFNvLA0KPiBpbnN0ZWFkLCB3ZSBwaWNr
IHVwIHRoZSBsb3dlc3QgYmFzaWMgcmF0ZSB0aGUgQVAgY2FuIHN1cHBvcnQgdG8gc2VuZC4NCj4g
DQo+IFRoZSBwYXRjaCBhbHNvIGZpeGVkIHVwIHRoZSBod192YWx1ZSBpbiBpZWVlODAyMTFfcmF0
ZSBmb3IgTVQ3OTIxDQo+IGhhcmR3YXJlLg0KPiANCj4gRml4ZXM6IDE2M2Y0ZDIyYzExOCAoIm10
NzY6IG10NzkyMTogYWRkIE1BQyBzdXBwb3J0IikNCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBXYW5n
IDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIC4uLi9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc5MjEvaW5pdC5jICB8IDE5ICsrKysrKysrKysrKysrKy0tDQo+ICAuLi4v
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL21hYy5jICAgfCAyMSArKysrKysrKysr
KysrKysNCj4gLS0tLQ0KPiAgLi4uL3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL210Nzky
MS5oICAgIHwgMTQgKysrKysrKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRp
b25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gDQo+ICsJaW50IGksIG9mZnNldCA9IDA7DQo+
ICsNCj4gKwlpZiAobXBoeS0+Y2hhbmRlZi5jaGFuLT5iYW5kID09IE5MODAyMTFfQkFORF81R0ha
KQ0KPiArCQlvZmZzZXQgPSA0Ow0KPiArDQo+ICsJaSA9IGZmcyh2aWYtPmJzc19jb25mLmJhc2lj
X3JhdGVzKSAtIDE7DQo+ICsJcmF0ZSA9ICZtdDc5MjFfcmF0ZXNbb2Zmc2V0ICsgaV07DQo+ICsN
Cj4gKwlyZXR1cm4gcmF0ZS0+aHdfdmFsdWU7DQo+ICt9DQo+ICsNCj4gIHZvaWQgbXQ3OTIxX21h
Y193cml0ZV90eHdpKHN0cnVjdCBtdDc5MjFfZGV2ICpkZXYsIF9fbGUzMiAqdHh3aSwNCj4gIAkJ
CSAgIHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBtdDc2X3djaWQgKndjaWQsDQo+ICAJCQkg
ICBzdHJ1Y3QgaWVlZTgwMjExX2tleV9jb25mICprZXksIGJvb2wgYmVhY29uKQ0KPiBAQCAtODE1
LDEwICs4MzEsNyBAQCB2b2lkIG10NzkyMV9tYWNfd3JpdGVfdHh3aShzdHJ1Y3QgbXQ3OTIxX2Rl
dg0KPiAqZGV2LCBfX2xlMzIgKnR4d2ksDQo+ICAJCS8qIGhhcmR3YXJlIHdvbid0IGFkZCBIVEMg
Zm9yIG1nbXQvY3RybCBmcmFtZSAqLw0KPiAgCQl0eHdpWzJdIHw9IGNwdV90b19sZTMyKE1UX1RY
RDJfSFRDX1ZMRCk7DQo+ICANCj4gLQkJaWYgKG1waHktPmNoYW5kZWYuY2hhbi0+YmFuZCA9PSBO
TDgwMjExX0JBTkRfNUdIWikNCj4gLQkJCXJhdGUgPSBNVDc5MjFfNUdfUkFURV9ERUZBVUxUOw0K
PiAtCQllbHNlDQo+IC0JCQlyYXRlID0gTVQ3OTIxXzJHX1JBVEVfREVGQVVMVDsNCj4gKwkJcmF0
ZSA9IG10NzkyMV9kZWZhdWx0X2Jhc2ljX3JhdGVzKGRldiwgdmlmKTsNCg0KLi4uLg0KDQo+IAkJ
CQ0KPiBcDQo+ICsJLmJpdHJhdGUgPSBfcmF0ZSwJCQkJCVwNCj4gKwkuZmxhZ3MgPSBJRUVFODAy
MTFfUkFURV9TSE9SVF9QUkVBTUJMRSwJCQlcDQo+ICsJLmh3X3ZhbHVlID0gKE1UX1BIWV9UWVBF
X0NDSyA8PCA2KSB8IChfaWR4KSwJCVwNCj4gKwkuaHdfdmFsdWVfc2hvcnQgPSAoTVRfUEhZX1RZ
UEVfQ0NLIDw8IDYpIHwgKDQgKyBfaWR4KSwJXA0KPiArfQ0KPiArDQo+ICsjZGVmaW5lIE1UNzky
MV9PRkRNX1JBVEUoX2lkeCwgX3JhdGUpIHsJCQkJDQo+IFwNCj4gKwkuYml0cmF0ZSA9IF9yYXRl
LAkJCQkJXA0KPiArCS5od192YWx1ZSA9IChNVF9QSFlfVFlQRV9PRkRNIDw8IDYpIHwgKF9pZHgp
LAkJXA0KPiArCS5od192YWx1ZV9zaG9ydCA9IChNVF9QSFlfVFlQRV9PRkRNIDw8IDYpIHwgKF9p
ZHgpLAlcDQo+ICt9DQo+ICsNCg0KTmljZSBjYXRjaGluZy4gSSBzaGlmdGVkIHRoZSB3cm9uZyBv
ZmZzZXQgd2hpbGUgYnJpbmdpbmcgdXAgbXQ3OTE1LCBidXQNCkkgdXNlZCB0aGUgY29ycmVjdCBv
ZmZzZXQgaW4gVHhEIHJlc3VsdGluZyBpbiB0aGlzIG10NzkyMSBpc3N1ZS4gQ2FuDQp5b3UgZG8g
bWUgYSBmYXZvciB0byBmaXggdGhlIG9mZnNldCBvZiBtdDc5MTUgYXMgd2VsbD8NCg0KUnlkZXIN
Cg==

