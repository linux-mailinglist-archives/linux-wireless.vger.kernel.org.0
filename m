Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6E465A9E4
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jan 2023 13:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjAAMAL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Jan 2023 07:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjAAMAK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Jan 2023 07:00:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFDD26E6
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 04:00:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7379B60D2D
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 12:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792E2C433F1;
        Sun,  1 Jan 2023 12:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672574407;
        bh=/jBwC7VhNI4ketIg8jxLThU+CNDJN4x1V1iWqTZTqnQ=;
        h=From:To:Cc:Subject:Date:From;
        b=vCuRBU5GozWKWr1XFSGcqNx6o+5RO8D6dFR99HLzqPhkssH03Zm14Z5gU6YTnH+aa
         SYbLlSMhRL+2KHEtCZoV7W0qRHGx9weQXsT1GogzEnrwzE34GJ8O/RtVcqoNLk10jp
         bpcu+ZpLgKXQKWzoNSDp8oedSo7w9kZbBadvhH/FsH9G7Y+gnYVIlM2MCJ9IaMBAzk
         /2GHfHjGpu1jhahSZbFdaAHBYeNP3fqs6yvdp64zDT0dkdYR/L/M5Du65LfmlD0cRF
         e3qeSbWNSt4KXa0Es06JdtRMW1hs7+/+IrRA1/qle/1PfMDtsCTSH0dPmB0hP3sD9U
         qxYYmwZPH1W8A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 0/3] mt76: switch to page_pool allocator
Date:   Sun,  1 Jan 2023 12:59:56 +0100
Message-Id: <cover.1672574310.git.lorenzo@kernel.org>
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

In order to reduce possible memory allocation failures due to memory
fragmentation caused by page_frag_cache allocator, switch to page_pool
allocator for dma and usb mt76 drivers.
Remove per rx-queue page_frag_cache

Lorenzo Bianconi (3):
  wifi: mt76: switch to page_pool allocator
  wifi: mt76: dma: keep rx pages DMA mapped
  wifi: mt76: enable page_pool stats

 drivers/net/wireless/mediatek/mt76/Kconfig    |  2 +
 drivers/net/wireless/mediatek/mt76/dma.c      | 83 ++++++++++---------
 drivers/net/wireless/mediatek/mt76/mac80211.c | 57 +++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     | 24 +++++-
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 26 +++---
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 21 ++---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 31 ++++++-
 drivers/net/wireless/mediatek/mt76/usb.c      | 42 +++++-----
 8 files changed, 198 insertions(+), 88 deletions(-)

-- 
2.38.1

