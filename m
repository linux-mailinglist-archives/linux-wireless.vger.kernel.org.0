Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F0D3636B9
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhDRQqW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhDRQqW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9C9F6101E;
        Sun, 18 Apr 2021 16:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764353;
        bh=K/t4nRpFya419EKweznwtxYu2nOP6vaLhKxWUnLbiMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=KRuoDJKnwVy8G6y3I9DqMJtSC/whRi7qgBYTUd55WFsQdnHKO9Z+Uv5vPemhovHGU
         aVNM6EGtkKqKerhAzPVkbloWiOC9q/q9UqOVH6qQRt5GtomJjvLqygFJw+8ommYGeO
         wntXpo3bmm24JSCNYvlozFU/nJr3tcslNxwNuCB+k3uhRu88FVhMYVFf086ikBCpl3
         cxdNOEwTZJzcgIg9YQHZTsqgeldEUUulaftTzTGdBIGliMZBvdqIDeJtHYCwHI+KNf
         09rS4hSjPcQMnTE9JRknih4lCUdLQQEvwYmLAkhZDx5Ua+9Ru88Uslm4UlzfUjs3xA
         BSO0BeBLmDB4g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 00/19] mt76: improve runtime-pm support
Date:   Sun, 18 Apr 2021 18:45:26 +0200
Message-Id: <cover.1618763000.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rework runtime-pm support introduce pm refcounting in order
to fix some leftover races between fw_own and tx/rx path.
Introduce awake/doze time accounting.
This is a preliminary series to enable 'deep sleep' support in
mt7921 firmware.

Lorenzo Bianconi (19):
  mt76: mt7921: fix a race between mt7921_mcu_drv_pmctrl and
    mt7921_mcu_fw_pmctrl
  mt76: mt7663: fix a race between mt7615_mcu_drv_pmctrl and
    mt7615_mcu_fw_pmctrl
  mt76: connac: introduce wake counter for fw_pmctrl synchronization
  mt76: mt7921: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx
    path
  mt76: mt7663: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx
    path
  mt76: dma: add the capability to define a custom rx napi poll routine
  mt76: mt7921: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx/rx
    napi
  mt76: mt7663: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx/rx
    napi
  mt76: connac: unschedule ps_work in mt76_connac_pm_wake
  mt76: connac: check wake refcount in mcu_fw_pmctrl
  mt76: connac: remove MT76_STATE_PM in mac_tx_free
  mt76: mt7921: get rid of useless MT76_STATE_PM in mt7921_mac_work
  mt76: connac: alaways wake the device before scanning
  mt76: mt7615: rely on pm refcounting in mt7615_led_set_config
  mt76: connac: do not run mt76_txq_schedule_all directly
  mt76: connac: use waitqueue for runtime-pm
  mt76: remove MT76_STATE_PM in tx path
  mt76: mt7921: add awake and doze time accounting
  mt76: mt7921: enable sw interrupts

 drivers/net/wireless/mediatek/mt76/dma.c      | 10 ++--
 drivers/net/wireless/mediatek/mt76/dma.h      |  1 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |  6 ++-
 .../net/wireless/mediatek/mt76/mt7603/dma.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/dma.c   | 30 +++++++++--
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  5 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 20 ++++---
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 30 +++++------
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 23 +++++---
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  1 +
 .../wireless/mediatek/mt76/mt7615/pci_init.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt76_connac.h  | 52 ++++++++++++++++++-
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 17 ++----
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  2 +-
 .../wireless/mediatek/mt76/mt7921/debugfs.c   | 32 +++++++++++-
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 34 ++++++++++--
 .../net/wireless/mediatek/mt76/mt7921/init.c  | 10 +++-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 29 +++++------
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 26 ++++------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 46 +++++++++++-----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  3 ++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 13 +++++
 .../net/wireless/mediatek/mt76/mt7921/regs.h  | 17 +++---
 drivers/net/wireless/mediatek/mt76/tx.c       | 18 ++++---
 25 files changed, 307 insertions(+), 126 deletions(-)

-- 
2.30.2

