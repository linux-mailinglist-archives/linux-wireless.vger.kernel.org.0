Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF5BBDAA6
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2019 11:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbfIYJLv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 05:11:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54532 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732047AbfIYJK5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 05:10:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F3D036115A; Wed, 25 Sep 2019 09:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569402648;
        bh=5PJK+SEQ8N7jhb0SG9vi+nd3Gvu/oOJKz/borfItxDc=;
        h=From:To:Cc:Subject:Date:From;
        b=WaRGVGrWhfX5m1fPlqLhRxGRJOtyGua/5CEfxRHYLSpB2l8UAtCx+XevH47NUDD2F
         byjBDCU8q3n5H5vSpwGZSkvWkdlCcY3GOLYPHFC5uhq+OYybURTHws11cZ9BqavDyP
         mKZu2yo/RK/GSo5gkZ17fzE+UY+SuTX3gMH5yuhI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D61336115A;
        Wed, 25 Sep 2019 09:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569402647;
        bh=5PJK+SEQ8N7jhb0SG9vi+nd3Gvu/oOJKz/borfItxDc=;
        h=From:To:Cc:Subject:Date:From;
        b=Mgr4SvT+R3yHsS8BEepSaYWfLLpSowRJkN58Osz5lhIbbfKfbr0dnAC8sweoPqz8p
         KyHZ9kBqvGVMqZLjq7ewZkmgU0LaDeIAOvoKUA8txVrtKKhhPjM7LbDFzN+AXi7P2D
         jCePmHumHrgj0Ln6QBN28IWWeQZXsghGPHhq7Y0o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D61336115A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v6 0/3] ath10k: improve throughout of RX of sdio
Date:   Wed, 25 Sep 2019 17:10:36 +0800
Message-Id: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v6: change code style, change commit log to add test value of RX, use sk_buff_head to replace the rx queue
this is 3 patches of the 7 patches from ath10k: improve throughout of tcp/udp TX/RX of sdio

v5: no change

v4: add err handle in ath10k_sdio_mbox_rx_fetch_bundle, change commit log

v3: change some code style
split fix incorrect skb tail of rx bundle to patch "adjust skb length in ath10k_sdio_mbox_rx_packet"

v2: fix incorrect skb tail of rx bundle in ath10k_sdio_mbox_rx_process_packet, change macro HTC_GET_BUNDLE_COUNT

The bottleneck of throughout on sdio chip is the bus bandwidth, to the
patches are all to increase the use ratio of sdio bus.

These patches only affect sdio bus chip, explanation is mentioned in each
patch's commit log.

Alagu Sankar (1):
  ath10k: enable RX bundle receive for sdio

Wen Gong (2):
  ath10k: change max RX bundle size from 8 to 32 for sdio
  ath10k: add workqueue for RX path of sdio

 drivers/net/wireless/ath/ath10k/htc.h  |  12 ++-
 drivers/net/wireless/ath/ath10k/sdio.c | 147 +++++++++++++++++++++++----------
 drivers/net/wireless/ath/ath10k/sdio.h |  26 +++++-
 3 files changed, 134 insertions(+), 51 deletions(-)

-- 
1.9.1

