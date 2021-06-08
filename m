Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B178F39F9F0
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 17:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhFHPId (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 11:08:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:27741 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233354AbhFHPIc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 11:08:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623164800; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=MxPY8mUTMwKuP+gTjmpZ6eT5nb24rZnO4rIX+cewIl4=; b=GBrAokCSZWE/A40ZWYurccMSvSryc6GzD8tTPxqUJACVbmf+UnUwianDvbtap308JIktHLMZ
 I2PmYVfSONOobSyD8CC39ftc1IiVyvOcrkQk1XOpymt/32vqmnFiZ8OCG/1FnsoOO3nd7oPl
 ueW6BhsmHK+9qKA0q+BPc8BKDmU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60bf86f7f726fa4188fcef06 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 08 Jun 2021 15:04:23
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 069F1C4338A; Tue,  8 Jun 2021 15:04:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4AD97C433D3;
        Tue,  8 Jun 2021 15:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4AD97C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     000ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH v3 0/3] Add support to configure beacon tx mode
Date:   Tue,  8 Jun 2021 20:34:00 +0530
Message-Id: <1623164643-7803-1-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to configure the beacon tx mode as STAGGERED
or BURST mode via hostapd configuration during the AP
bring-up or via wpa_suppplicant configuration during MESH
bring-up.

Beacons can be sent out in burst(continuously in a single shot
one after another) or staggered (equally spread out over beacon
interval) mode.

V3: Addressed Johnson's comment on v2 patch.

V2: Addressed Johannes's comment on v1 patch.

Maharaja Kennadyrajan (3):
  nl80211: Add support for beacon tx mode
  mac80211: Add support for beacon tx mode
  ath11k: Add support for beacon tx mode

 drivers/net/wireless/ath/ath11k/mac.c | 10 +++++++---
 include/net/cfg80211.h                |  4 ++++
 include/net/mac80211.h                |  2 ++
 include/uapi/linux/nl80211.h          | 16 ++++++++++++++++
 net/mac80211/cfg.c                    |  2 ++
 net/wireless/nl80211.c                |  9 +++++++++
 6 files changed, 40 insertions(+), 3 deletions(-)

-- 
2.7.4

