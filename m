Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED0771480F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 May 2023 12:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjE2Kle (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 May 2023 06:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjE2Kle (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 May 2023 06:41:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E04FC7
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 03:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01A7062353
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 10:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13008C433D2;
        Mon, 29 May 2023 10:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685356891;
        bh=LdVG3yr5zpRu3bzXSLdYoQ3AA/P9Tzu54/yXwKIWxD0=;
        h=From:To:Cc:Subject:Date:From;
        b=pCIMugNt57BDFF03e9/lweBb7xVV1doni2U7hqGzIo5rijw0hC46YBO9NeHa6Hkp4
         +3cROYy96ClRdDuJlP9a9QrH+YJgsvG4eVFQJyEGfO3P5N2Ltu+Xsehd1OdDHVTqRH
         NKB690exkevaUuNWPf/zaVUqfnWAB7HOwdKL8DUE2Dn5CbRmTbaHzkuLTXHZf9TCgp
         GGHZLake2mioL0covCFMlv8d+qHJXSgvRNDOkDz9QR9aiBbP/DQblYz3mzMZpqPZv0
         2SHLa7+6bulMFwIfOYf6nWNemvAXIEQLHtGfLuXiEb3LN4jdsBq2340XffzbZOZLyb
         Hkc0GuUGfNwKg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 00/13] move some common mac fields in shared code
Date:   Mon, 29 May 2023 12:40:51 +0200
Message-Id: <cover.1685356673.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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

Lorenzo Bianconi (13):
  wifi: mt76: mt7921: make mt7921_mac_sta_poll static
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

 drivers/net/wireless/mediatek/mt76/mac80211.c |   2 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |   6 +
 .../net/wireless/mediatek/mt76/mt7603/init.c  |   2 -
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  22 +--
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  20 +--
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |   4 -
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   2 -
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  27 ++--
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  20 +--
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   4 -
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   5 +
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  82 ++++++++++
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 140 ++++--------------
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  30 ++--
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   5 -
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   2 -
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 104 ++++---------
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  26 ++--
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  10 --
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |   2 +-
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |  16 +-
 .../net/wireless/mediatek/mt76/mt7996/init.c  |   2 -
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  52 +++----
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  30 ++--
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |   4 -
 26 files changed, 268 insertions(+), 355 deletions(-)

-- 
2.40.1

