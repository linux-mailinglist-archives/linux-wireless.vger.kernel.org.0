Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6854735162
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2019 22:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfFDUxi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Jun 2019 16:53:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38996 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfFDUxi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Jun 2019 16:53:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2so13409958pfe.6
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jun 2019 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gruPFlVVyS4OxQK3/Q59YreJPgKRxWAs8F6mM68ird0=;
        b=IKnJi1FlMevrgtGn8TeswKeGDAwgN7EYyZ3FFApF9iNkUD2wUJZL6r/aQ00ict3TGV
         ROBfLrskBDVWg1WAfQdKcN/u0lhaGPHlKQgotl5/D391Z3NuN4NOSLGiEH5ATxaN8OVY
         7ed77bU1xqalexXPqGWLT3t8fiNPr8Tt991HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gruPFlVVyS4OxQK3/Q59YreJPgKRxWAs8F6mM68ird0=;
        b=lW4aDvGyK+Eb8GbRk8VgKgJkw3gBtSlXzlm/y4i8i1b0G7ycsqE+uJ/FuWHHDWDZr7
         vhp3PNVM9iQV2uLBk8u7s7t0Nw+4PMeqxzq06wrUm7y8g3jJ6/NAzFP4ZhZxN9sFjYbs
         cFfCh2EOINXlXCYMc4C3H3IgockwAx1wwACAa9A+pGiKOeE4q2+o1VRAT/5qKUZrjtXL
         gauSYbagpJr+02IT9aeZoBGAhcKHizYURhTMykcAiNHo8xy6y8Ff+6e9F9pPmS7J1dmY
         QEFLeEJr01F8wuNJX+yh4QtiVKLprVjrd2t3kknb/XEtghiwtdhxVEgncfus7GC3jea8
         dvBA==
X-Gm-Message-State: APjAAAVc16H3MGAM0rRfBc0QpB76658U48r0ZNRyvWWWllzEqppJnyWd
        4BW0X0DNlcUCKT+AWTnQjzREmQ==
X-Google-Smtp-Source: APXvYqwC4tUyV6LN0n8dHVSZTPwtyuQc+MFJYqWpQKhpmQzcNKMrmzZYHfOSJnItRmJt3Bn7d/8qMQ==
X-Received: by 2002:a63:ff23:: with SMTP id k35mr615831pgi.139.1559681617542;
        Tue, 04 Jun 2019 13:53:37 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id b128sm13870876pfa.165.2019.06.04.13.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 13:53:36 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/2] mwifiex: spinlock usage improvements
Date:   Tue,  4 Jun 2019 13:53:21 -0700
Message-Id: <20190604205323.200361-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series follows up on some notes from this thread:

  http://lkml.kernel.org/linux-wireless/20181130175957.167031-1-briannorris@chromium.org
  Subject: [4.20 PATCH] Revert "mwifiex: restructure rx_reorder_tbl_lock usage"

where Ganapathi suggested I send out my work. So here goes.

In particular, patch 1 is a step toward helping apply Ganapathi's
original "mwifiex: restructure rx_reorder_tbl_lock usage" solution
without regression, by logically separating the two operations (and
therefore, the locking patterns) involved in that deadlock. It doesn't
re-apply that change, nor does it 100% unblock such a solution, but at
least it's a step in the right direction, as I understand it.

Patch 2 is a change I noticed should be possible along the way. There
are a number of reasons we probably shouldn't be disabling hardirqs when
it's not necessary, but one funny side effect: bugs noticed in the above
"revert" patch would no longer happen. This is because
mwifiex_recv_packet() bases softirq decisions on in_interrupt() (see
description in include/linux/preempt.h), so it will automatically skip
softirq processing if we have BH disabled, but not if we only have hard
IRQs disabled. In other words, if we have such an incorrect nesting bug
in the future (this time with BH disabled), we will now skip softirq
processing and therefore sidestep this sort of bug. [1]

[Related note: softirq masking is weird:
https://lwn.net/Articles/779738/]

It's also possible we can improve system responsiveness and
debuggability by keeping (hard) IRQs enabled more often, although I
didn't measure any particular effect here, and most of these contexts
should be rather quick.

I've done a variety of performance and stress tests for this series, on
both 8897/SDIO and 8997/PCIe, and I haven't seen any decrease in
performance or stability. Or, any change in performance appears to be
within the range of "noise".

I'd appreciate any testing others can do on this series though, as
Ganapathi did offer to try this out.

Regards,
Brian

[1] Side note: the usage of 'in_interrupt()' in mwifiex_recv_packet() is
probably not really a good idea. But it does have a helpful side effect
for this particular sort of bug.


Brian Norris (2):
  mwifiex: dispatch/rotate from reorder table atomically
  mwifiex: don't disable hardirqs; just softirqs

 drivers/net/wireless/marvell/mwifiex/11n.c    |  53 +++-----
 drivers/net/wireless/marvell/mwifiex/11n.h    |   5 +-
 .../net/wireless/marvell/mwifiex/11n_aggr.c   |  24 ++--
 .../wireless/marvell/mwifiex/11n_rxreorder.c  | 125 ++++++++----------
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  35 +++--
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |  76 +++++------
 drivers/net/wireless/marvell/mwifiex/init.c   |  32 ++---
 drivers/net/wireless/marvell/mwifiex/main.c   |  29 ++--
 drivers/net/wireless/marvell/mwifiex/scan.c   |  58 ++++----
 .../wireless/marvell/mwifiex/sta_cmdresp.c    |   5 +-
 .../net/wireless/marvell/mwifiex/sta_event.c  |  10 +-
 drivers/net/wireless/marvell/mwifiex/tdls.c   |  68 ++++------
 drivers/net/wireless/marvell/mwifiex/txrx.c   |   5 +-
 .../net/wireless/marvell/mwifiex/uap_txrx.c   |  10 +-
 drivers/net/wireless/marvell/mwifiex/usb.c    |  10 +-
 drivers/net/wireless/marvell/mwifiex/util.c   |  15 +--
 drivers/net/wireless/marvell/mwifiex/wmm.c    |  92 +++++--------
 17 files changed, 269 insertions(+), 383 deletions(-)

-- 
2.22.0.rc1.311.g5d7573a151-goog

