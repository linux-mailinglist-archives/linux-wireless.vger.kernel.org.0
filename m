Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4C1CDB19
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2019 06:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfJGEb1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Oct 2019 00:31:27 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:41972 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfJGEb1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Oct 2019 00:31:27 -0400
Received: by mail-vk1-f201.google.com with SMTP id u123so6250990vkf.8
        for <linux-wireless@vger.kernel.org>; Sun, 06 Oct 2019 21:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SlvEJivuJVpik9EELPiEmiAI6r961EG88fWr2/CrBCs=;
        b=oq+JjPTSuo7VivHm5zcXY8ilBeOsXOYBpPEKTTs7XaP/lfOYDSPyVtR135owcAdgeI
         dlkKkiEU2B7baPCX4sDRiIO7NC1NXg3shpBjRsDw14YCDkSOTtw9IfukmeCZQHDbfd4u
         c31KAFoo8GsomuYFb6E+VaQh+aGh8N8z+0GaGU78ksOLkviEgG11U57BtIO2WpApnNr6
         mBGM8QZKxdxinKf6xrt/EV+tSgaiz3LWzHS7sO+otiQzEqqA7s4uNbb/kC7BWimavtF5
         dqtSbVnITLzs5gmPdzSN0BPcivaDvEJW16O913rgDdmve08oHjNYLSGj8zBB4YRMQpMA
         Ectw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SlvEJivuJVpik9EELPiEmiAI6r961EG88fWr2/CrBCs=;
        b=OV5+Tcw3H7RrBAs1mvF4aCGw5z4/LGhnK3XIJDQsfJELljMJcv7Bgd77onqimvs+sy
         1VfCibnw7UIAdPeVciec9uqCthPjUb1WOEkMc5uyHbWkzWNSFGHU3azXncSbQu6WztC0
         7ChlycgPjymc1HtXfZUrCPJSuRh3dsRv9UIYus2S81HvfD0rm3U/T7PZlbJkEXB8RGUA
         Lu7W+zOBTQxzl7RQ81rYiJQYq840kb4DO2yHl0xC7StCQRZegcM0HsV6/xXoI08tU561
         wTo+27xnL3YajLItgisov5rrqGKEMKvl1YLL4W3EUBqt8021WhDHvTcFd/8duwDi21ov
         5J9w==
X-Gm-Message-State: APjAAAV4Sbop68dqKlPZj0vb9wkXplV0S1esr8PIU2g69G9e/tnfnBuZ
        +8BsxEYYOEP09yUOq8ruurxenZOd
X-Google-Smtp-Source: APXvYqxM0y87Lg5ycIjqnmhP27v5DYaJLIDSpzin2cfXX56OKIdqwbvf/I4wc7gQaJUaYQ992KdrfGyl
X-Received: by 2002:ab0:2b06:: with SMTP id e6mr1208074uar.127.1570422685747;
 Sun, 06 Oct 2019 21:31:25 -0700 (PDT)
Date:   Sun,  6 Oct 2019 21:31:18 -0700
Message-Id: <20191007043120.67567-1-kyan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v2 0/2] Implement Airtime-based Queue Limit (AQL)
From:   Kan Yan <kyan@google.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, yiboz@codeaurora.org, Kan Yan <kyan@google.com>
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
 drivers/net/wireless/ath/ath10k/txrx.c   | 13 +++-
 include/net/cfg80211.h                   |  7 +++
 include/net/mac80211.h                   | 29 +++++++++
 net/mac80211/debugfs.c                   | 78 ++++++++++++++++++++++++
 net/mac80211/debugfs_sta.c               | 44 +++++++++----
 net/mac80211/ieee80211_i.h               |  4 ++
 net/mac80211/main.c                      |  8 ++-
 net/mac80211/sta_info.c                  | 20 ++++++
 net/mac80211/sta_info.h                  |  4 ++
 net/mac80211/tx.c                        | 58 +++++++++++++++---
 12 files changed, 247 insertions(+), 27 deletions(-)

-- 
Changes from v1:
 - Fix checkpatch error.
 - Keep iterate the list of active_txq until an eligible txq's deficit become non-negative in ieee80211_next_txq(), instead of break the loop after one iteration.
 - Enforce the AQL limit in ath10k's pulling mode in ath10k_htt_rx_tx_fetch_ind()
