Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2B501A16C5
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2020 22:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDGU0D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Apr 2020 16:26:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:32963 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726380AbgDGU0D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Apr 2020 16:26:03 -0400
X-UUID: 92afffd9c6cb4daab415fe2e4a020d56-20200408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=UbWFIDfpNOnnjPYw8DA44ZCVcPaW6m7bX2+v5UeLIPM=;
        b=ERRCl8PngAo4sRR7vBacrOuOZkfDbQwFgvcsE9/EOpfxbCizu4s5hlyIzEBUySAwTY8z8LAZEfctrocJcdURVc1rbkfS7zNGoMfTEmCNdC4z4/e+MSZYmMI5zYbiAaBRLW+iyj2Jyckyq7D1feGQ4sz/jJm+MKj432yRwDxdYCc=;
X-UUID: 92afffd9c6cb4daab415fe2e4a020d56-20200408
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 827516133; Wed, 08 Apr 2020 04:25:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Apr 2020 04:25:52 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Apr 2020 04:25:51 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: replace consume_skb with dev_kfree_skb
Date:   Wed, 8 Apr 2020 04:25:54 +0800
Message-ID: <b90644567e758b5702e37e34e31f2007e3bd2c87.1586290996.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F128AB51B999D028722362800A55E212DFBAC26E03CE284711BFDDF30F7DA98B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpjb25zdW1lX3NrYiBp
cyBpZGVudGljYWwgdG8gZGV2X2tmcmVlX3NrYiwgc28gdGhhdCByZXBsYWNlIGNvbnN1bWVfc2ti
IHdpdGgNCmRldl9rZnJlZV9za2IganVzdCB0byBtYWtlIGNvbnNpc3RlbnQgaW4gd2hvbGUgbXQ3
NiBkcml2ZXIuDQoNClNpZ25lZC1vZmYtYnk6IFNlYW4gV2FuZyA8c2Vhbi53YW5nQG1lZGlhdGVr
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NngwMl91
c2JfbWN1LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzZ4MDJfdXNiX21jdS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc2eDAyX3VzYl9tY3UuYw0KaW5kZXggYTMwYmI1MzZmYzhhLi4yODU2N2UyZTRhNjUgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzZ4MDJfdXNiX21j
dS5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzZ4MDJfdXNi
X21jdS5jDQpAQCAtMTExLDcgKzExMSw3IEBAIF9fbXQ3NngwMnVfbWN1X3NlbmRfbXNnKHN0cnVj
dCBtdDc2X2RldiAqZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KIAlpZiAod2FpdF9yZXNwKQ0K
IAkJcmV0ID0gbXQ3NngwMnVfbWN1X3dhaXRfcmVzcChkZXYsIHNlcSk7DQogDQotCWNvbnN1bWVf
c2tiKHNrYik7DQorCWRldl9rZnJlZV9za2Ioc2tiKTsNCiANCiAJcmV0dXJuIHJldDsNCiB9DQot
LSANCjIuMjUuMQ0K

