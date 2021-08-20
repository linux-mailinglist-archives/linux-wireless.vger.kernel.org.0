Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56ABC3F2BE9
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 14:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbhHTMVi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 08:21:38 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:53290 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240340AbhHTMVh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 08:21:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629462058; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=TNsFo9asXxTaILvhClQleGhoJKkPqv7/MQpYITwgVmY=; b=nk8JUCAjb6dMJ4qgRNF9kw4SiB0wGdWiF5ilyVwHiHVJnma+Mqjd9BIpI+JXoF2WO/N+CBhn
 ed5Y0VwKQcWqZM3yCp2coZlmAEtLUfYpPOMKx08wOBSIU2la58Fi8ZWYIiRfvE6TDy8X0zDO
 7K+JJmOe8SqJFnZ802zAmVWgv+w=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 611f9e2189fbdf3ffe7b6237 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Aug 2021 12:20:49
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C32A6C4360C; Fri, 20 Aug 2021 12:20:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F5AEC4338F;
        Fri, 20 Aug 2021 12:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 1F5AEC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v2 0/8] cfg80211/mac80211: Add support for 6GHZ STA for various modes : LPI, SP and VLP
Date:   Fri, 20 Aug 2021 08:20:33 -0400
Message-Id: <20210820122041.12157-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v2: change per comments of johannes.
    including code style, code logic, patch merge, commit log... 

It introduced some new concept:
power type of AP(STANDARD_POWER_AP, INDOOR_AP, VERY_LOW_POWER_AP)
power type of STATION(DEFAULT_CLIENT, SUBORDINATE_CLIENT)
power spectral density(psd)

This patchset for cfg80211/mac80211 is to add the definition of new
concept of 6G and add basic parse of IE(transmit power envelope
element) in beacon and save power spectral density(psd) reported
by lower-driver for 6G channel, the info will be passed to lower
driver when connecting to 6G AP.

Wen Gong (8):
  cfg80211: add power type definition for 6 GHz
  mac80211: add definition of regulatory info in 6 GHz operation
    information
  mac80211: add parse regulatory info in 6 GHz operation information
  cfg80211: add definition for 6 GHz power spectral density(psd)
  cfg80211: save power spectral density(psd) of regulatory rule
  mac80211: add definition for transmit power envelope element
  mac80211: add parse transmit power envelope element
  mac80211: save transmit power envelope element and power constraint

 include/linux/ieee80211.h    | 43 +++++++++++++++++++++++++++++++++++-
 include/net/cfg80211.h       |  7 ++++++
 include/net/mac80211.h       |  6 +++++
 include/net/regulatory.h     |  1 +
 include/uapi/linux/nl80211.h | 36 ++++++++++++++++++++++++++++++
 net/mac80211/chan.c          |  9 ++++++++
 net/mac80211/ieee80211_i.h   |  3 +++
 net/mac80211/mlme.c          | 26 ++++++++++++++++++++++
 net/mac80211/util.c          | 19 ++++++++++++++++
 net/wireless/reg.c           | 14 ++++++++++++
 10 files changed, 163 insertions(+), 1 deletion(-)

-- 
2.31.1

