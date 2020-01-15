Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4E913BDD8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 11:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAOK7K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 05:59:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:58552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgAOK7K (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 05:59:10 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B06612187F;
        Wed, 15 Jan 2020 10:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579085949;
        bh=IhUpTntnvaymhS8z5wAdvFGtx2/5/jRcsY/wtcNvX74=;
        h=From:To:Cc:Subject:Date:From;
        b=jqo6BS9edhZANQYtkKYvl+16FUf+7P6LD8zrHbccFVSWjZEPBXasHARwEKnMV7wuI
         7CSBMNMFc6km2bEyANOEUCqW/+AikPKUXTijFXPtWPSJm3n+L6C529ex0LEOa/hASZ
         1tD/wQ9SJmja1g2e1KO3IrTZFsDy4WkuNIWhzeA4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v3 00/18] rework mt76u layer to support new devices
Date:   Wed, 15 Jan 2020 11:58:40 +0100
Message-Id: <cover.1579085367.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rework mt76u layer to support new devices (e.g. 7663u).
The main difference between mt7663u and previous mt76u dongles
(e.g. mt76x2u) is mt7663u reports fw events through a dedicated
mcu hw queue. Moreover, mt7663u relies on full usb 32bit address
space to configure the usb dongle.

Chabges since v2:
- added Co-developed-by tag

Chabges since v1:
- rabase on top of mt76 master branch

Lorenzo Bianconi (18):
  mt76: mt76u: check tx_status_data pointer in mt76u_tx_tasklet
  mt76: mt76u: add mt76u_process_rx_queue utility routine
  mt76: mt76u: add mt76_queue to mt76u_get_next_rx_entry signature
  mt76: mt76u: add mt76_queue to mt76u_refill_rx signature
  mt76: mt76u: use mt76_queue as mt76u_complete_rx context
  mt76: mt76u: add queue id parameter to mt76u_submit_rx_buffers
  mt76: mt76u: move mcu buffer allocation in mt76x02u drivers
  mt76: mt76u: introduce mt76u_free_rx_queue utility routine
  mt76: mt76u: stop/free all possible rx queues
  mt76: mt76u: add mt76u_alloc_rx_queue utility routine
  mt76: mt76u: add queue parameter to mt76u_rx_urb_alloc
  mt76: mt76u: resume all rx queue in mt76u_resume_rx
  mt76: mt76u: introduce mt76u_alloc_mcu_queue utility routine
  mt76: mt76u: add {read/write}_extended utility routines
  mt76: mt76u: take into account different queue mapping for 7663
  mt76: mt76u: introduce mt76u_skb_dma_info routine
  mt76: mt76u: add endpoint to mt76u_bulk_msg signature
  mt76: mt76u: introduce MT_DRV_RX_DMA_HDR flag

 drivers/net/wireless/mediatek/mt76/mt76.h     |  15 +-
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |   8 +-
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |  25 +-
 .../wireless/mediatek/mt76/mt76x02_usb_mcu.c  |   9 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb.c   |   2 +-
 .../wireless/mediatek/mt76/mt76x2/usb_init.c  |   6 +
 drivers/net/wireless/mediatek/mt76/usb.c      | 370 +++++++++++++-----
 7 files changed, 309 insertions(+), 126 deletions(-)

-- 
2.21.1

