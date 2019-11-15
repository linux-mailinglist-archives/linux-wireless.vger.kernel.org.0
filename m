Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5ABDFD290
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 02:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKOBsy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 20:48:54 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:46432 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfKOBsy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 20:48:54 -0500
Received: by mail-pl1-f201.google.com with SMTP id a5so5237080pln.13
        for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2019 17:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Rbei2+oM8vnqMHv68WAZb0gF0lJnVi4eBV36M8R5sZg=;
        b=u8pensdtnNKHBUpFoZ+V6IROjr8HjW/W9q3PFTGFh4vzZprnl7RRYz+3m5FlJdE+qS
         GO2Jv3OIgzga0RMH6tcQVVvVGSzwfO+TdaZ6BblGLfnWoNUYeTdwLzRIxiBMB72uZs/n
         DgI9SA3zZcSUXiunmGpFj9EiaP/yGRRC97S+nlHRB+OG/fBKnX4K2rObYfk/zwjUxDOx
         ZlC+ielmhlxQ867Z9mwhZbUKLYm015p+DECWjtlIyGsjcz2hmyx4tqhK6DKRsdy8gYec
         +DIVdtObPDW2h7JNpMbiGdFBsACV80xZWeWb20B2oJ6g3i8bPekEj7X4hBcabOobnubm
         8kGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Rbei2+oM8vnqMHv68WAZb0gF0lJnVi4eBV36M8R5sZg=;
        b=VFNGK0bMAVO4fsVHNNI5rZukaekpFhZ77YKoomi+ne0xZ/evpxzLfd/pAbfoAl2quJ
         F7Vt+QsdmS07p8GSrzLA0te3IcVycbzqAfTuEcbokRS7RGMbXZE+wCK1y7EkBVMCn2Zj
         92sVbjCt9hfMF/fLeNNHdt3EwvSYCqCtl+gTudH/uKc8ZfPJT9wK2BIfDupi0lSsf3Gn
         zZ4yG3qpO1ncpqJ3DJ/KOV2GA3sfxgZELfHvRI9rAMOo23xZOknS3xbs9z4tCQ6dxVNf
         9oFhIekPhlZjO/xs16L5r3ePdretMezjIKMKhJVF0QptEy1EjFhxjYy+w2KGgvVvkezp
         23tw==
X-Gm-Message-State: APjAAAXwUM0Pv70nL66qOM/1M3Rx4THvWp4dv3r8qv+GkMt5qKOFKNyx
        iVKB2z51TRxn7ikDSIZtSE1Awe71
X-Google-Smtp-Source: APXvYqzYah0lBHI4T8etq2dXjQOQdO6o90bYbvm5PG6GGdXVmIEnRde0aVtfkYtvyNZ95aVrwN03JEuh
X-Received: by 2002:a63:4b52:: with SMTP id k18mr13103560pgl.394.1573782531887;
 Thu, 14 Nov 2019 17:48:51 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:48:44 -0800
Message-Id: <20191115014846.126007-1-kyan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v8 0/2] Implement Airtime-based Queue Limit (AQL)
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

This patch series port the Airtime Queue Limits concept from the out-of-tre=
e
ath10k implementation[0] to mac80211. This version takes my patch to do the
throttling in mac80211, and replaces the driver API with the mechanism from
Toke's series, which instead calculated the expected airtime at dequeue tim=
e
inside mac80211, storing it in the SKB cb field.

This version has been tested on QCA9984 platform.

[0] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/1703105/7

Changelog:

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

Toke H=C3=B8iland-J=C3=B8rgensen (1):
  mac80211: Import airtime calculation code from mt76

 include/net/cfg80211.h     |   7 +
 include/net/mac80211.h     |  41 +++
 net/mac80211/Makefile      |   3 +-
 net/mac80211/airtime.c     | 597 +++++++++++++++++++++++++++++++++++++
 net/mac80211/debugfs.c     |  85 ++++++
 net/mac80211/debugfs_sta.c |  43 ++-
 net/mac80211/ieee80211_i.h |   8 +
 net/mac80211/main.c        |  10 +-
 net/mac80211/sta_info.c    |  38 +++
 net/mac80211/sta_info.h    |   8 +
 net/mac80211/tx.c          |  47 ++-
 11 files changed, 872 insertions(+), 15 deletions(-)
 create mode 100644 net/mac80211/airtime.c

--=20
2.24.0.rc1.363.gb1bccd3e3d-goog

