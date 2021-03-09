Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20909331DB7
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Mar 2021 04:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhCIDzQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Mar 2021 22:55:16 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:17967 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhCIDyr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Mar 2021 22:54:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615262087; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=hyggxAjmD34KQNhDhfjaOblMSk91ZNWHWoXKRmB4iiQ=; b=mG4x/lQgHutqUCsRbfRfSCB7729RCG+TvLlzjQnYWS7NoUxkOOlgDlulovPJrMpGxb29RyOp
 5w8hjX874Urr5f8lNeIM4FqEuL9FS8l0ZIhSOCGgBosgqfo1K8QafA6vywzWhHqTfVLtAAeg
 mHsUfar9rp/r7Nw65dI3lzDUIKs=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6046f186f7ec0ea57c7fc74e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Mar 2021 03:54:46
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E0B78C433ED; Tue,  9 Mar 2021 03:54:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19363C433C6;
        Tue,  9 Mar 2021 03:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19363C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v8 0/4] Multiple BSSID support
Date:   Mon,  8 Mar 2021 19:54:33 -0800
Message-Id: <20210309035437.6131-1-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset adds support for multiple BSSID and
enhanced multi-BSSID advertisements.

This version has changes only in patch 1/4 (nl80211) which add
new feature flags NL80211_EXT_FEATURE_MULTIPLE_BSSID_AP and
NL80211_EXT_FEATURE_EMA_AP along with wiphy parameters
max_num_vaps and max_profile_periodicity to be used by drivers

John Crispin (4):
  nl80211: add basic multiple bssid support
  mac80211: add multiple bssid support to interface handling
  mac80211: add multiple bssid/EMA support to beacon handling
  mac80211: CSA on non-transmitting interfaces

 include/net/cfg80211.h       |  47 ++++++
 include/net/mac80211.h       | 116 ++++++++++++++-
 include/uapi/linux/nl80211.h |  84 +++++++++++
 net/mac80211/cfg.c           | 178 ++++++++++++++++++++--
 net/mac80211/debugfs.c       |   1 +
 net/mac80211/ieee80211_i.h   |   2 +
 net/mac80211/iface.c         |   6 +
 net/mac80211/tx.c            | 189 +++++++++++++++++++++---
 net/wireless/nl80211.c       | 277 ++++++++++++++++++++++++++++++-----
 9 files changed, 828 insertions(+), 72 deletions(-)


base-commit: 38b5133ad607ecdcc8d24906d1ac9cc8df41acd5
-- 
2.25.0

