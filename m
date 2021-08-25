Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C59F3F71FD
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Aug 2021 11:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbhHYJjl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Aug 2021 05:39:41 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:29903 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239640AbhHYJjc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Aug 2021 05:39:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629884327; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=hfIggJzWOJSfgAa8fE1YMGiYCif8u9049esE/unfi9c=; b=KGq1WbzIhKYnahxGeT2naqw3CUinsz+eGH/r1M1V6ZzleQQGEblomR35Rqoo7gmxipav0HWc
 KT4JCJ/PoD869oymiZrZ7IvyqyQdchjU2Q6pv+gRXxqhfVLojF5BPfBTicI8mFZhgUtdmuEl
 kvg81DUXvG9oXFhetX8pqnfsKGs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61260f9a4cd90150372c0a53 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Aug 2021 09:38:34
 GMT
Sender: ppranees=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 603C9C43616; Wed, 25 Aug 2021 09:38:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ppranees)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30A09C4338F;
        Wed, 25 Aug 2021 09:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 30A09C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   P Praneesh <ppranees@codeaurora.org>
To:     kvalo@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>
Subject: [PATCH v2 00/12] ath11k: optimizations in data path
Date:   Wed, 25 Aug 2021 15:07:45 +0530
Message-Id: <1629884277-18759-1-git-send-email-ppranees@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset covers optimizations in rx (first 7 patches)
and tx (remaining 5 patches) data path.

Running UDP DL/UL traffic on IPQ8074 5G radio showed an average 5-10%
improvement on a 4 core platform
---
v2:
        - Addressed internal developer reported segfault and avoid lookup twice
	  by utilizing idr_remove (patch 12/12 and patch 2/12).
---
P Praneesh (12):
  ath11k: disable unused CE8 interrupts for ipq8074
  ath11k: allocate dst ring descriptors from cacheable memory
  ath11k: modify dp_rx desc access wrapper calls inline
  ath11k: avoid additional access to ath11k_hal_srng_dst_num_free
  ath11k: avoid active pdev check for each msdu
  ath11k: remove usage quota while processing rx packets
  ath11k: add branch predictors in process_rx
  ath11k: allocate HAL_WBM2SW_RELEASE ring from cacheable memory
  ath11k: remove mod operator in dst ring processing
  ath11k: avoid while loop in ring selection of tx completion interrupt
  ath11k: add branch predictors in dp_tx path
  ath11k: avoid unnecessary lock contention in tx_completion path

 drivers/net/wireless/ath/ath11k/ce.c    |   2 +-
 drivers/net/wireless/ath/ath11k/core.c  |   5 +
 drivers/net/wireless/ath/ath11k/dp.c    |  48 ++++++--
 drivers/net/wireless/ath/ath11k/dp.h    |   1 +
 drivers/net/wireless/ath/ath11k/dp_rx.c | 205 ++++++++++++++++----------------
 drivers/net/wireless/ath/ath11k/dp_tx.c |  76 ++++++------
 drivers/net/wireless/ath/ath11k/hal.c   |  35 +++++-
 drivers/net/wireless/ath/ath11k/hal.h   |   1 +
 drivers/net/wireless/ath/ath11k/hw.h    |   1 +
 drivers/net/wireless/ath/ath11k/mac.c   |   2 +-
 10 files changed, 219 insertions(+), 157 deletions(-)

-- 
2.7.4

