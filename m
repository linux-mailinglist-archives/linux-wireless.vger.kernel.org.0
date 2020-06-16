Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6897F1FB33C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 16:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgFPOBa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 10:01:30 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:44251 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729215AbgFPOB2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 10:01:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592316088; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=IurHvV+xIe2+LXqyWE1Bs5v4f3iu8pS8kQ6yGxstKdo=; b=uP8h87TSO2As+5YphnJVEJEjoFHjgXAD0DwoOgFuTYtf/rlXsWnd2wYFkUYt7Mw9F7Z6cJod
 ZCBcMohUwpMLHzn3dHv8Vd0rrFHrEbDHN4uQnGGaserXNLvCx0fvXDN9CrqyuDI2oCF9VGMB
 VM7oMfPu2qo4u0RiAcBealfuWNM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5ee8d09ffe1db4db8915545d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 14:01:03
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 009EDC433B2; Tue, 16 Jun 2020 14:01:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 13904C43395;
        Tue, 16 Jun 2020 14:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13904C43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 00/12] preparation for IPQ6018 support
Date:   Tue, 16 Jun 2020 17:00:43 +0300
Message-Id: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Here are some preparation patches for IPQ6018. Some of the patches are from
Anil's patchset "ath11k: Add IPQ6018 support" which I modifies and I did some
refactoring and cleanup on top.

All patches are compile tested only.

Anilkumar Kolli (5):
  ath11k: ahb: call ath11k_core_init() before irq configuration
  ath11k: convert ath11k_hw_params to an array
  ath11k: define max_radios in hw_params
  ath11k: add hw_ops for pdev id to hw_mac mapping
  ath11k: Add bdf-addr in hw_params

Kalle Valo (7):
  ath11k: create a common function to request all firmware files
  ath11k: don't use defines for hw specific firmware directories
  ath11k: change ath11k_core_fetch_board_data_api_n() to use
    ath11k_core_create_firmware_path()
  ath11k: remove useless info messages
  ath11k: qmi: cleanup info messages
  ath11k: don't use defines in hw_params
  ath11k: remove define ATH11K_QMI_DEFAULT_CAL_FILE_NAME

 drivers/net/wireless/ath/ath11k/Makefile   |   3 +-
 drivers/net/wireless/ath/ath11k/ahb.c      |  23 +++---
 drivers/net/wireless/ath/ath11k/core.c     | 115 ++++++++++++++++-------------
 drivers/net/wireless/ath/ath11k/core.h     |  12 ++-
 drivers/net/wireless/ath/ath11k/dp_rx.c    |   2 +-
 drivers/net/wireless/ath/ath11k/htc.c      |   2 +-
 drivers/net/wireless/ath/ath11k/hw.c       |  34 +++++++++
 drivers/net/wireless/ath/ath11k/hw.h       |  28 +++++--
 drivers/net/wireless/ath/ath11k/mac.c      |  10 +--
 drivers/net/wireless/ath/ath11k/peer.c     |   3 -
 drivers/net/wireless/ath/ath11k/qmi.c      |  22 ++----
 drivers/net/wireless/ath/ath11k/qmi.h      |   2 -
 drivers/net/wireless/ath/ath11k/reg.c      |   2 +-
 drivers/net/wireless/ath/ath11k/spectral.c |   8 +-
 drivers/net/wireless/ath/ath11k/wmi.c      |   4 +-
 15 files changed, 163 insertions(+), 107 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/hw.c

-- 
2.7.4

