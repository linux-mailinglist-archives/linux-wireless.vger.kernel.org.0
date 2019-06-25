Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39DB75561D
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 19:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbfFYRk5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 13:40:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34807 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfFYRk5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 13:40:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so9855931pfc.1
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2019 10:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ux77FZ9CHBjOrnDI3EGePYwTHmJ+z3DID4gfNoVBXXI=;
        b=B2tUetSMchtGW/+SGYLyVgEoxEsQnGMalqfzkjRhSWLa2CAkg9rIOWI2GrJouCvBmJ
         8SSoFbzPRXkulByCc5u2YTkbxzk3N/RPcIhBo+OM3Jz9vXdGLPi+TvGlOLoAMx10+WlV
         P/0Y1ECcoF74A7rb/2nxql5xDRiDJ7zW4eJ5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ux77FZ9CHBjOrnDI3EGePYwTHmJ+z3DID4gfNoVBXXI=;
        b=pfJCznvBIcqGyvxCYCB14Aa3u1nkRTrttsU7OEU6pRT7nHh+RDA0KaeyLRm/EHosi4
         BZEZTUIdUrGe0sCjAcMeGbZC6cOU7SpqaUoXTMlbz/ogZCT49Pep3O7+UsWr+bU8g7Hh
         nMlkw02VpQS7X+93lU2gi+G47KZIHwwnOKS3t0UX6KdsMl8FsIKb0S6kATVs2AvqD08P
         kuxfsdM9UYoChVfflWmDx111iHWIm1p0Sx999jhLYxO3ltBNZ8g8zhLIO6KlaoK0eouU
         w10OKIDy2izYXqL0JzhDC2xjPjHoV87Cn5ksxGeuDZnC3utvjB8W3YJ7Yh61rRCQLplD
         jH3g==
X-Gm-Message-State: APjAAAUjgYIMjj4bT1FP0/41C8vVKx3lk7a2F4AikAde3qbllLFoa511
        De/UWYliD8gUCfwCQcXK8GbfSQ==
X-Google-Smtp-Source: APXvYqzNDPcrCGfOG+yL1j11DnH5kFJPaIn1I4HvlZNFyLHQ4xt+OBlk/zX50Hgr1Nyc9Lq0MQAuSw==
X-Received: by 2002:a63:d60c:: with SMTP id q12mr39461181pgg.176.1561484456705;
        Tue, 25 Jun 2019 10:40:56 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id 85sm20872129pfv.130.2019.06.25.10.40.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 10:40:55 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 0/2] mwifiex: spinlock usage improvements
Date:   Tue, 25 Jun 2019 10:40:43 -0700
Message-Id: <20190625174045.125223-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series follows up on some notes from this thread:

  http://lkml.kernel.org/linux-wireless/20181130175957.167031-1-briannorris@chromium.org
  Subject: [4.20 PATCH] Revert "mwifiex: restructure rx_reorder_tbl_lock usage"

where Ganapathi suggested I send out my work.

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

Regards,
Brian

[1] Side note: the usage of 'in_interrupt()' in mwifiex_recv_packet() is
probably not really a good idea. But it does have a helpful side effect
for this particular sort of bug.

Changelog:

v2:
 * fix warnings about using uninitialized "flags" variables


Brian Norris (2):
  mwifiex: dispatch/rotate from reorder table atomically
  mwifiex: don't disable hardirqs; just softirqs

 drivers/net/wireless/marvell/mwifiex/11n.c    |  53 +++-----
 drivers/net/wireless/marvell/mwifiex/11n.h    |   5 +-
 .../net/wireless/marvell/mwifiex/11n_aggr.c   |  26 ++--
 .../net/wireless/marvell/mwifiex/11n_aggr.h   |   2 +-
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
 drivers/net/wireless/marvell/mwifiex/wmm.c    | 109 ++++++---------
 18 files changed, 278 insertions(+), 395 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

