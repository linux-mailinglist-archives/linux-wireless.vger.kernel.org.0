Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9277EF86C1
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 03:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfKLCLt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Nov 2019 21:11:49 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:47375 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfKLCLt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Nov 2019 21:11:49 -0500
Received: by mail-pf1-f202.google.com with SMTP id w16so14201268pfq.14
        for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2019 18:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=c0XkcrBbJmn29isoFMJEpXbj1UComGd5lQPbOm8JDH4=;
        b=lb69U/VDW4oJRpPtad/zFO6hoHDkbIoi6r9KeWVcPbM4nd3NhoOvPHspF6Nesfbiod
         s8IB1577nEQWxpuHHmFTppPfyFaZZZQwtLbdKATaMsUbPUbFEe7eboVKprrmkefqKIM6
         DE2INLVTNau9QW9tSfJZ34ZJm3wAjiD0Upnqy7tc+ombLue6OcVx+7Y/bOmpsZbVfvbv
         erpcqCm6ljiugGWBQP/Vg5g0hU7XFwKlIFOoMyS59ttixqfNt4RS7fDglSJs/SbtR2qA
         F4lUsqxkk7vMd47REMt8eUVCO+HySqVDlpmZHXD8wnrX9JnMy8yyYYhlrqVolfVQnp3G
         cvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=c0XkcrBbJmn29isoFMJEpXbj1UComGd5lQPbOm8JDH4=;
        b=IlyH+rFDWX6/k64wNTsyDw/oAtV6HkI8jRjakIFh0w/9RKl/gdexxtYk/ALX9jQ2sI
         ooWTi4N5M17IcUO/tOQknGr8GwdXlG/eldws91UHvvjCB9XEV5956kZSO/HA3hPBkT2m
         mpt0FwIfk5lHR4/kyo1sIallWuDMa18/jhin8GPgrshBbG3BJGPwpPNYP3/pxM2/nczd
         sQ5UBn519Vtz2CLzw2cRPEJNPLwS++Axor/nGHA9DVRCfRzIfEjL2wDQahOTH8irw5rQ
         k5K92cIj6jRHPNJmA5r8OxPmlCzoc37Ni4cEMKuSQ+GO2q1eLIvt0bGh0e+eEv+z5Fus
         yUrQ==
X-Gm-Message-State: APjAAAXGc1RN2eOQ2yhFkQWznPGCsuqVzgUJklSAYmS93yCas12pO6Eo
        isMLFG6VYpjp72USI+DhRkzTAKOD
X-Google-Smtp-Source: APXvYqy4IoJMxQUq60MN9iUa2HaVUHGz6vX8IFK1GFwVwUyREO+5oOUInz3I95lOGmpkpiSyNyDIFyVj
X-Received: by 2002:a65:670d:: with SMTP id u13mr21326060pgf.19.1573524708148;
 Mon, 11 Nov 2019 18:11:48 -0800 (PST)
Date:   Mon, 11 Nov 2019 18:11:34 -0800
Message-Id: <20191112021136.42918-1-kyan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v7 0/2] Implement Airtime-based Queue Limit (AQL)
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

This patch series has been tested on QCA9984 plaform.

[0] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/1703105/7

Changelog:

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

Toke H=C3=B8iland-J=C3=B8rgensen (1):
  mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue

 include/net/cfg80211.h     |  7 ++++
 include/net/mac80211.h     | 12 ++++++
 net/mac80211/debugfs.c     | 78 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/debugfs_sta.c | 43 ++++++++++++++++-----
 net/mac80211/ieee80211_i.h |  4 ++
 net/mac80211/main.c        | 10 ++++-
 net/mac80211/sta_info.c    | 40 +++++++++++++++++++
 net/mac80211/sta_info.h    |  8 ++++
 net/mac80211/status.c      | 33 ++++++++++++++++
 net/mac80211/tx.c          | 68 +++++++++++++++++++++++++++++++--
 10 files changed, 289 insertions(+), 14 deletions(-)

--=20
2.24.0.rc1.363.gb1bccd3e3d-goog

