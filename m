Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F553F2459
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 03:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhHTB3n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 21:29:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34774 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232191AbhHTB3m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 21:29:42 -0400
X-UUID: 223b09b2fcbf4c2a8f3559511d71e03b-20210820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3uIDSbynqZ+e8h4IIwd7j0R/OKDKxqtlUSN4a8VEEGA=;
        b=GLNPBB0dp0oZMidyyQ2CfM5bVpYAEZfU69OzJd4/m79w1fna5kuLJvyT39a+3gyvu7+y9So0cTB8ArxgrwcmJVkSVf1sukqQ0nQo/DCnMxG/scruwhxSZyDSLFWqCuYZ+kS6cJM/6ZwyeNdOL9B+lXRBR7Hm9eGcALPDjXucGX8=;
X-UUID: 223b09b2fcbf4c2a8f3559511d71e03b-20210820
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 40793816; Fri, 20 Aug 2021 09:29:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 Aug 2021 09:29:00 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 Aug 2021 09:29:00 +0800
Message-ID: <45c67ffb65debdd62a417c0b68af2ba7f1932195.camel@mediatek.com>
Subject: Re: [PATCH 2/4] mt76: mt7615: checkpatch cleanup
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 20 Aug 2021 09:29:00 +0800
In-Reply-To: <87wnoha1rd.fsf@tynnyri.adurom.net>
References: <77372f644903053e09d671325c0cd44cf75e14ac.1628301615.git.ryder.lee@mediatek.com>
         <1991c856459c2014386d1a16f6657e9ba82b6d1f.1628301615.git.ryder.lee@mediatek.com>
         <87wnoha1rd.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIxLTA4LTE5IGF0IDE4OjMyICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBS
eWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+IHdyaXRlczoNCj4gDQo+ID4gRml4IHJl
YXNvbmFibGUgY2hlY2twYXRjaCB3YXJuaW5ncy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBS
eWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQo+IA0KPiBPbmUgbG9naWNhbCBjaGFu
Z2UgcGVyIHBhdGNoLCBwbGVhc2UuDQo+IA0KDQpJIHByZWZlciBjb2xsZWN0aW9uIGFsbCBjaGVj
a3BhdGNoIHdhcm5pbmdzIGludG8gdGhlIHNpbmdsZSBwYXRjaC4NCg0KUnlkZXINCg==

