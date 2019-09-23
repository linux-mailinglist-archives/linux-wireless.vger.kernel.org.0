Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9600BAE64
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 09:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392846AbfIWHUW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 03:20:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46216 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbfIWHUW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 03:20:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 80C8560240; Mon, 23 Sep 2019 07:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569223221;
        bh=YXQQg1QmF5UFWDYNhDFlNIhg9/MebxMrqpKpp6NXSNA=;
        h=From:To:Cc:Subject:Date:From;
        b=ZwF3BQVoYK/Qh6EAy7qXTIXxnrY66PibjwfMdn5g6JyHSRY5XMKb8cms5ydIInO6V
         Cuc5ufnm1sOSSGNloX6zRSd9Bins+d1R/IOQcyYtRp+JfWtP1ttSxRlQwk89+W85JW
         3ePHGFVK4Y/2Ydj/+SgyH026zQ3sJMBwS2YYIcBw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from ybzhao-HP-Z230-SFF-Workstation.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: yiboz@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D5FB60240;
        Mon, 23 Sep 2019 07:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569223221;
        bh=YXQQg1QmF5UFWDYNhDFlNIhg9/MebxMrqpKpp6NXSNA=;
        h=From:To:Cc:Subject:Date:From;
        b=ZwF3BQVoYK/Qh6EAy7qXTIXxnrY66PibjwfMdn5g6JyHSRY5XMKb8cms5ydIInO6V
         Cuc5ufnm1sOSSGNloX6zRSd9Bins+d1R/IOQcyYtRp+JfWtP1ttSxRlQwk89+W85JW
         3ePHGFVK4Y/2Ydj/+SgyH026zQ3sJMBwS2YYIcBw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D5FB60240
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=yiboz@codeaurora.org
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org, Yibo Zhao <yiboz@codeaurora.org>
Subject: [PATCH V3 0/4] Enable virtual time-based airtime scheduler support on ath10k
Date:   Mon, 23 Sep 2019 15:19:57 +0800
Message-Id: <1569223201-1490-1-git-send-email-yiboz@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series fix some issues when enabling virtual time-based airtime scheduler on ath10k.

Changes since v2:
  Changes station airtime weight to be per-AC based to avoid sync issue
  Remove Co-developed-by and Toke's sign-off as Toke suggested

Changes since v1:
  Modify the author of Co-developed-by as Johannes suggested

Toke Høiland-Jørgensen (1):
  mac80211: Switch to a virtual time-based airtime scheduler

Yibo Zhao (3):
  mac80211: defer txqs removal from rbtree
  mac80211: fix low throughput in multi-clients situation
  mac80211: Sync airtime weight sum with per AC synced sta airtime
    weight together

 include/net/mac80211.h     |  16 ++-
 net/mac80211/cfg.c         |  29 ++++-
 net/mac80211/debugfs.c     |  48 +++++++-
 net/mac80211/debugfs_sta.c |  18 +--
 net/mac80211/ieee80211_i.h |  17 ++-
 net/mac80211/main.c        |   8 +-
 net/mac80211/sta_info.c    |  25 +++-
 net/mac80211/sta_info.h    |   8 +-
 net/mac80211/tx.c          | 282 +++++++++++++++++++++++++++++++++------------
 9 files changed, 347 insertions(+), 104 deletions(-)

-- 
1.9.1

