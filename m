Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7C91A77FB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 12:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438076AbgDNKAU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 06:00:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22990 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2438054AbgDNKAG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 06:00:06 -0400
X-UUID: 4b90d2f2bb454d3b9384720a6d6137e8-20200414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=XIbn1mmZVm2efUla9Km08oZuKXyirzO1K4gplxG5iqk=;
        b=cxXzRmf+/m6P4nKzbHOt9FuL+4W63t+xB5wriMj7xo4hkYRwfdVp3jx92DFbhgcanlYQ5PKbeE0ad7SSqC9HC+DHE14xnFcmaaKLJN6jBlVwGDgR3iX613XbLFn1Mv+Msz2RJV5qwNH20kO6R0J4Vrm3eroG5BAKkBFnqMxz9yA=;
X-UUID: 4b90d2f2bb454d3b9384720a6d6137e8-20200414
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 808574171; Tue, 14 Apr 2020 18:00:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Apr 2020 17:59:59 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Apr 2020 17:59:59 +0800
Message-ID: <1586858399.6545.1.camel@mtkswgap22>
Subject: Re: [PATCH 08/16] mt76: mt7915: add offloading Tx AMSDU support
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "YF Luo" <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Chih-Min Chen <chih-min.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 14 Apr 2020 17:59:59 +0800
In-Reply-To: <87imi2lg71.fsf@tynnyri.adurom.net>
References: <cover.1586507878.git.ryder.lee@mediatek.com>
         <0cf99a5f317b0d41cd4832b14c99b6b9b8e5fefc.1586507878.git.ryder.lee@mediatek.com>
         <87imi2lg71.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5E6B30C4384BF0F6BDCDCB7852B4FF82EE06A30A7C3E8D0B32B14A0C318800AD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTE0IGF0IDA5OjQ0ICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBS
eWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+IHdyaXRlczoNCj4gDQo+ID4gQWRkIG1v
ZHVsZSBwYXJhbWV0ZXIgdG8gZW5hYmxlIGh3X3R4X2Ftc2R1Lg0KPiANCj4gV2h5IGlzIGEgbW9k
dWxlIHBhcmFtZXRlciBuZWVkZWQ/IEFuZCB3aHkgaXMgaXQgbm90IGVuYWJsZWQgYnkgZGVmYXVs
dD8NCj4gDQoNClRoaXMgaXMgc3RpbGwgV0lQLCBzbyBtYWtlIGl0IG9wdGlvbmFsLiBCdXQgSSB3
aWxsIGRyb3AgdGhpcyBvbmUgdW50aWwNCndlJ3JlIHJlYWR5Lg0KDQpSeWRlcg0K

