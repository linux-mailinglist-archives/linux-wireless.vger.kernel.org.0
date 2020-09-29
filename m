Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED1627D43B
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 19:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgI2RPq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 13:15:46 -0400
Received: from z5.mailgun.us ([104.130.96.5]:42360 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgI2RPq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 13:15:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601399745; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=oknWmVJp4p2cGt5TEyctlj1tfrz8/K2DZCUpJyvZqkY=; b=pYJfQ/g7FCri16SnRUyVgIRHebAha3oihLTQdhQ1DffFAu4NA25VDspsd9Ea4U76SsCr7mZp
 NslWUqomsej+yepgrr2URgd+ufYee7gJH3s4vrSoSFe57GBeRdBW/fAqZVxH95E2oNkHWaOR
 2Ay/8M3WJv1th80F2Z6hbD7mtig=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f736bbdbe59ebabf3a4275a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Sep 2020 17:15:41
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 97199C433F1; Tue, 29 Sep 2020 17:15:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37327C433C8;
        Tue, 29 Sep 2020 17:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37327C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/8] ath11k: qca6390: smaller new features and fixes
Date:   Tue, 29 Sep 2020 20:15:28 +0300
Message-Id: <1601399736-3210-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Few new features to improve QCA6390 PCI support and some bugfixes.

Ben Greear (1):
  ath11k: support loading ELF board files

Carl Huang (1):
  ath11k: fix AP mode for QCA6390

Govind Singh (1):
  ath11k: Use GFP_ATOMIC instead of GFP_KERNEL in idr_alloc

Kalle Valo (3):
  ath11k: add interface_modes to hw_params
  ath11k: pci: check TCSR_SOC_HW_VERSION
  ath11k: disable monitor mode on QCA6390

Wen Gong (2):
  ath11k: change to disable softirqs for ath11k_regd_update to solve
    deadlock
  ath11k: Use GFP_ATOMIC instead of GFP_KERNEL in
    ath11k_dp_htt_get_ppdu_desc

 drivers/net/wireless/ath/ath11k/core.c  |  14 ++++
 drivers/net/wireless/ath/ath11k/dp.c    |   3 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c |  30 ++++-----
 drivers/net/wireless/ath/ath11k/dp_rx.h |   6 +-
 drivers/net/wireless/ath/ath11k/hw.h    |   3 +
 drivers/net/wireless/ath/ath11k/mac.c   | 115 ++++++++++++++++++++------------
 drivers/net/wireless/ath/ath11k/pci.c   |  46 +++++++++----
 drivers/net/wireless/ath/ath11k/qmi.c   |  12 +++-
 drivers/net/wireless/ath/ath11k/reg.c   |   6 +-
 9 files changed, 156 insertions(+), 79 deletions(-)

-- 
2.7.4

