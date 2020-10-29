Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4622229F2B4
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 18:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbgJ2RL3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Oct 2020 13:11:29 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:42729 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbgJ2RL3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Oct 2020 13:11:29 -0400
X-UUID: f444395b662b4093bcb5a2fb14b6aca5-20201030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rHnJvyRuC+Q6pEX9APo1cQzlBAu7Gfh0TtiXRxOMke0=;
        b=hOc0acrZQS2FPCyZzWn0371tYmLMF6/9mtnBoF6Ej15ffN7fIPyV5PvyQobXonXI+dGErRH4OrLAcSy/UaToY1YoYJfNSXefOH4JMltrnIjyT1w9J3lvQdTWpgEnHnKn47BLt9eeDwwyTwquSSohk3sGQ3dB2pDpJRPph5Hu1jg=;
X-UUID: f444395b662b4093bcb5a2fb14b6aca5-20201030
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 387699569; Fri, 30 Oct 2020 01:11:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Oct 2020 01:11:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Oct 2020 01:11:17 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/3] mt76: mt7915: use BIT_ULL for omac_idx
Date:   Fri, 30 Oct 2020 01:11:15 +0800
Message-ID: <879705a8af8fa44c711feb3aa0351c1138aeef6c.1603988327.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3BF71E14A2E214604AF66DAD6A05602A8B54612CA0504207D3F5E955113D0C002000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhlIG9tYWNfaWR4IHZhcmlhYmxlIGlzIHU2NCBzbyB3ZSBzaG91bGQgdXNlIHRoZSA2NC1iaXQg
QklUX1VMTCgpLg0KDQpTaWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRl
ay5jb20+DQotLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9t
YWluLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210
NzkxNS9tYWluLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9t
YWluLmMNCmluZGV4IDY1MGRjYWQ0MzJkZS4uMjU0ZGI4YTZlMWRmIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFpbi5jDQorKysgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMNCkBAIC0yMzEsNyAr
MjMxLDcgQEAgc3RhdGljIHZvaWQgbXQ3OTE1X3JlbW92ZV9pbnRlcmZhY2Uoc3RydWN0IGllZWU4
MDIxMV9odyAqaHcsDQogDQogCW11dGV4X2xvY2soJmRldi0+bXQ3Ni5tdXRleCk7DQogCXBoeS0+
bXQ3Ni0+dmlmX21hc2sgJj0gfkJJVChtdmlmLT5pZHgpOw0KLQlwaHktPm9tYWNfbWFzayAmPSB+
QklUKG12aWYtPm9tYWNfaWR4KTsNCisJcGh5LT5vbWFjX21hc2sgJj0gfkJJVF9VTEwobXZpZi0+
b21hY19pZHgpOw0KIAltdXRleF91bmxvY2soJmRldi0+bXQ3Ni5tdXRleCk7DQogDQogCXNwaW5f
bG9ja19iaCgmZGV2LT5zdGFfcG9sbF9sb2NrKTsNCi0tIA0KMi4xOC4wDQo=

