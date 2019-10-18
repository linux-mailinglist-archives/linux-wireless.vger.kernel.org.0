Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 624C1DC794
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 16:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408662AbfJROk3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 10:40:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44176 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405743AbfJROk3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 10:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571409628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4jQ/tW2DJnux5IJz+rjWj2biWuzQKo2eWZ9vfDg1dJM=;
        b=bnUv6hjIKVEVKbWXo5JzzJNjkCVoFzIrj4LdrB1AdQjK2R+pfXa/Ax3tdwp4aI/4rbBNOv
        IL/uGxBAJjcONgjBl8QyO4A+bT4zg8g5DZGFDE4+AI5MuACJWKKtAqovhAZEiaeC/ETzd/
        OMiOq0n0gnRDomng94J3JhJV/Kkjbf0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-2uSYnUweM_W7YzcI8Xsj6Q-1; Fri, 18 Oct 2019 10:40:24 -0400
Received: by mail-lj1-f198.google.com with SMTP id e3so1119785ljj.16
        for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2019 07:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=e7FaDhgC1zTkjFC0jsJQQgggehot9KAb85p12pfkR44=;
        b=m/bwhiElO+qBMZbV7oUZj4cvhW08qXLvK7sseVfAoJa0NfHLyoGZH7Ptx1wo0HyAVg
         pJ48zo3APaFc9xAA8LBcWIFAwwlio/TVvk3N+/GWZn4/qC3kJek+IpPfAHEZWUmxFgk2
         jyhAGP7UTG7tDVldVT0YrEPSTXBAKGfOK5hhYzVO84ZmEjckb0wkbEXp9bTMKsijTL2L
         oCPtkHpOqG/3+qt2KEOZR12boYbO2y2yE2Tz782GAsZJtKOW/llx6zbQatHOla2zPMhq
         G+gB/BfQi5qLqNWDvoFYigjNxTESdLT8eJJ/33YDmhxsUsnku2FwZoxeESNjTLqAlS07
         w0Bw==
X-Gm-Message-State: APjAAAU6rr/5hykWJ46rBQ10v8aCF/AxNsU1tCKNx4ve972NrFlHJ0r3
        D7zurROAuOu5QjzQ8TK85CLj3Rc24/7AR+AOkcsdxFp75dBEsPUmcEE0ECJP7ReoEuVGY6Pt/BO
        5LOcpKJnc2UYZUWDRELMZ6czNY5c=
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr5868998lfm.15.1571409623107;
        Fri, 18 Oct 2019 07:40:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy1oW0Pilzv/j0cmg+z4cw3p8bFy2vRDcI9r/1HPABPVkHKj9AY00UN3Q8sVxFdt9bvMFmBOQ==
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr5868984lfm.15.1571409622930;
        Fri, 18 Oct 2019 07:40:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id u26sm2688629lfd.19.2019.10.18.07.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 07:40:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0EDCF1804B6; Fri, 18 Oct 2019 16:40:21 +0200 (CEST)
Subject: [PATCH v3 0/4] Add Airtime Queue Limits (AQL) to mac80211
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Fri, 18 Oct 2019 16:40:21 +0200
Message-ID: <157140962094.2866668.3383184317264069493.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
X-MC-Unique: 2uSYnUweM_W7YzcI8Xsj6Q-1
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
 net/mac80211/tx.c          |   67 +++++++-
 13 files changed, 684 insertions(+), 18 deletions(-)
 create mode 100644 net/mac80211/airtime.c

