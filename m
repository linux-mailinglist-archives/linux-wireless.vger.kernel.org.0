Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8452C2F25A6
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jan 2021 02:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbhALBnT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 20:43:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45582 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726837AbhALBnT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 20:43:19 -0500
X-UUID: a6368c3d9feb46fdb519a0813217d334-20210112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ZSNLc9PihXO6nuOHATGPf5myu+2eUyDH8fhV6ZmKRZo=;
        b=T+F4bi2v1/FRrc6dZtq9W6TfUcWdz7QGspkVCEXJ7BWEIR7VQIM59UvjAy3ybTTeploLEeVfUvNDFg5qB8q0+5lfm6Sx50O3ueS791Ho7mhbIkK7BHniLGfhbc2qz+yQjbe7jrZmIYTIWcOTBwQ9Q9WM45PsKE/da6kZh+q3vAI=;
X-UUID: a6368c3d9feb46fdb519a0813217d334-20210112
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1272495569; Tue, 12 Jan 2021 09:42:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 12 Jan 2021 09:42:32 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Jan 2021 09:42:32 +0800
Message-ID: <1610415752.4985.16.camel@mtksdccf07>
Subject: Re: [PATCH] mac80211: fix incorrect strlen of .write in debugfs
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Date:   Tue, 12 Jan 2021 09:42:32 +0800
In-Reply-To: <036e334c2a0a2ebaf940d3f7ae03ab0d9f7c45fb.camel@sipsolutions.net>
References: <20210108105643.10834-1-shayne.chen@mediatek.com>
         <0efec65815ff9e26b3da69cb35d503a90086760c.camel@sipsolutions.net>
         <1610345954.4985.7.camel@mtksdccf07>
         <036e334c2a0a2ebaf940d3f7ae03ab0d9f7c45fb.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2A3869795AF4D62E00F733F95164FA99692B98361A0380456F173D3EC3EA12832000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIxLTAxLTExIGF0IDEzOjEwICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBPbiBNb24sIDIwMjEtMDEtMTEgYXQgMTQ6MTkgKzA4MDAsIFNoYXluZSBDaGVuIHdyb3RlOg0K
PiA+IA0KPiA+IFJlZ2FyZGluZyB0aGUgY2FzZSAiMTBcblwwXDBcMFwwIiwgYm90aCBjb3VudCBh
bmQgc3RybGVuKCkgZmFpbCB0byBnZXQNCj4gPiB0aGUgY29ycmVjdCBzdHJsZW4uDQo+IA0KPiBZ
ZWFoLg0KPiANCj4gSSBkb24ndCB0aGluayB3ZSBuZWVkIHRvIHdvcnJ5IGFib3V0IHRoaXMgY2Fz
ZS4NCj4gDQpHb3QgaXQuDQo+ID4gIyBlY2hvICIxMFxuXDBcMFwwXDAiID4gL3N5cy9rZXJuZWwv
ZGVidWcvaWVlZTgwMjExL3BoeTAvYWlydGltZV9mbGFncw0KPiA+IGFpcnRpbWVfZmxhZ3Nfd3Jp
dGU6IGNvdW50ID0gMTMsIHN0cmxlbiA9IDE1IA0KPiA+ID4gPiArCWJ1Zltjb3VudF0gPSAnXDAn
Ow0KPiA+ID4gDQo+ID4gPiBCdXQgaWYgY291bnQgPT0gc2l6ZW9mKGJ1ZikgdGhlbiB0aGlzIGlz
IGFuIG91dC1vZi1ib3VuZHMgd3JpdGUuDQo+ID4gPiANCj4gPiA+IFNhbWUgZm9yIGFsbCB0aGUg
b3RoZXIgY29waWVkIGluc3RhbmNlcy4NCj4gPiA+IA0KPiA+ID4gam9oYW5uZXMNCj4gPiA+IA0K
PiA+IA0KPiA+IFNob3VsZCB3ZSBjb25zaWRlciB0aGlzIGtpbmQgb2YgY2FzZSBoZXJlPw0KPiAN
Cj4gU3VyZSwgd2UncmUgYXQgdGhlIGtlcm5lbC91c2Vyc3BhY2UgdHJ1c3QgYm91bmRhcnksIHdl
IGNhbid0IGp1c3QgcmVhZA0KPiBvdXQtb2YtYm91bmRzPyBPciB3aGF0IGRvIHlvdSBtZWFuPw0K
PiANCj4gam9oYW5uZXMNCj4gDQo+IA0KDQpTb3JyeSwgSSBwdXQgdGhlIHJlcGx5IGluIGEgd3Jv
bmcgcGxhY2UuDQpJIG1lYW50IHNob3VsZCB3ZSBjb25zaWRlciB0aGUgY2FzZSAiMTBcblwwXDBc
MFwwIiBoZXJlLg0KDQpXaWxsIHNlbmQgdjIsIHRoYW5rIHlvdS4NCg0KU2hheW5lDQo=

