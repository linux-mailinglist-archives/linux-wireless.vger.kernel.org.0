Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C803303E0
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Mar 2021 19:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhCGSVL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Mar 2021 13:21:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230507AbhCGSVE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Mar 2021 13:21:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47D8D6513D;
        Sun,  7 Mar 2021 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615141264;
        bh=yicg+PMkkWg6+b9XNs60NMd/nQMN/i/dx2BmcPkPacI=;
        h=From:To:Cc:Subject:Date:From;
        b=IA6qHNK9cILxTHqHKzrNwb6/QEud49ZJBMLJylYD64rsOpOSrKUIQCq/phRCVdvhn
         5R3pq5+I+3jJeCmaO1EvztojrXfvhFjZqXh/mumRXejL1ZdhMqijIG+zpKWHSZ66F2
         3byvkM/mXNBCznh7cxr1HaHcAOP/n0/pIh6FjjDLG/gA23hwDnuQXGuLtGjp99Dja5
         PKj16icE68ihfsYMPQMmnOmGfhWj3b2pAWTD4L3VOBlvNMz9rri7sYYcRH8bOFznmn
         mxvdF0nDuqEONTU8+mwVGhebPQu+oN9DrKjmIoYP6kbeU9lrdgsb42YrQ41wLDNl4H
         42KnbJGy8FQzg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 0/7] mt7921: introduce wifi chip reset support
Date:   Sun,  7 Mar 2021 19:20:44 +0100
Message-Id: <cover.1615140875.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce wifi chip reset support for mt7921 devices in order to recover from
mcu hangs.

Lorenzo Bianconi (7):
  mt76: mt7921: reduce mcu timeouts for suspend, offload and hif_ctrl
    msg
  mt76: introduce mcu_reset function pointer in mt76_mcu_ops structure
  mt76: mt7921: introduce mt7921_run_firmware utility routine.
  mt76: mt7921: introduce __mt7921_start utility routine
  mt76: dma: introduce mt76_dma_queue_reset routine
  mt76: dma: export mt76_dma_rx_cleanup routine
  mt76: mt7921: add wifi reset support

 drivers/net/wireless/mediatek/mt76/dma.c      |  47 ++--
 drivers/net/wireless/mediatek/mt76/mcu.c      |   4 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |   9 +-
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   3 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 201 +++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  35 +--
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  47 ++--
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   6 +-
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |   4 +
 9 files changed, 248 insertions(+), 108 deletions(-)

-- 
2.29.2

