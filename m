Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426732EC7F5
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Jan 2021 03:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbhAGCLu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Jan 2021 21:11:50 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:40060 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726086AbhAGCLt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Jan 2021 21:11:49 -0500
X-UUID: 6dbc2494557a44629dbc84958c8f4f5d-20210107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=420/pGT6oi1QByXc0WjNI2/geb+r0//1H8JLV8NvGug=;
        b=s4tlDEXgzv5SgfNwWdGEJJA4g+lIxrSs0tulW9ERkIwM7PL2+RAwAVKT4cskI2A10oaK6Py27LYvj77kYc+g4R9ppKvxAKqvpJ1YhvrbrlelUe3VekVuymXIW6Ph4O4nvgbkL9/GtzFK6xuLzDiTdH1mCQO9j2BIVIO2HOAGS8s=;
X-UUID: 6dbc2494557a44629dbc84958c8f4f5d-20210107
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1331681179; Thu, 07 Jan 2021 10:11:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 7 Jan 2021 10:11:01 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Jan 2021 10:11:01 +0800
Message-ID: <1609985461.9743.2.camel@mtkswgap22>
Subject: Re: [PATCH] mac80211: check ATF flag in ieee80211_next_txq()
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 7 Jan 2021 10:11:01 +0800
In-Reply-To: <87k0sq3wfl.fsf@toke.dk>
References: <d9aef825d186a91ff91f6a81045d49d375533b14.1609894402.git.ryder.lee@mediatek.com>
         <87r1my49us.fsf@toke.dk> <68ab89bc-70f4-e822-3d96-21ba3bd6511f@nbd.name>
         <87k0sq3wfl.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIxLTAxLTA2IGF0IDE2OjQxICswMTAwLCBUb2tlIEjDuGlsYW5kLUrDuHJnZW5z
ZW4gd3JvdGU6DQo+IEZlbGl4IEZpZXRrYXUgPG5iZEBuYmQubmFtZT4gd3JpdGVzOg0KPiANCj4g
PiBPbiAyMDIxLTAxLTA2IDExOjUxLCBUb2tlIEjDuGlsYW5kLUrDuHJnZW5zZW4gd3JvdGU6DQo+
ID4+IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4gd3JpdGVzOg0KPiA+PiANCj4g
Pj4+IFRoZSBzZWxlY3RlZCB0eHEgc2hvdWxkIGJlIHNjaGVkdWxlZCB1bmNvbmRpdGlvbmFsbHkg
aWYNCj4gPj4+IE5MODAyMTFfRVhUX0ZFQVRVUkVfQUlSVElNRV9GQUlSTkVTUyBpcyBub3Qgc2V0
IGJ5IGRyaXZlci4NCj4gPj4+DQo+ID4+PiBBbHNvIHB1dCB0aGUgc3RhIHRvIHRoZSBlbmQgb2Yg
dGhlIGFjdGl2ZV90eHFzIGxpc3QgaWYNCj4gPj4+IGRlZmljaXQgaXMgbmVnYXRpdmUgdGhlbiBt
b3ZlIG9uIHRvIHRoZSBuZXh0IHR4cS4NCj4gPj4gDQo+ID4+IFdoeSBpcyB0aGlzIG5lZWRlZD8g
SWYgdGhlIGZlYXR1cmUgaXMgbm90IHNldCwgbm8gYWlydGltZSBzaG91bGQgZXZlciBiZQ0KPiA+
PiBhY2NvdW50ZWQgdG8gdGhlIHN0YXRpb24sIGFuZCBzbyBzdGEtPmFpcnRpbWVbdHhxaS0+dHhx
LmFjXS5kZWZpY2l0IHdpbGwNCj4gPj4gYWx3YXlzIGJlIDAgLSBzbyB5b3UncmUganVzdCBhZGRp
bmcgYW5vdGhlciBjaGVjayB0aGF0IGRvZXNuJ3QgYWN0dWFsbHkNCj4gPj4gY2hhbmdlIHRoZSBi
ZWhhdmlvdXIsIGFyZW4ndCB5b3U/DQo+ID4NCj4gPiBJIHRoaW5rIGl0IG1pZ2h0IG1ha2Ugc2Vu
c2UgdG8ga2VlcCBhaXJ0aW1lIHJlcG9ydGluZyBldmVuIHdoZW4gYWlydGltZQ0KPiA+IGZhaXJu
ZXNzIGlzIGRpc2FibGVkIGF0IHJ1biB0aW1lLCBzbyB0aGlzIHBhdGNoIG1ha2VzIHNlbnNlIHRv
IG1lLg0KPiA+IEluc3RlYWQgb2YgdGhpcyBwYXRjaCwgdGhlIHJpZ2h0IHBsYWNlIHRvIGRlYWwg
d2l0aCB0aGlzIHdvdWxkIHByb2JhYmx5DQo+ID4gYmUgaWVlZTgwMjExX3N0YV9yZWdpc3Rlcl9h
aXJ0aW1lLg0KPiANCj4gV2hlbiB0aGUgZmFpcm5lc3MgbWVjaGFuaXNtIGlzIHVzZXItZGlzYWJs
ZWQgSSBhZ3JlZSBpdCBtYWtlcyBzZW5zZSB0bw0KPiBzdGlsbCBrZWVwIHRoZSBhY2NvdW50aW5n
OyBhbmQgaW4gZmFjdCB0aGF0J3Mgd2hhdA0KPiBpZWVlODAyMTFfc3RhX3JlZ2lzdGVyX2FpcnRp
bWUoKSBhbHJlYWR5IGRvZXMgd2hlbiB0aGUgYWNjb3VudGluZyBpcw0KPiB0dXJuZWQgb2ZmIGJ5
IHdheSBvZiB0aGUgYWlydGltZV9mbGFncyBmaWVsZC4uLiBTbyBkb24ndCB0aGluayBhbnl0aGlu
Zw0KPiBlbHNlIGlzIG5lZWRlZCB0aGVyZSBlaXRoZXI/DQo+IA0KPiAtVG9rZQ0KDQpOb3Qgc3Vy
ZSBJIGdldCB0aGlzIHJpZ2h0LiBBcmUgeW91IHRhbGtpbmcgYWJvdXQgbG9jYWwtPmFpcnRpbWVf
ZmxhZ3MgPQ0KQUlSVElNRV9VU0VfVFggfCBBSVJUSU1FX1VTRV9SWCA/IEkgdGhpbmsgdGhhdCdz
IGRpZmZlcmVudCBhbmQgd2Ugc3RpbGwNCm5lZWQgdG8gdGFrZSBOTDgwMjExX0VYVF9GRUFUVVJF
X0FJUlRJTUVfRkFJUk5FU1MgaW50byBhY2NvdW50LCByaWdodD8NCg0KUnlkZXINCg0K

