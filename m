Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9992B2D5CFA
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Dec 2020 15:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389958AbgLJOGO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Dec 2020 09:06:14 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:28639 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389956AbgLJOGA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Dec 2020 09:06:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607609137; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=QiSyXneoo/CIXwCPKWQSgNvC6NPWRqvUJmIt/js5FlY=; b=vpEbbabQgyqFsJYu70/lXNkDDdOY1omcTgV7qqkuetE6DSFdpKZpk4I2L2RnEsfRO8KRukPV
 zAwYj8EHwM+TFoSOcPE2Vh17R/W5H/NfU/lMfyEqMSdrpHL5QxNq1QQPkKnXH05Xht/W26Tf
 BbmBEJPtRNimxnSAKpKoFuJqSPM=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5fd22b2953d7c5ba60215e37 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 10 Dec 2020 14:05:29
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 71D86C43462; Thu, 10 Dec 2020 14:05:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB152C433CA;
        Thu, 10 Dec 2020 14:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB152C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/6] ath11k: QCA6390 stability fixes
Date:   Thu, 10 Dec 2020 16:05:18 +0200
Message-Id: <1607609124-17250-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Few fixes to improve statibility on QCA6390. Please review.

Kalle

Carl Huang (4):
  ath11k: put hw to DBS using WMI_PDEV_SET_HW_MODE_CMDID
  ath11k: pci: fix hot reset stability issues
  ath11k: pci: fix L1ss clock unstable problem
  ath11k: pci: disable VDD4BLOW

Kalle Valo (1):
  ath11k: mhi: print a warning if firmware crashed

Pradeep Kumar Chitrapu (1):
  ath11k: Fix incorrect tlvs in scan start command

 drivers/net/wireless/ath/ath11k/core.c |  12 ++-
 drivers/net/wireless/ath/ath11k/hw.h   |   6 --
 drivers/net/wireless/ath/ath11k/mhi.c  |   9 +++
 drivers/net/wireless/ath/ath11k/pci.c  | 132 +++++++++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/pci.h  |  24 ++++++
 drivers/net/wireless/ath/ath11k/wmi.c  |  69 +++++++++--------
 drivers/net/wireless/ath/ath11k/wmi.h  |   3 +
 7 files changed, 206 insertions(+), 49 deletions(-)

-- 
2.7.4

