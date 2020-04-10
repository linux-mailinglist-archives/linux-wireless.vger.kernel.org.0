Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4221A1A4C49
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2020 00:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgDJWwI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Apr 2020 18:52:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:6727 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726726AbgDJWwH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Apr 2020 18:52:07 -0400
X-UUID: c75ae9288dcf4d80823e0cbd18204fca-20200411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lzzg2X51hZj+pv7xhEfbRWqBKccscDkDYXCRCA+l5oQ=;
        b=LdyQng8GSOovllQfABnI9cobVpyH6OPNKSqWbEm86CWhlZ2CL9FKEapsf8NvSgLwVq6yUbZdkRO4vqF7zFBmktU60mkiYVdrBzwsPeRX91qaq0cdZ9ysUINqz/XfUcO3IhuBdIvhBQpGCWcQxENsv3hcESbtz38rrYbif0fr5p8=;
X-UUID: c75ae9288dcf4d80823e0cbd18204fca-20200411
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2006562571; Sat, 11 Apr 2020 06:51:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Apr 2020 06:51:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Apr 2020 06:51:48 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Chih-Min Chen <chih-min.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v1 11/16] mt76: mt7915: add HE capabilities support for peers
Date:   Sat, 11 Apr 2020 06:51:26 +0800
Message-ID: <4159987874a38d8db4012370eb29679b3f48276c.1586558901.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1586558901.git.ryder.lee@mediatek.com>
References: <cover.1586558901.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

U2V0IHBlZXIncyBic2ljIEhFIGNhcGFiaWxpdGllcyB0aHJvdWdoIHN0YXJlYy4NCg0KU2lnbmVk
LW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KU3VnZ2VzdGVkLWJ5
OiBTaGlod2VpIExpbiA8c2hpaHdlaS5saW5AbWVkaWF0ZWsuY29tPg0KVGVzdGVkLWJ5OiBTaGF5
bmUgQ2hlbiA8c2hheW5lLmNoZW5AbWVkaWF0ZWsuY29tPg0KVGVzdGVkLWJ5OiBDaGloLU1pbiBD
aGVuIDxjaGloLW1pbi5jaGVuQG1lZGlhdGVrLmNvbT4NClRlc3RlZC1ieTogRXZlbHluIFRzYWkg
PGV2ZWx5bi50c2FpQG1lZGlhdGVrLmNvbT4NCkFja2VkLWJ5OiBZaXdlaSBDaHVuZyA8eWl3ZWku
Y2h1bmdAbWVkaWF0ZWsuY29tPg0KQWNrZWQtYnk6IFlGIEx1byA8eWYubHVvQG1lZGlhdGVrLmNv
bT4NCi0tLQ0KIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMgICB8
IDE5NiArKysrKysrKysrKysrKysrKysNCiAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTE1L21jdS5oICAgfCAxMDAgKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAyOTYgaW5z
ZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5MTUvbWN1LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210
NzkxNS9tY3UuYw0KaW5kZXggMTFjZmUxMTcyNGY5Li5lNmU0NDA1ZjU3NjYgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYw0KKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMNCkBAIC04NSw2
ICs4NSw4IEBAIHN0cnVjdCBtdDc5MTVfZndfcmVnaW9uIHsNCiAjZGVmaW5lIHRvX3djaWRfbG8o
aWQpCQkJRklFTERfR0VUKEdFTk1BU0soNywgMCksICh1MTYpaWQpDQogI2RlZmluZSB0b193Y2lk
X2hpKGlkKQkJCUZJRUxEX0dFVChHRU5NQVNLKDksIDgpLCAodTE2KWlkKQ0KIA0KKyNkZWZpbmUg
SEVfUEhZKHAsIGMpCQkJdThfZ2V0X2JpdHMoYywgSUVFRTgwMjExX0hFX1BIWV8jI3ApDQorI2Rl
ZmluZSBIRV9NQUMobSwgYykJCQl1OF9nZXRfYml0cyhjLCBJRUVFODAyMTFfSEVfTUFDXyMjbSkN
CiAjZGVmaW5lIEhXX1RYX0FNU0RVX01BWF9OVU0JCTgNCiANCiBzdGF0aWMgZW51bSBtdDc5MTVf
Y2lwaGVyX3R5cGUNCkBAIC0xMjUwLDYgKzEyNTIsMTg3IEBAIG10NzkxNV9tY3Vfc3RhX2Jhc2lj
X3RsdihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0KIAli
YXNpYy0+cW9zID0gc3RhLT53bWU7DQogfQ0KIA0KK3N0YXRpYyB2b2lkDQorbXQ3OTE1X21jdV9z
dGFfaGVfdGx2KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBpZWVlODAyMTFfc3RhICpzdGEp
DQorew0KKwlzdHJ1Y3QgaWVlZTgwMjExX3N0YV9oZV9jYXAgKmhlX2NhcCA9ICZzdGEtPmhlX2Nh
cDsNCisJc3RydWN0IGllZWU4MDIxMV9oZV9jYXBfZWxlbSAqZWxlbSA9ICZoZV9jYXAtPmhlX2Nh
cF9lbGVtOw0KKwlzdHJ1Y3Qgc3RhX3JlY19oZSAqaGU7DQorCXN0cnVjdCB0bHYgKnRsdjsNCisJ
dTMyIGNhcCA9IDA7DQorDQorCXRsdiA9IG10NzkxNV9tY3VfYWRkX3Rsdihza2IsIFNUQV9SRUNf
SEUsIHNpemVvZigqaGUpKTsNCisNCisJaGUgPSAoc3RydWN0IHN0YV9yZWNfaGUgKil0bHY7DQor
DQorCWlmIChlbGVtLT5tYWNfY2FwX2luZm9bMF0gJiBJRUVFODAyMTFfSEVfTUFDX0NBUDBfSFRD
X0hFKQ0KKwkJY2FwIHw9IFNUQV9SRUNfSEVfQ0FQX0hUQzsNCisNCisJaWYgKGVsZW0tPm1hY19j
YXBfaW5mb1syXSAmIElFRUU4MDIxMV9IRV9NQUNfQ0FQMl9CU1IpDQorCQljYXAgfD0gU1RBX1JF
Q19IRV9DQVBfQlNSOw0KKw0KKwlpZiAoZWxlbS0+bWFjX2NhcF9pbmZvWzNdICYgSUVFRTgwMjEx
X0hFX01BQ19DQVAzX09NSV9DT05UUk9MKQ0KKwkJY2FwIHw9IFNUQV9SRUNfSEVfQ0FQX09NOw0K
Kw0KKwlpZiAoZWxlbS0+bWFjX2NhcF9pbmZvWzRdICYgSUVFRTgwMjExX0hFX01BQ19DQVA0X0FN
RFNVX0lOX0FNUERVKQ0KKwkJY2FwIHw9IFNUQV9SRUNfSEVfQ0FQX0FNU0RVX0lOX0FNUERVOw0K
Kw0KKwlpZiAoZWxlbS0+bWFjX2NhcF9pbmZvWzRdICYgSUVFRTgwMjExX0hFX01BQ19DQVA0X0JR
UikNCisJCWNhcCB8PSBTVEFfUkVDX0hFX0NBUF9CUVI7DQorDQorCWlmIChlbGVtLT5waHlfY2Fw
X2luZm9bMF0gJg0KKwkgICAgKElFRUU4MDIxMV9IRV9QSFlfQ0FQMF9DSEFOTkVMX1dJRFRIX1NF
VF9SVV9NQVBQSU5HX0lOXzJHIHwNCisJICAgICBJRUVFODAyMTFfSEVfUEhZX0NBUDBfQ0hBTk5F
TF9XSURUSF9TRVRfUlVfTUFQUElOR19JTl81RykpDQorCQljYXAgfD0gU1RBX1JFQ19IRV9DQVBf
QlcyMF9SVTI0Ml9TVVBQT1JUOw0KKw0KKwlpZiAoZWxlbS0+cGh5X2NhcF9pbmZvWzFdICYNCisJ
ICAgIElFRUU4MDIxMV9IRV9QSFlfQ0FQMV9MRFBDX0NPRElOR19JTl9QQVlMT0FEKQ0KKwkJY2Fw
IHw9IFNUQV9SRUNfSEVfQ0FQX0xEUEM7DQorDQorCWlmIChlbGVtLT5waHlfY2FwX2luZm9bMV0g
Jg0KKwkgICAgSUVFRTgwMjExX0hFX1BIWV9DQVAxX0hFX0xURl9BTkRfR0lfRk9SX0hFX1BQRFVT
XzBfOFVTKQ0KKwkJY2FwIHw9IFNUQV9SRUNfSEVfQ0FQX1NVX1BQRFVfMUxURl84VVNfR0k7DQor
DQorCWlmIChlbGVtLT5waHlfY2FwX2luZm9bMl0gJg0KKwkgICAgSUVFRTgwMjExX0hFX1BIWV9D
QVAyX05EUF80eF9MVEZfQU5EXzNfMlVTKQ0KKwkJY2FwIHw9IFNUQV9SRUNfSEVfQ0FQX05EUF80
TFRGXzNET1QyTVNfR0k7DQorDQorCWlmIChlbGVtLT5waHlfY2FwX2luZm9bMl0gJg0KKwkgICAg
SUVFRTgwMjExX0hFX1BIWV9DQVAyX1NUQkNfVFhfVU5ERVJfODBNSFopDQorCQljYXAgfD0gU1RB
X1JFQ19IRV9DQVBfTEVfRVFfODBNX1RYX1NUQkM7DQorDQorCWlmIChlbGVtLT5waHlfY2FwX2lu
Zm9bMl0gJg0KKwkgICAgSUVFRTgwMjExX0hFX1BIWV9DQVAyX1NUQkNfUlhfVU5ERVJfODBNSFop
DQorCQljYXAgfD0gU1RBX1JFQ19IRV9DQVBfTEVfRVFfODBNX1JYX1NUQkM7DQorDQorCWlmIChl
bGVtLT5waHlfY2FwX2luZm9bNl0gJg0KKwkgICAgSUVFRTgwMjExX0hFX1BIWV9DQVA2X1BBUlRJ
QUxfQldfRVhUX1JBTkdFKQ0KKwkJY2FwIHw9IFNUQV9SRUNfSEVfQ0FQX1BBUlRJQUxfQldfRVhU
X1JBTkdFOw0KKw0KKwlpZiAoZWxlbS0+cGh5X2NhcF9pbmZvWzddICYNCisJICAgIElFRUU4MDIx
MV9IRV9QSFlfQ0FQN19IRV9TVV9NVV9QUERVXzRYTFRGX0FORF8wOF9VU19HSSkNCisJCWNhcCB8
PSBTVEFfUkVDX0hFX0NBUF9TVV9NVV9QUERVXzRMVEZfOFVTX0dJOw0KKw0KKwlpZiAoZWxlbS0+
cGh5X2NhcF9pbmZvWzddICYNCisJICAgIElFRUU4MDIxMV9IRV9QSFlfQ0FQN19TVEJDX1RYX0FC
T1ZFXzgwTUhaKQ0KKwkJY2FwIHw9IFNUQV9SRUNfSEVfQ0FQX0dUXzgwTV9UWF9TVEJDOw0KKw0K
KwlpZiAoZWxlbS0+cGh5X2NhcF9pbmZvWzddICYNCisJICAgIElFRUU4MDIxMV9IRV9QSFlfQ0FQ
N19TVEJDX1JYX0FCT1ZFXzgwTUhaKQ0KKwkJY2FwIHw9IFNUQV9SRUNfSEVfQ0FQX0dUXzgwTV9S
WF9TVEJDOw0KKw0KKwlpZiAoZWxlbS0+cGh5X2NhcF9pbmZvWzhdICYNCisJICAgIElFRUU4MDIx
MV9IRV9QSFlfQ0FQOF9IRV9FUl9TVV9QUERVXzRYTFRGX0FORF8wOF9VU19HSSkNCisJCWNhcCB8
PSBTVEFfUkVDX0hFX0NBUF9FUl9TVV9QUERVXzRMVEZfOFVTX0dJOw0KKw0KKwlpZiAoZWxlbS0+
cGh5X2NhcF9pbmZvWzhdICYNCisJICAgIElFRUU4MDIxMV9IRV9QSFlfQ0FQOF9IRV9FUl9TVV8x
WExURl9BTkRfMDhfVVNfR0kpDQorCQljYXAgfD0gU1RBX1JFQ19IRV9DQVBfRVJfU1VfUFBEVV8x
TFRGXzhVU19HSTsNCisNCisJaWYgKGVsZW0tPnBoeV9jYXBfaW5mb1s5XSAmDQorCSAgICBJRUVF
ODAyMTFfSEVfUEhZX0NBUDlfTk9OX1RSSUdHRVJFRF9DUUlfRkVFREJBQ0spDQorCQljYXAgfD0g
U1RBX1JFQ19IRV9DQVBfVFJJR19DUUlfRks7DQorDQorCWlmIChlbGVtLT5waHlfY2FwX2luZm9b
OV0gJg0KKwkgICAgSUVFRTgwMjExX0hFX1BIWV9DQVA5X1RYXzEwMjRfUUFNX0xFU1NfVEhBTl8y
NDJfVE9ORV9SVSkNCisJCWNhcCB8PSBTVEFfUkVDX0hFX0NBUF9UWF8xMDI0UUFNX1VOREVSX1JV
MjQyOw0KKw0KKwlpZiAoZWxlbS0+cGh5X2NhcF9pbmZvWzldICYNCisJICAgIElFRUU4MDIxMV9I
RV9QSFlfQ0FQOV9SWF8xMDI0X1FBTV9MRVNTX1RIQU5fMjQyX1RPTkVfUlUpDQorCQljYXAgfD0g
U1RBX1JFQ19IRV9DQVBfUlhfMTAyNFFBTV9VTkRFUl9SVTI0MjsNCisNCisJaGUtPmhlX2NhcCA9
IGNwdV90b19sZTMyKGNhcCk7DQorDQorCXN3aXRjaCAoc3RhLT5iYW5kd2lkdGgpIHsNCisJY2Fz
ZSBJRUVFODAyMTFfU1RBX1JYX0JXXzE2MDoNCisJCWlmIChlbGVtLT5waHlfY2FwX2luZm9bMF0g
Jg0KKwkJICAgIElFRUU4MDIxMV9IRV9QSFlfQ0FQMF9DSEFOTkVMX1dJRFRIX1NFVF84MFBMVVM4
MF9NSFpfSU5fNUcpDQorCQkJaGUtPm1heF9uc3NfbWNzW0NNRF9IRV9NQ1NfQlc4MDgwXSA9DQor
CQkJCWhlX2NhcC0+aGVfbWNzX25zc19zdXBwLnJ4X21jc184MHA4MDsNCisNCisJCWhlLT5tYXhf
bnNzX21jc1tDTURfSEVfTUNTX0JXMTYwXSA9DQorCQkJCWhlX2NhcC0+aGVfbWNzX25zc19zdXBw
LnJ4X21jc18xNjA7DQorCQkvKiBmYWxsIHRocm91Z2ggKi8NCisJZGVmYXVsdDoNCisJCWhlLT5t
YXhfbnNzX21jc1tDTURfSEVfTUNTX0JXODBdID0NCisJCQkJaGVfY2FwLT5oZV9tY3NfbnNzX3N1
cHAucnhfbWNzXzgwOw0KKwkJYnJlYWs7DQorCX0NCisNCisJaGUtPnRfZnJhbWVfZHVyID0NCisJ
CUhFX01BQyhDQVAxX1RGX01BQ19QQURfRFVSX01BU0ssIGVsZW0tPm1hY19jYXBfaW5mb1sxXSk7
DQorCWhlLT5tYXhfYW1wZHVfZXhwID0NCisJCUhFX01BQyhDQVAzX01BWF9BTVBEVV9MRU5fRVhQ
X01BU0ssIGVsZW0tPm1hY19jYXBfaW5mb1szXSk7DQorDQorCWhlLT5id19zZXQgPQ0KKwkJSEVf
UEhZKENBUDBfQ0hBTk5FTF9XSURUSF9TRVRfTUFTSywgZWxlbS0+cGh5X2NhcF9pbmZvWzBdKTsN
CisJaGUtPmRldmljZV9jbGFzcyA9DQorCQlIRV9QSFkoQ0FQMV9ERVZJQ0VfQ0xBU1NfQSwgZWxl
bS0+cGh5X2NhcF9pbmZvWzFdKTsNCisJaGUtPnB1bmNfcHJlYW1fcnggPQ0KKwkJSEVfUEhZKENB
UDFfUFJFQU1CTEVfUFVOQ19SWF9NQVNLLCBlbGVtLT5waHlfY2FwX2luZm9bMV0pOw0KKw0KKwlo
ZS0+ZGNtX3R4X21vZGUgPQ0KKwkJSEVfUEhZKENBUDNfRENNX01BWF9DT05TVF9UWF9NQVNLLCBl
bGVtLT5waHlfY2FwX2luZm9bM10pOw0KKwloZS0+ZGNtX3R4X21heF9uc3MgPQ0KKwkJSEVfUEhZ
KENBUDNfRENNX01BWF9UWF9OU1NfMiwgZWxlbS0+cGh5X2NhcF9pbmZvWzNdKTsNCisJaGUtPmRj
bV9yeF9tb2RlID0NCisJCUhFX1BIWShDQVAzX0RDTV9NQVhfQ09OU1RfUlhfTUFTSywgZWxlbS0+
cGh5X2NhcF9pbmZvWzNdKTsNCisJaGUtPmRjbV9yeF9tYXhfbnNzID0NCisJCUhFX1BIWShDQVAz
X0RDTV9NQVhfUlhfTlNTXzIsIGVsZW0tPnBoeV9jYXBfaW5mb1szXSk7DQorCWhlLT5kY21fcnhf
bWF4X25zcyA9DQorCQlIRV9QSFkoQ0FQOF9EQ01fTUFYX1JVX01BU0ssIGVsZW0tPnBoeV9jYXBf
aW5mb1s4XSk7DQorDQorCWhlLT5wa3RfZXh0ID0gMjsNCit9DQorDQorc3RhdGljIHZvaWQNCitt
dDc5MTVfbWN1X3N0YV9tdXJ1X3RsdihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgaWVlZTgw
MjExX3N0YSAqc3RhKQ0KK3sNCisJc3RydWN0IGllZWU4MDIxMV9zdGFfaGVfY2FwICpoZV9jYXAg
PSAmc3RhLT5oZV9jYXA7DQorCXN0cnVjdCBpZWVlODAyMTFfaGVfY2FwX2VsZW0gKmVsZW0gPSAm
aGVfY2FwLT5oZV9jYXBfZWxlbTsNCisJc3RydWN0IHN0YV9yZWNfbXVydSAqbXVydTsNCisJc3Ry
dWN0IHRsdiAqdGx2Ow0KKw0KKwl0bHYgPSBtdDc5MTVfbWN1X2FkZF90bHYoc2tiLCBTVEFfUkVD
X01VUlUsIHNpemVvZigqbXVydSkpOw0KKw0KKwltdXJ1ID0gKHN0cnVjdCBzdGFfcmVjX211cnUg
Kil0bHY7DQorCW11cnUtPmNmZy5vZmRtYV9kbF9lbiA9IHRydWU7DQorCW11cnUtPmNmZy5vZmRt
YV91bF9lbiA9IHRydWU7DQorCW11cnUtPmNmZy5taW1vX2RsX2VuID0gdHJ1ZTsNCisJbXVydS0+
Y2ZnLm1pbW9fdWxfZW4gPSB0cnVlOw0KKw0KKwltdXJ1LT5vZmRtYV9kbC5wdW5jX3ByZWFtX3J4
ID0NCisJCUhFX1BIWShDQVAxX1BSRUFNQkxFX1BVTkNfUlhfTUFTSywgZWxlbS0+cGh5X2NhcF9p
bmZvWzFdKTsNCisJbXVydS0+b2ZkbWFfZGwuaGVfMjBtX2luXzQwbV8yZyA9DQorCQlIRV9QSFko
Q0FQOF8yME1IWl9JTl80ME1IWl9IRV9QUERVX0lOXzJHLCBlbGVtLT5waHlfY2FwX2luZm9bOF0p
Ow0KKwltdXJ1LT5vZmRtYV9kbC5oZV8yMG1faW5fMTYwbSA9DQorCQlIRV9QSFkoQ0FQOF8yME1I
Wl9JTl8xNjBNSFpfSEVfUFBEVSwgZWxlbS0+cGh5X2NhcF9pbmZvWzhdKTsNCisJbXVydS0+b2Zk
bWFfZGwuaGVfODBtX2luXzE2MG0gPQ0KKwkJSEVfUEhZKENBUDhfODBNSFpfSU5fMTYwTUhaX0hF
X1BQRFUsIGVsZW0tPnBoeV9jYXBfaW5mb1s4XSk7DQorCW11cnUtPm9mZG1hX2RsLmx0MTZfc2ln
YiA9IDA7DQorCW11cnUtPm9mZG1hX2RsLnJ4X3N1X2NvbXBfc2lnYiA9IDA7DQorCW11cnUtPm9m
ZG1hX2RsLnJ4X3N1X25vbl9jb21wX3NpZ2IgPSAwOw0KKw0KKwltdXJ1LT5vZmRtYV91bC50X2Zy
YW1lX2R1ciA9DQorCQlIRV9NQUMoQ0FQMV9URl9NQUNfUEFEX0RVUl9NQVNLLCBlbGVtLT5tYWNf
Y2FwX2luZm9bMV0pOw0KKwltdXJ1LT5vZmRtYV91bC5tdV9jYXNjYWRpbmcgPQ0KKwkJSEVfTUFD
KENBUDJfTVVfQ0FTQ0FESU5HLCBlbGVtLT5tYWNfY2FwX2luZm9bMl0pOw0KKwltdXJ1LT5vZmRt
YV91bC51b19yYSA9DQorCQlIRV9NQUMoQ0FQM19PRkRNQV9SQSwgZWxlbS0+bWFjX2NhcF9pbmZv
WzNdKTsNCisJbXVydS0+b2ZkbWFfdWwuaGVfMng5OTZfdG9uZSA9IDA7DQorCW11cnUtPm9mZG1h
X3VsLnJ4X3RfZnJhbWVfMTFhYyA9IDA7DQorDQorCW11cnUtPm1pbW9fZGwudmh0X211X2JmZWUg
PQ0KKwkJISEoc3RhLT52aHRfY2FwLmNhcCAmIElFRUU4MDIxMV9WSFRfQ0FQX01VX0JFQU1GT1JN
RUVfQ0FQQUJMRSk7DQorCW11cnUtPm1pbW9fZGwucGFydGlhbF9id19kbF9taW1vID0NCisJCUhF
X1BIWShDQVA2X1BBUlRJQUxfQkFORFdJRFRIX0RMX01VTUlNTywgZWxlbS0+cGh5X2NhcF9pbmZv
WzZdKTsNCisNCisJbXVydS0+bWltb191bC5mdWxsX3VsX21pbW8gPQ0KKwkJSEVfUEhZKENBUDJf
VUxfTVVfRlVMTF9NVV9NSU1PLCBlbGVtLT5waHlfY2FwX2luZm9bMl0pOw0KKwltdXJ1LT5taW1v
X3VsLnBhcnRpYWxfdWxfbWltbyA9DQorCQlIRV9QSFkoQ0FQMl9VTF9NVV9QQVJUSUFMX01VX01J
TU8sIGVsZW0tPnBoeV9jYXBfaW5mb1syXSk7DQorfQ0KKw0KIHN0YXRpYyB2b2lkDQogbXQ3OTE1
X21jdV9zdGFfdGx2KHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHN0cnVjdCBza19idWZmICpza2Is
DQogCQkgICBzdHJ1Y3QgaWVlZTgwMjExX3N0YSAqc3RhKQ0KQEAgLTEyODcsNiArMTQ3MCwxNCBA
QCBtdDc5MTVfbWN1X3N0YV90bHYoc3RydWN0IG10NzkxNV9kZXYgKmRldiwgc3RydWN0IHNrX2J1
ZmYgKnNrYiwNCiAJCXZodC0+dmh0X3J4X21jc19tYXAgPSBzdGEtPnZodF9jYXAudmh0X21jcy5y
eF9tY3NfbWFwOw0KIAkJdmh0LT52aHRfdHhfbWNzX21hcCA9IHN0YS0+dmh0X2NhcC52aHRfbWNz
LnR4X21jc19tYXA7DQogCX0NCisNCisJLyogc3RhcmVjIGhlICovDQorCWlmIChzdGEtPmhlX2Nh
cC5oYXNfaGUpDQorCQltdDc5MTVfbWN1X3N0YV9oZV90bHYoc2tiLCBzdGEpOw0KKw0KKwkvKiBz
dGFyZWMgbXVydSAqLw0KKwlpZiAoc3RhLT5oZV9jYXAuaGFzX2hlIHx8IHN0YS0+dmh0X2NhcC52
aHRfc3VwcG9ydGVkKQ0KKwkJbXQ3OTE1X21jdV9zdGFfbXVydV90bHYoc2tiLCBzdGEpOw0KIH0N
CiANCiBzdGF0aWMgdm9pZA0KQEAgLTE0ODgsNiArMTY3OSwxMSBAQCBtdDc5MTVfbWN1X3N0YV9y
YXRlX2N0cmxfdGx2KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYs
DQogCQl9DQogCX0NCiANCisJaWYgKHN0YS0+aGVfY2FwLmhhc19oZSkgew0KKwkJcmEtPnN1cHBf
bW9kZSB8PSBNT0RFX0hFOw0KKwkJY2FwIHw9IFNUQV9DQVBfSEU7DQorCX0NCisNCiAJcmEtPnN0
YV9zdGF0dXMgPSBjcHVfdG9fbGUzMihjYXApOw0KIA0KIAlzd2l0Y2ggKEJJVChmbHMocmEtPnN1
cHBfbW9kZSkgLSAxKSkgew0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3OTE1L21jdS5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MTUvbWN1LmgNCmluZGV4IGIyZjM3Yjg3MTE3Yy4uNTJiNDIwMjEwOTA4IDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmgNCisr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5oDQpAQCAt
NjY5LDYgKzY2OSw3NSBAQCBzdHJ1Y3Qgc3RhX3JlY192aHQgew0KIAl1OCByc3ZbM107DQogfSBf
X3BhY2tlZDsNCiANCitzdHJ1Y3Qgc3RhX3JlY19tdXJ1IHsNCisJX19sZTE2IHRhZzsNCisJX19s
ZTE2IGxlbjsNCisNCisJc3RydWN0IHsNCisJCWJvb2wgb2ZkbWFfZGxfZW47DQorCQlib29sIG9m
ZG1hX3VsX2VuOw0KKwkJYm9vbCBtaW1vX2RsX2VuOw0KKwkJYm9vbCBtaW1vX3VsX2VuOw0KKwkJ
Ym9vbCByc3ZbNF07DQorCX0gY2ZnOw0KKw0KKwlzdHJ1Y3Qgew0KKwkJdTggcHVuY19wcmVhbV9y
eDsNCisJCWJvb2wgaGVfMjBtX2luXzQwbV8yZzsNCisJCWJvb2wgaGVfMjBtX2luXzE2MG07DQor
CQlib29sIGhlXzgwbV9pbl8xNjBtOw0KKwkJYm9vbCBsdDE2X3NpZ2I7DQorCQlib29sIHJ4X3N1
X2NvbXBfc2lnYjsNCisJCWJvb2wgcnhfc3Vfbm9uX2NvbXBfc2lnYjsNCisJCWJvb2wgcnN2Ow0K
Kwl9IG9mZG1hX2RsOw0KKw0KKwlzdHJ1Y3Qgew0KKwkJdTggdF9mcmFtZV9kdXI7DQorCQl1OCBt
dV9jYXNjYWRpbmc7DQorCQl1OCB1b19yYTsNCisJCXU4IGhlXzJ4OTk2X3RvbmU7DQorCQl1OCBy
eF90X2ZyYW1lXzExYWM7DQorCQl1OCByc3ZbM107DQorCX0gb2ZkbWFfdWw7DQorDQorCXN0cnVj
dCB7DQorCQlib29sIHZodF9tdV9iZmVlOw0KKwkJYm9vbCBwYXJ0aWFsX2J3X2RsX21pbW87DQor
CQl1OCByc3ZbMl07DQorCX0gbWltb19kbDsNCisNCisJc3RydWN0IHsNCisJCWJvb2wgZnVsbF91
bF9taW1vOw0KKwkJYm9vbCBwYXJ0aWFsX3VsX21pbW87DQorCQl1OCByc3ZbMl07DQorCX0gbWlt
b191bDsNCit9IF9fcGFja2VkOw0KKw0KK3N0cnVjdCBzdGFfcmVjX2hlIHsNCisJX19sZTE2IHRh
ZzsNCisJX19sZTE2IGxlbjsNCisNCisJX19sZTMyIGhlX2NhcDsNCisNCisJdTggdF9mcmFtZV9k
dXI7DQorCXU4IG1heF9hbXBkdV9leHA7DQorCXU4IGJ3X3NldDsNCisJdTggZGV2aWNlX2NsYXNz
Ow0KKwl1OCBkY21fdHhfbW9kZTsNCisJdTggZGNtX3R4X21heF9uc3M7DQorCXU4IGRjbV9yeF9t
b2RlOw0KKwl1OCBkY21fcnhfbWF4X25zczsNCisJdTggZGNtX21heF9ydTsNCisJdTggcHVuY19w
cmVhbV9yeDsNCisJdTggcGt0X2V4dDsNCisJdTggcnN2MTsNCisNCisJX19sZTE2IG1heF9uc3Nf
bWNzW0NNRF9IRV9NQ1NfQldfTlVNXTsNCisNCisJdTggcnN2MlsyXTsNCit9IF9fcGFja2VkOw0K
Kw0KIHN0cnVjdCBzdGFfcmVjX2JhIHsNCiAJX19sZTE2IHRhZzsNCiAJX19sZTE2IGxlbjsNCkBA
IC04MjMsMTAgKzg5MiwxMiBAQCBlbnVtIHsNCiAjZGVmaW5lIE1UNzkxNV9TVEFfVVBEQVRFX01B
WF9TSVpFCShzaXplb2Yoc3RydWN0IHN0YV9yZXFfaGRyKSArCVwNCiAJCQkJCSBzaXplb2Yoc3Ry
dWN0IHN0YV9yZWNfYmFzaWMpICsJXA0KIAkJCQkJIHNpemVvZihzdHJ1Y3Qgc3RhX3JlY19odCkg
KwlcDQorCQkJCQkgc2l6ZW9mKHN0cnVjdCBzdGFfcmVjX2hlKSArCVwNCiAJCQkJCSBzaXplb2Yo
c3RydWN0IHN0YV9yZWNfYmEpICsJXA0KIAkJCQkJIHNpemVvZihzdHJ1Y3Qgc3RhX3JlY192aHQp
ICsJXA0KIAkJCQkJIHNpemVvZihzdHJ1Y3QgdGx2KSArCQlcDQogCQkJCQkgc2l6ZW9mKHN0cnVj
dCBzdGFfcmVjX2Ftc2R1KSArCVwNCisJCQkJCSBzaXplb2Yoc3RydWN0IHN0YV9yZWNfbXVydSkg
KwlcDQogCQkJCQkgc2l6ZW9mKHN0cnVjdCBzdGFfcmVjX3NlYykgKwlcDQogCQkJCQkgc2l6ZW9m
KHN0cnVjdCBzdGFfcmVjX3JhKSArCVwNCiAJCQkJCSBNVDc5MTVfV1RCTF9VUERBVEVfTUFYX1NJ
WkUpDQpAQCAtODU0LDYgKzkyNSw3IEBAIGVudW0gew0KICNkZWZpbmUgTU9ERV9PRkRNCQkJQklU
KDEpDQogI2RlZmluZSBNT0RFX0hUCQkJCUJJVCgyKQ0KICNkZWZpbmUgTU9ERV9WSFQJCQlCSVQo
MykNCisjZGVmaW5lIE1PREVfSEUJCQkJQklUKDQpDQogDQogI2RlZmluZSBTVEFfQ0FQX1dNTQkJ
CUJJVCgwKQ0KICNkZWZpbmUgU1RBX0NBUF9TR0lfMjAJCQlCSVQoNCkNCkBAIC04NjgsNSArOTQw
LDMzIEBAIGVudW0gew0KICNkZWZpbmUgU1RBX0NBUF9MRFBDCQkJQklUKDI0KQ0KICNkZWZpbmUg
U1RBX0NBUF9IVAkJCUJJVCgyNikNCiAjZGVmaW5lIFNUQV9DQVBfVkhUCQkJQklUKDI3KQ0KKyNk
ZWZpbmUgU1RBX0NBUF9IRQkJCUJJVCgyOCkNCisNCisvKiBIRSBNQUMgKi8NCisjZGVmaW5lIFNU
QV9SRUNfSEVfQ0FQX0hUQwkJCUJJVCgwKQ0KKyNkZWZpbmUgU1RBX1JFQ19IRV9DQVBfQlFSCQkJ
QklUKDEpDQorI2RlZmluZSBTVEFfUkVDX0hFX0NBUF9CU1IJCQlCSVQoMikNCisjZGVmaW5lIFNU
QV9SRUNfSEVfQ0FQX09NCQkJQklUKDMpDQorI2RlZmluZSBTVEFfUkVDX0hFX0NBUF9BTVNEVV9J
Tl9BTVBEVQkJQklUKDQpDQorLyogSEUgUEhZICovDQorI2RlZmluZSBTVEFfUkVDX0hFX0NBUF9E
VUFMX0JBTkQJCUJJVCg1KQ0KKyNkZWZpbmUgU1RBX1JFQ19IRV9DQVBfTERQQwkJCUJJVCg2KQ0K
KyNkZWZpbmUgU1RBX1JFQ19IRV9DQVBfVFJJR19DUUlfRksJCUJJVCg3KQ0KKyNkZWZpbmUgU1RB
X1JFQ19IRV9DQVBfUEFSVElBTF9CV19FWFRfUkFOR0UJQklUKDgpDQorLyogU1RCQyAqLw0KKyNk
ZWZpbmUgU1RBX1JFQ19IRV9DQVBfTEVfRVFfODBNX1RYX1NUQkMJQklUKDkpDQorI2RlZmluZSBT
VEFfUkVDX0hFX0NBUF9MRV9FUV84ME1fUlhfU1RCQwlCSVQoMTApDQorI2RlZmluZSBTVEFfUkVD
X0hFX0NBUF9HVF84ME1fVFhfU1RCQwkJQklUKDExKQ0KKyNkZWZpbmUgU1RBX1JFQ19IRV9DQVBf
R1RfODBNX1JYX1NUQkMJCUJJVCgxMikNCisvKiBHSSAqLw0KKyNkZWZpbmUgU1RBX1JFQ19IRV9D
QVBfU1VfUFBEVV8xTFRGXzhVU19HSQlCSVQoMTMpDQorI2RlZmluZSBTVEFfUkVDX0hFX0NBUF9T
VV9NVV9QUERVXzRMVEZfOFVTX0dJCUJJVCgxNCkNCisjZGVmaW5lIFNUQV9SRUNfSEVfQ0FQX0VS
X1NVX1BQRFVfMUxURl84VVNfR0kJQklUKDE1KQ0KKyNkZWZpbmUgU1RBX1JFQ19IRV9DQVBfRVJf
U1VfUFBEVV80TFRGXzhVU19HSQlCSVQoMTYpDQorI2RlZmluZSBTVEFfUkVDX0hFX0NBUF9ORFBf
NExURl8zRE9UMk1TX0dJCUJJVCgxNykNCisvKiAyNDIgVE9ORSAqLw0KKyNkZWZpbmUgU1RBX1JF
Q19IRV9DQVBfQlcyMF9SVTI0Ml9TVVBQT1JUCUJJVCgxOCkNCisjZGVmaW5lIFNUQV9SRUNfSEVf
Q0FQX1RYXzEwMjRRQU1fVU5ERVJfUlUyNDIJQklUKDE5KQ0KKyNkZWZpbmUgU1RBX1JFQ19IRV9D
QVBfUlhfMTAyNFFBTV9VTkRFUl9SVTI0MglCSVQoMjApDQogDQogI2VuZGlmDQotLSANCjIuMTgu
MA0K

