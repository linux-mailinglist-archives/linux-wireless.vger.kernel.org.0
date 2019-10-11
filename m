Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFBFD377C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2019 04:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfJKCYU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Oct 2019 22:24:20 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:44778 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfJKCYU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Oct 2019 22:24:20 -0400
Received: by mail-vk1-f202.google.com with SMTP id b204so2919388vkb.11
        for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2019 19:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pUbhQpJqyQJujGGClNz5rGmi70325W4vJGIc//2AsLU=;
        b=TZpDuH+CtoaZW48xbK27bT8Enq+cfoyxNqz92gTog1NMcRv7axdRUt8GE1jRFig2yl
         dADCRJ4LoasiDbn4RtpXrlUjHr1VgguwFY+OkzpFxTZwDZrUQGIzs2clK+JF6/9/n4QA
         pXPG7JS+/kMnOTbrupQrdIiaxRdZ+ENo/rjxMVQux/hI8ZR11FLDETY20TcOk5RQVH3o
         vu7XpXIJCnnMDwAhVhbBGpCAO5Bx1ud9L7NiViyWoPpDkX9NH7GZ0vB0OfrUte2JBjJ0
         T3CA+Ph/1o5OZTRaATzD3Wu2m31eRR5JXfTZFirBX3UebEwlMwlv/Uy4wFqDU44Sj1+8
         93bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pUbhQpJqyQJujGGClNz5rGmi70325W4vJGIc//2AsLU=;
        b=SWRJcv0YoSGE9YyWc2EivlHqdoH/iTrbD24wE/aUkYYkvQKL9gScusk/hc0saldVpg
         ozSgzn2lVQqzWdbMu/kOqGJOZB3tei+o5GOBXNv3lZta2Qd8QUv3Iq0IDr+fXiQ5R929
         jzN7J24PoblijqNqE+YWR5TNm69EKylA3JNoFnGh9MY5AXDAySWaOEt3epYcAQaIbXjq
         i6jOFnkVxZD5RZ7MK/8Krc3mo0AYlt25dqE3zY/8DHAb3sD9mYoig7CiUTTDoRxl5SBU
         8s7G8KgH6F7k/nA1cDSr9DNKO3Ung8SlyOZs8qxyIiHYh2F5LIJrM0kEjjzVIdLiQsv7
         m8qQ==
X-Gm-Message-State: APjAAAXPqiS7xJ5GHRaCuc9gOWue2c+6HQ5T7S0GXa+LKOhMMe6jN3J/
        guCAWHEYTulnzryJPBltcjpimkBy
X-Google-Smtp-Source: APXvYqxY3q2B3RSwzFSwc+FyjuVBvP5Fj90jJy/rxeafgUwzP3vNGN4KnVt5cfm9v1T2wdN74PDWYXeB
X-Received: by 2002:a67:f4c4:: with SMTP id s4mr7526195vsn.185.1570760658126;
 Thu, 10 Oct 2019 19:24:18 -0700 (PDT)
Date:   Thu, 10 Oct 2019 19:24:11 -0700
Message-Id: <20191011022413.176208-1-kyan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v4 0/2] Implement Airtime-based Queue Limit (AQL)
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
 drivers/net/wireless/ath/ath10k/mac.c    |  6 +-
 drivers/net/wireless/ath/ath10k/txrx.c   | 11 +++-
 include/net/cfg80211.h                   |  7 +++
 include/net/mac80211.h                   | 47 ++++++++++++++
 net/mac80211/debugfs.c                   | 78 ++++++++++++++++++++++++
 net/mac80211/debugfs_sta.c               | 43 ++++++++++---
 net/mac80211/ieee80211_i.h               |  4 ++
 net/mac80211/main.c                      |  9 ++-
 net/mac80211/sta_info.c                  | 33 ++++++++++
 net/mac80211/sta_info.h                  |  4 ++
 net/mac80211/tx.c                        | 46 +++++++++++++-
 12 files changed, 270 insertions(+), 19 deletions(-)

-- 
Changes from v1:
 - Fix checkpatch error.
 - Keep iterate the list of active_txq until an eligible txq's deficit become non-negative in ieee80211_next_txq(), instead of break the loop after one iteration.
 - Enforce the AQL limit in ath10k's pull mode in ath10k_htt_rx_tx_fetch_ind()

Changes from v2:
 - More coding style fixes.
 - Fixed a bug that txq is not removed from the active_txqs list when txq.sta is null.
 - Removed AQL queue limit check from ieee80211_txq_may_transmit(), so at least one frame will be sent to the firmware when called from ath10k_htt_rx_tx_fetch_ind() in ath10k's poll mode.

Changes from v3:
 - Coding style fixes.
