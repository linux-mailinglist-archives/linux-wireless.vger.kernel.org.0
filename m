Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111503645E3
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 16:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhDSOVh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Apr 2021 10:21:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49028 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238649AbhDSOVf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Apr 2021 10:21:35 -0400
X-UUID: 69ab0b1cc62c4e5db436c666f62db3cf-20210419
X-UUID: 69ab0b1cc62c4e5db436c666f62db3cf-20210419
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2147034633; Mon, 19 Apr 2021 22:21:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Apr 2021 22:21:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Apr 2021 22:20:59 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, Sean Wang <objelf@gmail.com>
Subject: [PATCH v2 0/6] enable deep sleep mode when mt7921e suspends
Date:   Mon, 19 Apr 2021 22:20:53 +0800
Message-ID: <1618842059-8192-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <objelf@gmail.com>

Enable the deep sleep mode in suspend handler which is able to reduce the
power consumption further.

v2:
- rebase onto [PATCH 00/19] mt76: improve runtime-pm support
- change the 'From' tag in 4/6 patch

Lorenzo Bianconi (4):
  mt76: mt7921: move mt7921_dma_reset in dma.c
  mt76: mt7921: introduce mt7921_wpdma_reset utility routine
  mt76: mt7921: introduce mt7921_dma_{enable,disable} utilities
  mt76: mt7921: introduce mt7921_wpdma_reinit_cond utility routine

Sean Wang (2):
  mt76: connac: introduce mt76_connac_mcu_set_deep_sleep utility
  mt76: mt7921: enable deep sleep when the device suspends

 .../net/wireless/mediatek/mt76/mt76_connac.h  |   2 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  22 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  10 +
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |   3 +
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 208 +++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  94 +-------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   8 +-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  12 +
 8 files changed, 205 insertions(+), 154 deletions(-)

--
2.25.1

