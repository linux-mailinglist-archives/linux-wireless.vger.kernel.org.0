Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426F51D5FD9
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2020 11:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgEPJFa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 May 2020 05:05:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51539 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726264AbgEPJFa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 May 2020 05:05:30 -0400
X-UUID: 020b3d02cb814b8aa8f1f5e40b899b2d-20200516
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WNNopO1zUNPM7KUT8zRztqjX7ggEw2/JQe+88S48eE4=;
        b=HChVdeEHgaafMWOsiPXgKbHwh16R/gF9aKl7G1h4tO9vqYKwfXv2N/IwIQgk4SaU21X7kC2Ivv+mrJ9ee2UJiLYEzkj496TnGtVvSwjUwMBM3fkrFv/IfV089ZML/u60i83jrNxQEPS8aoBbI6BeehIOF4sS5OBrbZZoFnWPqiU=;
X-UUID: 020b3d02cb814b8aa8f1f5e40b899b2d-20200516
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 537331515; Sat, 16 May 2020 17:05:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 16 May 2020 17:05:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 May 2020 17:05:20 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] mt76: mt7915: fix sparse warnings: incorrect type initializer
Date:   Sat, 16 May 2020 17:05:19 +0800
Message-ID: <c74093f29209201bdb5cf889d5f2aac30c9e6755.1589619627.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <828924b331eb9524f851d0fb233904a45219b25d.1589619627.git.ryder.lee@mediatek.com>
References: <828924b331eb9524f851d0fb233904a45219b25d.1589619627.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CEC5AC64FA5F151626272EEF82E48F39022734BDA928C831C290103E25CDE96F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmM6MjMxNzozMTog
c3BhcnNlOiBzcGFyc2U6DQppbmNvcnJlY3QgdHlwZSBpbiBpbml0aWFsaXplciAoZGlmZmVyZW50
IGJhc2UgdHlwZXMpDQoNCkZpeGVzOiA1NTE3Zjc4YjAwNjMgKCJtdDc2OiBtdDc5MTU6IGVuYWJs
ZSBmaXJtd2FyZSBtb2R1bGUgZGVidWcgc3VwcG9ydCIpDQpSZXBvcnRlZC1ieToga2J1aWxkIHRl
c3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVy
LmxlZUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkxNS9tY3UuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3OTE1L21jdS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MTUvbWN1LmMNCmluZGV4IDZkNDgwOGIxM2E0MC4uYWJkMDdjMmY0ZmY4IDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMNCisr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jDQpAQCAt
MjY3MSw3ICsyNjcxLDcgQEAgaW50IG10NzkxNV9tY3VfZndfZGJnX2N0cmwoc3RydWN0IG10Nzkx
NV9kZXYgKmRldiwgdTMyIG1vZHVsZSwgdTggbGV2ZWwpDQogCQl1MTYgbGVuOw0KIAkJdTggbGV2
ZWw7DQogCQl1OCByc3ZbM107DQotCQl1MzIgbW9kdWxlX2lkeDsNCisJCV9fbGUzMiBtb2R1bGVf
aWR4Ow0KIAl9IGRhdGEgPSB7DQogCQkubW9kdWxlX2lkeCA9IGNwdV90b19sZTMyKG1vZHVsZSks
DQogCQkubGV2ZWwgPSBsZXZlbCwNCi0tIA0KMi4xOC4wDQo=

