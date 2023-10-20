Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9547C7D0D25
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 12:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376720AbjJTKbY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Oct 2023 06:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376854AbjJTKbW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Oct 2023 06:31:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3952D69
        for <linux-wireless@vger.kernel.org>; Fri, 20 Oct 2023 03:31:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4398DC433C8;
        Fri, 20 Oct 2023 10:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697797880;
        bh=QG0eqApJv057ZhUcrZWheMwZD0XE0lTlkrDwaucJpqk=;
        h=From:To:Cc:Subject:Date:From;
        b=doOaSRLpZMJzggL6jVoa8LczUhdPDxKgghOhWEAAEQ6N9cIx+6JPLuagVPdgniFDf
         Mv2ROcU+avVJQyrW+SFw2zv7hT7Y+XWH9iR6QHi1SE1flpQsiMcjDXuEaEVxTepaAY
         v195HEop5kBSf6Y6JpZaOLZn2IDmMmoEtLwTkLQ8tKlwMQIjXaa6rMzDO9P3OHNBOm
         p3v/MyaPS3N/B2IM0jLnEnUSCe47WBtAKQbC8E0gJx36AcfPkvGqMwB+Q5dMCFROsn
         9Ap2HGu2T8x+zGMVfKjwqK5ApijAfdpy1RZesDg+LYDDKnIYciTmWh11nrXUu55+Bl
         oh2UJC1WjV95A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 00/13] wifi: mt7996: add wed support
Date:   Fri, 20 Oct 2023 12:30:47 +0200
Message-ID: <cover.1697797422.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to MT7915, introduce Wireless Ethernet Dispatcher (WED)
support for MT7996 driver to offload transmitted/received traffic.

Changes since v2:
- fix compilation errors if wed is not enabled
- add RRO garbage collector patch to the series

Changes since v1:
- add wed reset support
- unmap rro buffer on module unload
- check ind reason to check if the rx buffer must be discarded

Bo Jiao (1):
  wifi: mt76: mt7996: add wed rx support

Lorenzo Bianconi (11):
  wifi: mt76: mmio: move mt76_mmio_wed_{init,release}_rx_buf in common
    code
  wifi: mt76: move mt76_mmio_wed_offload_{enable,disable} in common code
  wifi: mt76: move mt76_net_setup_tc in common code
  wifi: mt76: introduce mt76_queue_is_wed_tx_free utility routine
  wifi: mt76: introduce wed pointer in mt76_queue
  wifi: mt76: increase MT_QFLAG_WED_TYPE size
  wifi: mt76: dma: introduce __mt76_dma_queue_reset utility routine
  wifi: mt76: mt7996: use u16 for val field in mt7996_mcu_set_rro
    signature
  mt76: move wed reset common code in mt76 module
  mt76: mt7996: add wed reset support
  wifi: mt76: mt7996: add wed rro delete session garbage collector

Sujuan Chen (1):
  wifi: mt76: mt7996: add wed tx support

 drivers/net/wireless/mediatek/mt76/dma.c      | 246 +++++++++++-----
 drivers/net/wireless/mediatek/mt76/dma.h      |  52 ++++
 drivers/net/wireless/mediatek/mt76/mac80211.c |  19 +-
 drivers/net/wireless/mediatek/mt76/mmio.c     | 105 +++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  96 +++++-
 .../net/wireless/mediatek/mt76/mt7603/dma.c   |   9 +-
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |   6 +-
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   3 +-
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |   5 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   1 +
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |   5 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  46 +--
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  16 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 116 +-------
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/dma.c   | 276 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 256 +++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 122 +++++++-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  42 +++
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 115 +++++++-
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  37 +++
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  | 245 ++++++++++++++--
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  79 ++++-
 .../net/wireless/mediatek/mt76/mt7996/pci.c   |  61 ++--
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  78 ++++-
 26 files changed, 1695 insertions(+), 345 deletions(-)

-- 
2.41.0

