Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C483B6C10
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jun 2021 03:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhF2Beq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Jun 2021 21:34:46 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:52360 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232071AbhF2Bep (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Jun 2021 21:34:45 -0400
X-UUID: 5dd0a4cc530f4a23a24dc14767d04fb1-20210629
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=7po5ACT0JUjttniIQ5Gb4nIJdIjU2KY5r4FD6Ik9sTg=;
        b=CLjWzIqAcYxUxKPcABHKQdZDypd9WD3jQPrVD6BpNE0iGwgAcUuw7LHhvlwGkp8yZG3jweh0HQbumSEfNZt5+NeNJZcQ9Rn6qx/hcHI9z9ysDNFQxm8slUcQV+Sq8yDGWjZinsOarH1OJVxbHraF/bOhidUUXrRMTz1Aoe76dho=;
X-UUID: 5dd0a4cc530f4a23a24dc14767d04fb1-20210629
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 914480503; Tue, 29 Jun 2021 09:32:15 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Jun 2021 09:32:13 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Jun 2021 09:32:13 +0800
Message-ID: <f3b33b288c3d287a95fa439dec8b9226ad5ef889.camel@mediatek.com>
Subject: Re: [PATCH v8 mac80211-next 0/3] mac80211: add BSS color change
 support
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, <johannes@sipsolutions.net>
CC:     <john@phrozen.org>, <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>,
        <linux-wireless@vger.kernel.org>
Date:   Tue, 29 Jun 2021 09:32:12 +0800
In-Reply-To: <cover.1624872141.git.lorenzo@kernel.org>
References: <cover.1624872141.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIxLTA2LTI4IGF0IDExOjI2ICswMjAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiBUaGlzIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIEJTUyBjb2xvciBjb2xsaXNzaW9uIGRl
dGVjdGlvbiBhbmQNCj4gY2hhbmdlLg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2NzoNCj4gLSBhbHdh
eXMgbm90aWZ5IHRoZSBkcml2ZXIgYWJvdXQgYnNzIGNoYW5nZSBpbg0KPiAgIGllZWU4MDIxMV9j
b2xvcl9jaGFuZ2VfZmluYWxpemUoKQ0KPiAtIGFkZCBtdDc5MTUgYnNzIGNvbG9yIHN1cHBvcnQN
Cj4gDQo+IENoYW5nZXMgc2luY2UgdjY6DQo+IC0gcmViYXNlIG9uIHRvcCBvZiBtYWM4MDIxMS1u
ZXh0DQo+IC0gZml4IGNoZWNrX3BhdGNoIGlzc3Vlcw0KPiAtIGFsbG9jIG5sYXR0ciB0YiBhcnJh
eSBkeW5hbWljYWxseSBpbiBubDgwMjExX2NvbG9yX2NoYW5nZQ0KPiAtIG1vdmUgTkw4MDIxMV9B
VFRSX0NOVERXTl9PRkZTX0JFQUNPTiBhbmQNCj4gTkw4MDIxMV9BVFRSX0NOVERXTl9PRkZTX1BS
RVNQDQo+ICAgaW4gTkw4MDIxMV9BVFRSX0NPTE9SX0NIQU5HRV9FTEVNUyBhcyBuZXN0ZWQgYXR0
cmlidXRlcw0KPiAtIHJlbW92ZSB1bnVzZWQgZGVmaW5pdGlvbnMNCj4gLSByZW1vdmUgbWJzcyBz
ZXJpZXMgZGVwZW5kZW5jeQ0KPiAtIHJlbW92ZSBhdGgxMWsgY29kZQ0KPiANCj4gSm9obiBDcmlz
cGluICgyKToNCj4gICBubDgwMjExOiBhZGQgc3VwcG9ydCBmb3IgQlNTIGNvbG9yaW5nDQo+ICAg
bWFjODAyMTE6IGFkZCBzdXBwb3J0IGZvciBCU1MgY29sb3IgY2hhbmdlDQo+IA0KPiBMb3Jlbnpv
IEJpYW5jb25pICgxKToNCj4gICBtdDc2OiBtdDc5MTU6IGludHJvZHVjZSBic3MgY29sb3Jpbmcg
c3VwcG9ydA0KPiANCj4gIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5p
dC5jICB8ICAgMSArDQo+ICAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21h
aW4uYyAgfCAgMjYgKysNCj4gIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUv
bWN1LmMgICB8ICA4NCArKysrKy0tDQo+ICAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTE1L21jdS5oICAgfCAgMjEgKy0NCj4gIC4uLi93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210
NzkxNS9tdDc5MTUuaCAgICB8ICAgMiArDQo+ICBpbmNsdWRlL25ldC9jZmc4MDIxMS5oICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgOTIgKysrKysrKw0KPiAgaW5jbHVkZS9uZXQvbWFjODAyMTEu
aCAgICAgICAgICAgICAgICAgICAgICAgIHwgIDI5ICsrKw0KPiAgaW5jbHVkZS91YXBpL2xpbnV4
L25sODAyMTEuaCAgICAgICAgICAgICAgICAgIHwgIDQzICsrKysNCj4gIG5ldC9tYWM4MDIxMS9j
ZmcuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDIzNA0KPiArKysrKysrKysrKysrKysr
Ky0NCj4gIG5ldC9tYWM4MDIxMS9pZWVlODAyMTFfaS5oICAgICAgICAgICAgICAgICAgICB8ICAx
MSArDQo+ICBuZXQvbWFjODAyMTEvaWZhY2UuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDIgKw0KPiAgbmV0L21hYzgwMjExL3R4LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDI1ICstDQo+ICBuZXQvd2lyZWxlc3Mvbmw4MDIxMS5jICAgICAgICAgICAgICAgICAgICAgICAg
fCAxNTcgKysrKysrKysrKysrDQo+ICBuZXQvd2lyZWxlc3MvcmRldi1vcHMuaCAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMTMgKw0KPiAgbmV0L3dpcmVsZXNzL3RyYWNlLmggICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDQ2ICsrKysNCj4gIDE1IGZpbGVzIGNoYW5nZWQsIDczNiBpbnNlcnRp
b25zKCspLCA1MCBkZWxldGlvbnMoLSkNCj4gDQoNCkZvciBtYWM4MDIxMSBzZXJpZXMgQWNrZWQt
Ynk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCg==

