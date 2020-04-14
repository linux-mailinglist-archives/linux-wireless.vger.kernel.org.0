Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5301A8D3D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 23:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633675AbgDNVFo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 17:05:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:16032 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2633566AbgDNVBu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 17:01:50 -0400
X-UUID: b6529dc0a0a343e49b867800a33809eb-20200415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2NtU9XJjT9BbahmByeTeE1WHgNy7AgGxqZOEqVbEgGQ=;
        b=j68lDKmfVcbVoV+2ybXeaKGGJ2nQVRiwJtpoqB9glZCdpafxkeRACKkELuVWLcOCAd/V96AYOy1w2OMpjFkRmTdMp4MITrenx9WVXrbJCUwayEWM92A6TvzuiqbKvODOraNzVcJUsHcMse/H0Ua0iwX8OY8WPdYtP+JNYQMuO4U=;
X-UUID: b6529dc0a0a343e49b867800a33809eb-20200415
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1868881394; Wed, 15 Apr 2020 05:01:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Apr 2020 05:01:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Apr 2020 05:01:20 +0800
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
Subject: [PATCH v2 05/18] mt76: add HE phy modes and hardware queue
Date:   Wed, 15 Apr 2020 05:01:03 +0800
Message-ID: <cf2fbf85884dbe026cf2a49799dd50240ab9ad64.1586895593.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1586895593.git.ryder.lee@mediatek.com>
References: <cover.1586895593.git.ryder.lee@mediatek.com>
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
YXRlay9tdDc2L210NzYuaA0KaW5kZXggYjI2YTkwZmE1ZDkyLi5kMWFkMWYwMzU0MjYgMTAwNjQ0
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

