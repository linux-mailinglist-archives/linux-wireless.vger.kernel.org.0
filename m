Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7FF1BB570
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 06:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgD1Epq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 00:45:46 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:45942 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbgD1Epq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 00:45:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588049145; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Bl3kP3qPEuQwJJ2Fixe7lMs7t/nlP90rIN3Pu3uXDm8=; b=iFVtjAO8IVTjIDxNpmPcuornGlf4gGxzRbwy0n8I2VONIf+ue4lxPELMAKk7oWXCuGdKATcO
 xcW6sVmg2L0OZ9NtOqe88g9rJwmtcQnRNJnkV5V/WORcZFdlPIdPDYXABPp88wDOYsPJOg/w
 X01VN10ntM47ZLLudff8ghJTOR8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea7b4f1.7fdc61634c70-smtp-out-n05;
 Tue, 28 Apr 2020 04:45:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 55695C433D2; Tue, 28 Apr 2020 04:45:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from murugana-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: murugana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BD6A8C433CB;
        Tue, 28 Apr 2020 04:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD6A8C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=murugana@codeaurora.org
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <murugana@codeaurora.org>
Subject: [PATCH v4 0/2] ath11k: fix mgmt_tx_wmi cmd sent for deleted vdev
Date:   Tue, 28 Apr 2020 10:15:24 +0530
Message-Id: <1588049126-1490-1-git-send-email-murugana@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch set adds fix for the case of mgmt_tx_wmi cmd sent
to FW for deleted vdev.

And also patch having DBG_MAC prints to track vdev events which
will help in debugging.

Sathishkumar Muruganandam (2):
  ath11k: fix mgmt_tx_wmi cmd sent to FW for deleted vdev
  ath11k: add DBG_MAC prints to track vdev events

 drivers/net/wireless/ath/ath11k/mac.c | 37 ++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

v4:
	fixed kbuild errors
-- 
2.7.4
