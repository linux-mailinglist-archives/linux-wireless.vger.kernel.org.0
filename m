Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C39AE10A629
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 22:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKZVrU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 16:47:20 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:46382 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfKZVrT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 16:47:19 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id DB56F580074;
        Tue, 26 Nov 2019 22:47:16 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v9 0/6] mt76: channel switch support for USB devices
Date:   Tue, 26 Nov 2019 22:46:58 +0100
Message-Id: <20191126214704.27297-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series adds channel switch support for mt76 usb interfaces.
When testing, I noticed that between 5 or 7 consecutive beacons had the
identical channel switch count set. After some debugging I found out,
that beacon copying over usb took far too long (up to 700ms for one call
of mt76x02u_pre_tbtt_work).

Therefore the first five patches speed up beacon copying and provide beaconing
fixes. The last patch enables channel switch support also for usb interfaces.

Thanks to Stanislaw, Lorenzo and Felix for their help.

v9:
* use beacon_data_count instead of beacon_data_mask
* add missing txwi copy again
* move csa_check for usb under beacon iteration (send beacons and no ps frames
  in case of finished csa)

v8:
* fix mbss beaconing
* fix adding vifs with idx 8
* fix memory leaks by dropping beacon buffer
* permanently enable 7 additional bss to save another usb call and make
  beacon masking easier
* added beacon_prepare call again, which now also clears beacon_data_mask

v7:
* fix mbss beacon settings (incorrect try)
* fix compilation with latest upstream

v6:
* use min_t in mt76u_copy
* use round_up in mt76u_copy
* use additional copy for mmio beacon set again

v5:
* ommit empty mt76x2u_channel_switch_beacon
* copy txwi into beacon skb

v4:
* use multiple of 4 len for usb copy again

v3:
* fixed checkpatch errors

v2:
* correctly track beacon data mask
* clean-ups
* make channel switch fn static (reported by kbuild test robot)

Markus Theil (6):
  mt76: mt76x02: ommit beacon slot clearing
  mt76: mt76x02: split beaconing
  mt76: mt76x02: add check for invalid vif idx
  mt76: mt76x02: remove a copy call for usb speedup
  mt76: speed up usb bulk copy
  mt76: mt76x02: add channel switch support for usb interfaces

 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  3 +-
 .../wireless/mediatek/mt76/mt76x02_beacon.c   | 97 +++++++------------
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  2 +
 .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  5 +-
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  4 +
 .../wireless/mediatek/mt76/mt76x02_usb_core.c | 22 +++--
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  6 +-
 drivers/net/wireless/mediatek/mt76/usb.c      | 24 +++--
 9 files changed, 85 insertions(+), 80 deletions(-)

-- 
2.24.0

