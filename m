Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E833FC1AA
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Aug 2021 05:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbhHaDqf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Aug 2021 23:46:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51044 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239719AbhHaDqf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Aug 2021 23:46:35 -0400
X-UUID: 4437d6f9ee644a1c9a268fe8bc3e15a9-20210831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lnxzkb/YsRsEyZLnSbd3aJpo5IND2ZTKMjx1rMjih50=;
        b=XjTqt6ZFXGj5N93fldUdxjUbI5ENSvGFsJCh2BK3/LSzeuY8MSJLfp4lHPMulatf3QF39j2i3xKRNfFTV/wAuU193N1/7anDKoLIUY9Mo+w5SpDVuKklzCKaEL3xKlXLx/P+Lk4QMoWZ+TcoR6cR7SaNpkDjY6RHLSpboGDrrSc=;
X-UUID: 4437d6f9ee644a1c9a268fe8bc3e15a9-20210831
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 174898009; Tue, 31 Aug 2021 11:45:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 31 Aug 2021 11:45:35 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 31 Aug 2021 11:45:35 +0800
Message-ID: <1292ba30d5305ab53fae51bcdaf50af16098f597.camel@mediatek.com>
Subject: Re: [PATCH v4] mt76: mt7915: introduce
 mt7915_mcu_beacon_check_caps()
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 31 Aug 2021 11:45:35 +0800
In-Reply-To: <d72dbfa5ce55cfd1e6700979b9f3566edfdae340.1630217348.git.ryder.lee@mediatek.com>
References: <d72dbfa5ce55cfd1e6700979b9f3566edfdae340.1630217348.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU3VuLCAyMDIxLTA4LTI5IGF0IDE0OjE3ICswODAwLCBSeWRlciBMZWUgd3JvdGU6DQo+IEJl
YWNvbiBlbGVtZW50cyBtaWdodCBiZSBjaGFuZ2VkIGJ5IGhvc3RhcGQgY29uZmlndXJhaW9uLCBz
byBkcml2ZXINCj4gc2hvdWxkIGNvbXBhcmUgYm90aCBJRXMgYW5kIFBIWSBjYXBhYmlsaXRpZXMg
dG8gZ2V0IHRoZSBsZWFzdCBjb21tb24NCj4gZGVub21pbmF0b3IgYmVmb3JlIGFzc29jaWF0aW9u
Lg0KPiANCj4gQ28tZGV2ZWxvcGVkLWJ5OiBFdmVseW4gVHNhaSA8ZXZlbHluLnRzYWlAbWVkaWF0
ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBFdmVseW4gVHNhaSA8ZXZlbHluLnRzYWlAbWVkaWF0
ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5j
b20+DQo+IC0tLQ0KPiBNeSBwcmV2aW91cyB2NCBkaWRuJ3QgZ2V0IHRvIHBhdGNod29yaywgc28g
cmVzZW5kIGl0Lg0KPiB2NCAtIHJlbW92ZSBleHRyYSArLg0KPiB2MyAtIHJlYmFzZSBhbmQgcmV3
b3JrIExEUEMgcGFydC4NCj4gdjIgLSBjbGVhbiB1cCBjb2Rlcy4NCj4gLS0tDQoNClBsZWFzZSBp
Z25vcmUgdGhpcyBvbmUuIFdlIHdpbGwgbWVyZ2UgaXQgdG8gYW5vdGhlciBzZXJpZXMgYXMgYSBj
b21tb24NCmdyb3VuZC4NCg0KUnlkZXINCg==

