Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AB847A191
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 18:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhLSRk6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 12:40:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44386 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbhLSRk5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 12:40:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56D1560ED0
        for <linux-wireless@vger.kernel.org>; Sun, 19 Dec 2021 17:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B57C36AE8;
        Sun, 19 Dec 2021 17:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639935656;
        bh=GtVZMBx9Jyy+f8Bnv2wGd0+5lmRNaTAHw4ivG/qE8I4=;
        h=From:To:Cc:Subject:Date:From;
        b=pYjUsqdYgrS67PN6TnBkcK8IV6/8H4fr26aSV17xVIY/xKT6O035d7SohJ2fDXrJr
         /RE0TAxkmehbZwOZF/UtfaoVbzwC8URjvatgvhzLPDlSsvnOESjs3QgoxOVGVsqask
         t3TXay5PC1yW/UtOwMMn0C4Sx2K3Ryv1v4hKz0kA9n039iZs+CtlcanuIE+8aIIWTE
         WQ5WO7GSZl38xkrZBeOaTjio7FyEeSIuOMdqCzttgBMGBi9QpYj1UD5ryomOJFhxWg
         qCPRIu2FsfhGnmpxJxER2Vk456sgkzXgbvn+50IlM1jVKcs1X20MMsl5BbEwYs5RLG
         dUwYbpfLjzWHQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH v2 0/9] introduce mt76-connac dependency in mt7915 driver
Date:   Sun, 19 Dec 2021 18:40:05 +0100
Message-Id: <cover.1639935477.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76-connac module dependency in the mt7915 driver and remove
duplicated mcu code.

Changes since v1:
- fix sta_rec_wtbl tag len for mt7615/mt7921
- fix broadcast muar_idx in alloc_sta_req for mt7615/mt7921

Lorenzo Bianconi (9):
  mt76: connac: fix sta_rec_wtbl tag len
  mt76: connac: fix broadcast muar_idx in alloc_sta_req
  mt76: mt7915: rely on mt76_connac_mcu_alloc_sta_req
  mt76: mt7915: rely on  mt76_connac_mcu_alloc_wtbl_req
  mt76: mt7915: rely on mt76_connac_mcu_add_tlv routine
  mt76: connac: move mt76_connac_mcu_get_cipher in common code
  mt76: connac: move mt76_connac_chan_bw in common code
  mt76: mt7915: rely on mt76_connac_get_phy utilities
  mt76: connac: move mt76_connac_mcu_add_key in connac module

 .../net/wireless/mediatek/mt76/mt76_connac.h  |  29 ++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 112 ++++-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  50 +-
 .../net/wireless/mediatek/mt76/mt7915/Kconfig |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   5 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 441 ++++--------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  17 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   9 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 137 +-----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  10 +-
 10 files changed, 278 insertions(+), 534 deletions(-)

-- 
2.33.1

