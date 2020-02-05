Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4B40153829
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2020 19:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBESbx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Feb 2020 13:31:53 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:16639 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727309AbgBESbx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Feb 2020 13:31:53 -0500
X-UUID: d94d3524aa2e478aa8d6672e92ac9058-20200206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xxlgbnU5pSZKUH3JfH939pFWVo6iRlJ+wxus9Y1Vfak=;
        b=oVpRXewEMkQmz2lTlwRsfnqfUx21siz6lK1fuRA3uB+rqi2tmsBsmWWk7OUhpLPzfYtDHE05OLFxmls5ljN1MTUs9ZprC/LuzgUHMDgoPQgIgchJie9kB7F6EI+5CVSelUT+jqgjPchNvJqh0VNpBoTH2zRg6NfePbjM39fCLvc=;
X-UUID: d94d3524aa2e478aa8d6672e92ac9058-20200206
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2026006206; Thu, 06 Feb 2020 02:31:48 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 6 Feb 2020 02:32:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 6 Feb 2020 02:31:22 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Chih-Min Chen <chih-min.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2] mt76: mt7615: set proper length in strncmp
Date:   Thu, 6 Feb 2020 02:31:19 +0800
Message-ID: <06da8143b6baa77295abaf70907fb8e345e15e0e.1580927122.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VXNlIHNpemVvZihoZHItPmZ3X3ZlcikgYXMgbWF4IGxlbi4NCg0KU2lnbmVkLW9mZi1ieTogUnlk
ZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KLS0tDQpjaGFuZ2VzIHNpbmNlIHYyIC0g
dXNlIHNpemVvZigpIGluc3RlYWQuDQotLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L210NzYxNS9tY3UuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3NjE1L21jdS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc2MTUvbWN1LmMNCmluZGV4IDY2MzlmOTI5MTcyMS4uYzNjMDFlMDk1OTI2IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMN
CisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21jdS5jDQpA
QCAtNDkxLDcgKzQ5MSw3IEBAIHN0YXRpYyBpbnQgbXQ3NjE1X2xvYWRfcmFtKHN0cnVjdCBtdDc2
MTVfZGV2ICpkZXYpDQogCQlnb3RvIG91dDsNCiAJfQ0KIA0KLQlpZiAoIXN0cm5jbXAoaGRyLT5m
d192ZXIsICIyLjAiLCA2KSkNCisJaWYgKCFzdHJuY21wKGhkci0+ZndfdmVyLCAiMi4wIiwgc2l6
ZW9mKGhkci0+ZndfdmVyKSkpDQogCQlkZXYtPmZ3X3ZlciA9IE1UNzYxNV9GSVJNV0FSRV9WMjsN
CiAJZWxzZQ0KIAkJZGV2LT5md192ZXIgPSBNVDc2MTVfRklSTVdBUkVfVjE7DQotLSANCjIuMTgu
MA0K

