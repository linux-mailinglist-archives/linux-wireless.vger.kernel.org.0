Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154BE1CDFFD
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 18:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbgEKQGy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 12:06:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54327 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730628AbgEKQGx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 12:06:53 -0400
X-UUID: fa73c2015b944f788dbd8001706ddc12-20200512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GiF5ILJq4wBAN4esndmcCiavOhFccrw4Q/IlNZ6dRuQ=;
        b=NizgOmG0S93BlGeHZ/7WiyP5HqPnbY0LTl3JokMzE9C8HM1F9/G0RAMeufjMtSgHEDkZQt0KGRVoQTGDcmv3ClHgl5KhsUl85xHOEVIJlCeFYO7HJq+rFLe54is1CvElf1PmeBkaf5Wraiex8lnkoWfOmSK59103WMQFl33lmWM=;
X-UUID: fa73c2015b944f788dbd8001706ddc12-20200512
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1459691715; Tue, 12 May 2020 00:06:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 12 May 2020 00:06:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 May 2020 00:06:39 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 0/7] MT7915: add TxBF support
Date:   Tue, 12 May 2020 00:06:31 +0800
Message-ID: <cover.1589212457.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhpcyBlbmFibGVzIHRoZSBTVSBUeCBiZWFtZm9ybWluZyBzdXBwb3J0IG9uIE1UNzkxNSwgYW5k
IHdpbGwgZW5hYmxlIE1VIHBhcnQgc29vbi4NCg0KUnlkZXINCg0KUnlkZXIgTGVlICg3KToNCiAg
bXQ3NjogbXQ3OTE1OiBpbnRyb2R1Y2UgbXQ3OTE1X2dldF9oZV9waHlfY2FwDQogIG10NzY6IG10
NzkxNTogYWRkIFR4IGJlYW1mb3JtZXIgc3VwcG9ydA0KICBtdDc2OiBtdDc5MTU6IGFkZCBUeCBi
ZWFtZm9ybWVlIHN1cHBvcnQNCiAgbXQ3NjogbXQ3OTE1OiBhZGQgVHhCRiBjYXBhYmlsaXRpZXMN
CiAgbXQ3NjogbXQ3OTE1OiBhZGQgZGVidWdmcyB0byB0cmFjayBUeEJGIHN0YXR1cw0KICBtdDc2
OiBtdDc5MTU6IGFsbG9jYXRlIHByb3BlciBzaXplIGZvciB0bHYgdGFncw0KICBtdDc2OiBtdDc5
MTU6IGZpeCBwb3NzaWJsZSBkZWFkbG9jayBpbiBtdDc5MTVfc3RvcA0KDQogLi4uL3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3OTE1L2RlYnVnZnMuYyAgIHwgIDQ1ICsrDQogLi4uL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMgIHwgMTE4ICsrKystDQogLi4uL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWMuYyAgIHwgIDQ5ICstDQogLi4uL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMgIHwgIDI4ICstDQogLi4uL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYyAgIHwgNDU3ICsrKysrKysrKysrKysr
KystLQ0KIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmggICB8ICA5
OSArKystDQogLi4uL3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L210NzkxNS5oICAgIHwg
ICA5ICstDQogLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9yZWdzLmggIHwg
IDIwICsNCiA4IGZpbGVzIGNoYW5nZWQsIDczNCBpbnNlcnRpb25zKCspLCA5MSBkZWxldGlvbnMo
LSkNCg0KLS0gDQoyLjE4LjANCg==

