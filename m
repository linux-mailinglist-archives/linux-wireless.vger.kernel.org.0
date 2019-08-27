Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1FD89E667
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 13:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfH0LDA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 07:03:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51548 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbfH0LDA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 07:03:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3E21D61D6B; Tue, 27 Aug 2019 11:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566903779;
        bh=LpEBqMTTYl3m6DImrwzQAPL4eEOspM6cbI3I/sdfpkY=;
        h=From:To:Cc:Subject:Date:From;
        b=KBNhSRlLlLOxyG6DNLC67Urg0GKs2/sGgdfq8L3cEeRqZULwqiCcwoeE2ewBvuPiL
         ADEzCr9eqVT35CyK+7wJL/V1K7e1P2Xj4N4f3aaQ5u6RsYCPRm3OLfVMCQAbUrrMbE
         z9i2+cO4UFa1jjY9CgOqnIObCA6plzUY1YV6QopY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A2A561C22;
        Tue, 27 Aug 2019 11:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566903735;
        bh=LpEBqMTTYl3m6DImrwzQAPL4eEOspM6cbI3I/sdfpkY=;
        h=From:To:Cc:Subject:Date:From;
        b=nEmn1DpZg7CmPbTHzaIRC969T/sfajpxYlTtKQNL48bdDI8Xnxx4zPv2VPy9BWBzT
         Ix3DTdXx1GHJKhra6fQv4OwM6lgwn8I2flTAyYv5yI2jh/rBMpdeKCdAlU7Melajx1
         erdgVz7yheaRZuHKgnGX3+bY3so/Xf31ETOTw/i4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A2A561C22
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 0/7] ath10k: improve throughout of tcp/udp TX/RX of sdio
Date:   Tue, 27 Aug 2019 19:01:40 +0800
Message-Id: <1566903707-27536-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The bottleneck of throughout on sdio chip is the bus bandwidth, to the
patches are all to increase the use ratio of sdio bus.

                      udp-rx    udp-tx    tcp-rx    tcp-tx
without patches(Mbps)  320        180       170       151
with patches(Mbps)     450        410       400       320

These patches only affect sdio bus chip, explanation is mentioned in each
patch's commit log.

Alagu Sankar (1):
  ath10k: enable RX bundle receive for sdio
v2: fix incorrect skb tail of rx bundle in ath10k_sdio_mbox_rx_process_packet

Wen Gong (6):
  ath10k: change max RX bundle size from 8 to 32 for sdio
v2: change macro HTC_GET_BUNDLE_COUNT

  ath10k: add workqueue for RX path of sdio
  ath10k: disable TX complete indication of htt for sdio
v2: change some code style

  ath10k: add htt TX bundle for sdio
  ath10k: enable alt data of TX path for sdio
  ath10k: enable napi on RX path for sdio

 drivers/net/wireless/ath/ath10k/core.c   |  36 ++-
 drivers/net/wireless/ath/ath10k/core.h   |   4 +-
 drivers/net/wireless/ath/ath10k/hif.h    |   9 +
 drivers/net/wireless/ath/ath10k/htc.c    | 374 ++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath10k/htc.h    |  41 +++-
 drivers/net/wireless/ath/ath10k/htt.c    |  15 ++
 drivers/net/wireless/ath/ath10k/htt.h    |  20 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c |  82 ++++++-
 drivers/net/wireless/ath/ath10k/htt_tx.c |  37 ++-
 drivers/net/wireless/ath/ath10k/hw.h     |   2 +-
 drivers/net/wireless/ath/ath10k/sdio.c   | 292 +++++++++++++++++++++---
 drivers/net/wireless/ath/ath10k/sdio.h   |  31 ++-
 12 files changed, 850 insertions(+), 93 deletions(-)

-- 
1.9.1

