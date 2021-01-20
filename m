Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEA72FDD0E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Jan 2021 00:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbhATWfP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jan 2021 17:35:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388472AbhATWPa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jan 2021 17:15:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E27B6206ED;
        Wed, 20 Jan 2021 22:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611180888;
        bh=RmCUUcpgJruwf2Mkk/yImUPvHcho3UFDIDGJiuPQNmQ=;
        h=From:To:Cc:Subject:Date:From;
        b=qVxKda8n9M/RplVRU7T0RL4Q8juPMp4g1qsL4Xsx79ZhEbxu0wiM+YXEU81EThs9B
         wH2GComTN0Aa8p1adPo7gZJ8egTaIVs5UotNYsIQwowIx0pFfUpqnaSpbwE5sYjcyh
         mYXflpIUQuLH4yCW8/jXCsm0Z68iAyMlXOaKJbcmJ6QGa2BXadZbpei7Y1F1t46+rD
         cBPOWWOOvD0x2J2zN8vzGqKlaoBstyNne176oGD609NKs/nSOKsjXYQCSzH+0o2HhH
         QDvaycuFi8+NWs6D4toG73A8HdhgGKTjOx4JcqIgpHs5/dmXtQDd7ywaboGjkI8QnJ
         7QlJ//rWmwKeQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 0/6] mt76: introduce mt76_connac common module
Date:   Wed, 20 Jan 2021 23:14:34 +0100
Message-Id: <cover.1611180342.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76_connac common module for code sharing between mt7615 and mt7921
drivers.

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

