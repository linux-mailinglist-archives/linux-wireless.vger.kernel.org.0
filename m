Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E393636A8
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhDRQgr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:36:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58373 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230028AbhDRQgm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:36:42 -0400
X-UUID: 7474f6eb89814d71925ab1ebdb8f1324-20210419
X-UUID: 7474f6eb89814d71925ab1ebdb8f1324-20210419
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2090682969; Mon, 19 Apr 2021 00:36:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Apr 2021 00:36:08 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Apr 2021 00:36:08 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 0/6] enable deep sleep mode when mt7921e suspends
Date:   Mon, 19 Apr 2021 00:36:01 +0800
Message-ID: <1618763767-1292-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7D5F2C5E062484233DDB16F9FAC75FFDAE0388D0C83E5CA575D7753A9C2DBD612000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Enable the deep sleep mode in suspend handler which is able to reduce the
power consumption further.

Lorenzo Bianconi (3):
  mt76: mt7921: move mt7921_dma_reset in dma.c
  mt76: mt7921: introduce mt7921_wpdma_reset utility routine
  mt76: mt7921: introduce mt7921_dma_{enable,disable} utilities

Sean Wang (3):
  mt76: mt7921: introduce mt7921_wpdma_reinit_cond utility routine
  mt76: connac: introduce mt76_connac_mcu_set_deep_sleep utility
  mt76: mt7921: enable deep sleep when the device suspends

 .../net/wireless/mediatek/mt76/mt76_connac.h  |   4 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  22 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  10 +
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  13 ++
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 204 +++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  93 +-------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   8 +-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  12 ++
 8 files changed, 215 insertions(+), 151 deletions(-)

--
2.25.1

