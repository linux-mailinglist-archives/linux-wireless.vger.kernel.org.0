Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB0EDD71
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 10:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfD2INK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 04:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbfD2INK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 04:13:10 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7A76206BF;
        Mon, 29 Apr 2019 08:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556525589;
        bh=axbGlAGlUhsmRLt32xfxYyJFZMWpJH+5Xd+wng/pJlc=;
        h=From:To:Cc:Subject:Date:From;
        b=Txl15e/I9lRSNqL1Wrp8saQcv0AaBEL6LJDD57MzaSRk4Ypng2DB1Bgn5yEeF3V2T
         iGma5TC+giGsWgBdXPtBgDK8bR1rgOXhrEcNVLiXsHd7rNVsFNSko7MuPD7FT5haFJ
         u2ZkmqWGFFDJTJQfaxTBNuoiCpP5RkwTQfcQDlcc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH v2 0/5] mt76: move common beacon code in mt76 module
Date:   Mon, 29 Apr 2019 10:12:57 +0200
Message-Id: <cover.1556525110.git.lorenzo@kernel.org>
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

Changes since v1:
- added new patch: 'mt76: do not enable/disable pre_tbtt_tasklet in
  scan_start/scan_complete'

Lorenzo Bianconi (5):
  mt76: do not enable/disable pre_tbtt_tasklet in
    scan_start/scan_complete
  mt76: move beacon_int in mt76_dev
  mt76: move beacon_mask in mt76_dev
  mt76: move pre_tbtt_tasklet in mt76_dev
  mt76: mt7603: enable/disable pre_tbtt_tasklet in mt7603_set_channel

 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 ++++
 .../wireless/mediatek/mt76/mt7603/beacon.c    | 19 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7603/core.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/init.c  |  4 ++--
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  6 +++---
 .../net/wireless/mediatek/mt76/mt7603/main.c  | 11 +++++++----
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |  5 -----
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  3 ---
 .../wireless/mediatek/mt76/mt76x02_beacon.c   | 18 +++++++++---------
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 18 +++++++++---------
 .../wireless/mediatek/mt76/mt76x02_usb_core.c | 11 ++++++-----
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  7 +------
 .../wireless/mediatek/mt76/mt76x2/pci_init.c  |  2 +-
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  |  4 ++--
 16 files changed, 57 insertions(+), 61 deletions(-)

-- 
2.20.1

