Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D029843773E
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 14:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhJVMlf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 08:41:35 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52910 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230519AbhJVMl2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 08:41:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634906351; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=qVNec6QWGpzrB+x5tAsrYszgLkbhZwBZq/zeaJmayUo=; b=VW2Qpii1rqZwDP7vfgOJycDkYfUFh8nacBUBPiy2u0CUwJfEZ4TQo6twS+x7BZbbjOtxT53O
 Rd9EfZoDPSHdWBrkMn3udumdg6G8aDJCJKPy7cXrqyBPfglX7hs7VI44HE6IC0twAufu1Xpc
 9LjndPUXFDSr/5Gah62uDfVpbIQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6172b0e9fd91319f0f611537 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 Oct 2021 12:39:05
 GMT
Sender: ppranees=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 19733C43618; Fri, 22 Oct 2021 12:39:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ppranees)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03B40C4360D;
        Fri, 22 Oct 2021 12:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 03B40C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   P Praneesh <ppranees@codeaurora.org>
To:     ath11k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>
Subject: [PATCH v3 0/3] mac80211: Add extended ROC support for 40-80 MHz bandwidth
Date:   Fri, 22 Oct 2021 18:07:04 +0530
Message-Id: <1634906227-22028-1-git-send-email-ppranees@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch add extended roc support for 40 and 80 Mhz bandwidth.
It helps to handle remain on channel for wide band scan in ath11k.
---
v3:
	- addressed Johannes comment to use ROC instead of SCAN command and
	  changed cover letter title from 'add Wide Band Scan support' to
	  'mac80211: Add extended ROC support for 40-80 MHz bandwidth'
v2:
	- updated message on cover letter.
---

P Praneesh (3):
  nl80211: Extended ROC support for 40-80 MHz bandwidth
  ath11k: Refactor update channel list function
  ath11k: Add ROC support for wide band scan

 drivers/net/wireless/ath/ath10k/mac.c              |   3 +-
 drivers/net/wireless/ath/ath11k/core.c             |   1 +
 drivers/net/wireless/ath/ath11k/mac.c              | 203 ++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/reg.c              |  99 +---------
 drivers/net/wireless/ath/ath11k/reg.h              |   1 -
 drivers/net/wireless/ath/ath11k/wmi.c              | 160 +++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h              |  31 +++-
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |   3 +-
 drivers/net/wireless/ath/ath9k/main.c              |   4 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |   3 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |   3 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.h |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   3 +-
 drivers/net/wireless/mac80211_hwsim.c              |   3 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |   3 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |   3 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |   3 +-
 drivers/net/wireless/ti/wlcore/main.c              |   3 +-
 include/net/cfg80211.h                             |   2 +-
 include/net/mac80211.h                             |   2 +-
 net/mac80211/driver-ops.h                          |   6 +-
 net/mac80211/ieee80211_i.h                         |   4 +-
 net/mac80211/offchannel.c                          |  56 ++++--
 net/mac80211/trace.h                               |  11 +-
 net/wireless/nl80211.c                             |   2 +-
 net/wireless/rdev-ops.h                            |   6 +-
 net/wireless/trace.h                               |   6 +-
 28 files changed, 452 insertions(+), 177 deletions(-)

-- 
2.7.4

