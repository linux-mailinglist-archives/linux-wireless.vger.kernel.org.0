Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE00832D443
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 14:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241312AbhCDNgT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Mar 2021 08:36:19 -0500
Received: from mailgw01.mediatek.com ([216.200.240.184]:28691 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCDNfs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Mar 2021 08:35:48 -0500
X-UUID: f476fc61a07a49418eb3c6a0a8f5b612-20210304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fRxxVM9hTCT8akBnptA/Vvb5Yp+hcTyvfgtIvrleoRA=;
        b=rp80SOUKBaNzJOFq0LaIQYTedTYLoyktRc6VnOCZeC14QyyQuJLr1XEtjVscKL4MAyxN8oNpwoChOalyEmxg6zzGvylMrYRT7tFcVTY2f9SqgYld6UDpr9D8Z5E6t70iN6rIH6GEXzbXpa9/verJJ7lWEIq0V5Caz56prNdhtP0=;
X-UUID: f476fc61a07a49418eb3c6a0a8f5b612-20210304
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1826850356; Thu, 04 Mar 2021 05:35:06 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 4 Mar 2021 05:25:28 -0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Mar 2021 21:25:28 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 3/3] mt76: mt7663s: fix the possible device hang in high traffic
Date:   Thu, 4 Mar 2021 21:25:23 +0800
Message-ID: <99976d786b85749243af3a3a32886d5fe94d11ac.1614863741.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <801a2aa986f5486a0e789065feef7b77c612ea7b.1614863741.git.objelf@gmail.com>
References: <801a2aa986f5486a0e789065feef7b77c612ea7b.1614863741.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpVc2UgdGhlIGFkZGl0
aW9uYWwgbWVtb3J5IGJhcnJpZXIgdG8gZW5zdXJlIHRoZSBza2IgbGlzdCB1cC10by1kYXRlDQpi
ZXR3ZWVuIHRoZSBza2IgcHJvZHVjZXIgYW5kIGNvbnN1bWVyIHRvIGF2b2lkIHRoZSBpbnZhbGlk
IHNrYiBjb250ZW50DQp3cml0dGVuIGludG8gc2RpbyBjb250cm9sbGVyIGFuZCB0aGVuIGNhdXNl
IGRldmljZSBoYW5nIGR1ZSB0byBtY3UgYXNzZXJ0DQpjYXVnaHQgYnkgV1JfVElNRU9VVF9JTlQu
DQoNCkZpeGVzOiAxNTIyZmY3MzFmODQgKCJtdDc2OiBtdDc2NjNzOiBpbnRyb2R1Y2Ugc2RpbyB0
eCBhZ2dyZWdhdGlvbiIpDQpTaWduZWQtb2ZmLWJ5OiBTZWFuIFdhbmcgPHNlYW4ud2FuZ0BtZWRp
YXRlay5jb20+DQotLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYx
NS9zZGlvX3R4cnguYyB8IDIgKysNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L3NkaW8uYyAgICAgICAgICAgICB8IDMgKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3NjE1L3NkaW9fdHhyeC5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc2MTUvc2Rpb190eHJ4LmMNCmluZGV4IDJkM2I3ZDFlMmM5Mi4uMjllNTEwZDI2M2ZjIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvc2Rpb190
eHJ4LmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3Nk
aW9fdHhyeC5jDQpAQCAtMjI1LDYgKzIyNSw4IEBAIHN0YXRpYyBpbnQgbXQ3NjYzc190eF9ydW5f
cXVldWUoc3RydWN0IG10NzZfZGV2ICpkZXYsIHN0cnVjdCBtdDc2X3F1ZXVlICpxKQ0KIAkJc3Ry
dWN0IG10NzZfcXVldWVfZW50cnkgKmUgPSAmcS0+ZW50cnlbcS0+Zmlyc3RdOw0KIAkJc3RydWN0
IHNrX2J1ZmYgKml0ZXI7DQogDQorCQlzbXBfcm1iKCk7DQorDQogCQlpZiAoIXRlc3RfYml0KE1U
NzZfU1RBVEVfTUNVX1JVTk5JTkcsICZkZXYtPnBoeS5zdGF0ZSkpIHsNCiAJCQlfX3NrYl9wdXRf
emVybyhlLT5za2IsIDQpOw0KIAkJCWVyciA9IF9fbXQ3NjYzc194bWl0X3F1ZXVlKGRldiwgZS0+
c2tiLT5kYXRhLA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvc2Rpby5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9zZGlvLmMNCmlu
ZGV4IDBiNmZhY2IxN2ZmNy4uYTE4ZDI4OTZlZTFmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9zZGlvLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvc2Rpby5jDQpAQCAtMjU2LDYgKzI1Niw5IEBAIG10NzZzX3R4X3F1ZXVl
X3NrYihzdHJ1Y3QgbXQ3Nl9kZXYgKmRldiwgc3RydWN0IG10NzZfcXVldWUgKnEsDQogDQogCXEt
PmVudHJ5W3EtPmhlYWRdLnNrYiA9IHR4X2luZm8uc2tiOw0KIAlxLT5lbnRyeVtxLT5oZWFkXS5i
dWZfc3ogPSBsZW47DQorDQorCXNtcF93bWIoKTsNCisNCiAJcS0+aGVhZCA9IChxLT5oZWFkICsg
MSkgJSBxLT5uZGVzYzsNCiAJcS0+cXVldWVkKys7DQogDQotLSANCjIuMjUuMQ0K

