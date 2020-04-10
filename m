Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A73CB1A43FD
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2020 10:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgDJIzG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Apr 2020 04:55:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49894 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725990AbgDJIzG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Apr 2020 04:55:06 -0400
X-UUID: 84dc2d542a5d4b46886060ff14b2f3d2-20200410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Ule6ZRnhMKPLo6FIhuNTylSpJjFPBks7O1Nokyid12g=;
        b=e67RKGNGSvaHaZ+lZEYn72oZ9BIhVGaGvifD5/e+1ih2CYgn1owKpE7PaSsbxmU1mkJACMyGFWQQtRE4NKH1cSf1KXNrD0iTMS3ASz6yxpBjcu5G7Fh/KvH/ACj4AgDA5XiNNXaMY/1vVe5ANO/vLqle/X0xwluQCsAD0gC1e2Y=;
X-UUID: 84dc2d542a5d4b46886060ff14b2f3d2-20200410
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1633387090; Fri, 10 Apr 2020 16:55:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 10 Apr 2020 16:54:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 10 Apr 2020 16:54:55 +0800
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
Subject: [PATCH 05/16] mt76: add HE phy modes and hardware queue
Date:   Fri, 10 Apr 2020 16:54:42 +0800
Message-ID: <06ea71e149abb759dba19370591d313a8fd0021d.1586507878.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1586507878.git.ryder.lee@mediatek.com>
References: <cover.1586507878.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 85DADBE71E5E5566FB558A100B56833FFB7180E6982677C15F0FFA369E4ECF7D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhpcyBpcyBhIHByZWxpbWluYXJ5IHBhdGNoIHRvIHN1cHBvcnQgMTFheCBkZWl2Y2VzLg0KDQpT
aWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQotLS0NCiBk
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYuaCB8IDYgKysrKysrDQogMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzYuaA0KaW5kZXggOTc4ODJiOTMwNmEyLi42OGJhY2NhNGZhZTUgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYuaA0KKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmgNCkBAIC02MCw2ICs2MCw3
IEBAIGVudW0gbXQ3Nl90eHFfaWQgew0KIAlNVF9UWFFfQksgPSBJRUVFODAyMTFfQUNfQkssDQog
CU1UX1RYUV9QU0QsDQogCU1UX1RYUV9NQ1UsDQorCU1UX1RYUV9NQ1VfV0EsDQogCU1UX1RYUV9C
RUFDT04sDQogCU1UX1RYUV9DQUIsDQogCU1UX1RYUV9GV0RMLA0KQEAgLTY5LDYgKzcwLDcgQEAg
ZW51bSBtdDc2X3R4cV9pZCB7DQogZW51bSBtdDc2X3J4cV9pZCB7DQogCU1UX1JYUV9NQUlOLA0K
IAlNVF9SWFFfTUNVLA0KKwlNVF9SWFFfTUNVX1dBLA0KIAlfX01UX1JYUV9NQVgNCiB9Ow0KIA0K
QEAgLTU3Nyw2ICs1NzksMTAgQEAgZW51bSBtdDc2X3BoeV90eXBlIHsNCiAJTVRfUEhZX1RZUEVf
SFQsDQogCU1UX1BIWV9UWVBFX0hUX0dGLA0KIAlNVF9QSFlfVFlQRV9WSFQsDQorCU1UX1BIWV9U
WVBFX0hFX1NVID0gOCwNCisJTVRfUEhZX1RZUEVfSEVfRVhUX1NVLA0KKwlNVF9QSFlfVFlQRV9I
RV9UQiwNCisJTVRfUEhZX1RZUEVfSEVfTVUsDQogfTsNCiANCiAjZGVmaW5lIF9fbXQ3Nl9ycihk
ZXYsIC4uLikJKGRldiktPmJ1cy0+cnIoKGRldiksIF9fVkFfQVJHU19fKQ0KLS0gDQoyLjE4LjAN
Cg==

