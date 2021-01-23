Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43A8301488
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Jan 2021 11:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbhAWKdz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Jan 2021 05:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbhAWKdy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Jan 2021 05:33:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD10A22B2D;
        Sat, 23 Jan 2021 10:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611397993;
        bh=AtW3YvjPJGwi5+G2f7Tx3jxZCP9J070R/GoLejM1cyU=;
        h=From:To:Cc:Subject:Date:From;
        b=PVFXjHN6UP8XEL2jhmvWeV3hr3B3MYPR3nsbObuzCEdfxQnyWsXiwxexXHWriQL4X
         g3xfTT9ZCKnac0LjCiLODbYMmqXkDK8hDWHuTGHHCphRbdl9pHLu2QRkLwRqrXql4Y
         UwJO/2EBgB2S7vZ1Yx931Q16LnLtCuFdCEvchHsYKY+pM4LVjzgfH1VWjlmdIItPtb
         giXuSoP2GjH8dL//HaSz8uvHAJyuDTBr15AH4oHYIQHdxkkGAWttmU50eogGTYvp4s
         UV+roS0f7GCjo6kkqQcr0w/RaGwxKGRcEtpn1jWDg8QDj31NnwTtu4OcVfyATBNZ6v
         xepAe26sKNn3A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 0/6] mt76: introduce mt76_connac common module
Date:   Sat, 23 Jan 2021 11:32:58 +0100
Message-Id: <cover.1611397696.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76_connac common module for code sharing between mt7615
and mt7921 drivers.

Changes since v1:
- rename mt76_vif struct of mt7615_vif in mt76

Lorenzo Bianconi (6):
  mt76: introduce mt76_vif data structure
  mt76: mt76_connac: create mcu library
  mt76: mt76_connac: move hw_scan and sched_scan routine in
    mt76_connac_mcu module
  mt76: mt76_connac: move WoW and suspend code in mt76_connac_mcu module
  mt76: mt76_connac: move pm data struct in mt76_connac.h
  mt76: mt76_connac: move pm utility routines in mt76_connac_lib module

 drivers/net/wireless/mediatek/mt76/Kconfig    |    4 +
 drivers/net/wireless/mediatek/mt76/Makefile   |    3 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |    8 +
 .../net/wireless/mediatek/mt76/mt7615/Kconfig |    2 +-
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   15 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |   91 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  159 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 1624 ++---------------
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  682 +------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   97 +-
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |    9 +-
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |    5 +-
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |    4 +-
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   91 +
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  119 ++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 1490 +++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  954 ++++++++++
 18 files changed, 2930 insertions(+), 2429 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h

-- 
2.29.2

