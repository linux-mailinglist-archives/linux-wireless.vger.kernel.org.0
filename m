Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDB93FE1C0
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Sep 2021 20:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346703AbhIASHw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Sep 2021 14:07:52 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:57902 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1346734AbhIASHv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Sep 2021 14:07:51 -0400
X-UUID: 62de42abce6d4f228f00c53115857dc6-20210902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=JGJFdApMcubNDWvC7wCYe/neX6g9lSnZlMWbSWb6VQQ=;
        b=Ur35WI6b93Vt0goLnNy7P0aVSgLl0QfsFqUtu7BacGCPDxLtH7Y59rbFUpO89t7mbny9cnSvQHTruxnUQiFFASq2huV8s72n8JQPcu4/UTUKWPnVQho14Sg9wYo+85NcuroaXsgq+aF9b6aNFY42ygXXAmxELBWgLk6x+r/TEfg=;
X-UUID: 62de42abce6d4f228f00c53115857dc6-20210902
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2042623059; Thu, 02 Sep 2021 02:06:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 02:06:49 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Sep 2021 02:06:49 +0800
Message-ID: <32b9ac1244f38d20f89548b14aa8d2afb0fa779b.camel@mediatek.com>
Subject: Re: [PATCH v5 1/2] mt76: mt7915: fix hwmon temp sensor mem
 use-after-free
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Ben Greear <greearb@candelatech.com>, Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 2 Sep 2021 02:06:49 +0800
In-Reply-To: <efe0cd18-b89a-0385-a271-d6c57fea08ca@candelatech.com>
References: <d72e872e7fdb5c04e890b978575f4d86bc61ad36.1630515789.git.ryder.lee@mediatek.com>
         <efe0cd18-b89a-0385-a271-d6c57fea08ca@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIxLTA5LTAxIGF0IDEwOjU1IC0wNzAwLCBCZW4gR3JlZWFyIHdyb3RlOg0KPiBP
biA5LzEvMjEgMTA6NDkgQU0sIFJ5ZGVyIExlZSB3cm90ZToNCj4gPiBGcm9tOiBCZW4gR3JlZWFy
IDxncmVlYXJiQGNhbmRlbGF0ZWNoLmNvbT4NCj4gPiANCj4gPiBXaXRob3V0IHRoaXMgY2hhbmdl
LCBnYXJiYWdlIGlzIHNlZW4gaW4gdGhlIGh3bW9uIG5hbWUgYW5kIHNlbnNvcnMNCj4gPiBvdXRw
dXQNCj4gPiBmb3IgbXQ3OTE1IGlzIGdhcmJsZWQuIEl0IGFwcGVhcnMgdGhhdCB0aGUgaHdtb24g
bG9naWMgZG9lcyBub3QNCj4gPiBtYWtlIGENCj4gPiBjb3B5IG9mIHRoZSBpbmNvbWluZyBzdHJp
bmcsIGJ1dCBpbnN0ZWFkIGp1c3QgY29waWVzIGEgY2hhciogYW5kDQo+ID4gZXhwZWN0cw0KPiA+
IGl0IHRvIG5ldmVyIGdvIGF3YXkuDQo+ID4gDQo+ID4gRml4ZXM6IGQ2OTM4MjUxYmI1YiAoIm10
NzY6IG10NzkxNTogYWRkIHRoZXJtYWwgc2Vuc29yIGRldmljZQ0KPiA+IHN1cHBvcnQiKQ0KPiA+
IFNpZ25lZC1vZmYtYnk6IEJlbiBHcmVlYXIgPGdyZWVhcmJAY2FuZGVsYXRlY2guY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCj4gPiAt
LS0NCj4gPiB2NTogIFVzZSBkZXZtX2tzdHJkdXAgb24gdGhlIHdpcGh5IG5hbWUgYXMgc3VnZ2Vz
dGVkLg0KPiANCj4gSSBkb24ndCBjYXJlIGEgZ3JlYXQgZGVhbCBlaXRoZXIgd2F5LCBidXQgcGh5
bmFtZSBjYW4gY2hhbmdlICh3aGljaA0KPiB3YXMgb3JpZ2luYWwNCj4gd2F5IHRvIHJlcHJvZHVj
ZSB0aGlzIGNvcnJ1cHRpb24gYnVnKSwgc28gd2l0aCB0aGlzIHY1IGNoYW5nZSwgdGhlbg0KPiB0
aGUgaHdtb24gJ2lkJyBjb3VsZCBjb25mdXNpbmdseQ0KPiBiZSAncGh5MCcgd2hpbGUgdXNlciBo
YXMgcmVuYW1lZCB0aGUgcGh5MCB0byB3aXBoeTAgb3Igd2hhdGV2ZXIuDQo+IA0KPiBJdCB3b24n
dCBicmVhayBteSB1c2FnZSBlaXRoZXIgd2F5LCBzbyBpZiB5b3UgYXJlIGhhcHB5IHdpdGggdGhp
cywNCj4gdGhlbiBnb29kDQo+IGVub3VnaCBmb3IgbWUuDQoNCkkgdGhvdWdodCBvZiB0aGlzIC4u
LiBDb25zaWRlcmluZyB0aGUgaHdtb24gY2FuJ3QgbmV2ZXIga25vdyB0aGUNCnBoeW5hbWUgb25j
ZSBpdCBnb3QgY2hhbmdlZC4gV2UgY2FuIG9ubHkgc3BlY2lmaXkgYSBzdGF0aWMgIm10NzkxNS14
eHgiIA0KdG8gbmFtZSBpdCwgb3IganVzdCB1c2UgYW4gaW5pdGlhbCBwaHluYW1lLiBBbnlob3cg
aXQncyBub3QgdGhlIHJlYWwNCnBoeW5hbWUgeW91IGNoYW5nZSBhY3R1YWxseS4NCg0KPiBCdXQs
IHNlZSBiZWxvdywgdGhlcmUgaXMgc3B1cmlvdXMgY2hhbmdlLi4uDQo+IA0KPiANCj4gPiB2NDog
IFNpbXBsaWZ5IGZsb3cuDQo+ID4gdjM6ICBBZGQgJ2ZpeGVzJyB0YWcgdG8gYWlkIGJhY2twb3J0
cy4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
OTE1L2luaXQuYyB8IDggKysrKy0tLS0NCj4gPiAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3OTE1L21jdS5jICB8IDIgKy0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMNCj4gPiBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2luaXQuYw0KPiA+IGluZGV4IGFj
YzgzZTlmNDA5Yi4uNzhiOWFiYmU2M2YzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2luaXQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2luaXQuYw0KPiA+IEBAIC0xNjAsOSArMTYw
LDEwIEBAIHN0YXRpYyBpbnQgbXQ3OTE1X3RoZXJtYWxfaW5pdChzdHJ1Y3QNCj4gPiBtdDc5MTVf
cGh5ICpwaHkpDQo+ID4gICAJc3RydWN0IHdpcGh5ICp3aXBoeSA9IHBoeS0+bXQ3Ni0+aHctPndp
cGh5Ow0KPiA+ICAgCXN0cnVjdCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlICpjZGV2Ow0KPiA+ICAg
CXN0cnVjdCBkZXZpY2UgKmh3bW9uOw0KPiA+ICsJY29uc3QgY2hhciAqbmFtZTsNCj4gPiAgIA0K
PiA+IC0JY2RldiA9IHRoZXJtYWxfY29vbGluZ19kZXZpY2VfcmVnaXN0ZXIod2lwaHlfbmFtZSh3
aXBoeSksIHBoeSwNCj4gPiAtCQkJCQkgICAgICAgJm10NzkxNV90aGVybWFsX29wcyk7DQo+ID4g
KwluYW1lID0gZGV2bV9rc3RyZHVwKCZ3aXBoeS0+ZGV2LCB3aXBoeV9uYW1lKHdpcGh5KSwNCj4g
PiBHRlBfS0VSTkVMKTsNCj4gPiArCWNkZXYgPSB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3JlZ2lz
dGVyKG5hbWUsIHBoeSwNCj4gPiAmbXQ3OTE1X3RoZXJtYWxfb3BzKTsNCj4gPiAgIAlpZiAoIUlT
X0VSUihjZGV2KSkgew0KPiA+ICAgCQlpZiAoc3lzZnNfY3JlYXRlX2xpbmsoJndpcGh5LT5kZXYu
a29iaiwgJmNkZXYtDQo+ID4gPmRldmljZS5rb2JqLA0KPiA+ICAgCQkJCSAgICAgICJjb29saW5n
X2RldmljZSIpIDwgMCkNCj4gPiBAQCAtMTc0LDggKzE3NSw3IEBAIHN0YXRpYyBpbnQgbXQ3OTE1
X3RoZXJtYWxfaW5pdChzdHJ1Y3QNCj4gPiBtdDc5MTVfcGh5ICpwaHkpDQo+ID4gICAJaWYgKCFJ
U19SRUFDSEFCTEUoQ09ORklHX0hXTU9OKSkNCj4gPiAgIAkJcmV0dXJuIDA7DQo+ID4gICANCj4g
PiAtCWh3bW9uID0gZGV2bV9od21vbl9kZXZpY2VfcmVnaXN0ZXJfd2l0aF9ncm91cHMoJndpcGh5
LT5kZXYsDQo+ID4gLQkJCQkJCSAgICAgICB3aXBoeV9uYW1lKHdpcGh5DQo+ID4gKSwgcGh5LA0K
PiA+ICsJaHdtb24gPSBkZXZtX2h3bW9uX2RldmljZV9yZWdpc3Rlcl93aXRoX2dyb3Vwcygmd2lw
aHktPmRldiwNCj4gPiBuYW1lLCBwaHksDQo+ID4gICAJCQkJCQkgICAgICAgbXQ3OTE1X2h3bW9u
X2dybw0KPiA+IHVwcyk7DQo+ID4gICAJaWYgKElTX0VSUihod21vbikpDQo+ID4gICAJCXJldHVy
biBQVFJfRVJSKGh3bW9uKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMNCj4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jDQo+ID4gaW5kZXggOTMyY2Y1YTYyOWRiLi4yMTliYjM1
M2I1NmQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MTUvbWN1LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkxNS9tY3UuYw0KPiA+IEBAIC0xOTYyLDcgKzE5NjIsNyBAQCBtdDc5MTVfbWN1X3N0
YV9iZmVyX3RsdihzdHJ1Y3QgbXQ3OTE1X2Rldg0KPiA+ICpkZXYsIHN0cnVjdCBza19idWZmICpz
a2IsDQo+ID4gICAJZWxzZQ0KPiA+ICAgCQlyZXR1cm47DQo+ID4gICANCj4gPiAtCWJmLT5iZl9j
YXAgPSBCSVQoIWViZiAmJiBkZXYtPmliZik7DQo+ID4gKwliZi0+YmZfY2FwID0gZWJmID8gZWJm
IDogZGV2LT5pYmYgPDwgMTsNCj4gDQo+IEFuZCB0aGlzIHNob3VsZCBub3QgYmUgaW4gdGhpcyBw
YXRjaC4NCj4gDQoNCk9vcHMuIEkgbWVzc2VkIHBhdGNoIHVwIHdoaWxlIG1lcmdpbmcgdG8gb3Ro
ZXIgc2VyaWVzLiBXaWxsIGZpeC4NCg0KUnlkZXINCj4gDQo=

