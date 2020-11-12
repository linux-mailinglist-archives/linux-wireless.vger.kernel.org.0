Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0659D2B0075
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 08:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgKLHnO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 02:43:14 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:63314 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgKLHnO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Nov 2020 02:43:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605166993; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=e0+tPyIMi8LorsVhRa4s9WlRbsd8PnxPsrl8tF6MYLY=; b=U/S7xXq7Vo0LficEaPTy1J7r1Gx/+213Wf0W8ew3Zg/cWBFSvImLBdPZbKm7XLmJ2flQAxUj
 nOVNlJRwBBvmvgd5jaDEoSDklGz/QbfDeW2JGOVvI6wQKWR/8ylM1rnOmyh4mTPubjSjLimh
 E4oiL7JuA1vZtN38L+04+JGsx4k=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5face791e9dd187f53cea477 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 12 Nov 2020 07:43:13
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4A4F2C433CB; Thu, 12 Nov 2020 07:43:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from ssreeela-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93074C433C6;
        Thu, 12 Nov 2020 07:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93074C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH v2 0/3] ath11k: vdev and peer delete synchronization with firmware
Date:   Thu, 12 Nov 2020 13:12:57 +0530
Message-Id: <1605166980-29115-1-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When add an interface immediately after removing the interface,
vdev deletion in firmware might not have been completed.
add vdev_delete_resp_event and wait_event_timeout to synchronize
with firmware.

Peer creation in firmware fails if last peer deletion is still in
progress, add wait for the event after deleting every peer from host
driver to synchronize with firmware.

1) add vdev delete resp event and wait event to get ack from firmware
2) add wait event timeout for peer delete to get ack from firmware
3) code clean up and replace the api 'ath11k_mac_get_ar_vdev_stop_status'
   with 'ath11k_mac_get_ar_by_vdev_id'

V2: Rebased on latest ath.git TOT - Addressed Kalle's comment.

Ritesh Singh (3):
  ath11k: vdev delete synchronization with firmware
  ath11k: peer delete synchronization with firmware
  ath11k: remove "ath11k_mac_get_ar_vdev_stop_status" references

 drivers/net/wireless/ath/ath11k/core.c |  2 +
 drivers/net/wireless/ath/ath11k/core.h |  9 ++--
 drivers/net/wireless/ath/ath11k/mac.c  | 82 ++++++++++++++++------------------
 drivers/net/wireless/ath/ath11k/mac.h  |  2 -
 drivers/net/wireless/ath/ath11k/peer.c | 44 ++++++++++++++++--
 drivers/net/wireless/ath/ath11k/peer.h |  2 +
 drivers/net/wireless/ath/ath11k/wmi.c  | 81 ++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/wmi.h  |  4 ++
 8 files changed, 166 insertions(+), 60 deletions(-)

-- 
2.7.4

