Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC204236DC
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Oct 2021 06:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhJFELi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Oct 2021 00:11:38 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:39439 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhJFELh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Oct 2021 00:11:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633493386; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: To: From: Sender;
 bh=Epb80q1QhIE8K+LvMuWKca8JFrzu/zlPQkAurP80fmo=; b=U4KIAUbEhM3xEjBJkVq1PG3mHHL4NXUoMgx/xWASKc4Mm16wLUp3ewqgqUSjiJrK33mLQ8di
 +UkDD5q5F1062/0yLqgWONpCIpgwAi1/foiho1qbZuNrSwC+cTr86DVQS28/4FlTvzga6uc9
 FgfcipTTYpkK/1P37ALDKG9sH3o=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 615d218a03355859c81b676b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 06 Oct 2021 04:09:45
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A8AEBC4338F; Wed,  6 Oct 2021 04:09:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F7CDC4338F;
        Wed,  6 Oct 2021 04:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 1F7CDC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: [v13 0/3] MBSSID and EMA support in AP mode
Date:   Tue,  5 Oct 2021 21:09:35 -0700
Message-Id: <20211006040938.9531-1-alokad@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset adds support for multiple BSSID and
enhanced multi-BSSID advertisements for AP mode.

New patch added to split __ieee80211_beacon_get() first
before MBSSID and EMA beacon handing.

Aloka Dixit (1):
  mac80211: split beacon retrieval functions

John Crispin (2):
  mac80211: MBSSID and EMA support in beacon handling
  mac80211: MBSSID channel switch

 include/net/mac80211.h     |  66 +++++++
 net/mac80211/cfg.c         | 177 ++++++++++++++----
 net/mac80211/ieee80211_i.h |   1 +
 net/mac80211/tx.c          | 360 ++++++++++++++++++++++++++++---------
 4 files changed, 484 insertions(+), 120 deletions(-)


base-commit: 171964252189d8ad5672c730f2197aa73092db6e
-- 
2.31.1

