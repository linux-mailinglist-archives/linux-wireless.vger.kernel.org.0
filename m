Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E6A39CF8A
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jun 2021 16:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFFOgG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Jun 2021 10:36:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41852 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230025AbhFFOgE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Jun 2021 10:36:04 -0400
X-UUID: b9da2d9d6a4441b0950ea621fe3a9822-20210606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=eENGFJ4+SpkiY3jmLOHzRg31PNVL6t535kEL01+n4+I=;
        b=DituJclx/D+0sMSDN7Ckrzbm7eHeSCdazTXroj1/+JtCmfm/l98FmnbUAgVPrC6XelhBXfHDdEMMNTFylQC7fJsFt7rV4+zweDW5kb1HiwJngschMOUNUZ9eO1kVa2l5ObAf+LcgZte7unGcF1GsWtftlh1cKRZLaZ+kioxrGkg=;
X-UUID: b9da2d9d6a4441b0950ea621fe3a9822-20210606
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 247634505; Sun, 06 Jun 2021 22:34:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 6 Jun 2021 22:34:10 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 6 Jun 2021 22:34:10 +0800
Message-ID: <2f67567432a0e6c304a47d19c655bf83cf271e6d.camel@mediatek.com>
Subject: Re: [PATCH] mt76: mt7921: enable VHT BFee capabiliity
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>, <jemele@google.com>,
        <yenlinlai@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Sun, 6 Jun 2021 22:34:10 +0800
In-Reply-To: <3bbdab20-60be-61fb-d731-5cf5d04f7f3c@nbd.name>
References: <a5748514496b2b4e4b23be7b0b560d2585feafb6.1622627260.git.deren.wu@mediatek.com>
         <3bbdab20-60be-61fb-d731-5cf5d04f7f3c@nbd.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU3VuLCAyMDIxLTA2LTA2IGF0IDA5OjUxICswMjAwLCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0K
PiBPbiAyMDIxLTA2LTAyIDE3OjE3LCBEZXJlbiBXdSB3cm90ZToNCj4gPiBGcm9tOiBEZXJlbiBX
dSA8ZGVyZW4ud3VAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IGVuYWJsZSBCRmVlIGZ1bmN0aW9u
cyB3aXRoIHByb3BlciBCRmVlIElFcw0KPiA+IA0KPiA+IFRlc3RlZC1ieTogRXJpYy1TWSBDaGFu
ZyA8RXJpYy1TWS5DaGFuZ0BtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGVvbiBZ
ZW4gPExlb24uWWVuQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEZXJlbiBXdSA8
ZGVyZW4ud3VAbWVkaWF0ZWsuY29tPg0KPiANCj4gSSd2ZSBzZW50IG91dCBhIG11Y2ggc2ltcGxl
ciByZXBsYWNlbWVudCBmb3IgdGhpcyBwYXRjaCwgcGxlYXNlIHRha2UNCj4gYSBsb29rLg0KPiAN
Cj4gLSBGZWxpeA0KSGkgRmVsaXgsDQoNCllvdXIgcGF0Y2ggaXMgZmluZSB3aXRoIG1lLiBUaGFu
a3MgZm9yIGhlbHAuDQoNClJlZ2FyZHMsDQpEZXJlbg0K

