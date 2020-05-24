Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB38E1DFE45
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2020 12:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgEXKOw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 May 2020 06:14:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:21246 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728766AbgEXKOw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 May 2020 06:14:52 -0400
X-UUID: df3be4ded574407fb8d8661c7a9d15fa-20200524
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hOzMYCZ3qsvYgw8bs4JJEy5VmWKuRRy/5B9rA8cNlEE=;
        b=S1HfFC78PLVuX2afd0UtVEi3+KZBJwc7t3mHpuswpYkzDBqlHFKK8LFReCGTV6VI6MtZQgeQiLOIoud5lVuPzypa4uBpz1HBqB99DKV7TlmRtwME5eiVnJMhhJH14A6uMtkmRiQH+JpuCKG/FICqg5Vxaickk5lyTEtGyfOZUNU=;
X-UUID: df3be4ded574407fb8d8661c7a9d15fa-20200524
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 950141301; Sun, 24 May 2020 18:14:46 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 24 May 2020 18:14:41 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 24 May 2020 18:14:40 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: fix BUG: spinlock bad magic in mt76_dma_init
Date:   Sun, 24 May 2020 18:14:41 +0800
Message-ID: <54dc821bf69fe8e7ae017f221069a4f41ae37893.1590260648.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4D90F55D31A314470E2E0E7DED0FDB3AADD4CE3F33CA5DB2C81192D7CF81C5A82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpkbWEgaW5pdCBzaG91
bGQgYmUgZG9uZSB3aGVuIGRtYSBoYXZlIGJlZW4gYWxsb2NhdGVkDQoNClsgICAgMi4zNjExMjdd
IEJVRzogc3BpbmxvY2sgYmFkIG1hZ2ljIG9uIENQVSMwLCBtb2Rwcm9iZS80NTYNClsgICAgMi4z
NjE1ODNdICBsb2NrOiAweGZmZmZhMTI4NzUyNWIzYjgsIC5tYWdpYzogMDAwMDAwMDAsIC5vd25l
cjogPG5vbmU+Ly0xLCAub3duZXJfY3B1OiAwDQpbICAgIDIuMzYyMjUwXSBDUFU6IDAgUElEOiA0
NTYgQ29tbTogbW9kcHJvYmUgTm90IHRhaW50ZWQgNC4xNC4xNzcgIzUNClsgICAgMi4zNjI3NTFd
IEhhcmR3YXJlIG5hbWU6IEhQIE1lZXAvTWVlcCwgQklPUyBHb29nbGVfTWVlcC4xMTI5Ny43NS4w
IDA2LzE3LzIwMTkNClsgICAgMi4zNjMzNDNdIENhbGwgVHJhY2U6DQpbICAgIDIuMzYzNTUyXSAg
ZHVtcF9zdGFjaysweDk3LzB4ZGINClsgICAgMi4zNjM4MjZdICA/IHNwaW5fYnVnKzB4YTYvMHhi
Mw0KWyAgICAyLjM2NDA5Nl0gIGRvX3Jhd19zcGluX2xvY2srMHg2YS8weDlhDQpbICAgIDIuMzY0
NDE3XSAgbXQ3Nl9kbWFfcnhfZmlsbCsweDQ0LzB4MWRlIFttdDc2XQ0KWyAgICAyLjM2NDc4N10g
ID8gbXQ3Nl9kbWFfa2lja19xdWV1ZSsweDE4LzB4MTggW210NzZdDQpbICAgIDIuMzY1MTg0XSAg
bXQ3Nl9kbWFfaW5pdCsweDUzLzB4ODUgW210NzZdDQpbICAgIDIuMzY1NTMyXSAgbXQ3NjE1X2Rt
YV9pbml0KzB4M2Q3LzB4NTQ2IFttdDc2MTVlXQ0KWyAgICAyLjM2NTkyOF0gIG10NzYxNV9yZWdp
c3Rlcl9kZXZpY2UrMHhlNi8weDFhMCBbbXQ3NjE1ZV0NClsgICAgMi4zNjYzNjRdICBtdDc2MTVf
bW1pb19wcm9iZSsweDE0Yi8weDE3MSBbbXQ3NjE1ZV0NClsgICAgMi4zNjY3NzFdICBtdDc2MTVf
cGNpX3Byb2JlKzB4MTE4LzB4MTNiIFttdDc2MTVlXQ0KWyAgICAyLjM2NzE2OV0gIHBjaV9kZXZp
Y2VfcHJvYmUrMHhhZi8weDEzZA0KWyAgICAyLjM2NzQ5MV0gIGRyaXZlcl9wcm9iZV9kZXZpY2Ur
MHgyODQvMHgyY2ENClsgICAgMi4zNjc4NDBdICBfX2RyaXZlcl9hdHRhY2grMHg3YS8weDllDQpb
ICAgIDIuMzY4MTQ2XSAgPyBkcml2ZXJfYXR0YWNoKzB4MWYvMHgxZg0KWyAgICAyLjM2ODQ1MV0g
IGJ1c19mb3JfZWFjaF9kZXYrMHhhMC8weGRiDQpbICAgIDIuMzY4NzY1XSAgYnVzX2FkZF9kcml2
ZXIrMHgxMzIvMHgyMDQNClsgICAgMi4zNjkwNzhdICBkcml2ZXJfcmVnaXN0ZXIrMHg4ZS8weGNk
DQpbICAgIDIuMzY5Mzg0XSAgZG9fb25lX2luaXRjYWxsKzB4MTYwLzB4MjU3DQpbICAgIDIuMzY5
NzA2XSAgPyAweGZmZmZmZmZmYzAyNDAwMDANClsgICAgMi4zNjk5ODBdICBkb19pbml0X21vZHVs
ZSsweDYwLzB4MWJiDQpbICAgIDIuMzcwMjg2XSAgbG9hZF9tb2R1bGUrMHgxOGMyLzB4MWEyYg0K
WyAgICAyLjM3MDU5Nl0gID8ga2VybmVsX3JlYWRfZmlsZSsweDE0MS8weDFiOQ0KWyAgICAyLjM3
MDkzN10gID8ga2VybmVsX3JlYWRfZmlsZV9mcm9tX2ZkKzB4NDYvMHg3MQ0KWyAgICAyLjM3MTMy
MF0gIFN5U19maW5pdF9tb2R1bGUrMHhjYy8weGYwDQpbICAgIDIuMzcxNjM2XSAgZG9fc3lzY2Fs
bF82NCsweDZiLzB4ZjcNClsgICAgMi4zNzE5MzBdICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3
ZnJhbWUrMHgzZC8weGEyDQpbICAgIDIuMzcyMzQ0XSBSSVA6IDAwMzM6MHg3ZGEyMThhZTQxOTkN
ClsgICAgMi4zNzI2MzddIFJTUDogMDAyYjowMDAwN2ZmZmQwNjA4Mzk4IEVGTEFHUzogMDAwMDAy
NDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAxMzkNClsgICAgMi4zNzMyNTJdIFJBWDogZmZmZmZm
ZmZmZmZmZmZkYSBSQlg6IDAwMDA1YTcwNTQ0OWRmOTAgUkNYOiAwMDAwN2RhMjE4YWU0MTk5DQpb
ICAgIDIuMzczODMzXSBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiAwMDAwNWE3MDUyZTczYmQ4
IFJESTogMDAwMDAwMDAwMDAwMDAwNg0KWyAgICAyLjM3NDQxMV0gUkJQOiAwMDAwN2ZmZmQwNjA4
M2UwIFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IDAwMDA1YTcwNTQ0OWQ1NDANClsgICAgMi4z
NzQ5ODldIFIxMDogMDAwMDAwMDAwMDAwMDAwNiBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAw
MDAwMDAwMDAwMDAwMDAwDQpbICAgIDIuMzc1NTY5XSBSMTM6IDAwMDA1YTcwNTQ0OWRlZjAgUjE0
OiAwMDAwNWE3MDUyZTczYmQ4IFIxNTogMDAwMDAwMDAwMDAwMDAwMA0KDQpGaXhlczogZDMzNzdi
NzhjZWM2ICgibXQ3NjogYWRkIEhFIHBoeSBtb2RlcyBhbmQgaGFyZHdhcmUgcXVldWUiKQ0KU2ln
bmVkLW9mZi1ieTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9kbWEuYyB8IDIgKy0NCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvZG1hLmMgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L2RtYS5jDQppbmRleCA3NWU2NTk3NzRlMDcuLmVjYTM5Nzk5ZjA1MCAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvZG1hLmMNCisr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvZG1hLmMNCkBAIC01NzYsNyAr
NTc2LDcgQEAgbXQ3Nl9kbWFfaW5pdChzdHJ1Y3QgbXQ3Nl9kZXYgKmRldikNCiANCiAJaW5pdF9k
dW1teV9uZXRkZXYoJmRldi0+bmFwaV9kZXYpOw0KIA0KLQlmb3IgKGkgPSAwOyBpIDwgQVJSQVlf
U0laRShkZXYtPnFfcngpOyBpKyspIHsNCisJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoZGV2
LT5xX3J4KSAmJiBkZXYtPnFfcnhbaV0uZGVzYzsgaSsrKSB7DQogCQluZXRpZl9uYXBpX2FkZCgm
ZGV2LT5uYXBpX2RldiwgJmRldi0+bmFwaVtpXSwgbXQ3Nl9kbWFfcnhfcG9sbCwNCiAJCQkgICAg
ICAgNjQpOw0KIAkJbXQ3Nl9kbWFfcnhfZmlsbChkZXYsICZkZXYtPnFfcnhbaV0pOw0KLS0gDQoy
LjI1LjENCg==

