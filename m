Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16B44FEC21
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2019 12:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfKPL5X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Nov 2019 06:57:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41124 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726794AbfKPL5W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Nov 2019 06:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573905441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4HWnUEWPK5gwkihfyRUsMpaxZslmtaOtUE3W9X1WMoY=;
        b=JgLRXqv5hxAIeWN1U1sW1luDR7XWZWhDrdikWFjO5gQeikU6rZOPlT8IXGsaVHCYprS0wF
        uNarg0wew7elvkLzT9lbkJSvjYxxhSV9WFDw27XcOlrIf3O01lAHoRqhxZkqEBYULVkiTD
        B2K52j19X9zB/KQpfMSsxrJSMBy/pVU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-x970k7k5MA-RgPOxuhEZWA-1; Sat, 16 Nov 2019 06:57:20 -0500
Received: by mail-lj1-f199.google.com with SMTP id o20so2124313ljg.0
        for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2019 03:57:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=xGmfCpzNCWtkinDzNO/MRj1kwSQ0zFMoREQi5LCL/+0=;
        b=ALuirGqwQMGEkdrVzsYT4pxzGBRfVH6aWPGIiz6D0cEsQWVglkBl3dyxNfv4e5IKkb
         i/P+Q+6a2t6lVK6U13MMGZKUNBVHkNuLrbZk3VSWMxMLnOUd0mLrVSoYttglHuR4klz8
         HFRiHMBEl1IJyuq8HqQ/iH8LA3PkoawbGADarRJZvnuxuSavExJODvMJMqKWWqwYQRhH
         ObWm+ZgADpHBYtGCtXRExbFXfOQvxRWlz9glM/9AiELqHcGbyTGxLxXTRvu4jNp1Fxkp
         xyGA4zTr8psRoiEND+8aMM2UtKU7a7IQOikYQ6z7A/YD9NV8Iajmx595gzlDenQ+fWH4
         MQtA==
X-Gm-Message-State: APjAAAXaKiOlvog0furvD6LHotoPIHVkIFYfGX79RJ1emy9W7Oalz+8D
        d2AH6xK0aRrn4oUuUoQHPrmzT8p4QQumQaUwAcyKmJKEZLVvyrz6tJiRB3cf7Z7QDW2jaiByx+A
        9cugqY8a+qWbQtdz7F0wlUU2TM7c=
X-Received: by 2002:ac2:5685:: with SMTP id 5mr2991270lfr.32.1573905439014;
        Sat, 16 Nov 2019 03:57:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqzzRBzAMxYEZHZsVAtvcDEJQdEDJ3P0ayzDpX+t+c91Igqa6iN1JaFun4iF1Kzjh2WJ+O8B4A==
X-Received: by 2002:ac2:5685:: with SMTP id 5mr2991257lfr.32.1573905438787;
        Sat, 16 Nov 2019 03:57:18 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id 12sm5429980lju.55.2019.11.16.03.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 03:57:17 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 01170181910; Sat, 16 Nov 2019 12:57:16 +0100 (CET)
Subject: [PATCH v10 0/4] Add Airtime Queue Limits (AQL) to mac80211
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Sat, 16 Nov 2019 12:57:16 +0100
Message-ID: <157390543688.662247.3735146484299260207.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-MC-Unique: x970k7k5MA-RgPOxuhEZWA-1
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
80211-aql-10

[0] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/1703105/7

Changelog:

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

