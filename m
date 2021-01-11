Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4272F0CCD
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jan 2021 07:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbhAKGUC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 01:20:02 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46254 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726008AbhAKGUB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 01:20:01 -0500
X-UUID: 94bd96e1fd7348f9bba859224c96e3f8-20210111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=hbUjx36G0lGh66Y/uyRkKQdmOZUnPTwRubcK5li375o=;
        b=tUWFAFTrtAgfEAHdnobjcdKW9a2Fsn5m+oS7yx9vBMthTRBwADrqfb2tD+86cng/3wi66ySFWewVCAFqA/ExonB8RaxQ3bgXHTJ96DeOm+UBHlkKKnVij7dX440D5vxY7r3Tjyp1QcuR4EhCvdu5szgYhdiM4gp4Rw+4z7RF8BA=;
X-UUID: 94bd96e1fd7348f9bba859224c96e3f8-20210111
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 577770196; Mon, 11 Jan 2021 14:19:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 14:19:13 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 14:19:14 +0800
Message-ID: <1610345954.4985.7.camel@mtksdccf07>
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
Date:   Mon, 11 Jan 2021 14:19:14 +0800
In-Reply-To: <0efec65815ff9e26b3da69cb35d503a90086760c.camel@sipsolutions.net>
References: <20210108105643.10834-1-shayne.chen@mediatek.com>
         <0efec65815ff9e26b3da69cb35d503a90086760c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIxLTAxLTA4IGF0IDIxOjAyICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBUaGlzIGxvb2tzIHdyb25nIHRvIG1lLCBhbSBJIG1pc3Npbmcgc29tZXRoaW5nPw0KPiANCj4g
PiBkaWZmIC0tZ2l0IGEvbmV0L21hYzgwMjExL2RlYnVnZnMuYyBiL25ldC9tYWM4MDIxMS9kZWJ1
Z2ZzLmMNCj4gPiBpbmRleCA5MTM1YjZmLi45OTkxYTZhIDEwMDY0NA0KPiA+IC0tLSBhL25ldC9t
YWM4MDIxMS9kZWJ1Z2ZzLmMNCj4gPiArKysgYi9uZXQvbWFjODAyMTEvZGVidWdmcy5jDQo+ID4g
QEAgLTEyMCw3ICsxMjAsNiBAQCBzdGF0aWMgc3NpemVfdCBhcW1fd3JpdGUoc3RydWN0IGZpbGUg
KmZpbGUsDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBpZWVlODAyMTFfbG9jYWwgKmxvY2FsID0gZmls
ZS0+cHJpdmF0ZV9kYXRhOw0KPiA+ICAJY2hhciBidWZbMTAwXTsNCj4gPiAtCXNpemVfdCBsZW47
DQo+ID4gIA0KPiA+ICAJaWYgKGNvdW50ID4gc2l6ZW9mKGJ1ZikpDQo+ID4gIAkJcmV0dXJuIC1F
SU5WQUw7DQo+IA0KPiBUaGlzIGVuc3VyZXMgdGhhdCBjb3VudCA8PSBzaXplb2YoYnVmKQ0KPiAN
Cj4gPiBAQCAtMTI4LDEwICsxMjcsMTAgQEAgc3RhdGljIHNzaXplX3QgYXFtX3dyaXRlKHN0cnVj
dCBmaWxlICpmaWxlLA0KPiA+ICAJaWYgKGNvcHlfZnJvbV91c2VyKGJ1ZiwgdXNlcl9idWYsIGNv
dW50KSkNCj4gPiAgCQlyZXR1cm4gLUVGQVVMVDsNCj4gDQo+IFdlIGNvcHksIHRoYXQncyBmaW5l
Lg0KPiAgDQo+ID4gLQlidWZbc2l6ZW9mKGJ1ZikgLSAxXSA9ICdcMCc7DQo+ID4gLQlsZW4gPSBz
dHJsZW4oYnVmKTsNCj4gPiAtCWlmIChsZW4gPiAwICYmIGJ1ZltsZW4tMV0gPT0gJ1xuJykNCj4g
PiAtCQlidWZbbGVuLTFdID0gMDsNCj4gPiArCWlmIChjb3VudCAmJiBidWZbY291bnQgLSAxXSA9
PSAnXG4nKQ0KPiA+ICsJCWJ1Zltjb3VudCAtIDFdID0gJ1wwJzsNCj4gDQo+IFRoaXMgSSB0aGlu
ayByZWFsbHkgd2FzIG1lYW50IGFzIHN0cmxlbiwgYmVjYXVzZSBpZiB5b3Ugd3JpdGUgc29tZXRo
aW5nDQo+IGxpa2UNCj4gDQo+ICAxMFxuXDBcMFwwXDANCj4gDQo+IGJlZm9yZSBpdCB3b3VsZCBo
YXZlIHBhcnNlZCBpdCBhcyAxMCBzdGlsbCwgbm93IGl0IGdldHMgY29uZnVzZWQ/DQo+IA0KPiBJ
IGd1ZXNzIEknbSBub3Qgd29ycmllZCBhYm91dCB0aGF0IHRob3VnaC4NCj4gDQpIaSBKb2hhbm5l
cywNCg0KUmVnYXJkaW5nIHRoZSBjYXNlICIxMFxuXDBcMFwwXDAiLCBib3RoIGNvdW50IGFuZCBz
dHJsZW4oKSBmYWlsIHRvIGdldA0KdGhlIGNvcnJlY3Qgc3RybGVuLg0KIyBlY2hvICIxMFxuXDBc
MFwwXDAiID4gL3N5cy9rZXJuZWwvZGVidWcvaWVlZTgwMjExL3BoeTAvYWlydGltZV9mbGFncw0K
YWlydGltZV9mbGFnc193cml0ZTogY291bnQgPSAxMywgc3RybGVuID0gMTUgDQo+ID4gKwlidWZb
Y291bnRdID0gJ1wwJzsNCj4gDQo+IEJ1dCBpZiBjb3VudCA9PSBzaXplb2YoYnVmKSB0aGVuIHRo
aXMgaXMgYW4gb3V0LW9mLWJvdW5kcyB3cml0ZS4NCj4gDQo+IFNhbWUgZm9yIGFsbCB0aGUgb3Ro
ZXIgY29waWVkIGluc3RhbmNlcy4NCj4gDQo+IGpvaGFubmVzDQo+IA0KDQpTaG91bGQgd2UgY29u
c2lkZXIgdGhpcyBraW5kIG9mIGNhc2UgaGVyZT8NCklmIHllcywgbWF5YmUgd2UgbmVlZCB0byB1
c2Ugc3NjYW5mKCkgYXMgb3RoZXIgLndyaXRlIHRvIHRha2UgY2FyZSBvZg0KdGhpcyBraW5kIG9m
IGNhc2UsIHNpbmNlIGtzdHJ0b3UxNigpIHdpbGwgYWxzbyBmYWlsIG9uIHRoaXMgY2FzZS4NCg0K
QnR3LCBzb21lIG9mIHN0cmxlbiBpbiBvdGhlciAud3JpdGUgYXJlIGFsc28gaW5jb3JyZWN0LCBi
dXQgdGhleSB3b24ndA0KZ2V0IHRoZSBwcm9ibGVtIGR1ZSB0byBzc2NhbmYoKS4NCg0KRG8geW91
IHByZWZlciB0aGF0IHdlIGFsc28gdXNlIHNzY2FuZigpIGluIC53cml0ZSBvZiBhaXJ0aW1lX2Zs
YWdzPw0KDQpTaGF5bmUNCg==

