Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDFA2B0257
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 10:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgKLJ5M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 04:57:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgKLJ5L (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Nov 2020 04:57:11 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB2EB221FE;
        Thu, 12 Nov 2020 09:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605175031;
        bh=vri0U9EkDByCTivO0zrymp1sK3qL4Zj1o2JXYy3neRk=;
        h=From:To:Cc:Subject:Date:From;
        b=FtUWbNX8tiAvansmPD5MWV+be/z//EVdyPcuvw+t3Cr15gPU1cbdqSHgEbUdql4ja
         5CQmsATIej7NqC7zvp90jaYaxQsnXDyLafz77PMl6qSYYqmk5GlyrldYYtbwOcqlVF
         29PG+UawDwS/OKeyPs0/Pqb9ghY+BbzBFcI6/evI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com
Subject: [PATCH 0/6] mt7915: introduce dbdc support
Date:   Thu, 12 Nov 2020 10:56:55 +0100
Message-Id: <cover.1605173301.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7615 devices, mt7915d chipset supports dbdc mode
where the hw exports a primary phy on 2.4GHz band and a secondary
phy on 5GHz band.

This series is based on "mt76: move hw data queues in mt76_phy"
https://patchwork.kernel.org/project/linux-wireless/list/?series=382083

Tested-by: Shayne Chen <shayne.chen@mediatek.com>

Lorenzo Bianconi (6):
  mt76: move band capabilities in mt76_phy
  mt76: rely on mt76_phy in mt76_init_sband_2g and mt76_init_sband_5g
  mt76: move band allocation in mt76_register_phy
  mt76: move hw mac_addr in mt76_phy
  mt76: mt7915: introduce dbdc support
  mt76: mt7915: get rid of dbdc debugfs knob

 drivers/net/wireless/mediatek/mt76/eeprom.c   |  12 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c | 106 +++--
 drivers/net/wireless/mediatek/mt76/mt76.h     |  11 +-
 .../wireless/mediatek/mt76/mt7603/eeprom.c    |   6 +-
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |   2 +-
 .../wireless/mediatek/mt76/mt7615/eeprom.c    |  20 +-
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   6 +-
 .../wireless/mediatek/mt76/mt76x0/eeprom.c    |  12 +-
 .../net/wireless/mediatek/mt76/mt76x0/init.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt76x0/phy.c   |   4 +-
 .../wireless/mediatek/mt76/mt76x02_eeprom.c   |   8 +-
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  16 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |   8 +-
 .../wireless/mediatek/mt76/mt76x2/eeprom.c    |   6 +-
 .../wireless/mediatek/mt76/mt76x2/pci_init.c  |   2 +-
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  40 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  19 +-
 .../wireless/mediatek/mt76/mt7915/eeprom.c    |  51 ++-
 .../wireless/mediatek/mt76/mt7915/eeprom.h    |   1 +
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 386 +++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  19 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   3 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   4 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   5 +-
 .../net/wireless/mediatek/mt76/mt7915/pci.c   |  19 +-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  13 +-
 drivers/net/wireless/mediatek/mt76/testmode.c |  17 +-
 27 files changed, 398 insertions(+), 402 deletions(-)

-- 
2.26.2

