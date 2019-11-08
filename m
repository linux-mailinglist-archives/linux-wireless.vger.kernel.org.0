Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E630CF57D1
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 21:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbfKHTm0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 14:42:26 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:46154 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbfKHTmZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 14:42:25 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 12A1F13C283;
        Fri,  8 Nov 2019 11:42:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 12A1F13C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1573242145;
        bh=BJb4vVZjGrUl9yDgrxCFDoWZAcBHhkUyLSCkxbGjPIo=;
        h=From:To:Cc:Subject:Date:From;
        b=MLW9C7G9ifeZxNBTU/irnyeQr0x+cfy3aWa9hrc6iPIvR0xjBWu95TRdZOchJv+UI
         gjbbFboGl6YdRruPjHqlVKyUt4w+8gfdB6difWSOcJ1rlxb06wc/pJm12Z5993jBAD
         LbwLtmfD3x2vOKNQ2GzIsnLoI+4S0TDtbB9j98JI=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 00/10] Ben's grab bag of mac80211 patches
Date:   Fri,  8 Nov 2019 11:42:01 -0800
Message-Id: <20191108194210.23618-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Here are some patches from my tree, freshly applied and compile tested on top of
upstream 5.4.0-rc6.  One incorporates a fix suggested back in 2013 :)

There should not be much dependencies between these, so just
skip any you don't want.

Ben Greear (10):
  mac80211: Add comment about tx on monitor devs.
  mac80211: Change warn-on to warn-on-once
  mac80211: Don't spam kernel with sdata-in-driver failures.
  mac80211: Don't spam so loud about warned-sdata-in-driver.
  mac80211: Improve connection-loss probing.
  mac80211: Make max-auth-tries configurable as module option
  mac80211: Revert some of e8e4f5, fixes setting single rate in ath10k.
  mac80211: Support decrypting action frames for reinsertion into the
    driver.
  mac80211: Use warn-on-once for queue mis-configuration.
  mlme: Don't unlink bss on assoc timeout and similar.

 include/net/mac80211.h     | 10 +++++
 net/mac80211/cfg.c         |  6 ++-
 net/mac80211/debug.h       |  3 ++
 net/mac80211/driver-ops.c  |  9 ++++
 net/mac80211/driver-ops.h  | 36 ++++++++++++++--
 net/mac80211/ieee80211_i.h |  3 +-
 net/mac80211/iface.c       |  7 ++++
 net/mac80211/mlme.c        | 84 +++++++++++++++++---------------------
 net/mac80211/rx.c          |  2 +-
 net/mac80211/tx.c          |  6 +++
 net/mac80211/util.c        |  5 ++-
 11 files changed, 115 insertions(+), 56 deletions(-)

-- 
2.20.1

