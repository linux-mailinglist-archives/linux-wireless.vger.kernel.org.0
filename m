Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD943337ED
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Mar 2021 09:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhCJIzO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Mar 2021 03:55:14 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43030 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232523AbhCJIyy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Mar 2021 03:54:54 -0500
X-UUID: 3d8355c8defd4eeda4875086578c8b15-20210310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=SdbKNEFQj6KE5ljqlY4DgijhePB6jeycIgwGj26hkrs=;
        b=OSypZczU+tVQt1VjGZtF8rB8AFyU2t1M2SSJcQDC/huBrk1njRnSQNXl762m2zu3yS9jgExy49Tvf6h+WmYQWsyqc2SNb6paCpR6FoWsS8x181ISwTZ4sdxM63RGbCGKo27DRIrt6aW13yB2RNPt+SSMvU7Ru4IsRRl6eAs0xJ4=;
X-UUID: 3d8355c8defd4eeda4875086578c8b15-20210310
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 711503969; Wed, 10 Mar 2021 16:54:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 10 Mar 2021 16:54:50 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Mar 2021 16:54:50 +0800
Message-ID: <1615366490.10387.0.camel@mtkswgap22>
Subject: Re: [kbuild] Re: [PATCH v2 1/2] mt76: mt7915: add missing
 capabilities for DBDC
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <kbuild@lists.01.org>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        <lkp@intel.com>, <kbuild-all@lists.01.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 10 Mar 2021 16:54:50 +0800
In-Reply-To: <20210310083018.GH21246@kadam>
References: <20210310083018.GH21246@kadam>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 52A78F482FCA1BF0DDF7F8DA1A1595CE86E8C0FD9664E8A8406C51CE7AFA5D132000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIxLTAzLTEwIGF0IDExOjMwICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBIaSBSeWRlciwNCj4gDQo+IHVybDogICAgaHR0cHM6Ly9naXRodWIuY29tLzBkYXktY2kvbGlu
dXgvY29tbWl0cy9SeWRlci1MZWUvbXQ3Ni1tdDc5MTUtYWRkLW1pc3NpbmctY2FwYWJpbGl0aWVz
LWZvci1EQkRDLzIwMjEwMjI1LTIzMDMyMyANCj4gYmFzZTogICBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9rdmFsby93aXJlbGVzcy1kcml2ZXJzLW5leHQu
Z2l0ICBtYXN0ZXINCj4gY29uZmlnOiB4ODZfNjQtcmFuZGNvbmZpZy1tMDAxLTIwMjEwMzA5IChh
dHRhY2hlZCBhcyAuY29uZmlnKQ0KPiBjb21waWxlcjogZ2NjLTkgKERlYmlhbiA5LjMuMC0yMikg
OS4zLjANCj4gDQo+IElmIHlvdSBmaXggdGhlIGlzc3VlLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0
YWcgYXMgYXBwcm9wcmlhdGUNCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BA
aW50ZWwuY29tPg0KPiBSZXBvcnRlZC1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBv
cmFjbGUuY29tPg0KPiANCj4gc21hdGNoIHdhcm5pbmdzOg0KPiBkcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmM6MzUzIG10NzkxNV9zZXRfc3RyZWFtX3ZodF90
eGJmX2NhcHMoKSBlcnJvcjogcG90ZW50aWFsbHkgZGVyZWZlcmVuY2luZyB1bmluaXRpYWxpemVk
ICdjYXAnLg0KPiANCj4gdmltICsvY2FwICszNTMgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jDQo+IA0KPiAwMGIyZTE2ZTAwNjM5MCBSeWRlciBMZWUgMjAy
MC0wNS0xMiAgMzQ0ICB2b2lkIG10NzkxNV9zZXRfc3RyZWFtX3ZodF90eGJmX2NhcHMoc3RydWN0
IG10NzkxNV9waHkgKnBoeSkNCj4gMDBiMmUxNmUwMDYzOTAgUnlkZXIgTGVlIDIwMjAtMDUtMTIg
IDM0NSAgew0KPiA1MGE2ZmU3OTYyM2UyMiBSeWRlciBMZWUgMjAyMS0wMi0yNSAgMzQ2ICAJaW50
IG5zczsNCj4gNTBhNmZlNzk2MjNlMjIgUnlkZXIgTGVlIDIwMjEtMDItMjUgIDM0NyAgCXUzMiAq
Y2FwOw0KPiA1MGE2ZmU3OTYyM2UyMiBSeWRlciBMZWUgMjAyMS0wMi0yNSAgMzQ4ICANCj4gNTBh
NmZlNzk2MjNlMjIgUnlkZXIgTGVlIDIwMjEtMDItMjUgIDM0OSAgCWlmICghcGh5LT5tdDc2LT5j
YXAuaGFzXzVnaHopDQo+IDUwYTZmZTc5NjIzZTIyIFJ5ZGVyIExlZSAyMDIxLTAyLTI1ICAzNTAg
IAkJcmV0dXJuOw0KPiA1MGE2ZmU3OTYyM2UyMiBSeWRlciBMZWUgMjAyMS0wMi0yNSAgMzUxICAN
Cj4gNTBhNmZlNzk2MjNlMjIgUnlkZXIgTGVlIDIwMjEtMDItMjUgIDM1MiAgCW5zcyA9IGh3ZWln
aHQ4KHBoeS0+bXQ3Ni0+Y2hhaW5tYXNrKTsNCj4gNTBhNmZlNzk2MjNlMjIgUnlkZXIgTGVlIDIw
MjEtMDItMjUgQDM1MyAgCSpjYXAgPSAmcGh5LT5tdDc2LT5zYmFuZF81Zy5zYmFuZC52aHRfY2Fw
LmNhcDsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Xl5eXg0KPiAiY2FwIiBpc24ndCBpbml0aWFsaXplZC4NCg0KVGhpcyBoYXMgYmVlbiBmaXhlZCBp
biB2Mw0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVr
L3BhdGNoLzQyN2FiNWEyYTc5YjhiYmZhMDUyMjVjZmU0Y2ZiNTViM2YxNDNjOGMuMTYxNDM1NzM0
Ni5naXQucnlkZXIubGVlQG1lZGlhdGVrLmNvbS8NCg0KUnlkZXINCg0K

