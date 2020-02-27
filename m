Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2202717169F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2020 13:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgB0MCj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Feb 2020 07:02:39 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:15641 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728882AbgB0MCi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Feb 2020 07:02:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582804958; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=WJBYog0gb05I/zFUOYjjc6l3GoIg9LVR+pHnj55+eTQ=; b=t6laDpiWN18S2iSV+jQAJJ71/7muYbqAbKPPOAA90ycEp2uJy4xz857vQ1FooWpBP9fSMh1H
 N9mWv6zieUhcEkitP1dKjdbpwLXLs0+SgMyhsjFZgFr3TdtFzB6kkoL+fkTs5c3PnMVTOMXV
 3dnoBZ6pAk2diTy2dZEC+w4vVZw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e57afb2.7f8f01bd9d50-smtp-out-n01;
 Thu, 27 Feb 2020 12:01:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D0D93C433A2; Thu, 27 Feb 2020 12:01:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mpubbise)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3FCD2C43383;
        Thu, 27 Feb 2020 12:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3FCD2C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mpubbise@codeaurora.org
From:   Manikanta Pubbisetty <mpubbise@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>
Subject: [RFCv2 0/2] add 802.11 decapsulation offload support
Date:   Thu, 27 Feb 2020 17:31:37 +0530
Message-Id: <1582804899-12814-1-git-send-email-mpubbise@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adding support for offloading 802.11 decapsulation to the HW.
This reduces the CPU cycles spent on host CPU for doing the
conversion from 802.11 format to ethernet format and thereby
improving the performance of the device.

This change was tested on IPQ8074 platform (ath11k driver).
In tests where CPUs are fully loaded, this change has improved
average CPU usage by nearly 8-10%.

Note:
Ath11k patch in this patchset depends on PN offload series and
the multi reo patchset with the following name.
"Support hash based reo destination ring selection"

v2:
	- Cover letter is updated with performance improvement numbers
	- Disabled tid stats update for decap offload case

Manikanta Pubbisetty (1):
  ath11k: add 802.11 decapsulation offloading support

Vasanthakumar Thiagarajan (1):
  mac80211: add receive path for ethernet frame format

 drivers/net/wireless/ath/ath11k/core.c     |   4 +
 drivers/net/wireless/ath/ath11k/core.h     |   3 +
 drivers/net/wireless/ath/ath11k/dp_rx.c    | 184 ++++++++++++++----------
 drivers/net/wireless/ath/ath11k/hal_desc.h |   2 +
 drivers/net/wireless/ath/ath11k/mac.c      |  21 +++
 include/net/mac80211.h                     |  20 +++
 net/mac80211/rx.c                          | 217 ++++++++++++++++++++++++++++-
 7 files changed, 371 insertions(+), 80 deletions(-)

-- 
2.7.4
