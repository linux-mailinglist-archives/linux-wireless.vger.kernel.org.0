Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551CC38F298
	for <lists+linux-wireless@lfdr.de>; Mon, 24 May 2021 19:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhEXRyc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 May 2021 13:54:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51912 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233000AbhEXRyb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 May 2021 13:54:31 -0400
X-UUID: e7ae3cc0adae48d08ea840d6a94b4d7e-20210525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=HCbB9ajOnGws9PENigdtqscCoyYeufv/mBXqD1vfrgU=;
        b=fCfhnbenNv6eBndgiQfznCbgYjk4LrxgTFPsO6qWrOrNBujdfPksr7M349IHiXUIX2mJ4mY714lfDDBeV8tFSfhb8jSy8pYEvS5sEdrQy4eKU9efIB00TtZTLAlym7gLXr1E3SmyklRhbNCsUnb8JW/lJF/rfP9K90Sls0kf7dw=;
X-UUID: e7ae3cc0adae48d08ea840d6a94b4d7e-20210525
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1295830885; Tue, 25 May 2021 01:53:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 May 2021 01:52:58 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 01:52:58 +0800
Message-ID: <1621878778.21477.1.camel@mtkswgap22>
Subject: Re: [PATCH] mt76: mt7921: fix UC entry is being overwritten
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     <sean.wang@mediatek.com>, <nbd@nbd.name>,
        <lorenzo.bianconi@redhat.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 25 May 2021 01:52:58 +0800
In-Reply-To: <YKrGretiq7wo+pzv@lore-desk>
References: <1621495354-4130-1-git-send-email-sean.wang@mediatek.com>
         <YKrGretiq7wo+pzv@lore-desk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU3VuLCAyMDIxLTA1LTIzIGF0IDIzOjE4ICswMjAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiA+IEZyb206IERlcmVuIFd1IDxkZXJlbi53dUBtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4g
Rml4IFVDIGVudHJ5IGlzIGJlaW5nIG92ZXJ3cml0dGVuIGJ5IEJDIGVudHJ5DQo+ID4gDQo+ID4g
Rml4ZXM6IDM2ZmNjOGNmZjU5MiAoIm10NzY6IG10NzkyMTogaW50cm9kdWNlIG10NzkyMV9tY3Vf
c3RhX2FkZCByb3V0aW5lIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBEZXJlbiBXdSA8ZGVyZW4ud3VA
bWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlOIENoZW4gPHluLmNoZW5AbWVkaWF0
ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNlYW4gV2FuZyA8c2Vhbi53YW5nQG1lZGlhdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc2X2Nvbm5hY19tY3UuYyB8IDExICsrKysrKystLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWN1LmMgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzZfY29ubmFjX21jdS5jDQo+ID4gaW5k
ZXggNzMzNTlkZWZhMTc2Li5mM2RlY2M1OWE2ZmUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tY3UuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWN1LmMNCj4gPiBA
QCAtODc1LDEwICs4NzUsMTMgQEAgaW50IG10NzZfY29ubmFjX21jdV9hZGRfc3RhX2NtZChzdHJ1
Y3QgbXQ3Nl9waHkgKnBoeSwNCj4gPiAgCWlmIChJU19FUlIoc2tiKSkNCj4gPiAgCQlyZXR1cm4g
UFRSX0VSUihza2IpOw0KPiA+ICANCj4gPiAtCW10NzZfY29ubmFjX21jdV9zdGFfYmFzaWNfdGx2
KHNrYiwgaW5mby0+dmlmLCBpbmZvLT5zdGEsIGluZm8tPmVuYWJsZSk7DQo+ID4gLQlpZiAoaW5m
by0+ZW5hYmxlICYmIGluZm8tPnN0YSkNCj4gPiAtCQltdDc2X2Nvbm5hY19tY3Vfc3RhX3Rsdihw
aHksIHNrYiwgaW5mby0+c3RhLCBpbmZvLT52aWYsDQo+ID4gLQkJCQkJaW5mby0+cmNwaSk7DQo+
ID4gKwlpZiAoaW5mby0+c3RhKSB7DQo+ID4gKwkJbXQ3Nl9jb25uYWNfbWN1X3N0YV9iYXNpY190
bHYoc2tiLCBpbmZvLT52aWYsIGluZm8tPnN0YSwNCj4gPiArCQkJCQkgICAgICBpbmZvLT5lbmFi
bGUpOw0KPiA+ICsJCWlmIChpbmZvLT5lbmFibGUpDQo+ID4gKwkJCW10NzZfY29ubmFjX21jdV9z
dGFfdGx2KHBoeSwgc2tiLCBpbmZvLT5zdGEsDQo+ID4gKwkJCQkJCWluZm8tPnZpZiwgaW5mby0+
cmNwaSk7DQo+ID4gKwl9DQo+IA0KPiB3aXRoIHRoaXMgcGF0Y2ggd2UgYXJlIGNoYW5naW5nIHRo
ZSBtdDc2NjMgYmVoYXZpb3VyIHNpbmNlIHdlIHJ1bg0KPiBtdDc2X2Nvbm5hY19tY3VfYWRkX3N0
YV9jbWQoKSBpbiBtdDc2MTVfcmVtb3ZlX2ludGVyZmFjZSgpIHdpdGgNCj4gZW5hYmxlID0gZmFs
c2UgYW5kIHN0YSA9IE5VTEwuIENhbiB5b3UgcGxlYXNlIGNvbmZpcm0geW91IGFyZQ0KPiBub3Qg
aW50cm9kdWNpbmcgYW55IHJlZ3Jlc3Npb24gaW4gbXQ3NjYzPw0KDQpJIHRoaW5rIHRoaXMgYWxz
byBicmVha3MgbXQ3NjIyLCBzbyBwbGVhc2UgZG91YmxlIGNoZWNrLg0KDQo+IFJlZ2FyZHMsDQo+
IExvcmVuem8NCj4gDQo+ID4gIA0KPiA+ICAJc3RhX3d0YmwgPSBtdDc2X2Nvbm5hY19tY3VfYWRk
X3Rsdihza2IsIFNUQV9SRUNfV1RCTCwNCj4gPiAgCQkJCQkgICBzaXplb2Yoc3RydWN0IHRsdikp
Ow0KPiA+IC0tIA0KPiA+IDIuMjUuMQ0KPiA+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eC1tZWRpYXRlayBtYWlsaW5nIGxpc3QNCj4g
TGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVrDQoNCg==

