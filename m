Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFE727E712
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 12:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgI3KvV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 06:51:21 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:14816 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgI3KvT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 06:51:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601463079; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=XwNd7iFvkBPGlYsC7OvRL5d0o8JDXyPA27fiAHy890s=; b=VnFNHL/FACT3eMUWiOyTL3HvzVMEat055qtvzgGzF9oz7hbbjMhUE1LxhQUz7D9Dd6OQ0S2v
 OTngMB2MaEbhJG7i3n/fFYAjqBXtiW6ykazt1IvctmyQflfpe/X+DpXikV4Zytrd1mLGhQRS
 DNnFMAkRASh9hVSXPVJAAP9j2WI=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f74632697ca3ed0fb0a0bf4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Sep 2020 10:51:18
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C6E55C433CA; Wed, 30 Sep 2020 10:51:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B64EC433F1;
        Wed, 30 Sep 2020 10:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B64EC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/5] ath11k: qca6390: packet log support and fixes for crashes
Date:   Wed, 30 Sep 2020 13:51:08 +0300
Message-Id: <1601463073-12106-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Packet log support for QCA6390 is important as otherwise the data connection
will stall. Also some important fixes.

Depends on patchset: ath11k: qca6390: smaller new features and fixes

Carl Huang (4):
  ath11k: add packet log support for QCA6390
  ath11k: pci: fix rmmod crash
  ath11k: fix warning caused by lockdep_assert_held
  ath11k: debugfs: fix crash during rmmod

Wen Gong (1):
  ath11k: mac: remove unused conf_mutex to solve a deadlock

 drivers/net/wireless/ath/ath11k/core.h    |   3 +
 drivers/net/wireless/ath/ath11k/debugfs.c |   8 +--
 drivers/net/wireless/ath/ath11k/dp.c      |   2 +
 drivers/net/wireless/ath/ath11k/dp.h      |   3 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c   | 108 ++++++++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/dp_tx.c   |  81 +++++++++++++++-------
 drivers/net/wireless/ath/ath11k/hal.c     |   2 +
 drivers/net/wireless/ath/ath11k/hal_rx.c  |   4 +-
 drivers/net/wireless/ath/ath11k/hal_rx.h  |   2 +-
 drivers/net/wireless/ath/ath11k/mac.c     |  35 +++++++---
 drivers/net/wireless/ath/ath11k/pci.c     |   9 ++-
 11 files changed, 186 insertions(+), 71 deletions(-)

-- 
2.7.4

