Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC31FDECA
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 14:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfKONUn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 08:20:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22452 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727249AbfKONUm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 08:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573824041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wvUQMq8paeveUMyRBwqhvZ4bHbn1KjByxEnpWY8JuvE=;
        b=TEHRyH3EDbKB3yqAEpWDvd01bbNuL5hak+KemeKMTgj0RUwpaxfYsUzcLFXm2t1XERTzbd
        30RVxo7lm7SQT5E6c+/Zw53Z1SkC5i4pAa6uGUQdpBfXcbv5lL9X3ssz2Pf5O4Y6hLAm4p
        DQYg/tR5KNYVPluyAGLyx6XJG4JeADk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-xecscQyOPOy_h8y7ItcMWA-1; Fri, 15 Nov 2019 08:20:39 -0500
Received: by mail-lf1-f69.google.com with SMTP id x16so3064288lfe.19
        for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2019 05:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=NCGmpHEMA2O10MpUQId67Zj1BdLKlIMXN/gDOoUArOA=;
        b=EEs+17oexsLl52J5LQaTJoiygdOS34NJPah4UhVj3Q8xRsTMuwtaLzRllVKJe6tmHM
         opE9NLH/mUty4+1w9U+//Q+WPdUA0G1i5c0BGurqAJdVbWRIG9JscCsihFCx7rkBrvDe
         eEnniGw1wSpr/YyOMsUrJMEerdwePDcqGfrSydMg9kpdvMiV7urcGYZkGUGE80iKyq9d
         frgoEfEh38Skt567m6fRA3YZ6LxFebT3oefyM4eyWGEdgUuWxt+MX9PWhRKCY5dNqSmu
         Mc+Qz3YOJ7ZeifXTplvy104FeJc3bPKd1mJrYFVSO8Iiqo0VoHUPtO00MUe6BU3idXZp
         nZFA==
X-Gm-Message-State: APjAAAWOGDHDPVXQCmBYM7cGE27PuLd/VJZeVJsrrCYH9hSB+kHFGRjq
        Ztq50y4+qsz53fsRlRWww7r7dHCiKlF40tE/7JmCf5c77W5Yi7wDssOV7MuwmKUnXB31hcqw+Bl
        6Oyq9Sg1uAy6dqKsQGfBCWLpfMqs=
X-Received: by 2002:a2e:7a07:: with SMTP id v7mr11448024ljc.208.1573824038422;
        Fri, 15 Nov 2019 05:20:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqyxFXP2mNsc87Z+RQVjwHXBRrtCroQSC10ZLbV3vxKa3Ps6nbCQkVp4nUXsnYmFbTK9gcgz9A==
X-Received: by 2002:a2e:7a07:: with SMTP id v7mr11447999ljc.208.1573824038202;
        Fri, 15 Nov 2019 05:20:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id a1sm4581906lfg.11.2019.11.15.05.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 05:20:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D40151818C5; Fri, 15 Nov 2019 14:20:36 +0100 (CET)
Subject: [PATCH v9 0/4] Add Airtime Queue Limits (AQL) to mac80211
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Fri, 15 Nov 2019 14:20:36 +0100
Message-ID: <157382403672.580235.12525941420808058808.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-MC-Unique: xecscQyOPOy_h8y7ItcMWA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
mechanism from the previous version of my series, which instead calculated =
the
expected airtime at dequeue time inside mac80211, storing it in the SKB cb
field.

This series also imports Felix' airtime calculation code from mt76 into
mac80211, adjusting the API so it can be used from TX dequeue, by extractin=
g the
latest TX rate from the tx_stats structure kept for each station.

As before, I've only compile tested this (lacking the proper hardware to do=
 more
testing), but Kan has tested in on the QCA9984 platform.

The series is also available in my git repo here:
https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/log/?h=3Dmac=
80211-aql-09

[0] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/1703105/7

Changelog:

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
    __ieee80211_tx_status()=20
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

---

Kan Yan (1):
      mac80211: Implement Airtime-based Queue Limit (AQL)

Toke H=C3=B8iland-J=C3=B8rgensen (3):
      mac80211: Add new sta_info getter by sta/vif addrs
      mac80211: Import airtime calculation code from mt76
      mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue


 include/net/cfg80211.h     |    7 +
 include/net/mac80211.h     |   57 ++++
 net/mac80211/Makefile      |    3=20
 net/mac80211/airtime.c     |  597 ++++++++++++++++++++++++++++++++++++++++=
++++
 net/mac80211/debugfs.c     |   85 ++++++
 net/mac80211/debugfs_sta.c |   43 ++-
 net/mac80211/ieee80211_i.h |    8 +
 net/mac80211/main.c        |   10 +
 net/mac80211/sta_info.c    |   58 ++++
 net/mac80211/sta_info.h    |   11 +
 net/mac80211/status.c      |   36 ++-
 net/mac80211/tx.c          |   65 +++++
 12 files changed, 957 insertions(+), 23 deletions(-)
 create mode 100644 net/mac80211/airtime.c

