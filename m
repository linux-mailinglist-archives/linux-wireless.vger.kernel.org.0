Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3C83120F2
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Feb 2021 03:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhBGCmE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Feb 2021 21:42:04 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:44011 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229506AbhBGCmD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Feb 2021 21:42:03 -0500
X-UUID: e84b5623047f4c7da125b0e03641216a-20210207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=KylhczPDQmJm8aTlE4/r72AkBA70MMaHxDqLsCazpho=;
        b=HBEVlQL9CDlorHHrIGPjmYLefXyDLfcPVpx2i91F/gvwCKIjBF9/V98x0WkL+MyB6PJYntMpfOmTelFp6HK8HIaMPKBDW8zu0E1/XgTUW283T85fUFuEuyQxteOVgaC02Ea/4S9GMGSUEKIYyDSTQtQ/BPZz3Jo6q+x+0Yxrg90=;
X-UUID: e84b5623047f4c7da125b0e03641216a-20210207
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1977239342; Sun, 07 Feb 2021 10:41:17 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 7 Feb 2021 10:41:15 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 7 Feb 2021 10:41:15 +0800
Message-ID: <1612665675.2364.43.camel@mtkswgap22>
Subject: Re: [PATCH] mac80211: only schedule TXQ when reasonable airtime
 reporting
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Sun, 7 Feb 2021 10:41:15 +0800
In-Reply-To: <878s82ve1c.fsf@toke.dk>
References: <c48c3555ab2261d6b6674ac7de8203359b80b127.1612529311.git.ryder.lee@mediatek.com>
         <878s82ve1c.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E0EB679D95937FD5FF6A6DA529D0893AF452B04BCD6066E3141017E110FB02092000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIxLTAyLTA1IGF0IDE0OjI5ICswMTAwLCBUb2tlIEjDuGlsYW5kLUrDuHJnZW5z
ZW4gd3JvdGU6DQo+IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4gd3JpdGVzOg0K
PiANCj4gPiBGb3Igc29tZSBkcml2ZXJzIGFuZCBoYXJkd2FyZSBtYXkgcmVwb3J0IGZhdWx0eSBh
aXJ0aW1lLCB3aGljaCBlbmRzIHVwDQo+ID4gd2l0aCBleGNlc3NpdmUgaG9sZCB0aW1lICh+MC45
cyBvbiBtdDc5MTUgbXVsdGljbGVudCB0ZXN0cykgaW1wYWN0aW5nDQo+ID4gc3lzdGVtIHBlcmZv
cm1hbmNlLg0KPiA+DQo+ID4gQWx0aG91Z2ggaXNzdWUgaGFzIGJlZW4gZml4ZWQgaW4gZHJpdmVy
LCBidXQgaXQgbWFrZSBzZW5zZSB0byBzZWxlY3QgdHhxaQ0KPiA+IGRlcGVuZHMgb24gYSByZWFz
b25hYmxlIGFpcnRpbWUgcmVwb3J0aW5nIHRvIHByZXZlbnQgc3VjaCBhIGNhc2UgZnJvbQ0KPiA+
IGhhcHBlbmluZyBhZ2Fpbi4NCj4gDQo+IEkgdGhpbmsgSSBzZWUgd2hhdCB5b3UncmUgdHJ5aW5n
IHRvIGRvIHdpdGggdGhlIHBhdGNoLCBidXQgdGhpcyBjb21taXQNCj4gbWVzc2FnZSBtYWtlcyBu
byBzZW5zZS4gV2hhdCwgZXhhY3RseSwgd2FzIHRoZSBlcnJvciB5b3Ugd2VyZSBzZWVpbmcNCj4g
dGhhdCB0aGlzIGlzIHN1cHBvc2VkIHRvIGZpeD8NCg0KSSB3aWxsIG1ha2UgY29tbWl0IG1lc3Nh
Z2UgbW9yZSBzdHJhaWdodGZvcndhcmQgLSBpZiBhIHN0YXRpb24gdGFrZXMNCmxhcmdlIGFtb3Vu
dCBvZiBhaXJ0aW1lIGFuZCBmYWlscyB0aGUgY2hlY2sgdGhhdCB3aWxsIGtlZXAgZ2V0dGluZw0K
cmVjeWNsZWQgdGhyb3VnaCB0aGUgbGlzdCBhbG9uZyB3aXRoIGV4Y2Vzc2l2ZSBsb2NrIGhvbGQg
dGltZS4gQWRkIHRoaXMNCnBhdGNoIHRvIGF2b2lkIGJyZWFraW5nIGZhaXJuZXNzLg0KDQo+ID4g
VGVzdGVkLWJ5OiBKaWFvIEJvIDxqaWFvLmJhb0BtZWRpYXRlay5jb20+DQo+ID4gVGVzdGVkLWJ5
OiBTdWp1YW4gQ2hlbiA8c3VqdWFuLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgbmV0
L21hYzgwMjExL3R4LmMgfCA0ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL25ldC9tYWM4MDIxMS90eC5jIGIvbmV0L21hYzgw
MjExL3R4LmMNCj4gPiBpbmRleCA2NDIyZGE2NjkwZjcuLjBiOGE4YzM2MDBmNCAxMDA2NDQNCj4g
PiAtLS0gYS9uZXQvbWFjODAyMTEvdHguYw0KPiA+ICsrKyBiL25ldC9tYWM4MDIxMS90eC5jDQo+
ID4gQEAgLTM3NzAsNiArMzc3MCwxMCBAQCBzdHJ1Y3QgaWVlZTgwMjExX3R4cSAqaWVlZTgwMjEx
X25leHRfdHhxKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCB1OCBhYykNCj4gPiAgCQkJCXN0YS0+
YWlydGltZV93ZWlnaHQ7DQo+ID4gIA0KPiA+ICAJCWlmIChkZWZpY2l0IDwgMCB8fCAhYXFsX2No
ZWNrKSB7DQo+ID4gKwkJCWlmICh0eHFpLT5zY2hlZHVsZV9yb3VuZCA9PSBsb2NhbC0+c2NoZWR1
bGVfcm91bmRbYWNdKQ0KPiA+ICsJCQkJZ290byBvdXQ7DQo+ID4gKw0KPiA+ICsJCQl0eHFpLT5z
Y2hlZHVsZV9yb3VuZCA9IGxvY2FsLT5zY2hlZHVsZV9yb3VuZFthY107DQo+IA0KPiBJIHRoaW5r
IHRoaXMgY2hhbmdlIG1heSBiZSB3b3J0aCBtYWtpbmcgYW55d2F5LCBidXQgZm9yIGEgZGlmZmVy
ZW50DQo+IHJlYXNvbjogV2l0aG91dCBpdCwgYSBzdGF0aW9uIHRoYXQgZmFpbHMgYXFsX2NoZWNr
IHdpbGwga2VlcCBnZXR0aW5nDQo+IHJlY3ljbGVkIHRocm91Z2ggdGhlIGxpc3QsIGFkdmFuY2lu
ZyBpdHMgZGVmaWNpdC4gV2hpY2ggY291bGQgYWN0dWFsbHkNCj4gYmUgdGhlIHJlYXNvbiBBUUwg
YnJlYWtzIGFpcnRpbWUgZmFpcm5lc3M7IGRpZCB5b3Ugb2JzZXJ2ZSBhbnkNCj4gZGlmZmVyZW5j
ZSBpbiBmYWlybmVzcyB3aXRoIHRoaXMgY2hhbmdlPw0KDQpPdXIgY2FzZSBpczogbXQ3OTE1IHBy
b3ZpZGVzIHBlci1wZWVyIGFpcnRpbWUgY291bnRlcnMuIEhvd2V2ZXIsIHNvbWUgb2YNCnRoZW0g
d2VyZSBub3QgcHJvcGVybHkgY29uZmlndXJlZCwgc28gY2VydGFpbiBzdGF0aW9ucyByZXBvcnRl
ZCBsYXJnZQ0KYW1vdW50IG9mIGFpcnRpbWUgd2hpY2ggbGVkIHRvIGRlZmljaXQgPCAwLCBhbmQg
YXMgeW91IHNhaWQsIGVuZGluZyB1cA0Kd2l0aCByZWN5Y2xlICsgdmVyeSBsb25nZXIgbG9jayBo
b2xkIHRpbWUgKDAuOXMgaW4gb3VyIHRlc3RzKSBhbmQNCmJyZWFraW5nIGZhaXJuZXNzLg0KDQoN
ClJ5ZGVyDQo=

