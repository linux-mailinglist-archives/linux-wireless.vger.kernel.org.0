Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401E945833B
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Nov 2021 13:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbhKUMPq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Nov 2021 07:15:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:41068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235783AbhKUMPq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Nov 2021 07:15:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8074660E54;
        Sun, 21 Nov 2021 12:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637496761;
        bh=B3G7Nw2QezolTcZzRCa15Df9MdCCMXPnG7NbmZoSX94=;
        h=From:To:Cc:Subject:Date:From;
        b=tMmV+ecqnY4g1X8qBcpgntCCFFUnveH8DI00Xohck7EakHiYfANNZI81GrnTHGtI8
         /Zy3bK9SJEiY34kuRwH5oghrmINefA5sd4700hAvSNln+GpsVM3WUFV1TbNgj7xjp+
         cQbmXwRnF/dJQX3ZxOEv42HgRxfRyFr656NyZFOuIvRyLGLYju5Q6K55I/ewlp4Aut
         U8vFKnY4ty4fUFg9x4ejJPzdzvsVGquBCFypKmNg3r3VIS9zAP1VqMJV7PdBMdMCMJ
         auqDPRuwXdhp05ehFMZtOKtgm2ZvvenPgwUupYms8wBbnh73JjO3se3MBQJUf1RVMM
         SN7GMVi/9wTuA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 0/2] introduce SAR support to mt76x02 drivers
Date:   Sun, 21 Nov 2021 13:12:23 +0100
Message-Id: <cover.1637496643.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add SAR spec support to mt76x02 driver to allow configuring SAR power
limitations on the frequency ranges from the userland.

Lorenzo Bianconi (2):
  mt76: move sar utilities to mt76-core module
  mt76: mt76x02: introduce SAR support

 drivers/net/wireless/mediatek/mt76/mac80211.c | 53 +++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  5 ++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 27 +---------
 .../net/wireless/mediatek/mt76/mt76x0/init.c  |  5 +-
 .../net/wireless/mediatek/mt76/mt76x0/main.c  | 34 +++++++++++-
 .../wireless/mediatek/mt76/mt76x0/mt76x0.h    |  2 +
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |  1 +
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |  1 +
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c | 11 +++-
 .../net/wireless/mediatek/mt76/mt76x2/init.c  | 29 ++++++++++
 .../wireless/mediatek/mt76/mt76x2/mt76x2.h    |  2 +
 .../wireless/mediatek/mt76/mt76x2/pci_init.c  |  5 +-
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  |  7 ++-
 .../wireless/mediatek/mt76/mt76x2/usb_init.c  |  4 +-
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  |  9 +++-
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 26 ++-------
 17 files changed, 164 insertions(+), 59 deletions(-)

-- 
2.31.1

