Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E221FC48D
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2020 05:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgFQDNh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 23:13:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:26374 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726253AbgFQDNh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 23:13:37 -0400
X-UUID: 619d7e2fcc044a5fb00e659debd96ffd-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=phSEVnx2YN8ID4XCGX38hcVMnB8sCkrhT2w5pB/6SzU=;
        b=OtVrMGrk2d24P9D3MDB7UP9YijorkELM6xE0iS3WnN7WOgu1YUfMLcC9Hhi7U7O7XtNbGlf2dIvgi57jJbMZR1N7oKBIS2zgFaBDqUNM3xIfb9uj3N43OpKrtUy0Eqk896fVI/BS3Eq+qX1qTy2W8ZYESVz+ZQuuft/Rzq1BM4o=;
X-UUID: 619d7e2fcc044a5fb00e659debd96ffd-20200617
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1767473644; Wed, 17 Jun 2020 11:13:33 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 11:13:31 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 11:13:26 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Ryder.Lee@mediatek.com>,
        <sean.wang@mediatek.com>
Subject: Re: [PATCH v2 2/2] mt76: mt7615: fix different licenses in same driver
Date:   Wed, 17 Jun 2020 11:13:30 +0800
Message-ID: <1592363610-13861-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <dae8a31520c0f30741f6e3bde76b7d4c8cf18de3.1592337119.git.ryder.lee@mediatek.com>
References: <dae8a31520c0f30741f6e3bde76b7d4c8cf18de3.1592337119.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQo+QXZvaWQgdXNpbmcg
ZGlmZmVyZW50IGxpY2Vuc2VzIGluIHRoZSBzYW1lIGRyaXZlci4NCj4NCj5TaWduZWQtb2ZmLWJ5
OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQo+LS0tDQo+QFNlYW4gQExvcmVu
em86IEZvciBtdDc2MTUsIEkgbmVlZCB0byBnYXRoZXIgQUNLIGZyb20gYWxsIHBlb3BsZSBpbnZv
bHZlZCB3aXRoIHRoZSBjb2RlLg0KDQpJIGFtIGZpbmUgd2l0aCBsaWNlbnNlIGNoYW5nZSB0b28u
DQpBY2tlZC1ieTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQo+LS0tDQo+
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L0tjb25maWcgICAgfCAy
ICstDQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21taW8uYyAg
ICAgfCAzICsrKw0KPiBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS91
c2JfaW5pdC5jIHwgMiArLSAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2
MTUvdXNiX21jdS5jICB8IDIgKy0NCj4gNCBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo=

