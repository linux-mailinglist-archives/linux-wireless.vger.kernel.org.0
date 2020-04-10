Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E07821A43FF
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2020 10:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDJIzI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Apr 2020 04:55:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:15206 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbgDJIzI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Apr 2020 04:55:08 -0400
X-UUID: 400511ce78b149c4bf148dca87656fd0-20200410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Q7vYceF8wcaJFxEzBhMAy15i6reVJ7NOYyhn/fL7Dc0=;
        b=pK8H0aPdHmoJpXUsdx+JcDZxCYwvXUpxVlhv/dCLUohRc4OJk2GEFCl4tnMLMj5dtN/ONJ2wNhr5+SNxspPqNtgNgzsdLngGqHLT4PD9jYumCx3DCKy46OWBParTsS0un613/xaKfuIxNTsWVVDPLmkPWR7jhGY2ewE78HXG4U4=;
X-UUID: 400511ce78b149c4bf148dca87656fd0-20200410
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 407822972; Fri, 10 Apr 2020 16:55:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH 04/16] mt76: adjust wcid size to support new 802.11ax generation
Date:   Fri, 10 Apr 2020 16:54:41 +0800
Message-ID: <85bc522a5cd6239c03d249dfba88d4523e95178f.1586507878.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1586507878.git.ryder.lee@mediatek.com>
References: <cover.1586507878.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 223F172043F60E650D16C8AA02142F0696146296BD88C483A8714D477CF3D0722000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhlIG5ld2VyIDgwMi4xMWF4IGRldmljZXMgKGkuZS4gTVQ3OTE1RSkgY2FuIGNvbm5lY3QgdG8g
bXVjaCBtb3JlDQpwZWVycyB0aGFuIHByZXZpb3VzIGdlbmVyYXRpb25zLg0KDQpTaWduZWQtb2Zm
LWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYuaCB8IDggKysrKy0tLS0NCiAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmggYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzYuaA0KaW5kZXggOGQyN2FmNjFiNjJlLi45Nzg4MmI5MzA2
YTIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYu
aA0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmgNCkBAIC0x
ODEsNyArMTgxLDcgQEAgZW51bSBtdDc2X3djaWRfZmxhZ3Mgew0KIAlNVF9XQ0lEX0ZMQUdfUFMs
DQogfTsNCiANCi0jZGVmaW5lIE1UNzZfTl9XQ0lEUyAxMjgNCisjZGVmaW5lIE1UNzZfTl9XQ0lE
UyAyODgNCiANCiAvKiBzdG9yZWQgaW4gaWVlZTgwMjExX3R4X2luZm86Omh3X3F1ZXVlICovDQog
I2RlZmluZSBNVF9UWF9IV19RVUVVRV9FWFRfUEhZCQlCSVQoMykNCkBAIC0yMDEsNyArMjAxLDcg
QEAgc3RydWN0IG10NzZfd2NpZCB7DQogCXN0cnVjdCBld21hX3NpZ25hbCByc3NpOw0KIAlpbnQg
aW5hY3RpdmVfY291bnQ7DQogDQotCXU4IGlkeDsNCisJdTE2IGlkeDsNCiAJdTggaHdfa2V5X2lk
eDsNCiANCiAJdTggc3RhOjE7DQpAQCAtMjY4LDcgKzI2OCw3IEBAIHN0cnVjdCBtdDc2X3J4X3Rp
ZCB7DQogDQogc3RydWN0IG10NzZfdHhfY2Igew0KIAl1bnNpZ25lZCBsb25nIGppZmZpZXM7DQot
CXU4IHdjaWQ7DQorCXUxNiB3Y2lkOw0KIAl1OCBwa3RpZDsNCiAJdTggZmxhZ3M7DQogfTsNCkBA
IC00NDEsNyArNDQxLDcgQEAgc3RydWN0IG10NzZfbW1pbyB7DQogc3RydWN0IG10NzZfcnhfc3Rh
dHVzIHsNCiAJdW5pb24gew0KIAkJc3RydWN0IG10NzZfd2NpZCAqd2NpZDsNCi0JCXU4IHdjaWRf
aWR4Ow0KKwkJdTE2IHdjaWRfaWR4Ow0KIAl9Ow0KIA0KIAl1bnNpZ25lZCBsb25nIHJlb3JkZXJf
dGltZTsNCi0tIA0KMi4xOC4wDQo=

