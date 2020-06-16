Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0E91FBF8F
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 22:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgFPUB2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 16:01:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:27173 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731054AbgFPUB1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 16:01:27 -0400
X-UUID: bc6c4d0c87504244a47a0ed20b80494c-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MPlbLoYu4SxADLEwOMGhe4GB3UlXiF6xAyq5JyY/ozM=;
        b=GmsD9FU5gHLOUA6G0lHFkD9wCztwFVYZKbhmyvviFzug5/nW4Xy/T2XMIkfZKx4S3m3ufqF3gnxIJN0lHKv+WQxuQjudWGTBetPFGkIoeaWQvZGhMBn/XmyrWRqQzBRbds8UQO8UG0V5CoLz6mA0HbaXBy+zFBRsqu6mwGHrKI0=;
X-UUID: bc6c4d0c87504244a47a0ed20b80494c-20200617
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1327581873; Wed, 17 Jun 2020 04:01:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 04:01:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 04:01:17 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Sean Wang <sean.wang@mediatek.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 2/2] mt76: mt7615: fix different licenses in same driver
Date:   Wed, 17 Jun 2020 04:01:18 +0800
Message-ID: <dae8a31520c0f30741f6e3bde76b7d4c8cf18de3.1592337119.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <f878543ad56fa3b74f5bfcb49e2112d3e4cc92ee.1592337119.git.ryder.lee@mediatek.com>
References: <f878543ad56fa3b74f5bfcb49e2112d3e4cc92ee.1592337119.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QXZvaWQgdXNpbmcgZGlmZmVyZW50IGxpY2Vuc2VzIGluIHRoZSBzYW1lIGRyaXZlci4NCg0KU2ln
bmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KLS0tDQpAU2Vh
biBATG9yZW56bzogRm9yIG10NzYxNSwgSSBuZWVkIHRvIGdhdGhlciBBQ0sgZnJvbSBhbGwgcGVv
cGxlIGludm9sdmVkIHdpdGggdGhlIGNvZGUuIA0KLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvS2NvbmZpZyAgICB8IDIgKy0NCiBkcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tbWlvLmMgICAgIHwgMyArKysNCiBkcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS91c2JfaW5pdC5jIHwgMiArLQ0KIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3VzYl9tY3UuYyAgfCAyICstDQog
NCBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9LY29uZmln
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvS2NvbmZpZw0KaW5k
ZXggZTI1ZGIxMTM1ZWRhLi5kODQ1NDhkNWUwMDAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9LY29uZmlnDQorKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9LY29uZmlnDQpAQCAtMSw0ICsxLDQgQEANCi0j
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCisjIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBJU0MNCiANCiBjb25maWcgTVQ3NjE1X0NPTU1PTg0KIAl0cmlzdGF0ZQ0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21taW8u
YyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21taW8uYw0KaW5k
ZXggMmU5OTg0NWI5Yzk2Li4zOWI3ZGI4NzFmYzEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tbWlvLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21taW8uYw0KQEAgLTEsMyArMSw2IEBADQorLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IElTQw0KKy8qIENvcHlyaWdodCAoQykgMjAyMCBNZWRp
YVRlayBJbmMuICovDQorDQogI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KICNpbmNsdWRlIDxs
aW51eC9tb2R1bGUuaD4NCiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvdXNiX2lu
aXQuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3VzYl9pbml0
LmMNCmluZGV4IDE5YTE1ZjM1M2UxZS4uMjcxMzZmZjFhYWM5IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvdXNiX2luaXQuYw0KKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvdXNiX2luaXQuYw0KQEAgLTEs
NCArMSw0IEBADQotLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCisvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogSVNDDQogLyogQ29weXJpZ2h0IChDKSAyMDE5IE1lZGlhVGVr
IEluYy4NCiAgKg0KICAqIEF1dGhvcjogRmVsaXggRmlldGthdSA8bmJkQG5iZC5uYW1lPg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3VzYl9t
Y3UuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3VzYl9tY3Uu
Yw0KaW5kZXggY2Q3MDlmZDYxN2RiLi4zNmM0NzUwMGViNWIgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS91c2JfbWN1LmMNCisrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3VzYl9tY3UuYw0KQEAgLTEsNCAr
MSw0IEBADQotLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCisvLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogSVNDDQogLyogQ29weXJpZ2h0IChDKSAyMDE5IE1lZGlhVGVrIElu
Yy4NCiAgKg0KICAqIEF1dGhvcjogRmVsaXggRmlldGthdSA8bmJkQG5iZC5uYW1lPg0KLS0gDQoy
LjE4LjANCg==

