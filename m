Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1EB1F4D50
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2020 07:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgFJFyF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jun 2020 01:54:05 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:11083 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbgFJFyF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jun 2020 01:54:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591768444; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ysvrkvs4hevyoicoOaRQyO0aLsTTpjO4YOoJFxUN9kY=; b=Ud2YLr/6aLeO7uoesCLE3jSV6PEx9ZdYnSoyVc5zeyxBfc1+PbrEajzlP26Y34JsTXmXgsbH
 k5PMLEnZg4cyvE7FwD3k0VmV/OwVsVfI0iThuJN5DjOrFOlUu+xpfHJp8WenyuDBduLm1PwK
 A7rJbUqYssiYScI811sbkPHNNrs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ee075738fe116ddd95cf135 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Jun 2020 05:53:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 63762C433CA; Wed, 10 Jun 2020 05:53:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from checstp253621-lin.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srirrama)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DBD8EC433C6;
        Wed, 10 Jun 2020 05:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DBD8EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=srirrama@codeaurora.org
From:   Sriram R <srirrama@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Sriram R <srirrama@codeaurora.org>
Subject: [PATCH 0/2] ath11k: Rename soc_rx_stats to soc_dp_stats and add more dp stats
Date:   Wed, 10 Jun 2020 11:21:46 +0530
Message-Id: <1591768308-32005-1-git-send-email-srirrama@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, the debugfs "soc_rx_stats" in location '/sys/kernel/debug/ath11k/ipq8074/'
is used for getting only dp rx stats. This has been renamed to "soc_dp_stats"
as tx stats and other ring specific info would also be useful for
debug purpose and it would be good to have all these stats under similar
file.

This patchset adds support for tx error stats and ring backpressure
stats. More ring specific stats could be added here in future.

Sriram R (2):
  ath11k: Add dp tx err stats
  ath11k: Add support for ring backpressure stats

 drivers/net/wireless/ath/ath11k/core.h  |  34 ++++++++-
 drivers/net/wireless/ath/ath11k/debug.c | 128 ++++++++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/dp.h    |  42 +++++++++++
 drivers/net/wireless/ath/ath11k/dp_rx.c |  28 ++++++-
 drivers/net/wireless/ath/ath11k/dp_tx.c |   7 +-
 5 files changed, 229 insertions(+), 10 deletions(-)

-- 
2.7.4

