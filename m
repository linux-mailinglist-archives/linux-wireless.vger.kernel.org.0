Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4344102895
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 16:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfKSPsC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 10:48:02 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:43682 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfKSPsC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 10:48:02 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id C1511580063;
        Tue, 19 Nov 2019 16:48:00 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v6 0/5] mt76: channel switch support for USB devices
Date:   Tue, 19 Nov 2019 16:47:41 +0100
Message-Id: <20191119154746.20821-1-markus.theil@tu-ilmenau.de>
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

Therefore the first four patches speed up beacon copying and the last
patch enables channel switch support also for usb interfaces.

v6:
* use min_t in mt76u_copy
* use round_up in mt76u_copy
* use additional copy for mmio beacon set again

v5 (thanks to Stanislaw):
* ommit empty mt76x2u_channel_switch_beacon
* copy txwi into beacon skb

v4:
* use multiple of 4 len for usb copy again

v3:
* fixed checkpatch errors

v2 (thanks for the comments Lorenzo):
* correctly track beacon data mask
* clean-ups
* make channel switch fn static (reported by kbuild test robot)

Markus Theil (5):
  mt76: mt76x02: ommit beacon slot clearing
  mt76: mt76x02: split beaconing
  mt76: mt76x02: remove a copy call for usb speedup
  mt76: speed up usb bulk copy
  mt76: mt76x02: add channel switch support for usb interfaces

 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 .../wireless/mediatek/mt76/mt76x02_beacon.c   | 72 ++++++++-----------
 .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  1 +
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  5 ++
 .../wireless/mediatek/mt76/mt76x02_usb_core.c | 12 ++++
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
 drivers/net/wireless/mediatek/mt76/usb.c      | 24 +++++--
 7 files changed, 69 insertions(+), 49 deletions(-)

-- 
2.24.0

