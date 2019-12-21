Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8111287E8
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2019 08:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfLUHRN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Dec 2019 02:17:13 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:64701 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725774AbfLUHRN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Dec 2019 02:17:13 -0500
X-UUID: bbd62af5328e47f8bcbaee64d092f4f0-20191221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6a1RKfO0AH2bkibQkHqHEE9QU8OujxhL2WQH1gq5fq4=;
        b=cqqFjOccVxh6YQ/wcKv4ytO37RDX6T1qtnzbbrv3V7O3rKPnpQcI1Wwk32mnJxB49Qz3O4gZYIPflkviRyX2WvBBIoACxK/WgHJqctcqBbid4Dl4I3/dJOR6HebBcJw3gNsar9+hRCGy/Gx+x9aQlDe7Pj4chpn1PdFERl06pLw=;
X-UUID: bbd62af5328e47f8bcbaee64d092f4f0-20191221
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 367908377; Sat, 21 Dec 2019 15:17:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 21 Dec 2019 15:17:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 21 Dec 2019 15:16:20 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7615: fix MT7615_CFEND_RATE_DEFAULT value
Date:   Sat, 21 Dec 2019 15:17:00 +0800
Message-ID: <373ef6c1a4a0252cc21dde3f08e618a62629ba38.1576911997.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rml4IGRlZnVhbHQgQ0ZFTkRfUkFURSBhbmQgcmVwbGFjZSBoYXJkY29kZSB2YWx1ZXMuDQoNClNp
Z25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L2luaXQuYyAgIHwgNCArKy0t
DQogZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbXQ3NjE1LmggfCAz
ICsrLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUv
aW5pdC5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvaW5pdC5j
DQppbmRleCA0NDI3MzZjZWFiZTUuLjk0YTBkYzhiZmEyOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L2luaXQuYw0KKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvaW5pdC5jDQpAQCAtMzUsOCArMzUsOCBA
QCBzdGF0aWMgdm9pZCBtdDc2MTVfbWFjX2luaXQoc3RydWN0IG10NzYxNV9kZXYgKmRldikNCiAJ
bXQ3Nl93cihkZXYsIE1UX1RNQUNfVFJDUjEsIHZhbCk7DQogDQogCXZhbCA9IE1UX0FHR19BQ1Jf
UEtUX1RJTUVfRU4gfCBNVF9BR0dfQUNSX05PX0JBX0FSX1JVTEUgfA0KLQkgICAgICBGSUVMRF9Q
UkVQKE1UX0FHR19BQ1JfQ0ZFTkRfUkFURSwgMHg0OSkgfCAvKiAyNE0gKi8NCi0JICAgICAgRklF
TERfUFJFUChNVF9BR0dfQUNSX0JBUl9SQVRFLCAweDRiKTsgLyogNk0gKi8NCisJICAgICAgRklF
TERfUFJFUChNVF9BR0dfQUNSX0NGRU5EX1JBVEUsIE1UNzYxNV9DRkVORF9SQVRFX0RFRkFVTFQp
IHwNCisJICAgICAgRklFTERfUFJFUChNVF9BR0dfQUNSX0JBUl9SQVRFLCBNVDc2MTVfQkFSX1JB
VEVfREVGQVVMVCk7DQogCW10NzZfd3IoZGV2LCBNVF9BR0dfQUNSMCwgdmFsKTsNCiAJbXQ3Nl93
cihkZXYsIE1UX0FHR19BQ1IxLCB2YWwpOw0KIA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L210NzYxNS5oIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbXQ3NjE1LmgNCmluZGV4IDU1NGJkMDRkNmQ4MS4uNDg4
MTBlZGExY2Q2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc2MTUvbXQ3NjE1LmgNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3NjE1L210NzYxNS5oDQpAQCAtNDAsNyArNDAsOCBAQA0KICNkZWZpbmUgTVRfQ0hGUkVR
X0RCRENfSURYCUJJVCg2KQ0KICNkZWZpbmUgTVRfQ0hGUkVRX1NFUQkJR0VOTUFTSyg1LCAwKQ0K
IA0KLSNkZWZpbmUgTVQ3NjE1X0NGRU5EX1JBVEVfREVGQVVMVAkweDY5IC8qIGNoaXAgZGVmYXVs
dCAoMjRNKSAqLw0KKyNkZWZpbmUgTVQ3NjE1X0JBUl9SQVRFX0RFRkFVTFQJCTB4NGIgLyogT0ZE
TSA2TSAqLw0KKyNkZWZpbmUgTVQ3NjE1X0NGRU5EX1JBVEVfREVGQVVMVAkweDQ5IC8qIE9GRE0g
MjRNICovDQogI2RlZmluZSBNVDc2MTVfQ0ZFTkRfUkFURV8xMUIJCTB4MDMgLyogMTFCIExQLCAx
MU0gKi8NCiANCiBzdHJ1Y3QgbXQ3NjE1X3ZpZjsNCi0tIA0KMi4xOC4wDQo=

