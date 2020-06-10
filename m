Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD181F4C59
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2020 06:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgFJEcJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jun 2020 00:32:09 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37307 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbgFJEcJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jun 2020 00:32:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591763528; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=xTBkhmKs9bpc29XF0uUagBj2tTgowyWliThXw6zfzYw=; b=xffvPCCEGKgVyr2ka+xqg5sit92FXq5RL01runN+GW3LmsXYqaMrfDPJKacdviuyi4rGsR7D
 18b7MrrI90+kX7aDCVbd1ILzQ5flzSf0BuD9C7OMRu02CLcmsPxuIhHr6o8Qq1Xjw0YOYc9d
 dl9yfRjMSWgel7F9DsRvpsgWmBo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ee062486f2ee827daa546ba (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Jun 2020 04:32:08
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 055D3C433C6; Wed, 10 Jun 2020 04:32:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from checstp253621-lin.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srirrama)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4780C433CA;
        Wed, 10 Jun 2020 04:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4780C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=srirrama@codeaurora.org
From:   Sriram R <srirrama@codeaurora.org>
To:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Cc:     Sriram R <srirrama@codeaurora.org>
Subject: [PATCH 0/2] mac80211: add 802.11 decapsulation offload support
Date:   Wed, 10 Jun 2020 10:00:54 +0530
Message-Id: <1591763456-23275-1-git-send-email-srirrama@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adding support for offloading 802.11 decapsulation to the HW.
This helps in RX path optmization to reduces the CPU cycles
spent on host CPU for doing the conversion from 802.11 format
to ethernet format and thereby improving the performance of the device.

Sriram R (2):
  mac80211: add receive path for ethernet frame format
  ath11k: add rx path 802.11 decapsulation offloading support

 drivers/net/wireless/ath/ath11k/core.h     |   3 +
 drivers/net/wireless/ath/ath11k/dp_rx.c    | 185 ++++++++++++++----------
 drivers/net/wireless/ath/ath11k/hal_desc.h |   2 +
 drivers/net/wireless/ath/ath11k/mac.c      |  20 +++
 include/net/mac80211.h                     |  20 +++
 net/mac80211/rx.c                          | 222 ++++++++++++++++++++++++++++-
 6 files changed, 373 insertions(+), 79 deletions(-)

-- 
2.7.4

