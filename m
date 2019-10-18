Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC2EDBE46
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 09:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504604AbfJRH2X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 03:28:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49206 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbfJRH2X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 03:28:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B600360265; Fri, 18 Oct 2019 07:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571383702;
        bh=ozyRCRj8gSIWs3v8F2NQ5Y9Vjt3xopcZa1rQk6KxJL0=;
        h=From:To:Cc:Subject:Date:From;
        b=fYeJlwPstbH6n+QNkKn9TOBNWtaXZfBdYSZgh9/HQXwRcrW5i68DJ7Q59WGa0gUHe
         wywcnvks9v3vjlq1K/dhOb6AdbJ8C2JWiR16xI69J9j+t8pc15r+nc+/oZ3VqsbXeE
         J6E7u0GfQQ7fAJ7q1vhiCZyvuk1PDqcg3yG+b8uI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8880460588;
        Fri, 18 Oct 2019 07:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571383702;
        bh=ozyRCRj8gSIWs3v8F2NQ5Y9Vjt3xopcZa1rQk6KxJL0=;
        h=From:To:Cc:Subject:Date:From;
        b=fYeJlwPstbH6n+QNkKn9TOBNWtaXZfBdYSZgh9/HQXwRcrW5i68DJ7Q59WGa0gUHe
         wywcnvks9v3vjlq1K/dhOb6AdbJ8C2JWiR16xI69J9j+t8pc15r+nc+/oZ3VqsbXeE
         J6E7u0GfQQ7fAJ7q1vhiCZyvuk1PDqcg3yG+b8uI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8880460588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v7 0/3] ath10k: improve throughout of TX of sdio
Date:   Fri, 18 Oct 2019 15:27:47 +0800
Message-Id: <20191018072750.10372-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v7: change a few code style to meet ath10k-check script

v6: remove module parameters disable_tx_comp and alt_data
this is 3 patches of the 7 patches from ath10k: improve throughout of tcp/udp TX/RX of sdio

v5: change ath10k_htc_setup_tx_req to add check bundle_tx
to forbidden init 2 times

v4: add macro ATH10K_HTC_MSG_READY_EXT_ALT_DATA_MASK

v3: change some code style

v2: change some code style

The bottleneck of throughout on sdio chip is the bus bandwidth, to the
patches are all to increase the use ratio of sdio bus.

These patches only affect sdio bus chip, explanation is mentioned in each
patch's commit log.

Wen Gong (3):
  ath10k: disable TX complete indication of htt for sdio
  ath10k: add htt TX bundle for sdio
  ath10k: enable alt data of TX path for sdio

 drivers/net/wireless/ath/ath10k/core.c   |  27 +-
 drivers/net/wireless/ath/ath10k/core.h   |   4 +-
 drivers/net/wireless/ath/ath10k/hif.h    |   9 +
 drivers/net/wireless/ath/ath10k/htc.c    | 373 +++++++++++++++++++++--
 drivers/net/wireless/ath/ath10k/htc.h    |  38 ++-
 drivers/net/wireless/ath/ath10k/htt.c    |  13 +
 drivers/net/wireless/ath/ath10k/htt.h    |  17 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c |  35 ++-
 drivers/net/wireless/ath/ath10k/htt_tx.c |  38 ++-
 drivers/net/wireless/ath/ath10k/hw.h     |   2 +-
 drivers/net/wireless/ath/ath10k/sdio.c   |  23 ++
 drivers/net/wireless/ath/ath10k/sdio.h   |   2 +-
 12 files changed, 528 insertions(+), 53 deletions(-)

-- 
2.23.0

