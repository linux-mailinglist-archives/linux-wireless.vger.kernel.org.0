Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BB2394416
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 16:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhE1OWI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 May 2021 10:22:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48684 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232146AbhE1OWF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 May 2021 10:22:05 -0400
X-UUID: 7b514791b05545bbb215f1d3337575cd-20210528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=GJbS2ZFW4DQHhXC9zIo8V+hxzyGc59YJHbNL6lRvS2Q=;
        b=NWit/1a/YwAqoB5rf8Z/dmlTYbIFhf3AlsuzzBJqfJR0uaDqoySyCC+7YbmOVfDiA4Lhrq+gsOzuoam4aNWeg1MjBI4oSpeVsBZ0WnqEZqF9ntJ3t18ItwiD6o7MF2lr6rragAYGJ9IvT7W4rYRIPb7+4Ux7I8kxOhri5kuNm+o=;
X-UUID: 7b514791b05545bbb215f1d3337575cd-20210528
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 278073331; Fri, 28 May 2021 22:20:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 May 2021 22:20:25 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 May 2021 22:20:25 +0800
Message-ID: <1a8b17744553235236560734aac6f83ce782f3e3.camel@mediatek.com>
Subject: Re: [PATCH] mt76: mt7915: add debugfs knob to read efuse value from
 FW
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Fri, 28 May 2021 22:20:25 +0800
In-Reply-To: <32908981-c864-aa13-b182-8081610baa9c@nbd.name>
References: <20210504125225.2536-1-shayne.chen@mediatek.com>
         <32908981-c864-aa13-b182-8081610baa9c@nbd.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIxLTA1LTI4IGF0IDEwOjU2ICswMjAwLCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0K
PiBPbiAyMDIxLTA1LTA0IDE0OjUyLCBTaGF5bmUgQ2hlbiB3cm90ZToNCj4gPiBJbiBlZnVzZSBt
b2RlLCBtdDc5MTUgb25seSByZWFkcyBlZnVzZSB2YWx1ZXMgZnJvbSBGVyB3aGljaCBkcml2ZXIN
Cj4gPiBuZWVkLg0KPiA+IEFkZCBhIGRlYnVnZnMga25vYiB0byByZWFkIGFkZHRpb25hbCBlZnVz
ZSB2YWx1ZXMgZnJvbSBhIHNwZWNpZmljDQo+ID4gZmllbGQsDQo+ID4gd2hpY2ggaXMgdXNlZnVs
IGluIHNvbWUgY2FzZXMgc3VjaCBhcyBjaGVja2luZyBpZiByZiB2YWx1ZXMgaW4NCj4gPiBlZnVz
ZQ0KPiA+IGFyZSBwcm9wZXJseSBidXJuZWQuDQo+ID4gDQo+ID4gQW4gZXhhbXBsZSBvZiB1c2Fn
ZToNCj4gPiBlY2hvIDB4NDAwID4gZWZ1c2VfaWR4DQo+ID4gaGV4ZHVtcCAtQyBlZXByb20NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGF5bmUgQ2hlbiA8c2hheW5lLmNoZW5AbWVkaWF0ZWsu
Y29tPg0KPiANCj4gSSdkIHByZWZlciBpZiB3ZSByZWFkIHRoZSBlbnRpcmUgZWZ1c2UgYW5kIHB1
dCBpdCBpbiBhICJvdHAiIGRlYnVnZnMNCj4gZmlsZSwgbGlrZSBvbiBvbGRlciBjaGlwcy4NCj4g
DQo+IC0gRmVsaXgNCg0KSGkgRmVsaXgsDQoNCkdvdCBpdC4gSSdsbCBzZW5kIGFub3RoZXIgcGF0
Y2gsIHBsZWFzZSBkcm9wIHRoaXMgb25lLg0KDQpUaGFua3MsDQpTaGF5bmUNCg==

