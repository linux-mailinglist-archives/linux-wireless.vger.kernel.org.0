Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E090D1E64
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2019 04:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbfJJCZR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 22:25:17 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35142 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfJJCZR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 22:25:17 -0400
Received: by mail-pl1-f202.google.com with SMTP id o12so2887484pll.2
        for <linux-wireless@vger.kernel.org>; Wed, 09 Oct 2019 19:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8pgq/CJPBzYHme4OP1iERhbwcRrWZJInlW+BNY7gFGQ=;
        b=LjVT4DuRP3siHRjeM97PhfGmplfGen12OwmQ/PglT1ts58sTq0z7wHlH4XZaxJjS9Q
         ps5L/a0WZkQIhMa0yDjEmHNLmSloFtMavUbQ987AoeZsgT4ZzebHeScsczTJ/Ke6C4zE
         iMBSnQj+F816TbJp5d6J0q6Hzfuw01ui3/OgwtxlFGnCFRsJDQqosXIKWrVyzEFsMntr
         DMr34pV93QqU56dtV+RyedGcSG6n1I2tOjzyBGr2B+78849IQV/E30bhm1DcRAvUgtLh
         PBI3mTdmTvTJthmO4dFIX6gFb9Nu675VXuSnZOxtwg62gbWisX1wohkn4auq7+PhbeU4
         YX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8pgq/CJPBzYHme4OP1iERhbwcRrWZJInlW+BNY7gFGQ=;
        b=lRE5/tPrSAv0xB8tOIvJTP408IW7EPZpo5z4ExJJVf8uaR2Gkrgt0sjnyJci/KHmW1
         efUxES9bwZGmAkhcddBfaSVcMg9fxPLCuRgtzjQKh/4iiO6U2UcwJoIWyZx0RePtYDCy
         RqJUoV0onArdhNMwpYQnRDrbtVr6I68KOg9TKSwl5D7EE2fxNgx6H5gELO7eu7aDZQui
         k7fOgR3j6Drfe/lmy41mET3fRA+ZWPUleOZMcHi2WKArERtFGD2YPYLOsVhES/Umjq8w
         gfmKmdEHQGjnP2UjXHsQAdUm3HjWtEQ5TSe7o8j9kc/ivyl4fK80MvIYTZl4lqxQkD0e
         Umdw==
X-Gm-Message-State: APjAAAVfWBeGS25NCzvwX4g7x9PZJXnNexyJOgmYPtaWef0Uv1+KoEUB
        DBt/T3Ux6ScWy85Q30kvIxBw6emJ
X-Google-Smtp-Source: APXvYqy2xg8KKbFIWzroLfW1okl9kYDSxQOdVYCJHqgcIuAc4XhwwuPotnFKnIzAsaNDtLnuBbcfORnP
X-Received: by 2002:a63:4046:: with SMTP id n67mr7304981pga.200.1570674315898;
 Wed, 09 Oct 2019 19:25:15 -0700 (PDT)
Date:   Wed,  9 Oct 2019 19:25:00 -0700
Message-Id: <20191010022502.141862-1-kyan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v3 0/2] Implement Airtime-based Queue Limit (AQL)
From:   Kan Yan <kyan@google.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, ath10k@lists.infradead.org, yiboz@codeaurora.org,
        Kan Yan <kyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series implements Airtime-based Queue Limit (AQL) in the mac80211 and Ath10k driver. It is based on an earlier version from the ChromiumOS tree[0].

This version has been tested with QCA9884 platform with 4.14 kernel. Tests show AQL is able to reduce latency by an order of magnitude in a congested environment without negative impact on the throughput.

[0] https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1703105/7

Kan Yan (2):
  mac80211: Implement Airtime-based Queue Limit (AQL)
  ath10k: Enable Airtime-based Queue Limit (AQL)

 drivers/net/wireless/ath/ath10k/htt_rx.c |  1 +
 drivers/net/wireless/ath/ath10k/mac.c    |  8 ++-
 drivers/net/wireless/ath/ath10k/txrx.c   | 11 +++-
 include/net/cfg80211.h                   |  7 +++
 include/net/mac80211.h                   | 43 +++++++++++++
 net/mac80211/debugfs.c                   | 78 ++++++++++++++++++++++++
 net/mac80211/debugfs_sta.c               | 43 ++++++++++---
 net/mac80211/ieee80211_i.h               |  4 ++
 net/mac80211/main.c                      |  8 ++-
 net/mac80211/sta_info.c                  | 30 +++++++++
 net/mac80211/sta_info.h                  |  4 ++
 net/mac80211/tx.c                        | 46 +++++++++++++-
 12 files changed, 263 insertions(+), 20 deletions(-)

-- 
Changes from v1:
 - Fix checkpatch error.
 - Keep iterate the list of active_txq until an eligible txq's deficit become non-negative in ieee80211_next_txq(), instead of break the loop after one iteration.
 - Enforce the AQL limit in ath10k's pull mode in ath10k_htt_rx_tx_fetch_ind()

Changes from v2:
 - More coding style fixes.
 - Fixed a bug that txq is not removed from the active_txqs list when txq.sta is null.
 - Removed AQL queue limit check from ieee80211_txq_may_transmit(), so at least one frame will be sent to the firmware when called from ath10k_htt_rx_tx_fetch_ind() in ath10k's poll mode.
