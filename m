Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A81836B985
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Apr 2021 20:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbhDZS7B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 14:59:01 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:45004 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbhDZS67 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 14:58:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619463498; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=po3JegB5oV8/BkdGAbdIR3FQ6uZYc7pFcgvulhI+rWM=; b=FDs/NCUygos0e53BQx5tUkz/q/VA0Aavqo74HpjMdvkswH5Tmck/Gm6uuJ2OT1wa7wn8xdk2
 eR3FFICohkeWpKhpJhAOkrF+8GFPib83Y7ZRoVWEG8D4009+BQXWxA4CwHKOyk7c3VOM1oc8
 1lS3R64PXRinoXAE0BPbg/PJ3Bk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60870d40853c0a2c462ddd7b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Apr 2021 18:58:08
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 550FCC433F1; Mon, 26 Apr 2021 18:58:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B221BC433D3;
        Mon, 26 Apr 2021 18:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B221BC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH 0/4] multiple bssid and EMA support in AP mode
Date:   Mon, 26 Apr 2021 11:57:52 -0700
Message-Id: <20210426185756.10924-1-alokad@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset adds support for multiple BSSID and
enhanced multi-BSSID advertisements for AP mode.

HWSIM support will be added in a separate patchset.

John Crispin (4):
  nl80211: multiple bssid and EMA support in AP mode
  mac80211: multiple bssid support in interface handling
  mac80211: MBSSID and EMA support in beacon handling
  mac80211: CSA on non-transmitting interfaces

 include/net/cfg80211.h       |  51 +++++++
 include/net/mac80211.h       | 123 ++++++++++++++-
 include/uapi/linux/nl80211.h | 101 ++++++++++++-
 net/mac80211/cfg.c           | 198 +++++++++++++++++++++++--
 net/mac80211/debugfs.c       |   2 +
 net/mac80211/ieee80211_i.h   |   2 +
 net/mac80211/iface.c         |  12 ++
 net/mac80211/tx.c            | 189 ++++++++++++++++++++---
 net/wireless/nl80211.c       | 280 ++++++++++++++++++++++++++++++-----
 9 files changed, 883 insertions(+), 75 deletions(-)


base-commit: 5d869070569a23aa909c6e7e9d010fc438a492ef
-- 
2.31.1

