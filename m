Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D55D20B7D6
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 20:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgFZSLx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 14:11:53 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30848 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFZSLx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 14:11:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593195112; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ulJKfi5lN2v1zpPbbJV+leSuXmEAIHWHEqi7KXrscX4=; b=vaes/ZI3xYFj8GJJc+oTjrNPFVxichi/4FEtkpqn1YSEAbgZcKItPluFiKGLgzcClkLcTyUZ
 LsGYpFEj+2IbKtJJQaio/lRVEEh/LMnQsNpVmc/yH+gsmUn01Uffoiq6SCqhdWs8vCEA2rJz
 S1pYZywCfeLNMsmOpz/b4I3bYCQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5ef63a68ad153efa346ff9b3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 18:11:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 11B76C433C6; Fri, 26 Jun 2020 18:11:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 55522C433C8;
        Fri, 26 Jun 2020 18:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 55522C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH 0/2] ath10k: Fixes during subsystem recovery
Date:   Fri, 26 Jun 2020 23:41:38 +0530
Message-Id: <1593195100-24654-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series includes some fixes when the device
is in recovery mode, i.e. when the firmware goes down.

- Pausing TX queues when FW goes down
- Removed unwanted/extra error logging in pkt TX path
- Skipping wait for FW response for delete cmds
- Handling the -ESHUTDOWN error code in case of SSR.

Rakesh Pillai (2):
  ath10k: Pause the tx queues when firmware is down
  ath10k: Skip wait for delete response if firmware is down

 drivers/net/wireless/ath/ath10k/core.h |  1 +
 drivers/net/wireless/ath/ath10k/mac.c  | 36 ++++++++++++++++++++++------------
 drivers/net/wireless/ath/ath10k/snoc.c |  3 +++
 3 files changed, 28 insertions(+), 12 deletions(-)

-- 
2.7.4

