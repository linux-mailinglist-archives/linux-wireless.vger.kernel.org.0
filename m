Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415A8F999
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 15:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfD3NML (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 09:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfD3NML (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 09:12:11 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14A3020835;
        Tue, 30 Apr 2019 13:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556629931;
        bh=yerfDpiFuPQXTYCNcZNJU1ytlyTHfxS69nnL80fbKi4=;
        h=From:To:Cc:Subject:Date:From;
        b=POOhk4B3zn8FsIQxoxvD/n4qxk+O6Npdab+KeKAVlMb7zpIvt4HC9q526B3MoYe1W
         zsFtM0SvtCm73hiEen3mwrednBz0lwozVJVAbe7EzWPnnAK1MCmFCtEB5Gn/3ozHvw
         1mQPHoRZ4pyw/8aCalFpErOei2ZBA7o65OHzg5qU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH v3 0/3] mt76: move common beacon code in mt76 module
Date:   Tue, 30 Apr 2019 15:12:00 +0200
Message-Id: <cover.1556629547.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move beacon data structures shared between mt76x02 and mt7603 drivers
in mt76_dev.
Enable/disable pre_tbtt_tasklet tasklet in mt7603_set_channel

Changes since v2:
- remove patch 2/5 and 3/5 since already applied
- do not run tbtt tasklet while offchannel

Changes since v1:
- added new patch: 'mt76: do not enable/disable pre_tbtt_tasklet in
  scan_start/scan_complete'

Lorenzo Bianconi (3):
  mt76: move pre_tbtt_tasklet in mt76_dev
  mt76: mt7603: enable/disable pre_tbtt_tasklet in mt7603_set_channel
  mt76: do not enable/disable pre_tbtt_tasklet in
    scan_start/scan_complete

 drivers/net/wireless/mediatek/mt76/mt76.h         |  1 +
 .../net/wireless/mediatek/mt76/mt7603/beacon.c    |  3 +++
 drivers/net/wireless/mediatek/mt76/mt7603/core.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c  |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c   |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/main.c  | 12 ++++++++----
 .../net/wireless/mediatek/mt76/mt7603/mt7603.h    |  2 --
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h      |  1 -
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 15 +++++++++------
 .../net/wireless/mediatek/mt76/mt76x02_usb_core.c |  3 +++
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c |  5 -----
 .../net/wireless/mediatek/mt76/mt76x2/pci_init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci_main.c  |  4 ++--
 14 files changed, 33 insertions(+), 27 deletions(-)

-- 
2.20.1

