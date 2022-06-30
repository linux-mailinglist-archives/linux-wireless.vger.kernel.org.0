Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB488562575
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jun 2022 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbiF3Vlg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jun 2022 17:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiF3Vlf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jun 2022 17:41:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE31C393FB
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jun 2022 14:41:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FE31B82D60
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jun 2022 21:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AFEC34115;
        Thu, 30 Jun 2022 21:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656625292;
        bh=w2M3raxVtJBbuhh4vraaeykw5VJ3XFQZ3AloTBHHJq4=;
        h=From:To:Cc:Subject:Date:From;
        b=NpYpvOdAoPmuDyU+xkBzg28fDKv1ixIxx2jzMnf1W3wyjczd+1QQ8pOZLGmPjmXIh
         Op+JXuONZTFBMO4BBqo9oRPeE6qoZmqcIoZVLguoFcfDcvk5NTyN6ttCQAry5/JsNN
         Sf+rxJtM/ynttJgtCUui3QJ1L59W9ADTlu1E2wJ7FB/GbPnkI9INl/vAovgfEYit7g
         SIIWhNpbflfja4B6RnTayKmi4LU/QJ4rrwR+5unIQ2zwNLPLBFPrCjGLGxWded+k3D
         qSkeRdit3zhBaYHQzSVALkXLvvS7vPX/eh6cTJw8LbSQ9v7ZNj96JSeOchK1ifCyTf
         wh+aZOn/BUdwA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        sean.wang@mediatek.com
Subject: [PATCH 0/5] mt76: add the capability to support more than two phys
Date:   Thu, 30 Jun 2022 23:41:11 +0200
Message-Id: <cover.1656624320.git.lorenzo@kernel.org>
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

