Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3491A8D28
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 23:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633594AbgDNVCj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 17:02:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47633 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2633568AbgDNVBw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 17:01:52 -0400
X-UUID: e2e51973878841ce8c30a73f5140377d-20200415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yiKAiI2nhfSsLuaGlvOkbDyVt0FQUMwZlFAur0d3G10=;
        b=Crpr5JtWNRvdcN4N0fCLpkrKZ6vx5YOzzKzSoFuqDMg0GP+GfWBk21JCYvMEHFqtOmLWV6Lr23ntbX60fQJbPaFzmQMXD94tsDa8h/X7mfRCKQKXsp1vVfRK+Ikl0lFgBnqvC9GIkpdjTliCBh/iE1FZuLmU8Oowc8zAVHYOp90=;
X-UUID: e2e51973878841ce8c30a73f5140377d-20200415
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2015758129; Wed, 15 Apr 2020 05:01:30 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Apr 2020 05:01:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Apr 2020 05:01:26 +0800
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
Subject: [PATCH v2 09/18] mt76: mt7915: register per-phy HE capabilities for each interface
Date:   Wed, 15 Apr 2020 05:01:07 +0800
Message-ID: <5101614598ed6c361a47a42552581a928c9b6886.1586895593.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1586895593.git.ryder.lee@mediatek.com>
References: <cover.1586895593.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0B78B7865578240104DB88AD0851B9236A7746B0FF8F07CA60E0827D3ECC93702000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhlIGNhcGFiaWxpdGllcyBmb3IgdGhlIEhFIGludGVyZmFjZXMgYXJlIGdlbmVyYXRlZCBmcm9t
IHRoZSBjYXBhYmlsaXRpZXMNCnJlcG9ydGVkIGJ5IHRoZSBmaXJtd2FyZS4NCg0KVGhpcyBzaG91
bGQgbW92ZSB0byBjb21tb24gZmlsZSBvbmNlIHdlIGdvdCBvdGhlciBIRSBkZXZpY2VzIHN1cHBv
cnQuDQoNClNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4N
Ci0tLQ0KIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jICB8IDE5
MCArKysrKysrKysrKysrKysrKysNCiAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
OTE1L21haW4uYyAgfCAgIDEgKw0KIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
MTUvbWN1LmMgICB8ICAgOSArDQogLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzkx
NS9tY3UuaCAgIHwgICAzICsNCiAuLi4vd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbXQ3
OTE1LmggICAgfCAgIDMgKw0KIDUgZmlsZXMgY2hhbmdlZCwgMjA2IGluc2VydGlvbnMoKykNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2lu
aXQuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2luaXQuYw0K
aW5kZXggYWJjZTM3Y2E5MjUyLi5iYjgzMjVlMmVkYmQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMNCisrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2luaXQuYw0KQEAgLTIzOSw2ICsyMzksMTk0
IEBAIG10NzkxNV9pbml0X3dpcGh5KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KQ0KIAlody0+bWF4
X3R4X2ZyYWdtZW50cyA9IDQ7DQogfQ0KIA0KK3N0YXRpYyB2b2lkDQorbXQ3OTE1X2dlbl9wcGVf
dGhyZXNoKHU4ICpoZV9wcGV0KQ0KK3sNCisJaW50IHJ1LCBuc3MsIG1heF9uc3MgPSAxLCBtYXhf
cnUgPSAzOw0KKwl1OCBiaXQgPSA3LCBydV9iaXRfbWFzayA9IDB4NzsNCisJdTggcHBldDE2X3Bw
ZXQ4X3J1M19ydTBbXSA9IHsweDFjLCAweGM3LCAweDcxfTsNCisNCisJaGVfcHBldFswXSA9IG1h
eF9uc3MgJiBJRUVFODAyMTFfUFBFX1RIUkVTX05TU19NQVNLOw0KKwloZV9wcGV0WzBdIHw9IChy
dV9iaXRfbWFzayA8PA0KKwkJICAgICAgIElFRUU4MDIxMV9QUEVfVEhSRVNfUlVfSU5ERVhfQklU
TUFTS19QT1MpICYNCisJCQlJRUVFODAyMTFfUFBFX1RIUkVTX1JVX0lOREVYX0JJVE1BU0tfTUFT
SzsNCisNCisJZm9yIChuc3MgPSAwOyBuc3MgPD0gbWF4X25zczsgbnNzKyspIHsNCisJCWZvciAo
cnUgPSAwOyBydSA8IG1heF9ydTsgcnUrKykgew0KKwkJCXU4IHZhbDsNCisJCQlpbnQgaTsNCisN
CisJCQlpZiAoIShydV9iaXRfbWFzayAmIEJJVChydSkpKQ0KKwkJCQljb250aW51ZTsNCisNCisJ
CQl2YWwgPSAocHBldDE2X3BwZXQ4X3J1M19ydTBbbnNzXSA+PiAocnUgKiA2KSkgJg0KKwkJCSAg
ICAgICAweDNmOw0KKwkJCXZhbCA9ICgodmFsID4+IDMpICYgMHg3KSB8ICgodmFsICYgMHg3KSA8
PCAzKTsNCisJCQlmb3IgKGkgPSA1OyBpID49IDA7IGktLSkgew0KKwkJCQloZV9wcGV0W2JpdCAv
IDhdIHw9DQorCQkJCQkoKHZhbCA+PiBpKSAmIDB4MSkgPDwgKChiaXQgJSA4KSk7DQorCQkJCWJp
dCsrOw0KKwkJCX0NCisJCX0NCisJfQ0KK30NCisNCitzdGF0aWMgaW50DQorbXQ3OTE1X2luaXRf
aGVfY2FwcyhzdHJ1Y3QgbXQ3OTE1X3BoeSAqcGh5LCBlbnVtIG5sODAyMTFfYmFuZCBiYW5kLA0K
KwkJICAgIHN0cnVjdCBpZWVlODAyMTFfc2JhbmRfaWZ0eXBlX2RhdGEgKmRhdGEpDQorew0KKwlp
bnQgaSwgaWR4ID0gMDsNCisJaW50IG5zcyA9IGh3ZWlnaHQ4KHBoeS0+Y2hhaW5tYXNrKTsNCisJ
dTE2IG1jc19tYXAgPSAwOw0KKw0KKwlmb3IgKGkgPSAwOyBpIDwgODsgaSsrKSB7DQorCQlpZiAo
aSA8IG5zcykNCisJCQltY3NfbWFwIHw9IChJRUVFODAyMTFfSEVfTUNTX1NVUFBPUlRfMF8xMSA8
PCAoaSAqIDIpKTsNCisJCWVsc2UNCisJCQltY3NfbWFwIHw9IChJRUVFODAyMTFfSEVfTUNTX05P
VF9TVVBQT1JURUQgPDwgKGkgKiAyKSk7DQorCX0NCisNCisJZm9yIChpID0gMDsgaSA8IE5VTV9O
TDgwMjExX0lGVFlQRVM7IGkrKykgew0KKwkJc3RydWN0IGllZWU4MDIxMV9zdGFfaGVfY2FwICpo
ZV9jYXAgPSAmZGF0YVtpZHhdLmhlX2NhcDsNCisJCXN0cnVjdCBpZWVlODAyMTFfaGVfY2FwX2Vs
ZW0gKmhlX2NhcF9lbGVtID0NCisJCQkJJmhlX2NhcC0+aGVfY2FwX2VsZW07DQorCQlzdHJ1Y3Qg
aWVlZTgwMjExX2hlX21jc19uc3Nfc3VwcCAqaGVfbWNzID0NCisJCQkJJmhlX2NhcC0+aGVfbWNz
X25zc19zdXBwOw0KKw0KKwkJc3dpdGNoIChpKSB7DQorCQljYXNlIE5MODAyMTFfSUZUWVBFX1NU
QVRJT046DQorCQljYXNlIE5MODAyMTFfSUZUWVBFX0FQOg0KKyNpZmRlZiBDT05GSUdfTUFDODAy
MTFfTUVTSA0KKwkJY2FzZSBOTDgwMjExX0lGVFlQRV9NRVNIX1BPSU5UOg0KKyNlbmRpZg0KKwkJ
CWJyZWFrOw0KKwkJZGVmYXVsdDoNCisJCQljb250aW51ZTsNCisJCX0NCisNCisJCWRhdGFbaWR4
XS50eXBlc19tYXNrID0gQklUKGkpOw0KKwkJaGVfY2FwLT5oYXNfaGUgPSB0cnVlOw0KKw0KKwkJ
aGVfY2FwX2VsZW0tPm1hY19jYXBfaW5mb1swXSA9DQorCQkJSUVFRTgwMjExX0hFX01BQ19DQVAw
X0hUQ19IRTsNCisJCWhlX2NhcF9lbGVtLT5tYWNfY2FwX2luZm9bMV0gPQ0KKwkJCUlFRUU4MDIx
MV9IRV9NQUNfQ0FQMV9URl9NQUNfUEFEX0RVUl8wVVMgfA0KKwkJCUlFRUU4MDIxMV9IRV9NQUNf
Q0FQMV9NVUxUSV9USURfQUdHX1JYX1FPU18xOw0KKwkJaGVfY2FwX2VsZW0tPm1hY19jYXBfaW5m
b1syXSA9DQorCQkJSUVFRTgwMjExX0hFX01BQ19DQVAyX0JTUjsNCisJCWhlX2NhcF9lbGVtLT5t
YWNfY2FwX2luZm9bM10gPQ0KKwkJCUlFRUU4MDIxMV9IRV9NQUNfQ0FQM19PTUlfQ09OVFJPTCB8
DQorCQkJSUVFRTgwMjExX0hFX01BQ19DQVAzX01BWF9BTVBEVV9MRU5fRVhQX1JFU0VSVkVEOw0K
KwkJaGVfY2FwX2VsZW0tPm1hY19jYXBfaW5mb1s0XSA9DQorCQkJSUVFRTgwMjExX0hFX01BQ19D
QVA0X0FNRFNVX0lOX0FNUERVOw0KKw0KKwkJaWYgKGJhbmQgPT0gTkw4MDIxMV9CQU5EXzJHSFop
DQorCQkJaGVfY2FwX2VsZW0tPnBoeV9jYXBfaW5mb1swXSA9DQorCQkJCUlFRUU4MDIxMV9IRV9Q
SFlfQ0FQMF9DSEFOTkVMX1dJRFRIX1NFVF80ME1IWl9JTl8yRzsNCisJCWVsc2UgaWYgKGJhbmQg
PT0gTkw4MDIxMV9CQU5EXzVHSFopDQorCQkJaGVfY2FwX2VsZW0tPnBoeV9jYXBfaW5mb1swXSA9
DQorCQkJCUlFRUU4MDIxMV9IRV9QSFlfQ0FQMF9DSEFOTkVMX1dJRFRIX1NFVF80ME1IWl84ME1I
Wl9JTl81RyB8DQorCQkJCUlFRUU4MDIxMV9IRV9QSFlfQ0FQMF9DSEFOTkVMX1dJRFRIX1NFVF8x
NjBNSFpfSU5fNUcgfA0KKwkJCQlJRUVFODAyMTFfSEVfUEhZX0NBUDBfQ0hBTk5FTF9XSURUSF9T
RVRfODBQTFVTODBfTUhaX0lOXzVHOw0KKw0KKwkJaGVfY2FwX2VsZW0tPnBoeV9jYXBfaW5mb1sx
XSA9DQorCQkJSUVFRTgwMjExX0hFX1BIWV9DQVAxX0xEUENfQ09ESU5HX0lOX1BBWUxPQUQ7DQor
CQloZV9jYXBfZWxlbS0+cGh5X2NhcF9pbmZvWzJdID0NCisJCQlJRUVFODAyMTFfSEVfUEhZX0NB
UDJfTkRQXzR4X0xURl9BTkRfM18yVVMgfA0KKwkJCUlFRUU4MDIxMV9IRV9QSFlfQ0FQMl9TVEJD
X1RYX1VOREVSXzgwTUhaIHwNCisJCQlJRUVFODAyMTFfSEVfUEhZX0NBUDJfU1RCQ19SWF9VTkRF
Ul84ME1IWjsNCisNCisJCS8qIFRPRE86IFR4QkYgJiBNVSAmIE1FU0ggKi8NCisNCisJCXN3aXRj
aCAoaSkgew0KKwkJY2FzZSBOTDgwMjExX0lGVFlQRV9BUDoNCisJCQloZV9jYXBfZWxlbS0+bWFj
X2NhcF9pbmZvWzBdIHw9DQorCQkJCUlFRUU4MDIxMV9IRV9NQUNfQ0FQMF9UV1RfUkVTOw0KKwkJ
CWhlX2NhcF9lbGVtLT5tYWNfY2FwX2luZm9bNF0gfD0NCisJCQkJSUVFRTgwMjExX0hFX01BQ19D
QVA0X0JRUjsNCisJCQloZV9jYXBfZWxlbS0+cGh5X2NhcF9pbmZvWzNdIHw9DQorCQkJCUlFRUU4
MDIxMV9IRV9QSFlfQ0FQM19EQ01fTUFYX0NPTlNUX1RYX1FQU0sgfA0KKwkJCQlJRUVFODAyMTFf
SEVfUEhZX0NBUDNfRENNX01BWF9DT05TVF9SWF9RUFNLOw0KKwkJCWhlX2NhcF9lbGVtLT5waHlf
Y2FwX2luZm9bNl0gfD0NCisJCQkJSUVFRTgwMjExX0hFX1BIWV9DQVA2X1BQRV9USFJFU0hPTERf
UFJFU0VOVDsNCisJCQloZV9jYXBfZWxlbS0+cGh5X2NhcF9pbmZvWzldIHw9DQorCQkJCUlFRUU4
MDIxMV9IRV9QSFlfQ0FQOV9SWF8xMDI0X1FBTV9MRVNTX1RIQU5fMjQyX1RPTkVfUlU7DQorCQkJ
YnJlYWs7DQorCQljYXNlIE5MODAyMTFfSUZUWVBFX1NUQVRJT046DQorCQkJaGVfY2FwX2VsZW0t
Pm1hY19jYXBfaW5mb1swXSB8PQ0KKwkJCQlJRUVFODAyMTFfSEVfTUFDX0NBUDBfVFdUX1JFUTsN
CisJCQloZV9jYXBfZWxlbS0+bWFjX2NhcF9pbmZvWzNdIHw9DQorCQkJCUlFRUU4MDIxMV9IRV9N
QUNfQ0FQM19GTEVYX1RXVF9TQ0hFRDsNCisNCisJCQlpZiAoYmFuZCA9PSBOTDgwMjExX0JBTkRf
MkdIWikNCisJCQkJaGVfY2FwX2VsZW0tPnBoeV9jYXBfaW5mb1swXSB8PQ0KKwkJCQkJSUVFRTgw
MjExX0hFX1BIWV9DQVAwX0NIQU5ORUxfV0lEVEhfU0VUX1JVX01BUFBJTkdfSU5fMkc7DQorCQkJ
ZWxzZSBpZiAoYmFuZCA9PSBOTDgwMjExX0JBTkRfNUdIWikNCisJCQkJaGVfY2FwX2VsZW0tPnBo
eV9jYXBfaW5mb1swXSB8PQ0KKwkJCQkJSUVFRTgwMjExX0hFX1BIWV9DQVAwX0NIQU5ORUxfV0lE
VEhfU0VUX1JVX01BUFBJTkdfSU5fNUc7DQorDQorCQkJaGVfY2FwX2VsZW0tPnBoeV9jYXBfaW5m
b1sxXSB8PQ0KKwkJCQlJRUVFODAyMTFfSEVfUEhZX0NBUDFfREVWSUNFX0NMQVNTX0E7DQorCQkJ
aGVfY2FwX2VsZW0tPnBoeV9jYXBfaW5mb1s4XSB8PQ0KKwkJCQlJRUVFODAyMTFfSEVfUEhZX0NB
UDhfMjBNSFpfSU5fNDBNSFpfSEVfUFBEVV9JTl8yRyB8DQorCQkJCUlFRUU4MDIxMV9IRV9QSFlf
Q0FQOF8yME1IWl9JTl8xNjBNSFpfSEVfUFBEVSB8DQorCQkJCUlFRUU4MDIxMV9IRV9QSFlfQ0FQ
OF84ME1IWl9JTl8xNjBNSFpfSEVfUFBEVTsNCisJCQloZV9jYXBfZWxlbS0+cGh5X2NhcF9pbmZv
WzldIHw9DQorCQkJCUlFRUU4MDIxMV9IRV9QSFlfQ0FQOV9UWF8xMDI0X1FBTV9MRVNTX1RIQU5f
MjQyX1RPTkVfUlU7DQorCQkJYnJlYWs7DQorI2lmZGVmIENPTkZJR19NQUM4MDIxMV9NRVNIDQor
CQljYXNlIE5MODAyMTFfSUZUWVBFX01FU0hfUE9JTlQ6DQorCQkJYnJlYWs7DQorI2VuZGlmDQor
CQl9DQorDQorCQloZV9tY3MtPnJ4X21jc184MCA9IGNwdV90b19sZTE2KG1jc19tYXApOw0KKwkJ
aGVfbWNzLT50eF9tY3NfODAgPSBjcHVfdG9fbGUxNihtY3NfbWFwKTsNCisJCWhlX21jcy0+cnhf
bWNzXzE2MCA9IGNwdV90b19sZTE2KG1jc19tYXApOw0KKwkJaGVfbWNzLT50eF9tY3NfMTYwID0g
Y3B1X3RvX2xlMTYobWNzX21hcCk7DQorCQloZV9tY3MtPnJ4X21jc184MHA4MCA9IGNwdV90b19s
ZTE2KG1jc19tYXApOw0KKwkJaGVfbWNzLT50eF9tY3NfODBwODAgPSBjcHVfdG9fbGUxNihtY3Nf
bWFwKTsNCisNCisJCW1lbXNldChoZV9jYXAtPnBwZV90aHJlcywgMCwgc2l6ZW9mKGhlX2NhcC0+
cHBlX3RocmVzKSk7DQorCQlpZiAoaGVfY2FwX2VsZW0tPnBoeV9jYXBfaW5mb1s2XSAmDQorCQkg
ICAgSUVFRTgwMjExX0hFX1BIWV9DQVA2X1BQRV9USFJFU0hPTERfUFJFU0VOVCkgew0KKwkJCW10
NzkxNV9nZW5fcHBlX3RocmVzaChoZV9jYXAtPnBwZV90aHJlcyk7DQorCQl9IGVsc2Ugew0KKwkJ
CWhlX2NhcF9lbGVtLT5waHlfY2FwX2luZm9bOV0gfD0NCisJCQkJSUVFRTgwMjExX0hFX1BIWV9D
QVA5X05PTUlNQUxfUEtUX1BBRERJTkdfMTZVUzsNCisJCX0NCisJCWlkeCsrOw0KKwl9DQorDQor
CXJldHVybiBpZHg7DQorfQ0KKw0KK3ZvaWQgbXQ3OTE1X3NldF9zdHJlYW1faGVfY2FwcyhzdHJ1
Y3QgbXQ3OTE1X3BoeSAqcGh5KQ0KK3sNCisJc3RydWN0IGllZWU4MDIxMV9zYmFuZF9pZnR5cGVf
ZGF0YSAqZGF0YTsNCisJc3RydWN0IGllZWU4MDIxMV9zdXBwb3J0ZWRfYmFuZCAqYmFuZDsNCisJ
c3RydWN0IG10NzZfZGV2ICptZGV2ID0gJnBoeS0+ZGV2LT5tdDc2Ow0KKwlpbnQgbjsNCisNCisJ
aWYgKG1kZXYtPmNhcC5oYXNfMmdoeikgew0KKwkJZGF0YSA9IHBoeS0+aWZ0eXBlW05MODAyMTFf
QkFORF8yR0haXTsNCisJCW4gPSBtdDc5MTVfaW5pdF9oZV9jYXBzKHBoeSwgTkw4MDIxMV9CQU5E
XzJHSFosIGRhdGEpOw0KKw0KKwkJYmFuZCA9ICZwaHktPm10NzYtPnNiYW5kXzJnLnNiYW5kOw0K
KwkJYmFuZC0+aWZ0eXBlX2RhdGEgPSBkYXRhOw0KKwkJYmFuZC0+bl9pZnR5cGVfZGF0YSA9IG47
DQorCX0NCisNCisJaWYgKG1kZXYtPmNhcC5oYXNfNWdoeikgew0KKwkJZGF0YSA9IHBoeS0+aWZ0
eXBlW05MODAyMTFfQkFORF81R0haXTsNCisJCW4gPSBtdDc5MTVfaW5pdF9oZV9jYXBzKHBoeSwg
Tkw4MDIxMV9CQU5EXzVHSFosIGRhdGEpOw0KKw0KKwkJYmFuZCA9ICZwaHktPm10NzYtPnNiYW5k
XzVnLnNiYW5kOw0KKwkJYmFuZC0+aWZ0eXBlX2RhdGEgPSBkYXRhOw0KKwkJYmFuZC0+bl9pZnR5
cGVfZGF0YSA9IG47DQorCX0NCit9DQorDQogc3RhdGljIHZvaWQNCiBtdDc5MTVfY2FwX2RiZGNf
ZW5hYmxlKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYpDQogew0KQEAgLTI1Niw2ICs0NDQsNyBAQCBt
dDc5MTVfY2FwX2RiZGNfZW5hYmxlKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYpDQogCWRldi0+bXBo
eS5ody0+d2lwaHktPmF2YWlsYWJsZV9hbnRlbm5hc190eCA9IGRldi0+cGh5LmNoYWlubWFzazsN
CiANCiAJbXQ3Nl9zZXRfc3RyZWFtX2NhcHMoJmRldi0+bXQ3NiwgdHJ1ZSk7DQorCW10NzkxNV9z
ZXRfc3RyZWFtX2hlX2NhcHMoJmRldi0+cGh5KTsNCiB9DQogDQogc3RhdGljIHZvaWQNCkBAIC0y
NzEsNiArNDYwLDcgQEAgbXQ3OTE1X2NhcF9kYmRjX2Rpc2FibGUoc3RydWN0IG10NzkxNV9kZXYg
KmRldikNCiAJZGV2LT5tcGh5Lmh3LT53aXBoeS0+YXZhaWxhYmxlX2FudGVubmFzX3R4ID0gZGV2
LT5jaGFpbm1hc2s7DQogDQogCW10NzZfc2V0X3N0cmVhbV9jYXBzKCZkZXYtPm10NzYsIHRydWUp
Ow0KKwltdDc5MTVfc2V0X3N0cmVhbV9oZV9jYXBzKCZkZXYtPnBoeSk7DQogfQ0KIA0KIGludCBt
dDc5MTVfcmVnaXN0ZXJfZXh0X3BoeShzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2KQ0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21haW4uYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21haW4uYw0KaW5kZXggMjMx
YmFlNDE4NGNhLi4wOTcyMjU2OTIwMjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3OTE1L21haW4uYw0KQEAgLTY5MSw2ICs2OTEsNyBAQCBtdDc5MTVf
c2V0X2FudGVubmEoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHUzMiB0eF9hbnQsIHUzMiByeF9h
bnQpDQogCXBoeS0+Y2hhaW5tYXNrID0gdHhfYW50Ow0KIA0KIAltdDc2X3NldF9zdHJlYW1fY2Fw
cygmZGV2LT5tdDc2LCB0cnVlKTsNCisJbXQ3OTE1X3NldF9zdHJlYW1faGVfY2FwcyhwaHkpOw0K
IA0KIAltdXRleF91bmxvY2soJmRldi0+bXQ3Ni5tdXRleCk7DQogDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYw0KaW5kZXggNzU3M2VmOGY4ZGZi
Li4yMzljYmMwYTJlZTkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L210NzkxNS9tY3UuYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5MTUvbWN1LmMNCkBAIC0xMzcsMTEgKzEzNywxMyBAQCBtdDc5MTVfZ2V0X3BoeV9t
b2RlKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsDQog
ew0KIAlzdHJ1Y3QgaWVlZTgwMjExX3N0YV9odF9jYXAgKmh0X2NhcDsNCiAJc3RydWN0IGllZWU4
MDIxMV9zdGFfdmh0X2NhcCAqdmh0X2NhcDsNCisJY29uc3Qgc3RydWN0IGllZWU4MDIxMV9zdGFf
aGVfY2FwICpoZV9jYXA7DQogCXU4IG1vZGUgPSAwOw0KIA0KIAlpZiAoc3RhKSB7DQogCQlodF9j
YXAgPSAmc3RhLT5odF9jYXA7DQogCQl2aHRfY2FwID0gJnN0YS0+dmh0X2NhcDsNCisJCWhlX2Nh
cCA9ICZzdGEtPmhlX2NhcDsNCiAJfSBlbHNlIHsNCiAJCXN0cnVjdCBpZWVlODAyMTFfc3VwcG9y
dGVkX2JhbmQgKnNiYW5kOw0KIA0KQEAgLTE1Miw2ICsxNTQsNyBAQCBtdDc5MTVfZ2V0X3BoeV9t
b2RlKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsDQog
DQogCQlodF9jYXAgPSAmc2JhbmQtPmh0X2NhcDsNCiAJCXZodF9jYXAgPSAmc2JhbmQtPnZodF9j
YXA7DQorCQloZV9jYXAgPSBpZWVlODAyMTFfZ2V0X2hlX2lmdHlwZV9jYXAoc2JhbmQsIHZpZi0+
dHlwZSk7DQogCX0NCiANCiAJaWYgKGJhbmQgPT0gTkw4MDIxMV9CQU5EXzJHSFopIHsNCkBAIC0x
NTksNiArMTYyLDkgQEAgbXQ3OTE1X2dldF9waHlfbW9kZShzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2
LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0KIA0KIAkJaWYgKGh0X2NhcC0+aHRfc3VwcG9y
dGVkKQ0KIAkJCW1vZGUgfD0gUEhZX01PREVfR047DQorDQorCQlpZiAoaGVfY2FwLT5oYXNfaGUp
DQorCQkJbW9kZSB8PSBQSFlfTU9ERV9BWF8yNEc7DQogCX0gZWxzZSBpZiAoYmFuZCA9PSBOTDgw
MjExX0JBTkRfNUdIWikgew0KIAkJbW9kZSB8PSBQSFlfTU9ERV9BOw0KIA0KQEAgLTE2Nyw2ICsx
NzMsOSBAQCBtdDc5MTVfZ2V0X3BoeV9tb2RlKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHN0cnVj
dCBpZWVlODAyMTFfdmlmICp2aWYsDQogDQogCQlpZiAodmh0X2NhcC0+dmh0X3N1cHBvcnRlZCkN
CiAJCQltb2RlIHw9IFBIWV9NT0RFX0FDOw0KKw0KKwkJaWYgKGhlX2NhcC0+aGFzX2hlKQ0KKwkJ
CW1vZGUgfD0gUEhZX01PREVfQVhfNUc7DQogCX0NCiANCiAJcmV0dXJuIG1vZGU7DQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmggYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuaA0KaW5kZXggZDlj
OWFhYjdlNmRjLi5jNzExNjFhZWM3NjcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuaA0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmgNCkBAIC04MTUsNiArODE1LDkgQEAgZW51bSB7DQog
I2RlZmluZSBQSFlfTU9ERV9HTgkJCUJJVCgzKQ0KICNkZWZpbmUgUEhZX01PREVfQU4JCQlCSVQo
NCkNCiAjZGVmaW5lIFBIWV9NT0RFX0FDCQkJQklUKDUpDQorI2RlZmluZSBQSFlfTU9ERV9BWF8y
NEcJCQlCSVQoNikNCisjZGVmaW5lIFBIWV9NT0RFX0FYXzVHCQkJQklUKDcpDQorI2RlZmluZSBQ
SFlfTU9ERV9BWF82RwkJCUJJVCg4KQ0KIA0KICNkZWZpbmUgTU9ERV9DQ0sJCQlCSVQoMCkNCiAj
ZGVmaW5lIE1PREVfT0ZETQkJCUJJVCgxKQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L210NzkxNS5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbXQ3OTE1LmgNCmluZGV4IDZkM2ZkZTdmNjM1YS4uOTJhNmJm
NzQ2ZDczIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc5MTUvbXQ3OTE1LmgNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTE1L210NzkxNS5oDQpAQCAtMTIyLDYgKzEyMiw4IEBAIHN0cnVjdCBtdDc5MTVfcGh5IHsN
CiAJc3RydWN0IG10NzZfcGh5ICptdDc2Ow0KIAlzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2Ow0KIA0K
KwlzdHJ1Y3QgaWVlZTgwMjExX3NiYW5kX2lmdHlwZV9kYXRhIGlmdHlwZVsyXVtOVU1fTkw4MDIx
MV9JRlRZUEVTXTsNCisNCiAJdTMyIHJ4ZmlsdGVyOw0KIAl1MzIgdmlmX21hc2s7DQogCXUzMiBv
bWFjX21hc2s7DQpAQCAtNDQzLDYgKzQ0NSw3IEBAIHZvaWQgbXQ3OTE1X3R4cF9za2JfdW5tYXAo
c3RydWN0IG10NzZfZGV2ICpkZXYsDQogCQkJICBzdHJ1Y3QgbXQ3Nl90eHdpX2NhY2hlICp0eHdp
KTsNCiBpbnQgbXQ3Nl9kZnNfc3RhcnRfcmRkKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIGJvb2wg
Zm9yY2UpOw0KIGludCBtdDc5MTVfZGZzX2luaXRfcmFkYXJfZGV0ZWN0b3Ioc3RydWN0IG10Nzkx
NV9waHkgKnBoeSk7DQordm9pZCBtdDc5MTVfc2V0X3N0cmVhbV9oZV9jYXBzKHN0cnVjdCBtdDc5
MTVfcGh5ICpwaHkpOw0KIHZvaWQgbXQ3OTE1X3VwZGF0ZV9jaGFubmVsKHN0cnVjdCBtdDc2X2Rl
diAqbWRldik7DQogaW50IG10NzkxNV9pbml0X2RlYnVnZnMoc3RydWN0IG10NzkxNV9kZXYgKmRl
dik7DQogDQotLSANCjIuMTguMA0K

