Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196F82EB6ED
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Jan 2021 01:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbhAFAgn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 19:36:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37764 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725860AbhAFAgn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 19:36:43 -0500
X-UUID: 2d1e655d25084c2583e546756063987b-20210106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=NNagxy59LWVrpfqGGDlvpcbmrMIVKJXiIdbWKMV2ZLk=;
        b=hkb7VAzjUJ+8LnRkuPGCmfqc3cXptvL7XnjFlWxnIIev9ud8JLF3/UkoeBMxnDipp4KFxAA9RX9niON/bcmvEzUg+pIytJdE0Irgc+QiQOnxXuS67RdTH4EJyIs0DzDxxwA4utn9cy6NZVzwm0QHiQ0bABMiiw5JTEiF2Na7Z0U=;
X-UUID: 2d1e655d25084c2583e546756063987b-20210106
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 613417877; Wed, 06 Jan 2021 08:35:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 Jan 2021 08:35:56 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Jan 2021 08:35:56 +0800
Message-ID: <1609893356.15178.1.camel@mtkswgap22>
Subject: Re: [PATCH] mt76: mt7915: force ldpc for bw larger than 20MHz in
 testmode
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Shayne Chen <shayne.chen@mediatek.com>
CC:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Wed, 6 Jan 2021 08:35:56 +0800
In-Reply-To: <20210105054100.5905-1-shayne.chen@mediatek.com>
References: <20210105054100.5905-1-shayne.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIxLTAxLTA1IGF0IDEzOjQxICswODAwLCBTaGF5bmUgQ2hlbiB3cm90ZToNCj4g
TERQQyBzaG91bGQgYmUgc2V0IHdoZW4gYncgaXMgbGFyZ2VyIHRoYW4gMjBNSHogdG8gbWFrZQ0K
PiB0ZXN0bW9kZSB0eCB3b3JrIG5vcm1hbGx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2hheW5l
IENoZW4gPHNoYXluZS5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWMuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21hYy5jIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFjLmMNCj4gaW5kZXggZGMxZjU2ZmI4
MjNkLi5lODc4N2MzMzZhNTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTE1L21hYy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTE1L21hYy5jDQo+IEBAIC03MDAsNyArNzAwLDcgQEAgbXQ3OTE1X21h
Y193cml0ZV90eHdpX3RtKHN0cnVjdCBtdDc5MTVfcGh5ICpwaHksIF9fbGUzMiAqdHh3aSwNCj4g
IAlpZiAobW9kZSA+PSBNVF9QSFlfVFlQRV9IRV9TVSkNCj4gIAkJdmFsIHw9IEZJRUxEX1BSRVAo
TVRfVFhENl9IRUxURiwgdGQtPnR4X2x0Zik7DQo+ICANCj4gLQlpZiAodGQtPnR4X3JhdGVfbGRw
YykNCj4gKwlpZiAodGQtPnR4X3JhdGVfbGRwYyB8fCBidyA+IDApDQoNClByZWZlciBleHBsaWNp
dGx5IGNoZWNraW5nIGJ3ID4gSUVFRTgwMjExX1NUQV9SWF9CV18yMA0KDQo+ICAJCXZhbCB8PSBN
VF9UWEQ2X0xEUEM7DQo+ICANCj4gIAl0eHdpWzZdIHw9IGNwdV90b19sZTMyKHZhbCk7DQoNClJ5
ZGVyDQoNCg==

