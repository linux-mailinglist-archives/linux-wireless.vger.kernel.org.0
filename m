Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B7F1F3FA8
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 17:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbgFIPmd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 11:42:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36912 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730898AbgFIPmc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 11:42:32 -0400
X-UUID: 4b3fcf2c12a44c779b14f4bbe838d64d-20200609
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=FaqckNT5+HtjSY6/rvoPe2BiCCGh3bWGAkSGRDWsxjU=;
        b=pX3sRh7GIIWlMfVYlBb5wSG725cLFp3+Od576Lo31c4Vn6ag+1Whj35NlgK7QLfp6AWOv3f35jhJF33sQ8IrlvGAlqCJDy5v0+dyDj1PvqKXzDlf/FprBGQ6eSS075YIiIMvtTWzTxrUqVoSxBC7tFNaTp5kT+Z9WkjUKDIm30E=;
X-UUID: 4b3fcf2c12a44c779b14f4bbe838d64d-20200609
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2105775564; Tue, 09 Jun 2020 23:42:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Jun 2020 23:42:19 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 9 Jun 2020 23:42:19 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: mt7615: fix up typo in Kconfig for MT7663U
Date:   Tue, 9 Jun 2020 23:42:21 +0800
Message-ID: <4714529e2d7d557b6ac8dedb66a59101b3ca7a4b.1591716798.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpGaXggdXAgdHlwbyBp
biBLY29uZmlnIHdpdGggaW5kaWNhdGluZyBNVDc2NjNVIGlzIGFuIDgwMi4xMWFjIGRldmljZQ0K
DQpGaXhlczogZWI5OWNjOTVjM2I2ICgibXQ3NjogbXQ3NjE1OiBpbnRyb2R1Y2UgbXQ3NjYzdSBz
dXBwb3J0IikNClNpZ25lZC1vZmYtYnk6IFNlYW4gV2FuZyA8c2Vhbi53YW5nQG1lZGlhdGVrLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L0tjb25m
aWcgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYx
NS9LY29uZmlnIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvS2Nv
bmZpZw0KaW5kZXggZTI1ZGIxMTM1ZWRhLi5jMDk0MjYwYjBmODkgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9LY29uZmlnDQorKysgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9LY29uZmlnDQpAQCAtMzUsNiAr
MzUsNiBAQCBjb25maWcgTVQ3NjYzVQ0KIAlkZXBlbmRzIG9uIE1BQzgwMjExDQogCWRlcGVuZHMg
b24gVVNCDQogCWhlbHANCi0JICBUaGlzIGFkZHMgc3VwcG9ydCBmb3IgTVQ3NjYzVSA4MDIuMTFh
eCAyeDI6MiB3aXJlbGVzcyBkZXZpY2VzLg0KKwkgIFRoaXMgYWRkcyBzdXBwb3J0IGZvciBNVDc2
NjNVIDgwMi4xMWFjIDJ4MjoyIHdpcmVsZXNzIGRldmljZXMuDQogDQogCSAgVG8gY29tcGlsZSB0
aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZS4NCi0tIA0KMi4yNS4xDQo=

