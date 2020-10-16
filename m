Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56038290E0A
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Oct 2020 01:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410838AbgJPXO1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Oct 2020 19:14:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33163 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409430AbgJPXO0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Oct 2020 19:14:26 -0400
X-UUID: 3e1dc6cdffa041d6ade073b772ae29ab-20201017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=EuZKtFefiJ6L/4gR71BklH0YKnd9Ub+bhASYlt1eN4g=;
        b=BfeX+e7dOHnd7KHlmPGHsSt/Mj5nEh+4kCitBL3kHsqINytArf3VUkuMYXv3Q1rMIUETbmGLYZLh8V7F7BD5GWK0VdknkJmK0zP/x5c33pWQYWDe/GpcPJhrVyEgKsffyg8vvM7tBFER3lhZdebazHTlsApxDyvSp9Wjede5V6E=;
X-UUID: 3e1dc6cdffa041d6ade073b772ae29ab-20201017
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 547434829; Sat, 17 Oct 2020 07:14:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 17 Oct 2020 07:14:20 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 17 Oct 2020 07:14:20 +0800
Message-ID: <1602890061.23114.2.camel@mtkswgap22>
Subject: Re: [PATCH 1/2] mt76: mt7663: handle failure event for patch
 semaphore cmd
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <sean.wang@mediatek.com>
CC:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Sean Wang" <objelf@gmail.com>, YN Chen <YN.Chen@mediatek.com>
Date:   Sat, 17 Oct 2020 07:14:21 +0800
In-Reply-To: <267346a9a9c5f71caec03292b6c33b39864b38c5.1602807276.git.objelf@gmail.com>
References: <267346a9a9c5f71caec03292b6c33b39864b38c5.1602807276.git.objelf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTE2IGF0IDA4OjI2ICswODAwLCBzZWFuLndhbmdAbWVkaWF0ZWsuY29t
IHdyb3RlOg0KPiBGcm9tOiBTZWFuIFdhbmcgPG9iamVsZkBnbWFpbC5jb20+DQo+IA0KPiBKdXN0
IGZvbGxvdyB1cCB2ZW5kb3IgZHJpdmVyIHRvIHJldHJ5IGEgZmV3IHRpbWVzIG9idGFpbmluZyBw
YXRjaA0KPiBzZW1hcGhvcmUgd2hlbiB0aGUgZXZlbnQgaXMgUEFUQ0hfTk9UX0RMX1NFTV9GQUlM
LiBUaGF0IHVzdWFsbHkNCj4gaGFwcGVucyBpbiBCbHVldG9vdGggYW5kIFdpZmkgZHJpdmVyIGNv
bnRlbmRzIHRvIGRvd25sb2FkIHBhdGNoDQo+IHNpbXVsdGFuZW91c2x5Lg0KPiANCj4gQ28tZGV2
ZWxvcGVkLWJ5OiBZTiBDaGVuIDxZTi5DaGVuQG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogWU4gQ2hlbiA8WU4uQ2hlbkBtZWRpYXRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6ICBTZWFu
IFdhbmcgPHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+DQoNCldoYXQncyB0aGUgZGlmZmVyZW5jZSBi
ZXR3ZWVuIHRoaXMgYW5kIGh0dHBzOi8vZ2l0aHViLmNvbS9uYmQxNjgvd2lyZWxlc3MvY29tbWl0
L2Y1NWJjMmYzN2UyNDc3MjlmODA4NzQzNGI5YWFmYzRkMDA5NWM0Y2EgPw0KDQo+IC0tLQ0KPiAg
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMgfCA5ICsrKysr
KysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
NjE1L21jdS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1
LmMNCj4gaW5kZXggMmIxN2JkMWMyYTMyLi5jOTkwY2NkNmY0NzIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21jdS5jDQo+ICsrKyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21jdS5jDQo+IEBAIC0xOTQ1
LDE0ICsxOTQ1LDIxIEBAIHN0YXRpYyBpbnQgbXQ3NjE1X2xvYWRfcGF0Y2goc3RydWN0IG10NzYx
NV9kZXYgKmRldiwgdTMyIGFkZHIsIGNvbnN0IGNoYXIgKm5hbWUpDQo+ICB7DQo+ICAJY29uc3Qg
c3RydWN0IG10NzYxNV9wYXRjaF9oZHIgKmhkcjsNCj4gIAljb25zdCBzdHJ1Y3QgZmlybXdhcmUg
KmZ3ID0gTlVMTDsNCj4gLQlpbnQgbGVuLCByZXQsIHNlbTsNCj4gKwlpbnQgbGVuLCByZXQsIHNl
bSwgYyA9IDUwOw0KPiAgDQo+ICtyZXRyeToNCj4gIAlzZW0gPSBtdDc2MTVfbWN1X3BhdGNoX3Nl
bV9jdHJsKGRldiwgMSk7DQo+ICAJc3dpdGNoIChzZW0pIHsNCj4gIAljYXNlIFBBVENIX0lTX0RM
Og0KPiAgCQlyZXR1cm4gMDsNCj4gIAljYXNlIFBBVENIX05PVF9ETF9TRU1fU1VDQ0VTUzoNCj4g
IAkJYnJlYWs7DQo+ICsJY2FzZSBQQVRDSF9OT1RfRExfU0VNX0ZBSUw6DQo+ICsJCWlmIChpc19t
dDc2NjMoJmRldi0+bXQ3NikgJiYgYy0tKSB7DQo+ICsJCQltc2xlZXAoMTAwKTsNCj4gKwkJCWdv
dG8gcmV0cnk7DQo+ICsJCX0NCj4gKwkJZmFsbHRocm91Z2g7DQo+ICAJZGVmYXVsdDoNCj4gIAkJ
ZGV2X2VycihkZXYtPm10NzYuZGV2LCAiRmFpbGVkIHRvIGdldCBwYXRjaCBzZW1hcGhvcmVcbiIp
Ow0KPiAgCQlyZXR1cm4gLUVBR0FJTjsNCg0KDQo=

