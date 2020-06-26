Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1891020BB6A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 23:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgFZVZ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 17:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFZVZ3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 17:25:29 -0400
Received: from localhost.localdomain.com (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9128C20B1F;
        Fri, 26 Jun 2020 21:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593206728;
        bh=+T9NvsXtOyvF9Opeckil8MObmla13qqGEOfn8ntgF5M=;
        h=From:To:Cc:Subject:Date:From;
        b=ygzOV/rJq05DBqBbJkXNulhL+xSYPIOZd/a0qWDxlIc77DNb2ArhGYsoUyngpuJkF
         spRh1KIHA7/GeTncKn+gRYdRyQqmedt+gAH0wgXfKQ9hudSso4SztQegQWfVh1G6/o
         T1i+7rWsDKKGiVaEZAK7ur/4rdeNBbaxGexfZx64=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 00/17] add runtime-pm support to mt7663 driver
Date:   Fri, 26 Jun 2020 23:25:00 +0200
Message-Id: <cover.1593204577.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series enable runtime power management support available in mt7663 offload
firmware in order to put the device in a reduced power consumption state if
idle for a configurable period of time. mt76 driver wakes the chipset up before
tx packets, accessing register map or sending mcu messages.

Tested-by: Sean Wang <sean.wang@mediatek.com>

Lorenzo Bianconi (17):
  mt76: mt7615: avoid polling in fw_own for mt7663
  mt76: move mt76 worqueue in common code
  mt76: mt7615: add mt7615_pm_wake utility routine
  mt76: mt7615: introduce mt7615_mutex_{acquire,release} utilities
  mt76: mt7615: wake device before accessing regmap in debugfs
  mt76: mt7615: wake device before configuring hw keys
  mt76: mt7615: introduce pm_power_save delayed work
  mt76: mt7615: wake device in mt7615_update_channel before access
    regmap
  mt76: mt7615: acquire driver_own before configuring device for suspend
  mt76: mt7615: wake device before pulling packets from mac80211 queues
  mt76: mt7615: wake device before pushing frames in mt7615_tx
  mt76: mt7615: check MT76_STATE_PM flag before accessing the device
  mt76: mt7615: do not request {driver,fw}_own if already granted
  mt76: mt7615: add runtime-pm knob in mt7615 debugfs
  mt76: mt7615: enable beacon hw filter for runtime-pm
  mt76: mt7615: add idle-timeout knob in mt7615 debugfs
  mt76: mt7615: improve mt7615_driver_own reliability

 drivers/net/wireless/mediatek/mt76/mac80211.c |  15 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   6 +-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  57 +++++
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   7 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 186 +++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 200 +++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  55 +++--
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  44 ++++
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |   4 +
 .../wireless/mediatek/mt76/mt7615/pci_init.c  |   4 +
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  17 +-
 .../wireless/mediatek/mt76/mt7615/usb_mcu.c   |   6 +-
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |   6 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb.c   |   7 +-
 drivers/net/wireless/mediatek/mt76/usb.c      |  20 +-
 15 files changed, 515 insertions(+), 119 deletions(-)

-- 
2.26.2

