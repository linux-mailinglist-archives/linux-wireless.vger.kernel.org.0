Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E31EA52A3
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2019 11:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbfIBJWl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Sep 2019 05:22:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60314 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbfIBJWk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Sep 2019 05:22:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 89F3B60264; Mon,  2 Sep 2019 09:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567416159;
        bh=Iv4eOvYHtTloypDJ7hVQSISV8i4783SmON8jpHeGegs=;
        h=From:To:Cc:Subject:Date:From;
        b=W94qtX/Z31mGv4JJFW6SNoZXQTloh45QXUEMFc9BR54yzD7u5paS62WNJxAacO+TN
         IWnXRau/6/Lchhc2IoYxCc4YBQLpE3NhxskbHiGhf1iQ+e2CxMMYJ6yWS13TFpNV+u
         eukKpb1wWElDCYwDTZyobS0xDlrR9cZHoLhilUVA=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38EF6602EF;
        Mon,  2 Sep 2019 09:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567416159;
        bh=Iv4eOvYHtTloypDJ7hVQSISV8i4783SmON8jpHeGegs=;
        h=From:To:Cc:Subject:Date:From;
        b=W94qtX/Z31mGv4JJFW6SNoZXQTloh45QXUEMFc9BR54yzD7u5paS62WNJxAacO+TN
         IWnXRau/6/Lchhc2IoYxCc4YBQLpE3NhxskbHiGhf1iQ+e2CxMMYJ6yWS13TFpNV+u
         eukKpb1wWElDCYwDTZyobS0xDlrR9cZHoLhilUVA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38EF6602EF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v4 0/8] ath10k: improve throughout of tcp/udp TX/RX of sdio
Date:   Mon,  2 Sep 2019 17:22:18 +0800
Message-Id: <1567416146-14403-1-git-send-email-wgong@codeaurora.org>
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
v3: change some code style
split fix incorrect skb tail of rx bundle to patch "adjust skb length in ath10k_sdio_mbox_rx_packet"
v4: add err handle in ath10k_sdio_mbox_rx_fetch_bundle

Nicolas Boichat (1):
  ath10k: adjust skb length in ath10k_sdio_mbox_rx_packet
v2: no this patch
v3: new added
v4: change commit log

Wen Gong (6):
  ath10k: change max RX bundle size from 8 to 32 for sdio
v2: change macro HTC_GET_BUNDLE_COUNT
v3: change some code style
v4: add macro ATH10K_HTC_FLAG_BUNDLE_MASK

  ath10k: add workqueue for RX path of sdio
v2: no change
v3: change some code style
v4: no change

  ath10k: disable TX complete indication of htt for sdio
v2: change some code style
v3: change some code style
v4: no change

  ath10k: add htt TX bundle for sdio
v2: no change
v3: change some code style
v4: no change

  ath10k: enable alt data of TX path for sdio
v2: no change
v3: change some code style
v4: add macro ATH10K_HTC_MSG_READY_EXT_ALT_DATA_MASK

  ath10k: enable napi on RX path for sdio
v2: no change
v3: change some code style
v4: change some code style

 drivers/net/wireless/ath/ath10k/core.c   |  42 +++-
 drivers/net/wireless/ath/ath10k/core.h   |   4 +-
 drivers/net/wireless/ath/ath10k/hif.h    |   9 +
 drivers/net/wireless/ath/ath10k/htc.c    | 377 ++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath10k/htc.h    |  49 +++-
 drivers/net/wireless/ath/ath10k/htt.c    |  15 ++
 drivers/net/wireless/ath/ath10k/htt.h    |  20 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c |  80 ++++++-
 drivers/net/wireless/ath/ath10k/htt_tx.c |  38 +++-
 drivers/net/wireless/ath/ath10k/hw.h     |   2 +-
 drivers/net/wireless/ath/ath10k/sdio.c   | 281 ++++++++++++++++++++---
 drivers/net/wireless/ath/ath10k/sdio.h   |  31 ++-
 12 files changed, 851 insertions(+), 97 deletions(-)

-- 
1.9.1

