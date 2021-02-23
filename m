Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D732322C0E
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Feb 2021 15:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhBWOSA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Feb 2021 09:18:00 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:60961 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232331AbhBWORj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Feb 2021 09:17:39 -0500
X-UUID: db59abee20754b54b48065c2491b4771-20210223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=CLesqB4Joy9jR+iPKmM1ObofPqxpQ5q//oLAgblgD5M=;
        b=M7pocVhMd9vlFcbbNlL5FOvcApHOs1oVx2nF9vwARN5N8/PVxM9uyhIw6XSMcVDEdzWpD+ulHTDcgWPmd8wFcb1t18Hdd68HyFP1G1MnQ1UlX15+oHao9foWhikYBAkows1H+IgenD6b3TqJqFqaVs+gGklfh7l2FxI1+7wIxLY=;
X-UUID: db59abee20754b54b48065c2491b4771-20210223
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 983352301; Tue, 23 Feb 2021 22:16:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Feb 2021 22:16:50 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Feb 2021 22:16:50 +0800
Message-ID: <1614089810.6667.7.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] mt76: mt7615: remove hdr->fw_ver check
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 23 Feb 2021 22:16:50 +0800
In-Reply-To: <YDTG6xGgCjbinhte@lore-desk>
References: <61d40a20375f888c122ee0e186168fc2db863fc3.1614058187.git.ryder.lee@mediatek.com>
         <d0ed6b4f2dbac66ac9e31f3725bc4db5cc50f1f3.1614058187.git.ryder.lee@mediatek.com>
         <YDTG6xGgCjbinhte@lore-desk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E703899C3C53470BE47EEE8151A47F80A15AD4E0526457DD38AFCDE7A5449DA12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIxLTAyLTIzIGF0IDEwOjEyICswMTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiA+IE9ubHkgbXQ3NjE1IHVzZXMgdjEgdmVyc2lvbi4gQWxzbywgc29tZSBvZiByZWxlYXNl
ZCBmaXJtd2FyZSBkb2Vzbid0DQo+ID4gaGF2ZSBoZHItPmZ3X3Zlci4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21jdS5jIHwgMyAr
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzYxNS9tY3UuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1
L21jdS5jDQo+ID4gaW5kZXggMzkzY2UwOWQzOTU2Li42NWM2YWIxNGZlNmYgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMNCj4g
PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYw0K
PiA+IEBAIC0xNDQ5LDggKzE0NDksNyBAQCBzdGF0aWMgaW50IG10NzYxNV9sb2FkX245KHN0cnVj
dCBtdDc2MTVfZGV2ICpkZXYsIGNvbnN0IGNoYXIgKm5hbWUpDQo+ID4gIAkJIHNpemVvZihkZXYt
Pm10NzYuaHctPndpcGh5LT5md192ZXJzaW9uKSwNCj4gPiAgCQkgIiUuMTBzLSUuMTVzIiwgaGRy
LT5md192ZXIsIGhkci0+YnVpbGRfZGF0ZSk7DQo+ID4gIA0KPiA+IC0JaWYgKCFpc19tdDc2MTUo
JmRldi0+bXQ3NikgJiYNCj4gPiAtCSAgICAhc3RybmNtcChoZHItPmZ3X3ZlciwgIjIuMCIsIHNp
emVvZihoZHItPmZ3X3ZlcikpKSB7DQo+ID4gKwlpZiAoIWlzX210NzYxNSgmZGV2LT5tdDc2KSkg
ew0KPiA+ICAJCWRldi0+ZndfdmVyID0gTVQ3NjE1X0ZJUk1XQVJFX1YyOw0KPiA+ICAJCWRldi0+
bWN1X29wcyA9ICZzdGFfdXBkYXRlX29wczsNCj4gPiAgCX0gZWxzZSB7DQo+IA0KPiBzbyB0aGVy
ZSBhcmUgc29tZSB2MiBmdyB2ZXJzaW9uIHcvbyBmd192ZXIgZmllbGQsIGNvcnJlY3Q/IElzIHRo
aXMgZncgaW4NCj4gbGludXgtZmlybXdhcmU/DQo+IA0KSSB3aWxsIHBvc3QgaXQuDQoNCkFjdHVh
bGx5IGFsbCBNVEsgc3RvY2sgZmlybXdhcmVzIGRvbid0IGluY2x1ZGUgdGhhdCB2ZXJzaW9uIGlu
Zm8sIHNvDQpjb25zaWRlcmluZyB1c2VycyBtYXkgdXNlIGJpbmFyaWVzIGZyb20gc29tZSBtYW51
ZmFjdHVyZXMuIEkgdGhpbmsgdGhpcw0KY2FuIG1ha2UgbGlmZSBtb3JlIGVhc2llci4gVGhpcyBw
YXRjaCBzaG91bGQgd29yayBmb3IgYWxsIGZpcm13YXJlcyB3ZQ0KY2FuIGZpbmQgZXZlcnl3aGVy
ZS4gRXZlbiA3NjE1IHYyIGNhbiBiZSBiYWNrd2FyZCBjb21wYXRpYmxlIHRvIHYxLiANCg0KUnlk
ZXINCg==

