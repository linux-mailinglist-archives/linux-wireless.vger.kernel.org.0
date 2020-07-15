Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F278D220D43
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 14:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbgGOMqn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 08:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbgGOMqm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 08:46:42 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D63BF20578;
        Wed, 15 Jul 2020 12:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594817202;
        bh=Ln6GACSEdsRfqzDZIE32+bve+4nimxMAv6/Q7sLUH/c=;
        h=From:To:Cc:Subject:Date:From;
        b=O3EVXwimOYPPUUKk3ihUFoOCXNO61T1jxwdXY8hMMbeqkJq3AZoQOuaciR7IuQ81g
         HGQ82UJzqc0HD84LtQhpK+rY5ABhGtbgshy6ENzpZ/91SJ2AVpgedXppnQ5qVzr4zU
         f+BOevjkIUXcv1YtN0Yl33qPG4CyIeCJdyXqpANU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/6] introduce support for mt7663s devices
Date:   Wed, 15 Jul 2020 14:46:25 +0200
Message-Id: <cover.1594815602.git.lorenzo@kernel.org>
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

Changes since v1:
 - remove mt7663s reg-map dependency from mt76-sdio module
 - get rid of rx buffer pre-allocation in mt76-sdio module
 - enable sdio rx aggregation
 - move tx/rx post-processing in a dedicated kthread

Lorenzo Bianconi (4):
  mt76: mt7615: take into account sdio bus configuring txwi
  mt76: mt76u: add mt76_skb_adjust_pad utility routine
  mt76: mt7615: sdio code must access rate/key regs in preocess context
  mt76: mt7615: introduce mt7663-usb-sdio-common module

Sean Wang (2):
  mt76: introduce mt76_sdio module
  mt76: mt7615: introduce mt7663s support

 drivers/net/wireless/mediatek/mt76/Kconfig    |   4 +
 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +
 drivers/net/wireless/mediatek/mt76/mac80211.c |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  32 +-
 .../net/wireless/mediatek/mt76/mt7615/Kconfig |  17 +-
 .../wireless/mediatek/mt76/mt7615/Makefile    |   6 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  20 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   6 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  42 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  10 +
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |   1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  23 +-
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  12 +
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  | 478 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/sdio.h  | 115 +++++
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  | 161 ++++++
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 271 ++++++++++
 .../net/wireless/mediatek/mt76/mt7615/usb.c   | 253 +--------
 .../wireless/mediatek/mt76/mt7615/usb_init.c  | 145 ------
 .../wireless/mediatek/mt76/mt7615/usb_mcu.c   |   3 +-
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  | 394 +++++++++++++++
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |   3 +-
 drivers/net/wireless/mediatek/mt76/sdio.c     | 363 +++++++++++++
 drivers/net/wireless/mediatek/mt76/tx.c       |  29 ++
 drivers/net/wireless/mediatek/mt76/usb.c      |  29 --
 25 files changed, 1991 insertions(+), 434 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/sdio.c

-- 
2.26.2

