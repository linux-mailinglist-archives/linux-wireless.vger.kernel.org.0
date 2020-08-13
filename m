Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A3B2440E0
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 23:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgHMVt6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 17:49:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:10123 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726192AbgHMVt6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 17:49:58 -0400
X-UUID: 9fb9d79f40ec4b2582e8845f8addbbf4-20200814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rD0m4doqCUrNGdW0dCK8TkYRyBtDiT5wCBqL1d3SJ2o=;
        b=fbqxBg2vdVmgE6fdEP8F75F3gcCfFqPaZKhM49Ezmx0+J7cPTTx15dOL37leD00HY6q37KAyhPGzrF2XBERTkLv6D7DnDbAbiAzavKaJRE84bl46eVlnbQ2NaiAa9DbDafBgTDkDCzeYv2w/agbUF4vp/GEifkQz6xxST3KHBJQ=;
X-UUID: 9fb9d79f40ec4b2582e8845f8addbbf4-20200814
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1728308026; Fri, 14 Aug 2020 05:49:50 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 Aug 2020 05:49:49 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 Aug 2020 05:49:49 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        YN Chen <YN.Chen@mediatek.com>
Subject: [PATCH] mt76: mt7663s: fix resume failure
Date:   Fri, 14 Aug 2020 05:49:47 +0800
Message-ID: <f15034742d64dde093562ed360164e1f37e10fd4.1597354840.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpNVDc2NjNzIGhhdmUg
dG8gcmVseSBvbiBNTUNfUE1fS0VFUF9QT1dFUiBpbiBwbV9mbGFncyBmb3IgdG8gYXZvaWQgU0RJ
Tw0KcG93ZXIgaXMgYmVpbmcgc2h1dCBvZmYuDQoNClRvIGZpeCBzZGlvIGFjY2VzcyBmYWlsdXJl
IGxpa2UgIm10NzY2M3MgbW1jMTowMDAxOjE6IHNkaW8gd3JpdGUgZmFpbGVkOg0KLTIyIiBmb3Ig
dGhlIGZpcnN0IHNkaW8gY29tbWFuZCB0byBhY2Nlc3MgdGhlIGJ1cyBpbiB0aGUgcmVzdW1lIGhh
bmRsZXIuDQoNCkZpeGVzOiBhNjZjYmRkNjU3M2QgKCJtdDc2OiBtdDc2MTU6IGludHJvZHVjZSBt
dDc2NjNzIHN1cHBvcnQiKQ0KQ28tZGV2ZWxvcGVkLWJ5OiBZTiBDaGVuIDxZTi5DaGVuQG1lZGlh
dGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IFlOIENoZW4gPFlOLkNoZW5AbWVkaWF0ZWsuY29tPg0K
U2lnbmVkLW9mZi1ieTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQog
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvc2Rpby5jIHwgMiArKw0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3NkaW8uYyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3NkaW8uYw0KaW5kZXggYjAxOGE5Njc1YzFhLi41
NmY2NTM0NWQwNDggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzYxNS9zZGlvLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3NjE1L3NkaW8uYw0KQEAgLTQyNCw2ICs0MjQsOCBAQCBzdGF0aWMgaW50IG10NzY2M3Nf
c3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQogCQkJcmV0dXJuIGVycjsNCiAJfQ0KIA0KKwlz
ZGlvX3NldF9ob3N0X3BtX2ZsYWdzKGZ1bmMsIE1NQ19QTV9LRUVQX1BPV0VSKTsNCisNCiAJbXQ3
NnNfc3RvcF90eHJ4KCZtZGV2LT5tdDc2KTsNCiANCiAJcmV0dXJuIG10NzYxNV9tY3Vfc2V0X2Z3
X2N0cmwobWRldik7DQotLSANCjIuMjUuMQ0K

