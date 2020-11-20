Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132282BA526
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Nov 2020 09:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgKTIx1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 03:53:27 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:10959 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgKTIx1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 03:53:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605862406; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=8cqF9Lxty80iiD9EYJWE3wbpgJX5IGQwGieLCYKqS+Y=; b=Tttc9XkyIRekJTTGXRdPFZo1cnJ/dv/HeceOJL61G1gF16zvnkQ3fCf7BgLNtn4EI2zkQ8Tt
 thy4NLqWORBVi9mXsmJK6rjIos+QTLzUAhbsPaPsA/71yC1MElxHC/+I+XyGjKGDKnuW1p5y
 hFJ25s9o2Z58lAcJC71u+t4jCZs=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5fb78402e714ea6501889025 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Nov 2020 08:53:22
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5EDFBC433C6; Fri, 20 Nov 2020 08:53:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from cjhuang-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B987DC433ED;
        Fri, 20 Nov 2020 08:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B987DC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cjhuang@codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, briannorris@chromium.org,
        dianders@chromium.org
Subject: [PATCH v2 0/3] add common API to configure SAR
Date:   Fri, 20 Nov 2020 03:53:09 -0500
Message-Id: <20201120085312.4355-1-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset is to add common API to configure SAR.
The mechanism is wlan driver registers sar capability
to wiphy and userspace queries it. Userspace then sets
power limiation to wlan driver.

v2:
- rebased on ToT
- fix comments by Johannes and Abhishek
- change sar_power to s32 and range_index to u32

Carl Huang (3):
  nl80211: add common API to configure SAR power limitations.
  mac80211: add ieee80211_set_sar_specs
  ath10k: allow dynamic SAR power limits via common API

 drivers/net/wireless/ath/ath10k/core.c |  16 +++
 drivers/net/wireless/ath/ath10k/core.h |   3 +
 drivers/net/wireless/ath/ath10k/hw.h   |   2 +
 drivers/net/wireless/ath/ath10k/mac.c  | 225 ++++++++++++++++++++++++---------
 include/net/cfg80211.h                 |  51 ++++++++
 include/net/mac80211.h                 |   2 +
 include/uapi/linux/nl80211.h           | 101 +++++++++++++++
 net/mac80211/cfg.c                     |  12 ++
 net/wireless/nl80211.c                 | 168 ++++++++++++++++++++++++
 net/wireless/rdev-ops.h                |  12 ++
 net/wireless/trace.h                   |  19 +++
 11 files changed, 552 insertions(+), 59 deletions(-)

-- 
2.7.4

