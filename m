Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F3A645E8F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 17:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiLGQUG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 11:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiLGQUF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 11:20:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296F863B94
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 08:20:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C79C0B8037A
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 16:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D24C433C1;
        Wed,  7 Dec 2022 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670430002;
        bh=EY9icodmuRyxgj/Io4K67F5YkKz8d66LK5A1OX0yYik=;
        h=From:To:Cc:Subject:Date:From;
        b=RIHNek1mez2s4/gfXt685SNsH3QePwuFdOErjo/pxOC8kzxGcKuy8/ZSd0aN/aDqa
         f1UQYotfglQ2YgWBBbNvN8Ne/NLISUg3zqSYe+rtw7y/LIKzxBs0X2g4FQcc0Z4qOe
         HydP7x/hYBm+1ZEEoL0l19rvMlPRzyZ/c5eq0knNAZi9qsuRjlhINRTWpljhM2Y/fU
         VPmv5z50MSp9oqm1K4H0sICVzY8+bLoyPU58fT/kyMl6lfcnKWCyhV6QDSL+OamcWE
         kI+cXgsyczya4+hNuwJpPjceB2Xv34A6QQfFW9lb7ohoaiIuLXcpkO6dCFYrN9nVBG
         4nVYNlkzuMzIw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, frank-w@public-files.de
Subject: [PATCH 0/4] mt76: add per-phy led support
Date:   Wed,  7 Dec 2022 17:19:41 +0100
Message-Id: <cover.1670429694.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series introduces per-phy led capability in order to support
multiple leds connected to a device in dbdc mode (e.g. MT7986 SoC or MT7615)

Lorenzo Bianconi (4):
  wifi: mt76: move leds field in leds struct
  wifi: mt76: move leds struct in mt76_phy
  wifi: mt76: mt7915: enable per-phy led support
  wifi: mt76: mt7615: enable per-phy led support

 drivers/net/wireless/mediatek/mt76/debugfs.c  |   2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |  56 +++++---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  12 +-
 .../net/wireless/mediatek/mt76/mt7603/init.c  |  34 ++---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  85 ++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |  16 ---
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   6 +
 .../wireless/mediatek/mt76/mt7615/pci_init.c  |  62 +--------
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |   1 +
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  35 +++--
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 124 +++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  12 +-
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  14 +-
 13 files changed, 282 insertions(+), 177 deletions(-)

-- 
2.38.1

