Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15B3564226
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Jul 2022 20:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiGBSrd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Jul 2022 14:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGBSrd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Jul 2022 14:47:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03723DF5D
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jul 2022 11:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90B3960FF2
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jul 2022 18:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B07C34114;
        Sat,  2 Jul 2022 18:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656787652;
        bh=FtmPh/JHRGigspHJbPwNOmV8Cxlph/fh4cFZqF+1s2A=;
        h=From:To:Cc:Subject:Date:From;
        b=C+8Sq1OW/1pEGSP9A0Xj9OQIS0hOg06QMr2Go4UzTIrRhFOw7yn7z1kqEk3Mk6Dui
         28RIbT74oF5pntt7n6a9RZGZh+M5xTn0J4s5H2b8xpPj0vmhq9LW40bDdZgKGaNdCc
         Yy0Kj5WQ51uR09zrjczpG0dGGbDldT1wvNs5GjqlX08M3FRr69/pr2udv+gfMKziv0
         O09FSweOyc0uvALn7c9bJLHEAeE0f0bVxCyMv+hzHq72lRs2rGU1YRepoNc/u5pQux
         GhitVlL4MQtTRz59SKW56iiLTDp+urNubEP+srn8wPZEpMQBKMN4jYQB+B/k6gao03
         ERzX1yaKkIuJg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        bo.jiao@mediatek.com
Subject: [PATCH v2 0/5] mt76: add the capability to support more than two phys
Date:   Sat,  2 Jul 2022 20:47:19 +0200
Message-Id: <cover.1656787439.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce the capability to support more than two mt76_phys.
This is a preliminary series to add mt7990 support.

Changes since v1:
- added Bo's SoB

Lorenzo Bianconi (5):
  mt76: add phy_idx in mt76_rx_status
  mt76: introduce phys array in mt76_dev structure
  mt76: add phy_idx to mt76_wcid
  mt76: convert MT_TX_HW_QUEUE_EXT_PHY to MT_TX_HW_QUEUE_PHY
  mt76: get rid of mt76_wcid_hw routine

 drivers/net/wireless/mediatek/mt76/dma.c      |  9 ++-
 drivers/net/wireless/mediatek/mt76/mac80211.c | 27 ++++----
 drivers/net/wireless/mediatek/mt76/mt76.h     | 67 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 44 ++++++------
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 32 +++++----
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   | 15 +++--
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 12 ++--
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 23 ++++---
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 25 +++----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  4 +-
 drivers/net/wireless/mediatek/mt76/testmode.c |  5 +-
 drivers/net/wireless/mediatek/mt76/tx.c       | 48 +++++++------
 18 files changed, 174 insertions(+), 157 deletions(-)

-- 
2.36.1

