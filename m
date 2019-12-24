Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB87A129C63
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2019 02:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfLXBYr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 20:24:47 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:50762 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726907AbfLXBYq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 20:24:46 -0500
X-UUID: 6a5e720533d6453d841232c1dd62e0dc-20191224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=q/7MmQNuPr5JrCrqcpEI/Kr7uFLHIWbzpfZhgQRMDyU=;
        b=Pi06ryVwr5uY7JcruUpnceO1qs7kWS1eAhVsKnm1EpkNZehTCGajx2tOjcWRLWXi5pS+Hb28FvtnG214PL8x8zIrKcmgIsjkkq456XG2Z2CaXB+lQu4L4bn4inTGKN8/9M9p9pXqdmduQW0nTqU8To7QKpmxMtkagPD0QEuof2s=;
X-UUID: 6a5e720533d6453d841232c1dd62e0dc-20191224
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1067820789; Tue, 24 Dec 2019 09:24:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 24 Dec 2019 09:24:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 24 Dec 2019 09:24:18 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7615: add missing settings for simultaneous dual-band support
Date:   Tue, 24 Dec 2019 09:24:25 +0800
Message-ID: <2d9c7c4dff5149f563ac5688e4ac4a911fbda3f7.1577149810.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TVQ3NjE1IHN1cHBvcnRzIGR1YWwtd2lwaHkgd2hpY2ggbWVhbnMgdGhhdCBpdCBjYW4gcnVuIG9u
IDIuNEcgYW5kIDVHSHoNCmNoYW5uZWxzIHNpbXVsdGFuZW91c2x5LCBhbmQgZHJpdmVyIHNob3Vs
ZCBjb25maWd1cmUgZWFjaCBiYW5kLg0KDQpBZGQgbWlzc2luZyByZWdpc3RlciBzZXR0aW5ncywg
YW5kIHJlZmluZSBiYW5kIHJlbGF0ZWQgZGVmaW5pdGlvbnMgdG8NCmF2b2lkIGR1cGxpY2F0ZSBj
b2Rlcy4NCg0KU2lnbmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29t
Pg0KLS0tDQogLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9pbml0LmMgIHwg
NTIgKysrKysrKy0tLS0tLS0NCiAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1
L21hYy5jICAgfCA3MSArKysrKysrLS0tLS0tLS0tLS0tDQogLi4uL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzYxNS9yZWdzLmggIHwgNTIgKysrKystLS0tLS0tLS0NCiAzIGZpbGVzIGNo
YW5nZWQsIDY5IGluc2VydGlvbnMoKyksIDEwNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L2luaXQuYyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L2luaXQuYw0KaW5kZXggOTRhMGRj
OGJmYTI4Li41ODllOTMzZTAwZDYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzYxNS9pbml0LmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3NjE1L2luaXQuYw0KQEAgLTI4LDE3ICsyOCwxNyBAQCBzdGF0aWMgdm9p
ZCBtdDc2MTVfbWFjX2luaXQoc3RydWN0IG10NzYxNV9kZXYgKmRldikNCiAJCSBNVF9DRkdfQ0NS
X01BQ19EMF8xWF9HQ19FTiB8IE1UX0NGR19DQ1JfTUFDX0QwXzJYX0dDX0VOIHwNCiAJCSBNVF9D
RkdfQ0NSX01BQ19EMV8xWF9HQ19FTiB8IE1UX0NGR19DQ1JfTUFDX0QxXzJYX0dDX0VOKTsNCiAN
Ci0JdmFsID0gbXQ3Nl9ybXcoZGV2LCBNVF9UTUFDX1RSQ1IwLA0KKwl2YWwgPSBtdDc2X3Jtdyhk
ZXYsIE1UX1RNQUNfVFJDUigwKSwNCiAJCSAgICAgICBNVF9UTUFDX1RSQ1JfQ0NBX1NFTCB8IE1U
X1RNQUNfVFJDUl9TRUNfQ0NBX1NFTCwNCiAJCSAgICAgICBGSUVMRF9QUkVQKE1UX1RNQUNfVFJD
Ul9DQ0FfU0VMLCAyKSB8DQogCQkgICAgICAgRklFTERfUFJFUChNVF9UTUFDX1RSQ1JfU0VDX0ND
QV9TRUwsIDApKTsNCi0JbXQ3Nl93cihkZXYsIE1UX1RNQUNfVFJDUjEsIHZhbCk7DQorCW10NzZf
d3IoZGV2LCBNVF9UTUFDX1RSQ1IoMSksIHZhbCk7DQogDQogCXZhbCA9IE1UX0FHR19BQ1JfUEtU
X1RJTUVfRU4gfCBNVF9BR0dfQUNSX05PX0JBX0FSX1JVTEUgfA0KIAkgICAgICBGSUVMRF9QUkVQ
KE1UX0FHR19BQ1JfQ0ZFTkRfUkFURSwgTVQ3NjE1X0NGRU5EX1JBVEVfREVGQVVMVCkgfA0KIAkg
ICAgICBGSUVMRF9QUkVQKE1UX0FHR19BQ1JfQkFSX1JBVEUsIE1UNzYxNV9CQVJfUkFURV9ERUZB
VUxUKTsNCi0JbXQ3Nl93cihkZXYsIE1UX0FHR19BQ1IwLCB2YWwpOw0KLQltdDc2X3dyKGRldiwg
TVRfQUdHX0FDUjEsIHZhbCk7DQorCW10NzZfd3IoZGV2LCBNVF9BR0dfQUNSKDApLCB2YWwpOw0K
KwltdDc2X3dyKGRldiwgTVRfQUdHX0FDUigxKSwgdmFsKTsNCiANCiAJbXQ3Nl9ybXdfZmllbGQo
ZGV2LCBNVF9UTUFDX0NUQ1IwLA0KIAkJICAgICAgIE1UX1RNQUNfQ1RDUjBfSU5TX0RETE1UX1JF
RlRJTUUsIDB4M2YpOw0KQEAgLTU5LDI1ICs1OSwyNyBAQCBzdGF0aWMgdm9pZCBtdDc2MTVfbWFj
X2luaXQoc3RydWN0IG10NzYxNV9kZXYgKmRldikNCiAJbXQ3Nl93cihkZXYsIE1UX0RNQV9EQ1Iw
LCBNVF9ETUFfRENSMF9SWF9WRUNfRFJPUCB8DQogCQlGSUVMRF9QUkVQKE1UX0RNQV9EQ1IwX01B
WF9SWF9MRU4sIDMwNzIpKTsNCiANCi0JbXQ3Nl93cihkZXYsIE1UX0FHR19BUlVDUiwNCi0JCUZJ
RUxEX1BSRVAoTVRfQUdHX0FSeENSX0xJTUlUKDApLCA3KSB8DQotCQlGSUVMRF9QUkVQKE1UX0FH
R19BUnhDUl9MSU1JVCgxKSwgMikgfA0KLQkJRklFTERfUFJFUChNVF9BR0dfQVJ4Q1JfTElNSVQo
MiksIDIpIHwNCi0JCUZJRUxEX1BSRVAoTVRfQUdHX0FSeENSX0xJTUlUKDMpLCAyKSB8DQotCQlG
SUVMRF9QUkVQKE1UX0FHR19BUnhDUl9MSU1JVCg0KSwgMSkgfA0KLQkJRklFTERfUFJFUChNVF9B
R0dfQVJ4Q1JfTElNSVQoNSksIDEpIHwNCi0JCUZJRUxEX1BSRVAoTVRfQUdHX0FSeENSX0xJTUlU
KDYpLCAxKSB8DQotCQlGSUVMRF9QUkVQKE1UX0FHR19BUnhDUl9MSU1JVCg3KSwgMSkpOw0KLQ0K
LQltdDc2X3dyKGRldiwgTVRfQUdHX0FSRENSLA0KLQkJRklFTERfUFJFUChNVF9BR0dfQVJ4Q1Jf
TElNSVQoMCksIE1UNzYxNV9SQVRFX1JFVFJZIC0gMSkgfA0KLQkJRklFTERfUFJFUChNVF9BR0df
QVJ4Q1JfTElNSVQoMSksIE1UNzYxNV9SQVRFX1JFVFJZIC0gMSkgfA0KLQkJRklFTERfUFJFUChN
VF9BR0dfQVJ4Q1JfTElNSVQoMiksIE1UNzYxNV9SQVRFX1JFVFJZIC0gMSkgfA0KLQkJRklFTERf
UFJFUChNVF9BR0dfQVJ4Q1JfTElNSVQoMyksIE1UNzYxNV9SQVRFX1JFVFJZIC0gMSkgfA0KLQkJ
RklFTERfUFJFUChNVF9BR0dfQVJ4Q1JfTElNSVQoNCksIE1UNzYxNV9SQVRFX1JFVFJZIC0gMSkg
fA0KLQkJRklFTERfUFJFUChNVF9BR0dfQVJ4Q1JfTElNSVQoNSksIE1UNzYxNV9SQVRFX1JFVFJZ
IC0gMSkgfA0KLQkJRklFTERfUFJFUChNVF9BR0dfQVJ4Q1JfTElNSVQoNiksIE1UNzYxNV9SQVRF
X1JFVFJZIC0gMSkgfA0KLQkJRklFTERfUFJFUChNVF9BR0dfQVJ4Q1JfTElNSVQoNyksIE1UNzYx
NV9SQVRFX1JFVFJZIC0gMSkpOw0KKwl2YWwgPSBGSUVMRF9QUkVQKE1UX0FHR19BUnhDUl9MSU1J
VCgwKSwgNykgfA0KKwkgICAgICBGSUVMRF9QUkVQKE1UX0FHR19BUnhDUl9MSU1JVCgxKSwgMikg
fA0KKwkgICAgICBGSUVMRF9QUkVQKE1UX0FHR19BUnhDUl9MSU1JVCgyKSwgMikgfA0KKwkgICAg
ICBGSUVMRF9QUkVQKE1UX0FHR19BUnhDUl9MSU1JVCgzKSwgMikgfA0KKwkgICAgICBGSUVMRF9Q
UkVQKE1UX0FHR19BUnhDUl9MSU1JVCg0KSwgMSkgfA0KKwkgICAgICBGSUVMRF9QUkVQKE1UX0FH
R19BUnhDUl9MSU1JVCg1KSwgMSkgfA0KKwkgICAgICBGSUVMRF9QUkVQKE1UX0FHR19BUnhDUl9M
SU1JVCg2KSwgMSkgfA0KKwkgICAgICBGSUVMRF9QUkVQKE1UX0FHR19BUnhDUl9MSU1JVCg3KSwg
MSk7DQorCW10NzZfd3IoZGV2LCBNVF9BR0dfQVJVQ1IoMCksIHZhbCk7DQorCW10NzZfd3IoZGV2
LCBNVF9BR0dfQVJVQ1IoMSksIHZhbCk7DQorDQorCXZhbCA9IEZJRUxEX1BSRVAoTVRfQUdHX0FS
eENSX0xJTUlUKDApLCBNVDc2MTVfUkFURV9SRVRSWSAtIDEpIHwNCisJICAgICAgRklFTERfUFJF
UChNVF9BR0dfQVJ4Q1JfTElNSVQoMSksIE1UNzYxNV9SQVRFX1JFVFJZIC0gMSkgfA0KKwkgICAg
ICBGSUVMRF9QUkVQKE1UX0FHR19BUnhDUl9MSU1JVCgyKSwgTVQ3NjE1X1JBVEVfUkVUUlkgLSAx
KSB8DQorCSAgICAgIEZJRUxEX1BSRVAoTVRfQUdHX0FSeENSX0xJTUlUKDMpLCBNVDc2MTVfUkFU
RV9SRVRSWSAtIDEpIHwNCisJICAgICAgRklFTERfUFJFUChNVF9BR0dfQVJ4Q1JfTElNSVQoNCks
IE1UNzYxNV9SQVRFX1JFVFJZIC0gMSkgfA0KKwkgICAgICBGSUVMRF9QUkVQKE1UX0FHR19BUnhD
Ul9MSU1JVCg1KSwgTVQ3NjE1X1JBVEVfUkVUUlkgLSAxKSB8DQorCSAgICAgIEZJRUxEX1BSRVAo
TVRfQUdHX0FSeENSX0xJTUlUKDYpLCBNVDc2MTVfUkFURV9SRVRSWSAtIDEpIHwNCisJICAgICAg
RklFTERfUFJFUChNVF9BR0dfQVJ4Q1JfTElNSVQoNyksIE1UNzYxNV9SQVRFX1JFVFJZIC0gMSk7
DQorCW10NzZfd3IoZGV2LCBNVF9BR0dfQVJEQ1IoMCksIHZhbCk7DQorCW10NzZfd3IoZGV2LCBN
VF9BR0dfQVJEQ1IoMSksIHZhbCk7DQogDQogCW10NzZfd3IoZGV2LCBNVF9BR0dfQVJDUiwNCiAJ
CShGSUVMRF9QUkVQKE1UX0FHR19BUkNSX1JUU19SQVRFX1RIUiwgMikgfA0KQEAgLTkzLDggKzk1
LDggQEAgc3RhdGljIHZvaWQgbXQ3NjE1X21hY19pbml0KHN0cnVjdCBtdDc2MTVfZGV2ICpkZXYp
DQogCSAgICAgICBNVF9ETUFfUkNGUjBfUlhfRFJPUFBFRF9NQ0FTVDsNCiAJc2V0ID0gRklFTERf
UFJFUChNVF9ETUFfUkNGUjBfUlhfRFJPUFBFRF9VQ0FTVCwgMikgfA0KIAkgICAgICBGSUVMRF9Q
UkVQKE1UX0RNQV9SQ0ZSMF9SWF9EUk9QUEVEX01DQVNULCAyKTsNCi0JbXQ3Nl9ybXcoZGV2LCBN
VF9ETUFfQk4wUkNGUjAsIG1hc2ssIHNldCk7DQotCW10NzZfcm13KGRldiwgTVRfRE1BX0JOMVJD
RlIwLCBtYXNrLCBzZXQpOw0KKwltdDc2X3JtdyhkZXYsIE1UX0RNQV9SQ0ZSMCgwKSwgbWFzaywg
c2V0KTsNCisJbXQ3Nl9ybXcoZGV2LCBNVF9ETUFfUkNGUjAoMSksIG1hc2ssIHNldCk7DQogDQog
CWZvciAoaSA9IDA7IGkgPCBNVDc2MTVfV1RCTF9TSVpFOyBpKyspDQogCQltdDc2MTVfbWFjX3d0
YmxfdXBkYXRlKGRldiwgaSwNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzYxNS9tYWMuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3NjE1L21hYy5jDQppbmRleCA5MDNiODM5NWE0NDYuLjJhMzlmOTVmNWU5ZSAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21hYy5jDQor
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tYWMuYw0KQEAg
LTY5LDcgKzY5LDcgQEAgdm9pZCBtdDc2MTVfbWFjX3NldF90aW1pbmcoc3RydWN0IG10NzYxNV9w
aHkgKnBoeSkNCiAJczE2IGNvdmVyYWdlX2NsYXNzID0gcGh5LT5jb3ZlcmFnZV9jbGFzczsNCiAJ
c3RydWN0IG10NzYxNV9kZXYgKmRldiA9IHBoeS0+ZGV2Ow0KIAlib29sIGV4dF9waHkgPSBwaHkg
IT0gJmRldi0+cGh5Ow0KLQl1MzIgdmFsLCByZWdfb2Zmc2V0LCByZWcgPSBleHRfcGh5ID8gTVRf
VE1BQ19JQ1IxIDogTVRfVE1BQ19JQ1IwOw0KKwl1MzIgdmFsLCByZWdfb2Zmc2V0Ow0KIAl1MzIg
Y2NrID0gRklFTERfUFJFUChNVF9USU1FT1VUX1ZBTF9QTENQLCAyMzEpIHwNCiAJCSAgRklFTERf
UFJFUChNVF9USU1FT1VUX1ZBTF9DQ0EsIDQ4KTsNCiAJdTMyIG9mZG0gPSBGSUVMRF9QUkVQKE1U
X1RJTUVPVVRfVkFMX1BMQ1AsIDYwKSB8DQpAQCAtMTAzLDcgKzEwMyw3IEBAIHZvaWQgbXQ3NjE1
X21hY19zZXRfdGltaW5nKHN0cnVjdCBtdDc2MTVfcGh5ICpwaHkpDQogCW10NzZfd3IoZGV2LCBN
VF9UTUFDX0NEVFIsIGNjayArIHJlZ19vZmZzZXQpOw0KIAltdDc2X3dyKGRldiwgTVRfVE1BQ19P
RFRSLCBvZmRtICsgcmVnX29mZnNldCk7DQogDQotCW10NzZfd3IoZGV2LCByZWcsDQorCW10NzZf
d3IoZGV2LCBNVF9UTUFDX0lDUihleHRfcGh5KSwNCiAJCUZJRUxEX1BSRVAoTVRfSUZTX0VJRlMs
IDM2MCkgfA0KIAkJRklFTERfUFJFUChNVF9JRlNfUklGUywgMikgfA0KIAkJRklFTERfUFJFUChN
VF9JRlNfU0lGUywgc2lmcykgfA0KQEAgLTExNCwxNSArMTE0LDE0IEBAIHZvaWQgbXQ3NjE1X21h
Y19zZXRfdGltaW5nKHN0cnVjdCBtdDc2MTVfcGh5ICpwaHkpDQogCWVsc2UNCiAJCXZhbCA9IE1U
NzYxNV9DRkVORF9SQVRFXzExQjsNCiANCi0JaWYgKGV4dF9waHkpIHsNCi0JCW10NzZfcm13X2Zp
ZWxkKGRldiwgTVRfQUdHX0FDUjEsIE1UX0FHR19BQ1JfQ0ZFTkRfUkFURSwgdmFsKTsNCisJbXQ3
Nl9ybXdfZmllbGQoZGV2LCBNVF9BR0dfQUNSKGV4dF9waHkpLCBNVF9BR0dfQUNSX0NGRU5EX1JB
VEUsIHZhbCk7DQorCWlmIChleHRfcGh5KQ0KIAkJbXQ3Nl9jbGVhcihkZXYsIE1UX0FSQl9TQ1Is
DQogCQkJICAgTVRfQVJCX1NDUl9UWDFfRElTQUJMRSB8IE1UX0FSQl9TQ1JfUlgxX0RJU0FCTEUp
Ow0KLQl9IGVsc2Ugew0KLQkJbXQ3Nl9ybXdfZmllbGQoZGV2LCBNVF9BR0dfQUNSMCwgTVRfQUdH
X0FDUl9DRkVORF9SQVRFLCB2YWwpOw0KKwllbHNlDQogCQltdDc2X2NsZWFyKGRldiwgTVRfQVJC
X1NDUiwNCiAJCQkgICBNVF9BUkJfU0NSX1RYMF9ESVNBQkxFIHwgTVRfQVJCX1NDUl9SWDBfRElT
QUJMRSk7DQotCX0NCisNCiB9DQogDQogaW50IG10NzYxNV9tYWNfZmlsbF9yeChzdHJ1Y3QgbXQ3
NjE1X2RldiAqZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KQEAgLTEzMjIsMjEgKzEzMjEsMTIg
QEAgbXQ3NjE1X21hY19zZXRfZGVmYXVsdF9zZW5zaXRpdml0eShzdHJ1Y3QgbXQ3NjE1X3BoeSAq
cGh5KQ0KIAlzdHJ1Y3QgbXQ3NjE1X2RldiAqZGV2ID0gcGh5LT5kZXY7DQogCWJvb2wgZXh0X3Bo
eSA9IHBoeSAhPSAmZGV2LT5waHk7DQogDQotCWlmICghZXh0X3BoeSkgew0KLQkJbXQ3Nl9ybXco
ZGV2LCBNVF9XRl9QSFlfQjBfTUlOX1BSSV9QV1IsDQotCQkJIE1UX1dGX1BIWV9CMF9QRF9PRkRN
X01BU0ssDQotCQkJIE1UX1dGX1BIWV9CMF9QRF9PRkRNKDB4MTNjKSk7DQotCQltdDc2X3Jtdyhk
ZXYsIE1UX1dGX1BIWV9CMF9SWFREX0NDS19QRCwNCi0JCQkgTVRfV0ZfUEhZX0IwX1BEX0NDS19N
QVNLLA0KLQkJCSBNVF9XRl9QSFlfQjBfUERfQ0NLKDB4OTIpKTsNCi0JfSBlbHNlIHsNCi0JCW10
NzZfcm13KGRldiwgTVRfV0ZfUEhZX0IxX01JTl9QUklfUFdSLA0KLQkJCSBNVF9XRl9QSFlfQjFf
UERfT0ZETV9NQVNLLA0KLQkJCSBNVF9XRl9QSFlfQjFfUERfT0ZETSgweDEzYykpOw0KLQkJbXQ3
Nl9ybXcoZGV2LCBNVF9XRl9QSFlfQjFfUlhURF9DQ0tfUEQsDQotCQkJIE1UX1dGX1BIWV9CMV9Q
RF9DQ0tfTUFTSywNCi0JCQkgTVRfV0ZfUEhZX0IxX1BEX0NDSygweDkyKSk7DQotCX0NCisJbXQ3
Nl9ybXcoZGV2LCBNVF9XRl9QSFlfTUlOX1BSSV9QV1IoZXh0X3BoeSksDQorCQkgTVRfV0ZfUEhZ
X1BEX09GRE1fTUFTSyhleHRfcGh5KSwNCisJCSBNVF9XRl9QSFlfUERfT0ZETShleHRfcGh5LCAw
eDEzYykpOw0KKwltdDc2X3JtdyhkZXYsIE1UX1dGX1BIWV9SWFREX0NDS19QRChleHRfcGh5KSwN
CisJCSBNVF9XRl9QSFlfUERfQ0NLX01BU0soZXh0X3BoeSksDQorCQkgTVRfV0ZfUEhZX1BEX0ND
SyhleHRfcGh5LCAweDkyKSk7DQogDQogCXBoeS0+b2ZkbV9zZW5zaXRpdml0eSA9IC05ODsNCiAJ
cGh5LT5jY2tfc2Vuc2l0aXZpdHkgPSAtMTEwOw0KQEAgLTEzNTMsMTkgKzEzNDMsMTkgQEAgdm9p
ZCBtdDc2MTVfbWFjX3NldF9zY3Moc3RydWN0IG10NzYxNV9kZXYgKmRldiwgYm9vbCBlbmFibGUp
DQogCQlnb3RvIG91dDsNCiANCiAJaWYgKGVuYWJsZSkgew0KLQkJbXQ3Nl9zZXQoZGV2LCBNVF9X
Rl9QSFlfQjBfTUlOX1BSSV9QV1IsDQotCQkJIE1UX1dGX1BIWV9CMF9QRF9CTEspOw0KLQkJbXQ3
Nl9zZXQoZGV2LCBNVF9XRl9QSFlfQjFfTUlOX1BSSV9QV1IsDQotCQkJIE1UX1dGX1BIWV9CMV9Q
RF9CTEspOw0KKwkJbXQ3Nl9zZXQoZGV2LCBNVF9XRl9QSFlfTUlOX1BSSV9QV1IoMCksDQorCQkJ
IE1UX1dGX1BIWV9QRF9CTEsoMCkpOw0KKwkJbXQ3Nl9zZXQoZGV2LCBNVF9XRl9QSFlfTUlOX1BS
SV9QV1IoMSksDQorCQkJIE1UX1dGX1BIWV9QRF9CTEsoMSkpOw0KIAkJaWYgKGlzX210NzYyMigm
ZGV2LT5tdDc2KSkgew0KIAkJCW10NzZfc2V0KGRldiwgTVRfTUlCX00wX01JU0NfQ1IsIDB4NyA8
PCA4KTsNCiAJCQltdDc2X3NldChkZXYsIE1UX01JQl9NMF9NSVNDX0NSLCAweDcpOw0KIAkJfQ0K
IAl9IGVsc2Ugew0KLQkJbXQ3Nl9jbGVhcihkZXYsIE1UX1dGX1BIWV9CMF9NSU5fUFJJX1BXUiwN
Ci0JCQkgICBNVF9XRl9QSFlfQjBfUERfQkxLKTsNCi0JCW10NzZfY2xlYXIoZGV2LCBNVF9XRl9Q
SFlfQjFfTUlOX1BSSV9QV1IsDQotCQkJICAgTVRfV0ZfUEhZX0IxX1BEX0JMSyk7DQorCQltdDc2
X2NsZWFyKGRldiwgTVRfV0ZfUEhZX01JTl9QUklfUFdSKDApLA0KKwkJCSAgIE1UX1dGX1BIWV9Q
RF9CTEsoMCkpOw0KKwkJbXQ3Nl9jbGVhcihkZXYsIE1UX1dGX1BIWV9NSU5fUFJJX1BXUigxKSwN
CisJCQkgICBNVF9XRl9QSFlfUERfQkxLKDEpKTsNCiAJfQ0KIA0KIAltdDc2MTVfbWFjX3NldF9k
ZWZhdWx0X3NlbnNpdGl2aXR5KCZkZXYtPnBoeSk7DQpAQCAtMTQ0MCwyNCArMTQzMCwxNSBAQCBt
dDc2MTVfbWFjX2FkanVzdF9zZW5zaXRpdml0eShzdHJ1Y3QgbXQ3NjE1X3BoeSAqcGh5LA0KIA0K
IAkJaWYgKG9mZG0pIHsNCiAJCQl2YWwgPSAqc2Vuc2l0aXZpdHkgKiAyICsgNTEyOw0KLQkJCWlm
ICghZXh0X3BoeSkNCi0JCQkJbXQ3Nl9ybXcoZGV2LCBNVF9XRl9QSFlfQjBfTUlOX1BSSV9QV1Is
DQotCQkJCQkgTVRfV0ZfUEhZX0IwX1BEX09GRE1fTUFTSywNCi0JCQkJCSBNVF9XRl9QSFlfQjBf
UERfT0ZETSh2YWwpKTsNCi0JCQllbHNlDQotCQkJCW10NzZfcm13KGRldiwgTVRfV0ZfUEhZX0Ix
X01JTl9QUklfUFdSLA0KLQkJCQkJIE1UX1dGX1BIWV9CMV9QRF9PRkRNX01BU0ssDQotCQkJCQkg
TVRfV0ZfUEhZX0IxX1BEX09GRE0odmFsKSk7DQorCQkJbXQ3Nl9ybXcoZGV2LCBNVF9XRl9QSFlf
TUlOX1BSSV9QV1IoZXh0X3BoeSksDQorCQkJCSBNVF9XRl9QSFlfUERfT0ZETV9NQVNLKGV4dF9w
aHkpLA0KKwkJCQkgTVRfV0ZfUEhZX1BEX09GRE0oZXh0X3BoeSwgdmFsKSk7DQogCQl9IGVsc2Ug
ew0KIAkJCXZhbCA9ICpzZW5zaXRpdml0eSArIDI1NjsNCiAJCQlpZiAoIWV4dF9waHkpDQotCQkJ
CW10NzZfcm13KGRldiwgTVRfV0ZfUEhZX0IwX1JYVERfQ0NLX1BELA0KLQkJCQkJIE1UX1dGX1BI
WV9CMF9QRF9DQ0tfTUFTSywNCi0JCQkJCSBNVF9XRl9QSFlfQjBfUERfQ0NLKHZhbCkpOw0KLQkJ
CWVsc2UNCi0JCQkJbXQ3Nl9ybXcoZGV2LCBNVF9XRl9QSFlfQjFfUlhURF9DQ0tfUEQsDQotCQkJ
CQkgTVRfV0ZfUEhZX0IxX1BEX0NDS19NQVNLLA0KLQkJCQkJIE1UX1dGX1BIWV9CMV9QRF9DQ0so
dmFsKSk7DQorCQkJbXQ3Nl9ybXcoZGV2LCBNVF9XRl9QSFlfUlhURF9DQ0tfUEQoZXh0X3BoeSks
DQorCQkJCSBNVF9XRl9QSFlfUERfQ0NLX01BU0soZXh0X3BoeSksDQorCQkJCSBNVF9XRl9QSFlf
UERfQ0NLKGV4dF9waHksIHZhbCkpOw0KIAkJfQ0KIAkJcGh5LT5sYXN0X2NjYV9hZGogPSBqaWZm
aWVzOw0KIAl9DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc2MTUvcmVncy5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2
MTUvcmVncy5oDQppbmRleCAyNmQxMjE2NDY3ODcuLmY0OGYzYTZmNDhmMCAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3JlZ3MuaA0KKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvcmVncy5oDQpAQCAtODEs
NyArODEsNyBAQA0KICNkZWZpbmUgTVRfV0ZfUEhZX0JBU0UJCQkweDEwMDAwDQogI2RlZmluZSBN
VF9XRl9QSFkob2ZzKQkJCShNVF9XRl9QSFlfQkFTRSArIChvZnMpKQ0KIA0KLSNkZWZpbmUgTVRf
V0ZfUEhZX1dGMl9SRkNUUkwwKG4pCU1UX1dGX1BIWSgweDE5MDAgKyAoKG4pICogMHg0MDApKQ0K
KyNkZWZpbmUgTVRfV0ZfUEhZX1dGMl9SRkNUUkwwKG4pCU1UX1dGX1BIWSgweDE5MDAgKyAobikg
KiAweDQwMCkNCiAjZGVmaW5lIE1UX1dGX1BIWV9XRjJfUkZDVFJMMF9MUEJDTl9FTglCSVQoOSkN
CiANCiAjZGVmaW5lIE1UX1dGX1BIWV9SMF9QSFlNVVhfNShfcGh5KQlNVF9XRl9QSFkoMHgwNjE0
ICsgKChfcGh5KSA8PCA5KSkNCkBAIC05NCwyMyArOTQsMTYgQEANCiAjZGVmaW5lIE1UX1dGX1BI
WUNUUkxfU1RBVF9NRFJEWV9PRkRNCUdFTk1BU0soMzEsIDE2KQ0KICNkZWZpbmUgTVRfV0ZfUEhZ
Q1RSTF9TVEFUX01EUkRZX0NDSwlHRU5NQVNLKDE1LCAwKQ0KIA0KLSNkZWZpbmUgTVRfV0ZfUEhZ
X0IwX01JTl9QUklfUFdSCU1UX1dGX1BIWSgweDIyOWMpDQotI2RlZmluZSBNVF9XRl9QSFlfQjBf
UERfT0ZETV9NQVNLCUdFTk1BU0soMjgsIDIwKQ0KLSNkZWZpbmUgTVRfV0ZfUEhZX0IwX1BEX09G
RE0odikJCSgodikgPDwgMjApDQotI2RlZmluZSBNVF9XRl9QSFlfQjBfUERfQkxLCQlCSVQoMTkp
DQorI2RlZmluZSBNVF9XRl9QSFlfTUlOX1BSSV9QV1IoX3BoeSkJTVRfV0ZfUEhZKChfcGh5KSA/
IDB4MDg0IDogMHgyMjljKQ0KKyNkZWZpbmUgTVRfV0ZfUEhZX1BEX09GRE1fTUFTSyhfcGh5KQko
KF9waHkpID8gR0VOTUFTSygyNCwgMTYpIDogXA0KKwkJCQkJIEdFTk1BU0soMjgsIDIwKSkNCisj
ZGVmaW5lIE1UX1dGX1BIWV9QRF9PRkRNKF9waHksIHYpCSgodikgPDwgKChfcGh5KSA/IDE2IDog
MjApKQ0KKyNkZWZpbmUgTVRfV0ZfUEhZX1BEX0JMSyhfcGh5KQkJKChfcGh5KSA/IEJJVCgyNSkg
OiBCSVQoMTkpKQ0KIA0KLSNkZWZpbmUgTVRfV0ZfUEhZX0IxX01JTl9QUklfUFdSCU1UX1dGX1BI
WSgweDA4NCkNCi0jZGVmaW5lIE1UX1dGX1BIWV9CMV9QRF9PRkRNX01BU0sJR0VOTUFTSygyNCwg
MTYpDQotI2RlZmluZSBNVF9XRl9QSFlfQjFfUERfT0ZETSh2KQkJKCh2KSA8PCAxNikNCi0jZGVm
aW5lIE1UX1dGX1BIWV9CMV9QRF9CTEsJCUJJVCgyNSkNCi0NCi0jZGVmaW5lIE1UX1dGX1BIWV9C
MF9SWFREX0NDS19QRAlNVF9XRl9QSFkoMHgyMzEwKQ0KLSNkZWZpbmUgTVRfV0ZfUEhZX0IwX1BE
X0NDS19NQVNLCUdFTk1BU0soOCwgMSkNCi0jZGVmaW5lIE1UX1dGX1BIWV9CMF9QRF9DQ0sodikJ
CSgodikgPDwgMSkNCi0NCi0jZGVmaW5lIE1UX1dGX1BIWV9CMV9SWFREX0NDS19QRAlNVF9XRl9Q
SFkoMHgyMzE0KQ0KLSNkZWZpbmUgTVRfV0ZfUEhZX0IxX1BEX0NDS19NQVNLCUdFTk1BU0soMzEs
IDI0KQ0KLSNkZWZpbmUgTVRfV0ZfUEhZX0IxX1BEX0NDSyh2KQkJKCh2KSA8PCAyNCkNCisjZGVm
aW5lIE1UX1dGX1BIWV9SWFREX0NDS19QRChfcGh5KQlNVF9XRl9QSFkoKF9waHkpID8gMHgyMzE0
IDogMHgyMzEwKQ0KKyNkZWZpbmUgTVRfV0ZfUEhZX1BEX0NDS19NQVNLKF9waHkpCShfcGh5KSA/
IEdFTk1BU0soMzEsIDI0KSA6IFwNCisJCQkJCSBHRU5NQVNLKDgsIDEpDQorI2RlZmluZSBNVF9X
Rl9QSFlfUERfQ0NLKF9waHksIHYpCSgodikgPDwgKChfcGh5KSA/IDI0IDogMSkpDQogDQogI2Rl
ZmluZSBNVF9XRl9DRkdfQkFTRQkJCTB4MjAyMDANCiAjZGVmaW5lIE1UX1dGX0NGRyhvZnMpCQkJ
KE1UX1dGX0NGR19CQVNFICsgKG9mcykpDQpAQCAtMTIxLDE1ICsxMTQsNiBAQA0KICNkZWZpbmUg
TVRfQ0ZHX0NDUl9NQUNfRDFfMlhfR0NfRU4JQklUKDMwKQ0KICNkZWZpbmUgTVRfQ0ZHX0NDUl9N
QUNfRDBfMlhfR0NfRU4JQklUKDMxKQ0KIA0KLSNkZWZpbmUgTVRfREJEQ19DVFJMMAkJCU1UX1dG
X0NGRygweDA1MCkNCi0jZGVmaW5lIE1UX0RCRENfQ1RSTDBfT01BQ18wMF8wNAlHRU5NQVNLKDQs
IDApDQotI2RlZmluZSBNVF9EQkRDX0NUUkwwX09NQUNfMTFfMUYJR0VOTUFTSygxOSwgNSkNCi0j
ZGVmaW5lIE1UX0RCRENfQ1RSTDBfTUdNVAkJR0VOTUFTSygyMSwgMjApDQotI2RlZmluZSBNVF9E
QkRDX0NUUkwwX1dNTQkJR0VOTUFTSygyNSwgMjIpDQotI2RlZmluZSBNVF9EQkRDX0NUUkwwX0RC
RENfRU4JCUJJVCgzMSkNCi0NCi0jZGVmaW5lIE1UX0RCRENfQ1RSTDEJCQlNVF9XRl9DRkcoMHgw
NTQpDQotDQogI2RlZmluZSBNVF9XRl9BR0dfQkFTRQkJCTB4MjBhMDANCiAjZGVmaW5lIE1UX1dG
X0FHRyhvZnMpCQkJKE1UX1dGX0FHR19CQVNFICsgKG9mcykpDQogDQpAQCAtMTQwLDggKzEyNCw4
IEBADQogI2RlZmluZSBNVF9BR0dfQVJDUl9SQVRFX0RPV05fUkFUSU9fRU4JQklUKDE5KQ0KICNk
ZWZpbmUgTVRfQUdHX0FSQ1JfUkFURV9VUF9FWFRSQV9USAlHRU5NQVNLKDIyLCAyMCkNCiANCi0j
ZGVmaW5lIE1UX0FHR19BUlVDUgkJCU1UX1dGX0FHRygweDAxOCkNCi0jZGVmaW5lIE1UX0FHR19B
UkRDUgkJCU1UX1dGX0FHRygweDAxYykNCisjZGVmaW5lIE1UX0FHR19BUlVDUihfYmFuZCkJCU1U
X1dGX0FHRygweDAxOCArIChfYmFuZCkgKiAweDEwMCkNCisjZGVmaW5lIE1UX0FHR19BUkRDUihf
YmFuZCkJCU1UX1dGX0FHRygweDAxYyArIChfYmFuZCkgKiAweDEwMCkNCiAjZGVmaW5lIE1UX0FH
R19BUnhDUl9MSU1JVF9TSElGVChfbikJKDQgKiAoX24pKQ0KICNkZWZpbmUgTVRfQUdHX0FSeENS
X0xJTUlUKF9uKQkJR0VOTUFTSygyICsgXA0KIAkJCQkJTVRfQUdHX0FSeENSX0xJTUlUX1NISUZU
KF9uKSwgXA0KQEAgLTE1MSw4ICsxMzUsNyBAQA0KICNkZWZpbmUgTVRfQUdHX0FTUkNSMQkJCU1U
X1dGX0FHRygweDA2NCkNCiAjZGVmaW5lIE1UX0FHR19BU1JDUl9SQU5HRSh2YWwsIG4pCSgoKHZh
bCkgPj4gKChuKSA8PCAzKSkgJiBHRU5NQVNLKDUsIDApKQ0KIA0KLSNkZWZpbmUgTVRfQUdHX0FD
UjAJCQlNVF9XRl9BR0coMHgwNzApDQotI2RlZmluZSBNVF9BR0dfQUNSMQkJCU1UX1dGX0FHRygw
eDE3MCkNCisjZGVmaW5lIE1UX0FHR19BQ1IoX2JhbmQpCQlNVF9XRl9BR0coMHgwNzAgKyAoX2Jh
bmQpICogMHgxMDApDQogI2RlZmluZSBNVF9BR0dfQUNSX05PX0JBX1JVTEUJCUJJVCgwKQ0KICNk
ZWZpbmUgTVRfQUdHX0FDUl9OT19CQV9BUl9SVUxFCUJJVCgxKQ0KICNkZWZpbmUgTVRfQUdHX0FD
Ul9QS1RfVElNRV9FTgkJQklUKDIpDQpAQCAtMTc5LDEzICsxNjIsMTEgQEANCiAjZGVmaW5lIE1U
X1RJTUVPVVRfVkFMX1BMQ1AJCUdFTk1BU0soMTUsIDApDQogI2RlZmluZSBNVF9USU1FT1VUX1ZB
TF9DQ0EJCUdFTk1BU0soMzEsIDE2KQ0KIA0KLSNkZWZpbmUgTVRfVE1BQ19UUkNSMAkJCU1UX1dG
X1RNQUMoMHgwOWMpDQotI2RlZmluZSBNVF9UTUFDX1RSQ1IxCQkJTVRfV0ZfVE1BQygweDA3MCkN
CisjZGVmaW5lIE1UX1RNQUNfVFJDUihfYmFuZCkJCU1UX1dGX1RNQUMoKF9iYW5kKSA/IDB4MDcw
IDogMHgwOWMpDQogI2RlZmluZSBNVF9UTUFDX1RSQ1JfQ0NBX1NFTAkJR0VOTUFTSygzMSwgMzAp
DQogI2RlZmluZSBNVF9UTUFDX1RSQ1JfU0VDX0NDQV9TRUwJR0VOTUFTSygyOSwgMjgpDQogDQot
I2RlZmluZSBNVF9UTUFDX0lDUjAJCQlNVF9XRl9UTUFDKDB4MGE0KQ0KLSNkZWZpbmUgTVRfVE1B
Q19JQ1IxCQkJTVRfV0ZfVE1BQygweDA3NCkNCisjZGVmaW5lIE1UX1RNQUNfSUNSKF9iYW5kKQkJ
TVRfV0ZfVE1BQygoX2JhbmQpID8gMHgwNzQgOiAweDBhNCkNCiAjZGVmaW5lIE1UX0lGU19FSUZT
CQkJR0VOTUFTSyg4LCAwKQ0KICNkZWZpbmUgTVRfSUZTX1JJRlMJCQlHRU5NQVNLKDE0LCAxMCkN
CiAjZGVmaW5lIE1UX0lGU19TSUZTCQkJR0VOTUFTSygyMiwgMTYpDQpAQCAtMjQ5LDggKzIzMCw3
IEBADQogI2RlZmluZSBNVF9ETUFfRENSMF9NQVhfUlhfTEVOCQlHRU5NQVNLKDE1LCAyKQ0KICNk
ZWZpbmUgTVRfRE1BX0RDUjBfUlhfVkVDX0RST1AJCUJJVCgxNykNCiANCi0jZGVmaW5lIE1UX0RN
QV9CTjBSQ0ZSMAkJCU1UX1dGX0RNQSgweDA3MCkNCi0jZGVmaW5lIE1UX0RNQV9CTjFSQ0ZSMAkJ
CU1UX1dGX0RNQSgweDBiMCkNCisjZGVmaW5lIE1UX0RNQV9SQ0ZSMChfYmFuZCkJCU1UX1dGX0RN
QSgweDA3MCArIChfYmFuZCkgKiAweDQwKQ0KICNkZWZpbmUgTVRfRE1BX1JDRlIwX01DVV9SWF9N
R01UCUJJVCgyKQ0KICNkZWZpbmUgTVRfRE1BX1JDRlIwX01DVV9SWF9DVExfTk9OX0JBUglCSVQo
MykNCiAjZGVmaW5lIE1UX0RNQV9SQ0ZSMF9NQ1VfUlhfQ1RMX0JBUglCSVQoNCkNCi0tIA0KMi4x
OC4wDQo=

