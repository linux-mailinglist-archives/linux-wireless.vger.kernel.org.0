Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC133135CB
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 15:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhBHO43 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 09:56:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:41049 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233108AbhBHOyo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 09:54:44 -0500
X-UUID: 53ae64c1e0ba416ab3f1396333a72b0f-20210208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=X2CdT3h2aCEflLRIVjhcK/OFaSLMOm98PChkcfUCSBM=;
        b=hHvQOgXXdmp+EG1ncFJywVbS/t8VZptU6odvOckC/PcTO4C/feWpIb9EFPcKsn6MvnbChf8bqjppMd6kQVcWwxOarx48gaThLHBNNy4uhWuexYmtNJmZq2DZTZoe0qobDf/tD85TzwgRIv1cp5cnBSmRBPw/WZmusIM1qtmiBjQ=;
X-UUID: 53ae64c1e0ba416ab3f1396333a72b0f-20210208
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 344770172; Mon, 08 Feb 2021 22:53:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Feb 2021 22:53:53 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Feb 2021 22:53:53 +0800
Message-ID: <1612796033.13185.5.camel@mtkswgap22>
Subject: Re: [PATCH] mac80211: only schedule TXQ when reasonable airtime
 reporting
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 8 Feb 2021 22:53:53 +0800
In-Reply-To: <1612665675.2364.43.camel@mtkswgap22>
References: <c48c3555ab2261d6b6674ac7de8203359b80b127.1612529311.git.ryder.lee@mediatek.com>
         <878s82ve1c.fsf@toke.dk> <1612665675.2364.43.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0BE62A6312E758FAC2090BBE2C4777B0A1A76458C17EF0742AC248A3F99B8CC42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU3VuLCAyMDIxLTAyLTA3IGF0IDEwOjQxICswODAwLCBSeWRlciBMZWUgd3JvdGU6DQo+IE9u
IEZyaSwgMjAyMS0wMi0wNSBhdCAxNDoyOSArMDEwMCwgVG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu
IHdyb3RlOg0KDQo+ID4gPiBAQCAtMzc3MCw2ICszNzcwLDEwIEBAIHN0cnVjdCBpZWVlODAyMTFf
dHhxICppZWVlODAyMTFfbmV4dF90eHEoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHU4IGFjKQ0K
PiA+ID4gIAkJCQlzdGEtPmFpcnRpbWVfd2VpZ2h0Ow0KPiA+ID4gIA0KPiA+ID4gIAkJaWYgKGRl
ZmljaXQgPCAwIHx8ICFhcWxfY2hlY2spIHsNCj4gPiA+ICsJCQlpZiAodHhxaS0+c2NoZWR1bGVf
cm91bmQgPT0gbG9jYWwtPnNjaGVkdWxlX3JvdW5kW2FjXSkNCj4gPiA+ICsJCQkJZ290byBvdXQ7
DQo+ID4gPiArDQo+ID4gPiArCQkJdHhxaS0+c2NoZWR1bGVfcm91bmQgPSBsb2NhbC0+c2NoZWR1
bGVfcm91bmRbYWNdOw0KPiA+IA0KPiA+IEkgdGhpbmsgdGhpcyBjaGFuZ2UgbWF5IGJlIHdvcnRo
IG1ha2luZyBhbnl3YXksIGJ1dCBmb3IgYSBkaWZmZXJlbnQNCj4gPiByZWFzb246IFdpdGhvdXQg
aXQsIGEgc3RhdGlvbiB0aGF0IGZhaWxzIGFxbF9jaGVjayB3aWxsIGtlZXAgZ2V0dGluZw0KPiA+
IHJlY3ljbGVkIHRocm91Z2ggdGhlIGxpc3QsIGFkdmFuY2luZyBpdHMgZGVmaWNpdC4gV2hpY2gg
Y291bGQgYWN0dWFsbHkNCj4gPiBiZSB0aGUgcmVhc29uIEFRTCBicmVha3MgYWlydGltZSBmYWly
bmVzczsgZGlkIHlvdSBvYnNlcnZlIGFueQ0KPiA+IGRpZmZlcmVuY2UgaW4gZmFpcm5lc3Mgd2l0
aCB0aGlzIGNoYW5nZT8NCj4gDQo+IE91ciBjYXNlIGlzOiBtdDc5MTUgcHJvdmlkZXMgcGVyLXBl
ZXIgYWlydGltZSBjb3VudGVycy4gSG93ZXZlciwgc29tZSBvZg0KPiB0aGVtIHdlcmUgbm90IHBy
b3Blcmx5IGNvbmZpZ3VyZWQsIHNvIGNlcnRhaW4gc3RhdGlvbnMgcmVwb3J0ZWQgbGFyZ2UNCj4g
YW1vdW50IG9mIGFpcnRpbWUgd2hpY2ggbGVkIHRvIGRlZmljaXQgPCAwLCBhbmQgYXMgeW91IHNh
aWQsIGVuZGluZyB1cA0KPiB3aXRoIHJlY3ljbGUgKyB2ZXJ5IGxvbmdlciBsb2NrIGhvbGQgdGlt
ZSAoMC45cyBpbiBvdXIgdGVzdHMpIGFuZA0KPiBicmVha2luZyBmYWlybmVzcy4NCj4gDQo+IA0K
Rm91bmQgYSBwcm9ibGVtIHdoZW4gd2UgYXJlIGluIGxvdyB0cmFmZmljIHdpdGggdGhpcyBwYXRj
aC5UaGlzIHdpbGwNCmluY3JlYXNlIGxhdGVuY3kgKGkuZSBwaW5nKQ0KDQoNClNvLCB3ZSBoYXZl
IHRvDQoNCglpZiAoZGVmaWNpdCA8IDAgfHwgIWFxbF9jaGVjaykgew0KCQlpZiAodHhxaS0+c2No
ZWR1bGVfcm91bmQgPT0gbG9jYWwtPnNjaGVkdWxlX3JvdW5kW2FjXSkNCgkJCS8vIHJlLXNjaGVk
dWxlDQoJCQlnb3RvIG91dDsNCgkJCS4uLi4NCgl9DQp9DQoNCmlmICh0eHFpLT5zY2hlZHVsZV9y
b3VuZCA9PSBsb2NhbC0+c2NoZWR1bGVfcm91bmRbYWNdKQ0KCS8vIHJlLXNjaGVkdWxlDQoJZ290
byBvdXQ7DQoNClJ5ZGVyDQo=

