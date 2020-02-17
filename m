Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9AF61611FA
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2020 13:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgBQMZP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Feb 2020 07:25:15 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:38607 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgBQMZP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Feb 2020 07:25:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581942311; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=iy9oYEyotI4KDaCwraKjGKVN+q5C/hmY7Nguh9S2LVs=; b=gRcKBU1RP3ugvadHoQJ1bXroBd7sVFW+AQs4aPUFRSWnYLLrh/A5ReGv6mfm0AiqjfY+3Avy
 /HQFcaDTsUEtFczJgrsZkmLtAFV20wHJrpK3ocKmoB0rSXbRmcdITU9OmunCMavm6sbSC7G1
 blFiVH4Fat3SheEqVOfdotBIP0w=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4a861d.7f8e83ea7260-smtp-out-n02;
 Mon, 17 Feb 2020 12:25:01 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 79CBDC4479F; Mon, 17 Feb 2020 12:25:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mpubbise)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CDCBBC43383;
        Mon, 17 Feb 2020 12:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDCBBC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mpubbise@codeaurora.org
From:   Manikanta Pubbisetty <mpubbise@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>
Subject: [RFC 0/2] add 802.11 decapsulation offload support
Date:   Mon, 17 Feb 2020 17:54:35 +0530
Message-Id: <1581942277-585-1-git-send-email-mpubbise@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adding support for offloading 802.11 decapsulation to the HW.
This reduces the CPU cycles spent on host CPU for doing the 
conversion from 802.11 format to ethernet format and thereby
improving the performance of the device.

Note:
Ath11k patch in this patchset depends on PN offload series
and the multi reo patchset with the following name.
"Support hash based reo destination ring selection"

Manikanta Pubbisetty (2):
  mac80211: add receive path for ethernet frame format
  ath11k: add rx hw 802.11 decapsulation offloading support

 drivers/net/wireless/ath/ath11k/core.c     |   4 +
 drivers/net/wireless/ath/ath11k/core.h     |   3 +
 drivers/net/wireless/ath/ath11k/dp_rx.c    | 184 ++++++++++++++----------
 drivers/net/wireless/ath/ath11k/hal_desc.h |   2 +
 drivers/net/wireless/ath/ath11k/mac.c      |  21 +++
 include/net/mac80211.h                     |  20 +++
 net/mac80211/rx.c                          | 215 ++++++++++++++++++++++++++++-
 7 files changed, 370 insertions(+), 79 deletions(-)

-- 
2.7.4
