Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF153BC8FF
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jul 2021 12:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhGFKH2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jul 2021 06:07:28 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:45603 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231214AbhGFKH1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jul 2021 06:07:27 -0400
X-UUID: d6892ee08ca4434b9843f970ec2038b5-20210706
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=7zav9C8Ab8coO8QsXvtBun3/cARc5MdBmvVcP8UQ9rA=;
        b=YmDMyI48yUMN+OmiyHos/IvE5PJSigbLcFsB1dgtQaM2CqiEw+Jx2kZkrX8QhISbHcOg3UJjG7YKIkTbslUO5sDNnnSphUtxBLHnWrvkk7UD1INm5/uqgK0VPqOOjSCiOoe5qzFfIYYcEKzt87CsbmZ4RpBgW23ImJ4JqezUj/Q=;
X-UUID: d6892ee08ca4434b9843f970ec2038b5-20210706
Received: from mtkmrs31.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2083210616; Tue, 06 Jul 2021 18:04:46 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 6 Jul
 2021 18:04:38 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 6 Jul 2021 18:04:37 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH] mt76: mt7915: adapt new firmware to update BA winsize for Rx session
Date:   Tue, 6 Jul 2021 18:04:26 +0800
Message-ID: <20210706100426.1763-1-bo.jiao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5E9EBCD832329CCA81BA9DBD9ECFA2340AFE343B008E73A170618CD70E11EC2B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogQm8gSmlhbyA8Qm8uSmlhb0BtZWRpYXRlay5jb20+DQoNClRoZSBuZXdlciBmaXJtd2Fy
ZSByZXF1aXJlcyBob3N0IGRyaXZlciB0byBzZXQgQkEgd2luc2l6ZQ0Kb24gYm90aCBUeC9SeCBz
ZXNzaW9ucywgc28gbW9kaWZ5IGl0IGZvciB0aGUgbG9uZyBydW4uDQoNClNpZ25lZC1vZmYtYnk6
IEJvIEppYW8gPEJvLkppYW9AbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTogU3VqdWFuIENo
ZW4gPHN1anVhbi5jaGVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jIHwgMiArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5oIHwgMSArDQogMiBmaWxlcyBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMNCmluZGV4IDg2M2FhMThiMzAyNC4uYjM0NTcxNTM4
ZmY5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
MTUvbWN1LmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1
L21jdS5jDQpAQCAtMTMxNyw3ICsxMzE3LDcgQEAgbXQ3OTE1X21jdV93dGJsX2JhX3RsdihzdHJ1
Y3Qgc2tfYnVmZiAqc2tiLA0KIAkJYmEtPnJzdF9iYV9zYiA9IDE7DQogCX0NCiANCi0JaWYgKGVu
YWJsZSAmJiB0eCkNCisJaWYgKGVuYWJsZSkNCiAJCWJhLT5iYV93aW5zaXplID0gY3B1X3RvX2xl
MTYocGFyYW1zLT5idWZfc2l6ZSk7DQogfQ0KIA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmgNCmluZGV4IGVkZDNiYTNhMGMyZC4uYzkwM2NjYjAx
NzQwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
MTUvbWN1LmgNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1
L21jdS5oDQpAQCAtNzE2LDYgKzcxNiw3IEBAIHN0cnVjdCB3dGJsX2JhIHsNCiAJX19sZTE2IHNu
Ow0KIAl1OCBiYV9lbjsNCiAJdTggYmFfd2luc2l6ZV9pZHg7DQorCS8qIG9yaWdpbmF0b3IgJiBy
ZWNpcGllbnQgKi8NCiAJX19sZTE2IGJhX3dpbnNpemU7DQogCS8qIHJlY2lwaWVudCBvbmx5ICov
DQogCXU4IHBlZXJfYWRkcltFVEhfQUxFTl07DQotLSANCjIuMTguMA0K

