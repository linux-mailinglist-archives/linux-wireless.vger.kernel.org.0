Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B8F37ABCB
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 18:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhEKQX7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 12:23:59 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:23522 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhEKQX6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 12:23:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620750171; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=pvdXb0Z9rl4Ey2Nv8OCmHtrir+Q7GYlwpCW7ZGD2TtU=; b=Lnv6YKABQqaRCxDQJaRf6A+11yj9LVAm8a+dtI4r6Q8w/mCrC8G5JsO1Xt8ctfRh0rtMvqnQ
 U5plvHqIWfZsv/FRrNy4tNo6LjKvW5M/rBWqg92kGRf0vAqxAwG83tN2G2lRcjlT319mBrKX
 /OQh7EcBprHVRlu3BlSm8RplnO8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 609aaf5aaaabe992f2ea756d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 May 2021 16:22:50
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1731AC433D3; Tue, 11 May 2021 16:22:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-96-12-nat.elisa-mobile.fi [85.76.96.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FCDCC4338A;
        Tue, 11 May 2021 16:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FCDCC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 0/7] ath11k: add support for WCN6855
Date:   Tue, 11 May 2021 19:22:07 +0300
Message-Id: <20210511162214.29475-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset adds supports for WCN6855. WCN6855 is a PCI based
DBS device. It is very similar to QCA6390 overall but with below
differences:
 -WCN6855 has different registers, so new regs are
  defined and attached in hw params.
 -WCN6855 has different rx descriptor, so new descriptors
  are created and in addition, new hw ops are added.
 -REO configuration is also different for this target, so
  separate reo handling is added in hw ops.
 -WCN6855 does not have clock drift problem which is found
  on QCA6390, thus no need to configure some related registers.

Baochen Qiang (7):
  ath11k: add hw reg support for WCN6855
  ath11k: add dp support for WCN6855
  ath11k: setup REO for WCN6855
  ath11k: setup WBM_IDLE_LINK ring once again
  ath11k: add support to get peer id for WCN6855
  ath11k: add support for WCN6855
  ath11k: don't call ath11k_pci_set_l1ss for WCN6855

 drivers/net/wireless/ath/ath11k/core.c    |  44 +++
 drivers/net/wireless/ath/ath11k/core.h    |   1 +
 drivers/net/wireless/ath/ath11k/dp.c      |  16 +-
 drivers/net/wireless/ath/ath11k/hal.c     |  10 +
 drivers/net/wireless/ath/ath11k/hal.h     |   3 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c  |  41 +--
 drivers/net/wireless/ath/ath11k/hal_rx.h  |   8 +
 drivers/net/wireless/ath/ath11k/hw.c      | 391 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h      |   5 +
 drivers/net/wireless/ath/ath11k/mhi.c     |   1 +
 drivers/net/wireless/ath/ath11k/pci.c     |  45 ++-
 drivers/net/wireless/ath/ath11k/rx_desc.h |  87 +++++
 12 files changed, 586 insertions(+), 66 deletions(-)

-- 
2.25.1

