Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B29532D43B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 14:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241302AbhCDNcg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Mar 2021 08:32:36 -0500
Received: from mailgw01.mediatek.com ([216.200.240.184]:3454 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241303AbhCDNc1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Mar 2021 08:32:27 -0500
X-UUID: ee0d427a2b3c457d8122f1b3b2c5ceb8-20210304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/bIZFIKuZhS1KaY00v9VcBNLL1ej0s7pxGvIPUKeREs=;
        b=hESFubvQ9lSXs6bzUbF43s3qAX9mswJMDOcyGAtS7Z12e5ohN2jzMPu48+S6jffqfB0SK6nq6nwSVg633B6rXXFGKuJqfR2UviChWs/jUSzb9VtJjsd8T6iXXOeLoBTEys6WiAr7aR40ZuKXMvytmN4zCs01IcDrjAJuaBXI9nI=;
X-UUID: ee0d427a2b3c457d8122f1b3b2c5ceb8-20210304
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1822701874; Thu, 04 Mar 2021 05:30:06 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 4 Mar 2021 05:25:25 -0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Mar 2021 21:25:24 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/3] mt76: mt7663: fix when beacon filter is being applied
Date:   Thu, 4 Mar 2021 21:25:21 +0800
Message-ID: <801a2aa986f5486a0e789065feef7b77c612ea7b.1614863741.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpIVyBiZWFjb24gZmls
dGVyIGNvbW1hbmQgaXMgYmVpbmcgYXBwbGllZCB1bnRpbCB3ZSdyZSBpbiBhc3NvY2lhdGVkIHN0
YXRlDQpiZWNhdXNlIHRoZSBjb21tYW5kIHdvdWxkIHJlbHkgb24gdGhlIGFzc29jaWF0ZWQgYWNj
ZXNzIHBvaW50J3MgYmVhY29uDQppbnRlcnZhbCBhbmQgRFRJTSBpbmZvcm1hdGlvbi4NCg0KRml4
ZXM6IDcxMjQxOThhYjFhNCAoIm10NzY6IG10NzYxNTogZW5hYmxlIGJlYWNvbiBmaWx0ZXJpbmcg
YnkgZGVmYXVsdCBmb3Igb2ZmbG9hZCBmdyIpDQpTaWduZWQtb2ZmLWJ5OiBTZWFuIFdhbmcgPHNl
YW4ud2FuZ0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L210NzYxNS9tYWluLmMgfCA2ICsrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tYWluLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzYxNS9tYWluLmMNCmluZGV4IDFhYTY5MjhmODhmYy4uMWNiMzEwYmYw
MWVlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2
MTUvbWFpbi5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYx
NS9tYWluLmMNCkBAIC0yMTcsOCArMjE3LDYgQEAgc3RhdGljIGludCBtdDc2MTVfYWRkX2ludGVy
ZmFjZShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywNCiAJcmV0ID0gbXQ3NjE1X21jdV9hZGRfZGV2
X2luZm8ocGh5LCB2aWYsIHRydWUpOw0KIAlpZiAocmV0KQ0KIAkJZ290byBvdXQ7DQotDQotCW10
NzYxNV9tYWNfc2V0X2JlYWNvbl9maWx0ZXIocGh5LCB2aWYsIHRydWUpOw0KIG91dDoNCiAJbXQ3
NjE1X211dGV4X3JlbGVhc2UoZGV2KTsNCiANCkBAIC0yNDQsNyArMjQyLDYgQEAgc3RhdGljIHZv
aWQgbXQ3NjE1X3JlbW92ZV9pbnRlcmZhY2Uoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsDQogDQog
CW10NzZfY29ubmFjX2ZyZWVfcGVuZGluZ190eF9za2JzKCZkZXYtPnBtLCAmbXN0YS0+d2NpZCk7
DQogDQotCW10NzYxNV9tYWNfc2V0X2JlYWNvbl9maWx0ZXIocGh5LCB2aWYsIGZhbHNlKTsNCiAJ
bXQ3NjE1X21jdV9hZGRfZGV2X2luZm8ocGh5LCB2aWYsIGZhbHNlKTsNCiANCiAJcmN1X2Fzc2ln
bl9wb2ludGVyKGRldi0+bXQ3Ni53Y2lkW2lkeF0sIE5VTEwpOw0KQEAgLTU0OCw2ICs1NDUsOSBA
QCBzdGF0aWMgdm9pZCBtdDc2MTVfYnNzX2luZm9fY2hhbmdlZChzdHJ1Y3QgaWVlZTgwMjExX2h3
ICpodywNCiAJaWYgKGNoYW5nZWQgJiBCU1NfQ0hBTkdFRF9BUlBfRklMVEVSKQ0KIAkJbXQ3NjE1
X21jdV91cGRhdGVfYXJwX2ZpbHRlcihodywgdmlmLCBpbmZvKTsNCiANCisJaWYgKGNoYW5nZWQg
JiBCU1NfQ0hBTkdFRF9BU1NPQykNCisJCW10NzYxNV9tYWNfc2V0X2JlYWNvbl9maWx0ZXIocGh5
LCB2aWYsIGluZm8tPmFzc29jKTsNCisNCiAJbXQ3NjE1X211dGV4X3JlbGVhc2UoZGV2KTsNCiB9
DQogDQotLSANCjIuMjUuMQ0K

