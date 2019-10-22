Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B030E0506
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 15:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbfJVNaV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 09:30:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31358 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731060AbfJVNaU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 09:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571751019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IrDLzKu3QUrojH/OETXB4MdYg9Xjq+HLcPnCemzkA6Q=;
        b=VInaSbqh8tT1KaW9ZJY91t5jQtJDWJFGr3iDF9cu16YkSx2iJ5cEP5PJL+fIRPltKsB1Wm
        Epm4tYwG44iN1SpFkTT2YzRkiNwRyTx+dOX9EDAYNUBCGCN/s4t2DFg7xQevEYJcREIdMT
        pi/gZ9TpGaoL0akwPhW4XEQYsakQrSc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-D4r_xS8VOy2VcqkUHanh9A-1; Tue, 22 Oct 2019 09:30:18 -0400
Received: by mail-wm1-f72.google.com with SMTP id z205so7498036wmb.7
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2019 06:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=HF+1TVAQSxCzMriSPvPocN7qek9sM/0jfjtpbpavxbM=;
        b=pJx5mGA2/TdfwD8xPwmdSqdtgf1G8A/gBJVMchmD2qmGDIddTk5QuF2Szu+niYRw1X
         fSKcCcFsNZLPWHxTQcZppFUUjQZCzcYnud1AcfCXT06AqGMKfsoHZ5pGkGcl2CGX3CCF
         +HofEJz7VVkoIMLztjZX9zPu9hFtiHHDlhYdvnmK5aB/yPYupLP6XJuL7PxNsBXmNITx
         82nV4bbEs5dhCS0WqDM4xObrJAIB06XzgMSWOLDs8Pb61p5qfSMj3JAgEokRMMC8m98b
         Vib2ypf3s7AhN0Gj9HitmDbe7l6xLal/bKovQcdTteVQKyVicnSleC3csdgolL9oBlsC
         iNKg==
X-Gm-Message-State: APjAAAWGxZitcUabHeB8l1WYJXpYOsn1b41kmC6h08XllDRlZErWTVpX
        ZPICpPDGPTqMbMN5j63FYwPNwjAhwl3tBzVw+qFXkyRw8qpl/iu9EIQ5rJOxloHdMVXQertijao
        7n7rGOWkOYtjcVKzSrPtvLc8KcFY=
X-Received: by 2002:a1c:b4c1:: with SMTP id d184mr2889388wmf.37.1571751017061;
        Tue, 22 Oct 2019 06:30:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxoGxGUot97MZlqwfPaLTsIDEjUXh20FBPZYwIEwIdrmUKHsNxhK9PMFDu5LGyPVlS9+2/g8A==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184mr2889362wmf.37.1571751016790;
        Tue, 22 Oct 2019 06:30:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id u11sm16355257wmd.32.2019.10.22.06.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 06:30:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 49BFD1804B1; Tue, 22 Oct 2019 15:30:15 +0200 (CEST)
Subject: [PATCH v5 0/4] Add Airtime Queue Limits (AQL) to mac80211
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Tue, 22 Oct 2019 15:30:15 +0200
Message-ID: <157175101518.104114.6722791270722911023.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
X-MC-Unique: D4r_xS8VOy2VcqkUHanh9A-1
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
 net/mac80211/status.c      |   28 +++
 net/mac80211/tx.c          |   69 +++++++-
 13 files changed, 704 insertions(+), 18 deletions(-)
 create mode 100644 net/mac80211/airtime.c

