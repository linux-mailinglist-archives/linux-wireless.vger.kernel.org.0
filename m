Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8764866DF88
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 14:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjAQNx6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 08:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjAQNxe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 08:53:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8629B7ABC
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 05:53:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29F6961423
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 13:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA3EC433EF;
        Tue, 17 Jan 2023 13:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673963612;
        bh=0+CxYhzVx568rCB17Tt45fY0Sjg6BCaISlh34w4/UKw=;
        h=From:To:Cc:Subject:Date:From;
        b=pRzOLuhZmXtFIE5s6ovP7d4+R3T8zvvJHZTi7CoEk64cmDRPuvlfjxLF/2tMiNpPs
         WwT9eid9d3gS0o8tevUIxjLxIjYHM8mZY4N00aFx503ALK2D1gqWNvqIorQF0FmaaO
         SmuR46XIFN4toq3H4mO28gSmksVJPhb47jQl/MunVUoNa/jtY4lbsN/eXDp68gUk0h
         fmIYWDdeZ6D/PzWeK6/miv6tbCkYwM8lNwoMjKxcImzpusMVi77LdlWuyxRYLoNMBJ
         CV+eICia2OQNzBTfybw2Tk5U6aQ6BoOvTQpjtbf/fni4RZcxnz7PIKXAaVV+xKcqkk
         1+vcr1WNXnhfA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v2 0/4] mt76: switch to page_pool allocator
Date:   Tue, 17 Jan 2023 14:53:13 +0100
Message-Id: <cover.1673963374.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
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

In order to reduce possible memory allocation failures due to memory
fragmentation caused by page_frag_cache allocator, switch to page_pool
allocator for dma and usb mt76 drivers.
Remove per rx-queue page_frag_cache

Changes since v1:
- rebase on top of mt76 tree

Lorenzo Bianconi (4):
  wifi: mt76: mt7915: fix memory leak in mt7915_mmio_wed_init_rx_buf
  wifi: mt76: switch to page_pool allocator
  wifi: mt76: dma: keep rx pages DMA mapped
  wifi: mt76: enable page_pool stats

 drivers/net/wireless/mediatek/mt76/Kconfig    |  2 +
 drivers/net/wireless/mediatek/mt76/dma.c      | 83 ++++++++++---------
 drivers/net/wireless/mediatek/mt76/mac80211.c | 57 +++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     | 24 +++++-
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 26 +++---
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 30 +++----
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 31 ++++++-
 drivers/net/wireless/mediatek/mt76/usb.c      | 42 +++++-----
 8 files changed, 206 insertions(+), 89 deletions(-)

-- 
2.39.0

