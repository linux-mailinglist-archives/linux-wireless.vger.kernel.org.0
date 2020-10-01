Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2049427FC86
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 11:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbgJAJfF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 05:35:05 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:21984 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731758AbgJAJfC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 05:35:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601544902; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=q5D4qParmyOlNKlW6xcxvv8uiGJKjG4FuJlcgyzqtHA=; b=hdMjMsCVKuG1PwSYBb0jx7IAdMIUR2DrhzkxX6mKn06kdUvo5rIkltzqMbLIk2fwOAnFqXb/
 l+eeyzL4YM54iRsQ7e6EZpf14WSEJrBCDcJ3sHA6XRgWGObtv6/VUaDEB+GMkDzy6gWtx7nA
 gXm4yRzqb1rfnl1kFga645qkaRk=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f75a2bf7df1a00ff88ce8d7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 09:34:55
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B3738C433F1; Thu,  1 Oct 2020 09:34:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 77B8BC433CA;
        Thu,  1 Oct 2020 09:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77B8BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/8] ath11k: enable shadow register for QCA6390
Date:   Thu,  1 Oct 2020 12:34:42 +0300
Message-Id: <1601544890-13450-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable the shadow register feature for QCA6390, so that it can enter idle power
save mode. Shadow registers can be accessed regardless target's power state,
and hardware will forward the value to target register automatically.

Also implement a workaround to fix a shadow register deficit.

This depends on patchset: ath11k: qca6390: packet log support and fixes for crashes

Kalle

Carl Huang (7):
  ath11k: read and write registers below unwindowed address
  ath11k: enable shadow register configuration and access
  ath11k: set WMI pipe credit to 1 for QCA6390
  ath11k: start a timer to update TCL HP
  ath11k: start a timer to update REO cmd ring
  ath11k: start a timer to update HP for CE pipe 4
  ath11k: enable idle power save mode

Kalle Valo (1):
  ath11k: remove unnecessary casts to u32

 drivers/net/wireless/ath/ath11k/ce.c     |  80 ++++++++++++++++++
 drivers/net/wireless/ath/ath11k/ce.h     |   3 +
 drivers/net/wireless/ath/ath11k/core.c   |   7 ++
 drivers/net/wireless/ath/ath11k/dp.c     |  97 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/dp.h     |  24 ++++++
 drivers/net/wireless/ath/ath11k/dp_tx.c  |   2 +
 drivers/net/wireless/ath/ath11k/hal.c    | 135 +++++++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/hal.h    |  19 ++++-
 drivers/net/wireless/ath/ath11k/hal_rx.c |   2 +
 drivers/net/wireless/ath/ath11k/htc.c    |   6 ++
 drivers/net/wireless/ath/ath11k/hw.h     |   2 +
 drivers/net/wireless/ath/ath11k/mac.c    |   9 +++
 drivers/net/wireless/ath/ath11k/pci.c    |  38 +++++++++
 drivers/net/wireless/ath/ath11k/pci.h    |   7 ++
 drivers/net/wireless/ath/ath11k/qmi.c    |  13 ++-
 drivers/net/wireless/ath/ath11k/qmi.h    |   2 +-
 16 files changed, 434 insertions(+), 12 deletions(-)

-- 
2.7.4

