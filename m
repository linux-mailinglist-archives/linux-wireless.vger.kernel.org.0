Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB3E3A8AD1
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 23:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhFOVQa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 17:16:30 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:10563 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhFOVQ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 17:16:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623791663; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=2rvjQ6rET3dEL+36xoKue3CZ7wmAWfyY88c4OdpniRY=; b=NiOf9bQ27M53XT8jN+6W9flBLh8M+E+3HSRs0tZNnt7UxbtEwk5/3pZ58DdMUigEmioAd8xA
 6IXTUWB9LBCLpTIwyKCpQLh7bgYSUWb9WKiH/CPOLHSpFayb65j3k1vhuzq/5Hn1RbqqFsgZ
 +Aqkm1hbfO7ppr3xmBEyfoPNznY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60c9182eed59bf69cc36aa51 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 21:14:22
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 85FB9C43217; Tue, 15 Jun 2021 21:14:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-78-13-nat.elisa-mobile.fi [85.76.78.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2176C433F1;
        Tue, 15 Jun 2021 21:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2176C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 00/12] ath11k: optimizations in data path
Date:   Wed, 16 Jun 2021 00:13:55 +0300
Message-Id: <20210615211407.92233-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset covers optimizations in rx (first 7 patches)
and tx (remaining 5 patches) data path.

Running UDP DL/UL traffic on IPQ8074 5G radio showed an average 5-10%
improvement on a 4 core platform.

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
 drivers/net/wireless/ath/ath11k/dp.c    |  45 +++++--
 drivers/net/wireless/ath/ath11k/dp.h    |   1 +
 drivers/net/wireless/ath/ath11k/dp_rx.c | 205 ++++++++++++++++----------------
 drivers/net/wireless/ath/ath11k/dp_tx.c |  63 +++++-----
 drivers/net/wireless/ath/ath11k/hal.c   |  32 ++++-
 drivers/net/wireless/ath/ath11k/hal.h   |   1 +
 drivers/net/wireless/ath/ath11k/mac.c   |   2 +-
 8 files changed, 202 insertions(+), 149 deletions(-)

-- 
2.25.1

