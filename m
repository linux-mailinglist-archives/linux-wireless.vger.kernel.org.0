Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35BD729271
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 10:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbjFIIP5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 04:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbjFIIP4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 04:15:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B40E211C
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 01:15:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9045B60C00
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 08:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0921C433EF;
        Fri,  9 Jun 2023 08:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298554;
        bh=iMtJHKvAppMt2J4p534O3CqKGH9UPUWtWEXP+S1dywQ=;
        h=From:To:Cc:Subject:Date:From;
        b=UOyO7Xyr6hRegNJzbnNGpn8wuT/P1GgqMCIqrqiAklQxhzqwE+YbBFFOvjcytbUU9
         CP6qFqBYeB98PwLk6kYLHj1ohZVXb8U7C/vy/cds+6uStR4seK55mucqoJcMRZE1QF
         92pCZS26n/NwA8FCZ3R62W18/g+Y+DuyHbdSeK/Ku7qPnSKUtPWYgmNuk1H+I/XWVf
         B7VJRk/wCA6o0E0iGE2LE/uC3N5cigZHPXiL2eImGxwxmIIJmCR+/x8m8GLY6v5gQH
         /Z8onvTub/WxdsgAMZ0oLVC4hV+hq6bjFsF+u+Ir0txvmTXqHzlE1rYqAIDgn8oKEB
         9+YdPxV2tij5w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH v2 00/15] mt76: introduce connac3_mac support
Date:   Fri,  9 Jun 2023 10:15:29 +0200
Message-Id: <cover.1686298162.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce connac3_mac in mt76_connac library to reuse mac code shared
between WiFi7 chipsets.
Move the following common mac fields in mt76_struct/mt76_wcid:
- sta_poll_list
- sta_poll_lock
- poll_list
- ampdu_state

Move the following routines in mt76-connac lib since they are shared
between mt7915 and mt7921:
- mt76_connac2_tx_check_aggr
- mt76_connac2_txwi_free
- mt76_connac2_tx_token_put

Changes since v1:
- rebase on top wireless-next tree
- fix connac3_mac library
- fix compilation warnings

Lorenzo Bianconi (15):
  wifi: mt76: mt7915: move sta_poll_list and sta_poll_lock in mt76_dev
  wifi: mt76: mt7603: rely on shared sta_poll_list and sta_poll_lock
  wifi: mt76: mt7615: rely on shared sta_poll_list and sta_poll_lock
  wifi: mt76: mt7996: rely on shared sta_poll_list and sta_poll_lock
  wifi: mt76: mt7921: rely on shared sta_poll_list and sta_poll_lock
  wifi: mt76: mt7915: move poll_list in mt76_wcid
  wifi: mt76: mt7603: rely on shared poll_list field
  wifi: mt76: mt7615: rely on shared poll_list field
  wifi: mt76: mt7996: rely on shared poll_list field
  wifi: mt76: mt7921: rely on shared poll_list field
  wifi: mt76: move ampdu_state in mt76_wcid
  mt76: connac: move more mt7921/mt7915 mac shared code in connac lib
  wifi: mt76: move rate info in mt76_vif
  wifi: mt76: connac: move connac3 definitions in mt76_connac3_mac.h
  wifi: mt76: connac: add connac3 mac library

 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |   2 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |   9 +
 .../net/wireless/mediatek/mt76/mt7603/init.c  |   2 -
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  22 +-
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  20 +-
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |   4 -
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   2 -
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  31 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  20 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   4 -
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  24 +
 .../wireless/mediatek/mt76/mt76_connac3_mac.c | 742 ++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac3_mac.h | 343 ++++++++
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  82 ++
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 140 +--
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  30 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   5 -
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   2 -
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 104 +--
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  26 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   9 -
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |   2 +-
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |  16 +-
 .../net/wireless/mediatek/mt76/mt7996/init.c  |   6 +-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 803 +-----------------
 .../net/wireless/mediatek/mt76/mt7996/mac.h   | 315 +------
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  42 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  11 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  36 +-
 31 files changed, 1403 insertions(+), 1457 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h

-- 
2.40.1

