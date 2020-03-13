Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 787F61842B7
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 09:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgCMIc4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Mar 2020 04:32:56 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:62649 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726545AbgCMIc4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Mar 2020 04:32:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584088375; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=lDDP0fSoCWyBVdzP8FTmEEK9qz5Vx3wfY71/vDaicZ8=; b=c0gfCNAobn8CSa2E/UvACJbtUShQ7miHOXaFR/TVtZxCiqOaEMFTdhYn5p+1Xz43Canarc4V
 q1my5rLnFG2r1mNOhXBDO3Zrb4xxvUtPd9jYochFMDzUGhy4oYH+0z919lcAzV6Gs0rmZOZj
 9Ptn0jj0l6oNS7n5oG6IYEONg18=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6b4523.7fddb4f7d570-smtp-out-n05;
 Fri, 13 Mar 2020 08:32:35 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B1E1BC432C2; Fri, 13 Mar 2020 08:32:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mpubbise)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EED37C433CB;
        Fri, 13 Mar 2020 08:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EED37C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mpubbise@codeaurora.org
From:   Manikanta Pubbisetty <mpubbise@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>
Subject: [PATCH v2 0/2] ath11k: offload PN verification to the HW
Date:   Fri, 13 Mar 2020 14:02:21 +0530
Message-Id: <1584088343-3584-1-git-send-email-mpubbise@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series enables PN validation in the HW thereby
reducing CPU cycles spent in the host CPU. It also is the
basis for other performance improvement patches that follow
this series.

TSC (TKIP sequence counter) validation is also offloaded.

Hardware validates PN/TSC only for unicast packets;
for group addressed packets, PN validation is done
in mac80211.

v2:
        - fixed kbuild test robot warnings

Manikanta Pubbisetty (2):
  ath11k: handle RX fragments
  ath11k: enable PN offload

 drivers/net/wireless/ath/ath11k/Kconfig   |   1 +
 drivers/net/wireless/ath/ath11k/core.h    |   2 +
 drivers/net/wireless/ath/ath11k/dp.c      |  12 +-
 drivers/net/wireless/ath/ath11k/dp.h      |  12 +
 drivers/net/wireless/ath/ath11k/dp_rx.c   | 870 ++++++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/dp_rx.h   |   8 +-
 drivers/net/wireless/ath/ath11k/hal.h     |   2 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c  |  14 +-
 drivers/net/wireless/ath/ath11k/mac.c     |  41 +-
 drivers/net/wireless/ath/ath11k/peer.h    |   7 +
 drivers/net/wireless/ath/ath11k/rx_desc.h |   2 +-
 11 files changed, 865 insertions(+), 106 deletions(-)

-- 
2.7.4
