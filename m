Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83AF1BA545
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 15:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgD0NpM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 09:45:12 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:61441 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727117AbgD0NpM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 09:45:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587995112; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=6HQ1qGM9hO0oCACXU+bUaseVv0IJTFrfZQBeZwftBmQ=; b=t3KGbC4HGYZ8GihJyL4fKT6QQD11pfryqAvm0qz4QFUjrBvRBnwpEEQOcISVNs290cd/kfph
 UHB3mTVr0tdnVgkpoAHaGCto3l0TDOC386c4w6HLdRAO1bvUD4yNU5PK55jon8o1SyxWrPFf
 QYyNhm1OvyD0M2bJGLiMcxscBdQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea6e1e7.7efd1e339730-smtp-out-n02;
 Mon, 27 Apr 2020 13:45:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 094C5C433BA; Mon, 27 Apr 2020 13:45:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from murugana-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: murugana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6A024C433D2;
        Mon, 27 Apr 2020 13:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A024C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=murugana@codeaurora.org
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <murugana@codeaurora.org>
Subject: [PATCH v3 0/2] ath11k: fix mgmt_tx_wmi cmd sent for deleted vdev
Date:   Mon, 27 Apr 2020 19:14:53 +0530
Message-Id: <1587995095-7808-1-git-send-email-murugana@codeaurora.org>
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

v2:
	added ath11k prefix to cover letter
v3:
	Cc'ed linux-wireless
-- 
2.7.4
