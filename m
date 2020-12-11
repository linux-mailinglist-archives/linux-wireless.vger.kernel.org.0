Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002B42D7D05
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 18:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395328AbgLKRhP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 12:37:15 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:35367 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395366AbgLKRgr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 12:36:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607708182; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=VelmzjqLTbhyNIdAI4LsuWemDxokFW108iLsQDzeVD4=; b=APQUB4F28oro4zzGCfvN973XSd30f4HofD/EoRluN3Dp7SDmuN4GzWF2OGx+3zY5KIjEPKMp
 iVo8uctDc94GnJBb66RXkBH+wUJNXVFLHKBj92rekT02/NhRm5aBuYArdrO/xk3T5HgF3aL9
 P9xueujkFvzJOBgoWE6bWVjKHbU=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fd3adfbf81e894c557376b8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 17:35:55
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 27E3EC433ED; Fri, 11 Dec 2020 17:35:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B8EEDC433CA;
        Fri, 11 Dec 2020 17:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8EEDC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 00/10] ath11k: suspend support for QCA6390 PCI
Date:   Fri, 11 Dec 2020 19:35:40 +0200
Message-Id: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Here is suspend support for QCA6390 PCI devices. For suspend we switch firmware
to WoW mode and keep the firmware running. At the moment we are not able to
shutdown and fully power off the device due to bugs in MHI subsystem, so WoW
mode is a workaround for the time being.

This patchset depends on patchset:

ath11k: QCA6390 stability fixes
https://patchwork.kernel.org/project/linux-wireless/list/?series=399797

Please review.

Kalle

Carl Huang (9):
  ath11k: mhi: hook suspend and resume
  ath11k: hif: implement suspend and resume functions
  ath11k: pci: read select_window register to ensure write is finished
  ath11k: htc: implement suspend handling
  ath11k: dp: stop rx pktlog before suspend
  ath11k: set credit_update flag for flow controlled ep only
  ath11k: implement WoW enable and wakeup commands
  ath11k: hif: add ce irq enable and disable functions
  ath11k: implement suspend for QCA6390 PCI devices

Kalle Valo (1):
  ath11k: htc: remove unused struct ath11k_htc_ops

 drivers/net/wireless/ath/ath11k/Makefile |   3 +-
 drivers/net/wireless/ath/ath11k/ce.c     |   2 +-
 drivers/net/wireless/ath/ath11k/ce.h     |   2 +
 drivers/net/wireless/ath/ath11k/core.c   |  88 +++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h   |  11 +++
 drivers/net/wireless/ath/ath11k/dp.c     |   2 +-
 drivers/net/wireless/ath/ath11k/dp.h     |   2 +
 drivers/net/wireless/ath/ath11k/dp_rx.c  |  48 +++++++++
 drivers/net/wireless/ath/ath11k/dp_rx.h  |   3 +
 drivers/net/wireless/ath/ath11k/hif.h    |  32 ++++++
 drivers/net/wireless/ath/ath11k/htc.c    |  31 +++++-
 drivers/net/wireless/ath/ath11k/htc.h    |  10 +-
 drivers/net/wireless/ath/ath11k/hw.h     |   1 +
 drivers/net/wireless/ath/ath11k/mac.c    |   4 +
 drivers/net/wireless/ath/ath11k/mhi.c    |  11 +++
 drivers/net/wireless/ath/ath11k/mhi.h    |   3 +
 drivers/net/wireless/ath/ath11k/pci.c    |  71 ++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.c    |  99 +++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h    | 165 +++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wow.c    |  73 ++++++++++++++
 drivers/net/wireless/ath/ath11k/wow.h    |  10 ++
 21 files changed, 656 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/wow.c
 create mode 100644 drivers/net/wireless/ath/ath11k/wow.h

-- 
2.7.4

