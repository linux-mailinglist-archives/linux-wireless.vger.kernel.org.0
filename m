Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED542EFC18
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Jan 2021 01:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbhAIAXD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jan 2021 19:23:03 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:34458 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725872AbhAIAXD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jan 2021 19:23:03 -0500
X-UUID: 2087cc9e142449a1a487af29da6a1889-20210109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=7CYUlKecezZ1BJCyWACsMHG9HSdAtzLwoRJDZJLvlmg=;
        b=EE1lsKQzli67viq9PmMnk8mcQizuxp5/LSQ6t0dhVoH2AHSULATmxaaZI66AsF9lq+7yVIoVOvY37OG71mk1zwR1+nPohCTa152KZfBmPJgSD7wnn9nJjLW+YyV7f4Uz0R1G7uo+2CQsiWlgALvimfvgWUHJWcRHwAE76AdmGUE=;
X-UUID: 2087cc9e142449a1a487af29da6a1889-20210109
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 693531631; Sat, 09 Jan 2021 08:22:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 9 Jan 2021 08:22:13 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 Jan 2021 08:22:13 +0800
Message-ID: <1610151733.9343.3.camel@mtkswgap22>
Subject: Re: [PATCH] mac80211: fix incorrect strlen of .write in debugfs
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Felix Fietkau <nbd@nbd.name>
Date:   Sat, 9 Jan 2021 08:22:13 +0800
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
IGd1ZXNzIEknbSBub3Qgd29ycmllZCBhYm91dCB0aGF0IHRob3VnaC4NCg0KSSB0aGluayB0aGUg
cHJvYmxlbSBvbmx5IGhhcHBlbnMgb24gYWlydGltZV9mbGFnc193cml0ZSgpIHRoYXQgdXNlcw0K
a3N0cnRvdTE2KCkNCg0KDQo+ID4gKwlidWZbY291bnRdID0gJ1wwJzsNCj4gDQo+IEJ1dCBpZiBj
b3VudCA9PSBzaXplb2YoYnVmKSB0aGVuIHRoaXMgaXMgYW4gb3V0LW9mLWJvdW5kcyB3cml0ZS4N
Cg0KUmlnaHQuIFRoZW4sIHdlIGNhbg0KDQogCWlmIChjb3VudCA+PSBzaXplb2YoYnVmKSkNCgkJ
cmV0dXJuIC1FSU5WQUw7DQoNClJ5ZGVyDQoNCg0KDQo=

