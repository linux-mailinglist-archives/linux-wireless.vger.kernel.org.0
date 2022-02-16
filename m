Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186E04B7DB7
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Feb 2022 03:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343838AbiBPCvN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Feb 2022 21:51:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343835AbiBPCvN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Feb 2022 21:51:13 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0488BFBF11
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 18:51:01 -0800 (PST)
X-UUID: 7c1fdd8b230a4ce4b412e5a236df1c4c-20220216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=MBNyLpMzBPbffcL38a9bQRGqGEVWlEbI+x1n1GKyJHQ=;
        b=mdkX9RYgjZhfNCoTnFcvYSzb+YC4k5CN3s8TiyUi2Y8yeRQPld7LCk3yJhOmRX9aelo/ccXY2UDHlurvoJjO5DAGSicV/sUg5kbiRhq8vqRhv5WQWVaJghS0XTzpiaqSC1VPlRlsvHmHA9UkC8uIgRYKIUH0iG5XD3v6PB2h6es=;
X-UUID: 7c1fdd8b230a4ce4b412e5a236df1c4c-20220216
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 145225230; Wed, 16 Feb 2022 10:50:56 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Feb 2022 10:50:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Feb
 2022 10:50:55 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 10:50:55 +0800
Subject: Re: [PATCH] mt76: mt7915: fix compiler warning
To:     Bo Jiao <bo.jiao@mediatek.com>, Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <4b7ba947d90fc12bba5da59cd448372e89438b82.1644915710.git.Bo.Jiao@mediatek.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <5f98215f-5478-4166-e030-449b3cb18dab@mediatek.com>
Date:   Wed, 16 Feb 2022 10:50:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4b7ba947d90fc12bba5da59cd448372e89438b82.1644915710.git.Bo.Jiao@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMi8xNS8yMiA1OjA4IFBNLCBCbyBKaWFvIHdyb3RlOg0KPiBGcm9tOiBCbyBKaWFvIDxCby5K
aWFvQG1lZGlhdGVrLmNvbT4NCj4gDQo+IGZpeCB3YXJuaW5nOiB2YXJpYWJsZSAndGVtcCcgc2V0
IGJ1dCBub3QgdXNlZCBhbmQNCj4gY2FzdCBmcm9tIHBvaW50ZXIgdG8gaW50ZWdlciBvZiBkaWZm
ZXJlbnQgc2l6ZQ0KPiANCj4gRml4ZXM6IDkxZWVhZWYyNTIzZiAoIm10NzY6IG10NzkxNTogYWRk
IHN1cHBvcnQgZm9yIE1UNzk4NiIpDQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8
bGtwQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQm8gSmlhbyA8Qm8uSmlhb0BtZWRpYXRl
ay5jb20+DQo+IC0tLQ0KPiAgIC0gcGxlYXNlIGZvbGQgdGhpcyBpbnRvIHByZXZpb3VzIGNvbW1p
dC4NCj4gLS0tDQo+ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUv
c29jLmMgfCA2ICsrKy0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc5MTUvc29jLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkxNS9zb2MuYw0KPiBpbmRleCBmYjcyYWI0Li5kZWNmMjg4IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9zb2MuYw0KPiArKysg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9zb2MuYw0KPiBAQCAt
MTI1LDcgKzEyNSw3IEBAIG10Nzk4Nl93bWFjX2FkaWVfZWZ1c2VfcmVhZChzdHJ1Y3QgbXQ3OTE1
X2RldiAqZGV2LCB1OCBhZGllLA0KPiAgIAkJcmV0dXJuIHJldDsNCj4gICANCj4gICAJcmV0ID0g
cmVhZF9wb2xsX3RpbWVvdXQobXQ3Nl93bWFjX3NwaV9yZWFkLCB0ZW1wLA0KPiAtCQkJCSFGSUVM
RF9HRVQoTVRfQURJRV9FRlVTRV9LSUNLX01BU0ssIHZhbCksDQo+ICsJCQkJIXRlbXAgJiYgIUZJ
RUxEX0dFVChNVF9BRElFX0VGVVNFX0tJQ0tfTUFTSywgdmFsKSwNCj4gICAJCQkJVVNFQ19QRVJf
TVNFQywgNTAgKiBVU0VDX1BFUl9NU0VDLCBmYWxzZSwNCj4gICAJCQkJZGV2LCBhZGllLCBNVF9B
RElFX0VGVVNFMl9DVFJMLCAmdmFsKTsNCj4gICAJaWYgKHJldCkNCj4gQEAgLTExMjYsOSArMTEy
Niw5IEBAIHN0YXRpYyBpbnQgbXQ3OTg2X3dtYWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4gICAJc3RydWN0IG10NzkxNV9kZXYgKmRldjsNCj4gICAJc3RydWN0IG10NzZf
ZGV2ICptZGV2Ow0KPiAgIAlpbnQgaXJxLCByZXQ7DQo+IC0JdTY0IGNoaXBfaWQ7DQo+ICsJdTMy
IGNoaXBfaWQ7DQo+ICAgDQo+IC0JY2hpcF9pZCA9ICh1NjQpb2ZfZGV2aWNlX2dldF9tYXRjaF9k
YXRhKCZwZGV2LT5kZXYpOw0KPiArCWNoaXBfaWQgPSAodWludHB0cl90KW9mX2RldmljZV9nZXRf
bWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsNCj4gICANCj4gICAJaXJxID0gcGxhdGZvcm1fZ2V0X2ly
cShwZGV2LCAwKTsNCj4gICAJaWYgKGlycSA8IDApDQo+IA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1
bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KUmVnYXJkcywNCk1hY3BhdWwgTGlu

