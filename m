Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57611A76EB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 11:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437359AbgDNJFL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 05:05:11 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51738 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2437356AbgDNJFL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 05:05:11 -0400
X-UUID: 62d31ce0bfef4b3db948251a20ddc61a-20200414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=E2YXqcVUBYLwN+oDjZ+Fv4snODg16/Q+ovfIm0S+RF8=;
        b=DYqOHGZhVkS5P4p6+0edpcRtwvwmjvygIHhcG5w41LLXajFjzxuEmICYc2EED8JDa1YAhNw6ig6peArHy9nepPDP51E+xWEUegwhWOMSJzfc4kYXikkXl56zZ4mlxNpEMbxRyAnVCgH5jWT6Z3psbrnsC1NEJsx6IuJhA2VxVKk=;
X-UUID: 62d31ce0bfef4b3db948251a20ddc61a-20200414
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1335367022; Tue, 14 Apr 2020 17:05:07 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Apr 2020 17:05:06 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Apr 2020 17:05:04 +0800
Message-ID: <1586855106.32428.5.camel@mtkswgap22>
Subject: Re: [PATCH 06/16] mt76: add mac80211 driver for MT7915 PCIe-based
 chipsets
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>, YF Luo <yf.luo@mediatek.com>,
        Chih-Min Chen <chih-min.chen@mediatek.com>,
        "Yiwei Chung" <yiwei.chung@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Felix Fietkau <nbd@nbd.name>,
        Shayne Chen <shayne.chen@mediatek.com>
Date:   Tue, 14 Apr 2020 17:05:06 +0800
In-Reply-To: <87mu7elgi1.fsf@tynnyri.adurom.net>
References: <cover.1586507878.git.ryder.lee@mediatek.com>
         <3d9a74111aaadde7be00ec7c8c53d095daf4f9d2.1586507878.git.ryder.lee@mediatek.com>
         <87mu7elgi1.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A8D0975846BF9946481E93089F5434300BF55617E9FB1178178E68882C03D45A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTE0IGF0IDA5OjM3ICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBS
eWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+IHdyaXRlczoNCj4gDQo+ID4gQWRkIHN1
cHBvcnQgZm9yIHRoZSBNZWRpYVRlayBsYXRlc3QgZ2VuZXJhdGlvbiBJRUVFIDgwMi4xMWF4IDR4
NA0KPiA+IGRldmljZSBNVDc5MTVFLCB3aGljaCBzdXBwb3J0cyBjb25jdXJyZW50IGR1YWwtYmFu
ZCBvcGVyYXRpb24gYXQNCj4gPiBib3RoIDVHSHogYW5kIDIuNEdIei4NCj4gPg0KPiA+IE5vdGUg
dGhhdCB0aGlzIHBhdGNoIGp1c3QgYWRkIGJhc2ljIHBhcnQgYW5kIHdpbGwgYWRkIG1vcmUgSEUN
Cj4gPiBjYXBhYmlsaXRpZXMgc3VwcG9ydCBpbiB0aGUgZnVydGhlciBwYXRjaGVzLg0KPiA+DQo+
ID4gVGhlIGRyaXZlciBzdXBwb3J0cyBBUCwgU3RhdGlvbiwgTWVzaCBhbmQgbW9uaXRvciBtb2Rl
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYXluZSBDaGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRl
ay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hpaC1NaW4gQ2hlbiA8Y2hpaC1taW4uY2hlbkBt
ZWRpYXRlay5jb20+DQo+ID4gVGVzdGVkLWJ5OiBFdmVseW4gVHNhaSA8ZXZlbHluLnRzYWlAbWVk
aWF0ZWsuY29tPg0KPiA+IEFja2VkLWJ5OiBZaXdlaSBDaHVuZyA8eWl3ZWkuY2h1bmdAbWVkaWF0
ZWsuY29tPg0KPiA+IEFja2VkLWJ5OiBZRiBMdW8gPHlmLmx1b0BtZWRpYXRlay5jb20+DQo+IA0K
PiBbLi4uXQ0KPiANCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvS2NvbmZpZw0KPiA+IEBAIC0wLDAgKzEsMTMgQEAN
Cj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+IA0KPiBTYW1l
IGFzIGluIG15IGVhcmxpZXIgY29tbWVudCB0b2RheTogbXQ3NiBpcyBJU0MsIHdoeSBhcmUgeW91
IHVzaW5nIEdQTD8NCg0KDQpNeSBiYWQuIEkgY29weS9wYXN0ZSB0aGlzIGZyb20gYW5vdGhlciBk
cml2ZXIuIFdpbGwgZml4IGl0Lg0K

