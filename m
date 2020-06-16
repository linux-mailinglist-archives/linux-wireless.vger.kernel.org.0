Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9282F1FB113
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 14:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgFPMqu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 08:46:50 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:27315 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbgFPMqu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 08:46:50 -0400
X-UUID: 08d2f915be1d4ee0a9833f846b7fe853-20200616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0zUnaVwf7NdA/yxdczKheQ3t79GOtZpyyLqwBUW4cDQ=;
        b=BmQx9CxUC+mvkntAi/PYoOWuPOxQuABN/tk84EaTG8t8jGwvGOcNZutj1k7WqQ3cQj5cRRpaG+u+Iss7+DDWSo1Y8L3VomXwxrY0SlHoriTJ6JEdXOv5kYUe4QcIUWnCC35dHV3UCrkhs9P2dtzJe0witpKJCCK9MwQpdLMobno=;
X-UUID: 08d2f915be1d4ee0a9833f846b7fe853-20200616
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1121773539; Tue, 16 Jun 2020 20:46:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Jun 2020 20:46:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Jun 2020 20:46:43 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/4] dt-bindings: net: wireless: mt76: add ru property in power-limits node
Date:   Tue, 16 Jun 2020 20:46:10 +0800
Message-ID: <9ae2b6233284b60206e3513f7bf2eb03d2fbd724.1592276165.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhpcyBuZXcgcHJvcGVydHkgb2YgcG93ZXItbGltaXRzIG5vZGUgY2FuIGJlIHVzZWQgdG8gc2V0
IHBlci1yYXRlDQp0eCBwb3dlciBsaW1pdHMgZm9yIDgwMi4xMWF4IHJhdGVzLg0KDQpDYzogZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNClRlc3RlZC1ieTogRXZlbHluIFRzYWkgPGV2ZWx5bi50
c2FpQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IFNoYXluZSBDaGVuIDxzaGF5bmUuY2hl
bkBtZWRpYXRlay5jb20+DQotLS0NClRoZSBzZXJpZXMgaXMgYmFzZWQgb24gRmVsaXgncyBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxlc3MvbGlzdC8/c2Vy
aWVzPTI5NTgwOQ0KLS0tDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrLG10NzYudHh0IHwgMTAgKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbmV0L3dpcmVsZXNzL21lZGlhdGVrLG10NzYudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcy9tZWRpYXRlayxtdDc2LnR4dA0KaW5kZXggOWQ5YWNl
MGNmYmY5Li5hZWZlODgwZDM2ZmYgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L3dpcmVsZXNzL21lZGlhdGVrLG10NzYudHh0DQorKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3dpcmVsZXNzL21lZGlhdGVrLG10NzYudHh0
DQpAQCAtMTAxLDYgKzEwMSwxMyBAQCBQcm9wZXJ0aWVzOg0KIAl3aGljaCB0aGUgcmF0ZSBzZXQg
YXBwbGllcywgZm9sbG93ZWQgYnkgZWl0aGVyIDggKE1UNzYwMy9NVDc2MjgpIG9yDQogCTEwIChh
bGwgb3RoZXIgY2hpcHMpIHBvd2VyIGxpbWl0IHZhbHVlcy4NCiAJVGhlIG9yZGVyIG9mIHRoZSBj
aGFubmVsIGJhbmR3aWR0aCBzZXR0aW5ncyBpczogMjAsIDQwLCA4MCwgMTYwIE1Iei4NCistIHJ1
Og0KKwlzZXRzIG9mIHBlci1yYXRlIHBvd2VyIGxpbWl0IHZhbHVlcyBmb3IgODAyLjExYXggcmF0
ZXMgZm9yIG11bHRpcGxlDQorCWNoYW5uZWwgYmFuZHdpZHRoIG9yIHJlc291cmNlIHVuaXQgc2V0
dGluZ3MuDQorCUVhY2ggc2V0IHN0YXJ0cyB3aXRoIHRoZSBudW1iZXIgb2YgY2hhbm5lbCBiYW5k
d2lkdGggb3IgcmVzb3VyY2UgdW5pdA0KKwlzZXR0aW5ncyBmb3Igd2hpY2ggdGhlIHJhdGUgc2V0
IGFwcGxpZXMsIGZvbGxvd2VkIGJ5IDEyIHBvd2VyIGxpbWl0DQorCXZhbHVlcy4gVGhlIG9yZGVy
IG9mIHRoZSBjaGFubmVsIHJlc291cmNlIHVuaXQgc2V0dGluZ3MgaXM6DQorCVJVMjYsIFJVNTIs
IFJVMTA2LCBSVTI0Mi9TVTIwLCBSVTQ4NC9TVTQwLCBSVTk5Ni9TVTgwLCBSVTJ4OTk2L1NVMTYw
Lg0KIA0KIA0KIHBvd2VyLWxpbWl0IGV4YW1wbGU6DQpAQCAtMTE0LDExICsxMjEsMTQgQEAgcG93
ZXItbGltaXRzIHsNCiAJCQkJb2ZkbSA9IDwyMyAyMyAyMyAyMyAyMyAyMyAyMyAyMz47DQogCQkJ
CW1jcyA9IDwxIDIzIDIzIDIzIDIzIDIzIDIzIDIzIDIzIDIzIDIzPiwNCiAJCQkJCSAgPDMgMjIg
MjIgMjIgMjIgMjIgMjIgMjIgMjIgMjIgMjI+Ow0KKwkJCQlydSA9IDwzIDIyIDIyIDIyIDIyIDIy
IDIyIDIyIDIyIDIyIDIyIDIyIDIyPiwNCisJCQkJCSAgPDQgMjAgMjAgMjAgMjAgMjAgMjAgMjAg
MjAgMjAgMjAgMjAgMjA+Ow0KIAkJCX07DQogCQkJcjIgew0KIAkJCQljaGFubmVscyA9IDwxMDAg
MTgxPjsNCiAJCQkJb2ZkbSA9IDwxNCAxNCAxNCAxNCAxNCAxNCAxNCAxND47DQogCQkJCW1jcyA9
IDw0IDE0IDE0IDE0IDE0IDE0IDE0IDE0IDE0IDE0IDE0PjsNCisJCQkJcnUgPSA8NyAxNCAxNCAx
NCAxNCAxNCAxNCAxNCAxNCAxNCAxNCAxNCAxND47DQogCQkJfTsNCiAJCX07DQogCX07DQotLSAN
CjIuMTguMA0K

