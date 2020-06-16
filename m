Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2107F1FB114
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 14:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgFPMrC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 08:47:02 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:17121 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbgFPMrC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 08:47:02 -0400
X-UUID: 6ab7a681ab6648f7867b780c320cff90-20200616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zlMoMDUbTsExrKd8RFq8cHNFiYg9RxmBmUZDOlfOEwY=;
        b=YBYgl4UGPxsMrRjq5R5U4SxhKri0FJXqSPMB1SA6lwq2xxqvtF7APOfgH227DlS//4TqHmlDYUQGvVqtYfWh7+QGAgjqBgrdccbXF6X2LjUQftcB243pL50D+GjrdT/CoTT8TR/LJUve5JSoND0ZPdG4H6JhIEPvikF0gnP1mcU=;
X-UUID: 6ab7a681ab6648f7867b780c320cff90-20200616
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 191896191; Tue, 16 Jun 2020 20:46:57 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Jun 2020 20:46:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Jun 2020 20:46:54 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 2/4] mt76: extend DT rate power limits to support 11ax devices
Date:   Tue, 16 Jun 2020 20:46:11 +0800
Message-ID: <08d8c206b15e705489fab96dbe9dd8a77874c4a4.1592276165.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <9ae2b6233284b60206e3513f7bf2eb03d2fbd724.1592276165.git.ryder.lee@mediatek.com>
References: <9ae2b6233284b60206e3513f7bf2eb03d2fbd724.1592276165.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RW5hYmxlIHBhcnNpbmcgcGVyLXJhdGUgdHhwb3dlciBsaW1pdHMgZnJvbSBEVCBmb3IgMTFheCBj
aGlwc2V0cy4NCg0KVGVzdGVkLWJ5OiBFdmVseW4gVHNhaSA8ZXZlbHluLnRzYWlAbWVkaWF0ZWsu
Y29tPg0KU2lnbmVkLW9mZi1ieTogU2hheW5lIENoZW4gPHNoYXluZS5jaGVuQG1lZGlhdGVrLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvZWVwcm9tLmMgfCA2
MyArKysrKysrKysrKysrKy0tLS0tLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzYuaCAgIHwgIDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwg
MjAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L2VlcHJvbS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9l
ZXByb20uYw0KaW5kZXggMzM0NjA2YjA3NjkzLi44N2E1ZDJkYjA1ZTEgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L2VlcHJvbS5jDQorKysgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L2VlcHJvbS5jDQpAQCAtMjIxLDYgKzIyMSw0MSBA
QCBtdDc2X2FwcGx5X2FycmF5X2xpbWl0KHM4ICpwd3IsIHNpemVfdCBwd3JfbGVuLCBjb25zdCBf
X2JlMzIgKmRhdGEsDQogCX0NCiB9DQogDQorc3RhdGljIHZvaWQNCittdDc2X2FwcGx5X21jc19s
aW1pdChzdHJ1Y3QgbXQ3Nl9wb3dlcl9saW1pdHMgKmRlc3QsIHUzMiBtY3NfcmF0ZXMsDQorCQkg
ICAgIGNvbnN0IF9fYmUzMiAqZGF0YSwgc2l6ZV90IGxlbiwgczggdGFyZ2V0X3Bvd2VyLA0KKwkJ
ICAgICBzOCBuc3NfZGVsdGEsIHM4ICptYXhfcG93ZXIpDQorew0KKwlzOCAqcHdyID0gKHM4ICop
ZGVzdC0+bWNzOw0KKwl1OCBwd3JfbnVtID0gQVJSQVlfU0laRShkZXN0LT5tY3MpLCBwd3JfbGVu
ID0gQVJSQVlfU0laRShkZXN0LT5tY3NbMF0pOw0KKwlpbnQgaSwgY3VyOw0KKw0KKwlpZiAobWNz
X3JhdGVzID09IEFSUkFZX1NJWkUoZGVzdC0+cnVbMF0pKSB7DQorCQlwd3IgPSAoczggKilkZXN0
LT5ydTsNCisJCXB3cl9udW0gPSBBUlJBWV9TSVpFKGRlc3QtPnJ1KTsNCisJCXB3cl9sZW4gPSBB
UlJBWV9TSVpFKGRlc3QtPnJ1WzBdKTsNCisJfQ0KKw0KKwlsZW4gLz0gNDsNCisJY3VyID0gYmUz
Ml90b19jcHUoZGF0YVswXSk7DQorCWZvciAoaSA9IDA7IGkgPCBwd3JfbnVtOyBpKyspIHsNCisJ
CWlmIChsZW4gPCBtY3NfcmF0ZXMgKyAxKQ0KKwkJCWJyZWFrOw0KKw0KKwkJbXQ3Nl9hcHBseV9h
cnJheV9saW1pdChwd3IgKyBwd3JfbGVuICogaSwgcHdyX2xlbiwgZGF0YSArIDEsDQorCQkJCSAg
ICAgICB0YXJnZXRfcG93ZXIsIG5zc19kZWx0YSwgbWF4X3Bvd2VyKTsNCisJCWlmICgtLWN1ciA+
IDApDQorCQkJY29udGludWU7DQorDQorCQlkYXRhICs9IG1jc19yYXRlcyArIDE7DQorCQlsZW4g
LT0gbWNzX3JhdGVzICsgMTsNCisJCWlmICghbGVuKQ0KKwkJCWJyZWFrOw0KKw0KKwkJY3VyID0g
YmUzMl90b19jcHUoZGF0YVswXSk7DQorCX0NCit9DQorDQogczggbXQ3Nl9nZXRfcmF0ZV9wb3dl
cl9saW1pdHMoc3RydWN0IG10NzZfcGh5ICpwaHksDQogCQkJICAgICAgc3RydWN0IGllZWU4MDIx
MV9jaGFubmVsICpjaGFuLA0KIAkJCSAgICAgIHN0cnVjdCBtdDc2X3Bvd2VyX2xpbWl0cyAqZGVz
dCwNCkBAIC0yMzEsOSArMjY2LDkgQEAgczggbXQ3Nl9nZXRfcmF0ZV9wb3dlcl9saW1pdHMoc3Ry
dWN0IG10NzZfcGh5ICpwaHksDQogCWNvbnN0IF9fYmUzMiAqdmFsOw0KIAljaGFyIG5hbWVbMTZd
Ow0KIAl1MzIgbWNzX3JhdGVzID0gZGV2LT5kcnYtPm1jc19yYXRlczsNCisJdTMyIHJ1X3JhdGVz
ID0gQVJSQVlfU0laRShkZXN0LT5ydVswXSk7DQogCWNoYXIgYmFuZDsNCiAJc2l6ZV90IGxlbjsN
Ci0JaW50IGksIGN1cjsNCiAJczggbWF4X3Bvd2VyID0gMDsNCiAJczggdHhzX2RlbHRhOw0KIA0K
QEAgLTI4MiwyNiArMzE3LDE0IEBAIHM4IG10NzZfZ2V0X3JhdGVfcG93ZXJfbGltaXRzKHN0cnVj
dCBtdDc2X3BoeSAqcGh5LA0KIAl2YWwgPSBtdDc2X2dldF9vZl9hcnJheShucCwgIm1jcyIsICZs
ZW4sIG1jc19yYXRlcyArIDEpOw0KIAlpZiAoIXZhbCkNCiAJCXJldHVybiBtYXhfcG93ZXI7DQor
CW10NzZfYXBwbHlfbWNzX2xpbWl0KGRlc3QsIG1jc19yYXRlcywgdmFsLCBsZW4sIHRhcmdldF9w
b3dlciwNCisJCQkgICAgIHR4c19kZWx0YSwgJm1heF9wb3dlcik7DQogDQotCWxlbiAvPSA0Ow0K
LQljdXIgPSBiZTMyX3RvX2NwdSh2YWxbMF0pOw0KLQlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0la
RShkZXN0LT5tY3MpOyBpKyspIHsNCi0JCWlmIChsZW4gPCBtY3NfcmF0ZXMgKyAxKQ0KLQkJCWJy
ZWFrOw0KLQ0KLQkJbXQ3Nl9hcHBseV9hcnJheV9saW1pdChkZXN0LT5tY3NbaV0sIEFSUkFZX1NJ
WkUoZGVzdC0+bWNzW2ldKSwNCi0JCQkJICAgICAgIHZhbCArIDEsIHRhcmdldF9wb3dlciwgdHhz
X2RlbHRhLA0KLQkJCQkgICAgICAgJm1heF9wb3dlcik7DQotCQlpZiAoLS1jdXIgPiAwKQ0KLQkJ
CWNvbnRpbnVlOw0KLQ0KLQkJdmFsICs9IG1jc19yYXRlcyArIDE7DQotCQlsZW4gLT0gbWNzX3Jh
dGVzICsgMTsNCi0JCWlmICghbGVuKQ0KLQkJCWJyZWFrOw0KLQ0KLQkJY3VyID0gYmUzMl90b19j
cHUodmFsWzBdKTsNCi0JfQ0KKwl2YWwgPSBtdDc2X2dldF9vZl9hcnJheShucCwgInJ1IiwgJmxl
biwgcnVfcmF0ZXMgKyAxKTsNCisJaWYgKCF2YWwpDQorCQlyZXR1cm4gbWF4X3Bvd2VyOw0KKwlt
dDc2X2FwcGx5X21jc19saW1pdChkZXN0LCBydV9yYXRlcywgdmFsLCBsZW4sIHRhcmdldF9wb3dl
ciwNCisJCQkgICAgIHR4c19kZWx0YSwgJm1heF9wb3dlcik7DQogDQogCXJldHVybiBtYXhfcG93
ZXI7DQogfQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3Ni5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmgNCmluZGV4
IDljNTQ4OGZmYmU1ZS4uZDUwODcxNjUzZGUxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmgNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3Ni5oDQpAQCAtNTg0LDYgKzU4NCw3IEBAIHN0cnVjdCBtdDc2X3Bvd2Vy
X2xpbWl0cyB7DQogCXM4IGNja1s0XTsNCiAJczggb2ZkbVs4XTsNCiAJczggbWNzWzRdWzEwXTsN
CisJczggcnVbN11bMTJdOw0KIH07DQogDQogZW51bSBtdDc2X3BoeV90eXBlIHsNCi0tIA0KMi4x
OC4wDQo=

