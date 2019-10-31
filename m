Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9397FEB036
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 13:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfJaM2M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 08:28:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41092 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJaM2M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 08:28:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8D62660927; Thu, 31 Oct 2019 12:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572524891;
        bh=6jNqu0rAezg/IEuvybwazr+r7OXDnEff/mnxC2917JQ=;
        h=From:To:Cc:Subject:Date:From;
        b=WJYsR6O3O3hqfFjZotWtOjthyGvoP3AfChBTuZPGXJ4IU2JN7AARcx+mQIr9OE9i/
         r0LcSQtlIDnM7Wt4DVAdPIHVToDZeSwx5qnExwNHWBuTUWuto0WHjtCeb424oTyXA0
         gyin/6QaTDtFCxQjENLXuVUa2P64CGAFYpNlduMc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from murugana-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: murugana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E9F846083E;
        Thu, 31 Oct 2019 12:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572524891;
        bh=6jNqu0rAezg/IEuvybwazr+r7OXDnEff/mnxC2917JQ=;
        h=From:To:Cc:Subject:Date:From;
        b=WJYsR6O3O3hqfFjZotWtOjthyGvoP3AfChBTuZPGXJ4IU2JN7AARcx+mQIr9OE9i/
         r0LcSQtlIDnM7Wt4DVAdPIHVToDZeSwx5qnExwNHWBuTUWuto0WHjtCeb424oTyXA0
         gyin/6QaTDtFCxQjENLXuVUa2P64CGAFYpNlduMc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9F846083E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=murugana@codeaurora.org
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: [PATCH 0/2] add Wide Band Scan support
Date:   Thu, 31 Oct 2019 17:57:45 +0530
Message-Id: <1572524867-26703-1-git-send-email-murugana@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wide Band Scan allows to perform off-channel scan on requested channel/
frequency along with corresponding phy mode/bandwidth (40Mhz, 80Mhz).

Sathishkumar Muruganandam (2):
  nl80211: add Wide Band Scan support

 include/net/cfg80211.h       |  2 ++
 include/uapi/linux/nl80211.h |  7 +++++
 net/mac80211/scan.c          |  2 ++
 net/wireless/nl80211.c       | 68 ++++++++++++++++++++++++++++----------------
 4 files changed, 55 insertions(+), 24 deletions(-)

  ath11k: add Wide Band Scan support

 drivers/net/wireless/ath/ath11k/mac.c |  41 ++++++++++--
 drivers/net/wireless/ath/ath11k/wmi.c | 115 +++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/wmi.h |  34 +++++++++-
 3 files changed, 175 insertions(+), 15 deletions(-)

-- 
2.7.4

