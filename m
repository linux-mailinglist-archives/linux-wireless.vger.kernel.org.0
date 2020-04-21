Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC581B1E72
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 07:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgDUF55 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 01:57:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34175 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbgDUF55 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 01:57:57 -0400
X-UUID: c6589aebde574df99628fa38c1032a99-20200421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=yD/NRJAM1wcixHyAPN6Ipx8fiEBnqXvyN97IIJeNFK4=;
        b=GpRWvTy8Xrf3OtNydz++O1tSxWbi88LYSOJFhhyUQQDoPQ4RPLh6s4Is88BBh134tlYpbZYfssRSBBUyh7YPMppZIEi5hObegtAFPQkSTiUHSCYrI+LJujUbDMXJxWOqSaQzBoH+Z3CxBCLEmACoKEo9qj6+zdlmO5J+RNYkAwo=;
X-UUID: c6589aebde574df99628fa38c1032a99-20200421
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1975207488; Tue, 21 Apr 2020 13:57:55 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 21 Apr 2020 13:57:52 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Apr 2020 13:57:51 +0800
Message-ID: <1587448674.12853.1.camel@mtkswgap22>
Subject: Re: [PATCH 2/3] mt76: mt7615: add missing code for providing aid
 info to the mcu
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <sean.wang@mediatek.com>
CC:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Soul Huang" <Soul.Huang@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Tue, 21 Apr 2020 13:57:54 +0800
In-Reply-To: <0292e088e934199434f0ea06598274f57a24f3d9.1587445885.git.sean.wang@mediatek.com>
References: <1467d47fd111b5711fa74410833153bdc9e01b72.1587445885.git.sean.wang@mediatek.com>
         <0292e088e934199434f0ea06598274f57a24f3d9.1587445885.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTIxIGF0IDEzOjIwICswODAwLCBzZWFuLndhbmdAbWVkaWF0ZWsuY29t
IHdyb3RlOg0KPiBGcm9tOiBTZWFuIFdhbmcgPHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+DQo+IA0K
PiBQYXJhbWV0ZXJzIGluIHN0YXRpb24gcmVjb3JkIHNob3VsZCBiZSBrZXB0IGFzIHVwIHRvIGRh
dGUgYXMgQlNTIGJlaW5nDQo+IHVwZGF0ZWQuDQo+IA0KPiBGaXhlczogYTkwYjRiYTFmMTM0ICgi
bXQ3NjogbXQ3NjE1OiBwcm92aWRlIGFpZCBpbmZvIHRvIHRoZSBtY3UiKQ0KPiBTdWdnZXN0ZWQt
Ynk6IFlGIEx1byA8WWYuTHVvQG1lZGlhdGVrLmNvbT4NCj4gU3VnZ2VzdGVkLWJ5OiBMdWN5IEhz
dSA8THVjeS5Ic3VAbWVkaWF0ZWsuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IFNvdWwgSHVhbmcg
PFNvdWwuSHVhbmdAbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTb3VsIEh1YW5nIDxT
b3VsLkh1YW5nQG1lZGlhdGVrLmNvbT4NCj4gQ28tZGV2ZWxvcGVkLWJ5OiBMb3JlbnpvIEJpYW5j
b25pIDxsb3JlbnpvQGtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IExvcmVuem8gQmlhbmNv
bmkgPGxvcmVuem9Aa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBXYW5nIDxzZWFu
LndhbmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3NjE1L21haW4uYyB8IDE1ICsrKysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWFpbi5jIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWFpbi5jDQo+IGluZGV4IGNk
YzhiYWJjYTg1YS4uZTUwMTJhZDY4MGJiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWFpbi5jDQo+IEBAIC00OTcsOSArNDk3LDE5IEBA
IHN0YXRpYyB2b2lkIG10NzYxNV9ic3NfaW5mb19jaGFuZ2VkKHN0cnVjdCBpZWVlODAyMTFfaHcg
Kmh3LA0KPiAgDQo+ICAJbXV0ZXhfbG9jaygmZGV2LT5tdDc2Lm11dGV4KTsNCj4gIA0KPiAtCWlm
IChjaGFuZ2VkICYgQlNTX0NIQU5HRURfQVNTT0MpDQo+ICsJaWYgKGNoYW5nZWQgJiBCU1NfQ0hB
TkdFRF9BU1NPQykgew0KPiArCQlzdHJ1Y3QgaWVlZTgwMjExX3N0YSAqc3RhOw0KPiArDQo+ICAJ
CW10NzYxNV9tY3VfYWRkX2Jzc19pbmZvKHBoeSwgdmlmLCBpbmZvLT5hc3NvYyk7DQo+ICANCj4g
KwkJcmN1X3JlYWRfbG9jaygpOw0KPiArCQlzdGEgPSBpZWVlODAyMTFfZmluZF9zdGEodmlmLCB2
aWYtPmJzc19jb25mLmJzc2lkKTsNCj4gKwkJcmN1X3JlYWRfdW5sb2NrKCk7DQo+ICsNCj4gKwkJ
aWYgKHN0YSkNCj4gKwkJCW10NzYxNV9tY3Vfc3RhX2FkZChkZXYsIHZpZiwgc3RhLCBpbmZvLT5h
c3NvYyk7DQo+ICsJfQ0KPiArDQpob3cgYWJvdXQgdGhpcyAtDQpodHRwczovL2dpdGh1Yi5jb20v
cnlkZXJsZWUxMTEwL3dpcmVsZXNzL2Jsb2IvbXQ3Ni9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9tYWluLmMjTDQzNA0KDQo+ICAJaWYgKGNoYW5nZWQgJiBCU1NfQ0hB
TkdFRF9FUlBfU0xPVCkgew0KPiAgCQlpbnQgc2xvdHRpbWUgPSBpbmZvLT51c2Vfc2hvcnRfc2xv
dCA/IDkgOiAyMDsNCj4gIA0KPiBAQCAtNTU3LDcgKzU2Nyw4IEBAIGludCBtdDc2MTVfbWFjX3N0
YV9hZGQoc3RydWN0IG10NzZfZGV2ICptZGV2LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0K
PiAgCW10NzYxNV9tYWNfd3RibF91cGRhdGUoZGV2LCBpZHgsDQo+ICAJCQkgICAgICAgTVRfV1RC
TF9VUERBVEVfQURNX0NPVU5UX0NMRUFSKTsNCj4gIA0KPiAtCW10NzYxNV9tY3Vfc3RhX2FkZChk
ZXYsIHZpZiwgc3RhLCB0cnVlKTsNCj4gKwlpZiAodmlmLT50eXBlICE9IE5MODAyMTFfSUZUWVBF
X1NUQVRJT04pDQo+ICsJCW10NzYxNV9tY3Vfc3RhX2FkZChkZXYsIHZpZiwgc3RhLCB0cnVlKTsN
Cj4gIA0KPiAgCXJldHVybiAwOw0KPiAgfQ0KDQo=

