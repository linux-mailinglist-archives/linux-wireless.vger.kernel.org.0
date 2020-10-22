Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD9729565E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Oct 2020 04:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895054AbgJVC2t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Oct 2020 22:28:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53853 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2894984AbgJVC2s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Oct 2020 22:28:48 -0400
X-UUID: d0728f0ea7a346bfa45fff1bec56a050-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=guyuTsoRUuSIeXgClFrwBChoxIhGLul/egI0BsmawRk=;
        b=lYeQdYdRMmKfL8n6W/nnp9rxwAqlfO5NlMlU+4aLS0FJEdeZqb6oUKnVknfNZasxOLTy2+6Ys3NXChHsqN9Z0EZngjRYInXr3mJtYL33NbiAOZVT6Olcc3ZKfU6Z3VSExj7flafVJ73CrlB7X+UikRJUgqxrMjDzylu/tW875bM=;
X-UUID: d0728f0ea7a346bfa45fff1bec56a050-20201022
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1393816057; Thu, 22 Oct 2020 10:28:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 10:28:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 10:28:38 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v4 02/10] mt76: testmode: add snr attribute in rx statistics
Date:   Thu, 22 Oct 2020 10:28:12 +0800
Message-ID: <20201022022820.3077-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201022022820.3077-1-shayne.chen@mediatek.com>
References: <20201022022820.3077-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A48846BED3A15C7579A47C7470F215387AD934F3FF0CC8ABEDFA51E09C5F6C442000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

U3VwcG9ydCB0byBkaXNwbGF5IHNuciB2YWx1ZSB3aGVuIGR1bXBpbmcgcnggc3RhdGlzdGljcy4N
Cg0KUmV2aWV3ZWQtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NClNpZ25l
ZC1vZmYtYnk6IFNoYXluZSBDaGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRlay5jb20+DQotLS0NCnYy
OiBjaGFuZ2Ugc25yIGF0dHJpYnV0ZSBkZXNjcmlwdGlvbiB0byB1OA0KDQogZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni90ZXN0bW9kZS5oIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvdGVzdG1vZGUuaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvdGVzdG1vZGUuaA0KaW5kZXggMDJjOTQ5NS4uNGQyMjYyNyAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvdGVzdG1vZGUuaA0KKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni90ZXN0bW9kZS5oDQpAQCAtMTAxLDYgKzEwMSw3IEBA
IGVudW0gbXQ3Nl90ZXN0bW9kZV9zdGF0c19hdHRyIHsNCiAgKiBATVQ3Nl9UTV9SWF9BVFRSX1JD
UEk6IHJlY2VpdmVkIGNoYW5uZWwgcG93ZXIgaW5kaWNhdG9yIChhcnJheSwgdTgpDQogICogQE1U
NzZfVE1fUlhfQVRUUl9JQl9SU1NJOiBpbnRlcm5hbCBpbmJhbmQgUlNTSSAoYXJyYXksIHM4KQ0K
ICAqIEBNVDc2X1RNX1JYX0FUVFJfV0JfUlNTSTogaW50ZXJuYWwgd2lkZWJhbmQgUlNTSSAoYXJy
YXksIHM4KQ0KKyAqIEBNVDc2X1RNX1JYX0FUVFJfU05SOiBzaWduYWwtdG8tbm9pc2UgcmF0aW8g
KHU4KQ0KICAqLw0KIGVudW0gbXQ3Nl90ZXN0bW9kZV9yeF9hdHRyIHsNCiAJTVQ3Nl9UTV9SWF9B
VFRSX1VOU1BFQywNCkBAIC0xMDksNiArMTEwLDcgQEAgZW51bSBtdDc2X3Rlc3Rtb2RlX3J4X2F0
dHIgew0KIAlNVDc2X1RNX1JYX0FUVFJfUkNQSSwNCiAJTVQ3Nl9UTV9SWF9BVFRSX0lCX1JTU0ks
DQogCU1UNzZfVE1fUlhfQVRUUl9XQl9SU1NJLA0KKwlNVDc2X1RNX1JYX0FUVFJfU05SLA0KIA0K
IAkvKiBrZWVwIGxhc3QgKi8NCiAJTlVNX01UNzZfVE1fUlhfQVRUUlMsDQotLSANCjIuMTcuMQ0K

