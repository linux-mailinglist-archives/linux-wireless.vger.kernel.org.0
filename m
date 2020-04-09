Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 784531A38A5
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 19:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgDIRKA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 13:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgDIRKA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 13:10:00 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 959EB20678;
        Thu,  9 Apr 2020 17:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586452200;
        bh=B8PuwnW0S3qjDKq3eT0Uklk4AJiEr5grst+cjB1olSs=;
        h=From:To:Cc:Subject:Date:From;
        b=Ow8kupwwtVpnFCLwAOKi0nmxWeRjqzORKbpT1TGNK6pYKV+Yj1cK3coFkALI45S9z
         R4VjIijX3SGsQ/oPHRTncfhER0rg1gfwST93jIssASZJ+7cVARfNbLpe/ekDPPCNeu
         bOpOphWphHr5gpmFNUygjmnReQF2EhjOSPGNtvt8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/2] introduce usb support to mt7615 driver
Date:   Thu,  9 Apr 2020 19:09:40 +0200
Message-Id: <cover.1586451954.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce support for mt7663u 802.11ac 2x2:2 chipset to mt7615 driver.
Create mt7615-common module as container for mmio and usb shared code

Changes since v1:
- rebased ontop of mt76 master branch

Lorenzo Bianconi (2):
  mt76: mt7615: move core shared code in mt7615-common module
  mt76: mt7615: introduce mt7663u support

 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 .../net/wireless/mediatek/mt76/mt7615/Kconfig |  18 +-
 .../wireless/mediatek/mt76/mt7615/Makefile    |  10 +-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |   1 +
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  39 --
 .../wireless/mediatek/mt76/mt7615/eeprom.c    |   1 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 192 +--------
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 249 ++++-------
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |   5 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  66 +--
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  18 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |   5 +
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |  30 ++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  22 +-
 .../wireless/mediatek/mt76/mt7615/pci_init.c  | 187 +++++++++
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   | 184 ++++++++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  26 ++
 .../net/wireless/mediatek/mt76/mt7615/usb.c   | 396 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7615/usb_init.c  | 144 +++++++
 .../wireless/mediatek/mt76/mt7615/usb_mcu.c   |  93 ++++
 21 files changed, 1257 insertions(+), 432 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c

-- 
2.25.2

