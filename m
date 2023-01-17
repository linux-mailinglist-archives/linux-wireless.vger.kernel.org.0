Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5C266DFD1
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 15:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjAQODK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 09:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjAQODI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 09:03:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E6D38EAB
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 06:03:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2BB6B81601
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 14:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A24C433EF;
        Tue, 17 Jan 2023 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673964185;
        bh=7sfnBHs9ZDFKQ/3eha9mgMw6zaXCmmAEjglCDGzq9kw=;
        h=From:To:Cc:Subject:Date:From;
        b=QpzgD0OToXkbnuDktzlJcBeyHcVBHP/8oiVkhWWqV3vuJe503a8Hr4DVU3FtgGeWF
         Z1UJ0ykoXHShauJk0lBp0owsjAaJoQGXtfqcWWtc4iOynA26wmO9BioalwUn2IYams
         n9eAlnIkJ+w9Ezmjv7lLVTMhcQqF19AJhmWOeGD96k5trcWt3OtF3Z2zsVg6j9SEjR
         ohK8Jm+n6d1GR4nE5sB6W+tMrD21YMO7L1Sy3B/u14hJfyVWX8LXqVZf4/rHGTLE7W
         6JkZbOj+j2j3d1pzHxv7GHoEVm1KJ0WycH1E1GyXbxi0FTLs9ANmhaEtlJYpepFWLW
         yzUcqPoKXZcjw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sujuan.chen@mediatek.com
Subject: [PATCH v2 0/4] mt76: add wed reset callbacks
Date:   Tue, 17 Jan 2023 15:02:52 +0100
Message-Id: <cover.1673963962.git.lorenzo@kernel.org>
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

Introduce Wireless Ethernet Dispatcher reset callbacks in order to complete
reset requested by ethernet NIC.

This series is based on the following mtk_eth_soc series:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/log/
This series is based on the following mt76 series:
https://lore.kernel.org/linux-wireless/cover.1673963374.git.lorenzo@kernel.org/T/#mc93e54dc09bb6ee00855645f88b85928e9a4c371

Changes since v1:
- rebase on top of mt76 tree.

Lorenzo Bianconi (2):
  wifi: mt76: mt7915: add mt7915 wed reset callbacks
  wifi: mt76: mt7915: complete wed reset support

Sujuan Chen (2):
  wifi: mt76: dma: add reset to mt76_dma_wed_setup signature
  wifi: mt76: dma: reset wed queues in mt76_dma_rx_reset

 drivers/net/wireless/mediatek/mt76/dma.c      | 27 +++++++----
 drivers/net/wireless/mediatek/mt76/dma.h      |  1 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |  3 ++
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 45 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  6 +++
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 40 +++++++++++++++++
 6 files changed, 109 insertions(+), 13 deletions(-)

-- 
2.39.0

