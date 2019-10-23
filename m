Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19105E172A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 11:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390977AbfJWJ7J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 05:59:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34242 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390880AbfJWJ7I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 05:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571824746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4pXgKJBnjUz11VWkqBfpqr53KxozwKIwmkHNMl/9+zw=;
        b=NDx7S6J4fA/4f3EuZDsZlT6s8cO3foIBPcrOzstME/fF4ziUsTGTq6OCikRa4Q1dCHm63A
        9yB09C0k8mJXa3cd4TzF1gbSdC7ho9zj4Dj7ySPFfmNvMCs+pqmFsxwmcGgqyjpwtfDK6K
        Gu8iW7cmQA2daq0GbZaqnAMJxnrEUbA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-4ASlbAE7P7amH3nTw0yGVA-1; Wed, 23 Oct 2019 05:59:03 -0400
Received: by mail-lf1-f72.google.com with SMTP id p15so4022246lfc.20
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2019 02:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=3MdYMdnRKSV1nWFKnq3bdn9+gHDBMXYlX8Fslkg9MNs=;
        b=jmo/ffuZz/jugkz+SU7hVBAro1crU0weHmsh85JRPZwkYUHiFxeohwwD0+RIBkJT8p
         T84r+i51cQb/w3IeLBbFinVy2aE860/uo29nukYOhurpC1Qw8hSdsJhYX9JpcaDlU5Sl
         +566xwD4LtnG4cROALZUZdeiUe04oejHYrhrQuSw08gGJ51tcE2wXBBY6D+O/8tJ3RNT
         tx0OyUZQJKyeDyf06OnsyzM0YKVjKwNg7GAD3ZZkOTC/wOEaQ/+I9l8SCjb0Ke73EuPW
         wjuUlvGU2pva9QQdY3b34jB9YRvDYDjbVJwEg5eSQAOkK7HhGwR7cMkiOZ3Pt0IfCZvI
         Xf7g==
X-Gm-Message-State: APjAAAWf1S2wj32i9N5P5gpfn9oxaHB7rBAUTSiqEgLk5qKYHy3EwiVa
        NyZabZECKn4IwZAFtZ3FvrZBZn4oQno4An+8R1VCwyzW+NLZvuwLXwI4WDEjuCm35xRFrk0sq+I
        r4CiTeRw0SWVYRjcvWipPb00BvkU=
X-Received: by 2002:a19:ad0c:: with SMTP id t12mr21890688lfc.149.1571824742220;
        Wed, 23 Oct 2019 02:59:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxsccYFxdpe6TJ9G5owaW/IC69cMu7dyocQsa5i4gjDIRydu1slZLTJ+S7n4J8F2QYqIktmXA==
X-Received: by 2002:a19:ad0c:: with SMTP id t12mr21890675lfc.149.1571824742010;
        Wed, 23 Oct 2019 02:59:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id x5sm12560666lfg.71.2019.10.23.02.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 02:59:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9B33A1804B1; Wed, 23 Oct 2019 11:58:59 +0200 (CEST)
Subject: [PATCH v6 0/4] Add Airtime Queue Limits (AQL) to mac80211
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Wed, 23 Oct 2019 11:58:59 +0200
Message-ID: <157182473951.150713.7978051149956899705.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
X-MC-Unique: 4ASlbAE7P7amH3nTw0yGVA-1
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
testing). So I'm hoping someone with a proper testing setup can take the wh=
ole
thing for a spin... :)

The series is also available in my git repo here:
https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/log/?h=3Dmac=
80211-aql-06

Changelog:

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
      mac80211: Shrink the size of ack_frame_id to make room for tx_time_es=
t
      mac80211: Import airtime calculation code from mt76
      mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue


 include/net/cfg80211.h     |    7 +
 include/net/mac80211.h     |   45 +++++
 net/mac80211/Makefile      |    3=20
 net/mac80211/airtime.c     |  390 ++++++++++++++++++++++++++++++++++++++++=
++++
 net/mac80211/cfg.c         |    2=20
 net/mac80211/debugfs.c     |   78 +++++++++
 net/mac80211/debugfs_sta.c |   43 ++++-
 net/mac80211/ieee80211_i.h |    8 +
 net/mac80211/main.c        |    9 +
 net/mac80211/sta_info.c    |   32 ++++
 net/mac80211/sta_info.h    |    8 +
 net/mac80211/status.c      |   33 ++++
 net/mac80211/tx.c          |   69 +++++++-
 13 files changed, 709 insertions(+), 18 deletions(-)
 create mode 100644 net/mac80211/airtime.c

