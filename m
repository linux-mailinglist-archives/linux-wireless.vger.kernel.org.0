Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72F4F1307DF
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2020 13:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgAEMWQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Jan 2020 07:22:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgAEMWQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Jan 2020 07:22:16 -0500
Received: from new-host-5.station (net-2-42-61-77.cust.vodafonedsl.it [2.42.61.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37B69215A4;
        Sun,  5 Jan 2020 12:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578226935;
        bh=bj65Xq3zG/8v/h88wahq5RUzi7MbsqTOqK5eSK15pqc=;
        h=From:To:Cc:Subject:Date:From;
        b=l8ImGn75Yv03oa7h5cOHm/4v9to6EEvc4xQRKwWRnQ7CsmHwWVCv2Hzn3ie7iEoLA
         a4kz9MthaCKgHlwyg7NJzmhF5s8tQGg1omOKhuuNNrOq/X80Be442btZqZQvVQnogZ
         rWBIiQlD1wbbqs1ltFH8VPl1V0/hT+jG0SkKFCAE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v2 00/18] rework mt76u layer to support new devices
Date:   Sun,  5 Jan 2020 13:21:38 +0100
Message-Id: <cover.1578226544.git.lorenzo@kernel.org>
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

