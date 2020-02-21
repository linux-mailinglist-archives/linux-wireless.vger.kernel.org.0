Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF100166B4A
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2020 01:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgBUAHw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Feb 2020 19:07:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbgBUAHw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Feb 2020 19:07:52 -0500
Received: from localhost.localdomain (unknown [151.48.137.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1B032071E;
        Fri, 21 Feb 2020 00:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582243672;
        bh=iCi8uym9jSKY8fYMmL2eNrM2d+i4/nsLHqeDyievqlM=;
        h=From:To:Cc:Subject:Date:From;
        b=kKBfuOuNpjI5YJgOp74dX3iEe9Chbh3O9g7kpcg7rb/3XNK+eXhesDiKM4V4KN76T
         su4AyA2Yc2GRnUUvDqT06C7YcSwvkNUYXFCLTaiW4WlDN7Qj1WjrGN8ydvEpzMZsjG
         f8cjJFWfbLFBpXtBN63j11VDGga0F98AGqE61C9I=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
Subject: [PATCH 0/8] Introduce mt7663e support to mt7615 driver
Date:   Fri, 21 Feb 2020 01:07:27 +0100
Message-Id: <cover.1582243031.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce support for mt7663e 802.11ac 2x2:2 chipset to mt7615 driver.
Introduce mt7615e_reg_map and mt7663e_regmap to reuse mt7615 code.
Code refactoring.

Lorenzo Bianconi (8):
  mt76: mt7615: introduce mt7615_register_map
  mt76: mt7615: add mt7663e support to mt7615_reg_map
  mt76: mt7615: add mt7663 support to mt7615_mcu_set_tx_ba
  mt76: mt7615: add mt7663e support to mt7615_{driver,firmware}_own
  mt76: mt7615: add mt7663e support to mt7615_mcu_set_eeprom
  mt76: mt7615: introduce mt7615_eeprom_parse_hw_band_cap routine
  mt76: mt7615: introduce mt7615_init_mac_chain routine
  mt76: mt7615: introduce mt7663e support

 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  45 +++-
 .../wireless/mediatek/mt76/mt7615/eeprom.c    |  48 ++++-
 .../wireless/mediatek/mt76/mt7615/eeprom.h    |   2 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 130 ++++++------
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  20 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |   7 +
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 192 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |  67 +++++-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  14 +-
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  12 +-
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  87 ++++++--
 .../net/wireless/mediatek/mt76/mt7615/soc.c   |   2 +-
 12 files changed, 507 insertions(+), 119 deletions(-)

-- 
2.24.1

