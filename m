Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186441B7EF7
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 21:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgDXTc4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 15:32:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:14309 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729198AbgDXTc4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 15:32:56 -0400
X-UUID: 8714d43202bb47fb8da89c20813846ec-20200425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=333UAHMqqUfl/oqO1oNmHQeRS6Hf48FRzVK5RbsxFDg=;
        b=Qux4ZwIWzVIOXuXfMv6mc48ZySHfUq/Fp1c+/T78JDe5BB2ZUaxBdQ17UPIIhpWaRi0HmxKB1XUwwtKDnGQP2MEqR1aZ4haNyDZ3RD0MyDpPbpiAbZLkeuvOOVgbxM1a+gz7gSsnA6tQNnJpBgnmlguu1W3GnHUCfg1OOqKDdtI=;
X-UUID: 8714d43202bb47fb8da89c20813846ec-20200425
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1345057240; Sat, 25 Apr 2020 03:32:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 25 Apr 2020 03:32:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 25 Apr 2020 03:32:50 +0800
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
Subject: [PATCH v3 05/18] mt76: add HE phy modes and hardware queue
Date:   Sat, 25 Apr 2020 03:32:26 +0800
Message-ID: <a46fac373d73eceeb8c60010eac596762208f045.1587756404.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1587756404.git.ryder.lee@mediatek.com>
References: <cover.1587756404.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
YXRlay9tdDc2L210NzYuaA0KaW5kZXggMmQwZmI1N2YwNTBiLi4yNTRmYmY1ZDA5NGEgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYuaA0KKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmgNCkBAIC02MCw2ICs2MCw3
IEBAIGVudW0gbXQ3Nl90eHFfaWQgew0KIAlNVF9UWFFfQksgPSBJRUVFODAyMTFfQUNfQkssDQog
CU1UX1RYUV9QU0QsDQogCU1UX1RYUV9NQ1UsDQorCU1UX1RYUV9NQ1VfV0EsDQogCU1UX1RYUV9C
RUFDT04sDQogCU1UX1RYUV9DQUIsDQogCU1UX1RYUV9GV0RMLA0KQEAgLTY5LDYgKzcwLDcgQEAg
ZW51bSBtdDc2X3R4cV9pZCB7DQogZW51bSBtdDc2X3J4cV9pZCB7DQogCU1UX1JYUV9NQUlOLA0K
IAlNVF9SWFFfTUNVLA0KKwlNVF9SWFFfTUNVX1dBLA0KIAlfX01UX1JYUV9NQVgNCiB9Ow0KIA0K
QEAgLTU3OSw2ICs1ODEsMTAgQEAgZW51bSBtdDc2X3BoeV90eXBlIHsNCiAJTVRfUEhZX1RZUEVf
SFQsDQogCU1UX1BIWV9UWVBFX0hUX0dGLA0KIAlNVF9QSFlfVFlQRV9WSFQsDQorCU1UX1BIWV9U
WVBFX0hFX1NVID0gOCwNCisJTVRfUEhZX1RZUEVfSEVfRVhUX1NVLA0KKwlNVF9QSFlfVFlQRV9I
RV9UQiwNCisJTVRfUEhZX1RZUEVfSEVfTVUsDQogfTsNCiANCiAjZGVmaW5lIF9fbXQ3Nl9ycihk
ZXYsIC4uLikJKGRldiktPmJ1cy0+cnIoKGRldiksIF9fVkFfQVJHU19fKQ0KLS0gDQoyLjE4LjAN
Cg==

