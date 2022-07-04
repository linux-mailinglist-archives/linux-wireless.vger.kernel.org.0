Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392C5564E1F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 09:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiGDHCu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 03:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiGDHCt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 03:02:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7895F42
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 00:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F666B80B1F
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 07:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B69C3411E;
        Mon,  4 Jul 2022 07:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656918165;
        bh=cA1b97YCfL7QRpib+F4TuHSrXtGTGcJXduCuPO7lpSI=;
        h=From:To:Cc:Subject:Date:From;
        b=u5FG8sLfRDVqRxO+9JHtmF6y39TFfOoNvN5zL38Zhm5xAGmGlJFEO8ZIuIwxjDrSL
         LfmhesHBrud0lCyj4yG/ULo0LJiOV+hMJ8txKRMeVk1ygL0LJHkYME5iFrt/6Q/l9c
         V9K9+fxTe0QCwPSxlSQXjAnzRexu5T+KR2KYg2Qhr2MyMfYQsdpV/NSOg0Bzxx/Qlg
         /kd1XfDpSTTbMa3+0QfhpPZZZZSddDfE6FJdkMjy+Ali920ZFeRh/K/kyepGrK4A5F
         d/j5BFCfR5fhaNEcXn7ifZ6u7SSg52HxQYJEhVHexmfkUROJWle5EL2nQc5udEO1gd
         ScBzQAni/wULg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        bo.jiao@mediatek.com
Subject: [PATCH v3 0/5] mt76: add the capability to support more than two phys
Date:   Mon,  4 Jul 2022 09:02:18 +0200
Message-Id: <cover.1656917976.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes since v2:
- rebase on top of mt76 master
- fix an issue in mt76_dma_cleanup

Changes since v1:
- added Bo's SoB

Lorenzo Bianconi (5):
  mt76: add phy_idx in mt76_rx_status
  mt76: introduce phys array in mt76_dev structure
  mt76: add phy_idx to mt76_wcid
  mt76: convert MT_TX_HW_QUEUE_EXT_PHY to MT_TX_HW_QUEUE_PHY
  mt76: get rid of mt76_wcid_hw routine

 drivers/net/wireless/mediatek/mt76/dma.c      | 13 ++--
 drivers/net/wireless/mediatek/mt76/mac80211.c | 27 ++++----
 drivers/net/wireless/mediatek/mt76/mt76.h     | 68 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 44 ++++++------
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 32 ++++-----
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   | 15 ++--
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 12 ++--
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 23 ++++---
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 25 +++----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  4 +-
 drivers/net/wireless/mediatek/mt76/testmode.c |  5 +-
 drivers/net/wireless/mediatek/mt76/tx.c       | 51 ++++++++------
 18 files changed, 181 insertions(+), 158 deletions(-)

-- 
2.36.1

