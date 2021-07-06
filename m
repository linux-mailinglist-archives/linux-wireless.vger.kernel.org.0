Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051643BCB15
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jul 2021 12:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhGFK7v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jul 2021 06:59:51 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:4113 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231630AbhGFK7u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jul 2021 06:59:50 -0400
X-UUID: 49c5bff8920f4ad7acdaeca5686df7c9-20210706
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=fySLpMv1btIaAU30kbuqvjoMxsndC4XVwJAZOxYQYGA=;
        b=Izir+vJ/aEkO2rEuajX54bDheErDs19tad0zqcW9tB4GDgibTCGAa0SC1kaHXPVp7NB6Qsn/C+No0GzPgi/wzYJEPfHoA1U3eR2LrYJCxCstF/nI9bBBSmXkae8IPLpgg8VjKmPzKIdf9o5S3lVMWMiLHjG8JxJvpVhFFWjtpuw=;
X-UUID: 49c5bff8920f4ad7acdaeca5686df7c9-20210706
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1595000243; Tue, 06 Jul 2021 18:57:07 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 6 Jul
 2021 18:56:57 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 6 Jul 2021 18:56:57 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix calling mt76_wcid_alloc with incorrect parameter
Date:   Tue, 6 Jul 2021 18:56:54 +0800
Message-ID: <20210706105654.4044-1-bo.jiao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B28D185ECE3A57D2545846F76292825BB233DA99F37DE772B60AACE3605F5B792000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogQm8gSmlhbyA8Qm8uSmlhb0BtZWRpYXRlay5jb20+DQoNCkl0IHdpbGwgY2F1c2UgbWF4
aW11bSBjb25uZWN0YWJsZSBTVEEgdG8gYmUgb25lIGxlc3MNCndoZW4gY2FsbGluZyBtdDc2X3dj
aWRfYWxsb2Mgd2l0aCBwYXJhbWV0ZXIgTVQ3OTE1X1dUQkxfU1RBIC0gMS4NCg0KU2lnbmVkLW9m
Zi1ieTogQm8gSmlhbyA8Qm8uSmlhb0BtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTdWp1
YW4gQ2hlbiA8c3VqdWFuLmNoZW5AbWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IFJ5ZGVyIExl
ZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTE1L2luaXQuYyB8IDIgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMgfCAyICstDQogMiBmaWxlcyBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMNCmluZGV4IDQ3OThkNjM0NDMwNS4uMWQyMjE0
NTE5ZjVhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc5MTUvaW5pdC5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210
NzkxNS9pbml0LmMNCkBAIC00ODAsNyArNDgwLDcgQEAgc3RhdGljIGludCBtdDc5MTVfaW5pdF9o
YXJkd2FyZShzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2KQ0KIAl9DQogDQogCS8qIEJlYWNvbiBhbmQg
bWdtdCBmcmFtZXMgc2hvdWxkIG9jY3VweSB3Y2lkIDAgKi8NCi0JaWR4ID0gbXQ3Nl93Y2lkX2Fs
bG9jKGRldi0+bXQ3Ni53Y2lkX21hc2ssIE1UNzkxNV9XVEJMX1NUQSAtIDEpOw0KKwlpZHggPSBt
dDc2X3djaWRfYWxsb2MoZGV2LT5tdDc2LndjaWRfbWFzaywgTVQ3OTE1X1dUQkxfU1RBKTsNCiAJ
aWYgKGlkeCkNCiAJCXJldHVybiAtRU5PU1BDOw0KIA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21haW4uYyBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21haW4uYw0KaW5kZXggYzI1ZjhkYTU5MGRkLi5kOGFi
ZWJjZmZlNGIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzkxNS9tYWluLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTE1L21haW4uYw0KQEAgLTYxMyw3ICs2MTMsNyBAQCBpbnQgbXQ3OTE1X21hY19zdGFfYWRk
KHN0cnVjdCBtdDc2X2RldiAqbWRldiwgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwNCiAJc3Ry
dWN0IG10NzkxNV92aWYgKm12aWYgPSAoc3RydWN0IG10NzkxNV92aWYgKil2aWYtPmRydl9wcml2
Ow0KIAlpbnQgcmV0LCBpZHg7DQogDQotCWlkeCA9IG10NzZfd2NpZF9hbGxvYyhkZXYtPm10NzYu
d2NpZF9tYXNrLCBNVDc5MTVfV1RCTF9TVEEgLSAxKTsNCisJaWR4ID0gbXQ3Nl93Y2lkX2FsbG9j
KGRldi0+bXQ3Ni53Y2lkX21hc2ssIE1UNzkxNV9XVEJMX1NUQSk7DQogCWlmIChpZHggPCAwKQ0K
IAkJcmV0dXJuIC1FTk9TUEM7DQogDQotLSANCjIuMTguMA0K

