Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E302EBD52
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Jan 2021 12:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbhAFLu5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Jan 2021 06:50:57 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:38435 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbhAFLu5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Jan 2021 06:50:57 -0500
X-UUID: 4c39aa1ff93e41c3b29d27278223d7c1-20210106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=NihNZqEfwG1aa8bZzu9bqcHanSugnqCQ6/bD5Qvfqxc=;
        b=toIF0Xsd6o0oYVtTeQi9hD0Y0ZiJPhpC9RvJeMgqtR0YoSRk5gECZ7/TK/EQTRzeHYPyHxLjBD8gGisGdYkbFjKZJGs5EUzHNH2StSLDkQfhA9VeID45Jioa2UhPOX6NWnjnzQCv9kQDNTe41rxinYBJe1ASJzXXbl1BNXNeF5o=;
X-UUID: 4c39aa1ff93e41c3b29d27278223d7c1-20210106
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 614193415; Wed, 06 Jan 2021 19:50:13 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 Jan 2021 19:50:11 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Jan 2021 19:50:11 +0800
Message-ID: <1609933811.10416.1.camel@mtkswgap22>
Subject: Re: [PATCH] mac80211: check ATF flag in ieee80211_next_txq()
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 6 Jan 2021 19:50:11 +0800
In-Reply-To: <87r1my49us.fsf@toke.dk>
References: <d9aef825d186a91ff91f6a81045d49d375533b14.1609894402.git.ryder.lee@mediatek.com>
         <87r1my49us.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIxLTAxLTA2IGF0IDExOjUxICswMTAwLCBUb2tlIEjDuGlsYW5kLUrDuHJnZW5z
ZW4gd3JvdGU6DQo+IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4gd3JpdGVzOg0K
PiANCj4gPiBUaGUgc2VsZWN0ZWQgdHhxIHNob3VsZCBiZSBzY2hlZHVsZWQgdW5jb25kaXRpb25h
bGx5IGlmDQo+ID4gTkw4MDIxMV9FWFRfRkVBVFVSRV9BSVJUSU1FX0ZBSVJORVNTIGlzIG5vdCBz
ZXQgYnkgZHJpdmVyLg0KPiA+DQo+ID4gQWxzbyBwdXQgdGhlIHN0YSB0byB0aGUgZW5kIG9mIHRo
ZSBhY3RpdmVfdHhxcyBsaXN0IGlmDQo+ID4gZGVmaWNpdCBpcyBuZWdhdGl2ZSB0aGVuIG1vdmUg
b24gdG8gdGhlIG5leHQgdHhxLg0KPiANCj4gV2h5IGlzIHRoaXMgbmVlZGVkPyBJZiB0aGUgZmVh
dHVyZSBpcyBub3Qgc2V0LCBubyBhaXJ0aW1lIHNob3VsZCBldmVyIGJlDQo+IGFjY291bnRlZCB0
byB0aGUgc3RhdGlvbiwgYW5kIHNvIHN0YS0+YWlydGltZVt0eHFpLT50eHEuYWNdLmRlZmljaXQg
d2lsbA0KPiBhbHdheXMgYmUgMCAtIHNvIHlvdSdyZSBqdXN0IGFkZGluZyBhbm90aGVyIGNoZWNr
IHRoYXQgZG9lc24ndCBhY3R1YWxseQ0KPiBjaGFuZ2UgdGhlIGJlaGF2aW91ciwgYXJlbid0IHlv
dT8NCj4gDQo+IC1Ub2tlDQoNCllvdSdyZSByaWdodC4gSSB0aGluayB0aGUgcHJvYmxlbSBpcyB3
ZSBzdGlsbCBjYWxsDQppZWVlODAyMTFfc3RhX3JlZ2lzdGVyX2FpcnRpbWUoKSBpbiBkcml2ZXIg
ZXZlbiBpZiBmZWF0dXJlIGlzIG5vdCBzZXQsDQphbmQgdGhhdCBtYWtlcyBkZWZpY2l0IDwgMC4g
V2lsbCBmaXggaXQgaW4gZHJpdmVyLg0KDQpSeWRlcg0KDQo=

