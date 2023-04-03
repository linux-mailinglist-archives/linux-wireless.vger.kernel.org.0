Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67A56D421D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 12:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjDCKeO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 06:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjDCKeK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 06:34:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07F83C34
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 03:34:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39656B81106
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 10:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A2CC433EF;
        Mon,  3 Apr 2023 10:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680518045;
        bh=Uh1Rj6GBCAC9YMQp6uFUteoeHyWQSEOLJwLoHSpqhwE=;
        h=From:To:Cc:Subject:Date:From;
        b=X505lx7KXuJUwyJZS1Z92KQBHl+mqid5IDHZ8YMIkLVznWVKeOjFN8G1y7hv9kXF/
         IeAaBkReI0EJCtxRuieoX1TsoqE4AwHbGxOhTLsDbKqUkTw3tYZcabddAGCLf4Rs0M
         POIC3ei9wDcKudZGrlbVlLOq3cHzcKXmom9As3SfDc62RWpwUp2tjnUcIACFwXI2kT
         Uhp5chpx2q1YUBuSCiKqWz19zjvjka8H4wiFul9yBQti47eR58oMV5Vl9jIHA9jvac
         hJHg5IFmrqQEeLQsoLPUycaOvudQQ7TgP9l3GcoCqgvzfWEEI56NgNASdpHQAw+cqd
         fv370FkBEkVcQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/6] mt76: remove some duplicated code
Date:   Mon,  3 Apr 2023 12:33:54 +0200
Message-Id: <cover.1680517676.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of some unused code and move shared one in mt76_connac module.

Lorenzo Bianconi (6):
  wifi: mt76: move irq_tasklet in mt76_dev struct
  wifi: mt76: add mt76_connac_irq_enable utility routine
  wifi: mt76: get rid of unused sta_ps callbacks
  wifi: mt76: add mt76_connac_gen_ppe_thresh utility routine
  wifi: mt76: mt7921: get rid of eeprom.h
  wifi: mt76: move shared mac definitions in mt76_connac2_mac.h

 drivers/net/wireless/mediatek/mt76/mac80211.c |  3 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  5 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  5 --
 .../net/wireless/mediatek/mt76/mt7615/mac.h   | 12 -----
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  | 11 ++--
 .../wireless/mediatek/mt76/mt7615/mt7615.h    | 10 ----
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  2 +-
 .../wireless/mediatek/mt76/mt7615/pci_init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |  1 -
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  1 -
 .../net/wireless/mediatek/mt76/mt76_connac.h  | 21 ++++++++
 .../wireless/mediatek/mt76/mt76_connac2_mac.h | 22 ++++++++
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 21 ++++++++
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 25 +--------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  6 +--
 .../net/wireless/mediatek/mt76/mt7915/mac.h   | 33 +-----------
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  7 ++-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +-
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  1 -
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 10 ++--
 .../wireless/mediatek/mt76/mt7921/eeprom.h    | 30 -----------
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 18 ++++---
 .../net/wireless/mediatek/mt76/mt7921/mac.h   | 53 -------------------
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 23 +-------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  3 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 20 +++----
 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 24 ++++-----
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  3 +-
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c  |  2 +-
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  3 +-
 .../wireless/mediatek/mt76/mt7921/usb_mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 25 +--------
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  6 +--
 .../net/wireless/mediatek/mt76/mt7996/mac.h   | 12 -----
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |  7 ++-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  4 +-
 40 files changed, 139 insertions(+), 306 deletions(-)
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mac.h

-- 
2.39.2

