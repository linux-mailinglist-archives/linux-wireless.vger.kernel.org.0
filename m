Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70D71F7CE2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2020 20:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgFLSaS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jun 2020 14:30:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:61842 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726268AbgFLSaS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jun 2020 14:30:18 -0400
X-UUID: d4ab8eb481e74834b3f1fd1e48fa560c-20200613
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DR/QwOiy7DR8h4Z/9L2Jab/8wPEsmQ3UrzfyTt+17nU=;
        b=KAxePdCYKUHPDIc+iFQixKHs/NcJU+Wi9pJNJZasJbZRws8zuOKbt+lBwf+5wzXcln2SJLLtgELJlmWuxDLOE1UFC/uqYOtgCmBPYtFDqUAH6WkR6iG8x0ANdJUPtZeVjgR0yzz567A3wT24/gmba0m+c65QVQRXNJzBGxqW+AM=;
X-UUID: d4ab8eb481e74834b3f1fd1e48fa560c-20200613
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1625286328; Sat, 13 Jun 2020 02:30:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 13 Jun 2020 02:30:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 13 Jun 2020 02:30:09 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 1/3] mt76: mt7915: add missing CONFIG_MAC80211_DEBUGFS
Date:   Sat, 13 Jun 2020 02:30:08 +0800
Message-ID: <2863c9a7e14c791202738597184f4a6b75d5bc07.1591983283.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 497600C2256EF5EB818657D376B1AF7AA6C69D695361B82EAFC67C6E4542F0CC2000:8
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

