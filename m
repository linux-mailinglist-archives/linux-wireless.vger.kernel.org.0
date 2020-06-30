Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2819F20ECB3
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 06:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgF3EiC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jun 2020 00:38:02 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:18903 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726710AbgF3EiC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jun 2020 00:38:02 -0400
X-UUID: 3eb3c89b4f1344fc8e37c960ea0ecaa4-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=77cQOpQ5AtB0qWOQGEEMr01KtYjsozyTdiVCSYv03Yw=;
        b=W3zTX7afVMhUj0OQdSRSdQpfwLKLafXWrVBUiIusxocnYF+foEhz29w4t7zoOHQhP84BOV5zJT60yv9SZuNXhX/CHfENUgD6RtlcFrz43N/V8m3ySV7v/AEaanVEsYa2iPKCkRK+M4LNbMDK7Zvy7ihn7Kv6g2RA6ooFvsN5gss=;
X-UUID: 3eb3c89b4f1344fc8e37c960ea0ecaa4-20200630
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1743755523; Tue, 30 Jun 2020 12:37:58 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Jun 2020 12:37:55 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 12:37:57 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 3/3] mt76: mt7615: fix potential memory leak in mcu message handler
Date:   Tue, 30 Jun 2020 12:37:51 +0800
Message-ID: <b1dc67b62bcc53ad02e86099ac0aab312109094b.1593491298.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5e8786d9cf0ccd09dd9c13c24c48ce441afbf0ff.1593491298.git.sean.wang@mediatek.com>
References: <5e8786d9cf0ccd09dd9c13c24c48ce441afbf0ff.1593491298.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpGaXggcG90ZW50aWFs
IG1lbW9yeSBsZWFrIGluIG1jdSBtZXNzYWdlIGhhbmRsZXIgb24gZXJyb3IgY29uZGl0aW9uLg0K
DQpGaXhlczogMGU2YTI5ZTQ3N2YzICgibXQ3NjogbXQ3NjE1OiBhZGQgc3VwcG9ydCB0byByZWFk
IHRlbXBlcmF0dXJlIGZyb20gbWN1IikNClNpZ25lZC1vZmYtYnk6IFNlYW4gV2FuZyA8c2Vhbi53
YW5nQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3NjE1L21jdS5jIHwgNyArKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3NjE1L21jdS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMNCmluZGV4IDFiNDZjY2NkOTNjNS4uNThlMzgzOGEzZGJhIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1
LmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21jdS5j
DQpAQCAtMTgzLDggKzE4MywxMCBAQCBtdDc2MTVfbWN1X3BhcnNlX3Jlc3BvbnNlKHN0cnVjdCBt
dDc2MTVfZGV2ICpkZXYsIGludCBjbWQsDQogCXN0cnVjdCBtdDc2MTVfbWN1X3J4ZCAqcnhkID0g
KHN0cnVjdCBtdDc2MTVfbWN1X3J4ZCAqKXNrYi0+ZGF0YTsNCiAJaW50IHJldCA9IDA7DQogDQot
CWlmIChzZXEgIT0gcnhkLT5zZXEpDQotCQlyZXR1cm4gLUVBR0FJTjsNCisJaWYgKHNlcSAhPSBy
eGQtPnNlcSkgew0KKwkJcmV0ID0gLUVBR0FJTjsNCisJCWdvdG8gb3V0Ow0KKwl9DQogDQogCXN3
aXRjaCAoY21kKSB7DQogCWNhc2UgTUNVX0NNRF9QQVRDSF9TRU1fQ09OVFJPTDoNCkBAIC0yMTUs
NiArMjE3LDcgQEAgbXQ3NjE1X21jdV9wYXJzZV9yZXNwb25zZShzdHJ1Y3QgbXQ3NjE1X2RldiAq
ZGV2LCBpbnQgY21kLA0KIAlkZWZhdWx0Og0KIAkJYnJlYWs7DQogCX0NCitvdXQ6DQogCWRldl9r
ZnJlZV9za2Ioc2tiKTsNCiANCiAJcmV0dXJuIHJldDsNCi0tIA0KMi4yNS4xDQo=

