Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEF510182A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 07:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfKSGGU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 01:06:20 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:34458 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbfKSGGU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 01:06:20 -0500
Received: by mail-pf1-f202.google.com with SMTP id z10so12730846pff.1
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 22:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=B8/EcY6i2w+bx7VVAlHm/6r6F+6BZA3JBunb1qXy/gQ=;
        b=GP/xri5JkGhW0+E0Y1n4CGlJOnnc4hfeXQREKh4dvuYaWaF7OEBoWj6Y7PPkcClRD2
         dbHf6qkkRo9S4Pt/43QZzFCV3J5ckdSKt7prpD+43g7Aolreijfd+jGMZxBg7oX9FnD9
         oe9cQrWnRy/JcF0aSyBJJF7quL4oqsacKmOfshnpEAfkSgb0S/UdeXlRHuj1pwVQiq1W
         s21x2l8PW+etOyjBkABLINaY8rK0Bm5SrYaOdCUMKNJDjEifQgDYS5IM609Aa4R383/Y
         pghLer1oj/KpgR7bYF60mNbMBrRnigX3GuJHVlm58cnQp3LmONurLqfDtndq42k34i1L
         QIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=B8/EcY6i2w+bx7VVAlHm/6r6F+6BZA3JBunb1qXy/gQ=;
        b=dkb0/jb6h2PFRR6zTqXd21HtLPWt7DR+idP08Lx4rykpbgYVROWQFgJOoZJYaImFe9
         y38Q+NvHNZFSoWh1d62K2meGmkcZmw4C4WALUHXPkjnemwP4ZiyJicMF05dOmsn2LVWL
         aDmKDkvE9joJtYuQIdzEDtUah8czlbN2JPREDLMft8tVeauORiZafRCVZGM41d12ZdPA
         /n4A9gyhfackAM74EOZ1UR8UeL7cRunP56kAHhjWZ/XgFMVXQRwDxLQLvFlhc9VnsNe/
         0qTXfyfEOC3E3QDspmOf9XPrlWRYQ48NnUWh9pQRByhoXYDle+LOBEljy5CRcC/8sO1F
         RWRA==
X-Gm-Message-State: APjAAAWEUvQ4k3PAGBHlBn1chd8HXplzPFd71DE1NUhiSvuEW/ZBfNeu
        Wd/I4JHapXQ/hxUBQie1VCeZ0qhK
X-Google-Smtp-Source: APXvYqxjvz9dZuhQhe5e4/6Xh2YXjB73qE0U7FjfHCreLc7wQmwWHMMKHqjMGBXUcVKVeoIbFX1J1dFF
X-Received: by 2002:a63:731a:: with SMTP id o26mr3681569pgc.108.1574143577688;
 Mon, 18 Nov 2019 22:06:17 -0800 (PST)
Date:   Mon, 18 Nov 2019 22:06:06 -0800
Message-Id: <20191119060610.76681-1-kyan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v11 0/4] Add Airtime Queue Limits (AQL) to mac80211
From:   Kan Yan <kyan@google.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, yiboz@codeaurora.org, john@phrozen.org,
        lorenzo@kernel.org, rmanohar@codeaurora.org, kevinhayes@google.com,
        Kan Yan <kyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is a first attempt at porting the Airtime Queue Limits concept =
from
the out-of-tree ath10k implementation[0] to mac80211. This version takes Ka=
n's
patch to do the throttling in mac80211, and replaces the driver API with th=
e
mechanism from the previous version of Toke's series, which instead calcula=
ted the
expected airtime at dequeue time inside mac80211, storing it in the SKB cb
field.

This series also imports Felix' airtime calculation code from mt76 into
mac80211, adjusting the API so it can be used from TX dequeue, by extractin=
g the
latest TX rate from the tx_stats structure kept for each station.

This series has been tested on the QCA9984 platform. The test data can be f=
ound in:
https://drive.google.com/drive/folders/16Th2PljrKXVWDgM1pqDredMdSNcqJGOB

[0] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/1703105/7

Changelog:

v11:
  - Fix softlockup in ieee80211_next_txq()
  - Increase the default queue limit

v10:
  - Fix return value from ieee80211_info_set_tx_time_est()

v9:
  - Use atomic_sub_return() instead of separate atomic_sub() and atomic_rea=
d()
  - Add getter/setter for tx_time_est
  - Use get_sta_info_by_addrs() to find the station in
    ieee80211_report_used_skb()
  - Integrate everything back into one series

v8:
  - Includes Toke's v7 version of "mac80211: Import airtime calculation cod=
e from mt76"
  - Don't clobber sta's customized queue limit when configuring the default=
 via debugfs
  - Fix a racing condition when reset aql_tx_pending.

v7:
  - Fix aql_total_pending_airtime underflow due to insufficient locking.

v6:
  - Fix sta lookup in ieee80211_report_used_skb().
  - Move call to ieee80211_sta_update_pending_airtime() to a bit later in
    __ieee80211_tx_status()
v5:
  - Add missing export of ieee80211_calc_rx_airtime() and make
    ieee80211_calc_tx_airtime_rate() static (kbuildbot).
  - Use skb_get_queue_mapping() to get the AC from the skb.
  - Take basic rate configuration for the BSS into account when calculating
    multicast rate.
v4:
  - Fix calculation that clamps the maximum airtime to fit into 10 bits
  - Incorporate Rich Brown's nits for the commit message in Kan's patch
  - Add fewer local variables to ieee80211_tx_dequeue()
v3:
  - Move the tx_time_est field so it's shared with ack_frame_id, and use un=
its
    of 4us for the value stored in it.
  - Move the addition of the Ethernet header size into ieee80211_calc_expec=
ted_tx_airtime()
v2:
  - Integrate Kan's approach to airtime throttling.
  - Hopefully fix the cb struct alignment on big-endian architectures.

Kan Yan (1):
  mac80211: Implement Airtime-based Queue Limit (AQL)

Toke H=C3=B8iland-J=C3=B8rgensen (3):
  mac80211: Add new sta_info getter by sta/vif addrs
  mac80211: Import airtime calculation code from mt76
  mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue

 include/net/cfg80211.h     |   7 +
 include/net/mac80211.h     |  57 ++++
 net/mac80211/Makefile      |   3 +-
 net/mac80211/airtime.c     | 597 +++++++++++++++++++++++++++++++++++++
 net/mac80211/debugfs.c     |  85 ++++++
 net/mac80211/debugfs_sta.c |  43 ++-
 net/mac80211/ieee80211_i.h |   8 +
 net/mac80211/main.c        |  10 +-
 net/mac80211/sta_info.c    |  58 ++++
 net/mac80211/sta_info.h    |  11 +
 net/mac80211/status.c      |  36 ++-
 net/mac80211/tx.c          |  69 ++++-
 12 files changed, 961 insertions(+), 23 deletions(-)
 create mode 100644 net/mac80211/airtime.c

--=20
2.24.0.432.g9d3f5f5b63-goog

