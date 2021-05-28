Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F8E393B39
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 03:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhE1Bz7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 May 2021 21:55:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45382 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235016AbhE1Bz6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 May 2021 21:55:58 -0400
X-UUID: 788495487c0e4ec88cad316f4ff01855-20210528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=oGHE8PMIoslcSlajowrXXBL8ZEp8fdbfLBIkED372ag=;
        b=tEhF2RoOLtYrKh803zOIhsL0tBKt7zOeWAlWASXX3uqg1Ul/NYU+a0IZv2Hf1LFWktaBT4RxdE0uSYr0Ts4FmtO/gpYxLn2nLq3JSFoiV0D7tcTmXus9gFeAtyqMzTL4iAZ+C1m7S7mTNGEeHtPSjB/QNTSbqIT8f4u2tDaSi+A=;
X-UUID: 788495487c0e4ec88cad316f4ff01855-20210528
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2021327913; Fri, 28 May 2021 09:54:21 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 May 2021 09:54:19 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 May 2021 09:54:19 +0800
Message-ID: <1622166859.31294.2.camel@mtkswgap22>
Subject: Re: [RFC PATCH 2/4] mac80211: minstrel_ht: fix minstrel_aggr_check
 for encap offload
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 28 May 2021 09:54:19 +0800
In-Reply-To: <47f9c5c2a9c5fd666751e01799a9a167d8776a49.camel@sipsolutions.net>
References: <a959135d3fe21118f38c33fc9ffb18124c1ef7ce.1621453091.git.ryder.lee@mediatek.com>
         <4e50d38c98c407825c6897a034fee3ba6366b0ad.1621453091.git.ryder.lee@mediatek.com>
         (sfid-20210519_215642_904470_7AA3F138)
 <47f9c5c2a9c5fd666751e01799a9a167d8776a49.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIxLTA1LTI1IGF0IDE1OjAwICswMjAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBPbiBUaHUsIDIwMjEtMDUtMjAgYXQgMDM6NTYgKzA4MDAsIFJ5ZGVyIExlZSB3cm90ZToNCj4g
PiANCj4gPiArCWlmICghKGluZm8tPmZsYWdzICYgSUVFRTgwMjExX1RYX0NUTF9IV184MDIxMV9F
TkNBUCkgJiYNCj4gPiArCSAgICB1bmxpa2VseSghaWVlZTgwMjExX2lzX2RhdGFfcW9zKGhkci0+
ZnJhbWVfY29udHJvbCkpKQ0KPiA+ICAJCXJldHVybjsNCj4gDQo+IFRoYXQgdW5saWtlbHkoKSBw
bGFjZW1lbnQgc2VlbXMgb2RkPw0KPiANCj4gam9oYW5uZXMNCj4gDQoNCg0KDQpJIHRob3VnaHQg
YWJvdXQNCglpZiAodW5saWtlbHkoIShpbmZvLT5mbGFncyAmIElFRUU4MDIxMV9UWF9DVExfSFdf
ODAyMTFfRU5DQVApICYmDQoJICAgICFpZWVlODAyMTFfaXNfZGF0YV9xb3MoaGRyLT5mcmFtZV9j
b250cm9sKSkpDQoNCi4uLnVudGlsIEkgZm91bmQgYSBzaW1pbGlhciBjYXNlIGluIGllZWU4MDIx
MV9nZXRfdHhxLCBzbyBJIGtlcHQgaXQgaW4NCnRoYXQgd2F5Lg0KDQpSeWRlcg0K

