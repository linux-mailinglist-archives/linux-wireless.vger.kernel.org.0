Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D542FC625
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jan 2021 01:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbhATAxU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 19:53:20 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:26277 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730999AbhATAxK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 19:53:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611103971; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=q/xVvwtSG0e8iybUwWiBEDqwZYtOfZVh9Hpq7maLc2Y=; b=T0KokJsfpfJ+vXrLDk5mZjOqTzc8pd7aQqYQrag8TwUMIbu8epfP0zNGk4rxMtnp81BuuJbJ
 /U+XxQlrsw5HDEXRG6EDZqNMKpOFHlNk8DZTiGIAMHYLUPnqntl/PcpAhOkJkudZSZdKeedZ
 kpjf7oWeJdeWTjzBYykksGqX7bg=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60077ed2f94f20d8b792a89f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Jan 2021 00:52:34
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6F2A7C433C6; Wed, 20 Jan 2021 00:52:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4707C433CA;
        Wed, 20 Jan 2021 00:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4707C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH 0/2] Commands for FILS discovery and unsolicited probe response
Date:   Tue, 19 Jan 2021 16:52:27 -0800
Message-Id: <20210120005229.32582-1-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset removes the dependency of FILS discovery and unsolicited
probe response configurations on beacon setup command and instead adds new
netlink commands which allow setting parameters dynamically.

Aloka Dixit (2):
  nl80211: Commands for FILS discovery and unsolicited broadcast probe
    response
  mac80211: Commands for FILS discovery and unsolicited broadcast probe
    response

 include/net/cfg80211.h       |  13 +++--
 include/uapi/linux/nl80211.h |  12 +++++
 net/mac80211/cfg.c           |  33 +++++-------
 net/wireless/nl80211.c       | 102 ++++++++++++++++++++---------------
 net/wireless/rdev-ops.h      |  24 +++++++++
 net/wireless/trace.h         |  43 +++++++++++++++
 6 files changed, 159 insertions(+), 68 deletions(-)


base-commit: 0ae5b43d6dde6003070106e97cd0d41bace2eeb2
-- 
2.25.0

