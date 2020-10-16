Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCB928FC0E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Oct 2020 02:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbgJPA07 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Oct 2020 20:26:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38554 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731753AbgJPA07 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Oct 2020 20:26:59 -0400
X-UUID: aa616be3f0374b52a30e8f6fee3bafcc-20201016
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bMfVRMKx8CbHQ6zK9+0AUtlDVS68xAYQbTyAUQ/UhAs=;
        b=YL9z9UHOYCi0OqlZmyqev+ymc//V4tYB0iVlDGjtehIJ8utEYhebjMaJ7ek09ZyGwLguwzH2vBCc+L0RuBABrt7t32OvuLnBu7Vs9LpXOsWO/Md0yGCSiMtLZuB6L9xzP/mom4Vj7+zkenfXyVOcZqFWdXOIsKtPkLoblKTIZW8=;
X-UUID: aa616be3f0374b52a30e8f6fee3bafcc-20201016
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 266506514; Fri, 16 Oct 2020 08:26:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Oct 2020 08:26:47 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Oct 2020 08:26:42 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, Sean Wang <objelf@gmail.com>,
        YN Chen <YN.Chen@mediatek.com>
Subject: [PATCH 1/2] mt76: mt7663: handle failure event for patch semaphore cmd
Date:   Fri, 16 Oct 2020 08:26:41 +0800
Message-ID: <267346a9a9c5f71caec03292b6c33b39864b38c5.1602807276.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9B668A4925E40B91B0B7B564063D5E6D26155C7129E86D65B82670778F1CCA332000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxvYmplbGZAZ21haWwuY29tPg0KDQpKdXN0IGZvbGxvdyB1cCB2ZW5k
b3IgZHJpdmVyIHRvIHJldHJ5IGEgZmV3IHRpbWVzIG9idGFpbmluZyBwYXRjaA0Kc2VtYXBob3Jl
IHdoZW4gdGhlIGV2ZW50IGlzIFBBVENIX05PVF9ETF9TRU1fRkFJTC4gVGhhdCB1c3VhbGx5DQpo
YXBwZW5zIGluIEJsdWV0b290aCBhbmQgV2lmaSBkcml2ZXIgY29udGVuZHMgdG8gZG93bmxvYWQg
cGF0Y2gNCnNpbXVsdGFuZW91c2x5Lg0KDQpDby1kZXZlbG9wZWQtYnk6IFlOIENoZW4gPFlOLkNo
ZW5AbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTogWU4gQ2hlbiA8WU4uQ2hlbkBtZWRpYXRl
ay5jb20+DQpTaWduZWQtb2ZmLWJ5OiAgU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29t
Pg0KLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMg
fCA5ICsrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3NjE1L21jdS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUv
bWN1LmMNCmluZGV4IDJiMTdiZDFjMmEzMi4uYzk5MGNjZDZmNDcyIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMNCisrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21jdS5jDQpAQCAtMTk0NSwxNCAr
MTk0NSwyMSBAQCBzdGF0aWMgaW50IG10NzYxNV9sb2FkX3BhdGNoKHN0cnVjdCBtdDc2MTVfZGV2
ICpkZXYsIHUzMiBhZGRyLCBjb25zdCBjaGFyICpuYW1lKQ0KIHsNCiAJY29uc3Qgc3RydWN0IG10
NzYxNV9wYXRjaF9oZHIgKmhkcjsNCiAJY29uc3Qgc3RydWN0IGZpcm13YXJlICpmdyA9IE5VTEw7
DQotCWludCBsZW4sIHJldCwgc2VtOw0KKwlpbnQgbGVuLCByZXQsIHNlbSwgYyA9IDUwOw0KIA0K
K3JldHJ5Og0KIAlzZW0gPSBtdDc2MTVfbWN1X3BhdGNoX3NlbV9jdHJsKGRldiwgMSk7DQogCXN3
aXRjaCAoc2VtKSB7DQogCWNhc2UgUEFUQ0hfSVNfREw6DQogCQlyZXR1cm4gMDsNCiAJY2FzZSBQ
QVRDSF9OT1RfRExfU0VNX1NVQ0NFU1M6DQogCQlicmVhazsNCisJY2FzZSBQQVRDSF9OT1RfRExf
U0VNX0ZBSUw6DQorCQlpZiAoaXNfbXQ3NjYzKCZkZXYtPm10NzYpICYmIGMtLSkgew0KKwkJCW1z
bGVlcCgxMDApOw0KKwkJCWdvdG8gcmV0cnk7DQorCQl9DQorCQlmYWxsdGhyb3VnaDsNCiAJZGVm
YXVsdDoNCiAJCWRldl9lcnIoZGV2LT5tdDc2LmRldiwgIkZhaWxlZCB0byBnZXQgcGF0Y2ggc2Vt
YXBob3JlXG4iKTsNCiAJCXJldHVybiAtRUFHQUlOOw0KLS0gDQoyLjI1LjENCg==

