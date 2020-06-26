Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A08F20B8B3
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 20:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbgFZSyI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 14:54:08 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:33979 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbgFZSyH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 14:54:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593197646; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ulJKfi5lN2v1zpPbbJV+leSuXmEAIHWHEqi7KXrscX4=; b=AqmdKIG9/WedwZZGi+Ek4vluM+JFRCWSRY2waW4bJ18JvWio837q0J7EbdLDaLVMc3KT0qlI
 cnuD5+mP0y8PGfmCXbGY/h/h6cZaxXxEX1k2Gclp3mLSAuk9iUrs/sD+jPZuRV6QB2HyRsdX
 o2/8nr7cv7RONXy01BeMdCaAPzE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-west-2.postgun.com with SMTP id
 5ef64448e144dd5115bb36d5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 18:54:00
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DD2FEC433C6; Fri, 26 Jun 2020 18:53:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11E67C433C8;
        Fri, 26 Jun 2020 18:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11E67C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH v2 0/2] ath10k: Fixes during subsystem recovery
Date:   Sat, 27 Jun 2020 00:23:51 +0530
Message-Id: <1593197633-9014-1-git-send-email-pillair@codeaurora.org>
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

