Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696911F8A09
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2020 20:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgFNSXr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Jun 2020 14:23:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:21439 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726857AbgFNSXq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Jun 2020 14:23:46 -0400
X-UUID: 6aca73ed846a4490b7138fd192ce79bf-20200615
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DR/QwOiy7DR8h4Z/9L2Jab/8wPEsmQ3UrzfyTt+17nU=;
        b=L3f1Ua0KaEkjpD0GCoPfD63Gvs3LFMr8HryVSTR3qfGXJt/VIsaaWw+Ie1nTBg/8l6BQ5evwjfyKecKo/1FTiEQBqvMlstFIm8n9/XRUEp1wsu+t0ILVlOVVdnq2d2m5Z92GUfbf67hET1vRXdPrWyOKs2i0vcvvRUSDCpqhrxg=;
X-UUID: 6aca73ed846a4490b7138fd192ce79bf-20200615
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 372453518; Mon, 15 Jun 2020 02:23:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 15 Jun 2020 02:23:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 15 Jun 2020 02:23:34 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 1/4] mt76: mt7915: add missing CONFIG_MAC80211_DEBUGFS
Date:   Mon, 15 Jun 2020 02:23:33 +0800
Message-ID: <2863c9a7e14c791202738597184f4a6b75d5bc07.1592158312.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1592158312.git.ryder.lee@mediatek.com>
References: <cover.1592158312.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWRkIENPTkZJR19NQUM4MDIxMV9ERUJVR0ZTIHRvIGZpeCBhIHJlcG9ydGVkIHdhcm5pbmcuDQoN
CkZpeGVzOiBlYzk3NDJhICgibXQ3NjogbXQ3OTE1OiBhZGQgLnN0YV9hZGRfZGVidWdmcyBzdXBw
b3J0IikNClJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NClNp
Z25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2RlYnVnZnMuYyB8IDIgKysN
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9kZWJ1Z2ZzLmMNCmluZGV4IDUyNzhiZWU4
MTJmMS4uN2U0OGY1NmI1YjA4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc5MTUvZGVidWdmcy5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzkxNS9kZWJ1Z2ZzLmMNCkBAIC0zODQsNiArMzg0LDcgQEAgaW50IG10
NzkxNV9pbml0X2RlYnVnZnMoc3RydWN0IG10NzkxNV9kZXYgKmRldikNCiAJcmV0dXJuIDA7DQog
fQ0KIA0KKyNpZmRlZiBDT05GSUdfTUFDODAyMTFfREVCVUdGUw0KIC8qKiBwZXItc3RhdGlvbiBk
ZWJ1Z2ZzICoqLw0KIA0KIC8qIHVzYWdlOiA8dHggbW9kZT4gPGxkcGM+IDxzdGJjPiA8Ync+IDxn
aT4gPG5zcz4gPG1jcz4gKi8NCkBAIC00NjEsMyArNDYyLDQgQEAgdm9pZCBtdDc5MTVfc3RhX2Fk
ZF9kZWJ1Z2ZzKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAq
dmlmLA0KIAlkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJmaXhlZF9yYXRlIiwgMDYwMCwgZGlyLCBzdGEs
ICZmb3BzX2ZpeGVkX3JhdGUpOw0KIAlkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJzdGF0cyIsIDA0MDAs
IGRpciwgc3RhLCAmZm9wc19zdGFfc3RhdHMpOw0KIH0NCisjZW5kaWYNCi0tIA0KMi4xOC4wDQo=

