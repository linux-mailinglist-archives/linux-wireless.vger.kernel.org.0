Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16415DD891
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 13:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfJSLhY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 07:37:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59444 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726246AbfJSLhY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 07:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571485043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=muExcf0yCS6wTiOGyHLKDSUQbgUBrcGix+0WiNdqPFM=;
        b=JKhq4JCww2fIggcDblObZhVrJsHyydezLAh7FjQZbRJFQ9zDPU4/puCzv+vvCOM2ebZrJO
        7KRfBvHYPS+z3hhJujMbJdYS+kjqoBC0unNsH7AkiNdRbkqdcd4kHbPzbrbBZyxooS1iK9
        TCWYf7UjmdCsg7k6vst0C3QE86mRYTA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-TVIzDl6tOHS6ihW9oUU83g-1; Sat, 19 Oct 2019 07:37:17 -0400
Received: by mail-lf1-f70.google.com with SMTP id m16so1770524lfb.1
        for <linux-wireless@vger.kernel.org>; Sat, 19 Oct 2019 04:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=qR0qPuNr+iUroIduE98U31BmbYV0VOc1XPfPgGkQcq8=;
        b=fWOAUuM09XJCFFCRmab5gX/uB9GEux6j48zk/VatHVp+4tSDQb3xn47bilYAcLfmN3
         h0raro336GqutFYmVWEmutjqSREDcp3ZhEvdgahEF4J2iLPfnf9eji/W4ODvWXTepcUe
         vVIpkw0u14vXvUF9QA5AS0TubVyZgFV0M+LO0R8aoz2lZnGNH369GASHzfehdqhcjaw4
         qt6DKTEmo1uSOE/OgJ6M6GRKbEvSuj4EZZAcHf6MZ0NRRi0mO2uJ2jnB2q6vyBaWQ5W+
         cVRuC0eA2OavCEWrVfZJxj5Nvy/fdCtzKp94EeFTS7uQ64Cdb+RbVqKjf60F4iylecun
         FjRA==
X-Gm-Message-State: APjAAAUNUKRMd4nr95nNN9TRUX6mEK1pRdhEsP/3o0S4TzGnoyvTGrhN
        pR1ck8BX/7PgX3T0MVBJcjo6mcpduJxaD4rGcRSwx7PDzHwBr+/I7Wy0+OvfATyZWHbjYmlsALN
        OXBs0wCSo5T7dR6Osi0T1xo9UkuU=
X-Received: by 2002:a19:ad4c:: with SMTP id s12mr9451097lfd.49.1571485035936;
        Sat, 19 Oct 2019 04:37:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwgYpL1rydi5XQWs/yj8s7rfZ6wHgMQtlj+W+mhe/lrCRacyZBa1z3mpBfKXWwigRyz+9hsrA==
X-Received: by 2002:a19:ad4c:: with SMTP id s12mr9451070lfd.49.1571485035712;
        Sat, 19 Oct 2019 04:37:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id 3sm6388408ljs.20.2019.10.19.04.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 04:37:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 42A901804C8; Sat, 19 Oct 2019 13:37:14 +0200 (CEST)
Subject: [PATCH v4 0/4] Add Airtime Queue Limits (AQL) to mac80211
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Sat, 19 Oct 2019 13:37:14 +0200
Message-ID: <157148503415.2989444.7391437309981941226.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
X-MC-Unique: TVIzDl6tOHS6ihW9oUU83g-1
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
80211-aql-02

Changelog:

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
 include/net/mac80211.h     |   30 +++-
 net/mac80211/Makefile      |    3=20
 net/mac80211/airtime.c     |  377 ++++++++++++++++++++++++++++++++++++++++=
++++
 net/mac80211/cfg.c         |    2=20
 net/mac80211/debugfs.c     |   78 +++++++++
 net/mac80211/debugfs_sta.c |   43 ++++-
 net/mac80211/ieee80211_i.h |    8 +
 net/mac80211/main.c        |    9 +
 net/mac80211/sta_info.c    |   32 ++++
 net/mac80211/sta_info.h    |    8 +
 net/mac80211/status.c      |   38 ++++
 net/mac80211/tx.c          |   69 ++++++++
 13 files changed, 686 insertions(+), 18 deletions(-)
 create mode 100644 net/mac80211/airtime.c

