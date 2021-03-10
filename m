Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591FF3346A8
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Mar 2021 19:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhCJS0n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Mar 2021 13:26:43 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:27273 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhCJS0M (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Mar 2021 13:26:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615400772; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=/Ld0Hlnt5SpAQBDnEzjJ0Btl03U9RAfKtn6YZF10otc=; b=ogJtQuFOtBH4lcsRiSRWWkF2jJtPEiYfIjUWyXniCxAwMUz8wldXJzXzHGLkEmzMMjiaP2HX
 fVqTHXVY9ivfc6w64dIFm03abjcPKElYj6VgUIh9nXnGrBg1XVWw6Yd8a2JPUPVZ1Rw/oilN
 mBJSscU9H6btrgfCl+IUBXM66KQ=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60490f436e1c22bc8ddf9d1e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Mar 2021 18:26:11
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B6D12C43461; Wed, 10 Mar 2021 18:26:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19995C433CA;
        Wed, 10 Mar 2021 18:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19995C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v9 0/4] Multiple BSSID support
Date:   Wed, 10 Mar 2021 10:26:00 -0800
Message-Id: <20210310182604.8858-1-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset adds support for multiple BSSID and
enhanced multi-BSSID advertisements.

This version modifies only nl80211 patch (1/4) which describes
the difference.

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
 net/mac80211/tx.c            | 189 ++++++++++++++++++++---
 net/wireless/nl80211.c       | 280 ++++++++++++++++++++++++++++++-----
 9 files changed, 830 insertions(+), 73 deletions(-)


base-commit: 38b5133ad607ecdcc8d24906d1ac9cc8df41acd5
-- 
2.25.0

