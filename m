Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D54E2E8297
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Dec 2020 23:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgLaW7E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Dec 2020 17:59:04 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49481 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726661AbgLaW7D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Dec 2020 17:59:03 -0500
X-UUID: 7cef5557fbf04a4486440b6da6f4f3cf-20210101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=6Ps4DdYhOu7Rm6Q7LAu2gQaEfsAp8CgW8IFQSpLNOtU=;
        b=qIUvAeJJrCqvNtaw51Ul1/H3j8WGm9mwUlJPU9hWAxiJ89SRmhHZ8/rrI0Catmo9SEWi6D6+nHwqDRqAK6MVHqug5GCCFT1kylkNic0wfsrcZCL+aLUCSTNK2z4mdRQQLLhMYgxv5GSYn/xaPOYDNd1ft/OPeP2VjJET2MfPgBo=;
X-UUID: 7cef5557fbf04a4486440b6da6f4f3cf-20210101
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1605171258; Fri, 01 Jan 2021 06:58:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 1 Jan 2021 06:58:14 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 Jan 2021 06:58:14 +0800
Message-ID: <1609455495.20208.8.camel@mtkswgap22>
Subject: Re: [PATCH -next v4 03/13] mt76: mt7921: add MAC support
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <sean.wang@mediatek.com>
CC:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Fri, 1 Jan 2021 06:58:15 +0800
In-Reply-To: <3969b56ae9211955428fad2aeba695416362a095.1609347310.git.objelf@gmail.com>
References: <cover.1609347310.git.objelf@gmail.com>
         <3969b56ae9211955428fad2aeba695416362a095.1609347310.git.objelf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTMxIGF0IDAyOjA2ICswODAwLCBzZWFuLndhbmdAbWVkaWF0ZWsuY29t
IHdyb3RlOg0KPiBGcm9tOiBTZWFuIFdhbmcgPHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+DQo+IA0K
PiBBZGQgUnggcGFja2V0IGRlc2NyaXB0aW9uIHBhcnNpbmcsIFR4IHBhY2tldCBkZXNjcmlwdGlv
biBjb21wb3NpdG9uLCBoYW5kbGUNCj4gcGFja2V0IHJlY3ljbGluZyBhbmQgcHJvdmlkZSBNQUMg
aW5mb3JtYXRpb24gbXQ3NiBjb3JlIG5lZWRzIHRvIHN1cHBvcnQNCj4gbWFjODAyMTEuDQo+IA0K
PiBDby1kZXZlbG9wZWQtYnk6IExvcmVuem8gQmlhbmNvbmkgPGxvcmVuem9Aa2VybmVsLm9yZz4N
Cj4gU2lnbmVkLW9mZi1ieTogTG9yZW56byBCaWFuY29uaSA8bG9yZW56b0BrZXJuZWwub3JnPg0K
PiBDby1kZXZlbG9wZWQtYnk6IFNvdWwgSHVhbmcgPFNvdWwuSHVhbmdAbWVkaWF0ZWsuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBTb3VsIEh1YW5nIDxTb3VsLkh1YW5nQG1lZGlhdGVrLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0N
Cj4gIC4uLi93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9NYWtlZmlsZSAgICB8ICAgIDIg
Ky0NCj4gIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvbWFjLmMgICB8IDEz
NjQgKysrKysrKysrKysrKysrKysNCg0KV2h5IG5vdCBwdXQgbWFjLmggaW50byB0aGlzIHBhdGNo
Pw0KDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEzNjUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTIxL21hYy5jDQoNCj4gK2ludCBtdDc5MjFfdHhfcHJlcGFyZV9za2Ioc3RydWN0IG10
NzZfZGV2ICptZGV2LCB2b2lkICp0eHdpX3B0ciwNCj4gKwkJCSAgZW51bSBtdDc2X3R4cV9pZCBx
aWQsIHN0cnVjdCBtdDc2X3djaWQgKndjaWQsDQo+ICsJCQkgIHN0cnVjdCBpZWVlODAyMTFfc3Rh
ICpzdGEsDQo+ICsJCQkgIHN0cnVjdCBtdDc2X3R4X2luZm8gKnR4X2luZm8pDQo+ICt7DQo+ICsJ
c3RydWN0IG10NzkyMV9kZXYgKmRldiA9IGNvbnRhaW5lcl9vZihtZGV2LCBzdHJ1Y3QgbXQ3OTIx
X2RldiwgbXQ3Nik7DQo+ICsJc3RydWN0IGllZWU4MDIxMV90eF9pbmZvICppbmZvID0gSUVFRTgw
MjExX1NLQl9DQih0eF9pbmZvLT5za2IpOw0KPiArCXN0cnVjdCBpZWVlODAyMTFfa2V5X2NvbmYg
KmtleSA9IGluZm8tPmNvbnRyb2wuaHdfa2V5Ow0KPiArCXN0cnVjdCBtdDc2X3R4X2NiICpjYiA9
IG10NzZfdHhfc2tiX2NiKHR4X2luZm8tPnNrYik7DQo+ICsJc3RydWN0IG10NzZfdHh3aV9jYWNo
ZSAqdDsNCj4gKwlzdHJ1Y3QgbXQ3OTIxX3R4cF9jb21tb24gKnR4cDsNCj4gKwlpbnQgaWQ7DQo+
ICsJdTggKnR4d2kgPSAodTggKil0eHdpX3B0cjsNCg0KTW9yZW92ZXIsIGhhcmR3YXJlIGNhbm5v
dCBhZGQgTExDLVNOQVAgd2hlbiBza2ItPmRhdGFfbGVuIGlzIDAsIHdoaWNoDQpjYXVzZXMgVHgg
c3R1Y2suIFdlIGZvdW5kIHRoaXMgY2FzZSBoYXBwZW5lZCBvbiBtdDc5MTUgKHN0YXRpb24gbW9k
ZSkNCnF1YWxpdHkgdGVzdCB3aXRoIGZldyBwYWNrZXRzIHdob3NlIHNrYi0+bGVuID0gMTQNCg0K
U28saHR0cHM6Ly9naXRodWIuY29tL25iZDE2OC93aXJlbGVzcy9jb21taXQvNmI2NjA1ZTQwNjFj
OTRjOTkwOWZmODJhY2MwZTAyYmZkM2E4ZDQwZQ0KDQpSeWRlcg0K

