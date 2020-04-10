Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F481A4C3F
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2020 00:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgDJWvz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Apr 2020 18:51:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7473 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726702AbgDJWvz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Apr 2020 18:51:55 -0400
X-UUID: 78911d13abd8425c87b7b8e9613799cb-20200411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vqu/zutvPUGFQUduE/Rc88ZnxYelSwiRPzDq7UrqkPY=;
        b=Z07PzAq6TQeWwsPQEjmLuZ70TlZzlOcUcXCkGzHM68r71Qp3hGWSpsfVrUSc08Tq7hRmQB+dqEeLYJjab30PUMoJyVOaWllfKDRuBnMF+148UQ/AJXkFS0O4aJjuNX2mg4dRavacFQeieGH6pwe/D9z/8c4hYoR3UETOhKZ3E8E=;
X-UUID: 78911d13abd8425c87b7b8e9613799cb-20200411
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1098312335; Sat, 11 Apr 2020 06:51:49 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Apr 2020 06:51:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Apr 2020 06:51:42 +0800
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
Subject: [PATCH v1 05/16] mt76: add HE phy modes and hardware queue
Date:   Sat, 11 Apr 2020 06:51:20 +0800
Message-ID: <27f2054108ef7ae4520ff266ead1927125545566.1586558901.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1586558901.git.ryder.lee@mediatek.com>
References: <cover.1586558901.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2921474DE6C42D4AA44CBA91E2BE402C4CE69B73769D5C563934F196D5E5595F2000:8
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
YXRlay9tdDc2L210NzYuaA0KaW5kZXggYzVlNDRjODk2MDk3Li5iMjk4NGUxY2FhMzYgMTAwNjQ0
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

