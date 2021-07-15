Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4D63C9961
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jul 2021 09:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbhGOHLB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jul 2021 03:11:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:28212 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230310AbhGOHLB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jul 2021 03:11:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626332889; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: To: From: Sender;
 bh=AZGzuP6zqgsNTDkj1BTjlYFgzi+Lz5J+AZOdUM8ogW8=; b=MzwfhfR/ItJKDXdQAKAgsn+mha8ZgIDdtk1eZbazdS+82skmiIFYojFe5zOgciQJpA8e2Ds8
 7xvXIBqvglMYdeTqhEswdsTt1bopZCRUsG5Q7Ee5ennEKEKfrkmbGCx5L4ELfPn6O/96biLy
 nOxM3HiI2odbodj9rLqmPeCkwLg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60efdec9290ea35ee6062ca7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 15 Jul 2021 07:07:53
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C80E3C433D3; Thu, 15 Jul 2021 07:07:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A87BC433F1;
        Thu, 15 Jul 2021 07:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A87BC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: [PATCH v11 0/4] multiple bssid and EMA support in AP mode
Date:   Thu, 15 Jul 2021 00:07:41 -0700
Message-Id: <20210715070745.5033-1-alokad@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset adds support for multiple BSSID and
enhanced multi-BSSID advertisements for AP mode.
Individual patches describe the changes in this version.

John Crispin (4):
  nl80211: MBSSID and EMA support in AP mode
  mac80211: MBSSID support in interface handling
  mac80211: MBSSID and EMA support in beacon handling
  mac80211: channel switch for non-transmitting interfaces

 include/net/cfg80211.h       |  44 ++++++
 include/net/mac80211.h       |  93 +++++++++++++
 include/uapi/linux/nl80211.h |  76 +++++++++-
 net/mac80211/cfg.c           | 170 +++++++++++++++++++++--
 net/mac80211/ieee80211_i.h   |   2 +
 net/mac80211/iface.c         |  29 +++-
 net/mac80211/tx.c            | 173 ++++++++++++++++++++---
 net/wireless/nl80211.c       | 261 +++++++++++++++++++++++++++++------
 8 files changed, 772 insertions(+), 76 deletions(-)


base-commit: 5e437416ff66981d8154687cfdf7de50b1d82bfc
-- 
2.31.1

