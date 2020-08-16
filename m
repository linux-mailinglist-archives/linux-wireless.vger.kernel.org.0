Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F8224561F
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Aug 2020 07:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgHPFb6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Aug 2020 01:31:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52995 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730105AbgHPFb5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Aug 2020 01:31:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597555917; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=EFWwWseA5xQGpFgtCtYtdiEyssDJT/Ko0ZwPOqis0rE=; b=lTs/cfYw6/4ldH/mojFTt+Ym+sS0f+SYsugI9uSdUickF8EQfAvlARw/VkpCccfEYr2mQG38
 HtntMgFa7CqBdVzxC9SDa7VwxBHe6FhbpqBcMcQiOD8NUfIzfOcOB/0pCUAbCFlQW8vTONXl
 JX94olkAh5aLTZRKbxsjb7gqLYA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f38c4b985672017517495f1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 16 Aug 2020 05:31:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4C1B8C433C6; Sun, 16 Aug 2020 05:31:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C1D6CC433C6;
        Sun, 16 Aug 2020 05:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1D6CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/9] ath11k: last patches for QCA6390 support
Date:   Sun, 16 Aug 2020 08:31:22 +0300
Message-Id: <1597555891-26112-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Here interrupt and ring configuration changes, and some smaller stuff,
are done to get QCA6390 working.

This is the last patchset adding initial QCA6390 support. Now it's
possible to associate to an AP and ping with an QCA6390 device.

This patchset depends on the patchset:

ath11k: CE and HAL support for QCA6390

Kalle

Carl Huang (9):
  ath11k: enable DP interrupt setup for QCA6390
  ath11k: don't initialize rxdma1 related ring
  ath11k: setup QCA6390 rings for both rxdmas
  ath11k: refine the phy_id check in ath11k_reg_chan_list_event
  ath11k: delay vdev_start for QCA6390
  ath11k: assign correct search flag and type for QCA6390
  ath11k: process both lmac rings for QCA6390
  ath11k: use TCL_DATA_RING_0 for QCA6390
  ath11k: reset MHI during power down and power up

 drivers/net/wireless/ath/ath11k/core.c  |  14 +-
 drivers/net/wireless/ath/ath11k/core.h  |   7 +
 drivers/net/wireless/ath/ath11k/debug.c |  41 ++++--
 drivers/net/wireless/ath/ath11k/dp.c    | 189 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/dp.h    |   7 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c | 208 +++++++++++++++++++-------
 drivers/net/wireless/ath/ath11k/dp_tx.c |  65 +++++---
 drivers/net/wireless/ath/ath11k/hw.c    |  68 +++++++++
 drivers/net/wireless/ath/ath11k/hw.h    |  40 ++++-
 drivers/net/wireless/ath/ath11k/mac.c   |  66 ++++++++-
 drivers/net/wireless/ath/ath11k/mhi.c   |  46 +++++-
 drivers/net/wireless/ath/ath11k/mhi.h   |  11 ++
 drivers/net/wireless/ath/ath11k/pci.c   | 254 +++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/pci.h   |  17 +++
 drivers/net/wireless/ath/ath11k/wmi.c   |   7 +-
 15 files changed, 907 insertions(+), 133 deletions(-)

-- 
2.7.4

