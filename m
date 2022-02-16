Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E57C4B7DDB
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Feb 2022 03:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343833AbiBPCu7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Feb 2022 21:50:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbiBPCu6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Feb 2022 21:50:58 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4FEFBF1C
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 18:50:40 -0800 (PST)
X-UUID: 9ac94e08a51c4d489558769e999697c0-20220216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=x5ghEANYgCCE+GMErwhGExbUN7+xiQGqNiso4BD/6f0=;
        b=mQS/qJzHU7zuFel6SfsDG3ZnFQhBmkqAnfyti8DQp6BEClRtasOtfisUzACBpzNfai56goLnC3b30fxRc+1CS/tgJPxOfLnpZ44iQs2DJMV0kXGinbjDmUinGfu2y20tkKcL+vHY21Ec3vko7CKWX8IRuKv3NnmRnPU7eLwhjtg=;
X-UUID: 9ac94e08a51c4d489558769e999697c0-20220216
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1680426320; Wed, 16 Feb 2022 10:50:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Feb 2022 10:50:36 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 10:50:35 +0800
Subject: Re: [PATCH] mt76: mt7915: fix logic error and remove the unused
 member of mt7915_dev
To:     Bo Jiao <bo.jiao@mediatek.com>, Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <4b7ba947d90fc12bba5da59cd448372e89438b82.1644915710.git.Bo.Jiao@mediatek.com>
 <73401df842523a426c9c223217a4273cace2ab4b.1644915711.git.Bo.Jiao@mediatek.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <62645f40-33e2-5f9f-2bde-0389d5edb06c@mediatek.com>
Date:   Wed, 16 Feb 2022 10:50:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <73401df842523a426c9c223217a4273cace2ab4b.1644915711.git.Bo.Jiao@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMi8xNS8yMiA1OjA4IFBNLCBCbyBKaWFvIHdyb3RlOg0KPiBGcm9tOiBCbyBKaWFvIDxCby5K
aWFvQG1lZGlhdGVrLmNvbT4NCj4gDQo+IGZpeCBsb2dpYyBlcnJvciBhbmQgcmVtb3ZlIHRoZSB1
bnVzZWQgbWVtYmVyICdhZGllJyBvZiBtdDc5MTVfZGV2Lg0KPiANCj4gRml4ZXM6IDkxZWVhZWYy
NTIzZiAoIm10NzY6IG10NzkxNTogYWRkIHN1cHBvcnQgZm9yIE1UNzk4NiIpDQo+IFNpZ25lZC1v
ZmYtYnk6IEJvIEppYW8gPEJvLkppYW9AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gICAtIHBsZWFz
ZSBmb2xkIHRoaXMgaW50byBwcmV2aW91cyBjb21taXQuDQo+IC0tLQ0KPiAgIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2luaXQuYyAgIHwgNCArKy0tDQo+ICAgZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbXQ3OTE1LmggfCAzIC0tLQ0K
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1
L2luaXQuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2luaXQu
Yw0KPiBpbmRleCA2YTRmYjRjLi42YjM3NDliIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMNCj4gKysrIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jDQo+IEBAIC01ODksMTAgKzU4OSwx
MCBAQCBzdGF0aWMgdm9pZCBtdDc5MTVfd2ZzeXNfcmVzZXQoc3RydWN0IG10NzkxNV9kZXYgKmRl
dikNCj4gICANCj4gICAJCW1zbGVlcCgxMDApOw0KPiAgIAl9IGVsc2UgaWYgKGlzX210Nzk4Nigm
ZGV2LT5tdDc2KSkgew0KPiAtCQltdDc5ODZfd21hY19lbmFibGUoZGV2KTsNCj4gKwkJbXQ3OTg2
X3dtYWNfZGlzYWJsZShkZXYpOw0KPiAgIAkJbXNsZWVwKDIwKTsNCj4gICANCj4gLQkJbXQ3OTg2
X3dtYWNfZGlzYWJsZShkZXYpOw0KPiArCQltdDc5ODZfd21hY19lbmFibGUoZGV2KTsNCj4gICAJ
CW1zbGVlcCgyMCk7DQo+ICAgCX0gZWxzZSB7DQo+ICAgCQltdDc2X3NldChkZXYsIE1UX1dGX1NV
QlNZU19SU1QsIDB4MSk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9tdDc5MTUuaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3OTE1L210NzkxNS5oDQo+IGluZGV4IDNmZmVlMzUuLjZkYjBkYjEgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L210NzkxNS5o
DQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L210Nzkx
NS5oDQo+IEBAIC0zMjIsOSArMzIyLDYgQEAgc3RydWN0IG10NzkxNV9kZXYgew0KPiAgIAlzdHJ1
Y3QgcmVzZXRfY29udHJvbCAqcnN0YzsNCj4gICAJdm9pZCBfX2lvbWVtICpkY207DQo+ICAgCXZv
aWQgX19pb21lbSAqc2t1Ow0KPiAtDQo+IC0JLyogYWRpZSBpcyBpbmFjY2Vzc2libGUgYWZ0ZXIg
d2ZzeXMgcG93ZXJvbiAqLw0KPiAtCXUzMiBhZGllOw0KPiAgIH07DQo+ICAgDQo+ICAgZW51bSB7
DQo+IA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNv
bT4NCg0KUmVnYXJkcywNCk1hY3BhdWwgTGlu

