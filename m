Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4C6811DE93
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 08:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfLMHYQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 02:24:16 -0500
Received: from m228-4.mailgun.net ([159.135.228.4]:56813 "EHLO
        m228-4.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfLMHYQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 02:24:16 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Dec 2019 02:24:15 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576221855; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=WLCDqno1s3uHYEMChVxX5DZEV90VVhx2NHGKrO4DQg8=; b=iZwMc/o4flh08wBWmnXZUSEgK2a84qwNChXYIZVwZdyvXUogVTpKAEEaZxnVoXdyaRUjGlRX
 w2SJ3/AnntmZze8BBKksY6bA4WGI+kaMVlRznvFrE6VAF4za7WUJ4ERDxr/ICP1xYcKw18SB
 KWsj4Neqqr3H5uAAWY00JKCDro4=
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df33b6f.7f33931077a0-smtp-out-n03;
 Fri, 13 Dec 2019 07:19:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5CD61C433A2; Fri, 13 Dec 2019 07:19:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from ybzhao-HP-Z230-SFF-Workstation.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: yiboz)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 00A10C43383;
        Fri, 13 Dec 2019 07:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00A10C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=yiboz@codeaurora.org
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org, Yibo Zhao <yiboz@codeaurora.org>
Subject: [PATCH V4 0/4] Enable virtual time-based airtime scheduler support on ath10k
Date:   Fri, 13 Dec 2019 15:19:49 +0800
Message-Id: <1576221593-1086-1-git-send-email-yiboz@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series fix some issues when enabling virtual time-based airtime scheduler on ath10k.

Changes since v3:
  Change schedule_pos to previous node once it has chance to be moved/removed
  from current position in the tree in loop scenario and bring back schedule_round
  in case that same node is to be scheduled again in the mean time.

  Increase airtime grace period to 2000 us in the first patch.

  Put per-AC station weight checking in its lock during configuration from application.

Changes since v2:
  Changes station airtime weight to be per-AC based to avoid sync issue
  Remove Co-developed-by and Toke's sign-off as Toke suggested

Changes since v1:
  Modify the author of Co-developed-by as Johannes suggested

Toke Høiland-Jørgensen (1):
  mac80211: Switch to a virtual time-based airtime scheduler

Yibo Zhao (3):
  mac80211: fix issue in loop scenario
  mac80211: fix low throughput in multi-clients situation
  mac80211: Sync airtime weight sum with per AC synced sta airtime
    weight together

 net/mac80211/cfg.c         |  29 +++++-
 net/mac80211/debugfs.c     |  48 +++++++++-
 net/mac80211/debugfs_sta.c |  18 ++--
 net/mac80211/ieee80211_i.h |  12 ++-
 net/mac80211/main.c        |   2 +-
 net/mac80211/sta_info.c    |  25 +++--
 net/mac80211/sta_info.h    |   8 +-
 net/mac80211/tx.c          | 234 +++++++++++++++++++++++++++++++--------------
 8 files changed, 278 insertions(+), 98 deletions(-)

-- 
1.9.1
