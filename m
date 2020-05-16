Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B1C1D5FDA
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2020 11:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgEPJFc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 May 2020 05:05:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55642 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726202AbgEPJFb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 May 2020 05:05:31 -0400
X-UUID: f3835ecfb7aa4bf693c5896f8486d2da-20200516
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=URhBg4iwpLNmGiEViy9OZtcCU3PfdFl2K8XTBaEHd50=;
        b=WSBMjWvhsJy7MZiUv1+1tyhqREgsEEl+lcMMhbAZuaWagX4s/oU/nKnd1FQLM5BtMExeVgLZWP8PcxC4c4THpuQNrtMtWRog/lCBOkw2ZBzuV6oDRP+RgZ4aYigKJwbrES1JBXZ5uE0c76zoLsmdrjikQo6KB3K/dyrRso9VldY=;
X-UUID: f3835ecfb7aa4bf693c5896f8486d2da-20200516
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1624334618; Sat, 16 May 2020 17:05:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 16 May 2020 17:05:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 May 2020 17:05:19 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] mt76: mt7915: fix some sparse warnings
Date:   Sat, 16 May 2020 17:05:18 +0800
Message-ID: <828924b331eb9524f851d0fb233904a45219b25d.1589619627.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B3065C127174FA7B057436D113CA35D79116B575A965D933B756D9CA975C11D12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhpcyBmaXhlcyB0aGUgZm9sbG93aW5nIHNwYXJzZSB3YXJuaW5nOg0KDQpkcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYzoyNTM6MTY6IHNwYXJzZTogc3BhcnNl
OiBtaXhpbmcgZGlmZmVyZW50IGVudW0gdHlwZXM6DQpkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9tY3UuYzoyNTM6MTY6IHNwYXJzZTogICAgdW5zaWduZWQgaW50IGVu
dW0gbXQ3OTE1X3R4cV9pZA0KZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
MTUvbWN1LmM6MjUzOjE2OiBzcGFyc2U6ICAgIHVuc2lnbmVkIGludCBlbnVtIG10NzZfdHhxX2lk
DQpkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYzo3NTg6NjM6
IHNwYXJzZTogc3BhcnNlOiBpbmNvcnJlY3QgdHlwZSBpbiBhcmd1bWVudCAyIChkaWZmZXJlbnQg
YWRkcmVzcyBzcGFjZXMpDQpkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzkx
NS9tY3UuYzo3NTg6NjM6IHNwYXJzZTogICAgZXhwZWN0ZWQgdW5zaWduZWQgY2hhciBjb25zdCBb
dXNlcnR5cGVdICppZXMNCmRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1
L21jdS5jOjc1ODo2Mzogc3BhcnNlOiAgICBnb3QgdW5zaWduZWQgY2hhciBjb25zdCBbbm9kZXJl
Zl0gPGFzbjo0PiAqDQpkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9t
Y3UuYzoxMzkwOjIzOiBzcGFyc2U6IHNwYXJzZTogaW5jb3JyZWN0IHR5cGUgaW4gYXJndW1lbnQg
MSAoZGlmZmVyZW50IGJhc2UgdHlwZXMpDQpkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkxNS9tY3UuYzoxMzkwOjIzOiBzcGFyc2U6ICAgIGV4cGVjdGVkIHVuc2lnbmVkIGlu
dCB3DQpkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYzoxMzkw
OjIzOiBzcGFyc2U6ICAgIGdvdCByZXN0cmljdGVkIF9fbGUzMiBbdXNlcnR5cGVdIHN1cHBfaHRf
bWNzDQpkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYzoxMzkw
OjIzOiBzcGFyc2U6IHNwYXJzZTogcmVzdHJpY3RlZCBfX2xlMzIgZGVncmFkZXMgdG8gaW50ZWdl
cg0KZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmM6MTQyOTo2
MDogc3BhcnNlOiBzcGFyc2U6IGJhZCBhc3NpZ25tZW50ICg+Pj0pIHRvIHJlc3RyaWN0ZWQgX19s
ZTE2DQpkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYzoxNzcz
OjE2OiBzcGFyc2U6IHNwYXJzZTogcmVzdHJpY3RlZCBfX2xlMzIgZGVncmFkZXMgdG8gaW50ZWdl
cg0KDQpGaXhlczogNjA5NGY4NmZiMzcxICgibXQ3NjogbXQ3OTE1OiBhZGQgSEUgYnNzX2NvbmYg
c3VwcG9ydCBmb3IgaW50ZXJmYWNlcyIpDQpSZXBvcnRlZC1ieToga2J1aWxkIHRlc3Qgcm9ib3Qg
PGxrcEBpbnRlbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRp
YXRlay5jb20+DQotLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzkx
NS9tY3UuYyB8IDExICsrKysrLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5MTUvbWN1LmMNCmluZGV4IGYwMGFkMmI2Njc2MS4uNmQ0ODA4YjEzYTQwIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMN
CisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jDQpA
QCAtMjIwLDcgKzIyMCw3IEBAIHN0YXRpYyBpbnQgX19tdDc5MTVfbWN1X21zZ19zZW5kKHN0cnVj
dCBtdDc5MTVfZGV2ICpkZXYsIHN0cnVjdCBza19idWZmICpza2IsDQogew0KIAlzdHJ1Y3QgbXQ3
OTE1X21jdV90eGQgKm1jdV90eGQ7DQogCXU4IHNlcSwgcGt0X2ZtdCwgcWlkeDsNCi0JZW51bSBt
dDc5MTVfdHhxX2lkIHR4cTsNCisJZW51bSBtdDc2X3R4cV9pZCB0eHE7DQogCV9fbGUzMiAqdHhk
Ow0KIAl1MzIgdmFsOw0KIA0KQEAgLTgxNSw4ICs4MTUsNyBAQCBzdGF0aWMgdm9pZCBtdDc5MTVf
Y2hlY2tfaGVfb2Jzc19uYXJyb3dfYndfcnVfaXRlcihzdHJ1Y3Qgd2lwaHkgKndpcGh5LA0KIAlz
dHJ1Y3QgbXQ3OTE1X2hlX29ic3NfbmFycm93X2J3X3J1X2RhdGEgKmRhdGEgPSBfZGF0YTsNCiAJ
Y29uc3Qgc3RydWN0IGVsZW1lbnQgKmVsZW07DQogDQotCWVsZW0gPSBjZmc4MDIxMV9maW5kX2Vs
ZW0oV0xBTl9FSURfRVhUX0NBUEFCSUxJVFksIGJzcy0+aWVzLT5kYXRhLA0KLQkJCQkgIGJzcy0+
aWVzLT5sZW4pOw0KKwllbGVtID0gaWVlZTgwMjExX2Jzc19nZXRfZWxlbShic3MsIFdMQU5fRUlE
X0VYVF9DQVBBQklMSVRZKTsNCiANCiAJaWYgKCFlbGVtIHx8IGVsZW0tPmRhdGFsZW4gPCAxMCB8
fA0KIAkgICAgIShlbGVtLT5kYXRhWzEwXSAmDQpAQCAtMTk1NCw3ICsxOTUzLDcgQEAgbXQ3OTE1
X21jdV9zdGFfcmF0ZV9jdHJsX3RsdihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbXQ3OTE1
X2RldiAqZGV2LA0KIA0KIAkJcmEtPnN1cHBfaHRfbWNzID0gKihfX2xlMzIgKilyYS0+aHRfbWNz
Ow0KIAkJcmEtPnN1cHBfbW9kZSB8PSBNT0RFX0hUOw0KLQkJbWNzID0gaHdlaWdodDMyKHJhLT5z
dXBwX2h0X21jcykgLSAxOw0KKwkJbWNzID0gaHdlaWdodDMyKGxlMzJfdG9fY3B1KHJhLT5zdXBw
X2h0X21jcykpIC0gMTsNCiAJCXJhLT5hZiA9IHN0YS0+aHRfY2FwLmFtcGR1X2ZhY3RvcjsNCiAJ
CXJhLT5odF9nZiA9ICEhKHN0YS0+aHRfY2FwLmNhcCAmIElFRUU4MDIxMV9IVF9DQVBfR1JOX0ZM
RCk7DQogDQpAQCAtMTk3Miw3ICsxOTcxLDcgQEAgbXQ3OTE1X21jdV9zdGFfcmF0ZV9jdHJsX3Rs
dihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LA0KIAl9DQogDQog
CWlmIChzdGEtPnZodF9jYXAudmh0X3N1cHBvcnRlZCkgew0KLQkJX19sZTE2IG1jc19tYXAgPSBz
dGEtPnZodF9jYXAudmh0X21jcy5yeF9tY3NfbWFwOw0KKwkJdTE2IG1jc19tYXAgPSBsZTE2X3Rv
X2NwdShzdGEtPnZodF9jYXAudmh0X21jcy5yeF9tY3NfbWFwKTsNCiAJCXUxNiB2aHRfbWNzOw0K
IAkJdTggYWYsIG1jc19wcmV2Ow0KIA0KQEAgLTIzOTksNyArMjM5OCw3IEBAIHN0YXRpYyBpbnQg
bXQ3OTE1X21jdV9pbml0X2Rvd25sb2FkKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHUzMiBhZGRy
LA0KIAl9Ow0KIAlpbnQgYXR0cjsNCiANCi0JaWYgKHJlcS5hZGRyID09IE1DVV9QQVRDSF9BRERS
RVNTKQ0KKwlpZiAocmVxLmFkZHIgPT0gY3B1X3RvX2xlMzIoTUNVX1BBVENIX0FERFJFU1MpKQ0K
IAkJYXR0ciA9IC1NQ1VfQ01EX1BBVENIX1NUQVJUX1JFUTsNCiAJZWxzZQ0KIAkJYXR0ciA9IC1N
Q1VfQ01EX1RBUkdFVF9BRERSRVNTX0xFTl9SRVE7DQotLSANCjIuMTguMA0K

