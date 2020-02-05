Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE9315254E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2020 04:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgBEDrG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Feb 2020 22:47:06 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:49657 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727792AbgBEDrG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Feb 2020 22:47:06 -0500
X-UUID: 03a792a462a845d5ba9f81c332988a16-20200205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jz7BtOn/G8LT4mRItKKrIs0A5WhRRkjr2DQoea+nrDY=;
        b=C8/L7eWez7bOK7N4a1RyxMHK9c3kyXxeNf27NgmhSrou12Ei4OYlO32IrnN/GaMtRAsRJMsI6xH2iKX1HfxTMY21a+6F+QCGDN2t/lkgckOSQLSPtY1N/1BrFjOXZBDcn8G6UATm/06YlUoxlknKnV/1CFmcLzADgJltp9Omzf8=;
X-UUID: 03a792a462a845d5ba9f81c332988a16-20200205
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 991039202; Wed, 05 Feb 2020 11:46:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 5 Feb 2020 11:47:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 5 Feb 2020 11:46:33 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Josh Boyer <jwboyer@kernel.org>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7615: fix wrong length in strncmp
Date:   Wed, 5 Feb 2020 11:46:54 +0800
Message-ID: <cee34bac9d6041784a92c5fdbf667c367dc7f968.1580874252.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rml4IGl0IHRvIHByb3BlciBsZW5ndGguDQoNClNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlk
ZXIubGVlQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3NjE1L21jdS5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzYxNS9tY3UuYw0KaW5kZXggNjYzOWY5MjkxNzIxLi5mYmRhNTYzNDJkMTEgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYw0K
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMNCkBA
IC00OTEsNyArNDkxLDcgQEAgc3RhdGljIGludCBtdDc2MTVfbG9hZF9yYW0oc3RydWN0IG10NzYx
NV9kZXYgKmRldikNCiAJCWdvdG8gb3V0Ow0KIAl9DQogDQotCWlmICghc3RybmNtcChoZHItPmZ3
X3ZlciwgIjIuMCIsIDYpKQ0KKwlpZiAoIXN0cm5jbXAoaGRyLT5md192ZXIsICIyLjAiLCAzKSkN
CiAJCWRldi0+ZndfdmVyID0gTVQ3NjE1X0ZJUk1XQVJFX1YyOw0KIAllbHNlDQogCQlkZXYtPmZ3
X3ZlciA9IE1UNzYxNV9GSVJNV0FSRV9WMTsNCi0tIA0KMi4xOC4wDQo=

