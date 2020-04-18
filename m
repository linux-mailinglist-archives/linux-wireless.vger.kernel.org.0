Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B17A1AEA83
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 09:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgDRHlM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 03:41:12 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39451 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725849AbgDRHlM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 03:41:12 -0400
X-UUID: dbc70448400045dbb60302985f6420e3-20200418
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=1U+i+7CJ6KZUZ5cCs3rS9/LtEgfxTjgWKs77kEGtB00=;
        b=RWoaJtN/pVSfEiVhnK9VsDTKbexNRHHU+Set3uBGVo0qBl+dVrCKMdXgGPf9UUHSP7tVK5JrV9vx279oQH/QY+rS8O4nsbnhNOosWG1IgwTJWggQ4C3haPX39q+Eb4h2pzbiXtziLe2+Hs7GTRDpKOm0wm4pbIAesm6XaVGRXOo=;
X-UUID: dbc70448400045dbb60302985f6420e3-20200418
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1227009724; Sat, 18 Apr 2020 15:41:06 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 18 Apr 2020 15:41:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 18 Apr 2020 15:41:04 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] MAINTAINERS: update mt76 reviewers
Date:   Sat, 18 Apr 2020 15:40:57 +0800
Message-ID: <c171e0dfce9f2dad5ca6935eaf6004117f82e259.1587195398.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 27E06CEA86D63DA8ECFB9A291ACAB92978605CE4AAE56B106ABFB72775E0B3462000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Um95IG5vIGxvbmdlciB3b3JrcyBoZXJlLiBUaW1lIHRvIHNheSBnb29kYnllLCBteSBmcmllbmQu
DQoNClNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCi0t
LQ0KIE1BSU5UQUlORVJTIHwgMSAtDQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCg0K
ZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCmluZGV4IDk3ZGNlMjY0YmM3
Yy4uNzcxMmVjMzk0MTczIDEwMDY0NA0KLS0tIGEvTUFJTlRBSU5FUlMNCisrKyBiL01BSU5UQUlO
RVJTDQpAQCAtMTA1OTgsNyArMTA1OTgsNiBAQCBNRURJQVRFSyBNVDc2IFdJUkVMRVNTIExBTiBE
UklWRVINCiBNOglGZWxpeCBGaWV0a2F1IDxuYmRAbmJkLm5hbWU+DQogTToJTG9yZW56byBCaWFu
Y29uaSA8bG9yZW56by5iaWFuY29uaTgzQGdtYWlsLmNvbT4NCiBSOglSeWRlciBMZWUgPHJ5ZGVy
LmxlZUBtZWRpYXRlay5jb20+DQotUjoJUm95IEx1byA8cm95bHVvQGdvb2dsZS5jb20+DQogTDoJ
bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQogUzoJTWFpbnRhaW5lZA0KIEY6CWRyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvDQotLSANCjIuMTguMA0K

