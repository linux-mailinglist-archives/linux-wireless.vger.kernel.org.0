Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E9B21B58A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2020 14:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGJM4c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jul 2020 08:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbgGJM43 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jul 2020 08:56:29 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B94620772;
        Fri, 10 Jul 2020 12:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594385788;
        bh=zEuVCwMPtcmeOrD97rEoLQftJ9vTfb19Y2/O838xjmQ=;
        h=From:To:Cc:Subject:Date:From;
        b=iJb5IRo7LIsk+gt6Jbd3t4MdAN1na6880DGZv+LSv5/CdJqrO41t5qoikkbeM1u5a
         DOlO5eF2bPJVwAxFdy8AaCTXO9lJMrpu0jSxiY5pkFdDshG8q1IKeGjMZFs5uVlccA
         T9Kz0nK+mKqOXu2nFQA2eE2EQUTvQs1J7/bL/Q9A=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/6] introduce support for mt7663s devices
Date:   Fri, 10 Jul 2020 14:56:14 +0200
Message-Id: <cover.1594384887.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce support for mt7663s 802.11ac 2x2:2 chipset to mt7615 driver.
Introduce mt76_sdio module as common sdio layer.
Introduce mt7663-common module as container for shared code between usb and
sdio mt7663 drivers

Lorenzo Bianconi (4):
  mt76: mt7615: take into account sdio bus configuring txwi
  mt76: mt76u: add mt76_skb_adjust_pad utility routine
  mt76: mt7615: sdio code must access rate/key regs in preocess context
  mt76: mt7615: introduce mt7663-common module

Sean Wang (2):
  mt76: introduce mt76_sdio module
  mt76: mt7615: introduce mt7663s support

 drivers/net/wireless/mediatek/mt76/Kconfig    |   4 +
 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +
 drivers/net/wireless/mediatek/mt76/mac80211.c |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  34 +-
 .../net/wireless/mediatek/mt76/mt7615/Kconfig |  17 +-
 .../wireless/mediatek/mt76/mt7615/Makefile    |   6 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  20 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   6 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  42 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  10 +
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |   1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  20 +-
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  12 +
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  | 204 ++++
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  | 161 +++
 .../net/wireless/mediatek/mt76/mt7615/usb.c   | 253 +----
 .../wireless/mediatek/mt76/mt7615/usb_init.c  | 145 ---
 .../wireless/mediatek/mt76/mt7615/usb_mcu.c   |   3 +-
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  | 394 ++++++++
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |   3 +-
 drivers/net/wireless/mediatek/mt76/sdio.c     | 948 ++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/sdio.h     | 111 ++
 drivers/net/wireless/mediatek/mt76/tx.c       |  29 +
 drivers/net/wireless/mediatek/mt76/usb.c      |  29 -
 24 files changed, 2026 insertions(+), 434 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/sdio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/sdio.h

-- 
2.26.2

