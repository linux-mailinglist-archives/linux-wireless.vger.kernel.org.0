Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2D22B18CA
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 11:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgKMKLj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 05:11:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgKMKLj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 05:11:39 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7329D2065E;
        Fri, 13 Nov 2020 10:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605262298;
        bh=YMlQppSE4uqDoiqoAd/hQVpT7cYWEwJIe/teXpmlKbo=;
        h=From:To:Cc:Subject:Date:From;
        b=YLZI+Q6REs2CmO3mnLiw4rVVLvX8FkSaRT2jC7IrMFlhV+g8Qtppg0iHOYo9TdXVH
         +RpxvJiQdRkgkc3EOf9ecNbjMG1nvm4qAyGbZ3nrsXNlcO5FSnakenLduVY9HjJea2
         +EhYpLwvF9K9eN8J+Et6e2OET2cph+U9C70DjACA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com
Subject: [PATCH v2 0/3] mt7915: introduce dbdc support
Date:   Fri, 13 Nov 2020 11:11:29 +0100
Message-Id: <cover.1605261982.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7615 devices, mt7915d chipset supports dbdc mode
where the hw exports a primary phy on 2.4GHz band and a secondary
phy on 5GHz band.

Changes since v1:
- drop patch 1/6, 2/6, 3/6 since they have been already applied
- fix a mac address configuration issue for mt7615 ext_phy
- improve commit log
- remove unnecessary chunk in mt7915_phy_get_nf()

Tested-by: Shayne Chen <shayne.chen@mediatek.com>

Lorenzo Bianconi (3):
  mt76: move hw mac_addr in mt76_phy
  mt76: mt7915: introduce dbdc support
  mt76: mt7915: get rid of dbdc debugfs knob

 drivers/net/wireless/mediatek/mt76/eeprom.c   |  12 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |  11 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   6 +-
 .../wireless/mediatek/mt76/mt7603/eeprom.c    |   4 +-
 .../wireless/mediatek/mt76/mt7615/eeprom.c    |   4 +-
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   7 +-
 .../wireless/mediatek/mt76/mt76x0/eeprom.c    |   6 +-
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  16 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |   8 +-
 .../wireless/mediatek/mt76/mt76x2/eeprom.c    |   6 +-
 .../wireless/mediatek/mt76/mt76x2/pci_init.c  |   2 +-
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  40 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  19 +-
 .../wireless/mediatek/mt76/mt7915/eeprom.c    |  51 ++-
 .../wireless/mediatek/mt76/mt7915/eeprom.h    |   1 +
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 382 +++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  14 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   3 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   4 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   5 +-
 .../net/wireless/mediatek/mt76/mt7915/pci.c   |  19 +-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  13 +-
 drivers/net/wireless/mediatek/mt76/testmode.c |  17 +-
 23 files changed, 330 insertions(+), 320 deletions(-)

-- 
2.26.2

